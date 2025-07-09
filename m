Return-Path: <linux-btrfs+bounces-15378-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66055AFE4D8
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 12:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D9917B2E5
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 10:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA91F1FC0F3;
	Wed,  9 Jul 2025 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="N7m5nenz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99607288502
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 10:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055349; cv=none; b=pzozvnk/3SGKl1xIH8vlzxlT/m/sUaAx0UUcnpRHPXAYG2M8RmQ5gMs6hHrZqw9jfIFCJG7hYxI+FEzrnbnDkwoNJINeiy2WjZD7eh/jRrSD+RLFZO3UMFbUNvzjMYBlvo1zoJ8oFc5iQ2X2FsxAImV/n23dfOAVFa8N+tUlTqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055349; c=relaxed/simple;
	bh=PsXpSOSAODAsMT4+lP3o/A42FxYIy31Mvn4hR1/cmFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ko2ffD7rPViUCaILDpoQd7HxKMmJhpawRiw4q3l0rH1sHOiq7+kflPWKk75G6hOGl3MWn+2g7gk6lhIhnv+SPImMxPfPLjnwuorOg5wDGzmkb9yMptRakylfBQHX4rs6QWplcLJfmjrq7yM3PoItNnJFf4UedqM85hxoSaPruN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=N7m5nenz; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1752055344; x=1752660144; i=quwenruo.btrfs@gmx.com;
	bh=oV78zq87HI4ZHYowPDUn0E92qloY4e6JyR+ZgLr+xo0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=N7m5nenzNA4apHaerZfqt/G1jG0KScNUJcRJF8g4PmmJTlQiCt6G6wSONP30HYec
	 jHm3H0ovkoTKSA1ANIUJzKmKJf0jzsq6GM4RCwsvAf+J/w0DAxLl+a0hEb8iCkoX/
	 YnlsRXwNF1JCnxofK2zbj3obwQ/abHbWbxaV7JAiI6Tr06Q3ppTDIoUmm6ZxYLYDQ
	 D79mfoK9HLp/X7TwCry0EOSVa0ynCw7nHS/vGnKBP+jP/jKwW7yZTqxMQcB+smS7n
	 vDEO9coWxYiKHeVjrXoqAmlzAdJwBgjVPKHUMIlpimq6B7SNFmSN0WJjTevcBYDuH
	 zDUm8TUJn/IzuRqYag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MpDNl-1v0jxX0AEp-00niCm; Wed, 09
 Jul 2025 12:02:24 +0200
Message-ID: <bb1cb822-39fc-4fe9-83b3-25d44eafbc50@gmx.com>
Date: Wed, 9 Jul 2025 19:32:21 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] btrfs: fix -ENOSPC mmap write failure on NOCOW
 files/extents
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1752050704.git.fdmanana@suse.com>
 <91b4d80da9b7938b6f7b0c628a6c0cf896f97061.1752050704.git.fdmanana@suse.com>
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
In-Reply-To: <91b4d80da9b7938b6f7b0c628a6c0cf896f97061.1752050704.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h9Wdj4I9dyEGi9IpQoXgPeC5+aSOLt7MgiO0sr/E7B+YEWBPdbh
 D9JcGl3tMxr/UkcFHi+syU9Jh3jf4fVUpZeLVuVXfZgugn9CiWaUQMP9jchPhbQ+mtK+UR6
 setqiWukQCrWmlmc87iFM7PcWnWln7DlEReQzoNwuORdH5tcG+1cpbD/wGpX8fKHC7rirgC
 zUyacsVWijcT9U76HMw7w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:shcwCZ9LOVc=;Ol3zTugaTgxoqUq7jjPOodvZ+r3
 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



=E5=9C=A8 2025/7/9 18:23, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> If we attempt a mmap write into a NOCOW file or a prealloc extent when
> there is no more available data space (or unallocated space to allocate =
a
> new data block group) and we can do a NOCOW write (there are no reflinks
> for the target extent or snapshots), we always fail due to -ENOSPC, unli=
ke
> for the regular buffered write and direct IO paths where we check that w=
e
> can do a NOCOW write in case we can't reserve data space.
>=20
> Simple reproducer:
>=20
>    $ cat test.sh
>    #!/bin/bash
>=20
>    DEV=3D/dev/sdi
>    MNT=3D/mnt/sdi
>=20
>    umount $DEV &> /dev/null
>    mkfs.btrfs -f -b $((512 * 1024 * 1024)) $DEV
>    mount $DEV $MNT
>=20
>    touch $MNT/foobar
>    # Make it a NOCOW file.
>    chattr +C $MNT/foobar
>=20
>    # Add initial data to file.
>    xfs_io -c "pwrite -S 0xab 0 1M" $MNT/foobar
>=20
>    # Fill all the remaining data space and unallocated space with data.
>    dd if=3D/dev/zero of=3D$MNT/filler bs=3D4K &> /dev/null
>=20
>    # Overwrite the file with a mmap write. Should succeed.
>    xfs_io -c "mmap -w 0 1M"        \
>           -c "mwrite -S 0xcd 0 1M" \
>           -c "munmap"              \
>           $MNT/foobar
>=20
>    # Unmount, mount again and verify the new data was persisted.
>    umount $MNT
>    mount $DEV $MNT
>=20
>    od -A d -t x1 $MNT/foobar
>=20
>    umount $MNT
>=20
> Running this:
>=20
>    $ ./test.sh
>    (...)
>    wrote 1048576/1048576 bytes at offset 0
>    1 MiB, 256 ops; 0.0008 sec (1.188 GiB/sec and 311435.5231 ops/sec)
>    ./test.sh: line 24: 234865 Bus error               xfs_io -c "mmap -w=
 0 1M" -c "mwrite -S 0xcd 0 1M" -c "munmap" $MNT/foobar
