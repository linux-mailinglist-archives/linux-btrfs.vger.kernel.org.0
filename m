Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34B35B41BB
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbiIIVyA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbiIIVx7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:53:59 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C21CEB26
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:53:58 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id s22so2222580qkj.3
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=HHuriAKnGvqRraw4EjngMZzAEBRl513RxLJo1fLnj8U=;
        b=mOW7zp91pdKBzlL4gtJ6P4R4cFi9hfeV8DEChfCQLRr95uwdu6jT5TisHsFOinnMcN
         +5G578l8IOBUeq51oQcZKerzHe5DYIVPPDpdyGH8Z0ZyAiCl50MxocXzFb/bL7vbMtxy
         BYl8Y3Tpr5Pb4vajMsKzS49xv1wgw+Ngfzqfp+mXdN7+a0yqvOOBg3Nk/Qy1bgC71mGU
         BuR+QR1AaGEZ9Uh8aO+Sc2KO0y6cC41dCAJsbgTyusns265zwfg28Top+S+gw1DDV5rF
         sUvPYe5V7JCJp7yGaM5X7j9YpXiJa7VSjU00vtB/zl9vCPBbpGQa/B9B3ZaMur+0LV+0
         I+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=HHuriAKnGvqRraw4EjngMZzAEBRl513RxLJo1fLnj8U=;
        b=LvMgpUCgk1SoJa+gbl2sge3spCthOClG/nSKA9h1VK0mD5Rtrq0qQ+YvR/CtEp+u6t
         PdJMYMwIfTg0vqk48Z1pHhcnChYJe2Qm27NhhL/r1PaS1whBYcizGFPXcSeVUY28iple
         +MarlBwty9BYV5GefQ1xP+Xwu+VrdVOlo6NKJ3OVssD9XjDXDZK4klOKmTEjnGpX7ENk
         SNLVSZLn50dzjJam6BLyry+NMIZEIlqT948UnC2t5gzUDe0rkmUCBpRgiy+sxfJPcxKA
         he4NO31NRu6RjCr4hVUYmtW3ia+6/Ry6etWtN+Zn7xCYQ1O2N0tWsiGhyD1GJhBwIgIx
         V1aw==
X-Gm-Message-State: ACgBeo1Yc5kClbXoSLxciIUN/m2uDIVKp5ZUGMAFzXb4Bl8lZ/8H2b9r
        we52OtQOUzaVuuBLCF8l28/9oydFKNviMg==
X-Google-Smtp-Source: AA6agR5SME4jJV0E6hiosmeCwYvPl0MM69kON7siIl7tqJXQLdv+r3eWWwqMEenBoXUNbSU8lHHveQ==
X-Received: by 2002:a05:620a:14a6:b0:6cd:df30:3ae6 with SMTP id x6-20020a05620a14a600b006cddf303ae6mr2697968qkj.556.1662760437261;
        Fri, 09 Sep 2022 14:53:57 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m16-20020ac84450000000b0034361fb2f75sm1069821qtn.22.2022.09.09.14.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:53:56 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 04/36] btrfs: use find_first_extent_bit in btrfs_clean_io_failure
Date:   Fri,  9 Sep 2022 17:53:17 -0400
Message-Id: <52eddebdf9d7f5d9605a469c0dd56d7421be61bb.1662760286.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662760286.git.josef@toxicpanda.com>
References: <cover.1662760286.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently we're using find_first_extent_bit_state to check if our state
contains the given failrec range, however this is more of an internal
extent_io_tree helper, and is technically unsafe to use because we're
accessing the state outside of the extent_io_tree lock.

Instead use the normal helper find_first_extent_bit which returns the
range of the extent state we find in find_first_extent_bit_state and use
that to do our sanity checking.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 972181451561..0f087ab1b175 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2395,9 +2395,10 @@ int btrfs_clean_io_failure(struct btrfs_inode *inode, u64 start,
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct extent_io_tree *io_tree = &inode->io_tree;
 	u64 ino = btrfs_ino(inode);
+	u64 locked_start, locked_end;
 	struct io_failure_record *failrec;
-	struct extent_state *state;
 	int mirror;
+	int ret;
 
 	failrec = get_failrec(inode, start);
 	if (IS_ERR(failrec))
@@ -2408,14 +2409,10 @@ int btrfs_clean_io_failure(struct btrfs_inode *inode, u64 start,
 	if (sb_rdonly(fs_info->sb))
 		goto out;
 
-	spin_lock(&io_tree->lock);
-	state = find_first_extent_bit_state(io_tree,
-					    failrec->bytenr,
-					    EXTENT_LOCKED);
-	spin_unlock(&io_tree->lock);
-
-	if (!state || state->start > failrec->bytenr ||
-	    state->end < failrec->bytenr + failrec->len - 1)
+	ret = find_first_extent_bit(io_tree, failrec->bytenr, &locked_start,
+				    &locked_end, EXTENT_LOCKED, NULL);
+	if (ret || locked_start > failrec->bytenr ||
+	    locked_end < failrec->bytenr + failrec->len - 1)
 		goto out;
 
 	mirror = failrec->this_mirror;
-- 
2.26.3

