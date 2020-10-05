Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22000282EDF
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Oct 2020 04:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbgJECi2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Oct 2020 22:38:28 -0400
Received: from mout.gmx.net ([212.227.15.18]:56833 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgJECi2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 4 Oct 2020 22:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601865506;
        bh=DTJdRO9cd8ChEGMfDvHbdk2smtlG/0wcc7ZsYBbCdtA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=fFXQSdRy+I/2A7lyQIcYf1wWubptAJxgcH6A2aHkXuoALIaaRU4piwENKb5EPY3Wq
         j6p2kooRI9/7Mp8HpsIzQ/fVYY6ikU7UIvf2KsI6bcWR8vWiPrNAHCMhrtswdeH5LY
         0+37k78mkRvDjc4jeWQ7zNgWm8znk33h659YUBH4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M3lY1-1kOz902NNb-000rWt; Mon, 05
 Oct 2020 04:38:26 +0200
Subject: Re: ERROR... please contact btrfs developers
To:     Eric Levy <ericlevy@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CA++hEgx2x=HjjUR=o2=PFHdQSFSqquNffePTVUqMNs19sj_wcQ@mail.gmail.com>
 <c2d13609-564d-1e3b-482a-0af65532b42b@gmx.com>
 <CA++hEgyyn0Os1-w-WE8seXCrDJVosgLnfL1pU7e2p_LpqRmJ_Q@mail.gmail.com>
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
Message-ID: <4623c387-f685-e836-f54a-6ce96b5fb318@gmx.com>
Date:   Mon, 5 Oct 2020 10:38:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CA++hEgyyn0Os1-w-WE8seXCrDJVosgLnfL1pU7e2p_LpqRmJ_Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NRmwrPtxskskMQRZjEJfNepYR1zG5cJYw"
X-Provags-ID: V03:K1:Z1UPXIPsv6FsU3KR2OrzlMss6+Pi/kLPkedBwRtsMLnESZos77p
 E7aZVm7b9DkehGqzICDzIIjUb80h7ccDHAvEmsfeYQbawM3diZVGJ2s5pnjqsOFmTTdcSct
 3fhdpi5DtvctjLC9BmYnokkhRAxif3+Aorh8CF0PaMcM3JaI9ilAGnXFDxI5qT/MlAkwgR1
 6CMMf4yUw0xvNT4VRiGBg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ez18JSCXDuo=:8wk13BjUQgQfbGXBP0e7yt
 X4hNLwMixu3IhaVmgGMffPMqGiM1NZEzk07T2DbKU1ECsjy3P+m/W1lGzT2hjCbBmeeQkwq3x
 YyPQvFFvEfNy3QEKgYwz0FcrWaoNNx73LndPdho/FlWiB6r15h8EGk+xIAAM3W75OOoasJNSg
 gCrQpvputURstJ6i85HfjHjbvIAZfkT0TcvXfPL1EnzxKgFHtiF0k5lrYtwO1L7IoHDG/NDFQ
 6F91dKHjF14pQGHbEHUfHJPgFx/AD4B8FlNFFdtNhMqfgr4LwCm3V5YApb9jg4DXOpDxeiy8s
 XDqzxQpU0kWOVZaBYQm6aA5wusEpt/+XvWz39hLWomS2Gp829WsBorDOfRHcsbv1tJ3+KZ+VO
 aMVKAskifqbzfw621iDgf9rKGHSC1Akkq5AhabdH1Tv3tv5diBYBPuaRelQ+83+2yVK0ZiFBf
 reQAIsY0mgtJY5mrsq9dwtkoyEhrQqznz770rEsQZX6T8MrKnz9Z4gt5n5TPeXFKN0HxJjW96
 IWftxWY4tlp4fnk0PBfjDUsiwAHL/fA/djCgJP4rrcdbxewpZW//O1EMG4M/UPKM08UTRfE4u
 lUyf9fxk+SuVc7Yc7WlQcWqOjwFlThBm+10HIeC9Pl527Mz+2G3FDkRX+EEIPJZ28DlEI23Ty
 tfX0SbC8fRRUiO+pNK7YA9zccpJKfw/HSAWjnkPr/Vxbm2tpKDSGORUF9U0m7FcWHQSPVcJFZ
 q1aSK9/CpsoYlxGolTCs+oXToOr41fZGA5cSxfGqVu8Uh+uBL4YUi5LSpJ2LK0N6DopYk7wNV
 20qcBPzmkUwxkF49v9Jj4wTIgpIzGQjp5717pal6mMuTLYwTBNVKQGrIDxow9pw7w+LUYtk/J
 PtDtHADO8IimY6yf7DpHhiK2+Elm/xHta3EwLknN7jCf7cbR2+pPyysLibL2/dzboie98PDaq
 DOWb/vrLHpk/3mC1YhM76fci/JiogZOoijQFcmn+QlRP8LuSZ2aCAZzVCKMkwLZignbdJjH+E
 ieFk8KkIWqvVAqmLbhO2swbBDB0L2YEb75ZsdLX+1IuRDZpVdPmNpHgf0mzrX0hfbn41MxOy+
 Rpw5rvLgzMQp7cowhQwJ9Yp6GgQq+6tmVMUhs99I3hGXMD3BAGRmG0PTBMFUAG3eLcWnVb9vi
 ckiC4TwO+2OIXBx6oG2c2zQybrfzQHGoQJZe2YsewUI7VYfZAycKuBnUPcnPH51KaqRGSzoUW
 UB/QVcW44WwDXHCQAR1mzwTwX//hD47/DyE9ziQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NRmwrPtxskskMQRZjEJfNepYR1zG5cJYw
Content-Type: multipart/mixed; boundary="kUYZgT3b7G1K5gnSBMFby2JlRqnjRuL5z"

--kUYZgT3b7G1K5gnSBMFby2JlRqnjRuL5z
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/5 =E4=B8=8A=E5=8D=8810:20, Eric Levy wrote:
>> There is an off-tree branch to do the repair:
>> https://github.com/adam900710/btrfs-progs/tree/extent_gen_repair
>>
>> You could try that to see if it works.
>=20
> Would this utility build and run on a stock kernel?

It's kernel independent. So choose whatever kernel you like.

> The documentation
> suggests otherwise. It would be difficult to perform an operation on
> an environment other than a standard recovery loaded on a USB stick or
> an active desktop running an up-to-date distribution.
>=20
> Also from the build output (Linux 5.4.0):
>=20
>     [CC]     btrfs-convert.o
> In file included from btrfs-convert.c:22:
> kerncompat.h:300: warning: "__bitwise" redefined
>   300 | #define __bitwise
>       |
> In file included from kerncompat.h:30,
>                  from btrfs-convert.c:22:
> /usr/include/linux/types.h:22: note: this is the location of the
> previous definition
>    22 | #define __bitwise __bitwise__
>       |
> btrfs-convert.c: In function =E2=80=98ext2_xattr_check_entry=E2=80=99:
> btrfs-convert.c:626:11: error: =E2=80=98struct ext2_ext_attr_entry=E2=80=
=99 has no
> member named =E2=80=98e_value_block=E2=80=99
>   626 |  if (entry->e_value_block !=3D 0 || value_size > size ||
>       |           ^~
> make: *** [Makefile:131: btrfs-convert.o] Error 1

This error is mostly due to older e2fsprogs headers.

You can skip the convert tool by './configure --disable-convert'.
Also you may want to disable document and zstd too.
Or you will need more deps.

Thanks,
Qu

>=20


--kUYZgT3b7G1K5gnSBMFby2JlRqnjRuL5z--

--NRmwrPtxskskMQRZjEJfNepYR1zG5cJYw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl96hx4ACgkQwj2R86El
/qi19wf+KW28ZOa7qU+5IGkel8GF7S6mZUXjtQFfvoCTzJkMSEFzTIYaQ/qsHvzV
jdUuQMuwzYrNyJIKaarkJ+cWKKA/4Wv26eFiowldXebIkY1xbnfd5kdIqISXTEhC
wtHunyoqLgrvRZz870qbu+XhR1HHsPsAqJ92MazSvdrrInA1JtxoU2Gp9umx0nsS
LLXbTL0PEMsaG66ES27RpPMmB2pu1L7MLylicguDwGmurXi56EeM+lb4h6l+7IjK
Et5JMEEjmlTZpBHn6lrFeI52TMEFgd8ciZj+mpbLkRzVWV0MiayRtVzzi66lwb7h
t3CEAz6YfBbki6kiqchCB+kLqN3Q0Q==
=qUFH
-----END PGP SIGNATURE-----

--NRmwrPtxskskMQRZjEJfNepYR1zG5cJYw--
