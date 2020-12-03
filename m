Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0461A2CCBD2
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 02:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgLCBtk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 20:49:40 -0500
Received: from mout.gmx.net ([212.227.15.19]:42093 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbgLCBtk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 20:49:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606960084;
        bh=b8t2O1gIHQGu76IfoBxLB3P95KG6nOpYatlKfE22eKo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Tj0EX+poHBbKPnF9bZAbV2UU9upS00/4/qu3EKuy2qygiOYeaVobjyIqQizSs1Kvp
         9S2M5Zi/h0b5AkLiEmLyGSTZiOvxki9qbLHUQ7WI9Yw7XoTMJTWxZpTcJ2Rr03Uyht
         PFc9TPIYDRLVrYhQUmscg6ok+MuxMvi9FYz2aR5Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MBUmD-1ktCyy2EjX-00Cw4p; Thu, 03
 Dec 2020 02:48:04 +0100
Subject: Re: [PATCH v3 02/54] btrfs: allow error injection for
 btrfs_search_slot and btrfs_cow_block
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <c0a4d7f83ba50576a4203f0169f2232dbe009d3a.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <9c81cc8d-6bdc-7e28-3a2a-5669a994eb5c@gmx.com>
Date:   Thu, 3 Dec 2020 09:48:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <c0a4d7f83ba50576a4203f0169f2232dbe009d3a.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ygp0PJ5A40h0AvfbHNPszCFo0So6EMP6P"
X-Provags-ID: V03:K1:qC8QzVpIgfNDhLh1i/gu0rbVGCPcwbTJRAuHrPTWv2VPxB7eGZo
 7WrOATxMbLn1WO/yr1nTzBnxKRjNWywAMCjAS7LBfPPbg7CUpg3Xu+AKlo75XRIWXGgJsyS
 X4aarJll1slmfSb1ythzeWfnKZgfSsYQISkYj7QYozFW0seUOvO4VPab/y+UafOI9b8/9dV
 n7Ke00ntwmGBl5sUg+BZQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KeHrmkNIgfI=:QNdxo+3BCNwq67n8XKRAFq
 T8NeY/iDhscs4xBu1AcA78L/Rh6cJtNjcBbW5LrmkJnzAS2n8ur1QvF7gQAkKwawZZ5IQzcaa
 bEXrWyx1ItP+w7SFg/aDou61D9zywC5oV/CeEJai0h6tOxM2du6cn0b7aBbIp44+6Xb5VhnXm
 D2oQurfQgvsTN6jReoYMyIwA3ciXi9MPoXIeJHUUGJO2+5VWHXCewHZp3zntPMRyZb5NCmRTy
 XOD6q+qFFQF1u5gK2GEJxGkfQm3yEojc/hfOlbBApPjsAfrv3LQgIOTohDBzgQs4YiraI2TXq
 OgXef2PWzH8IS4bJ+nj0n23kNScEH490u4H9dzdu0SsOqf5pI60ujOgU7vXfTT1uHOE6tW2JW
 gqGk1QPZWdEWf2s6iqhjMG2o03emYUN6VXL7SeJCAvEMcuQNxJ40SPrBIeVtWnYSZFYQ4W9zI
 KE2Vzm2u8lEfQyiALq3/kUqn4q6nBAS0rzPirRw6jBRGwT+/3BWss81Et+wGas7q2djOwMFPM
 4U9n7nsgnUPIvrtnJtEN4JFmnpNJibnD9qRkEb5s2aoZdhyGxR2VqD9NJ6L8SseaS4V9/+5V7
 KnYrGghzCdMKh5nw/9f+mC0NH+fC5TS9MnJ1ATWrZG+2DApJCO3yhibPfYvGKzavoh3jUMdpP
 3xm7OW/BR6L7PQsp8ddzjCPWxfoteRzmUKKi0yJD1KV7efx6etEmuHLM+kLSzVk+hbEX58QkY
 ZsilM4AE5+dKTHEJk+UqdTem379aHGCCNdBqyXgS17IJdjRMulEXc8BGF1ZJHJfq2+/CSA2Fi
 MT6fwVvvgIVmsZ+CZWsYAufSRUPEqQMnHMYpqtlcNK3fyl2k9ojKbchSUy2niXi1nQwt2NwzD
 Wmb7eWV+H/SR8wnwjz3Q==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ygp0PJ5A40h0AvfbHNPszCFo0So6EMP6P
Content-Type: multipart/mixed; boundary="wZnuXb6TGYYFdg7VRoPNRROYI2zR4nW4M"

--wZnuXb6TGYYFdg7VRoPNRROYI2zR4nW4M
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:50, Josef Bacik wrote:
> The following patches are going to address error handling in relocation=
,
> in order to test those patches I need to be able to inject errors in
> btrfs_search_slot and btrfs_cow_block, as we call both of these pretty
> often in different cases during relocation.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/ctree.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index e5a0941c4bde..f40d3a2590a5 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -1494,6 +1494,7 @@ noinline int btrfs_cow_block(struct btrfs_trans_h=
andle *trans,
> =20
>  	return ret;
>  }
> +ALLOW_ERROR_INJECTION(btrfs_cow_block, ERRNO);
> =20
>  /*
>   * helper function for defrag to decide if two blocks pointed to by a
> @@ -2800,6 +2801,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *=
trans, struct btrfs_root *root,
>  		btrfs_release_path(p);
>  	return ret;
>  }
> +ALLOW_ERROR_INJECTION(btrfs_search_slot, ERRNO);
> =20
>  /*
>   * Like btrfs_search_slot, this looks for a key in the given tree. It =
uses the
>=20


--wZnuXb6TGYYFdg7VRoPNRROYI2zR4nW4M--

--Ygp0PJ5A40h0AvfbHNPszCFo0So6EMP6P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/IQ9AACgkQwj2R86El
/qgF+Af9GymRPdoaMzIypvk9i+hoveFI0Wvs+OSH1BeiPLOXA+X8yAQStlDriMph
bQSPfRZxI8EZZFNSZkcos9hAJ5wtQqyOmwxXQLE4OmkUx9+nLfIFjVRLuyREyeAA
Gc9ZPg7k6XAHCWd3quI3diZMA7zFWot3uFkxqVMPgYkCs6RtpB/+bMpandxNv5w8
3D5lOXSh4WcTEqhXiMuamGot87RrvC0oN8fZcF6oBiKS8K5qqSvIju19wYyjM1pl
tmSuimQm19jK7HuSfN9gyaMiCAUhRamsRZFhRVlilw/crp33pn5XX2+sx+bII2p+
8HsrPySda6lUJ8RtGfToQjOsmMJdSg==
=Oq5U
-----END PGP SIGNATURE-----

--Ygp0PJ5A40h0AvfbHNPszCFo0So6EMP6P--
