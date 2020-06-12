Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A17C1F78D6
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jun 2020 15:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgFLNo5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jun 2020 09:44:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58620 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgFLNo5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jun 2020 09:44:57 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CDe0nh013606;
        Fri, 12 Jun 2020 13:44:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=tdHF5qjPu8ixC2L5Y4s2IV4XxBAR/Z1wO7OXpurzY9A=;
 b=u3uJTZDaq/BJUSZa2gI2zOu0E6R/mcuOcoUbSphoUvC7gf8G0/kkx7abr7aljeqlHR2t
 LT1+n7uh20VjzEq86ITuq2vClUs72eKsUHY2bLu3vCCAexHNyVLPNKDMZK2dUbtnWokQ
 TGO0ms039BBOeW+kF/kBYt+wTnNDySd8iDdR1b3Ub6cywQrZcahA/57NGiEVfrV8uYeh
 jf/MtRop4+mhTF1SCu3U28ayQXwcLunk84sHAzJCNBkq5YZjNE6QYPIwt+wsvEtszASR
 BaGrziISy0zl+Wft7x8DoHj6esefH9VxetmxI/U97aXHOpHCoavNLJYivuO3dQ38eoR8 BA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 31g3snd0xa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 13:44:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CDebdj089950;
        Fri, 12 Jun 2020 13:44:53 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 31masr054g-122
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 13:44:53 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05CBP4Ml025178;
        Fri, 12 Jun 2020 11:25:04 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Jun 2020 04:25:03 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH v3 05/16] btrfs-progs: subvolume delete: use global verbose option
Date:   Fri, 12 Jun 2020 19:24:56 +0800
Message-Id: <20200612112456.3568-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1574678357-22222-6-git-send-email-anand.jain@oracle.com>
References: <1574678357-22222-6-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 suspectscore=1 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006120101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=1
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006120101
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Transpire global --verbose option down to the btrfs subvolume delete
sub-command.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
V3: Update the help and documentation
v2: Use new helper functions and defines
    HELPINFO_INSERT_GLOBALS, BTRFS_BCONF_UNSET, BTRFS_BCONF_QUIET
    bconf_be_verbose(), bconf_be_quiet()

 Documentation/btrfs-subvolume.asciidoc |  3 ++-
 cmds/subvolume.c                       | 31 +++++++++++++-------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/btrfs-subvolume.asciidoc b/Documentation/btrfs-subvolume.asciidoc
index d8c414fd5c60..47f0cc471297 100644
--- a/Documentation/btrfs-subvolume.asciidoc
+++ b/Documentation/btrfs-subvolume.asciidoc
@@ -87,7 +87,8 @@ wait for transaction commit at the end of the operation.
 wait for transaction commit after deleting each subvolume.
 +
 -v|--verbose::::
-verbose output of operations.
+verbose output of operations. This option is merged to the global verbose
+option.
 +
 -i|--subvolid <subvolid>::::
 subvolume id to be removed instead of the <path> that should point to the
diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index 6f1d90358785..b1606fbd398c 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -236,7 +236,10 @@ static const char * const cmd_subvol_delete_usage[] = {
 	"-c|--commit-after      wait for transaction commit at the end of the operation",
 	"-C|--commit-each       wait for transaction commit after deleting each subvolume",
 	"-i|--subvolid          subvolume id of the to be removed subvolume",
-	"-v|--verbose           verbose output of operations",
+	"-v|--verbose           verbose output of operations. This option is",
+	"                       merged to the global verbose option.",
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_VERBOSE,
 	NULL
 };
 
@@ -251,7 +254,6 @@ static int cmd_subvol_delete(const struct cmd_struct *cmd,
 	char	*dupvname = NULL;
 	char	*path = NULL;
 	DIR	*dirstream = NULL;
-	int verbose = 0;
 	int commit_mode = 0;
 	u8 fsid[BTRFS_FSID_SIZE];
 	u64 subvolid = 0;
@@ -287,7 +289,7 @@ static int cmd_subvol_delete(const struct cmd_struct *cmd,
 			subvolid = arg_strtou64(optarg);
 			break;
 		case 'v':
-			verbose++;
+			bconf_be_verbose();
 			break;
 		default:
 			usage_unknown_option(cmd, argv);
@@ -301,11 +303,9 @@ static int cmd_subvol_delete(const struct cmd_struct *cmd,
 	if (subvolid > 0 && check_argc_exact(argc - optind, 1))
 		return 1;
 
-	if (verbose > 0) {
-		printf("Transaction commit: %s\n",
-			!commit_mode ? "none (default)" :
-			commit_mode == COMMIT_AFTER ? "at the end" : "after each");
-	}
+	pr_verbose(1, "Transaction commit: %s\n",
+		   !commit_mode ? "none (default)" :
+		   commit_mode == COMMIT_AFTER ? "at the end" : "after each");
 
 	cnt = optind;
 
@@ -395,11 +395,9 @@ again:
 		}
 
 		if (add_seen_fsid(fsid, seen_fsid_hash, fd, dirstream) == 0) {
-			if (verbose > 0) {
-				uuid_unparse(fsid, uuidbuf);
-				printf("  new fs is found for '%s', fsid: %s\n",
-						path, uuidbuf);
-			}
+			uuid_unparse(fsid, uuidbuf);
+			pr_verbose(1, "  new fs is found for '%s', fsid: %s\n",
+				   path, uuidbuf);
 			/*
 			 * This is the first time a subvolume on this
 			 * filesystem is deleted, keep fd in order to issue
@@ -440,10 +438,11 @@ keep_fd:
 			"unable to do final sync after deletion: %m, fsid: %s",
 						uuidbuf);
 					ret = 1;
-				} else if (verbose > 0) {
+				} else {
 					uuid_unparse(seen->fsid, uuidbuf);
-					printf("final sync is done for fsid: %s\n",
-						uuidbuf);
+					pr_verbose(1,
+					   "final sync is done for fsid: %s\n",
+						   uuidbuf);
 				}
 				seen = seen->next;
 			}
-- 
2.25.1

