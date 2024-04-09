Return-Path: <linux-btrfs+bounces-4079-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7862A89E50F
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 23:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E907B1F22365
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 21:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A657158A25;
	Tue,  9 Apr 2024 21:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ByjDL2Fy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A3A1EA8F
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Apr 2024 21:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712698818; cv=none; b=nrPUn8D0xAeyW6mTACVtLOYknomhORl81CwKpt3GinRf4wz9LZBNVW5a8CHTMC5ybe0rFw0ho6+ArhkwWU9WHJIBL0GUS1G9EzguseRTKb6WDOU9EbXw4+xaQh53c6Fto5bXEYd6f+ZURDgTN83nlJUGKPNPCqv2R+ddZfYo+5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712698818; c=relaxed/simple;
	bh=XgxmrDo9c6C721ovLOA/q6QwnyQjuaJJLgRGQG56kzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P++FXB6mVyjFSFMSmpFQcf87sXakwnbRGTctENfItN7GFSJoBIQQrg/3lN2XJPOdifQhbeatU5VfI9G7z+4R8PE6RYmZTzKR0CkvopuXJq8RErpWtMZ4JOhP3h9XAtZoBjwM8a3yK7VjpDBEsuJiInViTp7hYotpNQna1G1ZLtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ByjDL2Fy; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1712698812; x=1713303612; i=quwenruo.btrfs@gmx.com;
	bh=lHryDkXKDgFu9fhU0hbiosvLBAVg8ZAewV+Z6v1BLrY=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=ByjDL2Fyhs037dTleWcUDkScKa4iPLePGvSzgpUJFNlX0++j6PdqaqiErNGdpc6a
	 30xxvmF4Izp3TGpuvPpHUtJEXhc5BSmTmX4N8iNMn+Z3A8sBB53fclcmp+guohXX1
	 Mfb/z2dq+XGNFeoyxTCZWOVNOPiMIcrg2Ko2mOyYMCgq+Po1HOFMmUYg7uRhYd2Qj
	 EzIK4uSOT5t4CLYHGx3hUDVdRlp2CYSuaiNr6Da5cKehnB3Za3TyHqSraRDFTWGtO
	 qwS9FdYPlZFtrdnBS5x6cA6hJjYdKJ5wbuY5YO5uGKjj198F36uYYtl1jDYwSWrwT
	 6vSacfzn5uRDx0QPsQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M1Hdq-1rx4Lp16ra-002pQW; Tue, 09
 Apr 2024 23:40:11 +0200
Message-ID: <68c73ba9-067e-4542-9a26-a70cc9bde858@gmx.com>
Date: Wed, 10 Apr 2024 07:10:08 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] btrfs: extent-map: use disk_bytenr/offset to replace
 block_start/block_len/orig_start
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1712614770.git.wqu@suse.com>
 <20240409145720.GG3492@twin.jikos.cz>
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
In-Reply-To: <20240409145720.GG3492@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dBxRtr+O7ev1WYuw6Z2kAiBJNI5+nyuhOaYTSZmLVxgg3ZSCV06
 nbI1mk5vm2++Hu31qFkN3Ek9npjjhV7/5qB3jfJiBph3M7TjniDidueeSCRihesJaR5o+IR
 7bKhXNojOjZ6DT+nCQZDeYjAncZIWhA5wM0AxJwh4qvwnnbsc43+mHUw1C8ex6jr1gMjHFU
 t8c0O8A2L+qqyqiox5ANg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UjDTNvzwWOE=;PuQc4XeFZE0LN72qXsVxaZDZgGA
 0dfICcLyivk1BgnOKr85dSRZZPZEpOCtBwxdDyEIyC+ERZ0M7f+tb51cy57bVwAPeKoDeF4iF
 ZZobpAyVzF7JFqNqqVFw5434eerpjUluLsLNLS96oBMWP65qE5VbBN2AD9gCEOH4PoBBvTbVx
 N1bXkaMDOBavLNgX+KfNZLqHNwpHnceZzx5StZ/NYtxeC4vIMRhkO7Jon1AMg7HKPT1WEYJqF
 HdL6paxB4T0JaRN6tBjaV76SWtN1jVaOvGgwJtl5qkyv5rb95KbzlpFswPv/2IZinUHPzUR9v
 axa978dKTDDzTVp6zhzEcDzn8WA/EeyrHLp93Z1zhWJPc73GCRAuCqo96p/lQgJrG/fyMtkI3
 o0ELWvW6cq6EIMha0BiWOQs0mzRGs3vxV7fmqovx/nAjuKK02oMOv04xkMYYzWkGpOZa6S+dM
 1nDx78A0Z4ZUwPgvexxEH02fjUbX2Nced70hHR6CusU+GjYktVCpBMKgDUXsdJR0Jt4wnHEOg
 EKcDD/dJlqiHiwFizFrzsC9LfGrfF5vpxS2hhoQqI+h5ObNQN7x29jLpxIMk0tYzVo5NS+XJw
 wUTI63tcsAymXisIy6oZ5OTUiBqTY6opW9GzW9cM+ex6v3+7Ic2Vqmm5oShVW/+LpWfS9xDiz
 FHi6iqrNhGTmV9UtUhqC1LlqiaZL18JHhgU69EwTYyqGQ6w4C+SdYb3pysFu9fVzvh+xuUdaW
 nNjHgGRsFYrVezand3L3hDhiIoVV/VjcPMxaCNX4DPHqJoN4+VT+wu2gugo9R6F5Nxv8XzXm4
 cmL7yO+onI+TmNfMnw8VH1AUqMhugEAXFUES2l7sRH6nM=



=E5=9C=A8 2024/4/10 00:27, David Sterba =E5=86=99=E9=81=93:
> On Tue, Apr 09, 2024 at 08:03:39AM +0930, Qu Wenruo wrote:
>> [REASON FOR RFC]
>> Not all sanity checks are implemented, there is a missing check for
>> ram_bytes on non-compressed extent.
>> Because even without this series, generic/311 can generate a file exten=
t
>> with ram_bytes larger than disk_num_bytes.
>>
>> This seems harmless, but I still want to fix it and implement a full
>> version of the em sanity check.
>>
>> [REPO]
>> https://github.com/adam900710/linux/tree/em_cleanup
>>
>> Which relies on previous changes on extent maps.
>>
>> This series introduce two new members (disk_bytenr/offset) to
>> extent_map, and removes three old members
>> (block_start/block_len/offset), finally rename one member
>> (orig_block_len -> disk_num_bytes).
>>
>> This should save us one u64 for extent_map.
>>
>> But to make things safe to migrate, I introduce extra sanity checks for
>> extent_map, and do cross check for both old and new members.
>>
>> The extra sanity checks already exposed one bug (thankfully harmless)
>> causing em::block_start to be incorrect.
>>
>> There is another bug related to bad btrfs_file_extent_item::ram_bytes,
>> which can be larger than disk_num_bytes for non-compressed file extents=
.
>> (Generated by generic/311 test case, but it seems to be created on-disk
>>   first)
>>
>> But so far, the patchset is fine for default fstests run.
>
> I've only paged through the patches, besides the renames there are so
> many changes where it's hard to spot a subtle bug, but overall it looks
> ok.
>

That's why this time I go sanity/cross checks immediately after adding
new members, to make sure the behavior is not changed.

So that even it's pretty hard to review, if something obviously wrong
happened, I'll hit a crash.

You will be surprised by how many crashes it triggered during the
development.

Thanks,
Qu

