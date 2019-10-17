Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A56D6DA3F9
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 04:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404162AbfJQCmC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Oct 2019 22:42:02 -0400
Received: from m9a0003g.houston.softwaregrp.com ([15.124.64.68]:55466 "EHLO
        m9a0003g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388036AbfJQCmB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Oct 2019 22:42:01 -0400
Received: FROM m9a0003g.houston.softwaregrp.com (15.121.0.190) BY m9a0003g.houston.softwaregrp.com WITH ESMTP;
 Thu, 17 Oct 2019 02:41:22 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 17 Oct 2019 02:40:20 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (15.124.72.13) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 17 Oct 2019 02:40:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpGUd3sgcYyBKHO4vlzO2wpNGU5HdeDVtdzxRyMsouok5//ch9hK5qC8JoSRqJAojgiwokChYW/5X4U2NPQyaFBKj9URzsIkCWTMeGDPapFZvp5OZiVkr7mlOY84J0RI1SgEDD74LBmFroAuiHbLPevwR2bKNjpjFIl9H5mePeiQ8zZ/UQyJ3Rq7Cwe3AmfILW4IIJEOH5o1PtWbg1UxXvuXf3bfCswKt3751bxyU8hG0yOupiNIFaJ5MS1ZyuC91SIzys28l6efRw2cU+gOo01p14HYdGaOHZbTf9VGQtsW2JA+AwF/uYrEfh8JnKHq5kCQusy+wjAlCxuMfxZQzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heVq9mHsbIwJxwQ1GsrHluwtU21ae2RP4zgSSQRVfmw=;
 b=aHWWsbg6YQvFvOAzSXvlovXH2wemW3r760WTuHA/ktEMB79p5JLGPSSuqeU/T5nKok32TzswcHXAuOkc6rKXQQp0zYMryQ8mXX/4qR3otpBZNkTwmouIIxZ92falhZbEVL5D2RbgYHfqVAv5ftyacfxG83OP3+3i6OSYtDT+lN3P9vVkQuN42EC0OZ7lXQbMSuYMWOS6OGu2JrRtUs6tSMc1rSxIiP/Vp1ib5ceApN3BRC5E4p073Jw0ICSJbRpNy6vwrLdpZHtGFsaZW8r6MBJaUYgoVqvUJqXlcHaEHsV/GkoLL3NjHPC7qEqyXvla2dTHEcU9CjQbSLusyTpCQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3188.namprd18.prod.outlook.com (10.255.138.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 17 Oct 2019 02:40:18 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::5c5:8dae:70ef:a254]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::5c5:8dae:70ef:a254%4]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 02:40:17 +0000
From:   Qu WenRuo <wqu@suse.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-devel@vger.kernel.org" 
        <linux-trace-devel@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs: qgroup: Fix wrong parameter order for trace
 events
Thread-Topic: [PATCH v2] btrfs: qgroup: Fix wrong parameter order for trace
 events
