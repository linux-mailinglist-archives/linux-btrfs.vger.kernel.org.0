Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1534D0AA6
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343598AbiCGWMb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiCGWM2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:12:28 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5F48BF7F
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:11:34 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id bt3so14634239qtb.0
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=h46j3rjvPE0fuROOG8cfROxMNnBp54E0Vj9iGpjB7q4=;
        b=H78XcYPcMtDYofhyi89gOsA6A3NPiEF734BLIbYbhVINzdMHOoSZ0+ZII4GGac0/Yz
         U++r4jcJOME6ymCez6KeXy/ESPV7NtbOQNLW0Vb2KzXAJTAZfFNCFv8eTgz7KqhDoSMO
         1DuZ6PHv6waH+OQAzdrXiZ8HkfQ9AZNgwHEc1t6GKBGOhb7rH0T59QA024S/HnpN+5z7
         WQ4qW72uRC9XxCLdSP22YmheHsxaNsMyK7FuAPFGyZdbkfLbov1blCy4ijlwduSc64+I
         bWrnmp+sTwy4ouwE+7c1USyIYywKuRRiNF1DT1C9TB4VIYjTT/V93MJ+FIuP4QJGHyxr
         wIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h46j3rjvPE0fuROOG8cfROxMNnBp54E0Vj9iGpjB7q4=;
        b=rb0fcQ3lHR/3w38kpSXJR/4dEDlZykfYqgerUQm+KDwhKxewxBRsSu1WBg5sskfDZb
         o1Ynt27W/6hyyuLP6oL3siZdwhyfFkNK/cSIBn5nZhi558+xvrqL+YzlXq6PV3lDSS83
         2OqCt92rY6lr/wRAFZQHiPNchg7SwG17OAlibzqWgODfwVkIk60ZIGvzecFi/bvcRLzA
         Pk7JnEuDpT0kAjv1dKjijoSP0+yYuVtpgRx33MnCV0j6k0emEazkWLknKw1giph1JbY6
         Lr4gyutzZM112HiMAwPrtxRbxUm0Hgsxc2Ze7riG7ftU6QyY+wXc0grLrxupkuIQ83Q2
         IZnw==
X-Gm-Message-State: AOAM5335dBv9WMLxOIiSmJJCG8U39pkQOSt/h+e3UMLqWnGfERWtTe/O
        7BnROWq/SJxCJRiIsTrhD8rz0/l/E6Rct7Me
X-Google-Smtp-Source: ABdhPJyTO79Yum0k2r1fbGH1Q79ypIgSHvrJkA09o8WL1v192YaLznntREmeeWod3GqMFAM8iI3CYA==
X-Received: by 2002:a05:622a:49:b0:2de:4d52:5e76 with SMTP id y9-20020a05622a004900b002de4d525e76mr10923976qtw.633.1646691093010;
        Mon, 07 Mar 2022 14:11:33 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l6-20020ac87246000000b002dcec453e42sm8451921qtp.32.2022.03.07.14.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:11:32 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 19/19] btrfs-progs: check: don't do the root item check for extent tree v2
Date:   Mon,  7 Mar 2022 17:11:04 -0500
Message-Id: <75119c04f067e16f5090f5636145f55dc689ba0a.1646690972.git.josef@toxicpanda.com>
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

With the current set of changes we could probably do this check, but it
would involve changing the code quite a bit, and in the future we're not
going to track the metadata in the extent tree at all.  Since this check
was for a very old kernel just skip it for extent tree v2.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/check/main.c b/check/main.c
index 45065989..6bedd648 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9860,6 +9860,9 @@ static int repair_root_items(void)
 	int bad_roots = 0;
 	int need_trans = 0;
 
+	if (btrfs_fs_incompat(gfs_info, EXTENT_TREE_V2))
+		return 0;
+
 	btrfs_init_path(&path);
 
 	ret = build_roots_info_cache();
-- 
2.26.3

