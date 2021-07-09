Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37FBA3C1EB8
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 07:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhGIFEX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 01:04:23 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:43296 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhGIFEX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jul 2021 01:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625806899; x=1657342899;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=V76ruzJqzEtTt4x4WIUXWvUqvCKz4QSILG+l+uMcBZ4=;
  b=Ky9VzNoLFFNoHuLRAAB7Vkngd6SpmVAPr8LPLDk+muB7Y/QG2Abv2aft
   iiK98fKJkpDPcBjLXrNJ4Qu95E1xO5BSFZZvVs2ObYNCcyY75uzPOzyEN
   s0H94M6N35HzGwNqirgxjgkjR+slDa3l+x99VV5zt67u769UuL7RkewXM
   8+PbbMQsOARHWLVwOg+sDP7TWwQOuXtipCKzuHCQMA+w0ny25EqFywh0q
   bU3KM3ZVSpePrr4iyJUqZVR/0/eq4pSnenj61Z0wjEIOhS6uwJ3BOUBF4
   KKp3SFGLOSSXqfRzvcrNK+rntF951sQy7hSWqMtuY36YJiSktGer5lPzD
   w==;
IronPort-SDR: Mj4btQofMPLEpEQksyowh0rackN0q11l/0LP3rK30GEoT3cFRzL24jwcmnCf2FqtGsInZ/A47y
 RZwbuPJxjp6SIY+WP1GsY8b2igv16L+owfvo1LGQMThaJOl52ACP0m3Ky7LpWZKa20QUYubP0w
 Zl25zicuRPOC/0bidU5L/Dd3DOlcBnSQc6ISz/6wLmJA1c2Qz6ia9xXroZTklovVm+45bTkLou
 QXTmYaz3u2Z0it4jyaxwGJpNn8PQIEzGjHuJ3opxRV42cEOr2GLNqv9/sKj4sp8vLdTpFJ/2Mr
 RyQ=
X-IronPort-AV: E=Sophos;i="5.84,226,1620662400"; 
   d="scan'208";a="178936006"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2021 13:01:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROIMt3yam/5ZdiejGLTxJJ6wVbVYkxYln01pR9ytM1Gn7At/BJiD6etxvB/8CL5jS4ZwbPFgp8JkDLXapl+sicU8QpgJZGguDfDjhopBYQ1zXXe1J4JT5FjmbxhZibK/bNBaMFFH6siEdfTMUPplklXnfrKoM+xXdXgcTlgXJp6RC+VxZfVQ2a11HJpnGWcw3UNwk5xDhZzKsICl0ljndEWK1RkhXtJrb6CT7JWP50wZrE/98oc5XbBgPeICK8Cal4FeT1T2K+YAK4l9WI+JveXMbh2s/z0GZzYXxBfTQ238qvLsk+9IXDf4s6Q4TPkRtx4Osd4wRTzrF+JwCwMCsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FclcawyNYZms2X6fqwcfB+g2ObPnIvEnE9xdl2UtwMw=;
 b=C09ocy1NU9C2pIe0cj47qoWQsK0hL5gjdp/9h1K5CSDrbKitXD70B8pV0IHeuv/mC+TJsXvyUnHfxlkuitv+tlBuZQBS2quXBOuVw9VS+sOdu1jpbU4vysXAQOHAJV2TJSqFFfv+9gUkN1JITgfVeK5Lr3bgPi840H5pLWlKwSyYCsK4MLbTFWiN4l/XK6Ohk/NKT6j2PO1KK8TbMFR+/QXWo/7imsA4TcyrmdNbRzjZVkq72U0IRReh2QRcqEmvl0Eb+yK60FW4i/2SyIn9XhHp0Mw6/75OQQvXiB5y0j9Mhqc5pO9Wa84oFseSdVRw/geRPa9rGSujCRGt+Qf1WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FclcawyNYZms2X6fqwcfB+g2ObPnIvEnE9xdl2UtwMw=;
 b=tQdY8hSa3lItL4zCuWKBs3cKige9kjc3zVIZUwT3qZjsDyKwPsZneRgXDqkyZkhR7XRpae/ffe6tUhYummUMZvTn4nBLN+IrO8m7YMJkzyYKwh6quaqH5OFQOHHc/FOzVMYqJ4bWisbjeK3YgzPCNB1zz545EajGh0+enG0wfmc=
Received: from BN6PR04MB0707.namprd04.prod.outlook.com (2603:10b6:404:d2::15)
 by BN6PR04MB0356.namprd04.prod.outlook.com (2603:10b6:404:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Fri, 9 Jul
 2021 05:01:38 +0000
Received: from BN6PR04MB0707.namprd04.prod.outlook.com
 ([fe80::2dd7:4b71:80b1:9a71]) by BN6PR04MB0707.namprd04.prod.outlook.com
 ([fe80::2dd7:4b71:80b1:9a71%3]) with mapi id 15.20.4308.021; Fri, 9 Jul 2021
 05:01:38 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 2/3] btrfs: fix argument type of btrfs_bio_clone_partial()
