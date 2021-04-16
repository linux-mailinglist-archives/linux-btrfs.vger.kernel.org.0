Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F0E361D8C
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 12:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240732AbhDPJd2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 05:33:28 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:2112 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239848AbhDPJd0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 05:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618565581; x=1650101581;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=VAloYZ4NY8MDXl3CAAv4NWiY2joFjit6cLxlaRYR4R0=;
  b=V/7AZZgtqmGNdwvDKJHEJhB45trQ62fMH6o+/+iI07zdcK81Rutc/tHX
   J3cIPwvbnc0UxJ7pUJ3rw3vxmlIfZ6ZuEOYNoOQ2+3NX+3b2AEYmQx+7N
   nba7z0go+zSz7+gProXkABfvN02nJtWaK8KmQ+5uDlPD418naNYOR9Rqy
   +kVAXibwR0VzY2m+7wYETYO3LSkeZY9KRZOOSm4HTm7+5l50597tvXMWj
   OF5eITCHnV7ulemB1qBmQ7SKFuQGwEpnctPsHsyJAlBFtcS3K6LylPiaF
   lh+GZ2VCHF4QSjM9kgBYACm2uoaaGOe6+MrD7nD2BirXDRnQWzExEHwAQ
   Q==;
IronPort-SDR: lSuzPfXE+X6kT9W9kDxrDktCEwFNZ7EOdiC3e4mQNySfJn1wHLD9Jkfo7lRKQxXBQOiwOmdhkc
 /gtGe6o5mSucZp3fRUCnflbnUBk0g59SrdPqwamcnxOKwevxsCJ110GYrYhDCtcJEuxCJnKm8x
 rF0b2MQZfxNX2pbc0nK+4hImsPgyNtt7ZRpsxwpzH901g9ql4LxSwhYdfN8qanWglwr5QPU9jc
 ZAn40FTdMkrEz+KLGx4oJZXqTsWmP7MwRa4YCTfV/f7Ihi3VZ3YwjlEfkCXUAn/+FaLIlJ3Aex
 XQo=
X-IronPort-AV: E=Sophos;i="5.82,226,1613404800"; 
   d="scan'208";a="169612786"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2021 17:33:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgZAna9/qVu+cNbJg/CRbgtVuBAr3zIXGLYOHejvvmbKOvz0CGDJ+m3zoqXIEwH9/4Ou64/OuAYXJgyU//w8w3erFDgRfS/TpdPU5/aVPt1KNKQ+fpt7gBqZkSe63tkRSYs3IDJxShxIx0Q0hNCkQ1j8K2hs9GfE/jfvYT2BA6tKwzT3uAAHWSpD4vgtXJUqTD2krl7uPyBq6MUCMOFCv5vPsLu1XbMxUOyq4G5MyM0tZFbfVn9RH1NCZ50pqus10zx1b+0chm7ZR+ZYb0dvp3mCwIGrMj4w+P5SZFSeJZEgWqVq1pMvB+nvyYvYOaGJjnlIRaNB3bzu01agcw5bjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAloYZ4NY8MDXl3CAAv4NWiY2joFjit6cLxlaRYR4R0=;
 b=KjydP7JBewyJ+vsqZVgdGmm5an+7wBB9eOjAUJz875JEfmr5PDfQIFKsdEbWDF6TRw06G0SgwxPNP3t0Pm9ajwOhF300z/G46PP7c/m/oKugbyfeHB4VqLpYOy7l4ZIqE9CUpkhvMFfOBZHkcdVuNUCDNsVbB7qiVC1QNVy/xXEEY9C9rMEnTX9np4ZnlOG3mb2/Ky13c9MMtxzOmiHNxJuDnVqSVga/VxuL0mE4qbIvw1FY6QY7xwQIMHY4XOsB/suCicVJlyaT/gE1nnEV3zhZDFg9S2+Q53kOTJKQE5FA+P74lnZJFlupXFdSJYr6NDHKUxyOX/Mihgrbp6dhlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAloYZ4NY8MDXl3CAAv4NWiY2joFjit6cLxlaRYR4R0=;
 b=UyA+x7I2DD0rq2Szh1MSPADdE3gtimPLUQIWxoHkHA07aFh/8qgGYJ2/p6ZWRw/x08kZWu0zuylF397QXlfoMtqtUFlMTWX1cvU7ks/au0Ok6b6XiIN4jpw+pdOLv1jrSHvZkXt/m0YnQEWHxcq6WyrRzPhTqHuBLyFn6BjYKMU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7541.namprd04.prod.outlook.com (2603:10b6:510:54::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Fri, 16 Apr
 2021 09:32:59 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4042.018; Fri, 16 Apr 2021
 09:32:59 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@gmail.com" <fdmanana@gmail.com>
CC:     David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v4 1/3] btrfs: zoned: reset zones of relocated block
 groups
