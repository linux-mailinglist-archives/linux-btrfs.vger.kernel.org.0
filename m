Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E767986CC
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 14:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243164AbjIHMJq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 08:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242989AbjIHMJp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 08:09:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C081BC5
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 05:09:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58454C433CA
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 12:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694174981;
        bh=h9dIxJBzVpiFuPuXVPpGEbIiYP//2Olu5rK4Tnd3X40=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bI+fnJdEa5xyOLj6mWZDditz5Tq7XBVbdSD+K8jLKy08zyEGa2xYCyXhKStMYcY7j
         ilL4eGeir5nV7CLB+frU9pH3nfdXPoyyxbUWXpM6kACX6KxJvnyZAj2kjnJo8sRtea
         iUHArLYIiAkxVNt15YNfM3y/BeRtATsixcWE8J6nE891FfpPSbvyVprZV/kT4SUwPw
         3eut0GiqdyY1pUk7HTjv0IOkxRt6q9mV5vw7rs7BgtTKYbDpUjO9CvBJshB0+lD3XD
         CNDJlbddcFm/I4+XPZp3G0THwMGrhTF7DxjxzZaD789LVbwwUrUSSH1ucIRdssnrwL
         aHL0GxL8fKBXw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 15/21] btrfs: return -EUCLEAN if extent item is missing when searching inline backref
Date:   Fri,  8 Sep 2023 13:09:17 +0100
Message-Id: <b79b564eb5cc9823b42890db4309501bd48d2d39.1694174371.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694174371.git.fdmanana@suse.com>
References: <cover.1694174371.git.fdmanana@suse.com>
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

