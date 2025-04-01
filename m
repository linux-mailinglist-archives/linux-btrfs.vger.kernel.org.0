Return-Path: <linux-btrfs+bounces-12712-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CA2A774F0
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 09:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9043A168697
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 07:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A72A1E5B8B;
	Tue,  1 Apr 2025 07:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Nz+/qFFF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A3B2111
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 07:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743491602; cv=none; b=KrT4SK56NIzbYCvWxRM34SczwncDbXJN0C1WtF+S4BCGnI+Id9uAEgk5BO/pR5SfIoTEzIPuW0AYTnP03Wjd4SrG4czFOUjK93c5jdlf6BxDER1ks3H8WncZKFWGi9SXZbFNkXHGa+OWmkzyVw+wwzLbz7rPxeMvC6jJmn49qZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743491602; c=relaxed/simple;
	bh=BdcUHXh5Z5Z3OVs36VuCJYwT9NFMY+cjW3LH8qTWZfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HHb0UCG7mVxELsRPqQnKdxAYZc6/ZR2Et1Typu/uPw1/7+knGrVRoXwEirJjHG2H0UYmRj2r8PNxtY7vLIOrYgEmgtB4a/3e6tRfb/vtgMeGQAwQjqBY1wbH56pVU4AMbfA1qDsVfkx5s/QRjVxEENWX63W/nVFXtETUPrFLdJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Nz+/qFFF; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1743491594; x=1744096394; i=quwenruo.btrfs@gmx.com;
	bh=BdcUHXh5Z5Z3OVs36VuCJYwT9NFMY+cjW3LH8qTWZfY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Nz+/qFFFWrOG//MYfXOl4wNrCHzpsgltoIrIUq/cuOLVcYtX9OO3J1E6PoPKVibg
	 nBqW+TRiAIGsAWpZT34T+I6kT5YjkYVPwGQTrFuExRuVCFKLRnKOkK31cbwB1yUaN
	 jhQG5tyAyxT4kOKJwajT3JqqUfHzcT/U2BJKL2ZUcr1m7Ar7Ef14jnxG/CHX8ah2j
	 E2sSoOVjCVTklsHbz6YUstorYlBbUegx80fThckSFyXzss/9ZPoXZcXqFENF3kbdp
	 K8pysAuxrt2AcgPix3i0FAoSzP/2mnPdutDgsNu05z/FBil3kvsAFMW8DerzactqD
	 46jejzn6/2gS1wh+Kg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtOKc-1t70Zo0g8s-0178nE; Tue, 01
 Apr 2025 09:13:14 +0200
