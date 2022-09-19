Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D605BCDFF
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Sep 2022 16:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiISOGz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Sep 2022 10:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiISOGx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Sep 2022 10:06:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F3631ED6
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 07:06:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E090761CFD
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 14:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C6DC433B5
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 14:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663596410;
        bh=66H3gr42bDzmoCmSa+Fn1QW3aJofL2s6btp5zvW5OO8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PxUj3o8ZUO9IuWl0kv1mg0YNx8Uj5NiMhK0r1UDgpLO9Pez/aFg79uY0ZNctX1JYq
         pB6d2hM9PycyzYznWy4ieTpKjVYhGJxCsSTzRgTe0wCJhEYqIEfcKrOjLeZ9d00Zol
         nDwTGL/YWoMwtBJqHhE4vM51fC8inZJVCBhN8lw8hqBSD+TwUrh02IyQqH5S9vFyWb
         vAaWqEbQItmrO6ywcYN0v+C0kHt+Yp5xGOgS/toeCiG9m4ttAyj91/cSdkyP/K6lQ0
         9X9IOob6mtd6m3cIxt5TGH1a6htAcNhg2//4fBXcJT7oLf1A1iv5wEWXTZ1VGDHENM
         VA3hG8IS0Sucg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 07/13] btrfs: remove the refcount warning/check at free_extent_map()
Date:   Mon, 19 Sep 2022 15:06:34 +0100
Message-Id: <ff65eb8a4a15746946d77ab545c5e31caad76295.1663594828.git.fdmanana@suse.com>
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

At free_extent_map(), it's pointless to have a WARN_ON() to check if the
refcount of the extent map is zero. Such check is already done by the
refcount_t module and refcount_dec_and_test(), which loudly complains if
we try to decrement a reference count that is currently 0.

The WARN_ON() dates back to the time when used a regular atomic_t type
for the reference counter, before we switched to the refcount_t type.
The main goal of the refcount_t type/module is precisely to catch such
types of bugs and loudly complain if they happen.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index bef9cc8bfb2a..2e6dc5a772f4 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -74,7 +74,6 @@ void free_extent_map(struct extent_map *em)
 {
 	if (!em)
 		return;
-	WARN_ON(refcount_read(&em->refs) == 0);
 	if (refcount_dec_and_test(&em->refs)) {
 		WARN_ON(extent_map_in_tree(em));
 		WARN_ON(!list_empty(&em->list));
-- 
2.35.1

