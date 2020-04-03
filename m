Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B896119CE7D
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Apr 2020 04:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389809AbgDCCLF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Apr 2020 22:11:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47492 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389108AbgDCCLF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Apr 2020 22:11:05 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03329fOJ031900;
        Fri, 3 Apr 2020 02:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=sjsZmkhixvCS3D47N4EyvCtDFzMxWnbCH1AHCP0DBZE=;
 b=WGIGwGXU4af0NFDT2nxZPwua5Wd6/CwrSiJIrLvfCsPx9KRFaxu9c6gywjNd35YGWBGk
 dG9UuydZXOB+41tE4UlRidehbuY+V7s+fcrquSMLKPfiG5dwdAnR6J8Nlt6SXFNW/BzC
 HWzTOS6XOfuXiEWXTjGeeYs9E3H95NN7d7g2F5ykOMAmZI2Na5Y/7TqtyFd+pq6rclEZ
 75UrKMlJsGSpcVzd2wjZnXhrK/nM30dQFffj5iZ1PCcAm0TdQgf27lzfZM0oHeENWnfR
 9vkKnwwm5GwMOftGaCjZvEoimrX2kFHykOFg8DLjv4fjv+SMENVFsiJgOqauEo7hv/hb ng== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 303cevenct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 02:11:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03327GFD087543;
        Fri, 3 Apr 2020 02:11:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 304sjr8x87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 02:11:01 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0332B0U6022909;
        Fri, 3 Apr 2020 02:11:00 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Apr 2020 19:11:00 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz
Subject: [PATCH v3 0/4] btrfs-progs: fix issues in tests
Date:   Fri,  3 Apr 2020 10:10:39 +0800
Message-Id: <1585879843-17731-1-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=4 mlxlogscore=818 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030014
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=4 mlxscore=0 impostorscore=0 mlxlogscore=874 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030014
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fixes issues found in tests.

path 3/4 canonicalized the TEST_DEV path and affected few test group.
Unit tests passed however a complete tests runs is not done.

Anand Jain (4):
  btrfs-progs: fix fsck-test/037 skip corrupt FREE_SPACE_BITMAP
  btrfs-progs: fix TEST_TOP path drop extra forward slash
  btrfs-progs: test clean start after failures
  btrfs-progs: fix misc-test/029 provide device for mount

 tests/clean-tests.sh                                      |  2 +-
 tests/cli-tests.sh                                        |  2 +-
 tests/common                                              |  6 ++++++
 tests/convert-tests.sh                                    |  2 +-
 tests/fsck-tests.sh                                       |  2 +-
 tests/fsck-tests/037-freespacetree-repair/test.sh         | 14 ++++++++++----
 tests/fuzz-tests.sh                                       |  2 +-
 tests/misc-tests.sh                                       |  3 ++-
 tests/misc-tests/029-send-p-different-mountpoints/test.sh |  3 ++-
 tests/mkfs-tests.sh                                       |  2 +-
 10 files changed, 26 insertions(+), 12 deletions(-)

-- 
1.8.3.1

