Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628857240F7
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 13:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236351AbjFFLeG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 07:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236236AbjFFLeD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 07:34:03 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C01E10D1
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 04:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686051237; x=1717587237;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=FfDm9HiYZ87Lx3DZWTPX+8ijZRcs4OIu0cvWEJTsLEshVhORQ6Zh+De/
   iiMO2oLnI+2DjphmAXIuArTtTdITp0iw1inYoXAE4UvdfUWgHo9MSuqnd
   OpNj9uu74nrtUzY9Fw0VZER9jda7PI+ltxG+Ggo0E9StgcUta2CMH1lJa
   nnpni9f90BlwwYo6LTPP0xoQJyRqcivn3i9Gmyo3htX9w7To5VV/RYih7
   Fy3B77S7+k82qJnd/ghAu86NZXZPHrky4aQDg8QKD5jBpu6YL9+Lkxnut
   +lPznul1sgGCd2P0ZxH3pr6fBbohtq7zS8vXxqcaWy/V04mID++5FN+Mz
   g==;
X-IronPort-AV: E=Sophos;i="6.00,221,1681142400"; 
   d="scan'208";a="344785748"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jun 2023 19:33:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQO34g0EcL9euuIoNhJdTucU+iEIMRGtNb3/Aii0NPDxz/73euZrcXHY+bCIoj6rTo4fdSQ93vQ/79gwtlFMK1WWWXbSq+FkHuWgzZCiZGeGiT/rQL463MdyTg0WfW5cwxEAQq49GATfDCKkpa72sScFTIwIOpqjnrKhNyIM1UMMghStF52nuPprvoGOkFYeoiItZauFSdwtMQqN9cZ6yBsKBmmce+AGWDJLwx69v0yPZDymQy9H699abhMkJfVdXghKFCqLxTIvjGP+RdQxsB4u0FrcKeWm9BzlzAvjH1ntqY3JlfOGaUpdRNJtZtoOVlugzOalgQJhY76a0m6JWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=FgdaNvj6KI9xQH/5FGouUirgFscGcZFpWGJyU5xTfyiNhxOLHa1R9Q8bi4COTJsu5LMnaLCzrej6+QUzxyu5JDNdDUd54t2DOTcYZFHSdJ4ntIXpjAks6a6iRaIPCD8JotfM2Cdpv73SM+jn4UN78TD+hq81yA0KvneXDIqaZaM1wgTtJLhCPm+iyeTUJ8OML2yF74630S95wdVjeGMcTLrQvUffkmZPpLFvBf4rNxitMmW4sQ5DZ8qNgyuWcmL3MMnZ+dUZBomk3QOI6u6RlA2z52WqhAbbZd0gPsPM0Io8hTAA+//JnhqDp30F9qGiOhMyQMb/Ys5CSrZjjnhw1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=ipMtfVYBQCacwoqom+//AXt1LvvuEMT0myuyFm+9eIUwGq5wTVL1jIi1Dw2zF13X1oEdEsoRkafKqQTMWp4bEMkMjSE/KSjZOUm0HO/kepT157wKlehrhYTCThYGe0gkm5/Qrrul6K2LnqVcqXtO7V9QuhG60YfaaYqRCxjrI3Y=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DS0PR04MB8598.namprd04.prod.outlook.com (2603:10b6:8:126::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 11:33:54 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%5]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 11:33:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <naota@elisp.net>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 2/4] btrfs: move out now unused BG from the reclaim list
Thread-Topic: [PATCH 2/4] btrfs: move out now unused BG from the reclaim list
Thread-Index: AQHZmDjx6CISOuf1J0mdpl1m4RjRhq99pRiA
Date:   Tue, 6 Jun 2023 11:33:53 +0000
Message-ID: <d8e82977-bbb5-7540-fb68-fe3f2161d9e4@wdc.com>
References: <cover.1686028197.git.naohiro.aota@wdc.com>
 <6a25b9266b8fb08ff990214aae9efd04fed6b549.1686028197.git.naohiro.aota@wdc.com>
