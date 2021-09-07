Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F9F402310
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 07:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhIGFay (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 01:30:54 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:39530 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbhIGFax (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Sep 2021 01:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630992587; x=1662528587;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=70aO63XXDVC87BHr4J4IUszWnVi5w/JqM0i5GFhWoGE=;
  b=n9aVXOTeorTJKQJLQhs37dHzBkdkZb4XN6Wn08sPDNxMxwvpsK8OChh+
   enjxroAlq1AO2Xi/Rhk+WKFsSrBXzTeqePo2pE9cAYVlwMOoHD0Gtctca
   8sfRnKDi7H+HCrwWIsZf9UyDoqjPwIXRxOejCRPL83mPk8eJrn71yODGW
   CBeE1w2ptC8WPwUtXVk0KSVhMJw0I+ERln7bdWtk/ZnggzFrbDFMv6LoG
   C5LtJ3B6LjweH5F9nCXMhk3Rzs2p+0eBqHzTx8QGRNgFOUycBLPiI9cbd
   AZ8gwPmDoTL/gF+fWOrB6upHIz8oYAzPaO8t+XXpDaCdefzgLOff4sTzi
   g==;
X-IronPort-AV: E=Sophos;i="5.85,274,1624291200"; 
   d="scan'208";a="184128889"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2021 13:29:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0AKP/A0ZcLMnXFGO+0TtsJqbup4ibgOGhuBolGOEgkrtQN6Qop5yVYzfZEPmaeSizi5NTfy8lpg3VMSddvfLV7p8iGXmBgTLlwUGv7X/2i54URrDAZcIY3mUKnci0G9zF0pM9buhKoZ9tsXzxhFmHVRcXyos5uNmS7HsO3FJptFxCRIVwbNNqoY1lW0qbLDaycj6Zws8JVYeCY6wNXg0+RYbqb1mGeoF3J5x0KAWaQ+rQeOFQZCmTNEJjnz1nUsrLd0H442sM9fWODU82gYRsqHxov1ZIS2z4MQjNr3HrFs1X/5zGr97sfowX2NNh1xiYzjeSwjvVmeFfxHwJJBbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=U214DsLfepEcQ++CszQIF4ed7EbM2lK5cguCuj+jfLw=;
 b=At+Awn4hTb9iwGrfW6b4K/tk6MJGLkFvjF+rq6U63Aqg5k01pz0Zq1FM9p3HfJYcg3jU8ywv9lsPl2O+7OlRuyKfzAwtvy4c3s7msxfqHnPbo9vMADKRSOvaP0SH6QdbhlIC6S4uAOJCE+aZB8RnAIVKLVy0dnKM2d/McR5b9AdRkUl4mZf0bm8F0nErAn2g0U/a5PeeJXAoI2oF4TAaWov/myJlVt42SfQ0k1bCVL0WiAFPPJ0niRk/7qj8SK4jv0QERK/S5kx+QrfUXmBGi9IXO+RH7XFyO+bUqYM8iZxEVqCpZCzfd70bRS0EP4Z1wQCjcqJ0B8FOE1M0yZsi0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U214DsLfepEcQ++CszQIF4ed7EbM2lK5cguCuj+jfLw=;
 b=FVFyS6SZP4D9rgL93cgjXprTEJ4yiZ4TnVkQ5Ip/ldpFnVcrPZGwkGcw5ishD9feOIOvw6C5Wru2ql1CGs4+tMxBLg8wMtV70NdLzLi/X6gZIXUu2zIEUKKcXEKg7vsMsB43jmVQ64tX+9OMihkwXapHESg7O7T+F2BseGteNpQ=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB8325.namprd04.prod.outlook.com (2603:10b6:a03:3e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Tue, 7 Sep
 2021 05:29:46 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::19a7:91bd:cb0c:e555]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::19a7:91bd:cb0c:e555%7]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 05:29:46 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Anand Jain <anand.jain@oracle.com>,
        Jingyun He <jingyun.ho@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: btrfs mount takes too long time
Thread-Topic: btrfs mount takes too long time
Thread-Index: AQHXnARByMAr6JKsdU+12Q2vDJ1EmquN184AgApC5YA=
Date:   Tue, 7 Sep 2021 05:29:46 +0000
Message-ID: <20210907052945.t4i4wlq5jytf4sdc@naota-xeon>
References: <CAHQ7scVGPAwEGQOq3Kmn75GJzyzSQ9qrBBZrHFu+4YWQhGE0Lw@mail.gmail.com>
 <ce0a558f-0fab-4d52-f2d1-1faf4fb1777c@oracle.com>
 <CAHQ7scVkHp8Lcfxx2QZXv2ghkW-nYpiFGntyZa0Toz2hU3S-tQ@mail.gmail.com>
 <b0feb23e-4a18-efd7-eeaf-832ef0cf6860@oracle.com>
 <CAHQ7scUiNLVD_4---ArBet-0DqzfmmH5Y9JgQY0grYrUv8yhiQ@mail.gmail.com>
 <c2d2a244-f77c-e0a4-d266-db011fc4154b@oracle.com>
 <CAHQ7scVOYuzz58KcO_fo2rph44CCC46ef=LFVZF8XzoKYq27ig@mail.gmail.com>
 <250cfece-1d7f-b98a-b930-36baa34b8b72@oracle.com>
 <PH0PR04MB74166604ACA14137484EA6E59BCC9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20210831164744.GM3379@twin.jikos.cz>
In-Reply-To: <20210831164744.GM3379@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df0e33ca-e62d-42ca-f5cc-08d971c08135
x-ms-traffictypediagnostic: SJ0PR04MB8325:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB8325054CB58A9B063FAFD6FB8CD39@SJ0PR04MB8325.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rXUajTNW4VfXGbjHbLrZ49vRsX4UJh65anncCRLxC53g4dAWWkWOazXnmKKXs5owEKalbT7s5TvMR64QpynAuMFTrThVYSDvaPPQoCSvlvK1KSihtDZLPJ2B4ypnoQZ5gScn+IJIvDp1HiiUm+H7u3g1m0FXHQvX6ykAJXhpHXs/JBCvcJLY4z0uUKOVPaA7EuaMDEyH4HEuomnAZtdXDS5j6iX4OWtsjMYw05nYp1ntnEWeDM9PdNJPTBUvnn7CM4VaY6vA9aky7v1ZpIvJAA2PBR+RvCp59G082kILqZPc4N8VYgASTwv5e5Ngxi4gtbomDZXBtBIeb3ygesT2Dn6V9tHukIC+HfFbuK3d7nmsErqsa5KwIWyLicwZ+AbZcAeXXAR8PaxeRlPn+006npjKODXqIpaTJ/P0aaads+3ncnkahycuiW2J+iEKrF3oD3s/5SENP3X+5uOE4SAHbWUqcolDk/BB1R0oTMsHQ9caLSvzr/bRJKOaR7IgLGNY297Fcat6tZ3WlR1rHwmDHU+1l9ZV9ggUUDORrbJLryrfb8lCwgQTYcGXqd1zMg8QWwrkV9KHrbtEmZUIQ4FkHIAZhq4NNbRDVXYWFiGJ1Nu+MNxMXP9HxBvyssfFDOFKZ7Xn0IfQhuuLxey8n7NktEChgvptqB3UXvt0A+Qo07Dl+3XCaFZxAMn2SU60BCp9oe5GibjNpTW/nMZr8kZm1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(396003)(136003)(39860400002)(376002)(366004)(346002)(33716001)(316002)(71200400001)(110136005)(83380400001)(122000001)(478600001)(5660300002)(26005)(66476007)(66556008)(66446008)(91956017)(64756008)(6506007)(53546011)(76116006)(66946007)(186003)(6512007)(38070700005)(38100700002)(86362001)(6486002)(1076003)(8936002)(2906002)(9686003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Iu3fX0zE5WYs0M75f3zgwhokLd6wjCc4y5fnbd1pp3noKEAE6KwyJu8anXRK?=
 =?us-ascii?Q?9Cx2eksvE50tgCm7AS/vPabBnXEGuh1F8f9OlsHQhghLhcqNTDVzml6e+j+7?=
 =?us-ascii?Q?2eCXTlYIopMnAeWIIHPtv/WSjjp4wSKtnBbDy4K++kcxTxCbvkjt7Ki2ULVX?=
 =?us-ascii?Q?/7kle7owbLfa/8U6TvLCasrbjTYvgXSQVbrCTqul9sOvx2o8tXIAEyvlR4aY?=
 =?us-ascii?Q?U3qYpttmRUJMJwkQG9YWBDUc5olmRriVgVjnh2NzNk4H69aUFxOD/6R4+UYQ?=
 =?us-ascii?Q?MVXTPecYR1yPlFy8PWLUyq2H7bhusR0qDsQARXeap++OrT8OoUhyILtKsWy+?=
 =?us-ascii?Q?g+E5r6VqtOg63lssbRM7/f9EkqdpKHqymi9DFFaGkR44cUFh/LUTjiWj+285?=
 =?us-ascii?Q?1M5+65ekqig7vDS1EyklvR1PiiNZiOaqLpBZF4hEUQIiLivrRWMAekXfD9Sz?=
 =?us-ascii?Q?zdfIpunwlNWawN3/RyzB94zsFhSYIb9H4JqCR158hSoetVImC2TEI1eEu6Hm?=
 =?us-ascii?Q?NwEs94JwtS2B0HjEc1Vx26w1ns6NkQhuZRRBAModoAgKtjIJfk2UoOj0emOV?=
 =?us-ascii?Q?dqk6NduoioFYmcNv+mxO5MhxM8iqsOHI3YEF5IM3648pm+uQTXR08KNsODxX?=
 =?us-ascii?Q?FIHmRAuFWWA/bpncOd+/dOmZdBE+5zzL/Vtj0KxpN6Hwo0NMVerCZXs15pM2?=
 =?us-ascii?Q?1mMpO+ypFVgSdQQyTVpFu8AutuEuwc7+BlNU11naYLgmIuHwaVYt5kio1rR+?=
 =?us-ascii?Q?gEdZZOp27KnWxgSAr7JYIwkdurpu48la/P/s5DpaNFo9uYAuvtgHoWQiJbrX?=
 =?us-ascii?Q?u+UQXekEszzw7d4HTa/PUiq/6xmLc0LyzKfZejYTmtoAgMjVhGEkPkvLsXIC?=
 =?us-ascii?Q?GIDjaW5X77xXdT8tEGwUWtYmNcpAnNREXx9d+3Mlk8Gg7aIjVLtpvev5l8VT?=
 =?us-ascii?Q?uPdpIkD/N0/YxnScLlD2p2INWrX726lU608WU4ekmasediFLLCwsKSN2EgEq?=
 =?us-ascii?Q?trTz5cRf+ma7aSDZ4sLypMCispZO61GE3fE3p+rIyc3/0hyWd2AqVfOIE29k?=
 =?us-ascii?Q?72krX2dXsPCsouhIvUqYZgpNoKYoKc0g1RrsmV6cb2PRBdu5GSsxeR7mGsMF?=
 =?us-ascii?Q?ievXV/7ZIbM7DLrMr4RfHEzIhUirQyrOWLgo70Zci6x2ZPfxBneE004mWwQa?=
 =?us-ascii?Q?oTgkhck/MdRL10uUDWhp+WUghCqIQrpBklfZZKkrgUCfVO0+ms7Oe/mF3kOq?=
 =?us-ascii?Q?3X4ZvExW4e3wCxjv258nRLm7RMqB8ProVWFMpt59UJzw5Xy9I3u/MR2XV9wK?=
 =?us-ascii?Q?u76yLpJo/a3oIghyhNBO4gHYbD0UQhRVYSJ68cS2RnM8Jw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BEE92DF75627F748802F54AB349EB9B6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df0e33ca-e62d-42ca-f5cc-08d971c08135
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 05:29:46.3793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BV+0kkrhXQpAsAUoViKwjiiQPBc51eln5m/+P3wBBSLuai76M78kGcFtKM9xRAbemMWD/apAdynyfMkM2PCOvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8325
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 31, 2021 at 06:47:44PM +0200, David Sterba wrote:
> On Tue, Aug 31, 2021 at 01:10:38PM +0000, Johannes Thumshirn wrote:
> > [ +Cc Naohiro ]
> >=20
> > On 31/08/2021 14:11, Anand Jain wrote:
> > > But let's see what part in btrfs_load_block_group_zone_info() is taki=
ng
> > > most of the time. Could you please help get this output?
> >=20
> > I'd suspect it's the btrfs_get_dev_zone() call that we need to do for=20
> > each block group in order to determine the current write pointer to
> > set block_group->alloc_offset.
> >=20
> > We could speed up the mount process by caching the device's REPORT ZONE=
S
> > response, as we're doing a REPORT ZONES once to get all zones and then=
=20
> > again per block group load. On a 14TB SMR drive this results in=20
> > (14  * 1024 * 1024) / 256 + 1 =3D 57345 REPORT ZONES calls. OTOH=20
> > struct blk_zone is 64 bytes per zone resulting in 64 * 57344 =3D 3584kB
> > data to be cached.
> >=20
> > So the solution should probably somewhere in between, aka caching X=20
> > REPORT ZONES responses before we need to do a new one.
>=20
> That sounds like a good option. The number of new members in block group
> struct has grown due to zoned support, this means higher memory
> requirements, scaling up with device size. We'll have to do something
> about that eventually.

As a reminder, I'm working on to implement the REPORT ZONES caching
solution on mount time. But, I'm struggling to fill my btrfs to
reproduce the issue due to some other bug (it hang while I'm filling
it). So, it will take some more time implementing it.

Thanks,=
