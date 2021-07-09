Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABBB3C1E85
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 06:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhGIEmd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 00:42:33 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:5627 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhGIEmc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jul 2021 00:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625805604; x=1657341604;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UFtWt2LKJ5HJlY+tV/Zxv7nQTo2WqriAWT6vyPTBm9k=;
  b=GGJ617QnrNTurbZDpkxzgReMOhqYDhNtcLVpe7u3OyxUwc3eCqm3EbJc
   00rpW7Ko8tSMNDffBe6w7sJqjGSCDboehAwDurWhvs1jZI8rvYykM/2SU
   bCtVxXE+e7weYsH8kVhJRW9KA8cX3GOQxXlXYZoFZDubMLpHYYZHL1o1I
   pzKonm1BUS+jV24soO3A4TD/vqBkU2PKbGiIcvpGl4M3UdTpmgDQGFG6q
   w08ALfX9baJpL0Z+eszAMCwuIUBJVbGFz55CzvcJKbpdq89AjxWeheRux
   xai+TqKIQ7jz28bU4IJEhPTWEBlQO9aKKWtMwpdDBlxvBD/ewuDL2YHXM
   A==;
IronPort-SDR: TDtdPfKCG6LqLJlyDBJlT/rBf8v5JL3XcyIrLf5kGb3PTXQ7gG6zOJ47eX+5UkOdq6MgT7cqDK
 lnLbt1LBuIb2cp2xQ5UtwJA38La0LEDA9O+A+nrMv5JPGcGvieJMQrQxZ2GB9MqF9Qt/r3K17U
 NpW1/kvzd0zk+fmGaG2rVbgGM2+yaH378iKplU3Z04cj3+31eQ4QGeO3Y9t4ShexuljTcaAFXJ
 1lJxMWcQKHgt2FVRXBDhEfpuZ3gbd+f621kjQQcin1mQhfX5WXucByolwxoIOXscbfCqaOpi6o
 6nw=
X-IronPort-AV: E=Sophos;i="5.84,225,1620662400"; 
   d="scan'208";a="277936056"
Received: from mail-sn1anam02lp2047.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.47])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2021 12:40:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h73IlFJaaHOcEutNqSCpErobU3xmMp7iC2/z5lU4yk6ZrUQ7Is39mm5E5BT2MmOocC3IuiKKPnsvPtT1R6BmPLZyBDg58fawSFWO2hS2bGl1IPY4f0j6m77+ofUBw6RBfRHBS9p0iilr+vGUVeshM4uak4jiW++Qb8HTLlS8c+AvGjOa5BSkRj3GBjSDFSXr4tCbMPqjiNX2l5FS+L12qyFdCcV5vdpWxao94fyAbW+xL8XHzXw75FtCinr2HaMgIrJD273dabNliFcUp+YcBII/TrxHhE/3cIl+4BB57aaTXdUFiliTb1OnPulfk1B7VpXiS4MLRE2xF8A78DF9xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtJkpU3Vwl1mC2hsPt8Z8TdSDB8nnMOIEuwpJHaoAyY=;
 b=JiwI5429uDm1hU94c8yu8Ouc9hUn4n2iOe0j3AeSrY/o6CBB946/WY4q+lnjpzZ9tLYn/Yaxs3zk1FbiTiTIkLeVD5fXrHnak1zvvXkd5YuldVQNVN2vqWE6mZi1kW4nQg8Tt5dAdE9dodfsZ/N2ZsJxnuw+AJB4rNX1yZBJxT1lvYQwNY+AoyYuuhf1KZPyrGqBXrzDJouWTNoG7y0MuakZFal+2zOQ3wx6Xg4ouX2C2SBwj7IQ1f6fKdbHe2Z+aIp39j0Ez4XMrpHtcM/UM3pFz+yjHg3UyCpoV30VuOpcxgMFqS+yMaPB3LOXoZCVJdsnBBLR4iXxFM6uk7C+qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtJkpU3Vwl1mC2hsPt8Z8TdSDB8nnMOIEuwpJHaoAyY=;
 b=WE/zn98TL6TMu8GDzKJsVYc3cXiyo9ZIaYBUFVMiPqtq4PjZUdA8W4YYLMhkLh+MHToIpNzRPVG60Px9a9+I2ip+zW4aVfZblerkoyTnbXwjW80XHJBZs12m0CfQe0Rrcuxlw8NhxHel52jiKwJVtia1D1w/I0F91U2mHN3ZEfo=
