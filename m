Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E49330A3C
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Mar 2021 10:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhCHJYC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Mar 2021 04:24:02 -0500
Received: from mout.gmx.net ([212.227.17.21]:42331 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230002AbhCHJXs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Mar 2021 04:23:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615195424;
        bh=A+S2bHYPBGyShlM2moAuVtannTIugaL6CbFEZcDXCzM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=idTQJSOqKSrhC1VXn7ZTddSNczEkWNngkJABGMMYqecfPpAeNxCQI3ambG+fAhXp8
         ZD9L+cql+9N+8Fp93ZMgl3q96bfCjpLiAI39pylO+xs7hO1c/CfyTg+ZKoYj6lBOGN
         ZTd7rvoWpWYEwe5Qh5ihHCsGrzR0up9WH2K0YASg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmUHp-1m0kD00yyf-00iT3O; Mon, 08
 Mar 2021 10:23:44 +0100
Subject: Re: btrfs error: write time tree block corruption detected
To:     chil L1n <devchill1n@gmail.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CABBhR_6Y=H6Eujw51xkt6_fjAQFjdcp5trVgjtbrNf9iMDxZ0g@mail.gmail.com>
 <PH0PR04MB74168E7E65BDF004A6C06BB39B939@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CABBhR_6mO2e2Bu2TLGTCjY-xG3+Yu34visp9+uqdvKUvpVhG-g@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <100894a0-51c5-6ba9-7688-32203cb822c6@gmx.com>
Date:   Mon, 8 Mar 2021 17:23:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CABBhR_6mO2e2Bu2TLGTCjY-xG3+Yu34visp9+uqdvKUvpVhG-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y2W7/hEgCUZydqWkdMqOp77fizM0PZ6tRMhn5wCOlj4by5X+/5i
 uayeAWPq9wcrhhp1eQ6clOdlYOqSShU9W0cW06lGDvIUNJByXDjmddf9vmXYiKngADn++gr
 42IsJhR79psBeZj15zAcMmC3VfyhPq9kOngfKdmhX4iq2SEzHGripIEdJfNvNnnuQZL2MHM
 5ssn98SpXD6OHkrFj58Mg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mARYeQzHIBA=:7pcHYC+u5AEKr/tIRKiY6w
 GXWcYFqLEzVaBIXB5+BCvtiaNhZofYcVdQsjXZh7ugTOYJXQ1D7E6GOItRDwu6EccmRh+2ylp
 X3dpfixEYCJHsimPQmU76yEtlFnB5a86ODOgD8rUltZ3LMNnj9RAnzBegDzYkycX1Bpd20vJv
 hCuCG6HN5L/ptbodBcDrMz1vkH3LZliTLLz3aIGr9c+B6nvFcpEN+dQtDjGJ7wNfYz5PlLW3O
 qW28hpSo14DpfLm+RRvVypisYPiCqUgYTaodyw+/MmpBcmo3ATZqP9rs1xw/AONgLHPtCr6R5
 4nE3AhTAoktx3SuV+eDFpG9iAYCQ744Zv6p3/FzpECIDitXqkdg4zHpnTZXyHNfme/WemHZ2k
 /lD99fyipu49RjCBPixPwB3UVEyCmdTLRRYWjKjFyl4J1fOvcig08L6V106xRV2uLj9Hrlfjr
 EtjnSM7QkGde7spjF1uJxLvLgmiLujvsfQjU1P9Bl+p0VI9NiNbLo5LUxOm7VNJcNEHbrap7q
 fArAhLnOeByBlOBpQEbyEszODojnontVwCNS7M08ZQOt4VYiOKNicuSXTzmggq4bIobWVbILn
 tC2LL15v+0H+uLJ3kxJxyLHKK/5Fid81+j5pejbGGrvWLMW4ysl74dRk5kqb3HbJPvmuLrBno
 +dHpPlt+Zap281jEUB+I5ecedbYhNM/Ah4NGgHKxQnaubGHxov0ZWLj/WsK+J7s4yxf5CWQOn
 b8C6gd+m4oH21Rr1PFDwd9D1FQBg2BnoqqyAw50bGqedFVRq3/jItdZfXdRk5kKxIDJww5DZX
 bhecxt7XCVDdHbM1wahK0+zdWPmVee44EXwxdVmFe7lfl1dSjJrMVq/WjBSB72XqFF4gjKonl
 NikSEJJGV25R1VKR1kFg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/3/8 =E4=B8=8B=E5=8D=884:56, chil L1n wrote:
> Hi Johannes,
>
> Thanks for the advice. I'm running memtester now. This will take some
> time as the machine has 32GB RAM.
> Regarding your explanation, I count two bit position differences, not
> 1. Can you explain your reasoning?

It looks like Johannes missed one 0, and caused some confusion.

With 0 padded correctly, the result is:

3276800 =3D 0b1100100000000000000000
1310720 =3D 0b0101000000000000000000

That's why I prefer to use hex:
3276800 =3D 0x320000
1310720 =3D 0x140000
diff    =3D 0x200000

Definitely one bit flipped.

Thanks,
Qu

>
> Thanks,
>
> chill
>
>
> On Mon, Mar 8, 2021 at 9:41 AM Johannes Thumshirn
> <Johannes.Thumshirn@wdc.com> wrote:
>>
>> On 06/03/2021 10:11, chil L1n wrote:
>>> [2555511.868642] BTRFS critical (device sda4): corrupt leaf: root=3D25=
8
>>> block=3D250975895552 slot=3D78, bad key order, prev (256703 108 327680=
0)
>>> current (256703 108 1310720)
>>> [2555511.868650] BTRFS error (device sda4): block=3D250975895552 write
>>> time tree block corruption detected
>>
>> This /might/ be a memory bitflip:
>>
>> 3276800 =3D 0b1100100000000000000000
>> 1310720 =3D 0b101000000000000000000
>>
>> I guess the highest bit did flip so it should have been:
>> 3407872 =3D 0b1101000000000000000000
>>
>> (3407872 - 3276800) / 4096.0
>> 32.0
>>
>> Can you run a memtest on the machine to check if the RAM is ok?
>>
>> Byte,
>>          Johannes
