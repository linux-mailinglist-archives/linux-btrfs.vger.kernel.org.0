Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B15326AEC
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Feb 2021 02:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhB0BDI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Feb 2021 20:03:08 -0500
Received: from mout.gmx.net ([212.227.17.21]:57427 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230014AbhB0BDG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Feb 2021 20:03:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614387687;
        bh=3hL0pJVub1ZZMRV4HjpdiGKt9zBohw+IO6S6tLTR5BQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UM5456HpnRjJ/VH+gcamMdpZz+dk3yrYqM9QJ7Ssqh5F95+832GDxrXvZ/UPw/+1n
         S0XYMgCS28HsfbBr64zQO5FlCyf9FoZpyRnHjvQyhCbq58qrZbVOUOxSriMujZ/1P1
         +ZGGo/aTzssvC2pOmidSo1FOxvqS5ny/kh3D/QC0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3KPq-1lyJqm397a-010Mp6; Sat, 27
 Feb 2021 02:01:27 +0100
Subject: Re: [PATCH] btrfs: fix warning when creating a directory with smack
 enabled
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Cc:     casey@schaufler-ca.com, Filipe Manana <fdmanana@suse.com>
References: <556c75e2762f240b09aeaf21f13a318ae55b1675.1614361829.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <4c0e3529-db39-6649-66f1-b7eec7678acc@gmx.com>
Date:   Sat, 27 Feb 2021 09:01:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <556c75e2762f240b09aeaf21f13a318ae55b1675.1614361829.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L41/dvToU5bdAZ7xA7IPUoD428AWO95S5xtiCbZ84d/h/WygjqD
 OIDBoOsO0f+sq0w4jdb890kWh9pPk7Ko3tZ69ReVizaeny05MkrZBB4p3TpJqBQKVAenDrZ
 HjsmjE8aQl8chNuliWw+OnmQlf07NAGYyLpfRCYQaE+DQNO3ZeC6ak/kJpf6X39YH/TJNGq
 UCZ2MEJcpD9I47uqo1fAw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vEfSTF4SfLw=:7n4m2n7ilhRrPhPsao/LCG
 2M/INBfYbX47RX4Gl4ayVBhc3rdLo30tT7YZfD882SH0sUJ2EkWb7tbTQgUXpsvvp2s4JbjEX
 Q/+1u7StKZa2j6FIlJFTLC+vm28upBKB+k6uSaSn/OW7KNQ3nmNRcHddU/iRbuQMCKhxBeoKL
 7BwMFVNJCAmDpMuZwcQ2iRlQivGe7Orlo3hnmMI6DkNfOUY6eAptRpE+Yi2sML7bHEOBGlyY5
 AMSH83C6kPMNReRdkZNfw0XYRgJ7aOsJKwqz/5Ls696tTs+UwAEmZVWEid6NWUIMEPgju+NWt
 0CCymHlmsDZUH+nJvVSh+NiuzayshvN4stS0NTnR9gzwfQke7z4tgYHPkRz8qhURXppYJs0tR
 0hjM9zsabpNJBXPljdeBnTARl1ldZ7tHvSvotoOTffzHMnWSX0l0qithfOK/5m0pfuAx+bIMa
 gt82CrzB5+667+z7/pymHOw8wiE1m/Tyq08tYVC0xFFmFFUC50vTh+NcFJKR6BYJx5mDoV9fc
 VBwYfMTPRO60+8RqMxgzCcXq7u/M8TvaujBPql29+DUbXQIM9PhAM4ZMGBTaqvMKdVI4zHHUE
 Ax1I8pkkq6Nr7xuixKdCXU5QNoKEJmbQ6hJ6F7kuXR5cY3qkmQd8kfyszjTC0Zecug2+sQaPi
 edAXCs8T3iygvANMikOMD55ObWlSlJBBz4TrWV6DhEMHusKUUp+npgB57qat9iP3hL6wUnLMD
 8JQWfYHPVun733IVDtVAUP6HOCzOkomiYCeT4vi4at14BDUiqQcWkZ+7/UBG9vDrfttVQmjCP
 gCp+04tSxn3tBqvrvcJ/k9zL91kgvRCuEt0akMHTcpQ2/ElTBc5pOWt5IrA4v/UZYEFhVzd3R
 DeOdrMBvkvKdgd4Sg7Nw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/27 =E4=B8=8A=E5=8D=881:51, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> When we have smack enabled, during the creation of a directory smack may
> attempt to add a "smack transmute" xattr on the inode, which results in
> the following warning and trace:
>
> [  220.732359] ------------[ cut here ]------------
> [  220.732398] WARNING: CPU: 3 PID: 2548 at fs/btrfs/transaction.c:537 s=
tart_transaction+0x489/0x4f0
> [  220.732400] Modules linked in: nft_objref nf_conntrack_netbios_ns (..=
.)
> [  220.732439] CPU: 3 PID: 2548 Comm: mkdir Not tainted 5.9.0-rc2smack+ =
#81
> [  220.732441] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS =
1.13.0-2.fc32 04/01/2014
> [  220.732444] RIP: 0010:start_transaction+0x489/0x4f0
> [  220.732447] Code: e9 be fc ff ff (...)
> [  220.732449] RSP: 0018:ffffc90001887d10 EFLAGS: 00010202
> [  220.732452] RAX: ffff88816f1e0000 RBX: 0000000000000201 RCX: 00000000=
00000003
> [  220.732454] RDX: 0000000000000201 RSI: 0000000000000002 RDI: ffff8881=
77849000
> [  220.732456] RBP: ffff888177849000 R08: 0000000000000001 R09: 00000000=
00000004
> [  220.732458] R10: ffffffff825e8f7a R11: 0000000000000003 R12: ffffffff=
ffffffe2
> [  220.732460] R13: 0000000000000000 R14: ffff88803d884270 R15: ffff8881=
680d8000
> [  220.732463] FS:  00007f67317b8440(0000) GS:ffff88817bcc0000(0000) knl=
GS:0000000000000000
> [  220.732465] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  220.732467] CR2: 00007f67247a22a8 CR3: 000000004bfbc002 CR4: 00000000=
00370ee0
> [  220.732472] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000
> [  220.732474] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000=
00000400
> [  220.732475] Call Trace:
> [  220.732480]  ? slab_free_freelist_hook+0xea/0x1b0
> [  220.732483]  ? trace_hardirqs_on+0x1c/0xe0
> [  220.732490]  btrfs_setxattr_trans+0x3c/0xf0
> [  220.732496]  __vfs_setxattr+0x63/0x80
> [  220.732502]  smack_d_instantiate+0x2d3/0x360
> [  220.732507]  security_d_instantiate+0x29/0x40
> [  220.732511]  d_instantiate_new+0x38/0x90
> [  220.732515]  btrfs_mkdir+0x1cf/0x1e0
> [  220.732521]  vfs_mkdir+0x14f/0x200
> [  220.732525]  do_mkdirat+0x6d/0x110
> [  220.732531]  do_syscall_64+0x2d/0x40
> [  220.732534]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  220.732537] RIP: 0033:0x7f673196ae6b
> [  220.732540] Code: 8b 05 11 (...)
> [  220.732542] RSP: 002b:00007ffc3c679b18 EFLAGS: 00000246 ORIG_RAX: 000=
0000000000053
> [  220.732545] RAX: ffffffffffffffda RBX: 00000000000001ff RCX: 00007f67=
3196ae6b
> [  220.732547] RDX: 0000000000000000 RSI: 00000000000001ff RDI: 00007ffc=
3c67a30d
> [  220.732549] RBP: 00007ffc3c67a30d R08: 00000000000001ff R09: 00000000=
00000000
> [  220.732551] R10: 000055d3e39fe930 R11: 0000000000000246 R12: 00000000=
00000000
> [  220.732553] R13: 00007ffc3c679cd8 R14: 00007ffc3c67a30d R15: 00007ffc=
3c679ce0
> [  220.732563] irq event stamp: 11029
> [  220.732566] hardirqs last  enabled at (11037): [<ffffffff81153fe6>] c=
onsole_unlock+0x486/0x670
> [  220.732569] hardirqs last disabled at (11044): [<ffffffff81153c01>] c=
onsole_unlock+0xa1/0x670
> [  220.732572] softirqs last  enabled at (8864): [<ffffffff81e0102f>] as=
m_call_on_stack+0xf/0x20
> [  220.732575] softirqs last disabled at (8851): [<ffffffff81e0102f>] as=
m_call_on_stack+0xf/0x20
> [  220.732577] ---[ end trace 8f958916039daced ]---
>
> This happens because at btrfs_mkdir() we call d_instantiate_new() while
> holding a transaction handle, which results in the following call chain:
>
>    btrfs_mkdir()
>       trans =3D btrfs_start_transaction(root, 5);
>
>       d_instantiate_new()
>          smack_d_instantiate()
>              __vfs_setxattr()
>                  btrfs_setxattr_trans()
>                     btrfs_start_transaction()
>                        start_transaction()
>                           WARN_ON()
>                             --> a tansaction start has TRANS_EXTWRITERS
>                                 set in its type
>                           h->orig_rsv =3D h->block_rsv
>                           h->block_rsv =3D NULL
>
>       btrfs_end_transaction(trans)
>
> Besides the warning triggered at start_transaction.c, we set the handle'=
s
> block_rsv to NULL which may cause some surprises later on.
>
> So fix this by making btrfs_setxattr_trans() not start a transaction whe=
n
> we already have a handle on one, stored in current->journal_info, and us=
e
> that handle. We are good to use the handle because at btrfs_mkdir() we d=
id
> reserve space for the xattr and the inode item.
>
> Reported-by: Casey Schaufler <casey@schaufler-ca.com>
> Link: https://lore.kernel.org/linux-btrfs/434d856f-bd7b-4889-a6ec-e81aae=
bfa735@schaufler-ca.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/xattr.c | 31 +++++++++++++++++++++++++++----
>   1 file changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
> index af6246f36a9e..03135dbb318a 100644
> --- a/fs/btrfs/xattr.c
> +++ b/fs/btrfs/xattr.c
> @@ -229,11 +229,33 @@ int btrfs_setxattr_trans(struct inode *inode, cons=
t char *name,
>   {
>   	struct btrfs_root *root =3D BTRFS_I(inode)->root;
>   	struct btrfs_trans_handle *trans;
> +	const bool start_trans =3D (current->journal_info =3D=3D NULL);

Not sure about the call context, but shouldn't we also check
BTRFS_SEND_TRANS_STUB?

Or there is something else to prevent us getting journal_info as
BTRFS_SEND_TRANS_STUB?

Thanks,
Qu

>   	int ret;
>
> -	trans =3D btrfs_start_transaction(root, 2);
> -	if (IS_ERR(trans))
> -		return PTR_ERR(trans);
> +	if (start_trans) {
> +		/*
> +		 * 1 unit for inserting/updating/deleting the xattr
> +		 * 1 unit for the inode item update
> +		 */
> +		trans =3D btrfs_start_transaction(root, 2);
> +		if (IS_ERR(trans))
> +			return PTR_ERR(trans);
> +	} else {
> +		/*
> +		 * This can happen when smack is enabled and a directory is being
> +		 * created. It happens through d_instantiate_new(), which calls
> +		 * smack_d_instantiate(), which in turn calls __vfs_setxattr() to
> +		 * set the transmute xattr (XATTR_NAME_SMACKTRANSMUTE) on the
> +		 * inode. We have already reserved space for the xattr and inode
> +		 * update at btrfs_mkdir(), so just use the transaction handle.
> +		 * We don't join or start a transaction, as that will reset the
> +		 * block_rsv of the handle and trigger a warning for the start
> +		 * case.
> +		 */
> +		ASSERT(strncmp(name, XATTR_SECURITY_PREFIX,
> +			       XATTR_SECURITY_PREFIX_LEN) =3D=3D 0);
> +		trans =3D current->journal_info;
> +	}
>
>   	ret =3D btrfs_setxattr(trans, inode, name, value, size, flags);
>   	if (ret)
> @@ -244,7 +266,8 @@ int btrfs_setxattr_trans(struct inode *inode, const =
char *name,
>   	ret =3D btrfs_update_inode(trans, root, BTRFS_I(inode));
>   	BUG_ON(ret);
>   out:
> -	btrfs_end_transaction(trans);
> +	if (start_trans)
> +		btrfs_end_transaction(trans);
>   	return ret;
>   }
>
>
