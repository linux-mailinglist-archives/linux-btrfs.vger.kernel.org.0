Return-Path: <linux-btrfs+bounces-8257-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D60987329
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 14:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262BF1F25615
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 12:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DD0175D2F;
	Thu, 26 Sep 2024 11:59:52 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C26F1607AC;
	Thu, 26 Sep 2024 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351991; cv=none; b=NOGEGN404h9Q9z2AVpvwBvb9N9lNHdV7ulZCTF+HKtjwy9/0SI6f38X4Evl/KQQxo82wEIOptYn0z5aTKKcLWvvPuGVwvZZIut0IOUF463pDo+n+GmtcHrlcUsC4D4/N4vTtljYHZmkhtqu+z/jU/Ag27SkwF9Yn7xq5RUJDJ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351991; c=relaxed/simple;
	bh=9Irs03yPr6tjELLL2FPcWUMBrotw8+KG6uF7QcNk5io=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EaOQpTzbaJEjoKhRKrStBPO4xZgL78rpr3BQwOxSOJXp7JupYSxAT+d4u/P+fjX0KhJQNOp0o/WdgoX4Xe4VtNodBJjWVb1noqGaA3XrDhKcoga1i+TKRWRSTlQqFUla2tOD+QKQmD9FemYu5sVlmsRl7Y63vLwm5iNlH06lhoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42f56ad2afaso2938175e9.1;
        Thu, 26 Sep 2024 04:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727351988; x=1727956788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gxSjjMFIL5z+1ilqVFAedbVxswn5znP/0ZSm6j/I5zU=;
        b=nOtz0xoPkzk4iZN0pTo2XEBkDgUKsPZgp2BeL3w4gnsmuIqVSAAr4025BHo8sLqoQR
         bFrJZPCp/phjxUjXarPAclIvGq6v26hodu84gTGTFheAnIG75ThgI+6iyp3zJnk5dZPk
         U+A0O/MdfGFQxYicVeWFQTVyxE+aC6omBsZLFN0hUB8JRAW/aWta6IBlC4zIKdHNOBXe
         m8jajXiGNo0K0zaIlEkhGVxL9TgzROo+WuRo7qigg0zoOzWu1V4xUKxnylS/W75pa0KJ
         x2MMKwLudQq/FggkUaUyGr0Nx6PVgNVSfEX8dosYi0uIxXpRyO97AaAyPXaPesT6eLoX
         OaNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFevz6AqxdwIwE2mCiuRpEuE5sv3/tIPga1FcLMN3863yOygCMwR+UyvZCFETXwRGz0PVTefe7i5zLb39x@vger.kernel.org, AJvYcCWkvGqO5CAyeqLIBuNG9JGS2GlMKOLidGK2C6vGxYVvK5/HhBWnJDiQJonWMggdgNuxKdF/3P3LhPBGtw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2sEcevA+orERRooAeZ4HtN71FCQ0ufKGyVvCvU2di7Nocxwy5
	qsvSJIprZKdcDFj1WF2nk2fMpMK7Ky7BMp60GbEjtZghUFZUfjs4
X-Google-Smtp-Source: AGHT+IEc5vBF0pHaaWrHKVe6N8bqzSwjg/UM76GSZVbZBUvqAeMhP6OtJMqnMG7P38GAR/+gCbkBxA==
X-Received: by 2002:a05:600c:1c26:b0:42c:bae0:f05f with SMTP id 5b1f17b1804b1-42e9610ac1cmr49115685e9.13.1727351987911;
        Thu, 26 Sep 2024 04:59:47 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f71aeb00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71a:eb00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2cd263sm6274057f8f.48.2024.09.26.04.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 04:59:47 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: remove code duplication in ordered extent finishing
Date: Thu, 26 Sep 2024 13:59:35 +0200
Message-ID: <20240926115935.20631-1-jth@kernel.org>
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
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/inode.c | 45 ++++++++++++++++-----------------------------
 1 file changed, 16 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 353fb58c83da..35a03a671fc6 100644
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
@@ -3109,8 +3081,23 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 	trans->block_rsv = &inode->block_rsv;
 
 	ret = btrfs_insert_raid_extent(trans, ordered_extent);
-	if (ret)
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto out;
+	}
+
+	if (test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags)) {
+		BUG_ON(!list_empty(&ordered_extent->list)); /* Logic error */
+
+		btrfs_inode_safe_disk_i_size_write(inode, 0);
+		ret = btrfs_update_inode_fallback(trans, inode);
+		if (ret) /* -ENOMEM or corruption */
+			btrfs_abort_transaction(trans, ret);
 		goto out;
+	}
+
+	clear_bits |= EXTENT_LOCKED;
+	lock_extent(io_tree, start, end, &cached_state);
 
 	if (test_bit(BTRFS_ORDERED_COMPRESSED, &ordered_extent->flags))
 		compress_type = ordered_extent->compress_type;
-- 
2.43.0


