Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0392770C7
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 14:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbgIXMTz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 08:19:55 -0400
Received: from mout.gmx.net ([212.227.17.21]:59821 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727534AbgIXMTz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 08:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600949978;
        bh=ylQG1it39gRYPIF/zvch/zhlYPm0OlATUvzIEHdqJDM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XhZuFuGBB/hdoGCQR8J7xJPygzxkyZAYvFd9HBt8f9pgdiF7DcgJw2ub/Wa3zhshB
         a6yyYdgmxMXI6luRoBRkAZuc469wK8ymcvnw/mDMjbgMG6TnN86+KCEK3hBpH6lf5B
         FUmZx8A0+uKK4v8FAXY4qG+l4vDbNAHNbrYBikUw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNbkp-1k6vKs3YrL-00P6qa; Thu, 24
 Sep 2020 14:19:38 +0200
Subject: Re: [PATCH] btrfs-progs: convert: Mention which reserve_space call
 failed
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, wqu@suse.com
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200923171405.17456-1-marcos@mpdesouza.com>
 <528b370d-c594-6530-62aa-ef9067a2e275@gmx.com>
 <cd7b29bb4546ca82b511d254edcf6219f28a37c6.camel@mpdesouza.com>
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
Message-ID: <7fe96844-2aed-7a5e-bfbd-6bcbfeede060@gmx.com>
Date:   Thu, 24 Sep 2020 20:19:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <cd7b29bb4546ca82b511d254edcf6219f28a37c6.camel@mpdesouza.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ypU3j8aLzE79BjOiUdYKhhPGogM8uBhad"
X-Provags-ID: V03:K1:JZZQXbzJelDsPQIcBlLAXBkti/5TZtvCTk6EbymXiJfJ9XFB0YI
 WISV3UZZql5fgSzeRUeyfEj8zSeXZ7KqRvKJxXNO6pQz1WPud2OeBc/8vjO54koIcOh8B8/
 LbmrXYjSL2TGCdCl260zHzRqaCZ20CmwWOiMR0XbuGqfe8ZMD1TISgZ15wIq3yRMj/teDhg
 UGPrtOd4/vfVodw4j+PCQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ABRsrUp5FVA=:rhVBBmMJ/YKcwoBHooLvrz
 NTmibtKKExnZLtLZ6TAwEquqv5VNd4H1maWJLj9uWh2KRe9FUoSFpSJPOzGd/plC0sPjJrbvt
 QASRdfeX/VVNFEyWC6+GrpTJLeM6lbd9baEjN1IlxCi6hSbBDlRUjdtfxZntv7ZhyGcTG2ACa
 zCa9XOZAptw8gBrUM8MklfOG2wTqGoFe22JhYzGipO7t97GJ5kNbUSCK+IjM30Mh7OyIfHVNx
 G8NVoPLD+04Qh9FwH3vZYMqp8zlpRsE4R1u7wwZcFJZ2Y7AqjHerpqccoN/8jak+wPl33FOqM
 25JSQ4aynYtLTcsqR/FyjZ65585sYi9yBDcL8hgFAEZprHXyK7M1GECqTJ5P9q/nZMSF5mcEy
 PBGM0VFCy3q/OWnMFkRowFdA7GGXuAMud1OhGWjuamAuMAEKaytMtWySWJEUMOnxZKGauN5gU
 t46bbmGjt5m394+J5Ydesa20m8eIZENDm2JxPW6chn6Xwl9Rx5QDJ8VefJGvATgMfgp8g5Q5n
 mp67teW9FRs94UbSyhZMhbN2QO0NMbldXrsMDPcU/o/XRagURKsigwKVPH0iTstcmH1pFXwuN
 WvPq1SS1hCePueFPzcnyRIhqE+oGu7TLueI98mDwyKWT5l3c07viC6cwmj4EjdNDFE7jPN6J/
 ksKvSuWoazOKWqKsmJRLrk5/XIatjPbn8foHHWxzaSiAJ3SaiOx/yNz8FoKsZshB8aGuwz0L1
 PVRHbxQOLz2wGoWSfu/kXHAYEfnoGMXsh54pi17lSJp8uolDGjdICOHaxEN3pXl087LnsxgHM
 PpZm6zbOnBcenaiYLqLCx+TfWNW6/uFGih5at7rM0eRBGs3mbB8fEa56BfMpaJQ4kWbzpvZKT
 rTJpsCDsTp0qv2M6KKfGKhO/vxPgbURZagCsulovS/5U21lBXalZREKbyTAL4oskg1txtKEdd
 gPXdu9k9fak5DKdBFvG50J/bKjaQRJwUmOmsywvyg2J2BpnNjPTPvAYza6yYpYKrtFYI++tO5
 SpkuLEYdxdGHiR1bP6duCp72m574rMaO9xl7DEXqNJiQU3w3Ki7YR/y74GMDqgbZj5c8h3j2s
 W978qiQLPUiatyfCKp/QG+FgCuMw6pNoGZs6R3b2hNI5HoP/UfTtKzHFm95nUnVqpuycyZkUg
 BG6UyOyBO5U7eYayZsG+R6IK+ZgrQdAVXmhF8NMreSYFvN1pYDcwG/ihhcTknN+P36HJYfSz8
 NNQKu3Txsd+i8iijboNnU4BXbdOhlz0E5OpqhIg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ypU3j8aLzE79BjOiUdYKhhPGogM8uBhad
Content-Type: multipart/mixed; boundary="owY65SqqLZmEx8DI6HeRdQePcItZKe7ra"

--owY65SqqLZmEx8DI6HeRdQePcItZKe7ra
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/24 =E4=B8=8B=E5=8D=887:54, Marcos Paulo de Souza wrote:
> On Thu, 2020-09-24 at 08:08 +0800, Qu Wenruo wrote:
>>
>> On 2020/9/24 =E4=B8=8A=E5=8D=881:14, Marcos Paulo de Souza wrote:
>>> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>>>
>>> btrfs-convert currently can't handle more fragmented block groups
>> when
>>> converting ext4 because the minimum size of a data chunk is 32Mb.
>>>
>>> When converting an ext4 fs with more fragmented block group and the
>> disk
>>> almost full, we can end up hitting a ENOSPC problem [1] since
>> smaller
>>> block groups (10Mb for example) end up being extended to 32Mb,
>> leaving
>>> the free space tree smaller when converting it to btrfs.
>>>
>>> This patch adds error messages telling which needed bytes couldn't
>> be
>>> allocated from the free space tree:
>>>
>>> create btrfs filesystem:
>>>         blocksize: 4096
>>>         nodesize:  16384
>>>         features:  extref, skinny-metadata (default)
>>>         checksum:  crc32c
>>> free space report:
>>>         total:     1073741824
>>>         free:      39124992 (3.64%)
>>> ERROR: failed to reserve 33554432 bytes from free space for
>> metadata chunk
>>> ERROR: unable to create initial ctree: No space left on device
>>>
>>> Link: https://github.com/kdave/btrfs-progs/issues/251
>>>
>>> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
>>
>> Looks pretty good, but can be enhanced a little, inlined below.
>>
>> Despite that, feel free to add my tag:
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>>> ---
>>>  convert/common.c | 12 +++++++++---
>>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/convert/common.c b/convert/common.c
>>> index 048629df..6392e7f4 100644
>>> --- a/convert/common.c
>>> +++ b/convert/common.c
>>> @@ -812,8 +812,10 @@ int make_convert_btrfs(int fd, struct
>> btrfs_mkfs_config *cfg,
>>>  	 */
>>>  	ret =3D reserve_free_space(free_space, BTRFS_STRIPE_LEN,
>>>  				 &cfg->super_bytenr);
>>> -	if (ret < 0)
>>> +	if (ret < 0) {
>>> +		error("failed to reserve %d bytes from free space for
>> temporary superblock", BTRFS_STRIPE_LEN);
>>
>> It would be awesome if we can output the free space.
>>
>> Just the largest portion is enough to show that we're hitting a real
>> ENOSPC situation.
>=20
> Indeed, I'll send a v2 printing the free space tree when ENOSPC
> happens.

And it would be even better to mention the fragmentation problem in the
man page for btrfs-convert.

The fragmentation problem is a little too complex to explain in the
error message nor usage.

Although I guess the man page update could be another patch.

Thanks,
Qu

>=20
>>
>> Thanks,
>> Qu
>>>  		goto out;
>>> +	}
>>> =20
>>>  	/*
>>>  	 * Then reserve system chunk space
>>> @@ -823,12 +825,16 @@ int make_convert_btrfs(int fd, struct
>> btrfs_mkfs_config *cfg,
>>>  	 */
>>>  	ret =3D reserve_free_space(free_space,
>> BTRFS_MKFS_SYSTEM_GROUP_SIZE,
>>>  				 &sys_chunk_start);
>>> -	if (ret < 0)
>>> +	if (ret < 0) {
>>> +		error("failed to reserve %d bytes from free space for
>> system chunk", BTRFS_MKFS_SYSTEM_GROUP_SIZE);
>>>  		goto out;
>>> +	}
>>>  	ret =3D reserve_free_space(free_space,
>> BTRFS_CONVERT_META_GROUP_SIZE,
>>>  				 &meta_chunk_start);
>>> -	if (ret < 0)
>>> +	if (ret < 0) {
>>> +		error("failed to reserve %d bytes from free space for
>> metadata chunk", BTRFS_CONVERT_META_GROUP_SIZE);
>>>  		goto out;
>>> +	}
>>> =20
>>>  	/*
>>>  	 * Allocated meta/sys chunks will be mapped 1:1 with device
>> offset.
>>>
>>
>=20


--owY65SqqLZmEx8DI6HeRdQePcItZKe7ra--

--ypU3j8aLzE79BjOiUdYKhhPGogM8uBhad
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9sjtUACgkQwj2R86El
/qiF9AgAlufazEUHbpNDE4kafgIyfWG2Igcz/4Qa0se0ujDvZXfHErf4e2zKOpYC
5UTCwhdPE8yNLFoMQ++fezlDUPAMkvm3Xnypsi4QFuJXDklKyCeRKUR8l2LsbaoS
ptudlAcBp2/ixakDnwFgFGp+qEaDGddfWFUbwS1sj0/paCxuv7cZk8SlK88jhans
cNL50rQZ9fePCV3XCzFrvl+IB6bQral5SWW8D6BubAiI/bONKzQXJSxTnTosjO4/
0LEg52K2yhCRWV+2X6GJhAwPsyUPDdK9lPHpdHj1x07DPwhuZFU1c25hEEg5aSFr
clt4PB2NdP3MPhiizKVtePJwFPkC/A==
=9p9K
-----END PGP SIGNATURE-----

--ypU3j8aLzE79BjOiUdYKhhPGogM8uBhad--
