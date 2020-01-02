Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 633B812E4D5
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 11:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgABKNC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 05:13:02 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:40378 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbgABKNC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 05:13:02 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 002AAp6K149208
        for <linux-btrfs@vger.kernel.org>; Thu, 2 Jan 2020 10:13:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2019-08-05;
 bh=v1EVHUfCktQV6QFW/aPLB0d4L4auzEPSTCPFqsEnZXs=;
 b=EkcG5VRZq+4/Nzx7I1UPvhnWd2l2tXI9Okb78r3pLHl7DFFszSySUdMuhoqEOYmXE5i7
 2AEJGq46whlgfbBinxp8FoxdC9OBQitVUBgEannVfxy3AHsNMnoE7ka7rX62/fGlE/+T
 Y52yEq8YzQK0RjpcxUyi6D6nGJuFtBpQByo1OLQcV9qmyr5fggQN5y8+bmVLElxQD8YI
 v5/vDp8n6v91JlmJdpEkAmPHmAfwmCCTsYUA59AWLwiYeMy6SDi89JUZDKLq3vpCsSkZ
 YvivrPa/7Awf2embANLF45oVU2ukjK/DJUWz7oay4OAc+GshpzeEhkCaVBz9RNmCaovF 8g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2x5xftprda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 10:13:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 002A9atl039281
        for <linux-btrfs@vger.kernel.org>; Thu, 2 Jan 2020 10:13:00 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2x7meeqe2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 10:13:00 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 002ACxZR006563
        for <linux-btrfs@vger.kernel.org>; Thu, 2 Jan 2020 10:12:59 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Jan 2020 02:12:59 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] readmirror feature (sysfs and in-memory only approach)
Date:   Thu,  2 Jan 2020 18:12:45 +0800
Message-Id: <1577959968-19427-1-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9487 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001020092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9487 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001020092
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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


Anand Jain (3):
  btrfs: add readmirror type framework
  btrfs: sysfs, add readmirror kobject
  btrfs: sysfs, create by_pid readmirror attribute

 fs/btrfs/sysfs.c   | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c | 16 +++++++++++-
 fs/btrfs/volumes.h |  9 +++++++
 3 files changed, 98 insertions(+), 1 deletion(-)

-- 
1.8.3.1

