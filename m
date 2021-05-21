Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44AC38D1F3
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 May 2021 01:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhEUX1a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 19:27:30 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:58960 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhEUX1a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 19:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621639566; x=1653175566;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=HXK/j+lEyP0rxWy+Z+L+PpxKIyIi90pkXNtC6nTx6kc=;
  b=eeXr3HjxegAw0IxvuUeOJTYY+HWayKhrDbYBDXVbco7LDDF+yWIFTHmm
   8eDl5wyRfhgeX5KzvAD5GmNYLlYviACRBZNRXFnToN3DJ0wOCjb+UfVvQ
   4yxG6Z4b/QZEesoanPoDZo5MrMRmM95enQsIS0a09QSv8e5QeVKgz1Mqg
   sNZFrs2Y5zGP4P0bdA8Y+ThUS255ZfskUQUi+E/54ND0dUWS+1F0j04Nv
   PHUrE6KIY57URrI4fyKZCH1fDKIY9+Dr9iMb+RVokKGnGRB7K0y/CRQ5e
   s2BhoBPxNT5WPstkx1cxt/x2lWAtJZRyOosZwlHxcrlpjd04yKOaoFjaV
   w==;
IronPort-SDR: tc3+yEoMYuPEhYkbJa6WiCiEV6q8+qmrqhGY+UthKogSVX31CgqcQ41nnroAsnmpGOxsoXE/zD
 +7+/jv495WpmpO648EYPgNaBxA6nI95V6UFm5BGxRNCkEN/JoTeiqoKoF0lIYYhKWawXO6JkXU
 Dps8jN4mKC8Y/fza+JyOubQ6rtPelX6mH/J93mtM9jg1kOEFNZ/wPTThjxQHHIePohqEwN344s
 tmZUh8iytaW42qqV87AScSGBqTtPMz4DEFfa6no7soXQMQCi53FjnOkZk/xcpAUrfkbVp9IC11
 5Ig=
