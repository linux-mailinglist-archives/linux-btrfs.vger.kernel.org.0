Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C85271C70
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 09:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgIUH6T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 03:58:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46694 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgIUH6T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 03:58:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08L7sbbZ096363;
        Mon, 21 Sep 2020 07:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=YfXzG6w25mEucWzb4natHpFNhban2PK9sDz621j6ZmA=;
 b=eTpmLXrFpNX7bShNafBK3KezQjC9S7oKLR1X9gcZc35faAgxYUUxMMwYBjhOU0Ms9GUq
 Ugj4XXVZIJvq38hAuxWkawKwS7jx+foiCQgMnPqVaB43aYoiowRffa+bjY+lsXLou15C
 woSvJKhX4YQGu4DqX2j4lz55+hfMlIg01YphWG+27VX5Bh/QbljmDnVDoxfXsy5nsKC+
 D5xirZhU3KcTmcgiefSSrkJZ7QBWSWGNPM4BHgcwUdEzmQDp8mOvYeCnE6XSpMvXq/yf
 O3JoqAipRnEgSBnkHfu0G4iVkZG/0n0fjZK/SkAaGRWxXqs36HWocmCUXKnLQM8BF8mA vA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33ndnu3sjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Sep 2020 07:57:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08L7tnrT159229;
        Mon, 21 Sep 2020 07:57:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 33nuw03sws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Sep 2020 07:57:47 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08L7viTt017210;
        Mon, 21 Sep 2020 07:57:44 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Sep 2020 00:57:44 -0700
Subject: Re: WARNING in close_fs_devices (2)
To:     syzbot <syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, dsterba@suse.cz,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000005a890b05afc67285@google.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <c46c0d04-0ab7-dc81-978a-357c117eadbc@oracle.com>
Date:   Mon, 21 Sep 2020 15:57:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <0000000000005a890b05afc67285@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9750 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009210057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9750 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1011 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009210057
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/9/20 6:42 am, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    b652d2a5 Add linux-next specific files for 20200918
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17e84b07900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3cf0782933432b43
> dashboard link: https://syzkaller.appspot.com/bug?extid=4cfe71a4da060be47502
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112425d9900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1486929b900000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 6972 at fs/btrfs/volumes.c:1172 close_fs_devices+0x715/0x930 fs/btrfs/volumes.c:1172
> Modules linked in:
> CPU: 1 PID: 6972 Comm: syz-executor044 Not tainted 5.9.0-rc5-next-20200918-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:close_fs_devices+0x715/0x930 fs/btrfs/volumes.c:1172
> Code: e8 00 b8 4c fe 85 db 0f 85 65 f9 ff ff e8 93 bb 4c fe 0f 0b e9 59 f9 ff ff e8 87 bb 4c fe 0f 0b e9 c0 fe ff ff e8 7b bb 4c fe <0f> 0b e9 f9 fe ff ff 48 c7 c7 fc a1 8f 8b e8 e8 0b 8e fe e9 19 f9
> RSP: 0018:ffffc900061b7758 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffffffffffffffff RCX: ffffffff83285c2c
> RDX: ffff8880a6bbe4c0 RSI: ffffffff83285d35 RDI: 0000000000000007
> RBP: dffffc0000000000 R08: 0000000000000000 R09: ffff8880a2be1133
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880a2be1130
> R13: ffff8880a2be11ec R14: ffff888093ab0508 R15: ffff8880a2be1050
> FS:  000000000208a880(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000004babec CR3: 00000000a7bc7000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   btrfs_close_devices+0x8e/0x4b0 fs/btrfs/volumes.c:1184
>   open_ctree+0x492a/0x49cf fs/btrfs/disk-io.c:3381
>   btrfs_fill_super fs/btrfs/super.c:1316 [inline]
>   btrfs_mount_root.cold+0x14/0x165 fs/btrfs/super.c:1672
>   legacy_get_tree+0x105/0x220 fs/fs_context.c:592
>   vfs_get_tree+0x89/0x2f0 fs/super.c:1547
>   fc_mount fs/namespace.c:983 [inline]
>   vfs_kern_mount.part.0+0xd3/0x170 fs/namespace.c:1013
>   vfs_kern_mount+0x3c/0x60 fs/namespace.c:1000
>   btrfs_mount+0x234/0xaa0 fs/btrfs/super.c:1732
>   legacy_get_tree+0x105/0x220 fs/fs_context.c:592
>   vfs_get_tree+0x89/0x2f0 fs/super.c:1547
>   do_new_mount fs/namespace.c:2896 [inline]
>   path_mount+0x12ae/0x1e70 fs/namespace.c:3216
>   do_mount fs/namespace.c:3229 [inline]
>   __do_sys_mount fs/namespace.c:3437 [inline]
>   __se_sys_mount fs/namespace.c:3414 [inline]
>   __x64_sys_mount+0x27f/0x300 fs/namespace.c:3414
>   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x44851a
> Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 cd a2 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 aa a2 fb ff c3 66 0f 1f 84 00 00 00 00 00
> RSP: 002b:00007ffcb26bce08 EFLAGS: 00000293 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 000000000044851a
> RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffcb26bce50
> RBP: 00007ffcb26bce90 R08: 00007ffcb26bce90 R09: 0000000020000000
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
> R13: 00007ffcb26bce50 R14: 0000000000000003 R15: 0000000000000001
> 


I am able to reproduce. And its quite strange at the moment. A devid 0 
is being scanned. Looks like crafted image.

[19592.946397] BTRFS: device fsid f90cac8b-044b-4fa8-8bee-4b8d3da88dc2 
devid 0 transid 0 /dev/loop0 scanned by t (70902)


