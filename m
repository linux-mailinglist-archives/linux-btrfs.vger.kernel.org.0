Return-Path: <linux-btrfs+bounces-10333-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D9B9EFD86
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 21:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B22188E306
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 20:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58DF1AB6C9;
	Thu, 12 Dec 2024 20:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="gnoHIExn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523631422D4;
	Thu, 12 Dec 2024 20:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734035877; cv=none; b=SdrbItp+0zA74Pdiij/3RBi2zy0EJ+v6kxH17rSZoo1kKPaZAC9+Y/ktZoW4Lj30E3aPVkFyVe8OGJbDatFwW6D73pLExjKRz0cStdlXO2f/uGf3BF5DLES9rjYwT46StXz7z9LkHZ34WeAPmXZpPEkWWW2VLWKKmOSEK3tw8hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734035877; c=relaxed/simple;
	bh=MARY6dTFg2yP1/HJ5ATv5KHC3lbY2n8VnsTBcWvNK3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RaFCecjITyGwLna+tECZ/hZfG5RTpCHOv/FQL0RhMX1QUwCF9GSPGzVidkFZD7p27Ni1EswR7qJPjfa/fb4ZiYxnpxE9rFV0f7kkOMiQBWRMt0/jEXj1uf+eFPRjO6Hm20xHTVVMqFOsl7nMHGs8JGL0cqODHZxkOJLp9PVV8iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=gnoHIExn; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734035869; x=1734640669; i=quwenruo.btrfs@gmx.com;
	bh=sU4tDiWNTNcxD3yowewJ1TroqVKauDSKX8n01TRGqRc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gnoHIExnwe4dlx2F+ge1djxvKpJTNYna+gOIXnKUdp+M8j3wLON/GgL28mU4TWlD
	 T5o0+VyWVn5hyXRM0l2lcKh5JQlutZhpdVCMbix6Z/obGE1ybdgKRZV02rO1dASfd
	 0kV3uMVyzdPhNx4soLFzDQZEGFDs8/zAn3ut87eVWr4BRZhdHDiCj42pslHYkt/gu
	 EQdu+Fd1JYiE+P/cwMRoN/WGQXO3t1evqn0++zM+8CvDCAvLa1siFHIdYQc2zsEQM
	 1QN/Wv4eW54gPLoFuYjqrgMIQ3c6q9Wccb9pS+PQDJVpDYsHeasCPRiEqgkLmQVIZ
	 bnohNSoDc1RgbZ+bGg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Ma20q-1t9j0j1dK8-00PA4T; Thu, 12
 Dec 2024 21:37:49 +0100
Message-ID: <85bd7f9b-d9de-46ce-bda9-e7f2db31b8d6@gmx.com>
Date: Fri, 13 Dec 2024 07:07:44 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Fix avail_in bytes for s390 zlib HW compression
 path
To: Mikhail Zaslonko <zaslonko@linux.ibm.com>, Qu Wenruo <wqu@suse.com>,
 David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org
