Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D21D1B73F4
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Sep 2019 09:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbfISHVZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Sep 2019 03:21:25 -0400
Received: from m9a0002g.houston.softwaregrp.com ([15.124.64.67]:58977 "EHLO
        m9a0002g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727435AbfISHVZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Sep 2019 03:21:25 -0400
Received: FROM m9a0002g.houston.softwaregrp.com (15.121.0.190) BY m9a0002g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Thu, 19 Sep 2019 07:20:23 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 19 Sep 2019 07:19:55 +0000
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (15.124.8.13) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 19 Sep 2019 07:19:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MB0cjXqyBNMdWb0b+XVRQwJ/wSj8zoZ3rhwBEGJX8UxSGTGNjosP8j5sEPiEVaSTyY5IMvD9DpFf5BvGEFDt6stmrwKtUHQHWH/yB6M1kL3fZ8+O2wjyXPysMDwGMHekZuSEcdsQFLW+miBp6pxnGMZxIv9fFfJ8x1FwGEcBF08cUwAgYqW4b5MEjELt8C/aZoPQ2snleIiBq+/IGHknsGlub3IZZmK5gUMbq0VnK6n+7GA9EOhA7VLlXYu/kNt1MB42aHUQURGek0kiNpdXGg664ujN+O/4yF9CmfLVEtaUFFaZiYuWwVTgbPElT0HM1CQIlpuTGxRufs/PPCaHMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkFly++jVEF68O0fIyRl2hLgBgmqPg7TX4YUkU6G/+I=;
 b=nhFKcvczEyDS9/nobpGs0eq6vggLX+rRfBqN6Ey2733VvOY5GBpOTQsDH2hCZCqS6oJH/s7lPamTxyN8CIfmJ95lEQw/5u9+5GGcYa9RnjcH9a1rprY912lZ4/+y6EAobvOjIY4OOK9vw2PAvkdK3CZdjDgIcz/W+tHVFj/rBe7PQ8AaShHBZDbfrkfd9OsiYLDGqNtAmGpPcrJKcKNEi91c8R74om6LqYcrVF8R49Aj0m7VzMy0l2l+0NllVzxm68AQSUo66Ho52hBXcPHJgeiho/F/WnludPITcNvT5tXi2zvlm1Uoyi4nECjbX6oRbga+/A0kbkMMLtvtxzoZPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3396.namprd18.prod.outlook.com (10.255.138.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 19 Sep 2019 07:19:48 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::3993:1f66:bd4:83cc]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::3993:1f66:bd4:83cc%5]) with mapi id 15.20.2263.023; Thu, 19 Sep 2019
 07:19:48 +0000
From:   WenRuo Qu <wqu@suse.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2.1 00/10] btrfs-progs: image: Enhancement with new data
 dump feature
Thread-Topic: [PATCH v2.1 00/10] btrfs-progs: image: Enhancement with new data
 dump feature
