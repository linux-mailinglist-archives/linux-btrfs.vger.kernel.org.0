Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6898A40D770
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Sep 2021 12:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbhIPKdj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Sep 2021 06:33:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235590AbhIPKdj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Sep 2021 06:33:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B3986120E
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Sep 2021 10:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631788339;
        bh=CqpYUxXgW5n14goXh8VH4P6d2Wi6wLi4ri7i/GJiEv0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nV1dbC3u4hz+iuhVCpTHOWioagy4G5czYr6aqsu08gWBy9RZOb+H2AEzYvt2m8kr6
         LYCoXOrIJvu/UfLL5l7y5xCIxwaMXyo4uMu1RT1n5/OcXX4Ya38CvS5z/cmcGkt/UF
         xFyj3923738CTLKyCXWoI6NJSC7+mahxasI14u+xFm46tcsjsN53O4Mg9LmfFS64MI
         t7VqsTMsgXHv4jHa/bQO4F/SyMpEfxopF3pk+WkVZukRwxFQ60ZJ/9HY0LG1t6CBOP
         YTJD3fWi1BwbepJGj66SqR2UMJEeYuYDAD9e8QuyKVwPdoIEYP1cEMNRbXpHqQMjfN
         yCpKOdusA5G9A==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/5] btrfs: remove redundant log root assignment from log_dir_items()
Date:   Thu, 16 Sep 2021 11:32:11 +0100
Message-Id: <bdd87df835200aa080d7567c7780d65de8fd0392.1631787796.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1631787796.git.fdmanana@suse.com>
References: <cover.1631787796.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At log_dir_items() we are assigning the exact same value to the local
variable 'log', once when it's declared and once again shortly after.
Remove the later assignment as it's pointless.

This patch is part of a patchset comprised of the following 5 patches:

  btrfs: remove root argument from btrfs_log_inode() and its callees
  btrfs: remove redundant log root assignment from log_dir_items()
  btrfs: factor out the copying loop of dir items from log_dir_items()
  btrfs: insert items in batches when logging a directory when possible
  btrfs: keep track of the last logged keys when logging a directory

This is patch 2/5. The change log of the last patch (5/5) has performance
results.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index be9fb98465f5..64db4bd8e965 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3639,8 +3639,6 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 	u64 last_offset = (u64)-1;
 	u64 ino = btrfs_ino(inode);
 
-	log = root->log_root;
-
 	min_key.objectid = ino;
 	min_key.type = key_type;
 	min_key.offset = min_offset;
-- 
2.33.0

