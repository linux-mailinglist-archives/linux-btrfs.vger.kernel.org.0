Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51FF72C4EB
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jun 2023 14:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbjFLMuh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jun 2023 08:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235558AbjFLMud (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jun 2023 08:50:33 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7B810EA
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 05:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686574226; x=1718110226;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CwhqJDnOxvR105OCQZUzAYsqGez18fTOUNmlq082w50=;
  b=bHO2BvFIbr5wHkV2RfJljsEsp2A2YDiR2nY1vw6dwKs1FrnN2VVHHUC3
   nKwwWtgyWYMQB/PCKDxbdLL+aMXZjfldZTmfb5ZHinDeclI7g5CQAXyE8
   prunKJuhagpiU08Pxwk748J9SUISXxQjrLeSFkmph0LuE/GIlr5Uhb7uw
   msNliDdqjHCnU/BzhgSVBUxr6447OEj3oFSXNkN80lJz4dU6RCAsNvPPi
   0GROV5dmwIRzF2h3f9Skkq/IZMknzIHiFUsHBzkgdwj1AIDLvwhV2Cgzk
   xuY7CXnA9/Ho04zDrYjNyGn1znioNI77wmrO3JUWAttMjg/JKnMlAMsDZ
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,236,1681142400"; 
   d="scan'208";a="235436613"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jun 2023 20:50:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSVBATQnn6qfb4Z4VkkdptcnZwxfaWbRLHeKFgCFarA+rTWcLDNm6dKrh2dugoWZ2weORRgpX36BYYrAWyIkA1QtTd4RW5gftCl60YVSzcuODzkjRQ2f0qTe5YbeqThFnHCAwJPbYllKaS53AdtWoPm/yZ+PbHY1YhiFL4NrlxJWN1GojrndPmsTdqhkEwUykXk8fD7sBKf2tLCFJirdx+lZ/7HDIhZpT3y4VvunmQNnfpnVoSm27/aqU+y1eLCbhuUSACm18TA0IArUci89hPmNJGvP9tVLAeCUunegTpf+rSJhb/YMQBdF2RNfLM7akXj+0NgPW4KPb3D9kbjung==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3UAGy3ZwgOwyaroMXWO8svQkkSbdX+j0L+A1or8HD8=;
 b=JSmmfWOuaoJNYnACkc8hjkktYacU8Ki7zvpEVtVdUVMRCwsSDFunIndWGQaKiEksFsOcBSIQ6I/oWlRm4dYlWNISiQlGFSxG1XWPF795HVM2EYpL3fXycSWYCiw5ORxVY/uq8juWL2LwfklqjH0AZD3UWg9i/w5Yz9xDCNsb3Xx9MT7zYhhQfD6aAD3lKdOgZ66s8x8LGBjDIwvCqYxbRT73dy1eArSSzJVr2R9dm2kpLxkUeVGcWPtGCsw6RRnlOmnezyMO04gn/LR+d+HPZr6x8xkIvkhN7qO4kOVN8lwPywZm9LvcsjTbmUo8CA+b4sRI1Roepaj/1ND11hzFFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3UAGy3ZwgOwyaroMXWO8svQkkSbdX+j0L+A1or8HD8=;
 b=xqYMIwqgJxrXGk7Zg0ZtlGohP6vVdGfFekrLqYIY3nMVkDYhiRnJvgmbsQekJ9OVZ/l8ZqxxS//877nFNUCuQXO9ER1IDEIeH+z+sCZ71VRNLrOc7AiOlz1aTyP/W2pIu2xBq6U0G3cru8ICZk/I0fih71v5GqbIOTcqJpyrj7M=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CH2PR04MB7080.namprd04.prod.outlook.com (2603:10b6:610:9f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 12:50:22 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::e9d9:ae8:fb59:5f01]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::e9d9:ae8:fb59:5f01%4]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 12:50:22 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Boris Burkov <boris@bur.io>
CC:     Naohiro Aota <naota@elisp.net>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/4] btrfs: delete unused BGs while reclaiming BGs
Thread-Topic: [PATCH 1/4] btrfs: delete unused BGs while reclaiming BGs
Thread-Index: AQHZmDjvFfYJ0hOF1USNR3z/TNgYb69/sOSAgAd3j4A=
Date:   Mon, 12 Jun 2023 12:50:21 +0000
Message-ID: <axabm7qsqzqq3vzsufi5x24rhc26hldo3tvd2e5wmi6kjbtrpn@6iurkup4qcao>
References: <cover.1686028197.git.naohiro.aota@wdc.com>
 <06288ff9c090a5bfe76e0a2080eb1fbd640cdd62.1686028197.git.naohiro.aota@wdc.com>
 <20230607184837.GA3191631@zen>
