Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C3C2B1457
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 03:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbgKMCjW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 21:39:22 -0500
Received: from mout.gmx.net ([212.227.15.19]:44649 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgKMCjV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 21:39:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605235154;
        bh=57PFy9jqCSmNj2Z7eF2tL6wvVwzAXXK3cIgfUFWwpz0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AaAj9mqtbFG8F1yps0AtrZ0rfV6wdlUOxXW2p6WJKbL+WgbZxX5898MFlhiX/ox8R
         IAWLwwAoPywz/RKl8VgQisBiYmIF2xgEeIZOlCnBZF2DtO3G3qnjIEw3e9ey9VKWKr
         xeh4xqGfzgDreJHo4PXW/z7ubLfWnXxvmmLdPI5w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mjj8D-1jtJkI2xWF-00lIHH; Fri, 13
 Nov 2020 03:39:14 +0100
Subject: Re: [PATCH] btrfs: tree-checker: Error out if invalid btrfs_root_item
 size found
To:     Daniel Xu <dxu@dxuuu.xyz>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
References: <0e869ff2f4ace0acb4bcfcd9a6fcf95d95b1d85a.1605232441.git.dxu@dxuuu.xyz>
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
Message-ID: <247fae65-6e8b-6a99-03a0-535e25b5b570@gmx.com>
Date:   Fri, 13 Nov 2020 10:39:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <0e869ff2f4ace0acb4bcfcd9a6fcf95d95b1d85a.1605232441.git.dxu@dxuuu.xyz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IMPfTEBIuArXS6nMjouQJWeBzZkdnCq3b"
X-Provags-ID: V03:K1:Ikg4uTpm/8qCmd+8JeYLrOxDDL5o/MletpXYZSye/mSZEzfWFWb
 fd27RSCPaRw4Fax8/T5Gw3K3UC+HfY+4ZD9O+loeUWdMV5v2cotXj+s5uA/r5hG1kPIlX0E
 vYSh4rTztUy6ZaFwmugVbfNaEjiUXP1PYDs/lXOZg7Lh/yRIC1uaoS57KB8X4ipmHeOrTvI
 7Rn0mBgmpYWbLJxBdnTEw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oRRW6cW9egM=:foG90H+gjh/9jBb2nD1brS
 HkDtjFpqTa6tK/NyDIsvjJ+TedKvEwH0bc/JnfTr6+761zgO8tfAV2B5EqtOFshjOBaLkBrJ4
 563n4rnrmdFuUORLxl0JfR+dVDHT66PSS83uK2/aCV3Vl2wzTBNzeIY/bgoz5Y1nsJll653ke
 mSCKax+crdKCOSPo8dKaPbsZ9nqMA/8WIjn3E7goNj7b9E0Y1V9y1Qn/7eepUNuet0PLiuZNm
 Q3ER2AUH/QTv0gsDGI821lL+RWfhHY5AR91yHK7dHjiWoYVZvtwr8JuHTc6kphkHg0Z+mkf18
 cGnhL/b7b/fBNRVeFXT1gG+W8Hr/agp+/AYKQrkXRQ66V/bTQBRdi86JikuAPZ6P7lYkGXKa8
 cA8+Ut2pAvNpjbioWmIR+rpD5JE8RRviah1lpDD1AoLxFXliqsNBSHp5AejY0GI9HJPt9oBfN
 IxcEhn0EwBFVBD1uzU/RV84jUgKScA8gRG4xlIQVP3FXkFALFCdHqwinldR8RqiQnNBbyADqE
 PWQHEngYOTXfW0ERlChS798Ux1V6Ch4KBBWbj6LJ+nZjAPjo4gV97ZkXbUvvsZSYVVI8qFPo8
 fSvNMxCCp8vVzaDjxiXc2SipjVICsaC08WvQ3NBUMyjbn1DB5A97U7OHBFQ3N226vKiJK3kKA
 NvakhmvjO7eC/BR1EcFr2aevdI0ZfmE0p/bfcS6jEAS9AMFPMcDBeZn8TjuLDfUsvBc6ZpDlT
 kRxy3ayBWt6UBbYLxRPhq89rQ4omqc+VOIW9EfdAFJg3eC05VwAwX5Q/GK4u3NBEL/+whY4NQ
 2h6pEuHNpMXGApanXJfjtkSXnNMuKV8qK3MOr3DJWeORHDD2I+pZ09c7ZQu8JvbhPgL3NGFaK
 l36HLgmLIy0leFgh6yAQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IMPfTEBIuArXS6nMjouQJWeBzZkdnCq3b
Content-Type: multipart/mixed; boundary="ROe5Phx0BoXTV83Qocq88Rk4QqGEryf98"

--ROe5Phx0BoXTV83Qocq88Rk4QqGEryf98
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/13 =E4=B8=8A=E5=8D=889:55, Daniel Xu wrote:
> There was a proper error check but it failed to error out. This can
> cause stack scribbling against a crafted iamge.
>=20
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D210181
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Can't believe I just forgot that...

Thanks,
Qu

> ---
>  fs/btrfs/tree-checker.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 8784b74f5232..6cefabd27209 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -1068,6 +1068,7 @@ static int check_root_item(struct extent_buffer *=
leaf, struct btrfs_key *key,
>  			    "invalid root item size, have %u expect %zu or %u",
>  			    btrfs_item_size_nr(leaf, slot), sizeof(ri),
>  			    btrfs_legacy_root_item_size());
> +		return -EUCLEAN;
>  	}
> =20
>  	/*
>=20


--ROe5Phx0BoXTV83Qocq88Rk4QqGEryf98--

--IMPfTEBIuArXS6nMjouQJWeBzZkdnCq3b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+t8c4ACgkQwj2R86El
/qiSuQf/Ys1uxYeipMCLD8RE7a7tUkITd+nYAR0N6vBPhFojAVl5Bw61Jg+oSHuP
/i4eioocyoMQ+0MTLXyrxR/FVrpx0gf7B9yRvtCptaFn1i6VMTvh1oXoHbof3/gs
Y4SXgFpK5v9auwPC9twFGrj4cXZum3UG4x6jHkpm48kCVI3Rm0cY83WSvdemXOzM
bXq7dxoYf/11yT6s1Dk9XQQIdwU1FL42i7rHWNn4j4tNt84g2TDfnXPXo5ZzXd/B
XcyKKCEMJhmZyz33Hl/PdLZ2/5+HZ4g8hr5m6ZstX2XvnQqIjsmsreuI64jgnVus
E7JjDxLiu4A8ohuKIYEOkKbYKGa/HQ==
=pY1U
-----END PGP SIGNATURE-----

--IMPfTEBIuArXS6nMjouQJWeBzZkdnCq3b--
