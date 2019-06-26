Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2E56564AA
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2019 10:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfFZIeJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jun 2019 04:34:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39734 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFZIeI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jun 2019 04:34:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q8XU6v184471
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=jMAvjrcEVd1Wp7+cqjqazn6Z7vxqjEmntVom/Z0bVzQ=;
 b=ICc8LFcZzMgc7ZJqp+sOaNQ1zpM6dKawSvy48M0w6mcwRAucSq1jdy0/SPjgyv+TQQvW
 LTu141DQzywE5X7n6IgSXokjqPoknigyAWps2WAet7R0GwhcB17wNjNmA1p2SGx6HLWc
 tRQdP9WDbysJ1qJiWY/FdbXdANpQxskqeRwgohiVKcZUCjCu7ZSLV9jrLPYmPA527imk
 DP7+UfsSwaxe9EpWcp13du+TZCxLNBwBXDCKLHJ0hphbzjdn0Sq36MC6FK25o11MqBF9
 zYpXf1wNQVjBlUfsplUo5luHTecEz1op1bu4cjHWnY38pTGOwMJCRGY0mc28cpExcG3H SQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2t9brt8vsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:34:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q8XxbG027485
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:34:07 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2t99f4bh0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:34:07 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5Q8Y6nk015413
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:34:06 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 01:34:06 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3 RESEND Rebased] readmirror feature
Date:   Wed, 26 Jun 2019 16:33:59 +0800
Message-Id: <20190626083402.1895-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=993
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906260104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260104
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These patches are tested to be working fine.

Function call chain  __btrfs_map_block()->find_live_mirror() uses
thread pid to determine the %mirror_num when the mirror_num=0.

This patch introduces a framework so that we can add policies to determine
the %mirror_num. And adds the devid as the readmirror policy.

The property is stored as an extented attributes of root inode
(BTRFS_FS_TREE_OBJECTID).
User provided devid list is validated against the fs_devices::dev_list.

 For example:
   Usage:
     btrfs property set <mnt> readmirror devid<n>[,<m>...]
     btrfs property set <mnt> readmirror ""

   mkfs.btrfs -fq -draid1 -mraid1 /dev/sd[b-d] && mount /dev/sdb /btrfs
   btrfs prop set /btrfs readmirror devid1,2
   btrfs prop get /btrfs readmirror
    readmirror=devid1,2
   getfattr -n btrfs.readmirror --absolute-names /btrfs
    btrfs.readmirror="devid1,2"
   btrfs prop set /btrfs readmirror ""
   getfattr -n btrfs.readmirror --absolute-names /btrfs
    /btrfs: btrfs.readmirror: No such attribute
   btrfs prop get /btrfs readmirror

RFC->v1:
  Drops pid as one of the readmirror policy choices and as usual remains
  as default. And when the devid is reset the readmirror policy falls back
  to pid.
  Drops the mount -o readmirror idea, it can be added at a later point of
  time.
  Property now accepts more than 1 devid as readmirror device. As shown
  in the example above.

Anand Jain (3):
  btrfs: add inode pointer to prop_handler::validate()
  btrfs: add readmirror property framework
  btrfs: add readmirror devid property

 fs/btrfs/props.c   | 120 +++++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/props.h   |   4 +-
 fs/btrfs/volumes.c |  25 +++++++++-
 fs/btrfs/volumes.h |   8 +++
 fs/btrfs/xattr.c   |   2 +-
 5 files changed, 150 insertions(+), 9 deletions(-)

-- 
2.20.1 (Apple Git-117)

