Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5E31E2A69
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 08:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437748AbfJXG2f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Oct 2019 02:28:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43198 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbfJXG2e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Oct 2019 02:28:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O6OGNR157671
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2019 06:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=42Km7nebQvOR6ZHpmk5vb5aFkUx9WlA3OQSlT3++GTc=;
 b=aWiJl+mkQf6+5+mQBBqSHKf3oIeEiTmG5gk0LftTJUuN/+bkh/xpN9OjkO6SzRB2m4Pz
 YONTb+7v9dHFX1UvbKC+995STi7wYJ1If5tnSgEyIzbIzQHwJer899ppZrnz/Hv68izl
 ZpueygwFlYw2Jjcgu7JPjPj0hjXSxc6SDjJP2aPiGMOhunnWpRrCSYl0nKgDoUDVk/TP
 vdcghddLNVOZcUrqjU2EhLFbqypo4DXSM0Vhu1pn0muaR6F0TFqWSqrmppribbVnKCMB
 pTC/XDPuEH/j2nqke9oGoQuCOjc4jyBTPVf4Zbc/+MfEcciHtBfekZxN6zBanFChcQOW uw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2vqu4r1ah5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2019 06:28:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O6MvcI150717
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2019 06:28:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2vtsk3vqrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2019 06:28:32 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9O6SVSb023373
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2019 06:28:31 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Oct 2019 23:28:30 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [RFC PATCH 1/3] btrfs-progs: send: let option quiet overrule verbose
Date:   Thu, 24 Oct 2019 14:28:23 +0800
Message-Id: <20191024062825.13097-2-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024062825.13097-1-anand.jain@oracle.com>
References: <20191024062825.13097-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910240060
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910240060
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs send has both -q|--quiet and -v|--verbose options, now the test
here is, which option shall take the precedence if in case both of them
are specified.

Per current implementation it really depends on the order of the options
as shown below

Without fix:
---- btrfs send -q /btrfs/ss2 -f /tmp/t -----
---- btrfs send -q -v /btrfs/ss2 -f /tmp/t -----
At subvol /btrfs/ss2
---- btrfs send -q -vv /btrfs/ss2 -f /tmp/t -----
At subvol /btrfs/ss2
BTRFS_IOC_SEND returned 0
joining genl thread
---- btrfs send -v -q /btrfs/ss2 -f /tmp/t -----
---- btrfs send -vv -q /btrfs/ss2 -f /tmp/t -----
---- btrfs send -v -q -v /btrfs/ss2 -f /tmp/t -----
At subvol /btrfs/ss2

If the effectiveness of the output depends on the chronological order
of the options -q and -v specified in the command line, then its rather
confusing at times.

So fix it by making the option -q|--quiet to overrule the -v|--verbose
option if when both of them are specified.

So with the fix:
---- btrfs send -q /btrfs/ss2 -f /tmp/t -----
---- btrfs send -q -v /btrfs/ss2 -f /tmp/t -----
---- btrfs send -q -vv /btrfs/ss2 -f /tmp/t -----
---- btrfs send -v -q /btrfs/ss2 -f /tmp/t -----
---- btrfs send -vv -q /btrfs/ss2 -f /tmp/t -----
---- btrfs send -v -q -v /btrfs/ss2 -f /tmp/t -----

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/send.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/cmds/send.c b/cmds/send.c
index 7ce6c3273857..4bf2be7db4d0 100644
--- a/cmds/send.c
+++ b/cmds/send.c
@@ -477,6 +477,7 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 	int full_send = 1;
 	int new_end_cmd_semantic = 0;
 	u64 send_flags = 0;
+	bool quiet = false;
 
 	memset(&send, 0, sizeof(send));
 	send.dump_fd = fileno(stdout);
@@ -500,7 +501,7 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 			g_verbose++;
 			break;
 		case 'q':
-			g_verbose = 0;
+			quiet = true;
 			break;
 		case 'e':
 			new_end_cmd_semantic = 1;
@@ -584,6 +585,9 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 	if (check_argc_min(argc - optind, 1))
 		return 1;
 
+	if (quiet)
+		g_verbose = 0;
+
 	if (outname[0]) {
 		int tmpfd;
 
-- 
2.23.0

