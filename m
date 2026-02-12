Return-Path: <linux-btrfs+bounces-21656-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4O0XJAJZjmn2BgEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21656-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 23:49:38 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7E713199F
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 23:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9902A3108A6B
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 22:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C512E36F3;
	Thu, 12 Feb 2026 22:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="orhl4yU/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C382609CC;
	Thu, 12 Feb 2026 22:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770936508; cv=none; b=EsnUGY6AEsFl63tZWfwId3rwoSQY1YUpOez8DfMgAIEK4qb3BaQq15fvfplfzSkDlIuzdCH7nUvPlPi0NJ0AEV0yOJ+ml7dnl2fwQv5vlwkFLCRMhJ+80L8JpSaf4ZAjvqDZY7CO05egpe7ymIH3ez2K8rfiRRLGmymuNVIyAjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770936508; c=relaxed/simple;
	bh=ozystt88+f1frcwH2JDB47xX8GZmG0gavjKYBLxAle8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T6ftQazfN0j3AN+ENqg+c74h19mP6tzWCImRMvs+HkGZJknjPfXanupqYH83ROR9QL8V2hDGhEfp1rfdR+Xoy1VMTzlVl7Aym2ZuNECmKiiIGP+d5bFYIKvTrIP2dUiU4jbyxvrOOawsiJQALA9Rt4KHL4FCuAEmoUFSr8LoSm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=orhl4yU/; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1770936497; x=1771541297; i=quwenruo.btrfs@gmx.com;
	bh=KcdcOXwvLdT4eQ5fULIc8Wrbh1pVJzHj4tP2eI5Aay4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=orhl4yU/+GsRtNhoLg9rMa84qdHUYdCg6kLCwLBFvqkiTTSL/hyJcPIBoYC5cD5x
	 BHXPbCfmbi+jF9SE8qVrtNrX8rYlZvFi2PmasRpGN5tuzR9pI4XEZ1tzqhgkzPHou
	 toZZMpF8IAEiT7DACb4q6SuxhR1Xhs1bx+NFcrwLueqFNPPv03bqGv8boDgTelOlq
	 +DWjP0okh3qMU99BcpFA6TeS06wU8dwhBKdhpTjz7mEkfMdu22ffWXR3glSAy78GS
	 K5dy2FomR1ecQGXTEO/HSpj1t3qO+gGbAwh50VHfugQcqYscoB8rmeoAPOWb/MQK9
	 yuosnluDar/6lK0Dtw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mt757-1vXCmi23Jp-017FtM; Thu, 12
 Feb 2026 23:48:17 +0100
Message-ID: <1ccd1b09-3a08-4cb0-8155-2cd4ac21c640@gmx.com>
Date: Fri, 13 Feb 2026 09:18:08 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Orange PI 5 MAX: very unstable using kernel 6.19.0 and 6.18.10,
 6.18.9 perfectly stable
