Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD58E3DF8A4
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Aug 2021 01:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbhHCXwM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Aug 2021 19:52:12 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:3690 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbhHCXwL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Aug 2021 19:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628034720; x=1659570720;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=x8vcsgSynFdfBY72tup9BW9c/r3mUJwaoZm30RCmTk4=;
  b=QI2K2AenM4huT3HS8dnmR6XXQ+NRemMPoU1OMmqqHKXXIqgumbKN4gtB
   7IkWcfomUKFeoTJBenm9BVeGHbNrXUqHYdwzNaaNJrV4j1jr/3W+SX4tZ
   UYMWjZwieTt6CH9XyD+KhCaTaKh1z4aPNEY0XSA5OBQj9BcYB+FMyH2A5
   GbJwYb/4npot0xaLDP2L6yeOiVWke6NMOKb5Ygd9fuI6bqEYyTEbMCV7b
   G2EsawpGw9SmTt/pdLB4X+tiYTNqoRnBYeUAzMiWPLVOrM8iNGL+92dYh
   isUW6EH69U5wUDY38gxfx2mKIIadIEHw4vWRUKj3Y42HK7VmcSS9Ixudy
   g==;
X-IronPort-AV: E=Sophos;i="5.84,292,1620662400"; 
   d="scan'208";a="287810886"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
  by ob1.hgst.iphmx.com with ESMTP; 04 Aug 2021 07:51:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHOT6RkjgiGw28FaqBrhuUU0lySF8LopiaFjZPNCIxeA9VTq8OfHQkFDvpb7LmwLDhk9CvoSXoiewY7E23klGNm/IjDBkBAQig1lwon7wtW6YTRkUJ199QckS14ju7++6pVwfjg0Q24aKViNbLZ1vF0hynMI96aoxqGbsDL1BYawzU1x0oQqIERDzhSDIUyb/6AmF/aQVT/dxRZ5SXpAthmNXXl05eD+FVW/gJ1QV1CNXI5ecse78AhrVi8T35W4AcW72oPNeRnvuQE1M2aY6zPYOzzCptynrrJOumu9Pn51U4urDtE6ykjvxZqXCwizDD5xUJ4fVHSlHpyz8HQ0BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTEg+a0AIN/Pb1LtxR42U4ohc817nlMGRGw8LFnc5oI=;
 b=SxVR1gKv1tquZudLFioM0edXE8XOl0y19BkxI+yqNgo/WL2/ahd5qCQ1qHZMcV9rbwRkC8Jii5sQXBc8tbzfKMa8v0coFq1KS05lkA6JgU0dx3n7rJf0FkBol6Ca4IeIDjQwpPFDikYKVpJww6a4XagkZbA7U7O3ffQBLmE5rWyyRIkrwrKEp/xBj/dzvKTQQeJCQIS+tVGSLonZI6SGwITxnYwlzgxjF8hW53Ee81W4Uy6nfRVhBNfF0V1iOBBEP9AdDVCmbsEAfANmknCH5lcYnkA2YFPW2MzBHV/QSp/9KbSTlBN4+tqbPtfX39dT7cbj35asX4CvWgINF0gK6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTEg+a0AIN/Pb1LtxR42U4ohc817nlMGRGw8LFnc5oI=;
 b=S3wgQPU1tNA9cxAoWwtF5lag+PSgRvZyjVlaSrcESJ3IqoqcUCSWvAeWSb+eVBPO6QWN6iGASoyCusg2nmNfFCEGPq0T/ukmGDFVmjxIgGbmXFlbw/zrL+q1pnv5kqWtSVZjzeIQ0ZcX1lVf9gNESEJFIjfrR1uWYJJkByZWgsE=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB8247.namprd04.prod.outlook.com (2603:10b6:a03:3fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Tue, 3 Aug
 2021 23:51:58 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::c12a:749f:475d:a04d]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::c12a:749f:475d:a04d%5]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 23:51:58 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Filipe Manana <fdmanana@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: properly split extent_map for REQ_OP_ZONE_APPEND
Thread-Topic: [PATCH] btrfs: properly split extent_map for REQ_OP_ZONE_APPEND
Thread-Index: AQHXa/ytxJjeP3wsJk2N//EMaf0z9qsuWCcAgAADxICAKlu6gIAJ9XeA
Date:   Tue, 3 Aug 2021 23:51:57 +0000
Message-ID: <20210803235157.seskvbshficvsymz@naota-xeon>
References: <20210628085728.2813793-1-naohiro.aota@wdc.com>
 <CAL3q7H4LsXDK8rTr3yEkftMm9ok9kWdQuwxk57Pke5oJ+EZOZQ@mail.gmail.com>
 <CAL3q7H6dMNGQ+RKrK91pZsbXQO9852fE+pqZDzo53xOvDAeYFA@mail.gmail.com>
 <20210728154703.GO5047@twin.jikos.cz>
