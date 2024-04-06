Return-Path: <linux-btrfs+bounces-3995-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1905089A8B8
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Apr 2024 05:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A9761C21130
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Apr 2024 03:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535C31CF9A;
	Sat,  6 Apr 2024 03:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="gOcHvNlM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6111BF53
	for <linux-btrfs@vger.kernel.org>; Sat,  6 Apr 2024 03:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712375264; cv=none; b=JH56wkuP/SwtW+w0boxKIuD1F5zbmLi1NRM11bmEzIfpT6z48MbAhyKKFZmOkWl7ab4R5nbXZgi/JARoE/4SQbNuxW6MZDPKejX9UbzA/K0T0yO2bxvX/AfuSYeOBVP7IFfRMpjx2/kAxa8RGbzlpBwkvIpLQ12WzPZSdOJqyd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712375264; c=relaxed/simple;
	bh=Y4ZNrvpYxcW07eAIUU+PloI3uinNyQAg1KNOZ073Tqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tKsyiXlootXmJl9yv1oaYE8AAsLlgGaeFK3n/kxFPvGUgTX4bSVuj2krZMoNlK2Z3klfq+NwnURV3Y0g/Du961hl/c5QQFnBdwP11X+08SdjQC0mYjSd+yN7Co1Jh7JX/5hbEmgerCFa9yaMrk+tFyjQLuCUJRRXT/0lB22MCoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=gOcHvNlM; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1712375259; x=1712980059; i=quwenruo.btrfs@gmx.com;
	bh=Y4ZNrvpYxcW07eAIUU+PloI3uinNyQAg1KNOZ073Tqg=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=gOcHvNlMVrq45JS5Fbpins4aqcIMoiJkBQyNS8QWEQ6ogwHwBJ8QX3oGltDL3nPi
	 cyTzeRkBJKPbTb8VxNDd2omIrebUtXJbqeK8OvE5VqdR7zkzsEpdlEQtal85t2ABS
	 4Bf+Xp8nXYPHNx47ZXLTxLPRSnjqYerLFLf7Wwz0+JZKC92nXUPo2af9sx9zP8ozO
	 2shfjzoYe2g+imsYU/e2fGhfaPuskArdjRnpXb3Qxmzer3ww+6gsp+FaAqGCM2T9s
	 EqEKiBbwz+HysAbNd4oYkM9l7qWs6xZPxGKKjIGVBW8A4l48+wpXoNqgU3Dl9HatA
	 Z/TSd9B3GVMVLs24Tg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N49hB-1sseGh38WP-0106lO; Sat, 06
 Apr 2024 05:47:39 +0200
Message-ID: <f1e7424c-64a8-4752-8a36-fa08f902ce7b@gmx.com>
Date: Sat, 6 Apr 2024 14:17:35 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Preconfigured BTRFS Virtual Drives for testing?
To: "David F." <df7729@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAGRSmLtrH7GNzAE2o69qvfEMk9mTR1a=zUq36dzwkCeQTz7F8A@mail.gmail.com>
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
In-Reply-To: <CAGRSmLtrH7GNzAE2o69qvfEMk9mTR1a=zUq36dzwkCeQTz7F8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RrJDXqpHQP157uhyP+lS76YT6QTED1NHkeKdvBQ1LMmZcAceNW0
 Ctvghgktu+x2pD+GHqn6L3zL3YjwmYWVmQ4CogKqiHoHcbHxbZ0kjwUN1L1wq9d3VcKEFPI
 cCq98TquHwPsVT0hwzR7pLX3nxG7zHBmDh5f9AemPutuL0UZiSoCqnaBqzd5mSzq2ZfC7Wk
 qT3Kl+eUkFriiIXV4DZeg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gpEI1PGgbhw=;AwAN9OgfQRdkpvgkOi/MqJPz7K4
 36jzFL5YS368xUM2out5xjhaoWOIfxNqBxyHEIQy2zkCv+w1KXDekXNRJQVXGyeyCpi9I2c3G
 FHX5SjLBkZRB35WFpNeHNEwevwg4jYwUrJDBDyEsgtg7zAH9zVcybywb/jnc8Sn9maQGa8/6Q
 niWgVdo++2Q/FPgXZghR6nYNSCkvXkGVmQ47AN4sfrVbGgMbI+SVwZIfIVQzFVNBkBbq+T6v5
 DKlcatkqAqZkptFCP4633k4uBM4Bc/UADvg7cSbfXaBPpPnH0EYKc7hSPS1WGVIKxLz+rvDxz
 FBv0Mn9LbNHzsI7gL+gGgEl66Esb/MA6Kt8rKDh/tykwmUAQ8Pg7S1vo7g12ckoLo4PX7LDQA
 Wo2SsbDg0DM6iQrgmmLIuk646Fb1g7yJEhthGLYMRveXm6Oe0xrt5C5lfB9KZQ5tIQ4/nD+x5
 LzEBYzSmKrJf/z6NjNKyBH5ZX4PGsKlzNxii9M84IUIGhNT8qUiXO9gPHFpZE+a1tPAPaYUNr
 g6jnYQicY3BCDEcCgjKPIyYJtR5gtoRxAVdvdAOZ3dNXJ8uqxa/JSfBjFSIElENnGpkyqNP81
 8IYZkr7ydd2r68v1v1e2a28BlW6X/fTnxFUuODGPa+phhWTgCmMlAi5/9dDcRkQh9MDVjSJhO
 qJv/jJ9ttjgr/dbb17uLhJjvhcKVONPtwJwPxHuwncRUvRbOY8E5Xu2WjBGuek5AjrGaau/wU
 6D5deVYhAMrKXqGIfuV9PxO38dJd7/S5LvtP5J8BN+QThuN/E+T6+f8YlZLUxSku5b45M2DVZ
 bwRyr8QzmChslDV2Mv9l97c1aW7P689ZRbxrWup/9k8Tg=



=E5=9C=A8 2024/4/6 12:04, David F. =E5=86=99=E9=81=93:
> Hello,
>
> I wonder if there are preconfigured BTRFS virtual hard drives setup
> with all the various conditions BTRFS metadata can be in (leaf only,
> max nodes, new format, full drive, etc..) for testing purposes?

It's not possible, due to zoned support.

A virtual disk image can not easily tell a VM to emulate a zoned device
for it.

For features other than zoned, you can mostly specify the feature at
mkfs time.

That's how we handle it for fstests.

Thanks,
Qu
>
> If so, where can they be downloaded?
>
> Thanks.
>

