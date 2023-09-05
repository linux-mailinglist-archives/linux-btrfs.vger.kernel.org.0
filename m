Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23869792FD7
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 22:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243373AbjIEUWI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 16:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbjIEUWH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 16:22:07 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12380D2
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 13:21:59 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-76f0807acb6so174884385a.1
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Sep 2023 13:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1693945318; x=1694550118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Htt9joSIkNadrNgi0VqCKp8H6PmG5zv4leFkC0grZ8w=;
        b=etcxllOqu19buZSaLg0R2iZisbqBzNLUm0oMlX06uQ/2+Nbg5ILtk2SPEdshhl4w2c
         U5u2TvbwBejaPSfIKiVt8Ty+DJtL+0TMVMgDNRIhu9G4X9L3HQVAwU9rxM9kf4zXthZq
         7a7MSeiI7Mi/qduVooJSb9xOSNZYB2XHMezneGeX6D4MDoP1Ssm014lJc/Vz5XkBVW7X
         o6ZicvfiKTJHwxvZFqjyH/iL98FyKFp9jBbnwRfTHZizn+6wuTSslA5T/CoTK+Jp6NfP
         hbiGx2N3Z/sJCrVEeBIYxosXCw6rTqi1mM2AFw09/NTx2XuxeZO4laRgdRwp2hQlbdx4
         Upfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693945318; x=1694550118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Htt9joSIkNadrNgi0VqCKp8H6PmG5zv4leFkC0grZ8w=;
        b=kP7DR1GNUpfQUpMsdROH//uExeto4nDfHjylEO+keD8eNeWTJtfCM9ymI6YR/P7QbC
         sDT8/qhxU7CW1DRdSjnCkz8W5PaN6yUBrMoGOyp3A/RUp4Sfoh98Fvv+AdXJ90spB3bz
         C7E7Mcsnw0Z+6X4H/PCLUtM7EG3keKTDoOp1EkgVxTW/Zc0BcpH1FFDMcdpOLieTXmQY
         fhrKrWxh1IsxNMdDb6FHZcaR8ZWjC9qo2ahx3sDSfgSlHiHv69Ra24+eTtlfbw1hbytm
         C6JFR5VMMwW6AcUyuizxhyJ3meKNAqqUbLeAEtDwDQbcT6Rc1noRcp3FXoG1Ed2qB9B4
         GC4w==
X-Gm-Message-State: AOJu0YzxyqZcs3A3UJdHyAXokPKI4CAdQquvw/pNMRe1WJlLx8MiL9rQ
        8+vU3FhVv+C5Wb8W7kqc6i22GUwHda3yfHwyOuQ=
X-Google-Smtp-Source: AGHT+IGdAu6biTaVomkYpQPCuaQ4n79mpRh6wj/mEnJ6ylisFHyn5B+fY5gtMGVmJIMagyMOqw/C9Q==
X-Received: by 2002:a05:620a:995:b0:76c:d4b7:5dbd with SMTP id x21-20020a05620a099500b0076cd4b75dbdmr12547433qkx.45.1693945317957;
        Tue, 05 Sep 2023 13:21:57 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id z7-20020ae9c107000000b0076eedc31b5esm4350528qki.128.2023.09.05.13.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 13:21:57 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/3] btrfs-progs: cleanup dirty buffers on transaction abort
Date:   Tue,  5 Sep 2023 16:21:51 -0400
Message-ID: <0f71fe47579f137a626d9c9f4e68419bad9dd4c7.1693945163.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693945163.git.josef@toxicpanda.com>
References: <cover.1693945163.git.josef@toxicpanda.com>
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

When adding the extent buffer leak detection I started getting failures
on some of the fuzz tests.  This is because we don't clean up dirty
buffers for aborted transactions, we just leave them dirty and thus we
leak them.  Fix this up by making btrfs_commit_transaction() on an
aborted transaction properly cleanup the dirty buffers that exist in the
system.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/transaction.c | 45 +++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/kernel-shared/transaction.c b/kernel-shared/transaction.c
index fcd8e6e0..01f08f0f 100644
--- a/kernel-shared/transaction.c
+++ b/kernel-shared/transaction.c
@@ -132,6 +132,25 @@ int commit_tree_roots(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
+static void clean_dirty_buffers(struct btrfs_trans_handle *trans)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct extent_io_tree *tree = &fs_info->dirty_buffers;
+	struct extent_buffer *eb;
+	u64 start, end;
+
+	while (find_first_extent_bit(tree, 0, &start, &end, EXTENT_DIRTY,
+				     NULL) == 0) {
+		while (start <= end) {
+			eb = find_first_extent_buffer(fs_info, start);
+			BUG_ON(!eb || eb->start != start);
+			start += eb->len;
+			btrfs_clear_buffer_dirty(trans, eb);
+			free_extent_buffer(eb);
+		}
+	}
+}
+
 int __commit_transaction(struct btrfs_trans_handle *trans,
 				struct btrfs_root *root)
 {
@@ -174,23 +193,7 @@ cleanup:
 	 * Mark all remaining dirty ebs clean, as they have no chance to be written
 	 * back anymore.
 	 */
-	while (1) {
-		int find_ret;
-
-		find_ret = find_first_extent_bit(tree, 0, &start, &end,
-						 EXTENT_DIRTY, NULL);
-
-		if (find_ret)
-			break;
-
-		while (start <= end) {
-			eb = find_first_extent_buffer(fs_info, start);
-			BUG_ON(!eb || eb->start != start);
-			start += eb->len;
-			btrfs_clear_buffer_dirty(trans, eb);
-			free_extent_buffer(eb);
-		}
-	}
+	clean_dirty_buffers(trans);
 	return ret;
 }
 
@@ -202,8 +205,11 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_space_info *sinfo;
 
-	if (trans->fs_info->transaction_aborted)
-		return -EROFS;
+	if (trans->fs_info->transaction_aborted) {
+		ret = -EROFS;
+		goto error;
+	}
+
 	/*
 	 * Flush all accumulated delayed refs so that root-tree updates are
 	 * consistent
@@ -277,6 +283,7 @@ commit_tree:
 	return ret;
 error:
 	btrfs_abort_transaction(trans, ret);
+	clean_dirty_buffers(trans);
 	btrfs_destroy_delayed_refs(trans);
 	free(trans);
 	return ret;
-- 
2.41.0

