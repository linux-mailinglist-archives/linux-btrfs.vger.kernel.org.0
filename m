Return-Path: <linux-btrfs+bounces-9990-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ABD9DF528
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Dec 2024 10:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4101B21083
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Dec 2024 09:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7590E136326;
	Sun,  1 Dec 2024 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="o9Pi8M79"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245927E575
	for <linux-btrfs@vger.kernel.org>; Sun,  1 Dec 2024 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733046934; cv=none; b=EtgU6dUmY29mp74erIaEs70IxZ0ftWF+42gvVHPgvVt3jK8IHoOfG/PhbCitJUndNC7hNHAVxCoIzn1D18Zqz7fqs4J8a5yQVCNvXe2t3b5W4H3mj+TERxxfvp3NCzBaBzm1ECLBNwwBlsXSgDWAG/525Qu49siD6gxShLOem94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733046934; c=relaxed/simple;
	bh=oN4+TI4lTqvtztkhqzJB/1Ifp65jHai+BOqbkjbDcac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R8tBC8vW+gc5YwAc4US/FwKKs41ThoPBUnuEbyllgdCXcno7ZJXZvWeexIv543bhNFLo/hr96hOsCuHoc1ERt4coKSgmCKTJHvOv4GvifQo5P+2/eIEK6BfdqzT0lh3cD1NaCbMOt/pfVpHaWm2wiLCpn4DMCPRrjOPyGOmBO3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=o9Pi8M79; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1733046922; x=1733651722; i=quwenruo.btrfs@gmx.com;
	bh=vttKmG4SnzuXQ3SuHJ0BFja0/onJqOhrimJO6LtkcxE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=o9Pi8M79cvd/e58I2QrNeOBFlj3/6GHB2qTXu2p7o5HvEZVPiLWeRksdXpvRV592
	 hR9mMyRJ26gLgfwjGuiqN8ukCR7oI138gbyF8dWk8DB8pzx35AJjdXphP7iqIXSX5
	 TRoIJ1VRjiZXZUFXbXRGx4lNLeRJddUscIEFcDJgy+mHyo+5uh+jII6hyP/1pFlgI
	 GCMqMOIE1His03WSc1NlbxUu71GxUkQhLiLxQWxLDdTAePnrQY0et5KPljhidXDT7
	 4XMz5/4u1I71VLh0V647+seKP3cy1qPuTPsMjybnunxFfEaQyBNJWqkvAG8pufxgM
	 tHnr71d4eSk2oAbGkw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mq2jC-1u4iYC1FEQ-00hFfQ; Sun, 01
 Dec 2024 10:55:22 +0100
