Return-Path: <linux-btrfs+bounces-9999-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A239DFC6B
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 09:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9806B2126D
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 08:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABCF1F9ECE;
	Mon,  2 Dec 2024 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="hpjuiIYl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B2E1D6DD8
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Dec 2024 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733129576; cv=none; b=nUAk429nTRQZXgE0u9niQMPJKW9DNr8roOtBYh3Kka6FAq1KJ8I88LZSoG6d/FfeGxoTz6N1MC4RtMda8kxOeN/ZV7o0XGLTcIfsJa8+3/43FY1X88CovAWIz4EKKiPBBYg1YNsftdUSVgn1XoKvFpOMT2Nx4HAu/PQ0Xq2JewE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733129576; c=relaxed/simple;
	bh=M/wkMyFYg7l7CPNYctcw7ynSJhHtTB5Bus+d0Ug97NI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mgEYRufYv3NKOTFwr92b4fmdi+xdZgATTzHF4YH1xlsbN5arNrHvgLeXNXMamXoh2k6gibY4gZ9SOewXawmUFK4jM7qXzaxkKPIlUoD7ECUChp+sodsk0o2xR4yQw3QiOAuS2BL1U5Wxq/qcAvsjoacwR3ovlmDdqDCcmH6spCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=hpjuiIYl; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1733129571; x=1733734371; i=quwenruo.btrfs@gmx.com;
	bh=M/wkMyFYg7l7CPNYctcw7ynSJhHtTB5Bus+d0Ug97NI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hpjuiIYlFQVip2UBQ/cldvgxPPKgABwXuzENLIpwzr5XcaCZgx0LG6N3ek8unK60
	 mcLFtlp9bQXi7DNcDvwqc4kEII9b1fSqVoCSZ6pv4ZWTdwNk4YVnMRZn+k/zpg97Q
	 j4NxEbLu8Y+RfVrtPYPg2YezurJcZ+3XX3sBb2LPEm2dOad0CRFMcTc+EyJi3DCNr
	 AAibCoV6TpImkFyIyqUUbUPDWnOvmLZuGIRGBl/VxS7+Ho6NycXWp6vhGHi8GPz0Y
	 PR6so65t40fmI2p1NW5Uapn2xlwr0a86ih9Vx3s0FmMvPxL3eYBg2u+aCCTzr/4It
	 qcsZu/Yqv3zYhB7Fbw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MzhjF-1tdoBf32af-00wYDN; Mon, 02
 Dec 2024 09:52:51 +0100
Message-ID: <725d9253-8d83-4180-8032-adf926f33ac4@gmx.com>
Date: Mon, 2 Dec 2024 19:22:48 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "fixed up error" during scrub reported multiple times for same
 logical
