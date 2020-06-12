Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76AEA1F78E1
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jun 2020 15:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgFLNq6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jun 2020 09:46:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35698 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgFLNq6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jun 2020 09:46:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CDkUYe169020;
        Fri, 12 Jun 2020 13:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=vA6HucPQX0eUXZuFcnZFj5l/HUyhDYg/znTH8xiZfqo=;
 b=0g1mOEdX29wlDvn9XO3bbsfHT4dwCiBTXnaWYQCakkzRZ81wfELiznsGizBFt0Pa4BDD
 mWGN8jori0XJVApb8wY8QdujpZlbxULd3eud9VgnlC3LsYBSVwHjnHHPQuEz2zX9f8yy
 Csjk6r8PeUONorungBTpHfe/V6tk/cuo6Mght8yDucNtmDknmQqH+P2wjgT8KvpNYw8j
 RL21S2g4b2hUvfRzOtccfCqtaTrzCQls47d+j3sKnTzvHNgHc6JZN1buZxvS+oyNms+X
 O1YDaypPjkIUkSN28DvGOFys73uKShTWY3TtjDG+OIdDR2yAcuJymTdzTAN4SwEQU6gq xg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 31g2jrn60d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 13:46:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CDebdi089950;
        Fri, 12 Jun 2020 13:44:53 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 31masr049h-135
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 13:44:53 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05CBPLF3025252;
        Fri, 12 Jun 2020 11:25:21 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Jun 2020 04:25:21 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH v4 06/16] btrfs-progs: filesystem defragment: use global verbose option
Date:   Fri, 12 Jun 2020 19:25:07 +0800
Message-Id: <20200612112507.3624-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1574678357-22222-7-git-send-email-anand.jain@oracle.com>
References: <1574678357-22222-7-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 suspectscore=1 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006120101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 spamscore=0 suspectscore=1
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006120102
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Transpire global --verbose option down to the btrfs receive sub-command.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v4: Update help and documentation
v3: Space after HELPINFO_INSERT_VERBOSE, in the usage.
v2: Use new helper functions and defines
    HELPINFO_INSERT_GLOBALS, BTRFS_BCONF_UNSET, BTRFS_BCONF_QUIET
    bconf_be_verbose()

    No need to init bconf.verbose in the sub command.

    Move the HELPINFO_INSERT_GLOBALS, and HELPINFO_INSERT_VERBOSE, right
    after the command options.

 Documentation/btrfs-filesystem.asciidoc |  3 ++-
 cmds/filesystem.c                       | 15 +++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/btrfs-filesystem.asciidoc b/Documentation/btrfs-filesystem.asciidoc
index 151b7889d8a5..ad8717a70949 100644
--- a/Documentation/btrfs-filesystem.asciidoc
+++ b/Documentation/btrfs-filesystem.asciidoc
@@ -111,7 +111,8 @@ KiB, MiB, GiB, TiB, PiB, or EiB, respectively (case does not matter).
 `Options`
 +
 -v::::
-be verbose, print file names as they're submitted for defragmentation
+be verbose, print file names as they're submitted for defragmentation. This
+option is merged to the global verbose option.
 -c[<algo>]::::
 compress file contents while defragmenting. Optional argument selects the compression
 algorithm, 'zlib' (default), 'lzo' or 'zstd'. Currently it's not possible to select no
diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 936db672e329..d4ffc000e59b 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -833,13 +833,16 @@ static const char * const cmd_filesystem_defrag_usage[] = {
 	"btrfs filesystem defragment [options] <file>|<dir> [<file>|<dir>...]",
 	"Defragment a file or a directory",
 	"",
-	"-v                  be verbose",
+	"-v                  be verbose. This option is merged to the global",
+	"                    verbose option.",
 	"-r                  defragment files recursively",
 	"-c[zlib,lzo,zstd]   compress the file while defragmenting",
 	"-f                  flush data to disk immediately after defragmenting",
 	"-s start            defragment only from byte onward",
 	"-l len              defragment only up to len bytes",
 	"-t size             target extent size hint (default: 32M)",
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_VERBOSE,
 	"",
 	"Warning: most Linux kernels will break up the ref-links of COW data",
 	"(e.g., files copied with 'cp --reflink', snapshots) which may cause",
@@ -849,7 +852,6 @@ static const char * const cmd_filesystem_defrag_usage[] = {
 };
 
 static struct btrfs_ioctl_defrag_range_args defrag_global_range;
-static int defrag_global_verbose;
 static int defrag_global_errors;
 static int defrag_callback(const char *fpath, const struct stat *sb,
 		int typeflag, struct FTW *ftwbuf)
@@ -858,8 +860,7 @@ static int defrag_callback(const char *fpath, const struct stat *sb,
 	int fd = 0;
 
 	if ((typeflag == FTW_F) && S_ISREG(sb->st_mode)) {
-		if (defrag_global_verbose)
-			printf("%s\n", fpath);
+		pr_verbose(1, "%s\n", fpath);
 		fd = open(fpath, defrag_open_mode);
 		if (fd < 0) {
 			goto error;
@@ -914,7 +915,6 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 	thresh = SZ_32M;
 
 	defrag_global_errors = 0;
-	defrag_global_verbose = 0;
 	defrag_global_errors = 0;
 	optind = 0;
 	while(1) {
@@ -932,7 +932,7 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 			flush = 1;
 			break;
 		case 'v':
-			defrag_global_verbose = 1;
+			bconf_be_verbose();
 			break;
 		case 's':
 			start = parse_size(optarg);
@@ -1032,8 +1032,7 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 			/* errors are handled in the callback */
 			ret = 0;
 		} else {
-			if (defrag_global_verbose)
-				printf("%s\n", argv[i]);
+			pr_verbose(1, "%s\n", argv[i]);
 			ret = ioctl(fd, BTRFS_IOC_DEFRAG_RANGE,
 					&defrag_global_range);
 			defrag_err = errno;
-- 
2.25.1

