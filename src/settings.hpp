// http://stackoverflow.com/a/23524110/2966847

#ifndef SETTINGS_H_
#define SETTINGS_H_

#include <QSettings>

class Settings: public QSettings
{
    Q_OBJECT
public:
    Settings(QObject *parent = 0);
    Q_INVOKABLE QVariant value(const QString& key, const QVariant& defaultValue = QVariant()) const;
    Q_INVOKABLE void setValue(const QString& key, const QVariant& value);
};

#endif /* SETTINGS_H_ */
