Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F634CD508
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Mar 2022 14:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbiCDNTR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Mar 2022 08:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiCDNTQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Mar 2022 08:19:16 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA4622BEE
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Mar 2022 05:18:29 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id m22so7364614pja.0
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Mar 2022 05:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xfgqt4W9u38RH785DMxeI2jUthWv6zOix3OhZqCWOgg=;
        b=g2nnNNE1yeEr3t/nHtuKQtE84rgMgt2YUkdRa4JJ3HpuPfLp6wrwZJN4oPSOhf1ETu
         Rm7u1GZ0twF5rkXRaT9GE6RO9AED7xNoHfBsNUMU59Hz74Lle9/OL2GANycm/UZuMCBg
         2PZHyc7qsvUgbhaePT0i4SJ7IOQE4USnOLFMXvF7DDuo34mRBWx6NLc/z+rL3aAYN0nP
         oIDBGyLPjmfup3x5+1YvUokPMZmX+eJ52B+GMi40e2Ch3M4EbI8oIFYGvUfkrSHjmM0s
         96F+2qgvW2jY03tmO6wYz79gU4mRl3bvGvJhcM+463s20f0UYq1U73+O3kQoGCX5oazq
         /slw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xfgqt4W9u38RH785DMxeI2jUthWv6zOix3OhZqCWOgg=;
        b=0V39jQywoBKT7N8BXYdT4fJVs2caSA2N35dpwsVwe66Pm+DYD8MjLFjysB7u/MmylQ
         8Qcxk4eyFPtDU1Hn5UYhKpG1dxR1im0U7YToVXKfB64PcVSKeItmnZSSYecdil6beHNx
         oYlMqSttHBVCMNcuSnT75UNHRTQMvC3EVTYsY4L0w87aae00OoZUVmEKYEEaPz6z9Rs6
         pqG9Bdl/JMZWWpYodT1nHC9ArQnsdg2uzPL+jfR1Nb+HrpXeu/R8hOGc8gPtR3ss2oVz
         5XxL2c/JY54/b4cGNqy3k49GPL4Xl/ChTm1jzDEfWEE09/myXug3GK11cfjl55o1AXLB
         ZyBQ==
X-Gm-Message-State: AOAM532H2qqtiMDrDaWD2600LDmXWvQ+6zhQ2Jun6bb1YV2I6ltgJ+Pe
        skQQzC0tK9Do1d8uNnIPsE4=
X-Google-Smtp-Source: ABdhPJw4ED2h/4fhnAZ9m5Tf8NgQcXCtewciWeEknPlAdajBniVtSx04eYT1BGqz1S0PeeyJgc3fJw==
X-Received: by 2002:a17:90a:af88:b0:1bd:6b5d:4251 with SMTP id w8-20020a17090aaf8800b001bd6b5d4251mr10475519pjq.134.1646399908810;
        Fri, 04 Mar 2022 05:18:28 -0800 (PST)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id 142-20020a621894000000b004dfc714b076sm6308981pfy.11.2022.03.04.05.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 05:18:28 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     Graham Cobb <g.btrfs@cobb.uk.net>,
        Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v4] btrfs-progs: cmds: subvolume: add -p option on creating subvol
Date:   Fri,  4 Mar 2022 13:18:20 +0000
Message-Id: <20220304131820.14022-1-realwakka@gmail.com>
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

This patch resolves github issue #429. Add an option that create parent
directories when it creates subvolumes on nonexisting parents. This
option tokenizes dstdir and checks each paths whether it's existing
directory and make directory for creating subvolume.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
v2: fixed the case using realpath() that path nonexists, added
description on docs.
v3: added longopt, used strncpy_null than strcpy, use perm 0777
v4: removed trailing whitespace, fix doc and comment.
---
 Documentation/btrfs-subvolume.rst |  5 +++-
 cmds/subvolume.c                  | 43 +++++++++++++++++++++++++++++--
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/Documentation/btrfs-subvolume.rst b/Documentation/btrfs-subvolume.rst
index 4591d4bb..ef9aa1cc 100644
--- a/Documentation/btrfs-subvolume.rst
+++ b/Documentation/btrfs-subvolume.rst
@@ -49,7 +49,7 @@ do not affect the files in the original subvolume.
 SUBCOMMAND
 -----------
 
