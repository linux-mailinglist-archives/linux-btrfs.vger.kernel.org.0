Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DA11BC35E
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Apr 2020 17:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgD1PYn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Apr 2020 11:24:43 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53240 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgD1PYl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Apr 2020 11:24:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SFIoNA061899;
        Tue, 28 Apr 2020 15:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=x5HfnPaKuQVTvW8xZop/YULtAHrAaNSOGqHzm+EzxQA=;
 b=JKwGh2iHMNwCpxOCyoKFbWemAiCZFKRaaIdBTv9IOm9/QaYfxOz5v788HqlFms1x7ZDD
 NCsBhNMlGgQ9iVqmYn2R+hU9PJrldANn014rhD8P314nKvlvbEJ7OcNdhdaIhBhr4Ik2
 iWmehQv7JzQHH4D62KHerJvy7JpbvesdHDKjjjmum6EtQf8paQovuQhMhGm7XOR3uewl
 Yj+yOEuXbSs5Y0lVZ7feBWnkhpINcm0Dp7h0nyI7hBL/ZpJhgarRNiTzHnAHHxMcoTpi
 54H3bCmbDmIMViBTZZXA5SoNk1VXK138SwHUlMRKPmf7pHZSKm8PB+Gm4HsBQ1tmO6Ll LQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 30nucg0nef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 15:24:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SFD1Dq134136;
        Tue, 28 Apr 2020 15:22:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 30my0ded47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 15:22:35 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03SFMYl0004774;
        Tue, 28 Apr 2020 15:22:34 GMT
Received: from localhost.localdomain (/39.109.243.230)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 08:22:32 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, nborisov@suse.com, josef@toxicpanda.com
Subject: [PATCH v3 REBASED 0/3] btrfs: fix issues due to alien device
Date:   Tue, 28 Apr 2020 23:22:24 +0800
Message-Id: <20200428152227.8331-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=3 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=3 malwarescore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280120
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v3 REBASED: Based on the latest misc-next. for for-5.8.
   Dropped the following patches as there were concerns about the usage
   of error code -EUCLEAN
	btrfs: remove identified alien device in open_fs_devices
	btrfs: remove identified alien btrfs device in open_fs_devices

   Rmaining 3 patches here have obtained reviewed-by. With this pathset
   the pertaining fstests btrfs/197 and btrfs/198 (which tests 3 bugs)
   would pass as the patch 2/3 fixed a bug and 3/3 fixed the trigger
   of 2 other bugs (patch 1/3 is just a cleanup). Further at the moment
   I am not sure if there is any other trigger where it could again leave
   an alien device in the fs_devices leading to the same/similar bugs.

==== original email ====
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

Anand Jain (3):
  btrfs: drop useless goto in open_fs_devices
  btrfs: include non-missing as a qualifier for the latest_bdev
  btrfs: free alien device due to device add

 fs/btrfs/volumes.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

-- 
2.23.0

