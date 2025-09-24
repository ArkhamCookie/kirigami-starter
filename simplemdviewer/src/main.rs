use std::env;

use cxx_qt_lib::{QGuiApplication, QQmlApplicationEngine, QQuickStyle, QString, QUrl};
use cxx_qt_lib_extras::QApplication;

mod mdconverter;

#[derive(Default)]
pub struct DummyRustStruct;

fn main() {
	let mut app = QApplication::new();

	// Associate the executable to the installed desktop file
	QGuiApplication::set_desktop_file_name(&QString::from("org.ac.simplemdviewer"));

	// Ensure the style is set correctly
	if env::var("QT_QUICK_CONTROLS_STYLE").is_err() {
		QQuickStyle::set_style(&QString::from("org.kde.desktop"));
	}

	let mut engine = QQmlApplicationEngine::new();
	if let Some(engine) = engine.as_mut() {
		engine.load(&QUrl::from(
			"qrc:/qt/qml/org/ac/simplemdviewer/src/qml/Main.qml"
		));
	}

	if let Some(app) = app.as_mut() {
		app.exec();
	}
}
