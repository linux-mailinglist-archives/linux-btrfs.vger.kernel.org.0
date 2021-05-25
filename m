Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E6738FD83
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 May 2021 11:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbhEYJM5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 05:12:57 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:45179 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbhEYJMu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 05:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621933880; x=1653469880;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=EgXpDbHtLpuE53uiaewp62A/GIXhtCZkBRuhW9p2aNM=;
  b=qqdtllm414OZx2tyxaNJuCKQUwGQNFYFQlve7FMKKd/tDMByLFo6N1Ox
   r/+5t7oQZOTHHy8OGWz2T396kYcOj2F1a73ScUJW5rCg02qaNOvSuuTYE
   gZxLS7DWu9w1/f7eUv74O3v/6CpOD1QAlHraGgyBNMp+CxNIAqcMAz/jw
   0HFwhOqBEcJnMm7mvfTpy0corrcut+cjRvac9FUiVIZgxASpZuQsS86/r
   liwop3d9DBppCTjTNOUjdXNJr5YXFgl2Mb20wvisJio85D5/rmwfigAP1
   3skx19YkgET3RBDizMzTxRKs9ncznOo0/D4TY9rnxz8OCquXSuxJL9Ep3
   Q==;
IronPort-SDR: rDNbBhUJAo2Xtr+J7qMgBJAfpH//SAyTjKHMVvV/ylrP2yuQVQ0LX3Ck3vElCRxnLrIivgDR43
 XccvP9g6B0A880A6gakeciJZtb8Gss8urmY5ExMulXvs02I5byE/099AwBpTR0e0cJQrh0KuDF
 GhjNT2pHqJi1iwaCMSBuQou4Vg9M0+clAszuMo1fVB6p1aU3E8BGeRrL8hHP98MXuJ64UDRH2p
 Gnl4Cdv59iEtyqMft7lRjd9grKrI9NXrXivhYjA2QI3deCaks4YpcQfaJAeBZpEf6qVr+mMTSn
 S64=
X-IronPort-AV: E=Sophos;i="5.82,328,1613404800"; 
   d="scan'208";a="168648294"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2021 17:11:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6KO7jW+bF4LqTkh5iCG0QveWcIp5ma3SfQ/qBmviXrg88k36P/YVevF59M23mf8prJI/gmOBSSvVs0ECY8ebYszjdM+LGMlAOsXl+A4Imoz/hE8VtuCOrmilvocLnFpKUi5WhHNcPCxjdPMZYnObYL9NpHMYWNiwmm80872mxqpOy1M3zC1uqVK1mHK5MuUANlVVUnNikAOB9sXLVMXqC0u6sREzShd3oZey+5t9mXRLZIs7rM6+TnawHowWCVCEOaQn38+nY+531a2OjphWMp/F+XWRWQhxwfZY40Atmwek1Z9ZgRHAkq+yHo1xUx5IrrYVd3+W/sDQsBqbon65Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKVsKm8qTJDwdipnH3l0inzeB+qlGqEpqkr7cUpaxXA=;
 b=VVdQPf3TGGOLZ+bWadEgBIdwI75gvYhyFCssCIy9fFj0Ja/4bF932q7/yw+7eG3k/TZojVgV88RQQHRpU1jP7476el/ASKJ+Xsb7OOY5MndFYOW/UB36C2wM5eyJ88lBWpIGt5tVnxIz3aWYHKDhdu6iPuD5QkHst/37dtOUeO72S1Fv7NL+z9Oe0X8tfuwNB9bl73w6QPdRRNkdiq6Y8aqG3GmKfUAkBU9W/NqU93BoM8lUx3A7Bxr3jddFFEHmxOA4Q7zMe3Cvvpp2k7/nZcz6c1e3u9nwoTFMGKK6Po5MCuPyOEJ+kZdXWqNnHyiHxcvO+IL7zgNQXkO2lYUbyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKVsKm8qTJDwdipnH3l0inzeB+qlGqEpqkr7cUpaxXA=;
 b=hw6qqNdQDxb2kygtsZ2ejxRIAiT28qiLFUsa78waqAMAg0XC/DX0khnkQbxpS/FpPdojPNrXlgCU5+1QZdb2ckVEkxxGiitT4d28TuiGAQ3tS205HZ+aBNfhue4E8a1ReopF/NkChTa7c3go8fVS6f68lWs7VtlhGtphk3WrOko=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7399.namprd04.prod.outlook.com (2603:10b6:510:17::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Tue, 25 May
 2021 09:11:13 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 09:11:13 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] btrfs: zoned: factor out zoned device lookup
