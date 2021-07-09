Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84BA3C1EA4
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 06:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhGIE4P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 00:56:15 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17599 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhGIE4P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jul 2021 00:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625806412; x=1657342412;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=w3yQ4n/2tcq9LukU5+W6oS6tMXXOF1BYyU/fSeugN0E=;
  b=dk9ZXEAckbGKpb2fxaSkMzW584Xe5QYuqRTytBkG5iYSADEMTdgRvZVE
   HGyX1wuvgSahjauXK7TMvRiGtKmNvL+/sBvvkwd25DDwssiA+qnJfo+or
   5U6oE5ahI8o0neMYX0GJSZ2zfwJMmizGdGIOKh9oegYuiiz1yF7V+7LNC
   l7/I8d08l+4dOzn9qKAPvrWhrbDYiwb+3bLFe7qzjNs63UZqerey9oLlh
   R038CU2qf2aQmAtJSIldobjDxwktePM2HOnVL9gBnTe1B+LIyq1UqjIde
   tyzFtRnSQMv6IMTY9J6pyjePehuQtJo7dCp5tEJCR7Z5OJy7mwtdTP8jU
   w==;
IronPort-SDR: I05tktduWxxjUt0jfnYWEpl91qlbxMshXtudD5RtEnBSlgYNAJERUHLNHMD2VGj2aGKNHSeUoG
 55nPB/RuxUK8TbfybJ31a8T4bHlTHWFlL8lGdVbwVzTMFLv1JTnloME46cPT/PCIqE8Ae22scH
 vEi+1k6nlahLFFBINfS24HocLd8zs1p07jVn/P8A6l8mPNAcYD1A3M4izwm4Fxa8jwB8WDNyRN
 sArAlF5vV9k4f6XRKx9jcgMAJ5W9zowmF9XbkmALhClHgMgqnlwfn1z9ymfrPO3Ke4iVckWTP7
 dmk=
X-IronPort-AV: E=Sophos;i="5.84,225,1620662400"; 
   d="scan'208";a="173370147"
Received: from mail-bn1nam07lp2044.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.44])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2021 12:53:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvISs1ZNvj8luVn7y1M3zRg9VQtM097QuKgB8woPHzZU0vv2sVo855823rLuitQoQ/NnpzmvwRwDlyauZm5PUW+4ytiRo8x44Z+tvJ8MjLJhE1Be6fuMU90iZkrcNieYaZIkUG5TZdnEAd4hcB5yUW7rIT4+6rbFRuL85qwpcA3H//En5qpRa1S6DTo7h07qtsizu5OKJfhT/OnUzO4bc8g8wrBNss8vJRBRxOSbd8qlS1ytufr/EiNrQeFitzIsYit9XlzGzaB25IVgIItWpe+fPfQzAiO6ffQawnZz/2OFI+dNBDdIM3NgLKYEilItqzb8LXoQ+swQJL28IQYr9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAu9mQ+gd+gH78118X5/XtzffAqDbHSHoNrCSLZgDpQ=;
 b=BbKqaPIn5HL0C7jQ+rNlGSMMlUMJxe62WF01LLaYitr1Wvm7Mq7+Fq3+0zkRLBJ7wqk48D9O3hwBazmrpTCBQ7HOgpGb8JRubtMXYlmn6HCX19EhRC5gyPaIldbytuWmVQnZcu5aLN9NLu9oiuIqIpCOJAqYpQrJISVXjYvmvn+Xuf/ENSZCv/wr20l64HAiRfoE9lIRFdPlauUBHct+VaPyjAA42evK4b4NmWjZhaNSl6cOeM3fAbXxvu+yzms/9WWR8H1bUb5FSxETEN6XGR+/ZP89Wgb07vo5iH77gIovYap0VYR9soaoqDbmhafKSHFtTruHrNRkPFYm9T88/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAu9mQ+gd+gH78118X5/XtzffAqDbHSHoNrCSLZgDpQ=;
 b=an2AHNJUZeNUiuQeJgJ9TW2/qQUpCKZ/Cnaqn3iLDwuIgk/akK/NeDLoSA2kR58Hna/N6wJT6RMQ3VsEEdtQ/BZ+VvdD11sgoRht1HkyXmcaFldFRCLCoDU5Bh0o2GxqmID/hlvD82Jl4UcQNn5BFUMOdW2unQvu84foc1Pn3uk=
