Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1A3245A9E
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Aug 2020 04:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgHQCIg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Aug 2020 22:08:36 -0400
Received: from mout.gmx.net ([212.227.17.20]:50577 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgHQCIe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Aug 2020 22:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597630111;
        bh=5kWkynwXa03q6nIFR20HllBvo16XnT1Sqm7y1tqODGs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=jyPXT/LVAVZHjA4dFEUtfRXRmj0HYrAV7N6pzgZsW0a37k+CeitkKe99eh19D6aAz
         q8CAI4hMs24Z+gN+gvtJwsDRaMtK14oQiXjWS1w8R2WL6WOCxfPBZ6zxtQr6w1bugR
         wk8xg4H578Ac4/krYNPNQ37XPkPFa3A5XcBcu3wg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7b6b-1k1jwB1VAz-0084kb; Mon, 17
 Aug 2020 04:08:30 +0200
Subject: Re: AW: AW: Tree-checker Issue / Corrupt FS after upgrade ?
To:     benjamin.haendel@gmx.net
References: <000301d673b2$9c3a2ec0$d4ae8c40$@gmx.net>
 <a295225b-bfa2-f3ea-8c19-43f699ebddcc@gmx.com>
 <000d01d67431$4edca1b0$ec95e510$@gmx.net>
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
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <d11f303c-7e3d-2d28-6074-ad8ebb9539ad@gmx.com>
Date:   Mon, 17 Aug 2020 10:08:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <000d01d67431$4edca1b0$ec95e510$@gmx.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NvZ1VxMhrSFUEcIqkTCiXXhq8ecFzeDqh"
X-Provags-ID: V03:K1:yqkOtzSRYr5eGbdC46kMAq56TXBi5Q9wJu8jLkp42IEkJoxsmmB
 lnWhqOKSPBN2Bg5l5N6w1oGihc61avD1XtbVJt8GG6b2Kb7ydSCLcBV8rGqheAR7CHmA96B
 6HQT7pZ8rHcFa8iBdEoTYSaStC63hnkq2+3rDUIs3lT3YF9w4d8gIvWTPvpHAs63qh7+dDE
 eCDNdXrOSHJV1F5Z/X4jw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:w54D8EUnBZY=:hlToK4YLksXXA6Gs3SZ0nv
 B/tFptBFXu332sygMWE/A7v3aCKPx3MSVNd91GwUWbwU0UlzpIP/bo3OG7GfpP+r7qY94Gn0d
 2d3BD8/qlg/dDibikRjNda5R2oNF83eGKRP3T5lL9zX9uPYVgpz60f1yBw7eH91nAQ0uQ/PAH
 kTVg+Yum0Bfkl8Z8zY8ta+ealFKCDhlkTFg473qigncLgley2sFEmLlsyb2/RP3WT2LOhIM/G
 80dhVvHloIwXzYFXMKlI74RD6sKYDpeKNaYdWZfZBly2CFd5NrQDktVqNxZ836ywsHvSk5KlW
 UBMullP7p7iwOiyyi/2+3ED893XMmHSZ3pVB+92MjTCaaJAI7eEtM6WV9itjOzGSUa+A9iJzt
 RY/wTQOPuUAMYpSHuyFEImNgRE3YdW7aTjolodXG9MA1vx8ojneUyrjbNdXF0iTb0EG5Cd2Oo
 2DfZG206KSHw3gJ7QJEhy3SGnbkb9vqAa/szU/WopZpN1uVppmtdgjys9+iHePgyC+j004k3O
 wgeqhw0Nv5GpNJ/vZ37Jyy1/XWooR6MpgCDKgKerJ/Ap9MaDl42zjruWYG/IRBop4fHx+GC9b
 XHcuZiP7yE5t/CQXfIxZ9VSlGWod4d1lV6aHD6XW+EoU9s8Ag5h5devcF39YicDkZfdazekIm
 VO/8toMQ55oebo+Zpnfm9fjFBg/R8G/wxbvbW9S8nxmr3tmG0A+lHr4mwzQWzzw4C/Y/CkgDs
 6bMVANtnSpKdylYwTkCsFIbSPwEa5VxohZVHcRWePTpgwtQkkSn9Hbi3fw5F+D6mLrr/e+BHI
 i/yGVJ3RvhLZ3kezVHrcUJUI4Lo/9Umk+y2SAQuzgndV23q4EXIUJEaiZYswUP6/69y1ZVK1D
 reHxrLO/Fl6G9KuGXNKHxudnhCZUavvKKwEQP+8udjUuCAslJBKDgWLP5vEuKrluavUWWYBNW
 KroN5MqJW1SivGa9PRVLTQx+Be57xizahAxWMD7oiCj9WMq+rmhpAf5kehRDvo6++hcl+b/F0
 3aHwMFRdESGlj3x4QwMg95oTyEcx7YcjZC+ECqQjNDt2pSFETIvwzHpTCvcQwPBW3htENyeXM
 HLQmldfRf37QJ03jFWPY4Ql8QTMZX9MnNAaBpiosCO91CexoTiwvm8HhmM48LIfoLo4IBMqJc
 txIIYHZYNWwdHTNfFg278gvvSx0Z/pWsYheunhEgoA+CsmDH6WThRTQMdhIJIYiGsPrBfbtjL
 8LpOwHS9iukjXQtY7DI2zSLpDLL11GIUa9jt7rg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NvZ1VxMhrSFUEcIqkTCiXXhq8ecFzeDqh
Content-Type: multipart/mixed; boundary="zHrNG30vNznojpT6TSLzm0YhVkw1vUDg0"

--zHrNG30vNznojpT6TSLzm0YhVkw1vUDg0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/17 =E4=B8=8A=E5=8D=888:56, benjamin.haendel@gmx.net wrote:
> Hi Qu,
>=20
> attached are both dumps, the Chunk dump is rather large (8 MB-ish)so i =
zipped it.

Unfortunately, the lowmem mode is correct.

The extent 30077723082752 belongs to csum tree, but it is inside a data
chunk.
This looks like a bug, again, caused by older kernels.

This is a case where we can't recover by btrfs-check.

Thankfully, that problem can disappear if those involved tree blocks get
COWed (aka, defrag the whole fs), and they shouldn't cause any problem
nor prevent latest kernel to mount/read them.


For your current inode generation problem, they can be fixed without the
help of btrfs-check, but you still need to mount the fs with older kernel=
=2E

In your kernel log, locate the offending inodes by:
> [118342.511680] BTRFS critical (device dm-0): corrupt leaf:
root=3D5 block=3D22798248325120 slot=3D0 ino=3D747373811, invalid inode
generation: has 18446744073709551492 expect [0, 207862]

That ino=3D747373811 shows the inode number, root=3D5 shows the fs tree.

Then you only need to use the following command to copy that inode (of
course, use the older kernel which doesn't has such check):

# find <mnt> -inum 747373811
Which will locate the offending files, then you can just copy the files
to replace the original, or just remove them.

You need to execute this several times until all offending ones are remov=
ed.

=46rom your previous reply, the offending inodes are:
ino=3D746324257
ino=3D746324416
ino=3D746324557
ino=3D746324792
ino=3D746325907
ino=3D746455361
ino=3D746455691
ino=3D746458110
ino=3D746586563
ino=3D746587192
ino=3D746717976
ino=3D747372936
ino=3D747372980
ino=3D747373811
ino=3D747506165
ino=3D747506282


BTW, from your extent tree dump, your fs is really old, so old that a
lot of new optimizations are not enabled, and tons of older kernel bugs
are bothering your fs and causing problems.

I totally understand that migrating so many data is not an easy thing,
but I strongly recommend you to migrate the contents to a newly created
btrfs (and only mounted by kernel newer than v5.4)

Thanks,
Qu

>=20
> Best Regards,
> Ben
>=20
>=20
> -----Urspr=C3=BCngliche Nachricht-----
> Von: Qu Wenruo <quwenruo.btrfs@gmx.com>=20
> Gesendet: Montag, 17. August 2020 01:16
> An: benjamin.haendel@gmx.net
> Betreff: Re: AW: Tree-checker Issue / Corrupt FS after upgrade ?
>=20
>=20
>=20
> On 2020/8/16 =E4=B8=8B=E5=8D=885:50, benjamin.haendel@gmx.net wrote:
>> Hi Qu,
>>
>> attached the log that i ran with the piped ">" Output first (not as=20
>> much as i expected as i can not copy paste unlimited data sadly) and b=
elow the errors (there were many more) that i manually pasted as an examp=
le.
>=20
> It looks like the bad extent flags (possible a false alert) is masking =
the inode generation error.
>=20
> Thus it makes lowmem failed to repair.
>=20
> Would you please provide the following dump? (can be provided with moun=
ted fs)
>=20
> # btrfs ins dump-tree -t extent <device> | grep -A 10 300781367296
>=20
> # btrfs ins dump-tree -t chunk <device>
>=20
> Thanks,
> Qu=20
>=20


--zHrNG30vNznojpT6TSLzm0YhVkw1vUDg0--

--NvZ1VxMhrSFUEcIqkTCiXXhq8ecFzeDqh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl855psACgkQwj2R86El
/qjFQwf+OnxtLtZ5WE0CF4T6PJ5D66CAUTBr725dfyRF716T4cKheS1Z9FwsYJYu
JaEhZuwJqf3vEyJSC2D++VNspVrbn7StitmPQ9D34CGIVnjly2HR7Nd/t0gQzT5c
EGPnVogiypCUBBOGlpMeMwUf4sajYXY5X9yCJGnFRc5T+jgBa6S++0MbB2gThXbC
ljgKgyuO/lfxl0DQ9coosx3DYjbXyP6oZKtke0Ya0aKhQIK9vNF5Vz8ClKvTSkcJ
8gd+j1JbIwe/dq/ETJDZ4NPf+KMintHoOPuBBwujTs8FZLO/PjNJqlDL4/pZ85Wi
fvYujCNvoaO2PKQr5Pf0tG+hpKHzuQ==
=laZT
-----END PGP SIGNATURE-----

--NvZ1VxMhrSFUEcIqkTCiXXhq8ecFzeDqh--