X-IronPort-AV: E=Sophos;i="5.82,319,1613404800"; 
   d="scan'208";a="169600412"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 22 May 2021 07:26:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gg0Wz2BBo1yBy9ji043ndsKb4O+N5155P/iec9fcHz2Kok7By/ko0Of0A8tPZMJmxLK9fiqtT35lopSEEiXKYn2Akc7SNdBrArzVt96qU0PaHoPJ9ikZ8Qqkxg9XYg7sopccaVdyBxCSiv1wC9KU1IyJgFSGYq+SOv7lh+QIphR/qIoHOLzOJJLTeIBIJ+5I+q/vLS+c45TentiyNktqcmQu5AeSeSFVXho3nKl48vvEwkhld+3dg4ub0kdaNk8xVvPDJKgMrPHLlzHlRfzsPUr3yjZJsHIgsNC9ghfX4lAWF608G9V5bXS9ZdG6UHN75X1HxD8A9wEWHhcBg1WW5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWmcYfR6+PhP9X7fKJug2f/71oE/Bsbf6a1vYnCcfts=;
 b=kiWsyukEkA+KIg9EzqBhjaol2wRrOG8Ye/IcrMviOPLJXEdhoqlklXYDMxNLh+kB9BOaHx3h9e7mzuiz6TifqlgR3lxEjB1JNVRYumBiFkr6C5jNxW06AmXv8IAqy30WYuKUaNMCaDx/V840STqfR+ddJjAGUzMdgzpZuXVQxsar6m2IBA3vYh+Hic2hKqHwINJOnf1nJsYZvBVyA4f1G4RVYCeO327xEvoZY+44miCCNWsod13jcVqOrebparD5qCZ/8Fha8JAjtWxCPKFnzjhJPt1eC8WMXw8zx39M0yJbALOPfM4pIvnGBaXKQyt8WU1pQsbb3x363b6QJoGFzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWmcYfR6+PhP9X7fKJug2f/71oE/Bsbf6a1vYnCcfts=;
 b=xYmOOQLeIK9VBu4VA4EFUa/VpSS/hiz4UY5X3+v7OUrfgX1yOh5zRS2Njppslh0vv4MlKFAaaoa6E6vQio/VeQmH8vPRKmNFYGEdi9IxeEPAR6tTgIeLfTgfeW0xVk1A5phGYQ6PhETa+2MJXcMjXjV1QReXCmDn3jNSUof6TJE=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (52.135.233.89) by
 BY5PR04MB6551.namprd04.prod.outlook.com (10.255.68.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.26; Fri, 21 May 2021 23:25:58 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 23:25:58 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "mb@lightnvm.io" <mb@lightnvm.io>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [RFC PATCH 0/8] block: fix bio_add_XXX_page() return type
Thread-Topic: [RFC PATCH 0/8] block: fix bio_add_XXX_page() return type
Thread-Index: AQHXTUCZbkdV5W8mbU+6O2TFfy2HFA==
Date:   Fri, 21 May 2021 23:25:58 +0000
Message-ID: <BYAPR04MB4965118B90DE39ADA629865B86299@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210520062255.4908-1-chaitanya.kulkarni@wdc.com>
 <PH0PR04MB74169D71E3DCB347DFCBFCB59B299@PH0PR04MB7416.namprd04.prod.outlook.com>
 <BYAPR04MB496577D8AC414B1FFD44722486299@BYAPR04MB4965.namprd04.prod.outlook.com>
 <YKg2J5n3oY9RpgVb@relinquished.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: osandov.com; dkim=none (message not signed)
 header.d=none;osandov.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63bb9dcd-83c8-44cc-2911-08d91cafca1e
x-ms-traffictypediagnostic: BY5PR04MB6551:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB655143C3924BCEB03325F45486299@BY5PR04MB6551.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B9gapiL9Rhe4cCdaHNh8eApkQOmBXssSXbCeCKmZyWeh3ixSXLwfH7nC13VjsDv8kSY0edadPdsYg7gZhcs7j16MHRUxr14pQv8KauQ0rV2qaYFL9zQNTC9lldPGLfPmWwkpvfU2SLIVfRaa8ERQ9l4/7ASY6i0qrot0BHbhjbMkeZYEXoj2i7gCjSmjHCs6xjrnoEyfQvdOCK96F8AkgF1luyHH+DPZotxICXQwMB7rav7El5IHRgOnBnkRo/yFMK7dAQN/Ma1UnXVhMwkEBDQ3Gtzxi/ISVp19vfrNoVoZKG6orDUtz7bH1JSJqmqRCcZpbVvaswV0bw/OlsSA4TsGhBBJlOTchCnDQi0BPxKFCdEw9hrfWLp3tCAX3tlymrcSNTuyKsPweUi7nhzOXJ4Dy4xFYhZdGER0HB+OR/atZFMhlyh7tjAyz78Wb/hAZwDyWiRIj597tfFtP8ZP198Wq5m95owQNsRKt1cNYTM1So0BN+I0EGWR8gxUHUAQv9bP7cfrf4YVOo+2JKSNl9bpyNwVkUqibRCjDcZqRKqVwZV4ga39b8Z64blpcxS0e4Gh5c5cwDkVOp4ucbTNBv3ROIllNMfV4JFqvc5MnKI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(26005)(54906003)(2906002)(6506007)(53546011)(66476007)(66446008)(8676002)(6916009)(52536014)(66556008)(86362001)(4326008)(9686003)(66946007)(55016002)(38100700002)(76116006)(122000001)(186003)(64756008)(5660300002)(316002)(7696005)(8936002)(7416002)(478600001)(33656002)(71200400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cKrcGjEQcrcAEB3eJozTYXdssuWne8IUL/gMEdNpypeZqlUSHTv4HPquyzIO?=
 =?us-ascii?Q?GNNBHVeodPVVSZTww+0/3G331F4sdT8tFba6cqPxjRiDqdvMfB24OH0lE+58?=
 =?us-ascii?Q?wNBRVKOhyN36iBR5o6VR8WVCfw9H/aNrsfkURwnfj1qdy/Qvb6oFjgo/QDuS?=
 =?us-ascii?Q?8sELnuwmv4WLIeXYY72J9nD7TxgnU9fr308JsP7GdysLAwpmziG0voo2/iBC?=
 =?us-ascii?Q?5hTvzaDrE+SKzt2fmPHjKyaZDBkHf+RxknBg3BVgjUCT9MqTmnOJbN+NSwZp?=
 =?us-ascii?Q?J8eUxEAgo979O23wLvIVv3pwAsLm6zqV1F92H5nxlYkBBtnWNY1MW8aaztlB?=
 =?us-ascii?Q?5bQPxnXahaDX/NGk5gRxzTJevJGSi7niFwebD1zmZ35VcEIcutdZOOB85JNi?=
 =?us-ascii?Q?6Jpf+JDIB6aZVjRV9/1WK7zwhn9LZ85cRCPtj1kA6hS8IKqP/ysSVL41Ev2h?=
 =?us-ascii?Q?wpmyIF9ktBgIAeNZ360raAXbBl3HG5aEZShXxAWtfpyteDD8QQkUrRHaNb50?=
 =?us-ascii?Q?FTIcjqIWkwBMhi4RknaEMCR9qMg71tyQ5fKcf7OwEKAiI+o/tus63Klnlx2A?=
 =?us-ascii?Q?oXHXYe3GupF823fFZKHEIySvnQRDEUK2ceEp6agN56wIjxVILhyAiD1fiT3/?=
 =?us-ascii?Q?n1XX2fy789z0n6M5mXfyKbwemhk0SYxZ4YiOuXqPl6/cvkiIDHAHbfIfYbZU?=
 =?us-ascii?Q?4ubazncLh7iOTfdlO+2NYVCVvEGy5QjEI+F9a4U1UH2h2+tq/wzUqJmQ9zwH?=
 =?us-ascii?Q?qq9351gFbFTc4DkVGxLQKcWPgvUBFqlFy3Od0IEHYNkIovivRY8741/v6J4D?=
 =?us-ascii?Q?f0SuItDzG2zW1WDyYTUGO6SZlRfG0TluK5B/lQUWN1oMElFYPsHJ0ndUdf2J?=
 =?us-ascii?Q?Yvnu4vLC3iQfWprGR5eyCOoUWfKX7q6wBrrCNZYN65AU+eQMUs34s2R/LewX?=
 =?us-ascii?Q?KEUer7/8DiIhheTiEICV5Dm95aOC3hh/X2jYgZBW9z37ftJmfitGWP1+LVU6?=
 =?us-ascii?Q?DbXS7Ez24qkFQvP25tiHg1PhpmZNC7Ba6wRFbqfvOZlkIcZgbqz6vYSKakC7?=
 =?us-ascii?Q?IqTGjirjmN7EuvBfoZISHfpdeeIjdXYE59jwhvsJSl1GF3xDmlHLZ7uuA62L?=
 =?us-ascii?Q?3DgjEYth5SLbzXuo7IJhpgZf8g3EC9BWRXeHbeVHn52Q9UhDRvjmifGwal3Z?=
 =?us-ascii?Q?RokFpLw0lNYuFa5FQFs6qFI4+gcSs85If+88sB2fIR/1wgXG1WrW2aJQqrcD?=
 =?us-ascii?Q?f4k71VSt/S4SsaXq+UuzD5huwkRTh9bUGFLyiK9DGrj8vrFpNWwZ/LGbJeST?=
 =?us-ascii?Q?P2MyQxNW8JL4CNjjORpln3Ng?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63bb9dcd-83c8-44cc-2911-08d91cafca1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 23:25:58.4345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EoVKgs+yQRQFLHKAWuQX1DWVjzrS2LWwrS7KHf4mVTP4OnhHphEmvDlhpQgF2fBctBU9Q22u/zrlZraZYcPUCvvT5N2IOGTUmnz7d12KdxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6551
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/21/21 15:37, Omar Sandoval wrote:=0A=
> On Fri, May 21, 2021 at 09:37:43PM +0000, Chaitanya Kulkarni wrote:=0A=
>> On 5/21/21 03:25, Johannes Thumshirn wrote:=0A=
>>> I couldn't spot any errors, but I'm not sure it's worth the effort.=0A=
>>>=0A=
>>> If Jens decides to take it:=0A=
>>> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>>=0A=
>> It does create confusion on the code level which can result in=0A=
>> invalid error checks.=0A=
> Do you have any examples of bugs caused by this confusion (whether they=
=0A=
> were fixed in the past, currently exist, or were caught in code review)?=
=0A=
> That would be good justification for doing this.=0A=
>=0A=
=0A=
Yes, while implementing the ZBD over NVMeOF I accidentally ended up checkin=
g=0A=
the error value < 0 based on the function following declaration :-=0A=
=0A=
  1 F   f    bio_add_zone_append_page  block/bio.c=0A=
  int bio_add_zone_append_page(struct bio *bio, struct page *page,=0A=
=0A=
I did fix it later when doing the next code review myself, maybe that is=0A=
just=0A=
me :P.=0A=
=0A=
Also, new functions inherit the same style such as=0A=
bio_add_zone_append_page() from bio_add_page() and bio_add_pc_page() we=0A=
can prevent that.=0A=
=0A=
What you do you think about the approach suggested by Matthew  size_t ?=0A=
=0A=
=0A=
If it is too much trouble we can drop it.=0A=
=0A=
=0A=
