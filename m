Return-Path: <linux-btrfs+bounces-17882-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE6DBE27AA
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 11:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 166003A5761
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 09:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775F927E076;
	Thu, 16 Oct 2025 09:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="seymZ7QI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55CE22A813
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 09:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607987; cv=none; b=oTe7eNpy/+BJrz2wEEH7A8O6lD5NJlzXULn1fwFcR5GHA0jxvko3uSkwDYQkKTd7pKOyJ+BkeaymrxxcpQUbdjewMJXrHvoAfo9DXRFpNyxgjORKT0A8Pi3g2w6EhabrsDYv9suZCkRVb+kSk6pTRUQWa2dWtOPJj7WNB/+lnog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607987; c=relaxed/simple;
	bh=zkvDWjUw3IZyYHlLggCiaKfUg9v1RukjEVwM8OcX0Ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zmh2chyFI3Tth33ZouiJxnWgsVbtauEihzYCqcog/DOTvVvNZZxqtyxaNF3d1qPpWrur5DKi4CkfV4gidqNeYttO2yDy7eYIW11WdxWPFFqKkW4jnh/jASer8yi8KEVa81b45JMl6y/kt3mSdfzYHobn5iMMzZYCAcYRZBiA3ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=seymZ7QI; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760607979; x=1761212779; i=quwenruo.btrfs@gmx.com;
	bh=zkvDWjUw3IZyYHlLggCiaKfUg9v1RukjEVwM8OcX0Ps=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=seymZ7QIakEcLK7y8fNmChkH2QOXEHKgZvo3f7+Jn1pmqxQ6yey53GtwXb40iHdM
	 aKOuh2fsuTbtPCHHxEcOtklWkO1gx+inj9GuMYBpqcJdLI6hgtE0g3DtrxORMq6Sd
	 8+jwlMBfc0MhNSndJMpKW/YifYow8quQycQfZrwEPhuzeoP2AD+JzRvv7L1bAnAwn
	 SAFQ4nrU6eBib0FDafAwQicQQo4fXlD5cV808bZiSt4C36gNWv0sbeDr3jBq4RZ84
	 igTmJf8TTqdFJGZ3LCbnnVuqo1O5I+TSgVjp63rH/CuoR04ySB3U+s6lRhiMNs+Gq
	 ZSorTP2oi55qPdpTjA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MPXdC-1unvnU1yIE-00UBaD; Thu, 16
 Oct 2025 11:46:18 +0200
Message-ID: <4722abf1-bec9-45ed-bfde-6322088e0622@gmx.com>
Date: Thu, 16 Oct 2025 20:16:15 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] btrfs: exit scrub and balance early if the fs is
 being frozen
To: Askar Safin <safinaskar@gmail.com>
Cc: dsterba@suse.com, linux-btrfs@vger.kernel.org, lists@colorremedies.com,
 wqu@suse.com
References: <8c3628d5-8fce-45a1-b29c-65c2c52f1c06@gmx.com>
 <20251015111217.5538-1-safinaskar@gmail.com>
 <5517a3cd-1afa-4db0-bf8b-439f3ba410ed@gmx.com>
 <CAPnZJGC3Yt5E-+ShxVW2CcmAZAZ8ivbYGRkJ7g0v9O_09OH1Og@mail.gmail.com>
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
In-Reply-To: <CAPnZJGC3Yt5E-+ShxVW2CcmAZAZ8ivbYGRkJ7g0v9O_09OH1Og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w6mdMnEq5p2pN7AL4KlA8T1lBKK8ov6gH2nkJ9i1CpNdOnoo9aX
 S4r0VuPS3ZLoEF8u86NDPohMa3r8+OSJFVeC3rbe1JlpKWfVFeeP1Ol3DJ+poTuSlkxPbfM
 t4KIuMQxpC6OUd1oFkLKLihzBnYneC7uH1CdLd4cR5lLglp4funJZdQmAWMOb5L9J+9+qNx
 ig7dgpq6iB8Ib4guhOTvw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mzBFQmOCxzg=;PjXsDdRRgck3fdLnkHk2MhOR0oo
 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



=E5=9C=A8 2025/10/16 19:10, Askar Safin =E5=86=99=E9=81=93:
> On Thu, Oct 16, 2025 at 2:01=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
>> I guess the difference is in the systemd's handling of user slice.
>=20
> As well as I understand, systemd first freezes user slice using
> cgroup freezer, then performs kernel suspend (which freezes
> everything). I'm not even sure that these two terms "freeze" are
> the same thing.
>=20
>> Anyway, mind to test the attached newer patch?
>=20
> I tested it.
>=20
> in-win freeze_filesystems=3D0 - suspends instantly
> in-win freeze_filesystems=3D1 - suspends instantly
> as-a-service freeze_filesystems=3D0 - suspends instantly
> as-a-service freeze_filesystems=3D1 - suspends instantly
>=20
> Also, "btrfs scrub" terminates when it gets INT, TERM, HUP or KILL.
>=20
> Also, system powers off instantly both when scrub is in a window
> and when it is run as a service.
>=20
> Great patch, thank you!
>=20
> Tested-By: Askar Safin <safinaskar@gmail.com>

Thanks a lot!

Although you may want to add your tested-by tag to the formal patchset her=
e:

https://lore.kernel.org/linux-btrfs/cover.1760607566.git.wqu@suse.com/

So that I can add your tags at merge time.

Thanks,
Qu

>=20


