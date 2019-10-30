Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E60AAE9858
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 09:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfJ3Ily (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 04:41:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60902 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfJ3Ilx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 04:41:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8cc0x054001;
        Wed, 30 Oct 2019 08:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=T2JUL7xMsrLuSxzN0oovlXLyL4Wwn7wa6s/xhbG6cr0=;
 b=WZOwD2Sgb8o2N/60W7SOePEGkunaBCMI5wcS+aWfKVD6fuwLbDoGsjMWZ+5ClHgtmCWM
 LOEqXontpCRuSw4QtjmxM1s+Xot9socRrA0ANNV7h9fZsQNY4eHmarTYtjitzX9dDtVm
 1kQdmNFLIfneaDqAecMBuwaFarfryj+rxCa/oMzT0WTsW4cCLjy4rrnVkwhGd/OZqMs0
 8eBcHuxRZXtW5uvfyBZEERa284k/K31bOv6h/Tk9VHZ4tv+4zu0wIloU3/idATkIYIRI
 VQfI5LVVNLYbzsjRLg6pvRdl4pS6zyPHH2x2xXe07Xdbabmn5V8/jZoViX5d2hIzytxC kw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2vxwhfje47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:41:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8crDX071047;
        Wed, 30 Oct 2019 08:41:52 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2vxwj8uuee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:41:51 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9U8fpYA018725;
        Wed, 30 Oct 2019 08:41:51 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 01:41:50 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH v1 14/18] btrfs-progs: inspect-internal inode-resolve: use global verbose
Date:   Wed, 30 Oct 2019 16:41:18 +0800
Message-Id: <20191030084122.29745-15-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191030084122.29745-1-anand.jain@oracle.com>
References: <20191030084122.29745-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910300086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910300086
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Transpire global --verbose option down to the
btrfs inspect-internal inode-resolve sub-command.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/inspect.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/cmds/inspect.c b/cmds/inspect.c
index 758b6e60c591..f36fee395159 100644
--- a/cmds/inspect.c
+++ b/cmds/inspect.c
@@ -56,12 +56,11 @@ static int __ino_to_path_fd(u64 inum, int fd, int verbose, const char *prepend)
 		goto out;
 	}
 
-	if (verbose)
-		printf("ioctl ret=%d, bytes_left=%lu, bytes_missing=%lu, "
-			"cnt=%d, missed=%d\n", ret,
-			(unsigned long)fspath->bytes_left,
-			(unsigned long)fspath->bytes_missing,
-			fspath->elem_cnt, fspath->elem_missed);
+	pr_verbose(1,
+	"ioctl ret=%d, bytes_left=%lu, bytes_missing=%lu cnt=%d, missed=%d\n",
+		   ret, (unsigned long)fspath->bytes_left,
+		   (unsigned long)fspath->bytes_missing, fspath->elem_cnt,
+		   fspath->elem_missed);
 
 	for (i = 0; i < fspath->elem_cnt; ++i) {
 		u64 ptr;
@@ -84,6 +83,8 @@ static const char * const cmd_inspect_inode_resolve_usage[] = {
 	"Get file system paths for the given inode",
 	"",
 	"-v   verbose mode",
+	HELPINFO_GLOBAL_OPTIONS_HEADER,
+	HELPINFO_INSERT_VERBOSE,
 	NULL
 };
 
@@ -91,10 +92,13 @@ static int cmd_inspect_inode_resolve(const struct cmd_struct *cmd,
 				     int argc, char **argv)
 {
 	int fd;
-	int verbose = 0;
 	int ret;
 	DIR *dirstream = NULL;
 
+	/* set global verbose if unset */
+	if (bconf.verbose < 0)
+		bconf.verbose = 0;
+
 	optind = 0;
 	while (1) {
 		int c = getopt(argc, argv, "v");
@@ -103,7 +107,7 @@ static int cmd_inspect_inode_resolve(const struct cmd_struct *cmd,
 
 		switch (c) {
 		case 'v':
-			verbose = 1;
+			bconf.verbose++;
 			break;
 		default:
 			usage_unknown_option(cmd, argv);
@@ -117,8 +121,8 @@ static int cmd_inspect_inode_resolve(const struct cmd_struct *cmd,
 	if (fd < 0)
 		return 1;
 
-	ret = __ino_to_path_fd(arg_strtou64(argv[optind]), fd, verbose,
-			       argv[optind+1]);
+	ret = __ino_to_path_fd(arg_strtou64(argv[optind]), fd,
+			       bconf.verbose, argv[optind+1]);
 	close_file_or_dir(fd, dirstream);
 	return !!ret;
 
-- 
2.23.0

