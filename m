Return-Path: <linux-btrfs+bounces-10417-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 737859F3758
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 18:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4238188083D
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 17:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FB5207A33;
	Mon, 16 Dec 2024 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoEKt6s6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C11207A0E
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369454; cv=none; b=u+l6C3mZ3QbmqT+2zBJzhQbNlCiaz4qg2b5NoLzUW1aYSpJMgYvkRpsHUm3WaIB63WaHJmlcFqaNRtyYDTAtgtIs/Ht2+4JQ2KiSOlFiwSoEkIr0XUXEapV03EcEpHEcqLqPVwdhM7HMTggeiqv+33JS8xJD8ytSEYpgAOLiTxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369454; c=relaxed/simple;
	bh=LQf6MsALj6WrAaHOoGYdWNSoVfYsf+QQQ228dnO2TAg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Acer+gzu2yILAwbd7/K0IVIZrnYvfZyj07gd1kwmu4Ft3NkJyT/SvCsSa4E3uRhAYZOtp0HOLAVg5a5gpXK2O8Q48j0084/yDvF2xKofS12HDc+pFUqW9rnGYH/GBq4afMiY+/n3CNgPY6n+S4Paut/hWfk57QHYsnLix8oX/lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoEKt6s6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145D6C4CEDE
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 17:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734369453;
	bh=LQf6MsALj6WrAaHOoGYdWNSoVfYsf+QQQ228dnO2TAg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SoEKt6s6VpOgOosXN0ZgAbBnyMXqeA+wL+bXTmx9LW8A0gDkHxqBEYsdn8Ue4G8lO
	 cX4GqtrVtT+IqBjwnPbkmLoLjFafWXfy8hD9XEVTwJoVVyoUSUZdlvkxb4c/K1hA/a
	 7IvTtCBqy1tDJQUySUEmLiLcjuELf/USi2TcWLoMBRpdc5GQqM8x8aA1YArxlsE7T2
	 H9hjVmqLgnOCeShU1/oqpLTQRL3zifCZ0vkIAtQ02EM3qILuE0IkGobYjoU0HyeSVb
	 r/VL8PoOBxBMufC8q2t8TMX4HKx1FSayGUkQ91lNwInyxayTgrHR2GILRkd1oaKwm4
	 +kvTogS+sIOpA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 6/9] btrfs: move BTRFS_BYTES_TO_BLKS() into fs.h
Date: Mon, 16 Dec 2024 17:17:21 +0000
Message-Id: <e9cf706f8df6bb14e03aba096f9ba2334039dc72.1734368270.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1734368270.git.fdmanana@suse.com>
References: <cover.1734368270.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently BTRFS_BYTES_TO_BLKS() is defined in ctree.h but it's not related
at all to the btree data structure, so move it into fs.h.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h | 3 ---
 fs/btrfs/fs.h    | 2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 3d9855d30057..bf054470dcd0 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -506,9 +506,6 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 	return BTRFS_MAX_ITEM_SIZE(info) - sizeof(struct btrfs_dir_item);
 }
 
-#define BTRFS_BYTES_TO_BLKS(fs_info, bytes) \
-				((bytes) >> (fs_info)->sectorsize_bits)
-
 static inline gfp_t btrfs_alloc_write_mask(struct address_space *mapping)
 {
 	return mapping_gfp_constraint(mapping, ~__GFP_FS);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 7a27f5fe9bc2..dd1a82297d4c 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -953,6 +953,8 @@ static inline u64 btrfs_calc_metadata_size(const struct btrfs_fs_info *fs_info,
 #define BTRFS_MAX_EXTENT_ITEM_SIZE(r) ((BTRFS_LEAF_DATA_SIZE(r->fs_info) >> 4) - \
 					sizeof(struct btrfs_item))
 
+#define BTRFS_BYTES_TO_BLKS(fs_info, bytes) ((bytes) >> (fs_info)->sectorsize_bits)
+
 static inline bool btrfs_is_zoned(const struct btrfs_fs_info *fs_info)
 {
 	return IS_ENABLED(CONFIG_BLK_DEV_ZONED) && fs_info->zone_size > 0;
-- 
2.45.2


