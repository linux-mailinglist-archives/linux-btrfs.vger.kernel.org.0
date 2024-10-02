Return-Path: <linux-btrfs+bounces-8462-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C63598E4CF
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 23:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CE41B2039F
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 21:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161AB217305;
	Wed,  2 Oct 2024 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="RBoGXQnB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E27216A33
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 21:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727904088; cv=none; b=if4sNCGiUdD5WYwvBHVrgxAPA3oCGOqgpJg7A0HUqwkuTtKoDmvsjuZ11fbGt78HxghHLTXZFb77e7qI+xccKwPnAEFZIy9DuIeRNaRwIvHpjr1F1fLzZFmA80vyYRJiHyzIJdGveRCUGdfeaf0i6A6c0AOxmKL9whsS017QnqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727904088; c=relaxed/simple;
	bh=wJL59/Cf+NPRbItCgkvjDu2EofkqQjKNyr8HsE+AltU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Gm2kzjDgoRFxvJ5T5fQR3fXLQiEYCWrZcD7nEjDSf0aOV3W3UWjUeldlKRBtmZI0ktHpafgyCHrswvVjtfie3G1D+hrbCJX6wT+pqxgBvdR/EAyvioeiqkjXz3YQ67xnefez2ANItEDDnYdUzxFee3TBx3K9EdsJxHAH9di7uKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=RBoGXQnB; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727904073; x=1728508873; i=quwenruo.btrfs@gmx.com;
	bh=cQeYDFLqrhIVSK3PEGEXSEgpwBlK7lPqgrtjAGCtRP8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RBoGXQnBLuv7eRLz5mWoRb8HxtVTxfT6WlX7XL09LYli4IodLnNG+8ZwrMhXSFh/
	 Jh9rdtXxcjXjLGty3jfydGYTPOqfkxY8UdbV3bFbpJtAzL/EMnglw1zjtlr0uhz1s
	 VL7h4OxDqegoXDX42L1CYTqxmUtLbXIc6x0jdd9y5uG5BmUt2KW0P2zBU8g6M+LNh
	 fwwdFDaKqRByYijYcnj5a7wG0eiM2qk1qnYqe4z1+5dLqP1Tkc4ROtW6HFXEuU776
	 Q10PrJ9zk10sfBzaugIYfoaWgnDasOHe47DeQtZIjuC1cmsV9SLVqPOSqwKKSwhlq
	 8nF8N0c0C2EBUpSBAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MrQEx-1s8hgc1SQ3-00iGWj; Wed, 02
 Oct 2024 23:21:13 +0200
Message-ID: <d4445e83-c5a0-4add-b266-2d97bd590efc@gmx.com>
Date: Thu, 3 Oct 2024 06:51:10 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix comments in definition of struct
 btrfs_file_extent_item
To: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org,
 HAN Yuwei <hrx@bupt.moe>
