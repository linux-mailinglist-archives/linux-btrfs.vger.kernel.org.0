Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E52ADE40C5
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2019 02:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388424AbfJYA4z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Oct 2019 20:56:55 -0400
Received: from mout.gmx.net ([212.227.15.19]:39643 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388288AbfJYA4z (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Oct 2019 20:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571965007;
        bh=XV23hmwvvCVXgFL1b6fR/I4CtPEEYrSLNsRI5aF28KM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OpAYNPhpf3aCFBImn6bxOHvqrB906NRrE1xG749xwmOUY1uvKTVE66sDAtGxdWH2t
         /IjObK9S8rZpKpUssN2go5nLMBHGEfAIefOHZTOjHYOMwzXrQwreiFJIrbQxs/COJZ
         wxSL2rbcE0kBXbI4GFtlPa7S/HESS7xnxIifz8Ys=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MSKyI-1iYlBm1Ljs-00SbBg; Fri, 25
 Oct 2019 02:56:47 +0200
Subject: Re: [PATCH 2/2] btrfs: provide an estimated number of inodes for
 statfs
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20191024154455.19370-1-jthumshirn@suse.de>
 <20191024154455.19370-3-jthumshirn@suse.de>
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
Message-ID: <f1ecf175-9b4f-36bb-add7-b95bc26bc5e5@gmx.com>
Date:   Fri, 25 Oct 2019 08:56:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191024154455.19370-3-jthumshirn@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tFLHZcKVmUQtATLEeCPG2VidYN3sN0SNF"
X-Provags-ID: V03:K1:rA8XGCpQYgeKu1Rfi/sxVriP2mnJQmJ5FMMXTNzWAjTVdGBbkO3
 99ShoxKqGkAPKNudtuGAZFnDiUokc0reFHot7IvaqyZk83/Nah+rLSgq3vNMyauGcXCRi2o
 s/UGlySky3tAxUf5o5dUsZ5tOm0bLFTv1pTwN/OBNJydxTDwHTQz6h4s4OFxxQw6QxPcevB
 r1cdVJrQoL0EdPKxr3PkA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4dEIt2vnxxA=:OfGeEtdhIRy5qaqrjDPedf
 JuInviLkF4MBg1TqJPvt7exjY/a2erFXQAcLNz0vFijoTHg/xvf/7nv7a+7+bfY2Xsei2tpnI
 rkgkeoTCig5sLK2VPCtGorUBT8mLgpcmhlzwdaAuhaI8dYtGQ/sS0CXe8ku3/aNRpXkZozg0O
 EqgxBavI0QDwOBhHTkd3zWJf7OvoydyvUevzvh01yL6nnoX81GsmFYYmMgo0RXoKAs5QTPwoS
 Z/KN9l0kl2h6lNMq7m0NV4TWdB17NXcM5UhvasbN1tv3n7Fy8mPWJTkdw9RkOaqaB5VQksKyH
 DfSzNocG7Z7Uq4MCIwdrIUDVUIYa4QTUB73wTLWG9HhUGTMpjv5C4kaIykq2g+W4Bo6iW3mnZ
 1oPgkBkQxVxoReuN5sg1omQWtM8KTaaf8fiprB1QrVt/mc4zAcsHqalxS30cf2Mz04RbDW0NO
 MJ+oKTMSn3zSn1NT4WwD0KlmJ5cLLbv41rQVzZjtOPh+SciO3IMw0XbdW45KF5mcRcnlPqV5m
 Fw9by9Mr4fOu2czaNlfuvuNR2nx+1ltEdMkv5IIAGHzufaGU2e8yb65CQ32tb3amIWGg/w26E
 hvHPsrGWIY2HnFbXJ8dldoonz9bCJ9GZxyW73HvFQvoZXiH59wde2M5xA3Wzjp3fMbSah8ND1
 Gtd537eajLM8jnBiG36qY927MZRsgf7mvodK2GO8JaaKwOPCPKBv7lBC6Tru287U94plr84PB
 8Bq/5813aoBsaba5xtoLkGxrqoqSiBmdjTI34beiX4YoMRxjRef1OrNHej4EWpi0PKttoF8Jl
 Tx60ZfwxxxHK9qQFwbm1FEpmDkEGi11Oytnul40xoYK/odd7aHgZb7BFvzJTPblzpWms0OtUg
 pxV6hqDyCj3h+uNRvR9g/Beitld+KqHQ6AOAv+1yeCkGGmNzwjNfb4TeiRkPdip4pzA0HB4YU
 skUkRh9C3pCHlYe5il3CEo/kBFS6TrA18569dqG9uY4bQFQDcnWU1i+i0WnhUIu/EKuG9l9mB
 wZHjZB8wfMXQr7/eKMNGb8apjdYCqUliln0I2DP8b6CWW5H7pngieBGZNKjJx7xyv5amo5sqx
 rvQEF/sCj37RtUSkZFs46bcAFrV2VmuLWZXvigiDjKLY89WNh5NKoMjtFFU9vbHxuzW/105je
 yeZGz0/eQ8xtjVZSxpoE67XAGYWE3TkjSN3FcJfGgebckLNGL2y6eIUJCsg71zL7lc4OCJj8B
 Ea8+dsYlFBGsvFdI5qdhAKhDYfhdfpTdr0xp5uzebIkhDpzDkWhfALXjZ1tE=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tFLHZcKVmUQtATLEeCPG2VidYN3sN0SNF
Content-Type: multipart/mixed; boundary="iGYzfDZ69gOH49eN7uG3gVjixNuzMp2XY"

--iGYzfDZ69gOH49eN7uG3gVjixNuzMp2XY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/24 =E4=B8=8B=E5=8D=8811:44, Johannes Thumshirn wrote:
> On the BeeGFS Mailing list there is a report claiming BTRFS is not usab=
le
> with BeeGFS, as BeeGFS is using statfs output to determine the number o=
f
> total and free inodes. BeeGFS needs the number of free inodes as it sto=
res
> its meta-data either in extended attributes of the underlying file-syst=
em
> or directly in an inline inode. According to the BeeGFS Server Tuning
> Guide:
>=20
> """
> BeeGFS metadata is stored as extended attributes (EAs) on the underlyin=
g
> file system to optimal performance. One metadata file will be created f=
or
> each file that a user creates. About extended attributes usage: BeeGFS
> Metadata files have a size of 0 bytes (i.e. no normal file contents).
>=20
> Access to extended attributes is possible with the getfattr tool.
>=20
> If the inodes of the underlying file system are sufficiently large, EAs=

> can be inlined into the inode of the underlying file system.  Additiona=
l
> data blocks are then not required anymore and metadata disk usage will =
be
> reduced.  With EAs inlined into the inode, access latencies are reduced=
 as
> seeking to an extra data block is not required anymore.
> """

Personally speaking, reporting 0 used and 0 free should be the proper
way. User of the fs should be aware of dynamical fs which doesn't go
fixed inodes.

I really think it's BeeFS' job to change their behavior.

Since there are more thing to consider when faking the used/free inodes.

>=20
> Provide some estimated numbers of total and free inodes in statfs by
> dividing the number of blocks by the size of an inode-item for the tota=
l
> number of possible inodes and for the number of free inodes divide the
> number of free blocks by the size of an inode-item, similar to what oth=
er
> file-systems without a fixed number of inodes do.
>=20
> This of is just an estimation and should not be relied upon.
>=20
> Without the patch applied:
> rapido1:/# df -hTi /mnt/test
> Filesystem     Type     Inodes IUsed IFree IUse% Mounted on
> /mnt/test      btrfs         0     0     0     - /mnt/test
>=20
> With the patch applied on an empty fs:
> rapido1:/# df -hTi /mnt/test
> Filesystem     Type     Inodes IUsed IFree IUse% Mounted on
> /dev/zram0     btrfs      1.6K     0  1.6K    0% /mnt/test
>=20
> With the patch applied on a dirty fs:
> rapido1:/# df -hTi /mnt/test
> Filesystem     Type     Inodes IUsed IFree IUse% Mounted on
> /dev/zram0     btrfs      1.6K  1.5K   197   88% /mnt/test
>=20
> Link: https://groups.google.com/forum/#!msg/fhgfs-user/IJqGS5o1UD0/8ftD=
dUI3AQAJ
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  fs/btrfs/super.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index b818f764c1c9..6f6f6a70eb1e 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2068,6 +2068,8 @@ static int btrfs_statfs(struct dentry *dentry, st=
ruct kstatfs *buf)
>  	buf->f_blocks =3D div_u64(btrfs_super_total_bytes(disk_super), factor=
);
>  	buf->f_blocks >>=3D bits;
>  	buf->f_bfree =3D buf->f_blocks - (div_u64(total_used, factor) >> bits=
);
> +	buf->f_files =3D div_u64(buf->f_blocks, sizeof(struct btrfs_inode_ite=
m));

That's too optimistic. (I'd call it even beyond Elon Musk's schedule)

We have tree block header overhead, and with the increase of tree
blocks, the size of extent tree will also increase and bring overhead.

In long run, user will report that the ffiles increases more than they us=
ed.
It will be a hell to calculate such estimation, and we will never reach
a good enough point for that.

> +	buf->f_ffree =3D div_u64(buf->f_bfree, sizeof(struct btrfs_inode_item=
));

The same can be applied to ffree, it will decrease faster than real usage=
=2E

If whatever the distributed fs is using ffree/files as an indicator,
it's not reliable anyway. And if they accept such unreliable indicator,
they'd better double think before using that indicator.

Thanks,
Qu

> =20
>  	/* Account global block reserve as used, it's in logical size already=
 */
>  	spin_lock(&block_rsv->lock);
>=20


--iGYzfDZ69gOH49eN7uG3gVjixNuzMp2XY--

--tFLHZcKVmUQtATLEeCPG2VidYN3sN0SNF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2ySEgACgkQwj2R86El
/qiJHwgAphI6FYJ43jTIgQSkAB+Pwetg5mD+Bz/eDAUGhMwECCmcaBFh0jdb1YoJ
c8apLIiKJlkN+3lth+ANfW//WLJays+euvomOAOP2723Ej9Pq1bb2V9tRv7iu+gm
B8RKKG43S0Q8ygGQIgNuQlTijc48cWbJ3sbyggFSBJR4XJIzn+Sk8OJBnzWMXn5n
wFCi1smgqQYSViL6B+M/YXHgdbEJlAY7dLnR3ecU6JVgSnfTyr5qsfj/1XBtl4Fm
mPkWb7kUb/IfnK36oaHWoF4XymfIWrQcMZucU0yZ7IwtBlCl3VDlj054oSA99n/B
Zex+cFZIyko99I4oF/c/FtO5ecIOAA==
=WhOT
-----END PGP SIGNATURE-----

--tFLHZcKVmUQtATLEeCPG2VidYN3sN0SNF--
