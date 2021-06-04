Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2871E39B612
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jun 2021 11:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhFDJiN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Jun 2021 05:38:13 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:40836 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhFDJiN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Jun 2021 05:38:13 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1549TJU2096594;
        Fri, 4 Jun 2021 09:36:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=OT/EgP0J6r/Whv8ir7erybHjTNbmMyNfwNJMwF7A8nc=;
 b=dJEVo1yYkxK5bXsen3E4nPgZPsh7MiqYlaIosMUEZv/9LNNliy5ta44FV+Fiv+C1yMYZ
 y09SGIoKl69693ViqqWbFhomqzqLnCwkzFJZT8yZS2I3Vked1JMeQx4hlsoGw6vpgj94
 r22xk/rtzBxgPMKKeuRtLHbZPdHXqYwJYmr1ldhUAze5AN0VCw+8pWMMGTE7W/OT1JOf
 HlaoIGbaBPpkQOf/kgxlDj6gE4FXX/ya0EUuN2I1u9wWZoBCj/4iCEUH4nDv+OW1N+pV
 DFeLTVWTWdbgOw2zcE1BuW+NnRZktkipIyQPr+8rcWq4fByIrb83wxvo5Gy7+sFx7LsQ JA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 38ub4cwjs7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 09:36:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1549ZbSm052263;
        Fri, 4 Jun 2021 09:36:23 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 38xyn33c0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 09:36:23 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1549aMAb023382;
        Fri, 4 Jun 2021 09:36:22 GMT
Received: from localhost.localdomain (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Jun 2021 02:36:21 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     wqu@suse.com, dsterba@suse.com
Subject: [PATCH RFC] btrfs: support other sectorsizes in _scratch_mkfs_blocksized
Date:   Fri,  4 Jun 2021 17:36:12 +0800
Message-Id: <2c3054e5b93f023cabd003ab4006d5f18ef3d484.1622717162.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106040076
X-Proofpoint-GUID: h8qo9llY6ZkCmG6W0k_ln2BjhwVGRu9X
X-Proofpoint-ORIG-GUID: h8qo9llY6ZkCmG6W0k_ln2BjhwVGRu9X
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106040075
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When btrfs supports sectorsize != pagesize it can run these test cases
now,
generic/205 generic/206 generic/216 generic/217 generic/218 generic/220
generic/222 generic/227 generic/229 generic/238

This change is backward compatible for kernels without non pagesize
sectorsize support.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
RFC: Are we ok with this patch?
     fstests completed on first 19 patches of subpage support (results I
     need to review yet) on arch64, with pagesize=64k.
     Subpage RW support tests are still pending.

 common/rc | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/rc b/common/rc
index 919028eff41c..b4c1d5f285f7 100644
--- a/common/rc
+++ b/common/rc
@@ -1121,6 +1121,13 @@ _scratch_mkfs_blocksized()
     fi
 
     case $FSTYP in
+    btrfs)
+	grep -q $blocksize /sys/fs/btrfs/supported_sectorsizes
+	if [ $? ]; then
+		_notrun "$FSTYP does not support sectorsize=$blocksize yet"
+	fi
+	_scratch_mkfs $MKFS_OPTIONS --sectorsize=$blocksize
+	;;
     xfs)
 	_scratch_mkfs_xfs $MKFS_OPTIONS -b size=$blocksize
 	;;
-- 
2.18.4