Received: from BN6PR04MB0707.namprd04.prod.outlook.com (2603:10b6:404:d2::15)
 by BN6PR04MB0357.namprd04.prod.outlook.com (2603:10b6:404:91::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Fri, 9 Jul
 2021 04:39:48 +0000
Received: from BN6PR04MB0707.namprd04.prod.outlook.com
 ([fe80::2dd7:4b71:80b1:9a71]) by BN6PR04MB0707.namprd04.prod.outlook.com
 ([fe80::2dd7:4b71:80b1:9a71%3]) with mapi id 15.20.4308.021; Fri, 9 Jul 2021
 04:39:48 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 1/3] block: fix arg type of bio_trim()
Thread-Topic: [PATCH 1/3] block: fix arg type of bio_trim()
Thread-Index: AQHXc/rs9j75hehid0CdbWHLvuNysqs5KyYAgADlyIA=
Date:   Fri, 9 Jul 2021 04:39:47 +0000
Message-ID: <20210709043947.edhwb5cj6zuf22kv@naota-xeon>
References: <20210708131057.259327-1-naohiro.aota@wdc.com>
 <20210708131057.259327-2-naohiro.aota@wdc.com>
 <20210708145722.GD2610@twin.jikos.cz>
In-Reply-To: <20210708145722.GD2610@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee7316d9-ccae-4ddc-b1fe-08d94293953b
x-ms-traffictypediagnostic: BN6PR04MB0357:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR04MB0357D631B388B155E4F9DD4B8C189@BN6PR04MB0357.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MC7UfmgGzW/bHdJjIi4XFrdk2KJtFfe9MaDBB+ZRPUeaAP4PIsHHm+5kGHe2/zaNtSrEa4J6dQ/FH7+JY4bWLNXc1lyYQYtjp3rvC6L6HlZ8dz2tbNL+C37m21aO+RrxANp/qhhNsZCM5jKHPR9abbbbpJfqYE18e/xG/j/EueYJE06Cz+e2haPt5eU+Q44UfPr3cDBO8DITA0A+cH0DKVtDEHzAv2aUds0E2Ds4o+7a3gKEIlSsWoyDjAo5oSBLcyRGKjXDQeOD1+FqXsZ2o/wdHTJPLlt/51nKIDHD3ARqVfYWdyQfBTcoIKNrEE5QigkW67rvSNEbXBDuBJs1WkLgWNZmBa3f8R0ULiki1buFExSNUY9lFQTHxNRByuvNXtnGpZpRD8kcTsDWA1MsDB7Av7t45Jc3WIP7TsuLERixGZQ07DOmkEYBSXqPn42O43oyhQGK4T2IyQldxI9yo1Omht5icPCZlBOBQTEpavtcolevB4ud40NdPnVJ24BhNB1o+yI8JnzrQ0goTvoVDSAunw1Bg+1aaM4KHdrUx3yEfs2VIK4tEzU6WE4Os8GowUPHPkHtVL+9lPSFUHCarPjfxAHm8mP2uY4RiRQ4nlYad0XR5gLczb5x1kv70BK2kqRGr1dKkyPDX9xbi7fNEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0707.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(136003)(366004)(396003)(39860400002)(376002)(346002)(54906003)(6486002)(6916009)(86362001)(9686003)(316002)(2906002)(66946007)(26005)(6512007)(1076003)(478600001)(5660300002)(33716001)(38100700002)(91956017)(6506007)(76116006)(8676002)(71200400001)(66476007)(66556008)(64756008)(186003)(66446008)(4326008)(83380400001)(8936002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J2Ft6PeTSVtTwFpyLbRERHct7+LcoAccn77naAkfP8rH9sKCCd1gR9zWDKMF?=
 =?us-ascii?Q?If41oREdc7igER/TPHd5idrBBwUhMUtFxtVc/hrKjvAPke1imY1n6cLc0OaT?=
 =?us-ascii?Q?ho9jABI87adwt0+JKcSmwiW3QvUmshUZTxQMBBSGJ51DFHSPdmU5MGRTUdtI?=
 =?us-ascii?Q?z/0ztjlX4ZGRHrs/dnxytpAslqeB7tHjO8GCLaMarVBgPrxBIkFmetsiWozj?=
 =?us-ascii?Q?V+2CLypKJCcDlCqbURDZYTiJoBQS/PXYPh2hIFS/8XXbxmpRAKmH8OMXlwp0?=
 =?us-ascii?Q?BswVQpUcWiLdINF9eNnerIZ9gjmAQpke6Wvy05zpNInv8T1tjjyBssXi1Jc4?=
 =?us-ascii?Q?AoNs2h5TTQm4BQDQvOrWOnnSMsdupJQCcdjzMaBPnzEXCU6KOnJJGS61FTb9?=
 =?us-ascii?Q?qcamu1B6bSjtQwbyEGH1Xr01ijAfHDGtSiNbVLPquoDRCPXdkSVFrpbvA433?=
 =?us-ascii?Q?Vw9lQbRRlM78q6QPM2v4LGqUgGyGWiC0h9QrgN0zjy6eDCWGKtDapBBLn91c?=
 =?us-ascii?Q?lI49IFJWs9lbdcKoQRGOnQaofmyXCWITA4mQbTmkOWIizo50eIGQXSbkycIR?=
 =?us-ascii?Q?CmIAKJDryxRu58JaRO9vOkcudPuob4jQMkzmTddIYlzF0TFVTfzKQXmo8ElP?=
 =?us-ascii?Q?tl18hbYufrybQyL02fh7Wd7AI7P6eY93VZlb64u0/PQbGHiNjJGVNBRais/p?=
 =?us-ascii?Q?eM4lVf8gW/kn/x2S4XA+cUWO4EPu50Mek4uuxDfVoYF7E0qn5J/JYMCLyf2C?=
 =?us-ascii?Q?gaBglM+XKUTOfhksfXMr7R8XjMvoTOxtpqv3IEgF6oQ5NixtYYFRplhKNvLP?=
 =?us-ascii?Q?20bJYe87D7phSTE5OBpB2AFWcAYyFEciNsnWgGbgPzSoeyIMVEE13yaTNDJq?=
 =?us-ascii?Q?JJKoGhnG2nu575XYU9Z4FH9lGkWgWTTmtg4PzUn6dkJ8UuI+p1Y9gI+RUW5W?=
 =?us-ascii?Q?4TrDxp53dJ9uTpR08d4q6mFRH7ForKA1oMjdpFz8BCaVzxAH8m9B3I+mH8u9?=
 =?us-ascii?Q?miOLXp3iMoHln2lxSYRUb1kSrcSRt/lvt196CW9Mb97uMpuf6eF48YP1yoT8?=
 =?us-ascii?Q?9p5EW6+SB/v5f9t9L2l+WM3ARuCZLUiGZ4Fls7uk8ublylEfJAerNtmbFskc?=
 =?us-ascii?Q?hzIRV/xU/FxVw6IJ74UuFeaJytjsS+LjUXaXf3lxtR5cXHnOj418O7JtrVkj?=
 =?us-ascii?Q?w/XQ/2xRZMPj3RPQBgkKOc1c5MQ4Q/8XLl/m/qAC/4pa6EcjBlXk4IqDu2bw?=
 =?us-ascii?Q?9ytOCU35YQ0SrNV/ruUr0PUdYNPZgDHOBUeM9oJtadaIjcXiC3Y6MoST2UBL?=
 =?us-ascii?Q?1i788sX83MSbXKW4qKUHLh9V?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <40B7B0742E7593439458412B382BE254@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR04MB0707.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7316d9-ccae-4ddc-b1fe-08d94293953b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 04:39:47.9979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jDTjoBSMt4gOqgx4/dhpOdGOsKKIxKCLyEp/PWraTIBfqAetSO9YmYahmW4wPztTdScPDjg3w7qo/dI7kqJcsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0357
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 08, 2021 at 04:57:22PM +0200, David Sterba wrote:
> On Thu, Jul 08, 2021 at 10:10:55PM +0900, Naohiro Aota wrote:
> > From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> >=20
> > The function bio_trim has offset and size arguments that are declared
> > as int.
> >=20
> > The callers of this function uses sector_t type when passing the offset
> > and size e,g. drivers/md/raid1.c:narrow_write_error() and
> > drivers/md/raid1.c:narrow_write_error().
> >=20
> > Change offset & size arguments to sector_t type for bio_trim().
> >=20
> > Tested-by: Naohiro Aota <naohiro.aota@wdc.com>
> > Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> > ---
> >  block/bio.c         | 2 +-
> >  include/linux/bio.h | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/block/bio.c b/block/bio.c
> > index 44205dfb6b60..d342ce84f6cf 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -1465,7 +1465,7 @@ EXPORT_SYMBOL(bio_split);
> >   * @offset:	number of sectors to trim from the front of @bio
> >   * @size:	size we want to trim @bio to, in sectors
> >   */
> > -void bio_trim(struct bio *bio, int offset, int size)
> > +void bio_trim(struct bio *bio, sector_t offset, sector_t size)
>=20
> sectort_t seems to be the right one, there are << 9 in the function so
> that could lead to some bugs if the offset and size are at the boundary.

Sure. I'll add the following ASSERT to catch the case.

diff --git a/block/bio.c b/block/bio.c
index d342ce84f6cf..54b573414126 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1467,10 +1467,14 @@ EXPORT_SYMBOL(bio_split);
  */
 void bio_trim(struct bio *bio, sector_t offset, sector_t size)
 {
+	const uint_max_sectors =3D UINT_MAX << SECTOR_SHIFT;
+
 	/* 'bio' is a cloned bio which we need to trim to match
 	 * the given offset and size.
 	 */
=20
+	ASSERT(offset <=3D uint_max_sectors && size < uint_max_sectors);
+
 	size <<=3D 9;
 	if (offset =3D=3D 0 && size =3D=3D bio->bi_iter.bi_size)
 		return;


> >  {
> >  	/* 'bio' is a cloned bio which we need to trim to match
> >  	 * the given offset and size.
> > diff --git a/include/linux/bio.h b/include/linux/bio.h
> > index a0b4cfdf62a4..fb663152521e 100644
> > --- a/include/linux/bio.h> > +++ b/include/linux/bio.h
> > @@ -379,7 +379,7 @@ static inline void bip_set_seed(struct bio_integrit=
y_payload *bip,
> > =20
> >  #endif /* CONFIG_BLK_DEV_INTEGRITY */
> > =20
> > -extern void bio_trim(struct bio *bio, int offset, int size);
> > +void bio_trim(struct bio *bio, sector_t offset, sector_t size);
>=20
> You may want to keep the extern for consistency in that file, though
> it's not necessary for the prototype.

True. Chaitanya, what is the intention of droping it? maybe just a mistake?

> The patch is simple I can take it through the btrfs tree with the other
> fixes unless there are objections.=
