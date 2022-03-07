Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7374D0AD9
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343721AbiCGWTE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343707AbiCGWTC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:19:02 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EAC41307
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:18:07 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id s15so14595465qtk.10
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0jXv4MAhBCBwO6ojsljHmTk+DusoavBOE9LdRe0z6CQ=;
        b=xsyDcFwQ0XqVvSlBvO/EA4igVlg0hgMGYcaayFT+ZxqZS567dobsZaehq0vuTBUbeu
         iA9fCznP1fHQEI4GlrguwVnFZwYi1neUB2cFvMbkY30T39vTTiA2uJ+JLulDUZSM4cMy
         MMyfAuQlosEDVjLVgjDj1ZMd2yeoNO7Ws7Qrq9488sZ7JBFLG5D8pUxrIcZLKujLH3z9
         h4trQUZc+YZ9gc6zSHibNX3HKHMAnpzzzjoArb+EDxnTKB83MvxAitjy49i5ubdXK+LQ
         7KLnViJscUxtAdME2BYoEsJ1+u1xFrj/Qt0IU4WEGtIPNByieDPZocHEqA46NZLL0QvT
         tS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0jXv4MAhBCBwO6ojsljHmTk+DusoavBOE9LdRe0z6CQ=;
        b=Kv+9XaSbrbMeDX4K0Kf0sTgb2W+ZBU6NT8BJVdLN3IHCGcPxK3DUnmW1rEI5q874YN
         9auHg+gitIUgLb6ncoDaM8ZScGAcP/gxrMYbfjhWhm1oPyZwqqnnxV2D8y3zNzsqGzjf
         7MDbQTMdvf6jH6kaUQzqRYxizAWHFqDCIHi+BLTyygAJn0MfYut90lPx5NoZnLSonPHD
         piWe3Vlxkk3zf+ZQrosak18wjxr4UzgwNSIq1NyqQv2El/hhoBmuw2QNbdmECdGdBGa1
         ZLWcrNMVj+vDgrkmsLBtZdCIAX7LBRZlQKE/i4mYh3X9EIitMnF0pIrjbpkKXIhI5tR5
         4VZw==
X-Gm-Message-State: AOAM533yoM8TSVz6OkJNugOCY8I1a0SYuX+pP7nQNqI/pFLMEzbx3bmi
        KYKqbXMTEgUM/Deldy5mEerOVGH29JpgCtlW
X-Google-Smtp-Source: ABdhPJzSKjCUTmXd7SLDfE514nmy7mQCKapu7+7SZSOBApVZkTgToPzJkuaCNTBzfcoGej8zlw81hA==
X-Received: by 2002:ac8:7c4e:0:b0:2de:79c2:55c1 with SMTP id o14-20020ac87c4e000000b002de79c255c1mr11192323qtv.405.1646691486174;
        Mon, 07 Mar 2022 14:18:06 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x6-20020a376306000000b0067b32a8568esm1440190qkb.101.2022.03.07.14.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:18:05 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/15] btrfs-progs: add new roots to the dirty root list
Date:   Mon,  7 Mar 2022 17:17:45 -0500
Message-Id: <fb6d6a9051cfb8e98c28e08ad2c5956cfebffc7d.1646691255.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646691255.git.josef@toxicpanda.com>
References: <cover.1646691255.git.josef@toxicpanda.com>
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

We have a few places that create new roots and then add the root to the
dirty list.  Since any root we create we need to make sure ends up on
the tree_root we can simply add this step to btrfs_create_tree().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/disk-io.c         | 2 ++
 kernel-shared/free-space-tree.c | 1 -
 mkfs/main.c                     | 1 -
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 3d99e7dd..078ab0fb 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -2485,6 +2485,8 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto fail;
 
+	add_root_to_dirty_list(root);
+
 	return root;
 
 fail:
diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-tree.c
index 03eb0ed2..ec2f7915 100644
--- a/kernel-shared/free-space-tree.c
+++ b/kernel-shared/free-space-tree.c
@@ -1494,7 +1494,6 @@ int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info)
 	ret = btrfs_global_root_insert(fs_info, free_space_root);
 	if (ret)
 		goto abort;
-	add_root_to_dirty_list(free_space_root);
 
 	do {
 		block_group = btrfs_lookup_first_block_group(fs_info, start);
diff --git a/mkfs/main.c b/mkfs/main.c
index 995b0223..7bdbe64d 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -798,7 +798,6 @@ static int create_uuid_tree(struct btrfs_trans_handle *trans)
 		goto out;
 	}
 
-	add_root_to_dirty_list(root);
 	fs_info->uuid_root = root;
 	ret = btrfs_uuid_tree_add(trans, fs_info->fs_root->root_item.uuid,
 				  BTRFS_UUID_KEY_SUBVOL,
-- 
2.26.3

