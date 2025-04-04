Return-Path: <linux-btrfs+bounces-12807-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB78A7C5B7
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 23:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FDF93BA0D4
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 21:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B976B218ABA;
	Fri,  4 Apr 2025 21:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="PWynbpQO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC72182BC
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743802897; cv=none; b=CLqj14qD0YDvxaVGVUN+okkEbYqMphw8snvki6b0OdOW+oN0WHV/VQ5UJoOGb60Ml+Ss/0nHWU1vh33RuYAT6mCngyxLJG7hrszWiI0xcUWQ75+EerUL5AOSp9D8jrZFuVGdghaQbvCWofBBks2RyXi5KLzJ2ixjdMBh4Gzq66E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743802897; c=relaxed/simple;
	bh=bhEGOvo9rHSkW3Q0cn3jMgVm8jC67TdcgM8Vg8vStA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f+UEL8Nej4O2hbSPCHtnA14fXeMz/pbQ/T1Fnyxif0RiVTzpTwrZsXOjRAU+a76IuY646j/3K7+1RQ0QdVvJoCs1glmYn7Rmbzo5E306AVcc8YhCifjPJuzrY/dsXPOo5IdL2XbNBQfIxPeOkCzShjhdMJ3N/v0lGoGBDwlxOsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=PWynbpQO; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1743802892; x=1744407692; i=quwenruo.btrfs@gmx.com;
	bh=bhEGOvo9rHSkW3Q0cn3jMgVm8jC67TdcgM8Vg8vStA0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PWynbpQOVc7eElj7lOnIRF55iO4xWax7AEhN93cJyT9Hqs/YSPmWuRa2paVD8WV6
	 CtqL8utWdVKQvfe+HJwkmjjQoJboOxD+btHdT7XB/gQIIIBWO+OZPsTlcNWM7OhS3
	 1x3TfsSAul9uLCQWa03xYGPG4f7fa/pU2Na7uugHi31Chb6+RUWew4X+uFCPDtk6H
	 PrxbFO3E7qz3LWqN7v8NLJxi20i2P2Wpo2bKMqFvNUwifwrADv4zfw08069ohB3qF
	 1X/4MARtwUaWNmVZ5Cw6g7VLsIbI3OafekA+gtnsFcAaXsdUD5n78/T9xMd/fhmOI
	 pz4FJOSF8T3lJiq44w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1wll-1t3oKA46zh-0106qd; Fri, 04
 Apr 2025 23:41:32 +0200
Message-ID: <29339223-1c02-4617-9013-66f4c1754d7a@gmx.com>
Date: Sat, 5 Apr 2025 08:11:29 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mount compress=zstd leaves files uncompressed, that used to
 compress well with before
