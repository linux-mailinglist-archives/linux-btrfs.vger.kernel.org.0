Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B372CCEAE
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 06:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgLCFeP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 00:34:15 -0500
Received: from mout.gmx.net ([212.227.15.15]:46417 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgLCFeO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Dec 2020 00:34:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606973559;
        bh=Ax3kY8MOisqWDyakyvGJPWjov5dpnC2JqL2ZtnOJycU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=W6IalunWJ5nqGicBF8n+C9qR2HnNSjRisOrCYxtdS+jSdQG7AfKuJCkSykVkb5/eC
         cr5wBq3wmBf/t5/qCzdEh477v7xdhzMb9vNOhC1dvepIUBONSQx7YYx3E2j5zHyDSZ
         gbL5uYtD+naI/ICW3Yh8RW6vCSPC/OENZltGT+Pw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MOzOw-1kWJ4g41tc-00PQx0; Thu, 03
 Dec 2020 06:32:39 +0100
Subject: Re: [PATCH v3 45/54] btrfs: handle __add_reloc_root failure in
 btrfs_recover_relocation
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <c8b8686a06271891df483dec87e3e6164cbc0f9e.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <4dd6242c-f0a6-2388-4f39-3d0341da790a@gmx.com>
Date:   Thu, 3 Dec 2020 13:32:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <c8b8686a06271891df483dec87e3e6164cbc0f9e.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rxBcLMSXoonvSgnwnyMQe0TFHuTFSVilL"
X-Provags-ID: V03:K1:/AMRbWPrU9wat7ZA2VponKcYONe0zGbgGBgT1M0k26wHHzJHZzF
 VOsNo+WKP0Cf3tSWbX3fvVmcQ19VbgFCY7dnzvz2CwCZtmkHhcbcjiQ14SQ6qh1PA4QvZIC
 cuuXeAjdtCgi2Iq8Penyqng9WddOmLicFNfWBUvBmHI5536q8zubU7X5kR5TwfQwJck3d07
 iQl1OL5lFBJ2WRCQ2FFkw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7PIRCjhKwJc=:JZlseIcQ+cLCQynxk91OD1
 pPd6Mq8SfxsGwQjUVnGJSVl5PjmZVnEWGfUAOxxdgLyI3JLiFMFXeqoVHY1/PVAPRh1voMUCl
 Y+XD4QN5IKmMiX9RR23pw6NnSLV91TFvNnv7m/X4UfB3bpiqUG2Ci6bRbELE4abMsa60ajNLh
 8VpmGxSkKKpZv/u1gC/sGDiLcIOjB+VF7S7QG5GasfRdBtzi+MN9HDC2YRaHxHWWJDo3tHbwd
 yHP2U0LGN8uB8hgXDgtTx0ZxhtRHuUt2+dIVv5gzdmRo4bSq42hxHMacwleNyLXU3iovpGS6S
 78q2/Fpjr2YSoStQClfHum3sDxJzHZeLxCh87ZQP4NiwnRxuN8fJf6SEQhqXRxQt8j+WvLTQz
 7J9t4UBrpHh4jHadbSm+gu8yy0Q251v79aTV/RwkOuhmTHM7XGIujOkBLsXafpoqDacMRpGdS
 9ygtPDXNmT4zY0kRJtwmlwIzRHBtEubhCzbsnM8ot/f/9z7DnWbX38ydFJE1IWregR/1bwFEm
 g0FNnyXLZyh+jbPvjIdOzJ/1FOLLcbTaAugOMETjxwDdx8eICZoR2Ruv+HEBWKU87/yPdEx16
 fdC1RIGksCkFvSwQkAQTsF+5PT6wDymv7tzPkoIEFNcox4fQGXwi6RWFB4Li+/GtAM/IpHE+g
 pa9M9aYK8wZttgreCd3Vvxrzoc0F5nBxRrN7iFHurYttizc4M6BmMkzI7RaIYhUPlyYWVAqs8
 LPvjXWXwzk/E72UYma1gFO7Z1JJf//5iTDCf5IL2akoJd2OAx+MEZsnBo61n7e1LzDKHz4O35
 NHFfFyxSkGDfoIHC2opD3gkY0Y30kQsGqH/rtcilGyKdKRd78WMC+6lw4P2fVQyoBQAZiyhEo
 YTqmYL7kfy4E1oNDy8NbcMc7NAcDbGDrVgIIDMTL8=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rxBcLMSXoonvSgnwnyMQe0TFHuTFSVilL
Content-Type: multipart/mixed; boundary="o1mARSugp7zqKia8MfzX9naMACUpZKUnR"

--o1mARSugp7zqKia8MfzX9naMACUpZKUnR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:51, Josef Bacik wrote:
> We can already handle errors appropriately from this function, deal wit=
h
> an error coming from __add_reloc_root appropriately.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

It turns out that we can do less cleanups, as if we error out here, the
fs won't be mounted any way.

Thus things like reloc tree don't need to be dropped.

Thanks,
Qu
> ---
>  fs/btrfs/relocation.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index bcced4e436af..6315e74c1da0 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -3984,7 +3984,12 @@ int btrfs_recover_relocation(struct btrfs_root *=
root)
>  		}
> =20
>  		err =3D __add_reloc_root(reloc_root);
> -		BUG_ON(err < 0); /* -ENOMEM or logic error */
> +		if (err) {
> +			list_add_tail(&reloc_root->root_list, &reloc_roots);
> +			btrfs_put_root(fs_root);
> +			btrfs_end_transaction(trans);
> +			goto out_unset;
> +		}
>  		fs_root->reloc_root =3D btrfs_grab_root(reloc_root);
>  		btrfs_put_root(fs_root);
>  	}
>=20


--o1mARSugp7zqKia8MfzX9naMACUpZKUnR--

--rxBcLMSXoonvSgnwnyMQe0TFHuTFSVilL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/IeG4ACgkQwj2R86El
/qh/Gwf9EjW5AivHRkvv4o9L4fsx8W3cKO9DD24Ib3qLAzT6N1wGD+znEYNZY8Sy
+eEPF1uO2kHudNhBkG6HMpW+1Zj4aLN0EKKH0mH1U90aqlJu5NYUjguAh3V4Hh+3
uU6Tvrhuz/tr2lxRTgeyMJtVQkQ7iWiBXKec4UBczbJZIhbarIys0dz11c8MKD9y
HInyXvtQ+rtq8trCeXf6WsDF1j6hXcBfoAQaj60VnYCF+EDG+7u74G+a4nTlqzq6
K1rxOjSve1cXEeGQ5Rhq7/K1uKS44WHlWaF39XOI05Ilp/VXpkDQI92lcIl4h2za
CPImWIgqlePtWnp8S2F+VYSdkiltkA==
=an6+
-----END PGP SIGNATURE-----

--rxBcLMSXoonvSgnwnyMQe0TFHuTFSVilL--
