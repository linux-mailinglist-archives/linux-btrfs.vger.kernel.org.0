Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C0C231BDA
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jul 2020 11:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgG2JNb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jul 2020 05:13:31 -0400
Received: from mout.gmx.net ([212.227.17.22]:49419 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgG2JNb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jul 2020 05:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596014006;
        bh=s9RUxIap2W9/ALo0nQs8E2P59jBNW86cWFikiFNSML0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KKFncwiregBhPW/XdwE6NVUm/nuCK/lOSQs4tNY52UvDQcJoMYnLj9rTy+GQ7EVHz
         4zumL0sROrwkjGTnL2bi1l3WQRxzSAPjMwGbAMbzNbBJ+7O9ztOtAqG9T2L7Y7nQV+
         kJdfhcQYHu9oujnqqVnqELuHIzB3ZPoPScGLM2kk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mv2xU-1kriJJ3RQW-00qx9P; Wed, 29
 Jul 2020 11:13:26 +0200
Subject: Re: [PATCH 3/3] btrfs-progs: convert: report available space before
 convertion happens
To:     Su Yue <Damenly_Su@gmx.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20200729084038.78151-1-wqu@suse.com>
 <20200729084038.78151-4-wqu@suse.com> <8sf28zdt.fsf@gmx.com>
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
Message-ID: <9904022e-8c16-bd93-960a-93f9019d19ba@gmx.com>
Date:   Wed, 29 Jul 2020 17:13:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8sf28zdt.fsf@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0fVyFl0NAExB4IRnNC6FoG1UsWk3uFOmA"
X-Provags-ID: V03:K1:qA2TWIc5naKWmmJOXg9YKQ8fcUvN79p7wpV20T4sYWKqAmkGWAi
 kqLxvimvt5fHhvdBf6msmPxw3xnirp1c4WvEXOlRhjyf4rs1Vte9LG/Q++d+pMDB/uzjkIq
 lHXMZX6Thg+VHalKHc8Eu0fRWDs4iu1Ab3SEi5NuU1kUydk6MWksZ9AbQgFnWby4sm+8BCe
 ekKnFB+qXHkJDFzVhC0Lw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0FMkoOlCQMA=:DTKxxPz5MMd7sIOXt61WZB
 p31vwWBJELljmp0tmi3uQYB59DGwlAWHFAqN2vMh07J5BcT5B2H/1TCgz6xk1ZpmU3Sxxs5j9
 aArgGmCtO8aAZBEH+12UU+xXXgNKl46iIeHEv14xF4XjRCaQKUQP6oR6uHN2WU75H1hOtHzmQ
 hXi9KXZ5xl9f/+vMZnf/wMHW7DrasQxs6PFFQ7Q+EyKX8RcJQ848ofkY1lthgbNRJGetRDb0i
 4BJ0NNrx+/1oTsejRpEabtMXx5wmmOyhMEpiT4PjdqQpiCGjTfTLXajEQu1Fm5+pYNS088Lob
 9ljVuHCyf/CN8sNOQXnA4hkpHvkZMTeSZLyJZXjOTBFQKIo6TbgrLWkAIkFnR0TdV26o2eH1j
 rUIGyymACUrD6EEV/i0yjHjDkAgdAifAXP/v9qO5UHSCfLPzlANw0nIJYUwoJ+MxGQfjhvwkN
 q5PdmK2Tn5kSJ2bxBaMN9vlRHt6d2kS5RWds6lhHThUydHZ31W0gDK5HkdL+QhEipVSBHm19k
 5P4f+grZ87RAyx7M4Qzzajr60YqIUZCcNGi8KfCx6aU/pPoM8oI5vB5H+JitKVom3r5A+oWqw
 llFlnbazolqoCvZKqA+3EmUUJ3mO72AyQAil8mgiOkZRic+lCytBq2md2w2L3ZItZzQiGpd5R
 HqnPlRvfDtOBL21aniAItQWPr7JN29c3oHsP4x8MAYr6mVrZjDR+yGJ5xGN6+hzCYS92LZ3ww
 Is15h/eDbP0x8xxpQv4LphwDMlxYMJrK8ZohYEgeBj6rmLyQdIhhlaTP7Az397YH/9RZ3X+c0
 rTmcvfM4LNnfxiW330D9s2lQ6K2dlGuuCRpKvgEPeBMmuACNjtas7WO3QLTfUj40IAXL42FtB
 XvBXbcwRfFRKfXl6AlRwnCdZnUAbL7XCqpcv3uqpK0gTETiFc8GwirxamidrStIerbrjv1X9R
 hCEQlPG3Y7Sm5oGL50DqwHsmxBdgpaQq6IkifKP34CEdgT45VKBh3R8uHBmQbEh88hoguV0yX
 /7BHhJFcXho5qPKOBnYab9xAyK4Smw46yWWB0bHUR73k2WasxEUe3yYdB1LXx3wf9BwYxJuVS
 YRdKhgTOnQ0u3wrd0D7cAyepRQPDTX/4ETeaOvv5MRTewlPyC0rHbI3cYqmW18RjTdS7FD3BW
 MrSwaR5F07HEAVKrZMdHYEMgwg77zkCEo68dDyfwd94smSG0vo1NwddYLSmb/7pFA/7Itx556
 nPxNyqxx5bY4ua0b5vw9IiDv59+Dlgzjrg8oauA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0fVyFl0NAExB4IRnNC6FoG1UsWk3uFOmA
Content-Type: multipart/mixed; boundary="1tLAT7U5jCpEXWYsq2zCI3txQxdnMmeph"

--1tLAT7U5jCpEXWYsq2zCI3txQxdnMmeph
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/29 =E4=B8=8B=E5=8D=885:05, Su Yue wrote:
>=20
> On Wed 29 Jul 2020 at 16:40, Qu Wenruo <wqu@suse.com> wrote:
>=20
>> Now if an ENOSPC error happened, the free space report would
>> help user to determine if it's a real ENOSPC or a bug in btrfs.
>>
>> The reported free space is the calculated free space, which
>> doesn't include super block space, nor merged data chunks.
>>
>> The free space is always smaller than the reported available
>> space of the original fs, as we need extra padding space for
>> used space to avoid too fragmented data chunks.
>>
>> The output exact would be:
>>
>> $ ./btrfs-convert=C2=A0 /dev/nvme/btrfs create btrfs filesystem:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blocksize: 4096 nodesize:=C2=
=A0 16384 features:=C2=A0 extref,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skinny-metadata (default) c=
hecksum:=C2=A0 crc32c
>> free space report: free / total =3D 0 / 10737418240 (0%) <<<
>> ERROR: unable to create initial ctree: No space left on device
>> WARNING: an error occurred during conversion, the original
>> filesystem is not modified
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com> ---
>> =C2=A0convert/common.h=C2=A0=C2=A0=C2=A0 |=C2=A0 9 +++++++++ convert/m=
ain.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 26
>> =C2=A0++++++++++++++++++++++++-- convert/source-fs.c |=C2=A0 1 + 3 fil=
es
>> =C2=A0changed, 34 insertions(+), 2 deletions(-)
>>
>> diff --git a/convert/common.h b/convert/common.h index
>> 7ec26cd996d3..2c7799433294 100644 --- a/convert/common.h +++
>> b/convert/common.h @@ -35,6 +35,7 @@ struct
>> btrfs_convert_context {
>> =C2=A0=C2=A0=C2=A0=C2=A0 u64 inodes_count; u64 free_inodes_count; u64 =
total_bytes;
>> +=C2=A0=C2=A0=C2=A0 u64 free_bytes_initial;
>> =C2=A0=C2=A0=C2=A0=C2=A0 char *volume_name; const struct btrfs_convert=
_operations
>> =C2=A0*convert_ops;
>> @@ -47,6 +48,14 @@ struct btrfs_convert_context {
>> =C2=A0=C2=A0=C2=A0=C2=A0 /* Free space which is not covered by data_ch=
unks */ struct
>> =C2=A0cache_tree free_space;
>> +=C2=A0=C2=A0=C2=A0 /* +=C2=A0=C2=A0=C2=A0=C2=A0 * Free space reserved=
 for ENOSPC report, it's just a
>> copy +=C2=A0=C2=A0=C2=A0=C2=A0 * free_space.=C2=A0 +=C2=A0=C2=A0=C2=A0=
=C2=A0 * But after initial calculation,
>> free_space_initial is no longer +=C2=A0=C2=A0=C2=A0=C2=A0 * updated, s=
o we have a good
>> idea on how many free space we really +=C2=A0=C2=A0=C2=A0=C2=A0 * have=
 for btrfs.=C2=A0 +
>> */ +=C2=A0=C2=A0=C2=A0 struct cache_tree free_space_initial;
>> =C2=A0=C2=A0=C2=A0=C2=A0 void *fs_data; };
>> diff --git a/convert/main.c b/convert/main.c index
>> 451e4f158689..49c95e092cbb 100644 --- a/convert/main.c +++
>> b/convert/main.c @@ -727,6 +727,23 @@ out:
>> =C2=A0=C2=A0=C2=A0=C2=A0 return ret; }
>> +static int copy_free_space_tree(struct btrfs_convert_context
>> *cctx) +{ +=C2=A0=C2=A0=C2=A0 struct cache_tree *src =3D &cctx->free_s=
pace; +
>> struct cache_tree *dst =3D &cctx->free_space_initial; +=C2=A0=C2=A0=C2=
=A0 struct
>> cache_extent *cache; +=C2=A0=C2=A0=C2=A0 int ret =3D 0; + +=C2=A0=C2=A0=
=C2=A0 for (cache =3D
>> search_cache_extent(src, 0); cache; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 cache =3D
>> next_cache_extent(cache)) { +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ret =3D
>> add_merge_cache_extent(dst, cache->start, cache->size); +=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 if
>> (ret < 0) +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return ret; +
>> cctx->free_bytes_initial +=3D cache->size; +=C2=A0=C2=A0=C2=A0 } +=C2=A0=
=C2=A0=C2=A0 return ret; +}
>> +
>> =C2=A0/*
>> =C2=A0 * Read used space, and since we have the used space, *
>> =C2=A0 calculate data_chunks and free for later mkfs
>> @@ -740,7 +757,10 @@ static int convert_read_used_space(struct
>> btrfs_convert_context *cctx)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;=C2=A0 ret=
 =3D calculate_available_space(cctx);
>> -=C2=A0=C2=A0=C2=A0 return ret; +=C2=A0=C2=A0=C2=A0 if (ret < 0) +=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret; + +=C2=A0=C2=A0=C2=A0 re=
turn
>> copy_free_space_tree(cctx);
>> =C2=A0}=C2=A0 /*
>> @@ -1165,7 +1185,9 @@ static int do_convert(const char *devname,
>> u32 convert_flags, u32 nodesize,
>> =C2=A0=C2=A0=C2=A0=C2=A0 printf("\tnodesize:=C2=A0 %u\n", nodesize); p=
rintf("\tfeatures:
>> =C2=A0%s\n", features_buf); printf("\tchecksum:=C2=A0 %s\n",
>> =C2=A0btrfs_super_csum_name(csum_type));
>> - +=C2=A0=C2=A0=C2=A0 printf("free space report: free / total =3D %llu=
 / %llu
>> (%lld%%)\n", +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cctx.free_byt=
es_initial, cctx.total_bytes,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cctx.free_bytes_initial * =
100 / cctx.total_bytes);
>> =C2=A0=C2=A0=C2=A0=C2=A0 memset(&mkfs_cfg, 0, sizeof(mkfs_cfg)); mkfs_=
cfg.csum_type =3D
>> =C2=A0csum_type; mkfs_cfg.label =3D cctx.volume_name;
>> diff --git a/convert/source-fs.c b/convert/source-fs.c index
>> f7fd3d6055b7..d2f7a825238d 100644 --- a/convert/source-fs.c +++
>> b/convert/source-fs.c @@ -74,6 +74,7 @@ void
>> init_convert_context(struct btrfs_convert_context *cctx)
>> =C2=A0=C2=A0=C2=A0=C2=A0 cache_tree_init(&cctx->used_space);
>> =C2=A0cache_tree_init(&cctx->data_chunks);
>> =C2=A0cache_tree_init(&cctx->free_space);
>> +=C2=A0=C2=A0=C2=A0 cache_tree_init(&cctx->free_space_initial);
>> =C2=A0}=C2=A0 void clean_convert_context(struct btrfs_convert_context
>> =C2=A0*cctx)
>=20
> Did you forget the clean path? :)

Oh, thanks for that!
Just forgot that.

Thanks,
Qu
>=20
> ---
> Su
>=20


--1tLAT7U5jCpEXWYsq2zCI3txQxdnMmeph--

--0fVyFl0NAExB4IRnNC6FoG1UsWk3uFOmA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8hPaoACgkQwj2R86El
/qh/iAgAmu+2NphWzAHG126rJfS+4ak0GAa02OxA19drDuzI46l6fk5eu/3rRSyn
DK7ONuUy7sYZTPpcbJ5o32seEwpQ44Og4/cFUSBy5pjmAdr1q3j4b/YrzGlpWZQO
T7IjJ8yikcYoKDY1GKOo4I48rgysbzyirqaqXh+eAEFwlPxGRgktMhm0yMtWo2zZ
MEZ6hNMuYNUQkK3mGZQM4KyV3raj0X8/hNJJGIrRmJmllMucmn35YN8MbxWKKdlE
wKveSpanYJKdABOBjYy1C1HrzDVWBfgTt8Gy9AAC+ZPFEcYV0qhSPwPEolHfYgxK
dANylfIW0JamTnhEdearSlnwUO/OLg==
=lOnF
-----END PGP SIGNATURE-----

--0fVyFl0NAExB4IRnNC6FoG1UsWk3uFOmA--
