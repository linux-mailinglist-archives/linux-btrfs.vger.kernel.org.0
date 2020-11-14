Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976892B2981
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Nov 2020 01:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgKNAJ7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 19:09:59 -0500
Received: from mout.gmx.net ([212.227.17.22]:34725 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbgKNAJ6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 19:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605312593;
        bh=fQQJhamnsVOiGu8oqE1jApgEJ0qTxW2ciMn7n1TTYsY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=W0Szskmk9wuHE3naC08YWcpskSicsMJOJ4vsMs4RkH+ey95JMsmHM1U3pkiipXhgT
         oaTe6kYMq2fyqgM5KneupbPJixNpqCgfyxcYa/YYhAV7SnootRtFSMwQteXoY5h2K/
         ZyJ0hwkWBvIbeB/YUcESyMow+IhV+neSTQF8U/sM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6KYb-1kFS812Ka1-016jWm; Sat, 14
 Nov 2020 01:09:53 +0100
Subject: Re: [PATCH] fstests: btrfs: check qgroup doesn't crash when beyond
 limit
To:     dsterba@suse.cz, fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
References: <20201111113152.136729-1-wqu@suse.com>
 <CAL3q7H5W6U4jYGBszQF59RLi-aehO9vBTNU_HMTi8hRfK7gjGg@mail.gmail.com>
 <d5cabe8e-37cb-42b7-9bd4-ba7ddca68b20@gmx.com>
 <20201113151946.GY6756@twin.jikos.cz>
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
Message-ID: <705e1226-2aaf-0d5f-45ed-03b25457e680@gmx.com>
Date:   Sat, 14 Nov 2020 08:09:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201113151946.GY6756@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UTQodH9m26fZgqrfvHLSUejYJRWrs7Nye"
X-Provags-ID: V03:K1:Fa8T3ftXZGlpUJw6V9iH1oBfloZ0cgfVpi1FXNV0ouUXYWD0wWn
 7KWwjdIDXbmR5te4/pLSVmq9RQu1yzEvri/bUm4vYI8TPaDTI8Zfn1OLytxwMkOQXrFEKbr
 x38QjocNbFA3tghmeBCzr8m7A8IoNr5FmhNTZn9L7auk6BLE6xauj4Jb4xJyJ39MVOgm0qx
 lnUsg88Sn70PntNRt/Y7Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kUSolHjDAhI=:oT8hdw8ZFMnpkyUFVDqjSm
 SdDL2swGywG10c3wzgTT8pz09+fSpTp1kf6C3soGLTqSM1JAqO/IW7SfQfFAotyGIsVcgeNy0
 Y4QfT5saWk81jUkY0h/UfszbEuS6dlRYfKWStEH/phTE1jNbL4owQ6jHcdLWzm78kd7+elei2
 NTDGun4XAzctkAYF+NqAWwsQSOAwF1xHwsOwTMjxhfREX5LcR7vT7h77MDug1r54CcU+40uFv
 UKYPc/FU6zdVaQ2RwBHnGo1YynnImUq/8zMmIPsnvIbB4Z5+LuRebvoyQEJjrbE//XZ9bel/p
 hFmMFZRnx6aZ5c2N+UJrHuOiLjjTa/CIkOOekjn7F1hYLUN4YIhmZu60d/0s5MokY6iOESAg9
 AAEU6NXxjUqsmDwSE0mlrbmmAzNKZ14j8Urd7i8qT0VT0H+GKvEBYznaV0120cPGGDI5ZiOh9
 LGSPrWK3goJ/mBobpOMiHsd4MYRirPbUY/LAMTcBkldw7TPcFRK5lBOUGHtAEi497HM1MArKZ
 rZpT20wPaiFhM79spZZFG/hqZYJUwNvsx7XvUClaky/D4G+xXRpI637V5SzEDHCe+kiHjLLyT
 D0b50NjaQ72eUOvfzmOv+W+EhYF4Af8yTW4FbE26vF4DLK6Xdi4Op2VRAdg/UYrh3sEafPNK8
 i2VSsvfJZ4VBzF7hVIdMsIrOfHwQ+F2Zfj7xEx5L7Zs2InG9jblgNVDCRzPhkYErJkgjL/jWm
 z4q4rVsfncHSrvUsjgzCdxp9bipOWTjwGdGuZ2OBsj2y/Z28nx9Mj6+2q7c6BuApg82TXi9sl
 UgSqeUEikCn0AF33lNa8NDF3ulbmg96tT1T73zrAEREB2k93Uh9vLYZ0DL/u+vmzaFRniA9E4
 NClDP5dCTzStvUmIqYBQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UTQodH9m26fZgqrfvHLSUejYJRWrs7Nye
Content-Type: multipart/mixed; boundary="rRk0Cupkunh4BCoNOibrqI8nJ9D7xAeaZ"

--rRk0Cupkunh4BCoNOibrqI8nJ9D7xAeaZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/13 =E4=B8=8B=E5=8D=8811:19, David Sterba wrote:
> On Thu, Nov 12, 2020 at 07:50:22AM +0800, Qu Wenruo wrote:
>>>> +$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
>>>> +$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
>>>> +
>>>> +# Set the limit to just 512MiB, which is way below the existing usa=
ge
>>>> +$BTRFS_UTIL_PROG qgroup limit  512M $SCRATCH_MNT $SCRATCH_MNT
>>>
>>> $SCRATCH_MNT twice by mistake, though the command still works and the=

>>> test still reproduces the issue.
>>
>> Nope, that's the expected behavior.
>>
>> Btrfs qgroup limit <size> <path>|<qgroupid> <path>
>>
>> The first path is to determine qgroupid, while the last path is to
>> determine the fs.
>>
>> In this particular case, since we're limit the 0/5 qgroup, it's also t=
he
>> as the mount point, thus we specific it twice.
>=20
> So why didn't you specify 0/5 so it's clear?
>=20
Oh no, my brain just shorted, and forgot that it's 0/5 fixed for fs tree.=


0/5 is indeed much better.

Thanks,
Qu


--rRk0Cupkunh4BCoNOibrqI8nJ9D7xAeaZ--

--UTQodH9m26fZgqrfvHLSUejYJRWrs7Nye
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+vIE0ACgkQwj2R86El
/qhdYgf8Dk5/Ni85Ct1bMlPrgckoqo62c7j6gdwtyfFlCIM/rnyhaabZd3JMXikP
y8PvL8YznfSUcEiCngmHXzbkz77hpBmr03hPI93xVDBxdwdAEgERqXubMb1gNxCl
RrH147bDCycgYhOPL0gyDBJLhF6loqUtWa7k7DWztE7aOblcpp5aWDmLD6lkeBQV
RqmHh/2ztf5XcQuS/JEBqD5SQYn/6N0DxTCmyAW6exApTQqnDWJLw9y2P6AI+0U3
cbGjpWh/1WKcaXYQghYgJli+MA3NFYvpILETrBfnGQRJdmFGrAfKbEK5A7lxi8cF
1pMTIs21frEsYs/Pc6yx6Lh090ASlg==
=s88X
-----END PGP SIGNATURE-----

--UTQodH9m26fZgqrfvHLSUejYJRWrs7Nye--
