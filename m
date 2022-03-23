Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4C04E4DA3
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 08:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242152AbiCWH4N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 03:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbiCWH4N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 03:56:13 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF62E010;
        Wed, 23 Mar 2022 00:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648022083; x=1679558083;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=UiXDyVvUIAiV9oD3G1Bj7GCbMou7CvbjLQJ/aC1BvxM=;
  b=NHf30kiMz9c84sCEBd3o+9UXI5bGEUFbUIG23EcdYZrqkWQMCz2sIdxf
   XXmmRtvYNkvaZHGNOtZCiYFkOR+5DPGDpcnUf86+QVcbDZ/a6awz8ajeU
   prbnannKPfqzMzYoe844pYb6poi86uiTNlutSMYn6iZlBRNcH7zPmIs6K
   Blq1BnTy77h+PlQKS0P1r4CMyfnYp1lxUhD0GrQkhS29pSDy9hT50WNVv
   paQub9Zj0PvkCfqIbKbnnX2D4ed/RUhdZT08louYgWdCCYTDWeZwkfz3H
   Wc3pKQGfY6JhHuW9FRjY5W6TcgdOEpg5M1YZEpoUuUV142m2yYqu/KZWF
   A==;
X-IronPort-AV: E=Sophos;i="5.90,203,1643644800"; 
   d="scan'208";a="300191696"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2022 15:54:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gaZ/J1YuOn/kd2pI63pMIzENhc87PQLK70kISKOPoPnSbvenqBBkuJPzHWU/C3ySrt5iSLtmXq7g2ny0PSQU5/Kz7UIIKIVWrBvuhtNF4vK3xJxwlAgQNCoOUOnGeffpYOnCUinI12mKEfT69n6XsCuZO2vTqig95h5iinoJe3nibMan2BI9FOVA4B+dS2goz749tI2Of3pT8AstPwRwsvS4ooRwC/6EDBJMj9/HC9oqDEvYHeaQCb6kTgcsm7HA663TYeod06sVtSa1rrhzWtZB0hRrvKg2McmeIkFvUdDh3XPB7la24wvPD8Mfy7IOCNnfcIa33ENaTqfuuGxXwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UiXDyVvUIAiV9oD3G1Bj7GCbMou7CvbjLQJ/aC1BvxM=;
 b=EOiy07BY+xi884m8u2oQgtSldn1BMQrPOnv2UUD0tSNOJmPau2kCRZSP7srw/VUTJmjTi0TtGnEAbdfkQ7lqJEufVAUPWkvFvlJRh19jsbBvze5uLfZfCuWuV9Tj7VDu68Z0HbRndCzH8Qb5GlHKGjImv5CcL55YcEeWaiQLSNQ0RE0ohXIcjmLBkFRzAdNrL2AbKY3/bQ9mEXTtuz/pZB9XxM7JF6HK1Rzkg6wn42HTBQie4b+X/r76gbvMCzDMiqC+eItk2++IfvXEeeuXIeyFj/iV8iZWy818xdQ0Dkj5cguVd3jNV0vPQVU+v3G5/LbVRPkMRNgux834iJgFNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiXDyVvUIAiV9oD3G1Bj7GCbMou7CvbjLQJ/aC1BvxM=;
 b=Uu69LMwa2ZYt14kCO8KfBjK0BOwJ5RaVeila5HSC9lF6y/VZtpx0elLVyryJB8ACL5R1SVCO4anTCR6Q/pwR7lHQMjFWaOby0ICztNAIUwC0IKImslUTwTdzpH7lBiR2KgqfUXV6zgK3gsvia3Tiha0YCsYfnsQpbdaivTsrOsw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN6PR04MB4158.namprd04.prod.outlook.com (2603:10b6:805:30::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Wed, 23 Mar
 2022 07:54:40 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2%3]) with mapi id 15.20.5102.017; Wed, 23 Mar 2022
 07:54:39 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Haowen Bai <baihaowen@meizu.com>, "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs: btrfs: Remove redundant condition
