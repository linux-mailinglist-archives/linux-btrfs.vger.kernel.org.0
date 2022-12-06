Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D15643E06
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Dec 2022 09:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiLFIEG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Dec 2022 03:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLFIEF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Dec 2022 03:04:05 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716FC15FF7
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 00:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670313844; x=1701849844;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=cuCt19tHotBnxNqc6Hh+L5xuJoTwDXtwQ0+M1LpTo4iDq16njr43cxGJ
   ofTo1Pz9FxhQR8Jd36dS5NCVAz9ztFLVw76CsfLkZhXouZkQ1fbr6Xatw
   lwXDiqqUXEM+G4pFN58E5dS5iynvneMIIceVSSsdTkYhIsqvY+Y6yYlA1
   9aVClPgrBCHhEr+86AxNRRqH8+RM26WmniwG0JuSAXTOrr2EBoUFcvPpG
   fqTuao43LY3Vhz/PBjZCemp4SZGMuC4E+2+UICw/Kbjez+lIKSXM8Fvbh
   5p6Pltr7fHUPTV3Qt5mJi/Wrgs6KqHOWQQAt8kaC9SFUSANnkFmyOzniy
   g==;
X-IronPort-AV: E=Sophos;i="5.96,220,1665417600"; 
   d="scan'208";a="330084491"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2022 16:04:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGX4Cs8JtBRHX5admVlT8LjJ46gnAElBwa+i/C6XvwcxSLsEhN3z464RNBLpV+ImiflyI+u2zhAqbkDsxsiCucxkdHlmED9DjZq0ZzzJ5O/7vd6GNAAlZxLvZH2/iT3zxuwSciQmmGnINTw6GbQiEQUATFIh6OtMSChJEXY+WJhNBTA0bZrhYeBqYkHzjn5mtSvV0Df5fsa5lapbChm36haAorHZ4MLOkLM0ZrmCmRXu/UWb4F/yhjiL2USob6PeWvbB3pyJJgMB74b8OKzHN/rIXoc3RqwgGVmUa/IX1juBylS6wVDrpVLd2xb4Qy6Wo1Y6JcxEa9eB0iCB0FO4fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=MD07CFMGVskXgq5w1wakA86n+PgP55Y2Wg97Bsfx47VL3l7iCLNQZq291My7n36iM+PVfcX+x2Ol6tDxZH5BeRoIuX5Riis8GHGQzsen/HO2XltZjK15NtlFEIC5IS+PUrXhN2klIc1V3gaC7BBgoRsvxVImedWQhmoHcGuIFSSO6xhJM0hSVlvQqtTY4arh4ZZlHSwwaVVdwPnTBj6Jzq7S7QL2mp0+iVCXP0n1VMUkI6l345RWb+wphQ2/ejgqntuVFo1w3S4xBsIj5IS4tyhEhVTA+PpJveZQL3Tt57rGHUhy/RJ9i/9uQz3HnpCtUNnoIKGKBiFNQa1FkLHUAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=MccdegQsLQV52BjgOskCXjgeqWoMqzBeU6qKf79Tj8HrYgKZtVDW0AJrdgv2yx/ztV2CWtFGf60mNP73VjC3iw9WvXacK2KgEURWiiDVUCEp9kvAGzWnNwbIf4i7PzavOOuTFkgAjdbr5WUdcMtPVZuNSK7+smyJzyZWFpWp8w4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7717.namprd04.prod.outlook.com (2603:10b6:510:4d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 08:04:02 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81b2:90e4:d6ec:d0c6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81b2:90e4:d6ec:d0c6%5]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 08:04:02 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] btrfs: remove level argument from btrfs_set_block_flags
