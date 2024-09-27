Return-Path: <linux-btrfs+bounces-8294-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E5598826C
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 12:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502021C22A4E
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 10:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21DB186617;
	Fri, 27 Sep 2024 10:30:25 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ED82B9CD;
	Fri, 27 Sep 2024 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727433025; cv=none; b=XEo+/mCB3S9kjV21JJtcSgy9Czs+pm0JQ8A0ckJ106Snhffti5aETMxjU/DlDtcI4ppxxRwf0azViDXgrVi2BwmFOw1R7EDcLkL0Xu1FsLWv5A8G+yg0MZ9BhFIisxYa4eIi3Iag2KxppjvYZbxSedMsY42dB/f46JUJtBT7q68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727433025; c=relaxed/simple;
	bh=i23Iim9cXkdz6Ckb0/1ebishCfbJ1d4LcWObJufVyDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ck0XyCzZtERVxvVY7xqjISD/9JH1bmIrJV80nZCCzKEVmtIeEn31FTiXbuo7M/x1uTi+RD8nwcuQIJu8LyjKMiY8NatR9gMuIev3DgNWUbrJppyASxjQM7vtVv8xTuWWMDwC77javYsrSqh0XSoemXGn+g/qhH3OcxM//PKi90w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cae4eb026so18976765e9.0;
        Fri, 27 Sep 2024 03:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727433022; x=1728037822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S0irRWsRKnoaNN2u1s1xIgNFbfY4YoxqLzDCKhb9xrs=;
        b=LhWHMo1+LLujeUQTCig4J6EvXlQ6WnSjyJN+A0YqYn+XMiFI1mJu8CqFgdBe9SNNQK
         XgzJQ/+g+paPCUHm4moLeX+UkZvfuFsMtX4BeMzE4TjbSh2JV6fwXC8xQ9gihNj2Z/U9
         RqkJ2QvXiKeUSkHri5c3oo+Roz0FanIfrflnL9RbwlygXopKSBSkXTyPXd2VyUNSOHxM
         rlq84EaFQPgOESb+tgnfu4cUW6FqyvtNHiemGTo/WQHKhBlEDHbZfIfBvqyBkqmL7s+j
         n3iNKINtz7BVfUHfc1FTSEA9X1dG+tsK64oZxp2GsyvZ/8yMCqvU0N52jbk7aEXp9GMv
         /E/A==
X-Forwarded-Encrypted: i=1; AJvYcCV9GkJn017xr6h0kDKAwIcXZRHEUh6f6xLvc5X2Vty+GcmXpmop+7S62rFR0u7R7EomDKWBT4JT3LHHvzE9@vger.kernel.org, AJvYcCVVXfHjVf3tmzLUKXge0mbZkT/eg8NnWIHmwHUNUL1I0/MzubauEFmM8ZWMfXQoZDQMpoZuxePTg9LtUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqLbBCEUXVmzhFHxGOGY3snaaZ4nsMGx+XbnZ7FOsd3QYkEgxG
	e11k8t6gF+7KQPz3HX1G6Zmd/RfTHmmzNZRZqWCgrcJjz8NufubUCZdLTqOQGZK7Eg==
X-Google-Smtp-Source: AGHT+IFmClhrcMQrR/bnQGKsXe8FFtEfQLC+uO9RryHGCXleHz6eZa8yvlVFO4IjZi4Tos/cCGhhVA==
X-Received: by 2002:a05:600c:1d20:b0:42c:b995:2100 with SMTP id 5b1f17b1804b1-42f5840d2a9mr19447505e9.6.1727433021513;
        Fri, 27 Sep 2024 03:30:21 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f71aeb00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71a:eb00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e9027450asm80141695e9.0.2024.09.27.03.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 03:30:20 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Filipe Manana <fdmanana@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2] btrfs: remove code duplication in ordered extent finishing
Date: Fri, 27 Sep 2024 12:30:05 +0200
Message-ID: <20240927103005.16239-1-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Remove the duplicated transaction joining, block reserve setting and raid
extent inserting in btrfs_finish_ordered_extent().

While at it, also abort the transaction in case inserting a RAID
stripe-tree entry fails.

Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
Changes to v1:
- Moved comments to the preferred style (Filipe)
---
 fs/btrfs/inode.c | 48 +++++++++++++++++++-----------------------------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 353fb58c83da..412dba9c66c3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3068,34 +3068,6 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 			goto out;
 	}
 
-	if (test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags)) {
-		BUG_ON(!list_empty(&ordered_extent->list)); /* Logic error */
-
-		btrfs_inode_safe_disk_i_size_write(inode, 0);
-		if (freespace_inode)
-			trans = btrfs_join_transaction_spacecache(root);
-		else
-			trans = btrfs_join_transaction(root);
-		if (IS_ERR(trans)) {
-			ret = PTR_ERR(trans);
-			trans = NULL;
-			goto out;
-		}
-		trans->block_rsv = &inode->block_rsv;
-		ret = btrfs_update_inode_fallback(trans, inode);
-		if (ret) /* -ENOMEM or corruption */
-			btrfs_abort_transaction(trans, ret);
-
-		ret = btrfs_insert_raid_extent(trans, ordered_extent);
-		if (ret)
-			btrfs_abort_transaction(trans, ret);
-
-		goto out;
-	}
-
-	clear_bits |= EXTENT_LOCKED;
-	lock_extent(io_tree, start, end, &cached_state);
-
 	if (freespace_inode)
 		trans = btrfs_join_transaction_spacecache(root);
 	else
@@ -3109,8 +3081,26 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 	trans->block_rsv = &inode->block_rsv;
 
 	ret = btrfs_insert_raid_extent(trans, ordered_extent);
-	if (ret)
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
 		goto out;
+	}
+
+	if (test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags)) {
+		/* Logic error */
+		BUG_ON(!list_empty(&ordered_extent->list));
+
+		btrfs_inode_safe_disk_i_size_write(inode, 0);
+		ret = btrfs_update_inode_fallback(trans, inode);
+		if (ret) {
+			/* -ENOMEM or corruption */
+			btrfs_abort_transaction(trans, ret);
+		}
+		goto out;
+	}
+
+	clear_bits |= EXTENT_LOCKED;
+	lock_extent(io_tree, start, end, &cached_state);
 
 	if (test_bit(BTRFS_ORDERED_COMPRESSED, &ordered_extent->flags))
 		compress_type = ordered_extent->compress_type;
-- 
2.46.1


