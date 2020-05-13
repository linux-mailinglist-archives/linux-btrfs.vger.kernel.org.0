Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84BE1D1C84
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 May 2020 19:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389805AbgEMRpK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 May 2020 13:45:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35662 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732694AbgEMRpK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 May 2020 13:45:10 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04DHXATq080540
        for <linux-btrfs@vger.kernel.org>; Wed, 13 May 2020 17:45:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=8YyVzja9ydG0f5mexXou/BCjEjQytAwtUjfSFV5ITA0=;
 b=TThGlXNMWJFIj7BRTinuWRl0qHU2tvtCCaBzvGeLLo7IvsJSkQ4tbT8OSmcP0ZMnkk9J
 w78sXHn5fp2zg5W018jWcyjUoF2DQL9FRpS6DeJpazK6/zOGSIBFE3HU4G8vihnBJTRo
 3WAWjQzrxnm28Vs3IBADiLWmc61yBPWvUbei4dPEmPMfdm/kWXwRVzwvvaTcUGlELIcX
 dM5mfhltmzfUmSlQ4aVTIwr7q1zkE2QdR0uqmlO+6XB7TlQUnzpqVeS5jU30paCSIzDS
 6OU+ZNZAFwY6oM3U7pqxG2rmiGHC9pgQwIIk8VJbhXP8eKfSW878dlqgAZBqci4cQs5w 5A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 3100xwdph7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Wed, 13 May 2020 17:45:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04DHWevG142181
        for <linux-btrfs@vger.kernel.org>; Wed, 13 May 2020 17:43:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 3100ys8d7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 13 May 2020 17:43:08 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04DHh7GF019731
        for <linux-btrfs@vger.kernel.org>; Wed, 13 May 2020 17:43:07 GMT
Received: from localhost.localdomain (/39.109.177.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 May 2020 10:43:06 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix comment drop reference to volume_mutex
Date:   Thu, 14 May 2020 01:42:45 +0800
Message-Id: <20200513174245.25956-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=1
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005130151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 lowpriorityscore=0
 suspectscore=1 mlxlogscore=999 clxscore=1015 cotscore=-2147483648
 mlxscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005130151
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

No functional changes.
commit dccdb07bc996 (btrfs: kill btrfs_fs_info::volume_mutex)
killed the volume_mutex. Drop all references to volumes_mutex
including the comment sections.

Fixes: dccdb07bc996 (btrfs: kill btrfs_fs_info::volume_mutex)
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index be1e047a489e..60ab41c12e50 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -280,7 +280,6 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
  * ============
  *
  * uuid_mutex
- *   volume_mutex
  *     device_list_mutex
  *       chunk_mutex
  *     balance_mutex
-- 
2.25.1

