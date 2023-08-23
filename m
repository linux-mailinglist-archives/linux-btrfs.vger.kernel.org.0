Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2C6785A75
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbjHWO16 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbjHWO15 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:27:57 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D2AE57
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:27:56 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-58df8cab1f2so60397117b3.3
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692800875; x=1693405675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IoFN3W7lDqZnofeAylvKtCc5G5mnsjUfSVACRAr/Fk0=;
        b=lLgLooNRTHGAieDccBfjJnv3s+OAlRIC3bTxHU7r3uV7br+ozN7g9A+iHDTBL/8wAQ
         hSViKEuy0yAIcRolakXJdOVjTvDl5U6pn7SKiMxOWmBXbPRxyQXjlTRK4tTov5mkZnJE
         R+nxssKZm9rzhpb6kFaLAHJ9751FWUhETugYe8yTUlN2jSnaulBkMp1Jea7kzQmpURB/
         V1K5v4ItamwtGNJjOzu43hQOh22V48xUjToOQYXNLzPNhNUQHfF/TWUbWZQZ66J9IcZ5
         I8gaXjlJwUn/WneXD3XjrCaDgKKeVZLTRZNluMbdJqR/dmXZJvLlCrubXfz+5rLVXM1n
         gDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692800875; x=1693405675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IoFN3W7lDqZnofeAylvKtCc5G5mnsjUfSVACRAr/Fk0=;
        b=MX8qXi08rIy8ZC+hC8ZkcV3DLEpciAlIDocab960Bg45WCCSwSPDp5VXhabfdvyOeN
         JMe0Pf35UhGMnoJyIZYoA+X+a69kmO/m9UeaWWvMcOHfVesduvXCntMVeByCdtixGstq
         bTJ/7bAZbhY5C8J9ohxz9QWN22WvvZQPhLuhLIb/m/+q0+sbb1xAkfojM0AmGzj8Siti
         J3WWguGswDJg+Rnr/53nWSW/jgGSfA36o4Mrg6rlthLTMpvGX3NBljf4cTzdVxx607O/
         RSF0wjL5PHlUIUoaT7ji8D1bWF8t4f+xr7aSlofhV7w+uEY6SLBDcNodpyLZP5s03h3Z
         JQuw==
X-Gm-Message-State: AOJu0Yzt5grmrEJm6sEONXJETsAfHq4AMB4hl1+fOcKfhYQOdkYNk2WE
        dij5iq10TM/Vtk8tNqVRlqCDbyDyaTgSBkxaiNQ=
X-Google-Smtp-Source: AGHT+IGKuqRiFGHZ44qt9Quzjmhi2jmHwifQNbJNRzx/ZaGb8DLXxSECiFRqq3dfRwIRFjoRUXNeCA==
X-Received: by 2002:a0d:c045:0:b0:589:8b55:fe09 with SMTP id b66-20020a0dc045000000b005898b55fe09mr12234345ywd.50.1692800875367;
        Wed, 23 Aug 2023 07:27:55 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id v17-20020a814811000000b00583b40d907esm3374908ywa.16.2023.08.23.07.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:27:55 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/3] btrfs-progs: take a ref in the root locking code
Date:   Wed, 23 Aug 2023 10:27:48 -0400
Message-ID: <d5f7aa7b21a238ddbbe4196d9c5707846550728f.1692800798.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692800798.git.josef@toxicpanda.com>
References: <cover.1692800798.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This code in the kernel not only returns the locked root, but also takes
a reference on the node.  This is important for when we sync ctree.c
into btrfs-progs, it expects that references are held on the root node
after calling these helpers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/locking.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel-shared/locking.c b/kernel-shared/locking.c
index a41ce06b..bd24571e 100644
--- a/kernel-shared/locking.c
+++ b/kernel-shared/locking.c
@@ -5,15 +5,18 @@
 
 struct extent_buffer *btrfs_read_lock_root_node(struct btrfs_root *root)
 {
+	root->node->refs++;
 	return root->node;
 }
 
 struct extent_buffer *btrfs_try_read_lock_root_node(struct btrfs_root *root)
 {
+	root->node->refs++;
 	return root->node;
 }
 
 struct extent_buffer *btrfs_lock_root_node(struct btrfs_root *root)
 {
+	root->node->refs++;
 	return root->node;
 }
-- 
2.41.0

