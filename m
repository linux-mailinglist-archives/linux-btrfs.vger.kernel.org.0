Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB121F6CEC
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jun 2020 19:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgFKRl7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Jun 2020 13:41:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49274 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgFKRl6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Jun 2020 13:41:58 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05BHaXwW039833
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:41:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=W2Tr5j/ycx1kT/zr8zjKbzx8H7OmAoFwgB1vLiHgtA4=;
 b=ZODM27CW7cOOi8gPvS3tdAY+OLhtv0XG416CtMO3hX/XPBrppgnDhpOE+qJ0PmaJTppF
 iET8LY2cxohHSwyc7kAcHFaKXNVZHiNrfc6iAWGFK2IQugb1hkuh8e4cDvEYEEN18cbJ
 OHj57Ayc16gM3H8PbxNstxKyGP8u1teQrQsLGIZ9pHQU5Wv/qK1Vc6E3ffy09z98aKgJ
 rroXJvU8Y00zwxeOr/HOUtBgM9K+sLkEgp7YPhuQQCNTeNqp82MpARGjTCFqOQABpN+F
 GI8kkql9JmHwDhYxkI6Q/jmSchY+J8ukc23/hfYGFUCxwYK8Z46+GU4JRL6/YAklNHq3 /A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 31g3sn92uk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:41:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05BHcVVD121626
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:41:57 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 31gmwvsjh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:41:57 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05BHfuG8009593
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:41:56 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jun 2020 10:41:55 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/8] btrfs-progs: subvolume create: add quiet option
Date:   Fri, 12 Jun 2020 01:41:17 +0800
Message-Id: <20200611174123.38382-3-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200611174123.38382-1-anand.jain@oracle.com>
References: <20200611174123.38382-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
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

Enable the quiet option to the btrfs(8) subvolume create command.
Does the job quietly. For example:
   btrfs --quiet subvolume create <path>

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: use MUST_LOG

 cmds/subvolume.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index 279c75d0669a..459661a93e31 100644
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
+	pr_verbose(MUST_LOG, "Create subvolume '%s/%s'\n", dstdir, newname);
 	if (inherit) {
 		struct btrfs_ioctl_vol_args_v2	args;
 
-- 
2.25.1

