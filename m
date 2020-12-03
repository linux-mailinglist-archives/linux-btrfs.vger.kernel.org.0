Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032EA2CCE5B
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 06:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgLCFMn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 00:12:43 -0500
Received: from mout.gmx.net ([212.227.15.19]:44381 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgLCFMm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Dec 2020 00:12:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606972266;
        bh=zQ+xS1PFhGeuYjAfg28WhZHawDVkfKHXm0HIxHZ4PBo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=AtKEffx5kXjcZwVUPH1d9XLYjdaW9euv0ysYKPfgUEayZofaNsIBr1X5xkmydNlaq
         Ulk5xjgY5DXRnp71tImWKlewkoW5aEFjW5Tl3hm0j3897akP3HcvKXgrWDOtgxScOr
         HkHPbL2ylYY0jweUWuuOF24ydpHJNlbwOAyQYGkI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MQMyZ-1kXgBk34QD-00MOlA; Thu, 03
 Dec 2020 06:11:06 +0100
Subject: Re: [PATCH v3 38/54] btrfs: handle the loop btrfs_cow_block error in
 replace_path
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <ccb1551a8d087aa2d6ac7cf9100a0034172a645a.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <729cb9c0-602e-c3e2-bba1-ab64874048c0@gmx.com>
Date:   Thu, 3 Dec 2020 13:11:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <ccb1551a8d087aa2d6ac7cf9100a0034172a645a.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="i6iEAtS4Dx0Pl1FlQktAE3rEq2uBq29sd"
X-Provags-ID: V03:K1:qWXpkCQmlf2juZ9lUw4LQvR2icRDoM/DVn3krEzDF39W715OBoe
 gwoS29W5819MCfVrnyHcVZ3PoSlXzy8n7RqNL2IviHW9rwDP4MZO2YcKQon0OBvc3sEtQML
 RRWMnx8oD1eFNDXo8RsLsgZV/xT/e710N2cwvRPT5iffDaEkuEuWfJaOqOJWvjQU99Py/Ql
 MP+l2VjqZvCIF6GmrIGZg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Uso456tQ8FM=:+u8L/iWCQpV8Rsen79ZgB3
 vEIlELmnb7G9E51ZLHk4SFM4+iSESlPlX+Ibi2vH99IMUth0ZmkV7pAKpovlKxSnO6svYMR83
 rjHzC+XePnUo7EL3InJPKMsNPhL3GhnFnHdma/RxPD2wM6MO4NFWRKW+IYce+q0YpglERJAOk
 oZeSEmIOjZVhxnTKZzAPczkPXh3r1HjiHWFERpeU1bpSfsWT3QNw6E7zN0m+BSi66nzsgk317
 zcd5sMqsoNxRxS30HlsXYZckI3NOWCbKoUXNYEzXePynv4wF9m3Bi/MmO1ArPBdoa0Wy0BgUR
 1QcpUyJyu9WDz2EEPXQOGCj3AzQzej7jyJA6pt1tJhRaqJA+UuDL6BwEDq0TPbwpdfFkPahLY
 LY5iJYVk2iSIB2Dk9+IBB5PL5rDiSn1GLAfyL8FGkJV+gtKqACIEYc+BPhuCY5Wp+Dp2Edpax
 m9KW4OUs9zax/NxvPEB2FGAhp3wiAtJsIBmD7Ga7gGifPiiQi78HvPfML/RnBOvrueNKuk0RW
 8yDlJ6Z5rjcNlzp0ZZTTh0JhHwYgILkLY7BRnizmEONRj02nbyQNN/q4WHFDAAlATC0BoENtQ
 VO5Jr2uNFLyeDidDvBB7Zu+R6amvxKUn4l2njYt3sLA1djlfDIVNbSDRsRMOmBa52VJzGHy6A
 V8Lurlr8ldH0IvE+LL14iWDXZKiT5S42FGCmY6/vlArAaMM1++J3PjxtRa3Yb0K9qlnkH5tru
 4uV02ABUZ8qEzLtrFHy/TmZAU1TCWO8ofMxA7KOMUYeOGRSrAfqKvTeTLcB2jTERuKXSskwOY
 K0A48hS44LgRqAUsa10FgWkZjopRqt85ZVOT98RdBk22jRqgA7h84C7pkkcE1sotioCjNx7XG
 bJ8gHt0a6ZWv4GNDynhg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i6iEAtS4Dx0Pl1FlQktAE3rEq2uBq29sd
Content-Type: multipart/mixed; boundary="277WQhL1jE8RbEVjgph7BzlomIfUWpPcr"

--277WQhL1jE8RbEVjgph7BzlomIfUWpPcr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:50, Josef Bacik wrote:
> As we loop through the path to replace it, we will have to cow each nod=
e
> we hit on the path down to the lowest_level.  If this fails we simply
> unlock and free the block and break from the loop.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

There are two btrfs_cow_block() calls in replace_path().
It would be better to handle them in the same patch.

Thanks,
Qu
> ---
>  fs/btrfs/relocation.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 52d6e7ab4265..781908f3a3af 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1286,7 +1286,11 @@ int replace_path(struct btrfs_trans_handle *tran=
s, struct reloc_control *rc,
>  				ret =3D btrfs_cow_block(trans, dest, eb, parent,
>  						      slot, &eb,
>  						      BTRFS_NESTING_COW);
> -				BUG_ON(ret);
> +				if (ret) {
> +					btrfs_tree_unlock(eb);
> +					free_extent_buffer(eb);
> +					break;
> +				}
>  			}
> =20
>  			btrfs_tree_unlock(parent);
>=20


--277WQhL1jE8RbEVjgph7BzlomIfUWpPcr--

--i6iEAtS4Dx0Pl1FlQktAE3rEq2uBq29sd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/Ic2YACgkQwj2R86El
/qhfQgf+INwSpGfSO/KCWYU2iqoDzlejb8h9Ue6jncL/3j93vrqDEK0L9X5Qy4vO
iywnvqVO/vVo26GSqhJMhBwixnPl32T+uQATCkciQHEB7OMdltctQtZlkQo2umwv
P7PDCeeOb119ABGynkSd2P6M1Kc5wn49t4vUOx1tfS3T63DglwpwtgKZVIy3VCkF
disaICzqLFo4YYytqIXlw0vdYvKTagceLlpzUqnR23+USGwuj3YsngDWpY9K0Yn9
9AGuwrA8lIXktoK3ue1Tq3oScR+7K+A16tl9bvK5KhZqdDTnnmrNVoirErlTcLZT
2d2v1LEfNX8a/JKANTZ2nL5/0NP4lw==
=xUVX
-----END PGP SIGNATURE-----

--i6iEAtS4Dx0Pl1FlQktAE3rEq2uBq29sd--
