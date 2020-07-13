Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315D421CC40
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 02:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgGMACJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Jul 2020 20:02:09 -0400
Received: from mout.gmx.net ([212.227.17.22]:55967 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727932AbgGMACJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Jul 2020 20:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594598524;
        bh=XEijxvPLG0ztfU5xQ6nYvGtIoUbMrrzaUlSvGKjIv4s=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=S1YCDpa+dBaD4n4bj94t+w667PvovS7+7AhRxRfZFPmCJZ0A79CGYkpQEBkXdLuOl
         XVPHkYon6LWjTD22gSBTm0v9dTNjuzlr0LbEZfY03+PI2cPo1PmNnAgJqwFLq91ZzN
         73BPLX14hxEdKQ2++Uu1c33gBapYOwl8cobh2MjQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4z6q-1kvMQ327K0-010y66; Mon, 13
 Jul 2020 02:02:04 +0200
Subject: Re: [PATCH v3 1/3] btrfs: qgroup: allow btrfs_qgroup_reserve_data()
 to revert the range it just set without releasing other existing ranges
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20200708062447.81341-1-wqu@suse.com>
 <20200708062447.81341-2-wqu@suse.com> <20200709160255.GA15161@twin.jikos.cz>
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
Message-ID: <e6f5ec9d-ad2a-9170-1adf-360841c29d54@gmx.com>
Date:   Mon, 13 Jul 2020 08:01:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200709160255.GA15161@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JRZ8Vntj5tSSgFlBSKLzUx2yY2vN8gl07"
X-Provags-ID: V03:K1:AZ4XZldALM+v6zgO2G2Lh3YHIYHBgH6sxt+N0t4SCXX53dP18/D
 4wCUOlwbiunwQzxVuMNeIgRyv8z5QwamfQobY96mSuiMTHqCOzcwNL2/CKtEQ63XtIZGJNp
 C+vR0aQK21NqyRgh/E4SmCSC02AfAWuXN5F79xFj4p68PnaeooNIj3klYNyy1vhbysCr42o
 93o0+IFc2AzWGqXUtPsLA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qWJx5kIsIUE=:eakHtTfEVyf/FXiTmS4SnO
 VZLUzHXpMUlvCdJnBQZ3bq5UwKzyJExkoNyPkoDZIQ/d6QcItxa1edVxhF20iCpsatPITI3ST
 GRRscLgYQ7/+kY303VZZE/AzYKYE/zMx8rCB5N/CNBc6reaCRSbf7rBqEY055To3l2unHCbYG
 gg+zW8No0ZrmEK9b9PxK1g3PFXRoHz4DvMX9iG0Rheutt19n+7Pndp+qfHVA7/qnOIx5oX8io
 KMd5ukniSRrfpc8kHBMityH456pQMcqv2MQ71fpKoUkmNZbNOcTkPxo/t7v9SAyHQXNCBkAcv
 0DisduPw/bqdtdVX70bEm1sUtmj6vgQ/madSUr2G3LQViBd1mz+5PcTDwQrMkEuToGTnBPsId
 3F1ZRg+Fa4JrbgFfQKBlAqDHMORtfvg5q2iIRmaG6aUMAYgHdaGmU98jB9NUxfCTqgbRmEr3h
 Ydz1oH3Voonlt8bOTKdxTNp3L1cUyw0ks3E9PBrYynb7dGY9AX+k34dF5jT4MxKFgg0cgIXtF
 WLmYl97cZam7tG0bOZOjdDaGjNEDOd8OI7VHxJ7X3lw/DbGtekQPwUd8Eect40GuBoCzyECXl
 WX3XP1YkgkCZfJVZyCun5yYXjbo54eI0Ah2Kv33v26rXuu2dMxvARllahFAcsGeJ8Q3vcdl0A
 3PBDXLsfY5t4piwU1+lA4wWt5OTo8CnUI9Uk76EQbrbA7dsU6qqI6VOW4VIin630Fvg2ZUmze
 ChVy7fle1nyt3Jpw215pmACL9tDS/AozRbXFHLXJgryAQsx6Rh54d7VZMCFxJhgpBUE8LaaRx
 cKvjCY/kgMKJaY1k4Hz/i6zENUzWsowzNbLoA7NPqNnAdPwiHCNKxtiZ1pBfTPLePijpLYCqB
 9OTcL0rkYfQ1PWLi2G4/tR7CRZWwe/h51HY4kgPtksAp/TsQ2TmAVF69Dge3q76irnTjLkHCt
 XNjwx2aYaoqVmt2+yb3ty6V1ELxioQK05qdCQXE/QayNQEHql2IusOOinFg6lmA0juYDU6G87
 lkQEYNzkWKCB54M5+y4PI9oC71zqjXAvGUzGpCUsMhmCErFj4DTnuZJd6MBtsalpYX+vRFTN1
 hqJT6+yUTcodmMTfdXizfUdjVDmrKH9KBBqlP2vbxX1VHxaWQnAEkTqbn6JOhTeGH2B/UoWGt
 N0wEE4BMDIOitekvisLqhZdKsieiMfSLtSwpQVyjzg9NAe4yOJtYNvu0x7ExiVD1mJSb6O0v7
 d6GR6M3V8DZgwUL0kyLCZmeObmbTnBoEvKfEBuw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JRZ8Vntj5tSSgFlBSKLzUx2yY2vN8gl07
Content-Type: multipart/mixed; boundary="PLWdW4A1d80SaTctr9YI2vcHvU3yC77m9"

--PLWdW4A1d80SaTctr9YI2vcHvU3yC77m9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/10 =E4=B8=8A=E5=8D=8812:02, David Sterba wrote:
> On Wed, Jul 08, 2020 at 02:24:45PM +0800, Qu Wenruo wrote:
>> [PROBLEM]
>> Before this patch, when btrfs_qgroup_reserve_data() fails, we free all=

>> reserved space of the changeset.
>>
>> For example:
>> 	ret =3D btrfs_qgroup_reserve_data(inode, changeset, 0, SZ_1M);
>> 	ret =3D btrfs_qgroup_reserve_data(inode, changeset, SZ_1M, SZ_1M);
>> 	ret =3D btrfs_qgroup_reserve_data(inode, changeset, SZ_2M, SZ_1M);
>>
>> If the last btrfs_qgroup_reserve_data() failed, it will release all [0=
,
>> 3M) range.
>>
>> This behavior is kinda OK for now, as when we hit -EDQUOT, we normally=

>> go error handling and need to release all reserved ranges anyway.
>>
>> But this also means the following call is not possible:
>> 	ret =3D btrfs_qgroup_reserve_data();
>> 	if (ret =3D=3D -EDQUOT) {
>> 		/* Do something to free some qgroup space */
>> 		ret =3D btrfs_qgroup_reserve_data();
>> 	}
>>
>> As if the first btrfs_qgroup_reserve_data() fails, it will free all
>> reserved qgroup space.
>>
>> [CAUSE]
>> This is because we release all reserved ranges when
>> btrfs_qgroup_reserve_data() fails.
>>
>> [FIX]
>> This patch will implement a new function, qgroup_revert(), to iterate
>> through the ulist nodes, to find any nodes in the failure range, and
>> remove the EXTENT_QGROUP_RESERVED bits from the io_tree, and decrease
>> the extent_changeset::bytes_changed, so that we can revert to previous=

>> status.
>>
>> This allows later patches to retry btrfs_qgroup_reserve_data() if EDQU=
OT
>> happens.
>>
>> Suggested-by: Josef Bacik <josef@toxicpanda.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/qgroup.c | 90 +++++++++++++++++++++++++++++++++++++++-------=
-
>>  1 file changed, 75 insertions(+), 15 deletions(-)
>>
>> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
>> index ee0ad33b659c..84a452dea3f9 100644
>> --- a/fs/btrfs/qgroup.c
>> +++ b/fs/btrfs/qgroup.c
>> @@ -3447,6 +3447,71 @@ btrfs_qgroup_rescan_resume(struct btrfs_fs_info=
 *fs_info)
>>  	}
>>  }
>> =20
>> +static int qgroup_revert(struct btrfs_inode *inode,
>> +			struct extent_changeset *reserved, u64 start,
>> +			u64 len)
>=20
> I've renamed it to qgroup_unreserve_range, as it's not clear what is
> being reverted.
>=20
>> +{
>> +	struct rb_node *n =3D reserved->range_changed.root.rb_node;
>> +	struct ulist_node *entry =3D NULL;
>> +	int ret =3D 0;
>> +
>> +	while (n) {
>> +		entry =3D rb_entry(n, struct ulist_node, rb_node);
>> +		if (entry->val < start)
>> +			n =3D n->rb_right;
>> +		else if (entry)
>> +			n =3D n->rb_left;
>=20
> Please don't use single letter variables in new code unless it's 'i' fo=
r
> integer indexing. 'node' is fine.
>=20
>> +		else
>> +			break;
>> +	}
>> +	/* Empty changeset */
>> +	if (!entry)
>> +		goto out;
>=20
> Switched to return as suggested.
>=20
>> +
>> +	if (entry->val > start && rb_prev(&entry->rb_node))
>> +		entry =3D rb_entry(rb_prev(&entry->rb_node), struct ulist_node,
>> +				 rb_node);
>> +
>> +	n =3D &entry->rb_node;
>> +	while (n) {
>> +		struct rb_node *tmp =3D rb_next(n);
>=20
> Renamed to 'next'
>=20
> All non-functional changes, no need to resend.
>=20
I haven't see it in misc-next yet, and consider the remaining two
patches will need some modification anyway, would you mind to update the
patchset?

Thanks,
Qu


--PLWdW4A1d80SaTctr9YI2vcHvU3yC77m9--

--JRZ8Vntj5tSSgFlBSKLzUx2yY2vN8gl07
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8LpHcACgkQwj2R86El
/qjeYggAsZe9unzNYHQyPHMoQGIpvDBOK5wfX97Lrph6KSvU6NyNOD1STi6JMDdf
gzT2yN/u90OuHb7ElxHy7dM+BRg3CWV5sUcYDTFahAO+FeuIbHOuV4/4tkQUit4H
TaN1XF4Du1ZN1CRf8V06QQsSvfgoqhdif2udWpqlOxdEdA5OINyPmz+O0ZDvEjWs
2whbG0p+UVL6oyYIB80aSp/1TCiEb0UndLq2OG/+1/sK9wqP3Fj5QC9h9BuARpe4
Ux6exVkTWqy0sCOeTqMpj2lwn/01qMpEfPQDbgNgula2My7w2uu7Low1EhRRaiFj
VjnsAk4h/n22JgLxy2SFRoBIqkm6Kw==
=OSFq
-----END PGP SIGNATURE-----

--JRZ8Vntj5tSSgFlBSKLzUx2yY2vN8gl07--
