Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C99599DE3D
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 08:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfH0GxG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 02:53:06 -0400
Received: from mout.gmx.net ([212.227.15.18]:44265 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfH0GxG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 02:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566888783;
        bh=JXt6wuDTCj1qd97GOSHiEUXWoGG76fggIVcHa9WMaCw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NiUN/RG5gLnH8lemql3Pvn+HhvbRrjdxBaacD0i1exOtySfc+VfErzLELw2MPVb/M
         xttE89GS4NPqFpIYxQTeiefuvEz2c99v9hF9PaUgqY4fx1pYtqSI1QNrbzvuUxoD7F
         m4xZ6LPpcBHHKfCdEdOXIc25PHV+ucOf0qKViOWI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0McmFl-1hl6vH1l2H-00Hw04; Tue, 27
 Aug 2019 08:53:03 +0200
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>,
        linux-btrfs@vger.kernel.org
Cc:     Christoph Anton Mitterer <calestyo@scientia.net>
References: <11e4e889f903ddad682297c4420faeb0245414cf.camel@scientia.net>
 <18d24f2f-4d33-10aa-5052-c358d4f7c328@petaramesh.org>
 <a8968a812e270a0dd80c4cf431a8437d3a7daba5.camel@scientia.net>
 <5aefca34-224a-0a81-c930-4ccfcd144aef@petaramesh.org>
 <4bd70aa2-7ad0-d5c6-bc1f-22340afaac60@petaramesh.org>
 <370697f1-24c9-c8bd-01a7-c2885a7ece05@gmx.com>
 <209fcd36-6748-99c5-7b6d-319571bdd11f@petaramesh.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <6525d5cf-9203-0332-cad5-2abc5d3e541c@gmx.com>
Date:   Tue, 27 Aug 2019 14:52:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <209fcd36-6748-99c5-7b6d-319571bdd11f@petaramesh.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1mytLaGuaij4jbaJdUGXJfyT1RF/a4YUGC0k3y+CXheBFchMDdW
 E6dtf4dzHpStoE1tvMfySh4xyWIxuY1W5i+MaU+eYQc+rYF+NsMzFhlmFnj0cipwJISjXHU
 eR5Jo51xoeju4ocIopjJeu3lSgYdnHWW3s7vbEEG/ZIjFrbUNnbWbAf/C4Yg+CZJ858pugM
 PsuG1fGMH6/TIp7js6E+g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ht1UBK76QY4=:dYQdc3IcZNjtE+gTZfq5Y1
 otdD/Si9LYJqyEqx/cYUjcFkMUWAXr3Sja0UH/uO64n+viZnNbcxXHURsroQfEOs9NzTKfZCs
 GGKuU53RboBKexEPrfQ9wXmCQO72bZYQRF0coCS3x9HVLWskhYJNEgnQLNi1Mk5aG1MXBhgSo
 GMKVN5oNrdPgVomILz4/zbXHmNBKpafq93cFRkiWBr3TfZS55ARbfVQttC+3ci/rl2jkjJ/5G
 MlAJJtdWyqI3uv5h9dkTytFapARvUTrcue63Z/6QZHIaqJs6qjxL0qjJ4n5osrXoDSTyb80oy
 3USM6co+yK4ptFMQjqiWjrSY/RD4jAjDQWZJ7krwLtqIxkd6PlcbJDOocMypgv/O127f89jyc
 VczxrSarEVYJI2mzf+HEpiqYQTbZzjskrwTa94GJCwfrBBXQgXE8h2aLLGKXb02gYAZHURzsL
 9dc0VHjl95lUX+dZ0erY8gd9wnhuxveQL88retYvKF530vdutCWx4suk4vXeGXDPkt8YE2xHJ
 T2WpkiA7GHO17GFUakH9VZHkKWTVJtueKQjJpAMxkycWEjEmSjSDY56PX/AKc5YfAW4/eNo5C
 ZrDkVYfS2L6JSoKUegZ/84gqa6fQJR1KuIjEf2+7Mo2JIrcboLDtwOE2tQ8JmM9zGQh+LWRIE
 6Uj93fDOHRupBGaRcKUQ/71bYFnDXtwjjhllSj9Rz3L0EmkahFgZdZWgtFz1HGZihM1Acgp1h
 iz80W2E/XsfS8L4oSSg0TH0n85LIO6daAfhb8w8ysEHP2yECX8alM3xeblQ5ZSn9Us4Yp9lZL
 vaOrA7LuTz3QhVWbw35W85i4OspBDskEplUAncPkP3JUdzr02DQ3+u15g2EL9BBbT5QeMViyK
 GDYIAUcizlzHbia+R8CbLC7L4lDqlyq3nQ+n7jeGPxPPacpfv/S1XJJJs1b1j5xtMA/7VuWfi
 Y27DsMmVte420SrTgMu38Pb9NYUpbxbedIia+swoLCOX/myXZMpsY5orLq1GQGchOKSspDYtH
 V5TclhAmSvvJKzkxGOLmknF2CfqHgMfQZJUSNC1JmIrf1V1SkqsE8AIxuQnjSDtnoViLo8o/a
 jb1JIKqJYwQROgyxep7gxCZId2Emc9Qt5vvMirqvQHeEDrySbFV6K/vOyZy2Pwb9yTspKeRoH
 7e9e3vgDzV18ht2AQr+AY3xwfPGQ7SF9wgDuT7yIl2ABOlLw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/8/27 =E4=B8=8B=E5=8D=882:34, Sw=C3=A2mi Petaramesh wrote:
> Hi Qu,
>
> Le 27/08/2019 =C3=A0 08:21, Qu Wenruo a =C3=A9crit=C2=A0:
>> If free space cache is invalid but passes its csum check, it's
>> completely *possible* to break metadata CoW, thus leads to transid mism=
atch.
>>
>> You can go v2 space cache which uses metadata CoW to protect its space
>> cache, thus in theory it should be a little safer than V1 space cache.
>>
>> Or you can just disable space cache using nospace_cache mount option, a=
s
>> it's just an optimization. It's also recommended to clean existing cach=
e
>> by using "btrfs check --clear-space-cache v1".
>>
>> I'd prefer to do a "btrfs check --readonly" anyway (which also checks
>> free space cache), then go nospace_cache if you're concerned.
>
> I will leave for travel shortly, so I will be unable to perform further
> tests on this machine for a week, but I'll do when I'm back.
>
> Should I understand your statement as an advice to clear the space cache
> even though the kernel said it has rebuilt it,

Rebuild only happens when kernel detects such mismatch by comparing the
block group free space (recorded in block group item) and free space cache=
.

If those numbers (along with other things like csum and generation)
match, we don't have a way to detect wrong free space cache at all.

So if kernel is already complaining about free space cache, then no
matter whatever the reason is, you'd better take extra care about the
free space cache.

Although another possible cause is, your extent tree is already
corrupted thus the free space number in block group item is already
incorrect.
You can only determine that by running btrfs check --readonly.

> or to use the V2 space
> cache generally speaking, on any machine that I use (I had understood it
> was useful only on multi-TB filesystems...)

10GiB is enough to create large enough block groups to utilize free
space cache.
So you can't really escape from free space cache.

Thanks,
Qu

>
> Thanks.
>
> =E0=A5=90
>
