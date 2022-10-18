Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD009602C88
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 15:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiJRNLM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 09:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJRNLK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 09:11:10 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B3436406
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 06:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666098669; x=1697634669;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=aek5uau1hVhynW6kpyO/9GeLAEWuNn28BkxRepVUDLlBHnDk+X33mAfp
   x8Wp76cZSHUyyDoke+Jwdvl8fhL66JbPTyhUrdmTs+uO3DiDGxcu14jxP
   tqVxpOiA0ecI/ydd1xaNlHRw3cDi8ilDHFdhxHdOEWSa2W26lTqABYydG
   gWXfVp+1XhhKSux+iiUtR6tuEJQKcMh4h5Xyvbe0vbXRwu7kukMsUn7i7
   pkRptl3aABVSO2b8vzblUpNxLW+ePZeozlKH1nvCjE8PT0/gr+Vcct9r0
   o8fuR1nbtOZ4dBDpWU7yScumng5n1jVRaaAlfBs/AHvu9IvLiep16HL8S
   A==;
X-IronPort-AV: E=Sophos;i="5.95,193,1661788800"; 
   d="scan'208";a="318443805"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 18 Oct 2022 21:11:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0oveu9lIGN34sLwTL4H9DmwL6gBDS8sS1jJBs3oCL7gnwWvaTCDXc1N9FIY1cW5AHl/zBT6x0UnmMVOrl/Le1DF3OkkVbm+B0FgX24NatWDkFcANscwuVOIvIRlbY7sIh5KcBQOrqdqgowhWaeQKPoLEFi0sgUTBBm7tPr1lVMwLhtXLVH5iHx4DIk+omacdjYfFDSuBjJTYjk6t0NiQFFgpxhageu/Aoj2vsXWnIRx6bC1urofOJAYI1Z055nsNy4s9nzlDxjAOPBgi8waF+CVo+RF3mI664gBhJAv4SGaCHtDMPqPXcDxN+z1FXN3Nb3H0OsjDbMQPo5EEft6Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=D5e/p9gh7Ljz3M+z5MU+ScSc753oE5D5tAWWOmHQSED7UvhVJxHVt0NGWwFA9O/f0k/j0cCmLU9wP03oyXAKIQdHjO445lAeyLn7kDBVt6LFYt9MVi95z00WcDjkIRaH/YzEr5CaUZ61jNp5AnAbONOEX+d2DWGRjyn/vZBVQaD1Zu8GIC3KHe8/eYFbyWZZJDK8CqJ38xDV4+Ev1rYaVaHtDWY1hTcKBZUr2sg4Afp+sFmWo+5Z0Ufd+dL4TuLiNs6654W3GsDkM8sGDPftmecJ+ptYrZQpjiuEikaMI+9FF7wA+Oo+L9PjVW0fEycPUm+2kTAYL/o4SpSCveO9cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=jHmnvK/2UiPTkT9XZxBL8L08RAyRqL3eeH/XIJvL4i6sVy2KXWbZ1Uv05I6lv0NLYNCVWgVAHfdfFykS7FmyJHKRbck9BBoC0r8Mn2ed2FztjhYqnv2EO/UWgJlljK1Ea+OcfVzR7i4ir0+FXE8S9anhwRWyXPbDMkCdAWpBpm8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB5635.namprd04.prod.outlook.com (2603:10b6:408:73::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 18 Oct
 2022 13:10:49 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff%5]) with mapi id 15.20.5723.034; Tue, 18 Oct 2022
 13:10:49 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 12/16] btrfs: move the compat/incompat flag masks to
 fs.h
Thread-Topic: [PATCH v2 12/16] btrfs: move the compat/incompat flag masks to
 fs.h
Thread-Index: AQHY4lwP8qTCHO1/BEuBFxG7hT+58q4UIVsA
Date:   Tue, 18 Oct 2022 13:10:48 +0000
Message-ID: <8159ef2e-9064-1fcf-c451-e7027991e6f9@wdc.com>
References: <cover.1666033501.git.josef@toxicpanda.com>
 <f76e2c61818dfebb58f26d3acd15b381619350e8.1666033501.git.josef@toxicpanda.com>
