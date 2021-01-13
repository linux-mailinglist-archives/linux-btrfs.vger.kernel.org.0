Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD282F4A03
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jan 2021 12:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbhAMLXE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jan 2021 06:23:04 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42782 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbhAMLXE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jan 2021 06:23:04 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10DBJCUo155891;
        Wed, 13 Jan 2021 11:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2020-01-29;
 bh=Z7eS4mLjVr/D+/UnydhY5ds+kvVXRR1V5nagix4uf+I=;
 b=H9NBxk6qpKRIlbYm08EWDoOp7FknbK6j9/T7gt2Jx6LYvDSyYJMOiQ37OMl5WTxgIu1i
 0lC29CqbRtVrV/b6oMMifqxZfAzn4TY56rbGsBBy07HtOY9j60pogLJT96DHFX5vnkgd
 Q367Qz9YDOZm8wB5q7rSC5qYEsj/kMhzCvWo5xsEqYYtatjQ3sSQDeSrGDGHjKnO0U5n
 bNDLju0iFuvCdCrl7/XqiDkIXSn25FpUozgsnqsiUyyTCyURrvf1F/M0hY66DxuOH//B
 h/uNrv8tnWFcecJulsOh+PpZgef1MAaFtvnWvz8cx1SAtJge+TMGsjtDNh6rjyvGzq3k 4g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 360kvk2vbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jan 2021 11:22:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10DBK9To016179;
        Wed, 13 Jan 2021 11:22:20 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 360kf0e3ct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jan 2021 11:22:20 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10DBMHqm011955;
        Wed, 13 Jan 2021 11:22:18 GMT
Received: from [192.168.10.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Jan 2021 03:22:17 -0800
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH RFC] btrfs: no need to transition to rdonly for ENOSPC
 error
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <169ba15cd316c181042bbe25e7d10c7963e3b7e8.1610444879.git.anand.jain@oracle.com>
 <c5ccc5d5-c9e4-16ff-0b57-3b7dd2f3dfca@toxicpanda.com>
Message-ID: <d6dcaeec-d227-fc97-13d9-ad9f143dc103@oracle.com>
Date:   Wed, 13 Jan 2021 19:22:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <c5ccc5d5-c9e4-16ff-0b57-3b7dd2f3dfca@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101130069
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101130069
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/1/21 10:41 pm, Josef Bacik wrote:
> On 1/12/21 5:34 AM, Anand Jain wrote:
>> In the current kernel both scrub and balance fails due to ENOSPC,
>> however there is no reason that it should be transitioned to the
>> RDONLY and making free spaces difficult.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/super.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index 12d7d3be7cd4..8c1b858f55c4 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -172,6 +172,9 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info 
>> *fs_info, const char *function
>>       if (sb_rdonly(sb))
>>           return;
>> +    if (errno == -ENOSPC)
>> +        return;
>> +
>>       btrfs_discard_stop(fs_info);
>>       /* btrfs handle error by forcing the filesystem readonly */
>>
> 
> Filipe and Qu are right, but there are cases where we probably shouldn't 
> flip read only on ENOSPC, and we should address those at the specific 
> spots where this happens.  Do you have an example?  If it's happening at 
> btrfs_search_slot() time then we're not reserving enough space in 
> whatever reserve we use, but if it's happening somewhere else, for 
> example trying to mark a block group as read only and getting an ENOSPC 
> there, we could probably skip flipping read only for that sort of case.  
> We need to address the specific scenarios you're hitting rather than 
> blanket skipping the abort for ENOSPC, otherwise we'll get corrupt file 
> systems.  Thanks,
> 

Ok. It makes sense to me.

Unfortunately, I had to restore my laptop, my only source of production.

Per the stack trace below, ENOSPC is from the search.

[ 2460.219094] BTRFS info (device sdb6): balance: start -f 
-dconvert=single -mconvert=single -sconvert=single
[ 2460.219224] BTRFS info (device sdb6): relocating block group 
194572713984 flags data
[ 2460.241299] ------------[ cut here ]------------
[ 2460.241302] BTRFS: Transaction aborted (error -28)
[ 2460.241328] WARNING: CPU: 3 PID: 4135 at fs/btrfs/volumes.c:3003 
btrfs_remove_chunk+0x60e/0x6c0 [btrfs]
::
[ 2460.241447] RIP: 0010:btrfs_remove_chunk+0x60e/0x6c0 [btrfs]
::
[ 2460.241497] Call Trace:
[ 2460.241500]  btrfs_relocate_chunk+0x9d/0xd0 [btrfs]
[ 2460.241533]  __btrfs_balance+0x413/0xa30 [btrfs]
[ 2460.241566]  btrfs_balance+0x436/0x4d0 [btrfs]
[ 2460.241597]  btrfs_ioctl_balance+0x2d5/0x380 [btrfs]
[ 2460.241647]  btrfs_ioctl+0x565/0x22b0 [btrfs]
[ 2460.241693]  ? selinux_file_ioctl+0x174/0x220
[ 2460.241698]  ? handle_mm_fault+0xd7/0x2b0
[ 2460.241702]  __x64_sys_ioctl+0x91/0xc0
[ 2460.241705]  ? __x64_sys_ioctl+0x91/0xc0
[ 2460.241707]  do_syscall_64+0x38/0x50
[ 2460.241711]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
::
[ 2460.241735] ---[ end trace 95b8b7b84503a477 ]---
[ 2460.241738] BTRFS: error (device sdb6) in btrfs_remove_chunk:3003: 
errno=-28 No space left
[ 2460.241743] BTRFS info (device sdb6): forced readonly
[ 2460.242646] BTRFS info (device sdb6): 1 enospc errors during balance
[ 2460.242649] BTRFS info (device sdb6): balance: ended with status: -30


