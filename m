Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC0C4D3195
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 16:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbiCIPRd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 10:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbiCIPRc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 10:17:32 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABEB177D0E
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 07:16:34 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id z3so2191894plg.8
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 07:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uHnCCYVununoqWq1NgVSqAxyr9ZpY1MOmEM0AmkKq4A=;
        b=k7w2RNv+ekV0F6i7WfxO87pZT91jbrN5BOSGGtQDSrmenX+0GJO5AsDKr24llN3Msr
         BUYeXJXLkb6Vg58Aq9Cxu0j0u1vjwm1m3B1on7jfHoAynh+NayQeWlj0+3VlEcG7Tquz
         oU/3+Z7Cf+j3cZaPABZtedEOz3YkiVYqLwVAmVrnu0j1VqRX6BWdppZBa/GZgl7EEZIj
         OOG2MCnfTWfsO4KphPjSWHejvT5he1j3pPLMq5ZkgpUjCsDxS6whBrYxfH69Pi0icAS6
         Xsg4n+NAj3uD9hwkh5FI/aKVk/0dlwCw4NhAe5R0R7iWx08R6OtTH5QKQNboqF6UcOYx
         z/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uHnCCYVununoqWq1NgVSqAxyr9ZpY1MOmEM0AmkKq4A=;
        b=lj8IvxzFM2qs/BuaBs82/R2v5PzrjaHUz9WAQ+lJ++Ho1rqjjVwuwmsuLSaEchulyO
         odUKyp23pqUfk+p9kvUPuAYaXMnKFZXcz8HPfpLSEZQysjua88yLANHJ2/eBw6MoCF8i
         jy16RGT2YvbYRnp9jHieCLPRjgYiGPsku5g7cxQaet5vGFdRvfdVas3P4uSzBcOwbDik
         3lkolydeeWEPVcb4d87FG8pjgzYGBiDoZzNDgacTEeP0kNVCjj/gf9oB7sbNE5cZ3x/o
         frfyFT1DqWuQSZZfx/q/C/6Qe865evRcg9izmHLf6y9T1viJMZ6kFapjxi2aSMBZjbCL
         AoDA==
X-Gm-Message-State: AOAM533PEnk+KYnoL4xkXyqEHNV+U+JcWYA8lIIPoY66+c6IPbmRyWqE
        m/HMCasvVzEcNJ2aeUrTuys=
X-Google-Smtp-Source: ABdhPJzHhJb+wHPnEvuBZBejOBWHE4MDDh/J2rSdt9C0DN/2bef4yxkjKM40zEYqx7J/5qFNFT+g4g==
X-Received: by 2002:a17:90a:a78c:b0:1b8:b769:62d0 with SMTP id f12-20020a17090aa78c00b001b8b76962d0mr10826613pjq.227.1646838993836;
        Wed, 09 Mar 2022 07:16:33 -0800 (PST)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id s2-20020a056a001c4200b004f41e1196fasm3192640pfw.17.2022.03.09.07.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 07:16:33 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v2 1/2] btrfs-progs: subvolme: remove unused options for create and snapshot
Date:   Wed,  9 Mar 2022 15:16:06 +0000
Message-Id: <20220309151607.48650-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are options '-c' in create subvolume and '-c' and '-x' in
snapshot. And the codes about them is there, but not in the manual or
help. These options allow us to directly copy qgroup numbers from other
subvolumes when creating subvolume. This codes should be removed to
avoid confusion.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
v2: add more explanation for removing options in changelog
---
 cmds/subvolume.c | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index fbf56566..408aebee 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -108,18 +108,11 @@ static int cmd_subvol_create(const struct cmd_struct *cmd,
 
 	optind = 0;
 	while (1) {
-		int c = getopt(argc, argv, "c:i:");
+		int c = getopt(argc, argv, "i:");
 		if (c < 0)
 			break;
 
 		switch (c) {
-		case 'c':
-			res = btrfs_qgroup_inherit_add_copy(&inherit, optarg, 0);
-			if (res) {
-				retval = res;
-				goto out;
-			}
-			break;
 		case 'i':
 			res = btrfs_qgroup_inherit_add_group(&inherit, optarg);
 			if (res) {
@@ -541,18 +534,11 @@ static int cmd_subvol_snapshot(const struct cmd_struct *cmd,
 	memset(&args, 0, sizeof(args));
 	optind = 0;
 	while (1) {
-		int c = getopt(argc, argv, "c:i:r");
+		int c = getopt(argc, argv, "i:r");
 		if (c < 0)
 			break;
 
 		switch (c) {
-		case 'c':
-			res = btrfs_qgroup_inherit_add_copy(&inherit, optarg, 0);
-			if (res) {
-				retval = res;
-				goto out;
-			}
-			break;
 		case 'i':
 			res = btrfs_qgroup_inherit_add_group(&inherit, optarg);
 			if (res) {
@@ -563,13 +549,6 @@ static int cmd_subvol_snapshot(const struct cmd_struct *cmd,
 		case 'r':
 			readonly = 1;
 			break;
-		case 'x':
-			res = btrfs_qgroup_inherit_add_copy(&inherit, optarg, 1);
-			if (res) {
-				retval = res;
-				goto out;
-			}
-			break;
 		default:
 			usage_unknown_option(cmd, argv);
 		}
-- 
2.25.1

