Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F176039B286
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jun 2021 08:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhFDG1p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Jun 2021 02:27:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56452 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhFDG1p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Jun 2021 02:27:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1546Kvj6005479;
        Fri, 4 Jun 2021 06:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=qn8WXCeSfRLba1xH8h0KaJHLZnGPLQdlOkEtgih1PC4=;
 b=jAHAQ+d0SVkQ5ONc1/ErLx4k3BqDZcA9K/CanAFFida3g4CMZHiAbrLqurb9VxB9CJiu
 nadHyJ3I8WznTvjeOhZ9fhuhOo+QZukkWBx350BgzeX9g6U/EBhezRE3NrlDudz/YuRm
 +Sku6+avvoVoG5qq6F37JZMgdmDYGYNL8yhQzOmB4t+ABPcZZjJ3UOb5siKj+dXNFyKo
 8AShe8mg7SYbSOiE5Ut5PkDVtFvO1sptD4kb9FmPVULUw6JeLyRZGUQ0DYS80VhKVYl4
 mGmGxMmhUjfJFL77EDkH2ZPPGAtVYObeMsJ9v2VR1UjRuXq19sLhX3Sdwf+j4jMYO5JA ow== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 38ue8pn224-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 06:25:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1546Oj8S152189;
        Fri, 4 Jun 2021 06:25:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 38x1bekx57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 06:25:58 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 1546Pv4w015120;
        Fri, 4 Jun 2021 06:25:57 GMT
Received: from localhost.localdomain (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Jun 2021 23:25:56 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs/029: fix the test compatible with older cp(1)
Date:   Fri,  4 Jun 2021 14:25:47 +0800
Message-Id: <09a46a038b552686766899cf06112dffbb835902.1622787708.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106040050
X-Proofpoint-GUID: gtuG5M3r1v_CLDjqIMPf_sV_v4_meQu-
X-Proofpoint-ORIG-GUID: gtuG5M3r1v_CLDjqIMPf_sV_v4_meQu-
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106040049
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

cp(1) versions 8.30 and 8.32 are compared with its --reflink=always option
and they have different semantic if the target-file (with zero sizes) must be
created when the cp --reflink=alaways fails with a cross-device link
error. As shown below.

$ cp --version | head -1
cp (GNU coreutils) 8.30

$ cp --reflink=always /mnt/scratch/original /mnt/test/test-029/copy
cp: failed to clone '/mnt/test/test-029/copy' from '/mnt/scratch/original': Invalid cross-device link

$ ls -l /mnt/test/test-029/copy
ls: cannot access '/mnt/test/test-029/copy': No such file or directory

$ cp --version | head -1
cp (GNU coreutils) 8.32

$ cp --reflink=always /mnt/scratch/original /mnt/test/test-029/copy;
cp: failed to clone '/mnt/test/test-029/copy' from '/mnt/scratch/original': Invalid cross-device link

$ ls -l /mnt/test/test-029/copy
-rw------- 1 root root 0 Jun  4 13:29 /mnt/test/test-029/copy

Reported-by: Wang Yugui <wangyugui@e16-tech.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/029     | 6 ++++--
 tests/btrfs/029.out | 2 --
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/btrfs/029 b/tests/btrfs/029
index bbbb79708180..0234a7f0142b 100755
--- a/tests/btrfs/029
+++ b/tests/btrfs/029
@@ -65,8 +65,10 @@ _create_reflinks()
     echo "reflink=always:"
     cp --reflink=always $1 $2 >> $seqres.full 2>&1 || echo "cp reflink failed"
 
-    # The failed target actually gets created by cp:
-    ls $2 | _filter_testdir_and_scratch
+    # The failed target gets created with zero sizes by cp(1) version 8.32. But
+    # in older cp(1) version 8.30 target file is not created when the
+    # cp --reflink=always fails.
+    ls $2 >> $seqres.full 2>&1
 }
 
 echo "test reflinks across different devices"
diff --git a/tests/btrfs/029.out b/tests/btrfs/029.out
index 0547d2803308..f1c887807650 100644
--- a/tests/btrfs/029.out
+++ b/tests/btrfs/029.out
@@ -5,11 +5,9 @@ reflink=auto:
 42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/test-029/copy
 reflink=always:
 cp reflink failed
-TEST_DIR/test-029/copy
 test reflinks across different mountpoints of same device
 reflink=auto:
 42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/original
 42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/test-029/copy
 reflink=always:
 cp reflink failed
-TEST_DIR/test-029/copy
-- 
2.27.0