btrfs fi us /Volumes/
Overall:
     Device size:         154.97GiB
     Device allocated:         154.97GiB
     Device unallocated:           2.00MiB
     Device missing:             0.00B
     Used:             147.91GiB
     Free (estimated):           2.75GiB    (min: 2.75GiB)
     Data ratio:                  1.99
     Metadata ratio:              1.52
     Global reserve:         183.72MiB    (used: 0.00B)

Data,single: Size:894.00MiB, Used:0.00B (0.00%)
    /dev/sdb6     894.00MiB

Data,RAID1: Size:75.53GiB, Used:73.23GiB (96.96%)
    /dev/sdb6      75.53GiB
    /dev/sdc2      75.53GiB

Metadata,single: Size:964.00MiB, Used:0.00B (0.00%)
    /dev/sdb6     964.00MiB

Metadata,RAID1: Size:1.00GiB, Used:737.25MiB (72.00%)
    /dev/sdb6       1.00GiB
    /dev/sdc2       1.00GiB

System,single: Size:32.00MiB, Used:0.00B (0.00%)
    /dev/sdb6      32.00MiB

System,RAID1: Size:32.00MiB, Used:16.00KiB (0.05%)
    /dev/sdb6      32.00MiB
    /dev/sdc2      32.00MiB

Unallocated:
    /dev/sdb6       1.00MiB
    /dev/sdc2       1.00MiB
--------


But below is another ENOSPC leading rdonlyfs. Here it was during the 
scrub. And while trying to finish the ordered extents.


[ 2365.314375] ------------[ cut here ]------------
[ 2365.314385] BTRFS: Transaction aborted (error -28)
[ 2365.314470] WARNING: CPU: 2 PID: 4672 at fs/btrfs/inode.c:2823 
btrfs_finish_ordered_io+0x8e6/0x950 [btrfs]
<snap>
[ 2365.314921] CPU: 2 PID: 4672 Comm: kworker/u8:11 Not tainted 
5.11.0-rc2+ #3
[ 2365.314933] Hardware name: LENOVO 20FAS6PN00/20FAS6PN00, BIOS 
N1CET47W (1.15 ) 08/08/2016
[ 2365.314939] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
[ 2365.315093] RIP: 0010:btrfs_finish_ordered_io+0x8e6/0x950 [btrfs]
<snap>
[ 2365.315290] Call Trace:
[ 2365.315309] BTRFS warning (device sda6): 
btrfs_finish_ordered_io:2823: Aborting unused transaction(No space left).
[ 2365.315305]  finish_ordered_fn+0x15/0x20 [btrfs]
[ 2365.315532]  btrfs_work_helper+0xcc/0x2f0 [btrfs]
[ 2365.315763]  process_one_work+0x1ee/0x390
[ 2365.315781]  worker_thread+0x50/0x3d0
[ 2365.315797]  kthread+0x114/0x150
[ 2365.315811]  ? process_one_work+0x390/0x390
[ 2365.315824]  ? kthread_park+0x90/0x90
[ 2365.315836]  ret_from_fork+0x22/0x30
[ 2365.315861] ---[ end trace b0e289a2c3d424e8 ]---
[ 2365.315871] BTRFS warning (device sda6): 
btrfs_finish_ordered_io:2823: Aborting unused transaction(No space left).
[ 2365.316713] BTRFS warning (device sda6): 
btrfs_finish_ordered_io:2823: Aborting unused transaction(No space left).
[ 2365.316796] BTRFS warning (device sda6): Skipping commit of aborted 
transaction.
[ 2365.316809] BTRFS: error (device sda6) in cleanup_transaction:1938: 
errno=-30 Readonly filesystem
[ 2365.316824] BTRFS info (device sda6): forced readonly
[ 2365.359195] BTRFS info (device sda6): scrub: not finished on devid 2 
with status: -125

-Anand

> Josef