Thread-Topic: [PATCH] fs: btrfs: Remove redundant condition
Thread-Index: AQHYPlfuGbtB9XwU/0WrDOeXCGnwJQ==
Date:   Wed, 23 Mar 2022 07:54:39 +0000
Message-ID: <PH0PR04MB7416707094AF9C6A42F34D8B9B189@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <1647999958-1496-1-git-send-email-baihaowen@meizu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a3210c3-756f-4c7f-b134-08da0ca2624c
x-ms-traffictypediagnostic: SN6PR04MB4158:EE_
x-microsoft-antispam-prvs: <SN6PR04MB415858FA73FD5204C94B7ADB9B189@SN6PR04MB4158.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GhYLn4adSLapiP9w4Oke45AG6oOA3A0pZ9JPXjay97S49G1DOMcwbbKUTV1wuD7EJ6ZSDX1/Rnl+65mCvA5iA1oMqbdvqaZw+BKFtEbnGM/KdG2u4Z66Td/G9BS/GKsDcH7Z2DxUeby5nrLcQLbNfBbAQPIDlerDCUFCNhSV0xxiU9XldAlZFP0L+vhFaq/dCH1yP67PGmCS8FSArEXdTIZ6yqFv6lhcdTSGlacxHEc0Vo5B2afth70kTEpRO1hkmpVwem/Cuqud2cvrEeS7DS+r9kn23X5W1SBjvFsYCFhSpl3nNeYehTEBHiEZhno6fqOGsZvJJS1QVFpSeBXSf3vBIfm/gEReC9vpyVNCms2VWP4DjFf1rvYV+CGdn603JM1P9ab3WZVu6WJt+zf4fsSQRFTdj5NffkMMFgzZdfiY39DQIMss/GoMG1Faful0AwJBFD/AOAMi7lqfeBG20cZMKHzwmiR3gIqA7dEAvzSG05ioOE11/taCIRRS2BZwIs7BOm2PrBiAnjgEBNWQVmoWUoxSE+5M9X4ZsECbN3Y3wRyNT3+IpK4UpkFWbYi8rQFkgBbZN/BM1dLRYFDV4ofHIxRNYopjGPNjYrpugay+yN20b4DrjmHODYzvWUABkaQUT17xLMXQ6shne1pjgjDF+wGl73eHILNvrDZVCYkgGAcNtmf3xzn8sqhgRfacEUSeyzM7x7kRXDre4Kji6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(71200400001)(52536014)(122000001)(8936002)(4326008)(82960400001)(5660300002)(38100700002)(2906002)(66476007)(66946007)(66446008)(9686003)(66556008)(64756008)(8676002)(7696005)(33656002)(76116006)(53546011)(508600001)(110136005)(38070700005)(91956017)(86362001)(54906003)(55016003)(558084003)(316002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BDJkGXm5BqxDM7XcA7w51Gm3NSJsSLkCRsbahKGeOBuBe9tNKLtvxtgXMMly?=
 =?us-ascii?Q?mG0GSCd0/F3afI5eN33k1zivHubsM3zk1RJdShBg2A6k7edBOSSLfVEKyYpK?=
 =?us-ascii?Q?Jyym1M0HXsqHlVtHQZYxbKMeKnJSElhqg5hVMwqFiP2fkbZ4zy8P1VJrz72o?=
 =?us-ascii?Q?tYOiI2eBrpUreKpALCWlhFQp3Kw/FBBmyH11EyMeEjodiqm4ioRbd3oEDzo0?=
 =?us-ascii?Q?T1P1wNOiDMUdClI2VA+noThyItGmNa7He/q/ziZWqj9Jxj+O/W/sHnY5oTnr?=
 =?us-ascii?Q?+cODdiw32zHeUDtaAjBthyjToidrqg9+Ll9J6z/uIqVPGBIL+BFRQGvRdpgC?=
 =?us-ascii?Q?QOANN8Qc0vmDFfimyUS2JvHxNcNG6lIVApgS5l4uywW2GFhb6EJD1DnFufmt?=
 =?us-ascii?Q?P4wi1XWp5Ne2fnjksJetrVeHsORK1DaNUJ+zGF9psj95IkrLV4wnSxNyNBU0?=
 =?us-ascii?Q?6sPr4M5pQTZyHbcu/ofu/rIzuKdWHzm3RfjNnl/dVb43MIayMV8kZ3Le6gmy?=
 =?us-ascii?Q?ao1suyXQGhRQ/ukCyTDbYvOVdRD8Sk40F/CTXQm4zGMubUDkJxdiCaeUd8wY?=
 =?us-ascii?Q?GjSAPck6JXGhYE9M964aE7oQym/3hJikXXzFWwWbkuB4v/7TRlqe7jbzj9g5?=
 =?us-ascii?Q?EpBFCA3VN6JXE5NSnhE60dBIqVsLV7UJU3AbZXZopUkgmAzCs7VLXpYrvsH+?=
 =?us-ascii?Q?i+daS+Wzhetdlvx2AMFJRMP7mNvlKK9RUnpDKtZnRqlAzdKobXpK+8WgnxPV?=
 =?us-ascii?Q?wthpCvE/p1fwLOixetuptXa1JPHmV5Yf70LKsufoNUxo8BUtxkWWMESjoZGO?=
 =?us-ascii?Q?txjVhAVB3LERPULfNwgxy/UtlJ4Dxmqm86h7bWlaKBlKo8+TvPiTiyBU69fx?=
 =?us-ascii?Q?TjX6ke2tn3f81CEPSA1mdsBD4vHQJbdfwih19LuFx4WEmlJdGkWqzexc3WyY?=
 =?us-ascii?Q?gBSy5W5Fm9jGbJiNFHNTFI2Kqu8i1od0L/pNuD+u4NJB1CKTBRiqF2wJyw8h?=
 =?us-ascii?Q?nVxA1dqGzEs6iL+I2QrohZA9krRkOIddrzooeUS6fWTThspup6CW/PBewAEN?=
 =?us-ascii?Q?dnqzvYiIioXKqZKSU6TjJxvDAKQ+AVkyXgMWIMyz55CMGWxPulTnBMxPV+We?=
 =?us-ascii?Q?8Pr69fRpWzGEVgscJDVIVoC023lR6Z67mNWnyIE7VfQ9OqmKj9JG/u4vfxw/?=
 =?us-ascii?Q?a1Trmikl2NMNN3ajlq+tFMsba91TwArA3hLoe3ho6sAL71y4Qu0lOJVhPCCi?=
 =?us-ascii?Q?cUfQ/0Zsk7KjbNXv+Aq/jfaxhJI44GlGo/EPfyzI7d3ouJs4Nh91pbyUypsb?=
 =?us-ascii?Q?sFmxZEfuW8uw2kccGvYf01qnwlwSeXkpiZaqrySRVFc6Qqs4jyU2EVgDgrpn?=
 =?us-ascii?Q?8Xsuml8Bh4SWmewt6oELS0+kpfhZ2dyyi4PtuWybZqiVdp4v9kpVCZu8FAw0?=
 =?us-ascii?Q?zPIdWyG2pLgi5yrqNMRPoXaavkexmkFLznE35iF+fJzHGb5+TDzksuCKouRU?=
 =?us-ascii?Q?UKd0oXy79H9VMZgaRGdtp6ij7A2hPhV1vwLWAgx1MI0t4JVToahlYuJJUagi?=
 =?us-ascii?Q?9ACn8guocdCCk5v48x4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3210c3-756f-4c7f-b134-08da0ca2624c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2022 07:54:39.8369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4CGj8StltP2IYIrizRM6xJVH48ARXrTF7BsAXBo8xNcziGR9Un3RCA70Iajozdr9WWDtjaZzCndZQQnvQDCjfs7oZXIwbp761yDzZWRlwaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4158
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23/03/2022 02:47, Haowen Bai wrote:=0A=
> The logic !A || A && B is equivalent to !A || B. so we can=0A=
> make code clear.=0A=
> =0A=
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>=0A=
> ---=0A=
=0A=
Well I guess as this is the 3rd time someone wants to do this:=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
