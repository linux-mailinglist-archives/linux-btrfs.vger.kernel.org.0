Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C814293E12
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Oct 2020 16:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407798AbgJTODF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Oct 2020 10:03:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44542 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407712AbgJTODF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Oct 2020 10:03:05 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09KDwdJl020105;
        Tue, 20 Oct 2020 14:03:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=eobv3PY8OjPoZ5KXBw3yJqsO+e4MlMEoXYGVDtXqV54=;
 b=ivhnKOkiwTdIrkMamJluBc/eFF67cCkqgspf0iShmzZlxzJiWw/PCkwIPjE5d+lQMtM4
 b9qAFQtQMyPyB/+26phfDJFYfpTOLepsaYkO4BP4R7a1tZ7qCxmFkn1R5Mnc+inW4vzr
 x+czFt1NMLcUtgajUxKajmhytH/ixukwkU8CEWYelaBFaNfmAXtsxMgZ6LKcnG3E1zN4
 U2XNuCwWWysJh8Ar/M/9GGetDi14cgFKXLdm9/AoC1czizWqiBS0REc21RGJk3nCgn4/
 oLpYiFVlD/zvFnwF8oEL2uZU37KG8JGbivfVeD/Yz9CfHY3Gbsm9ArPTI7u55DAtajtx vA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 349jrpkcu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Oct 2020 14:03:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09KE04o5112551;
        Tue, 20 Oct 2020 14:03:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 348a6n6mdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Oct 2020 14:03:00 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09KE30YQ008764;
        Tue, 20 Oct 2020 14:03:00 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 20 Oct 2020 07:02:57 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v8 0/3] readmirror feature (read_policy sysfs and
Date:   Tue, 20 Oct 2020 22:02:12 +0800
Message-Id: <cover.1602756068.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9779 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010200095
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9779 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010200095
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v8:
Separate the sysfs framework and the %pid read_policy into a separate
patchset here, so that the new read policies can be in its own patch set. 
Use fallthrough; instead of comments.

__ Original email: __

v7:
Fix switch's fall through warning. Changle logs updates where necessary.

v6:
Patch 4/5 - If there is no change in device's read prefer then don't log
Patch 4/5 - Add pid to the logs
Patch 5/5 - If there isn't read preferred device in the chunk don't reset
read policy to default, instead just use stripe 0. As this is in
the read path it avoids going through the device list to find
read preferred device. So inline to this drop to check if there
is read preferred device before setting read policy to device.

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

Anand Jain (3):
  btrfs: add btrfs_strmatch helper
  btrfs: create read policy framework
  btrfs: create read policy sysfs attribute, pid

 fs/btrfs/sysfs.c   | 72 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c | 15 +++++++++-
 fs/btrfs/volumes.h | 14 +++++++++
 3 files changed, 100 insertions(+), 1 deletion(-)

-- 
2.25.1