Received: from BN6PR04MB0707.namprd04.prod.outlook.com (2603:10b6:404:d2::15)
 by BN8PR04MB6355.namprd04.prod.outlook.com (2603:10b6:408:dd::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Fri, 9 Jul
 2021 04:53:30 +0000
Received: from BN6PR04MB0707.namprd04.prod.outlook.com
 ([fe80::2dd7:4b71:80b1:9a71]) by BN6PR04MB0707.namprd04.prod.outlook.com
 ([fe80::2dd7:4b71:80b1:9a71%3]) with mapi id 15.20.4308.021; Fri, 9 Jul 2021
 04:53:24 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 1/3] block: fix arg type of bio_trim()
Thread-Topic: [PATCH 1/3] block: fix arg type of bio_trim()
Thread-Index: AQHXc/rs9j75hehid0CdbWHLvuNysqs6FLuA
Date:   Fri, 9 Jul 2021 04:53:24 +0000
Message-ID: <20210709045323.ndywpydaiu5j4bzx@naota-xeon>
References: <20210708131057.259327-1-naohiro.aota@wdc.com>
 <20210708131057.259327-2-naohiro.aota@wdc.com>
 <20210708145722.GD2610@twin.jikos.cz>
 <DM6PR04MB70816886A482C04EE21D2C5EE7189@DM6PR04MB7081.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB70816886A482C04EE21D2C5EE7189@DM6PR04MB7081.namprd04.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1e2cc04-72c7-4a48-f26a-08d942957bc4
