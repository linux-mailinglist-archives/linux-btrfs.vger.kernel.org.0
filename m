Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C02C529C3F
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 10:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242283AbiEQIUS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 04:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbiEQIUP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 04:20:15 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E43640F
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 01:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652775614; x=1684311614;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=nETF0ms2NbKZENkNhZRtzGZ3ctuuAfJ80+zR9lt0exQ=;
  b=bRxt0dG4dAywcDrFU6NO19dPNgJEXNiREjI9L3SXIocfmHn0gDgpvieS
   ans6uWgOsLOQRDI8PFtOi4H8PmGZbOd123SqOkmqJbG0nukRSTUpUFqWd
   kX3vGRNiUcZOXbG95UViMRQqfXNhGuRtpHvCCKlUFvdiZtFUy+SWILw4v
   Y1G3NXVdxLiYBfuiEmZvSQvZ4iaXZTxS92E6glfAtS35VXSbn9finxX37
   g1Vt3PlOtukbcZF308OleVoDGtrt06XBN8uzt+y3+2U2/LY8BG1YJZe3D
   LAD8uLuN9CcKGnDABm3L6wc70v7PL4R5hDRUU7eDGk4mBryhws3MWKjIg
   w==;
X-IronPort-AV: E=Sophos;i="5.91,232,1647273600"; 
   d="scan'208";a="312516288"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2022 16:20:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVND0yrhFgSqbPRUp7UARml6RXkbCcSVorZ4oYMNNxCGTZ06I1kvrPN3Ei8dA05YF27/LESujlLok+Q0pTFsPWsrCicO83M1gjEdEFBE/KvI6mPqof562qKDA4wETp/H+jZqkzGPQ3fpBBhQDewOiVYfiS74EO5wrO/RPVUK+TkAb7rWdMDILJMYmDSpU3PUDx34OQXtCuJYUR09v83bzcOiPI/WgKqrSxy3+hV/2r/AYkcrpToKAklbtv4tHhU47B5Jx+ZrMOea2MK0kHJe9ad0g770bz3Bins8qBWrsMspmTMAWZswFMRZSxtUaTbeb3YBn9WeW8E7VI7t/+fuyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nETF0ms2NbKZENkNhZRtzGZ3ctuuAfJ80+zR9lt0exQ=;
 b=knHrzet45u6qscarZBO4FVPCMSwRUgvgyCioQRyizP5AmxfSFacrILhC//H252wtwWN9JL/XONjD19B6Umj/nUWuMrupkTTaV/n/sffYqHlyCNwKVR5k6+hxwSAwfdGdxQB3J9sUW0A1VNj2emNe/wtz3XwGcEzzMPyIbqfos6K5Jelz1EmEhNFOyVaWyV8KRi9Mvpf8ZKA6OFTYB7VI9crqT4yMJgCNOajhER6TRP4N6RHXAsrtJVQrsUQGDyclLsv8u2VofSLaMCE2asp6mIVfwKQ4/+V2dTR8G3JI1mwNTo7D4PH83111VYkR6DGzLY0TDyGOAazhHlZG+nXp4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nETF0ms2NbKZENkNhZRtzGZ3ctuuAfJ80+zR9lt0exQ=;
 b=QUucJG2iRvAgvdpnj9tTKcofu9+DwAmfhZ5lJXsGANYt187fY9rHZ72qwDf5cqKakwXEXtBf+o2OtVD1L9IEBJkQVz/KqMofYSumEwPxEtt/ujBIYyrtCzCVYSlkv3l6uGYxRKPxKQ9ux8e7dS7bveHrnkMeGKqgDmxghzNydrg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB4938.namprd04.prod.outlook.com (2603:10b6:5:fc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Tue, 17 May
 2022 08:20:03 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 08:20:03 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC ONLY 5/8] btrfs: add code to delete raid extent
Thread-Topic: [RFC ONLY 5/8] btrfs: add code to delete raid extent
Thread-Index: AQHYaTGzxFAMBdfaGEiUgbBInU4byA==
Date:   Tue, 17 May 2022 08:20:03 +0000
Message-ID: <PH0PR04MB74164ADA2B3AE9E749CE78209BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <b018704727883c27c3368f1cd3ba84daf682b733.1652711187.git.johannes.thumshirn@wdc.com>
 <d16c5465-2c24-1ce1-9b51-be85cd96259b@gmx.com>
 <PH0PR04MB7416FE34CF8A665F960691179BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <573613d5-156d-fee6-5b96-91ad823364b2@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2d50074-3638-42ed-72b6-08da37de0b10
