Return-Path: <linux-btrfs+bounces-5797-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9162690DE7F
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 23:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81F401C20A55
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 21:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88533177986;
	Tue, 18 Jun 2024 21:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="LuK3mhZE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4155413DDD2
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2024 21:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718746573; cv=none; b=Dd07QOZuhbsS+HU/z1eKdHmgebdnOK5ib/9/DmuasLgU2I+XXoENEuudS7md0+ldReZGq6MpmT+Z2JlTNEh/dU3iCxarU1NoRHmPrkw1YiiqiHCMZVUC3pKLGHeco7yps9Z8gRUmasGx9U9FcwPHhdejD7oMWzie5EClOwo9/nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718746573; c=relaxed/simple;
	bh=ij3oRdDf5X8Tf6fRoe8zsxpjo4uBrtZT6Sa+DFDZ0bU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BgZV6LL1dRGX7twiyckKEAGjp1yKsKyEIlxAekQ8wHbrJIGsr2OiJE1/E3MHRCYhrVpC4Ofv2h17pkkEfL+y0EJ5f8LLEhpIHqSl+oD5o2FDr6WXQzGbh0mjV5IQWdnWWJZvVDvTaZC03exarzKO7iSRnADG1F4vRoLdLl3Vbis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=LuK3mhZE; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1718746563; x=1719351363; i=quwenruo.btrfs@gmx.com;
	bh=PAyWQpmdrXG4oC39OdERkinWd5ZpF7Jl31mxZ32Zw0c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LuK3mhZEBGHFdJ6lkids/3VOgAnhkvgp9Krb+QR0nAHolVlqV+1XQ4PPo8cMaPy6
	 AgOqnnX7gVYluzlgWEqwwAUFQ2TN+OzIywF/zlJbfBa1JpPs1/jD/DFum/BdvTK/q
	 0hGxwylnuyQ4+xzerY591WyDVo+Rw/zXDlpJD5abJFvQS0KsbrI1gZO4HUcMAWt3u
	 Yk7WUqpxWzLKIRj2OvVsZGM7e3xRzSZfNFYbBJv9ullEvciQotweIRu0i0XLP116D
	 OYVfbC/lIjxIGYVbd3YoZ7UaZof/0KbKiJW8JFw1O6IvhIv/4nGjBFEbKb1Qc56jc
	 GH2ykuW3l90T1uEu1g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MRmfo-1rvvUO0hiM-00TqUN; Tue, 18
 Jun 2024 23:36:02 +0200
Message-ID: <282c7846-8ed9-4f3d-9b52-1994ee879499@gmx.com>
Date: Wed, 19 Jun 2024 07:05:58 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: remove NULL transaction support for
 btrfs_lookup_extent_info()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <053ee6d9b396be679070a5540b3452ee6e11a7d6.1718695906.git.fdmanana@suse.com>
 <a35d5db1edc40dff98f30a46ada610ec4604114d.1718706031.git.fdmanana@suse.com>
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
In-Reply-To: <a35d5db1edc40dff98f30a46ada610ec4604114d.1718706031.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i7nkhdWFSgsWAMcG+R/MKU2BuAVXv7MRahUdXE2DldHchSCMVRk
 OxxyVOAC00P47P3wSKrGTESSrQdVbZIqcjTLxAWZLC6bpQx54T/OBfoAODFVBOiJd6oyzHC
 lB4rOVKiatJ2/vyrvJKNwfEd1k7FpzhIKdz6uEkany4f9zlJXt1rzMdReIl/59BP7c9Yb09
 OBUtFKKJqEUhtD9kYMXtg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mo464k6GVfI=;+hytuSvdpOLnIH7/9L3FIGl8SC9
 g9084IUgvdVPrOyIK4e3cUyyE3lvlvzwYVzyNggUSwwutkkR8FpJI1qntYMLHIWHD0tucPdmB
 DhdEWqIQp1rRF6qTP/p2ikFB5SgGWcImlmwk9AqWeM3xGacgoT+QNqfnrdwfTZQJf3MJgfGUT
 NmwdXyPjpFWxCr5AprFn5K/W+8KM7svB5alsZpKYMD7bwBsZ82p+n8KF52ANp7hI+RlAZc9nR
 jLifw03kCb8vBDeyRu2YsmhDWOW0LaNHSg7NOrOiuePPmfzBdGcAxLnsYE752Wqa9XlZ/A1VU
 a/EAOTEUzaJK/ZJYO8jzjdpHnypQ+l81+IuyA/Mj1wF2fd1fp5LKgFaS2JojozSv5p9+U76pV
 EdXJ5gjNp3ec3oCscaGMlio3IJIHI6mN7aw1rP245k/yjA9Q2rVDlTqgU5Ie7dpxS8FwpDrYG
 frRDY2h1NeDqMxgWMIDRA1Ud6BmkWpZ2M3L/yaEVusN1Z+YaBt4KuvEUrU+XzaDHz/9caj3Xc
 R36yq+s9H4SpH+ZBsPwwl+gTc+PDS3OO0F45MGy569ptC/SaJtjnFBOa3rui77MugevxDUOEl
 dYT5xTbyBJ6IYQ2Uv9an0spV2vZqw8d6+gYeWu3d4OuTNJFXwfIh5CO8gYx8ywyBy9WOyP/Fb
 ihOJS42jNhuaKkZZH83Pi6uuuUDjRQW/dePvqoFnAT5QLUVXwKXqjdVzzrXy35elYc0WlOY3m
 jGQtlHKST9zx2STe262AYM523Een7iJvo/DGas2I1K4q6kDFG1Ozv7In88U9bhEVh0oZVgRye
 w0dTMj3DnQ2Jt1cSnvW0quSLOvfnxwbq3A1mGW66zfNhY=