In-Reply-To: <f76e2c61818dfebb58f26d3acd15b381619350e8.1666033501.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN8PR04MB5635:EE_
x-ms-office365-filtering-correlation-id: 8dbf1df4-f110-4ce5-5287-08dab10a2d14
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y5+iacfcxsVJh+YpudShS8DqLZHsgTb14V94UftBX0beFz3kMkF6r/MrMOGeFbYIQYzLjYVEtudFNVjtwZuULPtMad9J8igZI31IA3SNoB3/zmB6jTHjexCxgPv2DXbX7EGeocC9MDvaP8qJKZOkuHLPAYDbHKz0k7ToGigd/ZD6IHZT8boRzTPbrsMDOPv8eF+6iijiztFVJzJb3IX4Lf4P/o1mxpRqklxQOPBqLISJ8AB+dpYs17fwtcuC8v97MDI60wqHaCBeAq8gE0zFmRESGSlagxmI55y97Fo2F28W5W/AG1z96kyGpY8F7S8+mCyfXI/iz1FCm9YTBIqKpuS0Qf6fpuEt48sjnbRM4HwTlOPSiWAoo8qkvIxgzJRyJHRpLRWxA3bn9p4KyXoPUCV4Vzcd1oLBharnriPtytFW4Bxtplxk3Yd4Zc/6X8KYq/sqC73RAdkQ/wVtAEIelbJSOtWMRoq3QIn+g+Jh/85IBmA7eXVbvBumf5ZnbLvbFxGUJvQ8LlQBn3LBhmkm4vqgP88tK+hx/ca+X2NTvIou9n5OKBs3i7guAZ0EnNpMWOtRyzRvBuHmu4E99dCAUJhQS1XQ8LCXAt5EoCdLhfIohTmU76+6ABIgCWYBl+NEF0zSKMN8Rz/x3VI8ubQGELtvvh0fnHN6XU+Dy9tdRmLs9YKA6Kk3ncEx9QbgxizsMHzvOmumgPPuO1skUr/SrRWY19xhd4s5npmz+1LVoZltP5QTFaMvopH5qZjuDORUy9IqdpCm99ECbT49M43MWeayxeqDe1h83sp3zqttXohYd+BVDQnocALko1lJXhvoo1BWeQ+WMn2S9c7Z5iHmWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199015)(8936002)(26005)(38070700005)(8676002)(6512007)(2906002)(6506007)(38100700002)(5660300002)(4270600006)(2616005)(19618925003)(36756003)(122000001)(71200400001)(316002)(6486002)(478600001)(76116006)(41300700001)(64756008)(66476007)(86362001)(110136005)(31686004)(186003)(31696002)(82960400001)(558084003)(91956017)(66946007)(66556008)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekYyU0YrWThOT283aEtUSUsvbk9wQ3VwM3dZc0dXNUlnd3djaU9vRGpQY1RU?=
 =?utf-8?B?c1o5ZUp6dUg4VWt1L1REbitJd0tCL3pzNWdqUEhnQ0R2R3RGNzVIenBrN3Q3?=
 =?utf-8?B?L3FQNm9nKzl4MitLbnVLQWIwckJXS2JnWSt5RUl3RC9mcmpsS3dNaHNheFly?=
 =?utf-8?B?d0gxa1FjSjBQb0J0U3VrWFRoYW5BVnh0TXlWNGgrTk5JWVB2SFRuUThHUHIz?=
 =?utf-8?B?Q2RCUjJiNTRSeDJLdU1ER2dwblZyV3psU2FJQW9EODY3c3F4a251dDNxWGZx?=
 =?utf-8?B?a0UrK1ZSQW1HbEsvMVlxZlNVUE9md004QzdLNTYwUFVUTjNjYzF2Q29lKzVU?=
 =?utf-8?B?S3VtQmtZb3JydmdJSko3MWtwMFVxb3VRR2RQMkdialFEald3V0lvZW1wK2M5?=
 =?utf-8?B?NHBjbGJ5YmlicjdOR1BRdmx2ZDhxVjE3aUVTVGRiQnJVeVo3dHhPaFRONllG?=
 =?utf-8?B?bWxnNTJOeHlaY1hmRDloZXV6SzZobFp2eCtTZENkVWN5cjBSUUpoYU42MEdt?=
 =?utf-8?B?UzhYbXdzeWxrNEVDVnl3TTlDcW5XNktydllFY2lOU1kvT0FRcjdXNG5OMVpy?=
 =?utf-8?B?enRqODFqcDZQMW8xVVl1Yzg0K3RHaktZWEYxT0svV2hIRVF4WW5iSGpJdVNP?=
 =?utf-8?B?SWN3TU5UODhmNU1YdFFueUFGdmZZNVhLRys0M0Z0VjlyRmN6YlEyYitJMTBD?=
 =?utf-8?B?TDFGSk9pZ0d4TWk2MkVGYmRaMEJlSFFxdXBvaUp2eVNoUFJGNC9xV1pweFlJ?=
 =?utf-8?B?RkxVVWpJa1FBZUM4c1dwL3ExMnV2U3B2bmY0Z2s3enZDK3dMWXVtVU42QTFL?=
 =?utf-8?B?aDhTYXM2Y3p5cHpsV2k1cytuRmQzeXh1akpMNURKUnhtUndjYjVLcTVuUUVR?=
 =?utf-8?B?NkRjdWMxUTNzczIreUx1NTNKMjFLM1owNEpnQW1WYk54ZDA0YTNtUW1aS0Vv?=
 =?utf-8?B?NE12a2VXMndwQ1AyaHZmY25MSFQvWFRwTS9WdTI4aWs4NnE1Z0hrR2VqUVJi?=
 =?utf-8?B?U3FTT1U3S2lWTnhoUFVZT0licmdrRTNhcDVXZzRoUGhuek03MExDOWdpTUdD?=
 =?utf-8?B?QURlZ3g0cE8wTEhSbFhabnJWZzM4ZDQ1cFFSQzJDWHpIMFVGRGd0SFllTDRM?=
 =?utf-8?B?VWFKNy9FcUtWY3BNUHpsV2ErSnluVHd5N21WK2EvWEdGRENPbWplSk9qaVBF?=
 =?utf-8?B?QlNLdXFnQmlWanZDWkIrOHZGdWREc3hOVTlnMDlMcnNDaXYva3Y4dll2clJG?=
 =?utf-8?B?ZTlsK29ycFpWcTF6dVZMK1FBeHluQytlUTR4dVF5UnB4eDdMV0xjRWtRRDBw?=
 =?utf-8?B?Z3ZLUTRnZGR4ODBCSzlVdmZUd0xEWSs5aDN0N05XUnNEUUs0Mkd5VkpyMm1u?=
 =?utf-8?B?aXF5end4d1lMSjBwZzRCdDI5V3ZkTnNTb1BKSzg3cCtDY21lRHZnVVVHL2dq?=
 =?utf-8?B?bEdiL0ZBbEQ3RE1uYnJDRHVUdjJNakRTYlJKVkw2K085RGFscmVQVndBcE1m?=
 =?utf-8?B?YTdob2J0cStCL3lkcENzTzJ5dUt6UXdhR01SR3hEdWx1aXQ2QzA2Z083UWpa?=
 =?utf-8?B?MXVFTXJLaE9QZEp4ZmlDak55R0lmb0t0Tkc1NHNGaTBhdmlOR25DRWc0UTZi?=
 =?utf-8?B?dklRKzBnZ0FmaDkxemV1STY0ZGxLUHNMWmM1TEFoVjRGRnAzbGY5WlFjdGFn?=
 =?utf-8?B?VUtLcXlrQWw1MnF6eWd3djhyR1RkOW5tNnUwUFNPUnludEYvL0JXRS80WWk2?=
 =?utf-8?B?YzhiU3lNamlyVDF1YW1kajAzTmcrN1h3L1c3eUE5amZhTDJQUWpVVHpodFVh?=
 =?utf-8?B?UUR0VmdJMUF5OG5GK1RNSDJPUm5SMEI3a3g3Y3YxaHRBZkR4bzlZNHhQQVk5?=
 =?utf-8?B?VngxcVdXZVhKVmhSRkNxVCtBK1RUUDJHazZDSjdUTHVCeUFnU1hBNXJ0WkJC?=
 =?utf-8?B?UlZUT245VWwrUEJxektGY241UElxME9HMnBxdXlTSW0yNk5DTDBnTzRqK1U4?=
 =?utf-8?B?QVd5ZEx2RklKWmFDUnNwVVFVUThLZVVZeGlENFB3ajlsUE9xSjZLNjBQK01w?=
 =?utf-8?B?ZGtUSC94SDU3QzlKbDFxWU5UVHp4RnRaZkMrd1ZKYUcwakZ6N1V6NndlUUdh?=
 =?utf-8?B?anNoY3ZTbXVTbWFLRmpsQWpWMWp3SmJvVjJFM1RvU2VZR28wZ3dBQTZXRnFq?=
 =?utf-8?Q?sHUPD7CIJWKg/TRnGMUs6Pk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C85D65A27186E74EB1B5D8271ECCF47B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dbf1df4-f110-4ce5-5287-08dab10a2d14
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 13:10:48.7779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JQx1ti/pQAA23N3/iLj8NeAV7jgkaby9dc0NmXYNr1GFiMOkz5L4hOpaXjabycj7IRGyFZdqfrPQuH0hpHBv8clYXc9qD3dwYuXLFaL6Bmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5635
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
