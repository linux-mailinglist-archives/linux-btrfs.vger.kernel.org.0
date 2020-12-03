Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133122CCEBA
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 06:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgLCFlK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 00:41:10 -0500
Received: from mout.gmx.net ([212.227.17.20]:36347 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbgLCFlJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Dec 2020 00:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606973974;
        bh=DZnzJgbn50ciMHSnzpKXR79/VJR2917s9p8XGx8scqk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=MUQcAbERQOaZUm8bU+MdJBxM6DpSZh3D/JrAxf7xTEVVVoc9WFBDmrB1GBvJTbGn4
         apFwju7d+Av6EHUgzlugTZ8kfSqUUoH4WkcSMPK8cZRZPu7BCYPTstrssGKywWzc7e
         5JmZpeVnZZJpBhSxQbsS8XKpR0bb9U39ltHygaxc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUXpQ-1kbnPB1ATw-00QRH2; Thu, 03
 Dec 2020 06:39:33 +0100
Subject: Re: [PATCH v3 47/54] btrfs: cleanup error handling in
 prepare_to_merge
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <6e41922428a5b89b5ef0d7d47f8274e11468ee2c.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <2c507955-c50e-8206-8d99-00b99c176258@gmx.com>
Date:   Thu, 3 Dec 2020 13:39:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <6e41922428a5b89b5ef0d7d47f8274e11468ee2c.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UmipgqQknKFIofhKMQ04w913kwCDdguLi"
X-Provags-ID: V03:K1:iik8//wxvXu3kTatoLNeZZg49v+VaEiygfW98Two1Y0C6Gp7HqV
 OoYv9yvPCMHdjpwBWz8m6yUSeP2VxOOV1u0CFNb4BJ3Sb9Fz3K1SvQahw9mXHJFDJfbIFCU
 Gc+8AbWjPqb8bfWYW+g8JBKgV8GmT7ZeGZdkeTijvFDiFpN59NzOE584ytufdgepJtTKpCP
 +VWIpceTEABR6KW3XGlYw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PIq7JqEpY04=:Ml+nNKo3J6B3D2d8kqZm4R
 8n6qrMtzQidHlDEvF8X8+xGY273NJlTCf/opiurBapJAz4OqqcTDcr3bQwifLT23Aeanqz/CU
 DHXOL4+oTrQQAB0iDdArW4CoKYeHGixgHAKJQ3eJuwh87buKQ0GPwyVdJQPCNw4oiOWwkNxVl
 7HG8W0ytuQBm3smfOZOThPC+iEMycW1jG/QZ5cqpvugtp38ukL2hKgFSojd3ePFPUT4ajGWDI
 ZBO+xOuUTFYkRYpvk3mztbvpOrFRQP4U/sUW7rktItx9ahunQEMboaMsuroKnXr5IAV2Fs6GR
 k6dPUSethmypG1kYAjVMxuB8me6wtpWEO4hkUUtflKFtfMw1Re80ZOfY99RdG5Rt/W5MfFB5d
 DZRIVTcQRkZtAM7CAreLlrBlHEZ6BS56HGp+yrLnH5zL5vvKTSQgBpTX8AXcRf9wIj6nL8qKM
 Y758/Pq6zY2DS8nudlQynCLrnnyIgiUXDM86l0xe4PjpUOoOYOTfWUU2J7NY5pMaMMaAhcwqq
 434oW9+gmUzgHi40EbXN8O1i51M6HxbzDbWRISWQQxEx+VEDKdX/DgVpCoWRes25BdU8oppGc
 QY+wbF6VrVl9wljLwV+gq0O4diK05XNdmE91do+ek1/uOZR9UIHvDGZFs/R2gVhHtAugZGIvl
 SHoPnnPNdp0MVpnOczTb+5pMdZ+1myeB8gdpcoTZLtGBrjHme0DEyYrLxXbOBmD1PQ4Yr1SjN
 U+FZ/YUh2OPUBeVt+hVbGB4GxY2bkZf8lUqtg0MdUZGoIHCgJFpWa6/7lkSSHDHmpM73hsTqB
 ZBnoz2XKaQ+wWpASt9MdImVUV3+Rq1wFqmfE5nrQGpENPftOycjozsWeq/0iVePdeixKZgL5r
 IOvurVgtpGE1/iMLj/2HklJyLvcLNM8Cn0keb0vl4=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UmipgqQknKFIofhKMQ04w913kwCDdguLi
Content-Type: multipart/mixed; boundary="yDSuCbtSBTDbIA2PnYMfDnhfujZh77e3m"

--yDSuCbtSBTDbIA2PnYMfDnhfujZh77e3m
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:51, Josef Bacik wrote:
> This probably can't happen even with a corrupt file system, because we
> would have failed much earlier on than here.  However there's no reason=

> we can't just check and bail out as appropriate, so do that and convert=

> the correctness BUG_ON() to an ASSERT().
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

The handling it self is kinda OK.

Reviewed-by: Qu Wenruo <wqu@suse.com>

But still some (maybe unrelated) question inlined below.
> ---
>  fs/btrfs/relocation.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 695a52cd07b0..d4656a8f507d 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1870,8 +1870,14 @@ int prepare_to_merge(struct reloc_control *rc, i=
nt err)
> =20
>  		root =3D btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
>  				false);
> -		BUG_ON(IS_ERR(root));
> -		BUG_ON(root->reloc_root !=3D reloc_root);
> +		if (IS_ERR(root)) {
> +			list_add(&reloc_root->root_list, &reloc_roots);

I found it pretty strange that even if prepare_to_merge() failed, we
still go merge_reloc_roots().

I guess we'd better handle that first?

Thanks,
Qu
> +			btrfs_abort_transaction(trans, (int)PTR_ERR(root));
> +			if (!err)
> +				err =3D PTR_ERR(root);
> +			break;
> +		}
> +		ASSERT(root->reloc_root =3D=3D reloc_root);
> =20
>  		/*
>  		 * set reference count to 1, so btrfs_recover_relocation
>=20


--yDSuCbtSBTDbIA2PnYMfDnhfujZh77e3m--

--UmipgqQknKFIofhKMQ04w913kwCDdguLi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/IehIACgkQwj2R86El
/qgOtAf9HhHac3OgaXOlNkGCaZM1ZGPRq/kzwYpthgMHnSGdEkL4ZuICpDop5jDJ
EiWpr9P6NmdjFhmkKWXl740Fqz8z+wGGZnbEW655sgmJ2I3tH9cmF7OCMMui/3aJ
XcV016BjUS2HEgGpjbnas20DNRkNAub2AOtLzPAkUlpq1egarC4Qn6/bnHV1L03s
MA+9zuT3yg9rAC6474zfc6XevI6wAaHOwsNWwfsExnct+H7aaCauTGJ7Pm9mO4Pm
HLc0bW9ijs9afFhR3wITr7S+dmfacMRfyzRQ6o8zmJy5g2gdHkPsgqd/ZqfbaJxh
apEUFtR2QHjf++1rjRLP9rvWiS8USg==
=bY2a
-----END PGP SIGNATURE-----

--UmipgqQknKFIofhKMQ04w913kwCDdguLi--
