Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9662D68DE
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2019 19:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbfJNRxP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Oct 2019 13:53:15 -0400
Received: from p3nlsmtpcp01-04.prod.phx3.secureserver.net ([184.168.200.145]:48382
        "EHLO p3nlsmtpcp01-04.prod.phx3.secureserver.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728941AbfJNRxP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Oct 2019 13:53:15 -0400
Received: from p3plcpnl0639.prod.phx3.secureserver.net ([50.62.176.166])
        by : HOSTING RELAY : with ESMTP
        id K4Vxidsnr7wBxK4VxiucbK; Mon, 14 Oct 2019 10:52:13 -0700
Received: from [45.116.115.51] (port=33339 helo=giis.co.in)
        by p3plcpnl0639.prod.phx3.secureserver.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <lakshmipathi.ganapathi@collabora.com>)
        id 1iK4Vw-006IIA-6d; Mon, 14 Oct 2019 10:52:12 -0700
Date:   Mon, 14 Oct 2019 23:21:59 +0530
From:   "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.com>
To:     linux-btrfs@vger.kernel.org, pmhahn+btrfs@pmhahn.de,
        dsterba@suse.com, lakshmipathi.g@giis.co.in
Subject: [PATCH v2] Setup GitLab-CI for btrfs-progs
Message-ID: <20191014175159.GA13501@giis.co.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - p3plcpnl0639.prod.phx3.secureserver.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - collabora.com
X-Get-Message-Sender-Via: p3plcpnl0639.prod.phx3.secureserver.net: authenticated_id: lakshmipathi.g@giis.co.in
X-Authenticated-Sender: p3plcpnl0639.prod.phx3.secureserver.net: lakshmipathi.g@giis.co.in
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CMAE-Envelope: MS4wfHFBC55/rCjnkbW/GIukMSfGdaa3eO12oYohW7TnSOoGgyAwxlh690bS9BPGbtwIJQTAJUd4LMfqg0qQ5JxxEA89i9TXc66P2bGFvgFv3A7EcF+0XNft
 ojQW32Mm6zGcyk6QTbCXfa3fQur0tRJLZyrHgYy2HIFXoBArck/MLNjvoqcrqCKy+Jd3Oqxks8DfzaCrYb5UMcKovpRQU8rfPRjRj91W2HZErhHhye+mGJ4f
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Make use of GitLab-CI nested virutal environment to start QEMU instance inside containers 
and perform btrfs-progs build, execute unit test cases and save the logs.

More details can be found at https://github.com/kdave/btrfs-progs/issues/171

