Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9352D1606BC
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Feb 2020 22:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgBPVdm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Feb 2020 16:33:42 -0500
Received: from gateway22.websitewelcome.com ([192.185.47.179]:32028 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726020AbgBPVdm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Feb 2020 16:33:42 -0500
X-Greylist: delayed 1453 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Feb 2020 16:33:41 EST
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 276E23780
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Feb 2020 15:09:28 -0600 (CST)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id 3RAOj30mJSl8q3RAOjkQUr; Sun, 16 Feb 2020 15:09:28 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7S5efBgDCSC4pVkAhyXU8Ai4gMY5fgl9Dkx8r1deplE=; b=jKTsKRtz4a38qkKVhYL1lj89my
        Yo6uFXT45qjqsNmHD6rqQ1AgCYeuCJBb0VNNfw0jLCg14EfTF5ok6Hpsne0chlbQyegG5uhX6MEcA
        YL8etZPJ7/E3WZOgud4gneEiYb7w78XY56f3mesdgT6jhY1np3oSJ6x4Lb3XUIIofhKB01dr/qIFL
        QJ5jXKhTKRjkfaFaOSg3iGTAvAEtZFLqpKPgA68na433Ybr+2rrtefITS28L7yEolnyfwhEqKoGre
        1r8EgDbHBgv1rLzjROouWMbw0FtIvakmV6WTY/OtFFGVMT2kqrv0uQYk+LiN8f/T3+U82PU/aiQNf
        yseyfH5g==;
Received: from [179.183.207.150] (port=51688 helo=localhost.localdomain)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1j3RAN-001V3i-IX; Sun, 16 Feb 2020 18:09:27 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] progs: misc-test: 034: Call "udevmadm settle" before mount
Date:   Sun, 16 Feb 2020 18:12:21 -0300
Message-Id: <20200216211221.31471-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 179.183.207.150
X-Source-L: No
X-Exim-ID: 1j3RAN-001V3i-IX
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [179.183.207.150]:51688
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 3
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

As seem in this issue[1], this test can fail from time to time. The
issue happens when a mount is issued before the new device is processed
by systemd-udevd, as we can see by the og bellow:

[ 2346.028809] BTRFS: device fsid 593e23af-a7e6-4360-b16a-229f415de697 devid 1 transid 6 /dev/loop10 scanned by systemd-udevd (3418)
[ 2346.265401] BTRFS info (device loop10): found metadata UUID change in progress flag, clearing
[ 2346.272474] BTRFS info (device loop10): disk space caching is enabled
[ 2346.277472] BTRFS info (device loop10): has skinny extents
[ 2346.281840] BTRFS info (device loop10): flagging fs with big metadata feature
[ 2346.308428] BTRFS error (device loop10): devid 2 uuid cde07de6-db7e-4b34-909e-d3db6e7c0b06 is missing
[ 2346.315363] BTRFS error (device loop10): failed to read the system array: -2
[ 2346.329887] BTRFS error (device loop10): open_ctree failed
failed: mount /dev/loop10 /home/marcos/git/suse/btrfs-progs/tests//mnt
test failed for case 034-metadata-uuid
make: *** [Makefile:401: test-misc] Error 1
[ 2346.666865] BTRFS: device fsid 593e23af-a7e6-4360-b16a-229f415de697 devid 2 transid 5 /dev/loop11 scanned by systemd-udevd (3422)
[ 2346.853233] BTRFS: device fsid 1c2debeb-e829-4d6b-84df-aa7c5d246fd5 devid 1 transid 7 /dev/loop6 scanned by systemd-udevd (3418)

A few moments after the test failed systemd-udevd processed the new
device (registered the new device under btrfs). This can be
tested by executing a mount after the test failed, resulting in a
successful mount:

mount /dev/loop10 /mnt
[ 2398.955254] BTRFS info (device loop10): found metadata UUID change in progress flag, clearing
[ 2398.959416] BTRFS info (device loop10): disk space caching is enabled
[ 2398.962483] BTRFS info (device loop10): has skinny extents
[ 2398.965070] BTRFS info (device loop10): flagging fs with big metadata feature
[ 2399.012617] BTRFS info (device loop10): enabling ssd optimizations
[ 2399.022375] BTRFS info (device loop10): checking UUID tree

This problem can be avoided is we execute "udevadm settle" before the
mount is executed.

[1]: https://github.com/kdave/btrfs-progs/issues/192

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 tests/misc-tests/034-metadata-uuid/test.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/misc-tests/034-metadata-uuid/test.sh b/tests/misc-tests/034-metadata-uuid/test.sh
index 6ac55b1c..9791285b 100755
--- a/tests/misc-tests/034-metadata-uuid/test.sh
+++ b/tests/misc-tests/034-metadata-uuid/test.sh
@@ -6,6 +6,7 @@ check_prereq mkfs.btrfs
 check_prereq btrfs
 check_prereq btrfstune
 check_prereq btrfs-image
+check_global_prereq udevadm
 
 setup_root_helper
 prepare_test_dev
@@ -172,6 +173,8 @@ failure_recovery() {
 	loop1=$(run_check_stdout $SUDO_HELPER losetup --find --show "$image1")
 	loop2=$(run_check_stdout $SUDO_HELPER losetup --find --show "$image2")
 
+	run_check $SUDO_HELPER udevadm settle
+
 	# Mount and unmount, on trans commit all disks should be consistent
 	run_check $SUDO_HELPER mount "$loop1" "$TEST_MNT"
 	run_check $SUDO_HELPER umount "$TEST_MNT"
-- 
2.25.0

