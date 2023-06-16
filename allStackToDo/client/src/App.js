function App() {
  return (
    <div className="App">
      <h1>Welcome, User</h1>
      <h4>Here are your tasks</h4>

      <div className="todos">
        <div className="todo">
          <div className="checkbox"></div>
          <div className="text">Get the bread</div>
          <div className="delete-todo">x</div>
        </div>
      </div>
    </div>
  );
}

export default App;
