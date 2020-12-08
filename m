Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1DD2D2AB9
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 13:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgLHM1K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 07:27:10 -0500
Received: from mout.gmx.net ([212.227.17.21]:52593 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgLHM1K (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Dec 2020 07:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607430337;
        bh=z3hVgpDRiyqp8rNnraYdDMYZNsMMCC9qyeMItk8Cauw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Ls2D6JA3yNp6cXdTDQYcEKoRm1WzYFn2Zo738FqnywQx10FaXi62XHobBCrtgEt9g
         0rthjGCx27dEBEu5UJaY2uD5+UQC0raw12aTZDMEJxsSBcLy3ppGSjn7JmMInMdgDz
         RBjrbzUWs4vVNXiJ4DVOOgQg/NiFItg89kc0BX+E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOzOm-1kW2aT19gK-00PJrW; Tue, 08
 Dec 2020 13:25:37 +0100
Subject: Re: tree-checker corrupt leaf error
To:     Ross Vandegrift <ross@kallisti.us>, linux-btrfs@vger.kernel.org
References: <20201208010653.7r5smyo6vloqk7qv@vanvanmojo.kallisti.us>
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
Message-ID: <b3c3ef0d-13c7-f3e4-74b8-38c441fb9577@gmx.com>
Date:   Tue, 8 Dec 2020 20:25:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201208010653.7r5smyo6vloqk7qv@vanvanmojo.kallisti.us>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="F9o61kg41qSm6FbHoBcDqof6PsKnHetzd"
X-Provags-ID: V03:K1:bsYgPIsm+g6Opi7HEOSbz+omUMokSndjPIcolfKFCAjlcGgmgc1
 xVXjg6P/hbgRDlNBemW6lFuUPcw0oqiHJvNxbG+QDnQiyGR87jDfdN1yEU06waj7H/s7zRA
 vPC3si9R2kTHM5Z+Wm4O8Z8LDv+3kYUw3/WWnd0+E5FGIsTmo2i+1XmStjZ9FX3kcVpA0We
 w/WOCynncNT980BWddfTA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:l9szHux6I1c=:dutIqNhYM102jLhOgXnxsM
 lrCJCXODhdgKP8UO5FPTz2gfUCX6PqmI6zcMRqpY1zf3WQneg4jWNoh5bybA3H3s9mSQhnRQH
 ZDDtKwvAaTzK4z8eTNJbRi6ijGHEUy36PbOS9P2r7gznksRlges5KR7S5ZbBw5FUxd6CJAUzr
 NAAnayPzPa1Kn1KmocjMvikSOJaIz4V4Kd/MO1jw1umkes56DN62PARo6TFjGGcNRiS7pR1dl
 QQwvLXh5ZvCrg1mVbWNKas6vAkQGSRO8vZjesz9+cVefmPgRvIPZZE/i9Q1WP37LUT1nuF91u
 p8ErNfhoR/TKXEaLi5R4cl5za2V6bOUiY8asVfC5qQViNUqLUncdnLR9+M2DpzzfdiUlL+Lsj
 MBPkgGhfwv+bw5MuUIRV7amlNdT5e4tyCL4A9+GuirAC9XImolzcEEmXSGZuj7+mpwG9dKw2Y
 nkNM272qe+MvVBeiN1KvITUTgkikXb7T0C7cqXDpR1agH+cLJYE4LZqgJxi+6dm/WyxDpz9a7
 mZxAr4IjoMkedU0RLs6mLGSz3uBSgXxC5nEuu3tDQTfROOPri3COsu/VYnU2IA0WB/NoYm5r3
 o+HUio4S2BRjHWaXu6jRJSP+AM70skZwTVUk9E0daTgbHymJNJmZAuMBDpMTWOnvb01RoA3Ay
 28F8dxl/71G1+AasMmz5sJbfBLGgaH4r+oXs3LgQc4noPuww5OUkFmSKC81gChpguMW3bvCNf
 EjkBCtqzcF5U8fYzu4GR6XhUG9EcaUmSfX6PZP/oVNa+dR6rkEROGORp58K1piF35dvU5j0OH
 iraIMKSPTniQnbj5BO/+G1guqTbTXSqcrsIeCx24GEsPhqjZsszgR0ysbvwn5K1erijDGp6Tt
 F98Ukw8JrimS8oaXPa2A==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F9o61kg41qSm6FbHoBcDqof6PsKnHetzd
Content-Type: multipart/mixed; boundary="k6Sc4QouLbTMND3D8h03JYMCJvmlkwtwt"

--k6Sc4QouLbTMND3D8h03JYMCJvmlkwtwt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/8 =E4=B8=8A=E5=8D=889:06, Ross Vandegrift wrote:
> Hello,
>=20
> I've got a single-device btrfs filesystem that fails to mount and I'm
> not sure how to proceed:
>=20
> [  118.556075] BTRFS: device label backup devid 1 transid 55709 /dev/dm=
-21
> [  118.581857] BTRFS info (device dm-21): use zlib compression, level 3=

> [  118.581858] BTRFS info (device dm-21): disk space caching is enabled=

> [  120.035857] BTRFS info (device dm-21): enabling ssd optimizations
> [  120.037493] BTRFS critical (device dm-21): corrupt leaf: root=3D5 bl=
ock=3D3420303224832 slot=3D18 ino=3D265, invalid inode transid: has 14030=
1292396544 expect [0, 55710]
> [  120.065595] BTRFS critical (device dm-21): corrupt leaf: root=3D5 bl=
ock=3D3420303224832 slot=3D18 ino=3D265, invalid inode transid: has 14030=
1292396544 expect [0, 55710]
>=20
>=20
> The fs has been in use for a while with no obvious issue until now.  I
> got this message after upgrading from 4.19.118 -> 5.9.6 (from debian
> stable -> debian stable backports).  Nothing was done to this fs under
> 5.9 aside from trying to mount.  A different fs was converted from ext4=

> and mounted.
>=20
> The wiki suggests reverting to the working kernel, so I rebooted into
> 4.19.160 (stable was updated) - but now I get the same error on 4.19.
>=20
> The list archives point to using `btrfs inspect-internal inode-resolve`=

> to find problematic files and copying-then-deleting them.  But since I
> cannot mount, this doesn't work.
>=20
> Output of btrfs check is attached.  Thanks for any suggestions!

This is caused by an older kernel which puts garbage into the inode trans=
id.
And newer kernel introduces a check to find such garbage and exit more
or less gracefully before the garbage reach kernel memory.

The check is backported to v4.19, so starting from v4.19.156 the 4.19
kernel will also report such error.

I totally understand that this is very annoying, but to make btrfs more
robust against corrupted on-disk data, it's a necessary evil.

You can either rollback to even older kernel (v4.19.155 at most), or use
btrfs-progs v5.9 and run "btrfs check --repair <dev>" to repair it offlin=
e.

Thanks,
Qu
>=20
> Ross
>=20


--k6Sc4QouLbTMND3D8h03JYMCJvmlkwtwt--

--F9o61kg41qSm6FbHoBcDqof6PsKnHetzd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/PcL0ACgkQwj2R86El
/qhWaQf+LiIF7pZNHaaoeh5agqw7mL6VQuli1qdmwuHc2Kej6WIPIjVDtNnXX2uf
6mTYpOiuJcuYL/AHhSvinR5hO+Gt2Ss+Z7hq1kk3X0P3z0U3OtGDwZ/fxQRQHF4q
dICfK1v8T5HxJPbLrvRkfHw48TXRQv97IZoCJvZok9lP56SmsVsjqUzY242F0JrE
tZg+UddpdD+FfioxaeYUYgUQLwoYiobPgorYx8xwG5CL46g5bIUk/Mlqs1QBaw8J
/2jeRcNPKhUnFnNIy6q00tIZIZhTJ2JfLx9C21Mhdl1vhxmr2780FydGXaJdIMPA
jMqcrEq6jijnYksu2gsC/pQBCw+nGQ==
=uTYv
-----END PGP SIGNATURE-----

--F9o61kg41qSm6FbHoBcDqof6PsKnHetzd--
