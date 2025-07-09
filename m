Return-Path: <linux-btrfs+bounces-15380-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70C8AFE52B
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 12:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860EB3B95FB
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 10:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2619289E32;
	Wed,  9 Jul 2025 10:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="BIkUwrLU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F6E28B3FA
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 10:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055504; cv=none; b=KMsnqjAkUDjDu+NPCNUtaPwbM33Q3/uDilydDc+5DxcfPLdHRDiNGaV3x1fkZJoGdeMMN3jRqy7h8KaQIvN36AIrUpJwONQ/9Z1h1gotfAAyLK+ivY7c8neBuVDQVTYJhBbKvTwd0VQTfADKRtaPhpuzoxm2sSXdoQ1fz3GC+To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055504; c=relaxed/simple;
	bh=2qVPdZYYrNbJga+wRoKCLaX/YwBjHANXxbeM/vvYUqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u0Q7f9wrqR4FUNFwsLs2Kqra7o3lAb2ulJ4Mp4V9pbGqcaPtRuLGmzCikrB8kg6LTBNyfcADdSAlNSMlU1dHNuzbSXzT026e9sP9VsOLoiev1+oocEHTxM/riCDDzxMOhy0YcAlBaxXfuyZgcXiMtQUVK2BYsWdBQDS2KaiTQM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=BIkUwrLU; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1752055496; x=1752660296; i=quwenruo.btrfs@gmx.com;
	bh=v6AfraTyYi3U3ix/O5/J7BpMC/h94zle4kZryj+N+Mk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BIkUwrLUqDngfX9SCXTItQuyqqBJpborHzPaOnqz7/6HupsHKl9ZPaMh9qEBZ2B3
	 oXS7yX/X/Wnfh4kk4ogSzXdi8PfQ0tsWUeHRTK/EprKgKr3fGpedi1ySmCr2/RuI7
	 7g+f3/UN4ysBAT5pLXwCG10PVBDQMmvs0PGRWGNZYX8WiWMUR6bxO6R7+xKbioVX4
	 QJ1l3NG9V3z5eZtfoa2XD31oOQ3FZA+KuXQC2ggpNTiIBRwiY2G9Judoiqu31QpX/
	 DHgQfKGQq2GYBxRJ52nW+TCOUP3f4uJ3425X72dDcYi88eInlL56vHckdykhfk4E5
	 0ThlwYozTUUzLXariw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N33Ed-1ufNZz2gHt-011dXo; Wed, 09
 Jul 2025 12:04:55 +0200
Message-ID: <c10339a8-cb80-4fba-803d-797f51d9313d@gmx.com>
Date: Wed, 9 Jul 2025 19:34:52 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] btrfs: use btrfs_inode local variable at
 btrfs_page_mkwrite()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1752050704.git.fdmanana@suse.com>
 <6aefca8792028e0544de96b2d7f5b34ea836d1c7.1752050704.git.fdmanana@suse.com>
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
In-Reply-To: <6aefca8792028e0544de96b2d7f5b34ea836d1c7.1752050704.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:46HTtAPStnXOUssJ3Os7nymUj3g7OHVOwYYFaoJzUJX8KhkRLdN
 K4UTY2AsYcGVdYs6jtCVHOorbiw9B1E7jeOyyOssxvPh3XvxyTTIYwwMZ2GDDyO2NFg1NH4
 orJ1ZlZMAGEf7BbqF+JAI8Uial0pFAarL0D0wILco365RbaiJwCZDPV0VPHmOUsdi0xXOuk
 +0vjiWTI+LlKo5olVnLJA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:L2ekVpZ9WtY=;hIYkzD9/59yfQjaWza/3AncNZDJ
 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



=E5=9C=A8 2025/7/9 18:23, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> Most of the time we want to use the btrfs_inode, so change the local ino=
de
> variable to be a btrfs_inode instead of a vfs inode, reducing verbosity
> by eleminating a lot of BTRFS_I() calls.
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>
[...]
> -		if (btrfs_check_nocow_lock(BTRFS_I(inode), page_start,
> -					   &write_bytes, false) <=3D 0)
> +		if (btrfs_check_nocow_lock(inode, page_start, &write_bytes, false) <=
=3D 0)

I guess we are no longer limited by 80 chars line limit anymore?

What would be the new limit? 100 from checkpatch or something slightly=20
lower like 90?

Thanks,
Qu

