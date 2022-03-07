Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7E04D0AAE
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237427AbiCGWOW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235109AbiCGWOV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:14:21 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BD2554A8
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:13:24 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id s16so5024134qks.4
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wybfjwVqtA42w8Zf0pI3YzZS5YE9FZ8SLtQ9kBUCnC8=;
        b=C0BRzqrvbhVcUK9wc1hHb09IYxdw0EbN/xEcQzlHDGOqK17/qPixn3ofNF7sHIEM9I
         BBGcxvsBP/Dcgwkn34WEfMzV2IX+QLaNfrd/ECZOdqm8KqTI6jIeiguK35lljXswYHEP
         iwVjuJi70RSO17JsXrgY2oGBLJsTCcbRlOikDoFkjdJWJZqyZeD2rXfNrjEmeq0lhc1S
         2iM0U22G3PXVZM06ATlHrXrzcofwGg5RmLihQc6mVfbS6B7mBNFS0pYbWk8yfCHYRtSc
         AwlOHTOJlwOfRr+RaDo1Rnltmy97xzLaiFnjw4z4T80u0hBUnIljBQlvxOVTHoSGGtX5
         FApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wybfjwVqtA42w8Zf0pI3YzZS5YE9FZ8SLtQ9kBUCnC8=;
        b=W3QXQnrWh75WkdimwjxyAEDLWBz5rNhVWLYWXyOJ077I3T2DhiklQ0ELDaQZlpljWr
         lIJg5mHaXBpvuIqjHCWAUjnDsc6jGydMN1pxRfEFtXRzxcOp+mq5GGYfp6KCuhUnaa+q
         r8+7KFEKNdhhFvTxOhlzOPZqnsSy24hndRyrxjOcA4xIe/451o2fVafRWifMB4H9PzbK
         bn7997JJmZ0Aslk3xNh1q+GDf5faXzdHVfVNOMx5tgUxV9Knp+2VSR18J3euKdV5JEm0
         o9IgJI44ezA7yaCaH52xuttOAXTpscc/wYSeUNNPQhX9G0IQ/gjhoNUp++BBXd4SlJ1d
         BakA==
X-Gm-Message-State: AOAM530fR8AYRg5hnH+1TB9i+mLyStHvDazz3CgovBJo0Lr3N+rqGs2E
        Bd47WQ6g10RpKrmk7+cLQZ0vl0BjZ7b+kGfy
X-Google-Smtp-Source: ABdhPJyOvVAv78QANgh+w3SI8jw84v7arfp639H+gAedcqi0yleYDa8e5BXWdM+pSluSyUQ1cdErYg==
X-Received: by 2002:a05:620a:4724:b0:67a:ec28:ff14 with SMTP id bs36-20020a05620a472400b0067aec28ff14mr8182965qkb.344.1646691203846;
        Mon, 07 Mar 2022 14:13:23 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l126-20020a37bb84000000b0067b3c2bcc0dsm1207096qkf.1.2022.03.07.14.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:13:23 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 01/15] btrfs-progs: extract out free extent accounting handling
Date:   Mon,  7 Mar 2022 17:13:06 -0500
Message-Id: <da791db5a0a60a928e71f4c569598c9ee1e2d417.1646691128.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646691128.git.josef@toxicpanda.com>
References: <cover.1646691128.git.josef@toxicpanda.com>
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

__free_extent() currently handles the modification of the tree, but also
the accounting and cleaning up when we free the extent properly.
Extract the accounting portion out into it's own helper so it can be
used in the future.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/extent-tree.c | 45 +++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 697a8a1e..0db0f32d 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -1905,6 +1905,30 @@ void btrfs_unpin_extent(struct btrfs_fs_info *fs_info,
 	update_pinned_extents(fs_info, bytenr, num_bytes, 0);
 }
 
+static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
+				     u64 bytenr, u64 num_bytes, bool is_data)
+{
+	int ret, mark_free = 0;
+
+	ret = pin_down_bytes(trans, bytenr, num_bytes, is_data);
+	if (ret > 0)
+		mark_free = 1;
+	else if (ret < 0)
+		return ret;
+
+	if (is_data) {
+		ret = btrfs_del_csums(trans, bytenr, num_bytes);
+		if (ret)
+			return ret;
+	}
+
+	ret = add_to_free_space_tree(trans, bytenr, num_bytes);
+	if (ret)
+		return ret;
+	update_block_group(trans, bytenr, num_bytes, 0, mark_free);
+	return ret;
+}
+
 /*
  * remove an extent from the root, returns 0 on success
  */
@@ -2075,8 +2099,6 @@ static int __free_extent(struct btrfs_trans_handle *trans,
 			BUG_ON(ret);
 		}
 	} else {
-		int mark_free = 0;
-
 		if (found_extent) {
 			BUG_ON(is_data && refs_to_drop !=
 			       extent_data_ref_count(path, iref));
@@ -2089,28 +2111,13 @@ static int __free_extent(struct btrfs_trans_handle *trans,
 			}
 		}
 
-		ret = pin_down_bytes(trans, bytenr, num_bytes,
-				     is_data);
-		if (ret > 0)
-			mark_free = 1;
-		BUG_ON(ret < 0);
-
 		ret = btrfs_del_items(trans, extent_root, path, path->slots[0],
 				      num_to_del);
 		BUG_ON(ret);
 		btrfs_release_path(path);
 
-		if (is_data) {
-			ret = btrfs_del_csums(trans, bytenr, num_bytes);
-			BUG_ON(ret);
-		}
-
-		ret = add_to_free_space_tree(trans, bytenr, num_bytes);
-		if (ret) {
-			goto fail;
-		}
-
-		update_block_group(trans, bytenr, num_bytes, 0, mark_free);
+		ret = do_free_extent_accounting(trans, bytenr, num_bytes, is_data);
+		BUG_ON(ret);
 	}
 fail:
 	btrfs_free_path(path);
-- 
2.26.3

