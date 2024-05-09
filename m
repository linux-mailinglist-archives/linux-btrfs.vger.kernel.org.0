Return-Path: <linux-btrfs+bounces-4853-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 625158C0888
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 02:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54DDC1C212CD
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 00:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D4020DC5;
	Thu,  9 May 2024 00:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ar9PdE08"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607FD9463
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 00:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715215195; cv=none; b=pziQlyHNAk8Rvk7uKxfTVJAmD/snTwqCQI9EkkQ/AtmvTNWnOgtVpZJHucv4r21IGXYqS5oglGRFssESdWwUuQPR/NTG2kse0IzLSW80rWJyfvGINiCOb3v3doqm8AH7RglxZoKjGx+fB3i2VBofWerwW8/svmY+pUvD5nLcEmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715215195; c=relaxed/simple;
	bh=5m168/aHaWK66PPz2wFZqxLxMu/21B2IV92LYwyH6Qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tqw9qECeDDBq642Z8T+Ya+NELRjUHG5SIv2XO01WLpKVcjslJSb042oCs1ps4Uphx5d3Yd2CQfQMDlTzCgy/dnQX5h/OtzNt4vZQLz5ppd4XHB2nes0JIa1KipoUH5+me8NUwONFcFWm8DJFiCvI+3fHJQTmo38yAnYPfpS/rY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ar9PdE08; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715215186; x=1715819986; i=quwenruo.btrfs@gmx.com;
	bh=fGVMJgsJVJmOKb61qCvo8KQiJFxl1b5o7EuPco87RYg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ar9PdE08O1jn3JNxuK3RNVLdLypxMmwaTmmX3pX92+goj8R/F8OokMT7NH00s9f5
	 6H8XgSvlGxdQ3ey2Swfv6nawDxWnqmOpNqMgT+qrG/MJ4haFM45mWoZ7KmhjZN8YO
	 BfivefW88+xoeOiCc4xIRQpIgfrlUwVdI26agt/Dr0UMnSzEGHBFG763V0q82y9E8
	 LM24XW+Y3/RlL6v88IZ6WKXS2X2E9VsoKZvdLRL6gJUICfSfpWq3h6dwmR+wjAKrO
	 jZDs0UwvKo+oOQyFZveLESj/l56JCYyRwOJ38WwMnydTt056CuUlg3gLBrq/YifoN
	 zix0NoLKr6HZgnOR5w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MowGU-1sOGTf4AJS-00nMvV; Thu, 09
 May 2024 02:39:46 +0200
Message-ID: <39f3094b-4e6a-4f72-8ba7-c013a33a05ad@gmx.com>
Date: Thu, 9 May 2024 10:09:42 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] btrfs: don't allocate file extent tree for non
 regular files
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1715169723.git.fdmanana@suse.com>
 <13d914be0518dc3f4a8086f96275c3b8bf113d63.1715169723.git.fdmanana@suse.com>
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
In-Reply-To: <13d914be0518dc3f4a8086f96275c3b8bf113d63.1715169723.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vrMQAnISV7H5pCW/RcDFT6cBl9dIgOSuZ6PXNIeiPTZZXNBs1Fs
 Fqd5vINhzBnH855QseUH5vBdz/WqtkaCqbs/oZ/8fGuBDbcddaKwtWoafDpq6DM6aY7LMxw
 h7dSbOd65fFVnJbB3tojAQ1AcXD5ipQh4lyDTiYDcPIOhE3ZsDB2iPGgaoXBnRh57YHVduW
 ejuaPYnstKZUHb5tv25/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PvlwrhaTv3k=;NifHThNi7Sf42q1dW2+MGsIeW/H
 9M6co8dryetY7XbXA4/gujptO2SF8g9bijF1gwqXanUJMyYFPfzKCdPJt7D70N+EqovigMkHB
 dOMBakaXcPKspY5FyugaeOOB2cBVmlD0+eR5N9kCybGwH5cdsQCyeAkjEnQecLwNdNr3xSa/G
 C5aeYmTc4k2CV9DYtHZhImFiWJKXwIXzZekvu9EfgMclxTdQyUImBLFbdDGpGGaQtui7nAC7X
 tWr2a5tOiKCI542kR/D4LHUYdh+ksRMU9jQDNn4rJpYREI/U3Hhri3c3k/dO4OVIfnVrD+UH5
 qwEYp6WnMxqD5uI1pd6I5eB/QtVkT3cBC/Zv80vM9EN0GwbALgdBuYCGPmDwYSA008nKcaWw2
 ScZNGjX7OXPZVpC0jV/b+wEsvA0Ire8n4hxY+88qwSwrGd/xsdvVGM/SpQ7s/rDtelMWIULxT
 pbqY/0NB2UAhcWroGUcj8DpEaQTDSdXt2C4kjnVda9TVxpoJBPi2O3Fjqwmiv0qotEMGVLOUx
 RWCLFNsYGsdsuST0BRz71fpHMBxoJRnCM3iSZveKZAnjv+9m7fvcAqUGG1RJwpa9bXMlfnQJ6
 4iArgSgIVREKkzwYfUOckZYq6oI5PlB+SiQfU1gcmxQHo/aVcwikbGR5nTCY5/Snwa+0KsVLT
 WGMiW9/l0FTYzmQdZmSCB+mgYegE8aRScXSR3KR8lSw6T0rCKiA3VeorFXKkDoawtYNFf7FMt
 SLPqIXpw4KzILes40h5OsqaY64dP43Jwqu4kIB/Ew1qx1cf3bDhuvIcD971NeFiXqVCBs/sil
 T5GPGqucEVqSWhjJUGEFFMbEKzgp0Zd41SMrmLrqmN+zo=



