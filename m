Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3319FAE1C7
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2019 03:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbfIJAvU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Sep 2019 20:51:20 -0400
Received: from mout.gmx.net ([212.227.17.20]:52811 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728196AbfIJAvU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Sep 2019 20:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568076671;
        bh=lrf027Ycib2MmgIY1q08q6isiAFE2b8lP+F4nkRooMA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=T65B/jbC32LQoJAx2STqkEUVk/2ahUBkLMwPUTB7JnAZ3ZpuDY1ohiutZYz/p9Avc
         ApHygTjC2J9UHRT2Zqxt7l1FhRgn1A8fxiWAt/duByAe4lactdRPHwNGNaCSErPmqd
         P9L1DUpPXQ112tx00T6Sd0p7LqFD/Ysfx03iPleo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0LaGfK-1iYHCK4B6k-00m25o; Tue, 10
 Sep 2019 02:51:11 +0200
Subject: Re: Feature requests: online backup - defrag - change RAID level
To:     Chris Murphy <lists@colorremedies.com>
Cc:     webmaster@zedlx.com, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
 <20190909123818.Horde.dbl-yi_cNi8aKDaW_QYXVij@server53.web-hosting.com>
 <ba5f9d6c-aa6c-c9b2-76d2-3ca56606fcc5@gmx.com>
 <CAJCQCtQD5tCrFO+M8=R0jksqE4eXsshzy53smKXKRqgiRxz2zg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
Message-ID: <92566cf2-5621-6f3c-f8f9-225d9b88d08f@gmx.com>
Date:   Tue, 10 Sep 2019 08:51:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtQD5tCrFO+M8=R0jksqE4eXsshzy53smKXKRqgiRxz2zg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VE0jWljDKivxdcIoZAif64LQJYETZ9uNo"
X-Provags-ID: V03:K1:lOUR7AV1xG0J9jqujmi1yKTUArpmfPRNxp55PWu3lgff1Lv/Qgr
 QwSmazsIog8ys25kgZOJlWqEOkbz5e/3TI70IC3kyDXms7ab1NItlpvjTVIEdDPn1xm8iNP
 YEP4A9KZR+ZPPpnbpH+7vakfipgsbXJgJQ+e87qxrhjAdQjL3LfLWPm2VHddiKiqXYcsrdJ
 5uC34k2/HUnJ3BvXfLX4A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8kNaJ8yMeco=:b1IZF+dEnpTkJWky2tUncG
 mydq4125X+H5qJVBNBW2CQ3mrFtqkoR4cB4F9BZZrQycUq9sP+x1M0qahFiZ7pxIUYA4RT5k5
 BlH3f1LMKRdxJJSLzFGqXfPUmzSikR/Rx67MuW5+WXLWJTDCqabb6w/a8kzfYhGGG1Zr0PKd/
 oyo7VVlbEoTqS/lkYkAcIBwC6amC4oJXcM1WEsIjZrjbjOjyE32W5uKhExU6g1U0qKY3pgl/i
 oFljjKNE8muOlGg1gxCF8Q2muVLBSD2uwscBLFmsBT6orhn87Wh7XHOu/DdLIxNrkzRCgOGlh
 aRrkt6ygHiY8lpS2kBBtdXgENzlXY1QlQ/96KEZRTN1ex3mPTNUCnABjb3eAbqOp6UpL4sEip
 /aOD+PkQGWlDMA1g0+npvnxvPxx+gdt1azJDfRWZnlBU7VPuBPuteXKJLQ4oilbO+Zt7aOB04
 Drs4E/1ju6/+rJYSR+XwI33Vc7laV4cSmJMnbIFE0sguy8pHJAn9z4wLbLMaYPIWC/XxvMlF8
 wsBbFZaK2G5DZGIHWF8177YvFDDedN1ofZ26UNbXbbOreY+dqzYtQJJmQMJeJfCIoqDsX0QUi
 iHUx6DeWYDegdhKN3hwDL6NzESiQFzE/AjnV9FXwsColIl5V72est29dCxNwaJicKZkfRXyw3
 5FtoURLB8dsnl1LTI2/Ft38tBonh2VYZ5uy9kwJugjpftgzyIjtKV04sr6wDqoVGZwR4FXJu1
 WSPuDnYeIl7VEV665csVbr6d5kkfHk6sKe6XYdDIVNoCxpLbWEteRT0wZQ9aRcHuogmAdK4VF
 WsEflCFvtaXm2ZumBUAezoy4gCJe3jEriaIp/8uYzTN2BTYjug2+kc7nmvlsUXESoUj+13a3m
 VyqALMWX505S9rufUhUs1ew+f5rWwwNVqnBYR9UXRNBPB6j23/Ya6AwkvBGBnLnOmIbSfesi6
 yf3C3ipw13/JytNRy20bgj3TscYTZLVGMsGwSfmJ1FZ2lcsNZj8GiNNzMSuz6m2wVV3woBqt9
 IpTdo7Q7FpaNJ/+TVWFaCvRVDrt/i0ISE+rD3uP1B8HH5gzjdWf2fePr8hHA+A7B3r0zqey9v
 AL9H8XriAurV/NLZEE90qzgEyHDXm/db/vuqqjDSTykC8rshVbQmSEWJWowkvogr4GoSPEWPn
 jlHfW2dDICnEjTKDiGstJsoP/CBJcfqdzFJiT+HPXGpshPeWsxhZ9DbytLLZ6XmaB6qY2d/QC
 gF8G/SFo8OBrt6T8u
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VE0jWljDKivxdcIoZAif64LQJYETZ9uNo
Content-Type: multipart/mixed; boundary="TQWcRG43GmsOulfbluFSkctKTRzvHMBOO"

--TQWcRG43GmsOulfbluFSkctKTRzvHMBOO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/10 =E4=B8=8A=E5=8D=888:00, Chris Murphy wrote:
> On Mon, Sep 9, 2019 at 5:44 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>>
>> On 2019/9/10 =E4=B8=8A=E5=8D=8812:38, webmaster@zedlx.com wrote:
>>> Yes, it is true, but what you are posting so far are all 'red
>>> herring'-type arguments. It's just some irrelevant concerns, and you
>>> just got me explaining thinks like I would to a little baby. I don't
>>> know whether I stumbled on some rookie member of btrfs project, or yo=
u
>>> are just lazy and you don't want to think or consider my proposals.
>>
>> Go check my name in git log.
>>
>=20
> Hey Qu, how do I join this rookie club? :-D

By reading the funny code. :)

And try to write the funny code.
(Then you have double fun!)

Thanks,
Qu


--TQWcRG43GmsOulfbluFSkctKTRzvHMBOO--

--VE0jWljDKivxdcIoZAif64LQJYETZ9uNo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1283oACgkQwj2R86El
/qgaTggAjqBERnxR8ijfllWNoyPL3xhNziVgF5tkHVlbWRAky3fCF56aQ3Ha9uPI
zySVTRDbm8gU2GRIRfmfTnhbCdDV50YPXFS9EDpI7I9Qd3YwuJZtUauhm3voSi8q
MbIikBOtKVf1xWRD28Mp1/4e5db3TEAZXnav0pubExh1tfYvGDGQzxRNrYJgzFwa
Zwc8uPEIap+yLsXAm2o+nO7qDil3YlaXEJfzF+2OBmtZwL93GvyePCerSA3zYvzw
L7tLLlBI0UcjCGclPCo2olkPiF6fgYH2rYiSCwP4f695xvkf7Q9k/FD7g4t5rq+6
jGgjQ+F2dH5gTHkyTj7aV/kQKosf8Q==
=2LW7
-----END PGP SIGNATURE-----

--VE0jWljDKivxdcIoZAif64LQJYETZ9uNo--
