Return-Path: <linux-btrfs+bounces-14514-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6876ACF9A4
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 00:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94BEE7A7058
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 22:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884CD213E7A;
	Thu,  5 Jun 2025 22:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Y4lGtZ5k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B83920C03E
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 22:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749162040; cv=none; b=on24Ab8NsWremXHyLnqLHY5zYe5aQta/ZwLsMKbOwpnA0bZOfA/0m5WAC6pGjlAZEIOwjJ0s+wHUTR5RDWNv8Ewv5bDFM/fQASpGQ91VXz06Iflpbo/+ZKmOI6e47xlifsKViiBkJwhAu46PfykeObo3XtDNcyTErGn7/ekMm1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749162040; c=relaxed/simple;
	bh=Iogm7ruakegGOUz7lStnWZqgJN1J/qVrsbD7/8fIneo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lnM1up1/cG07wlDkOqtMD1/fIkdk5MM1mBCpdz7OTLFG1AfuJAY2Tl2BJK1j3CDsQQfDGAMSEhzg98ZiOag2n1MSJodnbr+Ba1KxxUxSTj/KAB38RVFsxZREyzogYriCBOnvYdKMfGUpw0XfEeF57x69jbnFCdFs9ah85Fx3sZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Y4lGtZ5k; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1749162032; x=1749766832; i=quwenruo.btrfs@gmx.com;
	bh=VbUOXVVHPjDd9l/YBAEywUBh/atD/4G9w6/eFHkUtko=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Y4lGtZ5kHEgkSiIJljNUhuOjN1HhMnPHEXxI8jAuwE6/0DjXvTF/DvPCwR0tbXai
	 gAvHn53BGk11VsaiJBg1hBenReBvq1Y/0KlUTj+NOzqN5USs63QK7bOjb1V9DmtU7
	 rVoHmzeJ/73rBmukC0dGvM+mBhD2Po1cyc57yd3yax6rKPaDXsgvuAoQCXeQx7++2
	 xqMWgORHgCWKvk3DjLnRSmj8K+lApOo9vmupJE0N2pCqWNLmPSyQXLqPy+spCEHBt
	 n4tXrlnfFVmtMBnEHHT3oQXItz8dapT1tSwEXz1H4lnwoW923n+O8sGEMMIN9INZs
	 28iMKQyiiz8FA86jHw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MBUqF-1uZA6S0x15-00Eqw8; Fri, 06
 Jun 2025 00:20:31 +0200
Message-ID: <36a9a35c-b999-41a5-b163-15d64569fec9@gmx.com>
Date: Fri, 6 Jun 2025 07:50:27 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix assertion when building free space tree
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <f60761dc5dd7376ac91d0a645bd2c3a59a68cee7.1749153697.git.fdmanana@suse.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <f60761dc5dd7376ac91d0a645bd2c3a59a68cee7.1749153697.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sPjjWp3IbR5xzuwvsS2ALcJ3EHM43dTLocmy0A6bFcc9AR55BOr
 03MKH+vsg756cxkil+3VpTGoJnfPa/QSknv7pIT3c48XEHanGROx94wPDmK0Fcp0AfZYhF1
 rNVp66nJN2LiqAP7+ua/egzgB5tOT5bfgrynr8+Cl8jYa+gXRlDh+qFjMADy92wFZtgiPE7
 NpY2Gnhzclk1k09Fh4RGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XqWL3iMVTTI=;+2e5msn4PAcydCKU0ul7Mwsdf9j
 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
 1mUH8QCRPzYWOB1wMVJEd5MI6Wf2n5S0ZMeZuA==



