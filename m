Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D6A5F9CAA
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Oct 2022 12:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiJJKWy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Oct 2022 06:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiJJKWl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Oct 2022 06:22:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE8D52E76
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 03:22:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B7E6B80E71
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B42C433D7
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665397350;
        bh=uAlLAlKffoQVDYeuoy8zlNBzKih62TNzbLGG4AD3PO4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=q3WSnPcvv7bseP3hQ/CpE8x+qNF57FR8zpQeO141fzuR4MuMkBTfxvv9nn/+OXcG/
         JMY5ZPPyIhN2lzu1+Fi9kIApSBwfBEmKZyOIbog5vre1Dh8MsGRlIT3UXxEdJaJ1Ow
         QQIPgCaDxTS6o3WIH1WBh+n9Ah+X7rrObT1v4riMnLO63VIOZD9539S8dt6mrGfUwH
         CsOIG/cqOW9oMdjX7Liqt2aNzFG4eGkVWmIXug3XPrqmei2qGSAf9KAcNhn9XxRIHL
         3mIX4vEOAHmpd7YrAAIUFNtjJlSHIWI2pbqeWdhgNd7mfP6HhwGc0rPDunD5bMuxYc
         1HLMlbac0Jpug==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/18] btrfs: remove checks for a root with id 0 during backref walking
Date:   Mon, 10 Oct 2022 11:22:10 +0100
Message-Id: <14b6aa002d9f3bbf4247818a0c5136a70c1102e1.1665396437.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1665396437.git.fdmanana@suse.com>
References: <cover.1665396437.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When doing backref walking to determine if an extent is shared, we are
testing the root_objectid of the given share_check struct is 0, but that
is an impossible case, since btrfs_is_data_extent_shared() always
initializes the root_objectid field with the id of the given root, and
no root can have an objectid of 0. So remove those checks.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index ac07a6587719..c112c99af1a1 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -704,8 +704,7 @@ static int resolve_indirect_refs(struct btrfs_fs_info *fs_info,
 			continue;
 		}
 
-		if (sc && sc->root_objectid &&
-		    ref->root_id != sc->root_objectid) {
+		if (sc && ref->root_id != sc->root_objectid) {
 			free_pref(ref);
 			ret = BACKREF_FOUND_SHARED;
 			goto out;
@@ -1317,8 +1316,7 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 		 * and would retain their original ref->count < 0.
 		 */
 		if (roots && ref->count && ref->root_id && ref->parent == 0) {
-			if (sc && sc->root_objectid &&
-			    ref->root_id != sc->root_objectid) {
+			if (sc && ref->root_id != sc->root_objectid) {
 				ret = BACKREF_FOUND_SHARED;
 				goto out;
 			}
-- 
2.35.1

