# 安装后的事情

## 1. 彻底关闭nvidia

参考 [Hybrid_graphics#Using_udev_rules](https://wiki.archlinux.org/title/Hybrid_graphics#Using_udev_rules)

## 2. 日志警告

`/etc/default/grub` 添加了 `nosgx` 参数来解决每次启动的日志警告 `x86/cpu: SGX disabled by BIOS`

## 3. Dae

`/etc/sudoers` 添加 `user(note to replace) ALL=(ALL:ALL) NOPASSWD: /usr/bin/dae reload, /usr/bin/dae suspend` 来避免输入密码，便于 `cron` 定时执行

## 4. 关机结束进程

```bash
$ echo "DefaultTimeoutStopSec=10s" | sudo tee /etc/systemd/user.conf.d/timeoutstopsec.conf
```

## 5. 休眠

参考 [Suspend_and_hibernate#Hibernation](https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate#Hibernation)


## 6. 传统接口名称

参考 [Revert_to_traditional_interface_names](https://wiki.archlinux.org/title/Network_configuration#Revert_to_traditional_interface_names)
