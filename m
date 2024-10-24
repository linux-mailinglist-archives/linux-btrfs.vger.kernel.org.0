Return-Path: <linux-btrfs+bounces-9151-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A789AF399
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 22:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290E81F22E5B
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 20:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F28A1AF0BD;
	Thu, 24 Oct 2024 20:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="th087d+A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AE0189F5E;
	Thu, 24 Oct 2024 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729801518; cv=none; b=RJJJubKC7dJloHF28uVYTOSSkIXE8TFlicZSzGweOd08QfBy2lCP87PFgSt+3VZ4/IiYIgyEBYUDGNyJ5BN4eODB+RP7ngr/1uu4IG62Qp3820IPfZO8y/EQIzrMk5R9a15Uhluw9Ds/e4RtBYZXgg2gTfnpt3pzay9ZjSIpT10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729801518; c=relaxed/simple;
	bh=La21tBVjLa1/xxZFgH8ZzqJFmzWy1Hln3A0pQrcqvgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ECuoyXxDGtTH1nA3F7X27USsjFS3vRPwxMWXDjF4NrrsgmP8MhhqfxWiYK7LDtIiLX9QWc66y2UpIAgGyBZOMWys+ZYazttNb62HSgUXqogG1fwqMFQ3ZDPJJ9fhmhkxxT0tcszGOpSXnWF6jnCzWldNqfZaF+zNqTVdUdr7EB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=th087d+A; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1729801502; x=1730406302; i=quwenruo.btrfs@gmx.com;
	bh=/NglWPGw0mNcKaztItWa7SEYWxOn0yAq0XOHdKj1BKg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=th087d+AjUHM08wGjdfQ1eN2Zo2nHc8UqUxzbiSKiNyWy8VhjzWqKQN/av/JMxGZ
	 FJbH+DEw6cweSQvKBiJElfan2p2I6a5glGIzz6QzFaZgarvoL1uN+qrYTN6jLaMRV
	 6Q8ZctWaInYUx47TRpybm7CzljFAdZYcBmkQFaICtxlN+MrvPx7aOjlg3vRf93hmK
	 MXn2WSpnMlOs090MH8/uvk0K9n61aXYk/i820C/IDMUcfpYI35fW60SLldOLFU98K
	 yeb9KUiOrIqeetHmHjHSJbH9RCCjvA+IZBVwd0Q3jP9Vm/O+tk5xx//n5bQNJEvWT
	 CFAFZz42eNT4I29UJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mel81-1teV4K3XTJ-00jqMt; Thu, 24
 Oct 2024 22:25:02 +0200
Message-ID: <b9f57b0a-3b31-4b66-b975-eb974323cec7@gmx.com>
Date: Fri, 25 Oct 2024 06:54:57 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: avoid deadlock when reading a partial uptodate
 folio
To: Zorro Lang <zlang@redhat.com>, Qu Wenruo <wqu@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org,
 zlang@kernel.org, fstests@vger.kernel.org
References: <62bf73ada7be2888d45a787c2b6fd252103a5d25.1729725088.git.wqu@suse.com>
 <ZxnXtI_6HCwvCvLT@infradead.org>
 <d373ef6a-956e-4319-ad2c-36f67a887a58@suse.com>
 <ZxnaqgJrYFjGxPEn@infradead.org>
 <20241024132003.64sxshdq4qh6fnwu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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
In-Reply-To: <20241024132003.64sxshdq4qh6fnwu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SBb6uUvEg4WKOC0uOv5b0+mu86DT3ndwy+WoIcStTf1iFR2XgoI
 +gLy6IztqS/FkCr/W+QheeCNqBqshwJ3DUDv3r2ERUGB+gq1KJfivxZEGEawT2IiPWHD2FA
 GnYZjbRF/5a4InVTka34+PEauQtZTuR4fRcGcQwrNqLV8h3gUXd34cF2P16Ry7c+Wo1TEpl
 N5o5x2Vnn9DFS8IrE0sYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tXDqCRYyDro=;rbVId/IrEYSIRZdp/3rtn4UKs6b
 0EU5OWKuYstRb9WIGSKaVV4oKhML3KE6VMxVZBlr1upIVptbcIYGiSyZsyE4ij5wCqqV1d3QR
 u+HvevRgRliWoO1lIQjRa/srbQ2NrMw8HXvODngCqP/VGLMo/hH/+4t6cuj02RpkN5rDVFSXi
 DMl1L30ud/2c4loCcytQFaIl91v4HKJ67sI1VgtAW88qg2/lF5MXeRZolzkJhno/mpoZYjEoT
 Ju2tcZELyYHsAA7Fs592Uxf0MfC06FxmjNM0eZLdydenQJlt6Jn2qCR2DFhmKX/4iu2d2grwr
 DAU+t6PwTm7t1Pjqki49Oi0DN49GKlHXj2LjcB+3b380eCAi1U1eCoKPx9W8Q6DP3ulboR1Ya
 41YgQ+7W6lNOCcO3cyIWnFNPlnTF9d/9Xgr75i4HmfgSL9JZTraaet7qngTIxKBa+i+bGbriK
 vU4J5sfgJvT5o/oJJFBvCPtpJ5vVoFWYbFGRW03t0a9V8stZBYgEDCc/dviiSgAtccfbz3alm
 R4/+p7NwzJMMYsdJJ0JqqCkk1IeEwL4ZEzCjMm7f0e+bcisbD8MzeEuQMXeChreXaceK9Xk7z
 sKME9dPE7aSjEs4ZBRK0fsme5W4YRwA0WvMI1BloYrAsRd3bJd1p+LdxPM0UnP689Nj76Tk7c
 828CYQkogZ5u9B0IV9t3zpLFXE1JwbR8t/sCRoIoXwEx7+kosJRVZE/rqYCDv4vwFN5zRBIb4
 jIzgJO4S7op9zEg2vYtCGyaBgJJaKJvBuzUkqrecbaDq5kez3ffQ0m3XLlucaTadun/wBkj1z
 CItZIDjKJBrYrQZtXBRSQdPQ==



=E5=9C=A8 2024/10/24 23:50, Zorro Lang =E5=86=99=E9=81=93:
> On Wed, Oct 23, 2024 at 10:27:06PM -0700, Christoph Hellwig wrote:
>> On Thu, Oct 24, 2024 at 03:54:54PM +1030, Qu Wenruo wrote:
>>> And generic/095 has a much higher chance to trigger it than the minima=
l one.
>>> The minimal one is only easier to debug and faster to finish one run.
>>>
>>> Do I still need to add the minimal one to fstests?
>>
>> If I have bug with a well known isolated reproducer I love
>> having it in xfstests.  I don't know if everyone agrees, though.
>
> generic/095 isn't a specific test case for a known issue, it's a common =
test case.
> If you want to have a reproducer for a particular bug, feel free add it =
to xfstests,
> mark _fixed_by_xxxx and describe more details about that bug in the test=
 case.
> If one day we update g/095, it might not cover the bug you need. Then a =
specific
> regression test case will help.

Thanks for the advice, this answers the uncertainty pretty well.

I'll add a dedicated generic test case for it.

Thanks,
Qu
>
> Thanks,
> Zorro
>
>>
>>
>
>


