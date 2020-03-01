Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9B25174C44
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Mar 2020 09:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgCAI0p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Mar 2020 03:26:45 -0500
Received: from mout.gmx.net ([212.227.15.19]:41389 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgCAI0p (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 1 Mar 2020 03:26:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583051186;
        bh=Se6fy0yaXrRSFc6T0ugnA4aq/KcNvxZLynIYD3dQw0o=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ei7SQz1fsS7aYvTNYS0+iBgWA5w/7XC6xjSZrpN8tJHx0fiitaWPyrW9awQm1QG/6
         6cptc++IJbp+1GAeE0Smdx7ZU93hq7blPcEYSSN9XvXNfMO0TP7wfFsgNxo/YNSJ3m
         RJrqBIuqKciNjqHEv+iYZMZzpOTzTunGOXw8deVs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M8hV5-1j3cxc2iUj-004lXn; Sun, 01
 Mar 2020 09:26:26 +0100
Subject: Re: [PATCH 1/3] progs: Remove manpages of not packaged binaries
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
References: <20200301033344.808-1-marcos@mpdesouza.com>
 <20200301033344.808-2-marcos@mpdesouza.com>
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
Message-ID: <e8a6bb6a-5c8b-5898-d00a-39a739816664@gmx.com>
Date:   Sun, 1 Mar 2020 16:26:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200301033344.808-2-marcos@mpdesouza.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="g8p4hvnIt2DKJhiXzE1YMGqCIRfJ1MgwN"
X-Provags-ID: V03:K1:dO8jVQKT4Ek6MssmYYySFbhxUICvpe2LJuEJwQlRU2rXFMle77X
 SZFAKXV0NeojPyDCuJYbZrn0RZyHD9n36WmGKD54yWrsGF3DXlXrcHx76RLH0nH934MZOGg
 7arzZ3U8011Q1zywSvMyoCM2ZRBb+9uPgNV8ZpqFt9bfD+8ihRRGfRmWAw8nIZ4azZQ9+pE
 /ZTnCIuUR7iJb6Zv7mnEA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OPcEkbAJKN8=:5l943NbQ3SULttycYgeQEW
 kcp6hSZ/R2VJvgIA2y225Yro6x3B+92gA+IqnHPaj1jwtRdSkHdBNS/pO512BLD830Oe5SRWO
 OoN6Ywn1anuhgPdgjiD19uPHvXFkKwgj1aD4rhQK+l+qBLCVeWiaMdnNFWkrPjnx+uy67Is9F
 RnXGN30XuYG8pvUQE0WRdFENqYmf3RP5bxb3NbINCG3KC2zvVBeaBGC99F92qmiSrDzVdtruB
 15PtURu0uSbjPgnGLZwf2oEKJyvhfFA7U20Sg0Yl1BQaNEOrg/jmE75GkJNRpExbXGRykRr/Z
 n2snpFu85yq7DY+HTAH0W3ldmpREPaVgMB+cD7QSfVfqAglHhLW7b3nx2k13bMwaMcchqOLuG
 v0nKVYCC0e8pSzRzQtPgDxjQYaXVPZl2GeVM8vs7oxgNOq/53hg69EskDqrrPWrSJ+weh2Xc0
 TouKacVPJM1ED2qlTMtdDWvWxHz4s/BHe5fAI7b7gtiqb42mll8R+OBni16WwvSDQ8B+9lN4a
 tU6Otr0ZOgBX7Y3o7NcDgtCErAE5NCj2oGfw971+j3DeqYaQS7XNOWYDl0yN9OVqntQNtPv3T
 tDeK/QOSKiN3BHRg/946Zz1GCMS3Y1riS/sj4jb1Sx5on70k8hExtxBmagV6EaPfgnnEecgIa
 J7DC8tuWGXdCg1INjDXr+QX9Ayo8zm5jurZcvWvDyScOq1Np9Jv9OHB+nX0E0jM3U0QgB4VLS
 ONi+3oGVSxjudsfBSDE1qA8cE28Z4KbeVN2ITVIkn65s87fiXILGtZKJ5CZCt+E5HtgUl7LLV
 7hashpOQWFu7vSXNuKYLm2O7dJ2nD81qAyNrMsRBsK6PN12TfjB6xTu+hFY8TJ5gPM7eD8Jfz
 kg4NnQDfhdOryXWGirHby+/nyxFfbThWekUBfZUJNhlXTTQ8LWctYdD4OehBuHq+uek9x/A0O
 xsDuMImZs1ok/fBC5LQa6d8nUNOmvi8kKF5ekmfbFVckDgOxHF11LLmnEpbl/c4pDY0gNp2ff
 5cd0twLa9bcmIrFVoTY+xOv+98h5+GDqBQqaUeXmjbt40NpAysaJacr3vEN4Mdpxqh3NZqoDf
 YkT7l3RlnRFxwCJg8Vmvpk6WqwqRzQlghRJ7L+zuD1m/tLchysNd4B0vD9wgh3r97m3HggoUd
 RkDRPFdcVOevkICZ70TsVhpcBwWfZXICuiW2aCyj4I7rjTrFNaqreUChuuMs6CR1X4ta1kSth
 C9D8sU15UXGwKSRlK
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g8p4hvnIt2DKJhiXzE1YMGqCIRfJ1MgwN
Content-Type: multipart/mixed; boundary="KsHmnCIHYJAJ2atqmnyiFMMyzogsjNySu"

--KsHmnCIHYJAJ2atqmnyiFMMyzogsjNySu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/1 =E4=B8=8A=E5=8D=8811:33, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>=20
> btrfs-find-root and btrfs-select-super stopped to be shipped in 2014, s=
o
> remove all references to these manpages as well.

Nope, my distro is still shipping it, and I find it kinda useful for
certain recovery scenario.

Thus it's better to keep their documents.

Thanks,
Qu

>=20
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  .gitignore                                |  2 -
>  Documentation/Makefile.in                 |  2 -
>  Documentation/btrfs-find-root.asciidoc    | 35 -----------------
>  Documentation/btrfs-select-super.asciidoc | 46 -----------------------=

>  Documentation/btrfs.asciidoc              |  2 -
>  5 files changed, 87 deletions(-)
>  delete mode 100644 Documentation/btrfs-find-root.asciidoc
>  delete mode 100644 Documentation/btrfs-select-super.asciidoc
>=20
> diff --git a/.gitignore b/.gitignore
> index aadf9ae7..2b1c1aef 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -73,7 +73,6 @@
>  /Documentation/btrfs-convert.8
>  /Documentation/btrfs-device.8
>  /Documentation/btrfs-filesystem.8
> -/Documentation/btrfs-find-root.8
>  /Documentation/btrfs-image.8
>  /Documentation/btrfs-inspect-internal.8
>  /Documentation/btrfs-ioctl.3
> @@ -87,7 +86,6 @@
>  /Documentation/btrfs-rescue.8
>  /Documentation/btrfs-restore.8
>  /Documentation/btrfs-scrub.8
> -/Documentation/btrfs-select-super.8
>  /Documentation/btrfs-send.8
>  /Documentation/btrfs-subvolume.8
>  /Documentation/btrfs.8
> diff --git a/Documentation/Makefile.in b/Documentation/Makefile.in
> index d35cb858..ff0459c0 100644
> --- a/Documentation/Makefile.in
> +++ b/Documentation/Makefile.in
> @@ -4,10 +4,8 @@ MAN8_TXT =3D
>  # Top level commands
>  MAN8_TXT +=3D btrfs.asciidoc
>  MAN8_TXT +=3D btrfs-convert.asciidoc
> -MAN8_TXT +=3D btrfs-find-root.asciidoc
>  MAN8_TXT +=3D btrfs-image.asciidoc
>  MAN8_TXT +=3D btrfs-map-logical.asciidoc
> -MAN8_TXT +=3D btrfs-select-super.asciidoc
>  MAN8_TXT +=3D btrfstune.asciidoc
>  MAN8_TXT +=3D fsck.btrfs.asciidoc
>  MAN8_TXT +=3D mkfs.btrfs.asciidoc
> diff --git a/Documentation/btrfs-find-root.asciidoc b/Documentation/btr=
fs-find-root.asciidoc
> deleted file mode 100644
> index 652796c8..00000000
> --- a/Documentation/btrfs-find-root.asciidoc
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -btrfs-find-root(8)
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -NAME
> -----
> -btrfs-find-root - filter to find btrfs root
> -
> -SYNOPSIS
> ---------
> -*btrfs-find-root* [options] <device>
> -
> -DESCRIPTION
> ------------
> -*btrfs-find-root* is used to find the satisfied root, you can filter b=
y
> -root tree's objectid, generation, level.
> -
> -OPTIONS
> --------
> --a::
> -Search through all metadata extents, even the root has been already fo=
und.
> --g <generation>::
> -Filter root tree by it's original transaction id, tree root's generati=
on in default.
> --o <objectid>::
> -Filter root tree by it's objectid,tree root's objectid in default.
> --l <level>::
> -Filter root tree by B-+ tree's level, level 0 in default.
> -
> -EXIT STATUS
> ------------
> -*btrfs-find-root* will return 0 if no error happened.
> -If any problems happened, 1 will be returned.
> -
> -SEE ALSO
> ---------
> -`mkfs.btrfs`(8)
> diff --git a/Documentation/btrfs-select-super.asciidoc b/Documentation/=
btrfs-select-super.asciidoc
> deleted file mode 100644
> index e3bca98b..00000000
> --- a/Documentation/btrfs-select-super.asciidoc
> +++ /dev/null
> @@ -1,46 +0,0 @@
> -btrfs-select-super(8)
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -NAME
> -----
> -btrfs-select-super - overwrite primary superblock with a backup copy
> -
> -SYNOPSIS
> ---------
> -*btrfs-select-super* -s number <device>
> -
> -DESCRIPTION
> ------------
> -Destructively overwrite all copies of the superblock
> -with a specified copy.  This helps in certain cases, for example when =
write
> -barriers were disabled during a power failure and not all superblocks =
were
> -written, or if the primary superblock is damaged, eg. accidentally ove=
rwritten.
> -
> -The filesystem specified by 'device' must not be mounted.
> -
> -NOTE: *Prior to overwriting the primary superblock, please make sure t=
hat the backup
> -copies are valid!*
> -
> -To dump a superblock use the *btrfs inspect-internal dump-super* comma=
nd.
> -
> -Then run the check (in the non-repair mode) using the command *btrfs c=
heck -s*
> -where '-s' specifies the superblock copy to use.
> -
> -Superblock copies exist in the following offsets on the device:
> -
> -- primary: '64KiB' (65536)
> -- 1st copy: '64MiB' (67108864)
> -- 2nd copy: '256GiB' (274877906944)
> -
> -A superblock size is '4KiB' (4096).
> -
> -OPTIONS
> --------
> --s|--super <superblock>::
> -use 'superblock'th superblock copy, valid values are 0 1 or 2 if the
> -respective superblock offset is within the device size
> -
> -SEE ALSO
> ---------
> -`btrfs-inspect-internal`(8),
> -`btrfsck check`(8)
> diff --git a/Documentation/btrfs.asciidoc b/Documentation/btrfs.asciido=
c
> index 1625f6d8..e3328942 100644
> --- a/Documentation/btrfs.asciidoc
> +++ b/Documentation/btrfs.asciidoc
> @@ -115,8 +115,6 @@ Tools that are still in active use without an equiv=
alent in *btrfs*:
> =20
>  *btrfs-convert*:: in-place conversion from ext2/3/4 filesystems to btr=
fs
>  *btrfstune*:: tweak some filesystem properties on a unmounted filesyst=
em
> -*btrfs-select-super*:: rescue tool to overwrite primary superblock fro=
m a spare copy
> -*btrfs-find-root*:: rescue helper to find tree roots in a filesystem
> =20
>  Deprecated and obsolete tools:
> =20
>=20


--KsHmnCIHYJAJ2atqmnyiFMMyzogsjNySu--

--g8p4hvnIt2DKJhiXzE1YMGqCIRfJ1MgwN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5bca0ACgkQwj2R86El
/qjkBAf9HP7xO2K3IK3EzvW7H4aLbJ7YRxcSzO8VQUTNxeuFCpgkiNSr6Q0iaP9E
lSKwrSXFAoPHoN7AgX4v6dUtStQNNFOC4OWjaqvhGJyY1f9KlfHvw8lHEedi5MII
w403uUYk++q0FO4784zTALvmAhk05runk4ZcAtEY/xZ86+yitpvfWo3BXYiwqu72
a/erxbuomPXkEE5gu00pIB+J54RfoOf8+s+YwL2E5E0V76QntbZrk41enpdBVeUT
kImIOg/1yXlXFl+ES10Po2pTMyWeegL9njaKKD6EPR9O391eo4TWqSPHhhx0/74K
UB2IRgYl2PpVSpDm5pBuvXBpZGpChg==
=FtSK
-----END PGP SIGNATURE-----

--g8p4hvnIt2DKJhiXzE1YMGqCIRfJ1MgwN--