=E5=9C=A8 2024/5/8 21:47, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> When not using the NO_HOLES feature we always allocate an io tree for an
> inode's file_extent_tree.

I'm wondering can we discard non-NO_HOLES support directly so that we
can get rid of the file_extent_tree completely?

Initially I'm wondering why NO_HOLES makes a difference, especially as
NO_HOLES can be set halfway, thus we can still have explicit hole extents.

But it turns out that the whole file_extent_tree() is only to handle
non-NO_HOLES case so that we always have a hole for the whole file range
until i_size.

Considering NO_HOLES is considered safe at 4.0 kernel, can we start
deprecating non-NO_HOLES?

> This is wasteful because that io tree is only
> used for regular files, so we allocate more memory than needed for inode=
s
> that represent directories or symlinks for example, or for inodes that
> correspond to free space inodes.
>
> So improve on this by allocating the io tree only for inodes of regular
> files that are not free space inodes.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
Otherwise looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/file-item.c | 13 ++++++-----
>   fs/btrfs/inode.c     | 53 +++++++++++++++++++++++++++++---------------
>   2 files changed, 42 insertions(+), 24 deletions(-)
>
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index bce95f871750..f3ed78e21fa4 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -45,13 +45,12 @@
>    */
>   void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64=
 new_i_size)
