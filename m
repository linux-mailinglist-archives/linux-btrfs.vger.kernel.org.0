Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE188326B04
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Feb 2021 02:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhB0B1l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Feb 2021 20:27:41 -0500
Received: from mout.gmx.net ([212.227.15.19]:60407 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229864AbhB0B1l (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Feb 2021 20:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614389161;
        bh=UsCkKagSkUzaaCQlKfwrrQ+0M7LvBfOmJbYtJOcKitg=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=be0EE323GmtmcKmzhptnvJorG+PL4JHjDjdzi7v49l/Q+ksEasxgQnhoIuctlkqR4
         iNJpnZaFko9PBJViigYyORvPr5YdK8/5JqXsPOntzNQQqrTNOCBjRgGMBVPFKeNGMK
         +xPUiG2KIJFoLxw7AGJ8DNdrAucsnoO63Rk+kjM4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1My32L-1m1HUN3KRT-00zT1T; Sat, 27
 Feb 2021 02:26:01 +0100
Subject: Re: [PATCH] btrfs: fix warning when creating a directory with smack
 enabled
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Cc:     casey@schaufler-ca.com, Filipe Manana <fdmanana@suse.com>
References: <556c75e2762f240b09aeaf21f13a318ae55b1675.1614361829.git.fdmanana@suse.com>
 <4c0e3529-db39-6649-66f1-b7eec7678acc@gmx.com>
Message-ID: <f394c71f-4f1c-e23e-5e0c-0c253325b4a5@gmx.com>
Date:   Sat, 27 Feb 2021 09:25:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <4c0e3529-db39-6649-66f1-b7eec7678acc@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:254PJn/qgM2y9EJbzMuxnW2lnn/UY/dXsWIFV7+V9nRl0Zs4ncm
 XAdD4OIoY3RluHF+tYPTMuadQ3Yo/VKgp2PmNhPRDxNjJ+VBmYdhT/Qd4HwBSveCQ9q88BI
 nMiT1ZfX+2yS7QmefhHb+fzoHmnywnBqxbcSuyeBCrPoS2TTx7O39e2G62E6rtKAsr8a78O
 lKUcZ+q8ZABh8YSob5wig==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1edMpGygwyA=:H5vaEn2RZthHscQIWqLvzM
 TtC+EauYR9XB1CPpTRWOqc4GF7mSNTPsqnxQZ2cjmfbTYTPIXirCis4bA7eujkCjpM9vWuaIl
 WRxelhY8G5eFvD1X3Q63eUj4uSlldtQkWT/Bfap/EoAEzkbmoHaP+Z2W2DRdQqWsHtn45W7sr
 FiRch1W1NFF0Gne2SqAWrGbX2M6xoO3vW744qHTtIKXHsGIgRDaU1clkIIujplCJAojobN0MI
 nI3Z74IlgJ1H2YAYfPoVz8PrzQozhz2JvFcQLPexw55boyrLJotFkV8k3HXJqFHhoUhLA+5Yd
 kzcs2y6pmrdsh3+dywF67KP50AWANXrpTkW9DJsYRQ86sm2RTH7fJ5MozLGqmOE1mAEvFmru6
 CGuLgvSyytT5vHeSmFHrQGzm9k1kfmxaUelOzOUNgxNlSuSq6xNFduGmBfN6xthjnsWimw0UD
 NCIfdtIS2gXFSZKbetdu8V/un6fpV+LlOrepWGdY9OAQVa6aFXBQ8oHslZ9Hetz/ueHBmgMCD
 Q+sgSB+1l5OalT6zeBUMNWSBMg/PZ3Pqp2qNvjtmTGvHBYU0LOYrBsC+K8UsifKZ+J/ZvApdJ
 SRD3D4fxxpgG9noUJ5V/LEYORrWtHAc2QoOjnDJ0tmFMNzGSD4tPw6L4snQvWxMWw0UJhdFWh
 MQAmLRPuJI5K+OrBw/YV7xNwB36KCrJDXsnSvmiC8NsTLHoVa2aYZQkUAPiCCr6y3bDBiko7h
 Spl0uq7shyO9q7EvnAyeIVFSXYiAM4xU7YfXNge7/6/B+rlJWECwASbvzdk8bGlkzdBmx92tb
 c99LkCDzA0/n/WSvmrS839hnISsl3LhOMfEuLXsPeFiw6gDGdw3EdryeQcO8qkPPXdP066LrJ
 YBh6vmgsDbCCRNpuvRAA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/27 =E4=B8=8A=E5=8D=889:01, Qu Wenruo wrote:
>
>
> On 2021/2/27 =E4=B8=8A=E5=8D=881:51, fdmanana@kernel.org wrote:
>> From: Filipe Manana <fdmanana@suse.com>
>>
>> When we have smack enabled, during the creation of a directory smack ma=
y
>> attempt to add a "smack transmute" xattr on the inode, which results in
>> the following warning and trace:
>>
>> [=C2=A0 220.732359] ------------[ cut here ]------------
>> [=C2=A0 220.732398] WARNING: CPU: 3 PID: 2548 at fs/btrfs/transaction.c=
:537
>> start_transaction+0x489/0x4f0
>> [=C2=A0 220.732400] Modules linked in: nft_objref nf_conntrack_netbios_=
ns
>> (...)
>> [=C2=A0 220.732439] CPU: 3 PID: 2548 Comm: mkdir Not tainted
>> 5.9.0-rc2smack+ #81
>> [=C2=A0 220.732441] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
>> BIOS 1.13.0-2.fc32 04/01/2014
>> [=C2=A0 220.732444] RIP: 0010:start_transaction+0x489/0x4f0
>> [=C2=A0 220.732447] Code: e9 be fc ff ff (...)
>> [=C2=A0 220.732449] RSP: 0018:ffffc90001887d10 EFLAGS: 00010202
>> [=C2=A0 220.732452] RAX: ffff88816f1e0000 RBX: 0000000000000201 RCX:
>> 0000000000000003
>> [=C2=A0 220.732454] RDX: 0000000000000201 RSI: 0000000000000002 RDI:
>> ffff888177849000
>> [=C2=A0 220.732456] RBP: ffff888177849000 R08: 0000000000000001 R09:
>> 0000000000000004
>> [=C2=A0 220.732458] R10: ffffffff825e8f7a R11: 0000000000000003 R12:
>> ffffffffffffffe2
>> [=C2=A0 220.732460] R13: 0000000000000000 R14: ffff88803d884270 R15:
>> ffff8881680d8000
>> [=C2=A0 220.732463] FS:=C2=A0 00007f67317b8440(0000) GS:ffff88817bcc000=
0(0000)
>> knlGS:0000000000000000
>> [=C2=A0 220.732465] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033
>> [=C2=A0 220.732467] CR2: 00007f67247a22a8 CR3: 000000004bfbc002 CR4:
>> 0000000000370ee0
>> [=C2=A0 220.732472] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>> 0000000000000000
>> [=C2=A0 220.732474] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>> 0000000000000400
>> [=C2=A0 220.732475] Call Trace:
>> [=C2=A0 220.732480]=C2=A0 ? slab_free_freelist_hook+0xea/0x1b0
>> [=C2=A0 220.732483]=C2=A0 ? trace_hardirqs_on+0x1c/0xe0
>> [=C2=A0 220.732490]=C2=A0 btrfs_setxattr_trans+0x3c/0xf0
>> [=C2=A0 220.732496]=C2=A0 __vfs_setxattr+0x63/0x80
>> [=C2=A0 220.732502]=C2=A0 smack_d_instantiate+0x2d3/0x360
>> [=C2=A0 220.732507]=C2=A0 security_d_instantiate+0x29/0x40
>> [=C2=A0 220.732511]=C2=A0 d_instantiate_new+0x38/0x90
>> [=C2=A0 220.732515]=C2=A0 btrfs_mkdir+0x1cf/0x1e0
>> [=C2=A0 220.732521]=C2=A0 vfs_mkdir+0x14f/0x200
>> [=C2=A0 220.732525]=C2=A0 do_mkdirat+0x6d/0x110
>> [=C2=A0 220.732531]=C2=A0 do_syscall_64+0x2d/0x40
>> [=C2=A0 220.732534]=C2=A0 entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [=C2=A0 220.732537] RIP: 0033:0x7f673196ae6b
>> [=C2=A0 220.732540] Code: 8b 05 11 (...)
>> [=C2=A0 220.732542] RSP: 002b:00007ffc3c679b18 EFLAGS: 00000246 ORIG_RA=
X:
>> 0000000000000053
>> [=C2=A0 220.732545] RAX: ffffffffffffffda RBX: 00000000000001ff RCX:
>> 00007f673196ae6b
>> [=C2=A0 220.732547] RDX: 0000000000000000 RSI: 00000000000001ff RDI:
>> 00007ffc3c67a30d
>> [=C2=A0 220.732549] RBP: 00007ffc3c67a30d R08: 00000000000001ff R09:
>> 0000000000000000
>> [=C2=A0 220.732551] R10: 000055d3e39fe930 R11: 0000000000000246 R12:
>> 0000000000000000
>> [=C2=A0 220.732553] R13: 00007ffc3c679cd8 R14: 00007ffc3c67a30d R15:
>> 00007ffc3c679ce0
>> [=C2=A0 220.732563] irq event stamp: 11029
>> [=C2=A0 220.732566] hardirqs last=C2=A0 enabled at (11037): [<ffffffff8=
1153fe6>]
>> console_unlock+0x486/0x670
>> [=C2=A0 220.732569] hardirqs last disabled at (11044): [<ffffffff81153c=
01>]
>> console_unlock+0xa1/0x670
>> [=C2=A0 220.732572] softirqs last=C2=A0 enabled at (8864): [<ffffffff81=
e0102f>]
>> asm_call_on_stack+0xf/0x20
>> [=C2=A0 220.732575] softirqs last disabled at (8851): [<ffffffff81e0102=
f>]
>> asm_call_on_stack+0xf/0x20
>> [=C2=A0 220.732577] ---[ end trace 8f958916039daced ]---
>>
>> This happens because at btrfs_mkdir() we call d_instantiate_new() while
>> holding a transaction handle, which results in the following call chain=
:
>>
>> =C2=A0=C2=A0 btrfs_mkdir()
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trans =3D btrfs_start_transaction(root, =
5);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d_instantiate_new()
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smack_d_instantiate()
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 __vfs_setxattr()
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_setxattr_trans()
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_start_transaction()
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start_tran=
saction()
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 WARN_ON()
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 --> a tansaction start has TRANS_EXTWRITERS
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set in its type
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 h->orig_rsv =3D h->block_rsv
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 h->block_rsv =3D NULL
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_end_transaction(trans)
>>
>> Besides the warning triggered at start_transaction.c, we set the handle=
's
>> block_rsv to NULL which may cause some surprises later on.
>>
>> So fix this by making btrfs_setxattr_trans() not start a transaction wh=
en
>> we already have a handle on one, stored in current->journal_info, and u=
se
>> that handle. We are good to use the handle because at btrfs_mkdir() we
>> did
>> reserve space for the xattr and the inode item.
>>
>> Reported-by: Casey Schaufler <casey@schaufler-ca.com>
>> Link:
>> https://lore.kernel.org/linux-btrfs/434d856f-bd7b-4889-a6ec-e81aaebfa73=
5@schaufler-ca.com/
>>
>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>> ---
>> =C2=A0 fs/btrfs/xattr.c | 31 +++++++++++++++++++++++++++----
>> =C2=A0 1 file changed, 27 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
>> index af6246f36a9e..03135dbb318a 100644
>> --- a/fs/btrfs/xattr.c
>> +++ b/fs/btrfs/xattr.c
>> @@ -229,11 +229,33 @@ int btrfs_setxattr_trans(struct inode *inode,
>> const char *name,
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_root *root =3D BTRFS_I(inod=
e)->root;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_trans_handle *trans;
>> +=C2=A0=C2=A0=C2=A0 const bool start_trans =3D (current->journal_info =
=3D=3D NULL);
>
> Not sure about the call context, but shouldn't we also check
> BTRFS_SEND_TRANS_STUB?
>
> Or there is something else to prevent us getting journal_info as
> BTRFS_SEND_TRANS_STUB?

Oh, never mind, it won't be possible the have journal_info =3D=3D
SEND_TRANS_STUB in the context, so the check should be good.

Thanks,
Qu
>
> Thanks,
> Qu
>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>
>> -=C2=A0=C2=A0=C2=A0 trans =3D btrfs_start_transaction(root, 2);
>> -=C2=A0=C2=A0=C2=A0 if (IS_ERR(trans))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(trans);
>> +=C2=A0=C2=A0=C2=A0 if (start_trans) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 1 unit for insertin=
g/updating/deleting the xattr
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 1 unit for the inod=
e item update
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trans =3D btrfs_start_trans=
action(root, 2);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(trans))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn PTR_ERR(trans);
>> +=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This can happen whe=
n smack is enabled and a directory is
>> being
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * created. It happens=
 through d_instantiate_new(), which calls
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * smack_d_instantiate=
(), which in turn calls
>> __vfs_setxattr() to
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * set the transmute x=
attr (XATTR_NAME_SMACKTRANSMUTE) on the
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * inode. We have alre=
ady reserved space for the xattr and inode
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * update at btrfs_mkd=
ir(), so just use the transaction handle.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We don't join or st=
art a transaction, as that will reset the
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * block_rsv of the ha=
ndle and trigger a warning for the start
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * case.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASSERT(strncmp(name, XATTR_=
SECURITY_PREFIX,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 XATTR_SECURITY_PREFIX_LEN) =3D=3D =
0);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trans =3D current->journal_=
info;
>> +=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_setxattr(trans, inode, nam=
e, value, size, flags);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>> @@ -244,7 +266,8 @@ int btrfs_setxattr_trans(struct inode *inode,
>> const char *name,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_update_inode(trans, root, =
BTRFS_I(inode));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BUG_ON(ret);
>> =C2=A0 out:
>> -=C2=A0=C2=A0=C2=A0 btrfs_end_transaction(trans);
>> +=C2=A0=C2=A0=C2=A0 if (start_trans)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_end_transaction(trans=
);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>>
>>
