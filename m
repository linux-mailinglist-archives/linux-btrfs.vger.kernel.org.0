Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59BC4027ED
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 13:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241380AbhIGLiK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 07:38:10 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:46870 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbhIGLiI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Sep 2021 07:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631014622; x=1662550622;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9kxW7bj9DKJApZCuf+17cBZDMG6/b5cSIPz0Ezo8l1s=;
  b=P6HbLhWu3jfCjC3z4RKoRrFVz+R4SjzKWv1ebvW4w9ixErTsgsoDbFVA
   Q47jPywXlrdbgCziZH7ezNO4+7ntJH6+51SZMto4wnyL0yY7It69TlCoj
   wa35QBmMEgo0wgwUUZsdY6tmpLa36hWngxCzdazjsuWF9aY+Mj4KQrHS3
   vqXrc3bNwMkngzZGB1ETubiE8KXM/GgAXyxUD1uwyGajkI4LWdR6Uea7S
   eYeH1JYhZ2S1Tfn4Oj4bZF662J/DNsD4poQwmhh7vcsD+Of9rPYfZd2NS
   YbpCvoY3bzIL+O218PwFd0uQ7vuvf9VsDZXyrvJBsqGz8omkro8uJdZeR
   g==;
X-IronPort-AV: E=Sophos;i="5.85,274,1624291200"; 
   d="scan'208";a="178465042"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2021 19:37:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zti9Y6aMuyo6RrIk/1A/xTnmSdaybY0sDj0frkAuP7gRcYdhd7DO517sKpfvETdziKSIKXMNEA482jA2JZXFiumGehSdBRwVPkU3HEYctPdVNwOj4CIgGWmHIOK/0wasW9ZZ86w7M/wqLOe+XrcOQQI5gN0Hcuq16ruXq9Uz3BP9uhU6tX2zdeyK/AEPiJvNS6zCzJ/QKSYlPhYVEM+nWT1rbJWh2XkPW3KwqIL6HA/FrTAjfjiE/ZpXSgwHxVj77q31zNg+G7AGqIs5by/sIYKNNAFlVnhBzlv4es+DyuetG1PJ3ewaSITOwo1uqAqgnwppW9/XKuewpw3rFKAbpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=MOdOEMNpMFDuRU9f/tQhRmmzBz7k/1WU5xzAU6ePpEc=;
 b=mFdRCczu4K4+izq8egLgnx3CYZhrO9XzIwXDIrJI3VKvIMeLX/1i+ZWEISD0R27i4+F9yIP5M9EbS3SKcCbDuhgaoFEdclRz3e7tc717ysSkWu62M5sbk875gN1NNy4AuK97beBrxmGkMC4A3ngBbm3i6vt8YH9miqLce3rEPbfuWNddcNtEg8S53hJLd/SlEGVUEAawISVdK2+3el5fuuKaggEFafIHFs9bt7ZOcd67Vx43ZxPga24jdlJrG0bCJ99Bzsbmv21HdXR55o1PtITPhdfB05aX9k1W9IDGxOvW4a5X5jExOA+XfWAYy4fa4ms25rTbOgPZ4a3A2cAiRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOdOEMNpMFDuRU9f/tQhRmmzBz7k/1WU5xzAU6ePpEc=;
 b=h6ZpJP2kNvLslHPJT1xBUJ/pxHQRTSNFUwpVeCE0o0raF5exRmJbQdq5n9QMoRmNVBO6HhdjtzOfVJVYX8Is02z2XAc/ptlxUUsidTFEvtux+INolypRI/+OVrDLbHPKBYfEQyn2fBUTD3x6+7NpmZTwAK+ydwbohOigWfzjLg0=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB8344.namprd04.prod.outlook.com (2603:10b6:a03:3d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Tue, 7 Sep
 2021 11:37:01 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::19a7:91bd:cb0c:e555]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::19a7:91bd:cb0c:e555%8]) with mapi id 15.20.4500.014; Tue, 7 Sep 2021
 11:37:01 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 2/6] btrfs: zoned: add a dedicated data relocation block
 group
Thread-Topic: [PATCH 2/6] btrfs: zoned: add a dedicated data relocation block
 group
