Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB3A312EB52
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 22:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgABV07 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 16:26:59 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40915 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgABV06 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 16:26:58 -0500
Received: by mail-qk1-f194.google.com with SMTP id c17so32379475qkg.7
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 13:26:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=BuzfP5I9/BHaBf6FyHQQOIfKEOpRMWsA5XU5wykKT2o=;
        b=CdOid+UBVvRGXRbF7qCzcVOF2m61Y8IiZsjsLVZ66tUHkFWOtXKXnx0l7xzRBVtzvX
         hS/zgPvMPKIsCac3Khfu/Vbrx/QKLJX2bJGPqx7+uWdWi00+k4/4GkKRRFRaXnI9Nat+
         fUH3hsttp09Q/yqSKBammQVB6r+jbEquKZjr2oz5VeYr0M7951F7b53eKztJArPjjpli
         57bgEoJ9fCYRFmwvwa3DJZ/YZv99VSUOxW+/H9uhSdFgHYOnvy+VsaW1ttX3Gh27xyUT
         ofxSUREb8VrQqvpm0wtjAHJ8Cv4iC7rL6w2HaeZ/j6h/TkfTEuITdPV/hEEKscxo2no4
         re9g==
X-Gm-Message-State: APjAAAVrRD/NfGkmEJQ4TigQEgvsyNyYn/ycAe2GqhfyzQgYCTN0LNhf
        dgknY+BznA3MV4ifjtrQlKE=
X-Google-Smtp-Source: APXvYqxb4MqD2deYjYHn9wwqXYJEA7Ah5f2jj42wRGUKZgo1thInSXK1jt4a/hnwldtPqagZOGtgPw==
X-Received: by 2002:a37:6313:: with SMTP id x19mr70606916qkb.231.1578000417794;
        Thu, 02 Jan 2020 13:26:57 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id f42sm17553933qta.0.2020.01.02.13.26.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jan 2020 13:26:56 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 06/12] btrfs: only keep track of data extents for async discard
Date:   Thu,  2 Jan 2020 16:26:40 -0500
Message-Id: <81a50b61fa32f4b080702f196b31c8c4defd9840.1577999991.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1577999991.git.dennis@kernel.org>
References: <cover.1577999991.git.dennis@kernel.org>
In-Reply-To: <cover.1577999991.git.dennis@kernel.org>
References: <cover.1577999991.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As mentioned earlier, discarding data can be done either by issuing an
explicit discard or implicitly by reusing the LBA. Metadata block_groups
see much more frequent reuse due to well it being metadata. So instead
of explicitly discarding metadata block_groups, just leave them be and
let the latter implicit discarding be done for them. For mixed
block_groups, block_groups which contain both metadata and data, we let
them be as higher fragmentation is expected.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.h |  7 +++++++
 fs/btrfs/discard.c     | 16 ++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index a8d2edcd8760..4a088e690432 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -182,6 +182,13 @@ static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
 	return (block_group->start + block_group->length);
 }
 
+static inline bool btrfs_is_block_group_data_only(
+					struct btrfs_block_group *block_group)
+{
+	return ((block_group->flags & BTRFS_BLOCK_GROUP_DATA) &&
+		!(block_group->flags & BTRFS_BLOCK_GROUP_METADATA));
+}
+
 #ifdef CONFIG_BTRFS_DEBUG
 static inline int btrfs_should_fragment_free_space(
 		struct btrfs_block_group *block_group)
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index de436c0051ce..7dbbf762ee8d 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -54,6 +54,13 @@ static void __add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 static void add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 				struct btrfs_block_group *block_group)
 {
+	/*
+	 * Async discard only operates on block_groups that are explicitly for
+	 * data.  Mixed block_groups are not supported.
+	 */
+	if (!btrfs_is_block_group_data_only(block_group))
+		return;
+
 	spin_lock(&discard_ctl->lock);
 	__add_to_discard_list(discard_ctl, block_group);
 	spin_unlock(&discard_ctl->lock);
@@ -166,7 +173,10 @@ static struct btrfs_block_group *peek_discard_list(
 	if (block_group && now > block_group->discard_eligible_time) {
 		if (block_group->discard_index == BTRFS_DISCARD_INDEX_UNUSED &&
 		    block_group->used != 0) {
-			__add_to_discard_list(discard_ctl, block_group);
+			if (btrfs_is_block_group_data_only(block_group))
+				__add_to_discard_list(discard_ctl, block_group);
+			else
+				list_del_init(&block_group->discard_list);
 			goto again;
 		}
 		if (block_group->discard_state == BTRFS_DISCARD_RESET_CURSOR) {
@@ -504,7 +514,9 @@ void btrfs_discard_update_discardable(struct btrfs_block_group *block_group,
 	s32 extents_delta;
 	s64 bytes_delta;
 
-	if (!block_group || !btrfs_test_opt(block_group->fs_info, DISCARD_ASYNC))
+	if (!block_group ||
+	    !btrfs_test_opt(block_group->fs_info, DISCARD_ASYNC) ||
+	    !btrfs_is_block_group_data_only(block_group))
 		return;
 
 	discard_ctl = &block_group->fs_info->discard_ctl;
-- 
2.17.1

