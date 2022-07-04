Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0D0564E0B
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 08:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbiGDG5S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 02:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGDG5S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 02:57:18 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A30D55B6
        for <linux-btrfs@vger.kernel.org>; Sun,  3 Jul 2022 23:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656917836; x=1688453836;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=P2bqOHHk63DGvFs/7q8CzCXPSJmhi0JXWBhzK9mkKsAVnmsF0nMBU3rw
   HBIL18rUNhLQgpk1eQBtqYVCoNPeVTvK9H+H0nHYLMrEIhr9VQt+elZ4m
   mAkTaSTHqr4X0Q5fwVanO8SqBEuxuJWpxcZWafqfc8gaEyTDM1aAZF4Tn
   V/WnaAHq7a44T2tFzeqKUIeXW8efTCYCaVm62tVBtvTOl6N9Tp+DErPpC
   xc+PTeIdafW2KR0OhDx3aMfAHqIoYwXHmlN8rW/q2TatixeOO0p9lJBwa
   hBDT+zz31RlauSeDiX262dr62LzpKJZggERFJV/+VFBqnnlf/oK0J6fc0
   g==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650902400"; 
   d="scan'208";a="203400360"
Received: from mail-sn1anam02lp2048.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.48])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2022 14:57:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUTTV5hZipNrD9WKcD7qWIx8PW8vfIV1l66CgQs7DyyhORYWba49YuZDE+y3Zk7nqCWdsg9Jgq/w/CHpG2Sm/zSBpztEObStOMcnMcIhJce7epPFyyvWh6761Cn8HkbfRE6G7v1RyGvhfR1Id+tZFNrwMVc8a4q9RNK9JLq16zEdTcTedGVlfCHLMsiHfVll9YVn6qJaZlQbpGxihjvw3aH4h1V15qfEqRMudmxhzY/1C4isTM8ctYjKmyb16okIrraFArM2qTa7gADK16/qpG9fgOQhqIRO+Mk/lnjYTEFzG6b+5i43S+VB/bpVyqkR8WLNINtONDEYnnn+aaiH2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=OnHdkaCfB/A/Pjof2cE29mcI0MqgUlqA4Uu5z1ceMkT+0DfKUQVRYhN16SJuVj1058d78mGPk6Pyu7obyaJj6RpNhkiav1NzGL7lZZ+ASdmvJMuU3RwknnfYQ7On1WrWceZ/H4M5v872cYExvT5UHgrZh49I4YavqWqqNOgX/6+CPfFtncE/WZvhga6XLt2b/DoXK2RLawbVkJbYQueyIfbCZ4a/jFtgxookbv0z4O1dbwFM6sq00DXxTSID+U2Xb0rJkyEBxKzzlUh4RXDbn63HvIZ3x/OnArylCyiHC925nIadhkyih3ewE3QDkPzZRy7wv0Eg3Ss1T2FaJCoOTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=krGPkXZeCoFRDG3NCgv3jFNrTBZ3ikhg6dTAHbeCYXBY3oxnlOXljD65euLAvzRIQAmNjtT/WUkiaz5hGPQdSAt+pQBV9gtJRNmRXFhcBe4Sgf04wCOSaabjrpatQP7mwwj4/sGIT83GyZLsNBFFJNSNCExqx7gHWCK5Yf7VKks=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB4345.namprd04.prod.outlook.com (2603:10b6:5:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Mon, 4 Jul
 2022 06:57:14 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%7]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 06:57:14 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 01/13] block: add bdev_max_segments() helper
Thread-Topic: [PATCH 01/13] block: add bdev_max_segments() helper
Thread-Index: AQHYj2LFaei1w1cO0064p9t1BkweTg==
Date:   Mon, 4 Jul 2022 06:57:13 +0000
Message-ID: <PH0PR04MB7416159A89369D1C8EDFA14A9BBE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1656909695.git.naohiro.aota@wdc.com>
 <a3eed5d77f1cd3c7768780356f1528f9ce6e540a.1656909695.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ebf8698-2596-424d-16bb-08da5d8a6ce4
