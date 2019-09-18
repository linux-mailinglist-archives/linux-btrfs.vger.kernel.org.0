Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC7ACB6300
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2019 14:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbfIRMWt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Sep 2019 08:22:49 -0400
Received: from mout.gmx.net ([212.227.17.20]:52391 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726941AbfIRMWs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Sep 2019 08:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568809362;
        bh=YQhx3qry958VOSvpfWXEOYiq7nWiQPWSOwPuPBQnx7M=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=btkTTyZZEGq7gi+7mSV36R2t20+SmgffnJkiQlsoQR3F+825PRT+Y6eMOcWhGdlJ/
         ZvQ7zFGsG51Bp5i6uiJrFusZOWwTM6Bni5CrwKIAjKAXk0PMnLgwOy0po4Zqf6nWuN
         kIt/u8/LfZ1Z7CYwI4i7W0m6KxgroWdpm0zEUJCc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0M3u86-1hsceh1sGI-00rUyX; Wed, 18
 Sep 2019 14:22:42 +0200
Subject: Re: [PATCH] Btrfs: fix selftests failure due to uninitialized i_mode
 in test inodes
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20190918120852.764-1-fdmanana@kernel.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
Message-ID: <35dbd7db-ab20-111b-3ba4-01a0cd947f58@gmx.com>
Date:   Wed, 18 Sep 2019 20:22:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190918120852.764-1-fdmanana@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4tvY03OPMx2JSfeJS5Pc9LXRGeAIIovIO"
X-Provags-ID: V03:K1:NRKXmRLD1dlfnn8MZ1Fnh5MtfdNj2lLAZZSuDlorpQkc9FfIQOj
 UEiArxHUpj4vdHrDrBnmojXcOxg/cUo3ywJ1+To1Q+n8WjtAfVvMCv3bxjx685bcrNEy1ux
 nxlyJXpUeNHQ9eYuHowWX3Gj+dZ5Xh3+v3/k2fyGoIp5eBCvMl53X6GaVBiqZb0VlScU0sY
 G2qMt354mSBSqQj7R2AZQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7B859PSkpec=:hiJFQVF3scX+anqMQ/QIQ8
 QehHTpZG/Ue0phANH2t+KGGiue7LkdODP4Ggtic9xa2suJk4xmZ40Px69pEuvEddTiOn0RTiW
 zMiEr68+Kw0W6J5v6C0s6bSqcYL1hvD1SluObBgi2ada85DK0PicwyA8WjNOOUYUR8uhgf2nm
 Mn9PZou/n32HJBv/Xa7JQwGn20vYNCVRtxTmoLmSIgLehN4liZ/w2v+NZLCNlWBxCCoWz1K9c
 75NeQAZyyQLjMzlI5vKtK+OC8KyCPv4DBnFAekZMJJr1J3sRFAycptS5S7kDKZPVrvNEQxBMq
 N6chGK2MSh4EpoZkh50ayUtP5vgo2eu32gl0E+Zmh+WKDMdxV62dpuO5X6O1Olj2ZPR5X7Ah6
 IBMN37NjhnluNFNMbLKoV49yKhCWyJbjaIyAbQZbuz4t5WhH1qXHknFws0BtQwAGdMjhTlrmg
 A6pkc1oREvklo3RexThXTXPiCKeAMDQAGVdvnHXJOm4XmGwLrDTHBQ4KVVCCM6mEJ1cnRSwxy
 DFA2emKWRWNSxHySrTar/319wiSo4LEY8R1DdgXnMFC3/uMQCsYSvCnxjHOA5XGskP7HjB3ms
 EzhZjwYVT0QlNvT0fxBWaddbSiP5F+Rzauqx2JxUOQL42R15xRmKDJ9EsyUYY0mQ2CCcdN58i
 QE6F1uTK8nBVdpi0/YdvyBKKmN9F97049bu6oDlnIYRra8Rxm92dnby1ztgryPumhwTi2CzNv
 xtkG3YirZR2TX0O/Jkjfq8moXB2JBVmXpZdi3qNCJrNdhOmNB6gJmXMkSq0YWOLiV3oktnneU
 ZSQA/QDGJfxGmd79Kfr7WlvlMNlxoRWko5UvK3LqJjMAJMwPMsy5UIefVktYc7BALJsrWsDzs
 ZkoH9TzHdPLlS25HOUZJYzbc3s6T2yrfJmTXN4WOUHtO7OoGAlox9JhCMUe9PT0r1cqXNoict
 p9QocPsHmULH/jl5FhB14ZwJTXcr51hTn/OWARl7+mXsktgnhvJgYcCe7AzHAPk89FeA7A5E6
 uvssv1ylT5UNEESOenGJaAzKgl6ADjzZ8DEVQJTwaUlGS6nGt+qPqLcA1PCuC9Yhiqz2mXSYc
 Mnhot3LqiJ3s5xFiO54Y0x2PI4Tfk4YCDh48cZSnutHDFVo+M5VZx4x4oeNSyZwvnM5DMDNZB
 VKbKpeFI6Wj9GyK57oYCWY/Ds5S1epJY8l/lMox+af3sxEH74K5BPzbAVb+lyEnluQ+D8Ch4p
 3z3tm8fHSCWTb+0CUZpxQ8ZHKBMBZmBl7AkwCYJyZhmRNAhdG/kzd5oMxxug=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4tvY03OPMx2JSfeJS5Pc9LXRGeAIIovIO
Content-Type: multipart/mixed; boundary="Xy7H00mQoVdPGN84i81YOlXtli7xJWpiW"

--Xy7H00mQoVdPGN84i81YOlXtli7xJWpiW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/18 =E4=B8=8B=E5=8D=888:08, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> Some of the self tests create a test inode, setup some extents and then=
 do
> calls to btrfs_get_extent() to test that the corresponding extent maps
> exist and are correct. However btrfs_get_extent(), since the 5.2 merge
> window, now errors out when it finds a regular or prealloc extent for a=
n
> inode that does not correspond to a regular file (its ->i_mode is not
> S_IFREG). This causes the self tests to fail sometimes, specially when
> KASAN, slub_debug and page poisoning are enabled:
>=20
>   $ modprobe btrfs
>   modprobe: ERROR: could not insert 'btrfs': Invalid argument
>=20
>   $ dmesg
>   [ 9414.691648] Btrfs loaded, crc32c=3Dcrc32c-intel, debug=3Don, asser=
t=3Don, integrity-checker=3Don, ref-verify=3Don
>   [ 9414.692655] BTRFS: selftest: sectorsize: 4096  nodesize: 4096
>   [ 9414.692658] BTRFS: selftest: running btrfs free space cache tests
>   [ 9414.692918] BTRFS: selftest: running extent only tests
>   [ 9414.693061] BTRFS: selftest: running bitmap only tests
>   [ 9414.693366] BTRFS: selftest: running bitmap and extent tests
>   [ 9414.696455] BTRFS: selftest: running space stealing from bitmap to=
 extent tests
>   [ 9414.697131] BTRFS: selftest: running extent buffer operation tests=

>   [ 9414.697133] BTRFS: selftest: running btrfs_split_item tests
>   [ 9414.697564] BTRFS: selftest: running extent I/O tests
>   [ 9414.697583] BTRFS: selftest: running find delalloc tests
>   [ 9415.081125] BTRFS: selftest: running find_first_clear_extent_bit t=
est
>   [ 9415.081278] BTRFS: selftest: running extent buffer bitmap tests
>   [ 9415.124192] BTRFS: selftest: running inode tests
>   [ 9415.124195] BTRFS: selftest: running btrfs_get_extent tests
>   [ 9415.127909] BTRFS: selftest: running hole first btrfs_get_extent t=
est
>   [ 9415.128343] BTRFS critical (device (efault)): regular/prealloc ext=
ent found for non-regular inode 256
>   [ 9415.131428] BTRFS: selftest: fs/btrfs/tests/inode-tests.c:904 expe=
cted a real extent, got 0
>=20
> This happens because the test inodes are created without ever initializ=
ing
> the i_mode field of the inode, and neither VFS's new_inode() nor the bt=
rfs
> callback btrfs_alloc_inode() initialize the i_mode. Initialization of t=
he
> i_mode is done through the various callbacks used by the VFS to create
> new inodes (regular files, directories, symlinks, tmpfiles, etc), which=

> all call btrfs_new_inode() which in turn calls inode_init_owner(), whic=
h
> sets the inode's i_mode. Since the tests only uses new_inode() to creat=
e
> the test inodes, the i_mode was never initialized.
>=20
> This always happens on a VM I used with kasan, slub_debug and many othe=
r
> debug facilities enabled. It also happened to someone who reported this=

> on bugzilla (on a 5.3-rc).
>=20
> Fix this by setting i_mode to S_IFREG at btrfs_new_test_inode().
>=20
> Fixes: 6bf9e4bd6a2778 ("btrfs: inode: Verify inode mode to avoid NULL p=
ointer dereference")
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D204397
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

However I'm interested why it doesn't get triggered reliably.
As I have selftest compiled in everytime.

Is there anything racy caused the bug?

Thanks,
Qu

> ---
>  fs/btrfs/tests/btrfs-tests.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.=
c
> index b5e80563efaa..99fe9bf3fdac 100644
> --- a/fs/btrfs/tests/btrfs-tests.c
> +++ b/fs/btrfs/tests/btrfs-tests.c
> @@ -52,7 +52,13 @@ static struct file_system_type test_type =3D {
> =20
>  struct inode *btrfs_new_test_inode(void)
>  {
> -	return new_inode(test_mnt->mnt_sb);
> +	struct inode *inode;
> +
> +	inode =3D new_inode(test_mnt->mnt_sb);
> +	if (inode)
> +		inode_init_owner(inode, NULL, S_IFREG);
> +
> +	return inode;
>  }
> =20
>  static int btrfs_init_test_fs(void)
>=20


--Xy7H00mQoVdPGN84i81YOlXtli7xJWpiW--

--4tvY03OPMx2JSfeJS5Pc9LXRGeAIIovIO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2CIY0ACgkQwj2R86El
/qg1FAgAgTN3EZNeAmXTSbiYIbp2buIYTzUHalWUI+ozOtKf5CTX8kytKlJDhzQg
b+7aiZFebMbjHwgnnmevwLX1Ja6bA63MkMulSsm/Ql5FcvnOSg/rGBZtpx9/zYG/
8PBl8uLFO7nTKGYSqW2o3CQ/jRE1Yf6Oj+lPMa2cPr/Q1UtcnjZ2lMsixBIe20hy
T68ioJSpkDOEw5qVLUpj+4N1p+jhmNzNVGfgWjab4bUaPpdGz82WnLBLmSrNYoFV
Ndt1txishGBTNrxWzlFEbIS6xDnm0NLfISe/MMN/Z3U8C9Q4U+ED6/W+p0l2kG11
wWl1Ns4lDQm5A6XE/2O9T1Qu9g8xAQ==
=/uFd
-----END PGP SIGNATURE-----

--4tvY03OPMx2JSfeJS5Pc9LXRGeAIIovIO--
