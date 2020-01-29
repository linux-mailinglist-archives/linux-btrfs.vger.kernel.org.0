Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D29A214C5A9
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2020 06:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgA2FWa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 00:22:30 -0500
Received: from m9a0014g.houston.softwaregrp.com ([15.124.64.90]:38590 "EHLO
        m9a0014g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725858AbgA2FWa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 00:22:30 -0500
Received: FROM m9a0014g.houston.softwaregrp.com (15.121.0.191) BY m9a0014g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Wed, 29 Jan 2020 05:21:44 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 29 Jan 2020 05:19:39 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (15.124.72.11) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 29 Jan 2020 05:19:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxgqfinM++LJzXxK2lO8zuUBq2hhr8CltJE48Jk2b1++nhs9VoXy8i0BuoLXrVY7dj1XC04gATpka0D14lED4Bjkk2T7kyAwXuSxIo0oZIm3gkuhLOL7tzTONSZjYwm2GbRoIfi7E6owdbwsW//u6q+zem2Vd5PaPArcd6MyGTOeooAhsVEqrcAQhZKqq88H8kkFznbd2WlhPIUQbxDrpCFhdzFEIQpsrNCjGWKfNF5a/zTD9VrYKzNiOw+ws5ZgVwFspm0zMy9tLFZztbuRwNiP/vu+FFUoA2bbu4U8jtS3w5ggjPTuD19vvysi2yGTNJkcG4dmf5DnV3bzbpiyQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FalcBTae3ueZG+Ui/t7ccN5L3jlLvk3efvPkLMyGNo=;
 b=BHdrt2xw1UmJoM6FH1rRhg9Ihq/SXADZC/E2t7svRfixXSMrm9CNYFIhF+Fq7u790FH7m1YDHPTh6oAgJBq2fDWKLai4T6WvXL48s5zVhiIRV63UESLU6l8zzxqXjtASX50+uKYlZmxmxZhrfV2Aw6W62VuewJRlBHdgdhvys0ZvHO3WnGR3PAcTjtlPdKOo4Jb6rIZOcvxl2Khu5HRzT2e6rNnyo8lPQs96QfXQgzr8GLKjkEuPTXVklinYXe/30RNvETUx38qjm0zhDKRb6VXP1TsYVAK64wanZyzFz40jfZ3WD+L/7AwMqGQyNglaReoZFvZZnojYhOzy/CJ36g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3090.namprd18.prod.outlook.com (10.255.138.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Wed, 29 Jan 2020 05:19:38 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd%7]) with mapi id 15.20.2665.027; Wed, 29 Jan 2020
 05:19:38 +0000
Received: from [0.0.0.0] (149.28.201.231) by BYAPR11CA0038.namprd11.prod.outlook.com (2603:10b6:a03:80::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend Transport; Wed, 29 Jan 2020 05:19:36 +0000
From:   Qu WenRuo <wqu@suse.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH v6 0/4] Introduce per-profile available space array to
 avoid over-confident can_overcommit()
Thread-Topic: [PATCH v6 0/4] Introduce per-profile available space array to
 avoid over-confident can_overcommit()
