Return-Path: <linux-btrfs+bounces-12503-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A35C5A6CCFE
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Mar 2025 23:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BFEB188E550
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Mar 2025 22:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6971EB192;
	Sat, 22 Mar 2025 22:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="RjIX4CEx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFEB1DE4C2
	for <linux-btrfs@vger.kernel.org>; Sat, 22 Mar 2025 22:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742682003; cv=none; b=R9DkR1t8gDiDzJP/ZHm9kHi5u3qaUhoFIk7xrMWcJWxdTIg1Mmd9JTChQFSc+hoBLFkz39BxTFxBlGlf8yAAkryPCE2+8h/QdxmxeRCbBb5VsOJduj9srSaD5e0QlxEvmK1px1tkQnx4b+vVa6FTvHbV3yVl4No7nKzc2OpTeFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742682003; c=relaxed/simple;
	bh=zZzg6iFOR/Lf3MZEw6pwDCvAaMgq9KASW4XtfWb85KA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gqg4CKGLZ87QCNqRpecWFEoVCvKGj5t58YuJvH7ogj6tntmMDYjsT+BnH/s3XxoXFyC3mlhCwyHYvdqrb7D5qm2NUlb15pUS5iCsCDzsbpDrkgo0yWlUN/D6hAhm3uIwqnCik0HT8vRGwEH8xf6nu0VvBhvI8iivYoJGoXzsR/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=RjIX4CEx; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1742681999; x=1743286799; i=quwenruo.btrfs@gmx.com;
	bh=2i/lbtXh/JQHxHQSPYARTaWDSXSYEnr3gAS4SJIKcUE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RjIX4CExRWZtnJTjoNtmrTndkN/AQfePlE6QpCs+7/kCKZk6TAs6lU4R7yDkhXDL
	 wrpWmOtp/pkxuoUXzBaF/Vx8FsQ3yhbJ/2W1i18de2lTX2AccxVDm6B1jaTc72wjJ
	 aYG5Iaun5qEhwT1WEfdX9GLOpt6o/9SojRCpXiIe5gtgqe7/NjQ66r8FsPwTZDWmB
	 FVgo5TfoHe5lCD1dzdaoJDeOKRVMb/H3w9u9Z685YmDd/d7rEmkxVyoNMYo1JQJnS
	 10RNTusXzB7y+WiSt7cGsHaNeWNL+PQ9RdkFNfBP/sG8cz2XDHAsUZbxu6EKQGXnl
	 Jz2yDPYz6ay35FuD6A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N33ET-1tAiZv3Spx-00xUMq; Sat, 22
 Mar 2025 23:19:59 +0100
Message-ID: <0146825e-a1b1-4789-b4f5-a0894347babe@gmx.com>
Date: Sun, 23 Mar 2025 08:49:54 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: kill EXTENT_FOLIO_PRIVATE
To: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>,
 wqu@suse.com
