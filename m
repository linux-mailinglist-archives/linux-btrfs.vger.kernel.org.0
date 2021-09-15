Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D270440BE0A
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Sep 2021 05:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhIODOX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 23:14:23 -0400
Received: from mout.gmx.net ([212.227.15.15]:56757 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229834AbhIODOW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 23:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631675577;
        bh=djn3yFVuMA4uupGafDcTwLChu6KJiUE1RWGXn5Tg5Y8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fiF2ybA6/85v3g1Ou74TvQ+LRQu6SI+CC3QL6kGalQGZmWNlOMg0XCAlOR95uiuWx
         qoy4LexoNZaqXqdcsNNZzfMq21Xgfcl7pvnGW76KYdYc48qYVsFDKZ0COI+dthYClu
         TwUNM2YLaYpcevqO8NUyr7Qr+bid6q6hZ0LVQ3zE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MdNcA-1mzg6a20dU-00ZQpC; Wed, 15
 Sep 2021 05:12:57 +0200
Subject: Re: WARNING in btrfs_run_delayed_refs
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     clm@fb.com, dsterba@suse.com, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CACkBjsa0wQ5oDQh0CABfV-UoAa9czS6DAuAA0fBrM_HhVxd6+w@mail.gmail.com>
 <a911ac2c-d743-03ea-513d-0b9756808d17@gmx.com>
 <CACkBjsa6uQU9RGKVmtbkAjBkQn4QZNCWo5N_wq4RHjPcJKt2Kw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <94d7ce1c-61c4-9aa8-956d-f2299d87e7d1@gmx.com>
Date:   Wed, 15 Sep 2021 11:12:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACkBjsa6uQU9RGKVmtbkAjBkQn4QZNCWo5N_wq4RHjPcJKt2Kw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GZvXGIMhQazYYrYOOt7avPb5sQCuME6YYGGyp5cY4XEyk33zTi7
 Nzw++CRYqbg7bWoiEKcUAtUd9VcI2QbmUuLTChWqK1MMnVWyUK57ZZCo7EoeesgQlnqWgQD
 xCJNsGP7tLOjsVl/Zjl4e4psXaiL1OkstLt20VpWNA7QGNunEHV8NNDAHd5U2yOXXa2nox9
 pDeoe9ZsxD2yWLqgmizVg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fzHvvz5/4n0=:vJFUgPwlwx2ZSMjaAdXvYf
 HQQ0KfXB27EvRu0gocsYo9E7GCBHu6w9hF2Zi9R7lmlmj77ltl9I0C/Uq0FUrYXTvW5ER3ZmH
 X2rKh1q9nj0Y3y6v88Y0/jOO+jbPadKcsLbR011B3XTo913+1mZwcfJHDRUVrWn7DOFNitN1g
 ZL9NvCzSxiQv/gqzDRylfh4LhQRgrp/9QLPL+7GjzcqcIhQ7vtg4+oKfuHXcKl3FH/kA0s0Wh
 v9C6oH2TLSPyrL+6qctWfTP6qurKjGaDVT430afSJK2T1eGXf+XmsvzYiint9qO6PpWTfQVh+
 QxtPkhZ1XLZScEz7Qv+EuV7g8QZcpWBV4+nnza48TpG5tkRuVbPZXYjH6/QVE1I7AQcHZOacZ
 ZEKw/XrEERh1MI0eSjEMuMXLU6LPgY19LEuFtMSI14eEiCIkmMT13Tt9ii2hqdPIWi+/uPd7K
 mqnoSinuPNqjN7+bW5bgTUuKC4bxWiy9t+E+cULDWMoRIeyyNCt4m2iaxMkH5n+L2ASwVWtqd
 1PzJtVX+CC8s9yPEfLBnKOkTfhMjxACwiISYdbvg1MgBFHgBddADTGtUTI1MaSCOgq4VLMceq
 dXN52dG2xz+6JUu4FBxf0uQr6TB/t8qXgFNfTqS1/NxAfkk2vcX5eeDjRxjb3aIx4lA/ggEhD
 3gu/x03hFjJ6Rj9WGtULSJiysKOJ1xcEsiXmnT2rTQ3twZE0NG6cSMJtz2RbpDXSCcW8QH22L
 VW8qA7Wq4b1vIQCz/pLYSZwUugDmhRE1JlwuM6lCpKkHgsjec3h5uQ/y5lviLcH3UJsXDIJbp
 Tv9OrMpBcUHveeIDeLmBJD8nL3LuElA7I5vMSHx1umoybob7kmszmvMRP7tnAjgBz4ZROt1V0
 phRSIwQZU9p7Pnu6gP0GMGjtmEoMju+AIfN44hkN49t/C1Agnk+ROCl8GrelCj0Tfp8ct4vc2
 aEXBubEVvhseD7RZGFmhaGv1AhuaTu7IatGk8NJ7svwdrVO8sWqs18ZkqjG2Cugtq99Z2tjSo
 zx4uh9vVpFXwA+Lbi2VzBqSzRDn1LDrvmgCgGOI/yAvMotXOIpL8pCM/WCtcqEzGsJKY3DoK3
 w4gy+nbW4G8bpTK5e28l1LxINsbgIWL+UunV4HI+4tLKyk5uY1gK0mASsDgMSO6p8j9ZJZ5Bn
 j4XWTm/yC3unKtzrNa5znr0c5C
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/15 =E4=B8=8A=E5=8D=8810:56, Hao Sun wrote:
> Qu Wenruo <quwenruo.btrfs@gmx.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=8815=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8810:20=E5=86=99=E9=81=93=EF=BC=
=9A
>>
>>
>>
>> On 2021/9/15 =E4=B8=8A=E5=8D=8810:14, Hao Sun wrote:
>>> Hello,
>>>
>>> When using Healer to fuzz the latest Linux kernel, the following crash
>>> was triggered.
>>>
>>> HEAD commit: 6880fa6c5660 Linux 5.15-rc1
>>> git tree: upstream
>>> console output:
>>> https://drive.google.com/file/d/1gd0dl74MyvvVAYqsCDKSGmcfpZszD0kt/view=
?usp=3Dsharing
>>> kernel config: https://drive.google.com/file/d/1rUzyMbe5vcs6khA3tL9EHT=
LJvsUdWcgB/view?usp=3Dsharing
>>> C reproducer: https://drive.google.com/file/d/1WKQukijOJ7D0NYk1iKf47FE=
SjYfAjrlz/view?usp=3Dsharing
>>> Syzlang reproducer:
>>> https://drive.google.com/file/d/1Gi9-Mgbrjw1OI-ymO4zDVIFej2Qf4ppL/view=
?usp=3Dsharing
>>>
>>> If you fix this issue, please add the following tag to the commit:
>>> Reported-by: Hao Sun <sunhao.th@gmail.com>
>>>
>>> loop11: detected capacity change from 0 to 32768
>>> BTRFS info (device loop11): disk space caching is enabled
>>> BTRFS info (device loop11): has skinny extents
>>> BTRFS info (device loop11): enabling ssd optimizations
>>> FAULT_INJECTION: forcing a failure.
>>> name failslab, interval 1, probability 0, space 0, times 0
>>> CPU: 0 PID: 7769 Comm: syz-executor Not tainted 5.15.0-rc1 #16
>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>>> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
>>> Call Trace:
>>>    __dump_stack lib/dump_stack.c:88 [inline]
>>>    dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:106
>>>    fail_dump lib/fault-inject.c:52 [inline]
>>>    should_fail+0x13c/0x160 lib/fault-inject.c:146
>>>    should_failslab+0x5/0x10 mm/slab_common.c:1328
>>>    slab_pre_alloc_hook.constprop.99+0x4e/0xc0 mm/slab.h:494
>>>    slab_alloc_node mm/slub.c:3120 [inline]
>>>    slab_alloc mm/slub.c:3214 [inline]
>>>    kmem_cache_alloc+0x44/0x280 mm/slub.c:3219
>>>    __btrfs_free_extent.isra.53+0x7b/0x1180 fs/btrfs/extent-tree.c:2942
>>>    run_delayed_tree_ref fs/btrfs/extent-tree.c:1687 [inline]
>>>    run_one_delayed_ref fs/btrfs/extent-tree.c:1711 [inline]
>>>    btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1952 [inline=
]
>>>    __btrfs_run_delayed_refs+0x83e/0x1a00 fs/btrfs/extent-tree.c:2017
>>>    btrfs_run_delayed_refs+0xb1/0x2b0 fs/btrfs/extent-tree.c:2148
>>>    btrfs_commit_transaction+0x7d/0x1430 fs/btrfs/transaction.c:2065
>>>    btrfs_sync_fs+0x9a/0x430 fs/btrfs/super.c:1426
>>>    btrfs_ioctl+0x209b/0x3be0 fs/btrfs/ioctl.c:4970
>>>    vfs_ioctl fs/ioctl.c:51 [inline]
>>>    __do_sys_ioctl fs/ioctl.c:874 [inline]
>>>    __se_sys_ioctl fs/ioctl.c:860 [inline]
>>>    __x64_sys_ioctl+0xb6/0x100 fs/ioctl.c:860
>>>    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>>    do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
>>>    entry_SYSCALL_64_after_hwframe+0x44/0xae
>>> RIP: 0033:0x46ae99
>>> Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
>>> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
>>> 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
>>> RSP: 002b:00007f8ac08c7c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>>> RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
>>> RDX: 0000000000000000 RSI: 0000000000009408 RDI: 0000000000000003
>>> RBP: 00007f8ac08c7c80 R08: 0000000000000000 R09: 0000000000000000
>>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
>>> R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffccc1d6390
>>> ------------[ cut here ]------------
>>> WARNING: CPU: 0 PID: 7769 at fs/btrfs/extent-tree.c:2150
>>> btrfs_run_delayed_refs+0x245/0x2b0 fs/btrfs/extent-tree.c:2150
>>
>> This is again btrfs_abort_transaction().
>>
>> This makes me wonder, should we add ENOMEM to abort transaction warning
>> condition to make the ENOMEM injection code happy.
>>
>> Mind to test the following diff?
>>
>> Thanks,
>> Qu
>>
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index 8c6ee947a68d..6bc79f6716fa 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -3548,7 +3548,8 @@ do {
>>                   \
>>           /* Report first abort since mount */                    \
>>           if (!test_and_set_bit(BTRFS_FS_STATE_TRANS_ABORTED,     \
>>                           &((trans)->fs_info->fs_state))) {       \
>> -               if ((errno) !=3D -EIO && (errno) !=3D -EROFS) {        =
     \
>> +               if ((errno) !=3D -EIO && (errno) !=3D -EROFS &&     \
>> +                   (errno) !=3D -ENOMEM) {                       \
>>                           WARN(1, KERN_DEBUG                           =
   \
>>                           "BTRFS: Transaction aborted (error %d)\n",   =
   \
>>                           (errno));                                    =
   \
>>
>
> Just tested it. This did fixed most `WARNING` reports, e.g., "WARNING
> in btrfs_add_link", "WARNING in btrfs_run_delayed_refs".
> I think it would be better if we can judge whether the  `ENOMEM` is
> caused by `fault injection` or not.
>
This is really hard to distinguish.

If the fuzzer test tool can do it by relating the transaction abort
message with error injection log, it would save us a lot of time and
prevent false alerts.

For now, I guess the above diff would be a quick and dirty filter for
ENOMEM injection tests.

Thanks,
Qu
