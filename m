Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2AEC11EF2C
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2019 01:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfLNAXA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Dec 2019 19:23:00 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35530 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfLNAW7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Dec 2019 19:22:59 -0500
Received: by mail-pg1-f194.google.com with SMTP id l24so286493pgk.2
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2019 16:22:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=z+63g65+RKcVcR5uWAB1cmMaOkxiHCfRgiQVI4OyzLs=;
        b=Ww6obF+Sf8PvyrsRh1Mep9Am8HNdMEZ+nGpzbGmj/asqEQdti6AyANhCbYaMpupJgW
         MUYcVn1/l8DYn4O9Sa9GZUylXMZtOmb3XJ7fBKdG3jcLjQUoLljva+Swm8VjADtYC2/Y
         9YxYplakyp5gxv0FGap1nC14IbuQUBSPJTZ8QyOOpKu7eb7RfZHFJBOd/V8IwfWB++yZ
         drTGF+8exXNaLyPXi3ucU8HZH0yD7G388fSQEz87tZBb5kKlWCfe7Z5IMb6SSCV6y4Et
         JaGIsBJ/dJX4BsGh+1Ku6skL72xKuMr2VgTiwUz7kI9uLK2KDlac533fENDm+fu2RB2J
         wAhg==
X-Gm-Message-State: APjAAAXm+dWRf2ZwdQwIKa58MkHa51mod9ZnaQ9EgIxgu2DG4Sxe6rlh
        niWNgp5KukkzF4SI/w6d5+Y=
X-Google-Smtp-Source: APXvYqyFLnMaEIV+qg1IoO9IJTEwuCzCbuImR7Gf/zoLvj4GFIOeGXhTbLz4Bzit0nHSVdunixacpA==
X-Received: by 2002:a63:f901:: with SMTP id h1mr2547443pgi.445.1576282978865;
        Fri, 13 Dec 2019 16:22:58 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.138])
        by smtp.gmail.com with ESMTPSA id m12sm11911430pgr.87.2019.12.13.16.22.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Dec 2019 16:22:57 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 18/22] btrfs: only keep track of data extents for async discard
Date:   Fri, 13 Dec 2019 16:22:27 -0800
Message-Id: <7dbf1733c917f37122c630d392622d70021cdbdb.1576195673.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1576195673.git.dennis@kernel.org>
References: <cover.1576195673.git.dennis@kernel.org>
In-Reply-To: <cover.1576195673.git.dennis@kernel.org>
References: <cover.1576195673.git.dennis@kernel.org>
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
 fs/btrfs/discard.c     | 11 +++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

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
index 884dffd28596..55ad357e65f3 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -53,6 +53,9 @@ static void __add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 static void add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 				struct btrfs_block_group *block_group)
 {
+	if (!btrfs_is_block_group_data(block_group))
+		return;
+
 	spin_lock(&discard_ctl->lock);
 
 	__add_to_discard_list(discard_ctl, block_group);
@@ -168,7 +171,10 @@ static struct btrfs_block_group *peek_discard_list(
 	if (block_group && now > block_group->discard_eligible_time) {
 		if (block_group->discard_index == BTRFS_DISCARD_INDEX_UNUSED &&
 		    block_group->used != 0) {
-			__add_to_discard_list(discard_ctl, block_group);
+			if (btrfs_is_block_group_data(block_group))
+				__add_to_discard_list(discard_ctl, block_group);
+			else
+				list_del_init(&block_group->discard_list);
 			goto again;
 		}
 		if (block_group->discard_state == BTRFS_DISCARD_RESET_CURSOR) {
@@ -508,7 +514,8 @@ void btrfs_discard_update_discardable(struct btrfs_block_group *block_group,
 	s64 bytes_delta;
 
 	if (!block_group ||
-	    !btrfs_test_opt(block_group->fs_info, DISCARD_ASYNC))
+	    !btrfs_test_opt(block_group->fs_info, DISCARD_ASYNC) ||
+	    !btrfs_is_block_group_data(block_group))
 		return;
 
 	discard_ctl = &block_group->fs_info->discard_ctl;
-- 
2.17.1