>   {
> -	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>   	u64 start, end, i_size;
>   	int ret;
>
>   	spin_lock(&inode->lock);
>   	i_size =3D new_i_size ?: i_size_read(&inode->vfs_inode);
> -	if (btrfs_fs_incompat(fs_info, NO_HOLES)) {
> +	if (!inode->file_extent_tree) {
>   		inode->disk_i_size =3D i_size;
>   		goto out_unlock;
>   	}
> @@ -84,13 +83,14 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs=
_inode *inode, u64 new_i_siz
>   int btrfs_inode_set_file_extent_range(struct btrfs_inode *inode, u64 s=
tart,
>   				      u64 len)
>   {
> +	if (!inode->file_extent_tree)
> +		return 0;
> +
>   	if (len =3D=3D 0)
>   		return 0;
>
>   	ASSERT(IS_ALIGNED(start + len, inode->root->fs_info->sectorsize));
>
> -	if (btrfs_fs_incompat(inode->root->fs_info, NO_HOLES))
> -		return 0;
>   	return set_extent_bit(inode->file_extent_tree, start, start + len - 1=
,
>   			      EXTENT_DIRTY, NULL);
>   }
> @@ -112,14 +112,15 @@ int btrfs_inode_set_file_extent_range(struct btrfs=
_inode *inode, u64 start,
>   int btrfs_inode_clear_file_extent_range(struct btrfs_inode *inode, u64=
 start,
>   					u64 len)
>   {
> +	if (!inode->file_extent_tree)
> +		return 0;
> +
>   	if (len =3D=3D 0)
>   		return 0;
>
>   	ASSERT(IS_ALIGNED(start + len, inode->root->fs_info->sectorsize) ||
>   	       len =3D=3D (u64)-1);
>
> -	if (btrfs_fs_incompat(inode->root->fs_info, NO_HOLES))
> -		return 0;
>   	return clear_extent_bit(inode->file_extent_tree, start,
>   				start + len - 1, EXTENT_DIRTY, NULL);
>   }
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 9b98aa65cc63..175fd007f0ef 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3781,6 +3781,30 @@ static noinline int acls_after_inode_item(struct =
extent_buffer *leaf,
>   	return 1;
>   }
>
> +static int btrfs_init_file_extent_tree(struct btrfs_inode *inode)
> +{
> +	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> +
> +	if (WARN_ON_ONCE(inode->file_extent_tree))
> +		return 0;
> +	if (btrfs_fs_incompat(fs_info, NO_HOLES))
> +		return 0;
> +	if (!S_ISREG(inode->vfs_inode.i_mode))
> +		return 0;
> +	if (btrfs_is_free_space_inode(inode))
> +		return 0;
> +
> +	inode->file_extent_tree =3D kmalloc(sizeof(struct extent_io_tree), GFP=
_KERNEL);
> +	if (!inode->file_extent_tree)
> +		return -ENOMEM;
> +
> +	extent_io_tree_init(fs_info, inode->file_extent_tree, IO_TREE_INODE_FI=
LE_EXTENT);
> +	/* Lockdep class is set only for the file extent tree. */
> +	lockdep_set_class(&inode->file_extent_tree->lock, &file_extent_tree_cl=
ass);
> +
> +	return 0;
> +}
> +
>   /*
>    * read an inode from the btree into the in-memory inode
>    */
> @@ -3800,6 +3824,10 @@ static int btrfs_read_locked_inode(struct inode *=
inode,
>   	bool filled =3D false;
>   	int first_xattr_slot;
>
> +	ret =3D btrfs_init_file_extent_tree(BTRFS_I(inode));
> +	if (ret)
> +		return ret;
> +
>   	ret =3D btrfs_fill_inode(inode, &rdev);
>   	if (!ret)
>   		filled =3D true;
> @@ -6247,6 +6275,10 @@ int btrfs_create_new_inode(struct btrfs_trans_han=
dle *trans,
>   		BTRFS_I(inode)->root =3D btrfs_grab_root(BTRFS_I(dir)->root);
>   	root =3D BTRFS_I(inode)->root;
>
> +	ret =3D btrfs_init_file_extent_tree(BTRFS_I(inode));
> +	if (ret)
> +		goto out;
> +
>   	ret =3D btrfs_get_free_objectid(root, &objectid);
>   	if (ret)
>   		goto out;
> @@ -8413,20 +8445,10 @@ struct inode *btrfs_alloc_inode(struct super_blo=
ck *sb)
>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(sb);
>   	struct btrfs_inode *ei;
>   	struct inode *inode;
> -	struct extent_io_tree *file_extent_tree =3D NULL;
> -
> -	/* Self tests may pass a NULL fs_info. */
> -	if (fs_info && !btrfs_fs_incompat(fs_info, NO_HOLES)) {
> -		file_extent_tree =3D kmalloc(sizeof(struct extent_io_tree), GFP_KERNE=
L);
> -		if (!file_extent_tree)
> -			return NULL;
> -	}
>
>   	ei =3D alloc_inode_sb(sb, btrfs_inode_cachep, GFP_KERNEL);
> -	if (!ei) {
> -		kfree(file_extent_tree);
> +	if (!ei)
>   		return NULL;
> -	}
>
>   	ei->root =3D NULL;
>   	ei->generation =3D 0;
> @@ -8471,13 +8493,8 @@ struct inode *btrfs_alloc_inode(struct super_bloc=
k *sb)
>   	extent_io_tree_init(fs_info, &ei->io_tree, IO_TREE_INODE_IO);
>   	ei->io_tree.inode =3D ei;
>
> -	ei->file_extent_tree =3D file_extent_tree;
> -	if (file_extent_tree) {
> -		extent_io_tree_init(fs_info, ei->file_extent_tree,
> -				    IO_TREE_INODE_FILE_EXTENT);
> -		/* Lockdep class is set only for the file extent tree. */
> -		lockdep_set_class(&ei->file_extent_tree->lock, &file_extent_tree_clas=
s);
> -	}
> +	ei->file_extent_tree =3D NULL;
> +
>   	mutex_init(&ei->log_mutex);
>   	spin_lock_init(&ei->ordered_tree_lock);
>   	ei->ordered_tree =3D RB_ROOT;