Thread-Index: AQHVhJQ277nlpWMdQ0GT/PbOGHanpQ==
Date:   Thu, 17 Oct 2019 02:40:17 +0000
Message-ID: <20d8b346-3db6-d207-00ea-8776a3f43097@suse.com>
References: <20191017022329.31545-1-wqu@suse.com>
In-Reply-To: <20191017022329.31545-1-wqu@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: TY2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:404:e2::15) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [13.231.109.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 350d73bd-c0cd-4157-4646-08d752ab5893
x-ms-traffictypediagnostic: BY5PR18MB3188:
x-microsoft-antispam-prvs: <BY5PR18MB3188BDF174CD84622455F5C9D66D0@BY5PR18MB3188.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:188;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(199004)(189003)(54534003)(81156014)(6436002)(31686004)(3846002)(81166006)(2201001)(305945005)(86362001)(99286004)(76176011)(110136005)(8936002)(52116002)(316002)(7736002)(6116002)(6246003)(31696002)(6512007)(229853002)(6486002)(8676002)(99936001)(66946007)(6506007)(446003)(102836004)(66616009)(66446008)(64756008)(66556008)(14454004)(386003)(36756003)(26005)(186003)(14444005)(11346002)(476003)(2616005)(486006)(450100002)(2906002)(66476007)(5660300002)(71200400001)(25786009)(478600001)(71190400001)(256004)(2501003)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3188;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AU37BYv0xwZmMTws4o+vgUszzIUeKhOiXXyyUuBBCyzY4Mge5TkslUtxhVW+99ZhZjMtf3UKp4ETpd1CTrQE+vj4NjajPZNq/rzwaM8DVlETHgYZDRtILBroTycxe6E2A9Mmy6wV6FY7w2aSLeSVVFH/+d5fpzzjV1ZLeBUE5UsttTYNVxvO5jWDpZmAxg0RkWzL4PEYxa4o29Tyr18gP0pu8Qf9E7Q+yunfo1aHZ7Aav+TGvozG29NFqZr9yvmM5gaDm4sn4UK1tq4mgbhtFJOZccBbgLQGerMhD8pUjL4Ke31YWQdMOxTxy3MHuJL+yPS47ctiaNkg65DCdT21TD48vzfXAhS3PDILBmmO3Ldahby1AWH+DO3gTgSLz1qPOREmLS30zyqoGwJT1g9aVJdhxCJrgbJhcRoriDy1vrQ=
x-ms-exchange-transport-forked: True
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="yXxxrWGaCDJhogUZ3FUjlyn2GAkFVABYH"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 350d73bd-c0cd-4157-4646-08d752ab5893
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 02:40:17.7894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VGYE61kgjwz0MmPCvM8JmgtmJ8erc43x1KuVnEwjmS94Ar+CZfpBZdlWTzFdlc+G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3188
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--yXxxrWGaCDJhogUZ3FUjlyn2GAkFVABYH
Content-Type: multipart/mixed; boundary="JQR14woZQSaqcIuTReaJqSLCSdK2GsPPk"

--JQR14woZQSaqcIuTReaJqSLCSdK2GsPPk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Please discard this patch.
It's sent out by accident.

The correct one is only sent to btrfs mail list.

Thanks,
Qu

On 2019/10/17 =E4=B8=8A=E5=8D=8810:23, Qu Wenruo wrote:
> [BUG]
> For btrfs:qgroup_meta_reserve event, the trace event can output garbage=
:
> qgroup_meta_reserve: 9c7f6acc-b342-4037-bc47-7f6e4d2232d7: refroot=3D5(=
FS_TREE) type=3DDATA diff=3D2
> qgroup_meta_reserve: 9c7f6acc-b342-4037-bc47-7f6e4d2232d7: refroot=3D5(=
FS_TREE) type=3D0x258792 diff=3D2
>=20
> Since we're in qgroup_meta_reserve() trace event, the @type should neve=
r
> be DATA, while diff must be aligned to sectorsize (4K in this case).
>=20
> Only UUID and refroot is correct.
>=20
> [CAUSE]
> There are two causes for this bug:
>=20
> - Bad parameter order
>   For trace event btrfs:qgroup_meta_reserve, we're passing wrong
>   parameters.
>=20
>   The correct parameters are:
>   struct btrfs_root, s64 diff, int type.
>=20
>   However the used order is:
>   struct btrfs_root, int type, s64 diff.
>=20
> - @type is not even assigned
>   What I was doing !? /facepalm
>=20
> [FIX]
> Fix the super stupid bug.
>=20
> Now everything works fine:
> qgroup_meta_reserve: 0477ad60-9aeb-4040-8a03-1900844d46ba: refroot=3D5(=
FS_TREE) type=3DMETA_PERTRANS diff=3D81920
> qgroup_meta_reserve: 0477ad60-9aeb-4040-8a03-1900844d46ba: refroot=3D5(=
FS_TREE) type=3DMETA_PREALLOC diff=3D16384
> qgroup_meta_reserve: 0477ad60-9aeb-4040-8a03-1900844d46ba: refroot=3D5(=
FS_TREE) type=3DMETA_PREALLOC diff=3D0
> qgroup_meta_reserve: 0477ad60-9aeb-4040-8a03-1900844d46ba: refroot=3D5(=
FS_TREE) type=3DMETA_PREALLOC diff=3D16384
> qgroup_meta_reserve: 0477ad60-9aeb-4040-8a03-1900844d46ba: refroot=3D5(=
FS_TREE) type=3DMETA_PREALLOC diff=3D-16384
> qgroup_meta_reserve: 0477ad60-9aeb-4040-8a03-1900844d46ba: refroot=3D5(=
FS_TREE) type=3DMETA_PREALLOC diff=3D16384
> qgroup_meta_reserve: 0477ad60-9aeb-4040-8a03-1900844d46ba: refroot=3D5(=
FS_TREE) type=3DMETA_PREALLOC diff=3D-16384
> qgroup_meta_reserve: 0477ad60-9aeb-4040-8a03-1900844d46ba: refroot=3D5(=
FS_TREE) type=3DMETA_PREALLOC diff=3D16384
> qgroup_meta_reserve: 0477ad60-9aeb-4040-8a03-1900844d46ba: refroot=3D5(=
FS_TREE) type=3DMETA_PREALLOC diff=3D-16384
>=20
> Fixes: 4ee0d8832c2e ("btrfs: qgroup: Update trace events for metadata r=
eservation")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Use more accurate comment about the fintuning options
> - Use more elegant method to output uuid
> ---
>  fs/btrfs/qgroup.c            | 4 ++--
>  include/trace/events/btrfs.h | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index c4bb69941c77..3ad151655eb8 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -3629,7 +3629,7 @@ int __btrfs_qgroup_reserve_meta(struct btrfs_root=
 *root, int num_bytes,
>  		return 0;
> =20
>  	BUG_ON(num_bytes !=3D round_down(num_bytes, fs_info->nodesize));
> -	trace_qgroup_meta_reserve(root, type, (s64)num_bytes);
> +	trace_qgroup_meta_reserve(root, (s64)num_bytes, type);
>  	ret =3D qgroup_reserve(root, num_bytes, enforce, type);
>  	if (ret < 0)
>  		return ret;
> @@ -3676,7 +3676,7 @@ void __btrfs_qgroup_free_meta(struct btrfs_root *=
root, int num_bytes,
>  	 */
>  	num_bytes =3D sub_root_meta_rsv(root, num_bytes, type);
>  	BUG_ON(num_bytes !=3D round_down(num_bytes, fs_info->nodesize));
> -	trace_qgroup_meta_reserve(root, type, -(s64)num_bytes);
> +	trace_qgroup_meta_reserve(root, -(s64)num_bytes, type);
>  	btrfs_qgroup_free_refroot(fs_info, root->root_key.objectid,
>  				  num_bytes, type);
>  }
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.=
h
> index 5df604de4f11..0ebcaa153f93 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -1710,6 +1710,7 @@ TRACE_EVENT(qgroup_meta_reserve,
>  	TP_fast_assign_btrfs(root->fs_info,
>  		__entry->refroot	=3D root->root_key.objectid;
>  		__entry->diff		=3D diff;
> +		__entry->type		=3D type;
>  	),
> =20
>  	TP_printk_btrfs("refroot=3D%llu(%s) type=3D%s diff=3D%lld",
>=20


--JQR14woZQSaqcIuTReaJqSLCSdK2GsPPk--

--yXxxrWGaCDJhogUZ3FUjlyn2GAkFVABYH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2n1IcACgkQwj2R86El
/qhxMwf9HyXFoliy4C5Tr4B8/Lm7ZowS4DhAP9bH7CVXdFElJ3L42XqPJYcBT3BC
fIQLLGjyVP7pu5Oj3HkdkEf4jkxQPFSNpYVMZ1JB3YNQFEkqWety8CEIHEOUxn65
iggGRHc7RMdYw5hSngUyDU+0MGFALHnPsTmeV/knzkoBZPS6MxP4HdscgmrgkPY1
ZCx62EWN79DTSMGG5OTz7Lgj94FMPOLdPAYrK1YTLHLYtx7hf38Uee17+J7TCbuN
lu/V0A1v18j1bim01umex5iF9A6Djfxu3lIbZLIeEEJ8dUPk93K8IvSGkahTO4NZ
l1v4pa84fgHjcEojXVbw7t8d6RqOjw==
=tikh
-----END PGP SIGNATURE-----

--yXxxrWGaCDJhogUZ3FUjlyn2GAkFVABYH--
