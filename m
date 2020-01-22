Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A121144ADF
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2020 05:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgAVElp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jan 2020 23:41:45 -0500
Received: from mout.gmx.net ([212.227.15.19]:52415 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbgAVElo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jan 2020 23:41:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579668101;
        bh=Jj25XT9PJwYUQpTTmqBGzrF2yakH5NgfRca0F31C3xo=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=iS1Q0JU6W8foFQEqemz5azKKzm8GkPq5taFYXcfGm7p64bcrGOuA/ypAI4xn44fiu
         Em77FR6LZXSANZUk+/qrL4IcI/H7sdc0tbXojdho3dqkfsnWV6WKsxWSWNe2u/22fk
         gmaa+Q12UPZRaezSyis/McLGrlM3bQkCb3htkf1U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mlw7V-1jJati0PcB-00j0fu; Wed, 22
 Jan 2020 05:41:41 +0100
Subject: Re: BTRFS critical / corrupt leaf
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     =?UTF-8?B?T25kxZllaiBWw6HFiGE=?= <vana.ondrej@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAP9tsLnvnoapn_uT0Bi6_XBAAAyEyL0AirnGVxZ3AB74AQuc+w@mail.gmail.com>
 <75c522e9-88ff-0b9d-1ede-b524388d42d1@gmx.com>
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
Message-ID: <a0f94844-d18f-8801-0c8f-3eef01de7782@gmx.com>
Date:   Wed, 22 Jan 2020 12:41:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <75c522e9-88ff-0b9d-1ede-b524388d42d1@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="X9pwDCSeFPC7sUkoCptgg499fFgzeG7PY"
X-Provags-ID: V03:K1:EhhzIJ7UdH5mhPjaAUkHeOiBPVMVqvVlBgsCebK5diS6oeqhsTX
 Ncx9wkVMIJkct1jWeqGetQEPMQIk5k6SvMPtcLllhFzhHQvAzY4YNh8V1t7FUCRJDg52zWz
 98ctpnjxqTHW4eAhPL2PqQddrtvARGWMVx3Wfe9GPoxneiNLRkmb3WivtkJ5ajaejukaYB5
 VUgrP/9rDbjBc0gBRKFJQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q/rcXiY+Sa4=:G4mN0h+04Wda1CzTs7AY4N
 I2CcUp816xUd1Ov4RjbAKICyOPZYP/fehW6W9e0E9/1AgdLwI9QGlCMEpPdM8TE5+qiTNX3UN
 msGCg7LCXQm4zacAWATesl7EMGDxrdbqtZY4B5AVcaU3oQ+bExnLoPY9UN+U+r64pzyZ7CWPn
 Fn3FREPPaGevNoLXsKLpUK3BkXqzFow7oEGLk6QtOB/t94qBoesE1VhuHKjxIh28SPjCnUEom
 DN5dHO0eZwu7ObHGRLeZ9o25NtY74Mz6QR2jaMurJ0Rnx0FG4K0fhFrYEeIU4WRA0dr+bETO+
 mj5hYFCR21YnbVp9zOB54n/rYOKOUyiiZlFmSaN4Sde+p8eBVop8JwhYOmGNre8xsfZqys7e7
 8CT/zhrDGAeHio3XuB+vVppjHBpG/fs2so/HjBfwiP+VHI5SYL0NjsNaRuaJ0Bjgm/37Savrq
 WqL1KEWyQgu7lJ/xsQOnb+3W7pukt9GzXwTKI1voIjqV4vWKqV4KfhSlwdwnZmD3kgf7z7+Pd
 TKajizg65cACSwGNWbnRlcc5Sq97ymycbevizbJK/ZwDvj5H4qPWYay8OEaPNhEhIrXgwrcmN
 m2ep3eb2Hg6+PoFLl73JBKSIgiuwxO8bZzXK5InuUK67hoAkZPfX/AAC1q0PqreMsrK8LRXBw
 FWOiSy1A032Hsx7SoBEAoTHa7Ty/egbKA5j41jZqiAB7b17H/VVpfEyjy3jjSW+hEmMbWzuVa
 h6kCRHKylz2+gZ3nkCwFoyqkxxNdWqkY/bOmq3doQplPOXYXRO61JAw5FR1I+EIrp436nje1x
 DqCv4ZPBoG7rTgurtTlp7TFG3D5nnwH1a35oPRBo8eaIUJMdZihYSfE4pHhGEKoufq/F26aaE
 r1vWHq6maGLwyJW0obw8vCsetY13ZYUq1RgEpX58RigbgOPW/G8rMxj2OvNObomks2NqgalDN
 yYAgG9Tcewdb6TfikIeVKYbGPVT/qieTg5WkeKfXDIrX4GnGPNQ+m7xZv61UwUa8o3LTW6KaP
 hiPxSFlXKsNJdKXcQJBUK7egNvJUx635THIu3XgeNe9Ts8D5RuvMw2Zpi4rAgPf23BRetZHEy
 8uXCH3QMTpaU+GvxxuoQFJxcpazNigbacBWCsFrc5IVweHcZ0/y/A061oE34VFYAy/zN/jxAK
 St74y17x0+eaUJ3p+pxDlUysqPCfLUSJ063L2JKra3ouzktt3UuaSyawkZ6hK6YSYEFPA0sde
 qdH4uRpAp4e54gun5hE+QW8c/vQAA3iqohHzPb2jaEzuGjTygieQ6ndoPG+g=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--X9pwDCSeFPC7sUkoCptgg499fFgzeG7PY
Content-Type: multipart/mixed; boundary="J7kvXjFxa8VARX12vSwWI0dxo0BapwFad"

--J7kvXjFxa8VARX12vSwWI0dxo0BapwFad
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/22 =E4=B8=8A=E5=8D=8811:39, Qu Wenruo wrote:
>=20
>=20
> On 2020/1/22 =E4=B8=8A=E5=8D=8811:29, Ond=C5=99ej V=C3=A1=C5=88a wrote:=

>> Hello!
>> I've ran into an issue mounting my /home due to this error:
>> `[ 1567.750050] BTRFS critical (device sdb5): corrupt leaf:
>> block=3D135314751488 slot=3D67 extent bytenr=3D101613793280 len=3D1342=
17728
>> invalid generation, have 500462508591547182 expect (0, 222245]`
>=20
> This looks like an error caused by older kernel.
>=20
> So I guess your fs is created some time ago right?
>=20
>>
>> Now before seeing the note about contacting the mailing list, I did
>> run `btrfs check --repair /dev/sdb5`, though it did not find or
>> correct any errors.
>=20
> You need btrfs-progs v5.4.1 to "detect" the problem.
> But repair needs to be done using this branch:
> https://github.com/adam900710/btrfs-progs/tree/extent_gen_repair
>=20
>>
>> Tried booting older kernels from snapshots and the issue persists.
>>
>> Now some time between my restarts, the error trying to mount stopped
>> displaying the corrupt leaf error and now says there's an unclean
>> windows filesystem or just 'mount: /home: wrong fs type, bad option,
>> bad superblock on /dev/sdb5, missing codepage or helper program, or
>> other error.', but the partition is certainly btrfs.
>>
>> Here's the required output:
>> ```
>> kachna:/oops # uname -a
>> Linux kachna.kachna 5.4.10-1-default #1 SMP Thu Jan 9 15:45:45 UTC
>> 2020 (556a6fe) x86_64 x86_64 x86_64 GNU/Linux
>> kachna:/oops #   btrfs --version
>> btrfs-progs v5.4
>> kachna:/oops #   btrfs fi show
>> Label: none  uuid: 7dc4b27d-8946-418f-a790-a3eeeac213ba
>>        Total devices 1 FS bytes used 23.54GiB
>>        devid    1 size 30.00GiB used 27.55GiB path /dev/sdb3
>>
>> Label: 'Home'  uuid: 1c0257d6-77ea-4d0c-ad16-2b99114f4e5e
>>        Total devices 1 FS bytes used 128.05GiB
>>        devid    1 size 163.47GiB used 140.02GiB path /dev/sdb5
>>
>> kachna:/oops #   btrfs fi df /home
>> ERROR: not a btrfs filesystem: /home
>> ```
>>
>> I did read through some seemingly related mailing list threads, tried
>> running on individual RAM modules to see if one of them could be
>> faulty but nothing seems to make a difference.
>>
>> Is there any way to recover the partition?
>=20
> You can just mount use v5.3 kernel without problem.
>=20
> Then locate the file owning that extent by:
> # btrfs ins logical-resolve 101613793280 </mnt>
>=20
> Then remove all involved files if they are not important.
> Or just rewrite them with the same content.
>=20
> Then the fs should be gone.

s/fs/problem/

>=20
> Alternatively, you can try that mentioned branch to repair it, but the
> above logical-resolve and delete method should be safer than that
> experimental branch.
>=20
> Thanks,
> Qu
>=20
>>
>> Cheers!
>>
>=20


--J7kvXjFxa8VARX12vSwWI0dxo0BapwFad--

--X9pwDCSeFPC7sUkoCptgg499fFgzeG7PY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4n0oIACgkQwj2R86El
/qhrCwgAo7gq+sOThAw0ors540hQHnGrX033xK3ku2n92t34nz8L0ne5kXq9HASn
+/ID7Mx9DW5xZpQth1wbeG6wSWgb3ZjlvN6kc8c1f69cf32KRXWRV3tTUdndeysJ
JYvI5cwy0V0nfKEt59ipRIEgvShkfNJUD5D+eTwsy1s7vCdgc70yzQswG1oqMVRO
u/ShXxJZFWCvRvualRTnGo+s7xRoubaTcF1HFokcrx+QspKJYFEOY78igjOAmshs
annqYVY9vjoicFb59MWru30w4I0QQh5Nl9byeKI1BhS6GtvZ2Dl4IyCHcsV+h+tg
WzPpIb9adqiy3ZsjDqVy/asvkpCXTg==
=QB52
-----END PGP SIGNATURE-----

--X9pwDCSeFPC7sUkoCptgg499fFgzeG7PY--
