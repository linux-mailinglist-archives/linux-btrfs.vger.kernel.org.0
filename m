Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0335F78E65
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2019 16:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbfG2Ovq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Jul 2019 10:51:46 -0400
Received: from mout.gmx.net ([212.227.17.21]:47649 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728377AbfG2Ovq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jul 2019 10:51:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564411904;
        bh=2EQhR092z+XsdcbY+bzRzhvWh0v0I4Qy0PIWUjLHaf8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=VMQXFQWR7cZHETroxtPFx0E8jVPjx6yjDKNXR/UL6MkHrV0zkLBrZM5VOs9eECnnZ
         aq9AFLgxMLeAflMJhWvGFy0vulVXwGggtKIsBeiS7lxQCX7PKG/hwNWB//iF2IYjge
         xA9XbxQSHyzJ2Md/8w5qFapIiWXeSGLuxmjgsr0M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4zAy-1iZFDm2UAG-010rxo; Mon, 29
 Jul 2019 16:51:44 +0200
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
 <43dc92e7-cd13-81db-bbe5-68affcdd317b@gmx.com>
 <a74e3ba6-7106-f2c5-383e-1f75621605a5@petaramesh.org>
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
Message-ID: <c5fb61ef-05dc-2bd4-a0aa-d86358d7b82a@gmx.com>
Date:   Mon, 29 Jul 2019 22:51:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a74e3ba6-7106-f2c5-383e-1f75621605a5@petaramesh.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NkRX1oiKSIZSGWQok2kAGQqIeIGXMUHfmtyxxyyEp92wOv+SOTE
 5tPBVgue7b9NU1SCWjVrZW55WDQi4LaY33fdSqXWz+onfBp7SBaZY65MCW+kV537Qu0Ur9C
 10ujJUJxnUj1Zchw8vW4rI9RbmWkRHjUIKSMoQmmJvQ0xS1J4BS9CtU0roN9Z+aYDV27HMl
 8Mb+RoqioNlJs7D9pt7sg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8DRoOW67YMk=:SvYmr/7m4+2Ncpo1m7Bm2z
 kEcPN0svzf/mrMCsU69NEW4QlYCfs8WOtF7VLUJbMcfFSncVDhha5rfVBku/f61+ZzvaYtVEY
 12+YFjuunZeL127YWI6j8c0NijovDpLgp849RvLPoVSLjhvI5lcz5WobPGZRHHD1rytnaj1ow
 n/gRD4tjnoe+zB47pn70rwTBru+hT70cbsO0XlO4PmgeQRsTQp7+VBmX7Fv/KfUDtE/Bx9Ryn
 XH3igb6Ubxz6smV8p09dSQowXhGxbgeKanNPqEmp4m/cLrIw6fyLaDlglsjzQqqptg7xpZP9k
 7Zh0bshmLVdpVeKljA51zJ/PIOBbq4LDa2wXY8QANljLt8Gx8dsZWaEnm7nFbI6a+UnGzeQLw
 jxWeFlJejk7ifLsXjnRTUI/6h1OOfcOts/eif7uiOB3qQXEKU8Zj+2cQKW0E81lTxCoN/ERE1
 8OL3rmSgJeIqIblzIrgPoZK5bG4o/prgcclIXXrVMXxDhaOdxcCX7757QNocsG6H0FtresXAp
 SKQlMQbY2Mcaory9nMyA71ySqEVxvvCC8OTIcxXcciZQHH4Jjq9a9IgATrY8DIw+kxTCdgm94
 CcPrQZwfTdzQmfg2rfdqEui6VQrQBbYzDRf2/kdNDEkQ88atkOEsaBNBWLKGobkj9p21nUCte
 CyikrQCfqMF+MR9xv+g0KfjTDFDBQw4Xr+7xYyRp+Zx0ij8Wym4gNqZgVkjH0TmffgtYJ0+4n
 Wq+yFfdzNCqKXRk3grGnzNshGsFMLAQipTk32nFLlawvuTrGSru8KskeagM9HCOuYxJnTifOB
 L9QKLjFnSNRZyidZVTfx/4oBTCMkC68M2VeY/mEP0ysi9T3/J0mtB8bFPQ9cZlJNnR9TdWv4v
 sqJlABV3G8Y3OPKcIPb954QVEs504GFcLCDVtRjAYY4Um8Uo0n9ZReiWIN66UZ70CIU66K3da
 0N4GW0naIBInC48B6Eb8nOfjq2EA41hIC8LnFfycvTXdQiJSc1m7bfSdypTvFeVR4vrwg2Ay2
 Sq7GH2MteGt7oGTsi+gmhcKRWS46ZBxIr3RRW3Bl0HrII5IP+QCcQKdfAVKY2QcVRmMbXjdI+
 d2wH8x6jSSdtjfrfPS5d/lJbe2ZW1y8KMZL
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/7/29 =E4=B8=8B=E5=8D=8810:46, Sw=C3=A2mi Petaramesh wrote:
> Le 29/07/2019 =C3=A0 16:40, Qu Wenruo a =C3=A9crit=C2=A0:
>> At least from what I see in this transid error, unless you ruled out th=
e
>> possibility of bad disk firmware and LVM/LUKS, it's hard to say it's
>> btrfs causing the problem.
>
> Well it would be such a coincidence that a machine that has been 100%
> stable since 2014 suddently crashes 2 filesystems on 2 different disks
> justy after upgrading to 5.2 and both things would be unrelated.
>
> Can happen, but the chances...

If I understand your two threads correctly, one is this transid error,
the other one is tree-checker, which is completely different from this one=
.

The tree-checker one is mostly caused by older fs, and as you mentioned,
reverting to 5.1 solves that problem.

This transid won't be resolved whatever kernel version you use, it's a
real corruption in extent tree, caused by incorrect metadata CoW.

So they are two different problems, and this transid error can be
completely unrelated to 5.2 kernel.

Thanks,
Qu

>
>> In fact, we have a more experienced sysadmin, Zygo, sharing his
>> experience of bad *HARDWARE* causing various Flush/FUA problem, which i=
s
>> not easy to hit in normal use case, but only after power loss.
>
>> So for your transid error, it's really hard to pin down the cause,
>> unless you have deployed hundreds btrfs...
>
> For the record I am a professional sysadmin with 20+ years Linux
> experience and I have deployed BTRFS on dozens of systems (OK maybe not
> hundreds, not sure)...>
> Kind regards.
>
> =E0=A5=90
>