To: David Arendt <admin@prnet.org>, Qu Wenruo <wqu@suse.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-rockchip@lists.infradead.org,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <8ebe4d76-eb07-499b-b140-1f300c1b8d7e@prnet.org>
 <f95f0d27-5bee-4363-b0f0-75e95b2a470d@suse.com>
 <de166323-bb9d-4240-bc42-08ae32067284@prnet.org>
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
In-Reply-To: <de166323-bb9d-4240-bc42-08ae32067284@prnet.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mF8n7gocTdDn6xj/wagTIl5mzrMsdkDzn0qeZ6tcAZsALG8Dmrm
 /0MPjCSTnRhXwtXFdCsp13IdE8F30Cher4rawc3enuYJKfiLDXHYg1SLsDHn5A/iniz086o
 4tIAUMYb93q+iVJxIVwgjuOEmy2RPFEVFd1MIWIsR/ki/LexPh9KJ+jOETwEIFk8xM+cxcb
 w3ch/dX+qm4yGQL34OwBg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fvczc4PDltY=;b8Iw0yv5X2dYudu3cXbivPguQlJ
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21656-lists,linux-btrfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmx.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE7E713199F
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/13 08:53, David Arendt =E5=86=99=E9=81=93:
> On 2/12/26 10:05 PM, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2026/2/13 06:41, David Arendt =E5=86=99=E9=81=93:
>>> Hello,
>>>
>>> I am using a Kubernetes Cluster with 3 Orange PI5 MAX nodes. The data=
=20
>>> is stored using a btrfs filesystem as backend. If using kernel 6.19.0=
=20
>>> or kernel 6.18.10 I have experienced many crashes during high IO load=
=20
>>> on all 3 nodes. Reverting back to 6.18.9 solves the problems=20
>>> completely. Unfortunately the crashes are spontaneous reboots without=
=20
>>> leaving a trace in any logfile, so I have no stacktrace of them.=20
>>> After the crashes I have sometimes incorrect btrfs csums for a file=20
>>> but these may also be a result of a partial write due to the crash.=20
>>> On one node I had a btrfs error logged without crashing, but I am not=
=20
>>> sure if this is the root cause or a result of a prior crash. A scrub=
=20
>>> after reboot returned no error with 6.19.0.
>>
>> The offending tree dump items are:
>>
>> Feb 10 13:31:07 opi02 kernel:=C2=A0 item 92 key (13218356101120
>> Feb 10 13:31:07 opi02 kernel:=C2=A0 item 93 key (13216208642048
>> Feb 10 13:31:07 opi02 kernel:=C2=A0 item 94 key (13218356162560
>>
>> Obviously item 93 is smaller than all its previous and next item keys.
>>
>> hex(13218356101120) =3D 0xc05a36b8000
>> hex(13216208642048) =3D 0xc05236be000
>> hex(13218356162560) =3D 0xc05a36c7000
>>
>> It looks like something fliped, "0xc05a3" -> "0xc0523"
>>
>> 0xa -> 0x2 is exactly one bit flipped.
>>
>> So either the memory hardware has something wrong and resulting a=20
>> sticking bit (always 0), or there is something inside the kernel=20
>> touching memory it shouldn't.
>>
>> And this exactly matches the symptom, changing random bit of your=20
>> kernel, crash always expected.
>>
>>
>> Can you run a memtest to make sure it is not hardware problems first?
>=20
> Hello,
>=20
> I don't know of anything like memtest86 for the arm64 platform for=20
> testing the whole memory, so I used the user space memtester to check=20
> the 14G of unused ram on all 3 machines while using kernel 6.18.10.
>=20
> Here is the result of the first iteration (same on every machine):
>=20
> memtester version 4.7.1 (64-bit)
> Copyright (C) 2001-2024 Charles Cazabon.
> Licensed under the GNU General Public License version 2 (only).
>=20
> pagesize is 4096
> pagesizemask is 0xfffffffffffff000
> want 14000MB (14680064000 bytes)
> got=C2=A0 14000MB (14680064000 bytes), trying mlock ...locked.
> Loop 1:
>  =C2=A0 Stuck Address=C2=A0 =C2=A0 =C2=A0 =C2=A0: ok
>  =C2=A0 Random Value=C2=A0 =C2=A0 =C2=A0 =C2=A0 : ok
>  =C2=A0 Compare XOR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: ok
>  =C2=A0 Compare SUB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: ok
>  =C2=A0 Compare MUL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: ok
>  =C2=A0 Compare DIV=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: ok
>  =C2=A0 Compare OR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : ok
>  =C2=A0 Compare AND=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: ok
>  =C2=A0 Sequential Increment: ok
>  =C2=A0 Solid Bits=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : ok
>  =C2=A0 Block Sequential=C2=A0 =C2=A0 : ok
>  =C2=A0 Checkerboard=C2=A0 =C2=A0 =C2=A0 =C2=A0 : ok
>  =C2=A0 Bit Spread=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : ok
>  =C2=A0 Bit Flip=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : ok
>  =C2=A0 Walking Ones=C2=A0 =C2=A0 =C2=A0 =C2=A0 : ok
>  =C2=A0 Walking Zeroes=C2=A0 =C2=A0 =C2=A0 : ok
>=20
> I don't think it is hardware a failure as it is happening on 3 different=
=20
> machines. Crashes occur somewhere between 30 minutes and 12 hours on all=
=20
> 3 machines that have been running without a single crash for more than a=
=20
> year now with older kernel versions including 4 days with 6.18.9 and all=
=20
> version from 6.18.0 to 6.18.9, so it seems to be caused by something=20
> that has changed between 6.18.9 and 6.18.10.

Then I'm afraid you have to try bisecting.

On the other hand, I also have a arm64 board (Orion O6) as a VM host.
The testing arm64 VM is running a kernel very close to v6.19.0, but=20
never hit such a crash/corruption.

So I'm wondering it may be some driver, specific to RK3588, that is=20
corrupting memory randomly that caused the problem.

In the past (several years ago), we had amd sfh driver causing random=20
corruptions in x86_64, and led to the exactly same problem (random=20
crash, btrfs corruption detected etc).
So I guess it can be the same situation.

Thanks,
Qu

>=20
> Thanks,
>=20
> David Arendt
>=20
>>
>> Thanks,
>> Qu
>>
>>
>>>
>>> Unfortunately I don't have more information at the moment.
>>>
>>> Thanks in advance,
>>>
>>> David Arendt
>>>
>>>
>>
>=20
>=20


