Return-Path: <linux-btrfs+bounces-7984-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E328977885
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 07:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA85F1C23B82
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 05:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF291A0BF6;
	Fri, 13 Sep 2024 05:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="OxBVVm6L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1784183CB1;
	Fri, 13 Sep 2024 05:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726206460; cv=none; b=cqmW1MIfPqTIkCNZ69YLMVW2lt5kxV+f8D6iHmFZmEKo98cFCB6iWTX9xQxLGmqXEVVTjGHZ6PP+N+vGIflJFSpIYTz526x3nQR74cjWIQARrci7nkvr7+THkKwj0l++YI+NnBZNdprjjs8m6KZZdMBAe17oxhK3G6UJeDlkoVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726206460; c=relaxed/simple;
	bh=lAMua73ejBJurk/Ie6xLFCg83ls2Ldu5/yxaZDQ0kHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JTSgUBIAgj7wVGtORLKkBFcRRNNujWr1gBYje80Q9CFymH/L72tQ3xEJwFMrec2f+oGJZE1ssbDSaRSV0yNQ/4Zbiw/+/jIqP8f2N2QGeP4/Cpcs9h2sDwvv8a0CaUXjO1ud3CWYYDnQi7Pcl8WO7pDGunssVSMBaPjkYqK9qjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=OxBVVm6L; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726206445; x=1726811245; i=quwenruo.btrfs@gmx.com;
	bh=lAMua73ejBJurk/Ie6xLFCg83ls2Ldu5/yxaZDQ0kHY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OxBVVm6L1Js2OSv5x+d3IZrU+jS3kG2Jk4KneMnIzwcYyiXcTEY/HQ00Sru4ZoMI
	 dzh2RvsHHhudYOe6QECbMuqkYf0tNWFr4kL3fy26GIZfQIPXi3mLA8P64FyrghL9M
	 L5mgn95ICclStLviPlf7i9KKwrtGiSyVWc938PmB1Gd7JL7KBB4tLM74BSA2UtnfF
	 oW33PjBUzUbttCrONubaADGlkgGuY7WSaxGu6YUj9mbh8Cl2c02IZufHGk+cc95yB
	 FS7UexkO7WjOnBfPvUqbC6O8HGZDL5DAqMZ3nLmwXF48NDCZoBxSA8k1zGTM8gfQf
	 RDTp73paIwo1gfCC2g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MgvrB-1sN4K11ebF-00mRsc; Fri, 13
 Sep 2024 07:47:24 +0200
Message-ID: <85888aaa-c8f5-453b-8344-6cabc82f537e@gmx.com>
Date: Fri, 13 Sep 2024 15:17:19 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: scrub: skip PREALLOC extents on RAID stripe-tree
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: WenRuo Qu <wqu@suse.com>
References: <20240912143312.14442-1-jth@kernel.org>
 <a0d0fa88-e67c-4b35-88b4-74c5b15a16bb@gmx.com>
 <958f5586-c37a-4836-87a2-4530428b0a4e@wdc.com>
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
In-Reply-To: <958f5586-c37a-4836-87a2-4530428b0a4e@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5wVcUuI1GXMVxdeNkUQATjTvVBMzNLFpNPQ8eIwvXFTUdatVbaC
 sl5NfNe3OkDrLxe0fKW79BS0rmo9JVBEIVHXQEnZ6WGHd95T8LqiTTKl2e9tfXciW/BPC9f
 dCUOK5dLbSWmT6mPnHcmFSKCzZRxwAPFSXNQznJTvPEauqaAgVseGc8mcYivD1soR2ERWiK
 oxl9qyG5l/peJTDwmCT6w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yF2iUk9ITAQ=;GK0xtzAmesKahR10OBPz2IsDzNp
 VNqDA1MrCgijWpnK/6estQTuClGDIOMUFZYdoO3T1CaJ8exKElbSdJn8BtHTKaZS8AXlZhnvL
 yLm7b7Y3WQd2l+woQtejeNtcLtdcNUKSQ0UJIyjhLIPXwx+XmzOMFwBTni2h7MTRJ7nos91/X
 skSRbFdpR1LPjwYSfctmJ3pk048C5H87g/nbS7RDwJB8prDDp1/m/GeP9YXVlD/gNutIj8oxi
 UAgijv1gHQ62A77aZpeAQbZ8rbfbVFPFt1/b1o51AkmWeIkkQ7IlP2t4vrmlncZbcpKXtODz9
 G3G6dpaEz64drk5E2iWo3EzhMio4uYQ6qkj5I4SdYvWO6dRo9c45AT4+CiYXPHGGssFdOtfB+
 PwnPOTUtRekgAeySkcJvaIJoslwUCIzn0DZsw4NNEvnURqMkbmEEUzLGmuchzcLyHPasylvrr
 HZr5LD7OQJpUuCOAcUMqMpvEXNIvJmCVoVFEmfNezWGauSwQfAI3/ojN9Fh3MHqEcMrXxcEs2
 9zhbaXPYFHnBTO67l2yuqiyW5alRI83/cHljz3I9LeK+8mkec5aZs8lQnePDTPHgqPxvsn9Yp
 U4KI0j2IcWFmjWKL8AFiHHRa4ZUrcAzZpRP5eHF/Sjx2iCVu5cFFczftqKUbSQ1itprjfpE/5
 qVw2MiyHBEBt5VyhWJbz4FuO0SbEJgcYowmGE1AjCLQBrBvVZ8WlR2CImHTcbj3M3SdX3A2P8
 V8/c1gxdD4soMfgb6CdKV63V05QL8V1l1R03Ngde8I3iE/AORuBmMnNbUqG/gbgqRk6B/ZKin
 MOeC2pld7s6UC59VfK8Ur8Fg==



=E5=9C=A8 2024/9/13 15:12, Johannes Thumshirn =E5=86=99=E9=81=93:
> On 12.09.24 23:32, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/9/13 00:03, Johannes Thumshirn =E5=86=99=E9=81=93:
>>> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>>
>>> When scrubbing a RAID stripe-tree based filesystem with preallocated
>>> extents, the btrfs_map_block() called by
>>> scrub_submit_extent_sector_read() will return ENOENT, because there is
>>> no RAID stripe-tree entry for preallocated extents. This then causes
>>> the sector to be marked as a sector with an I/O error.
>>>
>>> To prevent this false alert don't mark secotors for that
>>> btrfs_map_block() returned an ENOENT as I/O errors but skip them.
>>>
>>> This results for example in errors in fstests' btrfs/060 .. btrfs/074
>>> which all perform fsstress and scrub operations. Whit this fix, these
>>> errors are gone and the tests pass again.
>>>
>>> Cc: Qu Wenru <wqu@suse.com>
>>
>> My concern is, ENOENT can be some real problems other than PREALLOC.
>> I'd prefer this to be the last-resort method.
>
> Hm but what else could create an entry in the extent tree without having
> it in the stripe tree? I can't really think of a situation creating this
> layout.

My concern is that, if by some other bug that certain writes didn't
create needed RST entry, we will always treat them as preallocated
during scrub.

Thus it may be better to have a way to distinguish a real missing entry
and preallocated extents.

>
>
>> Would it be possible to create an RST entry for preallocated operations
>> manually? E.g. without creating a dummy OE, but just insert the needed
>> RST entries into RST tree at fallocate time?
>
> Let me give it a try. But I'm a bit less happy to do so, as RST already
> increases the write amplification.

Well, write amplification is always a big problem for btrfs...

Thanks,
Qu

