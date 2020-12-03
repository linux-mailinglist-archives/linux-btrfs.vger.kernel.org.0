Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A292CCCCE
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 03:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgLCCqb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 21:46:31 -0500
Received: from mout.gmx.net ([212.227.15.19]:37965 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727264AbgLCCqa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 21:46:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606963494;
        bh=oDJWlYZur9/ee4eHOVmKW3AosKmJSsQ3AIN5mPCqL9E=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=KDmNJKabaz8L67qVvWznVZ8cxb5on07TLZeK0OgzU4X1lLwDhP7zWoT+ZrTYfmDdH
         m55Cypw721FAIHhIbPCQzJvoBUcNFhZrNi8IJVEj3GefWCUJWE6w+KGM2fWl2Gqjxd
         bXx0vOMowTKxsEuxIrQl2ktlmpKSJray8i82PPHo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Ma20k-1khJ6g0fmm-00VzRj; Thu, 03
 Dec 2020 03:44:54 +0100
Subject: Re: [PATCH v3 22/54] btrfs: btrfs: handle btrfs_record_root_in_trans
 failure in relocate_tree_block
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <fc86b367066e2853db86aabae066318a7346bafb.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <1ad75211-e7ee-359e-a378-94566bc66cca@gmx.com>
Date:   Thu, 3 Dec 2020 10:44:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <fc86b367066e2853db86aabae066318a7346bafb.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5q17DJh7QavZlI8Nn5PaDy8ChkJr9UVS1"
X-Provags-ID: V03:K1:CEMOCz5vxdEovtzcAUhFmY5jmtCQ/WAVqPf1jUsUJT4XBJx6K34
 fL0fnaKZU0H3Dl5K52XDdtZ/vOA7fi2OThIrzg+Ssrs6Xd6ck24RLB6fuQiUJsnhLMyCYGc
 Ln40VYrvXKAoI8T3zNfV/4JNAK6XPd9v7IAlfyfZmWypMA08Axy2YANuRmZ6q2No0kNlWqa
 UuQ+6L5WP4afQkOT/ZnOQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bINWaOouZtU=:BsELxgoXNijH5N5VPhEfTA
 ikiKLnVVTvvxOIOOr5ShHEFxpqSoE3+Q6q+w4ybJr7CjqFJEkFaOTweJm6jX4FO+GBVRyqugw
 5b5eao+VveIXnGNCjAUtiL5qK7KQUmNNbAMcrj0V+A6YLMF+lRQ6x1ye1TS46u+wPelL/saaj
 Em5oJ729ht9YZxbVnOQPomEWi5w/RuT4XD9mXD/+mv0olr1NC/kSF8kwzGJ6AWwcWhYoyWz40
 f8Y0GMkk7dEKZwVYlhWYAuqYnhD2K49sL8X2qadn0HjSSSfzXFgFIUTtPfEjKfFHPI4as8v7d
 NNAR6ddW9EvkNOKKoxo3h6ci8QxmMaLpkzoixyQmLo57I/krVEVYu0dYWsB8Ne1T1eGRr5X/H
 VrrIWIi0221jvFKbjyHwqcW43v7blrmMWwBwzD1/NCUyxhJ1aC6aZwBkxWE7OoQTjQEbSSUuE
 JCEa7Za6iq+JO5JZD+GkRlU6vOJdmTIOL3AYlDzyPCButNnIsFGQU6nQvPsw/FwAP62XkMmWo
 Xpnhje4cEcJFBYHS6p8i8rgIrK5imiJTTl6TGFdMnI4SE/Hv0KnAKjBQiVHw5jUzfdPtrZkIL
 v+9Vr9iNoHFAkZyJ++pB0WfIIpSb9JZa6n9Q4iJGwGMmoy+/T5i10EerXoju+8xwNpu6vfa/C
 4Q/0XggZuwUHHJ+1NCZuWMbNP1qBw0dMkA2ZzDSdky67S+W7KO8+u/cTPgRTYHOPTOZX0U1g5
 ISUaauoruG++ZuKa/TpRWhlO3x40SwqKMzhQtrP8B5uSaGkwaRiA+L84uU/QG0p6kZx0BlLpw
 aQoFsx/+f1aAlPfdwOxwVJ6kkVgYNyWsq0ygTv3b0o7+3YQpwg7GwZtuwF5I3xDon29wJ2MqN
 7RB5+5Fqu5kix2V7kPcw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5q17DJh7QavZlI8Nn5PaDy8ChkJr9UVS1
Content-Type: multipart/mixed; boundary="bmFfBldmxjxfPNX9n4JHNmxX0v9jhD1wx"

--bmFfBldmxjxfPNX9n4JHNmxX0v9jhD1wx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:50, Josef Bacik wrote:
> btrfs_record_root_in_trans will return errors in the future, so handle
> the error properly in relocate_tree_block.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/relocation.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 5a4b44857522..e9d445899818 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2559,7 +2559,9 @@ static int relocate_tree_block(struct btrfs_trans=
_handle *trans,
>  				ret =3D -EUCLEAN;
>  				goto out;
>  			}
> -			btrfs_record_root_in_trans(trans, root);
> +			ret =3D btrfs_record_root_in_trans(trans, root);
> +			if (ret)
> +				goto out;
>  			root =3D root->reloc_root;
>  			node->new_bytenr =3D root->node->start;
>  			btrfs_put_root(node->root);
>=20


--bmFfBldmxjxfPNX9n4JHNmxX0v9jhD1wx--

--5q17DJh7QavZlI8Nn5PaDy8ChkJr9UVS1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/IUSMACgkQwj2R86El
/qiRJwgAkEfjFornV02zTjbTmbIP4kEaNyT8r3+ja+OSrOSJKNnxRpyvsZc7xQ07
+HLnjNtuWNcACXbqtaieMTjHXb4/f3GDkPRZmlV4HSwu2zw48N7Mc9CxIOb7OTPb
RjL8+hitlxuUnhIs9UeJs2AfL5QWg91rTCXQoUJm/eZTEoDMslZmIVXa+Cu5P5lA
tqAGWshKhkq47Y/o2oQ0mZ7Tcp8QFXANqazebmnBpZs4692jZaMYXGf7riXRbitx
Ee+Jagvl0Yg2ike90nue5XVL4fWFd+br7ltxN1Eg6bjh0uxqdnSGLcn4rcsNJJEm
xN2g7QzBzbuXCAavVeO+8DHzZmE5YA==
=VsZg
-----END PGP SIGNATURE-----

--5q17DJh7QavZlI8Nn5PaDy8ChkJr9UVS1--
