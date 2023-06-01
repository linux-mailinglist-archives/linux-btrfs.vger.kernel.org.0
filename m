Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCDC719219
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 07:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjFAFVs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jun 2023 01:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjFAFVq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jun 2023 01:21:46 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D022212F
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 22:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685596905; x=1717132905;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mTaTd6pnj50m5GqsCWv6BcXk+lESbjtBy9BdNmS9gpU=;
  b=Aj1Eb47eh3Yr7KYsXQZbmmsnikBSVHiZSnjXgONxISFyiHg5j5V30BdA
   6i5Jg2y3kKo0WNSkqTUgVtHghWNwHlkvcr5+iJGsNJaNBUI9moYLzX7VP
   fkATTxZ4qzR3f+yV124g7edr+EmTYtaEboFK1CwX6fcKhwi5zL9HbFzVq
   qqUCkBsE/ispqkMr7sphw4WCMKapqkUSV1eOXPQTSqbkzRb9DRvMzHtBb
   +3/Ljl99zPth2zyD49hiT5iV2QFsNxeYrq25U6zlXWSdJcIdCItKApW8x
   WID/HBiFGYWZfW4bxm2v1RKooKCuDi6LMBqYUI2mNuHxN27sK9LvCXpjE
   g==;
X-IronPort-AV: E=Sophos;i="6.00,209,1681142400"; 
   d="scan'208";a="344251682"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jun 2023 13:21:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAU8GLcCJub8664eUMEd820LtitM3qZAXml3EidZ7ou8AeDEZ1TFa1fJ//Ad0MZFi5hxg389S90HmJoMkZE/Nt8GCax2Habmb1ePcj7uPNzmVCjUXA3hIfvUmeCYAiUlHI+z5ot/yHLiS6hmQ4US5k+wwjdjYwyU7j1B7xjiRoHrjDSVkVaGutjttCEZ13dimjbYh00u7dmMRXWk68VS5InYb13N8xRc61OBaS3yB4DsKYEDNORG+qBonmtJtDeRmXxCanGbjQRzELTRbrlfHck7Iy4VCDM1HJXHPCEVX0NPqU6gdOdSPpIEgRra10VdmIlwe5440FVEXvktMOx0Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aEo4dkpA/O2kYxvGHamfUinqG7ckrqYiJ6BW6ad7LAo=;
 b=hNg+LPig0MVEs3unuHuKweIiywvuwF7/xJBr5IS51kXLYtU9ROAtFCJuFQajD7TMHGgiM144vIzkug7R48Lam6gRLuSR6vSmpxbIpxk0OCGdZtM7Isa6pLNkzbtHn/4ZadAZOh24sLtRHtPsiyB5vLRK1ul7br2JlgDIdtmMttGzTB7DWbhUN+lUWbFrWxJYzaeXd4Ept3gvmDUySy60IvMUpCRI1WOFYt3/CBYtaWOcXUNSkSDr76Dw0drhxH2v9+TT7pqcYnUQHWqjXHQnQrVYQdHhbYUE+4zW4XBzxrB7ywA8zM6i7qDs+g3CHbcetCQl2S8N59isng4zv2IF2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEo4dkpA/O2kYxvGHamfUinqG7ckrqYiJ6BW6ad7LAo=;
 b=nBdkGbgwLdPxPDQRvXPdx737kpvfYn1YwEbEu6qUOJ5Q1kszqTppGI1T1lCGm9aDon3DWhOvImoRAhe96CeRpBwDy4+LMxq0xcpbNVsWrOGvpZefZPYH8KHjPl+Sz/A9mRNDDKVSQEiiO1xzkfCENXO1+Bmy5io2tuPnx5lEJWo=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB7344.namprd04.prod.outlook.com (2603:10b6:a03:29f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 05:21:42 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::b52e:3dc8:52f:b0cd]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::b52e:3dc8:52f:b0cd%2]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 05:21:42 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: new scrub code vs zoned file systems
