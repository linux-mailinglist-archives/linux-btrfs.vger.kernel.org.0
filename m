Return-Path: <linux-btrfs+bounces-10565-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB6D9F6BEE
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 18:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEACC188150A
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 17:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACBE1FA8D8;
	Wed, 18 Dec 2024 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgP9PRwz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BDF1FA8D6
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541620; cv=none; b=Q2PgQFLHqfwfrIG/oqwMbDlKV1QePsqIXpViiMhe1e5fksv4cPOZQ3+c/39beqh2JZ2bI7dcqZq2LZCctfuqWFlxSiuTdXJbZNcf/qEagYZJf4BFZE4xStvSXtEOoYCPya+cWFl9O5UkPDBdelkOkf5KM1BvhQu1gMLG4QeF3qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541620; c=relaxed/simple;
	bh=G2Yf43vIG9olS0cGs5gb4tZAw/qH/tXvSip0GfUBG5c=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LAdWh+sxvFBXYQZ1MbOVqA+pvJdgjFKt39DGRO6gpxD/WW3w/SbaNJkcwMqunGVyLllA+LBGhC5aJNSgVqIoVYK2xZ67xbyFPoci+ZAYAML8HGTGilm1kWZBWtZszq0WUpQA/10WKK6j2FM/0Ork5uAAU6nRLSmxjyt8mvZGbbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgP9PRwz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E7AC4CED0
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734541620;
	bh=G2Yf43vIG9olS0cGs5gb4tZAw/qH/tXvSip0GfUBG5c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fgP9PRwzK140foI1WEr9OOsG2WQbpH1zjyKdmVIc1pPfQMTQsKzXPSy/0RV6IEjNq
	 8YC9WU04UKmQL9oHCoOPLArkNJlJf9EQzJp19XMmlPhaXL31MluIpMBZub6QSHcL8f
	 /tGlMSpiZxzaQ1FcVEw1NzID5aVPXh/TdnPa7C1yaGxeV2UPOpFIxxxWNHMRgBKTok
	 TrEytWC4Wf9HDGSAtycIruyxPHw/VUsjuD1imWhHZjg1uLB+Dx2y/28g0t8tryV/Ar
	 9qNIpRlNNvtIYBbPb3Yo+X0EHrXmk6Z+D0mr8yfXmUcmO5MlLfUxz4BvOpyKNdTUMG
	 0i/LlcLBPLrsw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 09/20] btrfs: file-item: remove unnecessary calls to btrfs_mark_buffer_dirty()
Date: Wed, 18 Dec 2024 17:06:36 +0000
Message-Id: <e57e3526e43f99eb4cb19a0fe563c64a371e3bd5.1734527445.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1734527445.git.fdmanana@suse.com>
References: <cover.1734527445.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We have several places explicitly calling btrfs_mark_buffer_dirty() but
that is not necessarily since the target leaf came from a path that was
obtained for a btree search function that modifies the btree, something
like btrfs_insert_empty_item() or anything else that ends up calling
btrfs_search_slot() with a value of 1 for its 'cow' argument.

These just make the code more verbose, confusing and add a little extra
overhead and well as increase the module's text size, so remove them.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file-item.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 886749b39672..d04a3b47b1fb 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -190,8 +190,6 @@ int btrfs_insert_hole_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_file_extent_compression(leaf, item, 0);
 	btrfs_set_file_extent_encryption(leaf, item, 0);
 	btrfs_set_file_extent_other_encoding(leaf, item, 0);
-
-	btrfs_mark_buffer_dirty(trans, leaf);
 out:
 	btrfs_free_path(path);
 	return ret;
@@ -1259,7 +1257,6 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 	ins_size /= csum_size;
 	total_bytes += ins_size * fs_info->sectorsize;
 
-	btrfs_mark_buffer_dirty(trans, path->nodes[0]);
 	if (total_bytes < sums->len) {
 		btrfs_release_path(path);
 		cond_resched();
-- 
2.45.2


