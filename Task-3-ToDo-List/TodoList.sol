// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TodoList {
    struct Task {
        string description;
        bool completed;
        uint256 createdAt;
    }

    mapping(address => Task[]) private userTasks;
    // Events
    event TaskCreated(
        address indexed user,
        uint256 taskId,
        string description,
        uint256 createdAt
    );

    event TaskCompleted(
        address indexed user,
        uint256 taskId
    );

    event TaskStatusUpdated(
        address indexed user,
        uint256 taskId,
        bool completed
    );

    event TaskDeleted(
        address indexed user,
        uint256 taskId
    );
    // Function to Add a new task
    function addTask(string memory _description) public {
        require(
            bytes(_description).length > 0,
            "Task description cannot be empty"
        );
        userTasks[msg.sender].push(
            Task({
                description: _description,
                completed: false,
                createdAt: block.timestamp
            })
        );
        uint256 taskId = userTasks[msg.sender].length - 1;

        emit TaskCreated(
            msg.sender,
            taskId,
            _description,
            block.timestamp
        );
    }
    // Function to Update task status
    function updateTaskStatus(
        uint256 _taskId,
        bool _completed
    ) public {

        require(
            _taskId < userTasks[msg.sender].length,
            "Invalid task ID"
        );
        userTasks[msg.sender][_taskId].completed = _completed;
        emit TaskStatusUpdated(
            msg.sender,
            _taskId,
            _completed
        );
        if (_completed) {
            emit TaskCompleted(msg.sender, _taskId);
        }
    }
    // Function Retrieve all tasks for a specific wallet
    function getTasks(
        address _user
    ) public view returns (Task[] memory) {

        return userTasks[_user];
    }
    //Function Retrieve the caller's task count
    function getTaskCount() public view returns (uint256) {
        return userTasks[msg.sender].length;
    }
    // Delete a completed task
    function deleteCompletedTask(
        uint256 _taskId
    ) public {
        require(
            _taskId < userTasks[msg.sender].length,
            "Invalid task ID"
        );
        require(
            userTasks[msg.sender][_taskId].completed,
            "Task is not completed"
        );
        //Function to Move the last task into the deleted position
        uint256 lastIndex = userTasks[msg.sender].length - 1;

        if (_taskId != lastIndex) {
            userTasks[msg.sender][_taskId] =
                userTasks[msg.sender][lastIndex];
        }
        //Function to Remove the last element
        userTasks[msg.sender].pop();
        emit TaskDeleted(msg.sender, _taskId);
    }
}
