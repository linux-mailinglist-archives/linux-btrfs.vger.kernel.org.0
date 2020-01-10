Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9942813728B
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 17:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgAJQLg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jan 2020 11:11:36 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36493 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728492AbgAJQLg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jan 2020 11:11:36 -0500
Received: by mail-qk1-f193.google.com with SMTP id a203so2326156qkc.3
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2020 08:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Kskmwj6FrI7Shs9A8VY921eBeoA98bfV8GCQBdKXFU=;
        b=R2agfhszauQ5JVD9fxMW2sgoUbEAyye4YUK3FQn3s9ENeVgyjWgeDNuRvb5T8ULxpK
         yi8oiKgtf0lQXzl/RAflEr6mwAxTxPZ+YkTSJYh3BP+aYW5aUIw3nwf1x/jr4hUMiIlu
         qW9p330XMiAvIFEWvnK+IIHr7QBFz3A+Fw8ZI8jMzkDkK1BnNyShKjjkItzLA1rOylB+
         RwvSoG9ufJJaYNiop3NpBjalzn8r83I1vlSOjX3sbRxzxU/uZx2XtNJYW4ibuyGZ956I
         VnsedIP58vRdB9t8BN/vtccqEsFt0Xkp6iVGIMGKZZj9X6uKUhAte8U1GgFWjo6fYnPV
         J3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Kskmwj6FrI7Shs9A8VY921eBeoA98bfV8GCQBdKXFU=;
        b=bOhFBn35qmDK6WehjDujc3F+wQOnLo3ufPC+yRyyml8iZ7k1wFfH4KZMDW37xsuxsv
         gKsVYqg4n1HXmErNI3gvuBtpQTQ4LKCbDCuygeNWB1YHfTxhKYHbyqJRNqtBJNnbLEZE
         QyK6BbYnRdaGkIKl9DGnuKqHSlt55jpxi0PWlP7dRM5z8mxw1zplLTMDx7Dkgn3z6wut
         ynJ5ghi05glx9PWGkxQoItF7Dy11Tnb+ykzXG02oO66L49u3DXPt+bhdre7d4IdXwHN1
         kUiafgPJqClzRw8Kn0+bLmhtmMMd6Ej0ngi+qneENg0Zhxme2uDn5Jqpy1wCio7qC84A
         txZg==
X-Gm-Message-State: APjAAAWLquWrtXzLroG7C1qTvbhXebGKNz+2GRbT4v+rfA0wnL/SL4Ev
        LR/euUY9d9z6JqQCZso3YImAeZxQt32nZQ==
X-Google-Smtp-Source: APXvYqwRHIYXD9nrhI5H+nGa7iZNuIPJ8f4EjJjPd1hxthSy18gsC6Gw4sLLsQ+T4ECVm/knHvHlMg==
X-Received: by 2002:ae9:ef4b:: with SMTP id d72mr3702289qkg.27.1578672694740;
        Fri, 10 Jan 2020 08:11:34 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k9sm1194056qtq.75.2020.01.10.08.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 08:11:34 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 2/5] btrfs: don't pass system_chunk into can_overcommit
Date:   Fri, 10 Jan 2020 11:11:25 -0500
Message-Id: <20200110161128.21710-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110161128.21710-1-josef@toxicpanda.com>
References: <20200110161128.21710-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have the space_info, we can just check its flags to see if it's the
system chunk space info.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/space-info.c | 41 +++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index f09aa6ee9113..df5fb68df798 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -161,8 +161,7 @@ static inline u64 calc_global_rsv_need_space(struct btrfs_block_rsv *global)
 
 static int can_overcommit(struct btrfs_fs_info *fs_info,
 			  struct btrfs_space_info *space_info, u64 bytes,
-			  enum btrfs_reserve_flush_enum flush,
-			  bool system_chunk)
+			  enum btrfs_reserve_flush_enum flush)
 {
 	u64 profile;
 	u64 avail;
@@ -173,7 +172,7 @@ static int can_overcommit(struct btrfs_fs_info *fs_info,
 	if (space_info->flags & BTRFS_BLOCK_GROUP_DATA)
 		return 0;
 
-	if (system_chunk)
+	if (space_info->flags & BTRFS_BLOCK_GROUP_SYSTEM)
 		profile = btrfs_system_alloc_profile(fs_info);
 	else
 		profile = btrfs_metadata_alloc_profile(fs_info);
@@ -227,8 +226,7 @@ void btrfs_try_granting_tickets(struct btrfs_fs_info *fs_info,
 
 		/* Check and see if our ticket can be satisified now. */
 		if ((used + ticket->bytes <= space_info->total_bytes) ||
-		    can_overcommit(fs_info, space_info, ticket->bytes, flush,
-				   false)) {
+		    can_overcommit(fs_info, space_info, ticket->bytes, flush)) {
 			btrfs_space_info_update_bytes_may_use(fs_info,
 							      space_info,
 							      ticket->bytes);
@@ -626,8 +624,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 
 static inline u64
 btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
-				 struct btrfs_space_info *space_info,
-				 bool system_chunk)
+				 struct btrfs_space_info *space_info)
 {
 	struct reserve_ticket *ticket;
 	u64 used;
@@ -643,13 +640,13 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 
 	to_reclaim = min_t(u64, num_online_cpus() * SZ_1M, SZ_16M);
 	if (can_overcommit(fs_info, space_info, to_reclaim,
-			   BTRFS_RESERVE_FLUSH_ALL, system_chunk))
+			   BTRFS_RESERVE_FLUSH_ALL))
 		return 0;
 
 	used = btrfs_space_info_used(space_info, true);
 
 	if (can_overcommit(fs_info, space_info, SZ_1M,
-			   BTRFS_RESERVE_FLUSH_ALL, system_chunk))
+			   BTRFS_RESERVE_FLUSH_ALL))
 		expected = div_factor_fine(space_info->total_bytes, 95);
 	else
 		expected = div_factor_fine(space_info->total_bytes, 90);
