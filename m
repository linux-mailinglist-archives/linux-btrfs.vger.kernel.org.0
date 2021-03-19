Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B22834161E
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Mar 2021 07:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbhCSGrd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Mar 2021 02:47:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53244 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbhCSGrK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Mar 2021 02:47:10 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12J6UECd137172;
        Fri, 19 Mar 2021 06:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=+YYSBGCd7eqpM6OcFZnMLuMT2hPXXsTSerhi+/LBLF4=;
 b=tER0nJ/3Mqz/BpbuHJWUSoprlcVMGIJLInp7DvUXkaWZlY30iTwuJTuAV/dqJI6lbh5z
 8byfKyjyTeXDPxfWOw2VV32clAJaYTvNnK67cUImXFbkeZSkGg3r8UfEt5ZbKsA62JYQ
 FbvCncnRAeLJRwZSF2k+cH6jJTo9jBtQHXfsNhACZ35MvFDn2WLhpqeKaVWe/6w4jMyf
 Z3EOPVQ1LSel3S4zwBUv14+arfJnftoatd0fINaL3Y5ViN+FrhbYv135d+jWJcSZZ9k0
 SPWeA7uF2CF7NpZxLD8Mn3KWZGznQu15rXz7E3i510sjdfWobKW0FtJeDq2C7aVN2E+j HQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 378nbmhtqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 06:47:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12J6irtK101981;
        Fri, 19 Mar 2021 06:47:04 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 3796yx4db5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 06:47:04 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 12J6l2YG028675;
        Fri, 19 Mar 2021 06:47:03 GMT
Received: from localhost.localdomain (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Mar 2021 23:47:02 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH] btrfs-progs: fix inspect-internal --help incomplete sentence
Date:   Fri, 19 Mar 2021 14:46:52 +0800
Message-Id: <d9905452906eea5e8ac5b569e92df3c48861d734.1616136002.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9927 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190046
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9927 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190045
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs inspect-internal --help show some incomplete sentenses. As shown
below,

  btrfs inspect-internal --help
  <snip>
      btrfs inspect-internal min-dev-size [options] <path>
          Get the minimum size the device can be shrunk to. The
      btrfs inspect-internal dump-tree [options] <device> [<device> ..]
  <snip>

This patch just fixes it.

Also, the consistency is missing whether to add a period after the
one-line statement of the btrfs --help output.
So while here, this patch adds a period at the end of the help
statement and makes it consistent within the command
btrfs inspect-internal --help.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/inspect.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/cmds/inspect.c b/cmds/inspect.c
index 15f19c8a3027..fcb3b1ae1321 100644
--- a/cmds/inspect.c
+++ b/cmds/inspect.c
@@ -80,7 +80,7 @@ out:
 
 static const char * const cmd_inspect_inode_resolve_usage[] = {
 	"btrfs inspect-internal inode-resolve [-v] <inode> <path>",
-	"Get file system paths for the given inode",
+	"Get file system paths for the given inode.",
 	"",
 	"-v   deprecated, alias for global -v option",
 	HELPINFO_INSERT_GLOBALS,
@@ -126,7 +126,7 @@ static DEFINE_SIMPLE_COMMAND(inspect_inode_resolve, "inode-resolve");
 
 static const char * const cmd_inspect_logical_resolve_usage[] = {
 	"btrfs inspect-internal logical-resolve [-Pvo] [-s bufsize] <logical> <path>",
-	"Get file system paths for the given logical address",
+	"Get file system paths for the given logical address.",
 	"",
 	"-P          skip the path resolving and print the inodes instead",
 	"-o          ignore offsets when matching references (requires v2 ioctl",
@@ -389,9 +389,9 @@ static DEFINE_SIMPLE_COMMAND(inspect_rootid, "rootid");
 
 static const char* const cmd_inspect_min_dev_size_usage[] = {
 	"btrfs inspect-internal min-dev-size [options] <path>",
-	"Get the minimum size the device can be shrunk to. The",
-	"device id 1 is used by default.",
+	"Get the minimum size the device can be shrunk to.",
 	"",
+	"The device id 1 is used by default.",
 	"--id DEVID   specify the device id to query",
 	NULL
 };
-- 
2.29.2