Thread-Index: AQHV1mOzyWxqmqAlCUuQw2dvgduxLw==
Date:   Wed, 29 Jan 2020 05:19:37 +0000
Message-ID: <55af2fa3-0762-3893-90b4-e0b90a225d27@suse.com>
References: <20200116060404.95200-1-wqu@suse.com>
In-Reply-To: <20200116060404.95200-1-wqu@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0038.namprd11.prod.outlook.com
 (2603:10b6:a03:80::15) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [149.28.201.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 472caeea-10d3-4546-9e1c-08d7a47ad5dc
x-ms-traffictypediagnostic: BY5PR18MB3090:
x-microsoft-antispam-prvs: <BY5PR18MB30909D96CB15112C93BDA686D6050@BY5PR18MB3090.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02973C87BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(199004)(189003)(64756008)(66446008)(31686004)(66556008)(66946007)(36756003)(66476007)(16526019)(66616009)(478600001)(186003)(6486002)(26005)(71200400001)(86362001)(31696002)(52116002)(2616005)(16576012)(110136005)(6706004)(8676002)(81156014)(81166006)(2906002)(8936002)(5660300002)(956004)(316002)(78286006)(131093003);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3090;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bSzIoHPvWZwFQdfNNacA4rRsP4Bzpq38AphqXZzwsqKvXkJq8r7MOFEOp7AELEgKFP9pJ+ZsDNFLqQrlPUpjHi1Egb1B1f32LuXO2o42pFX+JHi3kPgh2e7zFObynu9cxUDeCk+2eI1SfvCFLJpD7p5waZe3mCCo/mx/+ge97sU6YEv6pSbF4euhnaAL+qr0Q+xahiMBFexc1t9IA06+irrNXAeaopmwHBomOaHvn9IhSUI4YAJwsbDGuQldyRpAMJgVEOcjvmDPHEeGEs36rwDM/ujN1B1U0mU6F+vQ1Xvu1zST3Fi6P+VqVQKkmSlD1uNeVH18cQxwiDdXK1a7p+zwQ54JLovUsDjkP0Bk8OrsmJGG6buZfF2g0Z4VDrfyEJehn+by/d7b11YSUGXj6kj2LMKbBsvaszXTMwNQ14msNCSG0DUwENaVMd/9jhgamE1j7dVCNdT+vkRm2cnu5yYkZ2Jc+tz6cUe5uv0qorD7N2Jy2MJ/gHq80ulXpg2qeL3VI4osG1tagjjFxg1F1RKvG/XLjGbMBZT+a0hPPvGfJmPZGfS9P3GEvmyBS0jK
x-ms-exchange-antispam-messagedata: izxR7VtQ49ghV2YIpNLcq2cl4dmagBhQ7ruAJ1xoBBNPytvtFlPJXWWNsFtb6p/iOQXI9M/R0BvaGyTsPu8UgwgF+Dr5OwgSu87P5La7ax6JjFzkPpJLJZErrr4le7Jh0FXaMR7V7OZp6v73dT+7YA==
x-ms-exchange-transport-forked: True
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="PZQlBeyShjyJKUALvWTuv55cZkmfd33xV"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 472caeea-10d3-4546-9e1c-08d7a47ad5dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 05:19:37.9284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BRGNql2TDr3RedAocmyVzW99cO/8keI5QpdxDfSseBi6HCc+akmTzdmVjji/on8O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3090
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--PZQlBeyShjyJKUALvWTuv55cZkmfd33xV
Content-Type: multipart/mixed; boundary="XsG6ewtfZ0MrF1g7NZTlgAwLf0BLvqILw"

--XsG6ewtfZ0MrF1g7NZTlgAwLf0BLvqILw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi David,

Mind to merge the patchset for misc-next?

As patches 1~4 are reviewed, and the last patch is not that complex to
grasp, I guess it's time to finish the long existing df 0 space bug,
with better RAID5/6 estimation for df.


For the long discussion about whether we should set available space back
to 0 when metadata is exhausting, I still tend not to do so, since
metadata and data are separate resources.

Thanks,
Qu

On 2020/1/16 =E4=B8=8B=E5=8D=882:03, Qu Wenruo wrote:
> There are several bug reports of ENOSPC error in
> btrfs_run_delalloc_range().
>=20
> With some extra info from one reporter, it turns out that
> can_overcommit() is using a wrong way to calculate allocatable metadata=

> space.
>=20
> The most typical case would look like:
>   devid 1 unallocated:	1G
>   devid 2 unallocated:  10G
>   metadata profile:	RAID1
>=20
> In above case, we can at most allocate 1G chunk for metadata, due to
> unbalanced disk free space.
> But current can_overcommit() uses factor based calculation, which never=

> consider the disk free space balance.
>=20
>=20
> To address this problem, here comes the per-profile available space
> array, which gets updated every time a chunk get allocated/removed or a=

> device get grown or shrunk.
>=20
> This provides a quick way for hotter place like can_overcommit() to gra=
b
> an estimation on how many bytes it can over-commit.
>=20
> The per-profile available space calculation tries to keep the behavior
> of chunk allocator, thus it can handle uneven disks pretty well.
>=20
> And statfs() can also grab that pre-calculated value for instance usage=
=2E
> For metadata over-commit, statfs() falls back to factor based educated
> guess method.
> Since over-commit can only happen when we have unallocated space, the
> problem caused by over-commit should only be a first world problem.
>=20
> Since this patch introduced a new failure pattern, some new error
> handling are introduced:
> - __btrfs_alloc_chunk()
>   At the end of that function where calc_per_profile_avail() get called=
,
>   if it failed due to -ENOMEM, we will revert device used space, and
>   remove the allocated chunk.
>   This is the only new error handling added by patch 5.
>=20
> - btrfs_remove_chunk()
>   There is no good way to revert the change. So here we abort
>   transaction, just like what the old error handling does.
>=20
> - btrfs_grow_device()
>   This function has its problem by not reverting device used space from=

>   the very beginning.
>   This patchset will enhance it in patch 4.
>=20
> - btrfs_shrink_device()
>   This function already has good error handling, reuse it.
>=20
> - btrfs_verify_dev_extents()
>   Mount time error will lead to mount failure, nothing to worry about.
>=20
> Contents of the patchset:
> Patch 1:	Core facility, with basic (not perfect) error handling
> Patch 2:	Fix for over-confident can_overcommit()
> Patch 3:	Make statfs() more accurate
> Patch 4:	Better error handling for btrfs_grow_device()
> Patch 5:	Better error handling for __btrfs_alloc_chunk()
>=20
> If needed, patch 4 and patch 5 can be merged into patch 1.
>=20
> Changelog:
> v1:
> - Fix a bug where we forgot to update per-profile array after allocatin=
g
>   a chunk.
>   To avoid ABBA deadlock, this introduce a small windows at the end
>   __btrfs_alloc_chunk(), it's not elegant but should be good enough
>   before we rework chunk and device list mutex.
>  =20
> - Make statfs() to use virtual chunk allocator to do better estimation
>   Now statfs() can report not only more accurate result, but can also
>   handle RAID5/6 better.
>=20
> v2:
> - Fix a deadlock caused by acquiring device_list_mutex under
>   __btrfs_alloc_chunk()
>   There is no need to acquire device_list_mutex when holding
>   chunk_mutex.
>   Fix it and remove the lockdep assert.
>=20
> v3:
> - Use proper chunk_mutex instead of device_list_mutex
>   Since they are protecting two different things, and we only care abou=
t
>   alloc_list, we should only use chunk_mutex.
>   With improved lock situation, it's easier to fold
>   calc_per_profile_available() calls into the first patch.
>=20
> - Add performance benchmark for statfs() modification
>   As Facebook seems to run into some problems with statfs() calls, add
>   some basic ftrace results.
>=20
> v4:
> - Keep the lock-free design for statfs()
>   As extra sleeping in statfs() may not be a good idea, keep the old
>   lock-free design, and use factor based calculation as fall back.
>=20
> v5:
> - Enhance btrfs_update_device() error handling in btrfs_grow_device()
> - Ensure all failure caused by calc_per_profile_available() is the same=

>   with existing error handling
> - Fix a bug where chunk_mutex is not released in btrfs_shrink_device()
>=20
> v6:
> - Don't update the array if we hit any error.
>   To avoid calling calc_per_profile_avail() in error handling path.
>=20
> - Re-order the patchset
>   Make the core facility the first patch.
>   Error handling improvement in later patches.
>=20
> - Add better error handling
>   Improve one existing bad error handling, and provide a better solutio=
n
>   for __btrfs_alloc_chunk()
>=20
> Qu Wenruo (5):
>   btrfs: Introduce per-profile available space facility
>   btrfs: space-info: Use per-profile available space in can_overcommit(=
)
>   btrfs: statfs: Use pre-calculated per-profile available space
>   btrfs: Reset device size when btrfs_update_device() failed in
>     btrfs_grow_device()
>   btrfs: volumes: Revert device used bytes when calc_per_profile_avail(=
)
>     failed
>=20
>  fs/btrfs/space-info.c |  15 ++-
>  fs/btrfs/super.c      | 182 +++++++++----------------------
>  fs/btrfs/volumes.c    | 245 ++++++++++++++++++++++++++++++++++++++----=

>  fs/btrfs/volumes.h    |  11 ++
>  4 files changed, 290 insertions(+), 163 deletions(-)
>=20


--XsG6ewtfZ0MrF1g7NZTlgAwLf0BLvqILw--

--PZQlBeyShjyJKUALvWTuv55cZkmfd33xV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4xFeUACgkQwj2R86El
/qjhsAf+PUumErjPgs3WizLL7j3zp6PGiYVTa6NJzOH+ByavjM57n9K7S9NHsRUI
w+o+NDy6RqIMFBR9HMKxMw19tKhbfBh0ojp3obXYCuJ++vRYPqFf/VUy8ce8j3dc
wi8Qa5MO29lfo6WvMUIjBgULR9lqq6aI/g8c3wUXhz/GTucheK6QuUxMoTtFXXiz
DN5pXADFFEKKtqL/jYdNxZSFwkY+ILsT7uDNKzf0f9SZ0MGyNQ0WCirf33XHQPBG
fRnege8NQ6yIvsSCM1JO6AX5nmEQHJn4DxCkkAASC8NbhlWoWO0m7gNDYZeIT7S5
Ul95vcAXAajhAMOi7CKR7CdyC/8luA==
=Vkfg
-----END PGP SIGNATURE-----

--PZQlBeyShjyJKUALvWTuv55cZkmfd33xV--
