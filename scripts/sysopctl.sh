#!/bin/bash

show_help() {
    echo "sysopctl - A custom command for managing system resources and tasks"
    echo
    echo "Usage: sysopctl [option] [command]"
    echo
    echo "Options:"
    echo "  --help        Display this help message"
    echo "  --version     Display the command version"
    echo
    echo "Commands:"
    echo "  service list              List all active services"
    echo "  service start <name>      Start a specific service"
    echo "  service stop <name>       Stop a specific service"
    echo "  system load               Display current system load"
    echo "  disk usage                Show disk usage statistics"
    echo "  process monitor           Monitor system processes"
    echo "  logs analyze              Analyze recent system logs"
    echo "  backup <path>             Backup system files"
    echo
    echo "Examples:"
    echo "  sysopctl service list"
    echo "  sysopctl system load"
    echo "  sysopctl backup /home/user/data"
}

show_version() {
    echo "sysopctl version 0.1.0"
}

list_services() {
    systemctl list-units --type=service
}

view_system_load() {
    uptime
}

start_service() {
    local service_name="$1"
    if systemctl start "$service_name"; then
        echo "Service $service_name started successfully."
    else
        echo "Failed to start service $service_name."
    fi
}

stop_service() {
    local service_name="$1"
    if systemctl stop "$service_name"; then
        echo "Service $service_name stopped successfully."
    else
        echo "Failed to stop service $service_name."
    fi
}

check_disk_usage() {
    df -h
}

monitor_processes() {
    top
}

analyze_logs() {
    journalctl -p 3 -xb
}

backup_files() {
    local backup_path="$1"
    if [ -d "$backup_path" ]; then
        rsync -av --progress "$backup_path" /backup/
        echo "Backup of $backup_path completed."
    else
        echo "Invalid path: $backup_path does not exist."
    fi
}

case "$1" in
    --help)
        show_help
        ;;
    --version)
        show_version
        ;;
    service)
        case "$2" in
            list)
                list_services
                ;;
            start)
                start_service "$3"
                ;;
            stop)
                stop_service "$3"
                ;;
            *)
                echo "Invalid service command."
                show_help
                ;;
        esac
        ;;
    system)
        case "$2" in
            load)
                view_system_load
                ;;
            *)
                echo "Invalid system command."
                show_help
                ;;
        esac
        ;;
    disk)
        case "$2" in
            usage)
                check_disk_usage
                ;;
            *)
                echo "Invalid disk command."
                show_help
                ;;
        esac
        ;;
    process)
        case "$2" in
            monitor)
                monitor_processes
                ;;
            *)
                echo "Invalid process command."
                show_help
                ;;
        esac
        ;;
    logs)
        case "$2" in
            analyze)
                analyze_logs
                ;;
            *)
                echo "Invalid logs command."
                show_help
                ;;
        esac
        ;;
    backup)
        backup_files "$2"
        ;;
    *)
        echo "Invalid command."
        show_help
        ;;
esac
