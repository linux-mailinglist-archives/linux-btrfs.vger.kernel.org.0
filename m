Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05BE212BD86
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Dec 2019 13:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfL1MGF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Dec 2019 07:06:05 -0500
Received: from mout.gmx.net ([212.227.15.15]:54663 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbfL1MGE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Dec 2019 07:06:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577534759;
        bh=kk/g3kHW/AcPZ+l9HGRPuFHXCO6bE02jr/4osM/Hc80=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=U/eYTxZDYUtIEAnw0wiWwhPwoDKNqtqT8pnB5YxDvnyUQuUBNNtSvl3dKpROo6r4g
         e0sGk9TwXyD3W537ODAGiPs1ULnXYnASzDkXJmKwElkyzTSA5U1s3b8Qwzmt6JZF/S
         T6+kp2u8TJV4Lof62HrWCbZeI9nF1ds5Ay2Wky4o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mel7v-1jJ85r0sJJ-00aoRF; Sat, 28
 Dec 2019 13:05:59 +0100
Subject: Re: Error during balancing '/': Input/output error
To:     Michael Ruiz <michael@mruiz.dev>, linux-btrfs@vger.kernel.org
References: <4196932.LvFx2qVVIh@archlinux> <9620299.nUPlyArG6x@archlinux>
 <c6a2b628-66b4-6bcb-7af5-48f1edb65522@gmx.com> <3499056.kQq0lBPeGt@archlinux>
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
Message-ID: <f6659a3b-9720-40dd-df3b-064fa4c393c8@gmx.com>
Date:   Sat, 28 Dec 2019 20:05:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <3499056.kQq0lBPeGt@archlinux>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rotfBT8T5bgpkOZLI13QqRnvArv92tM53"
X-Provags-ID: V03:K1:lltQ2bFFXaEveDhKRq/klQe0/3b/yBBZdurf2C+gmkIWAsJHo6r
 dZdzuRKB2V3QL6O7e0Ik9Bi/GzCdYl8Uep0svrIFoaa/2o/CkWVYPCWUBu/K1NroCNrSVJL
 nimIn05/vUOSQv86oLVG0LOtqQKHEcmlvccvNVH/xY+A3l5wBy8QLBxxr5JTAjQgkQ3R1bg
 24DFNg5juJZAgt0XwARCA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hmoYcLAWqNw=:/LCfwL+XjuYZCdcBQ2M920
 5x3Uo1az4+vwWOhqfNMvJfnEqvrGQ6aKNtrq9rzIK2RydrGoJ8hKTBWdEiMzAPauXrNP3Hh72
 VJ0iScrWApo/l72d0lffTf9hdPvPzodIIbMZLMEVQIv+RdRdCpfy0xBWApVGnNSzatgO0O2LJ
 d7jl3geOySDzlWLwk8r+sDZ5GephabWYzqOlvFQQ+srYH0Y1+2c1CSq5/nRZAeGlit6LqJGfx
 LxOX73Gd6qkI5ceTBiQ2P9NiGjjtxHvJXnRia6rdZZhgfxZ1sgFVN5hTxcxfmWtQTS7RioJx4
 a84QB7brHjtEVUaMBYKYiOITD3OBiWu+CzjC9NbixyKpqdXeiA8gxQ+iLrhmBEMDKNfJxRuv3
 bVUHCXlB8W9tebmL2PboPpe2dMnesrBDFt95HBU45vl/e7Xh8BlArYDCr9BXnDfvxOkHELwKw
 e79A0bffiWTFVrCgsWfnOVP9ym/Ln6R8h6nc4DE+HqKL2CVnobjPj1O5a4CgAY7KeJjtN21GO
 s+x6DCSnyWBFX+k5BNVXE6Auyk+y8jfIufOetob4la8RFzdm/8qxPZM/YFdJeh0fF7OXJbv7K
 r+hCmyinhabdwynI1mqh+Cq75edZv9VRyoHJ6Z3LgPiakgPrzwot6nAWUmbhVna9Lszpm+V0h
 mk5VZwB3FskznvH6kqNrVRc87NtbEipnFb5cvAtPHoTXAqP/m5FwBnSMdLHzZkbsUU7vzu/c3
 ldP4pO6TW8a2COkEKhL95ILvaOdTrmAddcYdoSRJqYInb14Uu2gL7tK6NmmB5TxSz0b39LFmb
 JBc62mdZ/hVxl+h/Q0CGY+s2Sv7fTgOWcvEZscy/jJK54u+qhN7IXxkbF//L/lV+IRkYQD6+m
 ANC5Pat3RODEu6A7ueWwZ6+QPisepaM0DyUweP/fDhkNYq5b70pqNXGzO//AzyTWh6nv4OtgG
 4v2lv4vf1jxsEiNjU0NSg/ik+FY4LmZiWFTjHNWoJdKKjPy6xB1u+IL7hFsVMdCtAzx+GzYRv
 PZEjfK8zfdrUACViFiN3RCF/E9viiMH0rd4xhhpxHReD03OYhmDtpDf+JDGgf6KJeU1m+mz03
 3cJcPxP2HlByFFkFzpoIxKsz6LQm6ovYvrApQakPRm4awUUy//F40g1MQA0f+gKYCvq+Hpkvs
 JT9q60H95GZ39PH0JHWqFiv+yB1STYbFC2ezT90jzLwtZmEMhPzAHfjK1J0ieCe9jy7JVDgfD
 fPrEo/rC7uQ7/6uu1BWLXlpvOSeyHr4MQN7m4BS43zi5xYmGytnFVA3RoeqU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rotfBT8T5bgpkOZLI13QqRnvArv92tM53
Content-Type: multipart/mixed; boundary="JSy7MDpILk3OkHGbdn7N6ukRwUWsQvONQ"

--JSy7MDpILk3OkHGbdn7N6ukRwUWsQvONQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/28 =E4=B8=8B=E5=8D=887:45, Michael Ruiz wrote:
> On Saturday, December 28, 2019 3:38:48 AM PST you wrote:
>>
>> Dmesg please, as that shows which file(s) is involved.
>>
>> Thanks,
>> Qu
>=20
> Sure thing, it appears they are all from firefox cache.. Perhaps they a=
re=20
> failing checksum because they were modified since I converted the parti=
tion=20
> earlier this week? I'm just guessing. Would you reccomend deleting thes=
e files=20
> manually or running btrfs check?
> Thanks
>=20
> ``` BEGIN DMESG OUTPUT ```
> [ 5638.996798] BTRFS warning (device dm-1): checksum error at logical=20
> 253563510784 on dev /dev/mapper/volgroup0-lv_root, physical 85319491584=
, root=20
> 5, inode 6477931, offset 8192, length 4096, links 1 (path: home/
> michael/.mozilla/firefox/default/storage/default/https+++www.pinterest.=
com/
> cache/morgue/16/{b696bf53-d26a-48eb-9688-ab3c5fd49010}.final)

Doesn't this filename look familiar with previous logical-resolve output?=
 :)

