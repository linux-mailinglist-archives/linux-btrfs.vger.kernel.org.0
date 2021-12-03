Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E958467FD0
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 23:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383395AbhLCWWB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 17:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383391AbhLCWV7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 17:21:59 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED8AC061353
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Dec 2021 14:18:35 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id b67so4998377qkg.6
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Dec 2021 14:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0bWGGXJlS9Jn3POFye1qVoQWPeB6GgvgS19h7McZZ1s=;
        b=WBZo80dSc+6Vi+EwNZXY34nZxYnfSNxhP5w4GvMYOdRD9nblMi5YiBawjJA1STTnRi
         rZkRIqyOBp3U7u1ZQ6/uRRfjm+OTC3WwDMdQ3bibxtxUqV/EMpBiGNr4R1l0MQaCM7K3
         TDFETRLn1LYAgqw1Xr2c6hTYtkVmbfpoThZJoxEuMtwtz3bXuhFAb+pnB2EJ+VEJoxPL
         3oOLD9hwyEwTwowinpxD0iPOWDtRmFAreC64CQSv2JiI9a3rts49vry++uWkpK31Tux1
         q5Gjz5M3Ct+yTQFT8C/hsIi0dc9SlwQEJxsBYXxpoHJtg+dzYAzyqZScR6R2jx7SwTTa
         lCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0bWGGXJlS9Jn3POFye1qVoQWPeB6GgvgS19h7McZZ1s=;
        b=3hqg66WI074JA/1SxkMKOwUvkMsYhmb91GQnRTZAqC6GBnnt1PPiDhKhXkFCOdYEn5
         mUrbSbvXAUiYt3EoHjMsbt2IunWlCWNWe1neZZeFVjnitwqhb7CoyyrWiVzzQLzfYjjk
         P+u0gOTfi2GfslTztTcBAsWofFbbMAQJqwSWI6utlrfQeddq98vL+bh270dTPrPZqGga
         E5fRHgTFT+mYOKaQHs3vFx5/EUqYVpIyYU3qOPYaxqkOa8QBeWdgvh/dfSOjbesaSqG5
         Jj1IUsoqwUF0RHRMDMe//3TTCq2X10NoSII2Cizhjwy2KbFcudGrX5KdJ/n6H9DeoWmY
         dqpg==
X-Gm-Message-State: AOAM533JYGmJAPaeVTdjDN9c2DL+K8QC7eZ+IOmKd+G8kOVJaGNXN+PC
        47RmDDPvF07PanQ7qzQL0ODqhWEcazqLSQ==
X-Google-Smtp-Source: ABdhPJwQ1x+I04fWsYICfwOL/RiBuGVaR7rVZe7dZixClm1UG3OXWMPH88S8lveeY9H4vZRyiLx8kg==
X-Received: by 2002:a05:620a:28c3:: with SMTP id l3mr20027937qkp.584.1638569914034;
        Fri, 03 Dec 2021 14:18:34 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bk25sm2987991qkb.13.2021.12.03.14.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 14:18:33 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/18] btrfs: control extent reference updates with a control flag for truncate
Date:   Fri,  3 Dec 2021 17:18:12 -0500
Message-Id: <450bed2abc79c39b448de30cf381a7e418cec058.1638569556.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638569556.git.josef@toxicpanda.com>
References: <cover.1638569556.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We've had weird bugs in the past where we forgot to adjust the truncate
path to deal with the fact that we can be called by the tree log path.
Instead of checking if our root is a LOG_ROOT use a flag on the
btrfs_truncate_control to indicate that we don't want to do extent
reference updates during this truncate.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode-item.c | 3 +--
 fs/btrfs/inode-item.h | 6 ++++++
 fs/btrfs/tree-log.c   | 1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index ebbe4054ae93..79305d646b98 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -663,8 +663,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 		}
 		should_throttle = false;
 
-		if (del_item && extent_start != 0 &&
-		    root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
+		if (del_item && extent_start != 0 && !control->skip_ref_updates) {
 			struct btrfs_ref ref = { 0 };
 
 			bytes_deleted += extent_num_bytes;
diff --git a/fs/btrfs/inode-item.h b/fs/btrfs/inode-item.h
index 771e264a2ede..0cb16cac07d1 100644
--- a/fs/btrfs/inode-item.h
+++ b/fs/btrfs/inode-item.h
@@ -27,6 +27,12 @@ struct btrfs_truncate_control {
 	 * removed only if their offset >= new_size.
 	 */
 	u32 min_type;
+
+	/*
+	 * IN: true if we don't want to do extent reference updates for any file
+	 * extents we drop.
+	 */
+	bool skip_ref_updates;
 };
 
 int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 04374a7346db..11b9b516af80 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4098,6 +4098,7 @@ static int truncate_inode_items(struct btrfs_trans_handle *trans,
 	struct btrfs_truncate_control control = {
 		.new_size = new_size,
 		.min_type = min_type,
+		.skip_ref_updates = true,
 	};
 	int ret;
 
-- 
2.26.3

