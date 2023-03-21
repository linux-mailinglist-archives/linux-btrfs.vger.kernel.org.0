Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086A16C319C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 13:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjCUMZP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 08:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjCUMZM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 08:25:12 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9214F3D098
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 05:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679401486; x=1710937486;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=CuCpLznHvheN4FxSGKceN3V8FMMkZhsFcIdaUMCg/hzPGuJhdnbXHl8j
   OxYJoHJ+iNgrtBxLYdGuSCrIdD8z7w39zC8XZ0UxWaLZ1y6QM7LETe+yT
   oUDW9+JeLHx7QbT1jQovtWMYuQsLjx0fC7qSV06O0YWYzC1bmmlIMUuyx
   xYbo0pQna1W8o1HjxXbZxa16MH5MlpfEPwBXz2P/oJc+5bgUj7OghUeFX
   eayf35KR/ryppabzh7PsHCj1zbKL7SsIISQete2Fmc9ClZPWU/rktjX9w
   CHugEdaA8Bl+rUNfIoRnwcpUSv48xIbWQ8dvuxKQhmaO/U7rFMVQ/y9MK
   g==;
X-IronPort-AV: E=Sophos;i="5.98,278,1673884800"; 
   d="scan'208";a="231103232"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
  by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2023 20:24:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmc2WIPdSj7pLXBxt+EcRHlmwNhKNqX6TXAysgdIHdDf5IbP9IKOnWBbTshRvsuUfBDcapEHZtiXDgbs1s67YzTj0AC6eVVenjsfsXqbXLKdhe1xP2iWYEDexxBUldlYKm/GoS4EZBnRggEkx3kkNte0rNc3TdsIbrr4k7s7CxCg80pFip50xnDPR5Q4T/edtYSA/XyqVgUrbGn2usaUs+SqPK+AY6qB6ED4frR1JhgY5MbDZ9AARJbSqYe2g8VvUWbSPswEVis7rgNpv3XYMlgTGR6WdckROLDj8TFK659a8gOThSjVlLusRCDLWmoQRlJIc968W5FWSWSh8dIyjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=fY+1lcKwSUU755jKdaOKH+3RHeIvZxK8bCS/035HCzB0sI7xxUglgi3IeGIG8tE9zrRqa2oyb+YmcZU6ZnytR0LznDmGResmTda5uJaEY8I+rtzrpmP+2iuKJg3eE2DQ6I5ANmjWbGjT3tcZvIQHyWg7cmHNbo4TMsLTQaYLIjElmPQW2jVT6/11ORaRQBYnJeQd4stv1IpF+AAtUmo+zF9AXvuaRHK3frwa4Vdql/oH5IvorHb2GAtg/ixV92AxLIVqWDYw8p0W5W3lWCOa7RA0iIGtdE98lnCYo/jNiKZunznpGO3TbydV5pQhUYNZLQ04IYECk24z1hKFqLO5mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=d8Hsh4eTUJFpzUbcsDKIML2/Z/Se/KulAZvhaYOHKeN9lmcuZ+1KaPX76LQ2253SlGKxV4abm6IDTrGdLKhomihgShfiDz1EoensregnLGSV2jWjYhYxSBcoDJcmMTqadcgjEWsNculpMDontgDk2fWFUr0r6eCQooi3UVO+RkY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7736.namprd04.prod.outlook.com (2603:10b6:510:53::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 12:24:44 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 12:24:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@kernel.org" <fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 06/24] btrfs: initialize ret to -ENOSPC at
 __reserve_bytes()
Thread-Topic: [PATCH 06/24] btrfs: initialize ret to -ENOSPC at
 __reserve_bytes()
Thread-Index: AQHZW+ZYBdIUx2CB9EqcViIV/z7QEa8FKG0A
Date:   Tue, 21 Mar 2023 12:24:44 +0000
Message-ID: <f0108d5c-679c-9827-8583-a4b4e57f9754@wdc.com>
References: <cover.1679326426.git.fdmanana@suse.com>
 <e20f821150a7f888758021613820c70a268a072e.1679326431.git.fdmanana@suse.com>
In-Reply-To: <e20f821150a7f888758021613820c70a268a072e.1679326431.git.fdmanana@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7736:EE_
x-ms-office365-filtering-correlation-id: da872d5d-c1ff-4542-bb41-08db2a0740f9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iePw5oAoXCXJAaVdOYIXRgNv9qxlat0bl9OA99/CnCZ9kr11pp6gX0xCquoI0zOlt7PYApkBRuosFiVbq5xG8wZHHFDxPMH9SrAhes8MKeAugPHagD5HIpuDgWqGsU2v8x+fpFGEqXXvPqpsCV/VkfDZSApq2Mhmpu1c3P9NAbRxKbJNBIkrAvAi/rmmStZj9eaDC7GA4thwZYLETJWj529ERSpdYOk7Z7Ghf74hcCi/WSd3kAK4iMsgpHoAoWdHTqGeCc1C7HFuQqU5kK4IUNbvdqpNttEvuxPhpwgW5zcz9+Y2ic8nxDJ4qcdBFHSlKJVEXeSCGxLTnQ3QQG5UzFKFQ0MVwRSHUIGSKC5tccBE1O/mTMrct0x0WzkL5Ht5sxqgbJZMzS84A3+hYFCwxropS18ssdSLbhlKDNasyTiMyPYQzbtwoGGYH/XUGNu2OeL/iOBMyKWTqxBcdDDL6OlHsjyRaLwOwJIhaLwUZhmMgOUpT79MUofWz0ysHNPX99jEr2PuyIgkJO2V6SAtWiI2ZXgzFOVHEdPNUwW47Z6CQVGMtfGYpg8i/m7sxWP8j4aPB5auQWB3+tTb7Eb4V+8PRQvD09mFfP7wGgr5jgHHODt92B6fsx1SWiTV2X3cCb6+2mnxKaZcgkcC41xe6ybsXdDTT6xcX6ZLe8AZXlUWmYOxzEMNPP9nB0O8JUnir085kWyakj2tMmijUAyiioMhgDXN4HHbJ1HbJdcL27UVH8OWjEMORUbKif26y0aZcxGkWFGgMq9ViBj5z1MImw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199018)(31686004)(558084003)(4270600006)(2616005)(6512007)(71200400001)(5660300002)(478600001)(6506007)(6486002)(186003)(316002)(122000001)(110136005)(31696002)(86362001)(38070700005)(38100700002)(91956017)(82960400001)(66946007)(2906002)(76116006)(41300700001)(8676002)(64756008)(66446008)(8936002)(19618925003)(36756003)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmdyS1RaWVg1b0NrYllBT2JFWWdFUnBGTkVZaHB5MzJzKzJadUlFeCtpSjdr?=
 =?utf-8?B?UVpNdGpidEJ3ZXVuVStNVldjQWhnYW5kd05JZ0h6OWY0V2J3RkNRcUlsdUNG?=
 =?utf-8?B?RWw3WXUzK1ZRU1Q5L0tBdkJnSGU2ZmhlZjl5VkYvVUtZNnd5VytPUG9wU1hx?=
 =?utf-8?B?aVRRWHNUd2JTbzZlc0V6U2J4N202QkxyUDF6bkx4Q1I4VjBRV3UzT2J4dWxp?=
 =?utf-8?B?SldrVnRuNTVWMjdoOE5CNE95OEphRHlFT2crUDBaaTFmVGFZcEU0VjY1cktQ?=
 =?utf-8?B?UTc4MW5HbzVFOVRoYlJ5K1MvY3c0Mm92MTlESllsZ2t4bG1QcHo3M2xLSmNm?=
 =?utf-8?B?OWZ0U0l4b244NGVJSnJEdFZOYkl1SFhxck1STW5mS2hnVVhsNGVwdWp3NGlT?=
 =?utf-8?B?OFdSUHpRUnZiRWkwUjVjcFJsK3NaZmJtd0xlUkFPeDg1RGlYYWJsK09KbDA2?=
 =?utf-8?B?QUdJWk1aVDlNOG5MSjRNSXFneUZ1U083Mmg4S0FUVHJkYmN1SEFCTTBCdUlT?=
 =?utf-8?B?aWZUSlIzazhJbjc4VW9SdzBnTUdLOUEyZ2orTnZTdEpQNnh6bU94aTJiUkhT?=
 =?utf-8?B?a01vNUpBQU5ZYmM2Y1ZLRmJIbTVCV2RsdWpjTWliOE1jREZvY3ZmeWYva3Zs?=
 =?utf-8?B?KzAydlpGNHgzWnU4dElmSU1TaFZKc0RsV2pIN0dUdDZzVFFiS0JqSnZPQVoz?=
 =?utf-8?B?M3NOUW5kWGllam1icmpqZzdKZVVnM2ptcGt5dVZhUEV2RUt4T2JQdENad2Fp?=
 =?utf-8?B?QWpESEMwNFhCMVpmVFIvSUcwL0Z3SlRBMmdSK3BQZ3c4Y2xQQ3BFQjRlTFBt?=
 =?utf-8?B?UkMxZTBOZ3BkREJtK1dGeThVTXpDRDJpdGJkVWhHZ2pYdHFHaURrWUpSZDdW?=
 =?utf-8?B?SnRYR1VmSXBIN1VqOGRVendWcFBoQTBpTzhBZ0I2RjlLTmN1b29UMlQvZjFk?=
 =?utf-8?B?VDBuNjNONXhTNUJWUkFlWXozRnpsZGloSGRnRThXOG5nVGp0VVdUeW1iUUtT?=
 =?utf-8?B?c2Vad1V1ejNmMXpoNTdEa0hxNXh3OTV2SUJiZW0zZE5CeE52WlMzMXlXeXl4?=
 =?utf-8?B?blFCY01RV3kyOUtaVmZmUXhmNWkrS1JjNlJtTmlmRU1lZW02L1hJNzhrYlQ4?=
 =?utf-8?B?THFaVXlwTzdPRlpCR3hlR1NYN3Z0aGdqN0t6Q2ZrL0N3dWgrRTg3YXErRzUz?=
 =?utf-8?B?cTZwaHY3RkkyUGpxbDgwUTFlSWsyMGpGL2o1bGNoVE5SRXV4cHlOa2RkWVN4?=
 =?utf-8?B?T3pYNlF1MnBGa0NHMEs2Ri9YL3RtYmcvbHpzYUZESS8wdkExYXRtU0lrL3Q0?=
 =?utf-8?B?ZlB3OHJHTzg0SGU1anhxM2FMWC9tQWptdTBXZXFYYXdIR25xNysyOTV3VUNN?=
 =?utf-8?B?Q2VCSTlNUVF0MFlBb0FPTTRTVU5NeG9RVlMrNmVlbVUzVElqVGZ2SjJWNk5a?=
 =?utf-8?B?OWFVNTYwV0llOEEyakF3ZElvMVJSa3RubWtBNEVZeUZQZ2JCQm5XQ2N5L3l2?=
 =?utf-8?B?U203TUdoWDBDZWtnN1BsWHlFWDhKRnRON3F6b3V6OFBxVDVBbEw2d3IxdXk4?=
 =?utf-8?B?WENwVlJtMHFLbXM0OWx0c3ArUlEvWloxUzk1U2Z2eERPVGxzbmNuRkpKMHJt?=
 =?utf-8?B?bHg0MWhmaDRMV3ZONlJNbGFTOXpaVFRZd292aHJuejhZQTVSR3ZVaFpGVTl1?=
 =?utf-8?B?TlA0Qmszb1NYSUhEalRsV0hiT21rUVYyVS9RU2Jsc2c5QkMzcS8vdWR3VGhv?=
 =?utf-8?B?OGJpNDI2TXJnOHg1SjdzTkhmenVBelcrNTBTL0xZRU96L3RoMDlEdVcyZ0F4?=
 =?utf-8?B?MDB1TjNuVGp0ZW8rVTJpRGRqTFFENlNpZFVNTld0dkxES0lWZ1JhbkxveVRa?=
 =?utf-8?B?UEFSaUVERVZydGxLR2o5NUdqclo2SjVRV2RyRWJaR3l0bUhycDQzVFAvZjhs?=
 =?utf-8?B?c0hjTkdxUFd0dWZ0OTVYMUpGSzlvbm5SU2JHbkpVS2pEUkUxUnhSTk56dGN3?=
 =?utf-8?B?d2c0OVBqQkxJTjlTekhGSGkwN2FaTTc5aEhhaEN3dGZhK3RtV05TSU5BK29l?=
 =?utf-8?B?TDYvNjJPZW5QSUtOanhpV0orSUx4VmFLY3NuR2tlek9SRGJSN0psZGlPQW9K?=
 =?utf-8?B?MFlCUFNnSi81TWlZSnMwSHNUbEZFb01FZ0hHUGVTZHBYMjMvcEdXUUJXSHRZ?=
 =?utf-8?B?bCtmd3J3U3pGbHZyMklIdUxwYVJzZVROeStxUURYOFlaa0xrR0hZdVM2dzdw?=
 =?utf-8?B?NUJiV09EUE52T2hsOTVlMUIzTElnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C272FC9C684F747AA31CF616951ABB1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zPzZu6Z06Jq0modP+FFMdhWajRpm1nXcGjj3Bj6/WFSQP2nJASLjDKL8CUhbCMvO8zhu7xK9g06T3j3rWESDAfreUJwfdVkW/tk4TBHu31i039mVfZZtC6n+TrpqA++eY/tAbZSPiTazE4FiGWCi5heti9t85THUxZMqZMB0SUonhMBK2S5Ox8RqklVVgJnrV+51qDCuTnp7xvy2C57lVNX6+1K+2qKeFCG+ASDDhoWt0l7Xm/RsAmHBenwfNqDsMP6BNxjZJA+XEJCVfaKOoymrk8Z5qeGzvOATCBaSwY2non0XMQHSjipku4fnFZKuzwLJxuDxUaDh7gwMo+Sh4yMReri1JfZ4TbmgsTIUIEHaMqpVX9HgrHR+HKt2623GBBoDLrjn0YZQSel1Qace7lMdHR5mFfxv+8OzwARPC2gduqqjTZekawDO4N/AJMmrJWnPwStoPaHEsm+FANvHGiihel3fYZVdJ0+Ce6a1L9jU8aNG8RBPhPUwERvlNQZdLFu11cY/TFzdA1qwMKJKK29iWEzl8IMX++myRusmMMNanTVPBHr71yi8PcbnEveQM6SptTr37XStUcOdBpFkH8ewgLoSrQ4EjQV0rxEAKcWDWui69ED7TTUEhRrfv4HFxZyF0toRJq/jLnw/kpNHwnFFBAcCpyc7Uz1VegRqiIZd0gRBK/TA3sJ9sYA6X0wm8BJuE6zj5yI0G5AbgqVQt/sVOMmOio2nYyosPcn+9T5L3QIdhvxEuCf6emVYejl+3Q5l3X3Vu9tV3K8AxKNbhH+MHLHA4fUqSaRDKYqXKwL6pVx6Ix4BitSWjPrSA+gO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da872d5d-c1ff-4542-bb41-08db2a0740f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 12:24:44.5990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qF0/VFhuTV84JgAzqQvPvSaHn1chS+VYbRPDOajtWNOqCHUS7PnT7RIpNBBv4hFyBPdeTVvRfNAP9lxDJ9gWg6Wts6FMV5feBlhtNxsmBvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7736
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
