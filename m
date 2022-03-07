Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8044D0AB3
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbiCGWOX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbiCGWOV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:14:21 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4003A55747
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:13:26 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id jo29so932045qvb.5
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nAxyEtqUx9AatXAsU5NRO16MfP85Skg5FAOwzsPxfNw=;
        b=0ARNCQegwq3HT59MixjzNIJwa8mrWrKBK4XkfBsJjpUZ9Ij0UUzI8CqJyc/SzIn41H
         eM4EXkJ1xL/U7bu7VPNLTQJsC+TNMxGXom5w9C8kUTTy9zjQ7Q6rnaUcYK2gVmpujYzv
         kuEmQourhVIl8SlfvzpniyH4HMMA9hMtpvqmQHmM3HLJo8QIO1Y2U05hXRmNM5E87Bqt
         vaYlcyccpAta59Q7qjvuc5ag1xH8OmO4MGLK3gkJG1ovsEFlHSym+dzEqdRJGhWhIqHX
         8Pszrhs+RUsKGcSPXJJySVaBTME2os9CpVHFtmGN3hCw4gR7oDODkzO11eAIxsey7Fop
         l3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nAxyEtqUx9AatXAsU5NRO16MfP85Skg5FAOwzsPxfNw=;
        b=fdOuHfXOkZQaFA5V1Z1Od+GBORgPIEvresr2qGWIlORFAPD+RbrKFJbHc7WVFgy1K5
         wgSJpwlgTrjKMfxed5Q6slPXeNwD7H3Qbl0GLFIxrMbusjBPIaib+xQGamvO1Y11D591
         TZbmSjn/LNu4Mh4KsWsUd8CS3FVzrh2VpfQjrMp0KXZcsMN5lx/zV0AofA6GZ31YLOF8
         5qXkbc6fLL348hx54NbrqjJnhV15hEpZgk+G5srEl8qDGWhyxnINmgyJopHVIvI0eYMJ
         OgHp8s5rRnUs21n5tvitwE0NaTllF0kNJjcO4dzE4vPgd4EexTf7vlmYLEJys5nk67mL
         c3DQ==
X-Gm-Message-State: AOAM532eHriXtHLuy9adLBLs/VFmEZfcX6rCVN6YQmIr8jmMRXZuRMDP
        5C1w0GrpO6Z3kF2ofDsisJ49DX7Df1ilM5YT
X-Google-Smtp-Source: ABdhPJwgnxViw4Nju6NmIKVgaHMWBj+VmqO8zEjmR5h4gB4GyNHHopG36j7vlP9y3D731YGoPmfUew==
X-Received: by 2002:ad4:4eac:0:b0:435:8fab:76e2 with SMTP id ed12-20020ad44eac000000b004358fab76e2mr5106335qvb.51.1646691205187;
        Mon, 07 Mar 2022 14:13:25 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d18-20020ac85d92000000b002d98bca0656sm9412905qtx.30.2022.03.07.14.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:13:24 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 02/15] btrfs-progs: check: skip owner ref check for extent tree v2
Date:   Mon,  7 Mar 2022 17:13:07 -0500
Message-Id: <1992861d08edbccd65045d83f35989606b1e8c42.1646691128.git.josef@toxicpanda.com>
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

We do not track extent references for metadata in extent tree v2, simply
skip this check if it is enabled.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/check/main.c b/check/main.c
index 6bedd648..2ab68248 100644
--- a/check/main.c
+++ b/check/main.c
@@ -4099,6 +4099,13 @@ static int check_owner_ref(struct btrfs_root *root,
 	int found = 0;
 	int ret;
 
+	/*
+	 * We don't have extent references for metadata with extent tree v2,
+	 * just return.
+	 */
+	if (btrfs_fs_incompat(gfs_info, EXTENT_TREE_V2))
+		return 0;
+
 	rbtree_postorder_for_each_entry_safe(node, tmp,
 					     &rec->backref_tree, node) {
 		if (node->is_data)
-- 
2.26.3