=E5=9C=A8 2025/6/6 05:35, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> When building the free space tree with the block group tree feature
> enabled, we can hit an assertion failure like this:
>=20
>     BTRFS info (device loop0 state M): rebuilding free space tree
>     assertion failed: ret =3D=3D 0, in fs/btrfs/free-space-tree.c:1102
>     ------------[ cut here ]------------
>     kernel BUG at fs/btrfs/free-space-tree.c:1102!
>     Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
>     Modules linked in:
>     CPU: 1 UID: 0 PID: 6592 Comm: syz-executor322 Not tainted 6.15.0-rc7=
-syzkaller-gd7fa1af5b33e #0 PREEMPT
>     Hardware name: Google Google Compute Engine/Google Compute Engine, B=
IOS Google 05/07/2025
>     pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
>     pc : populate_free_space_tree+0x514/0x518 fs/btrfs/free-space-tree.c=
:1102
>     lr : populate_free_space_tree+0x514/0x518 fs/btrfs/free-space-tree.c=
:1102
>     sp : ffff8000a4ce7600
>     x29: ffff8000a4ce76e0 x28: ffff0000c9bc6000 x27: ffff0000ddfff3d8
>     x26: ffff0000ddfff378 x25: dfff800000000000 x24: 0000000000000001
>     x23: ffff8000a4ce7660 x22: ffff70001499cecc x21: ffff0000e1d8c160
>     x20: ffff0000e1cb7800 x19: ffff0000e1d8c0b0 x18: 00000000ffffffff
>     x17: ffff800092f39000 x16: ffff80008ad27e48 x15: ffff700011e740c0
>     x14: 1ffff00011e740c0 x13: 0000000000000004 x12: ffffffffffffffff
>     x11: ffff700011e740c0 x10: 0000000000ff0100 x9 : 94ef24f55d2dbc00
>     x8 : 94ef24f55d2dbc00 x7 : 0000000000000001 x6 : 0000000000000001
>     x5 : ffff8000a4ce6f98 x4 : ffff80008f415ba0 x3 : ffff800080548ef0
>     x2 : 0000000000000000 x1 : 0000000100000000 x0 : 000000000000003e
>     Call trace:
>      populate_free_space_tree+0x514/0x518 fs/btrfs/free-space-tree.c:110=
2 (P)
>      btrfs_rebuild_free_space_tree+0x14c/0x54c fs/btrfs/free-space-tree.=
c:1337
>      btrfs_start_pre_rw_mount+0xa78/0xe10 fs/btrfs/disk-io.c:3074
>      btrfs_remount_rw fs/btrfs/super.c:1319 [inline]
>      btrfs_reconfigure+0x828/0x2418 fs/btrfs/super.c:1543
>      reconfigure_super+0x1d4/0x6f0 fs/super.c:1083
>      do_remount fs/namespace.c:3365 [inline]
>      path_mount+0xb34/0xde0 fs/namespace.c:4200
>      do_mount fs/namespace.c:4221 [inline]
>      __do_sys_mount fs/namespace.c:4432 [inline]
>      __se_sys_mount fs/namespace.c:4409 [inline]
>      __arm64_sys_mount+0x3e8/0x468 fs/namespace.c:4409
>      __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>      invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>      el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>      do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>      el0_svc+0x58/0x17c arch/arm64/kernel/entry-common.c:767
>      el0t_64_sync_handler+0x78/0x108 arch/arm64/kernel/entry-common.c:78=
6
>      el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
>     Code: f0047182 91178042 528089c3 9771d47b (d4210000)
>     ---[ end trace 0000000000000000 ]---
>=20
> This happens because we are processing an empty block group, which has
> no extents allocated from it, there are no items for this block group,
> including the block group item since block group items are stored in a
> dedicated tree when using the block group tree feature. It also means
> this is the block group with the highest start offset, so there are no
> higher keys in the extent root, hence btrfs_search_slot_for_read()
> returns 1 (no higher key found).
>=20
> Fix this by asserting 'ret' is 0 only if the block group tree feature
> is not enabled, in which case we should find a block group item for
> the block group since it's stored in the extent root and block group
> item keys are greater than extent item keys (the value for
> BTRFS_BLOCK_GROUP_ITEM_KEY is 192 and for BTRFS_EXTENT_ITEM_KEY and
> BTRFS_METADATA_ITEM_KEY the values are 168 and 169 respectively).
> In case 'ret' is 1, we just need to add a record to the free space
> tree which spans the whole block group, and we can achieve this by
> making 'ret =3D=3D 0' as the while loop's condition.
>=20
> Reported-by: syzbot+36fae25c35159a763a2a@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/6841dca8.a00a0220.d4325.0020.G=
AE@google.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/free-space-tree.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> index af51cf784a5b..15721b9bbfe2 100644
> --- a/fs/btrfs/free-space-tree.c
> +++ b/fs/btrfs/free-space-tree.c
> @@ -1115,11 +1115,21 @@ static int populate_free_space_tree(struct btrfs=
_trans_handle *trans,
>   	ret =3D btrfs_search_slot_for_read(extent_root, &key, path, 1, 0);
>   	if (ret < 0)
>   		goto out_locked;
> -	ASSERT(ret =3D=3D 0);
> +	/*
> +	 * If ret is 1 (no key found), it means this is an empty block group,
> +	 * without any extents allocated from it and there's no block group
> +	 * item (key BTRFS_BLOCK_GROUP_ITEM_KEY) located in the extent tree
> +	 * because we are using the block group tree feature, so block group
> +	 * items are stored in the block group tree. It also means there are n=
o
> +	 * extents allocated for block groups with a start offset beyond this
> +	 * block group's end offset (this is the last, highest, block group).
> +	 */
> +	if (!btrfs_fs_compat_ro(trans->fs_info, BLOCK_GROUP_TREE))
> +		ASSERT(ret =3D=3D 0);
>  =20
>   	start =3D block_group->start;
>   	end =3D block_group->start + block_group->length;
> -	while (1) {
> +	while (ret =3D=3D 0) {
>   		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
>  =20
>   		if (key.type =3D=3D BTRFS_EXTENT_ITEM_KEY ||
> @@ -1149,8 +1159,6 @@ static int populate_free_space_tree(struct btrfs_t=
rans_handle *trans,
>   		ret =3D btrfs_next_item(extent_root, path);
>   		if (ret < 0)
>   			goto out_locked;
> -		if (ret)
> -			break;
>   	}
>   	if (start < end) {
>   		ret =3D __add_to_free_space_tree(trans, block_group, path2,


