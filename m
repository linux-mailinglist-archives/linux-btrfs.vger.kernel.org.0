Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE65C1F12EC
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jun 2020 08:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgFHGjK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jun 2020 02:39:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44298 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgFHGjK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Jun 2020 02:39:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0586cBPJ086919;
        Mon, 8 Jun 2020 06:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=uWoIaKt2dLcS2z/3uycIVAhAYtciGeJi7wrxWuFozZ4=;
 b=M2O2W5NhctRmpGliuirOVKnjfejm6266bWtiNfU7pNYw7boA3p9wSekhJjDupa+3SZtd
 giB8gly75jhwCP+6iYJO1l+NZXhGvtBE4DqN/ny0iCqETuDomas+j4fRIEoBRhayYljo
 SoifWLhhnvz4QLy4VzzfiC5Un1ZD9emvZgVZ4nNNBHhZcnnFI6A7Ubq0cABi+GKD8u63
 El3hpNQRmDVb1ff0fiGLw9AYa8GXB9KyJ9ZZoEC6tuebpNNHjb/gxrcpatOQeJvnP6MZ
 HH7ovzBqdTnqUoZKxVgqkJALyV/WrSC/ox3kv0RbdJjyIIQJXy06839De0V5hPknPnGd LA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 31g2jqw50v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 08 Jun 2020 06:39:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0586YHCt059383;
        Mon, 8 Jun 2020 06:39:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 31gn21qp90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 06:39:06 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0586d5FW006201;
        Mon, 8 Jun 2020 06:39:05 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 07 Jun 2020 23:39:05 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz
Subject: [PATCH 2/8] btrfs-progs: subvolume create: add quiet option
Date:   Mon,  8 Jun 2020 14:38:45 +0800
Message-Id: <20200608063851.8874-3-anand.jain@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 spamscore=0 suspectscore=1
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006080049
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Enable the quiet option to the btrfs(8) subvolume create command.
Does the job quietly. For example:
   btrfs --quiet subvolume create <path>

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/subvolume.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index 279c75d0669a..ed3a3ab48ec7 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -88,6 +88,8 @@ static const char * const cmd_subvol_create_usage[] = {
 	"",
 	"-i <qgroupid>  add the newly created subvolume to a qgroup. This",
 	"               option can be given multiple times.",
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_QUIET,
 	NULL
 };
 
@@ -169,7 +171,7 @@ static int cmd_subvol_create(const struct cmd_struct *cmd,
 	if (fddst < 0)
 		goto out;
 
-	printf("Create subvolume '%s/%s'\n", dstdir, newname);
+	pr_verbose(-1, "Create subvolume '%s/%s'\n", dstdir, newname);
 	if (inherit) {
 		struct btrfs_ioctl_vol_args_v2	args;
 
-- 
2.25.1