Thread-Topic: [PATCH 2/3] btrfs: fix argument type of
 btrfs_bio_clone_partial()
Thread-Index: AQHXc/rtivEKh00VUUeSNzU4etMYM6s5LACAgADrCIA=
Date:   Fri, 9 Jul 2021 05:01:37 +0000
Message-ID: <20210709050137.63mo3vvf7f6wb46g@naota-xeon>
References: <20210708131057.259327-1-naohiro.aota@wdc.com>
 <20210708131057.259327-3-naohiro.aota@wdc.com>
 <20210708150025.GE2610@twin.jikos.cz>
In-Reply-To: <20210708150025.GE2610@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21a792f1-44e9-46b5-cd32-08d94296a201
x-ms-traffictypediagnostic: BN6PR04MB0356:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR04MB0356FC476AC2979136B621908C189@BN6PR04MB0356.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lPGE+3AfhzTqxhgCAlmLjGH7gcWVc/RL4VDjWK8RljtwM/kV0h3B9TDFxk5dH8h28wic8PgzFeTH81cdl7YojK6Yf6stgmzg8FJ5KTeUmR6dhMNCykARFjMFvgu9T7gn0qDZnx4VYoM0mQl8xI0b8MuBg8e4mn4+rxpQ2L7MrRoOHK9DJRoNn/RRBlqY7q/evGNFcMr4UsFS3oxQhO8kMlAu6Q5rL2yU+H7UH1un8IdoHGJgpripSSMwtr3R6fmxK9M8w03CG3XT63MvPqCsJJ6duDID/1ia2BPaqT76qcbRJTv2G48Pb0tWYtMJze+sO43o5fpTfiM8SWlxFJpE/iDuPW8zSmnltXvbZ/F00EXijwJRtwh12K8pUx5y6N+IfYQzBY7+/lClucDJP+ycna5aDNlCrR0I9TLC+jNvtUoUji49TkeBxs9yvL5zaikJjXI20XBsRvAmBbyG7lvs9zmz2fmHUxD9FdkCggUhwbjQUxAUWa9y9S2fjZfYnh4LDyOCP3mVuzxyfMHd6MS2IQwGu1VsI5LJmJWzmMweb9jVasD6Ifgdth0KloPAsQ2DMPdv9x0qOjWxrFy/+kzVJVsed4t7NdCgovnAT+oPa8oAYlUEj6VXg5zNrrevzY1ZFIZUNj2i6MMnDumhSL9U5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0707.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(54906003)(66946007)(4326008)(76116006)(91956017)(86362001)(6506007)(33716001)(66476007)(316002)(478600001)(64756008)(6512007)(66556008)(83380400001)(186003)(5660300002)(26005)(6486002)(6916009)(8936002)(8676002)(71200400001)(1076003)(122000001)(2906002)(38100700002)(9686003)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JXaBSscR7WyLjxRJLxFhMD9IIorh7M5UCrFxbdrrD6AIXCSF8jxTHVmyqvgS?=
 =?us-ascii?Q?ZW5f4/RrGIMm5GcwrpVxCxMJiLL3m6QamzYJ7sKoh9B764YNvsmICDH4T549?=
 =?us-ascii?Q?fLyoTKwADaoYmkU1wL5B2MJSSrk3SUXgH/H545L2TI9Zzqemoppa/S9E2RhH?=
 =?us-ascii?Q?cTvM8oZ+g9kq1WASQj6hhgBS8GDntDxOxYfxO4FlKNuo3JY4GBg4i5Rfchur?=
 =?us-ascii?Q?deArjyjYENpnWfomtZeuDzHQz3v93KNz25zdy7vj52Q7FNxChGu4gVYM8p9C?=
 =?us-ascii?Q?N0W6Ef78yHmba/Sw6Sw4HJDlxIkl3flVFeMbhYfKt4Cn7zhMxv+DJF1AJfCY?=
 =?us-ascii?Q?H53ffQMQntS9EA5A8dJ1qRFIH2GaVHzJziRH188rpPBDAIIIEkkxXdrnC6Ox?=
 =?us-ascii?Q?jNDDQq60oe+nq3DyyDvbpNEzAc/QbC8LCWFvR8cAZLjGMleF1HvYJCA848xj?=
 =?us-ascii?Q?Cnx7iXE7Cf013gNKHlTfoSW5FyxGXFI/cTFfHYa/QIOgXpLZ1ldn2GE+9ws9?=
 =?us-ascii?Q?upoiAncva9OB77xuiBKVgI4M+YKIYfmMW7qIMlyZs8ENVi5JKAas9SWmPXQ7?=
 =?us-ascii?Q?a+oqUHv831vflD5ELiNY/8Hsd4bMgVcq8V2dzDTTfja5av3TR9dDwXxJo3bR?=
 =?us-ascii?Q?iL0Go0OW7Q1BYaPOBsslDtIr8hQNG0dr3/suZytt4FR3jm9eS4IioSwHBAB1?=
 =?us-ascii?Q?2h5SH2mAZZY4+HAR4SKzg4kfDCgaeh10455dKx8yfZ774XTWD2PNVdCQiZQP?=
 =?us-ascii?Q?BqS8VqXGemJnLyafI3hH4KqkIURYdoZm4cuq16ACgb9LmFIrz9amHDj2Duw5?=
 =?us-ascii?Q?MNjofBGedMXXWr3UuG2lrkIN5m+FZUBYywytRV48eBhE64iHNTR53lah40I3?=
 =?us-ascii?Q?7SQD0bjeY14gPVEFMPtq6h62qV8zdSXM3XxWBuSvADl1pL9mEtTHw+wzUCPb?=
 =?us-ascii?Q?DexazMp/hKKT2V2fs7BXfjrZc/R3LFXFAgXDnhArwjyvG8FCMd+hhaf/uU6n?=
 =?us-ascii?Q?pG/F//H4hErm0O8y2/t1k+4PZLmCBuApLlTj4nqK2Y4owv1l7RSObeNZRBmu?=
 =?us-ascii?Q?JpzkSxX5E51NF6yyqWEXw/LYiokZJ3OC9aLA2BfEZhKM+F3mYYvQXCGslHUx?=
 =?us-ascii?Q?emB3QDo9G+iaxlBKN2QOXmjxcWdRORQMTEIIn/v6d4FN4iED/eCNF9l3dH/F?=
 =?us-ascii?Q?qND5byqa+RmO3imowI+5pNQxsAZ4gyXfwKFuQ1lqDv4m8VXK/iAjYSDQuUqH?=
 =?us-ascii?Q?vgpZTMdCwgZbpa2Ob5w+uvJQtkkjQGdERM76MrOzbHl2loBtrLwB7zoubXe5?=
 =?us-ascii?Q?KNbag9MOVm4aL5MJiaVzi4yisNiADWn8IC9VGGRx+7xg1g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <11EE62733EEDF84D9AD88F7A38651B91@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR04MB0707.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a792f1-44e9-46b5-cd32-08d94296a201
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 05:01:37.6951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 73qoh8iygDAnFZlq/VIa4kwa2qhPojBj1sHX8x+HJ3P44QrO9t0V9uP2xqdmdmsG2twxXFwOt09m5KPeIfiV5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0356
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 08, 2021 at 05:00:25PM +0200, David Sterba wrote:
> On Thu, Jul 08, 2021 at 10:10:56PM +0900, Naohiro Aota wrote:
> > From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> >=20
> > The offset and can never be negative use unsigned int instead of int ty=
pe
> > for them.
> >=20
> > Tested-by: Naohiro Aota <naohiro.aota@wdc.com>
> > Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> > ---
> >  fs/btrfs/extent_io.c | 3 ++-
> >  fs/btrfs/extent_io.h | 3 ++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 1f947e24091a..082f135bb3de 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -3153,7 +3153,8 @@ struct bio *btrfs_io_bio_alloc(unsigned int nr_io=
vecs)
> >  	return bio;
> >  }
> > =20
> > -struct bio *btrfs_bio_clone_partial(struct bio *orig, int offset, int =
size)
> > +struct bio *btrfs_bio_clone_partial(struct bio *orig, unsigned int off=
set,
> > +				    unsigned int size)
> >  {
> >  	struct bio *bio;
> >  	struct btrfs_io_bio *btrfs_bio;
> > diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> > index 62027f551b44..f78b365b56cf 100644
> > --- a/fs/btrfs/extent_io.h
> > +++ b/fs/btrfs/extent_io.h
> > @@ -280,7 +280,8 @@ void extent_clear_unlock_delalloc(struct btrfs_inod=
e *inode, u64 start, u64 end,
> >  struct bio *btrfs_bio_alloc(u64 first_byte);
> >  struct bio *btrfs_io_bio_alloc(unsigned int nr_iovecs);
> >  struct bio *btrfs_bio_clone(struct bio *bio);
> > -struct bio *btrfs_bio_clone_partial(struct bio *orig, int offset, int =
size);
> > +struct bio *btrfs_bio_clone_partial(struct bio *orig, unsigned int off=
set,
> > +				    unsigned int size);
>=20
> This is passed to bio_trim that you change to take sector_t, should this
> be the same?

btrfs_bio_clone_partial() expects byte-based value, so using sector_t
is misleading. Should we use u64 here? But the values must be <=3D
UINT_MAX.

> > =20
> >  int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 star=
t,
> >  		      u64 length, u64 logical, struct page *page,
> > --=20
> > 2.32.0=
