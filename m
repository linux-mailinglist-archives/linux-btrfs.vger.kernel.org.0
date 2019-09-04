Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77471A844D
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 15:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbfIDNR3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 09:17:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55646 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729804AbfIDNR3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Sep 2019 09:17:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x84DHP2L117837;
        Wed, 4 Sep 2019 13:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=gXXgJtoysaTr8zwIJghiDlw9J852M/zUhdcxvKk8jiY=;
 b=C0Oq3pHboDQjUyJVOEAkPl4MZ+50Glkt9Uk9CWqD7AtV6oHzxjdWkXOn44bgGrSkNVqM
 KtJHI2SzjZkXYo/lj9Uer8d7ImovnOsZYs1y0rKMfXxBpQ6X+yzgjxyMUHCNjpDAhDPj
 PWma7ZDMpdwt75cyXHOxWUzX7qWHoa3gkkAtTLhuqhVG5XE2YlOhmQz87Gx29TdYO9hL
 JuayCeADauhEquKNt0PRxvkbwKnxexiPiCkQSAkhz9VmjOPHV1uv+9RvmsE7fYxZbmRB
 /Xz/Y12glsfsq8ICt3hIuzPg781MeBj1up5KAcwB6fYCN/k9BChFu7TtKM4pg4b0YHlQ QQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2ute11g01t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Sep 2019 13:17:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x84CqVrl119000;
        Wed, 4 Sep 2019 12:55:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2usu51txfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Sep 2019 12:55:07 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x84Ct6na003930;
        Wed, 4 Sep 2019 12:55:06 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Sep 2019 05:55:06 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     jthumshirn@suse.de, dsterba@suse.cz
Subject: [PATCH] btrfs: misc-tests-021 fix restore overlapped on disk's stale data
Date:   Wed,  4 Sep 2019 20:54:57 +0800
Message-Id: <20190904125457.787-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-120)
In-Reply-To: <23f82b13-5050-0acd-49fb-1ecd06811b8d@suse.de>
References: <23f82b13-5050-0acd-49fb-1ecd06811b8d@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909040129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909040133
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As misc-tests/021 image dump is restored on the same original loop
device, this overlaps with the stale data and makes the test pass
falsely.

Fix this by using a new device for restore.

And also, the btrfs-image dump and restore doesn't not collect the data,
so any read on the files should be avoided. So instead of file data use
file stat data for the md5sum.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reported-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 tests/misc-tests/021-image-multi-devices/test.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tests/misc-tests/021-image-multi-devices/test.sh b/tests/misc-tests/021-image-multi-devices/test.sh
index b1013b5d2596..5ed8f4b01457 100755
--- a/tests/misc-tests/021-image-multi-devices/test.sh
+++ b/tests/misc-tests/021-image-multi-devices/test.sh
@@ -10,17 +10,18 @@ check_prereq btrfs
 
 setup_root_helper
 
-setup_loopdevs 2
+setup_loopdevs 3
 prepare_loopdevs
 loop1=${loopdevs[1]}
 loop2=${loopdevs[2]}
+loop3=${loopdevs[3]}
 
 # Create the test file system.
 
 run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f "$loop1" "$loop2"
 run_check $SUDO_HELPER mount "$loop1" "$TEST_MNT"
 run_check $SUDO_HELPER dd bs=1M count=1 if=/dev/zero of="$TEST_MNT/foobar"
-orig_md5=$(run_check_stdout md5sum "$TEST_MNT/foobar" | cut -d ' ' -f 1)
+orig_md5=$(run_check_stdout stat "$TEST_MNT/foobar" | md5sum | cut -d ' ' -f 1)
 run_check $SUDO_HELPER umount "$TEST_MNT"
 
 # Create the image to restore later.
@@ -32,13 +33,13 @@ run_check $SUDO_HELPER "$TOP/btrfs-image" "$loop1" "$IMAGE"
 run_check $SUDO_HELPER wipefs -a "$loop1"
 run_check $SUDO_HELPER wipefs -a "$loop2"
 
-run_check $SUDO_HELPER "$TOP/btrfs-image" -r "$IMAGE" "$loop1"
+run_check $SUDO_HELPER "$TOP/btrfs-image" -r "$IMAGE" "$loop3"
 
 # Run check to make sure there is nothing wrong for the recovered image
-run_check $SUDO_HELPER "$TOP/btrfs" check "$loop1"
+run_check $SUDO_HELPER "$TOP/btrfs" check "$loop3"
 
-run_check $SUDO_HELPER mount "$loop1" "$TEST_MNT"
-new_md5=$(run_check_stdout md5sum "$TEST_MNT/foobar" | cut -d ' ' -f 1)
+run_check $SUDO_HELPER mount "$loop3" "$TEST_MNT"
+new_md5=$(run_check_stdout stat "$TEST_MNT/foobar" | md5sum | cut -d ' ' -f 1)
 run_check $SUDO_HELPER umount "$TEST_MNT"
 
 cleanup_loopdevs
-- 
1.8.3.1

