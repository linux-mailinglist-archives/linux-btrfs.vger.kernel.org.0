Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C72253A69
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Aug 2020 00:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgHZWzq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 18:55:46 -0400
Received: from mout.gmx.net ([212.227.15.15]:39737 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbgHZWzp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 18:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598482528;
        bh=X3SA/KmCASOudF/OdAXjvSgSTsKuEJr/lPKZI6rFxSk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Ph5qVxPsA+ZkHFjF1+yllo7dWJXZ8r5L6ngPv7mulM01BKIk+RGZMz8MxodTA2SOc
         R164SqR6Td/TR59LW6h21HlD6yMz2tbY9ub2wPgNaovxrDTgwAILd976D8RSyN6mDY
         hZalmqLIASAKcRF+ZcXB8ZA1H6LYFEXBsy/EGsU4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N7zBR-1kfN7c3SZX-014z2n; Thu, 27
 Aug 2020 00:55:28 +0200
Subject: Re: [PATCH] btrfs-progs: convert: Make ASSERT not truncate
 cctx.total_bytes value
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>, dsterba@suse.com,
        wqu@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200826180820.31695-1-marcos@mpdesouza.com>
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
Message-ID: <002b4b76-43b0-e8ca-3d3e-f7ceb2619baf@gmx.com>
Date:   Thu, 27 Aug 2020 06:55:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826180820.31695-1-marcos@mpdesouza.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2Q9gD48mZwUJh2i4XczvdNGHkmvtO9AFW"
X-Provags-ID: V03:K1:SM9I5xBqp3j0GnzfsjL9reZqionO0HRjCGMLE8TZRtIK9cJMPnw
 TRcARkAHtl5NFcAZJCq2aVn3VxAph2GOlS5hxAKrvEF9Qj9UiXa6U6AfoQUnjk99O0vlt1G
 0QIj8o/CcM/SHKjD3bf5vTF+blJXw4N8nwYXFp27DY2AMCou1PPyL4OXgxsbPlYbc4uWcmd
 Tvtq5/C2PJx7QsO5Su3fA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RsLkQkOTJAw=:eY9BBbE/ip+/4Q+jFFGew8
 hNOaksjs9I4jDCKQfORY9CgIhOUZhtaDS5M7sVv1T7zJ730ym60Ebn98DuNqHIWejT62VFKWI
 8kBHhd5YX45+H410UpOyno1WqoBTGo/fe8aiDJUgSUc5oXV7p2uryXlR/VN3QFhLfAwiY/r+b
 EO/gfSZfPNRLy6VV+RbBvQ3EDKQIT/QLCW6mvuVkkOJmzBCz+b6mye7PF4jFQGeCK5BOpB76T
 GO97gsWMz2hv9hB50O01TUV+tAU6aUe1B3AbZh9cDNFCbG17frX2/ItYsp+rtKeuMf4wlVhc7
 dABR5K7NS3Eg2i5mRC0uffesujCqXr93L0Pf8QNiORBsRsDJicX21tCFELKICE8YOj4YsVCC5
 cC3Waqa63iTv7zNu5xGqJp9blSjJoiWcZeAhGTHUTYhQ7YcrtPtne3pXKG7vI7HkiXkxd/Tqa
 GQBS5jy1zWRr5PqBPi2Hjp7y5s75LD6PuNT0Mi8mpHuEjGqV9+7968jrDwqFoRbwdH/KR0+wC
 ivurBs3CXyXhV5cO1inLS3tvFCjPQoCGWbas6hnb6hbkKNOQ9A/0Pr+gZ1S5efpXlT6hMs494
 s1Tgd5O7AurSKL385UpuxASd+2SZya2TRgyst9zpYLxCb2qpW9mjj0Ha2P9L5qWkctYWUafOP
 NSDbbQ0AvQQ8OTE/9f22xiTF62d/biE6IP9cji+dZ2GpF4EvI17IE+5nvCw8VFrMmAm0q4tYG
 40aXfMCNvaQFWaUnW+3xfpkQDqOcTkpPaxEttu4x/HvPHiCVuLYRBP2WPP1OH2wiYIGXxcdm/
 CJ31H+VnJ26wkRL9+Xs5PvhrASTUzGfWOT2nabSdjTWqDu6J+Aio196aTqwnlYm8moKMloLHx
 g6HNdqhLAEux7fE446n8pwajAJi+TUNPoC8CLl1Nr6OHeNw1lFAE1lLfg9KmGC53w6rbSJ1Rr
 3VoQf1agV13sJa0JaVDVGPvd+fbcg4N7qvunyrieGDykGtaK2GmoHz6KHOQmKCEsbOuRZM8BT
 zWFqULyVhJCap+d/eSlpDsxz+QYJHE7bYjy64zwNnwSY5YT92FseIAgQhB+xiUPTZ3+afvF3E
 YVw6ZPkbHlChJyjS79b/bSTmjQtx6HxBWTTcOuP8DLANj4JzGyfjCap/ON7yvTS5GQeXaBJY8
 aop/W5W6us0jree+frDy/jJj1Et6TwiDIywHuAmrs7J4cfgZnNiNJkcIJFXviAr70LsjmHCTp
 646TUzoqpSQa3ZfSESo/q4IJQGKoruaWzQHhWGw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2Q9gD48mZwUJh2i4XczvdNGHkmvtO9AFW
Content-Type: multipart/mixed; boundary="A8hCPNR1eamWf4IhdYEYgF8NE6mqOAaap"

--A8hCPNR1eamWf4IhdYEYgF8NE6mqOAaap
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/27 =E4=B8=8A=E5=8D=882:08, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>=20
> Commit 670a19828ad ("btrfs-progs: convert: prevent 32bit overflow for
> cctx->total_bytes") added an assert to ensure that cctxx.total_bytes di=
d
> not overflow, but this ASSERT calls assert_trace, which expects a long
> value.

Oh, I forgot the type converting problem!

>=20
> By converting the u64 to long overflows in a 32bit machine, leading the=

> assert_trace to be triggered since cctx.total_bytes turns to zero.
>=20
> Fix this problem by comparing the cctx.total_bytes with zero when
> calling ASSERT.
>=20
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Awesome fix.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  convert/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/convert/main.c b/convert/main.c
> index 5f8f64c5..378fd61a 100644
> --- a/convert/main.c
> +++ b/convert/main.c
> @@ -1158,7 +1158,7 @@ static int do_convert(const char *devname, u32 co=
nvert_flags, u32 nodesize,
>  	if (ret)
>  		goto fail;
> =20
> -	ASSERT(cctx.total_bytes);
> +	ASSERT(cctx.total_bytes !=3D 0);
>  	blocksize =3D cctx.blocksize;
>  	total_bytes =3D (u64)blocksize * (u64)cctx.block_count;
>  	if (blocksize < 4096) {
>=20


--A8hCPNR1eamWf4IhdYEYgF8NE6mqOAaap--

--2Q9gD48mZwUJh2i4XczvdNGHkmvtO9AFW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9G6FsACgkQwj2R86El
/qhaFAf/S3xoVq8Rt/s3I/R6K6wlVRMVN+58T+2Btad2mzZTaG7Gjtyc9aVUM4vy
alrVPNxosrdxWS/1OJy7/0ijUEqm2cSkfZXSQSWVM9ofopRPmHbn7KTZT2zDV7ZC
0rQP+MYCL3MupR5All18XMZXEFjrnSWUchmU/LnRKM70DyHkRvZaYuqR7UtLOdox
5ImWkrpwCL0U5ynBcmu4H1i0fvr6PEt6gHhmfxfkq6qKBINn9lIqd8fpvHwtY7mJ
F7V7YKlCteH5rLoe9VXKb76GnAy97dFu+wVZGAp2XI23QmQ7dpR/N5p5rOivCxGJ
Dd1Z3EXfvWg0yW0m+ELQv/MJNOML/Q==
=tTs6
-----END PGP SIGNATURE-----

--2Q9gD48mZwUJh2i4XczvdNGHkmvtO9AFW--
