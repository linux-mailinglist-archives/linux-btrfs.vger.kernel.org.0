Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D724C15BEE4
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 14:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbgBMNDZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 08:03:25 -0500
Received: from mout.gmx.net ([212.227.17.21]:40949 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729557AbgBMNDZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 08:03:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581599000;
        bh=bLWV7Hf18jIVG4QZ2LIPnsUrjZNw5qUPrzU3iaIfq5M=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=jABixWMfheuF5fVRGIZgwABh7Znhz3Q8infj4uh4c5siCCDWbgro9+TjOfGlfCxTK
         7LEbYawxoz1buWpPgfso7hfWBqAL1jdxwGx1RJqvk8vPS2TlIOJJuFHUSzidiZMe8/
         g6j0HdQ61HpD54P79aJByEcOTZeyPeZnQPxr1QWA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvK0X-1jJcTW49uj-00rHqx; Thu, 13
 Feb 2020 14:03:20 +0100
Subject: Re: [PATCH] Btrfs: fix btrfs_wait_ordered_range() so that it waits
 for all ordered extents
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200213122950.12115-1-fdmanana@kernel.org>
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
Message-ID: <24d22c13-b799-c6eb-729f-81f3d8423cf8@gmx.com>
Date:   Thu, 13 Feb 2020 21:03:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200213122950.12115-1-fdmanana@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gbQPHpYmlmpnX40iTc98GNBhcWk4GxkXX"
X-Provags-ID: V03:K1:NmyENOHTVVzxINVJeTHwKi69kAtnTwcv+sMKu/RbF2iIp50AsgT
 l4LK6XubDlNd6NZmBVXYig8i8bfg6vU3ykgCkbBWJO2FcePUWVNM1NWIrctm+HDD5QJ6Shu
 D99OY8Wy5Bb0kNNOCJkd5CAbggk1azujPg1LgiwAwN8+RvZYYECAv0IqlcXdPbv50iPqbzy
 n2xMk7TlAwQP9NJch8jKQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Anix9bKfc0M=:nEXKlU7AMtG7DIV/RDEMfE
 ep7FPRLer27k0Ke5CwS9RhyNOiHUwGSJs+fyMvXX/UC9KyjtpNRLI7++9epqKYHMpnJAe1Tkb
 Us6xxI/ZDgLPflaGyF6yjN+3Lgzs2/iPIjROfaO8dmD0t2tAuD8NeONicQM/OUPOl6w0QhF9I
 KvtZcknZBcJtBeN1aHRrbYLMLB08M65ijxfv1g2wnNbyl1jqT2u0zgwFStMPH3loMFfevg6Xp
 T3m+ALQmH42lONvTmNmeTdV5Gn5ySRZ5iTK3oEoGzyO3k42c5JN9NaW/3nVsWmDv7EGSYBomz
 eiUwXUJGjUZzlTY9xRNZK9oIR8yovoGhPH9KnbtVN5KdVE/CftqGRCVAbomWU1XeM7xaL32wn
 NnnkC5ufKDBvgC8Io8fZxtG6NGSAjOrdQVzl7jPmXaBhDGnQiffsOdI7n0/BouVflbLBssBRP
 fda+2464x0IdD+ujbHSsj46jjlPxVyVZ+FZdCAd4BNxLeAOoyTxZFOg9MhLmGE41bigJy19gk
 otBFWBEGBTb1I//bLt3y7HEpbBjIPsDAPjtxHEjizIao4kH9aRtWvt03xI7szrraJ+7xRhlu0
 Jpq1g/FjmIPbGtSth0Rpafl2xGt591otoX9N9bv+7cv+IyMQqylpA7rTFwO8smEJrBD1YO5a6
 LXtaYBJkOQk+2VEzVJ0xg4YVHrAUxdNUessGGGWwS9I7Jep5HHIAgtcYnN5X92FJtu4XgKkPE
 N9nJcrAoWCA2R95bYjGu1XxaiXHxDGaaQ3eRL4gkX8rzo4UOZ60Y1U0Epb4i5P7FuOnIfnI+T
 E827SdBxwgWsWVEsFVXW+CA08ki9F1HvGAi4Mx5fPjSbyyDqkKDNtOtqdJhk5nhgjOfkrbCys
 3Fq1BSzLgfFoE+bjda6GZbsNJndPXvjiU0q7+6lw9zUNJ80StmHHdzQngte6xWOU3IJl8u6Ny
 9jpE+oLCjsjbbGv3YuF1znFAlHkrzFZ6/1Tm9UjJDg6jJU++DDxzT4vdWhmVgUbLx2GmeIy1R
 oV3fSX1TeLhqRe5UmdGwMPNQjUVDDxmyYykVUH1Y3PPsI3LCtNlLvE647BaYeBrgC142GYCT7
 4EAu/ceTLVTYbEwrmT30ygs8Axzt7MvV3tgRe8JJhTr9cNUqaC6CBTfhfGCW2OfgS3vlFyYWQ
 OPWZ+Ux4FNOnw64ZAZTvrco1PnXCNJFWjBVquMwta4yYRC8IXed4M1g8wpGcz4rQX3GjyLpTt
 U7Pcw0uQ7xAe+ARiY
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gbQPHpYmlmpnX40iTc98GNBhcWk4GxkXX
Content-Type: multipart/mixed; boundary="xhC4XAL36LkYQB66oXMCFQqweeKnoHBM4"

--xhC4XAL36LkYQB66oXMCFQqweeKnoHBM4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/13 =E4=B8=8B=E5=8D=888:29, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> In btrfs_wait_ordered_range() once we find an ordered extent that has
> finished with an error we exit the loop and don't wait for any other
> ordered extents that might be still in progress.
>=20
> All the users of btrfs_wait_ordered_range() expect that there are no mo=
re
> ordered extents in progress after that function returns. So past fixes
> such like the ones from the two following commits:
>=20
>   ff612ba7849964 ("btrfs: fix panic during relocation after ENOSPC befo=
re
>                    writeback happens")
>=20
>   28aeeac1dd3080 ("Btrfs: fix panic when starting bg cache writeout aft=
er
>                    IO error")
>=20
> don't work when there are multiple ordered extents in the range.
>=20
> Fix that by making btrfs_wait_ordered_range() wait for all ordered exte=
nts
> even after it finds one that had an error.
>=20
> Link: https://github.com/kdave/btrfs-progs/issues/228#issuecomment-5697=
77554
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/ordered-data.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 4cbb4e082800..ab3711328e7d 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -686,10 +686,15 @@ int btrfs_wait_ordered_range(struct inode *inode,=
 u64 start, u64 len)
>  		}
>  		btrfs_start_ordered_extent(inode, ordered, 1);
>  		end =3D ordered->file_offset;
> +		/*
> +		 * If the ordered extent had an error save the error but don't
> +		 * exit without waiting first for all other ordered extents in
> +		 * the range to complete.
> +		 */
>  		if (test_bit(BTRFS_ORDERED_IOERR, &ordered->flags))
>  			ret =3D -EIO;
>  		btrfs_put_ordered_extent(ordered);
> -		if (ret || end =3D=3D 0 || end =3D=3D start)
> +		if (end =3D=3D 0 || end =3D=3D start)
>  			break;
>  		end--;
>  	}
>=20


--xhC4XAL36LkYQB66oXMCFQqweeKnoHBM4--

--gbQPHpYmlmpnX40iTc98GNBhcWk4GxkXX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5FSRQACgkQwj2R86El
/qgXYAf/ZN9KFFX56WiuRlaUE2Y01O2+TTGA4o6SlJuccpTLndWU2DObcGg1rcXp
DJstH7n/nUJ5UahpbPokHy2MiRKgq9koBbAo/swLx23WqEpA9gHF/b+AF0c8xCqD
NzIbjqRaGEz6vz62HxFeTprSSX937OWLiKYRw4PEL3S+jKWQ/sTfAzrflYmVu5jd
sJdZRDToFZ3LzSfcKZIY9PkiN5HleiW6OmMQZXkieB0uzfKT+/5mbVSyvNRXUs1v
JFXDVVKE4zWYltv1Rd4e6PBVRP0a21ggPxdERdo3kkmmJX6tWAolu7Yt/M8jl7PU
BTunOqgmaA2tqnChTFo0rhhJMNkc3A==
=HU94
-----END PGP SIGNATURE-----

--gbQPHpYmlmpnX40iTc98GNBhcWk4GxkXX--
