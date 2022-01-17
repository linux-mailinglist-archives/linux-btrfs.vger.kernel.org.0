Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D06490048
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jan 2022 03:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236838AbiAQCjP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Jan 2022 21:39:15 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41318 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236829AbiAQCjM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Jan 2022 21:39:12 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 90C4D1F39A
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jan 2022 02:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642387151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QRceVjnFaeBlvbCSeQDV9IqnK+9RrIvS7d3mJMmFlbQ=;
        b=OV+gniwWW24KNKl9rdjh4kW0I04eosEqvMCt+0HG0oxdmznya+h42qEgRhy59AeSeoPOhZ
        3XCq534G7oXtlg4m+5PtlLSbWF2XxYZaN7WVJHCM0t+PqisUiw0UmNitHRxbgiEjeTJeZ9
        1rQDzNxZnIfrzK2vFWf9Js34SqO8S+Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E4D8F13216
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jan 2022 02:39:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AGdPK87W5GG9MAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jan 2022 02:39:10 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: tests/fsck: add test image with invalid metadata backref level
Date:   Mon, 17 Jan 2022 10:38:50 +0800
Message-Id: <20220117023850.40337-4-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220117023850.40337-1-wqu@suse.com>
References: <20220117023850.40337-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The image has a key in extent tree, (30457856 METADATA_ITEM 256), which
has invalid level (256 > BTRFS_MAX_LEVEL).

Make sure check can at least detect such problem.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../053-bad-metadata-level/default.img.xz     | Bin 0 -> 2084 bytes
 .../fsck-tests/053-bad-metadata-level/test.sh |  19 ++++++++++++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 tests/fsck-tests/053-bad-metadata-level/default.img.xz
 create mode 100755 tests/fsck-tests/053-bad-metadata-level/test.sh

diff --git a/tests/fsck-tests/053-bad-metadata-level/default.img.xz b/tests/fsck-tests/053-bad-metadata-level/default.img.xz
new file mode 100644
index 0000000000000000000000000000000000000000..d7debee7b7c2bb457dbe734da2429859245770ae
GIT binary patch
literal 2084
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
O#Ao{g000001X)_pOZyN2

literal 0
HcmV?d00001

diff --git a/tests/fsck-tests/053-bad-metadata-level/test.sh b/tests/fsck-tests/053-bad-metadata-level/test.sh
new file mode 100755
index 000000000000..0ffd7bdf34a1
--- /dev/null
+++ b/tests/fsck-tests/053-bad-metadata-level/test.sh
@@ -0,0 +1,19 @@
+#!/bin/bash
+#
+# Verify that check can detect invalid metadata backref level.
+#
+# There is a report that btrfs-check original mode doesn't report invalid
+# metadata backref level, and lowmem mode would just crash.
+#
+# Make sure btrfs check can at least detect such error.
+
+source "$TEST_TOP/common"
+
+check_prereq btrfs
+
+check_image() {
+	run_mustfail "invalid metadata backref level not detected" \
+		"$TOP/btrfs" check "$1"
+}
+
+check_all_images
-- 
2.34.1

