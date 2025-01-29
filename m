Return-Path: <linux-btrfs+bounces-11167-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E57A226F8
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2025 00:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5DB3A4B33
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 23:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9923E1B4246;
	Wed, 29 Jan 2025 23:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ArnleZsd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD18CDDCD
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 23:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738193748; cv=none; b=FJHMrAHntsGHlR0Ze6Z/ynF6IrMhIkrXD0wn1S6yepsN38sJZWVNc/hxc9EqMrNWOUbeqiaGlKzy7orGjvs3nw6LqkKYU7JfVAb/tnbsmJTokRQq0gn4bsUIfAF32n3D85TfYIs15xiUku5Qi4dvgaaqtXzr1EXgJBbrH866CAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738193748; c=relaxed/simple;
	bh=p7ANuMlYFF5sakEIBnDJot69SYwY+32ohCBwkhQpFyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jMgEn9kh+f/zUHDih+lSTCBmpeidZYDtbmC4QfFV4SH7M1Wc22euIdTv4ehJeBUeE+NYGFNfe5VaQcFWdF6XPQi1o6GDag5yp6QwLvjR6fhzuCYkrg4PxIuQyiwWRMO0+7njlRSKeErNI/EwH77jJ7SA5JPXvo/liIS4h6SGKiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ArnleZsd; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1738193744; x=1738798544; i=quwenruo.btrfs@gmx.com;
	bh=p7ANuMlYFF5sakEIBnDJot69SYwY+32ohCBwkhQpFyM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ArnleZsdxyLUlxzVPZJKjrpv3Fm7hru430P+JQULR6/VIj1XUsAJh9FJY+Rj4ttX
	 pN82mm0UO2aOcTyRCQCVjSUoe4EGfpL0o29qVo5o79fwwcilzi8BnLHIcWus0GfhL
	 DfgkSmFo3+MtqObHQ/CCCWqjZ8yL1nUpqZ/cyiX3+9r7kArsritft+jO8bjbTvinp
	 i6ZaeMkVMlx/gkgScMovopJ8CfyzhLyQFjJctQV9o7wBPbcA/WmEfuWyyLRNb0H24
	 46aMVQDfeiQHyk3DWRcmkC59dmgc+OgNZ/3taHe1qozVqQmqxT8LRSsTFJW7Zob/E
	 vzCpMhV9HB4jWRHEnA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MS3mt-1u1EF90TCF-00PAE9; Thu, 30
 Jan 2025 00:35:44 +0100
Message-ID: <89fb6391-a2e2-411d-abc2-864f563d680e@gmx.com>
Date: Thu, 30 Jan 2025 10:05:41 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Errors found in extent allocation tree or chunk allocation
To: Nicolas Gnyra <nicolas.gnyra@gmail.com>, linux-btrfs@vger.kernel.org
References: <207033eb-6e59-45f1-9ec5-09e63eaa4c70@gmail.com>
 <f404a687-cd6b-4014-b2fc-0f070f551820@gmx.com>
 <ed415d61-fbb2-4a24-850f-db40052111ff@gmail.com>
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
In-Reply-To: <ed415d61-fbb2-4a24-850f-db40052111ff@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3Dub0jdg4KQj1ii92L0MKWLCfTzMoz7l0Bg9PJvz6lLJu8DmiVe
 dGoH21vm4mYo53WWz5vqtaD78R1ysd2ZiVQ2O84qCMA+Uoo/X6f0L9URSCXP9ZABq4xUawz
 5p0la8emC4GITBMTpb14CPugLXmxDdjYkYZgNvvZqCZkLKaj2AgAA48kL4WpKsaalsFK+zG
 Xb4VojDENKj+d3AAQkriA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ej2qxsl8DJY=;VD/ktlBj+BSdRF/gs5RN3xV96ME
 7hhUbjqTqZcNjjtBFM3OVU8hnHrDReZZlXdscaxmC7P0F+D6Uu8coC4v7x2xaZ5P08onv4t36
 eWBuYW/nWM1exWyKxF7oLUV/XfwPF0iIIVcwMOobj45huP3vrca3PKr8VVTSorBNM+zTU1TXB
 9s4c4GPCM5BwfpMaP1tkrKTKQORa0dNCGZOD0PN83c9p2e5gmbgl+Wvnn9Uv/3M456KlQgEKT
 GrDX/OApzf/VnNO8EpAgMhPK7SQrfyBetcaCdLMpLEm8a8ya65U2ROYb5d/f7Czqxi1tijF8c
 PPV3XYukyXszynxs9Umk9fFw/ROE1FyBuaNAiADbTbaDjNDFOQHUZWMtSLI76+zuJMejvOQD1
 am+MTinowaq/RjhUEhFDGLUU8qH6cYibTg7ooaHOcBCAzsm4olJT1dl6NjLzzqaqKARRvlc1h
 G0UFl1yuHTRrqaIwQU1jdKW/sIfppXjHR9s3tNBUbynOA3Z6+tMHSC/qJUZ3wO077AZVRhVvi
 V9shyY+Mv9mWBpHTWMnSvYkhtWkvtrVVMhr4UvfRSJ3nEhyrFEt+Ukl+0Hjwc/gGag3tOsGAV
 jtGV0OZ09JcFle3bIcBLK26DzyxSxW6KgbtOHOk+WFWdd/gHbXbYD/1vL/t7vh7D7vPyQFIDL
 nBfg4UZkcfgWAg50QwIUROm+gnVBWaterdjfJ9LcDtHGnjXXYwiySBNy0SpE6LMGPYhnQJ9ai
 NOds32itq7E+v3I8XelF8/MzW4rUWjJEHSDw+uJOyJ2CPEkovd+Xj17G95tZ3GVScY72pddeF
 TWOqsOrOUlQE/f/YvLkbYEoT9wuyDTIA2GcAIw1clPwhvKZMl+AyY7SeLzeWnhj0mumSW1c75
 Ghuf6c/xEtI9Ni2Kk0QC7Zc4RtF1+WklvAcigzxa0NmbdNQ/vDk/QWVL/4/TexP2nlivbqSei
 avhvrATxJS9BSwLrfz6zzs/jqapA0ahYCIvq67RDYEkLmRR3TARXsakJKpNFLfIYYii4Tpq9A
 bokvg1B7S2g8rsXTc/Ce5vd9AuSQ2z4xcLQe9xPldJ2X8z5IwzciqAPkU2WE3ZAnjTQ7kAxqZ
 RUKXInyeNDR8u/ISBFJKCECMU7fx5cOZTKLEl0TNmMCteIuBS4DovIg/YbVic4hAdymVR+MvV
 79RGW5TevuJweJpOZENyJgeyvogoWdm4RAYVEV82mqw==



