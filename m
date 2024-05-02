Return-Path: <linux-btrfs+bounces-4687-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD808BA258
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 23:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DAE1281128
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 21:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF4F181BBA;
	Thu,  2 May 2024 21:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="NXmaqY4p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67CF1DDF8
	for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2024 21:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685589; cv=none; b=ukiCBMIou1LVJY2BEu7j94gpYIeDjp0/5Aj43Qo/k1bsh3EMlMVJ3BCLtQld86JsYpfppDB9ztLo63Q+ALy7HdqbDot9FGDsYL12AgWxxMHwiC9ydtC9t4Zdgn3RT4HiTAY92xKlz/NhIzCgvzKUCZbKBWp0MVqF7KEA2zVoEWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685589; c=relaxed/simple;
	bh=439MjiPGSWZqWYWxcWheE9NNRtOq3c+CNrw7Cq/R69o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=to+18M2DkJBvbDTfXQGxB8SoHPWLZtqHicxKE52UmbmAWZ7XdqkjV90o9+QDybSZ543XpyT+RhAtRdBMM8+PPSQK8we2eNS76yFNOAn0zAw56yrMIB/GV/PwANniOgMsGwPO3vO1iqnnvRZMaUQ/MIt6tPVZM7GRYhoQ+MuDC24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=NXmaqY4p; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1714685579; x=1715290379; i=quwenruo.btrfs@gmx.com;
	bh=XUg6xofUx7PiAbD+Kg2oHTMu/1OdPbEFM7R/IDzofIw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NXmaqY4pKNmx5fiCoLi4c0AkkvVTusChiA3K7aKwxVWfFLT24nTqTzhgWNU45Z4+
	 pLi6sgqzBMyn/LcsIbnK50y5WdWtJUxWMQSM7N1qu5xJKPPNTbT0Sw4BGajdVIURY
	 I546FA4mYXzeZ88T2KjzLIST3ASjYH8it/8CzQ54HblAZYW7pn0PskRyoz04FeWXC
	 /9X2jcXISpC/sg8jL8oHqLwF0V+svw9bfVaeMl/5AEn2cdXwbK4kCO/cm3dpTaB14
	 jNL7ROheEwkX0uGUrCTZVngt3L3H7gmDoorXEAM2rpannfHMpGVxMD+Vt7hqjoGtV
	 /uvT4cOkrEC3fIYnvQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtwUm-1sukfW2pbQ-00tjkq; Thu, 02
 May 2024 23:32:59 +0200
Message-ID: <0a5cb0b8-617b-4e11-beb3-8a60a2e5bffa@gmx.com>
Date: Fri, 3 May 2024 07:02:53 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: make sure that WRITTEN is set on all metadata
 blocks
To: dsterba@suse.cz
Cc: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com, lei lu <llfamsec@gmail.com>
References: <d82bd6cef76e7beaa0d33ef48f9292f3779d015c.1714395805.git.josef@toxicpanda.com>
 <2aec5fb2-f881-416a-b558-cb265886dad7@gmx.com>
 <20240502122722.GP2585@twin.jikos.cz>
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
In-Reply-To: <20240502122722.GP2585@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:27dUS+wDke+Hu6ANQVaRzX961ZFVwuIeRlY9LEipzFgJF8Wt9Gc
 2HlaP649SCy3J2EGhCMt/Q1mF7Q3nTrw8tzXMI/suXQxI/4H2jv9NeJAnVzA2+7daUAIZAC
 Y9UCW7ivFwe2x6IdbAkOnEa8v0IPKbw3quNM3BL9Mf8TtvhLxQ/gTH7GOptvuslAG3E+LY9
 qsUiFVpEJdPHpLD8yQy2A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:g4fbeKWjfJQ=;69+XAWJtAIpajDx9/PrcyyQraBe
 5nzpsUEYunPzprAgMrUJesjPpTEYYjr5Drg61EHk/WtumnTo+b2CAofdYHiCLMwgDCGDUNW8T
 6f91tUo+4C3parlMk0Zhh43sndTiQWbuKp56kHeCP9FKUh5bqMPC5scLgxJYWq7AU1cJ3eXBX
 XfMvjGwMZ1nVx0mZbJMHq8e6LM/J9rLLJ+OTsyyP4OpHtl93/YRLVLJQUCrU6VQFAS3iXickj
 timpHNSqmf6WENuQvrqX16KOXjJERDsy4eM4E60bzhemF4oQ8iIc0OVA0lB+nfrc2ONb0pfrr
 Cl8ymci8AO3DGhqg+SYY1C1GNq8S+WPfn2RlG5WqOOXtCU2cJrQyKGPdxlHcrqp4wJV651R+d
 Clcq1VFCxybHy0Ep1EmaBcAjHSZ2KED4D5canCdWd+J6ZqvpLLgCP62vF+ZRnvoy13WxMTPm3
 iejehi30VS3lDvEVFa9GafI+FrfDMoa007ebrRNdjz7Wntlear/selQwK3Tb7yzZfscD80kzd
 JMl6/YH2toeQV+m92h/6bqAIKJToqkYaSGPky5MDiXFGtXAPsPFPYuJBorMg1jUDVO44KVO2V
 GInWfKBNoow4Qa7Cy6O63Vqxpf+X0RD75WFb8MYWnzFxq8cD2KCyiaJqmtq2Rjnmu1R1+qBY0
 X9Ys+UJoGTGlP8MZK8Xdr1ITRMkA/D4gZJL+xYJ5jVWqk0gKjdfqCr44B8BTonuvPUHgWYLLR
 QxV5nfHRvr+b9EhXVwvQ5RS9+2VdBUA+PvzF3m668NQJw7vrWC3En0VhSuIlCzsqbQR0IOBIk
 Disla+FCLxWQUwOdsReHW4VzP5NFYnbVDyyT213wJ9p3Y=



=E5=9C=A8 2024/5/2 21:57, David Sterba =E5=86=99=E9=81=93:
> On Thu, May 02, 2024 at 07:15:36AM +0930, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/4/29 22:33, Josef Bacik =E5=86=99=E9=81=93:
>>> We previously would call btrfs_check_leaf() if we had the check
>>> integrity code enabled, which meant that we could only run the extende=
d
>>> leaf checks if we had WRITTEN set on the header flags.
>>>
>>> This leaves a gap in our checking, because we could end up with
>>> corruption on disk where WRITTEN isn't set on the leaf, and then the
>>> extended leaf checks don't get run which we rely on to validate all of
>>> the item pointers to make sure we don't access memory outside of the
>>> extent buffer.
>>>
>>> However, since 732fab95abe2 ("btrfs: check-integrity: remove
>>> CONFIG_BTRFS_FS_CHECK_INTEGRITY option") we no longer call
>>> btrfs_check_leaf() from btrfs_mark_buffer_dirty(), which means we only
>>> ever call it on blocks that are being written out, and thus have WRITT=
EN
>>> set, or that are being read in, which should have WRITTEN set.
>>>
>>> Add checks to make sure we have WRITTEN set appropriately, and then ma=
ke
>>> sure __btrfs_check_leaf() always does the item checking.  This will
>>> protect us from file systems that have been corrupted and no longer ha=
ve
>>> WRITTEN set on some of the blocks.
>>>
>>> Reported-by: lei lu <llfamsec@gmail.com>
>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> Is there any real world bug report on this? Or just some code reading
>> exposed this problem?
>
> There is a report.
>
Where?

I searched btrfs ML using this name, but no hit at all.

Thanks,
Qu

