Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9B165083C
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Dec 2022 08:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiLSH4s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Dec 2022 02:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiLSH4p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Dec 2022 02:56:45 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C9CBC2E
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Dec 2022 23:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671436605; x=1702972605;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=bd0YbR/KjoACtMRrUGAtCVwM/Z7/rCrHr6xK1DPiAjH5lPN45h4HYaSE
   v4+by4HtcFiuiJHUVNGr/L/a4CdBkIxRBvDF96o6Fm3fDqs/i89c8fT/t
   E+W1PjGvp+T9LnpKD9FsGkKv9BDyXdEvJ3a0VFGnGChCJiZkZ+kuSXUD3
   4p/iYvJYabr3rAX4DLQWURQ3AMN37fwuwhWKARLoCp89F4+0CgSMa81pr
   MYwwJ02ANtnbbSnkJcHfcW08RT4aSR4fDW5xq3/JZpIwfCVyJ79zrNBM2
   eOilWRwY6zp9DQSGQzOWbOKqHQ/8xqo/PDwOceiQIRC817GDZQx8os0Xj
   w==;
X-IronPort-AV: E=Sophos;i="5.96,255,1665417600"; 
   d="scan'208";a="217216180"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 19 Dec 2022 15:56:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bds1N8E9AD2oOMZI2sfw2dN+nBoatI8kCAIohW3tk3sryeCVVb+fbfjmXkaLfva+MtlUZQJ0/p4Rrg82AXuL+szD5UrITg2QPAf1wGvZu4TCzphBehk6zushKboE7wBvjiT3mqUJ3JMcNL7FirSHfatQUDU/v17KX6PJSo1fjYmHECWb3Yo6tFvQGHZUuwsuCAM4jdKrxntSbDNSXw2Ul0Jk2OZzYoffP9UX3fQ3NR8mObP+M8FuaQnFsY1HoPoKLkAdFHjHL6ch4fh8O+vzosPjlAxj+8Vh55tQ/QIqzJtxpOEJOk8vxRiQW8jqcwskmzNSg/exASewu3WYFIX09w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=MaWk710gzvV8p/7mwxymBXDhrLBW1b13OUePIOYz+g0IVDdHTG1oGl6R/70JIj8hTAp0qx/8NygJPA7uGif1Gqw2mlGk+cDZiXg5WhYpr2jp0lfzNQE/mFrKCde/MVs/IDpU8tIAQB6//7ikU4ru/2EYIxO7xybCnc1MJNBWy4Ill7sBATriC/Ple14lLEH/n7ftnYZhK1TkeEGNjxuzZTr03WDQg8293g1FJqzvb60i4sqiTNQ4AKcSf6rp/ZAvDJHgSvYcP3FQjT+bJLNjnE6/DbiQvv2vSGK9g8YQXJBsxxqOCFh2/o7wd5/uh7DS1Dh+U+Xt4Fb+xHn10JSxhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=K6xAhurXLXQYfpzhlkO4DEaKvtp+3dK/tKGG9anW5nyt2xkhAOKycfNJ95qtwwazhfTC8pkbpOWXQUUJ6CUwxVbHzOrWWYC7LlAjw//aG9/RBVRSovXgRAoBpVImK6ABqfTiEpg1eFIoGj8tlAtQMZ+lJUo2TPvAW4AkJWk43LE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN6PR04MB3713.namprd04.prod.outlook.com (2603:10b6:404:d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 07:56:40 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f66f:ab77:6874:af4b]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f66f:ab77:6874:af4b%9]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 07:56:39 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 4/8] btrfs: fix uninit warning in btrfs_update_block_group
Thread-Topic: [PATCH 4/8] btrfs: fix uninit warning in
 btrfs_update_block_group
Thread-Index: AQHZEYt+wMwj8X3qi02sJTULd9P9165028KA
Date:   Mon, 19 Dec 2022 07:56:39 +0000
Message-ID: <d97347c6-c1fd-a34f-9c99-8205b3a97638@wdc.com>
References: <cover.1671221596.git.josef@toxicpanda.com>
 <87302b559838af285024d47b3b738ef36ad0ebe4.1671221596.git.josef@toxicpanda.com>
