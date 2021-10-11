Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4AA4289E2
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 11:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbhJKJpN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 05:45:13 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33580 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235599AbhJKJpJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 05:45:09 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C3AC420047
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Oct 2021 09:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633945388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yoUAuEbdUPRYtt/1N+3MLX48IQ9PSH8SOVJ7uRR8Cgs=;
        b=RfBpbsrmotIHhRnDFzTUFkJ4crpDKJMRVXC3DpIaOujWFwKM+yrM9jpGJhvbO9Rll5A+yB
        1w+t6adVLa2KB97Bu3Rgbcza/7te0/Dz9lfxESTxjUdhKQ8IL3U5PsZcma9sKKUJ+7KZty
        9P3JstH7KQj1alPhqbGQ6Gqsh8RXSqc=
Received: from adam-pc.lan (unknown [10.163.34.62])
        by relay2.suse.de (Postfix) with ESMTP id D29A9A3BF0
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Oct 2021 09:43:07 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: mfks-tests: make sure mkfs.btrfs cleans up temporary chunks
Date:   Mon, 11 Oct 2021 17:43:00 +0800
Message-Id: <20211011094300.97504-4-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011094300.97504-1-wqu@suse.com>
References: <20211011094300.97504-1-wqu@suse.com>
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

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/mkfs-tests/001-basic-profiles/test.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/mkfs-tests/001-basic-profiles/test.sh b/tests/mkfs-tests/001-basic-profiles/test.sh
index b3ba50d71ddc..e44f9344bc6f 100755
--- a/tests/mkfs-tests/001-basic-profiles/test.sh
+++ b/tests/mkfs-tests/001-basic-profiles/test.sh
@@ -11,11 +11,17 @@ setup_root_helper
 
 test_get_info()
 {
+	tmp_out=$(mktemp --tmpdir btrfs-progs-mkfs-tests-get-info.XXXXXX)
 	run_check $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super "$dev1"
 	run_check $SUDO_HELPER "$TOP/btrfs" check "$dev1"
 	run_check $SUDO_HELPER mount "$dev1" "$TEST_MNT"
-	run_check "$TOP/btrfs" filesystem df "$TEST_MNT"
-	run_check $SUDO_HELPER "$TOP/btrfs" filesystem usage "$TEST_MNT"
+	run_check_stdout "$TOP/btrfs" filesystem df "$TEST_MNT" > "$tmp_out"
+	if grep -q "Multiple block group profiles detected" "$tmp_out"; then
+		rm -- "$tmp_out"
+		_fail "temporary chunks are not properly cleaned up"
+	fi
+	rm -- "$tmp_out"
+	run_check$SUDO_HELPER "$TOP/btrfs" filesystem usage "$TEST_MNT"
 	run_check $SUDO_HELPER "$TOP/btrfs" device usage "$TEST_MNT"
 	run_check $SUDO_HELPER umount "$TEST_MNT"
 }
-- 
2.33.0

