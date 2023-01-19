Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2BD6745A0
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jan 2023 23:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjASWOQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Jan 2023 17:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjASWNo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Jan 2023 17:13:44 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494BA966F2
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 13:53:31 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id k6so3759291vsk.1
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 13:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HwdnYcIiWi7wHi2bXU/Fk7/olRy/K+ncT86VsG5nZ9o=;
        b=wD/+SNt/hJ7CuVQWGC/v6YjhDRRYabJ+6ELIaUvNOHLuJYFNNXMLRbx8lDFpm8nl6a
         DSEjxDUDDoQqT1NVbJyVD2UBxJxJkkNdHHdO4hJ43Gshos2wpuayCcupAp7bhv1xSeAP
         JHrPEsplsIW2zF7GHNifZv8wmdYTTH1thDbT37dc6bR7CJ2yvXYU7O0EJp8qQFVlXV0b
         hNFfE93/6HiPFYOWz8gHlF2/ucThGgqWDrBvwcKY9OOaMZUaujOJknWpIrCJNCRlfJLI
         csliUTPe4j6zyXnkh0jbDgAsdzUBeUjQe+Yc6NLmPxD0pv6gl1dMggo+toqHEvBt8tyt
         DgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwdnYcIiWi7wHi2bXU/Fk7/olRy/K+ncT86VsG5nZ9o=;
        b=q+3GST9g1I87ag15Pp5WUJFZhmF2LKkxZvLfNZrkHxYC8oVV3+DR7YFEHLFrvvsnQ3
         kvRu2Ds8ExmHAPUuIj3gPyubcyJu7CK3W3/TLNM0eunCoVuQOaxxy+0dEmh45JQzuci8
         zX+ECnRGYC6qDD2k7eQzHU0MINmlx0Wqve0gONScphJ5kpOjiUtvemxGtpKsQihu70hz
         wgKO30g0YrpKOSMdZ08RvfCUZDHruwP8e5g9/lCGAN6uja/oUpSgdJoLZNHqee+wOQqF
         TUTLXQ+KfLWDfoTifIkaGpm5sagDjd42D04z1EbZUg5AiZDTBGJz1k5xIi2DPKQVt5Kb
         AD2g==
X-Gm-Message-State: AFqh2kr1Qo2bPH6eZXN7wgjhB614BY2kpP4jhixLaspt+5UHIDmH2wNm
        Pp5S4yGGPsin6dh4EdoYbXK2LZcQcIeJh6UlWgU=
X-Google-Smtp-Source: AMrXdXuAVhld7En9JaySNGk7qDVKk2KXeaQoc46Y9RBw39rqpIXp0kA1+4mbWU3cgGIB9O5TUFo98g==
X-Received: by 2002:a05:6102:3e0b:b0:3ce:a1db:d54d with SMTP id j11-20020a0561023e0b00b003cea1dbd54dmr6479835vsv.17.1674165209890;
        Thu, 19 Jan 2023 13:53:29 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id bk14-20020a05620a1a0e00b006ce580c2663sm24970377qkb.35.2023.01.19.13.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 13:53:29 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 2/9] btrfs: always lock the block before calling btrfs_clean_tree_block
Date:   Thu, 19 Jan 2023 16:53:18 -0500
Message-Id: <15350a9c0b5f12fb6d00493e92bae6ed7637ca6c.1674164991.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1674164991.git.josef@toxicpanda.com>
References: <cover.1674164991.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We want to clean up the dirty handling for extent buffers so it's a
little more consistent, so skip the check for generation == transid and
simply always lock the extent buffer before calling
btrfs_clean_tree_block.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 876bea67f9a1..c85af644e353 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5534,8 +5534,7 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 			}
 		}
 		/* make block locked assertion in btrfs_clean_tree_block happy */
-		if (!path->locks[level] &&
-		    btrfs_header_generation(eb) == trans->transid) {
+		if (!path->locks[level]) {
 			btrfs_tree_lock(eb);
 			path->locks[level] = BTRFS_WRITE_LOCK;
 		}
-- 
2.26.3

