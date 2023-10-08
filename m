Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B3B7BCABC
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Oct 2023 02:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbjJHAtR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Oct 2023 20:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbjJHAtP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 7 Oct 2023 20:49:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3CADB;
        Sat,  7 Oct 2023 17:49:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C594C433C7;
        Sun,  8 Oct 2023 00:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696726147;
        bh=A3kjQty4vI/GS8IYqcujAel4pBfkUQWJdq8CYZ1+6Oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G77b62kvu4+7SZg0+l587nOi5muXR+SElSzdAQXSGKcT3O1ojfJmGHlqFko8lh9oF
         JGIweckuzUFmlFFWYYkvFDeerRaCbryXOMHCCq5LUJeVAfApi2CZwIwX9fp+xd3sNy
         +lK/6hRwTH1/DzQ1MVJ2zZn7iTI5N/dytrv0pvFNxOy1TOrxtxpO5sdiMrpis9dP55
         GLy+iTttLjSAHdyqlqOvk91nTfnQpn+y0ehWBzMbebCV6HnZiF2xbMm4CbhBQMinG3
         Qp8fp7vw2SqlrQNyVLG+Lcj/I8juDiRaPxxp22RmcfAHSYqeUmvny9EspnPh8I+xDQ
         JExRT58c3hizA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 07/18] btrfs: return -EUCLEAN for delayed tree ref with a ref count not equals to 1
Date:   Sat,  7 Oct 2023 20:48:41 -0400
Message-Id: <20231008004853.3767621-7-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231008004853.3767621-1-sashal@kernel.org>
References: <20231008004853.3767621-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 1bf76df3fee56d6637718e267f7c34ed70d0c7dc ]

When running a delayed tree reference, if we find a ref count different
from 1, we return -EIO. This isn't an IO error, as it indicates either a
bug in the delayed refs code or a memory corruption, so change the error
code from -EIO to -EUCLEAN. Also tag the branch as 'unlikely' as this is
not expected to ever happen, and change the error message to print the
tree block's bytenr without the parenthesis (and there was a missing space
between the 'block' word and the opening parenthesis), for consistency as
that's the style we used everywhere else.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent-tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 0917c5f39e3d0..2cf8d646085c2 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1715,12 +1715,12 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 		parent = ref->parent;
 	ref_root = ref->root;
 
-	if (node->ref_mod != 1) {
+	if (unlikely(node->ref_mod != 1)) {
 		btrfs_err(trans->fs_info,
-	"btree block(%llu) has %d references rather than 1: action %d ref_root %llu parent %llu",
+	"btree block %llu has %d references rather than 1: action %d ref_root %llu parent %llu",
 			  node->bytenr, node->ref_mod, node->action, ref_root,
 			  parent);
-		return -EIO;
+		return -EUCLEAN;
 	}
 	if (node->action == BTRFS_ADD_DELAYED_REF && insert_reserved) {
 		BUG_ON(!extent_op || !extent_op->update_flags);
-- 
2.40.1