Signed-off-by: Lakshmipathi.G <lakshmipathi.ganapathi@collabora.com>
---
 .gitlab-ci.yml                        | 158 ++++++++++++++++++++++++++++++++++
 ci/gitlab/Dockerfile                  |   3 +
 ci/gitlab/btrfs-progs-tests.service   |  13 +++
 ci/gitlab/build_or_run_btrfs-progs.sh |  37 ++++++++
 ci/gitlab/kernel_build.sh             |  30 +++++++
 ci/gitlab/run_tests.sh                |   9 ++
 ci/gitlab/setup_image.sh              |  42 +++++++++
 7 files changed, 292 insertions(+)
 create mode 100644 .gitlab-ci.yml
 create mode 100644 ci/gitlab/Dockerfile
 create mode 100644 ci/gitlab/btrfs-progs-tests.service
 create mode 100755 ci/gitlab/build_or_run_btrfs-progs.sh
 create mode 100755 ci/gitlab/kernel_build.sh
 create mode 100755 ci/gitlab/run_tests.sh
 create mode 100755 ci/gitlab/setup_image.sh

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
new file mode 100644
index 0000000..8ecfc5a
--- /dev/null
+++ b/.gitlab-ci.yml
@@ -0,0 +1,158 @@
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public
+# License v2 as published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# General Public License for more details.
+#
+# You should have received a copy of the GNU General Public
+# License along with this program; if not, write to the
+# Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+# Boston, MA 021110-1307, USA.
+#
+
+image: docker:18.09.7
+
+services:
+    - docker:18.09.7-dind
+
+# To enable or disable Kernel Build set BUILD_KERNEL: "1" or BUILD_KERNEL: "0"
+# If you disable Kernel Build, make sure PREBUILT_KERNEL_ID points to previously built the kernel job id.
+# To enable or disable image build update BUILD_IMAGE value to "1" or "0".
+# If you disable Image Build, make sure PREBUILT_IMAGE_ID points to previously built rootfs job id.
+
+variables:
+  DOCKER_DRIVER: overlay2
+  IMAGE_TAG: registry.gitlab.com/$CI_PROJECT_NAMESPACE/btrfs-progs:gitlab-ci
+  BUILD_KERNEL: "1"
+  PREBUILT_KERNEL_ID: "320566224"
+  BUILD_IMAGE: "1"
+  PREBUILT_IMAGE_ID: "288506168"
+
+stages:
+  - build
+  - btrfs-progs build
+  - test
+
+before_script:
+   - docker login --username $CI_REGISTRY_USER --password $CI_REGISTRY_PASSWORD $CI_REGISTRY
+
+docker build:
+  stage: build
+  script:
+    - cd ci/gitlab
+    - docker pull $IMAGE_TAG > /dev/null && echo "Downloaded image" || ( docker build -t $IMAGE_TAG . && docker push $IMAGE_TAG )
+
+
+kernel build:
+  before_script:
+    - apk add curl unzip 
+  stage: build
+  script:
+     - if [ "$BUILD_KERNEL" == "1" ]; then
+         docker run --cap-add SYS_PTRACE --cap-add sys_admin --privileged --device=/dev/kvm -v $PWD:/repo $IMAGE_TAG /repo/ci/gitlab/kernel_build.sh;
+       else
+         curl -o bzImage.zip --location --header "JOB-TOKEN:$CI_JOB_TOKEN"  "https://gitlab.com/api/v4/projects/$CI_PROJECT_ID/jobs/$PREBUILT_KERNEL_ID/artifacts" && unzip bzImage.zip;
+       fi;
+  artifacts:
+    when: always
+    paths:
+      - bzImage
+
+ 
+image build:
+  before_script:
+    - apk add curl unzip 
+  stage: build
+  script:
+     - if [ "$BUILD_IMAGE" == "1" ]; then
+          docker run --cap-add SYS_PTRACE --cap-add sys_admin --privileged --device=/dev/kvm -v $PWD:/repo $IMAGE_TAG /repo/ci/gitlab/setup_image.sh;
+       else
+          curl  -o qemu-image.img.zip --location --header "JOB-TOKEN:$CI_JOB_TOKEN" "https://gitlab.com/api/v4/projects/$CI_PROJECT_ID/jobs/$PREBUILT_IMAGE_ID/artifacts" && unzip qemu-image.img.zip;
+       fi;
+  artifacts:
+    when: always
+    paths:
+      - qemu-image.img
+
+btrfs-progs build:
+  stage: btrfs-progs build
+  script:
+     - docker run --cap-add SYS_PTRACE --cap-add sys_admin --privileged --device=/dev/kvm -v $PWD:/repo $IMAGE_TAG /repo/ci/gitlab/run_tests.sh
+  artifacts:
+    expire_in: 1 week
+    when: always
+    paths:
+      - qemu-image.img
+
+cli tests:
+  stage: test
+  script:
+     - echo "./cli-tests.sh" > $PWD/cmd
+     - docker run --cap-add SYS_PTRACE --cap-add sys_admin --privileged --device=/dev/kvm -v $PWD:/repo $IMAGE_TAG /repo/ci/gitlab/run_tests.sh
+     - test -e "result" || exit 1 # If result doesn't exists, job failed.
+  artifacts:
+    when: always
+    paths:
+      - "*tests-results.txt"
+
+convert tests:
+  only: 
+    - devel
+  stage: test
+  script:
+     - echo "./convert-tests.sh" > $PWD/cmd
+     - docker run --cap-add SYS_PTRACE --cap-add sys_admin --privileged --device=/dev/kvm -v $PWD:/repo $IMAGE_TAG /repo/ci/gitlab/run_tests.sh
+     - test -e "result" || exit 1
+  artifacts:
+    when: always
+    paths:
+      - "*tests-results.txt"
+
+fsck tests:
+  stage: test
+  script:
+     - echo "./fsck-tests.sh" > $PWD/cmd
+     - docker run --cap-add SYS_PTRACE --cap-add sys_admin --privileged --device=/dev/kvm -v $PWD:/repo $IMAGE_TAG /repo/ci/gitlab/run_tests.sh
+     - test -e "result" || exit 1
+  artifacts:
+    when: always
+    paths:
+      - "*tests-results.txt"
+      - error.log
+
+fuzz tests:
+  stage: test
+  script:
+     - echo "./fuzz-tests.sh" > $PWD/cmd
+     - docker run --cap-add SYS_PTRACE --cap-add sys_admin --privileged --device=/dev/kvm -v $PWD:/repo $IMAGE_TAG /repo/ci/gitlab/run_tests.sh
+     - test -e "result" || exit 1
+  artifacts:
+    when: always
+    paths:
+      - "*tests-results.txt"
+
+misc tests:
+  stage: test
+  script:
+     - echo "./misc-tests.sh" > $PWD/cmd
+     - docker run --cap-add SYS_PTRACE --cap-add sys_admin --privileged --device=/dev/kvm -v $PWD:/repo $IMAGE_TAG /repo/ci/gitlab/run_tests.sh
+     - test -e "result" || exit 1
+  artifacts:
+    when: always
+    paths:
+      - "*tests-results.txt"
+
+mkfs tests:
+  stage: test
+  script:
+     - echo "./mkfs-tests.sh" > $PWD/cmd
+     - docker run --cap-add SYS_PTRACE --cap-add sys_admin --privileged --device=/dev/kvm -v $PWD:/repo $IMAGE_TAG /repo/ci/gitlab/run_tests.sh
+     - test -e "result" || exit 1
+  artifacts:
+    when: always
+    paths:
+      - "*tests-results.txt"
+
diff --git a/ci/gitlab/Dockerfile b/ci/gitlab/Dockerfile
new file mode 100644
index 0000000..356a21f
--- /dev/null
+++ b/ci/gitlab/Dockerfile
@@ -0,0 +1,3 @@
+FROM debian:stretch-slim
+
+RUN apt-get update && apt-get install -y --no-install-recommends ovmf qemu-system qemu-efi
diff --git a/ci/gitlab/btrfs-progs-tests.service b/ci/gitlab/btrfs-progs-tests.service
new file mode 100644
index 0000000..d255d77
--- /dev/null
+++ b/ci/gitlab/btrfs-progs-tests.service
@@ -0,0 +1,13 @@
+[Unit]
+Description=Execute build_or_run_btrfs-progs.sh on console
+
+[Service]
+ExecStart=/usr/bin/build_or_run_btrfs-progs.sh
+StandardInput=tty
+StandardOutput=tty
+TTYPath=/dev/ttyS0
+Type=idle
+
+[Install]
+WantedBy=getty.target
+After=multi-user.target
diff --git a/ci/gitlab/build_or_run_btrfs-progs.sh b/ci/gitlab/build_or_run_btrfs-progs.sh
new file mode 100755
index 0000000..081e83c
--- /dev/null
+++ b/ci/gitlab/build_or_run_btrfs-progs.sh
@@ -0,0 +1,37 @@
+#!/bin/bash
+#
+# Build or Run btrfs-progs tests.
+#
+set -x
+
+BTRFS_BIN="btrfs"
+MNT_DIR="/mnt/"
+BUILD_DIR="/btrfs/"
+test_cmd=$(cat ${MNT_DIR}/cmd)
+
+rm -f ${MNT_DIR}/result
+${BTRFS_BIN} --version
+
+if [ $? -ne 0 ]
+then
+    echo "=========================== Builb btrfs-progs ================"
+    echo " Image doesn't have ${BTRFS_BIN} - start build process"
+    cd ${MNT_DIR} && ./autogen.sh && ./configure --disable-documentation --disable-backtrace && make -j`nproc` && make install && make testsuite
+    echo "================= Prepare Testsuite =========================="
+    mkdir -p ${BUILD_DIR}
+    cp tests/btrfs-progs-tests.tar.gz ${BUILD_DIR}
+    poweroff
+else
+    echo "================= Run Tests  ================================="
+    cd ${BUILD_DIR} && tar -xvf btrfs-progs-tests.tar.gz && ${test_cmd}
+
+    # check test result status
+    if [ $? -ne 0 ]; then
+       cd ${BUILD_DIR} && cp *tests-results.txt ${MNT_DIR}
+       poweroff
+    else
+       cd ${BUILD_DIR} && cp *tests-results.txt ${MNT_DIR}
+       touch ${MNT_DIR}/result
+       poweroff
+    fi
+fi
diff --git a/ci/gitlab/kernel_build.sh b/ci/gitlab/kernel_build.sh
new file mode 100755
index 0000000..189dec1
--- /dev/null
+++ b/ci/gitlab/kernel_build.sh
@@ -0,0 +1,30 @@
+#!/usr/bin/env bash
+#
+# Setup BTRFS kernel options and build kernel 
+set -x
+
+apt-get update
+apt-get -y install build-essential libncurses-dev bison flex libssl-dev libelf-dev unzip wget bc 
+
+# Build kernel
+wget https://github.com/kdave/btrfs-devel/archive/misc-next.zip
+unzip -qq  misc-next.zip
+cd btrfs-devel-misc-next/ && make x86_64_defconfig && make kvmconfig 
+
+# BTRFS specific entires
+cat <<EOF >> .config
+CONFIG_BTRFS_FS=y
+CONFIG_BTRFS_FS_POSIX_ACL=y
+CONFIG_BTRFS_FS_CHECK_INTEGRITY=n
+CONFIG_BTRFS_FS_RUN_SANITY_TESTS=n
+CONFIG_BTRFS_DEBUG=y
+CONFIG_BTRFS_ASSERT=y
+CONFIG_BTRFS_FS_REF_VERIFY=y
+CONFIG_RAID6_PQ_BENCHMARK=y
+CONFIG_LIBCRC32C=y
+EOF
+
+make -j8
+
+# Store file to shared dir
+cp -v arch/x86/boot/bzImage /repo
diff --git a/ci/gitlab/run_tests.sh b/ci/gitlab/run_tests.sh
new file mode 100755
index 0000000..c53d09e
--- /dev/null
+++ b/ci/gitlab/run_tests.sh
@@ -0,0 +1,9 @@
+#!/usr/bin/env bash
+#
+# Install and start qemu instance with custom kernel while exporting btrfs-progs src over 9p
+#
+set -x
+
+qemu-system-x86_64 -m 512 -nographic -kernel /repo/bzImage -drive file=/repo/qemu-image.img,index=0,media=disk,format=raw \
+-fsdev local,id=btrfs-progs,path=/repo,security_model=mapped -device virtio-9p-pci,fsdev=btrfs-progs,mount_tag=btrfs-progs \
+-append "console=tty1 root=/dev/sda rw" 
diff --git a/ci/gitlab/setup_image.sh b/ci/gitlab/setup_image.sh
new file mode 100755
index 0000000..4048099
--- /dev/null
+++ b/ci/gitlab/setup_image.sh
@@ -0,0 +1,42 @@
+#!/usr/bin/env bash
+#
+# Setup debian image via debootstrap and include systemd service file.
+set -x
+
+apt-get update
+apt-get -y install debootstrap wget unzip
+
+# Setup rootfs
+IMG="/qemu-image.img"
+DIR="/target"
+truncate -s2G $IMG
+mkfs.ext4 $IMG
+mkdir -p $DIR
+for i in {0..7};do
+mknod -m 0660 "/dev/loop$i" b 7 "$i"
+done
+
+# mount the image file
+mount -o loop $IMG $DIR
+
+# Install required pacakges
+debootstrap --arch=amd64  --include=git,autoconf,automake,gcc,make,pkg-config,e2fslibs-dev,libblkid-dev,zlib1g-dev,liblzo2-dev,asciidoc,xmlto,libzstd-dev,python3.5,python3.5-dev,python3-dev,python3-setuptools,python-setuptools,xz-utils,acl,attr stretch $DIR http://ftp.de.debian.org/debian/
+
+## Setup 9p mount
+echo "btrfs-progs /mnt           9p             trans=virtio    0       0" > $DIR/etc/fstab
+
+#Setup autologin 
+sed -i 's/9600/9600 --autologin root/g' $DIR/lib/systemd/system/serial-getty@.service
+
+# Setup systemd service
+cp -v /repo/ci/gitlab/build_or_run_btrfs-progs.sh $DIR/usr/bin/
+cp -v /repo/ci/gitlab/btrfs-progs-tests.service $DIR/etc/systemd/system/
+
+## Enable service
+ln -s $DIR/etc/systemd/system/btrfs-progs-tests.service $DIR/etc/systemd/system/getty.target.wants/btrfs-progs-tests.service 
+
+cd /
+umount $DIR
+rmdir $DIR
+
+cp -v $IMG /repo
-- 
2.7.4

