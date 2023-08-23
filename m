Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11A3785AB7
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236536AbjHWOdu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236530AbjHWOdt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:49 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C31E5F
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:48 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d77c5414433so684835276.0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801227; x=1693406027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iMu2CwI+bLkq149TYP8lMxufPqfWGVbZmFYmRx+T1Z0=;
        b=ivto+ha3MD1ly59k50mCnhsj1S4SwkXa9vLLAIjc0/S9cx6ifOJPgErNm5DgXx81DU
         t3W4rcjqSVJzHQuRKPR9a71QNjkwRqKL2WZHgP7bwLf7kEXYZPfCw0SWS9wmJ54eL5tK
         HGXtYtgnX1NfHGqwZuMhAMFmpFn5v2R9AptNhZpdu93daetgMzInbUxR7KXxYHGfWj/v
         dqljxqFdFbj7sa3wf7aBrWZgJW9Id41gNA3sN/UTJowkOp/vVGE4/gw+d2+Gmg+kI6PP
         DybL5m6dOcBWfAXh4NfDuqlSr2Fhjc2EkFJdXNbbeh0wGDtUnboI6pKzj9z0yFtFNYzQ
         mQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801227; x=1693406027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMu2CwI+bLkq149TYP8lMxufPqfWGVbZmFYmRx+T1Z0=;
        b=hZ/KEYFeaPzbijsI9dMy/s8iweCOgq00uiL8IjrBlsZXCLwKOCz2ZidOYG6KZO0maH
         4VrFQXCkzjvNJW6adlKAT6gCfoZi3uXV9huGD4BIpWULZePbnRrN1QfbljnZ46oFQnjT
         yM8OqajnO2zV8uB73hi7Slgrj+eDfECgKD9QAPXFsoCmO8Ito4Qdx233Gug5MGEuR6Cp
         u/tInE/4pqceLF01jjdYTnqyM2fW/2gByQv+EQSUiM43OzoDHhzPYAcEkFcTUvxbSBvc
         Eu6tFyugwyV+s7TOhT1LTZ5PTQEMvTkAgQxKaJLIS/GmRMofLkyfNuK9pUs7yc/5uqUy
         AC0A==
X-Gm-Message-State: AOJu0YxMIZUoK+rSRlx1Od6gBa2piZ5fBZ+lOFUW2lSasb2ka64bzyNR
        WPrtM2d6fQUwmfSSN+KLGDp3EzUVJ/XQ09GjDZE=
X-Google-Smtp-Source: AGHT+IE9xjZXNEVTPeHEBOyTMSBFWonRTeGp7CPSgp0OSwjmL71c3BPuDLZX906LBvdA7BjEuqwbLg==
X-Received: by 2002:a25:d886:0:b0:d07:f1ed:51f6 with SMTP id p128-20020a25d886000000b00d07f1ed51f6mr13563299ybg.2.1692801227515;
        Wed, 23 Aug 2023 07:33:47 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id p3-20020a25ea03000000b00d217e46d25csm2875715ybd.4.2023.08.23.07.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:47 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 33/38] btrfs-progs: update btrfs_leaf_free_space to match the kernel
Date:   Wed, 23 Aug 2023 10:32:59 -0400
Message-ID: <83136ab7881aa253f3cb31c022e3b1208ff32818.1692800904.git.josef@toxicpanda.com>
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

In the kernel we have const struct extent_buffer instead of struct
extent_buffer, update this to make it more straightforward to sync
ctree.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.c | 4 ++--
 kernel-shared/ctree.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 5355d385..e95839bd 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -1740,7 +1740,7 @@ static int split_node(struct btrfs_trans_handle *trans, struct btrfs_root
  * and nr indicate which items in the leaf to check.  This totals up the
  * space used both by the item structs and the item data
  */
-static int leaf_space_used(struct extent_buffer *l, int start, int nr)
+static int leaf_space_used(const struct extent_buffer *l, int start, int nr)
 {
 	int data_len;
 	int nritems = btrfs_header_nritems(l);
@@ -1760,7 +1760,7 @@ static int leaf_space_used(struct extent_buffer *l, int start, int nr)
  * the start of the leaf data.  IOW, how much room
  * the leaf has left for both items and data
  */
-int btrfs_leaf_free_space(struct extent_buffer *leaf)
+int btrfs_leaf_free_space(const struct extent_buffer *leaf)
 {
 	int nritems = btrfs_header_nritems(leaf);
 	u32 leaf_data_size;
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 5551d256..67c5a6f8 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1080,7 +1080,7 @@ static inline int btrfs_next_item(struct btrfs_root *root,
 }
 
 int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path);
-int btrfs_leaf_free_space(struct extent_buffer *leaf);
+int btrfs_leaf_free_space(const struct extent_buffer *leaf);
 void btrfs_set_item_key_safe(struct btrfs_fs_info *fs_info,
 			     struct btrfs_path *path,
 			     const struct btrfs_key *new_key);
-- 
2.41.0

