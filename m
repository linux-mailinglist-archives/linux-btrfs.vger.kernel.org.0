Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30431114048
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 12:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfLELpX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 06:45:23 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53444 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbfLELpW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Dec 2019 06:45:22 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB5BiCfm087784;
        Thu, 5 Dec 2019 11:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=nRANXrsDTsD7xIMu4tluBIrH6GvudrSNtwIqGV8OijY=;
 b=FI/qzIJlroPgo9emTAFRqzgUNOi3U8wJESd8mqRzyRU+05SvXDu3yX6isYr5hO9xc/zK
 ps2jf6y5Cxolm8tR5MSIHk0Y3xFGUOKxBEZHDnvBZxd2KS+qIIN2cVlyctklZZFStv+u
 pbXnTw/TAR18xTrGspI5cRgY/ZrhBElX3hQe4IZYAu/7/0FgigDtoeVG+CNhtdaCdSzF
 lzbSBYLJqT+8F4Y3IjZWv76oyEx6rGslYcYxQ1VDEKJGmNwoIhzyM1b7SLPcOqHFGYeG
 6lnbkUnGzl24T3d0qdMnh6j/giR879vqLfYdr/b1G2EJ+dgSkMtNVmfztou3qyxo4xZU kA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2wkgcqmhgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Dec 2019 11:45:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB5BdAAh108500;
        Thu, 5 Dec 2019 11:45:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2wpp740a74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Dec 2019 11:45:19 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB5BjIX2032265;
        Thu, 5 Dec 2019 11:45:18 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Dec 2019 03:45:18 -0800
Subject: Re: [PATCH v3] btrfs: fix warn_on for send from readonly mount
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20191202094450.1377-1-anand.jain@oracle.com>
 <20191205113907.8269-1-anand.jain@oracle.com>
 <CAL3q7H635MDHBAEA0UZZKOn6kz=Hwna2YyM7RLZ=MbYqJOcimQ@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <7b4f1318-eb0f-8d1d-7ea4-c2d7bce93df4@oracle.com>
Date:   Thu, 5 Dec 2019 19:45:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL3q7H635MDHBAEA0UZZKOn6kz=Hwna2YyM7RLZ=MbYqJOcimQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912050097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912050098
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5/12/19 7:43 PM, Filipe Manana wrote:
> On Thu, Dec 5, 2019 at 11:39 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> We log warning if root::orphan_cleanup_state is not set to
>> ORPHAN_CLEANUP_DONE in btrfs_ioctl_send(). However if the filesystem is
>> mounted as readonly we skip the orphan items cleanup during the lookup
>> and root::orphan_cleanup_state remains at the init state 0 instead of
>> ORPHAN_CLEANUP_DONE (2). So during send in btrfs_ioctl_send() we hit
>> the warning as below.
>>
>>    WARN_ON(send_root->orphan_cleanup_state != ORPHAN_CLEANUP_DONE);
>>
>> WARNING: CPU: 0 PID: 2616 at /Volumes/ws/btrfs-devel/fs/btrfs/send.c:7090 btrfs_ioctl_send+0xb2f/0x18c0 [btrfs]
>> ::
>> RIP: 0010:btrfs_ioctl_send+0xb2f/0x18c0 [btrfs]
>> ::
>> Call Trace:
>> ::
>> _btrfs_ioctl_send+0x7b/0x110 [btrfs]
>> btrfs_ioctl+0x150a/0x2b00 [btrfs]
>> ::
>> do_vfs_ioctl+0xa9/0x620
>> ? __fget+0xac/0xe0
>> ksys_ioctl+0x60/0x90
>> __x64_sys_ioctl+0x16/0x20
>> do_syscall_64+0x49/0x130
>> entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> Reproducer:
>>    mkfs.btrfs -fq /dev/sdb && mount /dev/sdb /btrfs
>>    btrfs subvolume create /btrfs/sv1
>>    btrfs subvolume snapshot -r /btrfs/sv1 /btrfs/ss1
>>    umount /btrfs && mount -o ro /dev/sdb /btrfs
>>    btrfs send /btrfs/ss1 -f /tmp/f
>>
>> The warning exists because having orphan inodes could confuse send
>> and cause it to fail or produce incorrect streams.
>> The two cases that would cause such send failures, which are already
>> fixed are:
>>
>> 1) Inodes that were unlinked - these are orphanized and remain with a link
>> count of 0. These caused send operations to fail because it expected to
>> always find at least one path for an inode. However this is no longer a
>> problem since send is now able to deal with such inodes since commit
>> 46b2f4590aab ("Btrfs: fix send failure when root has deleted files still
>> open") and treats them as having been completely removed (the state after
>> a orphan cleanup is performed).
>>
>> 2) Inodes that were in the process of being truncated. These resulted in
>> send not knowing about the truncation and potentially issue write
>> operations full of zeroes for the range from the new file size to the old
>> file size. This is no longer a problem because we no longer create orphan
>> items for truncation since commit f7e9e8fc792f ("Btrfs: stop creating
>> orphan items for truncate").
>>
>> As such before these commits, the WARN_ON here provided a clue in case
>> something went wrong. Instead of being a warning against the
>> root::orphan_cleanup_state value, it could have been more accurate by
>> checking if there were actually any orphan items, and then issue a warning
>> only if any exists, but that would be more expensive to check. Since
>> orphanized inodes no longer cause problems for send, just remove the warning.
>>
>> Reported-by: Christoph Anton Mitterer <calestyo@scientia.net>
>> Link: https://lore.kernel.org/linux-btrfs/21cb5e8d059f6e1496a903fa7bfc0a297e2f5370.camel@scientia.net/
>> Suggested-by: Filipe Manana <fdmanana@gmail.com>
> 
> s/gmail.com/suse.com/
> (David can probably do that when he picks the patch)
> 
  Oh. Sorry I missed it. Thanks, Anand

> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> Thanks
> 
>> [ Remove warn_on() part, and its reasoning ]
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v3: Commit log updated.
>> v2: Remove WARN_ON() completely.
>>   fs/btrfs/send.c | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
>> index ae2db5eb1549..091e5bc8c7ea 100644
>> --- a/fs/btrfs/send.c
>> +++ b/fs/btrfs/send.c
>> @@ -7084,12 +7084,6 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
>>          spin_unlock(&send_root->root_item_lock);
>>
>>          /*
>> -        * This is done when we lookup the root, it should already be complete
>> -        * by the time we get here.
>> -        */
>> -       WARN_ON(send_root->orphan_cleanup_state != ORPHAN_CLEANUP_DONE);
>> -
>> -       /*
>>           * Userspace tools do the checks and warn the user if it's
>>           * not RO.
>>           */
>> --
>> 1.8.3.1
>>
> 
> 
