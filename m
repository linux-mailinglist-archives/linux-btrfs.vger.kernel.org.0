Return-Path: <linux-btrfs+bounces-19790-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E88E0CC3E27
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 16:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46A75305B914
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 15:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697DB359F91;
	Tue, 16 Dec 2025 15:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goKu+mPy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A699433031F
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765898205; cv=none; b=jT1+9SEhHfGk73MjI8rHYjyOF8PfJPu5G7sXFnLvTRJynd0Tp0qQ80xD7QPllOBnpOoxU/wxUl1AvHTOglhloj4y4hnyPiPKg2LDpWLoRDWKMDChsHEEMqc7+aoHCuoW7HndnnUhVvQosBxey0lAISa+EVPiJSj9lIVl6KK5g5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765898205; c=relaxed/simple;
	bh=YmsoTLjjpmYCZOS6hApqZWV85tctTYC7rB+GDVVV0zM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krtXom7Cw5/QsHWqC/HZ29eV4JZr8I9fMg3hpFkB8/PJH7rryZ3byRTns/Xp8Nxr74B7+ltc4eF0DZDDTSTs22OTSLDUwgJv12YI1jA9dDX0xcPvfXGS0aZcYUT78gvDkAfWd7ZTR996uuJMO711FBXy0VjAVxH/MLMTnQPc0zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goKu+mPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4165AC19422
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 15:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765898205;
	bh=YmsoTLjjpmYCZOS6hApqZWV85tctTYC7rB+GDVVV0zM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=goKu+mPyVyTyGCYG0LElP8ByUMnqNOTqAw/aQkPBK4jDMhcW0VTeQCJrND1H//M1P
	 /mKD37HZCaW1MOw0ZRkVUnB8n+iMRCq16VcbcyHns6bZlVq86DeAlmgCpUNl4tR7qQ
	 xvR8zsbXECeUf9qNGK8VQnI+nwFa3EOZ0vDVssnkMLLhmdFl68u/kcVrHUnU2xqEE2
	 f/xHbPTYVUNvEJLuePUppvuPx7qu0Dn5BkCbiiKRS8ePerRlU/9douD/1clXIGG8iB
	 WtX/Dmvq4iUXo6vYYugGqSUOkYqf6lsEe4idUvgb1Hj6y9rGE20lvnn/KeBvIVfo8y
	 Q8zSvAirBUiGQ==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b7ffbf4284dso75734266b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 07:16:45 -0800 (PST)
X-Gm-Message-State: AOJu0YwllBrRjWyFX/ncO665EunDNesw06RSqz/wzcpzzvdz1ciPtzwz
	eiK0spE3zR0Zd17IRdMBfbnIZFQr9clAg53DdeTkdFFV6sKkqcbbkEHK3DTMDCf5kb8CMPyXZSd
	HGb09roDhkGP6egEdjLt1+rttWwcQEbc=
X-Google-Smtp-Source: AGHT+IEidc5BFKdDqYp/kSGLM9IkL1oGZcykfzsAgjbI4C+FDBzldlFSt3ymtGeyw0P0pckzCWZ4e8XjagIkDwt98sM=
X-Received: by 2002:a17:906:f59b:b0:b73:76c5:8f7c with SMTP id
 a640c23a62f3a-b7d238d3445mr1494841566b.43.1765898203725; Tue, 16 Dec 2025
 07:16:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6e55113a22347c3925458a5d840a18401a38b276.camel@linux.intel.com>
In-Reply-To: <6e55113a22347c3925458a5d840a18401a38b276.camel@linux.intel.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 16 Dec 2025 15:16:06 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6CRWKYCHAu9PnuGygxqb-fkXjs2rAUO1D5hP=giFdUMw@mail.gmail.com>
X-Gm-Features: AQt7F2or1KvJ_CvgYnNKLpzrMjPIu6VqWA4_Sr8wi7quT7RXnWsXMAKoAqwxdGU
Message-ID: <CAL3q7H6CRWKYCHAu9PnuGygxqb-fkXjs2rAUO1D5hP=giFdUMw@mail.gmail.com>
Subject: Re: btrfs lockdep splat while paging
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 1:07=E2=80=AFPM Thomas Hellstr=C3=B6m
<thomas.hellstrom@linux.intel.com> wrote:
>
> Hi
>
> I've been seing the below lockdep splat [1] for quite some time during
> paging to disc and  since it seems persistent I figure it's a bit hard
> to trigger and nobody's looking at fixing it.

No one's been looking at fixing it probably because no one reported it befo=
re.

I've just sent a fix for it:

https://lore.kernel.org/linux-btrfs/d3b2797ff1161a809b1935ed0e1ce31d6110cc3=
3.1765897890.git.fdmanana@suse.com/

