Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55463104624
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2019 22:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfKTVvu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Nov 2019 16:51:50 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41664 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfKTVvt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Nov 2019 16:51:49 -0500
Received: by mail-qt1-f194.google.com with SMTP id o3so1252209qtj.8
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2019 13:51:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=q0yKfvu8hBqvrVb4HPSXF9EzaWCJORHs5Pk7tYqqZ3s=;
        b=Vicmlxw5Q9hPHfN1Ly1DYVMTRQg5AlrAonc2xEsBN8bnq609smSwZTOKymtVC5pzlQ
         +79zxPdGgkVv6Zn8+sZpmV4IW6BUsZHvKdVOghQyfPK1F+yYQ8l2ifZcenb0GlTrgE4a
         LpSSGCTpLPxTt0hCXcAulKo3N+KCKEbuV8ozw5+J2nBXVnuH4rc3cwedBsfdteETCf1V
         SBjaxnRcuT5anNbrItrWeokihPRaaPbkuNzcEcfMXX3+bx0vnPmfgBEJPer3NHKMo7qk
         XOVU22VKR/LMC+ky3DLo+7sTZuizLbEU1+57cujKNiP8mQTAIvwvEegiojSggapzufw0
         hJRg==
X-Gm-Message-State: APjAAAXdloAsvBcT9obvKIVvRAg1hQFtgNGYdOiOdMRH6CpD78ZIU+++
        JJ+oxK1K3d7e0mBP+yEytOo=
X-Google-Smtp-Source: APXvYqxgJP13Q1/+0dEf8xJW5uDpJ1jrJTd0uucoSl48OneAM6URc03oB7YHZ91j8HNSrLCqrSO0xg==
X-Received: by 2002:ac8:7190:: with SMTP id w16mr1728168qto.308.1574286708659;
        Wed, 20 Nov 2019 13:51:48 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id t16sm303820qkm.73.2019.11.20.13.51.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Nov 2019 13:51:48 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 18/22] btrfs: only keep track of data extents for async discard
Date:   Wed, 20 Nov 2019 16:51:17 -0500
Message-Id: <9efdcd731316d95e899c515454bcfd2a61c718bc.1574282259.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1574282259.git.dennis@kernel.org>
References: <cover.1574282259.git.dennis@kernel.org>
In-Reply-To: <cover.1574282259.git.dennis@kernel.org>
References: <cover.1574282259.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As mentioned earlier, discarding data can be done either by issuing an
explicit discard or implicitly by reusing the LBA. Metadata chunks see
much more frequent reuse due to well it being metadata. So instead of
explicitly discarding metadata blocks, just leave them be and let the
latter implicit discarding be done for them.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.h |  6 ++++++
 fs/btrfs/discard.c     | 12 ++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 601e1d217e22..ee8441439a56 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -182,6 +182,12 @@ static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
 	return (block_group->start + block_group->length);
 }
 
+static inline bool btrfs_is_block_group_data(
+					struct btrfs_block_group *block_group)
+{
+	return (block_group->flags & BTRFS_BLOCK_GROUP_DATA);
+}
+
 #ifdef CONFIG_BTRFS_DEBUG
 static inline int btrfs_should_fragment_free_space(
 		struct btrfs_block_group *block_group)
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 05e99adb149b..2529cf88b02c 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -49,6 +49,9 @@ static void __btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 			       struct btrfs_block_group *block_group)
 {
+	if (!btrfs_is_block_group_data(block_group))
+		return;
+
 	spin_lock(&discard_ctl->lock);
 
 	__btrfs_add_to_discard_list(discard_ctl, block_group);
@@ -159,7 +162,11 @@ static struct btrfs_block_group *peek_discard_list(
 	if (block_group && now > block_group->discard_eligible_time) {
 		if (block_group->discard_index == BTRFS_DISCARD_INDEX_UNUSED &&
 		    block_group->used != 0) {
-			__btrfs_add_to_discard_list(discard_ctl, block_group);
+			if (btrfs_is_block_group_data(block_group))
+				__btrfs_add_to_discard_list(discard_ctl,
+							    block_group);
+			else
+				list_del_init(&block_group->discard_list);
 			goto again;
 		}
 		if (block_group->discard_state == BTRFS_DISCARD_RESET_CURSOR) {
@@ -501,7 +508,8 @@ void btrfs_discard_update_discardable(struct btrfs_block_group *block_group,
 	s64 bytes_delta;
 
 	if (!block_group ||
-	    !btrfs_test_opt(block_group->fs_info, DISCARD_ASYNC))
+	    !btrfs_test_opt(block_group->fs_info, DISCARD_ASYNC) ||
+	    !btrfs_is_block_group_data(block_group))
 		return;
 
 	discard_ctl = &block_group->fs_info->discard_ctl;
-- 
2.17.1

