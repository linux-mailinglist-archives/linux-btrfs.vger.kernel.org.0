Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B65FB159E6D
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 01:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgBLA7A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 19:59:00 -0500
Received: from mout.gmx.net ([212.227.15.19]:34347 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbgBLA7A (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 19:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581469135;
        bh=CClZfbHmdvMeRnx8QCcJNgUr7eOnHjHsV+bbmYTlvuU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=hXGWyXaDbd/D1BWV3sa/NFVkuymBTe1Vnq25OQw3aXnsjr/8t98MzC547RWQRPki3
         z6KYQm0CHm0fhB+7syNaMSpk7K2KHQDm+JQDR60eHKNyHjg/kQVqNwMj4Gb0VZ/tf0
         IR0Ku+bpXVy9eYOfOctQdfelS+di0PV5Mu3cqcKw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mkpf3-1jmJWb2yid-00mIU2; Wed, 12
 Feb 2020 01:58:55 +0100
Subject: Re: [PATCH 3/4] btrfs: handle logged extent failure properly
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200211214042.4645-1-josef@toxicpanda.com>
 <20200211214042.4645-4-josef@toxicpanda.com>
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
Message-ID: <564c09e1-12e1-cb8e-6a25-8ad3f9ef68f0@gmx.com>
Date:   Wed, 12 Feb 2020 08:58:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200211214042.4645-4-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GlPfV21D7biv1fy4pl6cYn1zfaic0OPeX"
X-Provags-ID: V03:K1:1SBfkl0VLTO/U4KaCIZGsXSMQc6uH87VSk5SnIGE4cvWv/KlAnZ
 ltsxD98G89xgZB6z9Z29qXtcWiRLCrIBb0QOtCtXgT6GYOpvCfnCVtWZPdIkbwB90wi+yjN
 EpEUybul5t5+jHM+W8RPkKtxwTI/MicQ3v0VRPE9w0gGgpsg1VMJlVmVbxntxWXcxSQE20z
 quwhYE+m9itL1hWBKEU5A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+Ll9H7dC/xU=:WSRdlxOl3kCa66dYKHX4H6
 iJdQMBYdYV2dd5FGDGXXqFdNZFrADOH7WY2Y/IuMk4yZpbpnvj4unbnsvEnfFwqEFFlqp+8eI
 9v7N3s6A4x5416lNIx8DWV8gHZAvHnpRRqdsKHoba9BZZ1xP/3R/qJQTxs4f57Qu6gynxa04v
 DEXCyY5IEtb1DavCuiEBdP8SizIYaSfJ1cmb6OYxGv3oK9/+Ir/TfTV5e8gVCq+DOLbdE1A3V
 6oc4joOFW+1Fjmy/ej1edtmJTXMeDIXyQkFXOnK2sDklDMd+Ulx42eDhKnAJNw3TBn0SnjhRw
 1TCFAHe1gXBTk6XQ3LNQF+/1azSkDUk0bVJ9P+dQ1Y5AMUfjQkY+HaAYwMBveceMiYm0tcrVP
 ayb1LhB0FV232eejBEJ6s0INyGU/InaDJe/LkslALDWMzYig8HPFnO/0/S3JCyZDXSdB9laoN
 UoDpZch6sbO0hOsBK9zFKZSu6bLp0sFJs5CQbH+p7zCVUfspQdoo6oIyfYMj/w5i2+70st6HJ
 a/XuZz65iipkJdOQO4yoeSRBViprVJEAZahFu2MHJaPooDIHuhPzdyzdpOyWVBBAc/QkX+lS3
 6u/gYPK0mzPNQaic899uegTYhXjsQvePC9jVORp4YHfnb/CP9sTYJxYTot+FuD0IIbhLrT00a
 8Toi0IEg/IoaYTwQjqIalLTqZ/5aUeAvfOEa+lk9YDkFmk1Oevpe0qtkvaafAWmqL3w3VHGly
 828nyCSDO2afFs5l7nBRTfU9gXZdRzSh0jziRTjqBatsN5os4kAjnjl1A/tGrMGhHagPJLwh5
 9UghSyIf+kz6QIXrotoaCkLH3FBpCpuyzHpwhTd47B7A+sPdIWQaGdOEO3u7NhEmxJo2fsWg2
 k24vGJtFHrQ7iiqX95ntdCGIb8hWuTBXH1dL8meo0f/drJ53EUwrEpKDaGq4lqsqJjFlMhsAN
 hk7pin8qTlcqtiado2MnwGIwnTSqZclmw946zOSUa8McWC4aEN0C3zHOpy9KzPz/E7ij8uRxJ
 ZT9L0n45CQc3C1aIQ0iA3IU3OJrOjEKNbT9GV7zUoD2t/emuUN1dqsAjY/I4UffeC8ATkL8Gp
 OosJGMk5N7+PPI5jBpE8kx4b1kU3BA4IswoYVN7QYola+aOkZ8L465uw/lxnBLplmYn5yzhRs
 jwA8ixe0+5NeBliorDHxLTccauYOIsPCHETKGIiB9cTu03U4QQB9St3hcXu5rcqGjzi3lLQlv
 zReO96NNdQ/yrhsa8
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GlPfV21D7biv1fy4pl6cYn1zfaic0OPeX
Content-Type: multipart/mixed; boundary="3w4ePIzpMEuXjBYPSXnb258cp2kCjLqcr"

--3w4ePIzpMEuXjBYPSXnb258cp2kCjLqcr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/12 =E4=B8=8A=E5=8D=885:40, Josef Bacik wrote:
> If we're allocating a logged extent we attempt to insert an extent
> record for the file extent directly.  We increase
> space_info->bytes_reserved, because the extent entry addition will call=

> btrfs_update_block_group(), which will convert the ->bytes_reserved to
> ->bytes_used.  However if we fail at any point while inserting the
> extent entry we will bail and leave space on ->bytes_reserved, which
> will trigger a WARN_ON() on umount.  Fix this by pinning the space if w=
e
> fail to insert, which is what happens in every other failure case that
> involves adding the extent entry.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  fs/btrfs/extent-tree.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index c43acb329fa6..2b4c3ca5e651 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -4430,6 +4430,8 @@ int btrfs_alloc_logged_file_extent(struct btrfs_t=
rans_handle *trans,
> =20
>  	ret =3D alloc_reserved_file_extent(trans, 0, root_objectid, 0, owner,=

>  					 offset, ins, 1);
> +	if (ret)
> +		btrfs_pin_extent(fs_info, ins->objectid, ins->offset, 1);
>  	btrfs_put_block_group(block_group);
>  	return ret;
>  }
>=20


--3w4ePIzpMEuXjBYPSXnb258cp2kCjLqcr--

--GlPfV21D7biv1fy4pl6cYn1zfaic0OPeX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5DTcoACgkQwj2R86El
/qg89Qf9F2n0Rmh0S10i6eRt6hO7td1uar4df1a+I3fAf9vpvra9hugzKv6LC2Mt
rPOBuLdVQ8svNzMiH6AFv/sM5B5J2K9g5xCp2Z1Scw4A08zUehwvUyxw8fhOQJas
lygW9WGa5YuLM8uqsdsWGI7AhM+322NQFGbWlh6IZ+UqEZ0DYUaqVOu7oAeYEIH4
Rpijh6HGZ6cuwNcQiRuWHmXkNQOKvToILxFlKp8YVR83BFPTjMtSynjnYhgYBq8c
Bcy45TYIQypNYQuqEqT6cO8w0sPVuE818/GLsyhi39GEZwTXBT7VPSIK/NSjkVax
1cQUgn/+ntG4wLCoi40IP4nyckVmCA==
=iaGE
-----END PGP SIGNATURE-----

--GlPfV21D7biv1fy4pl6cYn1zfaic0OPeX--
