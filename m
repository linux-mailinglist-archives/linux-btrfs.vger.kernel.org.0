Return-Path: <linux-btrfs+bounces-2299-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C83850369
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Feb 2024 08:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02137285BA1
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Feb 2024 07:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351F5374FD;
	Sat, 10 Feb 2024 07:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="rJr4ZTTy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674DC36AF1
	for <linux-btrfs@vger.kernel.org>; Sat, 10 Feb 2024 07:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707551388; cv=none; b=ITBQnEk71tgZN/awttR9D4xMF6yVN612VIdO795STY/0HaRljo0n3xKu4fE+y0Ql9NfyCzdLWXFbM6dKvY5m5Y92vMC9Ag3tmk0aYTY0xAq0YTYhhkLnKrB3G8YmvRgGOcwc46gUiQ1c5kE8wQfkMLmtP+m9VAFyhrex0GLNkXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707551388; c=relaxed/simple;
	bh=r2q//TWOUizItPqzxYXDCE/rYZcNfPL0gx8uQrC6+w8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tD2/LKIa34JMKr/nvrizdCYNDViukilU/bgPtewKJz5fKlTKtm6Mu0iaPg/PtuIAzPYN+GiFE4i1t14FlexRMOs5dBspyMLozsVPSHkB2MUfIDMUuj4rQFOoi/x0uqSc+jRnbZ80vT4xI5HtIWNbHYGDvmydFTmx86i1gCDjsqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=rJr4ZTTy; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707551379; x=1708156179; i=quwenruo.btrfs@gmx.com;
	bh=r2q//TWOUizItPqzxYXDCE/rYZcNfPL0gx8uQrC6+w8=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=rJr4ZTTyqWSgYvYLTWCC9N0WZtYgiiOBoFkdTM9C4ymx70PvWhaRyMYkzEbqnHTK
	 iPCLi+7NykuVrqnlIsFq6pqht6xBk4g8tYwOfkfFlavvraK/mv44z2liVDzOKTSFJ
	 vttI5gX7TckXM9SD1a2R0qNWrWGv43UmfHgk3knJ/ptBd0wWTXS3LJXPkJLM/lP7L
	 R7VMhAr2Ne3Ofn0MH/qZEhVE+Qkw8H2l2buQNTthhCupoLTjvjioE6n1Hs/4DUJV2
	 p/6p3mOqxPDxQPPmT4opv4+PELpAjF0sovG8ipVdR/89zt4GAe8Qk/bE/lOiMRMO9
	 36AwR9FKtJoW/R4I+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMXQF-1rFG7h3v1z-00JeD9; Sat, 10
 Feb 2024 08:49:39 +0100
Message-ID: <1627445f-7751-49fa-a8da-6033ac5a45ab@gmx.com>
Date: Sat, 10 Feb 2024 18:19:38 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] btrfs: remove do_list variable at
 btrfs_clear_delalloc_extent()
