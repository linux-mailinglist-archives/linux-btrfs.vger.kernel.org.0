Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE0D108BE0
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 11:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfKYKjr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 05:39:47 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48200 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbfKYKjq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 05:39:46 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAY6n5006377
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=um/Dblr28DOQNZpmDtKaP71+P5HlUbPaxLl1ooA7et8=;
 b=ABdTf6PpMZufYQpWe88vgLvrTcQWQzqeQKrDEchFBFVdGPVjaDQ04FoSRHq8QUkoDv9K
 MCSSLO2dLDU3V521vYvYvf5LzYZkjnAS4f+iq3IzqI/y2lgoma5jLX8rDnwo2OwXjQGV
 oxv8MBUQVeS35TmdArvw6aKKWvalwyD0BmXUH1rdDvymmql3XMSn5z3Zk5T1VJIbWviF
 DdUUu21IRsktyPTdooGlPJhgSybHdu2JbRUJ52A92SrtEbK0N4m/lwaqhsFIpErvxd/1
 QPucQitvlQkYoi1TUxChZAZeb4OWz9Eg22vosUG0Atsf/h1BN5c48RqKmU5A5aS1NQws mw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2wewdqxnp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAXIFw191733
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2wfex64qxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:43 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAPAdfpP016886
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:42 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Nov 2019 02:39:41 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 08/16] btrfs-progs: balance status: use global verbose option
Date:   Mon, 25 Nov 2019 18:39:09 +0800
Message-Id: <1574678357-22222-9-git-send-email-anand.jain@oracle.com>
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

Transpire global --verbose option down to the btrfs balance status
sub-command.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Use new helper functions and defines
    HELPINFO_INSERT_GLOBALS, BTRFS_BCONF_UNSET, BTRFS_BCONF_QUIET
    bconf_be_verbose(), bconf_be_quiet()

    No need to init bconf.verbose in the sub command.

 cmds/balance.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/cmds/balance.c b/cmds/balance.c
index 9c2cdacdb288..9f4ab21518de 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -828,6 +828,8 @@ static const char * const cmd_balance_status_usage[] = {
 	"Show status of running or paused balance",
 	"",
 	"-v|--verbose     be verbose",
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_VERBOSE,
 	NULL
 };
 
@@ -844,7 +846,6 @@ static int cmd_balance_status(const struct cmd_struct *cmd,
 	const char *path;
 	DIR *dirstream = NULL;
 	int fd;
-	int verbose = 0;
 	int ret;
 
 	optind = 0;
@@ -861,7 +862,7 @@ static int cmd_balance_status(const struct cmd_struct *cmd,
 
 		switch (opt) {
 		case 'v':
-			verbose = 1;
+			bconf_be_verbose();
 			break;
 		default:
 			usage_unknown_option(cmd, argv);
@@ -907,7 +908,7 @@ static int cmd_balance_status(const struct cmd_struct *cmd,
 	       (unsigned long long)args.stat.considered,
 	       100 * (1 - (float)args.stat.completed/args.stat.expected));
 
-	if (verbose)
+	if (bconf.verbose > BTRFS_BCONF_QUIET)
 		dump_ioctl_balance_args(&args);
 
 	ret = 1;
-- 
1.8.3.1