Cc: Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 linux-s390@vger.kernel.org
References: <20241212135000.1926110-1-zaslonko@linux.ibm.com>
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
In-Reply-To: <20241212135000.1926110-1-zaslonko@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PzkNlcE/RRInJK66ffBW1pOxoQwoeoa6Ox1A+fWIBeDszxux413
 YMMuAKhmoZHIFjqfOWxMlR6NGyhwLdj4Rh05rHDAyF5NjmCEhYvNXAvVBkvVD1mk0QSbbvP
 iQvYdoSn71kmsvYgezyLJsZFUgfRLkHuhiVjlL8q+Je2oj35435rrYqvmmqwgkXzJ9LHl6R
 KCadNySCDWknw8cTeVApw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KDOCV57KgmA=;j1eana9Dcm4tAvuDF/1wcp1Isbl
 5DXlhld8ju2sAIUcdWsdLbmBLxHgyJFExPXQH6fYxaEyl+IxSFX4PCaJcUB1Q5PBKDKuWrwQe
 UMANo86kNn+KfiOEx+4EgZECKIIqS9p0/0TeIRvCObWT/8hJpaF82naCI8K5+R6wDuXlW9C68
 l+AqTr5E7lu2yeAwpvcNjhJf4fiZTJvysoRuHfvvBxCUCK9NGsnfuiUH7auOxO+ndeQwrNlrf
 cidFoR9iz555JATQj8J63uykQNhjZ8AeIOqVC4sW2n6Jl5+0zpWY2Vltw4EOrOdNaOwh9RTH0
 Ju1q9VkuLocStsnCouBfH3EMJVDHhNh3fYXhjRbF14RUpDGm39oPqAEbkiKd1RXC/xOR6SzPk
 JUWW/yIvSUtk5swLXfVJSZau1Al4gfYlatZ/Mh+PUrY6WZUFa5t4k700b1RyVeEpmL6uTY6Pa
 hSWYPQzJLsAHFSUZWg/JITtPQY9vyDJxKnUOd7/mxjsGHxGLMZYdOz8MG8vXwEAYkB5xjvZ/2
 l+nxCz9Zw9UcpGbd6VctCQ+nY+DaSSDLqh/zhfuMUuq7cwBy5KIyJO0C5DWRmzFCjhqV+jKRn
 2kdR6H2eHGWndop94MxAabcvXaKWSETmfqH0uCnWPbqT2ZOFRA10T81SAZJIEf5qfp2JAAMdL
 dM0Fyc5pZENUnw2kpoUiufbUckBg5juYjolk08caBPGsA3RMuT36JRFoiUtKUqulSJW7eBPCY
 0JecT+S+Fwe7HoigS7N/YRhC6LumsTS0FqNY0+D4MToIC28c7z/KKGq3PRWYESm2uCgX3KuJR
 RUj8ZeaniUpckzXLdas7rxfb8e8c7Z4wbUfQ9NBVIG2fFbEttw2BqEhqL0ZaKsFagqL3rYK7w
 8Tc7DqW4AaiSzIRnREkfEN4q5J7pPI6Lz/60lkke8Xe5ObZxb+IG8E8gV1ojbePS5gzmIh9IG
 bqXsOtpoUyKSRcXW5UciXB8yXPqyvsH52wT3NZwsVtCxpjezCaT865O/zL9bJTLkZ58cbbV6s
 34dj2O8Qfdk/PpT2JWHf1+9E5QKXTodrx1KnwyR8ENqmVhlYO39jbPbxJd4tL2uHuhByrOD9u
 H7g4w24uI1kjVJt5WWdqu32haRhnNj



=E5=9C=A8 2024/12/13 00:20, Mikhail Zaslonko =E5=86=99=E9=81=93:
> Since the input data length passed to zlib_compress_folios() can be
> arbitrary, always setting strm.avail_in to a multiple of PAGE_SIZE may
> cause read-in bytes to exceed the input range. Currently this triggers
> an assert in btrfs_compress_folios() on the debug kernel. But it may
> potentially lead to data corruption.

Mind to provide the real world ASSERT() call trace?

AFAIK the range passed into btrfs_compress_folios() should always have
its start/length aligned to sector size.

Since s390 only supports 4K page size, that means the range is always
aligned to page size, and the existing code is also doing full page copy
anyway, thus I see no problem with the existing read.

Thanks,
Qu

> Fix strm.avail_in calculation for S390 hardware acceleration path.
>
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> Fixes: fd1e75d0105d ("btrfs: make compression path to be subpage compati=
ble")
> ---
>   fs/btrfs/zlib.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
> index ddf0d5a448a7..c9e92c6941ec 100644
> --- a/fs/btrfs/zlib.c
> +++ b/fs/btrfs/zlib.c
> @@ -174,10 +174,10 @@ int zlib_compress_folios(struct list_head *ws, str=
uct address_space *mapping,
>   					copy_page(workspace->buf + i * PAGE_SIZE,
>   						  data_in);
>   					start +=3D PAGE_SIZE;
> -					workspace->strm.avail_in =3D
> -						(in_buf_folios << PAGE_SHIFT);
>   				}
>   				workspace->strm.next_in =3D workspace->buf;
> +				workspace->strm.avail_in =3D min(bytes_left,
> +							       in_buf_folios << PAGE_SHIFT);
>   			} else {
>   				unsigned int pg_off;
>   				unsigned int cur_len;


