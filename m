Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F26536ACE5
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 09:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhDZH06 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 03:26:58 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26498 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbhDZH05 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 03:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619421976; x=1650957976;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=FF14Q7XZri+HeV0cgVFB6PlE5u9W7b+kqId3rbwGbM1i+g8zNekBiK9q
   noDNFvQ3ufZR7C74qGkX6gxF0qm5A31tjl//K/O5NUACzF4wGjyrwcpDr
   z39eu+PPJ+JD1FeH6jpWmasV3sDEMoKQfvL5InEvtxUSY8uh27ht5j+dT
   mvBtduAMzhikGSbxGpIys27FPUpHU1o2Zg7MhGdCz87/IrQ7vYxb7JMPj
   4sAzZo2qztG7qBiSELIb8f5XMN+rLmlkWXB/pkvReDvVsQYXZ7pgLLObl
   r+PI5fCLM6erKoX7Lm3pLU3uswBFMNh2MMvtvWGilpmD48EK7CGHuQ/Rx
   A==;
IronPort-SDR: TsDwD3zo2hAQwEOx1YZHgcOauYUjioa038AGs+N03/JmGpYzcbo8tdCm+4/2d2C9RDaD3FH43L
 BQfKhN9ekyE3VMb9pwTZBrKFagiLrhCoFzRtbrt3Y37ngLZCrvYxutvme+FDWFCu+sahsVFNLl
 mo8QOc4IW2SGXhsosscQogYFxBoaGxHIxyv+DM742C26XVZRWgf3VEJ8eY2e2ZxP8YmxSq9RDO
 9lMc7w/B6pWHOkqDnUDolP5nE5eULhzn2jQ7R83hPflCPTsmk8Mnck2j01+YPeJKLL/nwJ9qZ3
 zt4=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="277247924"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 15:26:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8Fm4PoX2zgy6rUZrkMUkuIbBc309YiAvz7Pg9USUplOtAGJH8q0TvZ1Ri1x4WBj3pHGf0XhDf9K+ogSB//LshNS5TUoQedXlbR48CodbWOyCpPn+LfbAoA3d2WZ3vXoZFYprbwVUz3WuVTXUr45LyMFu7OS2MHXN2cygZF2Che10crpABiNV0pbA0wWF0zF6nuLSpZoq9y8I/iV88EgvZCJoGmBh/02FjBBqsQZf0Kwsi9GvBgx4Rc/YV70qw8ZxX4Uudt3h5kSZ+KhC8DqsMV8622VP4FRCJhKuzZU4XZqy6HALM8biYaLZ47eVoeVBP9E4S1kAEv+kwwTDXmREQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=lIfzfIsIkqYq2iLJ8w+BDEaoFPJNBzt+TgGFw9pTWDfSvhpl2aHqKaHiHPoh/A4MCj5w9+ZrTJ5S4FyleCkHlztt5izTOAXl1f3L8UUrcXU2AZJHmhs92D6rLGB4xX0M8RVTOUtzCAMILaZPtFqpCTBqTMZNnHsbt/GFE4/cQEFGXwBU7BnBwP3r7A4Lftpj7UeOyxhK/tuc8Bg2eEU5zzx5dptm5UnBcW4cz4BBxBUFZoQvrKz4d+IJoG0K4LJrah60248DO9cr4k33PmJ707DZyN3VlKyk0O8f68pfVimXdRhWsVi4T2uDm19bcC9W1eFyOkgla5B942YwcNUCtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=LA1Uw4XdgN4shBkc/iti5D1oVhEimTCPjTzwUry7wNHGl9FD6bhC/ISeZZKaureE7B/R4fa/C52vHELhdKVDPKBJKgoKiTGRhCAzjxf29ooA41dmGHyAKBjqbc/hJ7zCiNpDVUcKP9XTX2gZwDPvKSWzp6wTjniBY/QaELwmh/c=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7368.namprd04.prod.outlook.com (2603:10b6:510:1d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Mon, 26 Apr
 2021 07:26:15 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 07:26:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 01/26] btrfs-progs: utils: Introduce queue_param helper
 function
Thread-Topic: [PATCH 01/26] btrfs-progs: utils: Introduce queue_param helper
 function
Thread-Index: AQHXOmVmreM7f/P4t0mVPNh8qf1DFA==
Date:   Mon, 26 Apr 2021 07:26:14 +0000
Message-ID: <PH0PR04MB741676B6CF2553A6798C37F39B429@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
 <bb41cec6cf9449b3899cf9fe816ae4a7d5820a0c.1619416549.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 180b94d7-c092-427b-65f0-08d908849364
