Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62C9E131D86
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 03:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgAGCOA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 21:14:00 -0500
Received: from mout.gmx.net ([212.227.15.19]:54365 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727332AbgAGCOA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jan 2020 21:14:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578363229;
        bh=6gS2mpKSqrgHpmxZZ79JVUuKYqx8sesdv0m6pQ4airw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=i1pxG/d+dg/IFaDNbEEQkN9gkNBq+ruW6lwJOcPFH+eKblxROydVor42K+8OIbDrw
         qpySu+4sU+isuAndPXwiENCy0cDZm+Vv9li6HEOTKJrimcu5JnhVgAr4GY07wQGeC4
         j9R4+HEuzqVlzuq+DXxV1IGuKc06j2Q3yGkszGL4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M7b6l-1inHrF21PR-0086rA; Tue, 07
 Jan 2020 03:13:49 +0100
Subject: Re: [PATCH v3 1/3] btrfs: Introduce per-profile available space
 facility
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20200106061343.18772-1-wqu@suse.com>
 <20200106061343.18772-2-wqu@suse.com> <20200106143242.GG3929@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <9c2308bb-c3ae-d502-4b27-f8dbedc25d1a@gmx.com>
Date:   Tue, 7 Jan 2020 10:13:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200106143242.GG3929@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZZ7jdGyxENux3rZChYum9RlgL724Sja2M"
X-Provags-ID: V03:K1:zDWtt8mCTgQW0T6B76QJ+T7uVYLiXt6gGgX0cXuDA3xiKWEBczU
 NaBxvfw0gIjdgg4YZCEEa6P3wXpj91xMkq7ay4B+oPw969q6PQNm52EMzNGptI++KRYEamX
 glhNqS7J7Ng+V3ROguBxdUJu817v6Pn5F9hcyd6bJs185ECnV81f0m+yK5fwZ7voaGUy6fJ
 RKERJm7HA1h2B+uKjHKOg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:e2JHPSvZHYk=:8Fm85NsdXB/EO5G8afgRUs
 2CyJn90IQwuJyuB6M5OfjlcKXivo853E6URrs7jJPr1PM9mSHvqClcwea5tvE7b0IBof02oHz
 m43z8DNCsAYhFIsItTclepBwFUYserNKOs2eMvlO+1oCUEEsB2Txo33L9IAtvbcl/PU2e0M42
 mVI0Dg3XKkEaLev2BstP8MrCNX7GP6c1DTeOtTevhHH0HkNRvbdEIQaLQLqxTVGmZhv3c/K1o
 9nu+Xfaoaw+3cHOXoIMo0usgM1S5Q7DGj67fHAg876iYkgaR1zhjcn0Cq3asiIrJ8MSZgXlLL
 M55Fd75u0psAHASixRefSXX1umwWHZPMYOaTdW3Ia9Q8vuLXCCWcaJRFGmEh7Chfd8QfpNyJ1
 Lw1ZaC4nwR4WWzdGkzD1q86pKK+1QlDZ7PIY0UJcke3mXeM3/0HVY474XYoSFV4VDXBgH63kt
 seH24gAfDRfIYe1b1aYpxLsxIuUo0BKyG+4ZdqpOs3LkVC0e51bwjjzNPZQ/ctl8+L4Q0TbPZ
 0TlB43XqGKvVbXEeRpwmy3rYyFMUKC3WmZJjk906wRrfMY01tmBBMGaLnow143fU6RSAwjLH1
 cKqvDVP99zuGUsDFlqQ/gox2aDq364/N0PIpGMweJZd3JPHdMBvrkv/0MpXkcKXx2r5tDFl5v
 UufwS9C41PkXWceMFKCtrfZZoydsjKjM7WK8QSP1bRCnK/RdMC1AyqjKcdjlkx/qM1QXQqoLS
 BiaPBSUukdfwn/Tq+/NL5aju5qq4191Eih0ekBBKQbOAqC0ctib8C8Ln/6JOfvN0HkX+2EXib
 oli8+DH2npeZw//X095PML3EqHHotFchABbUo+XdEG5ar7ZOHv6NlZu2Jq+HQD07AvJFi286g
 bKRtVzw/QnAKV8Ugsn8cV1wQYZ6kEBwdFjLB1NVFeuwYKHvz3eo5+bjK8ODf6ILGqnQO0Kr9r
 7Ow+N8mwly7B97aCf9UGKwBCgFxkyBwctke/mnnz6MCOAOQOYcDpHqPbdOiCDx9G8Hug+Urk4
 ILDQOJ9YTzoeekNs7KkEbgaoeXF34pn9yPr3UgQfWXcTh5NLQe/8D7Wa0DkGG2mAiVBZgCbvb
 5ybSvPmrqM1z4d2Wj/hzwj2jmsGEGPyO6EyfmGJFdXbCbNTaVIMoMj6pD+NWuGPXbGY3NaCJ8
 rPEDX5IJl+khAEucgf8xO0mdMiGhPvA74P7DN6GL46Zv5Hve1Nrq/QrkjUdSq1OPOOfefHEFT
 xY5tDqcZS13n7HgftFZCWLqyCRH75pBcJ4N/t5MsUzwih3ulRmq+ynraoW44=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZZ7jdGyxENux3rZChYum9RlgL724Sja2M
Content-Type: multipart/mixed; boundary="y3b4kW2t1NcDf8OecT1Nxw0oomwSzY2jN"

--y3b4kW2t1NcDf8OecT1Nxw0oomwSzY2jN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/6 =E4=B8=8B=E5=8D=8810:32, David Sterba wrote:
> On Mon, Jan 06, 2020 at 02:13:41PM +0800, Qu Wenruo wrote:
[...]
>> +static int calc_one_profile_avail(struct btrfs_fs_info *fs_info,
>> +				  enum btrfs_raid_types type)
>> +{
>> +	struct btrfs_device_info *devices_info =3D NULL;
>> +	struct btrfs_fs_devices *fs_devices =3D fs_info->fs_devices;
>> +	struct btrfs_device *device;
>> +	u64 allocated;
>> +	u64 result =3D 0;
>> +	int ret =3D 0;
>> +
>> +	ASSERT(type >=3D 0 && type < BTRFS_NR_RAID_TYPES);
>> +
>> +	/* Not enough devices, quick exit, just update the result */
>> +	if (fs_devices->rw_devices < btrfs_raid_array[type].devs_min)
>> +		goto out;
>> +
>> +	devices_info =3D kcalloc(fs_devices->rw_devices, sizeof(*devices_inf=
o),
>> +			       GFP_NOFS);
>=20
> Calling kcalloc is another potential slowdown, for the statfs
> considerations.

That's also what we did in statfs() before, so it shouldn't cause extra
problem.
Furthermore, we didn't use calc_one_profile_avail() directly in statfs()
directly.

Although I get your point, and personally speaking the memory allocation
and extra in-memory device iteration should be pretty fast compared to
__btrfs_alloc_chunk().

Thus I don't think this memory allocation would cause extra trouble,
except the error handling mentioned below.

[...]
>> +			ret =3D calc_per_profile_avail(fs_info);
>=20
> Adding new failure modes

Another solution I have tried is make calc_per_profile_avail() return
void, ignoring the ENOMEM error, and just set the affected profile to 0
available space.

But that method is just delaying ENOMEM, and would cause strange
pre-profile values until next successful update or mount cycle.

Any idea on which method is less worse?

[...]
>> =20
>> --- a/fs/btrfs/volumes.h
>> +++ b/fs/btrfs/volumes.h
>> @@ -138,6 +138,13 @@ struct btrfs_device {
>>  	atomic_t dev_stat_values[BTRFS_DEV_STAT_VALUES_MAX];
>> =20
>>  	struct extent_io_tree alloc_state;
>> +
>> +	/*
>> +	 * the "virtual" allocated space by virtual chunk allocator, which
>> +	 * is used to do accurate estimation on available space.
>> +	 * Doesn't affect real chunk allocator.
>> +	 */
>> +	u64 virtual_allocated;
>=20
> I find it a bit confusing to use 'virtual', though I get what you mean.=

> As this is per-device it accounts overall space, so the name should
> reflect somthing like that. I maybe have a more concrete suggestion onc=
e
> I read through the whole series.
>=20
Looking forward that naming.

Thanks,
Qu


--y3b4kW2t1NcDf8OecT1Nxw0oomwSzY2jN--

--ZZ7jdGyxENux3rZChYum9RlgL724Sja2M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4T6VcXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qg8kAgAjjDLCL34TOSZI8LNXQOLvEgz
NBnwUklZE0r7vDgFe+zp2mj4dJUdl/FtOcm01hZ1OkPYOMIX/tD/KCiOkQ7JeFSq
aiIaHqrhfVhl1BqP967DZhMKKkMYjaPDs5ViBqbFpO68H2TkaiIrJT6aXutkRzCM
9LgtonZJzGSA24vz1lMQYId+5ym9wOjf0JmErujzyQCNUeApCjcFm9xcDxHqUMUk
LG2VV3qFTp/wB5XOPy/x7IeY0ZqpCXPsdCauWFlzNJdQ9WS7Wge+1YAfv/v7ZbGX
44eqoOR75bVpMmFgi6Y+7qmELl4YYkR+UueWt6ns1YxGWgSY1orexorQJNVKtw==
=6ut4
-----END PGP SIGNATURE-----

--ZZ7jdGyxENux3rZChYum9RlgL724Sja2M--
