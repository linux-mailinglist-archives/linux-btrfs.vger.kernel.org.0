Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105EA5745CA
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 09:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbiGNHSa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jul 2022 03:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiGNHS2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jul 2022 03:18:28 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328D013E38
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jul 2022 00:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657783106; x=1689319106;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=pLkCe/bG1MNoxp3wLuZPQEbok986iv7IopWs625GSUC9aYjBhCI+ZtNV
   mJz4WY0POP6sZATR41GGg4BId9dUPsPIPOoC/sEq9gJZXBEFV3Uuj2yzk
   9mf8VHbP8F1bjeJ7+c0GYIqx+8EByyAz9J8L7U0+0g1psBGOlZl5f5S+d
   Ov2vgWiBv/b0gqCV/ZaObnMSRqhs2S0cFcX/eRyYeYNtT1VMa7SgDpDkL
   tseHXulUousR4xJ0Cv87kGcZ9lM2IMGn2UclzQgj8T8MXQ3PK0cMwHUbs
   YI5EFReZuHm6laW8TfjGqt7FTOVSDRof0kUTcFBQHxmo7rPY/B+3106bY
   A==;
X-IronPort-AV: E=Sophos;i="5.92,269,1650902400"; 
   d="scan'208";a="205698750"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2022 15:18:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJDtHWYLkG6a/192j8wdqNxKRTz+AKm1v3aC8fMoS79Vi+2lsErIGVCD+wDfZNMtizdImL4uQGUKEvwakllveUql7+7GLwWHhxBXPltI9hSFNlx2iWWPcQtPlo8hkXOof7UTvZaB9MDUPpmfJ4/xjE3LN/FVVtZ4LUbcCXhDO/NzIvOLzeX71joTM5xox+fOV8o7BJLxp2tHagW5842/+2zk762VMHrPiPlcqAWTx8KxnO2a1MEZ8iG9jRyEUatjuSdPLiPW1UbSEmZK+WTvRz8XTjIHihWooywD6yiBMM2Q2y8/kI0VhZWcqHtdTSLr7UZgT0TuO3RIVqK2RMV5kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ePFMX9x2yL3+oH3GgoaoRhwp5rTkOUJRTZpfih0RQ1ziQst+7JDVTP2bst597ak/ELSY9fT7U8AXNP4Q7Bp1YKJfl1xmksCM30lM6zBM8VOTjOx4eJkKTWD8dZGcaqA1VkKEbMkWXirdEJsc1KSG9yAtKGKAE0BAlI6sZjAOT94iSph6e+YjPO8CM6p8VDovEPfOh8hNvuuGBn5XqqSLVCFEIBGSGvvXTHpcRmO0QDuINds6ibidLfmdVAaX4y9qtyaL8ZNC3ylOObASmHFM+SxOWrzt4GC+wzdfeS2BIb69hwrtcroye361fUw6OO8qBR4vDaya1XuLJTY4CfSIiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=wHdsySU9Xrs/7XoykdMAmMQL0QiaKShNBAWuTrIjRHrB8TEoqyWKKzDt6gNwGu4ytmS3SMKLrRfgN7xuTXmSYoCD0ZYwQJOtz+FeoAJSOKn0zjMBIuUBn5UKvEnz5kOHP7qDyYhCJRxgIsnX4wzHeqIZKzrVryxtxbnWYmvuPjY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6841.namprd04.prod.outlook.com (2603:10b6:5:24e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Thu, 14 Jul
 2022 07:18:25 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5%7]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 07:18:25 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 1/5] btrfs: use btrfs_fs_closing for background bg work
Thread-Topic: [PATCH 1/5] btrfs: use btrfs_fs_closing for background bg work
Thread-Index: AQHYlxl5hr6uJVIpuUqXN+DzI+0gLA==
Date:   Thu, 14 Jul 2022 07:18:24 +0000
Message-ID: <PH0PR04MB74162D7FED998A17EE71CD7D9B889@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1657758678.git.josef@toxicpanda.com>
 <7a3bde7c329b45fdfc3335e9ba57c6e1205cd131.1657758678.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1148519f-b4af-4681-f336-08da65690a92
