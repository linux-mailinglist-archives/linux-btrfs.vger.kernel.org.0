Return-Path: <linux-btrfs+bounces-10419-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEEB9F3756
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 18:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8887616B36F
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 17:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E254D207DF6;
	Mon, 16 Dec 2024 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNLNmkvl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0B02063D0
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369456; cv=none; b=Yy6tmfbJfoK2SJu0rqNV+eujFyR7fj1EPM5t+PYU/YZFqNetR2WTTlmyzajuYt0cf94B+eRLN2cmrvJzUtwlRXCzsr7P7FyiuRAsf7iDADVk7e6v+LldGEUnBZd0HiBxMgxu5E969b49X82qvshK8hgvCDgP/jesIMkignGZ7ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369456; c=relaxed/simple;
	bh=1suv9f2S9kTUFSV2EflrnOa4ShVUnmGdE64ARGDAt8U=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tvb2dqlXzZHhtPiZDqjAcxRzsKrkaiBxge5MFmqlCb9ufpfFQPBKO/KSxtFIUIKxmFO6usbOJZTTbjIYi3QLljrfOn5WLX7LdjUHuvMQaG0xF2MAAQxNV48exJBGL9TUADcu+3OJcwPr7KgN3/hBqQGYB6/5WbyvVY53ZjugzkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNLNmkvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F660C4CED0
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 17:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734369455;
	bh=1suv9f2S9kTUFSV2EflrnOa4ShVUnmGdE64ARGDAt8U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nNLNmkvl2WQ6OtlR8mJPuGaI8NOVXllT4hPOdl8qC4MQsWjxb1k3stJu9C0f6AUVc
	 7BcPu/j7JH5BwLnIyM4AGD5uPlqZRh27aB3MlwBgbnk/RKyFTg1Eb03Snl7Uu/B3H6
	 PLP8k1SKQMHCMlPcXgYq/2EAUJEFOjnRjfhtmXy5+OORy7wOPhipJddOnd74PmMPD6
	 H80uWZvoNbpz4nJbAICixgLqDyr1xl73cy5/FLd9mSzeYK15zDm1bebnjm0FZflRMU
	 HDbP/5EDuPWFA96zkLh5KJtSxIKNZTBKtoCk1ruKNzcPcGQMS4xE8XdhpWb0pU3aP5
	 V5nlr7DP6uovA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 8/9] btrfs: move extent-tree function declarations out of ctree.h
Date: Mon, 16 Dec 2024 17:17:23 +0000
Message-Id: <9b4b5042a21425eedfa2b5d3faecccf70704cf10.1734368270.git.fdmanana@suse.com>
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

We have 3 functions that have their prototypes declared in ctree.h but
they are defined at extent-tree.c and they are unrelated to the btree
data structure. Move the prototypes out of ctree.h and into extent-tree.h.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h            | 5 -----
 fs/btrfs/extent-tree.h      | 4 ++++
 fs/btrfs/free-space-cache.c | 2 +-
 fs/btrfs/volumes.c          | 2 +-
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 53f9fc04f66f..cdf10cca8194 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -505,11 +505,6 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 	return BTRFS_MAX_ITEM_SIZE(info) - sizeof(struct btrfs_dir_item);
 }
 
-void btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info, u64 start, u64 end);
-int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
-			 u64 num_bytes, u64 *actual_bytes);
-int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range);
-
 /* ctree.c */
 int __init btrfs_ctree_init(void);
 void __cold btrfs_ctree_exit(void);
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index 46b8e19022df..cfa52264f678 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -162,5 +162,9 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 			struct btrfs_root *root,
 			struct extent_buffer *node,
 			struct extent_buffer *parent);
+void btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info, u64 start, u64 end);
+int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
+			 u64 num_bytes, u64 *actual_bytes);
+int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range);
 
 #endif
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index cfa52ef40b06..17707c898eae 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -12,7 +12,7 @@
 #include <linux/error-injection.h>
 #include <linux/sched/mm.h>
 #include <linux/string_choices.h>
-#include "ctree.h"
+#include "extent-tree.h"
 #include "fs.h"
 #include "messages.h"
 #include "misc.h"
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1cccaf9c2b0d..7ebfc978cade 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -13,8 +13,8 @@
 #include <linux/list_sort.h>
 #include <linux/namei.h>
 #include "misc.h"
-#include "ctree.h"
 #include "disk-io.h"
+#include "extent-tree.h"
 #include "transaction.h"
 #include "volumes.h"
 #include "raid56.h"
-- 
2.45.2