Content-Language: en-US
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1707491248.git.fdmanana@suse.com>
 <c943cf4b01e5e27d04c0cf8dbf58d9f2ff8119af.1707491248.git.fdmanana@suse.com>
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
In-Reply-To: <c943cf4b01e5e27d04c0cf8dbf58d9f2ff8119af.1707491248.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oC57DANpcVdJKP3cjC+DMw27kQ6Ojb+EexQtjjj1WcRXtD9eMbh
 KlSEhDDGz3sUxl7sortkkkCQ/qgf1zzcXDtmHHut9JUoY69NmSabzNcRSqQux7sNpkJjMCi
 jgWEO5jJlqLMsCFjjqMdU93I6Vol2h9DUoHTCSfrn9RSsElOFXQ1QfhzHn0nkqWxpjDjkMJ
 AkHH6W082geplNqzS7mKQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XS61agUFeAk=;fHk75LvJVcBEpVz0YIROsx9XVWV
 j+7rZK2GZzxgm8d7VoRskfie+r+XqTMVkgO5vmIN+iE5q1dE/I5N1bYzbSWDbdZFDEusdUDJz
 i2dzypbZHUDbZeRr6VL4otKQhgQBgmWpXrNovya1Q6Yl0bBE3ABmrKIXiBWN9P2wO7SYTp+x5
 0XM4DQNBWiR4NsYiAiQLSrdKwY3oeFEN8phxdfX+iXjwZ/2t/9QrCmLNlvR+HG2g0CiGC/+Qn
 tTe399Wth4Ocw+ENgZKqtab98ciCM3Lkmz2+seumHit9uTbyTNFVIEX7t6wRrsqXtw212X84J
 1nBT8G75cdAm5HSvCnCeVfmBrWT0v+tlBucGVFd5RNK29xGMwEzS8FT5JBViyntmuns+YDkem
 IFQKHxIFhZyAC5CP7NQJoXIEFPxiTFXe01ODBQ6EYqYdx/OPEsjM8sAUf9Yw/Qi6DiL0Zcdws
 3/qtcy02gat9od+Vw3U7V+/LBfjmXF0kYySnxbFwm+SeXVZtny5/pQ6fAUvVuJnQE3JYo3Q2P
 BlK5KVmOVidkZ8RY11VNvNbDgm3Xhn+herAqpln2YFQJDArQVNEH/BOwxmvej7EYkn+s/aeP1
 RELeZH1e7KC6IR7S354KKmv+9/nBXs9OZVk3827rGe043tygOaeKpQfpBTBGX3jXMIe4zJQgm
 GCfMaXqV1zxkTp/ur9638hZ0iv27pLdmsBHZifZIFx77yviK71gYCyFe4ZqOXP6Oj36G6Q/UK
 Gds6Wxu2JxQ46VJqqpAJGqjzRpiCRO+UPn8q6vIUH5ofTJofhq1wQxibk+wyswtUOT4w7yNGB
 1wFfNGi7AqDdaDBE+tK9qcEx2SPIahQZkJrYloYPunF9k=



On 2024/2/10 04:30, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> The "do_list" variable has a rather confusing name, so remove it and
> directly use btrfs_is_free_space_inode() instead.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/inode.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 17b6ab71584a..5bb61d4aa2cb 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2525,7 +2525,6 @@ void btrfs_clear_delalloc_extent(struct btrfs_inod=
e *inode,
>   	if ((state->state & EXTENT_DELALLOC) && (bits & EXTENT_DELALLOC)) {
>   		struct btrfs_root *root =3D inode->root;
>   		u64 new_delalloc_bytes;
> -		bool do_list =3D !btrfs_is_free_space_inode(inode);
>
>   		spin_lock(&inode->lock);
>   		btrfs_mod_outstanding_extents(inode, -num_extents);
> @@ -2545,7 +2544,8 @@ void btrfs_clear_delalloc_extent(struct btrfs_inod=
e *inode,
>   			return;
>
>   		if (!btrfs_is_data_reloc_root(root) &&
> -		    do_list && !(state->state & EXTENT_NORESERVE) &&
> +		    !btrfs_is_free_space_inode(inode) &&
> +		    !(state->state & EXTENT_NORESERVE) &&
>   		    (bits & EXTENT_CLEAR_DATA_RESV))
>   			btrfs_free_reserved_data_space_noquota(fs_info, len);
>
> @@ -2562,7 +2562,7 @@ void btrfs_clear_delalloc_extent(struct btrfs_inod=
e *inode,
>   		 * and are therefore protected against concurrent calls of this
>   		 * function and btrfs_set_delalloc_extent().
>   		 */
> -		if (do_list && new_delalloc_bytes =3D=3D 0)
> +		if (!btrfs_is_free_space_inode(inode) && new_delalloc_bytes =3D=3D 0)
>   			btrfs_del_delalloc_inode(inode);
>   	}
>

