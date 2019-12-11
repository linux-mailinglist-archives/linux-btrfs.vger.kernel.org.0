Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D82311A4BA
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 07:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfLKGxl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 01:53:41 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43246 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfLKGxl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 01:53:41 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBB6nB8D086994;
        Wed, 11 Dec 2019 06:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=KO8uU17+5ZZZr+K9m6DzftVTkCSDp3QRNJ3CYYIYw7A=;
 b=o5LVtXCLnU/3NrbfM7O62XJo0c6CO7x3+4vFDEu1eLbElh32dqb8HlkAN1LH2q2/5AMB
 e3upOnXZaZRy3hM+XBkpcfkGSa73JVxjt+PoP3UAXmuonOgUB10wFrPMD+shECuCp1dM
 pZOkLRqG01SLmTZTV1qoKJsHxpAUC3AhK2W+6CGGQjVLC9v6n1ClcYST1NV2lE9lRXLD
 uVo77be2x3WUkwxkuLxtLp5td1kWFJObvnp4UVb0GfKVL00zUnjMBDNpz8RWtsE5AL0B
 p7FXN+ZuBWg0SMZ05byWKunncm6ElL/75mDLDOMETadU0n2SJN5xLbmSsRB0J0pd6WsU 3w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2wr4qrjk58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Dec 2019 06:53:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBB6n5rG176509;
        Wed, 11 Dec 2019 06:53:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2wtk2h12jc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Dec 2019 06:53:35 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBB6rYD5029070;
        Wed, 11 Dec 2019 06:53:34 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Dec 2019 22:53:34 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, fdmanana@gmail.com, wqu@suse.com
Subject: [PATCH] fstest: btrfs/142 fix match the device and stripe id
Date:   Wed, 11 Dec 2019 14:53:24 +0800
Message-Id: <1576047204-30621-1-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9467 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912110058
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9467 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912110058
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We re-aliened the device allocation order to the device id oder, if the
available space on the device is all same. So for this reason the test
cases which is hard coded with the device and the stripe id fails. Fix
it with the new expected device and stripe id.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/142 | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/btrfs/142 b/tests/btrfs/142
index a23fe1bf4b75..95caddfd770a 100755
--- a/tests/btrfs/142
+++ b/tests/btrfs/142
@@ -89,12 +89,13 @@ $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" |\
 
 # step 2, corrupt the first 64k of one copy (on SCRATCH_DEV which is the first
 # one in $SCRATCH_DEV_POOL
-echo "step 2......corrupt file extent" >>$seqres.full
 
 ${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
 logical_in_btrfs=`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_filefrag | cut -d '#' -f 1`
 physical_on_scratch=`get_physical ${logical_in_btrfs}`
 
+echo "step 2......corrupt file extent on device $SCRATCH_DEV logic $logical_in_btrfs physical $physical_on_scratch" >>$seqres.full
+
 _scratch_unmount
 $XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical_on_scratch 64K" $SCRATCH_DEV |\
 	_filter_xfs_io_offset
@@ -106,13 +107,13 @@ echo "step 3......repair the bad copy" >>$seqres.full
 
 # since raid1 consists of two copies, and the bad copy was put on stripe #1
 # while the good copy lies on stripe #0, the bad copy only gets access when the
-# reader's pid % 2 == 1 is true
+# reader's pid % 2 == 0 is true
 start_fail
 while [[ -z ${result} ]]; do
 	# enable task-filter only fails the following dio read so the repair is
 	# supposed to work.
 	result=$(bash -c "
-	if [[ \$((\$\$ % 2)) -eq 1 ]]; then
+	if [[ \$((\$\$ % 2)) -eq 0 ]]; then
 		echo 1 > /proc/\$\$/make-it-fail
 		exec $XFS_IO_PROG -d -c \"pread -b 128K 0 128K\" \"$SCRATCH_MNT/foobar\"
 	fi");
-- 
1.8.3.1

