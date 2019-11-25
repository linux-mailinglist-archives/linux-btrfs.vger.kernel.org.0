Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7BE108BE5
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 11:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfKYKjz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 05:39:55 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48362 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbfKYKjy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 05:39:54 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAY98P006501
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=rlOenJOgolsqiDQP4s0131sVFBxxllbW+cuhHHmQHAk=;
 b=S5XCzjjX+9Eo9NbYHkzmCud5WOWQ/zbt03+xBf1N/7o1ab2kYVmY+YoKqEFRXUdtgT9Z
 XXmrDElcoMQG5kl24VOW9TXuG/Y6nE9s08ebSjdJqvpopNmmqSSQ+W5ZsfbX/l0RipZP
 rPRbutUJhWyI8nM0Oeh0q5NltozAeNPm31Amoq5Dr5SywWqboG0/v0wFz/eYoJUtj708
 x3DJf1M8fvMdEoUkDL7bBV592ErWAG4wnTVNAcGSadWBblaRdYRyzSb4nMhaYg3d7ed7
 wWtA/cpdzSfbdPk8uyLF66VjcOEVvc52TYaGkSM/47pMr+3DZclo7DvC5UtG9E9jDxbu Yg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2wewdqxnpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAY3M8090734
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:52 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2wfe7yr6c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:52 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAPAdp8u001786
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:51 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Nov 2019 02:39:49 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 13/16] btrfs-progs: inspect-internal logical-resolve: use global verbose option
Date:   Mon, 25 Nov 2019 18:39:14 +0800
Message-Id: <1574678357-22222-14-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
References: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9451 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911250098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9451 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911250098
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Transpire global --verbose option down to the
btrfs inspect-internal logical-resolve sub-command.

Command btrfs inspect-internal logical-resolve provides local verbose
option this patch makes it enable-able by using the global --verbose
option.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Use new helper function bconf_be_verbose()

 cmds/inspect.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/cmds/inspect.c b/cmds/inspect.c
index de4d163991a5..8baa7aa4604a 100644
--- a/cmds/inspect.c
+++ b/cmds/inspect.c
@@ -38,7 +38,7 @@ static const char * const inspect_cmd_group_usage[] = {
 	NULL
 };
 
-static int __ino_to_path_fd(u64 inum, int fd, int verbose, const char *prepend)
+static int __ino_to_path_fd(u64 inum, int fd, const char *prepend)
 {
 	int ret;
 	int i;
@@ -117,8 +117,7 @@ static int cmd_inspect_inode_resolve(const struct cmd_struct *cmd,
 	if (fd < 0)
 		return 1;
 
-	ret = __ino_to_path_fd(arg_strtou64(argv[optind]), fd,
-			       bconf.verbose, argv[optind+1]);
+	ret = __ino_to_path_fd(arg_strtou64(argv[optind]), fd, argv[optind+1]);
 	close_file_or_dir(fd, dirstream);
 	return !!ret;
 
@@ -134,6 +133,8 @@ static const char * const cmd_inspect_logical_resolve_usage[] = {
 	"-s bufsize  set inode container's size. This is used to increase inode",
 	"            container's size in case it is not enough to read all the ",
 	"            resolved results. The max value one can set is 64k",
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_VERBOSE,
 	NULL
 };
 
@@ -143,7 +144,6 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 	int ret;
 	int fd;
 	int i;
-	int verbose = 0;
 	int getpath = 1;
 	int bytes_left;
 	struct btrfs_ioctl_logical_ino_args loi;
@@ -164,7 +164,7 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 			getpath = 0;
 			break;
 		case 'v':
-			verbose = 1;
+			bconf_be_verbose();
 			break;
 		case 's':
 			size = arg_strtou64(optarg);
@@ -199,13 +199,11 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 		goto out;
 	}
 
-	if (verbose)
-		printf("ioctl ret=%d, total_size=%llu, bytes_left=%lu, "
-			"bytes_missing=%lu, cnt=%d, missed=%d\n",
-			ret, size,
-			(unsigned long)inodes->bytes_left,
-			(unsigned long)inodes->bytes_missing,
-			inodes->elem_cnt, inodes->elem_missed);
+	pr_verbose(1,
+"ioctl ret=%d, total_size=%llu, bytes_left=%lu, bytes_missing=%lu, cnt=%d, missed=%d\n",
+		   ret, size, (unsigned long)inodes->bytes_left,
+		   (unsigned long)inodes->bytes_missing, inodes->elem_cnt,
+		   inodes->elem_missed);
 
 	bytes_left = sizeof(full_path);
 	ret = snprintf(full_path, bytes_left, "%s/", argv[optind+1]);
@@ -250,8 +248,7 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 					goto out;
 				}
 			}
-			ret = __ino_to_path_fd(inum, path_fd, verbose,
-						full_path);
+			ret = __ino_to_path_fd(inum, path_fd, full_path);
 			if (path_fd != fd)
 				close_file_or_dir(path_fd, dirs);
 		} else {
-- 
1.8.3.1

