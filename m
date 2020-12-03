Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7F82CCE68
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 06:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgLCFRg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 00:17:36 -0500
Received: from mout.gmx.net ([212.227.17.22]:43437 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbgLCFRg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Dec 2020 00:17:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606972531;
        bh=Rmx8QJdUyc5Tn9zdMvmF+h7ZHssQ4Khp9t2T6mBH1I4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=VlgY5MNr7C2Rv+nBQvRqJ3jdY4c6R+gM+f/lWHQDYHGg1A/Fg30EUTjQ++zEUgZ2d
         8JLr/4YzzXn8AgAjgam8dy074YZFIZQ5AHFNfH40DsoJq87gv/Wky3l4GrR+45ZHUD
         r3jO/jr5Wv0bPjVn5PYRdSWuIJAS0vhf530nTkK4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mel3t-1kD0J52V8f-00aoNW; Thu, 03
 Dec 2020 06:15:31 +0100
Subject: Re: [PATCH v3 41/54] btrfs: handle extent reference errors in
 do_relocation
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <fe755664856dd75359962c132d7398b0e69a3f22.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <a5a5d6d0-0cb2-18c6-3eac-976176811d9e@gmx.com>
Date:   Thu, 3 Dec 2020 13:15:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <fe755664856dd75359962c132d7398b0e69a3f22.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="a7LprRWcEyyu7lHPyqOvQSwLyDcwOxdje"
X-Provags-ID: V03:K1:A1FVgzbKh3ywlUbAx53drsAs0yS8yljqvdBpA4lhKLd8n9vz4/M
 D8F7+W/UsxEoFjurkqfIXSsMAeTLI73iH7eGNoeCbwz1INF+sWHAV1kck78i8SRF9Vdsnol
 00pictYBAvK9uWazPQzX2D5r7ec1vEfpFmKTmHzyw5xX82SiBE8btAn1QVfhdU+ku+Z5v6U
 1gaTwtmvllo1I6TqFsi/A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kqSZaIOiuxk=:78ACFZg/hAnXJGFST/oRO8
 HfF9Rw39zPFhB7nLkEX+NVow8SNDY16eoK9hmgIj3K6gQeWgZAxHfxU53OeqZRpGUISXAPatN
 fm0Uu0CJV7ArI7uQwfW59UuNoAIbtIrM96cbERpTf5B1LxTME1jhe//JM2Hx56ptHVKANtu+0
 8u037eAOuTJT9YowADR0xjXY+yOaERrwlj6tOd0XEq5xOCG54RI93lsKgR1IjCxiD59G+xO8l
 QBso+allPneHpFx/8yUOvaFjEBuK4I4IGu+/LRJ4OPENh/9HGV11jEIc7YJTaBzwOk+YjgXRH
 aZZHwzXOLhYm6Cj7cxgYKyr8Cgy5GFZfXli7k1abHf+ZFk8RyLhHTSyHfm4WhYIdcpA+Uhleu
 Wp2T69xioI/jdNthq/X9VC016Hsg/8k9oMF2GuR6VcIV6xOCOzqYuWHxJNrVnGtt4X1b18mB+
 Awdynroc4NowRzA9PKez6moPAJFeE1G4Lc36etgIaxI3W3G5U/fDlgMGvpGzium+gFcSCzbHx
 ByhLGR5R07/gcsNPSTiWpSsmK1iEWsMApD6zTx/rJb0jqTUBQ5LYLygt9K8HWpNHT1nS7xpA3
 g81muuGoK/juc3gLAE0Y7/1oYpPwOUBenhDebz3J0H2e4gba2DRApN8M8s57zpmXWD+82rJJ0
 cwmPnMJAiN7kBNc4i1MF2mp4A2/+GwtCO7GwLbUcDZPvNxXKXpecLCrZDetwVuIX16tyqEUiE
 axaXz2XuPwBKhGzZuMDAIvuIBq2+Qltkj7NEwH/IgaN4OyPKyMUoVsr9Sb/7mAzdirnuOvWza
 6xMpoDi8Ns82othRhTs3eFrJLsmdAbI6Ujynm3kLCQpkRkHwTqlscoPa8FcZ8nRZBIzopmUSB
 KIQoG2XDxuFSt76m0z+A==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--a7LprRWcEyyu7lHPyqOvQSwLyDcwOxdje
Content-Type: multipart/mixed; boundary="DQ2hMTLSIUfLG8jCxeVBXLQzvnOLJeWXW"

--DQ2hMTLSIUfLG8jCxeVBXLQzvnOLJeWXW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:50, Josef Bacik wrote:
> We can already deal with errors appropriately from do_relocation, simpl=
y
> handle any errors that come from changing the refs at this point
> cleanly.  We have to abort the transaction if we fail here as we've
> modified metadata at this point.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/relocation.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index ef33b89e352e..3159f6517588 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2433,10 +2433,11 @@ static int do_relocation(struct btrfs_trans_han=
dle *trans,
>  			btrfs_init_tree_ref(&ref, node->level,
>  					    btrfs_header_owner(upper->eb));
>  			ret =3D btrfs_inc_extent_ref(trans, &ref);
> -			BUG_ON(ret);
> -
> -			ret =3D btrfs_drop_subtree(trans, root, eb, upper->eb);
> -			BUG_ON(ret);
> +			if (ret) {
> +				btrfs_abort_transaction(trans, ret);
> +				goto next;
> +			}
> +			btrfs_drop_subtree(trans, root, eb, upper->eb);

Wait for second. Now we don't handle the error for btrfs_drop_subtree()
completely?

Thanks,
Qu
>  		}
>  next:
>  		if (!upper->pending)
>=20


--DQ2hMTLSIUfLG8jCxeVBXLQzvnOLJeWXW--

--a7LprRWcEyyu7lHPyqOvQSwLyDcwOxdje
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/IdG8ACgkQwj2R86El
/qhObAf+PL4KVQKEub1wV5hBmbFtCW2ZIm4DPBoyHMWjHlZEk58o7+x5WBi0aviW
A5gwBha74K/8BysvRX4CLfGzsfdbTLxEyDwSwZ4pHcZGOje4P6mGQg1V4gwmfqet
c2k87Mm8m/GQdiKcm7ve68XMViZQ0WaHe7aIgMtjM0AKGTV6WnaucvUHIL1B68oQ
aI9t+8jKjk7wKa6f1/sNpXBs5dOEiCdb5CLRQ7sbKkq1da2g7tqcC/pyRcIrufL2
jNlALtb7+Ao25ctKmGBOnQVGmaPdaZdh1bMAR1t9eyotZEDPQ7j0hp8jor6VhaUZ
fF0l8hL6crK72FSCodX4B4e9vF/QHQ==
=KiQO
-----END PGP SIGNATURE-----

--a7LprRWcEyyu7lHPyqOvQSwLyDcwOxdje--