In-Reply-To: <6a25b9266b8fb08ff990214aae9efd04fed6b549.1686028197.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DS0PR04MB8598:EE_
x-ms-office365-filtering-correlation-id: 48d3e57b-ba50-4b06-4bd4-08db6681e867
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pIb988UluVa/ySfNB8X5hYqFnL7vLyCQIhJpBLGqfe8RBZlJSQtxpSlCrDuDNmVip+RiZhr/A2Oc/ELcTSAjYwZgXm1wzK+2rXiYwIW8nGjc0CLLfq4XKNQnfL8ZxJOE17flBwYSTQz0hkldT7wLxeBbUhr8lEtxpYh2ZACSGzJW5wO2CCdlEcNbMcb1+OgFOUiwSvK/E0K8tvmVFaXfJV5VqyhXD5Sd2NX4JHv9mGwq9q2E4p47pjtaww3ql36JKygdKYKXc9T09jrBuL0j87ooQyhVudE/kXNq2XB4Gy5e7TTe6a+O1JV7Qq8eH/Nu26bVdzFKNBwNcVjfADaHz/7lqlE/hjxffoSJatetZ5cqXBFR2HLjSgmJZA/1DO/y/kvHiB0DSKMgEpV7xs3JftbrlXPhpX/XuGySZ13R+ZNlfCQE4zZC25G2Jq8HGx4HG1X1Wri4SNkivYl4X9vptQo4fnNLOijZdUfmVZ5lAlKBjb8TkTT8cu6gHSNI0iVYWun3i0U8LRlOxqzOycvbFC7L6HCOFn3IiUo0N7IgOM4qeFy9+aosu+6nMfvbvQpGaDuI1a+ETVr+BILb00q/fcjcDKp6j7XeTy4ntOks/yz8pjsrqDmcgvvGBEL8wEiyhrS/UL0ZzzYrSvAwrerVpQvAlk6y06shinjfGczEkPS6PFtB7H9Mgk8Soxijq/Yk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199021)(478600001)(2906002)(6486002)(71200400001)(36756003)(19618925003)(558084003)(2616005)(38070700005)(6506007)(4270600006)(86362001)(26005)(31696002)(186003)(122000001)(82960400001)(38100700002)(6512007)(110136005)(316002)(5660300002)(31686004)(8676002)(8936002)(66946007)(91956017)(4326008)(66556008)(66476007)(66446008)(64756008)(76116006)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bk9iRGJnRlA1bFFDRXQ0MTFUM3c3U2NxQUdhMGpENEdQVE1IbVBRN2p2eXZG?=
 =?utf-8?B?MTBjcVl6d21OMllwb0l2MnY1azMvTUttZ3N1cWN6eDlTcittM0FxVzdRUzdT?=
 =?utf-8?B?elFyWmNrODdQdk8xNThvTXEyK09DaGhRTjVwbkx1T0hVNEdkOFJ1Wm54V3ZK?=
 =?utf-8?B?ckEwdDJBNEVKSnFxV3VYNW14dG1kTkpRaG80VGEzdGxrM3NSUGpwVUl0RGFn?=
 =?utf-8?B?MFNKa0Y5b1ZlV0Rka3VpUjI4WEhISjZFU2VPc2xQdFpPc2RjamRWWnNHai9w?=
 =?utf-8?B?NzF4R0ZZR0ZoaGhQSmEvSlIvZVdKM0U5eEpNSU9mNHlSV0I4ZGxtVmNuVjhV?=
 =?utf-8?B?ZUExeTA3alMzN1ZsWEtUdnVUcnE3c3pMWHV1TUtKeFJJVG5hN2ZFN2FPSnZW?=
 =?utf-8?B?M21FQVo3VkZmRW9UZjdZTkZRTGpRRWYrbjFuTktPVUJLR2l2R2o1N1hwUmdU?=
 =?utf-8?B?WHpEQTZxRnlJRHVBUjIyVlZMeDh5RGg5SDNtR3E2S2xaWkdVRWRQay95VVVV?=
 =?utf-8?B?TERDOVFPY250NEhyc1hTU3JBZmlFbDBDdTB4K2FON3JCQTJubUdEaUpUZVBQ?=
 =?utf-8?B?MmVkK1RQcmJYNWVvZThVUHdVeGFaY2k5SGdYR05GS3RLdkJSQThaalNqMzVJ?=
 =?utf-8?B?VitYWkNIS2VVQWtwVDNQVDFnMXd3ckd2cVVvdUdtRGpSbW9ydFNabFdHMDVx?=
 =?utf-8?B?bkppSlBIZnFuMHF2R1htOGZ1eW15QlNQNEhpWVNUdEw4SitzMTRRckhscStM?=
 =?utf-8?B?MDZSK0tkTGx4SFlOTXdNZlpwUkxwTWNIdElXY0Z4ak1uS2h0WGJSeG4wb0VM?=
 =?utf-8?B?YmtsUk1KTkZ1Vm5pVGtZRFhPcE5hMzBvbEpqRy9sbkMzZ3RpM010V3J3M2h5?=
 =?utf-8?B?dlZuc3d0ZE9nWGE1bENyNFdRWm1FWC92clZaRGpSS20vd1lxN2dqMmpWOC9o?=
 =?utf-8?B?UDVGVnBoQy9LdjNWWEh6QkdUUWZjRTlBTTVYVmg0MUx0dmlQeUVabjRhTWJq?=
 =?utf-8?B?OERsTG9HTnBIek9sNG1Ta3hwUnNDcmI1eE9GSEc3RDNqeWp6VEVkSzdTZWts?=
 =?utf-8?B?aHhocGprbmkvL1ArOXU2YkcwZmtOSzl1WnhZNGxFOTZVYjEvQWxUVkk5aVY1?=
 =?utf-8?B?cGc2QXl1UWZVcGtDSFJjbXoybWliL1orbFN0TU1NUXNBdVdVOFBFeTlBbFNX?=
 =?utf-8?B?ZUI4aG1CbXpablpYanJPRzNiemJINmVMNUdYSEJKNFpnSDdsL3I2dWhCdVBT?=
 =?utf-8?B?cHpOU3lIUTlOczNlY2tXWTRLY1FBdzNwRFR0ZHE4SWxpWm1oaFNQaVlqaFRp?=
 =?utf-8?B?UTBvM1Evc0VhUFZrUDBVWlI0VFVNZ2hkM0lVUkxuRmMvLy9XZnJwTHoxNEZ4?=
 =?utf-8?B?Y1ZYcVhodDJEV2lWVVJpTjhiLzVqYXU0U1ZjUEgzQXJyWmNuenF5SnNSYWsx?=
 =?utf-8?B?T3VwTGEzaWhSb2hkYzNVamVtQTI4d3VHSTY4cUc0elRiR2FQbnJHWWZBOW1B?=
 =?utf-8?B?aXRHd2l2YkNUeEVSdUdJLytnS0dYbkd0bXdJaWl0UnlYMzZic2VITlR2eGVS?=
 =?utf-8?B?N3l6SU5ZWlFVOEtNcXZFWHZqcmFNL0xoWW91cXZNVWdiaVVhdWZqbmh0MUpF?=
 =?utf-8?B?WVhwUEM1azNsZ2d5WW5aNFpKS0R1UEFMYUZpQUhQWmN5dUYxcVlObHNnSWNs?=
 =?utf-8?B?TnRsY2t2VUFISVZKcTFQci9CWUN1N0Nrb1hydGZsS3JuOEsvbkZxWFFoemxX?=
 =?utf-8?B?QThTYVdMV2ZnVFRNL1k2R0c0L3JSanBpZ3gwWTFLSVk1Q0ZFVFRBR3BUYTNI?=
 =?utf-8?B?YlpFaURieW5TRkJQSWlyRFZnNm54Qk42d1orYVBpeHNkemR0TFo3Z3BhZHRw?=
 =?utf-8?B?Ymd4WU5lRDhxQytQTVNUUzJjYU1Bd3lib0JiaVZYdzdydUNqWkFsU1RuUW5M?=
 =?utf-8?B?MkhtdHMrcFBiVDBkem5kemZEb3RHMFdLZDR5T1VMS1hwbmJXeDR1YXBkT204?=
 =?utf-8?B?YmprcXRBeFo5T0pPWkoxdnpQZlBrdnpkL1VDYjd0dzNCcEY3RGswU3hDVVNn?=
 =?utf-8?B?enVnamxlN3l5YnJGY2MwSVNSM0VpT1I4VXRzMFUzRkNCckVGYnk3Q0ZBRUZn?=
 =?utf-8?B?TW5GL05KbkttMytaODNKSW96QzVLWjF3QmxrZC9vb1A3VjVxU0lTT3d2bCto?=
 =?utf-8?B?UXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C350580CBD791749A4EBC850E3590C9E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BU0VnmwS8gLkzjvKbUyjkUdKnW41En8kUhMOUKGPiuRyV+UT6cZDZWeSr3qd2Z9jj8NL1ItAuyTH3z5X3MNfaEnkj0L/GHKzUy+ZK2RL0ln6cccjkXvrJ+A3q+H4Ge+A1IGPjhzW9FsmmsCPb2RlPDmXyrhkWSis8R4ILoUFyOTdg9hkovoxEIEwC602nMzuTiJPuePpKWJI/CF2tSVlsaPQe1RGSz34M7yzipxZ9BzKzWW3TflIIHTrj3ylVZAu+toKS23uUoRnV/KYZJm2LWU8cCLoRvxhZHAW4a7XGCQuQVcpi7dtG7mWuJ+0sPQCgW8gwIZoz9V2IJOR+rtOq9qtvwquvH5UuwZAAaBVLctLd3MAgH4r4t6vvMsI283xm465bZic9780d9UnX+f40xYAi3QtFUtnzSjZ/aS4T/RUDrVvNc9DajblHeZ23T5XWNhYDIv/Cik1H57Hm7rYG9PaWl0yAxoE3JMRK4aB/SdPPJy/WycFPj8J+78R++kRgX5JIWMMAcNiBXWo/OA7c1RNSzhr6IrXzYCsAyd/CJ5NYvzt4nhplYUvUo4T+ImPU7GW9MY1oVWYlWDP3dWYVsJlEVoF+FulP2btJKrlLhhyNcmMUp75okLCW68EWd1dgw6HiwXDDB+CK5itsJJjmRpLkxQPolXcfNfoF6N/sV+PR5AQo4omw/Milgq4gGpqKz2yDs1oYkbgapZ3IvPM0TGZNtAChnBek8zCSCqI0ZU5tYrcP9AxwMC+qn0Fqi0sNKaeVaHs/Ys16CiVZvSpSaD7D1Da9B93N8fvkTSDlBz8cmrlZMii+cqavuM2fKzL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d3e57b-ba50-4b06-4bd4-08db6681e867
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 11:33:53.8516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 58ZtT37fX5SQZfsVUHpGgSIXHtk/R2X/afrwu67mlFPpSiXY1UgH7xeMMUjIqIyrxoN2ryF7UQhtq5COqSJdw1mUWT3civ/WnWD7KHx0Q14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB8598
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
