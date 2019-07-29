Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF5E78CEA
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2019 15:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387483AbfG2Ndt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Jul 2019 09:33:49 -0400
Received: from mout.gmx.net ([212.227.15.19]:55785 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387449AbfG2Ndt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jul 2019 09:33:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564407225;
        bh=FhvALpyZetTXrmg++lAXY/hyxeJtPcEiDE4/pznBpH4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Crn2GuJLV3RmNJ6C3gh7hYwFLVMYZt40iG2TiRQz70tp1VeBLft9fSU/fIHk1jVfo
         bkSGTqoLi0p2zzV3GF56VmFvv7KriPlh30Zu6oACFijfoNGlR5XLPNYoihTcAr1WMr
         D3fOFREsuuviDjGcKwlttAscjncZtV+jSaQ6Qo+4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LjrDd-1iPEbh3LU9-00bwek; Mon, 29
 Jul 2019 15:33:45 +0200
Subject: Re: [BUG] BTRFS critical corrupt leaf - bisected to 496245cac57e
To:     =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>,
        alexander.wetzel@web.de
Cc:     linux-btrfs@vger.kernel.org
References: <5a89e922-00af-51a9-390f-b0a6b1f6cfb6@web.de>
 <daeb4767-b113-f945-da67-61d250fa1663@petaramesh.org>
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
Message-ID: <d9ea9623-657e-0315-7166-b7f58b32d4e0@gmx.com>
Date:   Mon, 29 Jul 2019 21:33:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <daeb4767-b113-f945-da67-61d250fa1663@petaramesh.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p2ioTwRLlqhfsu1sCsauOOombSJHQ+JtOYS0FuvGwef7yPDctXU
 Wu+shqw0zb17gaAKdx7ltjhoWLZjiDAN+JajV/ZwmHQenFjw4GIXrTxCs3xyC3kH+vsdVOF
 s/FVFcraUFsEtEMDHFbxP+/a+q73IPRQlSB6wgrAbIdT/Hkvm5FOQSNo2qdPW6moKOfG31W
 Qsy7LCERxMBAaIS+Mq/WA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7GRSyLeGyfE=:tVQ/iuwxakuWggESbl7kZl
 W/gbHIFD7M0YrV5v/GBt9E+sJo+6NhuYe1yMs0vnTspzwIqQzGEr1LLmPe7mLdE1Sd8Vwip9i
 zW6U7pS6Fv7N+jo2Ev/ayKVdtc6eotjZyQPy8yW+xRnbuuQWkV7nK4nkPYagg8gCemfuG79V2
 1DhTYTzKhoE5Fr8V7MUntfnyxMPA4f4rBiAfbTfgsxEwG1ZKXsPVJ8HQmk5HmrdNdjLQEFuxm
 SDEiWB1h+cUZnmyNodT1br5oadFsQhl5hO8zRR4NnTtwyGc20Ur0bHyNkE7Xnp/sYN9IJRs9J
 +vhurpYYnkYz7oroG0qXSgHM7TOJpTpvM5aTAR9JvLIB5Q6gR9FHHPeEEYAt3CGg/W4Gr46JH
 QEpDVJDPF5FKgnxWn/wfPJYK9rMUK0uARFQjSTcFiPShCeoPG/59wWUPPiQ/jqJR6Aho1lc5g
 jxIQo1tBQw66bJmkbUn71OgSNsZjy5F2Rkri8HJxDpDuZcwHGe+1W+tzI8WVBIZanfpoFvvVO
 2f1vhQGX5bBJpaQmRsr6Y01+WeISBU1fZQHRf1lRYdYPfvweQaVptdWNu0bDisDnEkOxAVwrH
 kDhkNJTdOI0kHV4LELvSntu7GBqZx8WJf7nrxNz7Sm4VBVs4HfsdQVOfB36/iXZ4taoGv8/Kj
 VzO5jkwb95/cVsuryTIdLK43Ry3rp7w5IdrSdev2hvvzT/2ULXxVpgZWeYVcrSPNQpjeR06YY
 z8qkMvjtPcJNIss2zJWYubOWWnp5ZAnwUc3yH8pRIFVM0/O4ozDm8utfdLkp2ToiY8HlLLwsc
 N48rho9MvCo6+zWmgsP81BJyuILqgCFo51Z9r0TlkDMpkRdtNE/9z6fXRoLaH4uqsGsPKV0Ch
 85/iJIPLEMEO0iGjGPnmJy0QGmg4f7Qvfstn5Ddwdy+qoaOxFNjDs2uCeZgnsU2IaKrIzSALB
 1Y/K74kN3nTysxrq3w4I3UxI2JsH16WuXuGA/eNNezgwB0AJGuYNU0nRv2KqbwkK0uXHioTdH
 P24hCr3pcRdFLjxyJDasK9y5lY5NgpX7AsPIF1CgC4CnY4NjYt9MdmA93SMmQsZLAaJLGuiNv
 0yZA+tJCoB3hfF68VP9SWAxmX5wf9oZ6SUX
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/7/29 =E4=B8=8B=E5=8D=888:46, Sw=C3=A2mi Petaramesh wrote:
> Hi,
>
> The corruption issue that you report just after upgrading to kernel 5.2
> resembles very much to what I had on 2 filesystems after such an upgrade=
.
>
> I think I'me gonna emergency downgrade all my BTRFS machines to kernel
> 5.1 before they break ,-(

Full kernel message please.

That commit is designed to corrupted inode item, we need more info to
determine if it's a real corruption or not.

Thanks,
Qu

>
>
> =E0=A5=90
>