[michael@archlinux /]$ sudo btrfs ins logical-resolve 253563502592 /
//home/michael/.mozilla/firefox/default/storage/default/https++
+www.pinterest.com/cache/morgue/16/{b696bf53-d26a-48eb-9688-
ab3c5fd49010}.final

The URL, the UUID, they all matches!

So yep, the file itself doesn't match its csum in the first place.

It looks like balance doesn't go regular file csum checking, but copy
all data and all csum without verifying them, then check the csum of
data reloc tree instead.

Thus this causes this hard-to-locate corrupted files.
We should make it more user-friendly I guess.


And obviously, just remove the offending files should allow you continue.=


Thanks,
Qu

> [ 5638.996805] BTRFS warning (device dm-1): checksum error at logical=20
> 253563502592 on dev /dev/mapper/volgroup0-lv_root, physical 85319483392=
, root=20
> 5, inode 6477931, offset 0, length 4096, links 1 (path: home/michael/.m=
ozilla/
> firefox/default/storage/default/https+++www.pinterest.com/cache/morgue/=
16/
> {b696bf53-d26a-48eb-9688-ab3c5fd49010}.final)
> [ 5638.996808] BTRFS error (device dm-1): bdev /dev/mapper/volgroup0-lv=
_root=20
> errs: wr 0, rd 0, flush 0, corrupt 17, gen 0
> [ 5638.996812] BTRFS error (device dm-1): unable to fixup (regular) err=
or at=20
> logical 253563510784 on dev /dev/mapper/volgroup0-lv_root
> [ 5638.996815] BTRFS error (device dm-1): bdev /dev/mapper/volgroup0-lv=
_root=20
> errs: wr 0, rd 0, flush 0, corrupt 18, gen 0
> [ 5638.996818] BTRFS error (device dm-1): unable to fixup (regular) err=
or at=20
> logical 253563502592 on dev /dev/mapper/volgroup0-lv_root
> [ 5638.997338] BTRFS warning (device dm-1): checksum error at logical=20
> 253563506688 on dev /dev/mapper/volgroup0-lv_root, physical 85319487488=
, root=20
> 5, inode 6477931, offset 4096, length 4096, links 1 (path: home/
> michael/.mozilla/firefox/default/storage/default/https+++www.pinterest.=
com/
> cache/morgue/16/{b696bf53-d26a-48eb-9688-ab3c5fd49010}.final)
> [ 5638.997344] BTRFS error (device dm-1): bdev /dev/mapper/volgroup0-lv=
_root=20
> errs: wr 0, rd 0, flush 0, corrupt 19, gen 0
> [ 5638.997348] BTRFS error (device dm-1): unable to fixup (regular) err=
or at=20
> logical 253563506688 on dev /dev/mapper/volgroup0-lv_root
> [ 5638.997526] BTRFS warning (device dm-1): checksum error at logical=20
> 253563514880 on dev /dev/mapper/volgroup0-lv_root, physical 85319495680=
, root=20
> 5, inode 6477931, offset 12288, length 4096, links 1 (path: home/
> michael/.mozilla/firefox/default/storage/default/https+++www.pinterest.=
com/
> cache/morgue/16/{b696bf53-d26a-48eb-9688-ab3c5fd49010}.final)
> [ 5638.997531] BTRFS error (device dm-1): bdev /dev/mapper/volgroup0-lv=
_root=20
> errs: wr 0, rd 0, flush 0, corrupt 20, gen 0
> [ 5638.997533] BTRFS error (device dm-1): unable to fixup (regular) err=
or at=20
> logical 253563514880 on dev /dev/mapper/volgroup0-lv_root
> [ 5638.998086] BTRFS warning (device dm-1): checksum error at logical=20
> 253563518976 on dev /dev/mapper/volgroup0-lv_root, physical 85319499776=
, root=20
> 5, inode 6477931, offset 16384, length 4096, links 1 (path: home/
> michael/.mozilla/firefox/default/storage/default/https+++www.pinterest.=
com/
> cache/morgue/16/{b696bf53-d26a-48eb-9688-ab3c5fd49010}.final)
> [ 5638.998097] BTRFS error (device dm-1): bdev /dev/mapper/volgroup0-lv=
_root=20
> errs: wr 0, rd 0, flush 0, corrupt 21, gen 0
> [ 5638.998101] BTRFS error (device dm-1): unable to fixup (regular) err=
or at=20
> logical 253563518976 on dev /dev/mapper/volgroup0-lv_root
> [ 5638.998542] BTRFS warning (device dm-1): checksum error at logical=20
> 253563523072 on dev /dev/mapper/volgroup0-lv_root, physical 85319503872=
, root=20
> 5, inode 6477931, offset 20480, length 4096, links 1 (path: home/
> michael/.mozilla/firefox/default/storage/default/https+++www.pinterest.=
com/
> cache/morgue/16/{b696bf53-d26a-48eb-9688-ab3c5fd49010}.final)
> [ 5638.998551] BTRFS error (device dm-1): bdev /dev/mapper/volgroup0-lv=
_root=20
> errs: wr 0, rd 0, flush 0, corrupt 22, gen 0
> [ 5638.998554] BTRFS error (device dm-1): unable to fixup (regular) err=
or at=20
> logical 253563523072 on dev /dev/mapper/volgroup0-lv_root
> [ 5638.998975] BTRFS warning (device dm-1): checksum error at logical=20
> 253563527168 on dev /dev/mapper/volgroup0-lv_root, physical 85319507968=
, root=20
> 5, inode 6477931, offset 24576, length 4096, links 1 (path: home/
> michael/.mozilla/firefox/default/storage/default/https+++www.pinterest.=
com/
> cache/morgue/16/{b696bf53-d26a-48eb-9688-ab3c5fd49010}.final)
> [ 5638.998981] BTRFS error (device dm-1): bdev /dev/mapper/volgroup0-lv=
_root=20
> errs: wr 0, rd 0, flush 0, corrupt 23, gen 0
> [ 5638.998984] BTRFS error (device dm-1): unable to fixup (regular) err=
or at=20
> logical 253563527168 on dev /dev/mapper/volgroup0-lv_root
> [ 5638.999356] BTRFS warning (device dm-1): checksum error at logical=20
> 253563531264 on dev /dev/mapper/volgroup0-lv_root, physical 85319512064=
, root=20
> 5, inode 6477931, offset 28672, length 4096, links 1 (path: home/
> michael/.mozilla/firefox/default/storage/default/https+++www.pinterest.=
com/
> cache/morgue/16/{b696bf53-d26a-48eb-9688-ab3c5fd49010}.final)
> [ 5638.999362] BTRFS error (device dm-1): bdev /dev/mapper/volgroup0-lv=
_root=20
> errs: wr 0, rd 0, flush 0, corrupt 24, gen 0
> [ 5638.999366] BTRFS error (device dm-1): unable to fixup (regular) err=
or at=20
> logical 253563531264 on dev /dev/mapper/volgroup0-lv_root
> [ 5638.999592] BTRFS warning (device dm-1): checksum error at logical=20
> 253563535360 on dev /dev/mapper/volgroup0-lv_root, physical 85319516160=
, root=20
> 5, inode 6477931, offset 32768, length 4096, links 1 (path: home/
> michael/.mozilla/firefox/default/storage/default/https+++www.pinterest.=
com/
> cache/morgue/16/{b696bf53-d26a-48eb-9688-ab3c5fd49010}.final)
> [ 5638.999596] BTRFS error (device dm-1): bdev /dev/mapper/volgroup0-lv=
_root=20
> errs: wr 0, rd 0, flush 0, corrupt 25, gen 0
> [ 5638.999598] BTRFS error (device dm-1): unable to fixup (regular) err=
or at=20
> logical 253563535360 on dev /dev/mapper/volgroup0-lv_root
> [ 5638.999861] BTRFS warning (device dm-1): checksum error at logical=20
> 253563539456 on dev /dev/mapper/volgroup0-lv_root, physical 85319520256=
, root=20
> 5, inode 6477931, offset 36864, length 4096, links 1 (path: home/
> michael/.mozilla/firefox/default/storage/default/https+++www.pinterest.=
com/
> cache/morgue/16/{b696bf53-d26a-48eb-9688-ab3c5fd49010}.final)
> [ 5638.999866] BTRFS error (device dm-1): bdev /dev/mapper/volgroup0-lv=
_root=20
> errs: wr 0, rd 0, flush 0, corrupt 26, gen 0
> [ 5638.999869] BTRFS error (device dm-1): unable to fixup (regular) err=
or at=20
> logical 253563539456 on dev /dev/mapper/volgroup0-lv_root
> [ 5692.239308] BTRFS info (device dm-1): scrub: finished on devid 1 wit=
h=20
> status: 0
> ``` END DMESG OUTPUT ```
>=20


--JSy7MDpILk3OkHGbdn7N6ukRwUWsQvONQ--

--rotfBT8T5bgpkOZLI13QqRnvArv92tM53
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4HRSIACgkQwj2R86El
/qgU4gf+KhlXlRSOFstR4r+d0Tikuo+1i7rshxTcMrDpkBUQU/FebOW7CPk20YSu
WCa+FquxpRKleJeM8ADX9cNn/4jtTpDtAs2vBMv8QS1IScbL8ipCZigs92yhGkb1
GN3R1t+oi2ctYoxV/Fed5bU4LGKknTdSG7LAlD6Ru2fkM4fYNkY3S+RglC899E+k
7Cwml9kSOTuvAf9z3PIrq8VMFAIS8GtUi77BgseZHrBrbzTsW9NzVEBqvvTHm8wO
IRV7nGNe75oy50KzasqH2S3o9m1Cj6asUR+/gB6e60B/I3SaZBoDpfTWr0KINzD4
599dPk/xpndiUOdW5V/6IQlwu3PDig==
=I81r
-----END PGP SIGNATURE-----

--rotfBT8T5bgpkOZLI13QqRnvArv92tM53--
