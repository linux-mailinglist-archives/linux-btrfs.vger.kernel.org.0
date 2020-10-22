Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9014295985
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Oct 2020 09:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507161AbgJVHpy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Oct 2020 03:45:54 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35142 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507100AbgJVHpy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Oct 2020 03:45:54 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09M7iuI6044904;
        Thu, 22 Oct 2020 07:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=YV637WPGIqgAPfvYHrYczR1bMVu3Kkpw4GKTLUzL9oM=;
 b=v9IuM25Uv3GZeNKW0Hqy3BwssbYVhNr3EN+++Gn84UXHmz7WPU+xsouS64wRXNsL3oaw
 kzldYsnaLAA+BKqtXIuqbb8UsG68THlyix3dnrYmGG+Wcogxc28cAZnKoWNlUWi+prch
 k0JyoIQRZsiA2KU6Oa8QJlb2xTQp8LFNAoibJBnAi5PPMn3aVEL5SVQqUpFDvB8Q8b49
 ZlcETXMY2vvYbUIQntZNnr1RWgojOMO5yxBNMPUaOji5XTl3WHBCkLvQp/2aqJtNdlqK
 BxyULLMcQ4PDITtBivCRA4Uya4RFa5hgGV1KdLVP2vfLP3EjoD5NZbqPdfZ42slfoPD+ Xg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 347p4b4f60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Oct 2020 07:45:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09M7a87u176638;
        Thu, 22 Oct 2020 07:43:48 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 348a6qaa0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Oct 2020 07:43:48 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09M7hkjo012590;
        Thu, 22 Oct 2020 07:43:46 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 22 Oct 2020 00:43:46 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com
Subject: [PATCH v9 0/3] readmirror feature (read_policy sysfs and in-memory only approach)
Date:   Thu, 22 Oct 2020 15:43:34 +0800
Message-Id: <cover.1603347462.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010220049
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010220050
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v9: C coding style fixes in 1/3 and 3/3

v8:
Separate the sysfs framework and the %pid read_policy into a separate
patchset here, so that the new read policies can be in its own patch set.

A latency based read_policy is being prepared to send it in a separate
patchset as it depends on a few changes in the block layer as well.

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

 fs/btrfs/sysfs.c   | 69 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c | 15 +++++++++-
 fs/btrfs/volumes.h | 14 ++++++++++
 3 files changed, 97 insertions(+), 1 deletion(-)

-- 
2.25.1