Thread-Topic: new scrub code vs zoned file systems
Thread-Index: AQHZk77Fzy8DdBvrZka6eWlKoRbYIK90WyyAgAACsACAAAFQAIAAAYIAgAAJWYCAAAPKgIAAxt0AgAAqPACAAAWeAIAABKoAgAABNYA=
Date:   Thu, 1 Jun 2023 05:21:41 +0000
Message-ID: <mmttvfirtcp32ruvodutdw2vnvxqdnad2gywwb6jxl7gtkzqta@xw75lfxofsso>
References: <546fad79-f436-c561-8b9b-0d9a7db09522@wdc.com>
 <20230531132032.GA30016@lst.de>
 <821003e3-b457-90ba-e733-8c2fdd0c3b3c@wdc.com>
 <20230531133038.GA30855@lst.de>
 <a59b2274-9d64-f11e-f726-9283f560a495@wdc.com> <20230531141739.GA2160@lst.de>
 <134e56ed-1139-a71c-54d7-b4cbc27834a9@gmx.com>
 <20230601044034.GA21827@lst.de>
 <dcc61893-c48d-e8d9-3161-7f7b965b8e8b@gmx.com>
 <gn6vj3mlwsm53iu4ktso2dts4ifyxaky54ivb22laq3mqy27lv@guvvxohmkxy6>
