Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D575F14E6F9
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 03:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbgAaCP4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 21:15:56 -0500
Received: from mout.gmx.net ([212.227.15.19]:57169 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbgAaCP4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 21:15:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580436948;
        bh=OzIC6jPqvhJF99RvJCRYH3x5+ly9wA67vIXGtY3I6O4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Vfott+G+8GQDBQ4a4baDuX4IN5YSX2lXDuAB1PQNBgC7SrFNKotu+iN2yaVpp/1dY
         qc/EZot9CRqYDgIvHZ4WvsnndJbtVNlHOUx90ui9lML8INCv5cusdl74O9ow5gG2Wf
         HeImZKZdKf4DpFnYrS7j+HhNqJFRW0ZdFr9plTbg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M72oH-1ivQpp3a6p-008aUD; Fri, 31
 Jan 2020 03:15:48 +0100
Subject: Re: [PATCH] inspect: make sure LOGICAL_INO_V2 args are
 zero-initialized
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
References: <20200131020823.29824-1-ce3g8jdj@umail.furryterror.org>
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
Message-ID: <458ab834-7cac-67d8-29a4-c5c2c5d6f852@gmx.com>
Date:   Fri, 31 Jan 2020 10:15:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200131020823.29824-1-ce3g8jdj@umail.furryterror.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Xg1whcpTsA2rMEMvWYlIbXv32ai7STwnf"
X-Provags-ID: V03:K1:YnhWstdlvDopn3twGy598WK8LS7xZJSUpIb7u0CtM1d24BOLKRx
 bjdc9i1ZAljjDsn7HPcqdsxMoLEuuIDhnQG3K4reapi8NvAVm5sB7qZbSGCZ5ofh5mL6Vvw
 m1IztHPN6XbR//kpseHYuNIt+4ReJkeTyfJMXZeHlCWJqSMAIaZ5K/gmT8jnxAqfoUBQTyA
 lfDr6lJyFUkIz/zL3KvOA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:orYOpVcRVMc=:o1oO8vb+b+seX8Vdg0vYKb
 sqi32GIFuneW0Vy+NjMbL0aAwC3WwGW7suu5+Uk9uryL9bMMPl0piTifi9rql8ZfvvNTwHqRr
 beIGqDm9mCJcHYTdf6PNXM0E6r+I6+tcKiLB7WBLYWW8x3MR8PCf5om84zznHyiaK3m3cL8QS
 mP+zPq4K/Lu9/45dkznVBsu0zVwH0Pd9hpHrBr7yKo14LCUvMioNYEkF3cZwQEQX60wjlZxTF
 qmAt+qVYD4ATJ+TT+tBNSGbFD3PG5ozs62aycNkrAKH5jvIXcJW7S+SLzY4xY839Lv5dcCKzg
 sTiRGSAEXC1UXRsY2y8imOJJpbGg+h7jNQUOBkIOnbqiMvoOvQJv6VVJLIi0fHzasc5y6WM7C
 Hx4hhy+7UhakrPi/1K4NAAHuqyAZwlLBFs/dlcOhXFiLBtKl5qxaIlbBRnWH2988QH03TPdI0
 Yc8YqKdVS0nA70m4QjhPuNT2IWfkLz7x/584By/230kvsJcIMzFIeiyyVHF8LSI60DpVh+2gs
 jExBxHDkP5DbtyINhJMEOtOO86pFfORYW67aHFtQ/HLHN7iuYpIsydfLhfX9kb49HDAHEyWmp
 XGvkMWFsrV/vIKCVUr1bFYoAUPDbJVSIAQ8KDjjjcj3TcDY1BTijY4HUAmwWZS03Hipwx/Ule
 uJGjtp1dGr4KHN1F1mELDO0hRM2oFGbl7H+zy8X2DYCK9610SZhvqyHupP64YcquUiL9GL1pX
 l9gUvrslS1Q4uHw2mj19G2Cr7lEzgD4slBmMtJ64yO3x/WqejDlwBnktP0wkbTo5FADyOhXj/
 5rW8VRdACMLBev7HNfd0sUSwD7c3cpG4CufGYKrtKuAMlNKkyYmS6AHdgTwZ0wVYiB0gdS7Jt
 bcxoWwGbIT6PAvfvBJjiC8Q8w7w4H7ENdkqYDW2efc53iR0frKx34oRnglQErI10KEf6jM5uO
 jgHer3/1QePes7XBph/9gs7znDQCwnV3RCrfaCzckrXbMkssP8KZKEtue2f6oTcozLFRpdovi
 tFa/LJn6ASvTgKRqCR2nLVoBCj2y3cAw5rtZFwgDTvUebAUM8fu/PKXL0yqlWXfhBGnZ6A7uk
 J0dN+BaT3/CMIC6EhlM31sRvrP3U2beAbKE+Ep3F7ZB9K8I/qAJxgYUzGh4OEST8/l8UgrKWP
 wt7kR3+9cIsoXIwGXafEkeCTXXqgVm+tMaHEhu00ATee0p/WmA5/E79Wy+blJSsDJNhSNJV7G
 JyVQvmjKvgWtb5f2o
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xg1whcpTsA2rMEMvWYlIbXv32ai7STwnf
Content-Type: multipart/mixed; boundary="mg9y3mSbiYrnHgrkrlp15Dr7gAb5zBMGG"

--mg9y3mSbiYrnHgrkrlp15Dr7gAb5zBMGG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/31 =E4=B8=8A=E5=8D=8810:08, Zygo Blaxell wrote:
> LOGICAL_INO v1 ignored the reserved fields, so they could be filled
> with random stack garbage and have no effect.  LOGICAL_INO_V2 requires
> all unused reserved bits to be set to zero, and returns EINVAL if they
> are not, to guard against future kernel versions which may interpret
> non-zero bit values.
>=20
> Sometimes when 'btrfs ins log' runs, the stack garbage is zeros, so the=

> -o (ignore offsets) option for logical-resolve works.  Sometimes the
> stack garbage is something else, and 'btrfs ins log -o' fails with
> invalid argument.  This depends mostly on compiler version and build
> environment details, so a binary typically either always works or never=

> works.
>=20
> Fix by initializing logical-resolve's argument structure with a C99
> compound literal zero.
>=20
> Signed-off-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  cmds/inspect.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/cmds/inspect.c b/cmds/inspect.c
> index 9ca78611..5b946da0 100644
> --- a/cmds/inspect.c
> +++ b/cmds/inspect.c
> @@ -149,7 +149,7 @@ static int cmd_inspect_logical_resolve(const struct=
 cmd_struct *cmd,
>  	int verbose =3D 0;
>  	int getpath =3D 1;
>  	int bytes_left;
> -	struct btrfs_ioctl_logical_ino_args loi;
> +	struct btrfs_ioctl_logical_ino_args loi =3D { 0 };
>  	struct btrfs_data_container *inodes;
>  	u64 size =3D SZ_64K;
>  	char full_path[PATH_MAX];
>=20


--mg9y3mSbiYrnHgrkrlp15Dr7gAb5zBMGG--

--Xg1whcpTsA2rMEMvWYlIbXv32ai7STwnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4zjc8ACgkQwj2R86El
/qgUMwf/QJcnncIBxst+jeIkRULZ0Z75XFsfz9kawt3lWm/djRnNNY+c4V7+gqW+
Tb+fNf/bnwF+2revuxMqCwDcWlmWfO/rolQlRjSQjQBXXCPaRZ8pvFfvWK4Tiy5S
9ClhxkgC9GdaTY7X/N7U+dr6b/G4+4L/bKglPjwwAAZFG2gxE7CA/l48ntsVCNrf
L/eMh9P9IikU19pTFI0LV5kOsyeuhPGVMrlkl2boOussFzA8ENnSeIzRvavw3Ewq
K2L95Z9g0syWgCiqktKwFaCMhFQ7LdZyEOFKez/hAIZ9jWf/HegNbXmvJHpUArc6
NIXLZstVItqBrQbf6//ZAvx40XZghA==
=V+eY
-----END PGP SIGNATURE-----

--Xg1whcpTsA2rMEMvWYlIbXv32ai7STwnf--
