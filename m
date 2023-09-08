Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC524798B6B
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 19:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245416AbjIHRVC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 13:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbjIHRVA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 13:21:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B820199F
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 10:20:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B76C433C8
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 17:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694193657;
        bh=g6XNS7/EsJySe6oWOGbizXbEj0VN2mldNvkXEtl2OkE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CuQpK9PalqOoYOQiPalfP6L/mG86BbiLg8kmyM+rHGMb0T6in6YtbxqWgNJ/sCj1j
         uD5qpY6qnn3JMC9Vx8NqX2R2p0Ge7Z/Idvl2aTNkZh8/1urwby8udR2kP3AOZHeF/9
         sXMtmz87V6Aoqd17F2BRc12a5/bnkzCjIDJJccjh7L8KTrOth9sgAuEV15B8fEvYX4
         UzPU4kaQwPm9Qinv5axELFaZ2smmdlvXA50+eC8Yahekm5uR1ngkrydb3P6XAGhJ5k
         6booLxdiSeY/y2skDrrNHT+43xx3ClvF5qWwTLL7cHTsC+vp3lBCgwkaLmnqj/H5/I
         xo2KaX57u4eJg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 15/21] btrfs: return -EUCLEAN if extent item is missing when searching inline backref
Date:   Fri,  8 Sep 2023 18:20:32 +0100
Message-Id: <20d52d8e4ff00c2f64907e83bc379669cc20bb8b.1694192469.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694192469.git.fdmanana@suse.com>
References: <cover.1694192469.git.fdmanana@suse.com>
MIME-Version: 1.0
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

At lookup_inline_extent_backref() when trying to insert an inline backref,
if we don't find the extent item we log an error and then return -EIO.
This error code is confusing because there was actually no IO error, and
this means we have some corruption, either caused by a bug or something
like a memory bitflip for example. So change the error code from -EIO to
-EUCLEAN.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index e57061106860..756589195ed7 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -851,7 +851,7 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 "extent item not found for insert, bytenr %llu num_bytes %llu parent %llu root_objectid %llu owner %llu offset %llu",
 			  bytenr, num_bytes, parent, root_objectid, owner,
 			  offset);
-		ret = -EIO;
+		ret = -EUCLEAN;
 		goto out;
 	}
 
-- 
2.40.1