Thread-Index: AQHVbrqeG5ki3Ct79ki9jQbiiHnHHw==
Date:   Thu, 19 Sep 2019 07:19:48 +0000
Message-ID: <8e533879-f048-fd28-6d88-2222a4c8f019@suse.com>
References: <20190704061103.20096-1-wqu@suse.com>
In-Reply-To: <20190704061103.20096-1-wqu@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: TY2PR0101CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::25) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [13.231.109.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c337049-61aa-42f1-9a42-08d73cd1c102
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(49563074)(7193020);SRVR:BY5PR18MB3396;
x-ms-traffictypediagnostic: BY5PR18MB3396:
x-microsoft-antispam-prvs: <BY5PR18MB33962AC7C3CF2638AB0EABA4D6890@BY5PR18MB3396.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(54534003)(189003)(199004)(2616005)(476003)(229853002)(11346002)(66066001)(446003)(305945005)(25786009)(14454004)(6246003)(486006)(36756003)(7736002)(5640700003)(478600001)(6486002)(71200400001)(6512007)(6436002)(6916009)(14444005)(71190400001)(86362001)(8676002)(81156014)(81166006)(8936002)(2501003)(256004)(99286004)(2906002)(5660300002)(316002)(66616009)(52116002)(2351001)(3846002)(99936001)(64756008)(66556008)(31696002)(102836004)(386003)(66446008)(26005)(66476007)(6116002)(186003)(6506007)(66946007)(76176011)(31686004);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3396;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: naXQi+XHIr2tNHMf8lyd1b9U1EmCoKKzeqVxaQfqwLDGpdpKL7GZF272nIgrK81ed1cgQQc0oTQbwPm5qcj/Lnrv8hp5Y94/R0m90/jPkIAVZDuYD7FcEJIikqdgXFo9aRt/kwsEePmNWsY18FDA2uidd5v+0XyJfdBYbekvp7lAWsJTWYT3RjpNy1vxAMPxpGr0XnwdHEyoIcz+apEfIb2BQ7EIyAtwOfNpls6NPUOpZ8KMC5wfm+J7KUOMYVSgS3AUhfoztFXdfxIbUjeVQBmcJKst+n80VlKfGhS31KOLFGmDLKBAzb6RJY/sFVwQ2FlgewvsliOgRX2SXS59L53akGZtZWF5oB4u90M3BcefTNoShbDS0dRKoP7k9uGYuU/soI8WndP6K3Cvs3I/HrYZNY09+6wpPbE5sTjnd6c=
x-ms-exchange-transport-forked: True
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="sTnhQjlQ97Af4MJBn4tJhMiMI5Ni18uZt"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c337049-61aa-42f1-9a42-08d73cd1c102
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 07:19:48.7514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s7rnveMr7MTNIUb715RKwB0WXV70wOSqHu3KA6ERNV34/Gt78XJfTbAtIWquZmwH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3396
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--sTnhQjlQ97Af4MJBn4tJhMiMI5Ni18uZt
Content-Type: multipart/mixed; boundary="ZvAUyehlJ6alCGfiHOBmnFW7InifzeYjK"

--ZvAUyehlJ6alCGfiHOBmnFW7InifzeYjK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Gentle ping?

This feature should be pretty useful for both full fs backup and debug
purpose.

Any feedback?
It can still be applied to latest stable branch without any conflict.

Thanks,
Qu

On 2019/7/4 =E4=B8=8B=E5=8D=882:10, Qu Wenruo wrote:
> This updated patchset is rebased on devel branch, whose HEAD is:
> commit 73289664917ad7c73f3f3393593e93a118228ad8 (david/devel)
> Author: David Sterba <dsterba@suse.com>
> Date:   Thu Jul 4 01:42:15 2019 +0200
>=20
>     btrfs-progs: kerncompat: define __always_inline conditionally
>=20
> This updated patchset includes the following features:
>=20
> - Small fixes to improve btrfs-image error report
>   * Output error message for chunk tree build error
>   * Fix error output to show correct return value
>   Patch 1 and 2.
>=20
> - Reduce memory usage when decompress super block
>   Independent change, for current btrfs-image, it will reduce buffer
>   size from 256K to fixed 4K.
>   Patch 3.
>=20
> - Rework how we search chunk tree blocks
>   Instead of iterating clusters again and again for each chunk tree
>   block, record system chunk array and iterate clusters once for all
>   chunk tree blocks.
>   This should reduce restore time for large image dump.
>   Patch 4, 5 and 6.
>=20
> - Introduce data dump feature to dump the whole fs.
>   This will introduce a new magic number to prevent old btrfs-image to
>   hit failure as the item size limit is enlarged.
>   Patch 7 and 8.
>=20
> - Reduce memory usage for data dump restore
>   This is mostly due to the fact that we have much larger
>   max_pending_size introduced by data dump(256K -> 256M).
>   Using 4 * max_pending_size for each decompress thread as buffer is wa=
y
>   too expensive now.
>   Use proper inflate() to replace uncompress() calls.
>   Patch 9 and 10.
>=20
> Changelog:
> v2:
> - New small fixes:
>   * Fix a confusing error message due to unpopulated errno
>   * Output error message for chunk tree build error
>  =20
> - Fix a regression of previous version
>   Patch "btrfs-progs: image: Rework how we search chunk tree blocks"
>   deleted a "ret =3D 0" line which could cause false early exit.
>=20
> - Reduce memory usage for data dump
>=20
> v2.1:
> - Rebased to devel branch
>   Removing 4 already merged patches from the patchset.
>=20
> - Re-order the patchset
>   Put small and independent patches at the top of queue, and put the
>   data dump related feature at the end.
>=20
> - Fix -Wmaybe-uninitialized warnings
>   Strangely, D=3D1 won't trigger these warnings thus they sneak into v2=

>   without being detected.
>=20
> - Fix FROM: line
>   Reverted to old smtp setup. The new setup will override FROM: line,
>   messing up the name of author.
>=20
> Qu Wenruo (10):
>   btrfs-progs: image: Output error message for chunk tree build error
>   btrfs-progs: image: Fix error output to show correct return value
>   btrfs-progs: image: Don't waste memory when we're just extracting
>     super block
>   btrfs-progs: image: Allow restore to record system chunk ranges for
>     later usage
>   btrfs-progs: image: Introduce helper to determine if a tree block is
>     in the range of system chunks
>   btrfs-progs: image: Rework how we search chunk tree blocks
>   btrfs-progs: image: Introduce framework for more dump versions
>   btrfs-progs: image: Introduce -d option to dump data
>   btrfs-progs: image: Reduce memory requirement for decompression
>   btrfs-progs: image: Reduce memory usage for chunk tree search
>=20
>  image/main.c     | 866 +++++++++++++++++++++++++++++++++++------------=

>  image/metadump.h |  13 +-
>  2 files changed, 654 insertions(+), 225 deletions(-)
>=20


--ZvAUyehlJ6alCGfiHOBmnFW7InifzeYjK--

--sTnhQjlQ97Af4MJBn4tJhMiMI5Ni18uZt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2DLAoACgkQwj2R86El
/qhq5wf/eG5H76ZtZtQY9PRSEI9ZSMlVZgbL7vpT6QNZVD6vF/DD6n2A/p7p53bj
3aWUfmk88pml0kDXGyN423AGL3G24SKhqsk81o0nmvgaRbRbkDFYWMLcMj2Opldw
Aat8Cazq4rWCIsgqE2EiX8azPSkktYmtpKaUt762Byz83dpzJUFROQqMsWf/a3EF
HuOlLZklOziRnF4P6h8maHeZ+O9/gxPb4qMxOEt8FjAuZTaqqAsgOH7yZJ/o6Kxy
sA4rHBth9iwhdg3MXURVfH6m/eRPFYp/6UK6G+3Ot5g3eRt/KDJoG2vZfNIVbAC3
UFrmf/uaNWbgKCTab1D8sLPH60IcHw==
=Z78y
-----END PGP SIGNATURE-----

--sTnhQjlQ97Af4MJBn4tJhMiMI5Ni18uZt--
