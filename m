Return-Path: <linux-btrfs+bounces-8883-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB61799BC71
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 00:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553191F21404
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Oct 2024 22:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C4E153820;
	Sun, 13 Oct 2024 22:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="DmvV5Pk2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18BF12DD88
	for <linux-btrfs@vger.kernel.org>; Sun, 13 Oct 2024 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728856838; cv=none; b=HoxpZeL6+ieywkj3SMIUT+nq0caN0xr25sF4IMiUu/zUVQJfz3lugPBg3AOc+11fnkIGmjPbnODHy+fkEcOWYWzM0thRb3jkd4q07gjIWVGCHOaL3hqUAW0mg6e65lpXToKR4+kUkfQZ51limFcLD3lR1ez2BuPMZzWyCl54p54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728856838; c=relaxed/simple;
	bh=UdwH7K9yf/V30xOfAcWAOm5m7lqQyH5BdEKs//qVq+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sMHK7yVUpPyAmDh8BI0qVgv/eOzrs8rw65eg19MrKAiuMCzuEd88MH/07gnH8YBXrzwqh4ZWijqlO2eMSrX/Ksfs+wSzdylzyFS6EhKYRH7nWfxmhvSFxfRNb09EBFil7CfD4i/mXL7oOJGbIcaHrdEbLBwAOsPTc5sigPlsKp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=DmvV5Pk2; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1728856828; x=1729461628; i=quwenruo.btrfs@gmx.com;
	bh=UdwH7K9yf/V30xOfAcWAOm5m7lqQyH5BdEKs//qVq+U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DmvV5Pk2hPtx2NqFXq4YAIANpUVFgw+PLJMiwoLMv+Xj4tqVqiR7FqTCx3XRgy4L
	 JdshS0YKxs72Zfi+5SQYJIssiKnpCXsVf5kGL4r4qc1p7d8BxnKHwVkF0TBeXQ92g
	 Qb/mMepujtQgVX+mTNljjIVui4Ez/AHuSql2EUSR+jqeMQ/9EfHGl7TTz6mfMHEmN
	 zVm6txoG/Y607ibWkKSSqMa1Lc++xnA2/NgHHfEbtp4qWBpLW7W/5QvpVNN3d4mHB
	 Q7kaA00+X05CxrSjS+CqwdRdkAVeQgZMT4u1dq+F4sfrBdEKSFgoJpyd0m8Ggx2NM
	 wbCu2zSUwayHHq228g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MSbx3-1tOYQn11QX-00Ygfq; Mon, 14
 Oct 2024 00:00:28 +0200
Message-ID: <a65d59bd-65ad-4036-9538-9977a4d0ceb5@gmx.com>
Date: Mon, 14 Oct 2024 08:30:25 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ERROR: failed to clone extents to [...]: Invalid argument
To: Christoph Anton Mitterer <calestyo@scientia.org>,
 Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <CAJhrHS2z+WViO2h=ojYvBPDLsATwLbg+7JaNCyYomv0fUxEpQQ@mail.gmail.com>
 <CAL3q7H7RfafuRir1Cdjh7YQ2fhas_NyK5orf4QYutzPC+TKycw@mail.gmail.com>
 <df20ff9c041bad189b19971a9f41cef6c43e696a.camel@scientia.org>
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
In-Reply-To: <df20ff9c041bad189b19971a9f41cef6c43e696a.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cr+GIk/tfeaBnO2LOfMe8Cvn2yfXpK07b8aQJ7d+0nYPgFJiu6G
 81vhDi2b+4Mp0B+Y1I2aROlQXkc/bmndkK8jfoJT1d7a82/rAdSwFgAujlAEMTt1PRh0COk
 e7yCrK8gcbWYvTMklDrEcWubhtOm73gcJSEzsz4/t2M3r5GCZMj5tjIphk9UZxtlzcINf3F
 TrBueZ7ocmVy+mAUKyl8Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:byGBs3kaLDs=;jBLRHAdDmA3S5lQlA55drG+WehD
 MkobpcCYBAj5sBIl5AqsuBq9l91vVMnZ87kEacXEcMIFkNRMwpn+cuvg67MQEDK6jUqa2bLhi
 lJrfDGeJkAuJfXrTbS+lEYKIE3Mtc6I5K1nSkg2niBAnTwTjyXc4aappzG5wv0dV/jNdnc+iU
 gnInfbiPKUDMsVOqx1WXVe7Lm+tYbc3WM696Z0FQAe00AGokHEZXcMDeBJXjnXidouzihzRky
 zV8zTe6nfxeKyo/s9WBzdCkuZDi4Kdqr33OYDGkE5pB+Blk64BtIdig562gjkpgNiDE7HbItp
 eBYZb7wfmwczs5yzw0IiuD/88X6XKFJ0YHiLwxKlAIG+7GI1p1aDIDt5MEuo6/wL2pGJn0UXM
 dA1riiehTV/B9TeHM9DD9f+bmJ1i/sEDo7jWrtvoSBq+i8IQb48ONUmWPBmVeTpyW3idp9rhb
 o7lNeMZE/alEExUei10eHfLfn/dfUgR5Rtoj8MBmJC8HJlV7Cxn4RjRzplDj+dFnzYy8n9Ie7
 TRAVxzlhLMvqONg7LHethGbhY8HUm9L5fXtqQf/b+dGDyEEarbB5ifz4xVRcQIAzrXAf9F2Xy
 kxpHNANRnP245E9GcW93TXI/Q7Ya4mPnEY9xVbNnkn4aMLPbenrH7bV4dC+6pM2wabOca/Vz0
 JkbGvsxQGvksr/Jg4IzdtNG0s/m/PkVOaa1rneuiRvtHODi9Qb+R84JFzPqIqkx4t5cIrFC9x
 09cgCJ/Ry7s+tveyUYeJHloax4xYKCuL4cnygaDbAE1PNOdu63U6/gO+6h4yFSmKA8xW+3pAW
 JgMaqcH1KsZjcFsswfGcLyj8b7V1vSTByMrHsbITVHTVg=



=E5=9C=A8 2024/10/14 07:43, Christoph Anton Mitterer =E5=86=99=E9=81=93:
> On Fri, 2024-09-27 at 11:32 +0100, Filipe Manana wrote:
>> It's a kernel bug and here's the fix for it which I've just sent a
>> few
>> minutes ago to the list:
>>
>> https://lore.kernel.org/linux-btrfs/5a406a607fcccec01684056ab011ff0742f=
06439.1727432566.git.fdmanana@suse.com/
>
> If one suffered from that... could that cause any corruption?

No corruption, it's just kernel rejecting the clone command due to not
yet met size requirement.

> Or would
> one be fine by just deleting the received subvol and start over (with
> the patch).

Yes.

Thanks,
Qu

>
> Thanks,
> Chris.
>


