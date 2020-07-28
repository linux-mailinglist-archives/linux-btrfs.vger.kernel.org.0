Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D47622FF2D
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jul 2020 03:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgG1B53 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jul 2020 21:57:29 -0400
Received: from mout.gmx.net ([212.227.17.20]:36647 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgG1B52 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jul 2020 21:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595901439;
        bh=C+uHpeCO+3ujpHEnJoZnzjTQpUX1KB8Eg4cpw07K6Bc=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=TZ+1souupDFLnr57kAMTsh9eFFHo0VYMPh7CEGhualGWRS0C/LNz4K0P1MD9cnoVT
         eHwrAiuKQd8P9fPJtAB+ZUrAMXp8T1XJ//b1CxClyQocsF+HC/T74/Z8JPwZDmSQA2
         9XzwruATXaA52JA6iVcXYFn+JqM1WhG3cQJVoPnc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mi2Jt-1kUdjS0Rft-00e5v7; Tue, 28
 Jul 2020 03:57:19 +0200
Subject: Re: [PATCH] btrfs-progs: Add basic .editorconfig
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Daniel Xu <dxu@dxuuu.xyz>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
References: <20200728012409.130252-1-dxu@dxuuu.xyz>
 <85567980-5c9f-99a9-80e3-89e6418ed86f@gmx.com>
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
 ABEBAAGJATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAK
 CRDCPZHzoSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gy
 fmtBnUaifnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsS
 oCEEynby72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAk
 ZkA523JGap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gG
 UO/iD/T5oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <349343e3-8687-d217-66f8-59d50e8a8ced@gmx.com>
Date:   Tue, 28 Jul 2020 09:57:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <85567980-5c9f-99a9-80e3-89e6418ed86f@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6wOZQAdliRI4Dflk9OHPJxBYBKW7cPRnk"
X-Provags-ID: V03:K1:rggZudmr8fssO78xBRC6jFaXePk3oz1saU/6AMs77d8o9nocCOj
 RWaHe8HY1GNKgSRastwQ54Mc+17Wvwo/ScRD8vutfVt+gqZGKcko2qPbn7HFsn+6OLxL1Vs
 TNXIJNPcMcAmZa83dfaelXSJR8/OuAyrrEMJTJxSYWGkWqf2WwxB3tGDcTp0bBMMhhDVala
 y4yniIo51rZlegtz3fv7A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6TzUdaWIRUE=:ihn8DGpmNRLmvrI1ra8AYO
 JMiRtU1apTnKyqp2hvB1GoOVu38vBg2m/7nKz9sOBRyUGnhKm4QnkaRY9UZzb0XZM3QG/Rj5Z
 0fa5yaaesoIEVD8/IEJp+UP8y+OP2Guqbi3+8EqYkrg0qh8+hUW4HxcUec6EKZe0dSjmERpK2
 sd4Tp9N03TXx1KAeJZcFJ8j1EW2d0x9/Maf96KlurnhVAEXWrS5vDYIuzG5yjKiaslI6jkC09
 RYX6zaDLklSt7nCwHm+0Y9AUfC83JKVYqfcEqM0QYAyzV469yTvhQEMGnjcmyrMetO/m+VGOP
 AjNb544y/InUFP4mg3dmxn/fvpDLs5A+U/FLV0LGLO9bJORCisS8MJ/W+r51aefjXgoLAXjhm
 0GMLh9u8OAx2b1sW7I2S/CZgtf6tF0kySPL5qWjzYmNSPSVvADVmEIDmd/Qkbrb0KJC+xmCW7
 epshi7ll2QxbV/vpkbE0BYQWw73Td3BofzdfYB5uZJ91H7ioX9dwjkZqQ7Vqs78r2wFe1f9VX
 qjzjbZZ+Dm2RVqbvBQlWxKAg/0ka4de/YTWHcllqW8ddfpDsug1CSPQB3tMM/mD6VYeiKu70k
 OerOdCyJoQ+/ofdmwvmqS29r8075j9dV4jR6wBdvwhd/psBHtYJtBpY2MjtzvjYhUH64TrFlQ
 HKIVpk2gNCSf9Xty/4DN/tUauzzZgGa5wDDCHt7fmTPfPMulmY4/sd+ITCiRIR8b99DVYI3YO
 THGQ66r38y54CbeUBSl+XeF3oY10JvOfnXCpGjU9ZPfaKUr/YGW329V2C/tLeE7SCuTS5J3G1
 O7+XU/PxvJjDrG0E6iJsbNRpRDYlv/qdzolWfIIQ7GYlpZVWBq7rZhQwzPqr3j+u6D4usPqZT
 XQCWUbelJPjGE4+12vDRHNNxwRTD5utXfht5diVlH3cAYG0DCQpGBbaDRHQunx6gFqRA6DYTu
 nY0K2u3BG3X47qSHQBHgdA+lTAMFIA7o3bljaKbh6wkPhzh5kcI7w2r9c+0b8g8y5AdimziY3
 p3l9+snWpXrXp6T3eGp89FABG9rpRr80DwG5nSnMSPD5/7a5R5O5BbY0D+2DTmheruhR50Qag
 Nx25yux8IOrsaM/QTsvrDrTcqzopscJkm9LAf4tkvz+uQC7iFQALm7R5hq80IrDB3KMPZqXes
 H9AWQrDiH0nLY1Cz60ijq1dQ5ioHt6OQmvHO3MQGWB18kurgCkNpYxr5vlTHvKp/o8+e0rD48
 P09kIDJaGtpAJUEJ5x2WE0R2I3CwddobNYF835g==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6wOZQAdliRI4Dflk9OHPJxBYBKW7cPRnk
Content-Type: multipart/mixed; boundary="hFiZdxh3ccYFdgSBgoDRCo4EXuyy9eckZ"

--hFiZdxh3ccYFdgSBgoDRCo4EXuyy9eckZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/28 =E4=B8=8A=E5=8D=889:50, Qu Wenruo wrote:
>=20
>=20
> On 2020/7/28 =E4=B8=8A=E5=8D=889:24, Daniel Xu wrote:
>> Not all contributors work on projects that use linux kernel coding
>> style. This commit adds a basic editorconfig [0] to assist contributor=
s
>> with managing configuration.
>>
>> [0]: https://editorconfig.org/
>=20
> I like the idea of the generic style file.
> It's just one single file for all editors.
>=20
> Although most btrfs developers I know use vim, and it's not supported
> natively, it shouldn't be a big problem, a plugin would handle it
> without problem.
>=20
>>
>> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
>=20
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>=20
> But a small nitpick inlined below.
>=20
>> ---
>>  .editorconfig | 10 ++++++++++
>>  .gitignore    |  1 +
>>  2 files changed, 11 insertions(+)
>>  create mode 100644 .editorconfig
>>
>> diff --git a/.editorconfig b/.editorconfig
>> new file mode 100644
>> index 00000000..2829cfbe
>> --- /dev/null
>> +++ b/.editorconfig
>> @@ -0,0 +1,10 @@
>> +[*]
>> +end_of_line =3D lf
>> +insert_final_newline =3D true
>> +trim_trailing_whitespace =3D true
>> +charset =3D utf-8
>> +indent_style =3D space

Wait for a minute, does that mean, we use space as indent?
IIRC kernel code style goes tab if possible?

Thanks,
Qu

>> +indent_size =3D 8
>> +
>> +[*.py]
>> +indent_size =3D 4
>> diff --git a/.gitignore b/.gitignore
>> index aadf9ae7..1c70ec94 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -65,6 +65,7 @@
>>  /cscope.in.out
>>  /cscope.po.out
>>  .*
>> +!.editorconfig
>=20
> You can force add that file and git should handle it without problem,
> and later modification would also be traced by git.
>=20
> Thanks,
> Qu
>=20
>>
>>  /Documentation/Makefile
>>  /Documentation/*.html
>> --
>> 2.27.0
>>
>=20


--hFiZdxh3ccYFdgSBgoDRCo4EXuyy9eckZ--

--6wOZQAdliRI4Dflk9OHPJxBYBKW7cPRnk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8fhfwACgkQwj2R86El
/qi46QgAkltthGJ8dzL7q/u74ITyXZEzLqK/hAf6ogLdgtvaqEu//Kpx6Je+OxFR
60whs5YTQrqj/6ydInKmjPC9Z+Sjv5iDH54NlJymzMZ43OGhCfBtpvbmoTmgj5LZ
N2W9Z9b3oP7055hQFeAEaur0DwSEdYhnqFlExwzVkLh4O2mjRYyDpncqn2CBSj2J
maUiHPDmBjD4DQHbNO47aoIZ9B2S0itKCJr/c4aCDiKpkMxP8NzfvIN/q6qoQzLZ
B/UVMvCEaixVxWRG4qjz2LmQWUIVilkQB/vgsX9Hy3jtIr6sh8eTb67drDGOXy4Z
zZxF6EAc423TXT3+7SoeCF9vO/FJ+Q==
=RylF
-----END PGP SIGNATURE-----

--6wOZQAdliRI4Dflk9OHPJxBYBKW7cPRnk--