x-ms-traffictypediagnostic: DM6PR04MB4938:EE_
x-microsoft-antispam-prvs: <DM6PR04MB4938A12E5CB904A8D89176329BCE9@DM6PR04MB4938.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f3UzDw01ML2lNFTGtcyo8LwmYbliLgPQepZKcNNWVlq/LnMRCbunI1QvWy3qCj68qUZegttDhoHNx62PJTx9aO3RV4H1EB/w1121rK2QBH9QPQQ+RqObLriG3SwMoeRnYrjalxJFE7nsXhItuHnJok47AyFMgeW/RC8GPb5tZXBcWTk3xLdmbZncg0Qz7YtBKaji3nmP+pNjwWpCa1xAgpe/obsnWemJ6cR6vvyEooahcjSsOlNAxFOc37zaTCRceb+++tMF6eFS3qMYG2fj3etOWeiJX3YW0t4Ae4EGF32t31tGt7lwevVhaa7yOOMikRRxqdA5u43nKUxtZQO+XJIQJzU8a7rsIPAS7txmwB4ylDDIWrsbbd4djGAOSfF7LKap1lMrPuIENA7hbWY6CeV7F0O3/GiwPLst3/H5m+xWCHklPQe3e+ZHCI4IX+CX+lgPIHopdlLJY9JIW0HXYtDSJ7dqYdT+tUM+8rP3dLz1swN/NCb/Giz/pBD4fTURwRxEeig5l1WJxSdHJC8n96Z2yZpY81yImAB3oxiTexLDYmj4rcwOFaq7VlODTumnrWxeMonjnsH1LV8mgajT9qVgjtsyiSwuojlvU/SsKi89VYuhNVXHhiqWiMkPjFRimQxWPtNuL5BI5GEhpFK8eEDmjAW/D6bUGS9tbPpabX5uAo2UTu0Js4/IGivSlNtWHIl0DOtelo/kucAOsdRVHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(7696005)(5660300002)(38100700002)(86362001)(4744005)(52536014)(91956017)(2906002)(53546011)(6506007)(508600001)(122000001)(33656002)(8676002)(66556008)(66446008)(64756008)(66476007)(76116006)(66946007)(9686003)(316002)(82960400001)(8936002)(186003)(55016003)(71200400001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mZKNHe8t0yM8+wCGoQgar4IkYrKVtQ3VA1e7s+gjPyM0uQyAvzsZNI7YEFJ8?=
 =?us-ascii?Q?r0BWPxQ+4G31jrvebFNeuapVI40u3vO/mkUSCzY4HG9zgTLzhTo9e8cjJxCM?=
 =?us-ascii?Q?gu/DqPYGA6oIXp5dJXkhxurzr2bz6j4Mrls41QuSJuCtaXQOqyp8LEhSgAbB?=
 =?us-ascii?Q?JWOMuFINN1tq2xjineQKIDsxWLZToDN7GzXHwJxACj/XxDc7YaJ4YxMfT1cA?=
 =?us-ascii?Q?+AFPELozOa+IvTU3mmhecGD9eEjRvEGCyKOl0JgweX5pY00dyqMUS50o8ADP?=
 =?us-ascii?Q?ZlvePP/iL/dO/tqaobXs2PNTu1bQRAAhRxw/0BEmZAcFB/odeYxk+KAfK639?=
 =?us-ascii?Q?OXTr1XQypfZMCfKgq6Q61rbfj+lvArc3PPsF6tGpx2BKyQaFfznLke2YGZb7?=
 =?us-ascii?Q?cqTNeN6L0S0zgrRvuzvMDhB8UrJF0FZYixkmLLIc78yUDoDlgs7eS1nJcLf3?=
 =?us-ascii?Q?QtdAKxO0fZ0LSYA/FEBrb74YPCCudfU+y9Mb6EMzLXJLrI3MeZn6jW5bL9mo?=
 =?us-ascii?Q?ujCJ+p/8cdSubRUnd3tIp1Gecqprir7ZN7pz4as5HACq/xSIdutR0BeEMfYD?=
 =?us-ascii?Q?Ey04pIQoTCHspThrgrTwezLTTACZeRoLX8uDrWUelbLniiCOO8MUTkiOoaei?=
 =?us-ascii?Q?zcj4sGxV1/YTrYpmuSP/9T4M598w53Mg2IlCp0tK740SdQ1jCiypgnQlvNmm?=
 =?us-ascii?Q?Zyzwy8LZJ3Sz6SDbHQ6cMNHngzZosreUdYknzCnzTzbdKXdj/fZewVLHueMK?=
 =?us-ascii?Q?4A8Z5RMLzDuW1+/4Mvmzry9Y5nXrqkoc1Wpqp4rhnSnZoHBZC7Wo/0gMBTos?=
 =?us-ascii?Q?rimClP8n9SPG6iWyZ+cGdHVqTlmqutp5ImBVR6NpXigk6EKsYwDT6aLqOAin?=
 =?us-ascii?Q?HVMT8oUn/Z99IjnsLsvIg+AU0hZlctE5m2EypJTVhkbGWIUuFRKgW0CJsjge?=
 =?us-ascii?Q?95QQCczYBzSd9ZxWOxMZI3STWG70BNiDashMg55zSNCETJKctFISJwHjsz6r?=
 =?us-ascii?Q?9ui6O22fhvuniwqXPqfxg7wMhSFu8Lhee07J1/93bMske45IsMWelR8dFNxl?=
 =?us-ascii?Q?lKu0GCIeDaX6EVMLYNIDIz11qavSV/OPNCYdMAPtjzfehaXJ/u5rzcjN6e5M?=
 =?us-ascii?Q?eXJB6mPBA2oKlJGTCl+dlyFNQP9dS1FEwkCru7cqpqlbWsDwlKtbj3oN7AZN?=
 =?us-ascii?Q?O1VPDemJmWuQJVJ7jZZPGYJaB4BCGW85W1PNP97a+Pvx2RBwEDOu8Ps4XpqH?=
 =?us-ascii?Q?p/tTFwYnj3pdUihnF+zwkXcjc9rDhPA6dTRvsb7s8kl69jjPz8Scc1WWDF+A?=
 =?us-ascii?Q?gFt4fbcs/dHFd4nhcFBPsv/LuwnnVfxife0q+Rtx69K+Gefs7zqmXbfjjHtm?=
 =?us-ascii?Q?DtV3uGJQanNYGUl5Zkk7V85WC5MP63XMbCFrlBskW/Hgd65Gmb5gxDVfogn9?=
 =?us-ascii?Q?p3jh4bFJ4vXuIgVPR3Yd6iy+cNiBdH/h3rqlskaM5fW/M+rHHFnyRoFXmjcl?=
 =?us-ascii?Q?DYajmpNnfvwkLXewLUWsDyf6uB4e9Bn2KcLE0mu8hJPxoEYPsB/CIM7X50U1?=
 =?us-ascii?Q?obto2ug+K8T/D9kz+VNRZ13rqsIf0CREESvrKgfqMGiuGWf7jxfs7uPJlRek?=
 =?us-ascii?Q?ltZw0jwpu4Ys6SF6nmFnswummP4n5DcASh2+MA68Ga+fBCFroy2ym3SJWrnO?=
 =?us-ascii?Q?eKM26OVvg/jaJzX5U315Zs5b3wxjx58sXe9Bj8tRMrWaVQyOJAQvt9A81Ivw?=
 =?us-ascii?Q?qekt6pb8aTOUphV5bXFu5KC2YXAzq7LPV2zjW6MaInqP/Y4ryTnbphk3qH4a?=
x-ms-exchange-antispam-messagedata-1: fIFsqYmSKHYn5k2+8oO1y3rBDaIW4mwAFKpjnGXvr8+tA2rqktRtkk17
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d50074-3638-42ed-72b6-08da37de0b10
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 08:20:03.4084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jcx365zLf3IXcDj9qTuwLmUhGxWn4FwRxpAfweLhTmia0k/eRhqImwrIFu1shN/DvGKmAqITECbMwOfovl08r6IBIuijMqxFKS/PNJEXj10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4938
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/05/2022 10:15, Qu Wenruo wrote:=0A=
> But btrfs extents are immortal, it can only get freed when every bytes=0A=
> are no longer referred to.=0A=
> =0A=
> Btrfs_drop_extents() is complex because it's working on file extent=0A=
> level, but __btrfs_free_extent() is already working on extent level.=0A=
> =0A=
> Or do you mean, the raid stripe is not really bounded to extent level,=0A=
> but really bounded to file extent level?=0A=
> =0A=
> Then I'm not sure if it's a good idea to do such level mapping then.=0A=
=0A=
It is bound to the file_extent_item as the extent_item is lacking the =0A=
(logical, lenght) information I need.=0A=
