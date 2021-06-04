Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F04639B8FF
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jun 2021 14:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhFDM2w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Jun 2021 08:28:52 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60314 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhFDM2w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Jun 2021 08:28:52 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 154CK4a6110029;
        Fri, 4 Jun 2021 12:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=MmQVQhpc2LW+01oKnlrqeKgKWISNYG6WYAbvrOjcVrg=;
 b=uPKqKkcGYEL9l90z+9gr4seMprx2wHR8gt9md07bajQQo2r8zyxaKOdK/3rRO40VeXM6
 cfZInJXF+HPDcKvwxNKIeNUiBjYrbsvWnJRqr6HY/mRHW3zR8X5XyT+0ttIB1klEDczQ
 zzdeg1plQ39KTcFPd+3sHkWRKgs/48rFUzx1+0UjGxCvC5/2n3kec+lFFnUfF5BiEFsm
 aaIQQ05abcdO1BhyeD6Q4htjIB7RoP/ZK5h1ETDMcg6IQpj1yqB3bpCJqPNftU1dU6JT
 sVOXPAfxvdPuBmd6hJtpeJjyNi2pnINKHknRXrSppANJmhuB/qbLwIlneKVKlLld46yy +g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38ub4cwvtd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 12:26:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 154CKl74155272;
        Fri, 4 Jun 2021 12:26:57 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 38x1bew7qc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 12:26:57 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 154CQuHd022710;
        Fri, 4 Jun 2021 12:26:56 GMT
Received: from localhost.localdomain (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Jun 2021 05:26:55 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, g.btrfs@cobb.uk.net,
        quwenruo.btrfs@gmx.com
Subject: [PATCH] btrfs: support other sectorsizes in _scratch_mkfs_blocksized
Date:   Fri,  4 Jun 2021 20:26:44 +0800
Message-Id: <d27e3a324f986b5b52d11df7c7bdcde6744fad4b.1622807821.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106040097
X-Proofpoint-GUID: 3nSnACmU3Cq_We8gSAUol8_VBP7NhkGJ
X-Proofpoint-ORIG-GUID: 3nSnACmU3Cq_We8gSAUol8_VBP7NhkGJ
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106040097
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
RFC->v1:
  Fix path to the supported_sectorsizes path check if the file exists.
  Grep the word.

 common/rc | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/common/rc b/common/rc
index 919028eff41c..baa994e33553 100644
--- a/common/rc
+++ b/common/rc
@@ -1121,6 +1121,15 @@ _scratch_mkfs_blocksized()
     fi
 
     case $FSTYP in
+    btrfs)
+	test -f /sys/fs/btrfs/features/supported_sectorsizes || \
+		_notrun "Subpage sectorsize support is not found in $FSTYP"
+
+	grep -q \\b$blocksize\\b /sys/fs/btrfs/features/supported_sectorsizes || \
+		_notrun "$FSTYP does not support sectorsize=$blocksize yet"
+
+	_scratch_mkfs $MKFS_OPTIONS --sectorsize=$blocksize
+	;;
     xfs)
 	_scratch_mkfs_xfs $MKFS_OPTIONS -b size=$blocksize
 	;;
-- 
2.18.4

