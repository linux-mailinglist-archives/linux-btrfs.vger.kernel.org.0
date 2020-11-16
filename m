Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2982B5552
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Nov 2020 00:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbgKPXpf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Nov 2020 18:45:35 -0500
Received: from mout.gmx.net ([212.227.15.18]:35713 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgKPXpf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Nov 2020 18:45:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605570329;
        bh=hURP4/NDjSGY/6TrDP9R8f55AyB96R0gpvdXfYCR4eo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=I4gRSOx0zd4hM//f1TROpy2ozcsHKGrQmuckzwZ3S1PUbA5+oYbPQdizyi85M5CQ5
         95HzoUPoS/jC5zTLHMHJEm97lxhjfwZDPdou5eFDT3ZFSEinPeztCTV+SHCn6nq7wv
         l/oPa8Sog6div//xRv+q7YW7aXQXab7eKSe2g+eQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M1HZo-1kgRoQ3op0-002kUb; Tue, 17
 Nov 2020 00:45:29 +0100
Subject: Re: [PATCH RFC] btrfs: tree-checker: missing returns after data_ref
 alignment checks
To:     dsterba@suse.cz, wqu@suse.com, linux-btrfs@vger.kernel.org
References: <20201116190113.GT6756@twin.jikos.cz>
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
Message-ID: <3f687422-bacf-40cd-bfef-bafb771ac913@gmx.com>
Date:   Tue, 17 Nov 2020 07:45:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201116190113.GT6756@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4F2BxufmwTDl4XzmbbbOgUstn3AI0eQ3a"
X-Provags-ID: V03:K1:P6EpXTrp+sK3jL/M3hy5bOESGeFMhoy3u1rKHLV3Mx7JAJvnI1N
 vWNFgpOGEU4CbttQx/Q6r/k1aqxtUrNveRdAq/cKJLFF0WXaLxe2XLwEXoFoIL7OYCbDic4
 i7fECpVqvhmenkwz6zmnj4qPAag6sGKhL64lrZciIxz3UpT8JkHh0fOzx1D900k7HIKdKG+
 hLSYEPLWEQc18XkrVyxyA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sx7qdHJjUeU=:22DK9JiF8wIjdZFnJuh3V8
 JxTamyfT24VK8FmZva/13aGF0ZtwrynbmM7+nR9ijXGtjUAld8BJtreyDEivhJ0tEZEzN4PIk
 WuXZBhNZZ0HO4CHcl88qOG1Uof8YDnj1maX/ebF4YGYa6U91w7fu6rsWpHbUBmWu00/K/tcWf
 OfYorn+0YfbmdvC3uTaQC0fxCIsyuqTvfMwfPqDXr+9W+334ybv0BFxLqX4W7KYIpS07s6zFn
 ooX8tmXOojx4a15f7KmqxDk2UibeTo3xgyEeq9aZApPF6O0FEqdeUcOk33z8pVzoMtAQYeQ3g
 B+iHWFaZoSfhGHdhKetrizqPBONq2Q6FWD4Rr+8fdWiqGLqADpGWM9bQfvPBWZqnrL2Ehvh/s
 wjffN8EXm0jqcwFZM2ruR+ob5nRD6VN4qviTODWNMalb3fDie6kgbXBVOpIpe/jreXGfmDYEh
 Vj1fign9KWvRcUrz/0MfI30zPWxR8NGw6l4qEfSkTogL7tX7zRU232PQoCbKxoieTluvUlnfA
 hdYXQCnu3Z4aQDqjM8CMAN5i+J/rfFuB+IiuDlXAiAJElTr0Sd9TKeGDMWlDtaBhB53elDCMa
 MWIbpbekEF28nQ6Vc1W4xkABMXsVJoTYF38Aq7hwnyeuiQ6EKoHDe1ytC3oQBLhVjetag5Rx8
 Zs8sQk5ssied6CsDy2UIREuRkmnkO/j2SVNuQhgpWOwlz4iUZolwbk6VFPHnQMlFyhIYq2Pvh
 1tdntKvMN0E5nt+MJHakl0hzjVPLkCMg0BLsaCQMEovSsiyZf62VGFAqVPSBJ8C1lrj7I+NMx
 FmRg1b4+DEdoGlg6RLbmxdlnzLChDnxBhkyK7E8Ogf9bXUSOW0w+ezoaDUjLNlPPMsz9AFGT8
 YVM2AsZdLrpQKGOcN2Aw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4F2BxufmwTDl4XzmbbbOgUstn3AI0eQ3a
Content-Type: multipart/mixed; boundary="yGrkUdbFmDacsBHNsnnT5ioqRO7GI0gP7"

--yGrkUdbFmDacsBHNsnnT5ioqRO7GI0gP7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/17 =E4=B8=8A=E5=8D=883:01, David Sterba wrote:
> Hi Qu,
>=20
> I've found more missing return satetments in tree-checker but I'm not
> sure if leaving them out was intentional. Both are for extent data_ref
> item alignment checks. It could be that alignment is not a hard problem=
,
> tough it could point to one, there's a check of the hash vs key->offset=

> that would catch inconsistent data.

All my bad.

The case is, alignment is the first sign of corruption.
So if alignment is incorrect, there is no need to continue.

So yeah, I forgot more return lines.
>=20
> As there's only one statement after if, this looks like it was
> forgotten, but otherwise needs a comment why the returns are not there
> given that the rest of the file follows the same pattern
> "if / extent_err/ return -EUCLEAN".
>=20
> ---
>  fs/btrfs/tree-checker.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 1b27242a9c0b..f3f666b343ef 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -1424,6 +1424,7 @@ static int check_extent_data_ref(struct extent_bu=
ffer *leaf,
>  	"invalid item size, have %u expect aligned to %zu for key type %u",
>  			    btrfs_item_size_nr(leaf, slot),
>  			    sizeof(*dref), key->type);
> +		return -EUCLEAN;

For EXTENT_DATA_REF_KEY, it should only contains one or more
btrfs_extent_data_ref, thus the alignment is a hard requirement.

Thus the return is needed.
>  	}
>  	if (!IS_ALIGNED(key->objectid, leaf->fs_info->sectorsize)) {
>  		generic_err(leaf, slot,
> @@ -1452,6 +1453,7 @@ static int check_extent_data_ref(struct extent_bu=
ffer *leaf,
>  			extent_err(leaf, slot,
>  	"invalid extent data backref offset, have %llu expect aligned to %u",=

>  				   offset, leaf->fs_info->sectorsize);
> +			return -EUCLEAN;

Basic sector size alignment requirement.
So yet another missing return.

Thanks,
Qu
>  		}
>  	}
>  	return 0;
>=20


--yGrkUdbFmDacsBHNsnnT5ioqRO7GI0gP7--

--4F2BxufmwTDl4XzmbbbOgUstn3AI0eQ3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+zDxUACgkQwj2R86El
/qhyRQf+PZedt3rWQhOSZ7zkwD+Ncm6TiFtqKwekBNjcyxTSgbbkPW88QGefW0ie
7CabQGxEjXI6vXn1qGa+zv2/4BtEqmH/t90x4U6ZQq1DPpaKRx2StV0vijsJsy7I
XwUUGyQDumnJCc+5YzS5WfAACikb+9SDzGME9TUGH2hsfBbWNo8Hq8GXNSKIRUW5
S8iIHQSLrQ3fG3y4Mb87qx7gPjnsqwturR+iOGmk6WAWedARzhGHibi/tk7kUHZj
WoIBB29sVMAFnp2+LDlmiyL0xuJl/jzHAk/Q7nFzgwqQwTMgK8/19XryM+PYX0O1
sg7EIRjBk1B+3gwNVeyhVITgYPnB8Q==
=kdrX
-----END PGP SIGNATURE-----

--4F2BxufmwTDl4XzmbbbOgUstn3AI0eQ3a--