References: <cover.1741631234.git.rgoldwyn@suse.com>
 <9ebfbb2024c3c4bfb334a37cde0ecb0c4e26ee5c.1741631234.git.rgoldwyn@suse.com>
 <20250312140807.GO32661@twin.jikos.cz>
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
In-Reply-To: <20250312140807.GO32661@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i4W3TB18/XB59oFQob2YaB+uduPQ5pZfXNEgcCVCcka5HcedLM5
 FMZDKizXbTu0WpncDsBEbYGX8tmfGehWGgMjqPykoJmlgaItkyeak7gwHfdne256VwprQx8
 40wg20abl0C2bcrK/lCeYxxaSrvNyBYTBASCSadV1/gf/CUTbpRJ7Jq2hFuBWlvb7LYl2Ro
 S6RxDCNQ9DIz8SLxHywvA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Q5gd47P+ONU=;MgJK6KYU7C9KeTkHTip+xHC5V0s
 0GMElcp/7XwMrQh6xmhWf0ysJb5VTBdBwjQbzhmAQedwI/AWDw8g0zOL7AkXPy2mTNjpbmI2s
 3HgTQOLJpK9LfdBNjrCtQwRGPtExTrSQ6pUUyS5qH3nBKFTaveqFmTQz5TZLt1q7N+fIAy33w
 ESOfguLim2dGQLHAnsrfhBSIfKd6dTK6DcWhwpLrAkk/Niz7Ilagb0l1jJgoUiJhsNnoovDLk
 ZDpg9I0l8lGaRwSH3wWn8brcpBZdp8YxRrv0ZSwn8f4j04/41Klbperwjy/A5wEQ08G9JBNwb
 g7oAFmRqrsmrQ+UofzpWasWwyHqAvi0v7X1nAycXZCO5gLhV8+xnJOVE6JhRfgx2mLbls3/yl
 fbOZB2glLDrP/6v0mFWXX1eLRJzDdPoRz7YK2zT+bS6nJjaLFredBm1pn+sSr4tjS/g4G7aez
 JFpE2qEG+HqaZKQlqrWIQE9YJKtY1j0Rp0YCbHPdKb+A181gu5OIuN0XUqj0xVBNFHv3qCqon
 Iv0qxjkA97WnwMkiqzj2ak5Wai0YEfDqcnFFHgz53KesgPmVrPnlKkJSzNR2Crb7Ipd775xa1
 UoeUUpk1PaJyBiwf6iWqf6M/H91jzIvImfdV89UQuGAl7X6Zx9fUs0W+memC1q8EaUzRbih+i
 eJhvZcpRD5CcxxdMAkKA+wy/UulXEQryaOSwhKVG6M662bihLQeVgRaBJxGzKj2l6Dmh3ncrs
 HrQu7cn6yCgI5bSR7fXyhv9zpWYjimVikOt2ufbR0lx1dkDSwclfc9FmGk9GyHUHmstiY7uOV
 +y3VPcTF+6EF1UZxapMHKKK3mxlOd5fcLC8euAWe5Z2GYCch/yN0LI3Wx7I+J4jhih99vrs2N
 /B+XYfKI+eCWXcIjgglZAnOJ59KLssKzCt3uZuvMf0kXAdMnNFvzETRAL7/6E3pPVtolO81T4
 MHNhj8+0QjTiZUJdAPaEHTowqgHzgG0yeLLpuF8PL7bl6JusI0qL08w6Dayaxqnk9it8/gbkT
 FGdUUW4NcjujGWbWu3rvJGnQgBEQ0/qvx7eSBwCV6ZtF3OpRVsG2IEdx1zx7X9LTUdXqKl+tM
 8c6X1s+HsSp1/wMHC6L9/1lQtSZHEHvaYD8e7DwqNVADx/e5pgLUZCYT4RlRSYZZaPBJ+vlLH
 ccbWm0fRm2pfJx//FoUxs0eUNd7cAQu2Z7xQMbVvZBMytSsD1o+8ajQDqladnFRQsUXPjveBy
 6B+OdA505c20rpQIKajkIluZwpCUUJZvaqjmwIrsy09kQKzCCbvAHBFXqaDZ/xhnwGxCz7icc
 dPP8AJq8G2t2CNMoKWEviYDpB05HFGi5WGKoBMgvjSQDxt0ls9iGW7TjH/EUnYVW7sNOY43ma
 iqwmSBJMg8M2GueSqHcSVoqhcpw+VhQz0gT40VTYFSUzBFfDRAQae8OCAYuOly24L+ejhtLsF
 adhEflb7rq7EaN86VUGwr8wJdbtg=



=E5=9C=A8 2025/3/13 00:38, David Sterba =E5=86=99=E9=81=93:
> On Mon, Mar 10, 2025 at 03:29:07PM -0400, Goldwyn Rodrigues wrote:
>> @@ -1731,30 +1711,7 @@ static int extent_writepage(struct folio *folio,=
 struct btrfs_bio_ctrl *bio_ctrl
>>   	 */
>>   	bio_ctrl->submit_bitmap =3D (unsigned long)-1;
>>
>> -	/*
>> -	 * If the page is dirty but without private set, it's marked dirty
>> -	 * without informing the fs.
>> -	 * Nowadays that is a bug, since the introduction of
>> -	 * pin_user_pages*().
>> -	 *
>> -	 * So here we check if the page has private set to rule out such
>> -	 * case.
>> -	 * But we also have a long history of relying on the COW fixup,
>> -	 * so here we only enable this check for experimental builds until
>> -	 * we're sure it's safe.
>> -	 */
>> -	if (IS_ENABLED(CONFIG_BTRFS_EXPERIMENTAL) &&
>> -	    unlikely(!folio_test_private(folio))) {
>> -		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
>> -		btrfs_err_rl(fs_info,
>> -	"root %lld ino %llu folio %llu is marked dirty without notifying the =
fs",
>> -			     inode->root->root_key.objectid,
>> -			     btrfs_ino(inode), folio_pos(folio));
>> -		ret =3D -EUCLEAN;
>> -		goto done;
>> -	}
>> -
>> -	ret =3D set_folio_extent_mapped(folio);
>> +	ret =3D btrfs_set_folio_subpage(folio);
>
> The removed part is from a recent patch "btrfs: reject out-of-band dirty
> folios during writeback" to make sure we don't really need the fixup
> worker. So with the rework to remove EXTENT_FOLIO_PRIVATE it's changing
> the logic a again. I'm not sure we should do both in one release, merely
> from the point of caution and making 2 changes at once.
>
> I can keep the 2 patches in misc-next and move them to for-next once the
> 6.15 pull request is out so you don't have to track them yourself.
>
> Also question to Qu, if you think the risk is minimal we can take both
> changes now.
>

BTW, it looks like this series seems to cause subpage cases to crash,
reported from IBM guys:

https://lore.kernel.org/linux-btrfs/87h63ms7gk.fsf@gmail.com/

Meanwhile our current for-next no longer crashes as these two are removed.

So I'm afraid there are still some conflicts between this and subpage case=
s.

Thanks,
Qu


