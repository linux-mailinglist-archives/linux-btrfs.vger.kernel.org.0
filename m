Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C39B1F12F2
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jun 2020 08:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgFHGjY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jun 2020 02:39:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60352 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728961AbgFHGjW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Jun 2020 02:39:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0586cKl4142485;
        Mon, 8 Jun 2020 06:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=P1DWNFmimeJeStDIPA5rcmBat59P4DzT3z1Ur+5I+5U=;
 b=L/pbdEi7VvfsyVBhCu6PH0IuF/h0lzEnhl8AwTai85BdkLZw8g8dfDueeqvxbWdOqk04
 pOdQafIqssg0ZoIlTKWFfbMrU9y2QkWRasjLX4U55+hsk/WzFQQyf7Wdubz/dPu4qWF7
 DzXYeraHKaYXkBzSaQ915WyYCC/jB0F4jJw+swhh1sqGBT58wcs4x8k7+dHSWURTlpYp
 fAG1mW9nY+vVH7DZ4HFdh8nzl6SgMIfB/s+jO2C3N0SlF2Ze9JxYnoEeHxXpeFqspZmz
 va/zNXvy6sRFNuFI9bXhpveC97GPxMa040lS7VI5TjLGdQRqkHHiqeedQa/Ge0fsTIFn jQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 31g3smn19v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 08 Jun 2020 06:39:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0586YHn3059327;
        Mon, 8 Jun 2020 06:39:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 31gn21qpu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 06:39:18 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0586dHnG006246;
        Mon, 8 Jun 2020 06:39:17 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 07 Jun 2020 23:39:17 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz
Subject: [PATCH 8/8] btrfs-progs: scrub cancel: add quiet option
Date:   Mon,  8 Jun 2020 14:38:51 +0800
Message-Id: <20200608063851.8874-9-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608063851.8874-1-anand.jain@oracle.com>
References: <20200608063851.8874-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=1 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080049
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=1
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006080049
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Enable the quiet option to the btrfs(8) scrub cancel command.
Does the job quietly. For example:
	btrfs -q scrub cancel <mnt>

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/scrub.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/cmds/scrub.c b/cmds/scrub.c
index e3b6427b47ae..3256f20121ae 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -1624,6 +1624,8 @@ static DEFINE_SIMPLE_COMMAND(scrub_start, "start");
 static const char * const cmd_scrub_cancel_usage[] = {
 	"btrfs scrub cancel <path>|<device>",
 	"Cancel a running scrub",
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_QUIET,
 	NULL
 };
 
@@ -1660,7 +1662,7 @@ static int cmd_scrub_cancel(const struct cmd_struct *cmd, int argc, char **argv)
 	}
 
 	ret = 0;
-	printf("scrub cancelled\n");
+	pr_verbose(-1, "scrub cancelled\n");
 
 out:
 	close_file_or_dir(fdmnt, dirstream);
-- 
2.25.1

