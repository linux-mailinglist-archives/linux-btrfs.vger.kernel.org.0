Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029E12E8B37
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Jan 2021 07:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbhACGx4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 3 Jan 2021 01:53:56 -0500
Received: from mout.gmx.net ([212.227.15.18]:49759 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbhACGxz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 3 Jan 2021 01:53:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609656738;
        bh=V71nJV1yj67Vrv0GU3OhZGBwQZbN8EIOLn8tT/ukABs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=MeLUinmuDXOdPZz+zyJTJF3FFporeKp92JvGuZK2uX6UGUnX8lqlsfED1oQu0O5O3
         4Sfz3mSYKivDcXi7z/rVrsJCZ2QOJi6WEgefIKacK4I2kGMJAjk21KOGFcbAqFeY/A
         xNMeHWUDRg2ZzSkr+dBiXi585ZxMQIvPpg+3YlcQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M5QJD-1kwmay2AKL-001ODJ; Sun, 03
 Jan 2021 07:52:18 +0100
Subject: Re: [PATCH] btrfs: fix NULL pointer dereference in
 extent_io_tree_panic()
To:     Su Yue <l@damenly.su>, linux-btrfs@vger.kernel.org
References: <20210103050156.2866-1-l@damenly.su>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <5a1fa648-15b2-1729-b697-dd4a3874cad7@gmx.com>
Date:   Sun, 3 Jan 2021 14:52:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210103050156.2866-1-l@damenly.su>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JR4RQYWuS68rwTwUc25XH8q8ZcwZj/Dh5MZrsurzAfsNIqUFQYi
 5ZS21vkiR6UDW+RF+I9KiZ4lW5jj0J9xo7h6YiNhuM1Su5oas2nTgYVirRm3dmgNh+7Tlgy
 ztlaj9R6TDq4BGDaXWA2D+zj9+DKFB+CcQqivFVpwL1rtypW6Ifs8t/rQnx7qa9VL/qs14K
 rpJW5PwKnPWMWYMz6pvhg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+Yao2uqkJcU=:wCT/cZhYRo041u5qvxRR7h
 gfXoXkoo0BRGMP+UZaeQ2161Y+yB9z3/HvlTUdH8kY3ryhnI4IaclE3QMJ2iKWsyCAddcDoKS
 pGsyjqOpAbxA/RVV+CdDs98oDbdUESEa1vVh3aZviQtySrFiaho+wgH+TX946l5vlKeLGuyu5
 MB5J6X8O7GrIMjW+KL5eZsaR38RA/cNy9ZvfUB384uzD1qQAuXJnzt4JnhO1c+gL4z/UR+3I6
 1+4X7q0GPRInSVaPwC3gIBKM5Yzcjlb+couYyImHCeyVrl+T68htEuLTlEirkUGo+t4k/RjIt
 lr0vCMyc5EZLV5aCDQkp2qdjX4cAQUvN0nvRJp1HTAIuOFyf9MB4stY1GsMSgiiKTpa78O/px
 Mvta7K0ooeyqu1lAEkAy7mx+7MEwMC00j42FaDJhjx+8mhk83pHhJ683qhRaL7F6P6SMV/UYh
 QpaH9p/tNqWfhzZHMDhzDqzAyNMlm89pppgmHhzrRzkLMGhjtzOh9oK2qU87FS+8OMmu2okRT
 qd5uCpnLZ6C89jwN1/Hlt6LWuJhpMu/CGvUWl56hV9u6h7ugGAUjmY4+aO3/AydBTAuEWvZuC
 ZCJERP56bGOltBR7ZNZ6q43M0r+mW3KcoAsOBpXnI6dVVPOPcnyrSLOjjpB6pKXlncH4s4UPJ
 erJChbLd2pGWJz8FiubM10JldQP2Dc+625IFQBTBq0dd9ofrVfbbBtgc0DlGoZPTTGwv98kQP
 Y4OeARlYBS2vO5q1k4ZZywp+fKAAyvU3i2ES5FPw+pvE4T0IpduByswCYfH+kkRyUdg8JWGH+
 Zo6B+5DCUJuIopoH1mErXIdO6mpyKCH+p9i6ofOZ1u/n4PXq5V5V6I4Gu4N9QP6IlybGT9fPi
 AAtwRhsdiT6HKY9VRFEA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/3 =E4=B8=8B=E5=8D=881:01, Su Yue wrote:
> while mounting the poc image user-provided, kernel panics due to the
> NULL deference of @tree->inode.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  109.663024] BTRFS error: found node 12582912 29360127 on insert of 37=
748736 29360127
> [  109.663032] BUG: kernel NULL pointer dereference, address: 0000000000=
000028
> [  109.664494] #PF: supervisor read access in kernel mode
> [  109.665543] #PF: error_code(0x0000) - not-present page
> [  109.666598] PGD 0 P4D 0
> [  109.667119] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [  109.668015] CPU: 14 PID: 641 Comm: mount Tainted: G        W  O      =
5.11.0-rc1-custom #45
> [  109.669707] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BI=
OS ArchLinux 1.14.0-1 04/01/2014
> [  109.671607] RIP: 0010:extent_io_tree_panic.isra.0+0x6/0x30 [btrfs]
> [  109.672911] Code: 89 fe 48 c7 c7 20 0e aa c0 48 89 e5 e8 3a b9 ee dd =
0f 0b be c0 13 00 00 48 c7 c7 48 0e aa c0 e8 d1 ff ff ff 0f 1f 44 00 00 55=
 <48> 8b 47 28 89 f1 49 c7 c0 70 0e aa c0 ba a9 02 00 00 48 c7 c6 00
