Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A573D0ED9
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 14:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbhGULxp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 07:53:45 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12285 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237713AbhGULxm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 07:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1626870859; x=1658406859;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=u49arsX3j5pVI9sfQ4LLap5eVWXYlWuPlqSYgVoLPD4=;
  b=TXB3TSqM/vkbjfASXgtcaNxBNVI9pc4ClxYbzzjaSfipejxsl+4Y86Hq
   YchTjZGl6cpHwBfdTU8YdEKexx2V1ZCPYFKM7GxZAQckMCMPkgkzVdSYB
   bjG1YNk8Nxm6bxkySCJnSdaPbnw08H6lbgS13NJsrp0cpDXq2S4gAoCGU
   TDzX5vhZ4oAz1EfpQciS1fA7bPtxNGjFhBHyE+cYPpVZpT8P5CLH53kPm
   0Gf09uvr1RJ8KXQNHlWlaU3tAkhkihActHcDmDtn0EOtGfrN20LXShjat
   VBHUbxXf9PHQFrYegJEkdJlltLCSnEv/faH1xtj+QAZrWH+ripNZMYri6
   w==;
X-IronPort-AV: E=Sophos;i="5.84,258,1620662400"; 
   d="scan'208";a="174365909"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jul 2021 20:33:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7ABhq5DuMdPcJN9MXNsn8BEydXdgtW3O/W7/6IQdP34NGrpAEf9meQ8XmRvuT8fvsOfgfNpveXuPPzSoW4d7sO4aV9io2KCcsQg90Nz3RI8hUCqQfmLNSB+FEq9xWtH0TqbZ6wCI9i8GdLoJSwvmxoeUp8i3VBISr987loVkHFW3+NYuUMi1A3OSfw9kZClC93y20B4pjbqN/QLNlMxU3Gcj/whvAzBj119ZtcsKDrjDe0tmo6BY1ISgzeW8olbSw9RgrRs1tS5zkOIBCZO1u0cduGOVuAxAep006pTSXTqfAf2sIeDy7+PEmVoJWXbc0QZecxE8hxL13WahZVfQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7BmxHj8GQFBabHZgKc/H+NeIom4hqX3Wk/7cdvKRgE=;
 b=oANESr8FyZ0C0UtOVcdQr2IPI5zv6JLw935Xw0BdarUxHqfZOsZWtkbhoU+R/y+lFEmS6Tm2jJX4DaLWhY6RVTsBFcsOzRjucdRsASCsdTOyfpgEHnE9cQdggiQEpEyXMJX7B/XHNktNTYKzpVx14OdnPW7Cim2BRYvWUxO55sA66p6Uawpg4KjJt5x29ekOsKxah3LQGOehwXuzbqvJciaA6bFRcOEj8QQrnkRxwIB8fQ0xC70bxfCKqWuyWAZCqS9vRUdNY9PW+pc3WarZMfNQ1IlDK8zqzmzgpLxVOQLKRcFuX8TvAaBEv8lJfA9tyvq9UQK32DBYPmXtQNJejQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7BmxHj8GQFBabHZgKc/H+NeIom4hqX3Wk/7cdvKRgE=;
 b=AuC0L6I1eRKfJgScc0pvTyNwaOWazdBaEUCJx2dSyI6ti9Y9vI65Cyx4ESeOakvM4VIDMEgohro6OxqvAFRLQ1eMd09M2nQ1zRuY8OFuVVHQdwAwjyi0CE3vgSJfwD5lwp7piYGAGcq2IPR9mG8sMzm+Da/5b1fbQKXgtyaODM8=
