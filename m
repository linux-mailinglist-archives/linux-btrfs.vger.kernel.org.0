Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138001AB53B
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 03:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406122AbgDPBIT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Apr 2020 21:08:19 -0400
Received: from gator3069.hostgator.com ([192.185.45.2]:20744 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1729471AbgDPBIQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Apr 2020 21:08:16 -0400
X-Greylist: delayed 1422 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Apr 2020 21:08:15 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 84F3E400CD416
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Apr 2020 19:44:25 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id OsdljaPWmSl8qOsdlj2iFP; Wed, 15 Apr 2020 19:44:25 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9WvtvDUzuPjGAnBn38mamDOCpOC1H3+8bpBgt77l5QU=; b=AXm7jSZBx6yjozo+MoLcI/mppg
        QHBBzaOVJiYqkhmLHyQ0jh8SVNoa+CGIkNlgBNZV9IVm2I3EXP26+0Ed/XZiohsc+ZnYqgpt5goun
        n+RYfMgXCEYF3mV+3NkaQeTeQZUwIkeS21fYf9g2M2WwwwQhpTxvpue+IYtnvw6MgUTEYcsOQb9n+
        TQDvFyR5H0wu/h2EBeDLyN+5St5tWASCAjpwUj/HOpu38iZp70teNWpw5u3jS0UBhDsg9waZ3M1YM
        p51Oy2NA+qFzIy/+wyjcSH55KA/cItPPL/HueOYPXVXa8+WHaEaYw7jJpaHcYhig4CtT/7EyIHeCZ
        gGpQFdMg==;
Received: from [177.132.129.218] (port=35128 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jOsdk-0046UY-Qo; Wed, 15 Apr 2020 21:44:25 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org, wqu@suse.com
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCHv3 3/3] btrfs-progs: tests: misc: Add some replace tests
Date:   Wed, 15 Apr 2020 21:46:42 -0300
Message-Id: <20200416004642.9941-4-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416004642.9941-1-marcos@mpdesouza.com>
References: <20200416004642.9941-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 177.132.129.218
X-Source-L: No
X-Exim-ID: 1jOsdk-0046UY-Qo
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.suse.de) [177.132.129.218]:35128
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 15
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

The new test includes a check for the new --autoresize option

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 tests/misc-tests/039-replace-device/test.sh | 56 +++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100755 tests/misc-tests/039-replace-device/test.sh

diff --git a/tests/misc-tests/039-replace-device/test.sh b/tests/misc-tests/039-replace-device/test.sh
new file mode 100755
index 00000000..64b80bed
--- /dev/null
+++ b/tests/misc-tests/039-replace-device/test.sh
@@ -0,0 +1,56 @@
+#!/bin/bash
+#
+# test the different arguments accepted by "btrfs replace"
+
+source "$TEST_TOP/common"
+
+check_prereq mkfs.btrfs
+check_prereq btrfs
+
+setup_root_helper
+
+setup_loopdevs 2
+prepare_loopdevs
+dev1=${loopdevs[1]}
+dev2=${loopdevs[2]}
+
+# resize only works with disk size bigger than the replaced disk
+run_check_stdout truncate -s3g `pwd`/img3
+dev3=`run_check_stdout $SUDO_HELPER losetup --find --show $(pwd)/img3`
+
+test()
+{
+	local srcdev
+	local final_size
+	local resize_arg
+	srcdev="$1"
+	final_size="$2"
+	resize_arg="$3"
+	args="-B -f"
+
+	if [ -n "$resize_arg" ]; then
+		args="$args --autoresize"
+	fi
+
+	run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f "$dev1" "$dev2"
+	TEST_DEV="$dev1"
+
+	run_check_mount_test_dev
+	run_check_stdout $SUDO_HELPER "$TOP/btrfs" replace start $args "$srcdev" "$dev3" "$TEST_MNT"
+	run_check_stdout $SUDO_HELPER "$TOP/btrfs" filesystem usage "$TEST_MNT" | head -2 | \
+			grep -q "$final_size\\.00GiB"
+	[ $? -eq 1 ] && _fail "Device size don't match. Expected size: $final_size\\.00GiB"
+	run_check_umount_test_dev
+}
+
+# test replace using devid and path, and also test the final fs size when
+# --autoresize is passed, executing the replace + resize in just one command.
+test 2 4
+test 2 5 true
+test "$dev2" 4
+test "$dev2" 5 true
+
+run_check $SUDO_HELPER losetup -d "$dev3"
+rm `pwd`/img3
+
+cleanup_loopdevs
-- 
2.25.1

