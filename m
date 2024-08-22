Return-Path: <linux-btrfs+bounces-7402-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2632895B367
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 13:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C42FE1F241C7
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 11:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AA318308D;
	Thu, 22 Aug 2024 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ZgnVrsR0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F094F18C31
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2024 11:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724324540; cv=none; b=FFNQ/0+S1N1ZgiJrpyDI0zZan17WE4Qr5qCRTQBPdyHhvXmGSACTJOkGWOo+p5Ew4VKTydt9lv1tDMk26ZB7yb46tNTwzWVTQ+G2o3OYAIzvgFPE0+ggxut/GSJiIVIsm0bJqHfpx8EAxm959wa5PoD4nYOfct3niEdkcj41zE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724324540; c=relaxed/simple;
	bh=BDNUTGsR5rsd9bQxG18DAjlfa43zSOpEZTUhhbu0tU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLtJudtx1MgqiWNBWZrHbmQ6+cMkRHhu3TYktKeiTcTD9Wxk+G9yAasiUf62vWuUNH11PdCer0RMdfEk0JD2xCQmmqAQ+eubLPKL9AQcaKKIGPPPSN2qYSyFeaQ5jC9r/DLcQ3riw0wb7ULg9KcR2fwb/sa9Fr6vzU+3r278XaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ZgnVrsR0; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1724324511; x=1724929311; i=quwenruo.btrfs@gmx.com;
	bh=p5LugtInfG5PpMXW1laltD35A5E1nWXeEWvj3V1iu9Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZgnVrsR0W3k63XUpc/YWjXL7IppFxzvppI0KD05zlojhveeN0zwtEXx6RoLrYDpH
	 OL9OJCyMf2J0t3NI5/2wUl2hoMlRXLwX1l5GjaYEXzEjIPxBEXzj9BzZ10Q8qxi9a
	 BQo3JqKMram/YVm0TjISmrDPMS00zX5CgOaGLivTbgQQIvST49TvIZXtRpJ1TZwPh
	 rTEPEAFiXtTbcA8c4nXDchEb7iETZxUK8YIjCUIflPaGTBtqi5PNbzqCvXoG5ZLv4
	 AFR8PiyKqzrlrbyCktZQwA92vebixfg/XgbphQe0u2tIAOXyRgCwmoClG2peLDCTW
	 6sRfvk8urm57i4ui8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4hvb-1rxPVw1Lq3-016zxw; Thu, 22
 Aug 2024 13:01:51 +0200
Message-ID: <e975458a-edf4-4525-b424-5f284eebe979@gmx.com>
Date: Thu, 22 Aug 2024 20:31:46 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] btrfs: convert get_next_extent_buffer() to take a
 folio
To: Matthew Wilcox <willy@infradead.org>, Li Zetao <lizetao1@huawei.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, terrelln@fb.com,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <20240822013714.3278193-1-lizetao1@huawei.com>
 <20240822013714.3278193-3-lizetao1@huawei.com>
 <Zsaq_QkyQIhGsvTj@casper.infradead.org>
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
In-Reply-To: <Zsaq_QkyQIhGsvTj@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GDAnGXDL6aEutjR12TqJRyPi0QdhoBXRm7C6YdXoCL4WGAxM3vc
 ah8E0Jx4R/WmSf7YXdpxQRXSamBJ6Knn7uAvGtDeowZTBykTfAdjWJ/I92rFvxWnHEx6GNV
 iXtHHUUY6AZUs1NS96QSxff5+xIF0wwe+TTF2etMXwl9w7nG+cR8BhYVE8jSjfJb7S803oz
 BSBtOM7zbs00mYtkgPT/A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:z2xu3eHn5e8=;4mam5odIxAsFkVDuNUmKggEcU52
 4d3sWr8SrgzwlObVJJXEat12uOvXebdBzOVNyU4bPsSER9/13KdMeonQPHYx/MqEuj7eE8vSs
 GeWWXA+fhTDrplUqtEkePtLtpNApBwbLZoux2dGmaOb6Sje3JbpTiOZBk8n12CpTgtx9ye9rh
 2/dykP/llfaZpu559Rm9aNLt9qfX2kocrzXBme+fRewQbtqE9Ss4FOpdycct6GLtHM3v4hyZL
 Exu5872MSabVV5tQSrluVYlxA/hqmDxD1XPr6veBc4k2JULMeqD+AoEm2BwrKGofkS/46gjDv
 uq8jwE6Q2W5dNFp5ey0fYRcVou+oaCX6nOlNB0e6HYc7LPg5Br0ccq5AV0AQps/Tt0CC0iHyX
 hFZi73sEQAUrRdQG5orA+pPesj8TPDmGIo7MbO/gSXn2jaITs0UK0gOM5gi8JpqygYz/HhNN0
 t0/ceLMR3qJ8hfySBesrN6t83KFLFQqxZcmlwtwuhxHR/oOweQykGzQOTwi3CluDY4W2c6C8F
 FhpWRGP5IgWsww0Ha1ZHDU+Ysi45OZedWlaMIkpCj6spfjNQbbzt9pwKNRyYkkt0j6lPu5G62
 /lylwNetgO15e/Zkwat+/LBWkAY1xlJyev2lIgu1YDSEeMHqCRt7RFRFBv9up9giwGZfw01BG
 GXog0wmdYHejvn7kMyrMNrsjaxlbGqM4vnXdjojfN+bw7VdDP74NL+gb7+w65INwBvccQsXDq
 gIll0xZn5rj20rYn+vPJ2fnWNc/7iq11Om3Mitr/cB7wY2OaGb7z/Dqj5ED5bwXUsnrt/aX4Y
 zZOyk9xg52T9RhJaes96gvmA==



=E5=9C=A8 2024/8/22 12:35, Matthew Wilcox =E5=86=99=E9=81=93:
> On Thu, Aug 22, 2024 at 09:37:02AM +0800, Li Zetao wrote:
>>   static struct extent_buffer *get_next_extent_buffer(
>> -		const struct btrfs_fs_info *fs_info, struct page *page, u64 bytenr)
>> +		const struct btrfs_fs_info *fs_info, struct folio *folio, u64 bytenr=
)
>>   {
>>   	struct extent_buffer *gang[GANG_LOOKUP_SIZE];
>>   	struct extent_buffer *found =3D NULL;
>> -	u64 page_start =3D page_offset(page);
>> -	u64 cur =3D page_start;
>> +	u64 folio_start =3D folio_pos(folio);
>> +	u64 cur =3D folio_start;
>>
>> -	ASSERT(in_range(bytenr, page_start, PAGE_SIZE));
>> +	ASSERT(in_range(bytenr, folio_start, PAGE_SIZE));
>>   	lockdep_assert_held(&fs_info->buffer_lock);
>>
>> -	while (cur < page_start + PAGE_SIZE) {
>> +	while (cur < folio_start + PAGE_SIZE) {
>
> Presumably we want to support large folios in btrfs at some point?
> I certainly want to remove CONFIG_READ_ONLY_THP_FOR_FS soon and that'll
> be a bit of a regression for btrfs if it doesn't have large folio
> support.  So shouldn't we also s/PAGE_SIZE/folio_size(folio)/ ?

Forgot to mention that, this function is only called inside subpage
routine (sectorsize < PAGE_SIZE and nodesize, aka metadata size < PAGE_SIZ=
E)

So PAGE_SIZE is correct. Going folio_size() is only wasting CPU time,
but if you do not feel safe, we can add extra ASSERT() to make sure it's
only called for subpage routine.

Thanks,
Qu