To: Dimitrios Apostolou <jimis@gmx.net>
Cc: linux-btrfs@vger.kernel.org
References: <2f70d8f3-2a68-1498-a6ce-63a11f3520e3@gmx.net>
 <d1c2f041-f4f5-9dad-511c-117ed8704565@gmx.net>
 <8aaba46c-f6d5-4f3a-a029-f564b8a6a9ff@wiesinger.com>
 <2858a386-0e8c-51a6-0d8a-ace78eced584@gmx.net>
 <2b33bf94-ec1d-4825-834d-67f4083ea306@gmx.com>
 <ba2a850f-6697-7555-baa4-32bc6bf62f81@gmx.net>
 <b9f7b83d-5efa-4906-9df3-a27f399162fb@gmx.com>
 <d6abe471-8144-3f13-1002-d55cf7d3e672@gmx.net>
 <939a6f4a-837b-4613-8761-b03f8d4809ea@gmx.com>
 <b338d808-f691-9969-9e48-d4a9f0363af3@gmx.net>
 <61996eb1-de0d-4d9c-b1cc-b24145985d38@gmx.com>
 <5c7978e6-ba04-9aaf-e32c-788f1607254a@gmx.net>
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
In-Reply-To: <5c7978e6-ba04-9aaf-e32c-788f1607254a@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sO1bfzIf80Uh1p9hdm+0pd2zeWRUjv1JFJu7CAOkyxNIpm20k8Z
 nnynl+kdrX9JSBb3lbxhbq7nNzxU5suLTIWgpA8QTVJtne73uznNgEVF4qiZzmRk5Ao0ncO
 4jaToR+Wmy2rrjUCnXmRVFcrKrWPE0uhyRA/wwrD5lAhZmN6KaMfGtuA031AmoZirUUnHVd
 YxFPyKZqPwpw9FjERz1ZA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qkDgRrL7YNU=;XIA/EN5P9t9uTCayhbu+KNOtF4f
 oHkkdw1yJMKJ7Ub3I1s13qAnxORkuUuMwXz8W1rvx665kVDxAitHB5l0GIIKvFeht7/5Zc6gj
 e+q65/PT8z/VxcVyc/nPjWF2ab4FEPvFROV4Fh/U/Z6OE4/QjCe/jjUG7vlZG2lp+58kANsIw
 kKlhEb109ljLRCHCVkyR6evy/XdrhAF3ZHSrVBp+OPXXZUhrQ8A8dCS7KvhB9xsrJ7HwjRato
 rOdtxk5ZJBi1dWQo6yWKg1Wbw3d1dY12qw52oIthC4nAH9ZnZ6PzyLtQ+w3IoAPs2YBvHQGXk
 1X0fq4xTYvVfwK8iVzvuv4kA+3b2QLQs3EgrbIEUloqtzvCP8ys/3KZbAPUfx9j+UGGOhxw95
 ib6a2Fap6+570gebkVJydOHKSrfx7q5FUbSYkMB71mf991i1wrObSlA0hgkdVkgH6v2bQ5Sab
 ufbJMdAK/btWdQtdYtiT1A+IRsiIt5C4neWg2TivrVHfP43alilRL7yzzg0lTdeh/Cy9nL65T
 iXv4kvmNjFJKfCu2msKple+XkR/rSGLLvJBl8P5+Z3N1hJqZKS8BeQebUYOCky7SAONlLr0cy
 DEEg2tnIvqarvv14+Uo8rBgDkLyRZSJaiTaSGtyCWih4pQHwDlIw3JmUHrbm7henPVFeyQ3NR
 IOFuhSDzUzw0SUeb358QCVsujfdkzYKvEaQmCG3u+2Cvxt4VjKok8UrCddaY1TCpeREXe3wxI
 D5mj8yfOUFGm64vYncPl/d5JeVM4lHcgvLeLYAWLPlvuojw6xbEzi7roa7yD7zcx1uYR+NhMg
 Nl55KSu/qrV6dGer5Q0fgxy1lGyrA2cBalQuXvmtk5FiVfzeEBEGS+YOJ8uqgSvTmvFOqThCE
 r5kNFD/V36M+OznHB+nJw7EhcfnpFQYyf6SNJWtLlVCEekhyB/8ob6+jPWgwhJIRMS3auRVgQ
 x56lIO52AxTQ/sdF/2VW+ISU35ZIzP2SZGdUQrfuDlhwo0dqjO/IAuZBHQ1tIA6B3yDNWWAk5
 Frh60SA7+I5IAODqx6sxpYbzk0VDz1aQDDupbiJRKPbKWRQUFaDJVkgXwzYJ+fJ/z8cJ2h+pF
 PA10uP3Lh8hkYM34oAfyiQpowDqBVLDakVWOFr/J12objwXKSfhDYhkInJvYn+2IJMfIFuzou
 V5+2kRVAD1rPqVkUagiSMP/qc1m43p4vIAO0n+cvBiTxvr/vTBQtz009qeFaNLZH2KvD6H+y4
 0JmcIJv0S6pjBZJu6H2p1QaW67NqdCO5qnJ0z39nWbVNIEl/3dChNRA/Xsyu8LnTxxMTIqp5D
 BkYUWPx+EiTW/Rvqc8+FTCaIalbBoCAjYDywsUAVBWtTRRIi8HvMDqXMdMQU8olK1NLSd0nJH
 aKms7yOYA2uoDnopotWhgFZQMfb8HwvRNQfX0tZGn63/htmUcBakSRoxp7I5w/cc3au7EZc36
 r7cwT1A==



=E5=9C=A8 2025/4/5 03:47, Dimitrios Apostolou =E5=86=99=E9=81=93:
> On Fri, 4 Apr 2025, Qu Wenruo wrote:
>>
>> Looks good to me.
>>
>> Feel free to submit a github PR or both patches to the mailing list for
>> more review.
>
> Forgive my ignorance but I thought I did what was needed. I notice now
> that maybe the subject is wrong. Do I just send an email with the same
> attachments and [PATCH] in the subject?

Oh I mean using git-send-email to send the patches to the mailing list,
that's the common way we do the review in the mailing list.

Some examples:

https://lore.kernel.org/linux-btrfs/cover.1740542229.git.wqu@suse.com/

Although it means you have to setup your mail box to allow SMTP access.

Thus the other solution is to send a PR through github.

Thanks,
Qu

>
> Thanks,
> Dimitris
>


