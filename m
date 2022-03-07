Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF73C4D0A94
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242939AbiCGWMJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242390AbiCGWMJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:12:09 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D55F75C29
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:11:14 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id eq14so7267239qvb.3
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zzGoFbPaHjYxOdEvMNYA2KUeGYoOWZmWRW9btUenLJA=;
        b=zly32dmB6/sExS4Kh0tV/7t/BAcbKTTdvnoZQF3Pto8yd6ydF/QE5qIiGRW/jdbbSr
         q4VHqdIZDjEMzD/v0pQcs5OpUugZnwkh9ZLQBE4Dm5LPt57Kz1JnCEq5M3+b7TVznxhZ
         40ZUwnIvMp/pTjTsLyprDWUn1+g5cQKTr9I2kAs2F5HO95o8MycLc12umC8an8onAY5t
         u2WvkBCYFf/792BfmtyRRFt0C3qMYssZTfwjPEBAtUrCxt6PJwhpw38eyOIiuAIH3uVR
         3ub0wrpu6XEZy8Vt0Zi3ImiVrDxignVFZ6c/Xnhm3k2QWND6o5I3vzW91amfSaRBu56w
         l77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zzGoFbPaHjYxOdEvMNYA2KUeGYoOWZmWRW9btUenLJA=;
        b=ZVDTqCNewEE/9UMhKirAj2hy/fwjYzzxAHHezhYgJSDeuRj40PiAPUeKIh7u/QhSdp
         +UYEVhFYiiDxGni5aWEaP17QgqzF3cTHvG+gK36eXWLmsNJd/DRbvPlO+OUFCyiAskqz
         M3cPvU8dc6VkTVdtfHbxK5KMIGwmxd1hlZOpEWfYnw0Kg3MLxDNhqK6bY8V/kc+Qm8hr
         qmot/7o3zqAYyCy/0kn4HF9zhVzuH9tnC84uEID0YZNV11dLQqsEL9yZQ0k/kyiyD0Ot
         kAnYQZfDVmR9lPxFpioUYgRCyltvykfyJCuMjRByTRefZqCV8fus0jbI+WTPp0Y8RIrx
         UO6g==
X-Gm-Message-State: AOAM5317THGKsAM1KwtPBesrCgWBcdrQoe4Oo35A3JUOlqc/Scxp4aoy
        vxPJoh5pFtmkyw9QflCfGcPQquWijNWSkFKd
X-Google-Smtp-Source: ABdhPJwdybtaE1RNAZd6cp1XcAiMeXUNCDlTlz/56coSyGXGC4psNVpY0ILhYuKoL7pxfjGrH8q3sQ==
X-Received: by 2002:ad4:596b:0:b0:434:ea08:d2ee with SMTP id eq11-20020ad4596b000000b00434ea08d2eemr10148038qvb.24.1646691073110;
        Mon, 07 Mar 2022 14:11:13 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u13-20020a05622a14cd00b002d5e213eb93sm9122178qtx.14.2022.03.07.14.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:11:12 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 05/19] btrfs-progs: handle no bg item in extent tree for free space tree
Date:   Mon,  7 Mar 2022 17:10:50 -0500
Message-Id: <29f7e7eee16caf0cd4295436ec8a96bed29fb264.1646690972.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646690972.git.josef@toxicpanda.com>
References: <cover.1646690972.git.josef@toxicpanda.com>
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

We have an ASSERT(ret == 0) when populating the free space tree as we
should at least find the block group item with extent tree v1.  However
with v2 we no longer have the block group item in the extent tree, so
fix the population logic to handle an empty block group (which occurs
during mkfs) and only assert if ret != 0 and we don't have extent tree
v2 turned on.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/free-space-tree.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-tree.c
index 0fdf5004..896bd3a2 100644
--- a/kernel-shared/free-space-tree.c
+++ b/kernel-shared/free-space-tree.c
@@ -1057,6 +1057,9 @@ int populate_free_space_tree(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto out;
 
+	start = block_group->start;
+	end = block_group->start + block_group->length;
+
 	/*
 	 * Iterate through all of the extent and metadata items in this block
 	 * group, adding the free space between them and the free space at the
@@ -1071,10 +1074,11 @@ int populate_free_space_tree(struct btrfs_trans_handle *trans,
 	ret = btrfs_search_slot_for_read(extent_root, &key, path, 1, 0);
 	if (ret < 0)
 		goto out;
-	ASSERT(ret == 0);
+	if (ret > 0) {
+		ASSERT(btrfs_fs_incompat(trans->fs_info, EXTENT_TREE_V2));
+		goto done;
+	}
 
-	start = block_group->start;
-	end = block_group->start + block_group->length;
 	while (1) {
 		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
 
@@ -1106,6 +1110,7 @@ int populate_free_space_tree(struct btrfs_trans_handle *trans,
 		if (ret)
 			break;
 	}
+done:
 	if (start < end) {
 		ret = __add_to_free_space_tree(trans, block_group, path2,
 				start, end - start);
-- 
2.26.3

