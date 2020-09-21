Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE8D272204
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 13:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgIULON (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 07:14:13 -0400
Received: from mout.gmx.net ([212.227.17.21]:35271 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgIULOM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 07:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600686848;
        bh=cfOt07FQ9/3Nywat9sGRujfM4HyiVGR9ZDFRRTFzL2c=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=lsa90y1DNRjw26iTcpmFgi6wfa52qf6JNdWymW1B7BtDxlAAJq7AugwdMFQSpQkZK
         HTw57Y67OTMm9QYcJQg1PZ7oY+m1YDmWq9eKmbIDosCS9fcxIqeE05xfrrze/PZLKu
         xH3ilBttvfd92nyXJxR3HFPkukihkkoJLdNOjQ6c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M1Ycl-1kIvnP0VdT-0031XM; Mon, 21
 Sep 2020 13:14:08 +0200
Subject: Re: external harddisk: bogus corrupt leaf error?
To:     Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs@vger.kernel.org
References: <1978673.BsW9qxMyvF@merkaba>
 <111a2551-98c1-61f4-8981-3f7de4b9084a@gmx.com> <4131924.Vjtf9Mc2VK@merkaba>
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
Message-ID: <8d2987f8-e27e-eedb-164f-b05d74ad8f3b@gmx.com>
Date:   Mon, 21 Sep 2020 19:14:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <4131924.Vjtf9Mc2VK@merkaba>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZC5C9jqb3pePvbOQLCDJJbpafMxMQyM9v"
X-Provags-ID: V03:K1:mJ+HXWpcp4Q3gn0anml2cMZuPzzkKLmRNC9l6phc5IiFT3kCdD6
 RLKy6WP5rUKRY1TgXAaU7ojTfwSFH2WoXhRAoLqtsolHqWhFhJVoV07AeLLGWK4Gan7+GiU
 JZ55FUxTAgyr9PPKJOR5zATlx7bZxi/TnV/JyvdErYzalzlJqlTqFfvax7WS9kF9bfEsgSD
 sme0wUpi+hGm/j0j4wfoQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9dX+1pHCUi8=:VqdKnjNA6tbLLJDiW681nk
 jv+3rx/eo1o7pjbqBt4/ZN5EfUW8siKdyeMkT9IisBe8DVdMa+U/pdPTmPPbLeGdcaXiDlg2r
 b2n8PaCUUdDhMdPTOCPw/bYwzrZ8frKV9pl/UxRDJrBy4k4My7gNX1VMUgD2XFao0cGicYyr4
 qVuzZsO555oV0IkRAei9c2zZNEFo0WHrlZzTzB0wZc8m34ABrsx3biv99wRw0o8lWjBWk+mTW
 RiSc5oyfTGQCXiNJFXlfvzfEcQcMqbav4ZKxVaj/1ow1O5+uay6LgCzrvYaOemazBaWVFBDy8
 m+NZQmDBaYupBa90pnuoEH5C6W0csBGpaWhVMFq+1874nIv6MGui1wXwjzPQRUFWW6c+oc81b
 gcupnGNQbo9BGdO5UpWevnsGr8F5UwfAtel+nx/EV7m/ONJgnhJc8YB5U5MnykXvYTIY5pTrr
 cLoWFuNRcVNudvWMjizMNIhAqBNXQa7TYSeGv+SovfuWEmyv90EF40ha6GU9jNVtC7aQCkQPS
 a4SFwbmDDmc/48kwsKXNOtE92UMaMW5amfb9sR0pE/ydjRRjZdqayaqzctyae6YCzZCsmttjY
 2oXdcdGuxDomoYdUqc/SCANmdGf+lGn1oxqSkI1BLwlBFJS9yXdqddiE2ttoRtkSXAXVlFsfg
 bGwxjJDBhyIrL5Fd8pfKMfglujVzlKhNqgFxGqQ4LmXI/SzncTg3RQqgcUR6c42KsKYH9w9Zm
 STTgzvxNmgRr8upAYCstdjwmj4bNecAjFz6fu30oVjFTXYZ+uVJuTZg1Liq+skza8XhOKk7Q3
 eihJZUDK6QuBc47Olw0EBzWvKYs1tg9h1GyN+9OhY7nF9d0mmKjYX3TWSkbOMhLgH8KptwkQg
 WKMb3fm81V6X/Pyg7ZfGtZd6SjuYQM/0K3A1ddG3sRCkFZ0IGQR26vQjK5Hh+YlgA+EFoPwBJ
 /Q+gKX44j1iC77HQ/3ml+G2rvNtwkxykhKhDR4RNufd/60DYmb1Isflh0/1WdMQwIsz2x1YAj
 lT2A/hjcpUpl+5dQrePD2QoISdFAWcbIB6IVUeIE360fzdA835HEmQN3KEGgLhmu8weDTkGOo
 vO7enYi39ltk6RP8vXFjq5AqDOQtiL1XEC1SvM4GYSB0ybyQc1mFZoibcsEb4dyrfFbUZXRN5
 53lNfniRTNln9nhEFI9AgbGCd/DCybjIpnVnG5nwDj9vVNZsDIoBk2yWRgWnY5HS3llqKoTxf
 EpiKoPsMCkQiwJfWneM3ZoqSdsXpSzHCAjI1sGA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZC5C9jqb3pePvbOQLCDJJbpafMxMQyM9v
Content-Type: multipart/mixed; boundary="GmYZOCw0uruYbFCj4TXOe0pMeeip2QOTp"

--GmYZOCw0uruYbFCj4TXOe0pMeeip2QOTp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/21 =E4=B8=8B=E5=8D=886:30, Martin Steigerwald wrote:
> Qu Wenruo - 21.09.20, 12:09:01 CEST:
>> On 2020/9/21 =E4=B8=8B=E5=8D=885:29, Martin Steigerwald wrote:
>>> Hi!
>>>
>>> I have an external 500 GB harddisk with BTRFS. On mounting it the
>>> kernel (5.9-rc5, vanilla, self compiled) reports:
>>>
>>> [282409.344208] BTRFS info (device sdc1): enabling auto defrag
>>> [282409.344222] BTRFS info (device sdc1): use zstd compression,
>>> level 3 [282409.344225] BTRFS info (device sdc1): disk space
>>> caching is enabled [282409.465837] BTRFS critical (device sdc1):
>>> corrupt leaf: root=3D1 block=3D906756096 slot=3D204, invalid root ite=
m
>>> size, have 239 expect 439
>> This one can only be detected by kernel, not btrfs check yet.
>>
>> Recently kernel has much more strict checks than btrfs-check,
>> sometimes it can be too strict, as some error is not really going to
>> cause problems, but just against on-disk format.
>>
>> And this is the case.
>>
>> In theory, you can mount the fs with older kernel, any kernel older
>> than commit 259ee7754b67 ("btrfs: tree-checker: Add ROOT_ITEM check")
>> should still be able to mount the fs.
>=20
> Oh, I can still mount the filesystem just fine, so no problem there.
>=20
>> For workaround, you can dump the tree block 906756096, locate the slot=

>> 204, see what tree root it is.
>=20
> While mounted, as the scrub is still running:
>=20
> btrfs-progs v5.7=20
> leaf 906756096 items 205 free space 2555 generation 12080 owner ROOT_TR=
EE
> leaf 906756096 flags 0x1(WRITTEN) backref revision 1
> fs uuid [=E2=80=A6]
>=20
> [=E2=80=A6]
>=20
>         item 204 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 7680 itemsiz=
e 239
>                 generation 4 root_dirid 256 bytenr 29442048 level 0 ref=
s 1
>                 lastsnap 0 byte_limit 0 bytes_used 16384 flags 0x0(none=
)
>                 drop key (0 UNKNOWN.0 0) level 0
>=20
> Now what does that tell me?

Oh, that's data reloc tree. It can't be easily fixed by regular
operations, we may have to craft a special repairer for you to repair tha=
t.

>=20
>> If it's a subvolume/snapshot, deleting it should solve the problem,
>> even for the latest kernel.
>=20
> The device has just one subvolume except root subvolume:
>=20
> % btrfs subvol list /mnt/amazon=20
> ID 258 gen 12560 top level 5 path daten

Yep, that data reloc tree is not visible to the user, thus much tricker
to handle.

>=20
>> For the root cause, it should be some older kernel creating the wrong
>> root item size.
>> I can't find the commit but it should be pretty old, as after v5.4 we
>> have mandatory write time tree checks, which will reject such write
>> directly.
>=20
> So eventually I would have to backup the disk and create FS from scratc=
h
> to get rid of the error? Or can I, even if its no subvolume involved, f=
ind the
> item affected, copy it somewhere else and then write it to the disk aga=
in?

That's the theory.

We can easily rebuild that data reloc tree, since it should be empty if
balance is not running.

But we don't have it ready at hand in btrfs-progs...

So you may either want to wait until some quick dirty fixer arrives, or
can start backup right now.
All the data/files shouldn't be affected at all.

Thanks,
Qu

>=20
>> Thanks,
>> Qu
>=20
> Somehow I am reminded of mister Q in Star Trek=E2=80=A6 :)
>=20
> Thank you!
> Martin
> =20
>>> Note: It has used LZO compression before, but I switched mount
>>> option to zstd meanwhile.
>>>
>>> However, btrfs-progds 5.7 gives:
>>>
>>> % btrfs check /dev/sdc1
>>> Opening filesystem to check...
>>> Checking filesystem on /dev/sdc1
>>> UUID: [=E2=80=A6]
>>> [1/7] checking root items
>>> [2/7] checking extents
>>> [3/7] checking free space cache
>>> [4/7] checking fs roots
>>> [5/7] checking only csums items (without verifying data)
>>> [6/7] checking root refs
>>> [7/7] checking quota groups skipped (not enabled on this FS)
>>> found 249031409664 bytes used, no error found
>>> total csum bytes: 242738928
>>> total tree bytes: 352387072
>>> total fs tree bytes: 67747840
>>> total extent tree bytes: 14565376
>>> btree space waste bytes: 37691414
>>> file data blocks allocated: 1067158315008
>>>
>>>  referenced 247077785600
>>>
>>> Is this kernel message in error? Or does 'btrfs check' not check for
>>> this error yet?
>>>
>>> Here some more information:
> [=E2=80=A6]
>=20


--GmYZOCw0uruYbFCj4TXOe0pMeeip2QOTp--

--ZC5C9jqb3pePvbOQLCDJJbpafMxMQyM9v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9oiv0ACgkQwj2R86El
/qjrAAgAn34qM4+NdoNuzuFn/rhtavxh+1H/065oOIMLsJL5qs08TCdeM2ifJwGn
17LnhgUs7aZL1ogRMIXcCd2S7EXpk2sVCRPNcIQd1MVb0gMj6LuzP7OxNnfaRpfH
weRxCOkpu6o0luyJYEHL+wKLVbf3Puf/W4BYw5ZA/LkuvfO6IrOLUhNvqYO4bpEH
V7758ATZzp5ZzU7ejYyCC0hms2zNDXQYa2GTfVkuEizVsJasOBgf46uTkQ0Oiz3h
/f3veZPwEvj+nXR8zYsUUE6OTA25IXDb4h09V+8dMxVnMHDF6D5oJclnrqm3DOzB
QCOPHqiNSNZHMt9eKCuwOo+1zBy1nw==
=vZgX
-----END PGP SIGNATURE-----

--ZC5C9jqb3pePvbOQLCDJJbpafMxMQyM9v--
