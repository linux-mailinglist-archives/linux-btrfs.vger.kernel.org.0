Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65AA939DBF6
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jun 2021 14:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhFGMKb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Jun 2021 08:10:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52520 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhFGMKb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Jun 2021 08:10:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 157C0Ltb107502;
        Mon, 7 Jun 2021 12:08:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=+u+mz5AuEGIdOm39vTlh04JiRbJYai6NC+No0l9XeyE=;
 b=N1eHmYbaMjctigRz8AeUn9XaSoRLGcabNU4FPdYjcxHHtgmFywDedRP2vaijTbQa915S
 /guNqhFsjyHHPb+8qBGLWruBFbv60YlUAJBu7oy7F2lXzVgZmElt7SazcGtjVyj40E40
 kldvgMEvTuOY8FxAJw5C1RfI1mILjYtx2pIp96fR2/0jeAkHJkolbRpp3uI7mVqNtXte
 1HVI8fNGHFUq6QJJyxryC/ilGCr6sjSQMK9VmO2j/bdk0AFj2mPgsDpfzxmzPSAkqq+l
 tUVJobCCZp63Az85B5KLyRhVkvvZGL2J82+2D4vHbZzhO6el2cuqkXdy7qUNRDWm5IMk 3A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 3914quha34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 12:08:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 157BxnRr007550;
        Mon, 7 Jun 2021 12:08:35 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 3906spjc3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 12:08:35 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 157C8YH9011190;
        Mon, 7 Jun 2021 12:08:34 GMT
Received: from fed2.sg.oracle.com (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Jun 2021 12:08:34 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, guan@eryu.me
Subject: [PATCH 2/2 v2] _scratch_mkfs_blocksized: fix indentation
Date:   Mon,  7 Jun 2021 20:08:20 +0800
Message-Id: <0807b564fd7935f4b8a4f03d5242e5ba578ae89b.1623059144.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623059144.git.anand.jain@oracle.com>
References: <cover.1623059144.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10007 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106070092
X-Proofpoint-ORIG-GUID: pWyLPeXicGsimC6DJArC_j71wpqvRzev
X-Proofpoint-GUID: pWyLPeXicGsimC6DJArC_j71wpqvRzev
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10007 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106070092
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

No function change. Fix indentation.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 v2: born

 common/rc | 60 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/common/rc b/common/rc
index 601540730b8f..9c42a6aedc8b 100644
--- a/common/rc
+++ b/common/rc
@@ -1116,42 +1116,44 @@ _scratch_mkfs_geom()
 # _scratch_mkfs_blocksized blocksize
 _scratch_mkfs_blocksized()
 {
-    local blocksize=$1
+	local blocksize=$1
 
-    local re='^[0-9]+$'
-    if ! [[ $blocksize =~ $re ]] ; then
-        _notrun "error: _scratch_mkfs_sized: block size \"$blocksize\" not an integer."
-    fi
+	local re='^[0-9]+$'
+	if ! [[ $blocksize =~ $re ]] ; then
+_notrun "error: _scratch_mkfs_sized: block size \"$blocksize\" not an integer."
+	fi
 
-    case $FSTYP in
-    btrfs)
-	test -f /sys/fs/btrfs/features/supported_sectorsizes || \
+	case $FSTYP in
+	btrfs)
+		test -f /sys/fs/btrfs/features/supported_sectorsizes || \
 		_notrun "Subpage sectorsize support is not found in $FSTYP"
 
-	grep -wq $blocksize /sys/fs/btrfs/features/supported_sectorsizes || \
+		grep -wq $blocksize /sys/fs/btrfs/features/supported_sectorsizes || \
 		_notrun "$FSTYP does not support sectorsize=$blocksize yet"
 
-	_scratch_mkfs --sectorsize=$blocksize
-	;;
-    xfs)
-	_scratch_mkfs_xfs $MKFS_OPTIONS -b size=$blocksize
-	;;
-    ext2|ext3|ext4)
-	${MKFS_PROG} -t $FSTYP -F $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV
-	;;
-    gfs2)
-	${MKFS_PROG} -t $FSTYP $MKFS_OPTIONS -O -b $blocksize $SCRATCH_DEV
-	;;
-    ocfs2)
-	yes | ${MKFS_PROG} -t $FSTYP -F $MKFS_OPTIONS -b $blocksize -C $blocksize $SCRATCH_DEV
-	;;
-    bcachefs)
-	${MKFS_PROG} -t $FSTYP $MKFS_OPTIONS --block_size=$blocksize $SCRATCH_DEV
-	;;
-    *)
+		_scratch_mkfs --sectorsize=$blocksize
+		;;
+	xfs)
+		_scratch_mkfs_xfs $MKFS_OPTIONS -b size=$blocksize
+		;;
+	ext2|ext3|ext4)
+		${MKFS_PROG} -t $FSTYP -F $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV
+		;;
+	gfs2)
+		${MKFS_PROG} -t $FSTYP $MKFS_OPTIONS -O -b $blocksize $SCRATCH_DEV
+		;;
+	ocfs2)
+		yes | ${MKFS_PROG} -t $FSTYP -F $MKFS_OPTIONS -b $blocksize \
+						-C $blocksize $SCRATCH_DEV
+		;;
+	bcachefs)
+		${MKFS_PROG} -t $FSTYP $MKFS_OPTIONS --block_size=$blocksize \
+								$SCRATCH_DEV
+		;;
+	*)
 	_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_blocksized"
-	;;
-    esac
+		;;
+	esac
 }
 
 _scratch_resvblks()
-- 
2.27.0

