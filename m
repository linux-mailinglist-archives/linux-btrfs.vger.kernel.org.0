Return-Path: <linux-btrfs+bounces-11710-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF85A40592
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2025 06:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B303F19E23D1
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2025 05:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C411F1932;
	Sat, 22 Feb 2025 05:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Zx6XJIyn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9011A18C0C
	for <linux-btrfs@vger.kernel.org>; Sat, 22 Feb 2025 05:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740200564; cv=none; b=CalswEL7DRKukTf0C2HIziCRtJU3xRAJ01kT2Ov5zXoDpn5u90VXHLrGrPSAKfg1Czjf6VaONNfjYo0R3S3TKHng8vqH0Jw7417sXFb7QlCCJ4uK0YMPE3SGHBaNf1niYl09/IeMs+ruXfynZgThLzSAaMWxEeJmzS3uf2NExZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740200564; c=relaxed/simple;
	bh=Y08rzk3x7gM5r4MbDXsIMAc56mORPiLEJDlY3dBZoqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JgTfTOQ/oPlWQ2FxvnIfen/GEJr0a9KOIMm17vTAelJU04RHGlstEErQRcP5ASK41eMqg3glfuQx1Ba4gD0jebwx0EuZuDVAOKNp6diuYjMc+NmxLkVZ8F8qG+a1eOVsozIfWmaXn+qITwApUCKzimN+WlrxFcutWi/Vpvq71ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Zx6XJIyn; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1740200556; x=1740805356; i=quwenruo.btrfs@gmx.com;
	bh=pQpAZDJXVkhIL0h8bUGliDUVPUib5Vk/4diDBISuBG4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Zx6XJIynBTTQE91TgpHzkRC76wx8M1GoXkVdsSRLkavgi2JPkMpJsceXoIwoE0OY
	 zTfrvu06Hp85Z6rUEXpG41LJMTiN+UWqn309H7+WattZO6WNxqHVTplzISRrEUCIC
	 wpFF43lktzdiCjD/1JIiLP7jzEgdTWjiix3r4AcPBtuWtkWBThq9QWs7ewGK6VZDd
	 4uAFXYR2ObBAf93T9XSqlOUzuquAATRkDOStKOpLAnxKDrYqHb6VTzjeRVkrsveaV
	 vSIWHJasuyHknuHiSbGt1I93nvCD1TVzETneJXz8pXiFYWKar1XvGa9PUm/wXQ9zh
	 gh73m9XkCYLvSzPgBw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQMuX-1tyXgQ3e7N-00QvDK; Sat, 22
 Feb 2025 06:02:36 +0100
