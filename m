Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4528410986C
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 06:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbfKZFAZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Nov 2019 00:00:25 -0500
Received: from mout.gmx.net ([212.227.15.15]:37085 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfKZFAY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Nov 2019 00:00:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574744361;
        bh=K35Rcq3emrwL0Nwq87qkJss0qJNyBuAsWx3qB5DxAFM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Er36ERUKYf/63phSup/ZYx4L77odKEh7WV7iXpqe8ldtrMMaZ08wpWw9QOeFSRTSi
         DmTQHQ1eowjCZzjrGGWt6w22QaapJbhgJC5FAC0sfT46xOvt/joJbO4EMnqbx+FcIS
         UgFWioMtOHwk+A14u/bnfITTVk/I/J5LcTJ2D/iY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mzyya-1hddnj0qCU-00wzQX; Tue, 26
 Nov 2019 05:59:21 +0100
Subject: Re: [PATCH 3/4] btrfs: fix force usage in inc_block_group_ro
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, wqu@suse.com
References: <20191125144011.146722-1-josef@toxicpanda.com>
 <20191125144011.146722-4-josef@toxicpanda.com>
 <64dec4e1-a602-454c-e9d5-af8f39aaf97a@gmx.com>
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
Message-ID: <38b1b3ab-abd3-57b0-c94a-178980d4dea5@gmx.com>
Date:   Tue, 26 Nov 2019 12:59:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <64dec4e1-a602-454c-e9d5-af8f39aaf97a@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="l5SimTX4qU7FBOG3oBZT3jg1cBTU7GFuO"
X-Provags-ID: V03:K1:7b62EPqG/MLDBpO/Hi/Bq2nk+OUYsDR4qZpDumRR9xSU60XICJh
 MaKwOIE46qKLNTK8R0qxlu57+3oDk4zzG1MkPzhl5qp0/IPCHi5R/ov2HyJku/fflXUM+VX
 oHRDV6P2QtPTvOIj+iMy7aW1jSMb9huRiALOCzbpUC4da7HdivDrdMmbWgggMOsCf6mzYbK
 aQetbfhkKVttY4ZgK4HUA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bv2XKd9aOQk=:VsPWGXOYGO4MAvhgAmW0bD
 UOd5F2WJ3ygMa2owddxkNKVfMn6x4dS73lmdOdz9i61FXFQsf+PL2Mu4owjKED14P06CaBdR7
 K6sJqd9R9lNzdtk4tVGvD4YTTHMNvvGmFvK17BhPtyX1eFVMug2E+LWiVNhrgu+TR/8qY5RhJ
 uLhtAPYxBV91dEBQXBy4UGpaEogE9OQJHqYSAa3BT6Vwvx1LaqXF5XtCPWYJghG4RnS+CsS4B
 2FFYDUOjPzXV0Bp4Q1w/Jkpo4ssrmZusqJoGroV1SQ3ZiCh7GY+bxZpB4BjyARBMXomTGe1xB
 bANEtzmK/gFYDa/VEf4ntSjc92S+c7S5tybMWUuJdQnNlDW1chfSQxwpyZYH1HyFU82u53s0g
 GePQYT6poSngHLA6e9nT+NvBAlaxurpMJzMGdlNaDWSQCJpJasvLn/5WHOb24jKCcw5PqnGMy
 upneCBYzlmJhivjujNj6TixfyugDqrkZoYtRvb/7bxm+HJ9XkF+2+3OtzPC4u+8vFlDvECw/k
 a/BcYEzGZkxmczaZ3vp/RQSdh6/mgUrFI+naBgtBken7KLO2vh/qh+R8dbq/qytHyvXyGjahX
 MqnR5B3e7QnF3P6WLYPzWFYa46Ome1YBJvopH2gBdcet96bF/rYTedBhMjTITl09LwhF0v90Q
 Vf4suHoOasGO2e50UACIDZsp6iq2doztb69zPEoXN73PXcOEhCuyxOqUwRMd41EgrKifTpJIr
 bT15T+EUaPEuj+Gc9e7KtoEvk7JDYXrJ0bexQoGjkTI8CH5T67ucO6HYWAv7sWZj94EVrlgch
 ukFydYJh1c6A1ySrAEi9ydZt+bUJ8vXVuS15jCyrvf0gN0wCo9VwQibtqSrFg/4chAlkv4duO
 akvYQQezvYCqhdcLKjd2n5jbLEzPvANAuwrdQ/yZqMdyO1+0zcHEKF3rEb7j37ZMQMyJKLpYu
 GnUHAikKbJxJGyERFUeLP7fjty6ILpaTCHLhNq0iUPhcN+QAIe3VnlcXlbyAq/CBGqk+aJtml
 Ekhs8ExY0AXcpcXb8TdbgE7E145kCrgmHZt7Bchxfc+Du50L+zOnXsQc0YiNG5VO1PC9MHK7P
 xkHeNxTh1D1UT9ioE2kwbuGRXV1GaDo7AO+P8HvHxav0PnsUo+wS94OWxe6ReJbvQ0/B1VMqI
 DjjzjisTByl5BTGobQrGMBvGUF8lw7/x+LsGq4Wod3Z07FYze3pbjvhCcAdRvX6Nn7eqXZMvF
 vpoOKD6xNjNqxfo+ng8CMQzi7OmujC7E08K0Ji9FcK7inHUy4/U4BnCMKDHQ=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l5SimTX4qU7FBOG3oBZT3jg1cBTU7GFuO
Content-Type: multipart/mixed; boundary="OoCyMymmfTCFqM2RLdKpMBp3oXZMSPjjo"

--OoCyMymmfTCFqM2RLdKpMBp3oXZMSPjjo
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/26 =E4=B8=8A=E5=8D=8810:43, Qu Wenruo wrote:
>=20
>=20
> On 2019/11/25 =E4=B8=8B=E5=8D=8810:40, Josef Bacik wrote:
>> For some reason we've translated the do_chunk_alloc that goes into
>> btrfs_inc_block_group_ro to force in inc_block_group_ro, but these are=

>> two different things.
>>
>> force for inc_block_group_ro is used when we are forcing the block gro=
up
>> read only no matter what, for example when the underlying chunk is
>> marked read only.  We need to not do the space check here as this bloc=
k
>> group needs to be read only.
>>
>> btrfs_inc_block_group_ro() has a do_chunk_alloc flag that indicates th=
at
>> we need to pre-allocate a chunk before marking the block group read
>> only.  This has nothing to do with forcing, and in fact we _always_ wa=
nt
>> to do the space check in this case, so unconditionally pass false for
>> force in this case.
>=20
> I think the patch order makes thing a little hard to grasp here.
> Without the last patch, the idea itself is not correct.
>=20
> The reason to force ro is because we want to avoid empty chunk to be
> allocated, especially for scrub case.
>=20
>=20
> If you put the last patch before this one, it's more clear, as then we
> can accept over-commit, we won't return false ENOSPC and no empty chunk=

> created.
>=20
> BTW, with the last patch applied, we can remove that @force parameter
> for inc_block_group_ro().

My bad, @force parameter is still needed. Didn't notice that until all
patches applied.

Thanks,
Qu

>=20
> Thanks,
> Qu
>>
>> Then fixup inc_block_group_ro to honor force as it's expected and
>> documented to do.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>  fs/btrfs/block-group.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index db539bfc5a52..3ffbc2e0af21 100644
>> --- a/fs/btrfs/block-group.c
>> +++ b/fs/btrfs/block-group.c
>> @@ -1190,8 +1190,10 @@ static int inc_block_group_ro(struct btrfs_bloc=
k_group *cache, int force)
>>  	spin_lock(&sinfo->lock);
>>  	spin_lock(&cache->lock);
>> =20
>> -	if (cache->ro) {
>> +	if (cache->ro || force) {
>>  		cache->ro++;
>> +		if (list_empty(&cache->ro_list))
>> +			list_add_tail(&cache->ro_list, &sinfo->ro_bgs);
>>  		ret =3D 0;
>>  		goto out;
>>  	}
>> @@ -2063,7 +2065,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_=
group *cache,
>>  		}
>>  	}
>> =20
>> -	ret =3D inc_block_group_ro(cache, !do_chunk_alloc);
>> +	ret =3D inc_block_group_ro(cache, false);
>>  	if (!do_chunk_alloc)
>>  		goto unlock_out;
>>  	if (!ret)
>>
>=20


--OoCyMymmfTCFqM2RLdKpMBp3oXZMSPjjo--

--l5SimTX4qU7FBOG3oBZT3jg1cBTU7GFuO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3csSQACgkQwj2R86El
/qjAYwf+JTxQQotEE8yR2n6Ev5OwS04IXLlcdr7fb1cG7r2P70hlMKch50cQqujb
6b/Tp9lKolOJbbpZiVlLLWzdTPV93uKp5U0hl5ooi6Il+NtVvWdO1rfdDlFsiNzg
XIqpEIIWbt2NOoJlQRIiLngc5Ajd8ZTEf5p/PTIj5EXkBP/EzTdZPFhZBVUh2Ptv
zU09+s7siGeh/CNqGDxQqS18hyHMwe/1T4uNQ0ph5o2t0QYI8Ah8D9460/0puuvy
YFhWrsD2TUWZlWKdVjhc52AGrL2gg7gesmUF0RM9KNLm5DpJGrt5S59MUXZxQ7/A
XQZGqFAN0/XEB7MZU+KCHtZDjlSxPg==
=JHKM
-----END PGP SIGNATURE-----

--l5SimTX4qU7FBOG3oBZT3jg1cBTU7GFuO--
