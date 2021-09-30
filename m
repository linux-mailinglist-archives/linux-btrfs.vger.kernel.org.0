Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801B941D915
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Sep 2021 13:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350611AbhI3Lu7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Sep 2021 07:50:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54772 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350609AbhI3Lu7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Sep 2021 07:50:59 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1EAF420022
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Sep 2021 11:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633002556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aE3+IC2D4U4Qiz9u5G80PakKGMLVjnC587WrtROR4W0=;
        b=Oxjzr51NyVqN0ftw3j47+ZIqdZpPU/1Dc9LNMvdeRH1uDCIdl7VzN9hRM1r0w5vjyhnTwJ
        oz2aYRm8XuQKla2rsa9cG0Un1yE7Lt/BTVBflamFo4/R3Ygm+ixk+emoU0UwRGhpcyejI8
        z1bKecNEOCeGiWfamya/jHrU36AluOc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 739E513B05
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Sep 2021 11:49:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YBQXEDukVWELJQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Sep 2021 11:49:15 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs-progs: misc-tests: add test case for receive --clone-fallback
Date:   Thu, 30 Sep 2021 19:48:55 +0800
Message-Id: <20210930114855.39225-3-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210930114855.39225-1-wqu@suse.com>
References: <20210930114855.39225-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new test case will create two send streams:

- parent_stream
  A full send stream.
  Contains one file, as clone source.

- clone_stream
  An incremental send stream.
  Contains one clone operation.

Then we will receive the parent_stream with default mount options, while
try to receive the clone_stream with nodatasum mount option.

This should result clone failure due to nodatasum flag mismatch.

Then check if the receive can continue with --clone-fallback option.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/common                                  |  9 +++
 .../049-receive-clone-fallback/test.sh        | 58 +++++++++++++++++++
 2 files changed, 67 insertions(+)
 create mode 100755 tests/misc-tests/049-receive-clone-fallback/test.sh

diff --git a/tests/common b/tests/common
index 253071025db2..0423af4231a8 100644
--- a/tests/common
+++ b/tests/common
@@ -633,6 +633,15 @@ run_check_mount_test_dev()
 	run_check $SUDO_HELPER mount -t btrfs $loop_opt "$@" "$TEST_DEV" "$TEST_MNT"
 }
 
+run_check_remount_test_dev()
+{
+	setup_root_helper
+
+	local opts="$1"
+
+	run_check $SUDO_HELPER mount -o "remount,$opts" "$TEST_MNT"
+}
+
 # $1-$n: optional paths to unmount, otherwise fallback to TEST_DEV
 run_check_umount_test_dev()
 {
diff --git a/tests/misc-tests/049-receive-clone-fallback/test.sh b/tests/misc-tests/049-receive-clone-fallback/test.sh
new file mode 100755
index 000000000000..18136a9e63ee
--- /dev/null
+++ b/tests/misc-tests/049-receive-clone-fallback/test.sh
@@ -0,0 +1,58 @@
+#!/bin/bash
+# Verify that btrfs receive can fallback to buffered copy when clone
+# failed
+
+source "$TEST_TOP/common"
+
+check_prereq mkfs.btrfs
+check_prereq btrfs
+setup_root_helper
+prepare_test_dev
+
+tmp=$(mktemp -d --tmpdir btrfs-progs-send-stream.XXXXXX)
+
+# Create two sends stream, one as the parent and the other as an incremental
+# stream with one clone operation.
+run_check_mkfs_test_dev
+run_check_mount_test_dev -o datacow,datasum
+run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT/subv"
+run_check $SUDO_HELPER dd if=/dev/zero bs=1M count=1 of="$TEST_MNT/subv/file1" 
+run_check $SUDO_HELPER "$TOP/btrfs" subvolume snapshot -r "$TEST_MNT/subv" \
+	"$TEST_MNT/snap1"
+run_check $SUDO_HELPER cp --reflink=always "$TEST_MNT/subv/file1" \
+	"$TEST_MNT/subv/file2"
+run_check $SUDO_HELPER "$TOP/btrfs" subvolume snapshot -r "$TEST_MNT/subv" \
+	"$TEST_MNT/snap2"
+
+run_check $SUDO_HELPER "$TOP/btrfs" send -f "$tmp/parent_stream" \
+	"$TEST_MNT/snap1"
+run_check $SUDO_HELPER "$TOP/btrfs" send -f "$tmp/clone_stream" \
+	-p "$TEST_MNT/snap1" "$TEST_MNT/snap2"
+
+run_check_umount_test_dev
+run_check_mkfs_test_dev
+
+# Receive the first stream with the same mount option
+run_check_mount_test_dev -o datacow -o datasum
+
+# Receiving the full stream should not fail
+run_check $SUDO_HELPER "$TOP/btrfs" receive -f "$tmp/parent_stream" "$TEST_MNT"
+
+# Remount the fs with nodatasum mount option, so that the new file received
+# through the incremental stream will end up with the nodatasum flag set.
+run_check_remount_test_dev nodatasum
+
+# Receiving incremental send stream without --clone-fallback should fail.
+# As the clone source and destination have different NODATASUM flags
+run_mustfail "receiving clone with different NODATASUM should fail" \
+	$SUDO_HELPER "$TOP/btrfs" receive -f "$tmp/clone_stream" "$TEST_MNT"
+
+# Firstly we need to cleanup the partially received subvolume
+run_check $SUDO_HELPER "$TOP/btrfs" subvolume delete "$TEST_MNT/snap2"
+
+# With --clone-fallback specified, the receive should finish without problem
+run_check $SUDO_HELPER "$TOP/btrfs" receive --clone-fallback \
+	-f "$tmp/clone_stream" "$TEST_MNT"
+run_check_umount_test_dev
+
+rm -rf -- "$tmp"
-- 
2.33.0

