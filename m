Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADEBF22F0E6
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jul 2020 16:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731711AbgG0O2K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jul 2020 10:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732135AbgG0O2I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jul 2020 10:28:08 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B51C061794
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jul 2020 07:28:08 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id u8so7499474qvj.12
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jul 2020 07:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kljYpc64M7skbE9DMx0YkEWJEAqAJdZBQ2kBCyfBLCM=;
        b=hYfvC8yyNXIWQCq4ys1L93kmP3AoP2i7remPemg7xViOQyDU5XEZwXOAlWE2ajG4xL
         QCzQnxR/k2aZfkuUzC1U0Yd09Q+4kHstVHE3Var2saF5lodXWbJiW+J3u0YwGpoR4QON
         iE5Cyhx/VmEOV4zvOILDM+T/gpdLM8eV/ZRJIrLdZ55ppTS77wzXpKyWSX+ZfeGqXRe+
         XW2QhJ2dwCaQHuAVIMO0Lg0/Dj6NdceWPaGSW9xkOJahvGXu+LLqoVEZBDXZIPVQik0x
         LZOeXK+4NFGnzS1JDJnmnDrC7l0sg+a6PfQ2ZSd5JzQHf5i6Z4bUqTEw2qxYlIn6hLGb
         2hFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kljYpc64M7skbE9DMx0YkEWJEAqAJdZBQ2kBCyfBLCM=;
        b=UxlUInNUqPPhidjtRdasTY9DpYGl6Zz45bfEM7HMe3ZO8HK8/wzsjlu/KnS+f7NMTJ
         VfJ8BYf3SOJqR3GbalKDgYHyFTlr7C5nalFx1awbWULlelgF4N9ZyX+sFnmLboRAzSul
         6YH6Mhq5yZzt448wDilVOKdDZCUuTNBYqd09WAu9+iUCL0XEyU17Y7EkS65ujyLALWvz
         rT7xHX01CeTJ6BGazfE7Lu35bI4nCfHBURvWLgZPq2GPsZi+vyL5C3smEptb6o6CaWua
         t/vptyzmnzuluxjTpHyAigYd1ChGU4p4RIEmakD143JQLBQMGRCA3TlfxUfuy4LrLOp7
         GUtQ==
X-Gm-Message-State: AOAM533zkl7OyAFUGlnr9BTbbln4mNyIpWKalpe7EqD/RUpP5K4/LG/Y
        P4oM23Ht3TPIWUWZltuaDtyDrWHyd/FaEA==
X-Google-Smtp-Source: ABdhPJwjiSrD1tvZVdlkt0A/P4gLJ3ot7BMoYMb29Ua/atWvE8uM+6CwFI8FaT7Nk9CHZvTEp8zs/g==
X-Received: by 2002:a0c:99c5:: with SMTP id y5mr23138072qve.66.1595860087588;
        Mon, 27 Jul 2020 07:28:07 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w27sm13833309qtv.68.2020.07.27.07.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 07:28:06 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH][v3] btrfs: only search for left_info if there is no right_info
Date:   Mon, 27 Jul 2020 10:28:05 -0400
Message-Id: <20200727142805.4896-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In try_to_merge_free_space we attempt to find entries to the left and
right of the entry we are adding to see if they can be merged.  We
search for an entry past our current info (saved into right_info), and
then if right_info exists and it has a rb_prev() we save the rb_prev()
into left_info.

However there's a slight problem in the case that we have a right_info,
but no entry previous to that entry.  At that point we will search for
an entry just before the info we're attempting to insert.  This will
simply find right_info again, and assign it to left_info, making them
both the same pointer.

Now if right_info _can_ be merged with the range we're inserting, we'll
add it to the info and free right_info.  However further down we'll
access left_info, which was right_info, and thus get a UAF.

Fix this by only searching for the left entry if we don't find a right
entry at all.

The CVE referenced had a specially crafted file system that could
trigger this UAF.  However with the tree checker improvements we no
longer trigger the conditions for the UAF.  But the original conditions
still apply, hence this fix.

Reference: CVE-2019-19448
Fixes: 963030817060 ("Btrfs: use hybrid extents+bitmap rb tree for free space")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v2->v3:
- Updated the changelog.

 fs/btrfs/free-space-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 6d961e11639e..37fd2fa1ac1f 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2298,7 +2298,7 @@ static bool try_merge_free_space(struct btrfs_free_space_ctl *ctl,
 	if (right_info && rb_prev(&right_info->offset_index))
 		left_info = rb_entry(rb_prev(&right_info->offset_index),
 				     struct btrfs_free_space, offset_index);
-	else
+	else if (!right_info)
 		left_info = tree_search_offset(ctl, offset - 1, 0, 0);
 
 	/* See try_merge_free_space() comment. */
-- 
2.24.1