-create [-i <qgroupid>] [<dest>/]<name>
+create [-i <qgroupid>] [-p|--parents] [<dest>/]<name>
         Create a subvolume *name* in *dest*.
 
         If *dest* is not given, subvolume *name* will be created in the current
@@ -61,6 +61,9 @@ create [-i <qgroupid>] [<dest>/]<name>
                 Add the newly created subvolume to a qgroup. This option can be given multiple
                 times.
 
+        -p|--parents
+                Make any missing parent directories for each argument.
+
 delete [options] [<subvolume> [<subvolume>...]], delete -i|--subvolid <subvolid> <path>
         Delete the subvolume(s) from the filesystem.
 
diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index fbf56566..d2a7ba33 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -81,13 +81,14 @@ static const char * const subvolume_cmd_group_usage[] = {
 };
 
 static const char * const cmd_subvol_create_usage[] = {
-	"btrfs subvolume create [-i <qgroupid>] [<dest>/]<name>",
+	"btrfs subvolume create [-i <qgroupid>] [-p|--parents] [<dest>/]<name>",
 	"Create a subvolume",
 	"Create a subvolume <name> in <dest>.  If <dest> is not given",
 	"subvolume <name> will be created in the current directory.",
 	"",
 	"-i <qgroupid>  add the newly created subvolume to a qgroup. This",
 	"               option can be given multiple times.",
+	"-p|--parents   make any missing parent directories for each argument.",
 	HELPINFO_INSERT_GLOBALS,
 	HELPINFO_INSERT_QUIET,
 	NULL
@@ -105,10 +106,18 @@ static int cmd_subvol_create(const struct cmd_struct *cmd,
 	char	*dst;
 	struct btrfs_qgroup_inherit *inherit = NULL;
 	DIR	*dirstream = NULL;
+	bool create_parents = false;
 
 	optind = 0;
 	while (1) {
-		int c = getopt(argc, argv, "c:i:");
+		int c;
+		static const struct option long_options[] = {
+			{NULL, required_argument, NULL, 'i'},
+			{"parents", no_argument, NULL, 'p'},
+			{NULL, 0, NULL, 0}
+		};
+
+		c = getopt_long(argc, argv, "i:p", long_options, NULL);
 		if (c < 0)
 			break;
 
@@ -127,6 +136,9 @@ static int cmd_subvol_create(const struct cmd_struct *cmd,
 				goto out;
 			}
 			break;
+		case 'p':
+			create_parents = true;
+			break;
 		default:
 			usage_unknown_option(cmd, argv);
 		}
@@ -167,6 +179,33 @@ static int cmd_subvol_create(const struct cmd_struct *cmd,
 		goto out;
 	}
 
+	if (create_parents) {
+		char p[PATH_MAX] = {0};
+		char dstdir_dup[PATH_MAX];
+		char *token;
+
+		strncpy_null(dstdir_dup, dstdir);
+		if (dstdir_dup[0] == '/')
+			strcat(p, "/");
+
+		token = strtok(dstdir_dup, "/");
+		while(token) {
+			strcat(p, token);
+			res = path_is_dir(p);
+			if (res == -ENOENT) {
+				if (mkdir(p, 0777)) {
+					error("failed to make dir: %s", p);
+					goto out;
+				}
+			} else if (res <= 0) {
+				error("failed to check dir: %s", p);
+				goto out;
+			}
+			strcat(p, "/");
+			token = strtok(NULL, "/");
+		}
+	}
+
 	fddst = btrfs_open_dir(dstdir, &dirstream, 1);
 	if (fddst < 0)
 		goto out;
-- 
2.25.1

