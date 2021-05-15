Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078DE38152E
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 May 2021 04:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhEOChp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 May 2021 22:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbhEOChp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 May 2021 22:37:45 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74148C06174A
        for <linux-btrfs@vger.kernel.org>; Fri, 14 May 2021 19:36:33 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id e19so1055925pfv.3
        for <linux-btrfs@vger.kernel.org>; Fri, 14 May 2021 19:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jcv0zi5Pf/qaGQ1OJSpBMhV5oqBuYD0/cetftnG1DLA=;
        b=WGJJSXGPK88pyWTU8PytJteHA9XUmNXa8kDRVxFl0Nt9cWO5V9S1obiXZKlAotN85M
         wb7GFlv4vN2/7UYtwKhRijQwEY8RrsX5ARyx5Yk82r3zU8eHW0piFP25xyr4IVKclkzI
         19Zp1kxogZh7EeiuYhYlBqDHcOXPZUvZcvQJz1nqJGrXigVsCh9cayekNzcylSSuCIRs
         vMCWFz1oJkqt/v2IAgWIqr79qRwKYsEMC4rFltRc5/y7Qin1AnVIC34vkXpUaUyD1cg6
         mLCJMkvDtbJImKo1n/tHX6NrV1kZkDgkqaf0bKXfoD93v1FY/pRsqCIyLX/yw62zs/JC
         nG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jcv0zi5Pf/qaGQ1OJSpBMhV5oqBuYD0/cetftnG1DLA=;
        b=TuayZypKItS6PFDwHr46ZJh9r/oBYqg7JdQ9Ixu3K5rlwlnKvEFkQi+okfAy5ToQ3R
         MwoSNOvLeIFSqDHohfMgfKz3fP6/QRceLmc01EyEp0JRqNNnLifIH/Uxhsxv2TpDRsbq
         COigtntfoFSm7FHsaDF9uBPhumsfgUnUGVRYnBNGx2/ffrNybcDfk88QpTeDSv+5xFTw
         CfQZ8q2UuAy5nd12j5dCaC5YK/AzVvKijb7wXIkEuwQR59PdbVI07/K7e7RX4PRRPv6w
         lKZIEq0cfXbTeZ6z/ikhb5PMB+jzXBDpboqpqEraaSGzjWyzdV1bw1r+JwpfSPUDOLLK
         szMQ==
X-Gm-Message-State: AOAM5326j0c2XIuD/yXjc8Blb8zYEhIjrb4CrbE6QJyqQUNv/nh6VDUG
        0ZndgYfLwlD4K0rXpAOf+TIFvRiTK8L99A==
X-Google-Smtp-Source: ABdhPJySWPW2BpK5THh2jzIHwEIJQczZVPq4et1DLcDyEj9tluCWL7rZJN+NO1WVWxpAQ3nl1GO/pA==
X-Received: by 2002:a63:e407:: with SMTP id a7mr11430963pgi.220.1621046192624;
        Fri, 14 May 2021 19:36:32 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id i197sm4987862pgc.13.2021.05.14.19.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 19:36:32 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs-progs: subvolume: destroy associated qgroup when delete subvolume
Date:   Sat, 15 May 2021 02:36:24 +0000
Message-Id: <20210515023624.8065-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch adds the options --delete-qgroup and --no-delete-qgroup. When
the option is enabled, delete subvolume command destroies associated
qgroup together. This patch make it as default option. Even though quota
is disabled, it enables quota temporary and restore it after.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---

