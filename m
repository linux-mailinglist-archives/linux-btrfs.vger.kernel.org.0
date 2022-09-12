Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3297A5B5B43
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 15:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiILNeS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Sep 2022 09:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiILNeR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Sep 2022 09:34:17 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBAF2B1A0
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 06:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662989656; x=1694525656;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=FUqEkiRrchL9MRCid9yM2WaA1b+zwlhpeAKDV0Ud9h+jt3x9GFfJRJ5b
   bKLJVsfxwssDewNJ3xrZhy7TCgnLfQZFm7/KsvmlocqbjnzoMtLRAXtOv
   JNTiovbz6j6RG4PGiqd0Vg+aBZpJwiPO3DeAofiQGegifH20qFs233yTk
   NbO8qBy7jB0rgq0olOcel3ra9mya/FDf/yinjVnzbAmmsDPGPoIPmB2de
   4M8rpnUMVAwDwQHUkNfk4EGVl2C1Z4cItBZg25MciCU8uR5R/uOVIzsbU
   9ZNw7Sz6OnmpnqiWAzxwwm1kggQkOFV8npbdeqOeWPqZUW+9GJJuDDqgN
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,310,1654531200"; 
   d="scan'208";a="315409919"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2022 21:34:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxOZdwcpHz1H0GWGdfXDrClWWfnX5jnMbJbdEiCr7ftEgzkzCge5l7AHOIzFb0CI3IvJTvLYUGOP/F20wq7TZmdUcUXl10GU3CrGM5dht7pyk3ZIQ/Iusvct5+WY56QD0JuR7DETgLaPhGzh/Xte5pD3CJP6WdGu1mWLKaj73rjzHAC9jlFWLMwcA+VsPHQlq4w9dnq3ddabFuUy/o6RORuqiz8jwCihLBgLnZekFWnoevwx271ca1bs9p2eTO74BzJQTS15IbDr85XCHFn+U2+FtYsvqxQ0Mr/61hZxX4rb7dKwCeNFJcHfjYSY/LQubAQni1ye96vWfDcgqDUVyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=UcHBVW1a9Lqih35TLiF3ATlAhwrv7dQ8IBiQ9P3SmJ3luZyPhanEt6C+zco0X90Gptz08Wq/uHwQvbCZEoSU7hg4AvRsT0m73+Ld9C4znrSG+hLWjCMqhi7uyssskOgJMLed7MVKmAAF012X1WG35P5WQcMd8Nz5edldNWK4uDel0S44Y268e4n5t0yLabLe5U6D4bf9BMf/hwswitWZkCKiBavlwgjkI3gRsH5jwa9Pj6i8wKPIBa4vvywSc8hWm5yNuogGpkNCjHgMF+dsJ1KrZg/8Hq6N4ZMfD+Zl/6pl/KOxtLKZUhRwRLME8k+1hg5KhiE0YbmlcmP5s+0I8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=naEQtoX0oH0AKVWCOJv/rccy8Me4ZP42mi1PY8aGpxhwUka6K8G2SUJSTbRqJHvEt+U6N62C6ALxI0YXpnMOWowCmblQiCxdGP2ABzix5IQ9mN/9hNTRJub2WhE6VtIJLmYks32U/rJUEOGNOUcbNQ20ijeY2gnwH4FdPYzhl3A=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB4234.namprd04.prod.outlook.com (2603:10b6:5:99::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Mon, 12 Sep
 2022 13:34:08 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 13:34:08 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 02/36] btrfs: unexport internal failrec functions
Thread-Topic: [PATCH v2 02/36] btrfs: unexport internal failrec functions
Thread-Index: AQHYxJbuwF/7S5yjl0anGhjVNhbWhQ==
Date:   Mon, 12 Sep 2022 13:34:08 +0000
Message-ID: <PH0PR04MB74169D598693379032689BFD9B449@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1662760286.git.josef@toxicpanda.com>
 <baa7597615c94103ff8b597cc27d6282f505b3dd.1662760286.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB4234:EE_
