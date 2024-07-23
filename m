Return-Path: <linux-btrfs+bounces-6663-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CDE93A8EA
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jul 2024 23:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E4B11C208D3
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jul 2024 21:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99474146D42;
	Tue, 23 Jul 2024 21:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Nwl0qKus"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F50144309
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Jul 2024 21:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721771551; cv=none; b=iFTBZ+ifQlZHKW0YAycWfDlxl3efESCse/BKG3aJn3nD8fxP5LITRWe9ESNZAVEMgcViVq3fWnGO21XBGOaOBrh79FqRJG2LajSqgUPvWGRH82sRyMixoKRMlhx6ns8Plk6hGrArZVXy3ZCpqTHO5eHYIrXE7VE1sf1wP1wV3Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721771551; c=relaxed/simple;
	bh=SxT/5+OXttFvhz8odaaUl9bE+ejrr+kgPWs/Bx6yVmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hjRpEtMi9AeX8oZt4InqnmCzrivQ9mZFZWXNtDCgzJz9LNUGU1NQp7vD3OqsHEzlY875pl8rgI2AegXAYCWUGjl1nP44LM3WKdyhWvlDII424Nftd+UmTUptFOAkuAJCdE+w2PgnmYeuR6w0ogXvhxnsHqiCR1dsgnWFva7aXiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Nwl0qKus; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1721771543; x=1722376343; i=quwenruo.btrfs@gmx.com;
	bh=KwC0Wx7gZshbRkc6ppP1MP+flDR0VzYukWy5cg3D5Hk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Nwl0qKusla/ze47NRG7LeUbtTQkgEWQ5pzHIYcQp2+uvsWOApsI7Ufx/qPbxqLQc
	 /1CKYPPt++8EwKf+SIvszgKyI00GCrLTodxX1PFnCsjMvN7biijLAPAtydoViCs95
	 739bLkZ0NArZmeSs042qzo8/1Jd2z/PIfwXxNyv5RoNkjDDkx9Shws2BemQ7TLLSq
	 FO25aZdSd8bvlXNC4vRMmlPfIDtHcJIpcNoDq33zdGQzG9LhTCJa1pkswmf+ukEey
	 i6aqJocpBdtLMQLMCM2h2Lu9yPNpJjuUIwZbsa+u8ecZFhG6VvYN/qeWkOJ9RPhgR
	 LZe405waJuhvjqPfLg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MsHru-1sHk1k2TUY-0128n8; Tue, 23
 Jul 2024 23:52:23 +0200
Message-ID: <685fcf3b-012d-427f-968d-ccd5517a398a@gmx.com>
Date: Wed, 24 Jul 2024 07:22:19 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: reduce size and overhead of extent_map_block_end()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <9003408d1f29de77deef59c6ed6e5bf1d98b91ab.1721746528.git.fdmanana@suse.com>
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
In-Reply-To: <9003408d1f29de77deef59c6ed6e5bf1d98b91ab.1721746528.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KHtHbxh0VpTipakPCW5ctBOLJbVZ2mPMeF/p5LrYI6gJfwDzXna
 iupFrGM3RPrBjezSsjKDv8c8yQgrT17LlvEDZM4Ojct/bfshScgnLhKy8QsELXMFTDZKs5q
 skZviVAE/QoiNi++VeZKy74TSeI2uEMfisjKY1vxHDXtzzZ3Vesg1RpIECqPz46ui37OWtA
 G8fHQzzKXwwnvMh43+9WQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:n7KuFornJ7s=;tqQDBWbYt4rWHYVbe2l+igPDner
 BnYWSzm0bGXEJRQ11ymIKhNJC1l4V/iqnrXlrQ+9Gjck/X+2SL3ySW2tlINvQ7AhK71eUkwt4
 S+9MWAaw5F3+uGsMCkfsJ5zBxmeVF94xg6+GCDJ1jaA3nFn74cycScnWpClrgbUmM/nnv8DQr
 1E+zlnm1l5UvhD1w3yju/tjJJA/Bxs6FwPu12WtzDE3Pro0KeFt85feI0QTl2MtvRX+JqXv4g
 ahCua4z7Me1XYooCf7k6e91cWXAr7vYj9j5pKKhe84SZ/lYOduaviQHQ+SQpAQOTTXydOmdJ8
 ChRummTsyDwAOR1s7KciDfPBUdlJZKXOf8Nmm0wg/f+R3PSnlTQjaWQxWwfFBy4kR01D2IRXx
 4F66oReZOFd5gB8zfbBYtd4d7xfqXnIMNaOwIHzN5TOFxnhDevi9cVO1fX0CG2OrjMY3Qnzqj
 +OjUJM80iKzel1vq5y9taBi5+2bA+nLYp+p631jNNIOPz0kCtOK6bzXWxkmPrw4tHNjJnc7NB
 AFenExGWQKrcc/epikCCi9brvxRQ5j4vYjXhqXnXAgW4zBJQEbwoRnBtN+FDLDyUO2cxh/cJf
 DG6H52DafJ5YijXYRHaGQuGoyCOKi/Prrj7YdGBc0LersRr8HGEs7PrZvL2U1JOluI37NeP+o
 tloEUU22hCKrVdyKHgIMvS7ALgVxG1jre4hf7cUoHTWs+R7z7khjmJf4n/qzDBguJ1dPQQUf6
 gZdFHP2wJYezqRMc6XlbI0tVajAkHJ0E9Z6k9w4iQq6afUXD2m1KgolBeZsQNxUQq2VRy7cW8
 8qhAdYTb7SKHrZszVP75rXww==



=E5=9C=A8 2024/7/24 00:46, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> At extent_map_block_end() we are calling the inline functions
> extent_map_block_start() and extent_map_block_len() multiple times, whic=
h
> results in expanding their code multiple times, increasing the compiled
> code size and repeating the computations those functions do.
>
> Improve this by caching their results in local variables.
>
> The size of the module before this change:
>
>     $ size fs/btrfs/btrfs.ko
>        text	   data	    bss	    dec	    hex	filename
>     1755770	 163800	  16920	1936490	 1d8c6a	fs/btrfs/btrfs.ko
>
> And after this change:
>
>     $ size fs/btrfs/btrfs.ko
>        text	   data	    bss	    dec	    hex	filename
>     1755656	 163800	  16920	1936376	 1d8bf8	fs/btrfs/btrfs.ko
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/extent_map.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index f85f0172b58b..806a8954b3d5 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -192,10 +192,13 @@ static inline u64 extent_map_block_len(const struc=
t extent_map *em)
>
>   static inline u64 extent_map_block_end(const struct extent_map *em)
>   {
> -	if (extent_map_block_start(em) + extent_map_block_len(em) <
> -	    extent_map_block_start(em))
> +	const u64 block_start =3D extent_map_block_start(em);
> +	const u64 block_end =3D block_start + extent_map_block_len(em);
> +
> +	if (block_end < block_start)
>   		return (u64)-1;
> -	return extent_map_block_start(em) + extent_map_block_len(em);
> +
> +	return block_end;
>   }
>
>   static bool can_merge_extent_map(const struct extent_map *em)

