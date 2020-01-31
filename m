Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D399014E803
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 05:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgAaEtd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 23:49:33 -0500
Received: from mout.gmx.net ([212.227.15.18]:51913 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727933AbgAaEtd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 23:49:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580446167;
        bh=zD8Zmh3cN4IT/LSFuJ4Qugco+r75Qq7zptEZlxLjDF8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QJyG2XAHmgvaowNn/msqesAlhZkPjCw8XnZN0bREAL68LCFjPFWiEsCd4bUYvv/hf
         u1EeHeT/tbYNVwmI6GF1IvnNxYiYlechcBlrtJHo+4vZNJwlpdLBqpgC7mcn2ryANm
         VykMGHXXN3wkf8gFgNNU8sPlO70u3BOp6O1Oytfg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYeQr-1j0z000JsJ-00Vkdf; Fri, 31
 Jan 2020 05:49:27 +0100
Subject: Re: [PATCH] btrfs: test unaligned punch hole at ENOSPC
To:     Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20200131043916.3170-1-anand.jain@oracle.com>
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
Message-ID: <526051b1-4a48-fd40-c8dc-af7e1b399111@gmx.com>
Date:   Fri, 31 Jan 2020 12:49:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200131043916.3170-1-anand.jain@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Tjr7I1XiBDTBwKapixMMlfo1H96mgvWzf"
X-Provags-ID: V03:K1:7hAEOWCSGCb/DeDpuEn50Zsi/1RllrxnXA32adZ0ebOsimced+9
 Y3WqfK00VyclPVJuviHM3UK9zrr/MUDujbRLWR9OBhOffYtCmC8cJXrxacNqv/mNVEWG8fs
 0UqUqaE4dMBhbu+Wra2VYrhHhbOAodXSat1k0Rnpz8IBshmr5fvh8AZFuTeTJCIfJm8Dcuu
 7Ys17tX7UL4deuyHl5z6g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:h491P9YfCGI=:h7wiE5yTd+LaLxlAorJmwo
 YvJzcNYLYmeoaCgLvxN9+LvUTrWKA5tk9U3aQsrS4KWBbAE9q4Gz5wGV12Da/r8NAI/ZmUf+f
 6Gp596Q9BNyp8DTt/rMlsPCkrC28D3i9LpNW5yjv1n/zjj2oXu4xymqbCz0ey7LFOXfI7Ficb
 dJxQW8xOSA/4rbqvOo0IUIeImy0piOoorMHJoV7W9Gp40mtoBYwMo7PEqrq1oxh1s7AX/3DJW
 Ehtrslt6ZvAA/1hGC/oC9XJZ7eRB2Uc83NFKTgmMaRMndGR/Sx2PP0ARdF1KVkEG6bdN12Pij
 QBbO15Iqzsx4QtZplPsyq2/dCa/avm0Eu3K5v7lOEKetNX7Uw905nsgR2ecugSPkT341abS9+
 DoShISZjOVojz32/U00tHvzUgvYhKfFeeR+2BxovNVS1DosaG8Eq7M48bWSRXqkQ7hSRPRSs/
 nPsmODcMcs7LD1EPsHhQOjMFSdyHWw8X0CkixlxXLsi52hJqzVqx2tiu189JKpiRL+6vYyao/
 CMuuxdjCPEQtgrBwc7OO9gNUS2ljkZyqtzzp4q/jL5wYBb8Ip+tB3Z+Ofx5weF6Et4gtWACSM
 68mjO3uoa+8QnZQsinCi4uycXt06/5XinNNpOk52wRgvRSWboz0CE/3cSVXzAcEwloYgB/3UP
 VRFd8ppud7fQm4Ifb0EaSSEmFgm/aoUHvyAnOwxlLAvW/FE0IRJWAw5wgv4ddUq2fPkANd+4b
 4Ievrq07q5vS9SHXAA7XW5nIOfX/JN2M2boWTlHULN/yclj91qavzdGGcOmLsRBSw+MS2ezUD
 G2XxpDV3ZQpqAhlzAIxoAwodW8G3OObGRwF0NwrUcJxWGdIIAITEZymt0jTPiNHwMOOpMtFDm
 jO5pg+OZmT7xDED2QhFDNUnlFkxdmNumpX7cckdsPCRZTc1N+b4vlSvuRdCE3xvqWNcv3cWz1
 Gq9JC2oNM8Nv0D4szsok0DmG7fAl4z0oimdhw4hlOgmCWjR8iT2oGEVjYT9Y+UrrI/Z8erlSe
 JJVWIonTa8swjqKez5WHHD1tHKJag2tB34Gj8z3lQl6f7ekcQij/5Vx0lGY4VguWWeyeW+pSP
 Pr6hU3LXPNGAZh1IgfVQRyn9lIrt/fLRyjaXL+zi0A7jhYdr1g45U0av26QoURECA66xr4Fw6
 iE0TPBvIiq0D7jLzUl5e2CnEFLMU77hD5hRuizahJgnlkAFeD6+7xkl31v7JILgqlptPHW3QX
 Ep99KGdesBnk3ysPU
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Tjr7I1XiBDTBwKapixMMlfo1H96mgvWzf
Content-Type: multipart/mixed; boundary="ufBJpaoohXXcOxI4s6t3xnnsbgrdCqogQ"

--ufBJpaoohXXcOxI4s6t3xnnsbgrdCqogQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/31 =E4=B8=8B=E5=8D=8812:39, Anand Jain wrote:
> Try to punch hole with unaligned size and offset when the FS is
> full. Mainly holes are punched at locations which are unaligned
> with the file extent boundaries when the FS is full by data.
> As the punching holes at unaligned location will involve
> truncating blocks instead of just dropping the extents, it shall
> involve reserving data and metadata space for delalloc and so data
> alloc fails as the FS is full.

It's better to mention the nocow part.
For COW part, the ENOSPC is still expected.

As that's the main reason I failed to understand the use case.

Thanks,
Qu
>=20
> btrfs_punch_hole()
>  btrfs_truncate_block()
>    btrfs_check_data_free_space() <-- ENOSPC
>=20
> We don't fail punch hole if the holes are aligned with the file
> extent boundaries as it shall involve just dropping the related
> extents, without truncating data extent blocks.
>=20
> Link: https://patchwork.kernel.org/patch/11357415/
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Eryu Guan <guaneryu@gmail.com>
> (cherry picked from commit 4c2c678cd56a81a210cb16f9f9347073e91e2fb0)
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>=20
> Conflicts:
> 	tests/btrfs/group
> ---
> Its decided to bring back this test case, now the problem is better und=
erstood
> and the fix is available in the ML as in [Link].
>=20
>  tests/btrfs/172     | 73 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/btrfs/172.out |  2 ++
>  tests/btrfs/group   |  1 +
>  3 files changed, 76 insertions(+)
>  create mode 100755 tests/btrfs/172
>  create mode 100644 tests/btrfs/172.out
>=20
> diff --git a/tests/btrfs/172 b/tests/btrfs/172
> new file mode 100755
> index 000000000000..0dffb2dff40b
> --- /dev/null
> +++ b/tests/btrfs/172
> @@ -0,0 +1,73 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2018 Oracle. All Rights Reserved.
> +#
> +# FS QA Test 172
> +#
> +# Test if the unaligned (by size and offset) punch hole is successful =
when FS
> +# is at ENOSPC.
> +#
> +seq=3D`basename $0`
> +seqres=3D$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=3D`pwd`
> +tmp=3D/tmp/$$
> +status=3D1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_scratch
> +_require_xfs_io_command "fpunch"
> +
> +_scratch_mkfs_sized $((256 * 1024 *1024)) >> $seqres.full
> +
> +# max_inline ensures data is not inlined within metadata extents
> +_scratch_mount "-o max_inline=3D0,nodatacow"
> +
> +cat /proc/self/mounts | grep $SCRATCH_DEV >> $seqres.full
> +$BTRFS_UTIL_PROG filesystem df $SCRATCH_MNT >> $seqres.full
> +
> +extent_size=3D$(_scratch_btrfs_sectorsize)
> +unalign_by=3D512
> +echo extent_size=3D$extent_size unalign_by=3D$unalign_by >> $seqres.fu=
ll
> +
> +$XFS_IO_PROG -f -c "pwrite -S 0xab 0 $((extent_size * 10))" \
> +					$SCRATCH_MNT/testfile >> $seqres.full
> +
> +echo "Fill all space available for data and all unallocated space." >>=
 $seqres.full
> +dd status=3Dnone if=3D/dev/zero of=3D$SCRATCH_MNT/filler bs=3D512 >> $=
seqres.full 2>&1
> +
> +hole_offset=3D0
> +hole_len=3D$unalign_by
> +$XFS_IO_PROG -c "fpunch $hole_offset $hole_len" $SCRATCH_MNT/testfile
> +
> +hole_offset=3D$(($extent_size + $unalign_by))
> +hole_len=3D$(($extent_size - $unalign_by))
> +$XFS_IO_PROG -c "fpunch $hole_offset $hole_len" $SCRATCH_MNT/testfile
> +
> +hole_offset=3D$(($extent_size * 2 + $unalign_by))
> +hole_len=3D$(($extent_size * 5))
> +$XFS_IO_PROG -c "fpunch $hole_offset $hole_len" $SCRATCH_MNT/testfile
> +
> +# success, all done
> +echo "Silence is golden"
> +status=3D0
> +exit
> diff --git a/tests/btrfs/172.out b/tests/btrfs/172.out
> new file mode 100644
> index 000000000000..ce2de3f0d107
> --- /dev/null
> +++ b/tests/btrfs/172.out
> @@ -0,0 +1,2 @@
> +QA output created by 172
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 4b64bf8b6d2f..697b6a38ea00 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -174,6 +174,7 @@
>  169 auto quick send
>  170 auto quick snapshot
>  171 auto quick qgroup
> +172 auto quick punch
>  173 auto quick swap
>  174 auto quick swap
>  175 auto quick swap volume
>=20


--ufBJpaoohXXcOxI4s6t3xnnsbgrdCqogQ--

--Tjr7I1XiBDTBwKapixMMlfo1H96mgvWzf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4zsdMACgkQwj2R86El
/qgdqAf+N3Qg/lMiDmOV+jtYiUsK7YpML+NsS0kk3CadY/MJQ51XXC0Py/mMXgZu
f7JuWh7KdzCClOFAUPFPrbtKAE0zpZdZvoTZuSnCjfBSi5pHx5FOJqUwBZRRrN9+
UQq0wX1qZQQa6kc0ay0w8ldEQuQLQkVEZGJVDbrnXGnzQy6j0z39WhHTW7jRFQHc
EtMLBAfVWVnuTUckP3nqgoXLgEH9+LxLiZlc7UZZPLMqiHyJ8fC8W09aZR+YYj0E
o8LxkwxJ3MN7V4VSEH7q+Z7Ebixs07lm49f2wMiiDdanjJZPmlzq7m1G0e7DvBej
xOdOrj3AbAQqziBhrT2HVza2w93+FQ==
=Ayva
-----END PGP SIGNATURE-----

--Tjr7I1XiBDTBwKapixMMlfo1H96mgvWzf--