Thread-Index: AQHXoNJMkBMN1xX/N0GF8l5ZfICZDKuYd7IA
Date:   Tue, 7 Sep 2021 11:37:01 +0000
Message-ID: <20210907113700.bgneqghxnqpzqvt2@naota-xeon>
References: <cover.1630679569.git.johannes.thumshirn@wdc.com>
 <ac2e5fc11c47dfc3626999460f606b980b0f5523.1630679569.git.johannes.thumshirn@wdc.com>
In-Reply-To: <ac2e5fc11c47dfc3626999460f606b980b0f5523.1630679569.git.johannes.thumshirn@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85ba3396-9c92-4e98-7a56-08d971f3cede
x-ms-traffictypediagnostic: SJ0PR04MB8344:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB83448BBEDA79ACEEC42D555A8CD39@SJ0PR04MB8344.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wTZ4DBIWNSkBBUvbInaZCI85o0B6kySHek/WJtaQIwqwihVAVIVfsnGq0q21Jw3m9IXCr8BAUgI+xH1JePi9BRpzAEda+8jmTeHgt1bGuqplX+S+u1xKC4YSjDIi9KKXOfsy3xfqho2inZRT66P/eZdRf5QWMl7fU7QL3Y70XtgrJaGQC+7Xg3wSMP0u8X90axMwqfkxc+GOBb4INk8PzNUN7RGNgMn7WsPhLe+crdnhWOYwcgo0gLx49fiUyFJJjoAEg79fCFoJKN4jN5jAgEU1IyjuKSZ2GfpoA+94xvp6tLK3EuiTciMHw4vdtj1kS8JvbEHrBB0UTno0v1VFivbzjbYZRGqFgsYmgGyyLBno1WUCh+jwqLyxcfQ8fOsesrC8oamD64fhMpj6Lng8CmcQmmo+aIgk6K8WUwCMKIvsjP5XyKC5N5iiODs/fpG4lQLuY/wTOjQwHcdxhC6/n2c9Dvnd2DAdIh2H93AtIhGdGEordAnBBv/kN7AxQ54z/3vwbtqsk/lstLymDCWyuMItj/yLDY/91EpEmFkHVnxjJQqL+1HgTdOjr7RHIHRnb85wNYlted1fc/1oQGowjn5VSNKW980TnoIycLPUBgEdMICx6QlVQT8T4zpNkmnJK0wz3f7V4G6JHbSihQvkqCOVvoA/CfPyHrqf7WECyqmo82IrpsaVaMb49M5a6DP2mDHlAoPFfNCj6LKU1+0EVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(39860400002)(376002)(346002)(136003)(396003)(33716001)(9686003)(478600001)(6512007)(66446008)(38070700005)(5660300002)(8936002)(4326008)(122000001)(91956017)(38100700002)(76116006)(66556008)(66476007)(66946007)(6862004)(316002)(6486002)(71200400001)(54906003)(86362001)(6636002)(83380400001)(64756008)(6506007)(186003)(26005)(1076003)(8676002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9Ad/q96HlmdIHfWNPR8Pj6r6wGe4QRt9B8iPUlgE0c38YO9dpDXRMkRkvgjF?=
 =?us-ascii?Q?2Slji2HqQqfdbeB2ZC3kQJzm+h5Wsu2tU4xYpZOEZeslQR66xgaQsjMQanJQ?=
 =?us-ascii?Q?rMLJaRFjVNuVWyWkWI7fmxzdoop6p69Ve0pLAp2p+CnyhLdHvWbrLz+QpDAQ?=
 =?us-ascii?Q?AaVMYwrw3DLpj6Rc5KLC3Geds4Fhuf3dmQpTww/toUmreEjd0WP0wu+N/O4n?=
 =?us-ascii?Q?yzDi2splWnQPU2U3C3ViF55dgG9an7Fa6Z9yLLqp6+/Gas5vbf/AFdhYpZry?=
 =?us-ascii?Q?yzYO+l0675DTL+jiSgdwKrYjBiqu/9qgRSEZEquiQLkIklwyubGSboKoSWCW?=
 =?us-ascii?Q?H+QN3HqDq3L+lzIuN/rGIUTLVYWXcQHSDld/gBuqnspOVjsk5lfV8C1pvpdV?=
 =?us-ascii?Q?UAejWR9CoKJ5fRfnBOXOIqF8ed2/j8/NIRLigvIu64RsTVADDIfRWhXyoD97?=
 =?us-ascii?Q?fulZQ9/8tv6oJuwSXVRp2kqy7Su29FKRnbLl4QiGSodbM6f6SIyJ8eNXFW8C?=
 =?us-ascii?Q?5p8YA3ZTqXfdPxy9QyYXdnPnX1DVGOKGCaEgf8NICihWgWji07wu6zdZeBkD?=
 =?us-ascii?Q?XUe6NqQIZea2j5WfQAilLBAQKBiFhsvnvkkMwss8j+0q+dg5QHnmPbMInpLK?=
 =?us-ascii?Q?Rzv+6qMrwx/+bwt8ZrSj0Zl6WoOYkzLE3HSc7V2ViEaJs9uAWpDYBeXN2Fmc?=
 =?us-ascii?Q?iJtbJvRDUOuOUIzlA7ZtbcfybVrULkvtkW7sGE08RBLCexjGOC6EW8VEOVgE?=
 =?us-ascii?Q?4cy0qKenpkn2PRniYvyWZpqLA/3xRAkNVpQsacaiQpaqcQRBxx7luLmoUJgH?=
 =?us-ascii?Q?zvtcffuwci3m/beylfRlWX+7RwUQa4XH8axW1ERDSwLwsnKXiQKUqTC5DDNW?=
 =?us-ascii?Q?a9B/pEjFCdaG2G2wy7rEIE7g5czCeNy7K9OmjE9ZDVQnZ2dYQ24V94qBmtND?=
 =?us-ascii?Q?hqp9z8WgjV34+uEmStwIh34XmJ8XUkLevyew4Qc4bKpzeLAMaQrhbOy32nGe?=
 =?us-ascii?Q?aLKC+eA+I8ipvuz6zpRjCMoHAy6RZC6xxubmRMCz0jjUyTG2azsBFWH2bXgf?=
 =?us-ascii?Q?9+I5o7B+q05oXEfOl4bWnclZG0EXxrknZCCybpsJ0H6xB1T3FvDwD91wMYor?=
 =?us-ascii?Q?Sw5zWe5QZvb0cfEFoTt/cqaN/bxzBz7vXMgzSiEqidmoB/thimRwTaXXi2Dy?=
 =?us-ascii?Q?QoWJzy9+vJi5KyXpzxc3t+/IuVjECSb/Nbr4FGczVEwR3R8k8NlXBY7AT772?=
 =?us-ascii?Q?LunuY3R+ogyGsObyjFBllOBbO2UrHBtGeui7jXAv9mNOEMPdDlqoKTaO89vn?=
 =?us-ascii?Q?KiMaBaX+RHP59F8QeS/ov91AHe3qA+ODTeTbwMUK2ZgzUQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A73FED8151EFD94EB2FC2B399D0E4041@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ba3396-9c92-4e98-7a56-08d971f3cede
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 11:37:01.0258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bpZziddgEngtid/4LcBG3g5wbrg0/5VRcMPHXlkzXOJkTw6kZNqTXEQ9Io63JLRzSr/JAefL0gTH2OcsQHUHJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8344
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 03, 2021 at 11:44:43PM +0900, Johannes Thumshirn wrote:
> Relocation in a zoned filesystem can fail with a transaction abort with
> error -22 (EINVAL). This happens because the relocation code assumes that
> the extents we relocated the data to have the same size the source extent=
s
> had and ensures this by preallocating the extents.
>=20
> But in a zoned filesystem we currently can't preallocate the extents as
> this would break the sequential write required rule. Therefore it can
> happen that the writeback process kicks in while we're still adding pages
> to a delallocation range and starts writing out dirty pages.
>=20
> This then creates destination extents that are smaller than the source
> extents, triggering the following safety check in get_new_location():
>=20
>  1034         if (num_bytes !=3D btrfs_file_extent_disk_num_bytes(leaf, f=
i)) {
>  1035                 ret =3D -EINVAL;
>  1036                 goto out;
>  1037         }
>=20
> Temporarily create a dedicated block group for the relocation process, so
> no non-relocation data writes can interfere with the relocation writes.
>=20
> This is needed that we can switch the relocation process on a zoned
> filesystem from the REQ_OP_ZONE_APPEND writing we use for data to a schem=
e
> like in a non-zoned filesystem using REQ_OP_WRITE and preallocation.
>=20
> Fixes: 32430c614844 ("btrfs: zoned: enable relocation on a zoned filesyst=
em")
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---

Looks good,
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>=
