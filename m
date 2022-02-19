Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA9B4BC907
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Feb 2022 16:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242431AbiBSPMO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 19 Feb 2022 10:12:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242424AbiBSPMM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 19 Feb 2022 10:12:12 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18ED286DA
        for <linux-btrfs@vger.kernel.org>; Sat, 19 Feb 2022 07:11:53 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id g1so4826843pfv.1
        for <linux-btrfs@vger.kernel.org>; Sat, 19 Feb 2022 07:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VeVgTMFPpU5QoE1sHmovPH22y3kb600X3aZ3c941Fa8=;
        b=E9p0Zc0DixIdSwl7Pv3XVUZOsjwQ00KTYjg3O0xCPUS3Xup2p/j3t1urGznwUfUEZ3
         bw1iTAMDbRYPCdt8SddfhTm1uDsylC6sbUhT5cHB9Ectt5dsnC3Ums82JBnSB8X2mgks
         RibedAvBL0pL/tbQWCbawMKTKXGITeyrERthtbKHAW58rWF3NMZpNL70bDIBcr0cltwi
         jY5OaGz5pt1EzV2QjmLIWfUjLwo5MXsRvfusOENoKvwMamMLvV+f+VOrsnPiiUIvKVGc
         x65g8yWlCqudqDN4hVP/EyosYkToWrD2QxZYsBXfzinAljfGhHQn6xCPnB8qX1IMYYtu
         SuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VeVgTMFPpU5QoE1sHmovPH22y3kb600X3aZ3c941Fa8=;
        b=Xm3LiuYpdZcZdFWEEXF21S+SXFDbzBq+jACxc8PKPwbTpRLDNigZXR1z5al0vfANtN
         RQt+XnDTgRT02w9CupK/ND9Auav6yggOjl6c3CQP8tHYZKoP0FcQ+Sztby6RU8G606/6
         P/QJkeb4FjAz7fgkz+B34IODwZN9NnkuUG8r8nB56D+4oPNbt89mu+5pQZIPUwbQC4vQ
         n9XPs2LWwf7IuhLK+vMPJclQHxxvY7jrB+LBfRXMv78bp5xbG/XHO/WqL0I75W7o8J5D
         woUO5CmEFMO/meKYlMaWCbt7Pujnt2QIRqS2ZnwhdJg0c8Tep9AluDcfLELArNoJzJvL
         ndIQ==
X-Gm-Message-State: AOAM531sKqL9JHuvtrTTRR2WM9H9Tjr6soa0nkbEvqdDUjaqET/6l7Lv
        JoL5H7aAxqAEYUwen7zqErM=
X-Google-Smtp-Source: ABdhPJzmSWPprJvs+cG9U++jHP85rLPKXNJrb4JRb7I10DabLZUMaZC3HBMD8Z8J7wnDPJHF0lJUNw==
X-Received: by 2002:a05:6a00:234a:b0:4e0:f776:876b with SMTP id j10-20020a056a00234a00b004e0f776876bmr12832873pfj.84.1645283513171;
        Sat, 19 Feb 2022 07:11:53 -0800 (PST)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id d16sm6849916pfj.1.2022.02.19.07.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 07:11:52 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v2] btrfs-progs: cmds: subvolume: add -p option on creating subvol
Date:   Sat, 19 Feb 2022 15:11:43 +0000
Message-Id: <20220219151143.52091-1-realwakka@gmail.com>
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
---
 Documentation/btrfs-subvolume.rst |  3 +++
 cmds/subvolume.c                  | 34 ++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/Documentation/btrfs-subvolume.rst b/Documentation/btrfs-subvolume.rst
index 4591d4bb..89809822 100644
--- a/Documentation/btrfs-subvolume.rst
+++ b/Documentation/btrfs-subvolume.rst
@@ -61,6 +61,9 @@ create [-i <qgroupid>] [<dest>/]<name>
                 Add the newly created subvolume to a qgroup. This option can be given multiple
                 times.
 
+        -p
+                Make any missing parent directories for each argument.
+
 delete [options] [<subvolume> [<subvolume>...]], delete -i|--subvolid <subvolid> <path>
         Delete the subvolume(s) from the filesystem.
 
diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index fbf56566..7df0d2ec 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -88,6 +88,7 @@ static const char * const cmd_subvol_create_usage[] = {
 	"",
 	"-i <qgroupid>  add the newly created subvolume to a qgroup. This",
 	"               option can be given multiple times.",
+	"-p             make any missing parent directories for each argument.",
 	HELPINFO_INSERT_GLOBALS,
 	HELPINFO_INSERT_QUIET,
 	NULL
@@ -105,10 +106,11 @@ static int cmd_subvol_create(const struct cmd_struct *cmd,
 	char	*dst;
 	struct btrfs_qgroup_inherit *inherit = NULL;
 	DIR	*dirstream = NULL;
+	bool create_parents = false;
 
 	optind = 0;
 	while (1) {
-		int c = getopt(argc, argv, "c:i:");
+		int c = getopt(argc, argv, "c:i:p");
 		if (c < 0)
 			break;
 
@@ -127,6 +129,9 @@ static int cmd_subvol_create(const struct cmd_struct *cmd,
 				goto out;
 			}
 			break;
+		case 'p':
+			create_parents = true;
+			break;
 		default:
 			usage_unknown_option(cmd, argv);
 		}
@@ -167,6 +172,33 @@ static int cmd_subvol_create(const struct cmd_struct *cmd,
 		goto out;
 	}
 
+	if (create_parents) {
+		char p[PATH_MAX] = {0};
+		char dstdir_dup[PATH_MAX];
+		char *token;
+
+		strcpy(dstdir_dup, dstdir);
+		if (dstdir_dup[0] == '/')
+			strcat(p, "/");
+
+		token = strtok(dstdir_dup, "/");
+		while(token) {
+			strcat(p, token);
+			res = path_is_dir(p);
+			if (res == -ENOENT) {
+				if (mkdir(p, 0755)) {
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

