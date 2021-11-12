Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEFF44E05B
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Nov 2021 03:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbhKLCip (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 21:38:45 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44466 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234499AbhKLCio (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 21:38:44 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EA432218A8;
        Fri, 12 Nov 2021 02:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636684553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5b5l+p2kRZ4sI1CtQB0bwnI7R1us2K1fuNCxb8D2wao=;
        b=qlhiToUNPiAkgXA9dJkCy4FBL6GHHQgmHKBS+8PG+aC6sQqt/pMy0YHwEvNm9KHecSE3LE
        YTAnQmSSf52lFMi7KfcMaM5xl20SdYs32HIo6uHbMiJOcgGWeNx8gFMT10rk6VVWjvpStc
        sc4qG9vGzDQYA+nhr98L31mz+iQEgso=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E94BC13D37;
        Fri, 12 Nov 2021 02:35:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rgFOKgjTjWGUGgAAMHmgww
        (envelope-from <wqu@suse.com>); Fri, 12 Nov 2021 02:35:52 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] fstests: btrfs/049: add regression test for compress-force=lzo mount option
Date:   Fri, 12 Nov 2021 10:35:35 +0800
Message-Id: <20211112023535.21370-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since kernel commit d4088803f511 ("btrfs: subpage: make lzo_compress_pages()
compatible"), lzo compression no longer respects the max compressed page
limit, and can cause kernel crash.

The fix is titled "btrfs: fix a out-of-boundary access for
copy_compressed_data_to_page()".

This patch will add such regression test for compress-force=lzo mount
option against incompressible data.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/049     | 41 +++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/049.out |  1 +
 2 files changed, 42 insertions(+)
 create mode 100755 tests/btrfs/049

diff --git a/tests/btrfs/049 b/tests/btrfs/049
new file mode 100755
index 00000000..5a73f738
--- /dev/null
+++ b/tests/btrfs/049
@@ -0,0 +1,41 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 049
+#
+# Test if btrfs will crash when compress-force=lzo hits incompressible data
+#
+. ./common/preamble
+_begin_fstest auto quick compress dangerous
+
+# Override the default cleanup function.
+# _cleanup()
+# {
+# 	cd /
+# 	rm -r -f $tmp.*
+# }
+
+# Import common functions.
+# . ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_require_scratch
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount -o compress-force=lzo
+
+$XFS_IO_PROG -f -c "pwrite -i /dev/urandom 0 4k" $SCRATCH_MNT/file > /dev/null
+
+# With kernel commit d4088803f511 ("btrfs: subpage: make lzo_compress_pages()
+# compatible"), the kernel would crash when writing back above data.
+_scratch_unmount
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/049.out b/tests/btrfs/049.out
index cb0061b3..c69568ad 100644
--- a/tests/btrfs/049.out
+++ b/tests/btrfs/049.out
@@ -1 +1,2 @@
 QA output created by 049
+Silence is golden
-- 
2.33.0