In-Reply-To: <87302b559838af285024d47b3b738ef36ad0ebe4.1671221596.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN6PR04MB3713:EE_
x-ms-office365-filtering-correlation-id: 0c0429bc-a66f-4580-f668-08dae1968fba
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bDLx8OpRfQRbNHAmyKveaOh+cu8ZBq/XBummlhb2BCsS3lPOf4YrBksoF+OcEc4otQk3dn53lk/tTgV1jFsMsJoQgWDJyi18jUT324q8qMrJjqrK6c5s3dlOfsRupaejFQ0iEm2RTylMYtYNz2epaSDNTmir85nhMCFv9iaQSpZP8eYF/avn6xkSIb04Mrs1fyTChLw8+DakH8LBt9E/ipetDaErtozkc2SwEmXhqzQnaI8s//uW7/Be56zEWf9OTuvRpXpDLvyPaD9U2C4BlCF//DE2tKYQzWgflBmz/fBgmHPtzizVo6P3LqRduqTYrN4fVcXXEFgaoNrBcZyXu/QK6WsUFk0CU1YJeL/mfeB0vG5DYYUza5UAajlWtoSvz8aRvuxDkohyLV8OamNNWbwQ7/WHEm+4fXHaqniBZYY5zJD9JZe0UA1ABjQGtOADtsC2wUE+A59aZdfXBzJYzZP1CQcMWw2efwMdfHrfkLwonqpHoTrhp3pjICowIeE327sjDANDQ1orwCJ8qhJYvuELpWBeYm2Wj9nloSkr3eTqrOszhyoJM14YPJBq90Vm1d+Sc9/eI3HKDp+G+YcZugP2+ZPibKaPjuHfiuG+XMoncel6tpRYyG/Gs0nKbbup5obGIYEBxoGGDYX8Yd7vMSZ6DynxcpEosEtEgLmxJfA67Sgw8c5wJZ+qR5uCT+m41Hq/n+LC54XT/XCCr1epwuM22KZeMFd6bA+f5RmgL78r/ZKlv0OhFejvRTvRCMKM2W8zszgF7rEKIlL4eOETSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199015)(122000001)(38100700002)(31696002)(82960400001)(86362001)(558084003)(38070700005)(19618925003)(76116006)(2906002)(66556008)(66476007)(66446008)(5660300002)(64756008)(8676002)(66946007)(41300700001)(8936002)(4270600006)(186003)(6512007)(6506007)(2616005)(110136005)(71200400001)(316002)(478600001)(91956017)(6486002)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0NsN0dXeVJlWVBXOS9PdlNiZ09PZi9LSmFpRHREZ3RWUStTUXFxSG03M09E?=
 =?utf-8?B?akxEYzJXN1BEeUxrdXQ0UGpZQ3QxRmtLMVRCdGZHVitOeXc1Uk9oN2JCa25o?=
 =?utf-8?B?ZWpRSEJkeVRSdXZhZVp0NUpqekVhc3ZYbE8rTFF2VTVFZ1h6WnRGTytOTzFv?=
 =?utf-8?B?K3RBM21Lb21mN1hOOXBnbm4wbU1QVG15ck10T096OHYyaFpJQVAxdDhFWlUv?=
 =?utf-8?B?M2x4UHNNY2p0NVZBaDFlV25MWHRzcW4vUnZIU3hzc2x1ZzB2TlhxTzZiQlJL?=
 =?utf-8?B?MEhQZ1pSdFVrcTdHNWwvY0s5WjRxM0JkeCs1L0xpRUIyVEUwQWdZR253d1Iw?=
 =?utf-8?B?WnJBR0ZTU1piQTgwUEdVeXZURVVWUytPL0tyNnBPZThudkNuMlRBU0VrRnlQ?=
 =?utf-8?B?Y0xpWEl5eG5RaFJmdEdGWldwdGdIcFVDSk5xTkgxOEQ2ODJMVU81TjFmMGor?=
 =?utf-8?B?V2Q0ZTliOTVGanJGaDUyNnlLTnZISlZGczAvdWdEeURIejYzZ2lyb2lVU2RQ?=
 =?utf-8?B?U3d6bUFSa1ZlN0JpYjhEV2RUbFEzamhCMFJhdzVYOHV1RXp6NlR5dGF4dmJI?=
 =?utf-8?B?V25pV3YrK2VBRUl2Mmt3RVYrazdPb25iZGhnNXJCOFAxQSs4eDBvU1NVT2lW?=
 =?utf-8?B?V3FOc0pKdytseWkyRnhzdGVNb3RMbjk2VTRjdXF0UU9DQS9XSUpEbWk1amhD?=
 =?utf-8?B?OWZHOWtJejlVcTJwNmhlZ3JISVo4TzlTZGRrSDhvZWRjcUxCTENCRjh0M3Zu?=
 =?utf-8?B?Zm50QWpPN0ZJQXZSenVReHVScFd3ay9aR3RPUXhlOWEvdTc3OFZPRGV0OEh0?=
 =?utf-8?B?alM3c1NrakpOOGJwYVQ4a242KzhSTUVSNUZJNlZscHl4YzI4MjdMUCsyQ1J4?=
 =?utf-8?B?MTJVSjBrRGdyWFlzOVl2Qnp1cEY2Mkhyb1ZNb1dUOHRoUS8vNVRBSjd0SmJn?=
 =?utf-8?B?U1V6L2dEdHFLUGw1TjB6b0c0RmthZ3pqdkRXVmNVZE9oU2JYTkxsNlREb1NO?=
 =?utf-8?B?aThHbWdaRy93ci9jcUJ4RmxkdWx1aGdMQURPV2VpQ3E1T1lMOS9PbWpNVm5K?=
 =?utf-8?B?Q21LWldPVHJhSEVvYXY3YkhkbEFCcVJGSGoxdWg2VHBPTzZKZytaSW9HZHov?=
 =?utf-8?B?VGs1N3BiTWE4YzJnU1VZOTdWb3NjNHp4QnptaUszL2RqVGFqdWhXTEttV0lZ?=
 =?utf-8?B?ZkNlTXFhSTFqRGJvU050YXdYNXM1YTVFRmpxQm8xY1lvSnpaMHNQNUppdXpW?=
 =?utf-8?B?ZlJIdHZmaG1UdExialVTZ1BiTDRLbk5LUDRtVmdka3MyWE1OWVV3SEl0QkVk?=
 =?utf-8?B?RUkxYWJsSm54c1dzZzdTKzRDZWNUMXAraWRXakJnOU9aa0t5U1ErY3JlM3cr?=
 =?utf-8?B?QTJObHUxQit2c2hmWUdlNmhZVmp6REtpOW1mci9rMkZFZldqZ0ZJdkpxWW1D?=
 =?utf-8?B?dEJFWnA3Z0N4NmtJNUJLRUwrQmFYdkNRTisvMjUxd1lRaVZseWpRQisxM2E2?=
 =?utf-8?B?V0F0UlA0S2tXdjcvc2UzZlV0ZTZsUnNUVHhYZy9RcnFOczQ3UDc5anUyUmpW?=
 =?utf-8?B?YmxpWTkvMWdDOEpNb2ROUTZUdjRQNVlBanRMVGRFOUF6K0FpNnpIT0ErNVZv?=
 =?utf-8?B?djNBVGFuSWRjNkwwczNYcXZxeVFzSmg3SWRCU2xnSHMvR1JyZ0VpS295Sk9n?=
 =?utf-8?B?SFdpYkp1d0VQd1I5U2tSSFBRclZIQzVpQ2hBODhaNk1LR256dmw4cVlaelVn?=
 =?utf-8?B?MGlxS2Y0OEozcXNabTN1ZS94VW0wMmY4OU8raHJ4b3VPU0prRnBzOERXOWdk?=
 =?utf-8?B?ckh1L05PSEl1STdDYnlzSE50Y3FBSS9Gai9iQWpucHdORDdFbElFNXRXYjhm?=
 =?utf-8?B?Nll1S3NYRXVIWHRqR1BhRlowYmJtS3hZTUpVY1hGOVlnR3FPeUFBU01FWFRh?=
 =?utf-8?B?YXpRMXNtSWpraDd1bkgzNW9xdEllL2FlbG9iZm5DaVhqTzFoekVSVUVZemQ1?=
 =?utf-8?B?QVJsL05hRHgzMDd1VXp3M2JMTysrWmIzSks3dGpkMVZFcmphNC95Mmo2Yllt?=
 =?utf-8?B?c3ZkWnhKdUlYQjNCY0NzeGhQdUVzNTVwUFJwVVlWTHJGQUVtVjVDZ3E3Skww?=
 =?utf-8?B?MDBxeTVJemdFSHJ2K2poMTJUcUdaWWZFQ3RlUmx5RGFjMFZBZnl0dENzcWtN?=
 =?utf-8?B?Z0hVLy9jTGwzTERJeEhrcCtDcnpOZldjM0dXc3pzTjN2N0N4azYrWElib2NJ?=
 =?utf-8?Q?YZcqOkBrv++wkZI7IsmMWoxs39/Do027xK0LTxL368=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7E73B135BD98E4DA63E18E2D5936E4F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0429bc-a66f-4580-f668-08dae1968fba
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 07:56:39.8616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y7ezzjqvLHTDm1q3SNF1gC2FdWONkxOJXRPX8j6o5YOUsD/caxK097NLEQvGf7JqdL0c3uLpq4rkJtS0VOahi2iaULFlkjAQBcUiQ/urwRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB3713
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
