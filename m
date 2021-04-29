Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A29736EB9A
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 15:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbhD2NvW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 09:51:22 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:56113 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbhD2NvV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 09:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619704235; x=1651240235;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=eRAwLnrWz/A3xY+yDX359OY4yPBUfNihvRUn4fF8/yNpiCVGQgVjtQDi
   3t266W2vYkOakr+pFn6jHq5xVloX7uBHv07Ps5NsMAfwBgXvg0bIL7raW
   /j4juWd7YG8ANHC5VA9OAJVcGPV99uHF5LT9NnqRtD5iLVYHUJt217aC0
   3FCvKjxuNl8K3llf65jtRwCpNyZ5IrhwoVmnnVVQ1NPUmesv+PBekUkiq
   yQEaoW8JuI3fuqe+s0/e83rhn5ZVjmaW/3PpESz+7O+F/Q3e/XCfMOEvC
   83MJq25yguWvHFl2HoEaGTCbwQIrScddQmPlzdm2dBharuyhBF/878Kfr
   A==;
IronPort-SDR: OfIjQdilRBL/c5Z8deYuKwlLKKyVKQtWKaoUhRhgSj6TiSFzbNmw97q/gBWgGFP2c9eJqG+Xhn
 I7rjZb1XANsOVQKzI+Fnhz9Ws6rTsHd9ChdeAQRitMFbyfGvY86I7X8kM4lO7EQSltkocymKav
 IROkYtqXNXYV3XUZCZgoe9PqkhBMMhq0jLuKEUCB32hEg3EbQpktOYt8YieSDrmBraEakLLyHL
 7dBsRd9Yf658d7XLWhRAjhCbshYasmcxJmhY/EzRlOnKCcjRXM9I2QX+Uvd9kZIEo35TJo/N+K
 nk0=
X-IronPort-AV: E=Sophos;i="5.82,259,1613404800"; 
   d="scan'208";a="167201633"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2021 21:50:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQjtqbm4T5g+P7nW9fZWZ2UoV5IPlVXUTJz94cRaJtZyppRuY4YGcX1WbJvvarR+19V3/vCxqS9HTRPWL+AmiaWaN+7zOyBwQs/umzLmZtjTbBWBFAqoZgysLXjf8lTuB4TsgmZJCy3WKYs1KxG0hMbfj7Ey2mGPm9OiHv096ij7Ty7q+inTSwG7+Y6HcqkqrNt483bjiggOFboVtist14tWVJz21SKGXySGFgYp68/6XMDqHf5f11W0Y7WV7QOsWs13yPfBqZHVx13Ko7+nEatN2gKSKuljQn/5h9PN/6gy+MXInb1zq0iczsnighPU5SGTFAKdqG/sjrJsenSJVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=enoLGCdYpvEEoXG/vZ1AdeErs7uCgUXP58H7Pb4qth8X+O3klPqcYcCVTWC3YwfJ6aJK661W+DMaAc6kXUo8kXmYQkVUrUomMESqipURiG3OwII45ugLQQRPlTJ5DeIG9tDMeiuiVPQ7Ukm0G8jtBR0p4aGZ1dBs82/WYt/YbCNCd6rJob1CbWeBi9Wz7fQD5LxBVNm1z1ux/2u0hTWErjDPTnTBPh0k8bKr1mtwnd4/AxDp1ONhHDd7oYaZC1Cj+ljh0KE57jdZiI857J75DRRuNkd9mhMF6q1GgYjCY4Jj596MCkqFwd6CyZzY4KX5pNfqbZtI2RaXAtvxBRU0dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=0QU5tVc6EB2dyGbdYq+Bns6+/antD4idfrpQdStCInUOcD8+Ey8jWEg/c1xEYNpiQJDL4MtG8OHVSxA/jonFYajwXzxO/cSLFxDLOSU255Ef/2grl1LcMoXwwUqW9V572X+Xb/lg2X8jwPXAhQH3zrhKJHI/t3vt8P95eshiEMI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7174.namprd04.prod.outlook.com (2603:10b6:510:d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 29 Apr
 2021 13:50:33 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 13:50:33 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 3/7] btrfs: take into account global rsv in
 need_preemptive_reclaim
