Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117AB2A0752
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 15:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgJ3OBP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Oct 2020 10:01:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42334 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgJ3OBJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Oct 2020 10:01:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09UDxeHx171678;
        Fri, 30 Oct 2020 14:00:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=VRkTS19R3GdoTa/XaONW6kZN5WY7ZWiBiaIzIvBfuZ0=;
 b=BKwy9SBQN3Cdj67lz8/qnAjbSY+Vew2BAwWxJmFyZp17cC9qCOi2jWxUwXt3xlia3vqU
 dLeVkLxmmsNlGDlNp/0znop3/pP9A8CRkyxSduyL3PwLsxKBzptxZK0qaVd2DwUvSdcw
 k1xxz0OI2mOX5QdFYpqczOUAmiRq+oONBQfEKIflt5KMZsHZKYYDIHXx9o/j7f5yIse6
 qFoVYRoJDGfzlSNWPDWXAH+gF1bIyoY1GME6MSIymiNTaJxf8fF+ye+r/wYdacmYs6e2
 GQYsujPgb4o5d8/ZPwTDCdC4NLXlCg/J+/HPwmGA3PwTiVCG4VTO1xhm2CYM9Ej/g3j7 DQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 34cc7m9u9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Oct 2020 14:00:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09UDpU2B000814;
        Fri, 30 Oct 2020 13:58:57 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 34cx70qvhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Oct 2020 13:58:57 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09UDwtKq011780;
        Fri, 30 Oct 2020 13:58:55 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Oct 2020 06:58:55 -0700
Subject: Re: WARNING in close_fs_devices (2)
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com>,
        Chris Mason <clm@fb.com>, dsterba@suse.com,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <0000000000008fbadb05af94b61e@google.com>
 <01bcf380-c806-02fa-67ac-ff66fd0100c7@oracle.com>
 <CACT4Y+ZakmsaKN+R94SWyErZc6FeKcmBP8d5yY8FO4+aL5WxOw@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <b0bc728a-0957-ca93-10a7-4851a9d3b043@oracle.com>
Date:   Fri, 30 Oct 2020 21:58:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZakmsaKN+R94SWyErZc6FeKcmBP8d5yY8FO4+aL5WxOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010300105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1011 mlxscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010300106
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 30/10/20 6:10 pm, Dmitry Vyukov wrote:
> On Tue, Sep 22, 2020 at 2:37 PM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> On 18/9/20 7:22 pm, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    e4c26faa Merge tag 'usb-5.9-rc5' of git://git.kernel.org/p..
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=15bf1621900000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c61610091f4ca8c4
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=4cfe71a4da060be47502
>>> compiler:       gcc (GCC) 10.1.0-syz 20200507
>>>
>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com
>>>
>>> ------------[ cut here ]------------
>>> WARNING: CPU: 1 PID: 3612 at fs/btrfs/volumes.c:1166 close_fs_devices.part.0+0x607/0x800 fs/btrfs/volumes.c:1166
>>> Kernel panic - not syncing: panic_on_warn set ...
>>> CPU: 1 PID: 3612 Comm: syz-executor.2 Not tainted 5.9.0-rc4-syzkaller #0
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>>> Call Trace:
>>>    __dump_stack lib/dump_stack.c:77 [inline]
>>>    dump_stack+0x198/0x1fd lib/dump_stack.c:118
>>>    panic+0x347/0x7c0 kernel/panic.c:231
>>>    __warn.cold+0x20/0x46 kernel/panic.c:600
>>>    report_bug+0x1bd/0x210 lib/bug.c:198
>>>    handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
>>>    exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
>>>    asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
>>> RIP: 0010:close_fs_devices.part.0+0x607/0x800 fs/btrfs/volumes.c:1166
>>> Code: 0f b6 04 02 84 c0 74 02 7e 33 48 8b 44 24 18 c6 80 30 01 00 00 00 48 83 c4 30 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 99 ce 6a fe <0f> 0b e9 71 ff ff ff e8 8d ce 6a fe 0f 0b e9 20 ff ff ff e8 d1 d5
>>> RSP: 0018:ffffc900091777e0 EFLAGS: 00010246
>>> RAX: 0000000000040000 RBX: ffffffffffffffff RCX: ffffc9000c8b7000
>>> RDX: 0000000000040000 RSI: ffffffff83097f47 RDI: 0000000000000007
>>> RBP: dffffc0000000000 R08: 0000000000000001 R09: ffff8880988a187f
>>> R10: 0000000000000000 R11: 0000000000000001 R12: ffff88809593a130
>>> R13: ffff88809593a1ec R14: ffff8880988a1908 R15: ffff88809593a050
>>>    close_fs_devices fs/btrfs/volumes.c:1193 [inline]
>>>    btrfs_close_devices+0x95/0x1f0 fs/btrfs/volumes.c:1179
>>>    open_ctree+0x4984/0x4a2d fs/btrfs/disk-io.c:3434
>>>    btrfs_fill_super fs/btrfs/super.c:1316 [inline]
>>>    btrfs_mount_root.cold+0x14/0x165 fs/btrfs/super.c:1672
>>>    legacy_get_tree+0x105/0x220 fs/fs_context.c:592
>>>    vfs_get_tree+0x89/0x2f0 fs/super.c:1547
>>>    fc_mount fs/namespace.c:978 [inline]
>>>    vfs_kern_mount.part.0+0xd3/0x170 fs/namespace.c:1008
>>>    vfs_kern_mount+0x3c/0x60 fs/namespace.c:995
>>>    btrfs_mount+0x234/0xaa0 fs/btrfs/super.c:1732
>>>    legacy_get_tree+0x105/0x220 fs/fs_context.c:592
>>>    vfs_get_tree+0x89/0x2f0 fs/super.c:1547
>>>    do_new_mount fs/namespace.c:2875 [inline]
>>>    path_mount+0x1387/0x2070 fs/namespace.c:3192
>>>    do_mount fs/namespace.c:3205 [inline]
>>>    __do_sys_mount fs/namespace.c:3413 [inline]
>>>    __se_sys_mount fs/namespace.c:3390 [inline]
>>>    __x64_sys_mount+0x27f/0x300 fs/namespace.c:3390
>>>    do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>> RIP: 0033:0x46004a
>>> Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd 89 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 da 89 fb ff c3 66 0f 1f 84 00 00 00 00 00
>>> RSP: 002b:00007f414d78da88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
>>> RAX: ffffffffffffffda RBX: 00007f414d78db20 RCX: 000000000046004a
>>> RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f414d78dae0
>>> RBP: 00007f414d78dae0 R08: 00007f414d78db20 R09: 0000000020000000
>>> R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
>>> R13: 0000000020000100 R14: 0000000020000200 R15: 000000002001a800
>>> Kernel Offset: disabled
>>> Rebooting in 86400 seconds..
>>
>>
>> #syz fix: btrfs: fix rw_devices count in __btrfs_free_extra_devids
> 
> Is it the correct patch title? It still does not exist anywhere
> including linux-next...
> 

V2 is here [1]. The patch title is changed. Also the cover letter talks 
about the path dependency. It is not yet integrated.

[1]
https://patchwork.kernel.org/project/linux-btrfs/patch/d0b5790792b8b826504dd239ad9efc514f3d9109.1604009248.git.anand.jain@oracle.com/


Thanks, Anand


