Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08B3A13BEDA
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2020 12:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbgAOLvf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 06:51:35 -0500
Received: from m4a0073g.houston.softwaregrp.com ([15.124.2.131]:34026 "EHLO
        m4a0073g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729931AbgAOLve (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 06:51:34 -0500
Received: FROM m4a0073g.houston.softwaregrp.com (15.120.17.146) BY m4a0073g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Wed, 15 Jan 2020 11:49:06 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 15 Jan 2020 11:40:12 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (15.124.72.12) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 15 Jan 2020 11:40:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNU3Zu6e/xjXXZ9L76DxdkXol1nmWrLlO5vNki4MOAqVESwkfRuqfgEUGOpGt1+Lnw1UADMKpu94EazSKL0LbBJrKqyxNNL03XTG4P0V7T/e9zE1QW78mZtX0ZMg30o2TQ60xdyGS/AqlIGz5x5OdqSP5saOcUCe/9TD0l1FRsvHs5qI9SRkKj6hPJs/LeIlJ3syHPirlCq5RbcMYkZHFIlgNWoO1s9+9Yiw7tut2z0OG0F+JlFUTBNpULXBiT481O0HGUR6bViAB5ZtnWpYlretPOH4Yf4d/9oJkF1StgNPn5eWU1Dfos3xGgleSHNND9TnJfqcmQcWhsjyL35NtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWpLPuiqrtXFtqqkZECkOcqTNXd28uIe/UxA2czqlnM=;
 b=Z2zNXTP5bFjUYHbIkE/riDcIWG9KZAXmc8zYfbWlNfix73gtJunIMn3RlRKspLCHEBtBgnrWwsrEozCfOE4qbRFMyYooHnC8ufjoIQr32viROA+KfpFyGnSaFMwor3v9l+CN7rraXk64q5d3tlYH1NY3Lu6s7TELTfuoyougL+j+Ol79X+qXhpLqWOmOh86tAzaxMVqzy9a05W0uHPgvInqXUZ/7isIBPJdcjDRSQq5QpQCwdRSS75Pbs4ZU9HltD26oO0q0hOqHDzRcb6OgoHFrrHddGxgLOxSv7cngQ9DRLua0RAlFOATb9c2wLLw/2tXwGRPe697IbTJGFJFOGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3282.namprd18.prod.outlook.com (10.255.138.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Wed, 15 Jan 2020 11:40:11 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd%7]) with mapi id 15.20.2623.017; Wed, 15 Jan 2020
 11:40:10 +0000
Received: from [0.0.0.0] (149.28.201.231) by BYAPR08CA0071.namprd08.prod.outlook.com (2603:10b6:a03:117::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Wed, 15 Jan 2020 11:40:09 +0000
From:   Qu WenRuo <wqu@suse.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] btrfs: statfs: Don't reset f_bavail if we're over
 committing metadata space
Thread-Topic: [PATCH] btrfs: statfs: Don't reset f_bavail if we're over
 committing metadata space
Thread-Index: AQHVy5iLGYF3rsMl+06UJ0HrpTfJaw==
Date:   Wed, 15 Jan 2020 11:40:10 +0000
Message-ID: <2a588e86-5894-fdc7-6e16-a106937f37e7@suse.com>
References: <20200115034128.32889-1-wqu@suse.com>
In-Reply-To: <20200115034128.32889-1-wqu@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0071.namprd08.prod.outlook.com
 (2603:10b6:a03:117::48) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [149.28.201.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea99b07e-704c-45eb-eaf1-08d799afad84
x-ms-traffictypediagnostic: BY5PR18MB3282:
x-microsoft-antispam-prvs: <BY5PR18MB32825E8210CF50B3F63A9237D6370@BY5PR18MB3282.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(189003)(199004)(6706004)(6666004)(5660300002)(956004)(66446008)(478600001)(66476007)(6486002)(2616005)(2906002)(66616009)(31686004)(66946007)(64756008)(66556008)(36756003)(316002)(16576012)(86362001)(71200400001)(26005)(8676002)(81156014)(81166006)(186003)(8936002)(16526019)(110136005)(52116002)(31696002)(78286006);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3282;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CI4jNV+NsWWtBcOTs9nk/3q2Iogs5eywShg9JfdxgLSo5U5aTNulMCt9B7ye1U3vf5i9lsYxp4VvCVMsezbTnhpHrrgyDLgLJD5DdLcFeQqSTd+gnBc6iY22LeD+VYDKhvQrgfqHpICeh9aUVwVBDsFR1GdWP1qrdo46Ej5q8USko8CBT379zt1HiLmr+p+dac5iFaVKpuLicn39p8kXk3xKjDbL/GTTAamVvoqpJEKPBb+8RBh/YasvI368hLuaXl7cT76+8T2TZrWOVbC6XpHRmdNRo3mEG6PqGrNh0r0ZUo9d98skh/HiY3LrZm4J73eIr0BNTqNjc0kNNSnNKf7Dxnwu2WC+BW99TgaHRCNPX441D1xmaAjyIH+QKslYdU+FnMcgSWfbsdHeoY8kvIAMFixjJ72AC6vDPihweU+vVXK9FmWAErCf8RhaXYn2XRN4ScP807K4LIc8bEPMuyUjZsmN8SG6dBbSMZZS/O4BNryuEmZas9k1myXOz+K0
x-ms-exchange-transport-forked: True
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="qBFTRbXYeWEbZoD0jxMhERn3F8dF4yheX"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ea99b07e-704c-45eb-eaf1-08d799afad84
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 11:40:10.7899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qqRJRwpnXzEBpomMoAcqEhnxl95ztzlZ621w1WYtek4GWrDiMVwSHYSQ3W9cBqni
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3282
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--qBFTRbXYeWEbZoD0jxMhERn3F8dF4yheX
Content-Type: multipart/mixed; boundary="JOJ5Tz5yOdw6okXBWgKQmqFooOnBoIEEy"

--JOJ5Tz5yOdw6okXBWgKQmqFooOnBoIEEy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

BTW, this patch is for v5.5-rc release.

As some GUI programs, e.g nemo from cinnamon, would check statfs result
before doing any write operation, thus could cause false early ENOSPC err=
or.

Thanks,
Qu

On 2020/1/15 =E4=B8=8A=E5=8D=8811:41, Qu Wenruo wrote:
> [BUG]
> When there are a lot of metadata space reserved, e.g. after balancing a=

> data block with many extents, vanilla df would report 0 available space=
=2E
>=20
> [CAUSE]
> btrfs_statfs() would report 0 available space if its metadata space is
> exhausted.
> And the calculation is based on currently reserved space vs on-disk
> available space, with a small headroom as buffer.
> When there is not enough headroom, btrfs_statfs() will report 0
> available space.
>=20
> The problem is, since commit ef1317a1b9a3 ("btrfs: do not allow
> reservations if we have pending tickets"), we allow btrfs to over commi=
t
> metadata space, as long as we have enough space to allocate new metadat=
a
> chunks.
>=20
> This makes old calculation unreliable and report false 0 available spac=
e.
>=20
> [FIX]
> Don't do such naive check anymore for btrfs_statfs().
> Also remove the comment about "0 available space when metadata is
> exhausted".
>=20
> Please note that, this is a just a quick fix. There are still a lot of
> things to be improved.
>=20
> Fixes: ef1317a1b9a3 ("btrfs: do not allow reservations if we have pendi=
ng tickets")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/super.c | 21 ---------------------
>  1 file changed, 21 deletions(-)
>=20
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index f452a94abdc3..ca1a26b3e884 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2018,8 +2018,6 @@ static inline int btrfs_calc_avail_data_space(str=
uct btrfs_fs_info *fs_info,
>   * algorithm that respects the device sizes and order of allocations. =
 This is
>   * a close approximation of the actual use but there are other factors=
 that may
>   * change the result (like a new metadata chunk).
> - *
> - * If metadata is exhausted, f_bavail will be 0.
>   */
>  static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  {
> @@ -2034,7 +2032,6 @@ static int btrfs_statfs(struct dentry *dentry, st=
ruct kstatfs *buf)
>  	unsigned factor =3D 1;
>  	struct btrfs_block_rsv *block_rsv =3D &fs_info->global_block_rsv;
>  	int ret;
> -	u64 thresh =3D 0;
>  	int mixed =3D 0;
> =20
>  	rcu_read_lock();
> @@ -2089,24 +2086,6 @@ static int btrfs_statfs(struct dentry *dentry, s=
truct kstatfs *buf)
>  	buf->f_bavail +=3D div_u64(total_free_data, factor);
>  	buf->f_bavail =3D buf->f_bavail >> bits;
> =20
> -	/*
> -	 * We calculate the remaining metadata space minus global reserve. If=

> -	 * this is (supposedly) smaller than zero, there's no space. But this=

> -	 * does not hold in practice, the exhausted state happens where's sti=
ll
> -	 * some positive delta. So we apply some guesswork and compare the
> -	 * delta to a 4M threshold.  (Practically observed delta was ~2M.)
> -	 *
> -	 * We probably cannot calculate the exact threshold value because thi=
s
> -	 * depends on the internal reservations requested by various
> -	 * operations, so some operations that consume a few metadata will
> -	 * succeed even if the Avail is zero. But this is better than the oth=
er
> -	 * way around.
> -	 */
> -	thresh =3D SZ_4M;
> -
> -	if (!mixed && total_free_meta - thresh < block_rsv->size)
> -		buf->f_bavail =3D 0;
> -
>  	buf->f_type =3D BTRFS_SUPER_MAGIC;
>  	buf->f_bsize =3D dentry->d_sb->s_blocksize;
>  	buf->f_namelen =3D BTRFS_NAME_LEN;
>=20


--JOJ5Tz5yOdw6okXBWgKQmqFooOnBoIEEy--

--qBFTRbXYeWEbZoD0jxMhERn3F8dF4yheX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4e+hcACgkQwj2R86El
/qg87Qf9HXk49OPHc8mMVYmO1LUCusDFGVyTtsShVUYE6rj/FqNLIfjB8VpPcBqr
NnFQZo1HtofREcElblLhDxUCvbA3UjtoRf9fsxul+9ebn/izyMz4P0cPidUeP/PL
mYz21OG/M49nmy9jfkPSrQZ7f68nHXKAcdJOBBZ1A4pgx3w2Z8kvgr2ru2yG7XzP
puUgCjdT0plNdDlyd65ZGFnb2LVncsl9m4Wi4G7zBYBkhtYIVJne9nfDpYv0wtrU
/wmx/mYn73I7idpbkCE26QatnN/TIz6RdE3eUcZcG7tZfz1knC3XZMVPSWvWNBVi
YDhE5rjALfRQUmZVHfeN95GUqg7LLA==
=j18B
-----END PGP SIGNATURE-----

--qBFTRbXYeWEbZoD0jxMhERn3F8dF4yheX--