x-ms-traffictypediagnostic: BN8PR04MB6355:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR04MB6355BCD697D26158A0A07EF68C189@BN8PR04MB6355.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6uxrBmvo4HaD8PvF85P68pudpX+ttg2GBVesc8kN8E68uK1T2Qkyz+EVQocJVzpeCSX9+u1adGu5IP7G4xOR+tKwjtzuNsRFPe6u1RqsW8mu3gws2K/o970N39IQe+z2V54KnvUAWN3HGKC1RuDFa5gK3XONbx+rfbzZLwWUI3zenXGCRp292iLbrw9YuJrx9iB4UwR5ezUPIgv0l/l+rZ1ArgN/seiVKO8FaFmtSOvmOqmIqEplWDqlZgR9GQHZTZeBVg/A/2WRC1YK8FNDOgHQp1q+ZCZZoE57rjwYpOFli/e1WJuAVtO81ZGfw28Tfy6k4d62UqIpUEk7Qf2HUQv+uo9RZkbcTSR8JOMTCS7ywGD3yNzyDcx9WBdDWDoiOaF3E8OIK6JJ8j/B+PrqjUV+OvwdLGh95nrtAB/Fvbw5Izbb58favCNzq/OIXMhFX9+I/5TwX3pKLynZ4OnYruZI92ZooYtZqRRXjmbIGk5H9De4TDoVjK+9j5IsucxLmeRX5qh1A3GiH3LcU2dlS/7pMeyEtbNSj6mjz4Zsip1yD5nuZB77jCUSGNE1p+Yf1lv/WirVwTwtFErXMdpoDQyHV0Vh1zB4+Vdnm8o0bnO61v+qIwYlO7L7rPuxPUC8Vl9uDKcFxhSciPSpS6+jhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0707.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(66946007)(64756008)(186003)(54906003)(76116006)(478600001)(5660300002)(6636002)(33716001)(122000001)(83380400001)(53546011)(38100700002)(2906002)(8676002)(71200400001)(6506007)(8936002)(26005)(4326008)(66446008)(66556008)(66476007)(91956017)(6862004)(86362001)(9686003)(6512007)(6486002)(1076003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e/etUmcMcSo7UfunB5ph9MigdzgXlue9hQnKnjeaCQZgQ0A8Q+Ws//tyLpSB?=
 =?us-ascii?Q?+A5kgutSpiyMJEHe4m/prfPgpw+CmxGtpf9dknYVN36LGKtye/ahuADg733z?=
 =?us-ascii?Q?zaYJmQhARjX0gvJed4yaEpA5bTRuoPPghh2QdhpDkeZI+PPOa1Jb6JwVLk9B?=
 =?us-ascii?Q?6q8ZukK2XwupoJS4TqR/VnNeuuuRHv7fkmqCrQvNNLtQM03PkUDqsWYI82EL?=
 =?us-ascii?Q?A48ZIS8jL3pfaIRSzVww8cB0oO3p412hJo99+hX1A15sTCpXOn/nELn1jWz4?=
 =?us-ascii?Q?+bY2PfANJrlkBlf7NoZHIckALjmdDMhBW8CfCGQ6cx2Uu9KQqscRLG5NS4XV?=
 =?us-ascii?Q?tV1rxY9zTl0eDnEKQJooyF+R2EW+AH317jtbBgIOimJKNxgS58+v0bLba7cn?=
 =?us-ascii?Q?mhjkARkc3GK/WBQfnyvq5VcvDkMfCqZRXSTD0D0nOvA+F53WRaTwx7e3k6CF?=
 =?us-ascii?Q?9TTcuI7C7bJIPSx/dtrUN0XNixiHiHnbMZz7wpR69xI7SfULWOVFDOtxLYAS?=
 =?us-ascii?Q?Y6iwGUt9U2YRJLVi0JCNtsl9BPOn5DBLgRwDhwp+0zgQLMIsIm1SqShZvI+L?=
 =?us-ascii?Q?UNU2eDky49Z5Fn/y9U70K1vmcTkRZkfeF0m6GNWzos//MVPg2JLsGEUjNODg?=
 =?us-ascii?Q?daK9w7DHRCIMb55rRQyVWd4CMm8/l8g9PEvnwDxpF+bQOIWMc6sd6Kj7K+aB?=
 =?us-ascii?Q?7UgqY5NT/fCqeMATOchTloo1AwSj+DVbKbgJjAQk1x35gegq1D7Yhr/Q1Hqp?=
 =?us-ascii?Q?csVbHjm4PbrehlIS7iHJIjiOSqEfvZuP2m7eEqMnCDipn7hC9Dgl4tnclHSU?=
 =?us-ascii?Q?Dr/aPX2oH77+qzlsBvtrJ5nLvoDFwZoG8sU5wjH750IeUVU+A2GIfLjGM7tO?=
 =?us-ascii?Q?jgEu8QHInRvbC6TlqQZYBbiGu7tee35wWIJjvNhNTFle6eUeECjueSHpIjr/?=
 =?us-ascii?Q?eI9mqM7c1sSKxBEEVvnp8oMDG+3UT+duvBKpi0w+KMEOhfp+p3kcVRv60PBe?=
 =?us-ascii?Q?1vT0FA1o8VTPBGk5Dn6ADnKB80Vs9XvF3saBIOadgCsFP4pxqOTjYhtjpxlz?=
 =?us-ascii?Q?YCv+TtfXlOAhCiHedp2Q3nCrO9P3JHehXBPzra36A9/vWTsR2MzzGRWnGGHJ?=
 =?us-ascii?Q?XVp2hxIK8NIMNYmmk4Azp+tWfjCFuWfV/Fj0udMZWzm8FHjF9NlbJR190b4E?=
 =?us-ascii?Q?yhxdmbtN+9Vp0LsAA6CbUz3BmQT/jXuGOclv3UR9+Pbraa7Sc6FAb8k+i+7w?=
 =?us-ascii?Q?M9Zl4Nt12pndQc2is5V7qm2l3W5ZKIZ6FodwZl1So0tM3jAVpFyRFJeIQ/bb?=
 =?us-ascii?Q?3spDrOVks9oCzTYPR8rN/aeCDAxvuGz+dhIxlkOvz62dbA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7328CF22DBAF364EACB3D773F59EE088@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR04MB0707.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e2cc04-72c7-4a48-f26a-08d942957bc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 04:53:24.2681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GCjLPXidjthxwAiS2q1n+P+rBmd4mD4+WTcJzPLu+dEVw2/ZCaz3EVN+hLMgwdPU9WbEQpuPav5MwRQDl5/bxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6355
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 09, 2021 at 12:42:04AM +0000, Damien Le Moal wrote:
> On 2021/07/09 0:00, David Sterba wrote:
> > On Thu, Jul 08, 2021 at 10:10:55PM +0900, Naohiro Aota wrote:
> >> From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> >>
> >> The function bio_trim has offset and size arguments that are declared
> >> as int.
> >>
> >> The callers of this function uses sector_t type when passing the offse=
t
> >> and size e,g. drivers/md/raid1.c:narrow_write_error() and
> >> drivers/md/raid1.c:narrow_write_error().
> >>
> >> Change offset & size arguments to sector_t type for bio_trim().
> >>
> >> Tested-by: Naohiro Aota <naohiro.aota@wdc.com>
> >> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> >> ---
> >>  block/bio.c         | 2 +-
> >>  include/linux/bio.h | 2 +-
> >>  2 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/block/bio.c b/block/bio.c
> >> index 44205dfb6b60..d342ce84f6cf 100644
> >> --- a/block/bio.c
> >> +++ b/block/bio.c
> >> @@ -1465,7 +1465,7 @@ EXPORT_SYMBOL(bio_split);
> >>   * @offset:	number of sectors to trim from the front of @bio
> >>   * @size:	size we want to trim @bio to, in sectors
> >>   */
> >> -void bio_trim(struct bio *bio, int offset, int size)
> >> +void bio_trim(struct bio *bio, sector_t offset, sector_t size)
> >=20
> > sectort_t seems to be the right one, there are << 9 in the function so
> > that could lead to some bugs if the offset and size are at the boundary=
.
>=20
> Need to add an overflow check:
>=20
> size <<=3D 9;
> ...
> bio->bi_iter.bi_size =3D size;
>=20
> bi_size is "unsigned int" so if "size << 9" is larger than UINT_MAX, thin=
gs will
> break in ugly ways. And since trim is a hint to the device, in case of ov=
erflow,
> the BIO size should probably simply be set to 0, with a WARN_ON signaling=
 it.

I'll add the following (fixed) WARN_ON to check it.

# I thought I could use ASSERT everywhere but actually it's from
# btrfs...

This function is not about TRIM command, but to trim a bio. So the
size overflow is invalid.

> Note that the potential overflow already exists with the current code as =
the BIO
> size can be less than requested or 0 if size <<9 overflows the int type..=
.

Ah, yeah. So the sanity check (with comment style fix) should be like this.

diff --git a/block/bio.c b/block/bio.c
index d342ce84f6cf..3fb2f1d7bb69 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1467,10 +1467,18 @@ EXPORT_SYMBOL(bio_split);
  */
 void bio_trim(struct bio *bio, sector_t offset, sector_t size)
 {
-	/* 'bio' is a cloned bio which we need to trim to match
-	 * the given offset and size.
+	const sector_t uint_max_sectors =3D UINT_MAX << SECTOR_SHIFT;
+
+	/*
+	 * 'bio' is a cloned bio which we need to trim to match the given
+	 * offset and size.
 	 */
=20
+	/* sanity check */
+	if (WARN_ON(offset > uint_max_sectors && size > uint_max_sectors) ||
+	    WARN_ON(offset + size > bio->bi_iter.bi_size))
+		return;
+
 	size <<=3D 9;
 	if (offset =3D=3D 0 && size =3D=3D bio->bi_iter.bi_size)
 		return;

> >=20
> >>  {
> >>  	/* 'bio' is a cloned bio which we need to trim to match
> >>  	 * the given offset and size.
> >> diff --git a/include/linux/bio.h b/include/linux/bio.h
> >> index a0b4cfdf62a4..fb663152521e 100644
> >> --- a/include/linux/bio.h
> >> +++ b/include/linux/bio.h
> >> @@ -379,7 +379,7 @@ static inline void bip_set_seed(struct bio_integri=
ty_payload *bip,
> >> =20
> >>  #endif /* CONFIG_BLK_DEV_INTEGRITY */
> >> =20
> >> -extern void bio_trim(struct bio *bio, int offset, int size);
> >> +void bio_trim(struct bio *bio, sector_t offset, sector_t size);
> >=20
> > You may want to keep the extern for consistency in that file, though
> > it's not necessary for the prototype.
> >=20
> > The patch is simple I can take it through the btrfs tree with the other
> > fixes unless there are objections.
> >=20
>=20
>=20
> --=20
> Damien Le Moal
> Western Digital Research=
