Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1B3117512E
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 01:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgCBAEM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Mar 2020 19:04:12 -0500
Received: from mout.gmx.net ([212.227.15.18]:55205 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbgCBAEM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 1 Mar 2020 19:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583107433;
        bh=6MtUgX+LEbikKxlPRsZLr3JZB6HDLS36pMyMF/4hoyE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QsRd+mbpuxclYWLAJuhB6n9TLf6kcb2vYXH7DSRP4DSBEby7XJ322eOL1jObeXmPl
         OjHPuw+78rYrhQL6uuWPyST3f7jUkPZuit54rdKZMcFqIcnOiKbdphWaB3HrBT/DlJ
         I4fiMxzHsreqhsAjYdB73+HwWR0K9iGdCciqgl7s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N17Ye-1jXOxn03OE-012X4s; Mon, 02
 Mar 2020 01:03:53 +0100
Subject: Re: [PATCH 3/3] progs: tests: misc: btrfs-{find-root,select-super}
 are internal commands
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
References: <20200301033344.808-1-marcos@mpdesouza.com>
 <20200301033344.808-4-marcos@mpdesouza.com>
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
Message-ID: <2f20c573-99e7-d1bd-337f-bf2ef613e051@gmx.com>
Date:   Mon, 2 Mar 2020 08:03:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200301033344.808-4-marcos@mpdesouza.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DymrNkrGT9zD5aGmZfmf0rySZl2wkuTrM"
X-Provags-ID: V03:K1:P26a333a9/h6fU7qDdqa0k2Hv/x43AJ8yZwNyz6bG4lffB4KOJK
 fpXCsI0MYavMTcKTboykGRgwi41NBdCVNQ7UCVsZ+VKwLjvZl+6ZW0lvAwko7JHO89MiLrU
 GTraoMY3RbM17CbmuHsHIRQtP3W2fndrpbEccKCtlqAyWKXoaugUTSvaqmgT2LJ0vnB4ZJ9
 5k4pMq5wjrVSyNSzQPOtA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IsmYeg97uEY=:KTYXX/Uk2PMHrVybVilf+3
 Lq9LJZb385s/HI4HD84DE/GMwZu803B446DsttHFwsleV0iksmtx+esWS6xAKsb0orXqXwCM4
 B1/Qsp20qtv/vUwxNKscVHdsbN4JFYYPofSCsQ3j281veuZdVnIaQoWLJQR29ln7OkKoKmEYW
 hgECFJ7zVrpzePKqnK2eeYZBqp7uAXDmsQCuFfUYDj80JegAsrtoRWrH/WIGQCU610AQd6yb2
 tGNWsqRIald4tGPj+KBfJZHSa9uDFUjrs6Rcii5nYtLJFMPeQuyWeYEaPWV1CYsgemKvOwoxv
 iRiDCELWXy+KoPr9BgbtriIh+MahqW8O7NvJrYyz7rZvlgruzX5LycsXLAgkG610VD/bg/W3w
 YrSZNgKgt1jhdp+AZ0wHGAurrZ6KCiGbripOdoG2NoCB21c/AAYxYmJECxLRJpGnVmZwheNvL
 1HWkiBGUJFkyqg4LIvPciLyY7ZzQfLKM1ZaYWVr2oFJALIPGdaaOt3OXnk/vSsfmbsawVYGJL
 hZDzu7g2q4MSYC3wirCGDLRm8yhSBLqMn4JXQsuFI7dYOyHsOepFxKSQxt/QpEGPhvq4SkXK9
 gEOp8DWucZWQYaS/bTzw0/KlGeXXj2jr0EOuBW3beU+ttdybEAkbkLEAXEMmmHHAsIpTDdD8H
 7OtQr5hFQ1FCjrjeoFoFoxKVmhU0Vqz3qij90oW1KmQHa/+l3nf9qPjYjiIDnbCNZtSgweJWd
 CunGqE263rRrizAcEswObqBMSPgO/AATCX7nwWPfyv71Tu/lKkqg9KyORr5XOHdkNizj+XMpn
 EMbaOSOVMYqtUBQw2l8RI8TqhuGXtgusGmaWfLVQRdBA1q4lVa/45DCN+hBcn2KADdtwn5xPO
 i7BjdCg1z606R0ZuwYb7ALEO5gUdceblAwS+kCrtyfUAkYrqMwxJpI6zGLRnXjCGTBnrbpOvb
 rqDJCrl3bF2WSeouciq0MdTtIZiIxY/ck1BHNkolov3Cax2l72yZKYJUSh6NwmFtgxan1TM6X
 a/sbxqen887uXAA8NnmO05ncXzwzeygx85F3MxR2SwguGKRLaq4XccCr4S9x6kRz1Ql+lVpRK
 D4gR+Uv5L4IjCPrK/8Jr7T/Lx3Qiy4ilVwesywwSi1Jl4zQ+eqBMVX5QeU7R94XkKsPvA3uh8
 8nCFJFeCsPay/GLM2cuSoOam1SuBPPmYENMYDmJ4nkc7YQXptZ9MeKmI+xnL9gATVa1oTu+9I
 hyJmVyKJ7rTb6o0t+
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DymrNkrGT9zD5aGmZfmf0rySZl2wkuTrM
Content-Type: multipart/mixed; boundary="rP9GSb7UaNBIlJtwHNMtruRbMBnB4yb1t"

--rP9GSb7UaNBIlJtwHNMtruRbMBnB4yb1t
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/1 =E4=B8=8A=E5=8D=8811:33, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>=20
> With this commit, testsuite works as expected.
>=20
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  tests/common                                        | 13 +++++++++----=

>  tests/misc-tests/012-find-root-no-result/test.sh    |  2 +-
>  .../020-fix-superblock-corruption/test.sh           |  2 +-
>  3 files changed, 11 insertions(+), 6 deletions(-)
>=20
> diff --git a/tests/common b/tests/common
> index 605cf72c..26190d85 100644
> --- a/tests/common
> +++ b/tests/common
> @@ -305,13 +305,18 @@ run_mustfail_stdout()
> =20
>  check_prereq()
>  {
> -	if [ "$1" =3D "btrfs-corrupt-block" -o "$1" =3D "fssum" ]; then
> +	case "$1" in
> +	btrfs-corrupt-block|btrfs-find-root|btrfs-select-super|fssum)
>  		if ! [ -f "$INTERNAL_BIN/$1" ]; then
>  			_fail "Failed prerequisites: $INTERNAL_BIN/$1";
>  		fi
> -	elif ! [ -f "$TOP/$1" ]; then
> -		_fail "Failed prerequisites: $TOP/$1";
> -	fi
> +		;;
> +	*)
> +		if ! [ -f "$TOP/$1" ]; then
> +			_fail "Failed prerequisites: $TOP/$1";
> +		fi
> +		;;
> +	esac
>  }
> =20
>  check_global_prereq()
> diff --git a/tests/misc-tests/012-find-root-no-result/test.sh b/tests/m=
isc-tests/012-find-root-no-result/test.sh
> index 6dd447f3..edfdfd38 100755
> --- a/tests/misc-tests/012-find-root-no-result/test.sh
> +++ b/tests/misc-tests/012-find-root-no-result/test.sh
> @@ -11,7 +11,7 @@ check_prereq btrfs-image
>  run_check "$TOP/btrfs-image" -r first_meta_chunk.btrfs-image test.img =
|| \
>  	_fail "failed to extract first_meta_chunk.btrfs-image"
> =20
> -result=3D$(run_check_stdout "$TOP/btrfs-find-root" test.img | sed '/^S=
uperblock/d')
> +result=3D$(run_check_stdout "$INTERNAL_BIN/btrfs-find-root" test.img |=
 sed '/^Superblock/d')
> =20
>  if [ -z "$result" ]; then
>  	_fail "btrfs-find-root failed to find tree root"
> diff --git a/tests/misc-tests/020-fix-superblock-corruption/test.sh b/t=
ests/misc-tests/020-fix-superblock-corruption/test.sh
> index 404d416b..d67a87c3 100755
> --- a/tests/misc-tests/020-fix-superblock-corruption/test.sh
> +++ b/tests/misc-tests/020-fix-superblock-corruption/test.sh
> @@ -25,7 +25,7 @@ test_superblock_restore()
>  		_fail "btrfs check should detect corruption"
> =20
>  	# Copy backup superblock to primary
> -	run_check "$TOP/btrfs-select-super" -s 1 "$TEST_DEV"
> +	run_check "$INTERNAL_BIN/btrfs-select-super" -s 1 "$TEST_DEV"
> =20
>  	# Perform btrfs check
>  	run_check "$TOP/btrfs" check "$TEST_DEV"
>=20


--rP9GSb7UaNBIlJtwHNMtruRbMBnB4yb1t--

--DymrNkrGT9zD5aGmZfmf0rySZl2wkuTrM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5cTWQACgkQwj2R86El
/qjM7wgAkymLuhJBIiiAzn8O9XFHu8o42TefXUk2ENGy0breTxso+HURaqGJ7cYf
Jo3hOQzuKjDaYZb9tOd8gpDSAbWByrh4NTrcA4zCX49aJrn7SRSjr1fjiJmPkvKo
r6brHTrl4yP2fdNh5UDwzkOoNj4FhW8YNIYYJ+EBW3Gyb2oucaoiibx+d9Yka9wR
a8EVPmUtkHWuNxFdAfEE6hhwpgMKvyllc9v7FlPRXIvAuiwSIkWo+LbMHT8b2Rh5
bKLaY6dkT0r/Zy31W7+cL8lusO5fSNAUDqM4+hIFUM8iDDG5J/NWvj6Rl8RVKfcO
Dnvmm2sHfQ2r6CmWBo4u+wsm6YXH9A==
=R724
-----END PGP SIGNATURE-----

--DymrNkrGT9zD5aGmZfmf0rySZl2wkuTrM--
