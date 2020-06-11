Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0951F6CF2
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jun 2020 19:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgFKRmZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Jun 2020 13:42:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49570 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbgFKRmZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Jun 2020 13:42:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05BHaVIu039801
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=o4wxZUx3f1uNWnNbDrS1VNuw/+/lxx9aYDo4v4UPqvw=;
 b=okRiB+omJDDrCXHOc93iVS1AJy50GehlQQY/HcbqwRdo0m1A89i0PEO5jz025OPsA1q3
 Nr4VZc3WwSkuq92GzLiS2pdvp64xefJuR9eL5RJ8onCrB4de8fhZYvwa4xTDdlib5onT
 9Q1Z2+ySAGoVfi8vQWNa3gDSWOdmxp9YiRSijwg5JawlLAR8lWhpACSxnP2DvtL7WKZX
 Q11M271snKHzPFMUzDYoaqEiHAm/LJspu4fHr1eGG4wQ3aZERkbnKxx+Hw6jVZRRcvEp
 AMskJFT0uXmPdGNQe4XoVTIo1tlvG6dS8phdFfoOAVG5RuV64zHfdh6kvlCkENh5nCMA YQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31g3sn92wk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:42:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05BHbm3C065813
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:42:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 31gn326g6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:42:23 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05BHgNd5023831
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:42:23 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jun 2020 10:42:21 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 8/8] btrfs-progs: scrub cancel: add quiet option
Date:   Fri, 12 Jun 2020 01:41:23 +0800
Message-Id: <20200611174123.38382-9-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200611174123.38382-1-anand.jain@oracle.com>
References: <20200611174123.38382-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006110139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=1
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006110139
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Enable the quiet option to the btrfs(8) scrub cancel command.
Does the job quietly. For example:
	btrfs -q scrub cancel <mnt>

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: MUST_LOG

 cmds/scrub.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/cmds/scrub.c b/cmds/scrub.c
index 809790266011..53376a376534 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -1626,6 +1626,8 @@ static DEFINE_SIMPLE_COMMAND(scrub_start, "start");
 static const char * const cmd_scrub_cancel_usage[] = {
 	"btrfs scrub cancel <path>|<device>",
 	"Cancel a running scrub",
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_QUIET,
 	NULL
 };
 
@@ -1662,7 +1664,7 @@ static int cmd_scrub_cancel(const struct cmd_struct *cmd, int argc, char **argv)
 	}
 
 	ret = 0;
-	printf("scrub cancelled\n");
+	pr_verbose(MUST_LOG, "scrub cancelled\n");
 
 out:
 	close_file_or_dir(fdmnt, dirstream);
-- 
2.25.1