Thread-Topic: [PATCH v4 1/3] btrfs: zoned: reset zones of relocated block
 groups
Thread-Index: AQHXMf93GJooZ3c0CU+2cn3hwVcHMQ==
Date:   Fri, 16 Apr 2021 09:32:59 +0000
Message-ID: <PH0PR04MB7416A9ADE7C7FC29FF4F4A579B4C9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1618494550.git.johannes.thumshirn@wdc.com>
 <d3aec3e168a547dcc39a764f242d1df9d3489928.1618494550.git.johannes.thumshirn@wdc.com>
 <CAL3q7H4WKR4bamLij43gDL9RA9gREi_zNFME7LRqj7ex-YBLaw@mail.gmail.com>
 <PH0PR04MB741694A4912A97C6CC5365EF9B4C9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CAL3q7H5dDxQf0YvnOFSOHLOnk=yuUQEO2na0Pg-hzfUri2etbw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:15ab:1:e10b:72a5:d443:5e5c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70a6d9e9-1a15-4046-f967-08d900ba9fde
x-ms-traffictypediagnostic: PH0PR04MB7541:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7541C66EDC8743E4049E9C019B4C9@PH0PR04MB7541.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XRNduSpfL0eHEdUDZrNeXfMDQQsvxqP8jpXSgeRHaLv/Pf88KAMIvtgSvayGAMumRbQcjmgn1ZZRiX6DQXWuHvIKf9wvyPFFgPv4r7ehZhGAmWyn47eC6MaHLqjZ5y1lNWJjgiLL+X8sepw/TtfbkUizzjRP6nv5CFLdeD39/xFV1OvSPCcvwoRTsQBB9xn6ojXdHM5/rizOTi2DvV1zU/p+gGeuk96zIspXb7t6EdJ7dryMNZlpwrv6qj1amgUGuSwITriQaK+xkRz8ilaiKqpcj9ld18aHAa9Jpbh36CPI8saCoC3RuMCSN21BuII4g3MYfyYCbpNFFgDKPagTLuPdp/VpyDcHi5RQrieCzzqwU3olE+1IOK/j6KQ4UQ81yKM5eNXnOmswvfa1hUf4cn28TzvWqkuAlY+oxmNso2CMe7Ad7fjWMSHA5sp9G+ov20qRV7AC/d/Xzc3nKx4iC2M10MhCxDz72dbVYRLcyiGdyyDOGJZCGo2YnbKIDQpzOnsxzGKxNb+ENS0Bvb7qq3b0NJzdwufkscivHx3g7tLIAEsbiEz0Q7Qat4Dln9nctasjAfzRLOGUpBrsH2BLnITA6TOlsu3IIZezLNQvgck=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(71200400001)(33656002)(558084003)(316002)(52536014)(9686003)(186003)(54906003)(38100700002)(2906002)(55016002)(122000001)(4326008)(83380400001)(8676002)(6506007)(64756008)(5660300002)(86362001)(478600001)(66476007)(66556008)(76116006)(66946007)(8936002)(53546011)(91956017)(6916009)(7696005)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QAZpK33ukXDqxRMrdk5LbheilzMD46XcvmqA/83oVSRt4bDwkPSrVMMxlqef?=
 =?us-ascii?Q?db2QcUWsHabba66k7oWQGbd6blUutoKGV4n8CKjbFtux2vf8fBfMgl2txRnW?=
 =?us-ascii?Q?0yssCUoOUdYbpiGDxIrk46WjzP32ZRNkb2csDxUaCiv33taGMch3KpPiGurq?=
 =?us-ascii?Q?RZEnwFD5xPer2ltA4byMGOYInhEaaOL8gOA716lAAq6ApajO5TAIduVE3kYb?=
 =?us-ascii?Q?lquib8pgk6phW+Qr1epO68d0NPbSGnJpN52skNSMf17K4qDHV/rZZrHEnWMS?=
 =?us-ascii?Q?zEbhHHLkIrMiOpl5MUFOGb8HC0ZP0chfsDACKgKsEM1hqKOA6TUtY3gArbJO?=
 =?us-ascii?Q?CCJl5fCJ+4BYrL3CRNZgLNx1vxdo4JKD4Q+FnrzOPLLXPcZaqwrzWyNaQlzt?=
 =?us-ascii?Q?R2qbs/XaIzMPDbz/3umXsElNd9KFWgk37sqOJGBnLRS8W9kQAQIYoYw33D8M?=
 =?us-ascii?Q?Yggu2JC6sdX/vUr0vhoRIF9sq1Z//C4ZYsy55vEqoVsgYLM4n5dpJCsb7Ydn?=
 =?us-ascii?Q?UTrX5wqqN6Hx3TAHxHJ5kRXJ8NRXuUWaHqZGySyKx5jWttDOfu832pxGDEvu?=
 =?us-ascii?Q?iIE7vBVHHU6TY7WDh3qk++CmTil1HMJ2JRcovm0NipoK54nnCrfJNtAfyYMZ?=
 =?us-ascii?Q?AziBGMm4wy0NuK2OHPoNT91xDCfK0ffeoUGkwIQWV2ayN+dlYF8hPOLtKIvK?=
 =?us-ascii?Q?uV+e8P4WsRuGPYOvbs/oPYDkpFIZxzXWVzA7rUT9Df+Xlntfk+65IhmOlJhh?=
 =?us-ascii?Q?lVlM2pM0o8gorY0NX0/E1YfzxLI3wyJe93a1V0BcWEdu1bTrL0ZIB13imUOI?=
 =?us-ascii?Q?FTbUluOEQCwFfmIOsVrrLKGrIacbB7teHykyICN3agHthSGbzyF5Jz+CuQRU?=
 =?us-ascii?Q?du9cZPzc2DfbR+BDyl6tJfM+m/Kz5Yie1cSY5ZTYwPb2AJy2KLb2MHYcLia9?=
 =?us-ascii?Q?39vWsgFPpkGcqdQ2WQK5klmvFvltnyN2uAbWVgL0dJ29xGsSx1AgF39CdVTz?=
 =?us-ascii?Q?0uiCWpQmR7cQHPq3opyQCxhzOuO1INPs47o9Rcb+y9AHokbGl/nw8nSiJDn4?=
 =?us-ascii?Q?6i/QjOWBQiMgHMjDXj18M7uyIPY03eltt2f0Xfcnf1ixnsbO6FvrTfMTBppS?=
 =?us-ascii?Q?fAeAensi2UKxJyBpdwEs5eaaKld1Wzmy/jRYJ1IkjTgzzMVbtWU/DuWJdPGH?=
 =?us-ascii?Q?W6NCRdkr/ijjX0R2vLfH2eSo+aOoB2zVwsHsjyY7TGx+rAsCNvYf4KJhx6cE?=
 =?us-ascii?Q?6zeygsnXH5XaJSVbLxrhf9c5qDvOI/NK4I6mKemAXeLDcpayXzv/TQcs1vDs?=
 =?us-ascii?Q?VEofxlJUSf+UYMkwzgr0SjlUKWtVP/VtidIcxnYE4hl51D0OHymH3/6tWh0H?=
 =?us-ascii?Q?jcX+ZuzPupn53rTQN+zol/sLcm0d?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a6d9e9-1a15-4046-f967-08d900ba9fde
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 09:32:59.4259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dtTK24BHUxzWfkJMDVPWXeCKTfafDhe/ckMC6ReObl8f9mkXrDqe2smLM9TEPwbY8faIYJvi4I1N3YVrkPNcY+0sTrcer4ur4MyLHfi7Os0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7541
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16/04/2021 11:30, Filipe Manana wrote:=0A=
> The comment refers to deleting the device extent items from the device=0A=
> tree, not really extents on disk.=0A=
> I.e. it's all about the items from the block group in the chunk and=0A=
> device trees.=0A=
=0A=
OK I'll move it back where it was.=0A=
