Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB1D39DBF5
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jun 2021 14:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhFGMK2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Jun 2021 08:10:28 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37604 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhFGMK2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Jun 2021 08:10:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 157Bxr1t058958;
        Mon, 7 Jun 2021 12:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=2T1Vaa4w38YnmJu2sAbx9nLQeTqFeXXxeqmKJSaykmA=;
 b=Zi5TNNCUTMvveSJGlZBhAWkuz9UKkYzGpBdJpbGAKhObiI8snFDAOwnjxBR32aMuzPy6
 edT+Xx3ki33bX3N72IDrVbYKTNlzOwkHNS2gUx+a84wCPZLVzoWYvLqa590vRQuBoEeC
 abSdb7Ks4YMJNA+bPqtK6ArJrNWxJpcYpxnXE1vTggEKuoK9cTAs50MjSnCqSzV6i9KF
 mkx27p9KSzXe8yZBtBEbNf/p67u+n7/6xNblknnc1JMOSHzin/sZ2bBhKg32hbRdm7AC
 dWO5ymSs88nZ8axhDfWzs/k0ZDHUT/L3IKLeSKG4zewQBmVSf2JHUhBsU8gefuthWw/1 Wg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 39017nasmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 12:08:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 157C0oE8132524;
        Mon, 7 Jun 2021 12:08:33 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 38yyaa24t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 12:08:33 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 157C8WBg011184;
        Mon, 7 Jun 2021 12:08:32 GMT
Received: from fed2.sg.oracle.com (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Jun 2021 12:08:32 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, guan@eryu.me
Subject: [PATCH 1/2 v2] btrfs: support other sectorsizes in _scratch_mkfs_blocksized
Date:   Mon,  7 Jun 2021 20:08:19 +0800
Message-Id: <e937328f1eb9664b788eb8b8a772901d26cabb9b.1623059144.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623059144.git.anand.jain@oracle.com>
References: <cover.1623059144.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10007 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106070092
X-Proofpoint-GUID: I2JhR3ts8ikMpKQW0t56y99pqlxpNEdZ
X-Proofpoint-ORIG-GUID: I2JhR3ts8ikMpKQW0t56y99pqlxpNEdZ
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10007 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106070092
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
v2:
 use grep -w
 drop $MKFS_OPTIONS

 common/rc | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/common/rc b/common/rc
index a0aa7300dc94..601540730b8f 100644
--- a/common/rc
+++ b/common/rc
@@ -1124,6 +1124,15 @@ _scratch_mkfs_blocksized()
     fi
 
     case $FSTYP in
+    btrfs)
+	test -f /sys/fs/btrfs/features/supported_sectorsizes || \
+		_notrun "Subpage sectorsize support is not found in $FSTYP"
+
+	grep -wq $blocksize /sys/fs/btrfs/features/supported_sectorsizes || \
+		_notrun "$FSTYP does not support sectorsize=$blocksize yet"
+
+	_scratch_mkfs --sectorsize=$blocksize
+	;;
     xfs)
 	_scratch_mkfs_xfs $MKFS_OPTIONS -b size=$blocksize
 	;;
-- 
2.27.0

