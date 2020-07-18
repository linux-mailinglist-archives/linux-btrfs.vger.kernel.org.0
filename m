Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5EA22474A
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Jul 2020 02:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgGRAEF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jul 2020 20:04:05 -0400
Received: from mout.gmx.net ([212.227.15.15]:40531 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727946AbgGRAED (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jul 2020 20:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595030637;
        bh=PLGXcOXWqoiHPS6SkZrxCBR0+0MMZYiQjRwqbJiB5ys=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=DfpJVkyPtiQbt/fJI/qqicJKHabxg6BG+R4dv0D8d9pXWJVjoOZw7Sz8qnIQ2fBKS
         9Qx4WbO3E3AvDWT98H84EZY8Vm/0LIWKwop10sjhhcbn71EhTo6V+XsrY9MkYQoZBC
         Mw8eza95I18jPsFmwvhVCO5rWuGdSv17jrvNKKtw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MkHMZ-1kh9Xw0qmv-00keCp; Sat, 18
 Jul 2020 02:03:57 +0200
Subject: Re: [RFC][PATCH] btrfs: add an autodefrag property
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, chris@colorremedies.com
References: <20200717204221.2285627-1-josef@toxicpanda.com>
 <c9b9d2f6-8e2c-01c2-193f-8f589134d39f@gmx.com>
 <99682fa7-4ba6-48df-60a7-a8eaa453419a@toxicpanda.com>
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
Message-ID: <2e3d691a-9596-fb99-8138-dd1b53fda7b4@gmx.com>
Date:   Sat, 18 Jul 2020 08:03:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <99682fa7-4ba6-48df-60a7-a8eaa453419a@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SyiRxtE0w9PCQtQn5gX3TwcjdY08kpgtf"
X-Provags-ID: V03:K1:JK9LTGu64itaK/m+QUa24hJPU11TnVEmRRWpwvRezB7BuLP7IIc
 6xE/CDAjbTzC9Gj9W45AQUoB3x+4PMamX0uKochh8/cLGAC4aORgSUcaHWtlrX47ruLzCMn
 grdFmRHQgHCw06h0UyloUaIvY4JQHLOV30C2DKj8A9P89R3Z8Y2Hwdo283GiewGM/3BchTE
 yJb5PhrkJTF98NpDtRAlQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9ePUBGfG6Q4=:I6iBoPqXwU1cHJjqUYceAS
 XBWB/wU+o0S5s+YsyA3aBpyJm3ZlEEnSubt0704HJtXnSw/W/74ZGjWQu0DFhXvz93Zb98uqA
 xjMWHrFh9Tp1fyfuM0AYbvaFlP0trXPBS1IKGcuRS44IqF3I4hjrR2SLB9vqP1tDj7xEQShMA
 XsTDetaLclMw150qYAiVwIvXhpxSuoaR6M8e7eqrKGk90R9EqQTB9Fo1FW9AMmLJhjbx3AaET
 dfkuHTG175rebmF4tDqm2LcbqJJraLQ5kyYtxKHGaoq4kguYgdiLwQP10MJ1b4FMIRt1YF83C
 gC7rV7+u22E2j6CbPRNGngLB1EBnWwdrYhHS6P/KfT8tmdPasK+cZGBLZR7klkHi6+N1v0CUZ
 1EAKLni09cqUbHqgYDWxA4UIeSZu5yKmZfQh3VFNqeLGiWp1oZSl7HAJgRE+Gn+DCNR8/zB/u
 UH5JYCKhhpk6stienjSuWgvAUYTeDQwlLSbaSmZY0W1hsPNOpF8DVpO9GoFFLmeprbAuHvjmD
 CS2vxogCrNaHAIOQWYYcydDF3z9HP/rTAqAdgKqQhRlG6f8yr7zoYWaiHwEOqXXh6RqOIThqo
 dC7TMo/kf0SQDs0k6eHpcnmc4UD1DzP1XzwFa1BrXYi1mLs+qa+GDoz8ezVyIBJEZbka16LM2
 tLKmh2rs0QJCx6gLyiqPgmUOv0RgsvnuMrFYcdFVvcVZQTpRJZ+MMKMvtOmnWyJFxPOD6fTZO
 q/epNiAGsuZQrZy10j26iX5PtpXsZ6tb5gWI9wibYfRm49T3voG2s4PNn8hWIaeod0lO519Rc
 G6T0P5im+V5GT2wRIHWQBIrK6XWVcbKO+itjYXK8a41ZfWXxn81tZ9PJkhSK6l6d/oW6EggjS
 8yDRJcjFiSk7hynKuelL4XRv4c17EsY1xkP9wcR2mx1/5rE012ODMYpSz4fX8sACY6tX+xbPB
 XSfRHo9gh1yVFr4SKasw/e0sqkpHO+5FIQ8RcSbyl3y2onmVHWZNEgvyaRMKviu1thyp3QaE4
 EC2VOl8lEJAxiZZhDYzbU+pYESa3dZ3YoAlTZKA3by/E55ZmFEq5UQZePSTEiArweiZhDuDwT
 Lwdr76grxw/JpWR2Ubimq0xsksJiE/ZSrFyEpyJC15J1AhpPF1JX54iZrTbYaLKe/9krlU5UG
 mUHpokt5rFrnMCHmhMZDE94ODNcgryn8DQVSl87AcGv9FCv9vk/rXS4iSOuZjOGcpR4RnFdrf
 p4EZsfAeQfQjIoN0G7n23XzkcAzAt0mWzv/fkXQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SyiRxtE0w9PCQtQn5gX3TwcjdY08kpgtf
Content-Type: multipart/mixed; boundary="DPCw5Sm3LBkvtl76v5xWpVf0XCYtL0CDf"

--DPCw5Sm3LBkvtl76v5xWpVf0XCYtL0CDf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/18 =E4=B8=8A=E5=8D=887:58, Josef Bacik wrote:
> On 7/17/20 7:46 PM, Qu Wenruo wrote:
>>
>>
>> On 2020/7/18 =E4=B8=8A=E5=8D=884:42, Josef Bacik wrote:
>>> Autodefrag is very useful for somethings, like the 9000 sqllite files=

>>> that Firefox uses, but is way less useful for virt images.
>>> Unfortunately this is only available currently as a whole mount optio=
n.
>>> Fix this by adding an "autodefrag" property, that users can set on a =
per
>>> file or per directory basis.=C2=A0 Thus allowing them to control wher=
e
>>> exactly the extra write activity is going to occur.
>>>
>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>> ---
>>> - This is an RFC because I want to make sure we're ok with this
>>> before I go and
>>> =C2=A0=C2=A0 add btrfs-progs support for this.=C2=A0 I'm not married =
to the name or
>>> the value,
>>> =C2=A0=C2=A0 but I think the core goal is valuable.
>>
>> The idea looks pretty good to me.
>>
>> Although it would be much more convincing to bring some real-world mic=
ro
>> bench to show the benefit.
>>
>=20
> The same benefit as what existed originally for autodefrag, firefox
> isn't unusably slow on spinning rust.
>=20
>>
>> However I still have a concern related to defrag.
>> Since it's on-disk flag, thus can be inherited by snapshot, then what
>> would happen if an auto-defrag inode get snapshotted.
>>
>> Would any write to the auto-defrag inode in new snapshot break the spa=
ce
>> saving?
> Sure but that's the case for all defrag, and this is in fact better tha=
n
> mount -o autodefrag because you can limit the damage.=C2=A0 Thanks,

That's right. So no problem at all then.

Thanks,
Qu

>=20
> Josef


--DPCw5Sm3LBkvtl76v5xWpVf0XCYtL0CDf--

--SyiRxtE0w9PCQtQn5gX3TwcjdY08kpgtf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8SPGkACgkQwj2R86El
/qj3/wf/bQ7fA/WOLczWD4ZK95yldbUMv+c33Uf+gOPJXwzr/AA0Fdp2NlWcJy/X
l41+jk+eoRZi1SQLDlKvoVx3y7A/GzOKrMw7eSB716hL1kml4/r0Jqf1FM3U+flK
8AmhvEsbAXvHmCxuo8MHm1bGjKib1B2a61gs3nS/n0AgQtAcDZrX/o6iu3gVtx1Y
2bnyJtWSAMkDwT5t0mS3sV1h4bArdV29+jz22Yrr/p3MP6cvEjN88CohHK9r2CUC
oJo//mViK7UvP4YFsx1blgxhZSCCUW4n2VjJjCagQ4HzOvw9yzRS4zEyy+KBgeAC
69jHyCFv6XfgSyJmbgjFGoIpKfP4vg==
=cL+e
-----END PGP SIGNATURE-----

--SyiRxtE0w9PCQtQn5gX3TwcjdY08kpgtf--
