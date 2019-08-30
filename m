Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0EB3A31A9
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2019 09:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfH3H4B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Aug 2019 03:56:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36006 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfH3H4B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Aug 2019 03:56:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7U7rcgN103055
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Aug 2019 07:55:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : references
 : to : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=AYuHbr04sKa47ir3dzuNFPHqnnJFA8pjORIFJKi176g=;
 b=CW5q1azq/iJ+WB2Om2ywl2G5k7A43bHIlAOnC5YiXePb0uGgxgjA2oFaM62lTYMpaVX2
 awQVqjNKyvdIGk0m4+VgPU2Rym6lnEp0tmgJ8ekkEYt4N+YaRB/J5xfcVQRyU/lRTf5m
 eumbca28hNX/lCSXHsMclVva+qdAbOHgW3LMwIk8wtYO8tGfkbDVkPsZik0WJwOavQM4
 dUCtOr7sO57j+mJTDQ8yQrG/4YVCEPtA4SHgosxiw23NqGzJnJ9nm9DFiAl0RLMc0os2
 RwKaIRHt250yVe8FF/CyStnCN5by3biKaKm1EA8F1MvNKowhnu+Q5mt2VR0yDiW1XPkB 2w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2upyher4yn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Aug 2019 07:55:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7U7rG82105721
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Aug 2019 07:55:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2upkrg024j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Aug 2019 07:55:58 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7U7twao011166
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Aug 2019 07:55:58 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Aug 2019 00:55:58 -0700
Subject: Fwd: [PATCH v3] btrfs: LOGICAL_INO enhancements
References: <20170922175847.6071-1-ce3g8jdj@umail.furryterror.org>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Anand Jain <anand.jain@oracle.com>
X-Forwarded-Message-Id: <20170922175847.6071-1-ce3g8jdj@umail.furryterror.org>
Message-ID: <ff9fc698-7b62-6a85-fbdf-85e28979823d@oracle.com>
Date:   Fri, 30 Aug 2019 15:55:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20170922175847.6071-1-ce3g8jdj@umail.furryterror.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9364 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908300084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9364 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908300084
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


  I wonder what happened to the btrfs-progs part of this new ioctl

  #define BTRFS_IOC_LOGICAL_INO_V2 _IOWR(BTRFS_IOCTL_MAGIC, 59, \
				struct btrfs_ioctl_logical_ino_args)

  test result shows using it but I can't find it the btrfs-progs nor
  in the mailing list.

Thanks, Anand


-------- Forwarded Message --------
Subject: [PATCH v3] btrfs: LOGICAL_INO enhancements
Date: Fri, 22 Sep 2017 13:58:44 -0400
From: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To: linux-btrfs@vger.kernel.org
Newsgroups: org.kernel.vger.linux-btrfs

Changelog:

v3-v2:

	- Stricter check on reserved[] field - now must be all zero, or
	userspace gets EINVAL.	This prevents userspace from setting any
	of the reserved bits without the kernel providing an unambiguous
	interpretation of them, and doesn't require us to burn a flag
	bit for each one.

	- Moved 'flags' to the end of the reserved[] array.  This allows
	existing source code using version 1 of the ioctl to behave the
	same way when using version 2 of the btrfs_ioctl_logical_ino_args
	struct definition (i.e. reserved[3] becomes an alias for 'flags',
	and the addresses of reserved[0-2] don't change).

	- Clarified the reasoning in the commit message for patch 2,
	"btrfs: add a flags argument to LOGICAL_INO and call it LOGICAL_INO_V2".

v2:

	- added patch series intro text

	- rebased on 4.14-rc1.

v1:

This patch series fixes some weaknesses in the btrfs LOGICAL_INO ioctl.

Background:

Suppose we have a file with one extent:

     root@tester:~# zcat /usr/share/doc/cpio/changelog.gz > /test/a
     root@tester:~# sync

Split the extent by overwriting it in the middle:

     root@tester:~# cat /dev/urandom | dd bs=4k seek=2 skip=2 count=1 
conv=notrunc of=/test/a

We should now have 3 extent refs to 2 extents, with one block unreachable.
The extent tree looks like:

     root@tester:~# btrfs-debug-tree /dev/vdc -t 2
     [...]
             item 9 key (1103101952 EXTENT_ITEM 73728) itemoff 15942 
itemsize 53
                     extent refs 2 gen 29 flags DATA
                     extent data backref root 5 objectid 261 offset 0 
count 2
     [...]
             item 11 key (1103175680 EXTENT_ITEM 4096) itemoff 15865 
itemsize 53
                     extent refs 1 gen 30 flags DATA
                     extent data backref root 5 objectid 261 offset 8192 
count 1
     [...]

and the ref tree looks like:

     root@tester:~# btrfs-debug-tree /dev/vdc -t 5
     [...]
             item 6 key (261 EXTENT_DATA 0) itemoff 15825 itemsize 53
                     extent data disk byte 1103101952 nr 73728
                     extent data offset 0 nr 8192 ram 73728
                     extent compression(none)
             item 7 key (261 EXTENT_DATA 8192) itemoff 15772 itemsize 53
                     extent data disk byte 1103175680 nr 4096
                     extent data offset 0 nr 4096 ram 4096
                     extent compression(none)
             item 8 key (261 EXTENT_DATA 12288) itemoff 15719 itemsize 53
                     extent data disk byte 1103101952 nr 73728
                     extent data offset 12288 nr 61440 ram 73728
                     extent compression(none)
     [...]

There are two references to the same extent with different, non-overlapping
byte offsets:

     [------------------72K extent at 1103101952----------------------]
     [--8K----------------|--4K unreachable----|--60K-----------------]
     ^                                         ^
     |                                         |
     [--8K ref offset 0--][--4K ref offset 0--][--60K ref offset 12K--]
                          |                                  v
                          [-----4K extent-----] at 1103175680

We want to find all of the references to extent bytenr 1103101952.

Without the patch (and without running btrfs-debug-tree), we have to
do it with 18 LOGICAL_INO calls:

     root@tester:~# btrfs ins log 1103101952 -P /test/
     Using LOGICAL_INO
     inode 261 offset 0 root 5

     root@tester:~# for x in $(seq 0 17); do btrfs ins log $((1103101952 
+ x * 4096)) -P /test/; done 2>&1 | grep inode
     inode 261 offset 0 root 5
     inode 261 offset 4096 root 5   <- same extent ref as offset 0
                                    (offset 8192 returns empty set, not 
reachable)
     inode 261 offset 12288 root 5
     inode 261 offset 16384 root 5  \
     inode 261 offset 20480 root 5  |
     inode 261 offset 24576 root 5  |
     inode 261 offset 28672 root 5  |
     inode 261 offset 32768 root 5  |
     inode 261 offset 36864 root 5  \
     inode 261 offset 40960 root 5   > all the same extent ref as offset 
12288.
     inode 261 offset 45056 root 5  /  More processing required in userspace
     inode 261 offset 49152 root 5  |  to figure out these are all 
duplicates.
     inode 261 offset 53248 root 5  |
     inode 261 offset 57344 root 5  |
     inode 261 offset 61440 root 5  |
     inode 261 offset 65536 root 5  |
     inode 261 offset 69632 root 5  /

In the worst case the extents are 128MB long, and we have to do 32768
iterations of the loop to find one 4K extent ref.

With the patch, we just use one call to map all refs to the extent at once:

     root@tester:~# btrfs ins log 1103101952 -P /test/
     Using LOGICAL_INO_V2
     inode 261 offset 0 root 5
     inode 261 offset 12288 root 5

The TREE_SEARCH ioctl allows userspace to retrieve the offset and
extent bytenr fields easily once the root, inode and offset are known.
This is sufficient information to build a complete map of the extent
and all of its references.  Userspace can use this information to make
better choices to dedup or defrag.
