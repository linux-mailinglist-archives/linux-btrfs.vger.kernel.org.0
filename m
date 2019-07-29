Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C933A78E3B
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2019 16:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfG2Oku (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Jul 2019 10:40:50 -0400
Received: from mout.gmx.net ([212.227.15.18]:48589 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfG2Oku (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jul 2019 10:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564411246;
        bh=8U19MIoehV4DfrykwFxbFJrfd7eOTDSCQ+iUQwNzBuI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=b59jJmjqKesMlM1NtQ0WQ5m6uGWzQgLqgBueB/+GgVl5s/yQl5NdADuDVZkiHsdVU
         iF06/aicY+lML5aDbVXmp7cKzDO0YwdfpLgSPD2VTP7J7vFtYy5+SiLAf6tw3BF07c
         kaWtXV+1U8Kvzkhb5QHyB8omvvCFuiXlGOGl7Oa4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0M9aX9-1hfDz03z5T-00CygR; Mon, 29
 Jul 2019 16:40:46 +0200
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>,
        linux-btrfs@vger.kernel.org
References: <bcb1a04b-f0b0-7699-92af-501e774de41a@petaramesh.org>
 <c336ccf4-34f5-a844-888c-cd63d8dc5c4e@petaramesh.org>
 <0ce15d14-9f30-ac83-0964-8e695eca8cbd@gmx.com>
 <325a96b2-e6a4-91e3-3b07-1d20a5a031af@petaramesh.org>
 <49785aa8-fb71-8e0e-bd1d-1e3cda4c7036@gmx.com>
 <39d43f92-413c-2184-b8da-2c6073b5223f@petaramesh.org>
 <b7037726-14dd-a1a2-238f-b5d0d43e3c80@petaramesh.org>
 <71bc824e-1462-50ef-19b1-848c5eb0439d@gmx.com>
 <a08455f0-0ee0-7349-69b3-9cdd00bfe2aa@petaramesh.org>
 <fc26d1e5-ea31-b0c9-0647-63db89a37f53@gmx.com>
 <4aa57293-3f60-8ced-db14-ed38dff7644b@petaramesh.org>
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
Message-ID: <43dc92e7-cd13-81db-bbe5-68affcdd317b@gmx.com>
Date:   Mon, 29 Jul 2019 22:40:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4aa57293-3f60-8ced-db14-ed38dff7644b@petaramesh.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fS75Pnvb7m6Pxyd7XW2oLGdJwCbkL/NwrvSFgJF2nNHT+chK2Pe
 KXttziRZLwxSS79izQ41e8FczK1k5chu+ag+njg1cRocdzNfHwVX5ucQ/cPmRIa8jVguoWf
 7i21cHd2LFmkDIwc0ZPumr9/0nJPOy3uP+SOMT7EN2eEoZPot92CYpe1XKN2qHIkkQuD0Ml
 BO6n5AZETLVRqD+k9ssnQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:P1B3OM79PPE=:UwfHqmCn5kHVZqkg6PBcjw
 WHmWohC0Y7HzY0jmp5TfJQkVZNVtETdACZY1d4CJmzFl/nAhMTvTIjC2Tt3lUti7PIKXDQeCT
 k3AG+Rr3SbMsyMVmWS7mv9T4pVR8o2LhVTizcwSLgQVGTFL+dlBfc32I5XD/5wXFHxLzT3T8v
 FOpYoFCUMtRWsGQVMHS5sVFbVHU4KivRsj2oUKXAQQN+TG0quBjm10JW4pCQfqqrexxZSVaBG
 RBm1OZtJhbsoBbaIY2qYYcQ9+mvGSfDjFtXoeEWNn3gs4flsrq5g4h+FPGbl2bR/7xRCDxI0f
 a3SRRDyN6DP+iwNYWpnJFhybDs7PDpyd/OioZf3yr2n/g2m1+sj8UPCLKJJA9AwthzUR96h6b
 7EMhX5JWB3D/Kb7gQItirVw+2xzJZQoHUgBdPjA+9k2ZRhgSdYsQtkQLzymzbRJFk3C2bGMjK
 tcyEB1OcqW0HaKHPxKvoGUvdvg3nJsd3pOHXffqhFlzgaJAkMeD7rHoQSqM6MKdMkutgnVRsX
 bmgC0AHI+iITlQBYWJWQHzUaeCQbJVoijvnc1cyJsx1Gvm/CMY4/fh0QiJohVJvd6o8m+pZ3x
 QpQ/o6TBD+NRwOZNeSNAfxYv/iHQKDSGB9zTglYYG+dFUX6mxIa4cuhdwuOds9qDcru19U30W
 dY2mfIcjk8HmcQPNmUxIUDrIC7xysHbTM4H4QPVU0CCavu1HaEmQ9C/spK4gIIHwNrAxV5QVt
 ldpgTlBLexkPc1xMEfaTbIQzh4Cj8s1gHd37+fAxmfuwnrlXGIt42D9KqT8bH6gp5xTX+Pqmu
 1uaGRbrKfU2ZL/fBUSaPc1pkzhivWpOFZW5k+7UuG2cYt1cwsxNk0qTPcj9clMSbw9wppEw0j
 tMmyjLvQTIQqagdOgbO9reMJTYM5Z3A5RWBsKLrGhn7ihMArkogfUvsClpyrHZk+wbZjm4l9o
 iil9bAix4XfCTpDGeY1DWpesm39lwIEek07LsXDAehw9M6vYWhAeK7FDmWFDvjMWTPT/TtsAu
 Q6opmG4bM6Q6o/osSjAsXrxyAODP1DUb3fQgtnhJ3qjI/yrUlUG8kWMEUGiDRPfYIfE+XlYxf
 C2X19PcmRwdpnGSwEZxoD0Xz6CCOpYOl7hB
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/7/29 =E4=B8=8B=E5=8D=8810:34, Sw=C3=A2mi Petaramesh wrote:
> Le 29/07/2019 =C3=A0 16:27, Qu Wenruo a =C3=A9crit=C2=A0:
>> BTW, I'm more interesting in your other corrupted leaf report other tha=
n
>> this transid error.
>
> Well I already broke 2 FSes including my most important computer with
> this, took me 2 working days to restore and mostly fix my main computer
> which I couldn't use for a week (because of lack of time for restoring
> it) and now I lose my main backup disk.

At least from what I see in this transid error, unless you ruled out the
possibility of bad disk firmware and LVM/LUKS, it's hard to say it's
btrfs causing the problem.

In fact, we have a more experienced sysadmin, Zygo, sharing his
experience of bad *HARDWARE* causing various Flush/FUA problem, which is
not easy to hit in normal use case, but only after power loss.

So for your transid error, it's really hard to pin down the cause,
unless you have deployed hundreds btrfs...

>
> I'd really like to see this addressed, because I'm crying tears of blood=
...
>
>> The later one is either some real corruption from older fs, or some
>> false alerts needs to be addressed.
>
> So how could I help with this one ?

As already said in that thread, full dmesg of that mount failure.

Thanks,
Qu

>
> TIA
>
> =E0=A5=90
>
