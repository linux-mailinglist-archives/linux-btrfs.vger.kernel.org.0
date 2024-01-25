Return-Path: <linux-btrfs+bounces-1773-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A759883B899
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 05:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63851C23881
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 04:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9EFCA50;
	Thu, 25 Jan 2024 04:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="oMqZYuID"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90E38829
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 04:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706155819; cv=none; b=a34UnBXU7HAdBFPRMZjFBALT6RVKch+HKNjtPKYTu/5krccj04L3u41hSEkgCoMNg6dsfwbb1RKULHgPYRxFGlRErKZEXlH6vJzupFUvz19iDV2wu1hnBuP0Bzj8a/E/YUHI/ui+vMtdvZ9hIVPC1OiI6JG3z+1YUch7pqsyeIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706155819; c=relaxed/simple;
	bh=C3YVppJ5UrEwSLkHEeLzz0RlMlRNYUgqE+zOauXiqLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lruMQtTb09DWkasY8ETEnknuU60MNkgE83tf1bWJ2ihf5KrLjg8DrXR7Ul7bDnsuarePTK6pPW2l9Hs9iBKNjc6EMrZT0qBR8RODJaZnlJC4THBfbBB1C5qEVQL24sdceVaMPTAlHya1fjaCdUt8sk4Znqsc7wdhrkz2ZSweiYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=oMqZYuID; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1706155815; x=1706760615; i=quwenruo.btrfs@gmx.com;
	bh=C3YVppJ5UrEwSLkHEeLzz0RlMlRNYUgqE+zOauXiqLk=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=oMqZYuIDeC5jrjOc4B5fNogOXmqbBAMZ5eKHq0D3s55+1G0QEMgwVd9mcXAiAnS/
	 22gqh0ibL+Nqf0rfkMTfAEHzM3JPMGe35teq4V8heAEHWZOlQiToXB0GYbfA4GbiI
	 aPkjQb53pygazGFjfuC29dAbM2tHNvUL4hFbYrLixBo41uARRbPUrLfSaKKlc0XGB
	 zMzgaJSe3y3vm1FLpMBokSNL5wcFp+YJeODOSO0s19A7mKil5qe7l7oiqkCwIlr26
	 dANZjMJcXk4XlduwwrF0p2xEn6K2Z/HLVNg2Zv2dJstUnt+QiLeOKofflkgg+nW2H
	 43zdEZGWMW3zgLYp0w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([61.245.157.120]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MMGN2-1rm1qK2cys-00JJMW; Thu, 25
 Jan 2024 05:10:15 +0100
Message-ID: <c917ba6b-142d-4ed3-b968-b850ae9079a5@gmx.com>
Date: Thu, 25 Jan 2024 14:40:12 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/20] btrfs: handle invalid extent item reference found
 in check_committed_ref()
Content-Language: en-US
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1706130791.git.dsterba@suse.com>
 <139f98f6906bcd774f867e1ef4020fa948ebef93.1706130791.git.dsterba@suse.com>
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
In-Reply-To: <139f98f6906bcd774f867e1ef4020fa948ebef93.1706130791.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c3gAJX5hirVoOnK6bqWkaf/2nFAkyX8OvrP7gD2ek9jU8DvyVmv
 5FoQAceDaIfq1/NRnH0vjLSClZc0bBY90D7fhobdC/wXo3QmkhrJPWWovh4SUyN2A80B4Hq
 YdFBLEggt3AyYqrsoQlNFNz616clAW9siGlaO6lJBqUoORbUkHio1mawwo10LQK+HEnlC/A
 p+4Uq7doAk8o2PQJVbcog==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8C2umELAOb4=;E92w10lwy2muZddgatYRYXLWGH6
 D7MoZZwqFKk14CcFQW/ROjPE9GZbfzocx9mUW4gjN8Uv5SOxXUG1+0s7AtmOuQqbDr3TE7SBO
 TS9LTKbHefdXRQXwBRiZzvWPluEhyNlGkvkwSoYVbBGrDhY7vM7aGBLBJwtUHd9YsNKU+ffIH
 OFbEAt9ePQLV4c9/xrGpnucKTykLc2d0l2aCLtOaBLQRNg4jKv95FlbQ9rcBiYyVnTxsKpCrM
 O/NlV5Js1M6m2vLUVrd4NYe+tkA07vud2tIKrtLZPC9xQLm4HyaNywDyuRAWxsSQWZy9glT8z
 XlJXSm4UI6zUxO3WmXP/1w/t7tAHbaQo4Xy8pIVpl42uljHpm2l+FmbJhUiH0xQcVaRvXVJTG
 p4o4nPp5dP0Rg14vrKS4QpNYtmrZNqqnb0M0gZnXKjpzzqYf6bUPGyRF8ZKba95WBJNHKDQiI
 cQkwA/Veop8+OGfbGpvv9uOzuFRnJaxANybMQW8EtJdJQaFgCCPYMFDC2NtmoC/HQeSeFCcyr
 FvGrsEcqSPJz320HiQP3PCJE+e7uJ8eY3vfWvdYti6xLKDLiMlUKYvYm74CeQcbsFxcnnfFNU
 34Qn8bkgHmrofrmn6/3/xEHnYxe1IJOY/eeAy31L1OyubQWgHLgcqCLkKJbnb8eY5ZCeZTnsj
 tTbIXMBdg0bvcaofUnMby40wPfBd3jUNw0X10SOdqlYfqRcR+cNVANwBIHl4BIr4BMANFXcED
 fjo8cnbDKDjYh2hlcFhVrlo5Pc2sIRe/6m5wXd8o6DlwFOE3nGfofqqTRVBgCgoBdWQs5GOSk
 hVEU3sjmMA7x+b7F88PWdBT7KNnz+v0qlhOvXzRM6okg3YSUPEDQoZGEfutfeUCjAZWMF59mV
 XI9RvX8EBpqdhmuPKBkCVx6jxpsT0MTvO5OkeCUCWzQTf8+s5gnRRUA/BJ0a/4xxKx8DW+Ne2
 d/RwcZaSQptnF9JR1BlnanaFInA=



On 2024/1/25 07:48, David Sterba wrote:
> The check_committed_ref() helper looks up an extent item by a key,
> allowing to do an inexact search when key->offset is -1.  It's never
> expected to find such item, as it would break the allowed range of a
> extent item offset.
>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/extent-tree.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 4283e3025ab0..ba47f5996c84 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2399,7 +2399,14 @@ static noinline int check_committed_ref(struct bt=
rfs_root *root,
>   	ret =3D btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
>   	if (ret < 0)
>   		goto out;
> -	BUG_ON(ret =3D=3D 0); /* Corruption */
> +	if (ret =3D=3D 0) {
> +		/*
> +		 * Key with offset -1 found, there would have to exist an extent
> +		 * item with such offset, but this is out of the valid range.
> +		 */
> +		ret =3D -EUCLEAN;
> +		goto out;
> +	}

It looks like we also need an key offset check for extent item.

Thanks,
Qu
>
>   	ret =3D -ENOENT;
>   	if (path->slots[0] =3D=3D 0)

