Return-Path: <linux-btrfs+bounces-9130-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5627C9AEBDA
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 18:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F41FB1F23D18
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 16:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1611F5841;
	Thu, 24 Oct 2024 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHly/SQM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675671F80C2
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787071; cv=none; b=lb48Bt1hPH4Bkmfyem8R7rieMkwmVHiakowQn6RFXT9YdS/U/SXFUzDcUZXXgnXsFKvYiV9MPCFDM+hJOh4N80K65h2BBDFXJ1un91+juNP6AKFulf46x0cbeIH5QqW/r6/lmGS0rJYnT5KCRaqBSExWKzQakOiO5zBbImOT4os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787071; c=relaxed/simple;
	bh=2TM5kw+3AMCjl212P0Xma/0fWZTxh6leN3rFH1E9BBo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bi4TmmRvuz9diXds9t08OXLFEQxHzYnRaQ9ltq8IbeplLqbAo5tdAUiVmwX/z+eIxwqCXwY0LbyVGEioet0wM1w6VALicczjHSJfZmgASNejGn4MNgSYF6WPf3KdO1wERwEGDZZRT7WzeBLkI1S7eXo24UfrKCA86iAGGa+1NOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHly/SQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FC4C4CEE4
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729787070;
	bh=2TM5kw+3AMCjl212P0Xma/0fWZTxh6leN3rFH1E9BBo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mHly/SQMt1GDCO+UsqtGQ5FhMAV7wI7qCSEoNxkDeCeFPoWrtaQHMfiazBeuqpWio
	 pCp14u134NoK5CHsbMdy4QH34ZNUmWN0tYFvaah9/RnYaSwiH7wpZU26AI/XwUOtMe
	 HlsUy13xIMu9nM+IgQ1BBrdc8/OFPurtQIeqh24nXPTey2eDl5wAtdTGrsSF8Yi3dC
	 Ibo5aH4VeZlnRhAR0X0zPOTRU0y1yRBy1NzC/0q5K97xml2b8S6b67wa7Clm44iSYu
	 BTh/s3Ub8B3j4xZwTyuhwkPtrLDIccH/Sj5VLtX8ZHdf6u41gCiHfFHqu7MSlUDabq
	 WCBCVhhp284Cw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 01/18] btrfs: remove BUG_ON() at btrfs_destroy_delayed_refs()
Date: Thu, 24 Oct 2024 17:24:09 +0100
Message-Id: <7b373dde44e2c2f7aacfbba08fc069bac8e5acfe.1729784712.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729784712.git.fdmanana@suse.com>
References: <cover.1729784712.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At btrfs_destroy_delayed_refs() it's unexpected to not find the block
group to which a delayed reference's extent belongs to, so we have this
BUG_ON(), not just because it's highly unexpected but also because we
don't know what to do there.

Since we are in the transaction abort path, there's nothing we can do
other than proceed and cleanup all used resources we can. So remove
the BUG_ON() and deal with a missing block group by logging an error
message and continuing to cleanup all we can related to the current
delayed ref head and moving to other delayed refs.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index bcf6e53bc2a7..47598e525ea5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4571,19 +4571,30 @@ static void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 			struct btrfs_block_group *cache;
 
 			cache = btrfs_lookup_block_group(fs_info, head->bytenr);
-			BUG_ON(!cache);
-
-			spin_lock(&cache->space_info->lock);
-			spin_lock(&cache->lock);
-			cache->pinned += head->num_bytes;
-			btrfs_space_info_update_bytes_pinned(fs_info,
-				cache->space_info, head->num_bytes);
-			cache->reserved -= head->num_bytes;
-			cache->space_info->bytes_reserved -= head->num_bytes;
-			spin_unlock(&cache->lock);
-			spin_unlock(&cache->space_info->lock);
-
-			btrfs_put_block_group(cache);
+			if (WARN_ON_ONCE(cache == NULL)) {
+				/*
+				 * Unexpected and there's nothing we can do here
+				 * because we are in a transaction abort path,
+				 * so any errors can only be ignored or reported
+				 * while attempting to cleanup all resources.
+				 */
+				btrfs_err(fs_info,
+"block group for delayed ref at %llu was not found while destroying ref head",
+					  head->bytenr);
+			} else {
+				spin_lock(&cache->space_info->lock);
+				spin_lock(&cache->lock);
+				cache->pinned += head->num_bytes;
+				btrfs_space_info_update_bytes_pinned(fs_info,
+								     cache->space_info,
+								     head->num_bytes);
+				cache->reserved -= head->num_bytes;
+				cache->space_info->bytes_reserved -= head->num_bytes;
+				spin_unlock(&cache->lock);
+				spin_unlock(&cache->space_info->lock);
+
+				btrfs_put_block_group(cache);
+			}
 
 			btrfs_error_unpin_extent_range(fs_info, head->bytenr,
 				head->bytenr + head->num_bytes - 1);
-- 
2.43.0