x-ms-office365-filtering-correlation-id: 103eed38-4bba-4891-a126-08da94c3786c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fYjpRauXRTRZ57bnDVtdr/piZfLV6B3K1BEJxuQz48lu8gVHL768gQX0Cgv1sYt4AzO7JuHoNvuVX7FwyZOuFIKb8sY9PqHBWjj/SdkV4DQ2rHLZ6D5hpqjINn/ihSjPDmbVDR6Ct+zdiX+OX7GPOba0mtP45umygDF28WA8bu91AfLFY4VzBG2DBv6Bg602ZX3Tk8oe4owXrzXUXxdMLXSihbORhnHl7egMyrUkC6yCZ5hMQlU2zUfvSZOWX1GdoxA4DwfMfkvY8ocLtl6/+H04JVJAmYcmYQPZ89T+OngCWQZ0bD2qo/VO/TgM8HyXipgE28cvOKZ56jjReg4J9DSVmH1QZmSsGTh7Eul04PzM0/nWb0iy/rgo3fHN8Hxm/lFV0W1AKH/SgqeY8XL5W5zriViNubHo9FM7se94jvjGenQ8BN13SIQOWHtZMcuoE6+IKKtl/gjKEBcTc6IxrJuI3BVwdIAAALoSnSPiB7kXFojqSr3OyL6IsNPcooP8AcwdL1AAni/jIUXHBWVpqry63UWavLLkiXG2pSTwx58mYtZMnPW6sYoprgjaflRa93tnovDT2FHmsuN1iK8NrbyIGiPh70UV2E1eNPvORKMSA229pYfOy5K9zlEiXgyKGMfHUpV3UOAlMJJSROUUnQwlzwXZWoFTuDxu671ATO3x5mtQSdD9OdozzkS+rRxArlmo5JpizX2nkHrt+oYZyMnGJaUhQkVnr2yc2vpTkBg+ouH3EgI0UU3CSGFA9e+Elr4BgJWhJrB3YgNVALIAZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(55016003)(2906002)(19618925003)(8936002)(316002)(33656002)(186003)(110136005)(6506007)(558084003)(478600001)(7696005)(9686003)(52536014)(41300700001)(71200400001)(5660300002)(4270600006)(82960400001)(86362001)(38070700005)(38100700002)(64756008)(122000001)(66556008)(66946007)(76116006)(91956017)(66476007)(8676002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L2VAyipFfeSJSAdbkCjCSik1JednsLIqNlHSitevOX2kZVko4IVZ7T7waETJ?=
 =?us-ascii?Q?djRAJfj8zqm3lJAkOyJ2okwrcQYkfgjUxBPovRBU88G5zsMzoW7ymom1vvgk?=
 =?us-ascii?Q?WIHgy9R/FIKEwZPK8I548t9uUcDu9KNf/JjFEpuQrpF45y9kgwNzqOtd6qqe?=
 =?us-ascii?Q?QweaWdYcMHMPXQUiFoh2IT81r/nJUmBHjaPw8u/nPHHTsH4Do28Nq33O8evU?=
 =?us-ascii?Q?/iStaIUtjb+5vBAd46f3lsrMWDwz7swj2deVZyvEihZ2Nd6wihB64RS7o0aM?=
 =?us-ascii?Q?NCcoEKfApDxrQUEnQOLMYzBaf5lLpGtrL8jxZX4Yr6RUpwf2ON6akcmm53F2?=
 =?us-ascii?Q?WfBmGBQunlPMx4UsyPRv2yeV5sLaehuRjjv63441IfRbTKVmsw+r914gk2bC?=
 =?us-ascii?Q?WF0IEnewL7xH9J3Bnf95VYIsFpdJ20vjqCIRZrnOIJF+30g7g+laSMlAC1Xu?=
 =?us-ascii?Q?aukNLot3qZiVvWicgCEnY6Q5WVCzN+saHsXKqqPBgBAIWDpDID1HxMpba+J3?=
 =?us-ascii?Q?8renEDnfp6hSM573ELAYSu3rtQuDHnttOEP2zgSrA6M+Spqi9QNgNJFz5nnv?=
 =?us-ascii?Q?V7fU/3dxi467U7dDW0hJDJmImunNiqt9ijjGQMR6plfN8DCZOq8uJSQpl02s?=
 =?us-ascii?Q?8gf49myJ/t7ymEDIFXb/3F2ZA7hgvUPBGAhDbj2W43VzTi/Z251Ttgq4Xc7A?=
 =?us-ascii?Q?PQeLq+iDddjh0HpVeRxs5Oh+Wpk8YVA0UDBRWHtBAf2SM3WRZKZWqh7KGBnS?=
 =?us-ascii?Q?ECRNjqsrKiEU39wMD8RxM1KzA56N//ZgOJ2Dg6gk9zdpn6loePOWzcZ89kT7?=
 =?us-ascii?Q?JTMYwDgYSMQEYMkAFvbd8YORBi0WavlRUSDaXqEYMpJKr9ZTorsmlk56mWv1?=
 =?us-ascii?Q?cjaxIhVVc8IwbpFYA0q+oQ70c33ivyCvPUrxUWs/GKLaMH6GW8DBXPk7jtAT?=
 =?us-ascii?Q?Nfoiiu0+CsiwXZMLbnifR91DSuFUtFpLLaT328EI/3ez53wYnoIlnvvyM67d?=
 =?us-ascii?Q?eOTa/lcTzsM0uqCwp2utKBTkT960wB4gxicQ+CkBl3in3aF/dk1lgGvXMByI?=
 =?us-ascii?Q?3cWoOL89IZ2ESqrTqFVgHl9l9LFzzVAZUiTmZMcnq3Fwqk0yQM3tLXXJkL5d?=
 =?us-ascii?Q?2/dyXyxJrgxb/ikA8/c9C9oO5vKR3/1N3ifhiVRcumOKakjZUsLDfjYQGnvH?=
 =?us-ascii?Q?az1RlpRLP85hlmEXDfWZjG3tmKhvtSetdTMhZOnlER/O+UvdSRMSFUHMooba?=
 =?us-ascii?Q?6Lmkm29tZ4wZF90Dr1p5pkdyJU/b5L0aOvoMNnInOKFXAFGiVMRtkX7COw8y?=
 =?us-ascii?Q?CaxQRLUig/gp61vETu9N8Bo0FVl1YRcOmW6AsCxsGHg0qYzrPoQi1YPK+IO+?=
 =?us-ascii?Q?F75eGzQ5z/NOTSYjU16koGnYJBHasWduOLJcDfqLMFDJf34QW/jUYWPaEHRV?=
 =?us-ascii?Q?1WGkYfOU1fFBiY5fykxvkhDKfAqwZlbq1yf/+qs8GvoLKdSnivAOjotcLPJh?=
 =?us-ascii?Q?YxxjXRdRaJy+xM70UPyIwWAJdD96ExlyR8zW7eqaJTv6kzIZgPV1cCw7X+t3?=
 =?us-ascii?Q?v+srAeiRiRkH1sAEW90uh+9/DgrLiUaGvMpHE2qF7uyGMTZnZ234HYDYqx7s?=
 =?us-ascii?Q?Im9ucICvLWGAYNIFgccAvfh/ZTmCMnQXKIib2dpOG1jewgxJlu2pHWDq0h9r?=
 =?us-ascii?Q?zViead/wsG3E3WbQOjAWjMsaJjw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 103eed38-4bba-4891-a126-08da94c3786c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 13:34:08.5640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZoVKi7840qzNltM5+dl8g0/RojLxU9tVSEU4A0oRdGK6vhLnhQLDGMQ4gWHET3TzHN1RskTsnDOAxcYEOGjOS16Te71N/qutkxwDL+/uXTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4234
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