x-ms-traffictypediagnostic: DM6PR04MB6841:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GNzlZrGVRFA87K7M96IPBRKzv9l+vLoMQ7970peNlE6sv4l0WVULAR0F74oU4/ylrALl9G0f6dve6mxgheRlgPKczjt3SaDNCuSNz/MdD6+RtdBFXoiBT50Apr4Hk0wPYlV5TokH9W0xWkVKnvezygW48ulfyfU+WzzCIxwzMyafdTZdrVquS096ShX/PaXQbmEzob/eIPGFLlGJ9GsrEmp9C5NAdPmeYL+TREAAx2jYr8O0U8fABO1KnoxEWAzV8Tv6ui5MogJWCN1vZ5xLa1KhE6Kqgc+cSU7ce52Nu6bACcLa0zxL3UYm089tzT5gMoXyXhJuK5y+9J3uwbPaEvLNbr07/bU3KycY56oi8cNgDKccpevmx47eGKHGNdJuIDSwR4WvcZiNSA6kaVH6TVoIaesDVcp+5/frd7kzhEEEOs1xe//xyM8VOTxNpcxGxV61dzIXA2+liX0W4kARKy3dix2C8KXfuwtTUDrfATOy4GhH+tays4Mp9FcsehbCk4PdJTMbMM/QW5TcMYatRrnDSQ05C8d+Jfcqu4Ds1NZS9Lnv0OUU414/6OFk8+BVyZnOZuvuff3vBnlCsvuP1usKA8U8f0QO2bmD44dadrlE5uQGDFYsSCufFh/t5qUUdd/KzexDVSUohE3tHSZOUuo9dsw7WUn1d22smgXTdDWOHJCNPPNvurGNM6727aiAuVufyUVCCNHS/qotiTugzxLsfdy7NAyR/OBs+fnOPd5trXQof14d/y3hSOgF22m7f/ckPgH/R1wB1wrz+KVGgC2AVsssxNVG0zqInfGYRaOhsKyTTyjMf38V0XLYiUs6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(186003)(2906002)(55016003)(478600001)(41300700001)(66476007)(19618925003)(66556008)(71200400001)(33656002)(110136005)(64756008)(558084003)(7696005)(66946007)(26005)(9686003)(4270600006)(6506007)(76116006)(38070700005)(8676002)(82960400001)(5660300002)(66446008)(91956017)(8936002)(316002)(52536014)(38100700002)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8jNO7tuy3PhMrm8AtrNuJDyYuS10Ww+ezb4IHCbeeBti/hUkweDKalT2WCph?=
 =?us-ascii?Q?A+Vy8YSEovtIyjSYSGw2JMXFR2HIC8kJ/Mq9t3svib9O+87SjskJkX2oKTdC?=
 =?us-ascii?Q?JK6A7lOohY4X87aU+iKFDccm0Bf9lvm+1Tz6ilvfdyjM1odieANEtwf6rEZI?=
 =?us-ascii?Q?CBMfhb1VkqCoqr+mTvcBT9twmtYUmPosAPa/I/cwtS6KssrFdoLGb+DTYXJv?=
 =?us-ascii?Q?sA9BnwVuvac9CD7Z8MT6eXKYQOxGix9B6pFiFL3jlHDAti8dm07PY45AZBqT?=
 =?us-ascii?Q?kBRAYBowTYurV0mz2Ul4iSc+7Kca9g7UxO25XP2u7nPc1c7/d/aQDTcf+cZX?=
 =?us-ascii?Q?GVBKLncCVe2mpEMUdmTckF6dFCj0NyvIKXqFy7BqjZhBE1dAuQ52w1LrNgGV?=
 =?us-ascii?Q?Z0StlCnIklDiiGLxBcRYAqwWSFCX/+zKFDCfhqlNfEQ5Cka3V9SJP8Bq18DJ?=
 =?us-ascii?Q?iXG90cLdGRYh9aw2b3BhxdQmzAZTVyWkca0/jb7tKoQqpFXd1FvHw2okVeYn?=
 =?us-ascii?Q?jtliSTGrsAfHNj6f+wGJQQrrv8pJ7EE7TjMfN2DoI6cNAGDL1ZgbYSD3OgyE?=
 =?us-ascii?Q?/h/pCLhv6Wv2CUzoOtQxSzDS+aKQaRsEpoGtLCJNblxf/9nm6gaZJAjLZReg?=
 =?us-ascii?Q?vGkvwyptD98vXJyvZA2+UhdomXVSTC/doTjfY//uDE/Z361U5o7zoysKPkA0?=
 =?us-ascii?Q?Ju2/AYoUG/HiG5Tx0AjHkpafowAirZvFI3c1Jp9X8Aa6PisaBi4lda4c+yio?=
 =?us-ascii?Q?+cbXodgLl+f+uQACVi/OPwzwT0UAE6BFnxYukUcXup1iFtEOweckTj7p1lWV?=
 =?us-ascii?Q?uKbLwjQ7mwkVuPw0ME8Nac9IuWj37V2Sky92MpYPXPggeWpFM0Y9bfCbfLdl?=
 =?us-ascii?Q?qdiQQTS5VZmOVoQv0BcqcjzGemoc0T8wTAwjtaHVTnQfDzWhim/8n4Rsfexe?=
 =?us-ascii?Q?L42qUayK0AMhDE6rrBK7Tp/A/8LyYrehgVPypguUf8BuzzEUTy1v3u/HMvh7?=
 =?us-ascii?Q?Dkz9DNheRXQLCl5lCZB+N52TB7eZtYtdjP85nCtmCsPg+C1txOolbmDvuow6?=
 =?us-ascii?Q?Urb0eQKd0fsTJvmj5k4r2C+ku6FW967d1/ZXyvzRT12qoyR6KsLZyPp7dqK+?=
 =?us-ascii?Q?9JuzB9FpGllunfBCd3p+F0YgIrqOUtjaU+C5tu0EUHDjpT/vqXPO99U09USi?=
 =?us-ascii?Q?561iV0dWcf642fOM9slaDNuVpcQSVrqAov3meCGvOYyqMf31jj5iQW7cKmz+?=
 =?us-ascii?Q?a1+swX8F7S3Es1MWR/k3H16/CJe+hZvXCEt8bFgAj9LyHzhHYtAPq/0GoUWY?=
 =?us-ascii?Q?lD5DTX94mxBckV7Mf8dlhynp0IehEBo3hKjHpLKGb5MVtqQSqa5SodiTZyEe?=
 =?us-ascii?Q?MxV+PsG2Wr1rgIzIJ0aSWXozDgH+lhbhPgNxTJMD3xgaXGcyN5NPZen1kqlN?=
 =?us-ascii?Q?x6luptOFaBUj66i84KkkC7R3fw4N6F5z0kxzBAX374UE1FsN7Y8OGNGYG8te?=
 =?us-ascii?Q?kus51/tiSMZGz+A1/Tglg9CmKsiInZiJFroJnjbVk18hIOlZsyEAwinh9rgn?=
 =?us-ascii?Q?VhFyGnYfSSXfpkSlgrNq0Ifws8zWotwx35/GP3RD44RYXMt383gj+VMq9Nrh?=
 =?us-ascii?Q?VEswKpEvPpsgMfeYWJ9taEw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1148519f-b4af-4681-f336-08da65690a92
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 07:18:24.9564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ZDXFttPYclZL92cPT0DlAiAWJS2yDpLcxCpjOEetPYzQRvfFRDCntK2/oelMrtmsKftXi/dGEkjjTz8iGV3TZNu3KA2GST4V3BzqY/NgL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6841
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
