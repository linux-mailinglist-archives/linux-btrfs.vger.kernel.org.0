Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FD14D2A64
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 09:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiCIIPr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 03:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiCIIPp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 03:15:45 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020BF151C70
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 00:14:46 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id o26so1333809pgb.8
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 00:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rd6T4d5SGxII4Us5S1+Di17j3z+mqPD1B8l6ZWtBA9c=;
        b=UX2Cg1KkGhSeEP4BdSfvK2ErfjhFcm06oVOUrzeHgmMIR6KRliEJBz8KvoGgHIMb7N
         VfLX2QjOJdNOF2qZN+ZexZA/uubY62vazx/CyxS0d8gJywtDsY6EqP6gLm7NC/KT46Bp
         nI46bQVkIl3GBkGnq2px2HY2koTnPtDcEEQBVlmswc8/DXFPv3wLp+tiKAMzZvsCBHJ7
         v5lMNlKJJEdtkdg85KH9XkCUZvOayUpZLlGtdr/8w+G6h+U6kI8/t9mkbIXTaTpWaPeO
         e4cXsTh03CJV8DtbbjDQzPJCNiaiQKoxc8x3d0m7BfTx0YePyJClFu9hTJrEyqu7B8JX
         fAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rd6T4d5SGxII4Us5S1+Di17j3z+mqPD1B8l6ZWtBA9c=;
        b=NtumGrOmO1krWNsDJAkRQR9tsl0ZfKkkJeZUAaIU6yU3KaCepKEUL2j4zEMbO2xQVa
         FDQCWsws1NWAv32wadTUon0qJURT14PjTVfA+fb/uyAbLEtQ57mrvsyxiQvBhRcecYTT
         zshSWnvRhLw2/cW5xtPyXN3KiAO5UUw13f4Rbsn+rN7ThAdiRzxJa+gNjw+QMwNZIi7o
         sJaYf7G6TurHbgkjmRZDfTkjzC0m42e48LVnMmP7+wjYYaCUH3co8J/ipg3TihhBGIuZ
         IqPLd57HwigS/4ZLyxuZrBX1ZmohjPGcWWklw3HX1OhS13q7Gqm8g7SZdDJSN+BC6aev
         tDow==
X-Gm-Message-State: AOAM530tJDSYa+6+y82FOG395/iuO1Z9OFp7kTV5Dj0XMTsGFfUj0tLm
        aWHzfTtWActa9FbuCeNtY8McQlRt1Po=
X-Google-Smtp-Source: ABdhPJy6SBjK8Vfdt/UUI+bZAPyU42XmVakotCcOG8iirPxsJ4871mQvKSjKI/QvYtdo6Yl4Opo1aA==
X-Received: by 2002:a63:8ac8:0:b0:37f:fcfb:6886 with SMTP id y191-20020a638ac8000000b0037ffcfb6886mr16176875pgd.466.1646813685244;
        Wed, 09 Mar 2022 00:14:45 -0800 (PST)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id t9-20020a056a0021c900b004f72e3838aasm1716275pfj.183.2022.03.09.00.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 00:14:44 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH 1/2] btrfs-progs: subvolme: remove unused options for create and snapshot
Date:   Wed,  9 Mar 2022 08:14:17 +0000
Message-Id: <20220309081418.46215-1-realwakka@gmail.com>
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
help. This codes should be removed to avoid confusion.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
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

