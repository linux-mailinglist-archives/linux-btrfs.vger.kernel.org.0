Return-Path: <linux-btrfs+bounces-4171-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A166B8A2226
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 01:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0B4AB220D4
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 23:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8358B47A7C;
	Thu, 11 Apr 2024 23:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="MwCyIiTj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD214779E
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 23:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712877365; cv=none; b=BbUk4D4eeqHobva6HIu+5l4QQ/yW7a+2KCLICx1ENwTQEGrsanSWRhLeOrENpMRETHcypCZW8uP7Zm7NtKMz5O0tC0WSB3hwU/cq3nMwtJbl2j2x53qK7jMSH3rLwyrJekWTYiNyFaLHWBzl76a6E2ArY96I53RIEbhVIT8jZKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712877365; c=relaxed/simple;
	bh=ZFAPC0dOrsXeA5pj8PEqU0f++A+gbzXq7V03M5DrqVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mx8yVB6ElJVKcSbmFGR5e8XMrRJVf2pm3L5LrzV/qsG/r2iTI+5OGHc4pMIS/Ptu+f1WgQnR3jtGKNWnFFf78Kz09q20r7cWZoxddemS7ntM9v36bJeU22QpsFbwg73pwvVnza9OrNyeDSbUk9wN6t3vAquF+3ayDpUppdo4/BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=MwCyIiTj; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1712877357; x=1713482157; i=quwenruo.btrfs@gmx.com;
	bh=frqqnAcd7DTwUoMUL0O1xXiANzTdBc7JgbVSz3f3IW0=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=MwCyIiTjLEVtF6qax3WD8lqqt3Qozse1Pnsh4IczqxRedVw6NR0niPkl/54AphnI
	 mADoeBVjw9XF6OesVWPRTn1CTruZTK/qmpw3U7M6lBkLcYE+vqqm04SueYPN0ALQ2
	 gOPZZPDgshL8J1DXN84+FH3f3kCT9cu0DkV54tEbtl6+Wnd63teXbIrwC8VAmbH23
	 dESF0h8peiaxleXr0z+x3i1AAPaLkmijEYzJtPIr5ulMLNhvvV6gBsPKDKNbcl0Pd
	 Fd2hy1eeF94y28gy0b1GYZXules0XzOjtGSicTQTLyjPocgGZ3FUce0H8cb5wOCi0
	 ItnPWw5fyfwzoW5Xog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMXUN-1sEVPG0mIh-00JYE4; Fri, 12
 Apr 2024 01:15:57 +0200
Message-ID: <719f6901-8505-44e2-80c1-56f967ade9b1@gmx.com>
Date: Fri, 12 Apr 2024 08:45:54 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/15] btrfs: use btrfs_find_first_inode() at
 btrfs_prune_dentries()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1712837044.git.fdmanana@suse.com>
 <787204cda3fa8259bb7763c558a910cf7a2e609b.1712837044.git.fdmanana@suse.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <787204cda3fa8259bb7763c558a910cf7a2e609b.1712837044.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6aWZFAb0NS/6UKr2pWRL8aS0IcoOTsMg6pAMBImLw/LoImaNG7W
 VFsnopAkdAIrE234V9GjBLsEZSfSLxR6v/SpAkMNQMyw25w3tAhkzmGGx2hAqv1TxCJlzfa
 dZHn0ziPSY2PAhPtPVOPuhP0x5YAqvfGnfQJWHj/kWNqOqNu4mSvzMsN/ihL2To0FN3NZGP
 qDLDcDF1VGnpcIHaSb5/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Fl8MocUNv+I=;YCKhq7p4Tt/fJXQMY+wOmKXaSh6
 EzHVbpi29C7jRCGo++4sS7Lb2hjcTk2XW+mUABLlAdMD41pt6iFUQ2kNm3lyGXSfhnHGxLGRZ
 jN4RxlFDUdg+M5L87L1c7TbXY/jI7wzNvbV7HtoLZWBIN2CTqWeeincTJXSv1+qJOIou9ciHB
 75bxL/BQ3fz7Tk2Cbe41+6xRv9dK/WkvkFpgCNXjPOXJKaPgaSH8V/ja2XPjb/y0fR/yKZcAa
 yIJz3mQOUnE4z82E9td5PepcZlFSNOisK9JcKlT8eHYWyuVbgEZThLqCssOXlZQX8xtpWfUbv
 gMPTnKpahCB1063L5f67JQ1y9O4jL4OF2PajjVSkwokISTXhRuWms9gcnDkkKkUuOfkiLH72v
 Y8q2Yd1OclDL47cwIPnkYDMuFoAChZRL37K2sDOLzGXEzH/L9mFlciy1kInMJeSmeU5atcrjq
 VCnow7ad51ynifyiERg3KYO6jOr8OrYaYUt950n3LpRQzL0y5vM5b5OFm+PfN0WbOjf+9BrkP
 dnWdzt7duRYECh3vs4HBBT5B484nyibxsz4A+hEH23UxZk6wYwg/O+zvH6KCOeYLjIlT3tUn6
 tp9YvVBO2qjLR5UCPriOWy+40QPrYgHdQwPD8R0Kz6fSfSZBnLRktniIX8CNb1nAJLC1lMcIm
 u859CYpxDPglQzjWi3NBldKyWkqt8xiUzziDPxJBI4OL2uZrit2sPu7wT3W+FJzo3AxafDfXE
 v3mwNKeZZOsZMDOsGlSAgrp+ndCfEfieBehsSl13eonZVbEMiA5mbSOFodbXwkSnenNMHzE3E
 SAWEWDfLACeJFG7K3oIHom8HU1N23yVFH0MTFTb+K7gz8=



