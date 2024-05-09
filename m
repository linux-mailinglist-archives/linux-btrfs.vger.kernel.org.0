Return-Path: <linux-btrfs+bounces-4852-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B638C0878
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 02:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1217CB216C1
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 00:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A65FBE62;
	Thu,  9 May 2024 00:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ELuh/jRk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF481A2C38
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 00:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715214643; cv=none; b=CVOwpJ5oSTK17IUa1SONByPkjeVj3EE3hchx/ANOCcutPMQ02Xzry/w//bOQTqiy5MTEfmDXsvMCEjJTCXS7exQFbeMSFCCAeUU3IYVujMxmPehYVqRVXoDF4JvgiQdZ45KGWfjtr6yMplvfxR95RF92HIt613a/yaeXI8hQ1mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715214643; c=relaxed/simple;
	bh=d0lMrnqNIJRaztK871OKmQiE/nkqhs/s6AtMtw/eKHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=niTkCFHcNaspZZQFh0VAyHanO/WVtEUN5ZOcykqNT9WK8zukplIlh1rr80QOZGAp0AsB9a6mtsO5RXCXFwq2pVSTaIJT9kn0ckqRov10tA7iGH5X4eD4eNOP0viWRj9BdzYXvgFLSP+OmTEKMMedXLmnX+AncY5VxOK5akvmd9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ELuh/jRk; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715214634; x=1715819434; i=quwenruo.btrfs@gmx.com;
	bh=Ehv7v9PUBFTaqe5JrZ+mLq7gwUdc+ccGUuvNbXzLL4k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ELuh/jRkicZv2qK43t5sK9euDOtN4dPkyMHlXl/dP0WSCCGaEsSZ0qnoYFvHWFDs
	 cv16GpWu9J6m34WrXf7F658/zxXKmOeN0C+N7aSjI7/2GMd5oENIswyz3SHCJYS+x
	 W3zrxc+ANmQVgDsnv2zZ3Mf10+aKHHqh68B5ZRLNSGOwX8HPfZCTFHyid2oBHver5
	 T9aIsuMdr7JJqCQc5BWclc+5CmudodmkppaCv2NNLJHZI3zcnQ12EsVWLgb6k7PWb
	 KahEUl8uaIZT/qTT+3VfSqnFihPRxeiAeBdl7vnzLBJHwSU5tHqUBl7ae0UrJI4HK
	 Nhgs0CCNbcM3MymvYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MoO24-1sOoHh3dLU-00nuVF; Thu, 09
 May 2024 02:30:34 +0200
Message-ID: <cc2ecee5-5ef0-43d0-bd24-c0d538b34c97@gmx.com>
Date: Thu, 9 May 2024 10:00:29 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] btrfs: unify index_cnt and csum_bytes from struct
 btrfs_inode
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1715169723.git.fdmanana@suse.com>
 <a9cda79653d2aa3964dec05ec21b96ce8f8f8e4f.1715169723.git.fdmanana@suse.com>
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
In-Reply-To: <a9cda79653d2aa3964dec05ec21b96ce8f8f8e4f.1715169723.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DHpNBeNUzMWVZ2sWG1yIQNSoCZnjfDnhxYInkQ1d3ZOYcO/bpKx
 rsglFWnLbiYze4BnmSQK0DDqBcS46T4+oplk8evIQEtolRTwGMPGxRxZXSJkJwLwmSHMnN8
 2EwcRp74lFdzAVpyAukegw1miJdT02gsKk4AgCwMYNwLXlRIPhk15BahJJ2XATf+wUkk/pA
 Ho0kSBh+dYJXpW6ktugxA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iPDV6LRi5QQ=;P1k32epvlynXyZhN341IsYwIvTo
 YekRRSp2HIv8f7y4cBCsIMIjZHq1Guq9qRLWOnv7EMyDLpKk2iQWIDf1SF+Ng7ondqY0zlfWv
 UbXjBrOh23Jq1P2Z9Czk045LDDI8VGzWf/CuwWbpgv8KQfmg8+Wi+dMPfMtZMhFeghq2bsA0Q
 HUHGafQyEucoNuKpSg06LlLzo4pIzujbtfD6wXR8tiNe6kK9yi0o+69AxLKj1XMyaFQHyzkmq
 pkqCPDkNYnoCUivEaA3xmqaoQr/x4Cnxjkc+Ksio7+q8KWgzgSv5DfbpdaPHxgFz5eQgAjoUw
 Gm+M7+mBAlktr/ORQZ8xPeO6YZXBjDxinyzzKDF7gQmZ/LtgPDCE7UUga6qE4wWJ4ShClD32a
 vbpGoBjq7+yV3OSx7gyCAKFtUX2lhy9Bb4lTT9xKPfZlWWvfmHX6H+swEkZPFf5Ly9+eKFfTi
 MuP7ObZG6vacH/u/yAoUtuGSFAmYOlQU2OOE8UKPzhW96wIEfmPbbdjy2E0xZeBMV/4y7wbwd
 4qjSAGoPqEgcCdtSSti76U0rnrw2jzueEgy9ur51B9Y+6vmw2eFYR6Nzz8wrcWLVg8kYqs6Kl
 pARqP5wTLXmtXLj6BdCpM3UdCBeWztBrC6HDADXguzKBl6Pg8HRElZvOwp7CiTEvCNBgVqlzn
 FceBUxDBJsZsJM+Rd5V189eVu284zh+KjXQ2IP8DHJTgSzqhJiSNTnbENvsjWgiwpmMVpKt8W
 PeD+QhjUdBGVnrEPqG9AMC8k6f25AbnLSPn+8UYQLM4rjhDy1WZRr2moOmBHtKhxEivmJ067Z
 oWXxHtrIiyAMITz4raAzspZDXPYXEQ7l23J3kYPix/VV0=



