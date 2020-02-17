Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2032D1610C5
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 12:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgBQLNC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 06:13:02 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33696 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgBQLNC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 06:13:02 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01HB34Tb155619;
        Mon, 17 Feb 2020 11:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=ZmRVs+kgSdE4AVul1HudBn2b4d/ETDj/p1KDRCpOVo4=;
 b=Tm4w5iqB9TukJcHK3hSDGCxQ5Wi0eIYWSN/kQQtUa6TD/HCt/0eCANBdUlugjLiLD9dG
 PtbgWe/s8zgi1OFACCNf8x7uBvA5Mz+ybcMZ0UBs40tqh9x9VmIR+tCJItdxqnUWnyLL
 MT3gwKz5ZX+HlLDS2XlBfYFyY+NEDjun/zlhKLCtzTrR7aa0mxKdNPGAa+6nX4tawF04
 hsuGioTTsLJsGEXC1ZoXPSpYM8u/uleZ9Q5f+i8/zTu2ez1jLPXveBdKCU494FphCFeI
 ERQfiA3MFMr32T4/mzSVOV7FGh6tqO2oEjwbvAYrdpZQ7TyuOpXCKHakcjna3u+BDUeS Jw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2y68kqqmm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Feb 2020 11:12:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01HBC6De086820;
        Mon, 17 Feb 2020 11:12:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2y6t6thkfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Feb 2020 11:12:56 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01HBCtxQ007780;
        Mon, 17 Feb 2020 11:12:55 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Feb 2020 03:12:54 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com
Subject: [PATCH v5 0/5] readmirror feature (sysfs and in-memory only approach; with new read_policy device)
Date:   Mon, 17 Feb 2020 19:12:40 +0800
Message-Id: <1581937965-16569-1-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9533 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002170097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9533 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002170096
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v5:
Worked on review comments as received in its previous version.
Please refer to individual patches for the specific changes.
Introduces the new read_policy 'device'.

v4:
Rename readmirror attribute to read_policy. Drop separate kobj for
readmirror instead create read_policy attribute in fsid kobj.
merge v2:2/3 and v2:3/3 into v4:2/2. Patch titles have changed.
 
v3:
v2:
Mainly fixes the fs_devices::readmirror declaration type from atomic_t
to u8. (Thanks Josef).

v1:
As of now we use only %pid method to read stripped mirrored data. So
application's process id determines the stripe id to be read. This type
of routing typically helps in a system with many small independent
applications tying to read random data. On the other hand the %pid
based read IO distribution policy is inefficient if there is a single
application trying to read large data as because the overall disk
bandwidth would remains under utilized.

One type of readmirror policy isn't good enough and other choices are
routing the IO based on device's waitqueue or manual when we have a
read-preferred device or a readmirror policy based on the target storage
caching. So this patch-set introduces a framework where we could add more
readmirror policies.

This policy is a filesystem wide policy as of now, and though the
readmirror policy at the subvolume level is a novel approach as it
provides maximum flexibility in the data center, but as of now its not
practical to implement such a granularity as you can't really ensure
reflinked extents will be read from the stripe of its desire and so
there will be more limitations and it can be assessed separately.

The approach in this patch-set is sys interface with in-memory policy.
And does not add any new readmirror type in this set, which can be add
once we are ok with the framework. Also the default policy remains %pid.

Previous works:
----------------------------------------------------------------------
There were few RFCs [1] before, mainly to figure out storage
(or in memory only) for the readmirror policy and the interface needed.

[1]
https://www.mail-archive.com/linux-btrfs@vger.kernel.org/msg86368.html

https://lore.kernel.org/linux-btrfs/20190826090438.7044-1-anand.jain@oracle.com/

https://lore.kernel.org/linux-btrfs/5fcf9c23-89b5-b167-1f80-a0f4ac107d0b@oracle.com/

https://patchwork.kernel.org/cover/10859213/

Mount -o:
In the first trial it was attempted to use the mount -o option to carry
the readmirror policy, this is good for debugging which can make sure
even the mount thread metadata tree blocks are read from the disk desired.
It was very effective in testing radi1/raid10 write-holes.

Extended attribute:
As extended attribute is associated with the inode, to implement this
there is bit of extended attribute abuse or else makes it mandatory to
mount the rootid 5. Its messy unless readmirror policy is applied at the
subvol level which is not possible as of now. 

An item type:
The proposed patch was to create an item to hold the readmirror policy,
it makes sense when compared to the abusive extended attribute approach
but introduces a new item and so no backward compatibility.
-----------------------------------------------------------------------


Anand Jain (5):
  btrfs: add btrfs_strmatch helper
  btrfs: create read policy framework
  btrfs: create read policy sysfs attribute, pid
  btrfs: introduce new device-state read_preferred
  btrfs: introduce new read_policy device

 fs/btrfs/sysfs.c   | 145 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c |  45 ++++++++++++++++-
 fs/btrfs/volumes.h |  16 ++++++
 3 files changed, 205 insertions(+), 1 deletion(-)

-- 
1.8.3.1

