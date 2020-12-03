Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F262CCE44
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 06:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgLCFHc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 00:07:32 -0500
Received: from mout.gmx.net ([212.227.17.22]:60969 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgLCFHc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Dec 2020 00:07:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606971956;
        bh=MYYjtEz3+PDkpNxCzqqkXSGDkq1Es7Cr7a/D0JrM/ZA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=LygNinaIPebmOviRhGDvdFs/3t7Qk6YnSa1O9jr3CUhBEwOADun5NSkt6tHXiLk/r
         jLKJPZhV7697PUiBStiSWW+nhekvxrk5bF+u/+xU//wOG6iyrHAcx0goraUgTgItCC
         3PSreLmiyprwyH+JpA1a+zC3tOxU/JKblsy5VsMI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhU5b-1kGpu440e3-00ee0Q; Thu, 03
 Dec 2020 06:05:56 +0100
Subject: Re: [PATCH v3 37/54] btrfs: handle initial btrfs_cow_block error in
 replace_path
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <6b80c4787250be970ff8bb1c1f261492cafba7df.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <a94cdd26-09bc-ceaf-7655-0f9a6963445a@gmx.com>
Date:   Thu, 3 Dec 2020 13:05:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <6b80c4787250be970ff8bb1c1f261492cafba7df.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="COQiu7d0LePIRutXTCrnoXhpghzttgBDq"
X-Provags-ID: V03:K1:vKBaFig0ZNGomT8CW2RoQt6/atd3ViKUdA8EdjIcDYFIViXbdsS
 ylm5c6hmqa0j9xUrsTNFFC2daogLxseYXy6mCUPHI8zIYa6jIX65LpERfN86vE8pwNUyA18
 tYaIUmTwB0WISiL1Lk8CpbgxywEcncckkgQp64+6o3xLQulKEgbvqh3D0IFVdxrBOufioc6
 dv9N+UoxIAjhp5uDacaPg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CRhnh+Mud9Q=:d5yXr0YUyWexB4EeHoAgSE
 sfnRD2V4Qs8K4kwPvXIWhDpW0eLOm+2y6trjXLIh2F7BMe7u/b0eB//IDrwxhd1mplrHESYab
 0fQO8RAZ0w0lxsLCzvrHX2IaDxItcZzce/uEGzvNDlmV2fqJ15JS1nntkPZTSx12z4YfdbUKD
 g170MQMXS5jj4S08BDsh5lDSvQE3LSUVWVC/JlFtgXlfBOQVJGocfLRtvOQcqt9TIZ4bPQiFW
 /sUM50m1UoyPjqGEC1V88UilFbuj/FfAn1gv1VTdBO+rdSWx0nNMDdDVMeB6YaYLtPfodRlaE
 de3Lt3QtcnzhXMB5VMQX14Z+70M0VEc2tZ7rrXrue0T1MXnHxAkwp6sV4OKakITCiSMRXLJ87
 hTwfKMt1HgrDuU4c2nXf2xO30EgxdbqZxvOXQ5iXHmkmO2MH2gR1medHjVK/ji9gN6QvFVYWW
 E2icElIFCy2DjAgxCSw9e4aYpgDABfOPpDv2lgddbskdNSCznmhsHZ3bIrqIPP0bhv4l/lEXw
 5bSJHKJk90VWMu5OjsdV6Sql/WZW/Q/1cCYag+g1exOTEsKO7AyKQfgcokU02fOcRX7DPhGYs
 tgf5e4VoFeN6D/zY5f4MjW5nv75/zMURSsvGhqgjoXBaS/DPTBpcYooRE1XlSQ9m/1hFifAtn
 Tzt88DjLwG2mMH0QYwGqEr7Wmhr1jfZ7TNJ+YKQCEH0yS+2xhWN6QpJ+gVr0x92tMW2UKt/s/
 rVSiJfW5Xn+NO6657RPDRrA6MNCYBkkVpL5KQgaytHNBONdMiIU+KlB79umCAXfI1tDcEfIfW
 o1v0LL7nHKdHw+zNZs1k1NsqwLAcWCKUH2DqjY8aXMX4R2FDyk2weMkpSAXUnL174K8DwlHjS
 HoPKZvN7J8F//z5J7YZw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--COQiu7d0LePIRutXTCrnoXhpghzttgBDq
Content-Type: multipart/mixed; boundary="XvLMnrAb2BtW2AzlJRWwClej15mbbvx8u"

--XvLMnrAb2BtW2AzlJRWwClej15mbbvx8u
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:50, Josef Bacik wrote:
> If we error out cow'ing the root node when doing a replace_path then we=

> simply unlock and free the buffer and return the error.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

One unrelated thing inlined below.
> ---
>  fs/btrfs/relocation.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index b872a64de8bb..52d6e7ab4265 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1222,7 +1222,11 @@ int replace_path(struct btrfs_trans_handle *tran=
s, struct reloc_control *rc,
>  	if (cow) {
>  		ret =3D btrfs_cow_block(trans, dest, eb, NULL, 0, &eb,
>  				      BTRFS_NESTING_COW);

Is it only me that such btrfs_cow_block() call using eb and source and
again eb as dest looks pretty strange?

Although I have seen a lot of callers in ctree.c doing the same thing,
in fact, ALL btrfs_cow_block() calls uses the same eb for its source and
dest.

Either it means we can remove one parameter of btrfs_cow_block() or it's
really confusing and we should avoid such use case.

Anyway, it would be another patch.

Thanks,
Qu

> -		BUG_ON(ret);
> +		if (ret) {
> +			btrfs_tree_unlock(eb);
> +			free_extent_buffer(eb);
> +			return ret;
> +		}
>  	}
> =20
>  	if (next_key) {
>=20


--XvLMnrAb2BtW2AzlJRWwClej15mbbvx8u--

--COQiu7d0LePIRutXTCrnoXhpghzttgBDq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/IcjAACgkQwj2R86El
/qjOVQf6A2tzQTVnZ6oXC7aImVMCpte9iYlFIOHtCB+mil/ZnLJVv+GbPcMNgQg7
2xbfZZBgp6R0AxkmgzqHzewQBZLtyZYXgT2TAY7/nG/glSTTYKZ5K6HhzufHRFqv
tAcJuZbRST348MXk5ssuxgs0M68IG10CDePnYAgsC3Ym6i657c3rfhZk+QhMAahL
NbeJCOC6IgoUkjrwp8pMDB7eOBh8feRqz6Vwk1mdTj9ZWwo3AtsnG/R7jiK16Mwc
E7FjI6BsPd6uawlWpXbQ5+Tlyek9Zj03hNjzo653s8LkdD1fjM3ZngbHIDkF62Uk
daSh/JeuoEuYNMbTYgymY4SrlLEiOA==
=5slC
-----END PGP SIGNATURE-----

--COQiu7d0LePIRutXTCrnoXhpghzttgBDq--