Thanks for the report.


>
> May I also suggest to add the following lockdep priming *iff* the
> delayed_node->mutex is really intended to be taken during reclaim. This
> will make a similar lockdep splat turn up much earlier without need to
> wait for paging:
>
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index ce6e9f8812e0..4d76d93957f4 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -61,6 +61,9 @@ static inline void btrfs_init_delayed_node(
>         delayed_node->ins_root =3D RB_ROOT_CACHED;
>         delayed_node->del_root =3D RB_ROOT_CACHED;
>         mutex_init(&delayed_node->mutex);
> +       fs_reclaim_acquire(GFP_KERNEL);
> +       might_lock(&delayed_node->mutex);
> +       fs_reclaim_release(GFP_KERNEL);
>         INIT_LIST_HEAD(&delayed_node->n_list);
>         INIT_LIST_HEAD(&delayed_node->p_list);
>  }
>
>
> Thanks,
> Thomas
>
> [1]:
> [27386.164433] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [27386.164574] WARNING: possible circular locking dependency detected
> [27386.164583] 6.18.0+ #4 Tainted: G     U
> [27386.164591] ------------------------------------------------------
> [27386.164599] kswapd0/117 is trying to acquire lock:
> [27386.164606] ffff8d9b6333c5b8 (&delayed_node->mutex){+.+.}-{3:3}, at:
> __btrfs_release_delayed_node.part.0+0x39/0x2f0
> [27386.164625]
>                but task is already holding lock:
> [27386.164633] ffffffffa4ab8ce0 (fs_reclaim){+.+.}-{0:0}, at:
> balance_pgdat+0x195/0xc60
> [27386.164646]
>                which lock already depends on the new lock.
>
> [27386.164657]
>                the existing dependency chain (in reverse order) is:
> [27386.164667]
>                -> #2 (fs_reclaim){+.+.}-{0:0}:
> [27386.164677]        fs_reclaim_acquire+0x9d/0xd0
> [27386.164685]        __kmalloc_cache_noprof+0x59/0x750
> [27386.164694]        btrfs_init_file_extent_tree+0x90/0x100
> [27386.164702]        btrfs_read_locked_inode+0xc3/0x6b0
> [27386.164710]        btrfs_iget+0xbb/0xf0
> [27386.164716]        btrfs_lookup_dentry+0x3c5/0x8e0
> [27386.164724]        btrfs_lookup+0x12/0x30
> [27386.164731]        lookup_open.isra.0+0x1aa/0x6a0
> [27386.164739]        path_openat+0x5f7/0xc60
> [27386.164746]        do_filp_open+0xd6/0x180
> [27386.164753]        do_sys_openat2+0x8b/0xe0
> [27386.164760]        __x64_sys_openat+0x54/0xa0
> [27386.164768]        do_syscall_64+0x97/0x3e0
> [27386.164776]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [27386.164784]
>                -> #1 (btrfs-tree-00){++++}-{3:3}:
> [27386.164794]        lock_release+0x127/0x2a0
> [27386.164801]        up_read+0x1b/0x30
> [27386.164808]        btrfs_search_slot+0x8e0/0xff0
> [27386.164817]        btrfs_lookup_inode+0x52/0xd0
> [27386.164825]        __btrfs_update_delayed_inode+0x73/0x520
> [27386.164833]        btrfs_commit_inode_delayed_inode+0x11a/0x120
> [27386.164842]        btrfs_log_inode+0x608/0x1aa0
> [27386.164849]        btrfs_log_inode_parent+0x249/0xf80
> [27386.164857]        btrfs_log_dentry_safe+0x3e/0x60
> [27386.164865]        btrfs_sync_file+0x431/0x690
> [27386.164872]        do_fsync+0x39/0x80
> [27386.164879]        __x64_sys_fsync+0x13/0x20
> [27386.164887]        do_syscall_64+0x97/0x3e0
> [27386.164894]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [27386.164903]
>                -> #0 (&delayed_node->mutex){+.+.}-{3:3}:
> [27386.164913]        __lock_acquire+0x15e9/0x2820
> [27386.164920]        lock_acquire+0xc9/0x2d0
> [27386.164927]        __mutex_lock+0xcc/0x10a0
> [27386.164934]        __btrfs_release_delayed_node.part.0+0x39/0x2f0
> [27386.164944]        btrfs_evict_inode+0x20b/0x4b0
> [27386.164952]        evict+0x15a/0x2f0
> [27386.164958]        prune_icache_sb+0x91/0xd0
> [27386.164966]        super_cache_scan+0x150/0x1d0
> [27386.164974]        do_shrink_slab+0x155/0x6f0
> [27386.164981]        shrink_slab+0x48e/0x890
> [27386.164988]        shrink_one+0x11a/0x1f0
> [27386.164995]        shrink_node+0xbfd/0x1320
> [27386.165002]        balance_pgdat+0x67f/0xc60
> [27386.165321]        kswapd+0x1dc/0x3e0
> [27386.165643]        kthread+0xff/0x240
> [27386.165965]        ret_from_fork+0x223/0x280
> [27386.166287]        ret_from_fork_asm+0x1a/0x30
> [27386.166616]
>                other info that might help us debug this:
>
> [27386.167561] Chain exists of:
>                  &delayed_node->mutex --> btrfs-tree-00 --> fs_reclaim
>
> [27386.168503]  Possible unsafe locking scenario:
>
> [27386.169110]        CPU0                    CPU1
> [27386.169411]        ----                    ----
> [27386.169707]   lock(fs_reclaim);
> [27386.169998]                                lock(btrfs-tree-00);
> [27386.170291]                                lock(fs_reclaim);
> [27386.170581]   lock(&delayed_node->mutex);
> [27386.170874]
>                 *** DEADLOCK ***
>
> [27386.171716] 2 locks held by kswapd0/117:
> [27386.171999]  #0: ffffffffa4ab8ce0 (fs_reclaim){+.+.}-{0:0}, at:
> balance_pgdat+0x195/0xc60
> [27386.172294]  #1: ffff8d998344b0e0 (&type->s_umount_key#40){++++}-
> {3:3}, at: super_cache_scan+0x37/0x1d0
> [27386.172596]
>                stack backtrace:
> [27386.173183] CPU: 11 UID: 0 PID: 117 Comm: kswapd0 Tainted: G     U
> 6.18.0+ #4 PREEMPT(lazy)
> [27386.173185] Tainted: [U]=3DUSER
> [27386.173186] Hardware name: ASUS System Product Name/PRIME B560M-A
> AC, BIOS 2001 02/01/2023
> [27386.173187] Call Trace:
> [27386.173187]  <TASK>
> [27386.173189]  dump_stack_lvl+0x6e/0xa0
> [27386.173192]  print_circular_bug.cold+0x17a/0x1c0
> [27386.173194]  check_noncircular+0x175/0x190
> [27386.173197]  __lock_acquire+0x15e9/0x2820
> [27386.173200]  lock_acquire+0xc9/0x2d0
> [27386.173201]  ? __btrfs_release_delayed_node.part.0+0x39/0x2f0
> [27386.173204]  __mutex_lock+0xcc/0x10a0
> [27386.173206]  ? __btrfs_release_delayed_node.part.0+0x39/0x2f0
> [27386.173208]  ? __btrfs_release_delayed_node.part.0+0x39/0x2f0
> [27386.173211]  ? __btrfs_release_delayed_node.part.0+0x39/0x2f0
> [27386.173213]  __btrfs_release_delayed_node.part.0+0x39/0x2f0
> [27386.173215]  btrfs_evict_inode+0x20b/0x4b0
> [27386.173217]  ? lock_acquire+0xc9/0x2d0
> [27386.173220]  evict+0x15a/0x2f0
> [27386.173222]  prune_icache_sb+0x91/0xd0
> [27386.173224]  super_cache_scan+0x150/0x1d0
> [27386.173226]  do_shrink_slab+0x155/0x6f0
> [27386.173228]  shrink_slab+0x48e/0x890
> [27386.173229]  ? shrink_slab+0x2d2/0x890
> [27386.173231]  shrink_one+0x11a/0x1f0
> [27386.173234]  shrink_node+0xbfd/0x1320
> [27386.173236]  ? shrink_node+0xa2d/0x1320
> [27386.173236]  ? shrink_node+0xbd3/0x1320
> [27386.173239]  ? balance_pgdat+0x67f/0xc60
> [27386.173239]  balance_pgdat+0x67f/0xc60
> [27386.173241]  ? finish_task_switch.isra.0+0xc4/0x2a0
> [27386.173246]  kswapd+0x1dc/0x3e0
> [27386.173247]  ? __pfx_autoremove_wake_function+0x10/0x10
> [27386.173249]  ? __pfx_kswapd+0x10/0x10
> [27386.173250]  kthread+0xff/0x240
> [27386.173251]  ? __pfx_kthread+0x10/0x10
> [27386.173253]  ret_from_fork+0x223/0x280
> [27386.173255]  ? __pfx_kthread+0x10/0x10
> [27386.173257]  ret_from_fork_asm+0x1a/0x30
> [27386.173260]  </TASK>
>
>

