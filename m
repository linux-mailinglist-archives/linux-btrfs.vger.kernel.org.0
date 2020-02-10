Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6803158068
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2020 18:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbgBJRDW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Feb 2020 12:03:22 -0500
Received: from gateway34.websitewelcome.com ([192.185.147.201]:41435 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727003AbgBJRDV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Feb 2020 12:03:21 -0500
X-Greylist: delayed 1276 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Feb 2020 12:03:21 EST
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 2E0FD85F68
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Feb 2020 10:42:04 -0600 (CST)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id 1C8KjzLu58vkB1C8KjxllX; Mon, 10 Feb 2020 10:42:04 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VVIKyGuGx0QrR64h+wSnRW7/hH/CLX/HUSVmHEryV+A=; b=UiLUMvihopMPFWQZjIK2nHJFwU
        9Fi+EW9XqLqVo2Q2qHmM+m8mXbUGcsT6iZ2m4Y2klx8bmyvb+6wUDAa8Yqy5aqigNte2ki+2LGbqJ
        fAAfCHU0Z5XseWkFQaBMpghbkUdrOOtwflADlTIA4Sdzq4qkSzsM0q1OQ7Kb/ElbUahcEPYQuZoAE
        bxlECY5O3wqIhhbMlSGeaTCVF+V7iZGj9r4qfnTepoTbsuasQWHCj9HLLbqZvDxeJ4mHNo2vscItY
        DIZKr96wFPlAzXoehOpZVavFvL86oOC3esNmEfsrCf4tHO+XA+n9j1fxIPzZJMuF/NCuT+Wtt9ySH
        piQWPG6Q==;
Received: from 200.146.48.32.dynamic.dialup.gvt.net.br ([200.146.48.32]:48998 helo=hephaestus.prv.suse.net)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1j1C8H-004ARM-NV; Mon, 10 Feb 2020 13:42:02 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] mkfs-tests: Only check supported checksums
Date:   Mon, 10 Feb 2020 13:43:00 -0300
Message-Id: <20200210164300.14177-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 200.146.48.32
X-Source-L: No
X-Exim-ID: 1j1C8H-004ARM-NV
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 200.146.48.32.dynamic.dialup.gvt.net.br (hephaestus.prv.suse.net) [200.146.48.32]:48998
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 2
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 tests/mkfs-tests/019-basic-checksums-mkfs/test.sh  | 11 +++++++----
 tests/mkfs-tests/020-basic-checksums-mount/test.sh |  7 +++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/tests/mkfs-tests/019-basic-checksums-mkfs/test.sh b/tests/mkfs-tests/019-basic-checksums-mkfs/test.sh
index 61562942..01934cf0 100755
--- a/tests/mkfs-tests/019-basic-checksums-mkfs/test.sh
+++ b/tests/mkfs-tests/019-basic-checksums-mkfs/test.sh
@@ -20,7 +20,10 @@ test_mkfs_checksum()
 	run_check $SUDO_HELPER "$TOP/btrfs" check "$TEST_DEV"
 }
 
-test_mkfs_checksum crc32c
-test_mkfs_checksum xxhash
-test_mkfs_checksum sha256
-test_mkfs_checksum blake2
+if ! [ -f "/sys/fs/btrfs/features/supported_checksums" ]; then
+	_not_run "kernel support for checksums missing"
+fi
+
+for csum in $(cat /sys/fs/btrfs/features/supported_checksums); do
+	test_mkfs_checksum "$csum"
+done
diff --git a/tests/mkfs-tests/020-basic-checksums-mount/test.sh b/tests/mkfs-tests/020-basic-checksums-mount/test.sh
index eaac25dd..d52f3e1c 100755
--- a/tests/mkfs-tests/020-basic-checksums-mount/test.sh
+++ b/tests/mkfs-tests/020-basic-checksums-mount/test.sh
@@ -30,7 +30,6 @@ if ! [ -f "/sys/fs/btrfs/features/supported_checksums" ]; then
 	_not_run "kernel support for checksums missing"
 fi
 
-test_mkfs_mount_checksum crc32c
-test_mkfs_mount_checksum xxhash
-test_mkfs_mount_checksum sha256
-test_mkfs_mount_checksum blake2
+for csum in $(cat /sys/fs/btrfs/features/supported_checksums); do
+	test_mkfs_mount_checksum "$csum"
+done
-- 
2.24.0

