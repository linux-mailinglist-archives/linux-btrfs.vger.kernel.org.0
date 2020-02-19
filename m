Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7273416435C
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 12:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgBSL3n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 06:29:43 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57372 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgBSL3n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 06:29:43 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JBSnlQ075636;
        Wed, 19 Feb 2020 11:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=xrtQ0d4SxKUHlMbwchgrArMhRW3Drb5uyljLimYxG+g=;
 b=aqwp/ZCoW5HdOQbv+BMQlOUQT8Rf66EVjarqE7xIz5ixsV4HVFg2S4V7YqDD3P3pUG9G
 QSUXHxd6tSK2czcn4uI2QUZmFb27azgYWluVHfNru0CXUygoQVGaeDUHgPv5P+1SQBTm
 6trE5GPSrEhnp2W+6LYT9pj5BjLzIaysCYv5G5wcAouXyenG1xikRBPO9b6lk1ChT6N5
 zf3wF794hkqWOrpCBAEruoHAhxAHZJt7RjqQ9+SBEDo4Og3jdwLKYozU2mZzt8lrse53
 I42u/58GxGkmAD3wt01mki2b3h5ZrGD9bc9wjEUfj3Q7aGFfVUISwzrE6ke9QAcNotYT lg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2y8udd2c7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 11:29:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JBRt68052460;
        Wed, 19 Feb 2020 11:29:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2y8ud0xrfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 11:29:38 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01JBTbM1023422;
        Wed, 19 Feb 2020 11:29:37 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Feb 2020 03:29:36 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.cz
Subject: [PATCH v6 0/5] readmirror feature (sysfs and in-memory only approach; with new read_policy device)
Date:   Wed, 19 Feb 2020 19:29:21 +0800
Message-Id: <1582111766-8372-1-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190087
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


v6:
Patch 4/5 - If there is no change in device's read prefer then don't log
Patch 4/5 - Add pid to the logs
Patch 5/5 - If there isn't read preferred device in the chunk don't reset
read policy to default, instead just use stripe 0. As this is in
the read path it avoids going through the device list to find
read preferred device. So inline to this drop to check if there
is read preferred device before setting read policy to device.

About new read_policy type 'device':

This patch introduces read-policy type 'device'. The 'device'
read-policy picks the device(s) flagged as read-preferred for reading
for raid1, raid10, raid1c3 and raid1c4 block groups.

The default read policy is pid which can be changed to device as below.

$ pwd
/sys/fs/btrfs/12345678-1234-1234-1234-123456789abc

$ cat read_policy; echo device > ./read_policy; cat read_policy
[pid] device
pid [device]

One or more devices which are favored for reading should set the flag
read-preferred. In an example below a typical two disk raid1, devid1 is
configured as read preferred.

$ echo 1 > devinfo/1/read_preferred
$ cat devinfo/1/read_preferred; cat devinfo/2/read_preffered
1
0

So now when the file is read, the read IO would prefer device(s) with
read_preferred flags for reading.

$ echo 3 > /proc/sys/vm/drop_caches; md5sum /btrfs/YkZI

Since the devid 1 (sdb) is our read preferred device, the reads are set
to sdb only.
$ iostat -zy 1 | egrep 'sdb|sdc' (from another terminal)
sdb              50.00     40048.00         0.00      40048          0

$ echo 0 > ./devinfo/1/read_preferred; echo 1 > ./devinfo/2/read_preferred;

[ 3343.918658] BTRFS info (device sdb): reset read preferred on devid 1 (1334)
[ 3343.919876] BTRFS info (device sdb): set read preferred on devid 2 (1334)

$ echo 3 > /proc/sys/vm/drop_caches; md5sum /btrfs/YkZI

Since now we changed the read preferred from devid 1 (sdb) to 2 (sdc),
now all the read IO goes to sdc.

$ iostat -zy 1 | egrep 'sdb|sdc' (from another terminal)
sdc              49.00     40048.00         0.00      40048          0

Whenever there isn't any read preferred device(s) or if more than one
stripe is marked as read preferred device then this read policy shall
use the stripe 0 for reading.

The command
 $ echo pid > ./read_policy
goes back to the pid read policy type.

As of now this is in memory only feature which means after a unmount
mount cycle the configuration will be lost and has to be configured
again.

FAQ:
You could set read_preferred on a missing device, why?
We still have the unfinished jobs - reappearing missing device,
persistent read policy, as there isn't any harm in allowing it lets not
block it for now. Moreover read policy by device is an advance level
tuning, its just a matter of time that the user learning to use it
correctly.

Does it carry forward read preferred flag to the replace target device
if the replace source is flags are read preferred ?
No. As it is a device specific flag it has to be configured again, like
for example if the ssd is replace to a HDD we don't want to mark that as
read preferred and cause the read IO slowness.

What happens when there are more than one read preferred device in a
chunk:
Then as of now it shall chose the stripe 0, however when we integrate
qdepth based read policy we can use the qdepth based routing among the
read preferred devices.

When does it still read the non preferred device in case of 2 disk
raid1?
Only when read from the preferred device fails with EIO or csum error.

Why can't we set all the non-rotational device as read preferred device
automatically with in the kernel.
A system might contain ssd, nvme, iscsi or san lun, all of these devices
are non-rotational devices. However if the system admin favors certain
device for the reading he can definitely configure. Further this advance
tuning comes handy for testing. For example test cases such as btrfs/140
btrfs/141... etc.


Original cover letter:

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

 fs/btrfs/sysfs.c   | 128 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c |  37 +++++++++++++++-
 fs/btrfs/volumes.h |  16 +++++++
 3 files changed, 180 insertions(+), 1 deletion(-)

-- 
1.8.3.1

