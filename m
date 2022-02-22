Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820454C0491
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 23:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236055AbiBVW1J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 17:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbiBVW1I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 17:27:08 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388ED9FF8
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:26:41 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id t21so1850935qkg.6
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bOB2lcEZb2eLTcchXz6BHds8aEvX5FQU89ADLRQpoQA=;
        b=XGcVdTI9BufRQYyaw8EH6ZhzimFv/vhdLMyFYkE7MD6BT2u+d+z8OxtCjPnMKhMBhb
         UwJPEvYgitqU7WDQts/Y4yQbVI93hdDDRA6NNBF9B3zK81r7e3oMtYarViJ1kb68dymv
         7CNlMMKLjMaRT/GOST0a2VyRR7qN5CyKeZgPMZCDlFiumbTQ834qN7vjvPUlxDoTEX75
         ur2TQCSZhEOX9OIR7kpWlZZlQBQ+iIz4I6290Mj18LnZ0kTvLba46qZEKZ3Lv5InOta4
         hppu7JTeEMDHLL7euTuuDy4sHbTfljlYSKbOwMPXUeuTzSeUHj2RHh3qOmkIgpQOlV8m
         d6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bOB2lcEZb2eLTcchXz6BHds8aEvX5FQU89ADLRQpoQA=;
        b=5VCjgnxouOE/K6Pp8ulg2LUxokypptt0OWR+7yQs/IGfffKbQueE7ByPKUi38ROrPk
         AUzMvQsQTUAvJyEnJJMKElMKxRzRN94cBzRM+24hKLbJ4e2UubLZQ2kz7smhCsVsScd7
         GGpoKPO1feZT9SKHbvRxkPJBjcXdgSpzPyWk2TVFrjwkDr/07WTPIyadj/xBFueixboG
         peauM8JUHKTSZpw94k3jPWhTMtpMYFcS76ja4yEr5345oQA0+TkH3xhMC8fcn5PsKsAb
         +IuCXb//1Qcqdpk+CTAODvlFWi9yJhFwShOa+o3pfzg3fT3RcONJYnbozgaUfUS7kxsI
         GvDA==
X-Gm-Message-State: AOAM532YypcKrI/j0QGift1S8+MHgKuCHShd8zrknsJ8GItNntHuXZM3
        rRAY5l+jbIXSO6HELrsrjt2VULVseYw/yyUO
X-Google-Smtp-Source: ABdhPJyVEM0qP8MDM2EjjLMe3DqC2WZrf4HJ25LFcPM7j33GJ4amPN7JUXqODQSQqOLZxmK4zBRzBA==
X-Received: by 2002:a37:404:0:b0:60d:29dd:b22f with SMTP id 4-20020a370404000000b0060d29ddb22fmr16479561qke.589.1645568800145;
        Tue, 22 Feb 2022 14:26:40 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a20sm816423qtx.6.2022.02.22.14.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:26:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/13] btrfs-progs: replace btrfs_item_nr_offset(0)
Date:   Tue, 22 Feb 2022 17:26:21 -0500
Message-Id: <a597a4dcd96aa815ab999b72af722c37c1eda19e.1645568701.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645568701.git.josef@toxicpanda.com>
References: <cover.1645568701.git.josef@toxicpanda.com>
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

btrfs_item_nr_offset(0) is simply offsetof(struct btrfs_leaf, items),
which is the same thing as btrfs_leaf_data(), so replace all calls of
btrfs_item_nr_offset(0) with btrfs_leaf_data().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 04847cd5..e164492b 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -2075,11 +2075,11 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 		     btrfs_leaf_data(left) + leaf_data_end(left), push_space);
 
 	memmove_extent_buffer(right, btrfs_item_nr_offset(push_items),
-			      btrfs_item_nr_offset(0),
+			      btrfs_leaf_data(right),
 			      right_nritems * sizeof(struct btrfs_item));
 
 	/* copy the items from left to right */
-	copy_extent_buffer(right, left, btrfs_item_nr_offset(0),
+	copy_extent_buffer(right, left, btrfs_leaf_data(right),
 		   btrfs_item_nr_offset(left_nritems - push_items),
 		   push_items * sizeof(struct btrfs_item));
 
@@ -2198,7 +2198,7 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 	/* push data from right to left */
 	copy_extent_buffer(left, right,
 			   btrfs_item_nr_offset(btrfs_header_nritems(left)),
-			   btrfs_item_nr_offset(0),
+			   btrfs_leaf_data(right),
 			   push_items * sizeof(struct btrfs_item));
 
 	push_space = BTRFS_LEAF_DATA_SIZE(root->fs_info) -
@@ -2238,7 +2238,7 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 				      btrfs_leaf_data(right) +
 				      leaf_data_end(right), push_space);
 
-		memmove_extent_buffer(right, btrfs_item_nr_offset(0),
+		memmove_extent_buffer(right, btrfs_leaf_data(right),
 			      btrfs_item_nr_offset(push_items),
 			     (btrfs_header_nritems(right) - push_items) *
 			     sizeof(struct btrfs_item));
@@ -2296,7 +2296,7 @@ static noinline int copy_for_split(struct btrfs_trans_handle *trans,
 	btrfs_set_header_nritems(right, nritems);
 	data_copy_size = btrfs_item_end(l, mid) - leaf_data_end(l);
 
-	copy_extent_buffer(right, l, btrfs_item_nr_offset(0),
+	copy_extent_buffer(right, l, btrfs_leaf_data(right),
 			   btrfs_item_nr_offset(mid),
 			   nritems * sizeof(struct btrfs_item));
 
-- 
2.26.3