Message-ID: <ca38a144-41c1-45ea-9769-4e0b22625810@gmx.com>
Date: Sat, 22 Feb 2025 15:32:32 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] btrfs: prepare extent_io.c for future larger folio
 support
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, WenRuo Qu
 <wqu@suse.com>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1740043233.git.wqu@suse.com>
 <19dfc0e42dce6416b66df114513d18d93b830d17.1740043233.git.wqu@suse.com>
 <c68a0824-493c-4049-9050-6e270793c44f@wdc.com>
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
In-Reply-To: <c68a0824-493c-4049-9050-6e270793c44f@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7/gjbnt4tp7XrA9JZ9vCY3hWooWRQ31VaDcsxXBaUY4GcjoEWW+
 N+OF0XqNI5ydd0Orjo7/S1EJCWyEHDAufTHPIA2m2oNSCvXT/Q8iUWWHkMhgY78ydl/JkLh
 LXPgWT+DItMoJMaVvJhHLS4Q/01N5c4nEvaYo3u9hwP7+lChErVvkkjDGxkxhmaYfLbTPft
 Wmj7RqYfKYhY7gHF5+oTw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QKozk8O+FiU=;gK4ZUv17/WEo+xSogOg4UH3BOHU
 T7V+IeH5NX08Tss5n7mHWmiI7v7UnqmOjq8QWDZdvUAWJfclhdalh3AwXNtjzNo5i+02aqx+Q
 fJpkEPYO2CkIdw+BcoCVkSLRw6nrGVpEXFQVnEKr57I7HTwocF65xgXmq05kNkTmYgQybQdAK
 wBir0Dk3zTS60WIrY4v3LOcg02bWu15HrHKj6cI0x6m3Ub85H82B1A12Tl3BstsNv410YNkTK
 wuHcf7ABd2rAKanOmP9Tptzo2w10GvieWAYQlSuhWqH/yDiXDBqiQ6bnlsFI2GhgqE/Ydc1uP
 DLiVgkC6Vf6Lb9MYtrdPEqxU3sQt2KTyuhCSbS5KGfU7iNkDZ7nLWrIZ85GumQ+OjlpQEadb5
 RkzUBHwgMKBRuxFJgtjLcv526OsVdeNZhtCmrUyr3qfFhtIP2LNXm9V5TfilzWu2UVHB9gSj0
 FjQPzrZmomrMlJcybkFgDi6vsbIR1C6nQVdXWRnmcJAyV1hbIN0r/1dWkzb1QUhpuX/FoiUVA
 tTFddLUBXoCCIfu3T4COhKlluQFVwcRU1oWgoj6RRMj28+91NEZ9yX9oz/izqwPNKUXowDJdk
 r5MqLmtCQJdFRW4GuR33zMw8db0GZHHZ+ySXjM8VcgG20PEddeWjXztwibVT/VYQUgTPG8Sbi
 TciJdk4NBuvxnr7tbBjZMpaNQRfmrslFPsZPwx+6+VKtZX22/Ocwrdo2P1yVwHbP88O83aoc/
 nRudDsQR24+zuAtt+abLt/NoiYN9CPyYjI4aYufFCekvYnUGdh83ojPh+c7IOjCAdl/xZEe+8
 UgfdpYYnQlVR95Q4i+vo7bMd01hBveEPubxhcFMZACah9KtsRcTZfSJ7fqpFBg878z0kqi7VP
 jIilox0laVpf6nECHIGUZld8hCYe7UgRLtiuozSBgu7bnwTTSDxc4G1o9mgtLjfahaiix4Hzt
 N1SXerN2sztbEqIizted3IALEBUm3oeJxHR7Vlv+iJi/PFVZsa+cOKpxVMEF6rPnm6AFDN0c4
 6MRj0E48cd9LIw03AOSReTvwLlczv8ltrzO7A8Ix24z4wcxnvLe8OWnpAM2OA+z3cd9O7eOBe
 wDK8upPe1P/uj4euitk6NdCIe99kkDmHQOllUMljw2Dns2wWpnmCiwz1OQASmVqqMF2s+B9z/
 /QKnW2lf3D6AH4fz2nhSw+sS17JM7zOdCmYSCIGUGrgZozVK6gfoPDSh+XigHowPYEfTDAmu8
 NnQEG0V2u6df7rUBmWk/HWS50o2A/Ee0XagtrbLKC8vy6HXdsQ+Osh1RrGu+ZwF+YnqnwmaMW
 qNy4RAHBAJtCMoErKm1Q+cjwrK6cE8HeNeUH0I9iPAUNKg/sTmpjHgdgDXQ9aVK5dQKSfUBPY
 82QGcnHm1DmlLqUnRhljknsglhMp4D7t10+epgNOY5GncFmkGjquk+mDxt



=E5=9C=A8 2025/2/21 22:42, Johannes Thumshirn =E5=86=99=E9=81=93:
> On 20.02.25 10:24, Qu Wenruo wrote:
>> @@ -2468,8 +2468,8 @@ void extent_write_locked_range(struct inode *inod=
e, const struct folio *locked_f
>>    	ASSERT(IS_ALIGNED(start, sectorsize) && IS_ALIGNED(end + 1, sectors=
ize));
>>
>>    	while (cur <=3D end) {
>> -		u64 cur_end =3D min(round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1, end)=
;
>> -		u32 cur_len =3D cur_end + 1 - cur;
>> +		u64 cur_end;
>> +		u32 cur_len;
>>    		struct folio *folio;
>>
>>    		folio =3D filemap_get_folio(mapping, cur >> PAGE_SHIFT);
>> @@ -2479,13 +2479,18 @@ void extent_write_locked_range(struct inode *in=
ode, const struct folio *locked_f
>>    		 * code is just in case, but shouldn't actually be run.
>>    		 */
>>    		if (IS_ERR(folio)) {
>> +			cur_end =3D min(round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1, end);
>> +			cur_len =3D cur_end + 1 - cur;
>
> Why is it still using PAGE_SIZE here?

This is because we are at a failure path where there is no folio.

But we still want to skip to the next slot (may or may not exist
though), so we have to increase the bytenr by the minimal unit of
filemap, which is still a page.

Thanks,
Qu

>
>>    			btrfs_mark_ordered_io_finished(BTRFS_I(inode), NULL,
>>    						       cur, cur_len, false);
>>    			mapping_set_error(mapping, PTR_ERR(folio));
>> -			cur =3D cur_end + 1;
>> +			cur =3D cur_end;
>>    			continue;
>>    		}
>>
>> +		cur_end =3D min(folio_pos(folio) + folio_size(folio) - 1, end);
>> +		cur_len =3D cur_end + 1 - cur;
>> +
>>    		ASSERT(folio_test_locked(folio));
>>    		if (pages_dirty && folio !=3D locked_folio)
>>    			ASSERT(folio_test_dirty(folio));


