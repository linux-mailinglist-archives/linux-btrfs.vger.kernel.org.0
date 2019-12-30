Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9932712CCFF
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 06:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfL3Fic (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Dec 2019 00:38:32 -0500
Received: from mout.gmx.net ([212.227.15.19]:47859 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfL3Fic (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 00:38:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577684309;
        bh=a/KWCc5RU8X3eAA8nVKchrO+4fKGNUiOqtAVuKv3u5U=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=R2TEqPARnr68yWvst+gAyRZjiBRMQdYs5kgo6PuJplNfav/7GShBeoi6XjQ6iTmXJ
         K2yUy/GJ62Tk1raJrCQmsAGQDG/iD1FSnhJ8LhKXw7WUYfzZQHS4kVWujnBE79ygpq
         /eMDRsw/MLS8JKUuyBNjq6gNTzY1pTkYk1hZ+2mA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1My36T-1jg6rz34ON-00zWVd; Mon, 30
 Dec 2019 06:38:29 +0100
Subject: Re: Cannot mount or recover btrfs
To:     Raviu <raviu@protonmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <qxM9wPidCbIA9yMGE4e57cGzc5GkQnFF39Q2h1PLV0XTLpSVZ1nvi9wDfOD3YXIAl3GYyq2wRoG8ncoE692e0MVUah_rmDSRggyZz_trQH0=@protonmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <3f51a5fa-90db-7247-ec78-b57b9798b99b@gmx.com>
Date:   Mon, 30 Dec 2019 13:38:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <qxM9wPidCbIA9yMGE4e57cGzc5GkQnFF39Q2h1PLV0XTLpSVZ1nvi9wDfOD3YXIAl3GYyq2wRoG8ncoE692e0MVUah_rmDSRggyZz_trQH0=@protonmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ubt8dmZXAXNsoQeH3HebhhUeksakCaXwg"
X-Provags-ID: V03:K1:afb14BHPWz6YVsx3TZBFDsj59K7CM8T55gstoljoFTfbpbbXCpj
 8ivdsEpd2/w8yTeFxZVB7WdwO11LnEwZXiNkGtKhx7dQ/RfJLifXxAFIcZsyqCEZB7+H2dR
 P6j9Y7EYhkumsep8GsYWR77IXyig92pdqBxqoI8s3t5wNnbQpPsYsjen0e3EK38xdbDa/GU
 CVJgKPjUTjb7+C3ZwFiMg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Dem3Ty+zRQE=:w1T/gUfnXLIommue37Rh9X
 rbTfC6mNbhjb+m6MGW4LPbVyVUNqmq/Z3THuE6ZoFy6maw8/MdQH/crzD/dkIFI/UNmTsr00U
 Tpd5He4sAH4HtrgzYEQUMlMRCjxa7/op/7rwhCTUxRtqrN2Wahcg4/BI3vS3MAQzg3r9gtgge
 ePLI/G9/uA1eCB9DKJN163GnGGIh7awaC0XkDnrIXbxplU8R0La51ej8QPaO5WDIbAPPCe5ed
 6i6pRkidA1eQKy+MzY5TwThLE+bp4UQPpwhl4gVFr9/f/774jazvwbQotGhWGCZv/ejiXtldd
 rqyI2oL4KfolD+VstbJhHl6/Jts719s6ggoYA71SsYLNZ7tRfChPfP5IHv32ACniJ9eMDM1dl
 QKlFLjChL1IHaoYgQ32uRKW24TqYhO4s2MJ2X7KJ6JC+EqNOReohcfEvezOCX14yvLb/GlPhF
 MwBfnmB0YD1yNprmnrBMyPDOUCci/PfuBfT/SZrd5GonUjW3QMAz91a9FZSOrpZjV6a4O71no
 LoGmqlv9NDWchngVsfN2FzVk9bzjWkYD/zi01V1qH6HKRrNpN1Dasn/k4n3NSfODJX9P9Uj8l
 yQwSjc1W2ajCw6qJDmgS9/GCkPXe9PB1u4mkZpiVjKdJ5s0wwea9fiBL16lI4jQGtmYa9uRxq
 VjeZv29Ce6WYqtbTzV2dwNKbVY6zRDh9pgJsuCrVm9wg6kbRVdxDbEJK8lUpijuQNOdaBcf5n
 Exk35zknUHZiRhmnbJ9m8cQ4NIUiHC8+pxCFHpHduRfAMWtaFbF8z/ApJBFv1t4QGrAZTtXWp
 XYRL60VHmjU32OoIVMvMEWW8jlAyjfwq3Y1JsiGQuAGvHt5XODm/weT9LFLCzdX5GbcqM/9Sg
 CmuAZOMt0XIXPgl/mCfpJKruH358MbFw/17zL1giukw2yvJGQo8AYPo+4iJKLkU7k24ORJclt
 CkuovmCkHTe7YG8MoFnaSpUY8MYC7eg8E4Oc60bFXAvuN6DpVfbytpwrizLMA+Xa7mfCKE7Ux
 hhMCdk8b5OSt/ndT6jBsZg+rCtJR5yI4TUeqLf676g1vH4+vKLLkPgPpcXzqw3mJj8JJeMTdZ
 2eZ5oDXU+KsDSX6bC+Z6YiHFu2wy4Dae/UHKBRWJ9L7gKu32RD9ATi0CWqMJWCyE4xzU+ZOh2
 vkjLNG9uIvPAHYpoKNfoxY86+lje8HKuaRSaLR99kO8F/aqBJhon1InLs4A/Xm9YakaXwM+VD
 UzBBMkCpR9yGLA9YzMMsQ9VWGG7aHEPO3vPlZkFl29052em5xvnNnQhCakhE=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ubt8dmZXAXNsoQeH3HebhhUeksakCaXwg
Content-Type: multipart/mixed; boundary="8pXqptvUXwM6wiC7Rk7n7DbAMr1XVxSPX"

--8pXqptvUXwM6wiC7Rk7n7DbAMr1XVxSPX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/29 =E4=B8=8B=E5=8D=8811:05, Raviu wrote:
> Hi,
> My system suddenly crashed, after reboot I cannot mount /home any more.=

>=20
> `uname -a`
> Linux moonIk80 4.12.14-lp151.28.36-default #1 SMP Fri Dec 6 13:50:27 UT=
C 2019 (8f4a495) x86_64 x86_64 x86_64 GNU/Linux
>=20
> btrfs-progs v5.4
>=20
> `btrfs fi show`
> Label: none  uuid: 378faa6e-8af0-415e-93f7-68b31fb08a29
>         Total devices 1 FS bytes used 194.99GiB
>         devid    1 size 232.79GiB used 231.79GiB path /dev/mapper/cr_sd=
a4
>=20
>=20
> The device cannot be mounted.
> [  188.649876] BTRFS info (device dm-1): disk space caching is enabled
> [  188.649878] BTRFS info (device dm-1): has skinny extents
> [  188.656364] BTRFS critical (device dm-1): corrupt leaf: root=3D2 blo=
ck=3D294640566272 slot=3D104, unexpected item end, have 42739 expect 9971=


As Hugo has already pointed out, this looks very like a bit flip.
Thus a memtest is highly recommended.

Also, your kernel is a little old. I'm not sure if the distro (I guess
it's openSUSE or SLE?) had all the backports, but starts from v5.2, we
had newer write-time tree-checker to even prevent such bitflip written
back to disk, thus we could catch them earlier.



This is extent tree, in theory you can always salvage the data using
`btrfs-restore`.

But that's the last resort method.

> [  188.656374] BTRFS error (device dm-1): failed to read block groups: =
-5
> [  188.700088] BTRFS error (device dm-1): open_ctree failed
>=20
>=20
>=20
> `btrfs check /dev/mapper/cr_sda4`
> Opening filesystem to check...
> incorrect offsets 9971 42739
> incorrect offsets 9971 42739
> incorrect offsets 9971 42739
> ERROR: failed to read block groups: Operation not permitted
> ERROR: cannot open file system
>=20
>=20
If you can re-compile btrfs-progs, you can try this branch:
https://github.com/adam900710/btrfs-progs/tree/dirty_fix_for_raviu

Then use the compiled btrfs-corrupt-block (I know it's a terrible name)
to fix the fs:
# ./btrfs-corrupt-block -X /dev/dm-1

It should output what it fixed if it found anything.

Thanks,
Qu


--8pXqptvUXwM6wiC7Rk7n7DbAMr1XVxSPX--

--Ubt8dmZXAXNsoQeH3HebhhUeksakCaXwg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4JjVIXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qhQZwgApMYnCljq01Fqu0UDloxdx/3r
uKrW1rlU2Aa8GbMRybI4Vci4j1iPho6CIQlrBCoX20OraTpCWOEo1gt2EYjQ7yqU
J0+RaKOZ/kxcAjEVpl5eBV8sHHjeO3XLRn4Zh7OIis/yLQLbxzggyrzS8a/L1IT0
d4fVHseH2PZG6QxC8E7quLbDh5SnTqfJcA/QJaC93aWQq5S9+PatUfRO3Qjtqks5
SqN2jKAriUzFkO2q0b81cNtGVt9f6F70Ub4VlHb0Sedm2fJoI5g5hsKTwT/yecaV
PQD/YCHnXq4ePA14yNM5GgnhiR38lvyjgRLPZQrn46lTWYJBsQ8YpQht+DzqwA==
=Vcon
-----END PGP SIGNATURE-----

--Ubt8dmZXAXNsoQeH3HebhhUeksakCaXwg--
