Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACF514957D
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jan 2020 13:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgAYMUT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Jan 2020 07:20:19 -0500
Received: from mout.gmx.net ([212.227.15.15]:42869 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgAYMUT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Jan 2020 07:20:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579954817;
        bh=9DZzm4Arr/Z01pGjmK4wUuQUd73xlr2qiMidHH6njQQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=RRDVafUfBrd1DjZOl6VaQLZa0tJoUO5XDHuYt6rA75asLBJ2C8p993RCrR0vJvOe1
         ypK1jqXXrLEIHfEhI+aYG9TRFEU1BITssjlElcj9q0Bdg6rh+u0FqYgiVXg8Ag0m9Y
         yaSNTfQjnGhmJbwUE8Me8tDyadYudQ8oRLkv77lU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Md6Mj-1jVUFn2irD-00aCKd; Sat, 25
 Jan 2020 13:20:17 +0100
Subject: Re: Broken Filesystem
To:     Hendrik Friedel <hendrik@friedels.name>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <em16e3d03d-97be-4ddb-b4a4-6a056b469f20@ryzen>
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
Message-ID: <887af814-cec5-494f-80b3-4c2e286dc1b1@gmx.com>
Date:   Sat, 25 Jan 2020 20:20:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <em16e3d03d-97be-4ddb-b4a4-6a056b469f20@ryzen>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DsEZUXPzU0xURoGiw4da2c6I1gYbI8XhU"
X-Provags-ID: V03:K1:Ta+E0Kl6QfACzHzaOB4ElF48izy/3WNwjt07Ut+VS2Vsa1Im997
 L99X6aYASIkCagct0RFX6mvdCgIb1S2D54ssXub1Me5V9JRYR6svIzxsbHlcg5BtWJ0i4t3
 9KlVD8bDZzWxmTN9MF3vxNFMY7o/Om8wTk39JwTVEIiwc8dU93RIPHGgTuI4KtDForDCFfC
 ZpyBVQeoDLfFNaoxYK66Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ighyGG9xiPA=:RoryQEFukSxnMEvpFcBNZd
 cejZOxTZpxqKgLSayJ7nPYvW948R+S+/GPay5MI3qRPALKvljynA8+ddDGRNPbYAdm8/oE18k
 Mjqx2OJbunj8TmV2V56N289GawTgl/1U1OFQQnXMeeDGE2ceW0AgC+fezdaIgBXQDwzenfdBB
 DFqA7Ts6YdDtJElywb9rPguGgCK8a6v25OSn5LQumw+yr/qUYAZxkQP/dX24nSLdzOee0QX2W
 wFS82VsS7v2mU82daNt7M9VWiYKp0FjE+fRxMGmrOY15JZK8p5NinIgqVwOszDkgYZHCYcnNV
 MDH3feaMTk1BIUsx33SAXja+8ENUcpEntD7T8/F25kOyWqd0qz8vTen82+ra+bbdttKApVC7C
 HSPhiZcYo5ljDS1vmOMIaQcFR2i2EYjzEayT7L5hou7f/tQ0w/Nhh+7TywkhdJfIYRHbtOvuq
 wQQpD4TQ4+tGWXEidpunC/Kdri0WnlscLOTPLglR00ON21bZeAUKXb4qqg6KlgGYqCdo5hBZq
 jOLOjhyUFGsTCa462gV5W2oqgSCDSZiDcgqe0ubqYiG/Iqb0GQi/4Jn3SnsM4fkAfGS8NasvK
 pncsUfBDCaOgTm2z74VpSepNq/o2MC+fzXrrGsF4ALjTU8xOIlPA8uMbRMeGl5m4aivdH2BOi
 b/9stRfZbrwRADy6gkfCgB65j4/h+E6m0a66bK+5oVxJx6h5fyt+rG8DShUQQ6JPwtftRP6wk
 AIGlvwcYV073kyY2Sjo1yM6+YJtMOyEaCleJncbPQhtUCGrEz84d3Blpwtaqu/6dB1PbYhnu+
 E/YQlK3F3ybT0kiA1tQf38D5NA2X4bspzMpzduJH4RO7Hk8UgjJLZS6AdgwoGs6cMjGdj0UI9
 UAaHv7Fq6Cr+a8bZSqkDBx/JtgaX0I3KcikPEggiGKlmG5lLedBUg0/Kbrs+SWFQQDqq0B9XL
 V7SIts/aJpCGUXtuNpvtKv+D1vmFaivPpTuHKMPS2QYB1Nd54C7ZDMaJ5/irV23a7F9Otxz+Q
 gWm2taYfqh769YXwzz2AYtSVVS6hOt5745PXoI6UkJPzQ38OrkybU0o7u1CiaW6ny+eC0q6BK
 n1RoJB8vHeHtauebdFevkhqKjUGTgwQ9u58l+9Q+Vomvt/R+fmzP18Nsgvs00JtjJjElWIPsc
 7/N/h9ufDjPeJWzq61K1C0EKZLnuiTScY8mGR0HuPjCptLgYRMTBczFtmCmrv+56BdA3Mso8w
 5H2IzAtnx24tdHkok
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DsEZUXPzU0xURoGiw4da2c6I1gYbI8XhU
Content-Type: multipart/mixed; boundary="aGGbcXXNfeUi5KZH3GbHeddTSwNWrDnEa"

--aGGbcXXNfeUi5KZH3GbHeddTSwNWrDnEa
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/25 =E4=B8=8B=E5=8D=887:34, Hendrik Friedel wrote:
> Hello,
>=20
> I am helping someone here
> https://forum.openmediavault.org/index.php/Thread/29290-Harddrive-Failu=
re-and-Data-Recovery/?postID=3D226502#post226502
> =C2=A0to recover his data.
> He is new to linux.
>=20
> Two of his drives have a hardware problem.
> btrfs filesystem show /dev/sda
> Label: 'sdadisk1' uuid: fdce5ae5-fd6d-46b9-8056-3ff15ce9fa16
> Total devices 1 FS bytes used 128.00KiB
> devid 1 size 931.51GiB used 4.10GiB path /dev/sda
>=20
> The 4.1GiB are way less than what was used.
>=20
>=20
> We tried to mount with mount -t btrfs -o recovery,nospace_cache,clear_c=
ache
>=20
> [Sat Jan 18 11:40:29 2020] BTRFS warning (device sda): 'recovery' is
> deprecated, use 'usebackuproot' instead
> [Sat Jan 18 11:40:29 2020] BTRFS info (device sda): trying to use backu=
p
> root at mount time
> [Sat Jan 18 11:40:29 2020] BTRFS info (device sda): disabling disk spac=
e
> caching
> [Sat Jan 18 11:40:29 2020] BTRFS info (device sda): force clearing of
> disk cache
> [Sun Jan 19 11:58:24 2020] BTRFS warning (device sda): 'recovery' is
> deprecated, use 'usebackuproot' instead
> [Sun Jan 19 11:58:24 2020] BTRFS info (device sda): trying to use backu=
p
> root at mount time
> [Sun Jan 19 11:58:24 2020] BTRFS info (device sda): disabling disk spac=
e
> caching
> [Sun Jan 19 11:58:24 2020] BTRFS info (device sda): force clearing of
> disk cache
>=20
>=20
> The mountpoint does not show any data when mounted
>=20
> Scrub did not help:
> btrfs scrub start /dev/sda
> scrub started on /dev/sda, fsid fdce5ae5-fd6d-46b9-8056-3ff15ce9fa16
> (pid=3D19881)
>=20
> btrfs scrub status /dev/sda
> scrub status for fdce5ae5-fd6d-46b9-8056-3ff15ce9fa16
> scrub started at Sun Jan 19 12:03:35 2020 and finished after 00:00:00
> total bytes scrubbed: 256.00KiB with 0 errors
>=20
>=20
> btrfs check /dev/sda
> Checking filesystem on /dev/sda
> UUID: fdce5ae5-fd6d-46b9-8056-3ff15ce9fa16
> checking extents
> checking free space cache
> cache and super generation don't match, space cache will be invalidated=

> checking fs roots
> checking csums
> checking root refs
> found 131072 bytes used err is 0
> total csum bytes: 0
> total tree bytes: 131072
> total fs tree bytes: 32768
> total extent tree bytes: 16384
> btree space waste bytes: 123986
> file data blocks allocated: 0
> referenced 0

Your fs is completely fine. I didn't see anything wrong from your `btrfs
check` result nor your kernel messages.

>=20
>=20
> Also btrfs restore -i -v /dev/sda /srv/dev-disk-by-label-NewDrive2 | te=
e
> /restorelog.txt did not help:
> It came immediately back with 'Reached the end of the tree searching th=
e
> directory'
>=20
>=20
> btrfs-find-root /dev/sda
> Superblock thinks the generation is 8
> Superblock thinks the level is 0
> It did not finish even in 54 hours
>=20
> I am out of ideas. Can you give further advice?

Since your fs is OK, what's wrong?

Maybe just mounted wrong subvolume?

Thanks,
Qu

>=20
> Regards,
> Hendrik
>=20


--aGGbcXXNfeUi5KZH3GbHeddTSwNWrDnEa--

--DsEZUXPzU0xURoGiw4da2c6I1gYbI8XhU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4sMn4ACgkQwj2R86El
/qitPQf/alK8bDNxHcFWg/jWHCcxxhqYYtq4O07SilKdSK4ma6PALd38z0YPB3Cm
g+r8/31afUZ1MhX4gUGqMY5ZQKrWfUBbodV3YxH0re7i2VAiDVj7V88IRlqBZtkr
REeiQHkVUcWT7rilm5DLw9HSSz/8IwarczTx6xbYvoGNoovrq28Q5hNMoA3BD0Rf
V6IIi8ax2Tw/Nl4fcMdmBiTCenT5SR7BzHEP5kCB5jkYo91cNw4VBcxK9gnpEmjD
hyOjvrlaE6RsHp4fmSn2kwotcGFbO+6uF6srqdAbLAF2ZJPCHvulvFAk2j71xizU
i8zkQ5zKJnCdvF3/l4ZmWyF43YXGQw==
=iVmF
-----END PGP SIGNATURE-----

--DsEZUXPzU0xURoGiw4da2c6I1gYbI8XhU--
