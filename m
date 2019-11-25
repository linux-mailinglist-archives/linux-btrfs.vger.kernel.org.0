Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 415BB109471
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 20:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfKYTrb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 14:47:31 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39017 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbfKYTra (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 14:47:30 -0500
Received: by mail-qt1-f194.google.com with SMTP id g1so9222945qtj.6
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 11:47:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=kWToEm0JE7KVFYUkmI6pVchwKh3LLVs2L2Cuev+zDCg=;
        b=HCuMj2cCDcKc73V0IASoSTtn0hAqcvaempgQW/6XC+WZzN3P+QHSi7y2hmYEY8vGJk
         Xtc0t0A8iHULpeSU2Uz8gNs1hm+n9KBucIH/4fCm+MJVzVdxhGGeNzT0cjL8OBXQvBE+
         Aq5fwi2yi/7VQCnlslmFnkc2fv3EHhrajdNZ7qtFMyOOEj2mavEfBaZg14LL7FjJCvLO
         nvuA/eSZXh+Mrv7gv/OCZXel/jgzJiIvIz/m17AuBlTuHV0191o+aymiYExJOZlkQmP5
         BDXWe5npXXr/ArEPFXhrbsDH/C5swKaEtV7PbVdE3dzRWUapamBR3ED2AdnJET1lehoS
         872A==
X-Gm-Message-State: APjAAAVsukKGG4Oe3D4YV7S5kqdSvj1eS2aiyVhSD0RIh/Fq+TcnnA6j
        AiHLI441jdAe2xrLpnmpxo0=
X-Google-Smtp-Source: APXvYqy8Xuwx5VkG5pHX0/yuySW7YLAAle9P3le0bYkvhkWEkxDyX05FrSwUiBTSBl6/uuxlnviU/A==
X-Received: by 2002:aed:2103:: with SMTP id 3mr18817410qtc.132.1574711247636;
        Mon, 25 Nov 2019 11:47:27 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id o13sm4481033qto.96.2019.11.25.11.47.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Nov 2019 11:47:27 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 18/22] btrfs: only keep track of data extents for async discard
Date:   Mon, 25 Nov 2019 14:46:58 -0500
Message-Id: <ea5bb4494425c9339fbdd657454500acc3f56774.1574709825.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1574709825.git.dennis@kernel.org>
References: <cover.1574709825.git.dennis@kernel.org>
In-Reply-To: <cover.1574709825.git.dennis@kernel.org>
References: <cover.1574709825.git.dennis@kernel.org>
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
index 004d83b0a215..c8e923b3f2b9 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -50,6 +50,9 @@ static void __btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 			       struct btrfs_block_group *block_group)
 {
+	if (!btrfs_is_block_group_data(block_group))
+		return;
+
 	spin_lock(&discard_ctl->lock);
 
 	__btrfs_add_to_discard_list(discard_ctl, block_group);
@@ -160,7 +163,11 @@ static struct btrfs_block_group *peek_discard_list(
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
@@ -502,7 +509,8 @@ void btrfs_discard_update_discardable(struct btrfs_block_group *block_group,
 	s64 bytes_delta;
 
 	if (!block_group ||
-	    !btrfs_test_opt(block_group->fs_info, DISCARD_ASYNC))
+	    !btrfs_test_opt(block_group->fs_info, DISCARD_ASYNC) ||
+	    !btrfs_is_block_group_data(block_group))
 		return;
 
 	discard_ctl = &block_group->fs_info->discard_ctl;
-- 
2.17.1

