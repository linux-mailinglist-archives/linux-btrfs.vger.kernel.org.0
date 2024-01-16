Return-Path: <linux-btrfs+bounces-1489-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6742982FBF7
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 23:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1688E28D643
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 22:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF6220B16;
	Tue, 16 Jan 2024 20:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="shS4e2TQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E866020B11
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 20:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435576; cv=none; b=mrrSvrJrfgQkbXo0qiGuZvdmqM7512kRoyb/5UMBNV/U7WZDkoBRVrkxG6Toz1MmVRoTySCt8HR4VGlvPIlHQ3gTsqjIclU2IVgGWUeLK9xb6BdUfHfLxTfu+b/uFV5lTbV6tDuTRDmP2FDZE+vrqG1s2iRMZHRwWOJRlCTmOk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435576; c=relaxed/simple;
	bh=ZTjgpjUpuMgUL7msncJ6MSahZGxekNPg4weV9kTRma4=;
	h=DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Provags-ID:X-Spam-Flag:UI-OutboundReport; b=aXfeP3uL6r9P+re/MOTcDIR9D86h/4Umnb6gYHwkTUTIfKyQgDoeTOYEJfniCTZsyYO56QSlj1uGF5fy9LyLNAyicKH4buot/LTqmU6urZdxjVRW+Vh4ECi6WMcYpOjx/lvjq13A2hvvXggvyW2mlHVBA91zTSvoJelw3AvImjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=shS4e2TQ; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705435565; x=1706040365; i=quwenruo.btrfs@gmx.com;
	bh=ZTjgpjUpuMgUL7msncJ6MSahZGxekNPg4weV9kTRma4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=shS4e2TQy65NZDN0yj59c496Hb/E5aRG4ckV7BCC/p1jICuwFK4BzVTmaP9b1KcH
	 s0EInR2vgKuWZR+EEPJ8uS3T4jHu57V9h6Z2iZXUwhjfFtJKH14KOv10y3QlV+QQV
	 lyzCygk5PeHA3tG5N/f8mFFO+8EgzZ3lSrJIW3ahiSFsqVlPnT/EGGyWjJSU7bfSF
	 i/hOlmCzHAIou5Qnm6E9CmphAlcfy++LyLu2qRHbsUY/Qu4sK83ROqTZsM/9RCc4E
	 mbIec3GbaMSheu4yHWboZ1n+zuSTtpsOwpChhbABnkCS/4u52nryBrJgoi9XqoUOT
	 OBEPqK5bjBXy7pPQYA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([61.245.157.120]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mq2jC-1qlX3v0CQs-00n9YY; Tue, 16
 Jan 2024 21:06:05 +0100
Message-ID: <49056bc2-55ba-4f09-9a30-0caf4016bfc2@gmx.com>
Date: Wed, 17 Jan 2024 06:36:00 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: scrub: avoid use-after-free when chunk end is not
 64K aligned
To: dsterba@suse.cz
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Qu Wenruo
 <wqu@suse.com>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 Rongrong <i@rong.moe>
References: <8531c41848973ac60ca4e23e2c7a2a47c4b94881.1705313879.git.wqu@suse.com>
 <12744dd0-a56e-487e-b27d-4ad66498d7e5@wdc.com>
 <de82a8aa-7b51-4aa1-9cd6-a2f749a6e941@gmx.com>
 <20240116182807.GB31555@twin.jikos.cz>
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
In-Reply-To: <20240116182807.GB31555@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lLCmsGMQAnqPICUZqDU7fmnK2n4zdcP+hPuQJq3UpTl+urYo6Z7
 M+FEAlviweeAvb1VIRa1t3TFfD4JJVVcSnDghbpL9SOyko3BLv1dANPMCAlvhrL0pJ1zTHK
 Xy9027SSK/QYY+7nl7VJhEjDa6A9h5rDWMBuBEROfL55kc2gt3IbpE6xCqB+ocZFtg4Qyk5
 8+nHiT427iuyeHHKCy0NA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:k0gMXu2PaHs=;Xhz1cwufBrqIZcHg9jdl4l8WSfd
 0rTJ+9IfbD8Co2JCd72l5aa25COH57hieDEF0+NQw5smjKsshryseIEC32arMJ4AQXQbYdm3c
 ssd9Bfdeb21I7lgKdOczc7+I8tEhrSsqPltrTuhEXoQ9keZelVtGpkE2Vfwi1Wpm+6baKL5xj
 vQ/jgIKBi/IjM+tbIPMVS5GDNXrvd+yqFrb/KFT/sUtzCzsS467nmq1koNTDBFqzZAgNDIspX
 0xpGnQr4Zf+tMIY8Gh+6RXq4UNg+qE31tEDrVQ1DpKtgGZ2K138kqZQq+eWIqfvswSvM1NC7T
 6StpksowQNDTqLB1rH2aIxdGd3/AsvENvEy+bU9kK0HfJtd8grxk8jjIFyQspYrY04Dlegn67
 1Wm/9hoKBYmCmOwSyPXCuXChhZfDcfab+ITv0y2do9/VLimD8IdHufE2xXukUvfOQD2kDvV8w
 DiBER+g6PlIXWYd2eZFNjDPLA8O1NannAJDtVskzuqGZkpbkxjCBOHezs2idMAGZ2EEcECWVO
 xGmOnzlbQOWXhqU+zUWATtOv8hCpqv4GCLM/sd0Me+MIkZ677qbWeEEx2nWM1PIgeQbcJGc0x
 0GPXW0MP1cKj9UCKa/vCCrCwn9aB3Nj7FFgNlzW6R82Dv527cEk4m71+di4Cu6VYgvMtINFWy
 DFnfwpO/OkfZJ+thvmUpsoTcoKMX8UoEYt/e60OJ/fnUcyJYiybt5c3DIaeY/R6U8FsNHbOJa
 AhNoVqapmn+5O5PfrnnDfliDR5ooGiH/BzDlKa7PsqQ+GEEiMDeOF47HXkW95qKwJ+7YZ3USN
 U0vVihgtr9Drlv6jTrPjV0FVBVxiepUlmieo6nARBQPAO3JNXWAhOiUz1kTAK8eCRtvtLDHuY
 08zHlxujT9PBhlc+n5bhL/p9P/SWL5Lj4Rg37edEkmuJsGzv0gvDv94jmNkasHwdsQ8kpLbFJ
 KNBYsSsSCEvfC1iyhBj6gIUaTEY=



On 2024/1/17 04:58, David Sterba wrote:
> On Tue, Jan 16, 2024 at 09:20:58AM +1030, Qu Wenruo wrote:
>>
>>
>> On 2024/1/15 22:39, Johannes Thumshirn wrote:
>> [...]
>>>
>>>> - Make sure scrub_submit_initial_read() only to read the chunk range
>>>>      This is done by calculating the real number of sectors we need t=
o
>>>>      read, and add sector-by-sector to the bio.
>>>
>>> Why can't you do it the same way the RST version does it by checking t=
he
>>> extent_sector_bitmap and then add sector-by-sector from it?
>>
>> Sure, we can, although the whole new scrub code is before RST, and at
>> that time, the whole 64K read behavior is considered as a better option=
,
>> as it reduces the IOPS for a fragmented stripe.
>
> I'd like to keep the scrub fix separte from the RST code, even if
> there's a chance for some code sharing or reuse. The scrub fix needs to
> be backported so it's better to keep it independent.

So do I need to split the fix, so that the first part would be purely
for the non-RST scrub part, and then a small fix to the RST part?

I can try to do that, but since we need to touch the read endio function
anyway, it may mean if we don't do it properly, it may break bisection.

Thus I'd prefer to do a manual backport for the older branches without
the RST code.

Thanks,
Qu

>
> The change itself looks as an enhancement of the existing code so it's
> "obvious" and does not need any preparatory patches.
>

