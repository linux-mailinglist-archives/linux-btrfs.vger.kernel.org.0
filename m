Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8914D10A207
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 17:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfKZQ0D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Nov 2019 11:26:03 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:45553 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbfKZQ0D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Nov 2019 11:26:03 -0500
Received: by mail-qv1-f66.google.com with SMTP id c2so352504qvp.12
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2019 08:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vpU8W2zZgvc44w00WVQ+sAVsphmTcbpuEoyH/Ctvvy4=;
        b=gj3H7C7WAL691aczrmC26Sz7+jVr7dGCUGVWM1injyH0BJCZylV2erMZRKtopIGDbE
         ulf3M1ff0h1++c0AKGuvE5xq9f1+7U1hKG5ySYdM5Hu5DcZKTeStPyXK8uSEHumhz/BH
         iFTpEjpxxph6aWa1ENOsUPCIbjciZRLvB0Ba3eZxraSgazZJRIwSzo4Hq+YzpCffPnMh
         Z9RFE2fDcBxGQNGcmAMt0cmVmOjVnRei9LlW0j17VnXdqNuUQaxfLIXdjEzakOv3uj8v
         RlNsK0bBcMrc1NtaUVlcb4O+NxhOnxKhBYGk3aHy6zKHkbV00JkgeVW7WzDqSK/ihXyU
         WnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vpU8W2zZgvc44w00WVQ+sAVsphmTcbpuEoyH/Ctvvy4=;
        b=fKE+M7zksFLrPOlYXQ7TPTggE7MIDcVkzoDSf2m8HpSK/EZCFnIqEHp+oHasuxI+Bg
         j9A4EUuWpY17YZ160DbyK+4H+ZuskRVUSAlIkCvXrDs6EXutyGx69IsKNOfZZdYcgot6
         4pZcT5kCdrrbBm3Mbqk+ZN6/D9V4aD3yNNbR5nEBaIfMPTvxY5ZVIj1Nf7xsVH+JwlWw
         Wjhdo5RNVVBQqjCXNXPJgp1b1y+ncN7+LVlAEMXg0GfCEqueshnH8KiFDcOUwA4AYUs4
         4/WNk+hcS+/dFZdlzbHjBeAO1iQ1opRC/nFTVfuSwYeYAji5AZ5Xl8J4FQQybEIsLy4D
         krlw==
X-Gm-Message-State: APjAAAWCVK1KQsfxTSivovyNle+WX6VBltIuF3UKm84pjhMJlayHBHx+
        Lvvg+pQ/cvLMJ9kP7Ntx/s07qQK/XSjNreJm
X-Google-Smtp-Source: APXvYqwD2djY6u6vZtUUjA4Zq4jCEY2+aczBRgM0OpMwYahdgr2VGncozSaN/oTnkeGHnihOCGOSxg==
X-Received: by 2002:a0c:e88f:: with SMTP id b15mr34235153qvo.21.1574785561807;
        Tue, 26 Nov 2019 08:26:01 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l130sm5126799qke.33.2019.11.26.08.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 08:26:01 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com, wqu@suse.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 1/4] btrfs: don't pass system_chunk into can_overcommit
Date:   Tue, 26 Nov 2019 11:25:53 -0500
Message-Id: <20191126162556.150483-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191126162556.150483-1-josef@toxicpanda.com>
References: <20191126162556.150483-1-josef@toxicpanda.com>
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
2.23.0