x-ms-traffictypediagnostic: DM6PR04MB4345:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ror/TwB2rrHonXk0BEnpG6EVWW9F4CVH0SBbWv2nzU6LG7rL2eL4BBguwGb3mHlyEuoaeo/N5qe4c2Gm8Q66ROCZtzv6H85o8qi5nXD5czYp1NkYfL28oj2M0ZH1NTjF/rLp18vK/CO4a4Eo3i5XQ7zLKP//v/cDPO3nlykR83Cykj9GMG11on+GaNk8j4HBtdowG+dZQzdSl8yJVTE38CyY6tvwms812Au/Qcp7awa10lsYo6PKc6DtNV7vtOM80SRQuQC7wk3AFcGgoOctU6IwYwDVwdVV9OPfx9wEyexddtTnSSDlvz/jCKrl6omvlFvYnQnUrCF6Yy+ZQvDzdtb0QlxPO4Hxu6nizThNGUVhnJ1csYxuIrviF2/o4QTsSY3QxLtSV8Fyf4SE7Y0iifXlJuTRKKC3DcSW7fk8LGt8Yxv56mvYLVrOvNliPP3+aPY8VH3FX6OH1LXHCtFmsxJOWNDb59GXxvVVT5rxRSLTldBEmExFHt3DR+wHtroESbOhT20kQiLwjECZdG2CUM4b+Gjje11fLNxwz5ponP2R1+uYqHkg8ZKs5QMoJPBOKiFMqHOG+qTFsfuB47upGYyOwV/VyJnBsygB1IKetsWFUXhA6BZ9YyJFcPmGni0uWAQ5T6yookPPrEJ4Fo3emRns/bJAwtyXGZb7j77t1iSDK0iF2bVkUb+94QcTM1gIKjkWc1umkW0g9sQF+o/zadTzhd0KDwuBfrhxjI52E8ULVvcWLvxWTl0gKGm9TOigO1cQ6+HY4/X7BPVtcQJeL2Sx0bVHPlcqR2t2ahBSlg5PNFzAcSzxhXn860O6Vbgu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(91956017)(6506007)(7696005)(558084003)(64756008)(66446008)(4270600006)(8676002)(66946007)(76116006)(66476007)(66556008)(9686003)(71200400001)(110136005)(86362001)(41300700001)(316002)(38100700002)(186003)(122000001)(82960400001)(38070700005)(478600001)(2906002)(55016003)(19618925003)(52536014)(8936002)(5660300002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wVJWT3bX9Msyx2fWqsLxjozElXQnx0fFzq9Z8eeHq0fvlpIAtLHThrbcHQhE?=
 =?us-ascii?Q?y+8WBunG6MhHbGKfahOwQsRT0eME1/ggAvjEU8dmFZVDEK70BW/OWXbjnO0g?=
 =?us-ascii?Q?HRfBe56ING+FDiot5wdH5jckjB0Y1N6BzheZOtGobKqpTT68neF6DKbPmwTO?=
 =?us-ascii?Q?PPXIr1tspc/54ttB8RL/qTnSByH2e2tPP7Yz1B0T4fITSXoDs3CO+Bt7yZ4U?=
 =?us-ascii?Q?x4aDwrq2yzXq/YF/y403GcVVcwBBsTZj9MImyjumvINgSpTrWapl1Wz7PBz+?=
 =?us-ascii?Q?nNvCfUhE28AAfFIfjAgolgqEC4rvWyAuP6P6+4o/KYOQJfw2pgMk68ks3tOk?=
 =?us-ascii?Q?WdPs54/2LYYtmoTuGko6CYpmfYN8+8gp0A3TX4cRQL5XNJhzcAFV3k5u9yIG?=
 =?us-ascii?Q?RFD1ds7EfHvJIORGadSt49n/n+DXd7lxul+xBosvINcECO5XxD5uEgGK7tCu?=
 =?us-ascii?Q?Seea9ysABuqXf7r7XYMa0Ke5fszMvTegmmR43duDTMqDl7gwg2K5otxvOk5a?=
 =?us-ascii?Q?3FhV0kH4WBpMCob0/LypZTWn6Hv+/MpWAxO0VGpW01j9jNqn0qpS4vCJ9+mp?=
 =?us-ascii?Q?BuxG4Fv+11/vlrIg2eBWgbyyp3S5iLQ98msF5nwspwHis2KDW6BbdHkhVOBn?=
 =?us-ascii?Q?Cu4UqgITpZzla60clCxiGsECld9gmREsZB7iqkf6UP7iqmTvbKgVkBr96heE?=
 =?us-ascii?Q?4sPTEMpfS+MIEVqrGAW/CiJhXEK86g0Q344vLmaas0HXgEowSfYgJEmNvf2g?=
 =?us-ascii?Q?CSRLwxeZj0iYqIHEFaz5WSSM8RbHo+KKz8zMKGJK2lUX4JRo6u/XhFhGRyFh?=
 =?us-ascii?Q?LyulY+dYn5JpKP8OJ7kt2ypmQ95Zfb1nQNekjsO3dtsjjknpQsismz7uMYKY?=
 =?us-ascii?Q?5lOA7xKte3WJ9ycyQBSGbrgFN22jBmygZZ+zXFsHOfzdR6p8HH9J99qmFRlW?=
 =?us-ascii?Q?+uyBcxUcfVo0em5L74CWxSTJu4awLtiXEWKDrgtuxMSWjcq4UtqA7SrCJ5oa?=
 =?us-ascii?Q?hr8NAiziRqtTlTqGmmmLoCBubf9PBDas2DPaIdKP/3UQohzdJ4K2S7Rg4Ool?=
 =?us-ascii?Q?fMNQWeu1Iw3nCyGfITwaJQWt7XV5Ui5ymIWM7/JtTSBfSAmXH2W0mQkH8YlF?=
 =?us-ascii?Q?GEJae7v8RfwO7RaTMC+rT2FWkj/rqItZac3oGOzd0cNJeP7AcArMtpkD2xsm?=
 =?us-ascii?Q?kT1jGXYtMXMkENfmcdKFKBjBul8fFjzaLFdEqvJeD9tSvLQmxUFEeLIiUYzU?=
 =?us-ascii?Q?ld0Sd93jCEDNaphXY3jwzZtneBXbKgmnSL66jLsqGzmSb/PZKq4sjuEYbJu+?=
 =?us-ascii?Q?Ym+e9gGi//CEsKhnSYymxweZZBvn1f6CQVzptvBO8zzQTtQAI9XAs9ohFyyW?=
 =?us-ascii?Q?8PLmxDm+IpUQBWF+UMpAV5shd+TgZybotMKIRn21wFhVF1WJiP6QLBzFaST9?=
 =?us-ascii?Q?4/FMdJsAKsd22rpbjWFT1EHnmAJgh4BxCVZEC0jWPpgxSI/7hi1Sgmq5nYvk?=
 =?us-ascii?Q?h8IrQjX7im3yDNfsBQ0nU+rVaALckz6Xsf7ec+iTiwbs3s5eFCqIYPc5dZ+k?=
 =?us-ascii?Q?prhnd8hWuKN2BqzNPpEc/7UasPiuU0PEg15Se/0+Vn6UKiPKX8bZNINc5wq0?=
 =?us-ascii?Q?/i8LOUgfnfafUkmx6TsQQDpVQOJ7FhNKn/RKDP9wQBMkSublqIgvYg0xsNRq?=
 =?us-ascii?Q?Xz231P34Hk2oQNmjaG0Cn9X/9YQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ebf8698-2596-424d-16bb-08da5d8a6ce4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 06:57:13.9635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 99TdgMfYFeemyalwqdQKJQFDUN/9NPC5K6xFBuGQjM89xwe86BIxdJ8dps/8rpwQj0BJ5VNpRx96IWb2m2Jr1CjL6toDaF5q6PB7/XuuAzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4345
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
