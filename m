Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5217D10EB54
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2019 15:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfLBOH7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Dec 2019 09:07:59 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:44042 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbfLBOH7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Dec 2019 09:07:59 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB2DsmLs027909;
        Mon, 2 Dec 2019 14:07:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=bMV1ou6qVD4Zkz1HUnw9v2qg+N5tvQbnCYyv/O6Xhng=;
 b=g7z4XcZ5MJ9C8IED5x984oZjIYLe/cep/LSuaAp0ysmIWwTTYHy4h+EJN8Td/E9EOFng
 Ldbw7LDMiyO7B6sVTqO57kCceBIo31bJxL2XKXFc1AFh8X/CxeesBx7ig059nEWVQEAu
 IEagq1JNO7/715lEVTpcNEYuh6BmanQ4C9KWQEU5kTXLq2dRDro/nU7z33lxRwv4V651
 3iC7pV1tuaX0Qu0sioGe3E+uCOqb5qXc592RZ5k6wtUuMEG/BwqoC5AiGOiW49gLcvg8
 dAWa5K5f3qc2eEI/hfTR3BhkN+x0hoXNvXGgbfPAgPvFE3x9Fjt3C4UFQBiHvsD/dvON Xg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2wkh2r02v1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Dec 2019 14:07:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB2DxS7R027457;
        Mon, 2 Dec 2019 14:07:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2wm1w2hxvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Dec 2019 14:07:52 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB2E7pL5016797;
        Mon, 2 Dec 2019 14:07:51 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Dec 2019 06:07:51 -0800
Subject: Re: [PATCH] btrfs: fix warn_on for send from readonly mount
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Christoph Anton Mitterer <calestyo@scientia.net>
References: <20191202094450.1377-1-anand.jain@oracle.com>
 <CAL3q7H7GyL2aY2mZ+hhR1CtEuiWi=Z0RwCgGgr39uWdKcYh5Ag@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <f56e2a83-aa6e-21d8-e851-8a333f2a1f57@oracle.com>
Date:   Mon, 2 Dec 2019 22:07:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H7GyL2aY2mZ+hhR1CtEuiWi=Z0RwCgGgr39uWdKcYh5Ag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9458 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912020127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9458 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912020127
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12/2/19 7:23 PM, Filipe Manana wrote:
> On Mon, Dec 2, 2019 at 9:46 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> We log warning if root::orphan_cleanup_state is not set to
>> ORPHAN_CLEANUP_DONE in btrfs_ioctl_send(). However if the filesystem is
>> mounted as readonly we skip the orphan items cleanup during the lookup
>> and root::orphan_cleanup_state remains at the init state 0 instead of
>> ORPHAN_CLEANUP_DONE (2).
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
>> Fix this by checking for the expected ORPHAN_CLEANUP_DONE only if the
>> filesystem is in writable state.
> 
> I wonder if you know why the warning is there in the first place...

  Nope. I didn't go that deep.

> In my opinion we could remove the warning completely because:
 >
> 1) Having orphan items means we could have files to delete (link count
> of 0) and dealing with such cases could make send fail for several
> reasons.
>      If this happens, it's not longer a problem since the following commit:
> 
>      https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=46b2f4590aab71d31088a265c86026b1e96c9de4
> 
> 2) Orphan items used to indicate previously unfinished truncations, in
> which case it would lead to send creating corrupt files at the
> destination (i_size incorrect and the file filled with zeroes between
> real i_size and stale i_size).
>      We no longer need to create orphans for truncations since commit:
> 
>      https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f7e9e8fc792fe2f823ff7d64d23f4363b3f2203a
> 
> I think that information needs to be in the changelog. And, as said
> before, I think the warning could go away completely.

  Makes sense. Will send v2 with it.

Thanks, Anand

> Thanks.
> 
>>
>> Reported-by: Christoph Anton Mitterer <calestyo@scientia.net>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/send.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
>> index ae2db5eb1549..e3acec8aa8de 100644
>> --- a/fs/btrfs/send.c
>> +++ b/fs/btrfs/send.c
>> @@ -7085,9 +7085,11 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
>>
>>          /*
>>           * This is done when we lookup the root, it should already be complete
>> -        * by the time we get here.
>> +        * by the time we get here, unless the filesystem is readonly where the
>> +        * orphan_cleanup_state is never started.
>>           */
>> -       WARN_ON(send_root->orphan_cleanup_state != ORPHAN_CLEANUP_DONE);
>> +       if (!sb_rdonly(file_inode(mnt_file)->i_sb))
>> +               WARN_ON(send_root->orphan_cleanup_state != ORPHAN_CLEANUP_DONE);
>>
>>          /*
>>           * Userspace tools do the checks and warn the user if it's
>> --
>> 2.23.0
>>
> 
> 