@@ -665,7 +662,7 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 
 static inline int need_do_async_reclaim(struct btrfs_fs_info *fs_info,
 					struct btrfs_space_info *space_info,
-					u64 used, bool system_chunk)
+					u64 used)
 {
 	u64 thresh = div_factor_fine(space_info->total_bytes, 98);
 
@@ -673,8 +670,7 @@ static inline int need_do_async_reclaim(struct btrfs_fs_info *fs_info,
 	if ((space_info->bytes_used + space_info->bytes_reserved) >= thresh)
 		return 0;
 
-	if (!btrfs_calc_reclaim_metadata_size(fs_info, space_info,
-					      system_chunk))
+	if (!btrfs_calc_reclaim_metadata_size(fs_info, space_info))
 		return 0;
 
 	return (used >= thresh && !btrfs_fs_closing(fs_info) &&
@@ -765,8 +761,7 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
 	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
 
 	spin_lock(&space_info->lock);
-	to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info, space_info,
-						      false);
+	to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info, space_info);
 	if (!to_reclaim) {
 		space_info->flush = 0;
 		spin_unlock(&space_info->lock);
@@ -785,8 +780,7 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
 			return;
 		}
 		to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info,
-							      space_info,
-							      false);
+							      space_info);
 		if (last_tickets_id == space_info->tickets_id) {
 			flush_state++;
 		} else {
@@ -858,8 +852,7 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 	int flush_state;
 
 	spin_lock(&space_info->lock);
-	to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info, space_info,
-						      false);
+	to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info, space_info);
 	if (!to_reclaim) {
 		spin_unlock(&space_info->lock);
 		return;
@@ -990,8 +983,7 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 				    struct btrfs_space_info *space_info,
 				    u64 orig_bytes,
-				    enum btrfs_reserve_flush_enum flush,
-				    bool system_chunk)
+				    enum btrfs_reserve_flush_enum flush)
 {
 	struct reserve_ticket ticket;
 	u64 used;
@@ -1013,8 +1005,7 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 	 */
 	if (!pending_tickets &&
 	    ((used + orig_bytes <= space_info->total_bytes) ||
-	     can_overcommit(fs_info, space_info, orig_bytes, flush,
-			   system_chunk))) {
+	     can_overcommit(fs_info, space_info, orig_bytes, flush))) {
 		btrfs_space_info_update_bytes_may_use(fs_info, space_info,
 						      orig_bytes);
 		ret = 0;
@@ -1054,8 +1045,7 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 		 * the async reclaim as we will panic.
 		 */
 		if (!test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags) &&
-		    need_do_async_reclaim(fs_info, space_info,
-					  used, system_chunk) &&
+		    need_do_async_reclaim(fs_info, space_info, used) &&
 		    !work_busy(&fs_info->async_reclaim_work)) {
 			trace_btrfs_trigger_flush(fs_info, space_info->flags,
 						  orig_bytes, flush, "preempt");
@@ -1092,10 +1082,9 @@ int btrfs_reserve_metadata_bytes(struct btrfs_root *root,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
 	int ret;
-	bool system_chunk = (root == fs_info->chunk_root);
 
 	ret = __reserve_metadata_bytes(fs_info, block_rsv->space_info,
-				       orig_bytes, flush, system_chunk);
+				       orig_bytes, flush);
 	if (ret == -ENOSPC &&
 	    unlikely(root->orphan_cleanup_state == ORPHAN_CLEANUP_STARTED)) {
 		if (block_rsv != global_rsv &&
-- 
2.24.1

