Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE0B5F3236
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Oct 2022 16:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiJCO5i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Oct 2022 10:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJCO5h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Oct 2022 10:57:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B182A94C
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Oct 2022 07:57:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 411E2B80766
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Oct 2022 14:57:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F26EC433D6
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Oct 2022 14:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664809053;
        bh=S0zfw0/6HhkwLHdBDBQ+JMwqLkKwIul9sDivUSyktLA=;
        h=From:To:Subject:Date:From;
        b=Tk7sngY1vQrxsKMv3ZeFlh8puVWZ02PSLFKvRu1x2CWkEcCP3W0SBUusGcYzvLE3K
         jgSMDrMwf6o4WrhZ/0rm0naaloTlQn2IRekNPhG4QtdpoIjsAcgUyuxS9WnpuTaVxI
         yB6RdjocxjkEycsqNOEzWjRgmI699LTnf27bQZx7xQAU95sa8SpOgNM3WlG7HkLwc7
         h7qlHlWWW554oNbtg+AYrM1NIZxgd1Y60gZvp4RlCYBez+uakqxU964nFpxaK1ZRql
         zdnQJeBObu2sSN5vKSFpGdYRv0xJ42FfK6N3udgIiLyGS+aShpiJwMjmaOMCYUEqjY
         xk1E+KIbGMVQw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: add missing path cache update during fiemap
Date:   Mon,  3 Oct 2022 15:57:30 +0100
Message-Id: <aa8da9743ec75d4438f5de49051834337133da10.1664808830.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
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

When looking the stored result for a cached path node, if the stored
result is valid and has a value of true, we must update all the nodes for
all levels below it with a result of true as well. This is necessary when
moving from one leaf in the fs tree to the next one, as well as when
moving from a node at any level to the next node at the same level.

Currently this logic is missing as it was somehow forgotten by a recent
patch with the subject: "btrfs: speedup checking for extent sharedness
during fiemap".

This adds the missing logic, which is the counter part to what we do
when adding a shared node to the cache at store_backref_shared_cache().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index dce3a16996b9..3c0c1f626c75 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1557,6 +1557,19 @@ static bool lookup_backref_shared_cache(struct btrfs_backref_shared_cache *cache
 		return false;
 
 	*is_shared = entry->is_shared;
+	/*
+	 * If the node at this level is shared, than all nodes below are also
+	 * shared. Currently some of the nodes below may be marked as not shared
+	 * because we have just switched from one leaf to another, and switched
+	 * also other nodes above the leaf and below the current level, so mark
+	 * them as shared.
+	 */
+	if (*is_shared) {
+		for (int i = 0; i < level; i++) {
+			cache->entries[i].is_shared = true;
+			cache->entries[i].gen = entry->gen;
+		}
+	}
 
 	return true;
 }
-- 
2.35.1

