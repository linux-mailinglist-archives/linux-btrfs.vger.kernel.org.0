Return-Path: <linux-btrfs+bounces-1783-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C94F83BEC6
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 11:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14A5EB28C7B
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 10:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00361CFBC;
	Thu, 25 Jan 2024 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6ef4GOK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264661CABC
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706178395; cv=none; b=VEf6rra2xfJ7VmcweG9XlOHoQE4SUk7X6tXDWxnsw4pcZQEoL/hT5+J6wkFUxY5OAVsZMBNCJBGX4eAhOxRWxcMWeOeLD97HlhUh6uIN0t3sUi2wRwZOIF7jl92pPOZkS9HTpN5+bhFQSraIrNOxn3Z08sosRN8vnrecNzn+gVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706178395; c=relaxed/simple;
	bh=a/Z8NlrgMADXJY5F4ipZrUN0GX5eLstqHayrNkkcngw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZVJrqJKlUang8gFvOuc38h4C0bA317MrK/PrHRNru+1DSvLIy4BmSY2AopLstUeNj4iiS20fS5SiPMLxFqdSVqaFlzRz8WlvIFYtcMYbfik+ZN0MtgWHJs+zoRpTq8cp6+HDOSP6zE6dKzblhjuIoz4pMHJvqcWyC10mPN/o5Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6ef4GOK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F473C43399
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 10:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706178394;
	bh=a/Z8NlrgMADXJY5F4ipZrUN0GX5eLstqHayrNkkcngw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=X6ef4GOKuqLW+8Nq1Zqkse+x2mb6oKD1TGTWr5ntxbVfjXGY1JBfQOEPL1Ggn+0T3
	 WufQiiyMP5iUjwH6ezsycReI+qsq1IltpRuAzflMCv7r6m7hkegPXU2CCi0tYjiFMY
	 0/S8ky88ffj5WDsI7xeTswlem7nQdhUTofnzxy0eFi9f2RWk7HnFjSOViXGfJAWzrk
	 l3R7CsgOJuNpVQqhbppgcaezMF3b1BI9LATEDEuuxtRg2qHqGIcgPvbs/EpJdD7S3c
	 z9fos/x+j6KFqzs5jlkB1Cy6JitQEQhFfQnNHgNXuwCm7leQycWVNjEjnfubFGsvNq
	 1fSrZbWD0Ug9w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/5] btrfs: add new unused block groups to the list of unused block groups
Date: Thu, 25 Jan 2024 10:26:26 +0000
Message-Id: <6182c48084855e40c898c019d9d6bcbca7e3722d.1706177914.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706177914.git.fdmanana@suse.com>
References: <cover.1706177914.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Space reservations for metadata are, most of the time, pessimistic as we
reserve space for worst possible cases - where tree heights are at the
maximum possible height (8), we need to COW every extent buffer in a tree
path, need to split extent buffers, etc.

For data, we generally reserve the exact amount of space we are going to
allocate. The exception here is when using compression, in which case we
reserve space matching the uncompressed size, as the compression only
happens at writeback time and in the worst possible case we need that
amount of space in case the data is not compressible.

This means that when there's not available space in the corresponding
space_info object, we may need to allocate a new block group, and then
that block group might not be used after all. In this case the block
group is never added to the list of unused block groups and ends up
never being deleted - except if we unmount and mount again the fs, as
when reading block groups from disk we add unused ones to the list of
unused block groups (fs_info->unused_bgs). Otherwise a block group is
only added to the list of unused block groups when we deallocate the
last extent from it, so if no extent is ever allocated, the block group
is kept around forever.

This also means that if we have a bunch of tasks reserving space in
parallel we can end up allocating many block groups that end up never
being used or kept around for too long without being used, which has
the potential to result in ENOSPC failures in case for example we over
allocate too many metadata block groups and then end up in a state
without enough unallocated space to allocate a new data block group.

This is more likely to happen with metadata reservations as of kernel
6.7, namely since commit 28270e25c69a ("btrfs: always reserve space for
delayed refs when starting transaction"), because we started to always
reserve space for delayed references when starting a transaction handle
for a non-zero number of items, and also to try to reserve space to fill
the gap between the delayed block reserve's reserved space and its size.

So to avoid this, when finishing the creation a new block group, add the
block group to the list of unused block groups if it's still unused at
that time. This way the next time the cleaner kthread runs, it will delete
the block group if it's still unused and not needed to satisfy existing
space reservations.

CC: stable@vger.kernel.org # 6.7+
Reported-by: Ivan Shapovalov <intelfx@intelfx.name>
Link: https://lore.kernel.org/linux-btrfs/9cdbf0ca9cdda1b4c84e15e548af7d7f9f926382.camel@intelfx.name/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5fe37bc82f11..378d9103a207 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2729,6 +2729,37 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 		btrfs_dec_delayed_refs_rsv_bg_inserts(fs_info);
 		list_del_init(&block_group->bg_list);
 		clear_bit(BLOCK_GROUP_FLAG_NEW, &block_group->runtime_flags);
+
+		/*
+		 * If the block group is still unused, add it to the list of
+		 * unused block groups. The block group may have been created in
+		 * order to satisfy a space reservation, in which case the
+		 * extent allocation only happens later. But often we don't
+		 * actually need to allocate space that we previously reserved,
+		 * so the block group may become unused for a long time. For
+		 * example for metadata we generally reserve space for a worst
+		 * possible scenario, but then don't end up allocating all that
+		 * space or none at all (due to no need to COW, extent buffers
+		 * were already COWed in the current transaction and still
+		 * unwritten, tree heights lower than the maximum possible
+		 * height, etc). For data we generally reserve the axact amount
+		 * of space we are going to allocate later, the exception is
+		 * when using compression, as we must reserve space based on the
+		 * uncompressed data size, because the compression is only done
+		 * when writeback triggered and we don't know how much space we
+		 * are actually going to need, so we reserve the uncompressed
+		 * size because the data may be uncompressible in the worst case.
+		 */
+		if (ret == 0) {
+			bool used;
+
+			spin_lock(&block_group->lock);
+			used = btrfs_is_block_group_used(block_group);
+			spin_unlock(&block_group->lock);
+
+			if (!used)
+				btrfs_mark_bg_unused(block_group);
+		}
 	}
 	btrfs_trans_release_chunk_metadata(trans);
 }
-- 
2.40.1