x-ms-traffictypediagnostic: PH0PR04MB7368:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB73683A249CD3FA710F5592D39B429@PH0PR04MB7368.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0gNlnreszTNkphfbuqUPRcOgp+5Q6OBP69sh6YOtyqt3NJTUpePzMGkEFpDokNcArUB6ndDJjWL6/wYlzacORs6HIRc6lfDTl/enqQ+U1+8XMuN1HX6onXuMj69dlYCf+ODf8IJoPAjDaEMcvQ9U2CVzqmaL1DTtJIp5dI5mq4MZ/E1/Otem0GCHa08mLO+qda01rUdNpmANLzdUc8NM/cu0Kqywf7PbM3lg1vQ2fptKEUGDHhcXzGGW/nhAdyD9b+7Y5ohV98/g0qu6nVbmDQPV/6fSryQ99Fx3TseQZJZzm1Y93IIfRDUJK/W4Yq5EyzohKYZI6gM5DHGCPHeHcMLdVPa0O89gkAL1TMvwyxeacMHc1y/pFlveamP/WootM+aPi/TBq+V2UtVNIju2D9EgwL7Swf6idNMGDYwWbW+RE+3zf9zeXKm5OCHKelK+YNanOZ1Anorya1WNahzd+dX3Ak2ZIrKTau4vvpxackgDGW6IFnZHNG8QmZudprWEELdW2czR0UengD+AKp+lk1z3LBdQK+Eo7k7zyXPvhjtZhJHiKeRl+TiluHZECeljaGbISMV1KCqgB4W+ziDuGDxNKgGKBy/jGGg+PJhZ8XY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(122000001)(71200400001)(55016002)(7696005)(186003)(38100700002)(558084003)(19618925003)(8676002)(4270600006)(4326008)(478600001)(26005)(6506007)(9686003)(76116006)(86362001)(5660300002)(54906003)(66446008)(64756008)(110136005)(66476007)(66946007)(66556008)(33656002)(2906002)(52536014)(316002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?c14nyzAeubD1H40zgTGzt5aX0MdeOAbL/dAdQs/sJRJ7ztTl4p75PQy4lg8q?=
 =?us-ascii?Q?7vdfrmi6EVYTUcVds9b9cXRbYkSoc0piAMYcLG6iShotLr/mPxCaWHNFd2Wd?=
 =?us-ascii?Q?I+rJbTFwokorFPiUu/lYOiXDRNyy/rk8eF2pNV1PyuzfJQxzpIAscr8NN/aD?=
 =?us-ascii?Q?xqKrlld+lucICsFnYRXIrINwRDsREd5bxkTMiCM7HYonsNaP1pOSpe6TOUOu?=
 =?us-ascii?Q?Tby+Iwu50DrEIrzgpJGB6oQhycMXBF/G2lNVdVV3V0GKIeXNs7Bt4skqzxXB?=
 =?us-ascii?Q?aP5FcMVQ10qjDokZhPCgZK0anqPXo6h55fD4K7ntPE1CsYuGs/SaPFV199lZ?=
 =?us-ascii?Q?RYBiAIwM+j0aBQtUMP9MYsbkltUHfRDNQVJzPDiDSeYYgdjYWOHIz2gW4UQd?=
 =?us-ascii?Q?RybBsuXGmtdiSV1kvqvj4x+oJlM7U5L2V2mA7v2CZj3iLW9D358c2kLipdT2?=
 =?us-ascii?Q?ZiJ5RsNplKpApCtA1QJ2L7609aPu9t5fRSdPtc8e3AHifILYR/GysFo+Z5qx?=
 =?us-ascii?Q?8poOmX5pPx9wDC7KioktLb4J5+kD74NN3AL+Jru2sOMauxfEE4qx1/nNRfhx?=
 =?us-ascii?Q?dILRRVZEnK0GtYI23/83evjAr7NexLOZgDtZqGtWYfQllxhFd/mENEzGwyOb?=
 =?us-ascii?Q?aX/d/a8OrPDcEiAE3XziSn8n5X8veyvpUmVSW1ZUNZE9uoFUTEWJkn9mliqG?=
 =?us-ascii?Q?hc7gkuVeWfLSzwClzZK3GMA8xZRz3xm1gXp1ei9AZ4MrQMXvsH0CHMwPdoB3?=
 =?us-ascii?Q?ycWtZNWGfgJmhdCCd6ngRTEsJIhN0p2LyYtghR6lmvz7FvWbZC3mQ25kwhSU?=
 =?us-ascii?Q?B7ibFS+BBmzwrSyidEJ/yEaq0XIf4Dg7aFPLRTZM8hJuss2GBaKEDaPYs3xD?=
 =?us-ascii?Q?B5bWp7TnzPpS7o/tm92ZhdZBrlicwzVT8/w8riWAF3s2kbfM8ej5dPai43B+?=
 =?us-ascii?Q?9/o0I+5HiRMGRJpHGdHoYpb98MQSJ/uQnBOjnWDp/gTJqjrpBeqRVmQ1gC3G?=
 =?us-ascii?Q?oXu8YPibcmOD4wL3jZuOpYhL9rA+qc6T+H86ktUpG+Q+BFzvGERlTZ3pMgVs?=
 =?us-ascii?Q?MmsTX6Q2VWDJYSD9Jw/JyPilYIRN/ooAmfwFAKxgJSBl0+A+s9HEPXiJ9Qys?=
 =?us-ascii?Q?/ViFpjcaPx8aryJN6QqdxhjqgvOS1C+FBYEPRXw/gxECSFFAgi0lhpuLwP/Z?=
 =?us-ascii?Q?q0CGmryEbBN0wLR5Nn/wT6X4VA48TvH7Cz+NEZVnNkvq4sALPNZ6jQv4nwE+?=
 =?us-ascii?Q?UAdAkxK6YqEzpd88B+TSoHl79Ztfsy1pe5G0rOiQj2CQ9+SaD8WwyCvlsTxz?=
 =?us-ascii?Q?JAKoupGkfBvtgNAPsaAHMH4e3tBwMRU/jNHxTGDtJwYs7Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 180b94d7-c092-427b-65f0-08d908849364
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 07:26:14.9678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: br6rWvDQ9JXfl56neAuBF7ZQ3Jmcs2e9xZVGhppdOKGpdXtWNlWyFyd2rklWdatgw3K9tUJr3NwrhpfC3hXVCLmLZMRr45zOXedTEr0FPtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7368
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
