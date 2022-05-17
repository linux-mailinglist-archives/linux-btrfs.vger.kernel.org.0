Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E875A52999E
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 08:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbiEQGfH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 02:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiEQGfG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 02:35:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154353FBD6;
        Mon, 16 May 2022 23:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=4EbXQYz/l5U4btSHrZ0I0ih1rzAJEOdrCD6qUJUkRwc=; b=i9L19imrF+zXjh6DSnnc7/QG38
        C1m3emUdQTi8QwSOchhoHVHq/x0nGDqqlzDgv5UAog1muftsunJadilUgYUhKU19Xbawei7RE0jvC
        wfI9tzU1yoypKxFFRBKh8BZJxkHh7k/2QmwIDd/WZ6sZXBDnkUag33LrJqgMs0fjlasvhiLsVDbLv
        5PQKcwZNb6GpUlVbn0ZXhu4ysAODjAYc3BvTVNWpVGzEhyxzjK5zn+X3fZMz5pmRLCAjFoftB8TvB
        quTbjsgyEyhZQ5DxnIetU+XVXuNxUZjPVJyPBjIB8ggrLBhl98P+6mvGgjLl8V4+RSM36urX6PRGT
        2vVy2T2g==;
Received: from [2001:4bb8:19a:7bdf:afb1:9e:37ad:b912] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqqnQ-00Bpcl-A2; Tue, 17 May 2022 06:35:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] fstests: add a btrfs read_repair group
Date:   Tue, 17 May 2022 08:35:02 +0200
Message-Id: <20220517063502.3017563-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a new group to run all tests the exercise the btrfs read_repair code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 doc/group-names.txt | 1 +
 tests/btrfs/140     | 2 +-
 tests/btrfs/141     | 2 +-
 tests/btrfs/142     | 2 +-
 tests/btrfs/143     | 2 +-
 tests/btrfs/150     | 2 +-
 tests/btrfs/157     | 2 +-
 tests/btrfs/215     | 2 +-
 8 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/doc/group-names.txt b/doc/group-names.txt
index e8e3477e..ef411b5e 100644
--- a/doc/group-names.txt
+++ b/doc/group-names.txt
@@ -88,6 +88,7 @@ punch			fallocate FALLOC_FL_PUNCH_HOLE
 qgroup			btrfs qgroup feature
 quota			filesystem usage quotas
 raid			btrfs RAID
+read_repair		btrfs error correction on read failure
 realtime		XFS realtime volumes
 recoveryloop		crash recovery loops
 redirect		overlayfs redirect_dir feature
diff --git a/tests/btrfs/140 b/tests/btrfs/140
index 66efc126..c680fe0a 100755
--- a/tests/btrfs/140
+++ b/tests/btrfs/140
@@ -12,7 +12,7 @@
 #	commit 2e949b0a5592 ("Btrfs: fix invalid dereference in btrfs_retry_endio")
 #
 . ./common/preamble
-_begin_fstest auto quick
+_begin_fstest auto quick read_repair
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/141 b/tests/btrfs/141
index ca164fdc..9fdcb2ab 100755
--- a/tests/btrfs/141
+++ b/tests/btrfs/141
@@ -13,7 +13,7 @@
 #	Commit 9d0d1c8b1c9d ("Btrfs: bring back repair during read")
 #
 . ./common/preamble
-_begin_fstest auto quick
+_begin_fstest auto quick read_repair
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/142 b/tests/btrfs/142
index c88cace9..58d01add 100755
--- a/tests/btrfs/142
+++ b/tests/btrfs/142
@@ -13,7 +13,7 @@
 #	commit 97bf5a5589aa ("Btrfs: fix segmentation fault when doing dio read")
 #
 . ./common/preamble
-_begin_fstest auto quick
+_begin_fstest auto quick read_repair
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/143 b/tests/btrfs/143
index 8f086ee8..71db861d 100755
--- a/tests/btrfs/143
+++ b/tests/btrfs/143
@@ -20,7 +20,7 @@
 #	commit 9d0d1c8b1c9d ("Btrfs: bring back repair during read")
 #
 . ./common/preamble
-_begin_fstest auto quick
+_begin_fstest auto quick read_repair
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/150 b/tests/btrfs/150
index 986c8069..c5e9c709 100755
--- a/tests/btrfs/150
+++ b/tests/btrfs/150
@@ -11,7 +11,7 @@
 #	Btrfs: fix kernel oops while reading compressed data
 #
 . ./common/preamble
-_begin_fstest auto quick dangerous
+_begin_fstest auto quick dangerous read_repair
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/157 b/tests/btrfs/157
index ae56f3e1..343178b7 100755
--- a/tests/btrfs/157
+++ b/tests/btrfs/157
@@ -21,7 +21,7 @@
 # Btrfs: make raid6 rebuild retry more
 #
 . ./common/preamble
-_begin_fstest auto quick raid
+_begin_fstest auto quick raid read_repair
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/215 b/tests/btrfs/215
index cbcd60e0..0dcbce2a 100755
--- a/tests/btrfs/215
+++ b/tests/btrfs/215
@@ -9,7 +9,7 @@
 # 814723e0a55a ("btrfs: increment device corruption error in case of checksum error")
 #
 . ./common/preamble
-_begin_fstest auto quick
+_begin_fstest auto quick read_repair
 
 # Import common functions.
 . ./common/filter
-- 
2.30.2

