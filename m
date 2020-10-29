Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD6C29F6E1
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 22:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgJ2Vav (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 17:30:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58168 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgJ2Vav (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 17:30:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TLScmS023635;
        Thu, 29 Oct 2020 21:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=y1U0+H8ujCKoFTwj6iDbrIvkVL1lK1HPgwAGJgHUAYk=;
 b=JW9UrsGkR2R5AR+uHxvBjE1PMhiNGGjesF37/Vi3tiMyLiiSmFC0Ru9lD/zAUebEKpdm
 HiP2X8wg6W49vPQjFwnGz3JD8nPNx1CkYxHNZ84UGlwIJ4i7RiOYXuf+jMkBKCogUOfT
 tbjVq9oPlw+Ekc+26HHQ8zAEUulR80fyB9wPHy6xJq5j+DlG/SNrKNoSx6H0ukv4bZtL
 iXNALN8Ps4TopH9lL8YKp1UYbMBT2IHs3cTgYjGgGXALoiWe/Z1AS74c08Pb8zvC7L3p
 9Yo6VWWb7WVKQgFibOZVvoihD2rFdDrQtT3pJnCzPHSiwXCXEvcaqgMzmXF88AKZNNFx og== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 34dgm4csd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 21:30:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TLPSBp186800;
        Thu, 29 Oct 2020 21:30:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 34cx6yxycw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Oct 2020 21:30:46 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09TLUknF018288;
        Thu, 29 Oct 2020 21:30:46 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Oct 2020 14:30:45 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Anand Jain <anand.jain@oracle.com>
Subject: [PATCH RESEND 0/2] fix verify_one_dev_extent and btrfs_find_device
Date:   Fri, 30 Oct 2020 05:30:24 +0800
Message-Id: <cover.1600940809.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290149
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 suspectscore=1 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290149
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

(Resend: I am marking all the patches as v2, not just 1/2).

v2: as in 1/2, 2/2 no change.

btrfs_find_device()'s last arg %seed is unused, which the commit
343694eee8d8 (btrfs: switch seed device to list api) ignored purposely
or missed.

But there isn't any regression due to that. And this series makes
it official that btrfs_find_device() doesn't need the last arg.

To achieve that patch 1/2 critically reviews the need for the check
disk_total_bytes == 0 in the function verify_one_dev_extent() and finds
that, the condition is never met and so deletes the same. Which also
drops one of the parents of btrfs_find_device() with the last arg false.

So only device_list_add() is using btrfs_find_device() with the last arg as
false, which the patch 2/2 finds is not required as well. So
this patch drops the last arg in btrfs_find_device() altogether.

Anand Jain (2):
  btrfs: drop never met condition of disk_total_bytes == 0
  btrfs: fix btrfs_find_device unused arg seed

 fs/btrfs/dev-replace.c |  4 ++--
 fs/btrfs/ioctl.c       |  4 ++--
 fs/btrfs/scrub.c       |  4 ++--
 fs/btrfs/volumes.c     | 37 ++++++++++---------------------------
 fs/btrfs/volumes.h     |  2 +-
 5 files changed, 17 insertions(+), 34 deletions(-)

-- 
2.25.1

