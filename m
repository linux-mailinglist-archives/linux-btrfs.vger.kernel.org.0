Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E654BCBD4
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Feb 2022 04:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiBTDNb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 19 Feb 2022 22:13:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiBTDNa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 19 Feb 2022 22:13:30 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46F3369C8
        for <linux-btrfs@vger.kernel.org>; Sat, 19 Feb 2022 19:13:09 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id g1so5687874pfv.1
        for <linux-btrfs@vger.kernel.org>; Sat, 19 Feb 2022 19:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A7lIpf9QEP2LE74i1e4EkiT1u6SI3D1RMx1XMbhcF3M=;
        b=T4+h6JTQbhymhLAZgCKMQQjAw8+a6EFWxdRoLTy6Ie+7uqypBoaJLOsqG4VFa571Sq
         P20YrYaLiNswWutMmqN069cKeEy2KepAGMMeIvyya9tjp/A6MZyWL3Ob+ugRqZhwCDVd
         V31CGGX5Kv5yK7p8Dt9TtPpGr+Q1JY46LWoZvMpnNwVaFSTll9GbsGAmG0WCX4Ji3B/l
         Ur//1iJc5BB9jq0vAAPA9Ckp8q2OOzpebWEaEG7LorRASVr6F6jLRADCpSGH/5oT27HV
         dqGQk5lBQDy6fd46FdkE44LMpGi8uLfpQB5PiIoyIDJ41ttopQ/Gr0x8Oaq4ag75XNIK
         yGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A7lIpf9QEP2LE74i1e4EkiT1u6SI3D1RMx1XMbhcF3M=;
        b=3JWsAsAIlT850i/bvVxXSqiHZq5khkkPazwboyzcYWvLNa/2BPfYGA02826CUxmStv
         x4XXpdI5MgyZ4tcG0I/vcSxHsIvgLpJCmbfgOfekmM2cEhAF61309LjS/wDu2F/LF/zl
         Bapg4UiMcFUZ5SH6LhxGkYvZgt81DZKsrb0kQ1bdjrmy8x8glRyV8upl0POlfEoHOClo
         kukVqw4EulPZ60ckAkbgdfngJZBdnNWguDkrbi4xQ58c2oqAcwdqxEXaNf9TRtdSS6AT
         nTsi55AQtC5BV6FoSX7qoa54dBa0U6AYO1Dyf5UHFjUwFpEwAAui3oJHgzTXOyVIBtLO
         gHIg==
X-Gm-Message-State: AOAM532UibieeHdHosQbN+/bTspfaHhWeWX01hmaLxLE8/WwpKeVwNYa
        xujWVRqEb85jxYSN9xs61Gg=
X-Google-Smtp-Source: ABdhPJzeaZIfjKVaDYmNioE2wbT9v5R6gVtOJqOBcVKKbpV0RrY+WLXiC17XSoRdazJBGNtyTV5kQg==
X-Received: by 2002:a63:cf52:0:b0:36c:8e67:45c9 with SMTP id b18-20020a63cf52000000b0036c8e6745c9mr11570878pgj.542.1645326789091;
        Sat, 19 Feb 2022 19:13:09 -0800 (PST)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id q93-20020a17090a4fe600b001b9ba2a1dc3sm3299037pjh.25.2022.02.19.19.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 19:13:08 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     Graham Cobb <g.btrfs@cobb.uk.net>,
        Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v3] btrfs-progs: cmds: subvolume: add -p option on creating subvol
Date:   Sun, 20 Feb 2022 03:12:54 +0000
Message-Id: <20220220031254.58297-1-realwakka@gmail.com>
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

This patch resolves github issue #429. This patch adds an option that
create parent directories when it creates subvolumes on nonexisting
parents. This option tokenizes dstdir and checks each paths whether
it's existing directory and make directory for creating subvolume.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
v2: fixed the case using realpath() that path nonexists, added
description on docs.
v3: added longopt, used strncpy_null than strcpy, use perm 0777
---
 Documentation/btrfs-subvolume.rst |  5 +++-
 cmds/subvolume.c                  | 41 ++++++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/Documentation/btrfs-subvolume.rst b/Documentation/btrfs-subvolume.rst
index 4591d4bb..2c138154 100644
--- a/Documentation/btrfs-subvolume.rst
+++ b/Documentation/btrfs-subvolume.rst
@@ -49,7 +49,7 @@ do not affect the files in the original subvolume.
 SUBCOMMAND
 -----------
 
-create [-i <qgroupid>] [<dest>/]<name>
+create [options] [<dest>/]<name>
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
index fbf56566..9c13839e 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -88,6 +88,7 @@ static const char * const cmd_subvol_create_usage[] = {
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

