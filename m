Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97CD9428C96
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 14:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236423AbhJKMJJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 08:09:09 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52224 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236430AbhJKMJC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 08:09:02 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AF40021C95
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Oct 2021 12:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633954021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mBCpzLXOQt5E+ogyHATMlbB+3w/n9T1izap85Vz0Q0Q=;
        b=rq3W9U1NcFPrzFB1PF5JojpIyRWpbyRxTus/wPJwkYXB5RPn1NwZbZt7m95X9LoSH/iD8M
        G4xHFOiJLd0HzAIb1667aTXOKTkKi62GB8gaCmPB/a1ACkgAzSI/cragGic5oTukR9/fxu
        I1TDgLzL3CG0rvjpNt9Elwvg/ikh9fE=
Received: from adam-pc.lan (wqu.tcp.ovpn2.nue.suse.de [10.163.34.62])
        by relay2.suse.de (Postfix) with ESMTP id B8637A3B87
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Oct 2021 12:07:00 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/3] btrfs-progs: mfks-tests: make sure mkfs.btrfs cleans up temporary chunks
Date:   Mon, 11 Oct 2021 20:06:50 +0800
Message-Id: <20211011120650.179017-4-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011120650.179017-1-wqu@suse.com>
References: <20211011120650.179017-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since current "btrfs filesystem df" command will warn if there are
multiple profiles of the same type, it's a good way to detect left-over
temporary chunks.

This patch will enhance the existing mkfs-tests/001-basic-profiles test
case to also check for the warning messages, to make sure mkfs.btrfs has
properly cleaned up all temporary chunks.

There is a special workaround newly implemented in test_get_info(), as
recent kernel introduced single device RAID0 support, which is no
different than SINGLE.

But for single device RAID0, kernel may choose to preallocate new chunks
with SINGLE profile, causing false alerts.

Work around this kernel bug by mounting the btrfs read-only to prevent
preallocating new chunks.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/mkfs-tests/001-basic-profiles/test.sh | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tests/mkfs-tests/001-basic-profiles/test.sh b/tests/mkfs-tests/001-basic-profiles/test.sh
index b3ba50d71ddc..0be199749864 100755
--- a/tests/mkfs-tests/001-basic-profiles/test.sh
+++ b/tests/mkfs-tests/001-basic-profiles/test.sh
@@ -11,10 +11,22 @@ setup_root_helper
 
 test_get_info()
 {
+	tmp_out=$(mktemp --tmpdir btrfs-progs-mkfs-tests-get-info.XXXXXX)
 	run_check $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super "$dev1"
 	run_check $SUDO_HELPER "$TOP/btrfs" check "$dev1"
-	run_check $SUDO_HELPER mount "$dev1" "$TEST_MNT"
-	run_check "$TOP/btrfs" filesystem df "$TEST_MNT"
+
+	btrfs ins dump-tree -t chunk "$dev1" >> "$RESULTS"
+
+	# Work around a kernel bug that kernel will treat SINGLE and single
+	# device RAID0 as the same.
+	# Thus kernel may create new SINGLE chunks, causing extra warning
+	# when testing single device RAID0.
+	run_check $SUDO_HELPER mount -o ro "$dev1" "$TEST_MNT"
+	if grep -q "Multiple block group profiles detected" "$tmp_out"; then
+		rm -- "$tmp_out"
+		_fail "temporary chunks are not properly cleaned up"
+	fi
+	rm -- "$tmp_out"
 	run_check $SUDO_HELPER "$TOP/btrfs" filesystem usage "$TEST_MNT"
 	run_check $SUDO_HELPER "$TOP/btrfs" device usage "$TEST_MNT"
 	run_check $SUDO_HELPER umount "$TEST_MNT"
-- 
2.33.0

