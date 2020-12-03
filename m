Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBD12CCE1B
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 05:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgLCExD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 23:53:03 -0500
Received: from mout.gmx.net ([212.227.15.19]:54637 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgLCExD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 23:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606971087;
        bh=VAwwyGlV7ewYWLyfbVEtcI2LojYBqb4aKKehw7R+2eQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=QOkNSeJvWAdVH0A/voXXknpK1gxCNxJiwrYyaHBDaTdeZBFfXRrftQgyOdTKpWDZf
         PDkyNmVML54JekhCAiw7NuFsH18a3ghFGrU+i0ECS3g9rfcJd34ZZYnM92fR2boyNC
         SHSojL/tbSbwR6Rhv4h9b5UiWMpkpL+1b5tY8P5c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MowGa-1kOF4y42ec-00qPW2; Thu, 03
 Dec 2020 05:51:27 +0100
Subject: Re: [PATCH v3 31/54] btrfs: handle btrfs_update_reloc_root failure in
 commit_fs_roots
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <55ff15d8ef98e0eab03044fc75e44d6cb2bc64b5.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <ad08f43a-d52c-a674-0b43-3cbe39ab2e47@gmx.com>
Date:   Thu, 3 Dec 2020 12:51:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <55ff15d8ef98e0eab03044fc75e44d6cb2bc64b5.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zgO9aZpIFLzOH8n3znGtnahLIGIb6Wsj4"
X-Provags-ID: V03:K1:VJgYgyY174D4Qsj42peYXrXtAna0dztFirbnB5LwlNqAP2V1gVe
 Fl9akdEWi7SshefWfgDmzVS/THrReahuXePVxrMpON3js5CVVoMduLTVY9oPN9b28vJOzy1
 RMIAur9ejVFZxnZvEO2/eDeco/tIsSbEij/0FW2ZCvBPlS2OPSl843EFJVaNvUMKpXhb9VL
 8IRvrHtfS54S526DTlytA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qDBfL2GP5Gw=:Rfbn08Vxe72UwzTif33PC2
 Malqx90DUi8Ekes6RJXtF7LPKa9WMv0GQ2uHOPkmAKbAmMK94VoiLxMTA2yMja8UStOSU9WOQ
 AYRwZb1IfSVeO1x77tHwcznxaaJNMYH07Zqui1Xu3fgLPoswvEawQscq4TqNkzfOHGUDZBxP3
 QDjAa6AY5MO8W6KmIg4Vh7r2h5g8HZFoE6S6HQ0K9m3QgvlEaGXqjd66ndAn+WPy+BOpK7A8x
 ZoSQKVJjUBSB0vIi812bunKa2ML32zJmBKMCcW47ZsoAEA2VZ2cSVmQc517sk0BtQJuHKqe1N
 6Dc4dSvDyioXyBxyMudx8LZnbrzUuxfrvTv7enUX2o2/8oEslaXixz2S8A0a/DCb9Gi3uLfC0
 oUBrCuJL2rd6iSsOCO/0avzTvVUia/vg7exzEPsiMUiRjBR/IckxXE8QTtrixmPmGS+dM+4ao
 vBv/k8V7y1TezAUpR0+x3X8lTogOi08VEkXViQfSfcn/vNKR+O+zXS+cb8/IZ+jhBALPM6jXs
 ZK1RT2yR1iYRFs0apH4adVD4GernzyywmJXMUqBM/uLmmLmMbGxFZdA13RGFWtda4d3Klvlvh
 OAelUth4QHk3YnNM7BDc86Y7xp8kTEWshHzaylS5WZK1j1lR5KTYRDgS/CRKAFPIHikP9qmwa
 BGXhAMBrM9gkuU1X0ObB5gxntlck+I7IfQ+F/qA+dUQP4Tj6pGlP4ok4DaVXONjiG7nfA585D
 Sb24rxiC9gv75fhkJdaNYMBIMISL7m7RnUsoo9DDfLgP3KbEmHlmGkLV7O7T6851yn5MaQWP7
 VmPTlBp00VDgqx6EZKMFMy5FHC5Akn9C2THgIs93uVznMuihH7I+ClRLT+JdPiQneDzot0sN3
 GKKSu1ixNpyZ2+0FYU5Q==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zgO9aZpIFLzOH8n3znGtnahLIGIb6Wsj4
Content-Type: multipart/mixed; boundary="ofrDXWgVXYg1VSciPPNfhFIVQ8ZWrnonz"

--ofrDXWgVXYg1VSciPPNfhFIVQ8ZWrnonz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:50, Josef Bacik wrote:
> btrfs_update_reloc_root will will return errors in the future, so handl=
e
> the error properly in commit_fs_roots.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

The patch itself is OK.

Reviewed-by: Qu Wenruo <wqu@suse.com>

But it would really help more if all the btrfs_update_reloc_root() error
handling patch can be merged into one.

Thanks,
Qu
> ---
>  fs/btrfs/transaction.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 5393c0c4926c..5064beff3f9f 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1344,7 +1344,9 @@ static noinline int commit_fs_roots(struct btrfs_=
trans_handle *trans)
>  			spin_unlock(&fs_info->fs_roots_radix_lock);
> =20
>  			btrfs_free_log(trans, root);
> -			btrfs_update_reloc_root(trans, root);
> +			err =3D btrfs_update_reloc_root(trans, root);
> +			if (err)
> +				return err;
> =20
>  			/* see comments in should_cow_block() */
>  			clear_bit(BTRFS_ROOT_FORCE_COW, &root->state);
>=20


--ofrDXWgVXYg1VSciPPNfhFIVQ8ZWrnonz--

--zgO9aZpIFLzOH8n3znGtnahLIGIb6Wsj4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/IbsoACgkQwj2R86El
/qjI+wf/Y9x5953a2T5iHIaIrb4UReaiLzArSQvKkXE/FHEgDD98ERpJXubVFYyw
H/fknOgODVia7qFmhUajOd/qumQ8NWhzH59JgqZmCPozqTsxPHuIBtvWpCRlLtbK
/d2Fe5AuBVEQtRiIYcz3KlL4V3ai7eKs7tbk2D6e8pWphyKmNpbKHMpsn6NI66L1
7AqM3DiyRlT6dAEGqRwdS78jUPW+8H2CJ+wGSWYB4Rygq5j5eWs+QOk9J1Gphfgn
OR3NHiHqGEx8cXceJehyAEoFrRCjzoBmDXG1JP6Ps1zwvT3iBnfnL2hzCGcGKq4P
gYpf4akgA21abc3yyLrZ3ZP5pJpG7w==
=qyOb
-----END PGP SIGNATURE-----

--zgO9aZpIFLzOH8n3znGtnahLIGIb6Wsj4--