=E5=9C=A8 2024/6/18 19:52, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> There are no callers of btrfs_lookup_extent_info() that pass a NULL valu=
e
> for the transaction handle argument, so there's no point in having speci=
al
> logic to deal with the NULL. The last caller that passed a NULL value wa=
s
> removed in commit 19b546d7a1b2 ("btrfs: relocation:
> Use btrfs_find_all_leafs to locate data extent parent tree leaves").
>
> So remove the NULL handling from btrfs_lookup_extent_info().
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>
> V2: Remove the transaction abort logic check for NULL transaction too.
>
>   fs/btrfs/extent-tree.c | 16 ++--------------
>   1 file changed, 2 insertions(+), 14 deletions(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 58a72a57414a..21d123d392c0 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -126,11 +126,6 @@ int btrfs_lookup_extent_info(struct btrfs_trans_han=
dle *trans,
>   	if (!path)
>   		return -ENOMEM;
>
> -	if (!trans) {
> -		path->skip_locking =3D 1;
> -		path->search_commit_root =3D 1;
> -	}
> -
>   search_again:
>   	key.objectid =3D bytenr;
>   	key.offset =3D offset;
> @@ -171,11 +166,7 @@ int btrfs_lookup_extent_info(struct btrfs_trans_han=
dle *trans,
>   			btrfs_err(fs_info,
>   			"unexpected extent item size, has %u expect >=3D %zu",
>   				  item_size, sizeof(*ei));
> -			if (trans)
> -				btrfs_abort_transaction(trans, ret);
> -			else
> -				btrfs_handle_fs_error(fs_info, ret, NULL);
> -
> +			btrfs_abort_transaction(trans, ret);
>   			goto out_free;
>   		}
>
> @@ -186,9 +177,6 @@ int btrfs_lookup_extent_info(struct btrfs_trans_hand=
le *trans,
>   		ret =3D 0;
>   	}
>
> -	if (!trans)
> -		goto out;
> -
>   	delayed_refs =3D &trans->transaction->delayed_refs;
>   	spin_lock(&delayed_refs->lock);
>   	head =3D btrfs_find_delayed_ref_head(delayed_refs, bytenr);
> @@ -219,7 +207,7 @@ int btrfs_lookup_extent_info(struct btrfs_trans_hand=
le *trans,
>   		mutex_unlock(&head->mutex);
>   	}
>   	spin_unlock(&delayed_refs->lock);
> -out:
> +
>   	WARN_ON(num_refs =3D=3D 0);
>   	if (refs)
>   		*refs =3D num_refs;