Message-ID: <d1682e7d-9b1d-44cc-963a-1b1c5394fb2d@gmx.com>
Date: Sun, 1 Dec 2024 20:25:19 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] LTP random fixes for xfs and btrfs
To: Zorro Lang <zlang@kernel.org>, ltp@lists.linux.it
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com
References: <20241201093606.68993-1-zlang@kernel.org>
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
In-Reply-To: <20241201093606.68993-1-zlang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SsrLxsvfSakt2nUgvfSVe7iku23lskb3v7Pcrlcw3LjeplC8mHQ
 ni2w6XoYh0AdEOpnvzZPj88AO1xFR6yAcp5ckPzxVNKB5zqSszPAqBfc0TAp9Mbap08VnWs
 Kymt2iQ9Xwaw1ZuKieplGuHD/MTPcK6LQgRfrNPvVRzo4jOHNdB4VvJHTG3Bew3Z9Yk7tdQ
 tBHZxdLjbABwJaz1MOyoA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ppc3pGpJ0CY=;6LeUSJGISZausMgThefqZvWdzbP
 26bhs0jfT1h050dqvmcXhhZl1A7Q204mEL9+odamU/GUbrvBuum9BxwbIpxLcBZVucq0kmfDd
 1hgexGjT+YmuJAtdyoX7rG/9b5YTh4XcZxDKu3IMJHfsloz7OIo7mnaNs7EDhOT55F7aU8hFi
 0O+heQr1h02YQIUZO9MHqQLGP5E83ViKLweS5ArhqJuJbw+6hXBzMG9TdPG7XjaJefGxViydh
 LRB1kQKjuvoqcOkO/KGQ4BGJUS9x5iK02lVJBAkMrG1AnD549iRTeb3AulwGy56J9J0RmZ3o9
 DLn5BBB5Tb8/T0vg0hsRAO2KhPx4JQ2WiwrvPvpl5u4mda4Wdg7U/TBqRUO3jsH+HTBtnyA2T
 IHmEjOO5pKxS/T7OJxQtiDRR22eX/bHp//zjDK2CISjR+ZpWYu2lJphZ5/LLmy11z2dr0daJX
 3QZpHR5rwCAjUumSYgRdFd/S18ViFsbnm8IK14BJgbSkq4G1v8nTifUy91RmLUjiQJF7xIaWo
 ArsiNJQXhNUIqC4M8SSLNQdinscH1JtO3GrJaDdirJ6PMc2cI/GH1rCLT5ZErvG0nq8g+HWIB
 Qyo67O8z9v4xu4znlyNQIBGjCSUNmi6pleqCYgsVI0sqUc85ABvciqklvqjzoRmMSMnVovh0Q
 iXLE1mAnqHhv59bLRO1hsVODsxTGzYa+F38Xc9x9Pl7P3ANPPlHA0iJrq4qluy/sc+WPmeRyc
 lROc0q/W13kVHFioEZEwywaPRTgSLUisdfq0wCH8BddixGKQaWDh790rEuxvalSQRVCFHpXkX
 pxWsSYf3taMC0/SbvPg0hSGp39nrYFL5w/z8ymwhyMiFZSyaEphh7OKNPZsRPWqJ2q3TVjLS4
 siQ0jrbEvp5gXe2vGps8KsJIaIca4uLrWuJWBD03mp91JsCizbxqnxGGhlRJf0kb6i8mqhO07
 QrF3Qzg9nCqYnZqvOXyguX2JhJa0mmXCEA4XZp3uNWZV2xdJfnucl1tDGazM70W3hcP+eFW1S
 twWLKSt9IDpVSgSpne2FQ1NXZGfM5Iifwiy5mxHdo11bKs2q0bx5oyeWtEFKrDCXhryHNr9Qn
 hHKL/QrJJlSXS4xbdK45uxDYdCgXPB



=E5=9C=A8 2024/12/1 20:06, Zorro Lang =E5=86=99=E9=81=93:
> [PATCH 1/3] ioctl_ficlone02.c: set all_filesystems to zero
>
>    It doesn't skip filesystems as its plan, fix it.
>
> [PATCH 2/3] stat04+lstat03: fix bad blocksize mkfs option for xfs
>
>    mkfs.xfs doesn't support "-b 1024", needs "-b size=3D1024"
>
> [PATCH 3/3] stat04+lstat03: skip test on btrfs
>
>    The "-b" option of mkfs.btrfs isn't a blocksize option, there's not b=
locksize
>    option in mkfs.btrfs. So I'd like to skip this test for btrfs. But I'=
m not
>    sure if there's better way, so CC *btrfs list* to get more review poi=
nts for
>    that.
>    (BTW, better to have a common helper to deal with different filesyste=
ms'
>     blocksize options in the future)
>

Well, I'd say Wilcox is kinda correct here.

Btrfs uses the name "sector size" to indicate the minimal unit, aka, the
blocksize of all the other fses.

Not sure if we will even rename the whole sector size to block size in
the future, it looks like a huge work to do.


However there is another problem related to the btrfs block size (aka,
"sector size").
Our block size starts at 4K, ends at 64K, and we do not yet support
block size > page size.

For systems with 64K page size, although we have the support for block
size < page size, I have added an artificial limits, that only 4K block
size and page size is supported.


So even if we added btrfs block size support, it won't really work
except 4K and page size (at least for now).

Thanks,
Qu

