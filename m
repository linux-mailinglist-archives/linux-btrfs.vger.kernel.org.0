Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC17060F131
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 09:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbiJ0Hfa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 03:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbiJ0Hf2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 03:35:28 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431468C44C
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 00:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666856126; x=1698392126;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=AOSXB3iXPyX8pAeZwIIVi17gulWi9bX5QC9HkIDda94WEM3MJzuuq8x0
   gaeKKoRBg6HLjMBBKehPRylBkQTjcrdqsX9FaK5UNPgakcIVnr8B1zAJn
   it1L6tx3pvadTEuQiWldzeK6yOHUY1yWg5FtnDBrSNqjhdv71tNMik1Dm
   mlbCcpBPEK2Gbaa/3laF2Cw/ogxQkzuC2sTPiqL2ouHATQKelE0F7UOQj
   A44issbqGuvnCHtfqlO4ER7Wi+eO5KrYvxAmT0mQpm7Rx+5VIutVKMCaR
   TJEdSZ3yS+bdDxFGo4uFappHXGmsn8xnMq4xwBFbY0YGI0zEugvRehtXu
   g==;
X-IronPort-AV: E=Sophos;i="5.95,217,1661788800"; 
   d="scan'208";a="214852382"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 15:35:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9/b0kiaWNH6yIgPDTQBCjreoucACoXiYpvnfYH9NmfdIJQai0luWPj9BW2guOw5Ix1cCKPgyUPLT4ARYUWFe+tZXP8tHAB9tbAF4vJj49AlBJe2gHN1LNWcoXo/wMotQyzfUEOeiRrfiy0avpQRwxmmQAavi48Y+uYve5+QToLf+zjJd6XEmxEdxAzzGwt2YeTQIJDJW30zRErX+jvZiIrPIHnir/atjZI3hCIQQnrOzJIItEE+cMfMSaCk3ZfVdc6LesHv293M596PKbYGybjG/nmlbWwA7Os6EcGRhO2qruQNqnTc9QiZoAc7M033k5Ap+dvSK6lowTomP3znJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=OzdyCK9kD/SLIKBP/LQEwmVIxWEDyOZdwBarsezyIHTqScbmYSVI4w7DmNetN68rxKgEnWe7XEkbukkq9O9YN24LgtQsKsswV/NUBvUMEE6J2oWJ7FXgjcWyxQ9oCDZhiU+QJiAkQgg/Lc8a7BGImnKdCMqFI8vHqihyp7uCtuWlxLMk3Q6jqMZLhHiolRaLtskQfbt+qv6rKniFHvJKBOG/wnOkcUwWVOmMCmV7auJG+mf2yOBHQEnvpv4SCSqOTPPta1jXod4p/NqD6RP0G/uuMnoKYYAIGK4y3pspxPedcqqffrt1CHgt3/CekzdQ5hIvqHd9gAEits19RBpZSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=jtF+skFwYFfp2L/zeRP2rhlkrsagAN/LFH2kVPlNzpQKq8C9IgcvKXcK7LGjereEGGQblSo68wgKrcO2bw4YNa8MFuprYIV93s0Qwwvgzoq7rP2enuZn/P+qV3ZMEcg8wC+j7d6iwbdEZietxMMgEHtcMAK2WhdCxp05SzBs0q8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB8017.namprd04.prod.outlook.com (2603:10b6:610:fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 07:35:24 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5723.041; Thu, 27 Oct 2022
 07:35:24 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 12/26] btrfs: move file-item prototypes into their own
 header
Thread-Topic: [PATCH 12/26] btrfs: move file-item prototypes into their own
 header
Thread-Index: AQHY6W7qB+Y7vCzA/kOqU6xOBrDmu64h2nqA
Date:   Thu, 27 Oct 2022 07:35:24 +0000
Message-ID: <64043c4c-ae4d-aab3-36be-8741006cbb91@wdc.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
 <4555d2f953254bc66af9e1a10183384c4b48b30f.1666811039.git.josef@toxicpanda.com>