I wrote a patch that adds command to delete associated qgroup when
delete subvolume together. It also works when quota disabled. How it
works is enable quota temporary and restore it. I don't know it's good
way. Is there any better way than this?

 cmds/subvolume.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index 9bd17808..18c75083 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -239,6 +239,8 @@ static const char * const cmd_subvol_delete_usage[] = {
 	"-c|--commit-after      wait for transaction commit at the end of the operation",
 	"-C|--commit-each       wait for transaction commit after deleting each subvolume",
 	"-i|--subvolid          subvolume id of the to be removed subvolume",
+	"--delete-qgroup        delete associated qgroup together",
+	"--no-delete-qgroup     don't delete associated qgroup",
 	"-v|--verbose           deprecated, alias for global -v option",
 	HELPINFO_INSERT_GLOBALS,
 	HELPINFO_INSERT_VERBOSE,
@@ -266,14 +268,18 @@ static int cmd_subvol_delete(const struct cmd_struct *cmd,
 	enum { COMMIT_AFTER = 1, COMMIT_EACH = 2 };
 	enum btrfs_util_error err;
 	uint64_t default_subvol_id = 0, target_subvol_id = 0;
+	bool delete_qgroup = false;
 
 	optind = 0;
 	while (1) {
 		int c;
+		enum { GETOPT_VAL_DEL_QGROUP = 256, GETOPT_VAL_NO_DEL_QGROUP };
 		static const struct option long_options[] = {
 			{"commit-after", no_argument, NULL, 'c'},
 			{"commit-each", no_argument, NULL, 'C'},
 			{"subvolid", required_argument, NULL, 'i'},
+			{"delete-qgroup", no_argument, NULL, GETOPT_VAL_DEL_QGROUP},
+			{"no-delete-qgroup", no_argument, NULL, GETOPT_VAL_NO_DEL_QGROUP},
 			{"verbose", no_argument, NULL, 'v'},
 			{NULL, 0, NULL, 0}
 		};
@@ -295,6 +301,12 @@ static int cmd_subvol_delete(const struct cmd_struct *cmd,
 		case 'v':
 			bconf_be_verbose();
 			break;
+		case GETOPT_VAL_DEL_QGROUP:
+			delete_qgroup = true;
+			break;
+		case GETOPT_VAL_NO_DEL_QGROUP:
+			delete_qgroup = false;
+			break;
 		default:
 			usage_unknown_option(cmd, argv);
 		}
@@ -388,6 +400,44 @@ again:
 		goto out;
 	}
 
+	if (delete_qgroup) {
+		struct btrfs_ioctl_qgroup_create_args args;
+		memset(&args, 0, sizeof(args));
+		args.create = 0;
+		args.qgroupid = target_subvol_id;
+
+		if (ioctl(fd, BTRFS_IOC_QGROUP_CREATE, &args) < 0) {
+			if (errno == ENOTCONN) {
+				struct btrfs_ioctl_quota_ctl_args quota_ctl_args;
+				quota_ctl_args.cmd = BTRFS_QUOTA_CTL_ENABLE;
+				if (ioctl(fd, BTRFS_IOC_QUOTA_CTL, &quota_ctl_args) < 0) {
+					error("unable to enable quota: %s",
+						  strerror(errno));
+					goto out;
+				}
+
+				if (ioctl(fd, BTRFS_IOC_QGROUP_CREATE, &args) < 0) {
+					quota_ctl_args.cmd = BTRFS_QUOTA_CTL_DISABLE;
+					ioctl(fd, BTRFS_IOC_QUOTA_CTL, &args);
+					error("unable to destroy quota group: %s",
+						  strerror(errno));
+					goto out;
+				}
+
+				quota_ctl_args.cmd = BTRFS_QUOTA_CTL_DISABLE;
+				if (ioctl(fd, BTRFS_IOC_QUOTA_CTL, &args) < 0) {
+					error("unable to disable quota: %s",
+						  strerror(errno));
+					goto out;
+				}
+			} else {
+				error("unable to destroy quota group: %s",
+					  strerror(errno));
+				goto out;
+			}
+		}
+	}
+
 	pr_verbose(MUST_LOG, "Delete subvolume (%s): ",
 		commit_mode == COMMIT_EACH ||
 		(commit_mode == COMMIT_AFTER && cnt + 1 == argc) ?
@@ -412,6 +462,7 @@ again:
 		goto out;
 	}
 
+
 	if (commit_mode == COMMIT_EACH) {
 		res = wait_for_commit(fd);
 		if (res < 0) {
-- 
2.25.1

