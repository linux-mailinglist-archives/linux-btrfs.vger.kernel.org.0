Return-Path: <linux-btrfs+bounces-6977-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C121947510
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 08:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A3B1B2153C
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 06:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB5E1422BD;
	Mon,  5 Aug 2024 06:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ogGc3VG1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED5638385
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Aug 2024 06:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722838254; cv=none; b=OYV/JY3M3NM4nbRjKjlL90dOaeeqmSxBuN+ip0Q+rz3QH5JDVnTKEEl3w7J6WY7zZpppcDwcfQKRnrC/i7uIqMddz2YXuoMc3F4/+rkTNeMYJk6zH0P5PGCa3I64+ovdR1ipCdn2dfdFNGyyLCPXWGmdwR38fqKCFX+Lszip9es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722838254; c=relaxed/simple;
	bh=J2uehO0HNPgCAGzIWRF5lFul1/YSDbB86yh2Y6VTq5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nDDn8ho38EqwGWplzJr6aJqE5F1gIK/7/oesp99pjJ7aBnbA6i7ErQzt91HftviDKxKB0Z+qsstfx3XWoRG4QEoRwBWZjiTb0qUbvF/UhvQraKu8vEIDG/qanstvJSNViokyAtOT7zQi4xsa4/ylhsidepVCGt7dYNJ75WxEZj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ogGc3VG1; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722838249; x=1723443049; i=quwenruo.btrfs@gmx.com;
	bh=J2uehO0HNPgCAGzIWRF5lFul1/YSDbB86yh2Y6VTq5w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ogGc3VG1YRihl6DbkqEYU1rc8VChKvK3yqAMgOBNDITDevEs8+77abu7ghAkpKMd
	 d0Qorasq44dmcNeIWGyj1n5nSL2RnUxR4qKSut4aT51HJdYr44fs05v7zmML7dkLF
	 buB8Makqna45pJpMJDuv3xrgwPCxiJzy46zNIgnKe2fDP5fMK1lLGTyYWrOaxEKF+
	 P0pSgSSgKvfQMtB5XcIfxLgrr+Pr/uMywIDh3asId9R5AuOGZmG5fHfRJ9BKEIFZK
	 sdU4OdSeXgCyXXjK0Lh/uJN0WCqp4RYplSlaY6WgEOGpVniyplYIhYzP0QeT02f10
	 nz0GEYac91Qak2B0xg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MrhQC-1rpffp1272-00ZMr7; Mon, 05
 Aug 2024 08:10:49 +0200
