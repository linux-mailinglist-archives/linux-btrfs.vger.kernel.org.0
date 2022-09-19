Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DFE5BCE0A
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Sep 2022 16:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiISOG6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Sep 2022 10:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiISOGz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Sep 2022 10:06:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DFD31DFD
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 07:06:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E9ACB81B6A
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 14:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABECC433B5
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 14:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663596412;
        bh=7kVVpIrCUi34lgVO9zeoGq13jz1cNkd4hNW7WQC/rdQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Czc006LWdxBboiMA2rPZ9dmrOlw3086xYJFgplmJwPu52XkkwcrU4G1FrtyVKUFrr
         et95TWCTZmaHRShJqA+hCL/x8PtOWJTRk/Cb5FoNotDdWsn3iWyofrHF9RXPJMqcl1
         reNsZAhQyfZR4Ar+tE2WQuifwJNkB6q+t7f+W7aX3cJOfh+XXzMXYApoEZCJ2xupdA
         zOY/RlnppOH2EQY62+iVMOyFQhj7H0YdbyUnVxeHts06mR4D53tpDq/u9db46xu6Vy
         uqjMo3OnkFQPZ37UmejqzJYz2jmB3Y5pnJNPXn3It5AlmeSt5dv+khUA/fhxLsqrX9
         /jAQhixB0XF3w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/13] btrfs: assert tree is locked when clearing extent map from logging
Date:   Mon, 19 Sep 2022 15:06:36 +0100
Message-Id: <f7a30feaffda0ca4480ee94c08114bcbfe9b22de.1663594828.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663594828.git.fdmanana@suse.com>
References: <cover.1663594828.git.fdmanana@suse.com>
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

When calling clear_em_logging() we should have a write lock on the extent
map tree, as we will try to merge the extent map with the previous and
next ones in the tree. So assert that we have a write lock.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 6b7eee92d981..f1616aa8d0f5 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -334,6 +334,8 @@ int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len,
 
 void clear_em_logging(struct extent_map_tree *tree, struct extent_map *em)
 {
+	lockdep_assert_held_write(&tree->lock);
+
 	clear_bit(EXTENT_FLAG_LOGGING, &em->flags);
 	if (extent_map_in_tree(em))
 		try_merge_map(tree, em);
-- 
2.35.1

