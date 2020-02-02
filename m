Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1CC914FD1A
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Feb 2020 13:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgBBM41 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Feb 2020 07:56:27 -0500
Received: from mout.gmx.net ([212.227.15.19]:48827 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbgBBM41 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 2 Feb 2020 07:56:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580648184;
        bh=HSXhPLiZ3EIWrYGlk+eBbMaMFSO+dN9Qf1icsOP6PG4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=MxH4/vAIS+4R1djPKk7rvvN2RmOgSZZAzUKnSvkmxT7RNIlW9iUYtCYyGy7MDJ403
         O9JrB8MGdC/2KOCyF0L5+zQ/ZartUqfMD9utWSV1Yj/4m7XW6DbnCYqrH5KZ4KSiYQ
         koQJ2eRzkGUbJC14/FAoR8k/B5ps2Sqvb/4oTTqg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MHG8g-1il5dQ0A08-00DGGf; Sun, 02
 Feb 2020 13:56:24 +0100
Subject: Re: My first attempt to use btrfs failed miserably
To:     Skibbi <skibbi@gmail.com>, linux-btrfs@vger.kernel.org
References: <CACN+yT_AYiLc29M41U+WrQHtk4t==D-4AkH+wRROKJY=WstGAA@mail.gmail.com>
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
Message-ID: <cd628b1f-25b7-0f3b-0b31-2122acdfcd36@gmx.com>
Date:   Sun, 2 Feb 2020 20:56:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CACN+yT_AYiLc29M41U+WrQHtk4t==D-4AkH+wRROKJY=WstGAA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gEPsXavyUauve7eOcKJSbHsYIfdfdIp12"
X-Provags-ID: V03:K1:CYYbENiA1lzHxvQzI6C3/5PTXcpSkmXuwnuEpv4+wAlf/1yieVN
 Q/szPtNh4s5BBYfE7TEqmpMjxkxYvUhKOQtHmbBlqQvVC3u8WY41ODe6KvtsXaKeYzyIy7T
 wbNTm+b4JjZ94oBB9beZfGuYD7ied/fzw3XtMjul7gieNjodFiwlxNuSWWOmRQ/jkwHa8sx
 JA+0PlYiWazb8OOLFY8vg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:w50OHmq2wjc=:wm+g3tq/Jg4Rxr5geUubeo
 Wh1LxSbaBg2iAwk5LA0/wMrnfWzKQR+58WSvGOu3U6Z4wJszndT9PJc2yKoqRa9a0otlwttRj
 RFOm29MuuuraPwHZOtstDYUmONDy7tkkOXeY829LLqKT1eljz4iszdUe/gun/0t7BlN938MdJ
 69psLo0FcSIzp4q7ipqc5T80DGWtFGxAd04+HBnTa5s3P8JG7W0SzGNJHvhLgbgWL95baJJKW
 MbJv2uAB9y7VmQucUxlSERbu087zjv6U9sAbrKrSri9yfnDAzGQFT2uvOR7JteGsN1yBieP5a
 apXaC0YFpvWT+Xtha+1cq132+9cHECz8n61rYsBLAPUTjMgJYqfExS3cD2D6HJbUe8WQYEoOb
 6A7WvaL++Jg5DQK99UQZrhbL8K6Fwiy5cyxS+e9nXR4H9I3T6k75mg1LIXEzFYpjv8RpeQdzl
 PMoZFLDR5tr/44FUNwmB1dkw3fJ4h51FPSC/+KMctGj0HJ10J6lEgtYHaOZp0kpAdB3y+M2My
 +I/JJDekQThp3+60GwjKUOf4cig/K/upA20LcV0PBGxWzzgxzHupFbwqY6hAJX12hBfvrsWRH
 E+n1t4GkbIG28kfc++YJdlZNKrGMC9o3xpvGzSkBFospU90ehcbamL/2uM4Kj+8WWvOLVSPQx
 5TirnA2SESkZmjvG4YWNMd7Ctm4C49M2D/1SYqIz7N+vWxMttsVrXxuUrmIuIlLPMFeQXaUvL
 rFOsy75ZoMdkpmvNfJKWMGmqVF5Q3pmURiU4ublolIrQ3YIf1adHJN/+5QyirbCb46qi5gANN
 bL4nEq5T0RlxP2kTkGEMMCMMl/9B5s9uHZogFvPNJ+6f6daTVVFlsUgKZ1I8NF0eqg1QpCrLs
 K3PtnJuvPVCFeZLwGt7Uq1Qc3tzPS42Y4xgfjWX4L1ulL/OkyWKypbuPOVf54tKc5q2d0XNg6
 kZ4hwVtpYVKVPY/zwAEYwfXo+xxAH9xheWDTD/sbZiB7e6HFZOBJ1FueQascek2I+v3rFD60m
 +gHPliNQUk2Zr2hBBW3JSdLwMiEHbI2a0Nr8Kj4/pHYICBwYNqHE/Er/MdfgDtjzzWVNnvo6F
 iP3wton0uj2sv0DBDd7HiOZsfkn4VWgdrlabm+7eieJQbilPhTj9tHRnt11M4tV4VviXqlcaM
 NqypN0fgQkoiPSGMYtGGt0axZZ9OKdLgW0GnMS1TnxJV0fdeDo6+3gmH7lPVd1Lql74VeiZft
 bPb4aMLKVbqEFuvgs
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gEPsXavyUauve7eOcKJSbHsYIfdfdIp12
Content-Type: multipart/mixed; boundary="sTu3ZGJogSSLHPnfAzVBcHUCo4SWn5hdq"

--sTu3ZGJogSSLHPnfAzVBcHUCo4SWn5hdq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/2 =E4=B8=8B=E5=8D=888:45, Skibbi wrote:
> Hello,
> So I decided to try btrfs on my new portable WD Password Drive
> attached to Raspberry Pi 4. I created GPT partition, created luks2
> volume and formatted it with btrfs. Then I created 3 subvolumes and
> started copying data from other disks to one of the subvolumes. After
> writing around 40GB of data my filesystem crashed. That was super fast
> and totally discouraged me from next attempts to use btrfs :(
> But I would like to help with development so before I reformat my
> drive I can help you identifying potential issues with this filesystem
> by providing some debugging info.
>=20
> Here are some details:
>=20
> root@rpi4b:~# uname -a
> Linux rpi4b 4.19.93-v7l+ #1290 SMP Fri Jan 10 16:45:11 GMT 2020 armv7l =
GNU/Linux

Pretty old kernel, nor recently enough backports.

And since you're already using rpi4, no reason to use armv7 kernel.
You can go aarch64, Archlinux ARM has latest kernel for it.

>=20
> root@rpi4b:~# btrfs --version
> btrfs-progs v4.20.1

Old progs too.

>=20
> root@rpi4b:~# btrfs fi show
> Label: 'NAS'  uuid: b16b5b3f-ce5e-42e6-bccd-b48cc641bf96
>         Total devices 1 FS bytes used 42.48GiB
>         devid    1 size 4.55TiB used 45.02GiB path /dev/mapper/NAS
>=20
> root@rpi4b:~# dmesg |grep btrfs
> [223167.290255] BTRFS: error (device dm-0) in
> btrfs_run_delayed_refs:2935: errno=3D-5 IO failure
> [223167.389690] BTRFS: error (device dm-0) in
> btrfs_run_delayed_refs:2935: errno=3D-5 IO failure
> root@rpi4b:~# dmesg |grep BTRFS
> [201688.941552] BTRFS: device label NAS devid 1 transid 5 /dev/sda1
> [201729.894774] BTRFS info (device sda1): disk space caching is enabled=

> [201729.894789] BTRFS info (device sda1): has skinny extents
> [201729.894801] BTRFS info (device sda1): flagging fs with big metadata=
 feature
> [201729.902120] BTRFS info (device sda1): checking UUID tree
> [202297.695253] BTRFS info (device sda1): disk space caching is enabled=

> [202297.695271] BTRFS info (device sda1): has skinny extents
> [202439.515956] BTRFS info (device sda1): disk space caching is enabled=

> [202439.515976] BTRFS info (device sda1): has skinny extents
> [202928.275644] BTRFS error (device sda1): open_ctree failed
> [202934.389346] BTRFS info (device sda1): disk space caching is enabled=

> [202934.389361] BTRFS info (device sda1): has skinny extents
> [203040.718845] BTRFS info (device sda1): disk space caching is enabled=

> [203040.718863] BTRFS info (device sda1): has skinny extents
> [203285.351377] BTRFS error (device sda1): bad tree block start, want
> 31457280 have 0

This means some tree read failed miserably.
It looks like btrfs is trying to read something from trimmed range.

> [203285.383180] BTRFS error (device sda1): bad tree block start, want
> 31506432 have 0
> [203285.466743] BTRFS info (device sda1): read error corrected: ino 0
> off 32735232 (dev /dev/sda1 sector 80320)

This means btrfs still can get one good copy.

Something is not working properly, either from btrfs or the lower stack.

Have you tried to do the same thing without LUKS? Just btrfs over raw
partition.

And it's recommended to use newer kernel anyway.

Thanks,
Qu
>=20
> --
> Best regards
>=20


--sTu3ZGJogSSLHPnfAzVBcHUCo4SWn5hdq--

--gEPsXavyUauve7eOcKJSbHsYIfdfdIp12
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl42xvQACgkQwj2R86El
/qheDgf/V2hGfL8ds0e8bQ5o/NmWeqUD88PfGRM+lZS5NPtBhSUsI3+wS3Rs6L5C
KKktANtp1nwSe1UP0aNgwYBZltgGC9VS1FHI4oakX7rxuiAQ+tZnjs4Oe8zOPpye
2CgVwAnjM34F3Gif9x3QhKi3k1v4dsJ4fZuS6i8HlsQvIzvZjMQE5/UKNDlRkFV+
rQmp1RCkMXeO/q8PuTuAkkz+0MvgV17qraom4LkuMK1GT83WJvBU14r129NUcrz/
+YfA2nMcmUBnceGGvyaT1RWBusAXX9I1i7tXjTP3RwLs0SjVWY2+WD5YFnb9wXYo
k4AYCrn4WTB5Fo1NWwma5eXraJGM6g==
=AqzE
-----END PGP SIGNATURE-----

--gEPsXavyUauve7eOcKJSbHsYIfdfdIp12--
