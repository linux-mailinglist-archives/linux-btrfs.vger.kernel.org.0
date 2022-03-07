Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748774D0AE4
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343727AbiCGWTI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343732AbiCGWTG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:19:06 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D37B4831C
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:18:11 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id b12so13263696qvk.1
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=79Mp749A9qYx20cjtwc8vFDMYd4fGXSpEKSXlgmf0iA=;
        b=79iPbDz1SjstgpHR1bTpT/tbkNAgl7v9tgOHr/lk/t3YudA1lHU7teccu7Q16zxXdd
         YkIBsEnKLoOKpaalGcG4+h77HTMrwIusrzqKtprzxGcjBGfRzOYf3tnIBiVQSSLs7+dO
         fS751fbH5dqfqPs7zRle8nhgCuppb+vRg6LuHaBQdzxcban6KtjaHs7uNMKlq5CUPxG0
         AI2OerqkikPWmG7+PVmE5dyF9ZQuVBNgjn2iOU6F6A08YAXyfEmtNTsIYm8tUaZOxywu
         /jfDaGlINvBlDrhLfo8U9kQcH1pZ8F04978WRAfOrp9DJYjMg6ix8E6SYhorM0sgRoxo
         6ujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=79Mp749A9qYx20cjtwc8vFDMYd4fGXSpEKSXlgmf0iA=;
        b=p4ywZLHtnSzJ44HOsqDGf+nBwKNcrbgk87Jr+k7qyQJS9a3niwL50rmrsBhiC0RZv2
         p+muaLPAOmgupi2QBDYHRI+wnGVOR58mRY0wgJDyiPh4jULcfjLclUUewTCRXXvWfGdP
         P+JIg06Sp9u2VTFQ6TTc7Nrl2DAvK1JILIqDPKM0rqNpAmStqsBfIeO3ucG+Wi185nbX
         xzmcjxOQOsAvuDhIp3X3UKzHewyxgHKNMVe4fe02/0cH5e0nCMgsHHIyb2YVScoYtj9s
         2YhSSgNZVnaRezPZdMx42XCx6sp25JPYuy+X4YtL6vmqFWHq0V/tylJARaGaYb0JLkk+
         b9bw==
X-Gm-Message-State: AOAM533ehUA620Z9ktyw7IJ18n3OaPetWbsw570g1lG86z70GtZrAR+Y
        8S661k4a69UQIy7UH45vCN1/p7TKUvbuFVKA
X-Google-Smtp-Source: ABdhPJxYPKBxiX8Gyb9jNA+J22dGUHH83Ww0Dahvzh0ijf9ZWh70GevemGTBR0+TOnwkFfpSx27R5Q==
X-Received: by 2002:a05:6214:2a4a:b0:435:8e79:83a9 with SMTP id jf10-20020a0562142a4a00b004358e7983a9mr5380123qvb.43.1646691490271;
        Mon, 07 Mar 2022 14:18:10 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w140-20020a376292000000b00648e88c1f05sm6965235qkb.67.2022.03.07.14.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:18:09 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 14/15] btrfs-progs: inherit the root snapshot id in the buffer
Date:   Mon,  7 Mar 2022 17:17:48 -0500
Message-Id: <5dbb563209f4e6f8800b7f8b7d08a91673eb43a3.1646691255.git.josef@toxicpanda.com>
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

Every extent buffer a root points to will inherit the current snapshot
id of the root.  This will allow us to easily tie which extent buffers
are shared with which roots.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/extent-tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 8f8617b3..e836c809 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -2590,7 +2590,8 @@ struct extent_buffer *btrfs_alloc_free_block(struct btrfs_trans_handle *trans,
 	trans->blocks_used++;
 	if (btrfs_fs_incompat(root->fs_info, EXTENT_TREE_V2)) {
 		memset_extent_buffer(buf, 0, 0, sizeof(struct btrfs_header_v2));
-		btrfs_set_header_snapshot_id(buf, 0);
+		btrfs_set_header_snapshot_id(buf,
+				btrfs_root_snapshot_id(&root->root_item));
 		btrfs_set_header_flag(buf, BTRFS_HEADER_FLAG_V2);
 	} else {
 		memset_extent_buffer(buf, 0, 0, sizeof(struct btrfs_header));
-- 
2.26.3

