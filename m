Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63CFF12BD3B
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Dec 2019 11:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfL1KJj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Dec 2019 05:09:39 -0500
Received: from mout.gmx.net ([212.227.15.19]:48407 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbfL1KJj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Dec 2019 05:09:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577527773;
        bh=CY55KUN8PwP0jN+BqSNDoasHO3hCJiUFTi2aZomze5M=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=By1rm1Pb7iEvs7XF2LvXWoPuqNoWq1eAjeCVrLcUcoHlcuBGghiFtP3rod25a188V
         cWeHS4C18hrgCuTvr8CFv8MkmmIOZX72UEQE9/cL3XzUV+foBHEcbXjXNs93y5DWNT
         yDc/RFH/WCriO7Pr7szS9IZIMGYJRkV/8NPHavRo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTAFh-1jBqhW01pH-00UXFt; Sat, 28
 Dec 2019 11:09:33 +0100
Subject: Re: Error during balancing '/': Input/output error
To:     Michael Ruiz <michael@mruiz.dev>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <4196932.LvFx2qVVIh@archlinux>
 <c1b81526-5d18-4cd2-563a-0cbca83123c8@gmx.com> <5555870.lOV4Wx5bFT@archlinux>
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
Message-ID: <f8696732-09f3-315f-3f66-6a318782bbbe@gmx.com>
Date:   Sat, 28 Dec 2019 18:09:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <5555870.lOV4Wx5bFT@archlinux>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sGOWl4jNnPsrA6rV7DpxAkW8S59V58B53"
X-Provags-ID: V03:K1:w6HkFV8P38nvMdd9Hh64oHPXnjM8XY1NcFxuiL5AP8Pv/zrwVpA
 vXCcvv0t5HV6TxfiCNjwlPok+KfTFDRZWF43qtu04M0wPCbrSIKN/I/sfPbCeG+Qy9Y/lto
 IUacfnju784qy901SdH1PEjmq/G5OKVx2KGm+M940PC733rDl9ciZqlM8bArGGSJ3JTPTLi
 GYemLsY646XPxrHTrHMtA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vzhx+2VvQFU=:w+sKpHwm+vktLBxwnSwM7Z
 uhLS6/bI3vNnLy+WOqyleLAt7dz2rq2SDEFmYx08X4iTB4ItKNhnyhZ5qkdTEBnYxMevPNsso
 FuF/HsVlUc7X6ss3bm8mUTJlh2UO9Xg2+r8mNOfmeLuL+V33FIEud0O5l1Dlls0Ro36Q4h1yO
 /L8lxMFOWtfBs3KwM5mM5Oz1zlRbNmosYw9tZx751OmlIy7HQDp11qjomqLyN5jWTbSr8NrDI
 F+PBwj9wsIJhZr0ZaMrmVpfyd3ba8bxOaQPKv+aGKdi33ytmo8fKe1/ztmwGmLbRH7ohbR+N/
 XnJGRKecq5gIA9WPJj0fq5mFrCn81Otqm51zZgt6b5CeIdsJERuy6xALnL0S7QctrPfW9dstd
 VebyJBZEHnoF1gbvwGqA/6QpN9y0+BLGunCKZyXi7r2xv4tmcuhC1OJZNvZxN4TUzuHxphvn2
 y77dNzo//5b74gj6wUvxFHaheOSG0QxEAmgz8NbD2LYyFNgbOF6ZPanfsjK+rJHjs9HhK9v+F
 q1q7/k1p2ZPhLUjhptp44mGju2xk3GZq8X7JRTkzbjFy1cduQw605//VMM/r/U6KPsY+OIjgU
 G387k9liQgSWVVR0NcESqkGPxn9a/jcInmaDJm93OpL7BiGr4XRPzJeeETJ2ULHRM/PFNgnfx
 FX8omsgFx4oilWFGZ4UCLBPhGmOJUWWwb6u24Rnw+HCITdEqk9AsiRfEfSJMFhmUTYzABp370
 PnPKRiom+Msfx5zUDHRyEpfDFJqbDRGHABCo6MJOYbgjNcd8OGZXrXzRA7dRg/MPWcZca/jEX
 PyRZmH2pJKxs6m1bsJdexy7Y4xeNNz/zcSZDAa3uXsmNGhui2+5p9T/7jT60kX3jRl6R/3sxv
 Fr0DmATGoVOzMhpIg2cYUPtHSS92Tk2Cr3KKqUm5uFxG/p/yl2J5RpwQiJgncMYo8qriHjKBp
 86ZQMLtxinw4pN4cQfJw2scPLtXlmY+zmV3MUOTwrorXEYsT2P/mjmkG9Q8w7HdFmqVn8Jfrg
 VbHNC5zP0Gd9Yj5ynr5fQSUGl8KYdpd0uOnaIr/h3DeDR9V/3qHzJ4vu5Mp7V6NgRvYnmSjO2
 q48wbZQlyBW5VPit4/A7FPnRGpaOq6ty0ENaltVwzG9WG+bcubz8/uo5o0CTIiIZ4mczibGy2
 KScUUZ5azbS4qUXb2AaVn0KswG7/7aTXD2y6hq+N7vIy0/8OqEZc2MLhYcFLCEJgxJAsFmReu
 jBeZ5WhfaFaI3JRFJOlnoofmU3w9NUAagPjabFv9eyAZB50R66q6O4eUBtjo=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sGOWl4jNnPsrA6rV7DpxAkW8S59V58B53
Content-Type: multipart/mixed; boundary="sobYNIoqEGM748BFlw99u50iu2kz2sTHK"

--sobYNIoqEGM748BFlw99u50iu2kz2sTHK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/28 =E4=B8=8B=E5=8D=885:49, Michael Ruiz wrote:
>> There are quite some reports about this problem. So far no real
>> corrupted confirmed.
>>
>> You can confirm it by scrub.
>>
>> I'm afraid there is some bug in data balance code which leads to this.=

>> We will dig further to pin down the cause.
>>
>> BTW, does that problem always show up at block group 253562454016? Or =
it
>> randomly shows up at different block groups?
>>
>> Thanks,
>> Qu
>=20
> Hi Qu,
> It appears to be the same data blocks giving me this issue. I have trie=
d it=20
> while mounting from a bootable usb and in my arch linux install both wi=
th=20
> similar results.

So it looks like you will hit the same -EIO even just relocating that
specific block group using vrange filter.

> I should also mention I have a btrfs root partition within a=20
> luks lvm partition becuase btrfs provides no encryption. I'm not sure t=
his=20
> makes a difference.

I don't believe it would cause any difference.

> Would you suggest running somekind of disk check or by=20
> running scrub? Please let me know what I should try to resolve this.

Running a scrub is always preferred.
An `btrfs check` run would be even better.

If all above reports no error, we need more info to dig. (See below).

> =E8=B0=A2=E8=B0=A2
>=20
> ``` BEGIN DEBUG INFO ```
> ERROR: error during balancing '/': Input/output error
> [  465.880807] BTRFS info (device dm-1): found 25 extents
> [  470.501319] BTRFS info (device dm-1): found 25 extents
> [  471.713073] BTRFS info (device dm-1): relocating block group 2535624=
54016=20
> flags data
> [  472.251356] BTRFS warning (device dm-1): csum failed root -9 ino 262=
 off=20
> 1048576 csum 0x9a7afaa8 expected csum 0x63e15594 mirror 1

Another question, is the reported csum (both have and expected) always
the same?

> [  472.254390] BTRFS warning (device dm-1): csum failed root -9 ino 262=
 off=20
> 1048576 csum 0x9a7afaa8 expected csum 0x63e15594 mirror 1

This line means two things:
- We have extra inodes in data reloc tree
  Normally data reloc only has one inode, 256.
  It's possible we have some extra orphan inodes.
  Would you like to do the following dump?

  # btrfs ins dump-tree -t data_reloc /dev/dm-1

  Although the result is not something representing the content when we
  hit the bug, it may still provide some clue.

- The original data is from logical 253563502592
  Would you like to check which file(s) owns that logical?
  It can be done by the following command:

  # btrfs ins logical-resolve 253563502592 <mnt>

  Unlike previous command, it needs to be executed on a mounted btrfs
  other than the block device.

  And the info about that inode is also helpful, like its attr
  (nodatacow?).

Thanks,
Qu

> ``` END DEBUG INFO ```
>=20


--sobYNIoqEGM748BFlw99u50iu2kz2sTHK--

--sGOWl4jNnPsrA6rV7DpxAkW8S59V58B53
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4HKdkACgkQwj2R86El
/qjfLAf+K6pOL6psr7cwwKesGiTb++kd0M2olv1dkJSIgE2PQ2ON/WmRzVOEjZdI
PgvSuV5TSvOFFn5cIgousiKr2FaYtfI+8NGY2IwlFcTcGGOMHraavlV/3Ml2VPPL
Q4/nJ+bmnbpwfBHmkrS+XHFOq60vzR2y4xiMHt+tKXyW/v9G9mIk5NWZ8ZNY/DTE
eZb2h0CzWGlynYcGnUbpWdCQrrcbAKgZYfoHISUX2w15dhjK17Dehl5pYZYFyfzW
XkgA4WLBmiAKtIf9PFBAZjM8FMPE3C82jqdZHoyxyebh8RMDSJ1VHbn/jU7TBe2w
kLJTi0YtDpubucmK9uSUz+N3PcEA3w==
=oqbQ
-----END PGP SIGNATURE-----

--sGOWl4jNnPsrA6rV7DpxAkW8S59V58B53--
