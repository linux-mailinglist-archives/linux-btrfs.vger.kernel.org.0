Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DABC390458
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2019 17:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfHPPGI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Aug 2019 11:06:08 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35744 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbfHPPGH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Aug 2019 11:06:07 -0400
Received: by mail-qk1-f196.google.com with SMTP id r21so5012755qke.2
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2019 08:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/jN/mH4Z9ut1okjG/yzfD356K6/+JhQnBNiXWoBStmo=;
        b=Rr4leqBOws7u8rSZgoyJCcHrVqSz+mNRMIQD8e7QI1q1W8h5wnIRRjYhrzP3N4Abl1
         V/bFS2GYkHLow3rTdUZLztWyVGfgYrqhZ1ZSV/3Ermj45TjO5H26VVb3kVf4orY7QcEb
         770DkFRYqBo9ZoGT5EmTn3gUUca4mT5tPXC8AsmdFXNl7zd/3HEi/8ZxKN9qPAHxIrtp
         wL65J2UqQeS0DLJ+zuOgDKUwL1dw+y0yO/kJbSGR9JiQQ3UfZ+mvjIHmDqlTPCbLRCOb
         7JuYPP5LhVgzhBid9AfaRu4ZOIBZpCYtrKfF9QEJW42pk63Hi4SugvD9SQs7xC4vNIlh
         Hovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/jN/mH4Z9ut1okjG/yzfD356K6/+JhQnBNiXWoBStmo=;
        b=lNt62Xh4C0FvxyJ6vHJCKatqIN0lN0lGci5baN0tlTGpqkrQ/AHuD/dqaWuP1tt0w3
         R2oU/M9fdgh0YRMbIH8jTEzWSTFbLH+KAh4QgzEk5h+XQ87FYwysvKKmhL1rAO4JhnyP
         kC7vZmVRRyAFf474iaio+wFZ35ynLBR5ca678cDJvMrUq5XNgjUmHSaZm3e9/5a+AONm
         Nfhpk0YbNYec8xDK5DIc+7OdptmKBeM8WVTSpxD/T4M1rkeI0Y3J1GHYrnIS7IqxkHjN
         2P3BjSzAcgcDOl+pc6Be65NemqI806bOTWxdQ0FHFmlIegbq2LtkYbzUvQjc4VMcKft4
         MHlQ==
X-Gm-Message-State: APjAAAU4KLWncARxqkQS4ID7nQU3/112TmYO+Xxlpmwban3YGlLsjLgL
        /74Q7FvFqsWXgfeChEUp/AqbIzeMUBc42A==
X-Google-Smtp-Source: APXvYqx07dPn0vV+xkzXYENl4Awkt1UaGYnCZqlZMHjDqtW/gDzH4dPC03vhqbgwzALcESmIknUMWw==
X-Received: by 2002:a37:64c8:: with SMTP id y191mr9133612qkb.210.1565967966749;
        Fri, 16 Aug 2019 08:06:06 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y204sm3423632qka.54.2019.08.16.08.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 08:06:06 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/3] btrfs: only reserve metadata_size for inodes
Date:   Fri, 16 Aug 2019 11:05:59 -0400
Message-Id: <20190816150600.9188-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816150600.9188-1-josef@toxicpanda.com>
References: <20190816150600.9188-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Historically we reserved worst case for every btree operation, and
generally speaking we want to do that in cases where it could be the
worst case.  However for updating inodes we know the inode items are
already in the tree, so it will only be an update operation and never an
insert operation.  This allows us to always reserve only the
metadata_size amount for inode updates rather than the
insert_metadata_size amount.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delalloc-space.c | 15 ++++++++++++---
 fs/btrfs/delayed-inode.c  |  2 +-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 2412be4a3de2..b8111ebdc92a 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -251,9 +251,16 @@ static void btrfs_calculate_inode_block_rsv_size(struct btrfs_fs_info *fs_info,
 
 	lockdep_assert_held(&inode->lock);
 	outstanding_extents = inode->outstanding_extents;
-	if (outstanding_extents)
+
+	/*
+	 * Insert size for the number of outstanding extents, 1 normal size for
+	 * updating the inode.
+	 */
+	if (outstanding_extents) {
 		reserve_size = btrfs_calc_insert_metadata_size(fs_info,
-						outstanding_extents + 1);
+						outstanding_extents);
+		reserve_size += btrfs_calc_metadata_size(fs_info, 1);
+	}
 	csum_leaves = btrfs_csum_bytes_to_leaves(fs_info,
 						 inode->csum_bytes);
 	reserve_size += btrfs_calc_insert_metadata_size(fs_info,
@@ -278,10 +285,12 @@ static void calc_inode_reservations(struct btrfs_fs_info *fs_info,
 {
 	u64 nr_extents = count_max_extents(num_bytes);
 	u64 csum_leaves = btrfs_csum_bytes_to_leaves(fs_info, num_bytes);
+	u64 inode_update = btrfs_calc_metadata_size(fs_info, 1);
 
 	/* We add one for the inode update at finish ordered time */
 	*meta_reserve = btrfs_calc_insert_metadata_size(fs_info,
-						nr_extents + csum_leaves + 1);
+						nr_extents + csum_leaves);
+	*meta_reserve += inode_update;
 	*qgroup_reserve = nr_extents * fs_info->nodesize;
 }
 
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index de87ea7ce84d..9318cf761a07 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -612,7 +612,7 @@ static int btrfs_delayed_inode_reserve_metadata(
 	src_rsv = trans->block_rsv;
 	dst_rsv = &fs_info->delayed_block_rsv;
 
-	num_bytes = btrfs_calc_insert_metadata_size(fs_info, 1);
+	num_bytes = btrfs_calc_metadata_size(fs_info, 1);
 
 	/*
 	 * btrfs_dirty_inode will update the inode under btrfs_join_transaction
-- 
2.21.0

