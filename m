Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9D44A87C1
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Feb 2022 16:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351890AbiBCPgy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 10:36:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35730 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241610AbiBCPgw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Feb 2022 10:36:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA48B60C16
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 15:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FEFC340E8
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 15:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643902612;
        bh=LciAtrFaqHLyqNnD0tyauq3G7Bvookjwa7F+QM3f+q8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=WU9k/cJUJW3t9j31YA2DeoZI7nMUsbi7fItjPMWMiD6S8C1DJWhBT9OIKHdPjmyjx
         5itosuAZn/oi95Qj9drUoicRqqFVRfK1uknkJPyid2+aHEINi34NtKI+nyNc8s0QuF
         C+YVTQf+7fcGeGjDw97rKCDy3GsNlbB9VjW85cyluz0PvDr/5cMol5cVT5XCFAVCiX
         +PS2ydw4CiVn9OM0VM31+aAtSr1UB63gisyax6sBueh2wasCT4VBojfclGomYS4vq4
         9r9vE/c1HSkFelel5bx6paMG20p6P0HheDQTwp/E4pJa0QIWwtZqR0XN6rs7VEVr++
         LzfAyStdn0cXw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: assert we have a write lock when removing and replacing extent maps
Date:   Thu,  3 Feb 2022 15:36:45 +0000
Message-Id: <ed5e1fbf066518b687909f39c23ba8bb193b54a4.1643902108.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1643902108.git.fdmanana@suse.com>
References: <cover.1643902108.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Removing or replacing an extent map requires holding a write lock on the
extent map's tree. We currently do that everywhere, except in one of the
self tests, where it's harmless since there's no concurrency.

In order to catch possible races in the future, assert that we are holding
a write lock on the extent map tree before removing or replacing an extent
map in the tree, and update the self test to obtain a write lock before
removing extent maps.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c             | 4 ++++
 fs/btrfs/tests/extent-map-tests.c | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 5a36add21305..ba43303cb081 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -490,6 +490,8 @@ struct extent_map *search_extent_mapping(struct extent_map_tree *tree,
  */
 void remove_extent_mapping(struct extent_map_tree *tree, struct extent_map *em)
 {
+	lockdep_assert_held_write(&tree->lock);
+
 	WARN_ON(test_bit(EXTENT_FLAG_PINNED, &em->flags));
 	rb_erase_cached(&em->rb_node, &tree->map);
 	if (!test_bit(EXTENT_FLAG_LOGGING, &em->flags))
@@ -504,6 +506,8 @@ void replace_extent_mapping(struct extent_map_tree *tree,
 			    struct extent_map *new,
 			    int modified)
 {
+	lockdep_assert_held_write(&tree->lock);
+
 	WARN_ON(test_bit(EXTENT_FLAG_PINNED, &cur->flags));
 	ASSERT(extent_map_in_tree(cur));
 	if (!test_bit(EXTENT_FLAG_LOGGING, &cur->flags))
diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index 319fed82d741..c5b3a631bf4f 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -15,6 +15,7 @@ static void free_extent_map_tree(struct extent_map_tree *em_tree)
 	struct extent_map *em;
 	struct rb_node *node;
 
+	write_lock(&em_tree->lock);
 	while (!RB_EMPTY_ROOT(&em_tree->map.rb_root)) {
 		node = rb_first_cached(&em_tree->map);
 		em = rb_entry(node, struct extent_map, rb_node);
@@ -32,6 +33,7 @@ static void free_extent_map_tree(struct extent_map_tree *em_tree)
 #endif
 		free_extent_map(em);
 	}
+	write_unlock(&em_tree->lock);
 }
 
 /*
-- 
2.33.0