Message-ID: <f4cd88a6-87e7-4a99-9f5f-4482e4607219@gmx.com>
Date: Tue, 1 Apr 2025 17:43:10 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: fix the file offset calculation inside
 btrfs_decompress_buf2page()
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
References: <cover.1743487685.git.wqu@suse.com>
 <8fb7820d18bef8f661f807b3d96be2591aee6494.1743487686.git.wqu@suse.com>
 <beff4178-200b-40cf-a7cf-afceaa1b413a@dorminy.me>
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
In-Reply-To: <beff4178-200b-40cf-a7cf-afceaa1b413a@dorminy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IpZazyN9CS0hDFbNdBANqA4Bsw5E4y8ulVT8YQ9mh7qVfQfj2nk
 KFWrl/P37cKxh5k9yWQp83YyQkQM3phYTvoMt5GT8ELSbEz87A148z+xJR2BaKiaacbTmWm
 +/V+e+nXVZo0XaEiuIA5PZyflYkemI7Jc0Od2KMau2s4NgpJqxQx2V1H9K0HX/8KRFQVHFE
 m0Ys3KblFqmJCJdpJl5ww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0ekYywu+WUE=;jr3DVGI6kii/0nwQRCXys3/1Gfe
 qy7RMQ6fqQXEkF3AcjVW+siYxkFYu8B0H3eXIdMrb3kXYOijlcJzBQieIMqbPZqAtALpQk7TO
 ZkXNubIQmYReuweokZnJbuUztOskbPU0pxKudktMaU2zupe6raqhYPb50hIQmN6yZHuTitafV
 SF1aGgqexza+l42tGGIh3vEehJnEOmomjoVe5CBv6z5MxrMJM2KehiDBiRc4Ws/jFWY6f5jQ7
 otwrtrvW/FFteiq7KpMTCwqoX53EB+oHVz837MTdG8kx7vklZMCHKAzlQMvnIEfwfci7pr5gg
 IET7VEOHJ6PzglwFxUuDsbSf79kZtqPG9P7X6+25nZL5XinENnJyIC/2mxJqfs58V8IK6PxZb
 N8itrg2QAUTiyjHAXCxes9TarfYAC395LwI9nbJhpaVbAey2Z/V5D68+4S0pyTQdhCEs/nfDi
 pat8ernvMi9s0eOAsh/4WLZqTFWvPbNdTsbIY6N7JwC9EkgpRDj5A3yiSzFiTYTZS8TnmncXA
 e31K7VcBRU2vprIafCj3n/1EVZzEvqalDU5Jxsfu4SEsZX/d1hCc9U2EDH50WNp5T7g4ZKrJd
 mGP5NOPgblJIv7TTgBAzPXsn0bipI8eCV4pV7a85H2dMiyLnvXZoixpo1X84HP2St3QBeYDkx
 CrYr0E9ZDX83dnRfeM+LpVU6SDopbiYKX9uCWPHncwP7/q2llntYLN5SnH27jkM7Q0eqhEi1G
 d3xuJJ3Qy+uUj+wcpN13CzMNUDErIU4ZhYjR4a7q7Qb/qFGZ7hU2hwZmGdn7xhurirQbW3oIf
 RTCuRJ+W5nN6Fy0AVX2/g4Mp26eJ52azHaza6nRAZvmeJlnu3PQaOe7clgtz5KBGSc//xbcvg
 9ByqC/d26xSbvjqoZXNDtLLXnHZwhfwzWh4u3/PvPfXQa61/uVFFqAvyxsg0wD2AhpJPlI03F
 BzHxOdaR7HWCL27/zj9lSOcbVfMMsWZv9CUHKKEqJR1c05faHZrNj/51j2Q1/05piq50pNGbz
 p5PnCVOEw3RBEcwpRQVS4zcJALuoAbKf6cmfZmSxeeTn60IxOE9f8/cTxGpmGh3tNFgRBRDUV
 /bCQXxI8kXQ+lpv3aitidpu9QgjdI3FDpI6N/GeaZQII+h+1NXtO/euLWuoYWx375xtL7fc75
 vd8VyQ+aSCI3W1WR6xbfGwT8meoXDNRjqdN2wJhry9r9WoJhjzB+v+Fu3j5vksW4pR3/JVYjl
 WXfR5kYJoZ/pMKjlgA7qS30bXkhIIKhGGv8c+yGLGe53/lc2G6u90uHU3iqK9RoyEieLQwCfk
 6BuVX1p1nkDvlPX0WCKU9AlorQcuGgDGtBtM7M9zI4wO+69CKBIgffyhzFu5vOhEkheIw9+P/
 RAW7bXltNhZk8T/R5o9zAJ6ffgBFybF9AxcMlku9buQXTUSJ9yFf+G/Ck5g3MKouxjECHGZIp
 mpMWyFw==



=E5=9C=A8 2025/4/1 17:03, Sweet Tea Dorminy =E5=86=99=E9=81=93:
>
>
> On 4/1/25 2:12 AM, Qu Wenruo wrote:
>> +static u64 file_offset_from_bvec(const struct bio_vec *bvec)
>> +{
>> +=C2=A0=C2=A0=C2=A0 const struct page *page =3D bvec->bv_page;
>> +=C2=A0=C2=A0=C2=A0 const struct folio *folio =3D page_folio(page);
>> +
>> +=C2=A0=C2=A0=C2=A0 return page_pgoff(folio, page) + bvec->bv_offset;
>> +}
>
> I think this needs to be page_pgoff() << PAGE_SHIFT + bvec->bv_offset:
> page_pgoff() returns in units of PAGE_SIZE, while bv_offset is in bytes?
>

Oh no, this must be some local change not committed, thanks for catching i=
t.

Thanks,
Qu