References: <20241002164500.2775775-1-maharmstone@fb.com>
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
In-Reply-To: <20241002164500.2775775-1-maharmstone@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dEl4j1wn1eHStrKAckQL4zFztwbW6pgkTvas7kBh1CUKO1z0RGJ
 f4kmAAU7hRHLRHzQoeatL4xI12nHpytUhzejFOAz9xcuo2/x+BDcoyXhQlrd6PD5TuF4oMy
 rNRf7fiDMX/JLvAWYEOqIQjgX/8ctTj8bhzqIMuUf4EavfWTAAFOwbKOjKa+ZqNzAVWfBhN
 rkxrCoQZKzivsWxRhUfYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6tL+9DrjeYE=;BICS0H/k1uw+anaAxjQGlzAWwYa
 O1qdcdeE+NxOvIlhXyu/aAoDJpbP+TpU1SPi9T0TvplSlbmrk8mT1/cmfO3KcPx1AlUAOcMPH
 wiwBPCCNmXC/n1C3i6Jl8PSBXO6/ZmUoFoicUQc96XpxmKWw8ULTCjTIEkYL8sG0OkiiVPYMC
 hCSwLDnBCrH9D3fgZ+4o1XgcTor1xwtzyGMBT5I+tWYfv8Ez79PB69WUXpAvPt40/Mi1MN+gz
 +PhRx/uMkoqVpaQYkuUO+tazhZQ3v7AIxkscmMIcywn2Y3JMCg0hgmSQ9549oCBLwx/ldy+8g
 hHrx0Ha9NxqOgQNt0YQvB4ZWkCmzruX5OdvQBTfAEdhZuKGpfGFcBvVCIMzwXj3jD6y5eoip2
 AanQk5yGPm+bKSljIGITiEJC5pfnD+tVaQVpWWPtXsX8Pwiq7ntW6STMcbxCAhVsgibRARrUk
 tZ54Solxx4q2ofxftNLkim/8/w/jZ01uHpqfASnjhd6AhrfKGysHlrdgA1dyCHNv0C/SqoSbo
 1bwFTjg0cUDDOSiFUI7VoglUG5lZzt1EyHJpsuN+5NagB3piYKeEEIeS+ZrHngPJQDHErUR6z
 owBDmL2aXeHt0V5HrpQyufMXX2DRiWukBjArAST92zbJkeRnThnjMtEKhrfSyI1dCo2pAdw42
 oPvNTVL77z6/bUi6/6DZYe6sHANgei6jeQwzEWEENbJXxYQ6vzLN/rSizPSjsVAGxLGt8raXu
 I4pPGbLyX5gAIUKWwc2qSO1vOnj/vLMeejKBCpOyvh85a3o4Px6rYPIhKIcCrRhILXTBnwQqq
 V1OyaWrEIacIxOttYf2YsE9g==



=E5=9C=A8 2024/10/3 02:14, Mark Harmstone =E5=86=99=E9=81=93:
> The comments in the definition of struct btrfs_file_extent_item were
> written while the FS was still in flux, and are no longer accurate.
>
> The range [disk_bytenr, disk_num_bytes) is the same as the extent in the
> extent tree. There's no difference here between csummed and non-csummed
> extents, as the comments were implying. And the fields offset and
> num_bytes are in bytes, not file blocks.
>
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---
>   include/uapi/linux/btrfs_tree.h | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_=
tree.h
> index fc29d273845d..5df54a11c74c 100644
> --- a/include/uapi/linux/btrfs_tree.h
> +++ b/include/uapi/linux/btrfs_tree.h
> @@ -1094,24 +1094,23 @@ struct btrfs_file_extent_item {
>   	__u8 type;
>
>   	/*
> -	 * disk space consumed by the extent, checksum blocks are included
> -	 * in these numbers
> +	 * The address and size of the referenced extent.  These should exactl=
y
> +	 * match an entry in the extent tree.

Recently I'm also helping Han Yuwei to understand all the ondisk format.
Maybe he can provide a better advice from a new respective.

And he is definitely not happy with the docs and comments on those
structures.

>   	 *
>   	 * At this offset in the structure, the inline extent data start.
>   	 */
>   	__le64 disk_bytenr;
>   	__le64 disk_num_bytes;
>   	/*
> -	 * the logical offset in file blocks (no csums)
> -	 * this extent record is for.  This allows a file extent to point
> -	 * into the middle of an existing extent on disk, sharing it
> -	 * between two snapshots (useful if some bytes in the middle of the
> -	 * extent have changed
> +	 * The logical offset in bytes this extent record is for.
> +	 * This allows a file extent to point into the middle of an existing
> +	 * extent on disk, sharing it between two snapshots (useful if some
> +	 * bytes in the middle of the extent have changed)

Maybe you want to add the offset is for the uncompressed data.

Another thing is, maybe we want to have a more consistent wording.

The word "extent record" may be a little confusing, I guess you mean
"file extent".
Since the structure is called "btrfs_file_extent_item", we may want to
unify to "file extent" when referring to the file extent, and "data
extent" to refer to the data extent.

Thanks,
Qu
>   	 */
>   	__le64 offset;
>   	/*
> -	 * the logical number of file blocks (no csums included).  This
> -	 * always reflects the size uncompressed and without encoding.
> +	 * The logical number of bytes.  This always reflects the size
> +	 * uncompressed and without encoding.
>   	 */
>   	__le64 num_bytes;
>


