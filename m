Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD88F12891B
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Dec 2019 13:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfLUMxQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Dec 2019 07:53:16 -0500
Received: from mout.gmx.net ([212.227.17.20]:38851 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbfLUMxP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Dec 2019 07:53:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576932794;
        bh=7P2PwAfnHf3eu+Glo2ofq/MCOVBCkKvxathEwIk1m48=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=EaaPkAK4D8wC6VWJA4Xh8jZq/0j0EodAg+ucbLHLU+Pciqilh1SixxoqAP+8ZQqX+
         ZqJQrBG7bTUH6IEmV2pkM1wntYqu6kN14oRVaJpouzkgHUQQGT+eyDTFWw3BR1mYJG
         HRvC/O1dtH0tXmN7kOiMTZBb1YHrgADDwlWqikCE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8GMq-1hesLB0qwK-014Fha; Sat, 21
 Dec 2019 13:53:13 +0100
Subject: Re: Kernel 5.4 - BTRFS FS shows full with about 600 GB Free ?
To:     =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>,
        "'linux-btrfs@vger.kernel.org'" <linux-btrfs@vger.kernel.org>
References: <8bd55f28-2176-89f7-bd53-4992ccd53f42@petaramesh.org>
 <81dec38b-ec8e-382e-7dfe-cb331f418ffa@gmx.com>
 <e7204e11-bb45-b7d2-7e98-af4d52c306a8@petaramesh.org>
 <9e54330f-0443-8a3b-d8a4-6377a3a55d0a@gmx.com>
 <cbbfe8a4-ff7b-4bea-313c-e1acbf9ee61a@petaramesh.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <ced9e509-25f9-1d20-fd7d-12faafdbfd11@gmx.com>
Date:   Sat, 21 Dec 2019 20:53:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <cbbfe8a4-ff7b-4bea-313c-e1acbf9ee61a@petaramesh.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lhuKTQPj03gXbRxVpmf/NMv5hQxiDgahzF1AOzmA8kFsMP7Tsm5
 cFgekTKeVu/Y/dpdXluG9MPiLQCYgzS6ozcV45Fm9e+FQGr2wB4lK6Le8Pac9uWtvKTWVTP
 2MEtwD16k5ICTTPXuzc1BXgUccVbAZfXNSnV4bworH8AfDv6p0cXiEQUCQKFOkFUdh7IVWF
 sKX2OBZJRODNngTlvIueg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HY9zwKS22u8=:9RI+0qYMvqT9SkYh9BRYgg
 46N11xsJVMy2osplIuJdyjhJ3TT3Uh9GQwocWf8Y0d9GjvOtvz7ERlH2sE9UhXzWKi+zhc9+T
 ANGb5VF6LCVn5dYjS3Dna6BIeYNkj3A1zLdSmNdcCUUfjcFnTpnyB0d3wMAC5cbXRYffkUGbJ
 JobbCpyWIP9sbRvcu/smrUTqPqdTJBhAG9WBoDUBb9FtZtsJbpPBNRdwvMCiSd52mxG4xmbxV
 ODSq63t/WhHPtbM3JzQsTFe9PUHbdB6MHKMGBBzz7NAkIiW+IYr1ENWcB4bV7cfcIXyfO93H4
 TDA2cHHRyDYYXGU4ayZjqiY+1kQK0n89qKhE6IzgnMihLKOHEpuqt4PzB4NdqQBBJXrD+new7
 +Qmo+f9sUkkIhcNEo9XdQTLhSiRIHOuR2MaN3y21Bpca07sW8D7BDQdKghH3ot4Q1w469/VQC
 CqkErt8UiPxOa/Vynh1svw++RqHhxoL8MuaGNLxgenCeWjOp7VRtE/OFC7VOrLO0x5syH3u7r
 8Mr+ftiftq8FsEMT3kC3wBlGBRo2ci7bSF/HJ7ASZsRAo+dnnVNPClSNYcWBVGcWgVOjEA0G9
 O0RK7XUAwES4lJr6sm0rxp3xn5od5VTBqJY0xdLiiv2d+PL62PRvrsDHRAqSuIn1CCIO5swut
 0/92zgNve01GO/JGSAMzwDJIiA+MaAy72a/IblL/3V2lTzk6/T0m9nUm2GswwAxxlc6UyKEfD
 RkX7IXUds7mS5Eg8G9EjBE/ee8WLIXxpm6EQLqBkpnkQH4x7JoVrS586WcBFrXnqaogsMH/9I
 Eg00yMqhBx0KECB1uPQUjFR5M57FRAfjJl3Tp2gAFwjE9uNVi0cIfquzJqnFD/R57x4f8yZN6
 GlfS/TgX3GBxtZQfLJr7HdXP8e54Tohw5bozDKJbGAolHkMQ3HgatETQbkezLahGvIy8b/PF/
 et8zECHz2o41jaZ4WtAsxHDHCXeAYPbyEiucmKqUUUp++pXbZAVgK93UE0hkTJouP8LdkcVES
 GldN7ycqxhbbvDvI5GSJsABWwe5gyW9I1zZYqa8c6H8SKo4gJb8/+GgTfkBgkSbfuCxjpheek
 0DRxEr0PpoF9K7yZ3RIENKGr6otysx2dp4lWDyJSGB8JJiY1TngkgyEwRcGbhOvapEcBiorb2
 +tfcFpNzigojpyXsPW+ZKFUT4bAYKD/9DpjrlfInEIcl18xyIdl1dHzmuUTF/0GSkZiCqYxDD
 7+G6yxthfl7XYu+cw3b6I4ooersj4R43cI1l7lXcdgXIVP7ohzFtTs7IUcpY=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/12/21 =E4=B8=8B=E5=8D=888:26, Sw=C3=A2mi Petaramesh wrote:
> Le 21/12/2019 =C3=A0 13:16, Qu Wenruo a =C3=A9crit=C2=A0:
>>> I understand =C2=AB no other bad effect =C2=BB as =C2=AB The FS will b=
e OK again when
>>> this is fixed in the kernel, I can leave the disk in my drawer in the
>>> mean time =C2=BB ?
>> You can even use it without any problem with v5.4 kernel, except the
>> `df` will sometimes bother you.
>>
> Actually I discovered the issue not typing =C2=AB df =C2=BB but trying t=
o copy
> files using my GUI's file manager (Cinnamon's =E2=80=9CNemo=E2=80=9D).

There are other reports of tools, which utilize 'statfs()' call to
monitor available space, also get affected.

So to be more accurate, any tools utilizing 'statfs()' call would
reports false ENOSPC error.

Since you're using arch, and if you're not utilizing bleeding edge
hardware, you could try lts kernel, or at least downgrade to v5.3 and
wait for the fix to be merged and backported.

Thanks,
Qu

>
> Got bounced with =C2=AB Filesystem full =C2=BB, so no, I cannot use the =
FS
> =E2=80=9Cwithout any problems=E2=80=9D...
>
> But using rsync in a terminal seems to actually work...
>
> Kind regards.
>
