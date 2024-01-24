Return-Path: <linux-btrfs+bounces-1731-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7BC83AFB1
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC00328C185
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18E9823A7;
	Wed, 24 Jan 2024 17:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="UwLZXEdj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA92B7F7CD
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116812; cv=none; b=gjovaolYTNKbyIxowK2pJeT+3yMaXjv9FbsFe3LWgkxYb9U8yu+8VGtLDqljXsW3aYWhBIs4hk+2TjoLIjn+k91RP+1x005e1M/Z+MyO40px/wODmXyGF1jaS+bQ4viQ94S5etzvV9gKDqdWB9xQBxz3lInPgT/TXHudC1/yU20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116812; c=relaxed/simple;
	bh=WbTRB9lE7epD1hoYbMG+ZF3S4ix/GhaIB0ommCRuatc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIb8l8VVRZZWyy4tlHc1SsYpYDiDwHgz+FqmsJqAi5MclDQQH0lqNPrvq8cH4J2ISBi7H7tGXS2KSmJH0dj0AbNL/stGRAbLUFndKSerlViYmIwVgPDgK1o7zrLPg9HtHDoMB2oug+b2S1v783VkvEBfznUMlwHDM5FGQVH0Ih4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=UwLZXEdj; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc25099b084so3796836276.0
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116809; x=1706721609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8lKOYzvD3OCjcsdzO+Q4jt7UVBXuG0LvsP4wyIM2rZ0=;
        b=UwLZXEdj556MLA2EV+CnOTNwT/tp6eMQ4Wxv4yNv4KAc08llUpXTVnzyT8lmnL0BFp
         2v7usSte8RS/IN7oVq5DRuqAo1QBW2o0c4vlxf5mbCXBC6/0xR/ohfHCClnMtipYQ3ox
         DT6xulzQ15QBqOX06ewi4q7L/1lMygb+5U86ygtgkxa1w48Ob7UOhryAY4HtOK68qn14
         xaDfiqTTYw3K15/G5uqpnHi6+2ocke2GuT86zNhigp/mmJ16W+SYs7EnNqcCfoK+pD9Y
         wIt3dsFggAmPn9CVhIpPe7wYVOBzmYBsjCBODaa895UZt5O2rG4glUq6Oa9jr4/DtT/J
         I1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116809; x=1706721609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8lKOYzvD3OCjcsdzO+Q4jt7UVBXuG0LvsP4wyIM2rZ0=;
        b=h90jTcXlhVCMdv1FlyApbBcI19GC0zk9++dA+dnX5WzxYTo42jyOWW8YjdE5Yt17uU
         7ndEnR0NSjRH9IjG2XiEa5WSGxdNCygPm8/vujg865+uokVddpXRPQ6djlRQz1BSTXAx
         A38A4zFDdcVG0cj/qR+UH5lAyZyWIDX9ZUuSbLyjFJwoGbCJNcXSOyZuS9T0ItkVugwE
         cukxjZdFAH/HybkJOsAWlW2RZ1pDU2xnlYZ3fc5QG6ms/xRnXFx4qh6Lz8FxpS+o0Mqf
         HqcIPYeJfRUGVaGi5EF2FphCiXnkX/L/ntOoUXfvivtj3YlbteVhV87bXUhuNydMX1Dx
         Y1tQ==
X-Gm-Message-State: AOJu0YzArLoxXp99g3+j9QXMa0NSxPMLPhW+o6pLPQYk0oJgsrVWHz+B
	zHc0+0yI+dd6BwVohIwZMbGe/9xSGRU+nSKTZkd6+L0rojLT/wGcPBwJ5xamnIOCBEpGsjCndBU
	C
X-Google-Smtp-Source: AGHT+IEK8MX9vvHJelwQ58erY6WdUgz1jusq/7aPm4l0ou90SJ9NcRF0+CqO1nklSAgLh0znDAVgxA==
X-Received: by 2002:a25:c245:0:b0:dc2:3289:5b5d with SMTP id s66-20020a25c245000000b00dc232895b5dmr963919ybf.57.1706116809605;
        Wed, 24 Jan 2024 09:20:09 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id y17-20020a056902053100b00dc2217892a4sm2848565ybs.56.2024.01.24.09.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:20:09 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 49/52] btrfs: support encryption with log replay
Date: Wed, 24 Jan 2024 12:19:11 -0500
Message-ID: <d1ada7ac632c2ab554a840c7ba29b53a93b9855f.1706116485.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706116485.git.josef@toxicpanda.com>
References: <cover.1706116485.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Log replay needs a few tweaks in order to make sure everything works
with encryption.

1. Use the size of the item itself, not the size of the item object when
   we're replaying an extent.
2. Copy in the fscrypt context if we find one in the log.
3. Set NEEDS_FULL_SYNC when we update the inode context so all of the
   items are copied into the log at fsync time.

This makes replay of encrypted files work properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/fscrypt.c  |  1 +
 fs/btrfs/tree-log.c | 10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/fscrypt.c b/fs/btrfs/fscrypt.c
index 83fa99a5be6e..b24591af3410 100644
--- a/fs/btrfs/fscrypt.c
+++ b/fs/btrfs/fscrypt.c
@@ -147,6 +147,7 @@ static int btrfs_fscrypt_set_context(struct inode *inode, const void *ctx,
 			goto out_err;
 	}
 
+	set_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &BTRFS_I(inode)->runtime_flags);
 	leaf = path->nodes[0];
 	ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 6fc16612b9b8..42c2b90515be 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -715,6 +715,7 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 	if (found_type == BTRFS_FILE_EXTENT_REG ||
 	    found_type == BTRFS_FILE_EXTENT_PREALLOC) {
 		u64 offset;
+		u32 item_size;
 		unsigned long dest_offset;
 		struct btrfs_key ins;
 
@@ -722,14 +723,16 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 		    btrfs_fs_incompat(fs_info, NO_HOLES))
 			goto update_inode;
 
+		item_size = btrfs_item_size(eb, slot);
+
 		ret = btrfs_insert_empty_item(trans, root, path, key,
-					      sizeof(*item));
+					      item_size);
 		if (ret)
 			goto out;
 		dest_offset = btrfs_item_ptr_offset(path->nodes[0],
 						    path->slots[0]);
 		copy_extent_buffer(path->nodes[0], eb, dest_offset,
-				(unsigned long)item,  sizeof(*item));
+				(unsigned long)item, item_size);
 
 		ins.objectid = btrfs_file_extent_disk_bytenr(eb, item);
 		ins.offset = btrfs_file_extent_disk_num_bytes(eb, item);
@@ -2511,7 +2514,8 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 			continue;
 
 		/* these keys are simply copied */
-		if (key.type == BTRFS_XATTR_ITEM_KEY) {
+		if (key.type == BTRFS_XATTR_ITEM_KEY ||
+		    key.type == BTRFS_FSCRYPT_INODE_CTX_ITEM_KEY) {
 			ret = overwrite_item(wc->trans, root, path,
 					     eb, i, &key);
 			if (ret)
-- 
2.43.0