In-Reply-To: <20210728154703.GO5047@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a73fb0f9-5d90-4f95-9bff-08d956d9ae48
x-ms-traffictypediagnostic: SJ0PR04MB8247:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB824798D538C35F09436DE23D8CF09@SJ0PR04MB8247.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JsByOG1WZ4WLz6aMX33/HeS1Mwpa8ORZYw024zv0ADJ7LmVFJAPQJgwIajiO7IRM+1vRjgTsnVsymS5V/w1b6yTnLfjU2GntaIvdWhh1ChKlAZrNxRSqzAy5caHsOg9obBCF2hY6ukQ68G3G2AHUR8vrGV6QDqLaFC/UO0hVgR9T+lEg//XKEWzqtvXsA8h9OpAnz58C1w1LoIHwFht8jh3oqvQF/pMqchwr/aS6SrX74iD3ddBy41JPeD+JwoIXTAS5xi0jEqLgrLl3pOQrmganLS0jJgSORKIT4zPcs8FpA0lQg5xldVm0FpDdasoczoTknE8TvBVZKj0bYplhYmdQJlYPC5Y+7HHD3YfHE2Gnfw+8BSh0c9rinOwbN4b6oaNajbhCcHpeygVS2+xQK6oCSO+nl066mFc+rPbzLwnjbHOAzpG7mNhOrQk0BYrJxFg5V0NqPbTdRdwzEL6lpvfzAM3xuD3kNDNoO3OnDAqDqpyxYmS0PghZU+6yCruOMlarG2aWTDcO7wmpexODbxj+LmoPw/RZOyJAFwDiBZ8WAJyvw9N13nz0Xg5JNxMFGWkwUOEA8GtU3GnMnirJOYxGcfzRIVmSaWLjHgpUkgc0/k6dFgB2+bhog8oUnSB07HaRjgRdsdKJGhYo/OV9QwMtm/kPzczhjF2+HIQknHcuuoIqbjZLlKScfUp+x9oC1KMS0SVLApusULA9c9jApA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(346002)(39860400002)(366004)(376002)(136003)(396003)(2906002)(3716004)(8676002)(5660300002)(186003)(8936002)(83380400001)(1076003)(38070700005)(71200400001)(66476007)(33716001)(6512007)(66556008)(66946007)(478600001)(122000001)(316002)(6636002)(6506007)(76116006)(64756008)(38100700002)(91956017)(9686003)(6486002)(26005)(110136005)(66446008)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T1ynaoWazV9PzUMUTEFSC4Yy2Mxkn1+3AhliWiUZ22/3B8WSq/pJ7fIpv8D9?=
 =?us-ascii?Q?xLfaSjgPZUcWBhabKQsitqowNtWXyanj8aa9y616J9KSds447sKtjDiPJsb2?=
 =?us-ascii?Q?X1oJ7FCDu2knaqNZHON3p4/YKF5hcFBV2UXVZrqJKDIJb+EaFwgJTKD0kw0U?=
 =?us-ascii?Q?YALcSRAGUpBWE0BkYdjVuka1Eu95wbMyc8XagGGhnFkqcvytb40nXHJ6b+I6?=
 =?us-ascii?Q?KnhkGJoOKATigKL/fJyC+Bhk/E1lIpP73agvVPW8C6Zcp/yIe53q+54ce4Wl?=
 =?us-ascii?Q?wj5yJCVUIZIjlTp7nP+D1aUkUodA9pjr/2LjMseLAmHIMxHRLIQEeRYWwL6d?=
 =?us-ascii?Q?M1Og0ZKJFfRH7Jn/asBVMNE9aidByTQq75Ix1CoKmFob0xqRQL7C7agUMqAJ?=
 =?us-ascii?Q?B4d5mqPBgQOp191yXUIga+o010mR4X77TPlsr7J6Yq4OsTzKx2b0iuOkLtAo?=
 =?us-ascii?Q?YyZsafmOt3aqLQHcTiyn9EQKvjPyOom288qm0HIqjwBLXg7d70REyIZBBVmt?=
 =?us-ascii?Q?ESPz65Eaio5MuucNLRNEjv5S96jvrMgpVfVpV88uhqJjdhxp5huzy2jrKzWb?=
 =?us-ascii?Q?j78Wb8fGs+XzVktb5atP/e4qW7Wh4Sw6KdV8iYKKQK3/9IMDIXYcuhnzoz3q?=
 =?us-ascii?Q?sE1Zzdr8SlJ3D5v+Zdt8oi4Uf+Rq0tSqPqzpf0klE3mmlPKgu9BpVsHEeANS?=
 =?us-ascii?Q?PB2k+26GNeEmOX2dQf2gfodqaf46sYPu/VN30ATeIdF0+p0klc5Tvo0CHbMk?=
 =?us-ascii?Q?xptxRSqTFZr7u7gc5kJr21p67MMSwaDZv8WY42f8+/EFEkl2TbHRY1txeyKb?=
 =?us-ascii?Q?2MpW599ricdnrCPwMP1sl/N3Ddwf9HRtIbxSoXAFHMC/TW424yYK726CCQa1?=
 =?us-ascii?Q?zJCWWFx6kv7xFoNwfka0fMt+6MUIriBsZ8HyBBjOM0JnVlIHUkopEW1mp/i3?=
 =?us-ascii?Q?QRaFhmJANtzvDY0GLaGsmFPAlrLr/UbKin9XjYcaFTUboKeiwLO2BL1sTvYy?=
 =?us-ascii?Q?FnAoHL6QM9r6iHA4kjuZvbXIRMFmkzy0watklKEF255c3HNsyMPg8ZBDdgDS?=
 =?us-ascii?Q?P5Ssr2LpAozwSULXRYVUEKvHZWu1g90UV08LjeLrAYAQQ9ZB9uh5aVB/OjRP?=
 =?us-ascii?Q?PYIWRGAbyUyImiYAqfKVc878yY4DKAbYQ3AwzHwfnusR5I2ZTl7GGHi5ijoH?=
 =?us-ascii?Q?afRepQYYzV69zHtiVC6YnqXdq+jYtIvPnd66b+SJeYYgGCJb7XXxV/DJk0fp?=
 =?us-ascii?Q?9+X1bFXeTw4iMiWcpac2vTJ/sU/YBLSAEZ1eOpNjGTKKiwZCVy8YZdBeGn8d?=
 =?us-ascii?Q?pvdZ5OpEA92p8dGFnhLdLuYx?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4F56633BAE692F4CB4ACFC6393A3D9D2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73fb0f9-5d90-4f95-9bff-08d956d9ae48
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 23:51:57.9222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dn7xPf1yW9DZrLNHK7eGSDj33PH5b0BIA+A7Npg7U9bqu8wJLU/7cEgMVpcemXFqZAUjiPPgGNiMWdGkWuc37g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8247
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 28, 2021 at 05:47:03PM +0200, David Sterba wrote:
> On Thu, Jul 01, 2021 at 05:55:51PM +0100, Filipe Manana wrote:
> > > > +       if (pre) {
> > > > +               /* Insert the middle extent_map */
> > > > +               split_mid->start =3D em->start + pre;
> > > > +               split_mid->len =3D em->len - pre - post;
> > > > +               split_mid->orig_start =3D split_mid->start;
> > > > +               split_mid->block_start =3D em->block_start + pre;
> > > > +               split_mid->block_len =3D split_mid->len;
> > > > +               split_mid->orig_block_len =3D split_mid->block_len;
> > > > +               split_mid->ram_bytes =3D split_mid->len;
> > > > +               split_mid->flags =3D flags;
> > > > +               split_mid->compress_type =3D em->compress_type;
> > > > +               split_mid->generation =3D em->generation;
> > > > +               add_extent_mapping(em_tree, split_mid, modified);
> > > > +       }
> > > > +
> > > > +       if (post) {
> > > > +               split_post->start =3D em->start + em->len - post;
> > > > +               split_post->len =3D post;
> > > > +               split_post->orig_start =3D split_post->start;
> > > > +               split_post->block_start =3D em->block_start + em->l=
en - post;
> > > > +               split_post->block_len =3D split_post->len;
> > > > +               split_post->orig_block_len =3D split_post->block_le=
n;
> > > > +               split_post->ram_bytes =3D split_post->len;
> > > > +               split_post->flags =3D flags;
> > > > +               split_post->compress_type =3D em->compress_type;
> > > > +               split_post->generation =3D em->generation;
> > > > +               add_extent_mapping(em_tree, split_post, modified);
> > > > +       }
> > >
> > > So this happens when running delalloc, after creating the original
> > > extent map and ordered extent, the original "em" must have had the
> > > PINNED flag set.
> > >
> > > The "pre" and "post" extent maps should have the PINNED flag set. It'=
s
> > > important to have the flag set to prevent extent map merging, which
> > > could result in a log corruption if the file is being fsync'ed
> > > multiple times in the current transaction and running delalloc was
> > > triggered precisely by an fsync. The corruption result would be
> > > logging extent items with overlapping ranges, since we construct them
> > > based on extent maps, and that's why we have the PINNED flag to
> > > prevent merging.
> >=20
> > Well, it actually happens that merging should not happen because the
> > original extent map was in the list of modified extents, and so should
> > be the new extent maps.
> > But we are really supposed to have the PINNED flag from the moment we
> > run delalloc and create a new extent map until the respective ordered
> > extent completes and unpins it.
> >=20
> > Also EXTENT_FLAG_LOGGING should not be set at this point - if it were
> > we would screw up with a task logging the extent map.
> >=20
> > Maybe assert that it is not set in the original extent map?
> > And also assert that the original em is in the list of modified
> > extents and has the PINNED flag set?
>=20
> Agreed, the asserts should be here, Naohiro, please send a followup,
> thanks.

Sure. I'll soon send an update.=
