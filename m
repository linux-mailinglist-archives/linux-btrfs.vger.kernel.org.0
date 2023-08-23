Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4EC785AA8
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbjHWOdi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236488AbjHWOdh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:37 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA06E57
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:35 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-5710b054710so595920eaf.1
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801215; x=1693406015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=By9Q/LMA6FtAhPIM1j6On7nXfUxFdhlB7musiSsZK40=;
        b=mEPu+5JuDvAV6bvveJPae6O3RH8l6Z+24fbMg9kxxt0C1jRImYhrwTJZusUC5tXF4J
         hDLHq3J4wdtO7YPWL+Hi5+jjVAbjLHMBZsYmhVzYN05EUfFiZ7i9ALVkoR1TgViLPpT0
         04Z7Y/MrH2m35G0VEqUzuqAPEvEe0K+LdaSq/Ot65EVRVn8EVPmQAJgciMMyeXWbKtsT
         xHDmGY/xWhRNGEG4n4GzfRwTQcd1pCPq642Gk3YJ2dyBn3DVq80omefDHwaCm5Yh8UGs
         rpUN/W2YalhAtD84KpDJIeZP0tw+G4mcBzmG+NJBj4n3cU67VswWauGJey4Iplyjce6A
         mH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801215; x=1693406015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=By9Q/LMA6FtAhPIM1j6On7nXfUxFdhlB7musiSsZK40=;
        b=M3wr39bdo5cBCR1bWayWLgKWCnhBATKSE6TTg5KUlBQMR2nd7V/oDC022kBo2KPSso
         aNdR2UPzm6PxytyA7wpmrrMrpxPXsiPU3/11xz9mp/YQsz34n9fBaHdVlzWab36fDdYL
         N9A6i56RGBHKBINRnSMlCyGEXWqbnS9yglWogS+plnBBq4wZcpoxo9dd1fxFi5xbSUlB
         QosR0sUhF/7ej8RBhOcmyNx/8AjRTvnfz98u3kL4Ea14Rlh6dVSlRB00SqBxFJPn0SLN
         COYizzh9IjMkTkURGoKfRLy/tRCGjmAiDJCGLYhu/ez5Hsg7JR3/8oHX9CWNsT+e7FU+
         bbrA==
X-Gm-Message-State: AOJu0Yzb4jpdb0B9925FgxAhX6NJD3/kMaXVj+iK5oTebJWwU/3F/BCt
        R/c2GR7i7NeqPNdtx7VB5tbFS7g5tQi+OkNYHRU=
X-Google-Smtp-Source: AGHT+IHTFwRDvrCMAMMwivqyq6x9cVG/RI+9SdRQ40pa5UAVPKnXBMRPJPneQJN7qKLyZm9PtMAcQA==
X-Received: by 2002:a05:6358:6f16:b0:133:428:35dc with SMTP id r22-20020a0563586f1600b00133042835dcmr11309633rwn.11.1692801214854;
        Wed, 23 Aug 2023 07:33:34 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x123-20020a818781000000b0057a918d6644sm3355408ywf.128.2023.08.23.07.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:34 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 22/38] btrfs-progs: use path->search_for_extension
Date:   Wed, 23 Aug 2023 10:32:48 -0400
Message-ID: <0c55a506da48747708c4ec759712c25d5a7b2e1d.1692800904.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692800904.git.josef@toxicpanda.com>
References: <cover.1692800904.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This flag is used by the kernel btrfs_search_slot to make sure that leaf
splitting decision doesn't subtract the size of an item.  This is for
inline extent items and csum items where we know we're going to find the
item we want, and we're only going to want to extend it.  Currently this
flag doesn't do anything, but when we sync ctree.c we'll stop making the
right decision WRT the leaf space, so add the flag usage in the places
we need it so we can sync ctree.c easily.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/extent-tree.c | 8 ++++++--
 kernel-shared/file-item.c   | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 439ac530..10482652 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -881,10 +881,12 @@ static int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 	key.offset = num_bytes;
 
 	want = extent_ref_type(parent, owner);
-	if (insert)
+	if (insert) {
 		extra_size = btrfs_extent_inline_ref_size(want);
-	else
+		path->search_for_extension = 1;
+	} else {
 		extra_size = -1;
+	}
 
 	if (owner < BTRFS_FIRST_FREE_OBJECTID && skinny_metadata) {
 		key.type = BTRFS_METADATA_ITEM_KEY;
@@ -1022,6 +1024,8 @@ again:
 	}
 	*ref_ret = (struct btrfs_extent_inline_ref *)ptr;
 out:
+	if (insert)
+		path->search_for_extension = 0;
 	return err;
 }
 
diff --git a/kernel-shared/file-item.c b/kernel-shared/file-item.c
index 7baa5614..54d7c094 100644
--- a/kernel-shared/file-item.c
+++ b/kernel-shared/file-item.c
@@ -257,8 +257,10 @@ int btrfs_csum_file_block(struct btrfs_trans_handle *trans, u64 logical,
 	 * enough yet to put our csum in.  Grow it
 	 */
 	btrfs_release_path(path);
+	path->search_for_extension = 1;
 	ret = btrfs_search_slot(trans, root, &file_key, path,
 				csum_size, 1);
+	path->search_for_extension = 0;
 	if (ret < 0)
 		goto fail;
 	if (ret == 0) {
-- 
2.41.0

