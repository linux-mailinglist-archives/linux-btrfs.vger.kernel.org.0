Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317B160F485
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 12:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbiJ0KKr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 06:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235141AbiJ0KKn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 06:10:43 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB244B9AC
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 03:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666865441; x=1698401441;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=CBRlnKkFBSAeiBZSzwI2cx8v2m35WMyYnqKqaltnCoV+rAJKrvsMeUft
   jYtOV44DuVVrDK0lZ7cZosL2SD6q6XqxS4u5P25iTbzyuZEVuoFls6FjU
   siNZpBEqSXNHuZ16/6ORSVlXwGph6iL7khkwS+wcB36tU65XITIkhJ4si
   kqrctFe2Q1STyZi/zHAtmjxV1hKfZwrRdoHQMuqkwC0zqX/4SlLvzi6p5
   7zRNfXxNalK2muyAjSXch5RSFHJwiw2wjk0WqwHU/bp4l7wRBzHzZrDvL
   Kuy7LBvZ0NXI/5TXy+orm3fCX5gAEp3nrb/C4TLZOKERfbIBC7+B2c4tl
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,217,1661788800"; 
   d="scan'208";a="214862769"
Received: from mail-bn8nam04lp2045.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.45])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 18:10:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0D4TfoNp6yTurXzHIcTUHAFzyeigzOMnIG/+JJp6LCz3XgDx+16e3O79Zjm0N2rj0rVcCmAF4VUSBClJ9oj6VXtJIsQSmpmAEkSnNbC3D6ix0z0HLGXIxq01yUzKY/cDCU7zBE1FJbbPM8njmZZUWSKKLaHL+JldDxr5O9ulixrrG2Vx3J07Wb+atcuCUkuL3UlxJaSiBePIZXKipe84bJLeVxKcmomBH5wdNwhdQ9Sx5dRPb/lL2NSIzPfv+l1ZilgQVNHP4FzX/7fKZ61S1btX2tbn+F29X2u7zet+fWISFy4U7QzxuK78xZFenMIu23UyqmU6378Pi8Ix3Ma9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=fuX5pM7gHLcCKpitXpDVH8Oz7djuPHF9srsaYlvkch8mQNtm2fQHKNxQjua6ekdLzqd754KkNgC7g6m7YUk6wPS5FwQi9X/R4HzTGZU3TYmm9yRsdsJNOKo3+PHOHqedpvPtoVDA9PdDFM1gvxLj7c3wtTrXUIRZZgxGjD4p+n0rt0bcHT8wLvLhtXDZ31MHj434gtQ+FDstdJwpaUvz3+RXe3ba4ADFpVGbJYtsydovRA/dfRq+A7QyjmIcKWm28D25Ilvzo2yvKTg0nt5mNsuBqS5ySOoZWiyKFsYnd2/vopnDHDYFNMrY/Z8+/KUaKbSm2B27Rtelr1p8SpnUqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=UUPFz6VFvp2vVkXf2ttgXiUfyTt3RGZVU5MdziwkBtr/6+BfKx3HeWI2zzCHYGvjOwp12ALpk0FQKnN+Wx5GNmbARNcOdnmvdNBZeS0uHVzftS26FumGbvJ98OoY7pG+IvO9iGtQ1EUMHC8cDT13+wbs2dyXXhJYM0gkeB9dO/k=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB5758.namprd04.prod.outlook.com (2603:10b6:208:a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 10:10:36 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5723.041; Thu, 27 Oct 2022
 10:10:36 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 18/26] btrfs: move acl prototypes into acl.h
Thread-Topic: [PATCH 18/26] btrfs: move acl prototypes into acl.h
Thread-Index: AQHY6W7bACknVxqXk0yVQUZFydAOra4iBdgA
Date:   Thu, 27 Oct 2022 10:10:36 +0000
Message-ID: <785f95ea-8a65-37da-2176-8214b0943c17@wdc.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
 <dd1f77b68f21366e0898e4415588e7a97a12112e.1666811039.git.josef@toxicpanda.com>
