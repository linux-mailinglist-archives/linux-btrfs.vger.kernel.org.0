Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFBA2CDE6B
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 11:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfJGJpW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 05:45:22 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59910 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfJGJpW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Oct 2019 05:45:22 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x979cwEs022845
        for <linux-btrfs@vger.kernel.org>; Mon, 7 Oct 2019 09:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=twwM2cQvxCisTxEIJfedITQTIQSyjT5yteZwnSdQLkc=;
 b=Nw4k7ozIBGkJbUlaDEs9THjQ3ruPw3D5XUWKsRcNJsbyVNT65e4vdh4MKyy7Wkdvz96X
 PEv4FO4NrTLBom5+yUGEe/pRUzZjg9l4vjyLpWkr1LCCJapKmFWuZIDRySQLDNmtrmty
 cVGAQFk5r0RQluBOIbM3uYxHXG+io0Fg5XSAtAlS9I9iumzTsDfeI+XIZqW7JTyACx3N
 Xr5dLTwOQ0StZ6QfKqFN5EssC7ZJO9mn5NynmGfk9O63WsLnBzC/W3caUFF5/LsB9KYb
 7/2etKaXkKUZZ3IpIOp+WFVt1ufGrEoXi0XPFQta/Jqs3ZILau/noaaQQqKsw2Dob3X5 Mw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2vek4q5ncq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 09:45:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x979dRBg115187
        for <linux-btrfs@vger.kernel.org>; Mon, 7 Oct 2019 09:45:20 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2vf4n8tba6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 09:45:20 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x979jJj9021448
        for <linux-btrfs@vger.kernel.org>; Mon, 7 Oct 2019 09:45:19 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Oct 2019 02:45:19 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/5] btrfs: fix issues due to alien device
Date:   Mon,  7 Oct 2019 17:45:10 +0800
Message-Id: <20191007094515.925-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9402 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=790
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910070097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9402 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=884 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910070097
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v3: Fix alien device is due to wipefs in Patch4.
    Fix a nit in Patch3.
    Patches are reordered.

Alien device is a device in fs_devices list having a different fsid than
the expected fsid or no btrfs_magic. This patch set fixes issues found due
to the same.

Patch1: is a cleanup patch, not related.
Patch2: fixes failing to mount a degraded RAIDs (RAID1/5/6/10), by
	hardening the function btrfs_free_extra_devids().
Patch3: fixes the missing device (due to alien btrfs-device) not missing in
	the userland, by hardening the function btrfs_open_one_device().
Patch4: fixes the missing device (due to alien device) not missing in
	the userland, by returning EUCLEAN in btrfs_read_dev_one_super().
Patch5: eliminates the source of the alien device in the fs_devices.

PS: Fundamentally its wrong approach that btrfs-progs deduces the device
missing state in the userland instead of obtaining it from the kernel.
I remember objecting on the btrfs-progs patch which did that, but still
it got merged, bugs in p3 and p4 are its side effects. I wrote
patches to read device_state from the kernel using ioctl, procfs and
sysfs but it didn't get the due attention till a merger.

Anand Jain (5):
  btrfs: drop useless goto in open_fs_devices
  btrfs: include non-missing as a qualifier for the latest_bdev
  btrfs: remove identified alien btrfs device in open_fs_devices
  btrfs: remove identified alien device in open_fs_devices
  btrfs: free alien device due to device add

 fs/btrfs/disk-io.c |  2 +-
 fs/btrfs/volumes.c | 57 +++++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 42 insertions(+), 17 deletions(-)

-- 
1.8.3.1