In-Reply-To: <gn6vj3mlwsm53iu4ktso2dts4ifyxaky54ivb22laq3mqy27lv@guvvxohmkxy6>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SJ0PR04MB7344:EE_
x-ms-office365-filtering-correlation-id: fa086238-be0d-4d5d-a45a-08db6260157d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: McYeDuKXsS3rjl1Ur+FJ95yzsMfKyfV5rIHaki1qy3KLTVoiNG23ZDbxtvc3vwOZP5Ebr0ki79+QrWyXP44pqNK6696BeYYs7mTRIABGSTbeHocLjqSxJUwhWLWJ9alcmtFUrkHtDkTsWXWNa/6Wv0rp40H/Lip7/ICBvhCqAF8ZkXJRKtaXsF6CKdzDvuoU/amZRQrokRFR4OSzW7y6F0UYHUyqerqTmnp+w3Pyelulrsz+APlYBOShIybCRBsxihvC/xGOGHYQYiURX+Ek1fmr/hAcL83mwr2DqQ5Uy2NBfmX2DUm8L9pu19FfptY71dphlub85qebAmZQ7HMAy8VX1ti0RtkHVsCVF8zcQM+op62ido+NqL3MdV5PnGia6MldXEtMDufQSwx6jINv9MWGSFTxgXwPnYOrHm6IuLc510L9MYvB3HH/ZeZ9v9siFcHMZbb6OvUEwaIZKjdvW7y1sL+O+3BlZagPlCdRAL5mujuXr6KxORwrHahK1aTZtPmW7MRJ0eiY2w6PoW934WT2qMPVsbRJuAkZHPwQMRJWPziV6C3Ck1/29WWFHKjhJCjnz/5aR0wYhoTGKtwBWk/9xhFfv+V8motGwReyhnyXzj7S6E9wCdi9KWqhc7e8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199021)(83380400001)(71200400001)(6486002)(9686003)(6512007)(26005)(6506007)(186003)(66556008)(76116006)(64756008)(66446008)(66476007)(66946007)(91956017)(4326008)(33716001)(82960400001)(122000001)(38100700002)(86362001)(2906002)(8936002)(41300700001)(316002)(38070700005)(5660300002)(8676002)(478600001)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZAC1L9CGkMo+OTCQH9LA06c1Jmyb65ZDetjZxw88rVcjI4YF1z/5sk2BghqT?=
 =?us-ascii?Q?AJsembs3SCddwJyHvjeddMEb7lo8wDnYhGmNZcgZK9cO3f8rgEHTxS29wJvm?=
 =?us-ascii?Q?hNrG9j1vaC+rwJLz/wDQyN4LouaKaj9DTOE07yy8GQG1zD/811YD75kHS7wV?=
 =?us-ascii?Q?W+Kb+Px7vwGRiLL67hfoWdkPHIVgnv3H1nBKGFFE9PijGRfT2zKdT9uvFcU0?=
 =?us-ascii?Q?/a97r1S4w67pp9gu2Iqs5B5vPiNuUXC541SENnfRa20H2/wNlgRGSMnNofdR?=
 =?us-ascii?Q?4lgOOO4+9nsg6JxSxZN0oDne0v7pXhwpT3RkUhzuBuQ1LtnUjaxwhY08gIMG?=
 =?us-ascii?Q?VfDX7E8bX2CGAJysWS44sbKd/oBWIDcMDtJkaCX6CEbyfQcEK1HsEmQDGC7f?=
 =?us-ascii?Q?xympL1QauIXziLGpNOdH064lf20I65MQLryDG/jyukFGI9sy/BRrq839HNiq?=
 =?us-ascii?Q?jNAZHH7VZSB6WJVVG0T4IYvyUl/JPDOb2ymVyuaxb9aaN92nOCrE0DpN1yNE?=
 =?us-ascii?Q?27DAxCnEocec+osWD+YZr4U8rN6AvexXHX+yggt0S9oSr8WXWeNaIYAc32Yu?=
 =?us-ascii?Q?HXpg2Wi9us3QvVTLLeFWLAY9KXi4YFHuIaHuvPhhLeYsXuQ2T92JUGQ0/69t?=
 =?us-ascii?Q?SlROXCNVVdrvSav8ndrTOwPSA5CxUTEpiiXgGCyfRnOSSYmK0Cly/Fxuof13?=
 =?us-ascii?Q?34yMELFbrwKOuAmAVroeMRa/YgCzbRLoxu46VSJlx++5dO3exS6aGOTc/ZiU?=
 =?us-ascii?Q?IluFVcTT8kvS0uOxrhp7nDPZ3RUpSCK4Rx62SEZ1u1uFU6cj5CN0H3Q0grks?=
 =?us-ascii?Q?eWWl1wqs1SZ8neJv7tOJStICQ98yrqGzlda9Sa81GKhE2v3kuID0vgc5TTNx?=
 =?us-ascii?Q?80te8Vt0WnHjythd9E2NPNsa3nAto0bRuE/8fsQW9njjKcaNHGwdaD3L+iQc?=
 =?us-ascii?Q?un7rzLpwzbaH+VdWnSugZHF7GxiDVpEx7SVS0U/yZbQoXj9he71yxkfxIgBe?=
 =?us-ascii?Q?Hn7Iki8h3Jd31TBTJmt6AJClK/cqsxa5OJnO3ZSMrcmTVb68HCSqcoBiJW6I?=
 =?us-ascii?Q?pOHgy6N671WsgTo0hI9O68T78AavwC4qNZWlNU6/XnkifDeZXBclr8ydvQCP?=
 =?us-ascii?Q?SIr7+wDzqGWYmJooQJbAH+rvZTUquVKa/YnvyWL6X8JNymYKi/QXw6k6gIZp?=
 =?us-ascii?Q?Ef+gvonrRiFc8UzkabK8wU32tCZbxDSXNPVT4IXRY0ZCCl8qp6pxrEvde6wN?=
 =?us-ascii?Q?/JaqcLY1MiYpqeHOx6nWn9iO0C31/teU/RWFd72JUTswXfwF7YfewLHI63Rv?=
 =?us-ascii?Q?c+SKodNtTMljnsgY1xeuFL6na0wHcFn3S6y4EyXOPrS20M3r3jvhZPPs6Ztm?=
 =?us-ascii?Q?G0RJa1uuMXxz7JZaU+5QEc9zI4WkotJa/xrKyps2IAaS6ISkbYssRFXGTeVo?=
 =?us-ascii?Q?fLZOEdml5zmwuP1oTVCy/aDn7GnhDC0bspldgzI6TRMk8p0SSC0gacvNY4pD?=
 =?us-ascii?Q?uZVSbmKLKBGLWOvx8W+21yts5/pSm1c8gx1g5zTMmPjpqgy9h4B2/uFtEdQp?=
 =?us-ascii?Q?TQut203n+Wm2Go19uz/zvyzFGz3y2cK3lzONEF7kD43yY3TU7+A5RiBd8rSk?=
 =?us-ascii?Q?SA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DC91F60726C2564DBF5E74BA794118F0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aQqAfRntb4Nxbv2/R8dreHCrjsrm7gPkYAMpGxnE2SEhhIJpr2ZBJ6qk/lLfOQICq5LdHMFNOI4tOr4Y1+68Apx6QLUP7DeQYyIVrqGJfYnmISkq4u1FLrRexhQMDZmu2qLbIA1GoUoLVIyikp7wJFXr/hsavHxf27ZnYBuAa60xotaFuFWl3BEK4JyAIlNDngxWCFNgHy9ow13uCBpkMmXMtFv/ZbrcZMZJouXcZO+S60zaJ7ZHkAk7Y9mFL/ke555Uf7F2WJ9METUUcv24lo54QO2Yldh/lFHxPz6EsCYLaDnLzLoJ4BIJMCvkprwPVVNTg9vwl+n2y+wjlQZKePSjvlntY84wQ3orIe9DC3/hQc/FxQ+ODXY5ZwTj5+gAcOfzRxwgRC4tn46EQsdTEMA648cTF5G+FDU5+4P7wjiSv94dkFBOz3VlAKZXR0/moaj6nwS78J01Cca1QR/c51efrqq0j+vKpPDhvhL+kM1gCzgTnr9SKfm2pmqeQoVvni7ZLgzfexh6lLDXhvWj2lKo3MwguFY0W9JVNUnksyHz+xtL9p318ZLyzdKYMkmK40uWmaHIA6RsXH3fJiEhnJxP7Ba8W7f/js+viucJa+Y7H6Ytkdyk0hOO5BoGVWTRRLNygrsysLOW+xpx9at/JdiVHOLKs0pkipECP6eHj7yaai4tIJvnNV46wTMd+APKX0eotS95mgNqmMXbTVXZyTYZ/MYtV7jxIOJBVB/Ev0VSBDmFX1O2ZMa0D4hibEWcK/26XvLph1RIyD9LST+UURB/FYblwpvLOKKA/I2knhZTIYwcF2oHt1knzbYbkkYL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa086238-be0d-4d5d-a45a-08db6260157d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 05:21:41.9973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yTrS8TJFh+3vNA8NS30wszyPrfAYlaJrrQMx7NWE9PHAEYUE+t5mGjdrCPb31pseTkhCy1+PycvtpX0FgcAZ6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7344
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 01, 2023 at 02:17:22PM +0900, Naohiro Aota wrote:
> On Thu, Jun 01, 2023 at 01:00:40PM +0800, Qu Wenruo wrote:
> > > > But I'm more concerned about why we have a full zone before that cr=
ash.
> > >=20
> > > I think this is happening because we can't account for the zone filli=
ng
> > > without the proper context.
> >=20
> > I believe it's a different problem, maybe some de-sync between scrub
> > write_pointer and the real zoned pointer inside the device.
> >=20
> > My current guess is, the target zone inside the target device is not
> > properly reset before dev-replace.
>=20
> This must be a different issue. Are we choosing that zone for zone finish
> to free the active zone resource?

BTW, you may want to use this patch to track zone finishing.

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index dbac203ea54a..5b4ab12368c9 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2015,6 +2015,7 @@ static int do_zone_finish(struct btrfs_block_group *b=
lock_group, bool fully_writ
 		btrfs_dev_clear_active_zone(device, physical);
 	}
=20
+	trace_btrfs_zone_finish_block_group(block_group);
 	if (!fully_written)
 		btrfs_dec_block_group_ro(block_group);
=20
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 8ea9cea9bfeb..594e4aca0a02 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2057,6 +2057,12 @@ DEFINE_EVENT(btrfs__block_group, btrfs_skip_unused_b=
lock_group,
 	TP_ARGS(bg_cache)
 );
=20
+DEFINE_EVENT(btrfs__block_group, btrfs_zone_finish_block_group,
+	TP_PROTO(const struct btrfs_block_group *bg_cache),
+
+	TP_ARGS(bg_cache)
+);
+
 TRACE_EVENT(btrfs_set_extent_bit,
 	TP_PROTO(const struct extent_io_tree *tree,
 		 u64 start, u64 len, unsigned set_bits),=