Thread-Topic: [PATCH v2 3/3] btrfs: zoned: factor out zoned device lookup
Thread-Index: AQHXS/wy68ygu/pkXkqvCJbZ46sW8g==
Date:   Tue, 25 May 2021 09:11:13 +0000
Message-ID: <PH0PR04MB741615D77099CEA4864ABACA9B259@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1621351444.git.johannes.thumshirn@wdc.com>
 <0177d54fd7d5d9e96ee0bcdc29facd1324149a0e.1621351444.git.johannes.thumshirn@wdc.com>
 <6acd6d7d-5ea3-8ca4-6184-0018f207797b@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.239]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db3f8225-4a3c-4ceb-ef68-08d91f5d0bad
x-ms-traffictypediagnostic: PH0PR04MB7399:
x-microsoft-antispam-prvs: <PH0PR04MB7399B013FA1082FE24F4E65B9B259@PH0PR04MB7399.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qDYcEXaUwVO9ZKJDa2n1nZyu5fsQdrxTkee3/dEFzGrlJMPpIDUnXTEWCOICZDlsjl/GjJLoVQNYXKOAhlvD6a34GS2Uh3hFJRB3u8oVDj358/wGazSsQyRjGkDiAvBubbMiHJnMCukReiChp+YNppf2Lu552OYbd0JtgB0S/fbTSPrv0AP10g0l2eh9KbqCBPvox/2tO8jMCvmic/m0uUJYKl4ftlrWpxyRvStwojbPR4lcvNjS6mkXpCBln2t+O8CCEY9EmB4n3jQ+XmiNQk5kq2OqJn3P2kjQNweXwm8tii1WrKlFEf8u9Ru1t3m9j0xjh53x0Ai/ANxK0Hp/F/CX1CTIajQj+Yd9FGgtEb7OL5nzJH6eAtnwbEIWcpWzbqNgRfREc4/dZmE/zr0zUiKil0OwV1EBzLxQgabjo+JCfrGN7h8co4hS18WH5/JcIro6Tb/6Y28ha9fCELthQruU5P3rO7N5RUNtPvdWSY197tCViMdS4xr6Lb0KXcwKfSCJR54uJpyrUw0OY/Q4AWFSlxbaBRtVzKY3Xz7jOZrSfq+mqHcMcjscvHyofOOH0N/BgWgRiRTK3xMS0m2XC41UbCPthT70iErxvvSi6a0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(366004)(396003)(376002)(346002)(83380400001)(52536014)(122000001)(478600001)(110136005)(66556008)(66476007)(6506007)(9686003)(91956017)(66446008)(7696005)(71200400001)(64756008)(66946007)(2906002)(26005)(33656002)(53546011)(76116006)(5660300002)(55016002)(38100700002)(316002)(86362001)(4744005)(8676002)(186003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?x+3oXyRlsgeO89+/XkQWar/r2iCAvMamgj1+WLdQCoeUoUrJrogK3Bj+1RSR?=
 =?us-ascii?Q?ee0lRj4hq8PJ+bY2PYCdogj/JncPjMrOI74qG0OL6WSJV09xx4HC3OGb8c8c?=
 =?us-ascii?Q?zs2sY6hCdXX8gHrK//Pes3tVruiQVkkZlr+4vSSyqC0cKwk8eE0iwIKbQz6v?=
 =?us-ascii?Q?vES9P/7YiJeGkF2I65KtBTe7pG/SunaWDSaszl/h7Jrx1XWVVKhOv9xIocmE?=
 =?us-ascii?Q?F2IpSlermHJjjPOxnhQ8a+Yrls4jFlEbB7PEYdI0JVREHG9hFhP4LObUDsZp?=
 =?us-ascii?Q?U5LbCU4nqlkNatVoROvUH6hJLIPxIX/PETjZhzWBK8cS26Vscs538F2pEPlE?=
 =?us-ascii?Q?tPieW0/RQiFigpD/u4n9w9AciGhkneOKQs7bj+i052gT7nJ5KftDqxjKkR+R?=
 =?us-ascii?Q?g4OsfDEO6Y1DSJLtO46auXjcaRurH3vfIEnTt9OZuNrcQVeGt1U1LOkAVyIQ?=
 =?us-ascii?Q?wSyXL48CgU+K1V5On1pYDYkF6Wb9vpIMJnN00gSwWkqKkkMXuRHmTRX4Sw1C?=
 =?us-ascii?Q?DOl5CATgeSOLwsIpreg7WuKiOQlcXqPptcAnXtHJE3/OlK8h/u4oYCvcvSNt?=
 =?us-ascii?Q?IjDSz/jPfj0qAM3sWqtO8Lwu+gnV4xmb1AZ2yO93LjGHmVbVVYlImkLbFBfr?=
 =?us-ascii?Q?EGqJb1OqVXbv/sfaAaCchJ6tDFsLRusD3LpLLmjLQJATb1dT/W1GEeYewt/Q?=
 =?us-ascii?Q?ZHM8iJSu9g+a9Gscwsm3FBQ5xt2YgCcNFaS4iRGY1dAq69nnwr54Caa6P30U?=
 =?us-ascii?Q?5n6G34F+TBe/3rRBg+yeE2B8/9y4HuEc8dFAdWz8DgxxDP3qsM/8YZBGRQnE?=
 =?us-ascii?Q?4SI5drbjIqlNQkX2g9d71DpuYwGXo43EY7qb59rid1ICRdJL5Uck6Y3ze6hq?=
 =?us-ascii?Q?g1UBl+pMP1oqosCoI2rtTsE6raJAuJcdVReUjtRddEHpTc5TS/AABD5OtQiZ?=
 =?us-ascii?Q?JuaHz47TOP+vQZKGlHsRwkbpHX063gPyqVi2fPDOg0hscdMQlfBM28mnETGl?=
 =?us-ascii?Q?vMAA2qvpBU3po15JUmTO5uRetgS4SywA+tnWdeiN5IsKI2Dlj3qf8DR88i76?=
 =?us-ascii?Q?XwJpeJqNKx+xHgSWWt+eDH7mjgZ4Sh1VUlrodZgFxBEuSXxctt90Zqz3I/Fj?=
 =?us-ascii?Q?IDGq3C24g0hNlUnOk07TMJxH4MeAyIQmRwOePafxX1hj1Vqhei4xesaa/hU3?=
 =?us-ascii?Q?Lbg+Cd9kfb1hD+X07ZWfvFJJkORG0w1IauYgXwW7aMUOvWeI3IoTvJ29o15R?=
 =?us-ascii?Q?EhNxea+6wQumKnPtCSirppM8bcUAlyiSU9d52QVcqi4e5dZvmOY5yt5n/kam?=
 =?us-ascii?Q?YR8Z0ll+IThGnaIhgu7Q5/OROtFi1efWS/EzdXNZJkcJ6Q=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3f8225-4a3c-4ceb-ef68-08d91f5d0bad
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 09:11:13.6132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vb2OoEm+P9fEfiszDw/sf18IIts6kuRYNfTepH4XPI7Wu3KYrheNBaEXYBVCmgNTNR36/XbNisSRLUCl/e2IrEjT39KwiUytqCXc8z5gXuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7399
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/05/2021 12:01, Qu Wenruo wrote:=0A=
>>   	if (use_append) {=0A=
>> -		struct extent_map *em;=0A=
>> -		struct map_lookup *map;=0A=
>> -		struct block_device *bdev;=0A=
>> +		struct btrfs_device *device;=0A=
>>=0A=
>> -		em =3D btrfs_get_chunk_map(fs_info, disk_start, PAGE_SIZE);=0A=
>> -		if (IS_ERR(em)) {=0A=
>> +		device =3D btrfs_zoned_get_device(fs_info, disk_start, PAGE_SIZE);=0A=
> Not sure if it's too late, but I find that all callers are just passing=
=0A=
> PAGE_SIZE (to be more accurate, should be sectorsize) to=0A=
> btrfs_zoned_get_device().=0A=
> =0A=
> Do we really need that @length parameter anyway?=0A=
> =0A=
> Since we're just using one sector to grab the chunk map, the @length=0A=
> parameter is completely useless and we can grab sectorsize using fs_info.=
=0A=
> =0A=
> This makes me to dig deeper than needed every time I see such length=0A=
> usage...=0A=
=0A=
=0A=
Hm yes I think you're right. I'll send a cleanup soon.=0A=
