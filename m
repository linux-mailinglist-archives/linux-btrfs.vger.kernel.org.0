Return-Path: <linux-btrfs+bounces-13402-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B4EA9B968
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 22:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8833D17E145
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 20:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFB426A0FF;
	Thu, 24 Apr 2025 20:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="HVep5Kca"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60569222578
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 20:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745527766; cv=none; b=IE8n5Xe6PwzJE43QOhgAglOpfegROC1ypC15TT70+ku2jpU9sjHYM/rEHVwXSePcwArfoSKfEM4b/YqH7GiVMCzFUstN+I7Zo9xK5fZt5s1nRZDAfCD13q6XiRSOS4RMfXNxGlDnIInQXEdCQVWjycsCc/Tgf0lP4aOAVgpW+3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745527766; c=relaxed/simple;
	bh=atDIOiCAn/cBtDZuRrN+z6JNyy/v1CN+VKOXP3karwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=a6Fhatk5e+vQMf/wVMQDNXTnBUh2QY24qZOqlyRXB79/tfeIbFZ2BHWTB+im5KhjoVdyxdC+boUPWl2iU6AxnI8E8QuI6/tibfRs8Olj5sg84NtgZJdXps0XTU/GX4mLYjqtR2GmSkcppqPMrMIrHi0jVJ5qMq4jPvWZQQWIfF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=HVep5Kca; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1745527761; x=1746132561; i=quwenruo.btrfs@gmx.com;
	bh=atDIOiCAn/cBtDZuRrN+z6JNyy/v1CN+VKOXP3karwE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HVep5KcavQpuWvl/bmtTPijKLss5XkRkJw+vf4pNpKptEc1M6MJCXQWOoMf5x7T9
	 7Ojkf5YbEKHE3xcYcSf+MqBjDnxLpA++KWDbWxJPI79wmzOmKYjc4Gkb5/tJv3a9s
	 ZGINVzdLeIZ1h6ZIF6JOsE0YKZnBpiVLJ0XAvpr0wFgBOfv7JcVeZ2QrBYXJT7ZGL
	 6SYvSyTy+J8iAGHAIoZsBT16693lSJ634aadznBIGDC6kBymiKhI7yYIHZQOccqkb
	 I11Qcmb6Q0hlGQWES7Ebz9hrO7leyPlLW45lEOKu0H6JRVUsOK9DuydLIoSo4EvFY
	 HFw6Zqo8NB4R9xjPJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1fii-1v5MAi2wXI-011Jt5; Thu, 24
 Apr 2025 22:49:21 +0200
Message-ID: <f32bd559-71c7-4d45-9af4-47a913eca63d@gmx.com>
Date: Fri, 25 Apr 2025 06:19:17 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Errors on newly created file system
To: Ferry Toth <fntoth@gmail.com>, linux-btrfs@vger.kernel.org,
 Qu Wenruo <wqu@suse.com>
References: <669c174e-5835-471f-9065-279a7da8f190@gmail.com>
 <2366963.X513TT2pbd@ferry-quad>
 <b2ac7b22-ab50-4eb4-a90a-0d110407ba36@gmx.com>
 <3309589.KRxA6XjA2N@ferry-quad>
 <d98ffb69-195b-4c07-ac56-8ae1f811af32@gmail.com>
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
In-Reply-To: <d98ffb69-195b-4c07-ac56-8ae1f811af32@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bBfB4jfSsEn45gyfbLpxtehKM6hMIAviXny39RcAWHrXJHdoBfL
 o31PWGosIW8gmn5wE65Er5Z2RF1/whyfOy7mJp6oE0RFaSMQwcQ+8RzVTBFghBv57iGzk+o
 lAp6q7h9rU/cwAoFh/K60KKZSiYgoCdZVqEj8IOZQpA0OBmPd48rCizMz5NRtYToJWEeyH8
 esHKiUON4lRemkAoqQjbQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nbNCKEC0Ja0=;bPcNIu1nMNNKV2QxP8pigal9Yg1
 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



=E5=9C=A8 2025/4/25 05:41, Ferry Toth =E5=86=99=E9=81=93:
> Hi
>=20
[...]
>>
>>
>> Except with newer mkfs.btrfs (I tested using 6.13) the files are owned=
=20
>> by the unprivileged user.
>>
>>
>> The result is, the image will not boot correctly.
>>
>>
> I found more about this issue here
>=20
> https://lore.kernel.org/yocto/=20
> tRtu.1740682678597454399.5171@lists.yoctoproject.org/T/=20
> #m5de0afa17d2c0f640e86ffe67e0d74aea467fd5b
>=20
Thanks for the report.

Just want to be sure, with pseudo emulating root environment, how does=20
it handle the file uid/gid?

Mkfs.btrfs uses the uid/gid reported from stat() system calls, thus if=20
pseudo doesn't change uid/gid reported from stat(), mkfs.btrfs will just=
=20
follow the result.

I guess it's possible for us to implement an idmap-like solution, but=20
I'd like to know how pseudo works first.

Thanks,
Qu