> [  109.676740] RSP: 0018:ffffb76c814fb948 EFLAGS: 00010282
> [  109.677808] RAX: 00000000ffffffef RBX: 0000000001bfffff RCX: 00000000=
00000000
> [  109.679271] RDX: ffffb76c814fb99c RSI: 00000000ffffffef RDI: 00000000=
00000000
> [  109.680722] RBP: ffffb76c814fb9e0 R08: 0000000000000001 R09: 00000000=
00000001
> [  109.682179] R10: ffffb76c814fb658 R11: 0000000000000000 R12: ffff9aca=
c353e500
> [  109.683629] R13: ffff9acac89a8228 R14: ffff9acac353e8c0 R15: 00000000=
02400000
> [  109.685092] FS:  00007fb1f7dc3580(0000) GS:ffff9acb48c00000(0000) knl=
GS:0000000000000000
> [  109.686749] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  109.687927] CR2: 0000000000000028 CR3: 0000000103982000 CR4: 00000000=
00750ee0
> [  109.689380] PKRU: 55555554
> [  109.689935] Call Trace:
> [  109.690438]  ? set_extent_bit.cold+0x30/0x98 [btrfs]
> [  109.718452]  set_extent_bits_nowait+0x1d/0x20 [btrfs]
> [  109.741357]  add_extent_mapping+0x1e0/0x2f0 [btrs]
> [  109.761474]  read_one_chunk+0x33c/0x420 [btrfs]
> [  109.781087]  btrfs_read_chunk_tree+0x6a4/0x870 [btrfs]
> [  109.800486]  ? kvm_sched_clock_read+0x18/0x40
> [  109.819669]  open_ctree+0xb32/0x1734 [btrfs]
> [  109.838794]  ? bdi_register_va+0x1b/0x20
> [  109.857812]  ? super_setup_bdi_name+0x79/0xd0
> [  109.876880]  btrfs_mount_root.cold+0x12/0xeb [btrfs]
> [  109.895860]  ? __kmalloc_track_caller+0x217/0x3b0
> [  109.914731]  legacy_get_tree+0x34/0x60
> [  109.933041]  vfs_get_tree+0x2d/0xc0
> [  109.950757]  vfs_kern_mount.part.0+0x78/0xc0
> [  109.968262]  vfs_kern_mount+0x13/0x20
> [  109.984976]  btrfs_mount+0x11f/0x3c0 [btrfs]
> [  110.001475]  ? kfree+0x5ff/0x670
> [  110.017410]  ? __kmalloc_track_caller+0x217/0x3b0
> [  110.033439]  legacy_get_tree+0x34/0x60
> [  110.049000]  vfs_get_tree+0x2d/0xc0
> [  110.064604]  path_mount+0x48c/0xd30
> [  110.080199]  __x64_sys_mount+0x108/0x140
> [  110.095918]  do_syscall_64+0x38/0x50
> [  110.111366]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  110.126869] RIP: 0033:0x7fb1f7f42f6e
> [  110.141818] Code: 48 8b 0d 05 0f 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 =
66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05=
 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d2 0e 0c 00 f7 d8 64 89 01 48
> [  110.188250] RSP: 002b:00007fff152c68a8 EFLAGS: 00000246 ORIG_RAX: 000=
00000000000a5
> [  110.220331] RAX: ffffffffffffffda RBX: 00007fb1f8067264 RCX: 00007fb1=
f7f42f6e
> [  110.237474] RDX: 00005608be216360 RSI: 00005608be208690 RDI: 00005608=
be20f6c0
> [  110.254718] RBP: 00005608be208440 R08: 0000000000000000 R09: 00000000=
00000001
> [  110.272042] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000=
00000000
> [  110.288955] R13: 00005608be20f6c0 R14: 00005608be216360 R15: 00005608=
be208440
> [  110.305969] Modules linked in:
> [  110.458051] CR2: 0000000000000028
> [  110.478548] ---[ end trace 3499c8e7baa57952 ]---
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The image has a device extent whose end(29360127) is less than the start
> (37748736). btrfs did warn but continued to insert the invalid sate
> to device::alloc_state tree. Then tree_insert() returned -EEXIST
> because of the duplicate end. extent_io_tree_panic() was to be called.
> However, the @tree->inode is NULL in extent_io_tree_panic() and it
> should be NULL here because that device::alloc_state io tree's member
> @private is NULL by design.
>
> Just pass @tree->fs_info as parameter to extent_io_tree_panic()
> directly. Let it panic as expected at least.
>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D208929
> Fixes: 05912a3c04eb ("btrfs: drop extent_io_ops::tree_fs_info callback")
> Signed-off-by: Su Yue <l@damenly.su>

This looks OK as a simple fix.

Reviewed-by: Qu Wenruo <wqu@suse.com>

>
> ---
> I don't know why insert_state() code only warns about the invalid state
> and extent io operations are used in so many places. So just send the
> simple patch.

Although I'd prefer a more comprehensive fix, by doing overflow check on
device extent item to reject such tree block.

Thanks,
Qu

> ---
>   fs/btrfs/extent_io.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 6e3b72e63e42..c9cee458e001 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -676,9 +676,7 @@ alloc_extent_state_atomic(struct extent_state *preal=
loc)
>
>   static void extent_io_tree_panic(struct extent_io_tree *tree, int err)
>   {
> -	struct inode *inode =3D tree->private_data;
> -
> -	btrfs_panic(btrfs_sb(inode->i_sb), err,
> +	btrfs_panic(tree->fs_info, err,
>   	"locking error: extent tree was modified by another thread while lock=
ed");
>   }
>
>