Thread-Topic: [PATCH 3/7] btrfs: take into account global rsv in
 need_preemptive_reclaim
Thread-Index: AQHXPFWTH5PCjodvCEi4dBpC9Lo7tg==
Date:   Thu, 29 Apr 2021 13:50:33 +0000
Message-ID: <PH0PR04MB7416F983840F01768FED01519B5F9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1619631053.git.josef@toxicpanda.com>
 <febdf6d9ff9efc92034ed688d61b38a9b53a5abf.1619631053.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:a91f:c11b:e39c:d980]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d8486a5-011a-4515-b89c-08d90b15c251
x-ms-traffictypediagnostic: PH0PR04MB7174:
x-microsoft-antispam-prvs: <PH0PR04MB71741420837E0CAEB4E9F2939B5F9@PH0PR04MB7174.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ly5La8dlvqoOg3wWFUysNr2RYR2UpGCU/0FfZwtg3WbC293RVOsbW2cIoipuVgO7NFbDGo1YCJRW79j/sSLAnokknrE6rqqfKMyHYVkAbJyyC14C00HIaHBGVNxJIByFyAVsEYUeDo5oNEKwG+sAGK77nrauz5201HsOBKplS6CE3bxCCla14rx60oFHcVe1oQ8HhVd1/16L9Ed8m+ueC5Mqx4PI5YiSaJHr8ShsplsBtMx+uH8OpJ2xcdj59pX6+4A/xlIPpNhWOnG42SBzzM3RoFaf9jZWwMZGAajudmvC6UXs5vozkfz20hfT+l0RsElWw5iT/4xWSnsYESdzT+Q+iermO9gF5qioBIYJHD9VDNCcg+N/PvwcWubWD5yL6U7y0OO72L0t2c0m7UI4XsJJUfrVNePN2XGfrDmWE88ePcx5XIVvpxEH6Yna9TVCXdHWPo3d6V9YsW/+XIDPWNuQ975Vq4290s6zxaVw1Q4GFPyKCEvsd428Ewawh3Uw3FZNDqsQId7+Ruz3YBjbUjN8j63ts9sMeoYMfEZxcdCduomyqspp4BLWNwgArF8MMQRpN5Q1lQXyhKH0m5uKSbnfYHrYWrA7ReoZjkuiEb0twwARs/YLp6aIorAMzHegV2q7gTg79pYJKh0ofQUWrGGqsWDytRJW986eFMWdEU0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(39850400004)(366004)(91956017)(186003)(76116006)(33656002)(38100700002)(64756008)(8936002)(86362001)(52536014)(9686003)(122000001)(19618925003)(316002)(2906002)(66446008)(7696005)(478600001)(6506007)(55016002)(4270600006)(110136005)(66556008)(66946007)(8676002)(66476007)(5660300002)(71200400001)(558084003)(178253001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3b7g4t/aD7KUwzABg2DqdiIX2BNkatduz8m9n3VUu3chqL0VB8DfYa7S2jAQ?=
 =?us-ascii?Q?kH/MiP7plPUP8VtY38UVlIGkUxLZjCGtYCxi7gcp0BoNjL5lDFuJNyGl/Ulk?=
 =?us-ascii?Q?zegpLsYUgmCKIKknvN1HyQPkDvE4jOQa03Fmgi4fi62ImhNgnGdRx31Jk03X?=
 =?us-ascii?Q?HTFYYkqQ/6Xko6xV4vtYvv6oaeLdXjzaxL2Hgo74v3uayl/+IzuVsZhmmPTZ?=
 =?us-ascii?Q?w9+rPjMUPLs+5kCAJukJ1p3kZZq4wP+IW5EPHkCnwlvLKEKf4ef2JLaR3Ba4?=
 =?us-ascii?Q?QToMTW/uK//uah5G77MfmxVAgZu/7PWN5Sy1QTpMEEtxpLpHIqzG9vcp9eqv?=
 =?us-ascii?Q?yn/UsXKmK4Vgh5HzxxMjDWErA8sdWy1ECENpcN4syqqig3cBysjwyH3qjy0p?=
 =?us-ascii?Q?XerqRMs+hUwMCFh9UeKn5ClPptn0doq7LxzqsuqpgPzN6FGcgZOvP4uyuk54?=
 =?us-ascii?Q?R39sbgIbYFtjpF0FE7OwSRz3WdDSYTT/D8eMu5AAYHlX/Q6ilOwZ2iTajjvQ?=
 =?us-ascii?Q?4CVVxbFKNZTYF/Ho0k9g6i2ZTmKXaIF4XC4g8dunBgPug87wiuxH/UizLD3X?=
 =?us-ascii?Q?xAzdX3MgyUFQWO1NtVrHf+CosaGAWYuKOIIkST+8qv21fD+62HLFuOal+P9V?=
 =?us-ascii?Q?xXceEHix3z4RKhi1EC4XxT6uDE4nvE+7RhaWi1F1vYlRZ/O43mfgR6/cW9BP?=
 =?us-ascii?Q?reuXhplQacCDddgRpgEZuxRECHKrjGg5Nbp3jeC83evGr+yBVYJHhwr9TQwY?=
 =?us-ascii?Q?Vfe1xi5BBkSbJduGxL1rHMYG7T59X1Y8o89uiemjq5s092nC4nUwIwovELDs?=
 =?us-ascii?Q?JVkJe/gzzZYy+5JnUQc6SFPPfozCImMOT3UX2dAaHzaqy887SF1ghA7cdeg6?=
 =?us-ascii?Q?xJgyHooWxC3hp8AP0Z4ZzyrAHugpYrr+LDj7zRISK3Ahdz0mRJWoP9ZkxdDH?=
 =?us-ascii?Q?BBKw0F07LnXoF/KwfWI0KSkwP79ef1k2bPI0B3PDm2mcV79F2QZ8I36sh3qk?=
 =?us-ascii?Q?Ley86k2NLnzm+gHiyIkHNfM7Haqaui/94RydaVrzgP/iJg1TBppyaGoYicz+?=
 =?us-ascii?Q?Ua4KOwuzWKa0gEr64u2B2zQK+V1yCvTqli8oq0JGkvU7GAD9MCRDyGDZnX4m?=
 =?us-ascii?Q?SqCcnfccjVD8Y3kjrEGZS7lUp4NBmahQt/XiYdWh0Z+P0Vst975xa2m3xuUJ?=
 =?us-ascii?Q?UZpwRZiwPZxpItUYXUNQYO6YCgcPhYSCjSba6Zq6d14d/gsuj4lSP1U3A5Ok?=
 =?us-ascii?Q?+EnodGfWb60MCYDWfXnqhZx45NjMfUGIsCQSkK/SwoVqq/ypL5jEXh29qZZU?=
 =?us-ascii?Q?sjEqyIVir19lfqaXg+l4jw/qVDe/KHjdHnzAs8vZNMvEs9LbNoawuaCW4zpy?=
 =?us-ascii?Q?psTJgdyn5yigS5zcskdmfJ9Jh97WGsW1gbhk2GPRVwJoVUtu2w=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8486a5-011a-4515-b89c-08d90b15c251
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 13:50:33.0347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KPYSPoeILSZeZneg5NtgEVZEx0KWnNR2//2BHjBpLBrwmNXtZssvxpLPjZwlYYCVt6c6ojO5UHfjVjgxLzMlxqUUGJSUEeKzvk3fCA5WcQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7174
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