Received: from BN6PR04MB0707.namprd04.prod.outlook.com (2603:10b6:404:d2::15)
 by BN8PR04MB5827.namprd04.prod.outlook.com (2603:10b6:408:a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 21 Jul
 2021 12:33:44 +0000
Received: from BN6PR04MB0707.namprd04.prod.outlook.com
 ([fe80::24d8:93d7:ee91:2b22]) by BN6PR04MB0707.namprd04.prod.outlook.com
 ([fe80::24d8:93d7:ee91:2b22%9]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 12:33:43 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2 2/3] btrfs: fix argument type of
 btrfs_bio_clone_partial()
Thread-Topic: [PATCH v2 2/3] btrfs: fix argument type of
 btrfs_bio_clone_partial()
Thread-Index: AQHXffl1QgVWPHMvOEWfourDGRSJkatM+eQAgABjcAA=
Date:   Wed, 21 Jul 2021 12:33:43 +0000
Message-ID: <20210721123342.m2a7mtz5tsvrrreu@naota-xeon>
References: <cover.1626848677.git.naohiro.aota@wdc.com>
 <c69cf6f0b81a28dd04b62537e3b8b4f46bd36e1e.1626848677.git.naohiro.aota@wdc.com>
 <YPfAvDXlikV4t3zA@infradead.org>
In-Reply-To: <YPfAvDXlikV4t3zA@infradead.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef7e39b1-f72e-48f1-9ab5-08d94c43c74a
x-ms-traffictypediagnostic: BN8PR04MB5827:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <BN8PR04MB58276ACFC1911F82895F77148CE39@BN8PR04MB5827.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PAgqWGUPiKkDT+nomBSr0cGf3acguqNm1Xj5MKhZaXk8ADwtETWneSGgZl78yYrvqg5tECW1GjrLrWdfPd3yt+YUFEiAB8mL1cboC4WArjpX0v/0omJAOkYAtb54dB0qgYSeTjZsdPvai73cGQopqYloMWGYtdN9ld88hWCn8Vg06YKqhD++M6ouxjDVjF5JeWSp+eKcMMbed8SdF9vS5m2OzGw31bFRC0vioS62+AHItkUFzTvr/vKhhWPZhTvCSP79xg+AgknLWdL5APzLXjK4shXgn0IdZoAkAiJ/7pFANyooeZ+zhJIu4G8bvDNMq0ok2XK8PURzNWuzePAIfnIYvRRATclcfIh4icPEXbH7UtGrq7f7Yh8gtLj2D4t4SjfTXU5yRGhc6PKV3N8cm9UExmhgW2krINGVw60w9qfOfJHXeq39rNt5pu3Gf/5u7lKAbFibbmXxJoU6PrxJycao1Q2x5HOtVeGQa+Rt814p9FemWbOlC95gVmOYjkUIcVmcFpQZX6Oj4Z2Q13/LKcMf85g79t6eF1RiZkGrIvtt9QkiXc4avSaHQZbATn9spnmSpARJyGZYzaOHqZG5bLXY7HNz0Ui7f1QxihTodPYRJQZcRJ+a5RB8WmKmjivAS8Dr3Ib2gEwdDkGY4YkED3oqrD+ol/k4kwZsbf64y/0p5LqZEBH6Wydo62l+RuCErnwEYmSsmXGBRSrJjH0QIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0707.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(376002)(39860400002)(136003)(366004)(346002)(396003)(6512007)(33716001)(9686003)(5660300002)(66946007)(71200400001)(66556008)(91956017)(26005)(86362001)(8936002)(8676002)(316002)(122000001)(38100700002)(2906002)(186003)(64756008)(66446008)(54906003)(6916009)(6486002)(4744005)(6506007)(4326008)(1076003)(478600001)(66476007)(76116006)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fQg9y2z2vXba46VxGt5JdgYePN7yIRNMR4QvYzeYHlQNILXLT+FnthE0kOe7?=
 =?us-ascii?Q?qotcolGJxQ6hPm6L44Bx3PV2OppqJOpma0vpqxUASPJYBVRKn8VGx/GbY1Gq?=
 =?us-ascii?Q?Vl2XkOln1OBHsdvwaW2mBmWNgcaKqfiYT3EnSOpPm1ssJND9A0EhqvolsaAF?=
 =?us-ascii?Q?5VqLD/ahaAu2kHcBxBuKlHkKZ1EE3QC1l3F4bo4jSZezvBkyAX0qUAnznUTE?=
 =?us-ascii?Q?2MZGRkGrirehlTh94JH3c6xT+9S+wpCsKJceVYXGfhv/YzzUitoHk48BjrVe?=
 =?us-ascii?Q?e3EZAxCsg7mVGgGbSY08CISfvV3ba8JL8nfIRoMdNLY9ItuCmd5A/EX8NwyH?=
 =?us-ascii?Q?fGs6PwlVW/RqOCmaJXLK0rdI3qzyLe8TKk3M/OwtYykILqofHfLxOVdx+DjD?=
 =?us-ascii?Q?yZCtCqjIUgL2QiTDJ/4NcQmBP4ycM+mQMZquEsePQEVB7pHVfk7qQSje7QY5?=
 =?us-ascii?Q?ZGlyPxU0uRR0MitWQXOClns2RmkDcZzLVdNkdj4DPGNlVPnA0qK3p9YlzU0u?=
 =?us-ascii?Q?EG+FBe3nDi3TeJVa3x/JC7gEGQsh6UWxrltqc2a+MR9qUwVnvUtX0RfJoSZT?=
 =?us-ascii?Q?mf1w8eAW93OXx3j8Vk80JjE7XZ+rWA6chlpE9SVw71KA4Gek5r7FX1AkE3Ve?=
 =?us-ascii?Q?Or6I+irmqCjgMYebajP0Y6x9+dAugTGFi6zbfP8N4BNXRIWAXkRK67USIvtS?=
 =?us-ascii?Q?lW/X1VOh8IqOC7BAIL6XblI8iwF1YxFCiyFhoKHwvtwPrXwjAV78JVbhjT2I?=
 =?us-ascii?Q?Pzhft2pXazGJxFxC6BL6rJbwHZmjUkXI8Fi9ze/VMkUrmro+XWjtxhPdOAW3?=
 =?us-ascii?Q?kbpsAi6QXvjGbvoO/sN4+UCEzpqP5UgjNY04BuyKCSokVtArXBCuSxuKDcM5?=
 =?us-ascii?Q?+byN0nNg3BtLyBgqhIJpxMnUEgSvQkvQE5Zldqz01TRkUblUNWjtoM6nlFER?=
 =?us-ascii?Q?cGrDS1YDZoCRE0oHNGKWImjUhunpuZ9IEMrO4QWFL4hZ/IJJk4RJW7/T+WCr?=
 =?us-ascii?Q?wHbrzJs6+2u0GlPJ+KY7ZckhCEJ4RRoS07jDh6telwMbgWbW+YfjtfoiIHLS?=
 =?us-ascii?Q?fBuPcYUWKXKIMyDTFs1fP7zqMPqk56vsIK6+1E36qa/1xAEodKFJPb1Fr+CR?=
 =?us-ascii?Q?IF4Uwp0OdKpEqyFoQ8evSsDcd3y/+kz7CzSDz9eGyAdXhc2BADn7UJuWOv7q?=
 =?us-ascii?Q?4Xn0L/yt+WRZ4wxKESWKxwV0rxoB/uYxSvajQ2JnhomRVDaadL5EkZkKu8GY?=
 =?us-ascii?Q?Tie4Ojv0W9kO1kZdl4/qCv6pdriWiCszNHyle6FV9OqAvllmxbp5u9K9c4Jx?=
 =?us-ascii?Q?Gj7rcLvMdiopkgYC4PUcM3jz?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E488B8AB817F0A4F9BA88BAE5EAB82FB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR04MB0707.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7e39b1-f72e-48f1-9ab5-08d94c43c74a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2021 12:33:43.8861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tLlia12/QHNreqihfpcocCHKv1EZSY+rUlHFMDLghdZ7jmJt4L+ylQTDB68QZTnuco9vRfJ4jM+7Si85Pi/hQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5827
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 21, 2021 at 07:37:48AM +0100, Christoph Hellwig wrote:
> On Wed, Jul 21, 2021 at 03:26:59PM +0900, Naohiro Aota wrote:
> >  	btrfs_bio =3D btrfs_io_bio(bio);
> >  	btrfs_io_bio_init(btrfs_bio);
> > =20
> > -	bio_trim(bio, offset >> 9, size >> 9);
> > +	bio_trim(bio, (sector_t)offset >> 9, (sector_t)size >> 9);
>=20
> No need for the casts when shifting down.

Ah, OK. As, I switched the type to "u64", they are actually the same
type anyway.=