In-Reply-To: <4555d2f953254bc66af9e1a10183384c4b48b30f.1666811039.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB8017:EE_
x-ms-office365-filtering-correlation-id: 1879da6d-5574-4651-1531-08dab7edcfa2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eDa3iWfDlQ3V5WVvPMb2gEVsx71aPtmUdhQQKpClX4b1w0Kkcy/CYb3fwnbm+AO/gYjR3ys/OHzzO+XjwijTCraz8pkEWormLI0yN7W8D802wBQlNDrHok3oO5eMndzRlabS4s6lEX61BPBYr4k5/UN9Xc1hXAwxL5y9Vr1jEx+GuOMwgmarCwquWxsL8c4Q1x96viT9S8muWZGaxoEvL+d+2H34PG6cRroRNTUh1d5UVqdluVXuudiYUdx3bSzXg0ibRxzSvH4sStEtw7AL7+TKqomqb2rrR3c7e9o4Mai7oyC8YWcWlQCm5Z8T3rZUc3TkKn60t4R0t82/Xj/uyi9DdJsBKRVoKL0VXlpCL7ytQ4gqiP2pWABpYPDzvb0SGvbF5ONkv00G37coRFoxWUUKGo8+Hy9xezujoOYHF487CMttOxrriSDbuVn3afKG/Q4UBiYPD5d6R6GMZsWUrSHpA0lqzYc4Hm2rc5wq5N81MsnEV7M9yCqZ8tPYOSoaQrzCt6eYEvij9rer0qngy7w/picsYd+X14iz9ap7C1y0SGtHxDfYxaw3nadqhf0gyyn7nqrG/6J+QsdvtMSNQNw/ZU32bFTyGqp8csGW6ooAtsIdwX/wKLnM6nx543hmqbY5Pkqh0PfxOmsnRcbGEJNxseO/bP3EVf9inZfLW84MpWJN/BfbugNl7xDaarvp3g+c6u80krhPkDXzoCb+SvF4Tim8JQt9srkMcyjd3MVlUz4rLRo5JQxzcKqsRnQmlk0HvjTFn7sXiT/SUcPBl96Z7Wa7ic+z619xzaOZT0Q5ZNM0dkN711z2B3u6ArPGTd7SXB16OCe3G0kGNB9LPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199015)(558084003)(122000001)(4270600006)(86362001)(38070700005)(31696002)(71200400001)(110136005)(38100700002)(82960400001)(316002)(2906002)(19618925003)(66446008)(5660300002)(8676002)(76116006)(186003)(66556008)(8936002)(66946007)(91956017)(66476007)(41300700001)(64756008)(2616005)(6512007)(478600001)(6486002)(6506007)(26005)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3dMR25EdzVxWlA0TDBISWZQN3Z2UU55Qk95aXovK2owM1RxY21NazZkNWNV?=
 =?utf-8?B?cVQyL211ZWZxMFhOeElHUUhMVFVYK2krWHpnTWQxc3E2eUxLZ1NVbnMyNW5F?=
 =?utf-8?B?VEFVOEI1UnVzU1hwZVZrMGJacThwVXJqanBCUXdGckRRRGZBMVczeU5QL3FN?=
 =?utf-8?B?M2x4ZGZObkdzUiswdlRXaENlRWtPa05Sd3owWXNJMDYrZUQ3NmlWS2pNRldD?=
 =?utf-8?B?akhYWVVraU11ZEkzY0ovQ2RCaklEYmlkczNQb001MTBHdHQ1cUpUKzF6T0lr?=
 =?utf-8?B?SmVhTVM1RVhiWFlQbHVIRUlCK0lnbWNOVU9SZmdydzVIaituVFNqdXBmMWxT?=
 =?utf-8?B?Y1Q0WVkvbEJJSXB3QUxnbWFISkU0eVJEY2dIL1hpQ09rcnYweGJtSm9DdnA5?=
 =?utf-8?B?SkxXSFpsUHVkeWE1R1JSUUdBZEdJaWR5czc1L0tUb0ZiTnJSaFVBaElEdDJV?=
 =?utf-8?B?T25BK014bzY3enZWQVVSNjJQZVpCWS84VWd1S2FMcG5yT0M2dmw2UUlOSkhk?=
 =?utf-8?B?MEhHUUxtZHNsSVJXNFBKUVpZM3psZEpJWm4vSmtWM0dGaEx6L3FyZFFmcjBO?=
 =?utf-8?B?MjhUeXR5UWdrVjZUMVUwT3VXSkZxSEZ0Ynl4SDBURXhqN0R6SlE4NDgrL0Q5?=
 =?utf-8?B?QzhCMmh1clhWSHVkRjc3ZnpwS0hVQ2JFekxYTDU1dWQ1WS9rMDdIL2Z0RkRl?=
 =?utf-8?B?MTd5dGFOTTRWV2NJeUJRQldreS9ZcHRsNWpQbThsMC9zOFJqUlZjYXZYM3RR?=
 =?utf-8?B?aEdvZFNiQkNLMjJvdzIzQ0MxL1FqWTVCcmlNOUE1UHR1cUFPaEF0SDQvQ3Z4?=
 =?utf-8?B?UG81RzBwTjB4UzBEWmlhT0xja0VWNUxSakwzSE00WXV6UTMxRG8zYUJkUWsw?=
 =?utf-8?B?NWFxa0l5YUV0MVlPUUtoY3RGaFJaTjY4MXRxUFBPeDhSaklPU2FMa25VT0tD?=
 =?utf-8?B?UWdCc1psS1EwUlNIS0ZJYlEwS3p6eCtGYjEzU3psT3ZEQnNpV3BycGloM2ZX?=
 =?utf-8?B?S201ODdMczhQd2ZRV2NLUEM4dm5IYkowU3NldFVVUytyNlJwbk53NFgydkFI?=
 =?utf-8?B?NnRVU0xVUWpJNTJ4ZTVTVndjL3dkRGkrUkU2bkp1bnBBK3kzRW1YWXZZazUr?=
 =?utf-8?B?VlIzQTNTSmRyb0tvZytLbndwNk9STUFHQjBTUWY5d0J3ZE14eGMySDd4dEx2?=
 =?utf-8?B?bFJVK3BNYW50R094S0lQUTd4RGdMc1ZwNURKN2pYMmpFbkt5VmlFZmgxbk8r?=
 =?utf-8?B?YWY1bXpXaEkrcjZGZllzbWMzclBtT0lBNW91YW9aMHQyOWpDQzhrL2t1Ri9Q?=
 =?utf-8?B?YzBaOVZENzQreEFrckU5enQ4Q1ozUjRRbzhmUFc3Wk5FRlhWVytXNGRwMmly?=
 =?utf-8?B?bUd6Z0lTT2FUQ0JyNEw4ZHZwdXRiSkRsODlBOVhLUjlvQ1NGMG4zbThUSTJL?=
 =?utf-8?B?RXVhb3JsT0FkY2I4MXNBTHhwcDRSTVdXb0gyb0lpV2FmNUpzem45RCszaEtU?=
 =?utf-8?B?d1hQanR1SERLK3dlNWpZekNOVCt0YStkL1UrbURROG1ZR2ZLODFZMS9JQndS?=
 =?utf-8?B?S0ZaOVR1V3NONG9wZHAydnpwMTJiYmZZQ3dUdkpLV0VSdkorVjNXaTJHVmtS?=
 =?utf-8?B?TkRsQnYraUJDdUFhRld0eHZwMFQ0eVFrdnV5SWRNRVMvajdkNzNZOG41R3o5?=
 =?utf-8?B?UzJtNjVqM05aelNtZUdTaHRIa1JTVDJvQVJHRG92N3Fyc0xSMXJoMm05aG9Z?=
 =?utf-8?B?MjNtdGVHUlJaMHJzY1ppQnJYMkNaVzNGNWVMa1E3YVpUUHk1QzUySnhZWUpi?=
 =?utf-8?B?WE9TZmdtREI5bzZFT1dIeGZZbkJvQVByc08xTG83OGN0WGVFd05nNGlzUnJo?=
 =?utf-8?B?RDFrVVFzSitCT3BlTFZ1TSt4eTBxTkpXUFpHTUlxQ2hyblR1Rms2V1dOTHZt?=
 =?utf-8?B?WmdwOG9JTUU1NFU4UVBxNkRudElNZWhuS2xBaGhISTVzQ1ZHTzNzTzN0VWlt?=
 =?utf-8?B?d1dPUVoxaGllc0dNTGFPNG5SVG5vTTRlUjhWRHB6ZXJoOWVIZFZQSnZvSmxK?=
 =?utf-8?B?UktTakh5VW92U3RtVlorUHR1Y2xEMjdVVkN2SklUbGRKL3hsTUczcm5FVlB6?=
 =?utf-8?B?d2tzeHM1dnpoOFlGVXE1dkVFSkdIQWdIU3hCOHloMEI3Mk13cXkzUmVtV0NU?=
 =?utf-8?Q?3aIoXD2qgDMi9qEBUBqHaTY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FC0B72A98F3E5478F5F3F9163412164@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1879da6d-5574-4651-1531-08dab7edcfa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 07:35:24.4360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lLZERTAZvDk2G5tApYw+ZDTxJYEDaQS+zDz6l/L/JvXMHi4zKyjD/YEyBUJSEcbZBVGu/5CIz99ny38abWJJYVRESB4lb4U0dOUx0kGk+JU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8017
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