In-Reply-To: <dd1f77b68f21366e0898e4415588e7a97a12112e.1666811039.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB5758:EE_
x-ms-office365-filtering-correlation-id: ac48f707-a75a-4f0b-c94b-08dab8037e3d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yJIC+CfpJz6Pb5LUOjXa05im8haAdShju2D1CP2DfYIrZ+/dRkncLdo0I8R8yZPzvK9dH6h0CNMr58tckUTd5NTDVtxs58v8HjEvvJhpgAXkK6+xNiq7ikOCPdEJ4Sv8VgprGp5kzGGi/utR77D2tEXgaiYXbZHNJSZyGiqZfF4hjKKSpPc1IGVTOWQJvcNDgsBkvx3ZOFJoloe9QORnnUbr9QQxKdgh416OvNB+k9WckGA3JTQ+LHZyBWa93R42mngKAet981T1edjzL19xMs9a/3PCPOatilj/syFgQprcOg+oavad/PeDKfQoGyNwSnJuBabt7mRsYXkCLC8ikcF0ewXEfL/UnfB8IW/Zn+Saqyzkf7KWbkgVEa9KuyVQVnWDx5wFLqGiM4S25G5mL2RNg6zA66Dm4THFNI8FwkaJNTketjIRskTRur+epI0YXic40zFuERk38AyPl6+dEAG0HknTnAQXTOgX6AAXXDQmvZGH75qlzz82B1utxTnDNnKpblxKv2ynBR0z22xMtULZvc+N73ZDIOM7JpUZ8AgrcyQOBvycVYhf3IWrnGf2EciviXj3vdlrT1zI1Odz0pFhRGEVMbUlqcy81MvUjrwjIUiPrP4qQ1rC68w5+H4/ZwXOd5ofTpTt1b8FR2OEfsRUngbJpeKJPe4MRrybBH2JBMKBAAG5bK2vjBoBv0IXLkrjTM7cYc/ebVsXb9yu+Re4XCX1IwWiwhGna2CM2BHAouFsTaSHMTBje9UH50OxXW/YMcSYB/JiNwKFE5PD8ds23FQNfxJWg2v6vpR0xY3U4tjBzNfdHRtJnX1qGirU4FrlnMXrPRgGQb9ahuhhjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199015)(41300700001)(122000001)(64756008)(8676002)(38100700002)(71200400001)(558084003)(110136005)(8936002)(66946007)(66556008)(2616005)(66476007)(91956017)(82960400001)(26005)(4270600006)(186003)(31696002)(5660300002)(6506007)(6512007)(478600001)(6486002)(316002)(38070700005)(86362001)(66446008)(36756003)(19618925003)(31686004)(76116006)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWZ3SERTRmlTcUhrb2lvd2Eza1ZVcWgzRlpSM2JhRFQvc1IxTmllaWVPU0ph?=
 =?utf-8?B?NXQzandYRDAwWXoyOFJwQU43TUlTNUlXTFJLeXkwK01wZFR6YmVzTUVWQ0d2?=
 =?utf-8?B?RlFkcXJkSVhwWlNMOXpVNHpPL0F6ZWlzcEVlay85Wml2UURRRkwzM0NmNmxW?=
 =?utf-8?B?d2RBNHhpRFg0aTBtZ0FXcTRPNjJxWVBTdDJSSUlCNlYvUTZhNVFiczUvamRv?=
 =?utf-8?B?aEZneWNHRmNDcmdyOUxEZEswNnhNZXppbHI1NENCd2JUbDVWdGR5dlU3Q25T?=
 =?utf-8?B?MllaQ3hVc1JvbGdjdHNRTCtQMXIwQ2FKMHROMGZrdDBXazkwQk1EUXgxdVY4?=
 =?utf-8?B?d09EbThSUHUvT3ZJbVBmQmlKZDBYb2FVWVduOGVGQyt6MUlGcnZLVGozRGFU?=
 =?utf-8?B?dEZsVjBCWTZSdUN4QXliV3pmQXMvL2gzU3h6QUEvK0xhenhhbGhVUmxubW56?=
 =?utf-8?B?NHhzQ3NETk5PeWVyQzdwR3RaeWxWbHlKbllrQ2FZMWhNeW0zWVd1KytqOVIx?=
 =?utf-8?B?Vzg1REFzSm1IQS9RYnlEYXFmSEhxSVViM25ST1NiY3hHTEx6Ykw4bCt5YjZL?=
 =?utf-8?B?eERKdTlNeVByY2FaSkxTRXZUTG9OK2M1eEJTY0VCZkxQK1MyQ2tFekFnTW8v?=
 =?utf-8?B?c3NEbXVLcjFNQWRScE5FQnYxUm1GcGZRaUI4QnBlNmRTZE45YTNhbFB4UXRy?=
 =?utf-8?B?b0M3UzdKTFV4aDh0ZjZMRkdBR0tiV0I5cTRwbXFvYVg1VWMrMlhhR1NRUTZS?=
 =?utf-8?B?bitKVk1adU5ML0p1ODZUMHo3dnlIdVlCa3Z6LytZM3NRM2tBbnFndy9aT1Ew?=
 =?utf-8?B?ODh6Skx4cHlDdTBSRzI4YURpUWZZT3lmMS84YmpZWGxxWUtNT2xrMDRTUmNy?=
 =?utf-8?B?bGJNZWhtRC9JTmdRdThKMUFpQjdHbVUxVFZ6YkN6TkZaZHN0bWlYK0dOQnZ3?=
 =?utf-8?B?UGc5VjFGM2VRcXNXSlFyakxVUW5wQzFINTlvVy9XRURUUlZkZ0JGMDBWZG4z?=
 =?utf-8?B?L3pEODkxTHZzc2N2RUk3MDRTcFNZMEljOW5RUnQwY2ZUUGJvbkdWNXhhVDJC?=
 =?utf-8?B?TlhZbE5jT2F5bXllWitRWWw3bWFSbTg1WG03cFRhVTFibUc4dS96K00ySWRy?=
 =?utf-8?B?dHdqY3RFWlZSZHNEOXdMRTRtTXVRZFlDcDhmMDRiV3NCTVJuejdHbGJlcFRv?=
 =?utf-8?B?eFl6OHlwVHY1N0dKTGIyZUZXZTlSUWcycG93OFdjNGZ2alMrRTZ3dUFDcm84?=
 =?utf-8?B?MmIwL2FmMFV3bkhvdFdjWmkzYkRKbStPaDJwbjg5bTRxWGtNSFp5aWVHZ0FC?=
 =?utf-8?B?WWpQTU5LQWZKNGo1L2NtR3EvSlVIcHVyY2gwRVpoU0x4ZUNaMHVpSER6YWhh?=
 =?utf-8?B?QkNYc1hkampNSk5CQU1WdVFxRXlNeTFWeS9OeStXakcwMVUrY3BWdkpvOStO?=
 =?utf-8?B?ZnFSSm50dnZENi9DMTNEc201clkzTGh6cG90TStraXRKOFEyUThONFFqaXlq?=
 =?utf-8?B?RXQzcTV0ZGNlRk9pZEhlbnVvRWo2MGMwSEFCMVZ4Wm1nY3Jma1F3TEJRQkJx?=
 =?utf-8?B?YndSMy9JK3dzZGRHNjVyU1IzalBCRkVUMGRCOHZLMDBYS0dsVFdpdDcrSGhr?=
 =?utf-8?B?UHNsVTFPTWFKSkRNL1QrWi9qNURBR0lsNnQ4NlY0emJ2RyszOEV0WlNMcTR3?=
 =?utf-8?B?R3JaT2dqSUk0b0VHb3RXcEpBdExWeXhDa3ZIM2hnTW1BZXE0UnBQV21aWXdP?=
 =?utf-8?B?ajE1NUxQdW9EMUQwRmE5MkhoRzQxV2YrSmI0RzdNTVJqaG1jWndjTXlYSkxP?=
 =?utf-8?B?ZHNHZXUwaHZHd1kraHdTc3VqWmNNdnRJWURxRkd1akF0OFJIajl2OFVNWEkw?=
 =?utf-8?B?emV6eFA3ZVlJcmh5M2p0czhSTTdHY2ZYckl1VGF3TXJLM1JLZXhzRXpwUUZ6?=
 =?utf-8?B?YTFzN2R2SmcyM3ZoN0FoV2RuZWJmQjZrUExIdm1HR2p6Q01pU293aTIwYS80?=
 =?utf-8?B?T0pFUDF6aDhrcjlnMExYL3RNMTlMMENoc0FqdnY0VVZsSkdUOThteTlhMEpZ?=
 =?utf-8?B?ZDRGY2c4VGFvQjd3bzFyZGQ0SU5hL1hKWnZ1QWp3RG5rc24zNjMrV24xWW1P?=
 =?utf-8?B?Wm4wUzJiRHhIQ2V5RUxFMStVdjQrUzEwai9HZVlXS0phTENhQWNWaUI5d0Y4?=
 =?utf-8?Q?eiNO5OHZ32vAdAGRp5Dswe8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EB1E26CC627F542A6461E1F31D2E9CE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac48f707-a75a-4f0b-c94b-08dab8037e3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 10:10:36.8727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OSR/sU2dkRK8jJdwQXmXjVocmbLEB66KnyA6H7paDqe0Hm1D2cpVNjmAdVCuusaiYMDrjeHXUqZks55fO7kKwPiZCh22gsNmn2TkEWLZWWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5758
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