>   			goto out_noreserve;
>  =20
>   		if (write_bytes < reserved_space)
> @@ -1876,11 +1875,11 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_f=
ault *vmf)
>  =20
>   		only_release_metadata =3D true;
>   	}
> -	ret =3D btrfs_delalloc_reserve_metadata(BTRFS_I(inode), reserved_space=
,
> +	ret =3D btrfs_delalloc_reserve_metadata(inode, reserved_space,
>   					      reserved_space, false);
>   	if (ret < 0) {
>   		if (!only_release_metadata)
> -			btrfs_free_reserved_data_space(BTRFS_I(inode), data_reserved,
> +			btrfs_free_reserved_data_space(inode, data_reserved,
>   						       page_start, reserved_space);
>   		goto out_noreserve;
>   	}
> @@ -1889,11 +1888,11 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_f=
ault *vmf)
>   	if (ret < 0)
>   		goto out;
>   again:
> -	down_read(&BTRFS_I(inode)->i_mmap_lock);
> +	down_read(&inode->i_mmap_lock);
>   	folio_lock(folio);
> -	size =3D i_size_read(inode);
> +	size =3D i_size_read(&inode->vfs_inode);
>  =20
> -	if ((folio->mapping !=3D inode->i_mapping) ||
> +	if ((folio->mapping !=3D inode->vfs_inode.i_mapping) ||
>   	    (page_start >=3D size)) {
>   		/* Page got truncated out from underneath us. */
>   		goto out_unlock;
> @@ -1911,11 +1910,11 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_f=
ault *vmf)
>   	 * We can't set the delalloc bits if there are pending ordered
>   	 * extents.  Drop our locks and wait for them to finish.
>   	 */
> -	ordered =3D btrfs_lookup_ordered_range(BTRFS_I(inode), page_start, fsi=
ze);
> +	ordered =3D btrfs_lookup_ordered_range(inode, page_start, fsize);
>   	if (ordered) {
>   		btrfs_unlock_extent(io_tree, page_start, page_end, &cached_state);
>   		folio_unlock(folio);
> -		up_read(&BTRFS_I(inode)->i_mmap_lock);
> +		up_read(&inode->i_mmap_lock);
>   		btrfs_start_ordered_extent(ordered);
>   		btrfs_put_ordered_extent(ordered);
>   		goto again;
> @@ -1926,7 +1925,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fau=
lt *vmf)
>   		if (reserved_space < fsize) {
>   			end =3D page_start + reserved_space - 1;
>   			if (!only_release_metadata)
> -				btrfs_delalloc_release_space(BTRFS_I(inode),
> +				btrfs_delalloc_release_space(inode,
>   							     data_reserved, end + 1,
>   							     fsize - reserved_space,
>   							     true);
> @@ -1944,8 +1943,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fau=
lt *vmf)
>   			       EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
>   			       EXTENT_DEFRAG, &cached_state);
>  =20
> -	ret =3D btrfs_set_extent_delalloc(BTRFS_I(inode), page_start, end, 0,
> -					&cached_state);
> +	ret =3D btrfs_set_extent_delalloc(inode, page_start, end, 0, &cached_s=
tate);
>   	if (ret < 0) {
>   		btrfs_unlock_extent(io_tree, page_start, page_end, &cached_state);
>   		goto out_unlock;
> @@ -1964,38 +1962,38 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_f=
ault *vmf)
>   	btrfs_folio_set_dirty(fs_info, folio, page_start, end + 1 - page_star=
t);
>   	btrfs_folio_set_uptodate(fs_info, folio, page_start, end + 1 - page_s=
tart);
>  =20
> -	btrfs_set_inode_last_sub_trans(BTRFS_I(inode));
> +	btrfs_set_inode_last_sub_trans(inode);
>  =20
>   	if (only_release_metadata)
>   		btrfs_set_extent_bit(io_tree, page_start, end, EXTENT_NORESERVE,
>   				     &cached_state);
>  =20
>   	btrfs_unlock_extent(io_tree, page_start, page_end, &cached_state);
> -	up_read(&BTRFS_I(inode)->i_mmap_lock);
> +	up_read(&inode->i_mmap_lock);
>  =20
> -	btrfs_delalloc_release_extents(BTRFS_I(inode), fsize);
> +	btrfs_delalloc_release_extents(inode, fsize);
>   	if (only_release_metadata)
> -		btrfs_check_nocow_unlock(BTRFS_I(inode));
> -	sb_end_pagefault(inode->i_sb);
> +		btrfs_check_nocow_unlock(inode);
> +	sb_end_pagefault(inode->vfs_inode.i_sb);
>   	extent_changeset_free(data_reserved);
>   	return VM_FAULT_LOCKED;
>  =20
>   out_unlock:
>   	folio_unlock(folio);
> -	up_read(&BTRFS_I(inode)->i_mmap_lock);
> +	up_read(&inode->i_mmap_lock);
>   out:
> -	btrfs_delalloc_release_extents(BTRFS_I(inode), fsize);
> +	btrfs_delalloc_release_extents(inode, fsize);
>   	if (only_release_metadata)
> -		btrfs_delalloc_release_metadata(BTRFS_I(inode), reserved_space, true)=
;
> +		btrfs_delalloc_release_metadata(inode, reserved_space, true);
>   	else
> -		btrfs_delalloc_release_space(BTRFS_I(inode), data_reserved,
> -					     page_start, reserved_space, true);
> +		btrfs_delalloc_release_space(inode, data_reserved, page_start,
> +					     reserved_space, true);
>   	extent_changeset_free(data_reserved);
>   out_noreserve:
>   	if (only_release_metadata)
> -		btrfs_check_nocow_unlock(BTRFS_I(inode));
> +		btrfs_check_nocow_unlock(inode);
>  =20
> -	sb_end_pagefault(inode->i_sb);
> +	sb_end_pagefault(inode->vfs_inode.i_sb);
>  =20
>   	if (ret < 0)
>   		return vmf_error(ret);