To: Clemens Eisserer <linuxhippy@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAFvQSYRxZ80O6cEVnU5_qG0HP2Lwn0LnBYmyy5EuCvX=Pa8ukQ@mail.gmail.com>
 <902510e3-3793-4444-bef1-ee33309be7c1@gmx.com>
 <CAFvQSYS650FwYj1n_2yZb9x7hw3yui4HyK87cA6pdNP53tav+A@mail.gmail.com>
 <3145e2ec-a25b-4d9d-a5fe-00e0de5fefd5@gmx.com>
 <CAFvQSYSnXJvnqM8SD-SPeyS2TKM3qJ+0-UVZTwNZYj2uXHDynw@mail.gmail.com>
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
In-Reply-To: <CAFvQSYSnXJvnqM8SD-SPeyS2TKM3qJ+0-UVZTwNZYj2uXHDynw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oIsnZzA8bj/xYGk2M/R9pmqgsmE/nGRjZjZ0wKnNHRQMRZtO60P
 19z/3B6SZW20BlY4ZchhTPI7com+mmDoizULtUS2BBnq1bkkUzOpHpTBykzncR1fcDwEPwP
 Mu3Gcp2ShZMBfh51E+u8+GgfhhyvfziVnS0XAZKXZU8m9NqR4nBRNEOstT0BoRB7hdG1rce
 V48UGQZBUcprlLWNTjQlA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZwtDAzD5Ois=;w0XoXEeEBIW319LgUDzCNmwNJ5i
 wfIOW2TEavbpoYbe1peREcC3KRRiF4t7ZaHnYLkLgfSxONdsVmTjy4j7mTIw8HcZ2NQdC4z89
 EUgExsZcqbh2LNJBa65MRW7JU3AQFR2QDzq+7fJQxgr/x3ou9GuGedop6Asl3haAULdAgpJWS
 hVvKMFaj8k122MH5anRwk9UMGeXIh21CXKi9bpPdNPS5jSY7IdnF1gmJ7ZvJRbfaFHLMV5wqY
 bpePzyIunMwwsKdZZxzh8Lv4UzHwIQkzV3EvYKdJg1y0KzqbOqcF+osNH0o5zGjao/qaPxHZP
 y0myaSVLco/ghIQB8iKh0u60/g4Tkgx6bzUpuOB6hzsoeXEqHiiMlRpIeWqrXip0buksJO2Wv
 OC1kgz2uA759AGg1aWMhgHLxzJaLxxS1YkxCqVXaLctpmtIZZPhM3zElp8IOvEsb+6ClUKFqE
 cZTbW9e/6hMnoxmb3zavQ4eG/EPK/dxBvG7GKRruwXv0/aPGhuZ9v0X7gu1kFLtdt3VzTDQdY
 E+A18SbGLictntI1NwPqyJB5Cpf6W26jo/1dQm6FSex7sSH0heEYxYlEt6fqYpiVj1XJNoIe1
 px6PJozxYW2nYf4XdV5KTLgfwqW5QDQO5o90v3x61vaCy2eCFT24paH/GGrDCdNHGQkO54UfB
 sjp1c5H0GRFhHlVqxRXELfrmyS315uIa3OGr5dfH0EBJQvHpQN6+e5D29KysycWvJGi85GQ4O
 CxQJprJDvyJgeGIBiSr0ic2S6sYV+gSVn/BGFZThdPi36WIca99YW/5/beEGD+tNUGITsCwEi
 600VVTrzlRj6mNABcMk5BgYLUWrDXoNM2PyRyRWtZSQYs8KRSqAwrYib+lyaOufCUven2GeX1
 jfbd3nvR8Hfp1gJ/+I6VetHzCAx3QPpLMyvW8FYmOZobeemE2UegnRgQmY0LNi27nCJ3u+ne4
 TkatiMpTKzUz0c/ynUSTlP7Q0fe79AUvluTgqBx3yuOehU29dq6L3RqCKp0PHeID4S2lQImhf
 3n96MCcBs7YXvBJzoKVYfC81vuFKCF7aLKew8odlPSsLGgeMuvcPRenZwS1Sts28a12R9dg80
 XO8BhelSJaWm1+auy0QZEJ5mh6ZTHD



=E5=9C=A8 2024/12/2 18:40, Clemens Eisserer =E5=86=99=E9=81=93:
> Hi Qu,
>
>> Yes, single data will never be able to be fixed, thus this should be
>> metadata.
>>
>> What's the profile of the fs?
>
> Data was single, metdata and system dup.
> I suspect the SD card is simply trying to "prolong" its life by not
> correctly reporting read errors - one of the reasons i decided to use
> btrfs.
> As I am not keen on replacing the card as the pi is rather
> inaccessible, I switched data also to dup.

That would provide some extra safety margin.

Although I'm not really a huge fan using SDcard for root partition.

 From my personal experience on the list, we have around one case
per-month that we're pretty confident it's hardware problems (mostly
memory bitflip).

Personally speaking if you're not bound to certain RPI peripherals, I'd
recommend to go other aarch64 SBCs with extra PCIE connections, so you
can go consumer grade NVME drives.
(There are even some SoC having better upstream support than RPI, along
with UEFI support)

There are even some with the same RPI dimension.

Thanks,
Qu
> Thanks to btrfs' send/receive backups over network are super comfortable=
 anyway.
>
> Thanks again, Clemens
>