Thread-Topic: [PATCH] btrfs: remove level argument from btrfs_set_block_flags
Thread-Index: AQHZCOoVy0tamukQ4EiPnagKl00GVK5ggMWA
Date:   Tue, 6 Dec 2022 08:04:02 +0000
Message-ID: <7320a8ac-c6dd-7007-0617-2a8b0d77b66b@wdc.com>
References: <720307086390595732e0265afc5ffb2da80f632f.1670272901.git.josef@toxicpanda.com>
In-Reply-To: <720307086390595732e0265afc5ffb2da80f632f.1670272901.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7717:EE_
x-ms-office365-filtering-correlation-id: f778b147-0853-4bd9-9f00-08dad760700d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ksNAQZV7viDtWlMUrCnC0gXwm7WoX/xyTSRRAad5Ptg1b7AAP84lrHuZ29fohrIARZBRPTnnQpzwgdzBmF7h7UZkwjJ7K/yQp6soYmgR9st+sbIIk62IgdLu25e7jEEwu135i4MAM1iqwmJvDUHcNwuuFUk3Mvo4GyRMlv9nnJWUOGSaMnnI2flliVV3ET/JbDLZ7Ho3GS9hZKRX5gwcX8sicOx+s+YHMP8c7xZhdiLBCpZ16D2vZnBDe7RVnH85VRQCp8bVoVHbYlwVDvvlt4G09kVuTG4GU8/uaxuCevfmVWJyU+IqJp9/J3Rl4r7RIbLkAuldHDsE1sGimODVJLagbZYCQlIXXI/nyFTwcZM1uv6JIX6LCu0EMinCj+3AU+zxOk/SovthhbPXmetfYBFCcVj4mRSuV/vsTuQ6COgdZfedCLEaw0EelVlB4PHgxAQcNMCG1aQqd4R8fPf+a/OEy2qg5PeUphqxpvOM2i6QyWq3sJQt1FUN8VlZuQS+SBCbH6KgPHq8sib5xcmD0juFUP8azdhivLpltabhqXf08iZyAb+bX5EubN6ct5XU+b4yLzBVGse5qD+DWsaPtoc0Xo7dFEW/ctQbK0i9Aj3SZcNQxswI37roQ2zYlMv9Tu1bkkTy7/UgAJOSe2o+KHkk+sYwbK+Isd2NiFnmS40POMq6kM51jxzLefC9XtWa1pnVWV1HZGHUBdRlhNVRwJEblF8iZ0mTej97ErLmSaQ2a6OD/64IJVnyfrndRoxnFAA80MoUEMIRMNcJsyvTBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199015)(6506007)(558084003)(6486002)(478600001)(71200400001)(36756003)(2616005)(64756008)(8676002)(8936002)(91956017)(66556008)(66446008)(122000001)(66946007)(66476007)(76116006)(5660300002)(186003)(2906002)(19618925003)(41300700001)(6512007)(110136005)(4270600006)(31696002)(86362001)(38100700002)(82960400001)(316002)(38070700005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTlXc0txN2pLODZFaG41c3V0ay9Qa0Z1bmVHUVhBTHE4Q2lNVE1rNUxLSnE4?=
 =?utf-8?B?SllWWHlIYXAyMi9xYlFNNndvdlJZOTREbEd2WGUxVUdxWXFpZ2ZwbDdRZzUw?=
 =?utf-8?B?bTdhNU9vRUdLVVRVRkkrbHcwTlBMWlNGSGFEME1mN2VnMWtnVk1UazF4Qi9s?=
 =?utf-8?B?eEpFSlRad0dWWWVzZlVGWXpQcTZNZnd3T0pWeTdTUUdnUWhQRkN2M1FGQkFB?=
 =?utf-8?B?dkhQWitwL2VUK1FGWGx4OW10dTY3Q3hoN3ZveUl5Y3N5RTJ4cHA2cFJqL0lh?=
 =?utf-8?B?WHNMaGxQZFZ4WUhpUFRmRWF0UVFHamw2Y3ZiR1ZTVm9MVFZ6REV1ZFBNaC90?=
 =?utf-8?B?aE9kZCtZV0o3ZjZwMmZuazRSTlJScS9IZXpmVkdhaFpQUUlXZEw5VXJZaC9j?=
 =?utf-8?B?T2xZWVlBY1hKMHpaY1JSTFY2MFBmdmNxbEJxVHVvZzZuYXNyR1BycTI2ZFNx?=
 =?utf-8?B?V1A1eHpabk5jdUduVjJoK1ArQ1dscitKN0ducHNqQ3JiamV0UlZ1TStOZDJ4?=
 =?utf-8?B?VEl5N0ZGRlg5MmhtcFBKK3VFSkViMHZqV3JXWHJKL2RsUHFwMko2OGMyM2U0?=
 =?utf-8?B?U2txYUtOOUpYeWt4ZnpxK0Vmc1Q0VktTTnVhOVEwNytiMjhqNUhhYWszalZJ?=
 =?utf-8?B?STZpNWRqZzNpMVR2am5ESENaQmtQZmhLUU9jQytrTzV2bnFhb2lnTFFJdGZV?=
 =?utf-8?B?aWhvSDluV1pFMHlDbnFtemNNbmlZSllvMXZCaHY5aHN5SkNDcnAyR2ZpNHdY?=
 =?utf-8?B?T0RiZWZGNVpSbkw5dHZzMjhJczBWNWtBTHM3MFlJREdMMUdNVjZvS1FuQXRI?=
 =?utf-8?B?KytMMDl6dlNmYWhDMFVHaXk0OGMvUlJETVgxbTVRWVRwRmVKeTJaaWgxN1Fk?=
 =?utf-8?B?UzkxcWJ1NDNYTjNqNlZqQmk4UG9qQUJMYUxJT25KRy84a2V0UkxpMi9iblMy?=
 =?utf-8?B?ZGJhTWlOT212WmlmOGpJdzZ5WnFob2gzUDJjNVNEckt4U3VRNWw4UlBLS2Jp?=
 =?utf-8?B?K213dW5NclBiUTdOK3EyN1ZRWEwzNlZ6V29IZThEM3ZSTTU2bmxKWnF3cUNT?=
 =?utf-8?B?T0Y2RGhiS1JIeEFLYjdXUS9HSDF5Q3VvaGIxcXBKQ0cxVFZkRmFGS1A1Qklo?=
 =?utf-8?B?MUlrM2cvVVFEeGQ0SGdXeUdtNGRtc1NrbGZXT2V0R0ZWOHlLSG1ybFBSQTM5?=
 =?utf-8?B?NnlhVURwaXdvU2RLSHlrdE8xdkpPTWZjdXRzUVAwNTl6TVByQkM0SjR6QXl5?=
 =?utf-8?B?YS9SeGRKUzMvcXZob21oTVRmK0ZpMEFxNzAveGpZSE01OWtJRUx5ZHN4WW9a?=
 =?utf-8?B?L09Yak9IY25ZZlM0L3FXUis2alVlQ1A1cS94ZHFrekV2UzMvR3NyaVVFb0hp?=
 =?utf-8?B?aThNYTF4VXJoekdJM210cjlvQ2x4Z3Q2R205N09qZ0w3SFhObmlHT1BoWDhZ?=
 =?utf-8?B?cGpQVWVkNnpNR0NYenlPLzhVMFByQWRiUSs1QnJ4NHlSbExXc2VGUXpKeXgr?=
 =?utf-8?B?U0d3SnZJdEQ1R2h5bXVOeVFHSVRuNlJJWG5mdFhzdFFhOCtvd2lnck8ybkNl?=
 =?utf-8?B?WE44ZmRHbDRLaktyMFJLR3ExcFgyYVhYOG5vVFk2TGhRYmZFY0w1eCtpdWNZ?=
 =?utf-8?B?dHRqSmYvWElJWXlDYmhXdE14MDNDNUtlbk13aGlaQloxUzRGUS8yUDg4czNY?=
 =?utf-8?B?WUdNWGpGQkNJd0lWVVdjcGZLdFpOdk50dmhwZmVkREdNUHA5M3hUa0FpRnhz?=
 =?utf-8?B?cy9oeWpCQU9KQnRXR3hVUkdVdmc5Q21mdUduVEFNditHTU0yblU2a052RCtQ?=
 =?utf-8?B?S2FSTlg4bnRVdTN4eWxJS1dXV0VHUFRqUjRFdHZOb3l0OHcvMFlRTWtFVnV3?=
 =?utf-8?B?Q1lzcHBHcmFrY0w1dmxqVjVzSE01V3V6ZFV2MXM0QmpMaVlENi9ndnUxRjVq?=
 =?utf-8?B?T0ptN295enRMTEZHU0hTZ0RNMkw4UVkyKzNKUy92NmdJSVJrTVU2eGVDUC9y?=
 =?utf-8?B?cEQvOWM0NGFhWUI1U3hRcDRTeFp1eTQ5NStob2lodzBjYTN6bzg2OHQzNHZM?=
 =?utf-8?B?NWxVRWZEc1hub25sMFBGN2RCT0Zhak40eEdRejNZT2pIMmJiZTlEcU9VRU84?=
 =?utf-8?B?aEZudlZreUQ0STZuQ25TckdCa0RYdEh2MjlVZmJYcXl6N0lPY3U1YlQxV2Z2?=
 =?utf-8?B?eFJuSnBBeEo2NUlLWEFDUjlQdlJBUk55dUNJSEVxQ2p5Y3lycEpDVkN5aGZM?=
 =?utf-8?Q?zUOQ9rfj30XMSUlcF9Y60Vt25dPppBtH7nq98h6PCM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14993F35695271429A70CFAF5D1CD0D9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pSmmJ9WixPMrg0gQK1ijJneSUp4yLKF3awgiPHIrObi+mTYn8/aa0FGEplWl6T3QZ1C7vOxw2SjyByGwpizateTeDVd+ecHKTb1tRRLbTS8ntE5BpXslr2ovbQ5ycf/WI3asLRIXzWQbpm62VSvE1vIrqcX77KtNw8WmbjV6iuSr3CJsLVv1/NqjXe+MC41Z6yC/u3/vANA3qK+KtpMbRfIm5owMiaCHd0ajPrnwNIJVVOr56fMyMueh4FlHx1MljL94K21GuRTZvYcqdYRO/ihXNFCKYoy0C16DvoYC6R1lvhJXtYi4aGrPwzJ8eUJRVz/IRkrZYKjHPuaQmXs4uEluFLQbMhkbksE3nob0MAW/IR2v56UaKwrU6uoPbLn5L/tcldN1DqXSE/2/hn5XgV9rjHE0n5gSpOesIuZnrWabhtel8PiIfqW9DyVdGJBoXew/ua1aK5yvrkL0A+lITdAGG13yFkPR7MKU5Z8Pte6PlDm/effsumWXMkL+uAFgUrvB4vU732uiFE3juY/bPOIL4DtFd/3b5cIWs4TcD8nXI+kOpIlBX7s5bE9f7pLzjsmRN+xgVAZOHPkLxeEXGCGyKAxDQp7IfWziy+pi9dzMg24LwqBEj9RleYaiPUum5teFhGb0zR+lRlXhc8/808v23UB69UNmzEgDF816+6rjb/+Eq246lhveQjkbJSrFe0efNUA2/DOZ7ZyyNHgbQi72UhzxgpS5++Bg3V2hauWX1Y3+UHzcHWGJwWVRmmYNWoTrc0QGGJlyS9EAd3xDtNKbuxnWyO0yUNxEDOBSbBqKiCjx3vLK4w86e/f2QTYbRXw2KFjc08fUz5adlKfqog==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f778b147-0853-4bd9-9f00-08dad760700d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2022 08:04:02.2494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HRH7oT/Z0m6pmE0ZPGkY+6une8EdEu44qKXApjQV5DL4pMeFnFBbOegJZD6O/lG6YWXbHhpdJpAmTSxceTpfooa728zPP0B2LZx1kHgp3/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7717
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
