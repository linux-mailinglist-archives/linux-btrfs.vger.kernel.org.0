Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38C53FFFF2
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Sep 2021 14:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348802AbhICMqT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Sep 2021 08:46:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60098 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbhICMqT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Sep 2021 08:46:19 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 44D6F21CCE
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Sep 2021 12:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630673118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=O610mBvZURoqYHuxckgN9T0z5w+xVd78LoX1tKf3Z2E=;
        b=TkZqqQPmR9PHITpJu0cssVnJn0c6MBGR7yjz6sQ6sATzCDVpdnSpQRZH3VKgXk6eLhOwpC
        IvODtAA96BHQesMgcgTZ6Bt8OK3ewaWMs/Yty9X7Fm/T1gF9LBPUd6osA1WnwbsXU1/IGR
        TmVgvAXT8HN6VyS+mSvPSQE6nYGqvb0=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 80F08137D0
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Sep 2021 12:45:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id JtxDEN0YMmGsMgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Sep 2021 12:45:17 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: unexport repair_io_failure()
Date:   Fri,  3 Sep 2021 20:45:14 +0800
Message-Id: <20210903124514.71575-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Function repair_io_failure() is no longer used out of extent_io.c since
commit 8b9b6f255485 ("btrfs: scrub: cleanup the remaining nodatasum
fixup code"), which removes the last external caller.

Just unexport it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 6 +++---
 fs/btrfs/extent_io.h | 3 ---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5ad749e19ff3..9f42a0b2ee4f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2282,9 +2282,9 @@ int free_io_failure(struct extent_io_tree *failure_tree,
  * currently, there can be no more than two copies of every data bit. thus,
  * exactly one rewrite is required.
  */
-int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
-		      u64 length, u64 logical, struct page *page,
-		      unsigned int pg_offset, int mirror_num)
+static int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
+			     u64 length, u64 logical, struct page *page,
+			     unsigned int pg_offset, int mirror_num)
 {
 	struct bio *bio;
 	struct btrfs_device *dev;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 9f3e0a45a5e4..ba471f2063a7 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -283,9 +283,6 @@ struct bio *btrfs_io_bio_alloc(unsigned int nr_iovecs);
 struct bio *btrfs_bio_clone(struct bio *bio);
 struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size);
 
-int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
-		      u64 length, u64 logical, struct page *page,
-		      unsigned int pg_offset, int mirror_num);
 void end_extent_writepage(struct page *page, int err, u64 start, u64 end);
 int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mirror_num);
 
-- 
2.33.0

