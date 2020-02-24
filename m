Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBE5E169E08
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 06:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgBXFw0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 00:52:26 -0500
Received: from mout.gmx.net ([212.227.17.20]:56093 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbgBXFw0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 00:52:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582523526;
        bh=qe4TwE0RyZlZQ1lXeyWZA6j0sLoYmV6w8Anhyu9w3XE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XJ/Z/jJtY98HIXXF3slpZ7wVo4rm47l/18a68vIdE50U0zegT47foMH8UHc3TDxe0
         gWJnVXe+ioUfVUB3KB1Ko8XNl0JNrXTpVmso6jEOGEKk3RC+wyr7I/yqhTQQclnuW6
         zI3TzawmGCHs6VHD4jc/sPNuzVVTHzPxldToIQEA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mt757-1jPhym21O5-00tTzT; Mon, 24
 Feb 2020 06:52:06 +0100
Subject: Re: [PATCH] progs: tests: Avoid multidevice test on 32bit platforms
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200215232819.30280-1-marcos@mpdesouza.com>
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
Message-ID: <9115debc-12e5-4de0-d3ae-d71b103ebffa@gmx.com>
Date:   Mon, 24 Feb 2020 13:52:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200215232819.30280-1-marcos@mpdesouza.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ec0KjlosYMwKtHF5uO8hlrjwNJzd6yzil"
X-Provags-ID: V03:K1:hQgbAUT/S+Zb9U7hJ/4/7Nc90Om9bN/19caceH7rxLEvxv21vqd
 TSePuTRRYdXIyf+VTeCTaeGHr9FaAXDr6nlCSldTGtwbpx4ujYsTpAIvzl0u1Tqgi4SenYf
 05K7VNFV5cHEcVQnaGS+rx01yG/l8KRHh2XSpBkyYw7t39tbQwUbsiOxVe5s+4c6lDt4qa2
 jJKTFmVsVtVxbRZ2pC6XQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mttVP9byqgI=:5kILP246l/F7hHTXIpBVlR
 vLwnrLbTEXa1vwtTGLetzUBlwZJkZhWu7mpfueoBVyyNxIZSGYR42DD/bbbiyJJ4nI0z3enlD
 YThN4vT0Wgjdy16/9tt3lLF+F69f0Q8LAGL0rwgVaU8AiSgdZSfvmucDrb0ba+FGy1Vjb8Jj7
 Y52Zq6x4yJyMzzbd6NEVTSLwQM8OLIPmIplUIZ4hr6UgNuNiRoXM9o239g2qNccCkZRb3KHUj
 UNrBbt64TijsuaQLReuTLNuXVRK3BkgaEb3K3g6o4EKACiBe3Diqpkr4boJ9Wvs5J0ycmQDfz
 spiZgpDiPZgGcX1H6cdpHNhh0+mMenz1kizq953YA1DFt+hCp5OCtSS/wWpc3x6802z8lSDMx
 pZcgUak9sJ0b+xh2eRTw4wE0VxlCHbhU+5C15QNeDe9R5hSqb+V9US9/YyTKbrrUwiZM17lsB
 XruA8FXkOdCWxoeA3aljrIRZmSC5cyrcE+X0zfVgVDTcBZyFi4fsIrLPcqQRU+e8H0xfgwPWS
 M8J9KEabC4PRcBIaDae/mVI4uzCImLb0m3WYe8cFxePqvFkqjGmiejJLOVMeNUTNS2A7FQ7lX
 LnSTxT/TBNSHmjEr0nKyW7A78cWIjmkq8LxDF+zs2hP33Ji41bJ9Drxg7Uhqdzqffk4QkX1LA
 VTlb8uSaS+YWu7TfDkgJ+JcYwpzdgLmtRStBqF4l2s/zEUoCMjYptFmlMclewl0PhAbgFIP0m
 Zzz1hsJ6NXbCO42wY7XS0nl67Lu70bnqD+J6XFZg3efsM22h9FP8v10WQQSbjP3iKPTyLr4Hd
 HDkQG1qt6KEPcoPSR1yuA5iA+g16W2QQB3gg/VCfLUceJlHuaKeEoiRilzz84O/q7HsdANioj
 yCWSIWSzXn/CKESqaq8d0BBhjb+kDMOGfij9w1RZJaUnWG6DtWX79RKnO39EZrMf74Y78WJR1
 4X3lEb7N8LtJFpBtWMOyJJxPVnscZzHvveSrnQEg9fiV1u/3wpDinUBcx+IjpQHL3GQcsHr0s
 4E/IqckqvWx80Zmk9SdNxf9WBcRqqKXtEVaFksiver5bmyGCy5CHE6DKm0zAw/nqhjgc2qr0F
 pJluiXKR8dAeDqJG65uKc/RIXEYKsrZHhU+wMX5Bt9Rf0XEChfVF8A3XHxUk3RVnyUpK//EnW
 +wERBjyQVvefDrrfu+OcF5XEQ91vtQYVt/TUQ8N6A6hVAnTXCcmMvic7D6HqhwsFyZ4WvbtYY
 fNzpAet8/1Ii4OtGk
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ec0KjlosYMwKtHF5uO8hlrjwNJzd6yzil
Content-Type: multipart/mixed; boundary="CxoLSsfruAK1lPhCdayOzn2dsnm9XaEyj"

--CxoLSsfruAK1lPhCdayOzn2dsnm9XaEyj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/16 =E4=B8=8A=E5=8D=887:28, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>=20
> This test uses truncate utility to create a 6E file but this fails
> currently fails for PPC32[1], but it will also fail to other 32bit
> platforms, so skip this test in these platforms.
>=20
> [1]: https://github.com/kdave/btrfs-progs/issues/192
>=20
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>=20
>  I couldn't find a way to make truncate to use O_LARGEFILE option. I th=
ough even
>  to write a helper to open the file using this flag and later on call f=
truncate,
>  but isn't it one more helper to maintain?
>=20
>  If there are better ideas to avoid skipping this test, please let me k=
now!

What about testing the first 6E file allocation?

If the first failed, then it means the system can't handle, and we skip
the test.

Skipping the whole 32bit systems looks overkilled to me.

Thanks,
Qu

>=20
>  tests/common                                      | 15 +++++++++++++++=

>  tests/mkfs-tests/018-multidevice-overflow/test.sh |  1 +
>  2 files changed, 16 insertions(+)
>=20
> diff --git a/tests/common b/tests/common
> index 605cf72c..9aa69a1a 100644
> --- a/tests/common
> +++ b/tests/common
> @@ -580,6 +580,21 @@ check_min_kernel_version()
>  	return 0
>  }
> =20
> +check_32bit_machine()
> +{
> +	local msg
> +
> +	msg=3D"$1"
> +	if [ -z "$msg" ]; then
> +		msg=3D"Skipping test on 32bit machines"
> +	fi
> +
> +	long_bit=3D$(getconf LONG_BIT)
> +	if [ $long_bit -eq 32 ]; then
> +		_not_run "$msg"
> +	fi
> +}
> +
>  # how many files to create.
>  DATASET_SIZE=3D50
> =20
> diff --git a/tests/mkfs-tests/018-multidevice-overflow/test.sh b/tests/=
mkfs-tests/018-multidevice-overflow/test.sh
> index 6c2f4dba..8bb3d5a9 100755
> --- a/tests/mkfs-tests/018-multidevice-overflow/test.sh
> +++ b/tests/mkfs-tests/018-multidevice-overflow/test.sh
> @@ -5,6 +5,7 @@ source "$TEST_TOP/common"
> =20
>  check_prereq mkfs.btrfs
>  check_prereq btrfs
> +check_32bit_machine "32bit machines can't handle 6E file sizes"
> =20
>  setup_root_helper
>  prepare_test_dev
>=20


--CxoLSsfruAK1lPhCdayOzn2dsnm9XaEyj--

--Ec0KjlosYMwKtHF5uO8hlrjwNJzd6yzil
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5TZIEACgkQwj2R86El
/qjkxQgAjuxDwZ2npNLRWwC8RTJJpaXK51ESyC11QV97au3n35UC/fX3uvscR52s
SLhln5GwjHqIgGm5AVe32bGEkBfQCk85pwq7f2EQtdynN5mBtpqmjWP5dUm5H/jV
nsVzlh6X5oY/BGZZCaY7buTfKpRubYNLT64PGlhyf+HNmEiUVMueX/zZwWQpGB09
qMbndhJ/Ay0usZWtMcGHTHSItCsb2jxN5Mgnuj25qAZIFSVWtdN4V+1MgNsWC8yZ
eGiPchWtVyulNtHmJrvZkQ0lonxFQKTnbA4qOjeyGuyls5vRC7Ioozit93m9kltA
whrs029s7rW5aXFZQwrNwQqPRCKBaQ==
=wDAl
-----END PGP SIGNATURE-----

--Ec0KjlosYMwKtHF5uO8hlrjwNJzd6yzil--