In-Reply-To: <20230607184837.GA3191631@zen>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CH2PR04MB7080:EE_
x-ms-office365-filtering-correlation-id: a0b5c01f-b91c-47cd-45a9-08db6b439594
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IXs5zU2He4G1oeMjgDQ/wiV+492B1SCDrNb47YXxsAeMAyqwup2NMTKr2N1euehEDHD6H4ORK4ytxCtPEmjrw/dQXPrYkur0jeEjt4H0VfozlicGq4j5Qk+qgVyx9vQ0DYyl/nFBl3lYl+MEP+Jm1Lw/kENCFCRfI6DWYh/ZZhQLzwSIKZZXKGzxamkZ3ZmxkDrPh4k15sxNkaDj1cgSUPdQeciMXI3ILldLPDWvvEuzx2ibzP6IXIGTEBI1iQ1u66f4EffVrU9PbE3+qwW++tP0EfVluM4Q7g6IiQVshp6X+a/e0AvoIh7gjUZDaYJIaXyYzyDRkgMAK0jZ+aP/sAhuTZzWJ82I1bw2j0n0rxEpUCpCrj+l1f4P0jBDfh1x9Tcobvj0q664s8WU+O+h8STbW1tboCNGbwLTUIPvmswl8+8J6GbssovwaZniAVAVPQ2CwIpfrPFWoX0HhutmUJe/zlKLEV2xMzPMPRANnBpNKanv6a4zNE7dg6bnTf3TgH8I/1pD0IW47+4Xnv2a8+9ctgSgzGBJEui6HjDY7txvz91Ensbxeqt6Hs5FxqllG4QJo1XcPN9YkwQho6ugdZW+R0S8sRzg4cCM2CcLskbFcBe8PDuRugxLl0RmHcNp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(396003)(346002)(39860400002)(376002)(136003)(366004)(451199021)(33716001)(86362001)(38100700002)(122000001)(82960400001)(38070700005)(6486002)(478600001)(71200400001)(54906003)(8676002)(8936002)(66446008)(5660300002)(6916009)(4326008)(66556008)(64756008)(66946007)(316002)(76116006)(2906002)(91956017)(41300700001)(186003)(9686003)(6512007)(66476007)(83380400001)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VwWD+JNTN4hB7nCiQYmnM2l13EQDDAuPWCFNLG7D3Tcan+hkZOeBo3qT+5as?=
 =?us-ascii?Q?eelqY46hePIwTmsFbKxhZCiNmI4BEHkCSOsml+ECdAAUpM0IUM7gstNSnIP+?=
 =?us-ascii?Q?XI7u25cC66gVK6cqc0BsHLYHgDPslfElvndx1liMcSgFcVGUSoYYtD/em7G3?=
 =?us-ascii?Q?4wJfcX8qmd4eFpxh8GwI4jwAs98gl3eUvL3qzLsvTMiO1o4gX6+RPYuDEv8Y?=
 =?us-ascii?Q?nFYZZgjqRb/uzFkTDqzFKf5HkaKbj1yLSQ27J0xZTcEQT4G7Y4214Fr9XvJK?=
 =?us-ascii?Q?Py5kK6srxWot+rKCUSRkbfJdxpXvTkLJgRVfr8oZ2d+eIzzgL4L5AbwaTCgk?=
 =?us-ascii?Q?wYY6vzgPcAShz8hFCXQlAc908CPj1oDD9Lgra47kyxUZ4jPanG7ZgDfrxngx?=
 =?us-ascii?Q?hwZvYNqjRGNDJIwQB5PcY5U3iz5TXtMVWvl517RhcIZsknREVZI4beT8R6Wa?=
 =?us-ascii?Q?DE5BEBVT659k8ESmeVfJF40V920Rrx5ffO8EQjceh2AenZlIIwOs7JO0E9UQ?=
 =?us-ascii?Q?EWgVvFMf2ty/XRnV/OrygnzzSd8gLhW9IZ597AZ4RJtNlwI5mG0u1b8UThsD?=
 =?us-ascii?Q?kxVG6WOLb18H+Ai1tl93cmVi13WeLnxZFcwNTsD0oIFFI+P3jgUsQg6YRcsp?=
 =?us-ascii?Q?mD45smQMB/Z2MabLnYhqbdNPEkEl7kF0W8aBzd5z3ow8JBQWGd2lJa/WC2/S?=
 =?us-ascii?Q?tQU3UQe61k3Nz4NlS505rvFrvea3bOCbt4KqFqpk9UJvi8PM4BvPuYUex8/i?=
 =?us-ascii?Q?7z7hjLApwfDG3HXYf4el7sp59wAbhS7c427XOpd1iFZhO/Ia6ogD4XirZqyK?=
 =?us-ascii?Q?tulsIA5R/5eaM12JJVvxZUXytPDcQKT0/pfjmAQaEQG17R40WqYeS0nZMny9?=
 =?us-ascii?Q?3WkbnDxV5ZWISmVmnZxkIaOEaPJgkmG6N+KU/DlQkepNRMi1FAQHsVigzh6X?=
 =?us-ascii?Q?bYgCGX1c+CIcrx/x3NSMfOu8g905H6BsgjTCx/E4fFb9fIf0OyBliv4biWPY?=
 =?us-ascii?Q?jJyFyYkPN18sXkxMZ/P6MAWD0F224+JC0eMdB+/+aD6qhgHVMZdTyHPtvQjX?=
 =?us-ascii?Q?8lplhFWmYWPPIS2/PapviZ/wLg5PiahMk9pvbCMVZZivy1eKZZrKRosE/5yh?=
 =?us-ascii?Q?AwzNLV3MPuMDE6b7byH30CV0s8LJheJ03M2+sZYcAJXRPiond5TTq36aWlVr?=
 =?us-ascii?Q?tlesStxcbKBVLaJU3NZ5K9D+g4gZ0vQJtHzIwgFXfY62jdBcz14lKjdrSzmx?=
 =?us-ascii?Q?clgQI8UM0BpFLJfKXFs/Y21A3diIJhhpo+dkHZyfZnwFU50vlwpA0/+lQ6oS?=
 =?us-ascii?Q?37m+vmy+qIqZPsQssPwd1OKsCI4TAQNV7PUfl7bVL7ZvQiDbFWLtYvaErnNS?=
 =?us-ascii?Q?dLS0D/pADGedZjWqI/akCfZF/EVpfReb+Hv2EnP2Nst+z0q8pnnKVMVJXx4J?=
 =?us-ascii?Q?JFiu4o0cLeLocA/ROMkwsAsFYvFB4szo+X47a3MA0pJKqFnS436yZVv59arq?=
 =?us-ascii?Q?gT33SfgVgXJA5WfJMws/hhvO29fnboj5IEePpfC+koiFfQjCLI5zPq4SaNFq?=
 =?us-ascii?Q?ljTGwGYtpTIly3wabvixnKaZSWNOMc4uFqyrmgqQktcFyJ5MmERWyK0u8DH7?=
 =?us-ascii?Q?bg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C672029A13648643A23C8719722F4C2D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NObh060tQrA9iMrdn9QTQcAy5MFoXUXCib6BSYTSECxXwNFq0ICRKyoZjkb42yyCuXDuMSoSSTwzC2NpkmlI8C6aqcJb0tTgj/kBSRS7EOD9KaIJPveoXruDyYw5vTVIq5la/IIM624x0vyhewd8mppYnKhVyRgyXxNTUV2fw+PS1HeOXit9mGOEt9FwfPsAPJDz+GDXJqlsmakwKfsbnrqF1idtiKQMUPWG9KH/75+M6ta/D1kLZyGeEpKh7auCQJ0XQbFmARqtSP1RB9aidgQ1QnS7kHTdHRqmfm8uP/biGX9tg5TCK2fYwKQMSSz0AwOspxwkdQ3zPR9JNmJsKZJkywGRVtcyum0YJDP9vRED6kU97JrVK1dIRvAfeShtbB7PPnMx3g+4hcA4ILAGCYf5vc+g6FWoTfb4sD5njvmPAyfg2cDNlyIQxk5wqRg8HUKzd2TL5SeGwQCxPR9sgb8um2tWR1+QG6wwCDAmsdzX/YtwWxg2qNtAyJArnlribbnVMvQAzjf4aNQLSQ8H9oydBUYIkBxKiGXwvdmmnluh5xhZTRzWr+DvrLs1bQJ9k6sWeE9cNeu6A5PPMwk2HORaFjOsq2vOyp/VjLMb9qtakrbzc7Wclp1L3ML1WreBL7OS95DK1aBXrVWfecMGGg+hX2qf9d4bhiaxmG4E7C1Mt0ikcD0apryurMbSw1NxUomq/a2ZQUV+Aexy9LOzWyyILYZnK6e2qtQ6j8pr/BQemFFnppfcMCCLQPLDAfsXUqgFSI1NWew3AwaToePPN+wsZ1WzE5uEJZnMDdyv612WFIkBUCag/H3UTZ5n21RomQVzm09cNRfwYxlMEnrGeg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b5c01f-b91c-47cd-45a9-08db6b439594
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 12:50:21.9356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: caY2zDJHn1U9ShhMETRJVICKDyNT/ycMs00pp8CiVw7VLMYkErDclzFfpftms0TtVOlDOnvjqjbbQYdfkxMbFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7080
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 07, 2023 at 11:48:37AM -0700, Boris Burkov wrote:
> On Tue, Jun 06, 2023 at 02:36:33PM +0900, Naohiro Aota wrote:
> > The reclaiming process only starts after the FS volumes are allocated t=
o a
> > certain level (75% by default). Thus, the list of reclaiming target blo=
ck
> > groups can build up so huge at the time the reclaim process kicks in. O=
n a
> > test run, there were over 1000 BGs in the reclaim list.
> >=20
> > As the reclaim involves rewriting the data, it takes really long time t=
o
> > reclaim the BGs. While the reclaim is running, btrfs_delete_unused_bgs(=
)
> > won't proceed because the reclaim side is holding
> > fs_info->reclaim_bgs_lock. As a result, we will have a large number of =
unused
> > BGs kept in the unused list. On my test run, I got 1057 unused BGs.
> >=20
> > Since deleting a block group is relatively easy and fast work, we can c=
all
> > btrfs_delete_unused_bgs() while it reclaims BGs, to avoid building up
> > unused BGs.
> >=20
> > Fixes: 18bb8bbf13c1 ("btrfs: zoned: automatically reclaim zones")
> > CC: stable@vger.kernel.org # 5.15+
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  fs/btrfs/block-group.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >=20
> > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > index 618ba7670e66..c5547da0f6eb 100644
> > --- a/fs/btrfs/block-group.c
> > +++ b/fs/btrfs/block-group.c
> > @@ -1824,10 +1824,24 @@ void btrfs_reclaim_bgs_work(struct work_struct =
*work)
> > =20
> >  next:
> >  		btrfs_put_block_group(bg);
> > +
> > +		mutex_unlock(&fs_info->reclaim_bgs_lock);
> > +		/*
> > +		 * Reclaiming all the BGs in the list can take really long.
> > +		 * Prioritize cleanning up unused BGs.
> > +		 */
> > +		btrfs_delete_unused_bgs(fs_info);
> > +		/*
> > +		 * If we are interrupted by a balance, we can just bail out. The
> > +		 * cleaner thread call me again if necessary.
> > +		 */
> > +		if (!mutex_trylock(&fs_info->reclaim_bgs_lock))
> > +			goto end;
>=20
> I agree that this fix makes sense and a lot of reclaim should not block
> deleting unused bgs.
>=20
> However, it feels quite hacky to me, because by the current design, we
> are explicitly calling btrfs_delete_unused_bgs as a first class cleanup
> action from the cleaner thread, before calling reclaim. I think a little
> more cleanup to integrate the two together would reduce the "throw
> things at the wall" feel here.
>=20
> I would propose either:
> 1. Run them in parallel and make sure they release locks appropriately
>    so that everyone makes good forward progress. I think it's a good
>    model, but kind of a departure from the single cleaner thread so
>    maybe risky/a pain to code.
> 2. Just get rid of the explicit delete unused from cleaner and
>    integrate it as a first class component of this reclaim loop. This
>    loop becomes *the* delete unused work except shutdown type cases.
>=20
> FWIW, not a NAK, just my 2c.

Thank you for your suggestion. Yeah, I also considered something like your
option 2, but I hesitated to do so as a fix patch because it will change
the current cleaner and reclaim thread model. I'll rework them an a
integrated loop if btrfs devs agree with it.

> Thanks,
> Boris
>=20
> >  		spin_lock(&fs_info->unused_bgs_lock);
> >  	}
> >  	spin_unlock(&fs_info->unused_bgs_lock);
> >  	mutex_unlock(&fs_info->reclaim_bgs_lock);
> > +end:
> >  	btrfs_exclop_finish(fs_info);
> >  	sb_end_write(fs_info->sb);
> >  }
> > --=20
> > 2.40.1
> > =