=E5=9C=A8 2024/4/12 01:49, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Currently btrfs_prune_dentries() has open code to find the first inode i=
n
> a root with a minimum inode number. Remove that code and make it use the
> helper btrfs_find_first_inode() for that task.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/inode.c | 66 ++++++++++--------------------------------------
>   1 file changed, 14 insertions(+), 52 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 9dc41334c3a3..2dae4e975e80 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4436,64 +4436,26 @@ static noinline int may_destroy_subvol(struct bt=
rfs_root *root)
>   static void btrfs_prune_dentries(struct btrfs_root *root)
>   {
>   	struct btrfs_fs_info *fs_info =3D root->fs_info;
> -	struct rb_node *node;
> -	struct rb_node *prev;
> -	struct btrfs_inode *entry;
> -	struct inode *inode;
> -	u64 objectid =3D 0;
> +	struct btrfs_inode *inode;
> +	u64 min_ino =3D 0;
>
>   	if (!BTRFS_FS_ERROR(fs_info))
>   		WARN_ON(btrfs_root_refs(&root->root_item) !=3D 0);
>
> -	spin_lock(&root->inode_lock);
> -again:
> -	node =3D root->inode_tree.rb_node;
> -	prev =3D NULL;
> -	while (node) {
> -		prev =3D node;
> -		entry =3D rb_entry(node, struct btrfs_inode, rb_node);
> -
> -		if (objectid < btrfs_ino(entry))
> -			node =3D node->rb_left;
> -		else if (objectid > btrfs_ino(entry))
> -			node =3D node->rb_right;
> -		else
> -			break;
> -	}
> -	if (!node) {
> -		while (prev) {
> -			entry =3D rb_entry(prev, struct btrfs_inode, rb_node);
> -			if (objectid <=3D btrfs_ino(entry)) {
> -				node =3D prev;
> -				break;
> -			}
> -			prev =3D rb_next(prev);
> -		}
> -	}
> -	while (node) {
> -		entry =3D rb_entry(node, struct btrfs_inode, rb_node);
> -		objectid =3D btrfs_ino(entry) + 1;
> -		inode =3D igrab(&entry->vfs_inode);
> -		if (inode) {
> -			spin_unlock(&root->inode_lock);
> -			if (atomic_read(&inode->i_count) > 1)
> -				d_prune_aliases(inode);
> -			/*
> -			 * btrfs_drop_inode will have it removed from the inode
> -			 * cache when its usage count hits zero.
> -			 */
> -			iput(inode);
> -			cond_resched();
> -			spin_lock(&root->inode_lock);
> -			goto again;
> -		}
> -
> -		if (cond_resched_lock(&root->inode_lock))
> -			goto again;
> +	inode =3D btrfs_find_first_inode(root, min_ino);
> +	while (inode) {
> +		if (atomic_read(&inode->vfs_inode.i_count) > 1)
> +			d_prune_aliases(&inode->vfs_inode);
>
> -		node =3D rb_next(node);
> +		min_ino =3D btrfs_ino(inode) + 1;
> +		/*
> +		 * btrfs_drop_inode() will have it removed from the inode
> +		 * cache when its usage count hits zero.
> +		 */
> +		iput(&inode->vfs_inode);
> +		cond_resched();
> +		inode =3D btrfs_find_first_inode(root, min_ino);
>   	}
> -	spin_unlock(&root->inode_lock);
>   }
>
>   int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *den=
try)