=E5=9C=A8 2024/5/8 21:47, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> The index_cnt field of struct btrfs_inode is used only for two purposes:
>
> 1) To store the index for the next entry added to a directory;
>
> 2) For the data relocation inode to track the logical start address of t=
he
>     block group currently being relocated.
>
> For the relocation case we use index_cnt because it's not used for
> anything else in the relocation use case - we could have used other fiel=
ds
> that are not used by relocation such as defrag_bytes, last_unlink_trans
> or last_reflink_trans for example (amongs others).
>
> Since the csum_bytes field is not used for directories, do the following
> changes:
>
> 1) Put index_cnt and csum_bytes in a union, and index_cnt is only
>     initialized when the inode is a directory. The csum_bytes is only
>     accessed in IO paths for regular files, so we're fine here;
>
> 2) Use the defrag_bytes field for relocation, since the data relocation
>     inode is never used for defrag purposes. And to make the naming bett=
er,
>     alias it to reloc_block_group_start by using a union.
>
> This reduces the size of struct btrfs_inode by 8 bytes in a release
> kernel, from 1040 bytes down to 1032 bytes.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/btrfs_inode.h   | 46 +++++++++++++++++++++++++---------------
>   fs/btrfs/delayed-inode.c |  3 ++-
>   fs/btrfs/inode.c         | 21 ++++++++++++------
>   fs/btrfs/relocation.c    | 12 +++++------
>   fs/btrfs/tree-log.c      |  3 ++-
>   5 files changed, 54 insertions(+), 31 deletions(-)
>
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index e577b9745884..19bb3d057414 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -215,11 +215,20 @@ struct btrfs_inode {
>   		u64 last_dir_index_offset;
>   	};
>
> -	/*
> -	 * Total number of bytes pending defrag, used by stat to check whether
> -	 * it needs COW. Protected by 'lock'.
> -	 */
> -	u64 defrag_bytes;
> +	union {
> +		/*
> +		 * Total number of bytes pending defrag, used by stat to check whethe=
r
> +		 * it needs COW. Protected by 'lock'.
> +		 * Used by inodes other than the data relocation inode.
> +		 */
> +		u64 defrag_bytes;
> +
> +		/*
> +		 * Logical address of the block group being relocated.
> +		 * Used only by the data relocation inode.
> +		 */
> +		u64 reloc_block_group_start;
> +	};
>
>   	/*
>   	 * The size of the file stored in the metadata on disk.  data=3Dorder=
ed
> @@ -228,12 +237,21 @@ struct btrfs_inode {
>   	 */
>   	u64 disk_i_size;
>
> -	/*
> -	 * If this is a directory then index_cnt is the counter for the index
> -	 * number for new files that are created. For an empty directory, this
> -	 * must be initialized to BTRFS_DIR_START_INDEX.
> -	 */
> -	u64 index_cnt;
> +	union {
> +		/*
> +		 * If this is a directory then index_cnt is the counter for the
> +		 * index number for new files that are created. For an empty
> +		 * directory, this must be initialized to BTRFS_DIR_START_INDEX.
> +		 */
> +		u64 index_cnt;
> +
> +		/*
> +		 * If this is not a directory, this is the number of bytes
> +		 * outstanding that are going to need csums. This is used in
> +		 * ENOSPC accounting. Protected by 'lock'.
> +		 */
> +		u64 csum_bytes;
> +	};
>
>   	/* Cache the directory index number to speed the dir/file remove */
>   	u64 dir_index;
> @@ -256,12 +274,6 @@ struct btrfs_inode {
>   	 */
>   	u64 last_reflink_trans;
>
> -	/*
> -	 * Number of bytes outstanding that are going to need csums.  This is
> -	 * used in ENOSPC accounting. Protected by 'lock'.
> -	 */
> -	u64 csum_bytes;
> -
>   	/* Backwards incompatible flags, lower half of inode_item::flags  */
>   	u32 flags;
>   	/* Read-only compatibility flags, upper half of inode_item::flags */
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index 1373f474c9b6..e298a44eaf69 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -1914,7 +1914,8 @@ int btrfs_fill_inode(struct inode *inode, u32 *rde=
v)
>   	BTRFS_I(inode)->i_otime_nsec =3D btrfs_stack_timespec_nsec(&inode_ite=
m->otime);
>
>   	inode->i_generation =3D BTRFS_I(inode)->generation;
> -	BTRFS_I(inode)->index_cnt =3D (u64)-1;
> +	if (S_ISDIR(inode->i_mode))
> +		BTRFS_I(inode)->index_cnt =3D (u64)-1;
>
>   	mutex_unlock(&delayed_node->mutex);
>   	btrfs_release_delayed_node(delayed_node);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 4fd41d6b377f..9b98aa65cc63 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3856,7 +3856,9 @@ static int btrfs_read_locked_inode(struct inode *i=
node,
>   	inode->i_rdev =3D 0;
>   	rdev =3D btrfs_inode_rdev(leaf, inode_item);
>
> -	BTRFS_I(inode)->index_cnt =3D (u64)-1;
> +	if (S_ISDIR(inode->i_mode))
> +		BTRFS_I(inode)->index_cnt =3D (u64)-1;
> +
>   	btrfs_inode_split_flags(btrfs_inode_flags(leaf, inode_item),
>   				&BTRFS_I(inode)->flags, &BTRFS_I(inode)->ro_flags);
>
> @@ -6268,8 +6270,10 @@ int btrfs_create_new_inode(struct btrfs_trans_han=
dle *trans,
>   		if (ret)
>   			goto out;
>   	}
> -	/* index_cnt is ignored for everything but a dir. */
> -	BTRFS_I(inode)->index_cnt =3D BTRFS_DIR_START_INDEX;
> +
> +	if (S_ISDIR(inode->i_mode))
> +		BTRFS_I(inode)->index_cnt =3D BTRFS_DIR_START_INDEX;
> +
>   	BTRFS_I(inode)->generation =3D trans->transid;
>   	inode->i_generation =3D BTRFS_I(inode)->generation;
>
> @@ -8435,8 +8439,12 @@ struct inode *btrfs_alloc_inode(struct super_bloc=
k *sb)
>   	ei->disk_i_size =3D 0;
>   	ei->flags =3D 0;
>   	ei->ro_flags =3D 0;
> +	/*
> +	 * ->index_cnt will be propertly initialized later when creating a new
> +	 * inode (btrfs_create_new_inode()) or when reading an existing inode
> +	 * from disk (btrfs_read_locked_inode()).
> +	 */

Would above comment be a little confusing?
As the comment is for csum_bytes, without checking the definition it's
not clear that csum_bytes and index_cnt is shared.

Maybe just removing it would be good enough?

Other wise looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>   	ei->csum_bytes =3D 0;
> -	ei->index_cnt =3D (u64)-1;
>   	ei->dir_index =3D 0;
>   	ei->last_unlink_trans =3D 0;
>   	ei->last_reflink_trans =3D 0;
> @@ -8511,9 +8519,10 @@ void btrfs_destroy_inode(struct inode *vfs_inode)
>   	if (!S_ISDIR(vfs_inode->i_mode)) {
>   		WARN_ON(inode->delalloc_bytes);
>   		WARN_ON(inode->new_delalloc_bytes);
> +		WARN_ON(inode->csum_bytes);
>   	}
> -	WARN_ON(inode->csum_bytes);
> -	WARN_ON(inode->defrag_bytes);
> +	if (!root || !btrfs_is_data_reloc_root(root))
> +		WARN_ON(inode->defrag_bytes);
>
>   	/*
>   	 * This can happen where we create an inode, but somebody else also
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 8b24bb5a0aa1..9f35524b6664 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -962,7 +962,7 @@ static int get_new_location(struct inode *reloc_inod=
e, u64 *new_bytenr,
>   	if (!path)
>   		return -ENOMEM;
>
> -	bytenr -=3D BTRFS_I(reloc_inode)->index_cnt;
> +	bytenr -=3D BTRFS_I(reloc_inode)->reloc_block_group_start;
>   	ret =3D btrfs_lookup_file_extent(NULL, root, path,
>   			btrfs_ino(BTRFS_I(reloc_inode)), bytenr, 0);
>   	if (ret < 0)
> @@ -2797,7 +2797,7 @@ static noinline_for_stack int prealloc_file_extent=
_cluster(
>   	u64 alloc_hint =3D 0;
>   	u64 start;
>   	u64 end;
> -	u64 offset =3D inode->index_cnt;
> +	u64 offset =3D inode->reloc_block_group_start;
>   	u64 num_bytes;
>   	int nr;
>   	int ret =3D 0;
> @@ -2951,7 +2951,7 @@ static int relocate_one_folio(struct inode *inode,=
 struct file_ra_state *ra,
>   			      int *cluster_nr, unsigned long index)
>   {
>   	struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
> -	u64 offset =3D BTRFS_I(inode)->index_cnt;
> +	u64 offset =3D BTRFS_I(inode)->reloc_block_group_start;
>   	const unsigned long last_index =3D (cluster->end - offset) >> PAGE_SH=
IFT;
>   	gfp_t mask =3D btrfs_alloc_write_mask(inode->i_mapping);
>   	struct folio *folio;
> @@ -3086,7 +3086,7 @@ static int relocate_one_folio(struct inode *inode,=
 struct file_ra_state *ra,
>   static int relocate_file_extent_cluster(struct inode *inode,
>   					const struct file_extent_cluster *cluster)
>   {
> -	u64 offset =3D BTRFS_I(inode)->index_cnt;
> +	u64 offset =3D BTRFS_I(inode)->reloc_block_group_start;
>   	unsigned long index;
>   	unsigned long last_index;
>   	struct file_ra_state *ra;
> @@ -3915,7 +3915,7 @@ static noinline_for_stack struct inode *create_rel=
oc_inode(
>   		inode =3D NULL;
>   		goto out;
>   	}
> -	BTRFS_I(inode)->index_cnt =3D group->start;
> +	BTRFS_I(inode)->reloc_block_group_start =3D group->start;
>
>   	ret =3D btrfs_orphan_add(trans, BTRFS_I(inode));
>   out:
> @@ -4395,7 +4395,7 @@ int btrfs_reloc_clone_csums(struct btrfs_ordered_e=
xtent *ordered)
>   {
>   	struct btrfs_inode *inode =3D BTRFS_I(ordered->inode);
>   	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> -	u64 disk_bytenr =3D ordered->file_offset + inode->index_cnt;
> +	u64 disk_bytenr =3D ordered->file_offset + inode->reloc_block_group_st=
art;
>   	struct btrfs_root *csum_root =3D btrfs_csum_root(fs_info, disk_bytenr=
);
>   	LIST_HEAD(list);
>   	int ret;
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 5146387b416b..0aee43466c52 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -1625,7 +1625,8 @@ static noinline int fixup_inode_link_count(struct =
btrfs_trans_handle *trans,
>   		if (ret)
>   			goto out;
>   	}
> -	BTRFS_I(inode)->index_cnt =3D (u64)-1;
> +	if (S_ISDIR(inode->i_mode))
> +		BTRFS_I(inode)->index_cnt =3D (u64)-1;
>
>   	if (inode->i_nlink =3D=3D 0) {
>   		if (S_ISDIR(inode->i_mode)) {

