Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2EF1F6C82
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jun 2020 19:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgFKRBw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Jun 2020 13:01:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49980 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgFKRBw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Jun 2020 13:01:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05BGqVRN161854
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=ALQW+buH6Qi1BWHuVU0Y3L5hwXXs40wss7Q4euFkQDc=;
 b=Ne88RI35NRb21dq1J1T8PkZxIp0TLnzxFjjipshAa5hkjzUE881AC03Ni2aixx1CjewW
 pSOTyZUGc38VkNamhGEMvnsbeF4q6UbR1aPchpfF0BgQGIRMLt9nHyxYqVD8ZxAfdyF9
 0c0WkfPNc18csr+2i6iaFhdeAxOrrdRCsHkQy35T3hMG6pfxeuHvzQl6daH1u08esS6J
 t6Y+llD7RpLS+J5jPyPpKNZjYWp6+cjx212roPt2TRGwbW47iM7/EvvytHnvTvZDwpoP
 hYkyAC9Asj5UpTI9b+xTIZbaMrMbAUCteZSRVKrk72Cl0bw/IvaBta5uj7/nkjwy9VSd Wg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 31g3sn8w2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:01:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05BGsV7I112698
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:01:50 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 31gmwvqem5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:01:50 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05BH1nlD012606
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:01:49 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jun 2020 10:01:49 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 06/16] btrfs-progs: filesystem defragment: use global verbose option
Date:   Fri, 12 Jun 2020 00:56:53 +0800
Message-Id: <20200611165653.36352-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <6c3bc461-c8e7-2fe8-4ffe-a71b105cf671@oracle.com>
References: <6c3bc461-c8e7-2fe8-4ffe-a71b105cf671@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006110133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=1
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006110133
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Transpire global --verbose option down to the btrfs receive sub-command.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3: Space after HELPINFO_INSERT_VERBOSE, in the usage.
v2: Use new helper functions and defines
    HELPINFO_INSERT_GLOBALS, BTRFS_BCONF_UNSET, BTRFS_BCONF_QUIET
    bconf_be_verbose()

    No need to init bconf.verbose in the sub command.

    Move the HELPINFO_INSERT_GLOBALS, and HELPINFO_INSERT_VERBOSE, right
    after the command options.

 cmds/filesystem.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 936db672e329..a582fa0a5aac 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -840,6 +840,8 @@ static const char * const cmd_filesystem_defrag_usage[] = {
 	"-s start            defragment only from byte onward",
 	"-l len              defragment only up to len bytes",
 	"-t size             target extent size hint (default: 32M)",
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_VERBOSE,
 	"",
 	"Warning: most Linux kernels will break up the ref-links of COW data",
 	"(e.g., files copied with 'cp --reflink', snapshots) which may cause",
@@ -849,7 +851,6 @@ static const char * const cmd_filesystem_defrag_usage[] = {
 };
 
 static struct btrfs_ioctl_defrag_range_args defrag_global_range;
-static int defrag_global_verbose;
 static int defrag_global_errors;
 static int defrag_callback(const char *fpath, const struct stat *sb,
 		int typeflag, struct FTW *ftwbuf)
@@ -858,8 +859,7 @@ static int defrag_callback(const char *fpath, const struct stat *sb,
 	int fd = 0;
 
 	if ((typeflag == FTW_F) && S_ISREG(sb->st_mode)) {
-		if (defrag_global_verbose)
-			printf("%s\n", fpath);
+		pr_verbose(1, "%s\n", fpath);
 		fd = open(fpath, defrag_open_mode);
 		if (fd < 0) {
 			goto error;
@@ -914,7 +914,6 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 	thresh = SZ_32M;
 
 	defrag_global_errors = 0;
-	defrag_global_verbose = 0;
 	defrag_global_errors = 0;
 	optind = 0;
 	while(1) {
@@ -932,7 +931,7 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 			flush = 1;
 			break;
 		case 'v':
-			defrag_global_verbose = 1;
+			bconf_be_verbose();
 			break;
 		case 's':
 			start = parse_size(optarg);
@@ -1032,8 +1031,7 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
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