Message-ID: <e53fdb4e-bbb2-4777-b822-f1173dfed3db@gmx.com>
Date: Mon, 5 Aug 2024 15:40:46 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs corruption issue on Pine64 PinePhone
To: ellie <el@horse64.org>, linux-btrfs@vger.kernel.org
References: <9b4f0e79-6e77-48a4-b87d-b27454ffb399@horse64.org>
 <b9103729-c51a-487f-8360-e49d3e9fc5e4@horse64.org>
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
In-Reply-To: <b9103729-c51a-487f-8360-e49d3e9fc5e4@horse64.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Apo5fBaPNUwKVUbDd2vFnb7b6sIloXbxLNc3KGTixZV+sMT3mQp
 clGEeYkYAwXSv7ixUni4Lqi9drHY511whDOX3yamfHt+lyO+pg8+oMXF4R7T7X1QHd1l3Yw
 Sb9PzFDwvsVjacobWErSh7D2LIPlbxH+9goiqOFlTtJFzinNrl27o+KxpF9eJl51Z/sTx3q
 Im/m+OxGNzEHyHcs1LeDA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:udUeHYLnlpA=;kzcW8vQhmg8chtnyYVVRv9L0b2L
 uUf2Ww4uJySfrSR0QHcgAG3FfOCPdqctNgifrNr5ZYDjcZU1/gEKdkhG7uPyVB/nt1MM5AM7i
 WCgYNr6RFAOnFmUjEf0fWTrO4wSJkARQx80mc52psCvRcjLUt7wRo/yLe1MNy51v/VXyBp856
 Ts0uhXlAjQjcwfE0LOLO9zLBCXPCiQCfRXhUABUdh6Ld7N+yXI+miZDbX8mZAgx1fAAFBSz45
 kB4ITaxUTOV9nlipgId7oC3OUKxWvXYNQHrZRhRQjuOigwzHx565BTNUfRHxo/JKq6FM0NcvY
 wrlbi/YRREmHZ46pj1jK7/L5Ig1cferlRcLw3yNPUT8xbsBpRZwRaS4dKFNASeFK7k6YplkNN
 xbtXZts1q85vt19L2mugbgHnbuLfOnJjIIgjzWYxUVNCnz5VKLLXzI9mzfL6e9MPXqbqQJZOW
 EWM3nR3nG2RAwUuAJTICLr/dcIkS0yH6vZxEgYMud/QKTlXk8b0Ngax2VmX5sdFvdO7r9cFx+
 n4ZAm7qTQAqWJ5plLsHwv8Cr7KPkEsZc6yQzZDHajjn8ClVka+3RG7aoVXiq9euvapZ6hhohP
 7yd6qe4hpEmyVmdXWezDWpOkgf6a1M/OykujJstNAps+gNSaErPIzpemHfh09Y7zzOToA7ElM
 dqa24KtAZwoZll338+UZNZnSh6PcFkgrOYe1o/agCrc39tvY99AgAXWozISjlfuJ20RRa4z+Q
 rQB5Egn3SImsCyMONARacY2upRXp7xwnG0Im9/4c6KRIE8/O6EZFgu86eZLM6rrN9EfxmgmZo
 sSbw4dqYJGPN1KloM+4b4JOyoHGncXMbDO+SzoJOPy7yk=



=E5=9C=A8 2024/8/5 15:25, ellie =E5=86=99=E9=81=93:
> On 8/5/24 07:39, ellie wrote:
>> Dear kernel list,
>>
>> I'm hoping this is the right place to sent this. But there seems to be
>> a btrfs corruption issue on the Pine64 PinePhone:
>>
>> https://gitlab.com/postmarketOS/pmaports/-/issues/3058
>>
>> The kernel is 6.9.10, I wouldn't know what exact additional patches
>> may be used by postmarketOS (which is based on Alpine). The device is
>> the PinePhone revision 1.2a or newer https://wiki.pine64.org/wiki/
>> PinePhone#Hardware_revisions sadly there doesn't seem to be a way to
>> check in software if it's 1.2a or 1.2b, and I don't remember which it i=
s.
>>
>> This is on an SD Card, so an inherently rather unreliable storage
>> medium. However, I tried two cards from what I believe to be two
>> different vendors, Lexar and SanDisk, and I'm seeing this with both.
>>
>> The PinePhone had various chipset instability issues before, like
>> https://gitlab.com/postmarketOS/pmaports/-/issues/805 which I believe
>> has however been fixed since. I have no idea if that's relevant, I'm
>> just pointing it out. I also don't know if other filesystems, like
>> ext4 that I used before, might have also had corruption and just
>> didn't detect it. Not that I ever noticed anything, but I'm not sure I
>> necessarily ever would have.

In the detailed report in pmOS issue, you mentioned it's a video file.

I'm wondering if all the corruptions you see are from video files,
especially if the video files are all recorded on the file.

If that's the case, it may be related to the IO pattern, especially if
the recording tool is using direct IO and didn't have proper writeback
wait for those direct IO.

Thanks,
Qu

>>
>> Regards,
>>
>> Ellie
>
> I forgot to specify one testing detail: testing this seems to require
> writing a couple of gigabytes to the SD Card. So that's an additional
> difficulty, since I assume doing that too often will simply kill the
> card for real, which limits how quick and often this can be tested.
>
> Regards,
>
> Ellie
>
>

