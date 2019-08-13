Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0B828B5F8
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2019 12:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfHMK4B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Aug 2019 06:56:01 -0400
Received: from mout.gmx.net ([212.227.17.20]:35943 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfHMK4B (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Aug 2019 06:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565693752;
        bh=rPZJ5wXV72EynrPxmI5b0XHgccyxheVD+2UwyWUOUbI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=FmoRXAWo5gMWEsPWZTg1JInO9K25+FzCHQPp0/qe4p4UQxbe4FrIXYopJIQgv33OF
         OYoBGU58ALDQy8QlLhOeAjk9riQlin8ZYPsfEdK3Zecw2FDw7ADPyvkbXFYqmEN80g
         3FgcJLxX+xbctAZHFUOUrO437zC9ZL8qE6+/czz8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0Lkjuq-1iXeAF1arc-00aYH9; Tue, 13
 Aug 2019 12:55:52 +0200
Subject: Re: btrfs errors
To:     "Konstantin V. Gavrilenko" <k.gavrilenko@arhont.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <347523577.41.1565689723208.JavaMail.gkos@xpska>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
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
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <8cdacece-32a3-daf7-3ac8-f062179ebbaf@gmx.com>
Date:   Tue, 13 Aug 2019 18:55:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <347523577.41.1565689723208.JavaMail.gkos@xpska>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zrnpVh6by4k8uDGZ8jCdWgu4Y6V0BtHaH"
X-Provags-ID: V03:K1:K2Jm9Mkg+cB/FUCZIvJafyfmIil9YQ0VU46S7VQcBlfxROupfcB
 ZKpHUa193a9CBjKIKHvOOVRsjTHoHouk05D4zpaD0XfhkGUi7kVknIpHkZ2CWfWE9cdlNvE
 9DzcHck9nJESczTA9oHBEW0bZRNlY3Iwnapis8iXBGePelLUqqI6VuPKRVyouXZxkih3pTK
 97u9KZp4vf/Dw1IPP5n1g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1wARNZ0ztXI=:Dj4x4yGdzw/1xgVKeKeFxM
 hl/PxxB4cILeEXXEJbJ2Ho0xiWb9tNZ0UQv5SwHakW/bmEQvozskXEsd3j5uVmYbVL+zHMy1P
 fEMN0Q0DW7xfYoRzEQSQNhnRwSigCyeKlx3dpmIaT10Ht1OyBcEQeBirdutSk2OewzfLxUZVj
 hVvGQXjGCjebiScjfatAnlSMXctu3XQ2+4rL30OH5mvLvmEnxYDI2mjyIIomE0G3mrE6pjUDU
 luO7EDzw4kjK3HS8HYkcJsz0DF8zkWtO2toOc7pKxVo3yVimjAGR/F6bK9IqxELJYw76OwiS/
 ZCzlj7wRi1GKsNIRtZHS9u4s2VWZPkH2rhHCb5HZLJPNseUE7J2BEaI/fZb1d6ygFVKDDfOoT
 ZHvnWAvHC4qpe2dBJlVY9eQXO3UsNFNZOeyvsFWCfngaAIXmQs5DZwUozp7N+uMNTxWcgvVi3
 aBX5adAQANk7NvdRe3iYzouH7IiBf6Eh10CpTxiiw/8KoJ06o66XBekv2aLMyTFYfKF3kYdGp
 u9x/cKY/QmKlmHyM5g+BFcdXb+HIJXuNvrG+bndbR50AzGdQ0hBjXTN5zQ1ugu4AnYDmGRM0A
 /t2vnQ62vlCFcuoSgGJtjEvIYrd/PyJQo5vhKL/0aNMBcurStAS/eiFRlTxU/3aP+Oy2q2HdA
 RxLdYlBitlsbHFl61S9M2/cK12P7MO4ujvNuAGZ6rk96cz4Tc1GPP9M4ZkE6nJxYGXW1b1DEA
 4tkQtVLfyX1qTAXYGT7nXFTPTILICVxhrXmipABWMv7WAa9S0UcmwTbyiVONghJvymERGFcwf
 KK322ZTgALDmlulS9NPo5Epw0lm22jUk9B2PVEIIEfWy/vuU3qPU4rteQKINxiD3NN5bpVVxC
 eyv2xlJjtFBp1lWA3JvLcOOt1gUys18sZGajiLp8tPZl+HRzgH3ITQ5U9n3NCfOE6WnSrCN52
 LIAsJPp589mi8LhZm/S8TbBQA3o4HH28RT4V7mrOG5VZO2buc2gh/YP2crqHlnEcn6AYkp9pb
 DUUCbYNOnogd9OjIzPirC5MrV8EcEGi0uOBda27HZLRV7vpvUghhQkrBEhaKIGO3G7xNRoA5Z
 C6Z0CsOYTsGGI16cGjNFa7Iob5Ff/3Wv8KxsJ+/0XlFz+mJTqCyDE62wA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zrnpVh6by4k8uDGZ8jCdWgu4Y6V0BtHaH
Content-Type: multipart/mixed; boundary="875JHsBPou16U6OkqVv1hfJbQhGD9OR2w";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: "Konstantin V. Gavrilenko" <k.gavrilenko@arhont.com>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <8cdacece-32a3-daf7-3ac8-f062179ebbaf@gmx.com>
Subject: Re: btrfs errors
References: <347523577.41.1565689723208.JavaMail.gkos@xpska>
In-Reply-To: <347523577.41.1565689723208.JavaMail.gkos@xpska>

--875JHsBPou16U6OkqVv1hfJbQhGD9OR2w
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/13 =E4=B8=8B=E5=8D=885:48, Konstantin V. Gavrilenko wrote:
> Hi list
>=20
> I have run the btrfs check, and that reported multiple errors on the FS=
=2E
>=20
> # btrfs check --readonly --force /dev/kubuntu-vg/lv_root
> <SKIP>

Please don't skip the output, especially for btrfs check.

The first tree btrfs check checks is extent tree, if we have anything
wrong in extent tree, it's way serious than the later part.

And I understand you want to check your root fs, thus you have to use
--force, but I'd recommend to go whatever distro you like, use its
liveCD/USB to check your root fs.

It looks like that since your fs is still mounted, the data structure
changed during the btrfs check run, it's possible to cause false alert.

> root 9214 inode 6850330 errors 2001, no inode item, link count wrong
>         unresolved ref dir 266982 index 22459 namelen 36 name 962104104=
5a17a475428a26fcfb5982f.png filetype 1 errors 6, no dir index, no inode r=
ef
>         unresolved ref dir 226516 index 9 namelen 28 name GYTSPMxjwCVp8=
kXB7+j91O8kcq4=3D filetype 1 errors 4, no inode ref
> root 9214 inode 6877070 errors 2001, no inode item, link count wrong
>         unresolved ref dir 226516 index 11 namelen 28 name VSqlYzl4pFqJ=
pvC3GA9bQ0mZK8A=3D filetype 1 errors 4, no inode ref
> root 9214 inode 6878054 errors 2001, no inode item, link count wrong
>         unresolved ref dir 266982 index 22460 namelen 36 name 52e74e9d2=
b6f598038486f90f8f911c4.png filetype 1 errors 4, no inode ref
> root 9214 inode 6888414 errors 2001, no inode item, link count wrong
>         unresolved ref dir 226391 index 122475 namelen 14 name the-real=
-index filetype 1 errors 4, no inode ref
> root 9214 inode 6889202 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 4096
> root 9214 inode 6889203 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 4096
> ERROR: errors found in fs roots
> found 334531551237 bytes used, error(s) found
> total csum bytes: 291555464
> total tree bytes: 1004404736
> total fs tree bytes: 411713536
> total extent tree bytes: 242974720
> btree space waste bytes: 186523621
> file data blocks allocated: 36730163200
>  referenced 42646511616
>=20
>=20
> However, scrub and badblock find no errors.
>=20
> # btrfs scrub status /mnt/
> scrub status for 7b19fb5e-4e16-4b62-b803-f59364fd61a2
>         scrub started at Tue Aug 13 07:31:38 2019 and finished after 00=
:02:47
>         total bytes scrubbed: 311.15GiB with 0 errors

Scrub only checks checksum, doesn't care the content.
(Kernel newer than v5.0 will care the content, but doesn't do full
cross-check, unlike btrfs-check)

>=20
> # badblocks -sv /dev/kubuntu-vg/lv_root=20
> Checking blocks 0 to 352133119
> Checking for bad blocks (read-only test):  done                        =
                        =20
> Pass completed, 0 bad blocks found. (0/0/0 errors)
>=20
> # btrfs dev stats /dev/kubuntu-vg/lv_root                              =
                                                                         =
                                               =20
> [/dev/mapper/kubuntu--vg-lv_root].write_io_errs    0
> [/dev/mapper/kubuntu--vg-lv_root].read_io_errs     0
> [/dev/mapper/kubuntu--vg-lv_root].flush_io_errs    0
> [/dev/mapper/kubuntu--vg-lv_root].corruption_errs  0
> [/dev/mapper/kubuntu--vg-lv_root].generation_errs  0
>=20
>=20
>=20
> FS mount fine, and is operational.
> would you recommend executing the btrfs check --repair option or is the=
re something else that I can try.

Don't do anything stupid yet.
Just go LiveCD/USB and check again.

>=20
> #  uname -a                                                            =
                                                                         =
                                                    Linux xps 5.1.16-0501=
16-generic #201907031232 SMP Wed Jul 3 12:35:21 UTC 2019 x86_64 x86_64 x8=
6_64 GNU/Linux

Since v5.2 introduced a lot of new restrict check, I'd recommend to go
mount with latest Archiso, btrfs-check first, if no problem, mount and
scrub again just in case.

> # btrfs --version                                                      =
                                                                         =
                                               =20
> btrfs-progs v4.15.1

Big nope. You won't really want to run btrfs check --repair on such old
and buggy progs. Unless recent releases (5.2?) btrfs-progs has a bug
that transaction is not committed correctly, thus if something wrong
happened like BUG_ON() or transaction aborted, the fs can easily be
screwed up.

Thanks,
Qu

>=20
>=20
> mount options
> on / type btrfs (rw,relatime,compress-force=3Dlzo,ssd,discard,space_cac=
he=3Dv2,autodefrag,subvol=3D/@)
>=20
> thanks,
> Konstantin
>=20


--875JHsBPou16U6OkqVv1hfJbQhGD9OR2w--

--zrnpVh6by4k8uDGZ8jCdWgu4Y6V0BtHaH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1SlzMACgkQwj2R86El
/qhhtwf8DImHlvbucYhsONWWmrjaJS5PYGzmZHUBKgkRMIlnT7YT3MDh5pfSfYJp
a374hg0NVVqbGb9gelzKA0Gp7ny5TQPQI3dOnlPvagegTifKWtWcmdDn/pIIom3n
ysFvpxpG0p4+r9YhKCSQrCcwVKDyOmEbkq4mLiiaGYyF1+hh4Vp/h4sg6mCeUotC
FXEJ/iaQV4QE+5emSLyd6riu1zAeGw0iiEIZKbdWLH2DTyWqCxGdukWMZw42e69Z
9Xs31s8KfFm4uQaqw/w/WnSML7MIGZKy6+IlQcrIdioFpAl9Ty7IfUh8NUYgWq1e
EtYPzn9S0JkFjnXoTAGtbspdxDu3BA==
=V19m
-----END PGP SIGNATURE-----

--zrnpVh6by4k8uDGZ8jCdWgu4Y6V0BtHaH--