>    0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
>    *
>    1048576
>=20
> Fix this by not failing in case we can't allocate data space and we can
> NOCOW into the target extent - reserving only metadata space in this cas=
e.
>=20
> After this change the test passes:
>=20
>    $ ./test.sh
>    (...)
>    wrote 1048576/1048576 bytes at offset 0
>    1 MiB, 256 ops; 0.0007 sec (1.262 GiB/sec and 330749.3540 ops/sec)
>    0000000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
>    *
>    1048576
>=20
> A test case for fstests will be added soon.
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

With large data folios, I'm afraid we may fail the nocow check more=20
frequently than the regular page sized folios.
But that's unavoidable, we have to ensure the whole folio can be written=
=20
back NOCOW.

Thanks,
Qu

> ---
>   fs/btrfs/file.c | 49 +++++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 41 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 05b046c6806f..f08c72dbb530 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1841,6 +1841,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fau=
lt *vmf)
>   	loff_t size;
>   	size_t fsize =3D folio_size(folio);
>   	int ret;
> +	bool only_release_metadata =3D false;
>   	u64 reserved_space;
>   	u64 page_start;
>   	u64 page_end;
> @@ -1861,10 +1862,28 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_f=
ault *vmf)
>   	 * end up waiting indefinitely to get a lock on the page currently
>   	 * being processed by btrfs_page_mkwrite() function.
>   	 */
> -	ret =3D btrfs_delalloc_reserve_space(BTRFS_I(inode), &data_reserved,
> -					   page_start, reserved_space);
> -	if (ret < 0)
> +	ret =3D btrfs_check_data_free_space(BTRFS_I(inode), &data_reserved,
> +					  page_start, reserved_space, false);
> +	if (ret < 0) {
> +		size_t write_bytes =3D reserved_space;
> +
> +		if (btrfs_check_nocow_lock(BTRFS_I(inode), page_start,
> +					   &write_bytes, false) <=3D 0)
> +			goto out_noreserve;
> +
> +		if (write_bytes < reserved_space)
> +			goto out_noreserve;
> +
> +		only_release_metadata =3D true;
> +	}
> +	ret =3D btrfs_delalloc_reserve_metadata(BTRFS_I(inode), reserved_space=
,
> +					      reserved_space, false);
> +	if (ret < 0) {
> +		if (!only_release_metadata)
> +			btrfs_free_reserved_data_space(BTRFS_I(inode), data_reserved,
> +						       page_start, reserved_space);
>   		goto out_noreserve;
> +	}
>  =20
>   	ret =3D file_update_time(vmf->vma->vm_file);
>   	if (ret < 0)
> @@ -1906,9 +1925,11 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fa=
ult *vmf)
>   		reserved_space =3D round_up(size - page_start, fs_info->sectorsize);
>   		if (reserved_space < fsize) {
>   			end =3D page_start + reserved_space - 1;
> -			btrfs_delalloc_release_space(BTRFS_I(inode),
> -					data_reserved, end + 1,
> -					fsize - reserved_space, true);
> +			if (!only_release_metadata)
> +				btrfs_delalloc_release_space(BTRFS_I(inode),
> +							     data_reserved, end + 1,
> +							     fsize - reserved_space,
> +							     true);
>   		}
>   	}
>  =20
> @@ -1945,10 +1966,16 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_f=
ault *vmf)
>  =20
>   	btrfs_set_inode_last_sub_trans(BTRFS_I(inode));
>  =20
> +	if (only_release_metadata)
> +		btrfs_set_extent_bit(io_tree, page_start, end, EXTENT_NORESERVE,
> +				     &cached_state);
> +
>   	btrfs_unlock_extent(io_tree, page_start, page_end, &cached_state);
>   	up_read(&BTRFS_I(inode)->i_mmap_lock);
>  =20
>   	btrfs_delalloc_release_extents(BTRFS_I(inode), fsize);
> +	if (only_release_metadata)
> +		btrfs_check_nocow_unlock(BTRFS_I(inode));
>   	sb_end_pagefault(inode->i_sb);
>   	extent_changeset_free(data_reserved);
>   	return VM_FAULT_LOCKED;
> @@ -1958,10 +1985,16 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_f=
ault *vmf)
>   	up_read(&BTRFS_I(inode)->i_mmap_lock);
>   out:
>   	btrfs_delalloc_release_extents(BTRFS_I(inode), fsize);
> -	btrfs_delalloc_release_space(BTRFS_I(inode), data_reserved, page_start=
,
> -				     reserved_space, true);
> +	if (only_release_metadata)
> +		btrfs_delalloc_release_metadata(BTRFS_I(inode), reserved_space, true)=
;
> +	else
> +		btrfs_delalloc_release_space(BTRFS_I(inode), data_reserved,
> +					     page_start, reserved_space, true);
>   	extent_changeset_free(data_reserved);
>   out_noreserve:
> +	if (only_release_metadata)
> +		btrfs_check_nocow_unlock(BTRFS_I(inode));
> +
>   	sb_end_pagefault(inode->i_sb);
>  =20
>   	if (ret < 0)


