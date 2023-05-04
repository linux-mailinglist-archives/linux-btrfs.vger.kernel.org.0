Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCE36F6978
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 13:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjEDLEs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 07:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjEDLEi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 07:04:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567D326A4
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 04:04:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6B3763342
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 11:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91F6C433EF
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 11:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683198274;
        bh=Gw95DJFsrVxwyHMU0ULENXVu9dUtOt4ql6OqP/Ryo1M=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=O8ePwTxrxozK+PROvZpO9iKayUlJqAOHtilnshuE5ABWgtnadiqkIcx8gGk3f5Jyy
         2N3/7zjczrcsx+ZCKCAXKbbZET7cP4rCc6YZwGtHXSh1cborSscy5M7xuGGeEbH4R3
         SgHIW139EGcBUnDo0WFOBA1RJUE2Ll60DtJHOSq6YRmV7TAG5rh/iRTF/Hn8tBIObU
         BExi5Ac6Z+NYBUMpK1DlmaPo8sdy6fK1YIAxZqcT7/Sp3bBmtiDmcCWEgfQEYn2A+v
         PdPl7nXBRjPtK31maIKwRYsGV4/eEcfcHLO9F1Gou4O5ZKbVcJicKaVKQDLSUuzNUi
         fpge/5Q+V2a2A==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/9] btrfs: avoid searching twice for previous node when merging free space entries
Date:   Thu,  4 May 2023 12:04:20 +0100
Message-Id: <93c8890e17eda56eec2c0b5ed7358dc85df5f5d4.1683196407.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1683196407.git.fdmanana@suse.com>
References: <cover.1683196407.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At try_merge_free_space(), avoid calling twice rb_prev() to find the
previous node, as that requires looping through the red black tree, so
store the result of the rb_prev() call and then use it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/free-space-cache.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index ec53119d4cfb..7d842d356d9f 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2449,6 +2449,7 @@ static bool try_merge_free_space(struct btrfs_free_space_ctl *ctl,
 	u64 offset = info->offset;
 	u64 bytes = info->bytes;
 	const bool is_trimmed = btrfs_free_space_trimmed(info);
+	struct rb_node *right_prev = NULL;
 
 	/*
 	 * first we want to see if there is free space adjacent to the range we
@@ -2456,9 +2457,12 @@ static bool try_merge_free_space(struct btrfs_free_space_ctl *ctl,
 	 * cover the entire range
 	 */
 	right_info = tree_search_offset(ctl, offset + bytes, 0, 0);
-	if (right_info && rb_prev(&right_info->offset_index))
-		left_info = rb_entry(rb_prev(&right_info->offset_index),
-				     struct btrfs_free_space, offset_index);
+	if (right_info)
+		right_prev = rb_prev(&right_info->offset_index);
+
+	if (right_prev)
+		left_info = rb_entry(right_prev, struct btrfs_free_space,
+				     offset_index);
 	else if (!right_info)
 		left_info = tree_search_offset(ctl, offset - 1, 0, 0);
 
-- 
2.35.1

