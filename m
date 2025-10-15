Return-Path: <linux-btrfs+bounces-17821-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC95BDD4F1
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 10:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17CF14E1E34
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 08:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD28C2D061B;
	Wed, 15 Oct 2025 08:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="a3beWvzP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62365204F93
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 08:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515653; cv=none; b=aUeOT0b4FCPfBkmWCc7aLMk0uWmtj+tj4idKKEN7nyJjXzX6S/mb3xugRP15cBCrD7PSjCmaiE7d9OFzRei72bTEuMxnuMqU9deefv1yaZOecBflAh93wZ0lcLWF8A8Q1I1z6zoieYWJ8Va/xXR6t/qKu40LbzXn66LFhAo9GvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515653; c=relaxed/simple;
	bh=yM5Oxl99YIcazPjmLgJiaR5IcKiJ66wYRdkZqle4Vxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDkd0YnywiiOdz326CzCadE4dgoQsjcfn67RCGFOcFflybD9qoKSidl/ljxvEy4qn3WqlC1e2TVtSTgGQB58uaDk6KuR/PVNA2AYG2h5wU/goJMjDro+0H7TsmCOANIsKyg7tYh1W9ZtOy1mGBh4a7fy381cNYDYqIvrdw3T3pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=a3beWvzP; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760515645; x=1761120445; i=quwenruo.btrfs@gmx.com;
	bh=zh5CkA6mnFfJADWNd9BczDpFv8JcSWzY/lACY8TBXkk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=a3beWvzP9OdumSyRfS6WpXV58/XOdX2q2eV6ejR9Bo4bmL2ryFDbFHWyw4Aeadc6
	 ytcEmmFPfM4Dzh2KPM3Gj69zvGxgQHkb+uCyMBGZfcT7BjZj9tWZvNljlSFMRHutD
	 665I9lZPC/VRchUbtYKUcXZ4PwhstDNzLaLnU0k0FLnEesYUUHF4b+FbcQLEf3squ
	 M2ITuqBFJD2qM16RaSZsSakEwdRYjtYfIc+iOBu7K4E+6fxLEp0GNx3NQpSBjbCqr
	 0RbCo7x6trW5QzVF/HN9fZagbyIbOS8hw6jLXM6rlgw6a6u4ogGR2n0oxn5VWfRpz
	 Brnz6WUnpDv1Sa6eZg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MK3Vu-1unQby0npm-00KekX; Wed, 15
 Oct 2025 10:07:25 +0200
Message-ID: <eba90c22-8b18-40ea-9e3b-9595b11f6e1c@gmx.com>
Date: Wed, 15 Oct 2025 18:37:19 +1030
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
Cc: wqu@suse.com, linux-btrfs@vger.kernel.org,
 Chris Murphy <lists@colorremedies.com>, David Sterba <dsterba@suse.com>
References: <9606fae20bff6c1fbe14dc7b067f3b333c2a955b.1751847905.git.wqu@suse.com>
 <20251012082355.5226-1-safinaskar@gmail.com>
 <8c3628d5-8fce-45a1-b29c-65c2c52f1c06@gmx.com>
 <CAPnZJGBAGO7bmiuL32YW-nq2Ycqy+EDXtfRhYCiiJX5YGxDWuQ@mail.gmail.com>
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
In-Reply-To: <CAPnZJGBAGO7bmiuL32YW-nq2Ycqy+EDXtfRhYCiiJX5YGxDWuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sQIXUeMmZbUbJJD2QBQynReYY/6vpvA3x0DeIig+VSml94Zz2L5
 9P96X1gzjlhFZgZ3U94ZibyBjGLfSgPeAzti3SbMDdyMyvL16SIg8o0cqsFntkZ4zN+pP9u
 qP7zgHjuzEp2ovQfeEzyiNaZW3eN3c+eIB/L0a9pd3UEfeCNn2AMqCA9aVS3nxqosESKGlU
 rPc7rT+LPLPCSRmAD9hyw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vkNitTeZU38=;1LqhSkSyPhNPqCHdata8+adzHN2
 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
 9nyNj9oOGE3igGGv3e1oarnALA=



=E5=9C=A8 2025/10/15 18:29, Askar Safin =E5=86=99=E9=81=93:
> On Wed, Oct 15, 2025 at 10:00=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.c=
om> wrote:
>> Unfortunately the delay (19s) between the freeze request may not be
>> reduced any further, the current check timing is for each full stripe (=
64K).
>=20
> Personally I'm okay with 19s delay. But less is better, of course.
>=20
>> But you experienced a full 60s, which I can not explain.
>=20
> First systemd tries to freeze unit "user.slice", and then it seems to
> perform kernel sleep:
>=20
> Oct 12 10:54:49 comp wpa_supplicant[1108]: nl80211: deinit
> ifname=3Dwlp0s20f3 disabled_11b_rates=3D0
> Oct 12 10:54:58 comp systemd[1]: NetworkManager-dispatcher.service:
> Deactivated successfully.
> Oct 12 10:55:49 comp systemd-sleep[2191]: Failed to freeze unit
> 'user.slice': Connection timed out
>=20
> systemd tries to freeze that slice and then times out after 60s.
>=20
> And I think that 60s is unacceptable delay.
>=20
>> Please try the attached patch, the idea is still based on the older
>=20
> I will try. Hopefully today. Thank you!
>=20
>> Thus it should still work without freeze_filesystems set to 1.
>=20
> Kernel devs plan to make freeze_filesystems=3D1 default.
> So we should not care about freeze_filesystems=3D0 case at all.
> I'm okay with manually setting it to 1 (and it will be 1 by default anyw=
ay).
> See https://lore.kernel.org/all/20250402-work-freeze-v2-3-6719a97b52ac@k=
ernel.org/
>=20
>> please do not test any relocation yet.
> I don't use relocations. The only operations I use are scrub and trim.
>=20
> Also, I noticed that poweroff takes a lot of time if scrub is running in=
side
> of systemd service. Systemd is unable to properly terminate that service=
.
> Systemd tries a lot of time, then times out, then poweroff reaches
> "systemd-shutdown" stage (which is very late poweroff stage),
> then "systemd-shutdown" again tries to kill "btrfs scrub" and then
> (after lots of time, again) the system finally powers off.

This is another problem, that scrub doesn't check pending signals at=20
all, unlike relocation which does the proper signal check.

If the test patch works for you, I'll send out a series addressing all=20
problems:

- Delay
   By reducing the number of full stripes from 128 to 16 or 8.

- Add extra signal checks

- The suspension fix

Thanks,
Qu
>=20