=E5=9C=A8 2025/1/30 06:03, Nicolas Gnyra =E5=86=99=E9=81=93:
> Le 2024-12-03 =C3=A0 21:50, Qu Wenruo a =C3=A9crit=C2=A0:
>>
>>
>> =E5=9C=A8 2024/12/4 10:32, Nicolas Gnyra =E5=86=99=E9=81=93:
>>> Hi all,
>>>
>>> I seem to have messed up my btrfs filesystem after adding a new (3rd)
>>> drive and running `btrfs balance start -dconvert=3Draid5 -
>>> mconvert=3Draid1c3 /path/to/mount`. It ran for a while and I thought i=
t
>>> had finished successfully but after a reboot it's stuck mounting as
>>> read-only. I seemingly am able to mount it as read/write if I add `-o
>>> skip_balance` but if I try to write to it, it locks up again. I manage=
d
>>> to run a scrub in this state but it found no errors.
>>>
>>> Kernel logs: https://pastebin.com/Cs06sNnr (drives sdb, sdc, and sdd,
>>> UUID dfa2779b-b7d1-4658-89f7-dabe494e67c8)
>>
>> The dmesg shows the problem very straightforward:
>>
>> =C2=A0=C2=A0 item 166 key (25870311358464 168 2113536) itemoff 10091 it=
emsize 50
>> =C2=A0=C2=A0=C2=A0=C2=A0 extent refs 1 gen 84178 flags 1
>> =C2=A0=C2=A0=C2=A0=C2=A0 ref#0: shared data backref parent 323991265280=
00 count 0 <<<
>> =C2=A0=C2=A0=C2=A0=C2=A0 ref#1: shared data backref parent 318089737175=
04 count 1
>>
>> Notice the count number, it should never be 0, as if one ref goes zero
>> it should be removed from the extent item.
>>
>> I believe the correct value should just be 1, and 0 -> 1 is also
>> possibly an indicator of hardware runtime bitflip.
>>
>> This is a new corner case we have never seen, thus I'll send a new patc=
h
>> to handle such case in tree-checker.
>>
>>> `btrfs check`: https://pastebin.com/7SJZS3Yv
>>> `btrfs check --repair` (ran after a discussion in Libera Chat, failed)=
:
>>> https://pastebin.com/BGLSx6GM
>>
>> In theory, btrfs should be able to repair this particular error,
>> but the error message seems to indicate ENOSPC, meaning there is not
>> enough space for metadata at least.
>
> I finally had some time to try out a version of the kernel with your fix
> (built locally from commit 0afd22092df4d3473569c197e317f91face7e51b) and
> I can now see the modified error message (see new dmesg contents:
> https://pastebin.com/t7J5TJ0Z). Unfortunately, apart from that,
> behaviour seems to be identical to before. `btrfs check --repair` still
> fails in the exact same way. Is this expected? For some reason I had
> assumed your change would fix it, but I had forgotten this mention of
> ENOSPC so is there any chance of getting back into a writable state or
> should I just reformat the drives?

For the ENOSPC problem, please provide `btrfs fi usage` output for the
mount fs.

I believe with the ENOSPC problem resolved, we can let btrfs check
=2D-repair to fix the problem.

Thanks,
Qu

>
>>> I'm currently running btrfs-progs v6.12 but the balance was originally
>>> run on v5.10.1. Is there any way to recover from this or should I just
>>> nuke the filesystem and restart from scratch? There's nothing super
>>> important on there, it's just going to be annoying to restore from a
>>> backup, and I thought it'd be interesting to try to figure out what
>>> happened here.
>>
>> Recommended to run a full memtest before doing anything, just to verify
>> if it's really a hardware bitflip.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Thanks!
>>>
>>
>


