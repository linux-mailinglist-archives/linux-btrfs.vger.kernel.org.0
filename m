Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4296D11A4C5
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 08:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfLKHCa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 02:02:30 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55644 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfLKHCa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 02:02:30 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBB6sFhp108454;
        Wed, 11 Dec 2019 07:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=/Y9uBwiBjQOeAK0P9S27CZKRRMHyjO8ah0H/UVEeeBY=;
 b=PEAe/Y5TXCuQVIaEosdRbB5DeVY23bhn+TmyggnZ2s2K0YDYulDdH3RLMJBkstbgCbFF
 M1pzC638TrKjAXVFG8xuDjtxulbWaq2jMNSNlznylOdQeQTMZFo0zOdE6oO+UiXPsg/S
 ZDWTy+qep0TtHmCQxN9zXeMaLu6W5VoGtRoNJWzn18P6lolK5qlguwG8bkfSKg3IpQ7S
 plj7XBCmOIyQKonGSlrSTVYjh4vHd71KgFqgufX4VWsLlB6EviPEYXuhozv1404sviDk
 hRNfuHWNoALJhdFNd/jBPNG0WL4XESyksU8PPD+TRoKoMsjhJ29n9UrtGl99TNwQ8R0e yg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2wrw4n7jcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Dec 2019 07:02:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBB6wxHO142390;
        Wed, 11 Dec 2019 07:02:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2wtqg9gkm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Dec 2019 07:02:24 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBB72OTR001517;
        Wed, 11 Dec 2019 07:02:24 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Dec 2019 23:02:23 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, fdmanana@gmail.com, wqu@suse.com
Subject: [PATCH v2] fstest: btrfs/142 fix match the device and stripe id
Date:   Wed, 11 Dec 2019 15:02:13 +0800
Message-Id: <1576047733-31132-1-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576047204-30621-1-git-send-email-anand.jain@oracle.com>
References: <1576047204-30621-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9467 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912110059
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9467 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912110059
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
v2: Update the comment which referred to the bad stripe and good stripe.

 tests/btrfs/142 | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tests/btrfs/142 b/tests/btrfs/142
index a23fe1bf4b75..06811a23e662 100755
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
@@ -104,15 +105,15 @@ _scratch_mount -o nospace_cache
 # step 3, 128k dio read (this read can repair bad copy)
 echo "step 3......repair the bad copy" >>$seqres.full
 
-# since raid1 consists of two copies, and the bad copy was put on stripe #1
-# while the good copy lies on stripe #0, the bad copy only gets access when the
-# reader's pid % 2 == 1 is true
+# since raid1 consists of two copies, and the bad copy was put on stripe #0
+# while the good copy lies on stripe #1, the bad copy only gets access when the
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

