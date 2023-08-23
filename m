Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857E7785AA4
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbjHWOde (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236470AbjHWOdc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:32 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCB7E68
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:30 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-58cf42a32b9so63487817b3.2
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801209; x=1693406009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LWYVPdrAqaymGLj3vcZR+O2TJhyfMPKOtfcj/j8VF8Y=;
        b=kwjJ8FOfrG+qoYtTk9GQxzJpfUEa5CN7suIJhbeHlvQTQxuJW6Uk2T4bszTxRaPHn3
         njWvStD36+0bkn2bMmv+iHqddemgwGUyzTwXYAaupxshnHInZw6tL+b8g2cOPeFIs1wD
         uxbVUaSe+qz1gB3YV+CB+MVY6OO0CcLuIRdJNUseFHL0n2BcytDRfw5hvSPRC/H6bdUJ
         ztsAESviLYQAxWVT0iXWPZF8jpL7lZw7YqUKM3g0ln5BvBb1h0lSSieAzOtD+uoTFssg
         h7nVbG3y+NtUjOxm3akyVxYlA+2zGERzDpQOm+FrnCQNvP3CRuUY+ZNGjWu1b3IZi+mT
         OyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801209; x=1693406009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWYVPdrAqaymGLj3vcZR+O2TJhyfMPKOtfcj/j8VF8Y=;
        b=gt2pmP0LtpIFw3r58AqXnxP8TADsZCJQq4xiZxY0ZHlw53CkFPf3qNOs0iQziZdmnk
         1UdKRrqIeg6zLuRLrLWvmsd4reQ04lLQdmNnOHbzQgynvxFqkUsztweTuRFzVnHUc0pU
         Eh6qXMg27THANN5cvW+owt8FmF+srNxN+Jy7X+gS44H75XrrNTSHislykhDC0w+mAieN
         apH9ZhmpO8ICkj2PAUlJwq8oNrSOSY63lEP+qMwBdYcSi469252AEZ6Q26sKxdN116A3
         NSwKmmP4SKvmskx7EasiU1xC4Gy2M0K12MXXWiLyHpRCHko1O1tM+oVgOc2wUoqUdCF8
         Fzkw==
X-Gm-Message-State: AOJu0Yy0qw1Nr4VVNqVF4oRxxzBCl8t8DODnfvs2nKOBtRxN6BnkbI+C
        GRBxn3Hvy6nO/sdach8asjE+ZqaZwwS6KBpWt0c=
X-Google-Smtp-Source: AGHT+IHSZ7yKLNX420/FyKi3C7j0voijBP7xl05u3o+KYch4j3PqEYFQR0+1JMW81tZHf21+0cbcjg==
X-Received: by 2002:a05:690c:e0d:b0:586:a249:d396 with SMTP id cp13-20020a05690c0e0d00b00586a249d396mr14119160ywb.12.1692801209137;
        Wed, 23 Aug 2023 07:33:29 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id p188-20020a815bc5000000b0057a6e41aad1sm3332907ywb.67.2023.08.23.07.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:28 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 17/38] btrfs-progs: don't set the ->commit_root in btrfs_create_tree
Date:   Wed, 23 Aug 2023 10:32:43 -0400
Message-ID: <b97af2da00b090c30932e9062ef7b73ebbdbb6b7.1692800904.git.josef@toxicpanda.com>
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

In btrfs_create_tree we set ->commit_root to the current node, however
we don't add the root to the dirty list, so this is never cleaned up.
This is a problem in btrfs-progs because the transaction commit stuff
clears the commit_root when we write the dirty root out, so if we try to
re-modify this root later we'll fail to start the transaction.  Fix this
by noting that we do this differently in the kernel, and drop the
assignment as we're inserting the root into the tree_root in this
function and thus don't need to update it again at transaction commit
time.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/disk-io.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 35b6cde9..c98addd2 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -2340,7 +2340,14 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(leaf);
 
 	extent_buffer_get(root->node);
-	root->commit_root = root->node;
+
+	/*
+	 * MODIFIED:
+	 *  - In the kernel we set ->commit_root here, however in btrfs-progs
+	 *    confuses the transaction code.  For now don't set the commit_root
+	 *    here, if we update transaction.c to match the kernel version we
+	 *    need to revisit this.
+	 */
 	set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
 
 	root->root_item.flags = 0;
-- 
2.41.0

