Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA34317A473
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2020 12:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgCELk2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Mar 2020 06:40:28 -0500
Received: from mout.gmx.net ([212.227.15.18]:36721 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgCELk2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Mar 2020 06:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583408422;
        bh=2nlL83G62NUSkBD97oiTTjx52sV84vkRqAP46OKK0SU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=iMYExaXZmQrxeq2u6W9FRZCIHgmNYn8PeCV3jPEjLFDaAs/FvV4BjqT5kEzR/XaoD
         6+G9DoKdyyCeBDVzWBrjtIFqeZLKEsMqdJRYmgskUdOk7UzOlI+n8LsIpFJ1aKNABd
         o78JpexlRmvmC5jh64PXpMLx2rYCsHfbhl2jMlww=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYvY2-1injdN3xZY-00UoRu; Thu, 05
 Mar 2020 12:40:22 +0100
Subject: Re: [PATCH 5/8] btrfs: run clean_dirty_subvols if we fail to start a
 trans
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200304161830.2360-1-josef@toxicpanda.com>
 <20200304161830.2360-6-josef@toxicpanda.com>
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
Message-ID: <4a6356f0-a177-8759-f89c-56f00417b2ee@gmx.com>
Date:   Thu, 5 Mar 2020 19:40:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304161830.2360-6-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hvSg1ngDp3dYX4VRiIeRURP5F7NPsMzQn"
X-Provags-ID: V03:K1:GHpXOcKqR9ohljg3LaI9jJbJ8ikqlCZJIfS10zvH8Qxe0nMHjAE
 JbKj6RVcrZgSbX8Xrow7RbFwuXx9geJAy3dFw4IUpfTP0hvf97ssJqqsBa2tvOQ4KuDp9DO
 BIugPj9hj7S1ryqBv2kWeRuFaakBENOwpm83WW0gWjIX55ln2Q7/THaNbEyo9fkD8iZ41lX
 2U1PVWz9WmUikCL8SPS1w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VnFEsdDqbeE=:QAVNTmR9my8zOPTQSeaBw3
 viavbMrUAxas3VfON1DsZKMqXdBZECWgaX+KutPV/T/68uV6nFhDQDNn5o9RNLIY62Afa+D2l
 SfCkEjonubbytZsmzJGq6zdb8CmiYq/RczyVE54yHBHPEW3p1NSW/IKo/+PHqeDFlJiwl04Ky
 nWuVggmqHrPmZ+P3a0CbL2LVxGs+JyoII0alrzhtoSCyyJMX8wDSuohxK7DdL6NPxkheRUIL/
 Q7nQGPAayLF2qqoaRYO6bHsuqEdnWw8DMut7riseuJmhq4KpxC9l4NDct4JEnCcvpe0slgs0c
 79W0Ge60+PvygheQgr54Oiu7CfVRWdeftS9jsgIrIXklZLZdvdvVJHF+Y128ZfbXPJv9XWB1G
 FUjlVTZoUAP7M0jejEsQ7fNheSXmYeMBqtgQ2gqI+yPFqZwaO0w2TSYSr3lCCjEPFIiqL0Tdk
 N32Ue7LPKP31eePhvj9NGDOI2ljMgsl14qjctyOwcgpKI1H1/ACMWqQgksf9KC8Q/wN2XEJZp
 rCsXlgArvAFSMJxRcB37wLf4LhWMm9KGc+5tBk/REs9epKcVpeaIlv2GFdd6G5JD5Tz6slpPZ
 BpsqUs8Gz6tKjr9kLCWH7eU+FXuJsww+X96C0o01tcWj5S8UpXC3tCceTh1hApuHvz6pExzkZ
 GCFSxNDnYKzJrRCN7QUAflMI1jnz3t47uZ354BobEslx3O1DDjulur8tnyMc/BZDPnS7tdPyb
 pwohWUF7rRn272r3pJsD9fd69yEq8srMb+qv33Us2VdOrDFunqLbTIo0oPvlCQhmU4lVUdWaB
 NCqotEsNmnn4J9FaqlLwxg9gnKsm6UuR5baRdVnoQMWVM08lika/4asyBEJPBcyZ+eiYUfF4o
 X42X6hc+FPUFLKxIYOxyT0R6Y6OBiCKv8MAokQGahEKrBZJHgLppOlKVzPHkFg9b23rWhpkTR
 ewM4cfMmD4tqNPg8pbuhYke6vuvm1yOmUmXH1AKzic+i8yNMmjGQ6iwq2kriFBp4k6J2bs39Z
 fqHq0hnnpqzQnsJRaqwiW66JCZD85QVf4EOmsNbrdfhr89pELZQgCgl+nglNXCGIWDM2CGwTD
 JCQbh2KQc8fXVBL3GxvN8QRto+XMTo7MdEnihrVlWiKVPSX7OQg8peRlwVapyvK1h1MYWYJit
 37R1Qvs5ZPljRGyyUrsyN+GfR1hvOCCnvhg97VPkjIguIzYjlYBaM38APDn6h9fdKCvDcuRBl
 7CjHcK5dJJVisHOTE
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hvSg1ngDp3dYX4VRiIeRURP5F7NPsMzQn
Content-Type: multipart/mixed; boundary="nNw7aTtqkpWtbL49fJ6AX68k8GfJdNSNS"

--nNw7aTtqkpWtbL49fJ6AX68k8GfJdNSNS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/5 =E4=B8=8A=E5=8D=8812:18, Josef Bacik wrote:
> If we do merge_reloc_roots() we could insert a few roots onto the dirty=

> subvol roots list, where we hold a ref on them.  If we fail to start th=
e
> transaction we need to run clean_dirty_subvols() in order to cleanup th=
e
> refs.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/relocation.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index f6237d885fe0..53509c367eff 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4279,10 +4279,10 @@ static noinline_for_stack int relocate_block_gr=
oup(struct reloc_control *rc)
>  		goto out_free;
>  	}
>  	btrfs_commit_transaction(trans);
> +out_free:
>  	ret =3D clean_dirty_subvols(rc);
>  	if (ret < 0 && !err)
>  		err =3D ret;
> -out_free:
>  	btrfs_free_block_rsv(fs_info, rc->block_rsv);
>  	btrfs_free_path(path);
>  	return err;
> @@ -4711,6 +4711,7 @@ int btrfs_recover_relocation(struct btrfs_root *r=
oot)
> =20
>  	trans =3D btrfs_join_transaction(rc->extent_root);
>  	if (IS_ERR(trans)) {
> +		clean_dirty_subvols(rc);
>  		err =3D PTR_ERR(trans);
>  		goto out_free;
>  	}
>=20


--nNw7aTtqkpWtbL49fJ6AX68k8GfJdNSNS--

--hvSg1ngDp3dYX4VRiIeRURP5F7NPsMzQn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5g5SAACgkQwj2R86El
/qgOZAf9HczQi+/VxKIiMM8u92tb+bgnUdStY8JzrbOUaobGUjQdH5nKNZxs1hfV
2emRz5uEGLGu3sKfKkB+/Sr+oPQNvkXhm81lZwNaCQ+6rGWUCzuC5t7E7tdYwW4i
idPikjAyH9eXlCN0Or0TmZXjTHn5YwwszWvLTBG+MKb6w7B/J/oHBVRQcqjvwTEq
Vta6B7t5Ctm7UataREkXes05FkSPBk1efF4VOLUOxEfW7uYHfCowk5d/Fe+DcRoQ
lNNYfO+YJ7Nhv9FHU4ScDpqx4CEN+CWypshvVtzXZOj97vPO+d+64ayhcliC+6Fm
KmlXAezKKgsL8IONf8E5ONXeRoVHsw==
=6kk3
-----END PGP SIGNATURE-----

--hvSg1ngDp3dYX4VRiIeRURP5F7NPsMzQn--
