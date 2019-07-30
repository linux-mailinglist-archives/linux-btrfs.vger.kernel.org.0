Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB017A21A
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2019 09:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfG3HWD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jul 2019 03:22:03 -0400
Received: from mout.gmx.net ([212.227.17.22]:59667 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727527AbfG3HWD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jul 2019 03:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564471319;
        bh=reneWoSH4MMbyFbPHokJsAkV+jpYmEdyMZm9pyamxPk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Fyfa925CXKmd04Z+dGj8Om8IXbZkjYPGWiZ4w/yWZF1rMX/2eK9qCmQQhG3hS/iCP
         3UJTb7xLjNqaKqrtwwRNsH7IDhmzng3TnEgIWsMAxaMTahKjlxaGP+7hIQUXNME3Y1
         iJsE1mefJwvWjWOGuwTzLuD6j7IHqccI+xWYsvcM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXp5Q-1htM0w3P4u-00YAzd; Tue, 30
 Jul 2019 09:21:59 +0200
Subject: Re: [BUG] BTRFS critical corrupt leaf - bisected to 496245cac57e
To:     =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>,
        alexander.wetzel@web.de
Cc:     linux-btrfs@vger.kernel.org
References: <5a89e922-00af-51a9-390f-b0a6b1f6cfb6@web.de>
 <daeb4767-b113-f945-da67-61d250fa1663@petaramesh.org>
 <d9ea9623-657e-0315-7166-b7f58b32d4e0@gmx.com>
 <4776e0bd-83c2-44a1-4403-3a155fe3f6c7@gmx.com>
 <508c6378-522a-ae24-6c33-83c8efc64ae5@petaramesh.org>
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
Message-ID: <83294063-9f98-71ab-428b-e2251b96e5b9@gmx.com>
Date:   Tue, 30 Jul 2019 15:21:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <508c6378-522a-ae24-6c33-83c8efc64ae5@petaramesh.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u2bwEWXmWfb4mOV/0LVcmla80dtjYqSCXHk0gr7LTVNJ/mnB6iT
 OfL+opbTXjvrnaGFJWs76N0Ro3HnciheNivKT3qSOApkfU+VmKdSJgkfbQd+B2Gkb4beiyg
 Ebl/m22++9D8ECcGDN8UcPUZDaPX4udD6xo/8J48HALyTK7zXt1OSThNfM+jAWodYeO3QqN
 yyU2GYFZy1g742NLqdhOg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UqLDZOWr250=:OX5nKycRaNl2HaHFoawxeb
 xZIYiLDQ2YHkHk5hpiG1r5Kyc3W6YucY4RFGyQxSAQtfehTtOdlfRYr9GhEq0qyqXGAWEDnq7
 s7Sd+c/X+EUMH8VhYoovS26WsxWggdRNbKU7C2+eMH7TFqY50PUTR7GlIwa3dAq/rAbLlWm9p
 y57T9O8n1tcynHI0UZFwjqxoWB2bRDCzydKvl98i7zZG8+UpOsGkBnu3cvvMZ1GFqKKpCg7Dk
 dCKeXOM80YJqIcyBB09NMLz+3oqAFr8uAs/U+pGvBdj0kCzkxfpDkj+EXpgqnvIDRf4Scqv0u
 XOCpP6Hn99+u2/UFXKIIP4ksnEh9kt0QLYWNIi7hvhnW8kpLIU8UFZv7HSuGqWemiUh9sqOUz
 uIg9lCAH5oyMX5Woqa7M3rNcL3tx9e8zlQIMjLLN/3qG+85NGP2Cw2+oKFf0ghrDgkXBl5+Uk
 JdKeacmoXUXm6TaXB+XUFSpiDtzHUCnjWvCDwIjM2vFGS4IXJl8RLZADjE2ooA3d0IhNQ/byA
 MVviL7XDtMgsHVtjd9rEEZ5xew6BiwcWMlvnCnWjTxVyG8DhQoto6zyLjq+xpU3oj1dPRK++k
 qATMZamOz55Z6UvEVn/indrbPyxS18+alkXjOvaF71ywGFH9ciQvjDK6/DT1tgwv9NlYdppdP
 CIuoyShbjh5B3ZRIwMiRek3W5EsMTdqAENWL5XsAo15/bfesuHu6Szm37/7qhhpBEUeGvea9F
 SCYC3DLssBSf4iIXBHCI9pUd5yAk+y8E33g/MKlujk6+bgf4HaViRNjehaqoWzG0tlLXsoTUP
 BRIcXDeFmwARWjqDj7JuEQ5/ChHgZA1g4MFm4qzAr/MorNhuGIGgI9C602syFoXLBSfZEqz1N
 2WQY7yCjxHwxwx15S3NYFLEu3BwNN2Mt5OtZu6oOL+CAH0+gdXqrGMkrKaaLN2Ewj5D/RgXuB
 lpN5B0I03HJKOr52GETKFOQ679W68DmEkIwpNXh1oK7sZpFjZ4NnOzyI2tYupjstLEn/R/SCE
 oAkLBDy4nwKQkkSJa+F2yHvomHp0z3Uj/B3LEzi3R0U9uj01ZB4awqEcKfr6cA5xz6ftMyYEe
 SQ+hiDK6JJcS6nEAYfMwBYayUoiAG4VGbC1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/7/30 =E4=B8=8B=E5=8D=882:44, Sw=C3=A2mi Petaramesh wrote:
> Le 30/07/2019 =C3=A0 06:56, Qu Wenruo a =C3=A9crit=C2=A0:
>>>>
>>>> I think I'me gonna emergency downgrade all my BTRFS machines to kerne=
l
>>>> 5.1 before they break ,-(
>>>
>>> Full kernel message please.
>>>
>>> That commit is designed to corrupted inode item, we need more info to
>>> determine if it's a real corruption or not.
>>>
>>> Thanks,
>>> Qu
>>
>> Ping? If you really want to solve the problem, please provide the full
>> kernel message.
>
> Hi,
>
> I have emergency downgraded my system to 5.1 not to take any risk of
> crashing my SSD again (and if it crashes again anyway, then I will know
> it is not kernel 5.2's fault and let you know...)

That kernel message is to *prevent* any further damage, by rejecting any
invalid metadata.
If it caused mount failure, it shouldn't have written anything to the disk=
.

The later transid error doesn't really match the original report.

We really need the mount failure message of that fs.

>
> I don't have the =C2=AB first kernel messages =C2=BB for the SSD because=
 I
> restored it to a backup before it failed, so obviously last kernel
> messages were lost.
>
> This morning if I try to scrub (using kernel5.1.16-arch1-1-ARCH) the
> external HD that failed yesterday, I get :
>
> BTRFS info (device dm-3): scrub: started on devid 1
> BTRFS error (device dm-3): parent transid verify failed on 2137144377344
> wanted 7684 found 7499
> BTRFS error (device dm-3): parent transid verify failed on 2137144377344
> wanted 7684 found 7499
> BTRFS error (device dm-3): parent transid verify failed on 2137144377344
> wanted 7684 found 7499
> BTRFS: error (device dm-3) in btrfs_drop_snapshot:9603: errno=3D-5 IO fa=
ilure
> BTRFS info (device dm-3): forced readonly
> BTRFS warning (device dm-3): failed setting block group ro: -30
> BTRFS info (device dm-3): scrub: not finished on devid 1 with status: -3=
0
>

Unfortunately, transid error here helps nothing.

Thanks,
Qu

> Hope this helps...
>
> =E0=A5=90
>
