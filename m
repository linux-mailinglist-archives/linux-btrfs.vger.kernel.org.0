Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 607BD123B97
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 01:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfLRAa1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 19:30:27 -0500
Received: from mout.gmx.net ([212.227.17.21]:32981 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbfLRAa1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 19:30:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576629018;
        bh=X/qSE1lzUf+ZZvGCUsZFhArgKvys0PY4PyLhB8V7ZNE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=a/P3v0w/8t+vNZhbFKBlGSeSR6gtUIloKZx0zMIk7xSRvbmgZy/5yQWFYn7UXUIkT
         h2gIu9zikIlMDFrvgsjuU9F5JhpXHKVekq9kS7q+acDDsv7xFksnYGsIVho39VtF83
         Bm1OsgEjIxCRQCNQlK3T1q5+EfcTNxXqesXUV0Zk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8QWG-1icxNS0LFQ-004XCI; Wed, 18
 Dec 2019 01:30:18 +0100
Subject: Re: [btrfs-progs PATCH 4/4] tests: Do not fail is dmsetup is missing
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com
References: <20191217203155.24206-1-marcos.souza.org@gmail.com>
 <20191217203155.24206-5-marcos.souza.org@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <ae5f2516-78e5-022f-f516-6351b75a362c@gmx.com>
Date:   Wed, 18 Dec 2019 08:30:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191217203155.24206-5-marcos.souza.org@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hO7adD5JIlr5uUGt4wtAqlD2X0gVSIPa8"
X-Provags-ID: V03:K1:atspB/WUdX39LC5vqfkfcD0oFrDjjA5jf+oxQMmvjZy5L0qRggv
 Ew3wiArBxdwEFXk6fBhOJKz2GCjz9of2j+No5qmd2r56Sl/pF3WaOu/ysQ2Out3qRfaJR1O
 3VXPWnvxWsyYvmzAt2E4/mFAVH5YkrxZWk/dFnafvazNrtC3jVnqdIuKPdhqXkU6OhVYHKV
 jF1i3uFbgNZH6swZSgykw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EcK4H5Ky6zg=:xuunrIhJ9rp6xaVJoxZ5ED
 gmL1V4CxScFK/aFBKFrNTqxBnbcPoQegBydyEsQj4UvAXraY2ujGRxMqjB4nRaBG8aoPkm3Kj
 4WdD63e5Wo29hy8XQ51RB5CnQmfTyl/ueXOzteeHY1sH2HEI6VQLwffcCJgCDhBWe1b40TAU4
 7GkmplO1gW1kfpWgVq3r6SnogX6xMM7XZ8Jq2AvfJ5xjobbv+dQ8I1by3kWGwj1hmGBCJpmyP
 l4gTEUM6vUFJinlKgq7FqUDIgZ/SPWd5oiTQ7RZuhVkBxOY3CMtXdLul+Iy7PNF44rfl/NUF1
 PoyAzTTaoSXGn8g32TQUfMlYeZy6OtmQ7f5+Hwme9rEN3RUKdonWwsuVA3XyvGjQ3d30y7car
 behzXV1DawB+LN64eSLyezemEwLlLAGKzuca/8304E36GZUdSrl2nXBqIZMc0I2LT2U6J5d25
 0aMS71mEEqYmGIVrR+5k52v3NroSNNf55Nwz/qtE2ty4iqW5oFTkoVYjB7r+T9rHAhalJusjN
 yh56bt7T79Uvuc+4Pi36ffavhmbIlDJMtgBC9GXv6tLBGvrjk3jswV3NUbkjmvMNCca5HfmR+
 zvw/72POpMkGxMjPH9IGtPdnFlI19TUVZt2uVGDgUey3qFEuNMNGqycwbs6jerXrjWI7OLbRu
 nkljPmkf9gfjvgdVtuYMomMH/JErOtLc0JiEniEJYK2QKM/vfiUEpjGJrV/PQBkCu3RqEFBDW
 lm6GAfbqxcRCd/fKkJWET2FrPF8ciA9b9llWZhS71BtBG+BAN/LkQctEHYO3WWdpQIVVmYc5a
 3Q9GC5b47ap9P6fmmSb+0/d24CqjYpjHMmXLWClAMMFTNaPDw9fuFMng/FQOiJ+luPddjfJRB
 qsc6odkMKPIiTLb6URGoFr3ZmaIoqIf9kg5tOsGAacKKMe8roN1nKDDtwYwvvmpTIgKvQFVBj
 a3Inyg2BjLXjtY+wvAuIa9HgLo0iXYVy5s/KP2ONiYQZ/YMG5YleO8BNI5HIp29a3M4W/lfNh
 87kC9laq1L/z3lBu4fzWp2TZwO3lLvDiuISkviGtiJw9gTcitBMXiOPttJvwQjonOehxoChqQ
 NxNEcWJJKr4nxAIXeevLnDKDRPKvAvBNXgY9mFS3FPj6rOJ2kEE2JkCBCLPhEqzaZ9Gaba0xs
 STDgvEARcNqObRZUg0OTgpkM0C+JGNCjRRIxsAhVWOPRoso6kPmp4GpV9KowPEb+5ZZqnn+8S
 sVtWgabmt1I1lxu0XZV8wPvO+dOK1oLzvE1waZoNRPT/UDXHxUbwlYhNC8uI=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hO7adD5JIlr5uUGt4wtAqlD2X0gVSIPa8
Content-Type: multipart/mixed; boundary="1Xd765EZCVFZJG08joTYAEj9iFLJKzlUA"

--1Xd765EZCVFZJG08joTYAEj9iFLJKzlUA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/18 =E4=B8=8A=E5=8D=884:31, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>=20
> Move the check of dmsetup to check_dm_target_support, and adapt the onl=
y
> two places checking if dmsetup is present in the system. Now we skip th=
e
> test if dmsetup isn't available, instead of marking the test as failed.=

>=20
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Looks good overall, just a small nitpick inlined below.

> ---
>  tests/common                                             | 9 +++++++--=

>  tests/mkfs-tests/005-long-device-name-for-ssd/test.sh    | 1 -
>  .../017-small-backing-size-thin-provision-device/test.sh | 1 -
>  3 files changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/tests/common b/tests/common
> index f138b17e..dc2d084e 100644
> --- a/tests/common
> +++ b/tests/common
> @@ -322,10 +322,15 @@ check_global_prereq()
>  	fi
>  }
> =20
> -# check if the targets passed as arguments are available, and if not j=
ust skip
> -# the test
> +# check if dmsetup and targets passed as arguments are available, and =
skip the
> +# test if they aren't.
>  check_dm_target_support()
>  {
> +	which dmsetup &> /dev/null
> +	if [ $? -ne 0 ]; then
> +		_not_run "This test requires dmsetup tool.";
> +	fi

What about using existing check_global_prereq()?

Despite that,

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> +
>  	for target in "$@"; do
>  		$SUDO_HELPER modprobe dm-$target >/dev/null 2>&1
>  		$SUDO_HELPER dmsetup targets 2>&1 | grep -q ^$target
> diff --git a/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh b/te=
sts/mkfs-tests/005-long-device-name-for-ssd/test.sh
> index 329deaf2..2df88db4 100755
> --- a/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh
> +++ b/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh
> @@ -4,7 +4,6 @@
>  source "$TEST_TOP/common"
> =20
>  check_prereq mkfs.btrfs
> -check_global_prereq dmsetup
>  check_dm_target_support linear
> =20
>  setup_root_helper
> diff --git a/tests/mkfs-tests/017-small-backing-size-thin-provision-dev=
ice/test.sh b/tests/mkfs-tests/017-small-backing-size-thin-provision-devi=
ce/test.sh
> index 91851945..83f34ecc 100755
> --- a/tests/mkfs-tests/017-small-backing-size-thin-provision-device/tes=
t.sh
> +++ b/tests/mkfs-tests/017-small-backing-size-thin-provision-device/tes=
t.sh
> @@ -6,7 +6,6 @@ source "$TEST_TOP/common"
> =20
>  check_prereq mkfs.btrfs
>  check_global_prereq udevadm
> -check_global_prereq dmsetup
>  check_dm_target_support linear thin
> =20
>  setup_root_helper
>=20


--1Xd765EZCVFZJG08joTYAEj9iFLJKzlUA--

--hO7adD5JIlr5uUGt4wtAqlD2X0gVSIPa8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl35cxUXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qj8iAf+NLsi0R3lwLfcitsYbrUpYRGc
RLkLGD/3kt9jJ+6Ig3P3Ts/n0/qH9K22NkeopQGV0yY7z5cMGbonKxJOuPP3+HND
pIEuClA+l3XPJ4RGeoqzPgOpuFdwWS5AWFElu5Bj4X/TmkhRtGP14vZ1rzAYkoJ+
uDUv080eQlBqDnCbjDvtgboPwuP/QvaPZrirgZfhV9lfTCm0ls1TgQc3Hc/qmG8H
CQ9V8zg06s8Wxl9espvqPRikd5SOD70UnbNexvLqv1zBNMvtH+GcP5v1WDB2SCub
6qVGLk+c8xn/vK87gGepDA+vd3gaxmQ5hnbCqQ0I37Oun8jmrwdCrRi6KDn+mQ==
=NJqU
-----END PGP SIGNATURE-----

--hO7adD5JIlr5uUGt4wtAqlD2X0gVSIPa8--
