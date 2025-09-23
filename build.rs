use cxx_qt_build::{CxxQtBuilder, QmlModule};

fn main() {
	CxxQtBuilder::new()
		.qml_module(QmlModule {
			uri: "org.ac.starter",
			qml_files: &[
				"src/qml/Main.qml",
				"src/qml/AddDialog.qml",
				"src/qml/KountdownDelegate.qml"
			],
			rust_files: &["src/main.rs"],
			..Default::default()
		})
		.build()
}
