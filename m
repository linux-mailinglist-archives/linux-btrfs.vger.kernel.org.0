Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C301455F50
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Nov 2021 16:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhKRPZJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Nov 2021 10:25:09 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47074 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbhKRPZH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Nov 2021 10:25:07 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C60C0212C4;
        Thu, 18 Nov 2021 15:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637248925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=DvXCv13/TWOEDrWtkkvBeubdJqm4HqnXqMRJkihk3J8=;
        b=bYaI3nTzDHxxAU/S8FoY3MLeDEoe4njB9idbZKvs5NIOY5eHNERNHr2hpvwlNO/8kKE2Vh
        XPMcjDRxFattBjo5YCO05V4ey9KggN62C/mMARgaSjSw5MeCQhWaxBCBGwOqKB7Lz0AGjl
        WYQ78XWvk2madfI8fD+o3tEeKLzRa8U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 94F8113D43;
        Thu, 18 Nov 2021 15:22:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id STjkIZ1vlmEPHQAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 18 Nov 2021 15:22:05 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs-progs: Add test for btrfs fi usage output
Date:   Thu, 18 Nov 2021 17:22:04 +0200
Message-Id: <20211118152204.424144-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There was a regression in btrfs progs release 5.15 due to changes in how
the ratio for the various raid profiles got calculated and this in turn
had a cascading effect on unallocated/allocated space reported.

Add a test to ensure this regression doesn't occur again.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 tests/cli-tests/016-btrfs-fi-usage/test.sh | 111 +++++++++++++++++++++
 1 file changed, 111 insertions(+)
 create mode 100755 tests/cli-tests/016-btrfs-fi-usage/test.sh

diff --git a/tests/cli-tests/016-btrfs-fi-usage/test.sh b/tests/cli-tests/016-btrfs-fi-usage/test.sh
new file mode 100755
index 000000000000..6c1563f8e0ce
--- /dev/null
+++ b/tests/cli-tests/016-btrfs-fi-usage/test.sh
@@ -0,0 +1,111 @@
+#!/bin/bash
+# Tests 'btrfs fi usage' reports correct space/ratio with various RAID profiles
+
+source "$TEST_TOP/common"
+
+check_prereq btrfs
+setup_root_helper
+setup_loopdevs 4
+prepare_loopdevs
+TEST_DEV=${loopdevs[1]}
+
+report_numbers()
+{
+	vars=($(run_check_stdout $SUDO_HELPER "$TOP/btrfs" filesystem usage -b "$TEST_MNT" | awk '
+	/Data ratio/ { ratio=$3 }
+	a {dev_alloc=$2; exit}
+	/Data,(DUP|RAID[0156][C34]{0,2}|single)/ { size=substr($2,6,length($2)-6); a=1 }
+END {print ratio " " size " " dev_alloc}'))
+
+	echo "${vars[@]}"
+}
+
+test_dup()
+{
+	run_check_mkfs_test_dev -ddup
+	run_check_mount_test_dev
+	vars=($(report_numbers))
+	data_chunk_size=${vars[1]}
+	used_on_dev=${vars[2]}
+	data_ratio=${vars[0]}
+
+	[[ $used_on_dev -eq $((2*$data_chunk_size)) ]] || _fail "DUP inconsistent chunk/device usage. Chunk: $data_chunk_size Device: $used_on_dev"
+
+	[[ "$data_ratio" = "2.00" ]] || _fail "DUP: Unexpected data ratio: $data_ratio (must be 2)"
+	run_check_umount_test_dev
+}
+
+test_raid1()
+{
+	# single is not raid1 but it has the same characteristics so put it in here
+	# as well
+	for i in single,1.00 raid1,2.00 raid1c3,3.00 raid1c4,4.00; do
+
+		# this allows to set the tuples to $1 and $2 respectively
+		OLDIFS=$IFS
+		IFS=","
+		set -- $i
+		IFS=$OLDIFS
+
+		run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f -d$1 ${loopdevs[@]}
+		run_check_mount_test_dev
+		vars=($(report_numbers))
+		data_chunk_size=${vars[1]}
+		used_on_dev=${vars[2]}
+		data_ratio=${vars[0]}
+
+		[[ $used_on_dev -eq $data_chunk_size ]] || _fail "$1 inconsistent chunk/device usage. Chunk: $data_chunk_size Device: $used_on_dev"
+
+		[[ "$data_ratio" = "$2" ]] || _fail "$1: Unexpected data ratio: $data_ratio (must be $2)"
+
+		run_check_umount_test_dev
+	done
+}
+
+test_raid0()
+{
+	run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f -draid0 ${loopdevs[@]}
+	run_check_mount_test_dev
+	vars=($(report_numbers))
+	data_chunk_size=${vars[1]}
+	used_on_dev=${vars[2]}
+	data_ratio=${vars[0]}
+
+	# Divide by 4 since 4 loopp devices are setup
+	[[ $used_on_dev -eq $(($data_chunk_size / 4)) ]] || _fail "raid0 inconsistent chunk/device usage. Chunk: $data_chunk_size Device: $used_on_dev"
+
+	[[ $data_ratio = "1.00" ]] || _fail "raid0: Unexpected data ratio: $data_ratio (must be 1.5)"
+	run_check_umount_test_dev
+}
+
+test_raid56()
+{
+	for i in raid5,1.33,3 raid6,2.00,2; do
+
+		# this allows to set the tuples to $1 and $2 respectively
+		OLDIFS=$IFS
+		IFS=","
+		set -- $i
+		IFS=$OLDIFS
+
+		run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f -d$1 ${loopdevs[@]}
+		run_check_mount_test_dev
+		vars=($(report_numbers))
+		data_chunk_size=${vars[1]}
+		used_on_dev=${vars[2]}
+		data_ratio=${vars[0]}
+
+		[[ $used_on_dev -eq $(($data_chunk_size / $3)) ]] || _fail "$i inconsistent chunk/device usage. Chunk: $data_chunk_size Device: $used_on_dev"
+
+		[[ $data_ratio = "$2" ]] || _fail "$1: Unexpected data ratio: $data_ratio (must be $2)"
+
+		run_check_umount_test_dev
+	done
+}
+
+test_dup
+test_raid1
+test_raid0
+test_raid56
+
+cleanup_loopdevs
-- 
2.17.1

