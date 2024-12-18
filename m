Return-Path: <linux-btrfs+bounces-10575-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 553199F6C05
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 18:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9555A1887328
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 17:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48531FBEBD;
	Wed, 18 Dec 2024 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoMF4aoL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068F71FBEAA
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541631; cv=none; b=OuJW1C+9DsAv/31SgZMiqzyLV8YP0AskfjS7wMWQZtsQKlkfet/QANL/AKmEMAZpcxTSTjPLtWb2OxVnOFeoKFiFMfQ491qU2enlb03TE1DSVnXL2KpJguGGfEsdCBimTU5WzMkGUAL1gJUN9vtliLM8GNLPYhExmxjRe0JTaqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541631; c=relaxed/simple;
	bh=XKE9hGDbVTXihAfTuetBRbi35ErMjC0c9DFeXS1dYqI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LrEMfb0tHj60hlLHLxmQvKTFINbKgeKK4RuD6CpmJYmG0Gh3whKBPT/5u9IoNkfvFHBnLzRstHSzghWURfyhejVkNqEAMhMqHryNW/KdYwyUTyqCRG1f0LLMJqnumCjdbHpyvYKUtfX+cq82+p1dM2aOyDkkRPj/sAdxVn4UDX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoMF4aoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C11BC4CEDD
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734541630;
	bh=XKE9hGDbVTXihAfTuetBRbi35ErMjC0c9DFeXS1dYqI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MoMF4aoLeeUkjj30Mwfk1pNE+LlLeKqYDCrW26SAK4TpbTbtChIxe2paJ1KmtLFpe
	 g8k1shdAsljs0UMZ5Ko875r95ZYkTk8LBwXIR+DfgHJWCSuiIRnv9IP5DtqdypLgaF
	 gydWESjMmj4XTm4ll4eqkZNGtAOZ3cTzTW7yiKMl+Sye0ULQZ5T6vOr0k5WY9I8HGA
	 YGchlb8O41dTl4eFh3RrwxdWFQCFpmx3S8a9/JcZylokTUzi2yZszuEupIoUsN+CeG
	 htr0XML5I64CTsTk+ipCOugzQsa121W9Z+1VdUJWB10vj+kdVny5bzWVIPEmrwZCQb
	 3sqjniWTHnFbQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 19/20] btrfs: volumes: remove unnecessary calls to btrfs_mark_buffer_dirty()
Date: Wed, 18 Dec 2024 17:06:46 +0000
Message-Id: <932b0c07f2d8a7ea4e7dd52eb71545490346ad2b.1734527445.git.fdmanana@suse.com>
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
 fs/btrfs/volumes.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d32913c51d69..7975d0d1236c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2046,7 +2046,6 @@ static int btrfs_add_dev_item(struct btrfs_trans_handle *trans,
 	ptr = btrfs_device_fsid(dev_item);
 	write_extent_buffer(leaf, trans->fs_info->fs_devices->metadata_uuid,
 			    ptr, BTRFS_FSID_SIZE);
-	btrfs_mark_buffer_dirty(trans, leaf);
 
 	ret = 0;
 out:
@@ -2742,11 +2741,9 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
 		device = btrfs_find_device(fs_info->fs_devices, &args);
 		BUG_ON(!device); /* Logic error */
 
-		if (device->fs_devices->seeding) {
+		if (device->fs_devices->seeding)
 			btrfs_set_device_generation(leaf, dev_item,
 						    device->generation);
-			btrfs_mark_buffer_dirty(trans, leaf);
-		}
 
 		path->slots[0]++;
 		goto next_slot;
@@ -3039,8 +3036,6 @@ static noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
 				     btrfs_device_get_disk_total_bytes(device));
 	btrfs_set_device_bytes_used(leaf, dev_item,
 				    btrfs_device_get_bytes_used(device));
-	btrfs_mark_buffer_dirty(trans, leaf);
-
 out:
 	btrfs_free_path(path);
 	return ret;
@@ -3749,10 +3744,7 @@ static int insert_balance_item(struct btrfs_fs_info *fs_info,
 	btrfs_set_balance_meta(leaf, item, &disk_bargs);
 	btrfs_cpu_balance_args_to_disk(&disk_bargs, &bctl->sys);
 	btrfs_set_balance_sys(leaf, item, &disk_bargs);
-
 	btrfs_set_balance_flags(leaf, item, bctl->flags);
-
-	btrfs_mark_buffer_dirty(trans, leaf);
 out:
 	btrfs_free_path(path);
 	err = btrfs_commit_transaction(trans);
@@ -7746,8 +7738,6 @@ static int update_dev_stat_item(struct btrfs_trans_handle *trans,
 	for (i = 0; i < BTRFS_DEV_STAT_VALUES_MAX; i++)
 		btrfs_set_dev_stats_value(eb, ptr, i,
 					  btrfs_dev_stat_read(device, i));
-	btrfs_mark_buffer_dirty(trans, eb);
-
 out:
 	btrfs_free_path(path);
 	return ret;
-- 
2.45.2


