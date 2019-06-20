Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDC7E4DA5B
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2019 21:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfFTTih (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jun 2019 15:38:37 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34379 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfFTTih (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jun 2019 15:38:37 -0400
Received: by mail-qk1-f196.google.com with SMTP id t8so2776416qkt.1
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2019 12:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=+A9I7TKCuoLhXXsjfyDwkv8x6ZHT83xYwe7kFlmZzm0=;
        b=uCf6CxsvRIeMBXFh4VIu8JceCMIl2eWgyACaFZZe8ujY0hyfJLsenP9jhlLp9Sk6aX
         JzoXS8eKabB09vBGs01pnIBEmHfBd2lRx6LA0QwIjcNd0YGfE9c9UA3Cq2oPfCY5BrlX
         h2J9k2mALAE26RNcmaFlBxKTbYoRgCneRY3PY5nYV/Vvz8M4OU/m60Tqh8UDno81bYeh
         JWcvpMLyJEvM4tXFKqKEG9lvRrUnTH4NJybJrACrhfejsp8OvnFDJ/cBuYuCdKvjM2lK
         SgEVnFL7HTNVkWgKJVqcXstAUhni2F/EARlnr/ki9ogy6SgWy+1M2547YlpXjt+01qeP
         v6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=+A9I7TKCuoLhXXsjfyDwkv8x6ZHT83xYwe7kFlmZzm0=;
        b=XJoK/r6TNj/92wwCG4XpwBLvkbbvta3BYWao/cx6q2AKo2flkJCjHNUgl4gHUYAUep
         uYkYJyC2Sd67lT66hjofSgG31c7Dv78xUpdOMMbj1O9QG3PTRPr5GKZK6ZNthPsOvjx0
         f/ksF29OjzKDmFUghMj9PuFBbsGFVeoTZ6gJTgkAjFPSXYNuTHzy7qrg4goJTqiqGrUG
         ceG9Lif66h2Dx3C4cUSBl6mDdwjcnO8Zo1G08xRmKaoW/xmRC/B3xG/ZaWcyRIG4bzUV
         GNdJyvFWHeH/CYTXO7tKavJUz8oEQEqCDxpffDlT21GttJUbnXADSO4f1o5WgbTgdbcG
         OqiA==
X-Gm-Message-State: APjAAAVj57rsKj+oDt9OdU+OyJ56qf9GXNchq2b+IAwQqESZMeCMA8EK
        jegquNw0rn+IurEC20bTh4ioHAW8N+TPLA==
X-Google-Smtp-Source: APXvYqy7qj+aBU2XkN9/ijnI/sVtI9YJffgRLaJOUdoKrXutWSAruCPCU4pMtp1ZpjiERtXybFONiA==
X-Received: by 2002:a37:a5d5:: with SMTP id o204mr32472085qke.155.1561059515726;
        Thu, 20 Jun 2019 12:38:35 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z18sm354421qka.12.2019.06.20.12.38.34
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 12:38:35 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 16/25] btrfs: temporarily export btrfs_get_restripe_target
Date:   Thu, 20 Jun 2019 15:37:58 -0400
Message-Id: <20190620193807.29311-17-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190620193807.29311-1-josef@toxicpanda.com>
References: <20190620193807.29311-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This gets used by a few different logical chunks of the block group
code, export it while we move things around.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.h | 2 ++
 fs/btrfs/extent-tree.c | 8 ++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index f38e726c8740..4ea744e29c1c 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -202,4 +202,6 @@ btrfs_block_group_cache_done(struct btrfs_block_group_cache *cache)
 
 int __btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache,
 			       int force);
+u64 btrfs_get_restripe_target(struct btrfs_fs_info *fs_info, u64 flags);
+
 #endif /* BTRFS_BLOCK_GROUP_H */
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index acb25ea7dbd0..f6e2cbe383dd 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3048,7 +3048,7 @@ int btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr)
  *
  * should be called with balance_lock held
  */
-static u64 get_restripe_target(struct btrfs_fs_info *fs_info, u64 flags)
+u64 btrfs_get_restripe_target(struct btrfs_fs_info *fs_info, u64 flags)
 {
 	struct btrfs_balance_control *bctl = fs_info->balance_ctl;
 	u64 target = 0;
@@ -3089,7 +3089,7 @@ static u64 btrfs_reduce_alloc_profile(struct btrfs_fs_info *fs_info, u64 flags)
 	 * try to reduce to the target profile
 	 */
 	spin_lock(&fs_info->balance_lock);
-	target = get_restripe_target(fs_info, flags);
+	target = btrfs_get_restripe_target(fs_info, flags);
 	if (target) {
 		/* pick target profile only if it's already available */
 		if ((flags & target) & BTRFS_EXTENDED_PROFILE_MASK) {
@@ -6533,7 +6533,7 @@ static u64 update_block_group_flags(struct btrfs_fs_info *fs_info, u64 flags)
 	 * if restripe for this chunk_type is on pick target profile and
 	 * return, otherwise do the usual balance
 	 */
-	stripped = get_restripe_target(fs_info, flags);
+	stripped = btrfs_get_restripe_target(fs_info, flags);
 	if (stripped)
 		return extended_to_chunk(stripped);
 
@@ -6839,7 +6839,7 @@ int btrfs_can_relocate(struct btrfs_fs_info *fs_info, u64 bytenr)
 	 *      3: raid0
 	 *      4: single
 	 */
-	target = get_restripe_target(fs_info, block_group->flags);
+	target = btrfs_get_restripe_target(fs_info, block_group->flags);
 	if (target) {
 		index = btrfs_bg_flags_to_raid_index(extended_to_chunk(target));
 	} else {
-- 
2.14.3

