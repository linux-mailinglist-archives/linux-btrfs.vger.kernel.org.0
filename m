Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7718C6966EA
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Feb 2023 15:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjBNOc1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Feb 2023 09:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjBNOc0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Feb 2023 09:32:26 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B7CA8
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Feb 2023 06:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676385144; x=1707921144;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Ttd6yKgnpFuDplowHpV6CCg3s1UwQlIMRIvslY9ME7U=;
  b=NkxCpHok6O5+aVsw1iOsV5rle4E8iP6OWrI6WlDMnPvh3X53s10TA+d/
   CkNw31OgqF1tqMu1LdKaXfswkeXo2pgnGcANjUAJRLj+E5PicxSf+pB4m
   GGSCbZQZYgzSre6p2NrCcOlYqCHJ9UPAZGEdThx3V2v36PFd8Jjxzrp6f
   JA3MzdIFoEm/zrVeUjBDZJ1qtLGS7DhsQEfJ/0j20C8gygrSDNZdQYvu9
   FHdg6nLXBczDR8lr79YKTonS3cp8QxO+avlO1UCuwQ/ndRss32Kl3mDqY
   sly3yvw4My/nNqKExVtrV3eJVidoWkr6oAghD/QlgHdr07kI1NYMaXoY7
   g==;
X-IronPort-AV: E=Sophos;i="5.97,296,1669046400"; 
   d="scan'208";a="228249119"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2023 22:32:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIaEDvvcZIMoDjOaD2OJgZ/RPY/rWGJP8RpeWWOuhvpCm8Ij3PCrhEESXBt3JdLI7E0R6bUrWWeddrz+q4CTAtC/E1x9WeupSQztnOLVmtICXOoS0pjuf83o6I8RPq34FE2MtkI9xx8gIcL4P5FJGrdlxWGLxHRWGJFUnmsBh5Seox6i7JYWRiTXMQTB1QIdABm/sObUgGykjFz31RWwTyRvg0YDVfvzIRIpfMPCWibPNri+CfM0UzMPG6HSCBP645N5vWwvLBvE5KfHi3si1kSXUqs/8EEfWTg29QB4bYcsGHULaIy3XPxJ1zVmn4dUJWDJTCdFw6d5mODY/vGJ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ttd6yKgnpFuDplowHpV6CCg3s1UwQlIMRIvslY9ME7U=;
 b=AYPTrMy1u8qF+puDAbMSHwmhkK5Hn6ZEmvYJ9kFVfK8kyROa+ymDihD2NIjL0jucHn8Ll3VQlyVURFLWZU7crbRx1AA0/BHfAb1LlVOX9UyX9scDIEr23oJDbYvOqYdJewcttWbvrVRKSNkooX/zvW7CJqIBhXZbLgngkjDhLoti0I6pSmoJg7TmYvu8vj66ZcMv5ygLFmiWhHKwCCl4uTSd2aAsq1+dy8nYjTidbc4IZG+rQg/NIwrPd7ukK/EO/x4X6qvaIiO5fN1ZNqx9gWjXgKiEoKKTja2TMCC/ESaSN2L+BW5ytfMXRW0gidsNdqWNThj5q4QqGwm+8CVnmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ttd6yKgnpFuDplowHpV6CCg3s1UwQlIMRIvslY9ME7U=;
 b=Ns+sgoqCSquC1qRnRGZFuvx9G5ChQXGC/H7IHK3dnHO3GpmVYPSQEaMizlkPOE5xwkTJm52B8gOg+2xkO71aicRO5aUVgX5UqmfpiDgPr95nOBOYlZSMxwISP8RSh65aR7QRtr98S9vDU1icO9QPRb+V6ixejrjuCgXj/y95M74=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB5122.namprd04.prod.outlook.com (2603:10b6:208:55::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 14:32:21 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 14:32:21 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Forza <forza@tnonline.net>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Automatic block group reclaim not working as expected?
Thread-Topic: Automatic block group reclaim not working as expected?
Thread-Index: AQHZPG2akAEfAE1cFkyLx/ChHDx+hq7Ga+4AgABNQwCAACr1gIABF4gAgABQOYCABcrbAIAAcqwA
Date:   Tue, 14 Feb 2023 14:32:21 +0000
Message-ID: <60d348db-822b-c337-4c4d-edb06094302b@wdc.com>
References: <e99483.c11a58d.1863591ca52@tnonline.net>
 <b508239a-dd7a-98d9-d286-7e4add096e13@wdc.com>
 <2563c87.c11a58e.18636bcdf0b@tnonline.net>
 <31bf44b.fe8fe284.1863749a10f@tnonline.net>
 <f6e2f95e-0892-f82b-43fa-34ef32f19320@wdc.com>
 <b19674f0-0743-4e34-df85-ba6c458af01c@tnonline.net>
 <73b49250-8aaf-bbb7-92c6-73e0ad3d707b@tnonline.net>
In-Reply-To: <73b49250-8aaf-bbb7-92c6-73e0ad3d707b@tnonline.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL0PR04MB5122:EE_
x-ms-office365-filtering-correlation-id: bbe72e71-d8ac-4bd0-738f-08db0e98484a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 19pXxMZpdSfb1j8FSbTYzA/XpWcsayPSy/TlYBMY4+6TibRpseZgUtqDUUP+69PabmlaqVINW+btLbmawfU4Cz0FOSpB7VUeIFSQ1LXTsx9RQsWV9rG3IXaxxk4URMGQcH03q8nWidwR6QTlqtGlEgLHCqkhXUqdHA2b7mwbL6DJUqMEbUGGH/Fszl3uwBlCwveY81zhKCvUNDU2vVmmaENqcDDsb3MeN/N56gFaZJoJZRSCqy92wY9u0c38zALlicEfHeTvZS4VMZz4EhezssTn2k+3tvxm6NO77JlEJlzzU0YJP4oEO2jqq9F5b4dgWsfVwfhFaGW4u0kxRAgE0I/EPukzv63wtOMG4DtYLocScrN+yVds5fX9ig4EcePgsxbnvljJwo9AvbZuOlUjEpS5fqS4E0A72bvn6bSeG/ymOe3aRjVI5fw+P+6uUCFrtVysdr7ogCg9kn3w5k9Zkzt88+YW/TE8KkMXRN/7paNLBZULmBx2g7lrx9rP2wfALgNAnavppQdP384SiM4ZCM2zS/6ntrUmWFucV+hQNbUaVQqltfHI5Q/LU2d9MekqeMGKEjEushbT1PhnDjd1+rQFj8e7EKDpCA2FdOVXr9mTuAkAhtpAzuCpuk594e3vltetDNgKlgsa6AFQ66xa/4x2hgUD7usTSMxMKrFvD5aNAyYUMtr7oLbn0BX9bL00tWlzK1+8ysjiQ3Dbb8Fb1C4A/zu2mNja/MUrJwkO7DcdQx5R9f5HfEUrhRCOhIB6X6mWd1PfucHBR6fzaEcVVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199018)(6486002)(478600001)(36756003)(71200400001)(66946007)(76116006)(91956017)(83380400001)(2616005)(8676002)(8936002)(64756008)(41300700001)(66476007)(2906002)(66556008)(38070700005)(110136005)(66446008)(316002)(26005)(31696002)(6512007)(6506007)(86362001)(53546011)(186003)(5660300002)(122000001)(38100700002)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0QyNjFEVGtQQjl2Y2NMNmdMY3ZrL3VjRXczdG5VQ0RRUC9uWGZNOUxKQU1T?=
 =?utf-8?B?dFJqNi9XVTlVQjBMclFGWnZ2QU9tOG9QR2JzbnE0QlFEY05Ld1pCYnhZbW8y?=
 =?utf-8?B?YUdmcjlkS3JqclE4Ukx2Y0YxeHpES3RGWm9xN0YzSlpCSUluYVcrTUVlYnZi?=
 =?utf-8?B?bTNnMHRLdi9wNXBOVDZ2T3d6V2QybGNTL2pFQ0VrTmxnMHV0a0xYOGdzYlMv?=
 =?utf-8?B?SitRMHZmd3h5Mm1qYVdGRUVxSzNyOGNzOWhxdjRlVUpTOThOZjhiMzlmSXdE?=
 =?utf-8?B?SUdXT0xOakluakoxdTNBb09XOUdUaGdCMGZCOFNqei9JMWNUR1YwaTg2NkVl?=
 =?utf-8?B?ZVY4MGRJUzZ3VG5XLzNaOWFmbEtYRllITlVqbTVqSy9sWFJNb3NpUXIvYUVN?=
 =?utf-8?B?TG1WR2J5VzlWTEdHQVI0QnVkRDdmbGRlM0ZCVGxadEhIUzlQOVRCN3IzdlRJ?=
 =?utf-8?B?ZmV5UmVYZjloY2tmZUR6anhEM0gzNC9XRlVSL2V6Smp0M1RrVW0yRGRiMkZz?=
 =?utf-8?B?UXN0RWZWd1dXdG1HcDl1c0J6Rm5IOGRaT21tMWtUc3FqaUVhbTh1RmRjeWFG?=
 =?utf-8?B?L0krT0RpRmNQeUU5T291cHhJcWx3KzVaNndmUmhaS0pYa3R0NFN5OWFwKzZ4?=
 =?utf-8?B?Ymt5VGYzd0h0dFZPenlNa3QvbVUxclpYSTFXRVNpNm5UK2ZTY29jWCtFQzFQ?=
 =?utf-8?B?Yzl6cmd2RkxIdjZWNGkyREFWZXdxcjFpTHVSZE1TLzV0aEx6bDVXVVN4Vndr?=
 =?utf-8?B?SkVuSWdld05KdGtMTkpoYzczazlIZytJQWg0YS9qS0NXTlhlazRtSFJGeVFm?=
 =?utf-8?B?bFErNDR0eWVaNzJFbW9hSFBKZHZacWZ2V3g4SzNXYTEwS0dYZGtiVmoyc0ZD?=
 =?utf-8?B?MVFFd2VabEFYQThNSWJydCtQbGZtZ1h6MzFtdW9aaXdicS81Y1N0cThlZzh0?=
 =?utf-8?B?MlB3RTFLazFYZW9ON0JFZHpubUNxcm5OVlczMkw5Ykl3OHJEZnRyVzFHTlhJ?=
 =?utf-8?B?RnRLZUtHSHo2LzVzK0J1T2IvKzVKb3lqV3NoL0NRSG4yQS9WVXJmQTlBQS9R?=
 =?utf-8?B?N1BEdGpNRnJWKy9PODdVRDVjcElDVVNPT3h2TEdqWUNXYzNGU0JDMmgzemY1?=
 =?utf-8?B?ak1MNlZpNHY2bCtIbVd1ZVhIQXBtTGIrSmdkNE5pYVM2ZElnUktMcWl6N3NI?=
 =?utf-8?B?bmdFQk16NHVUN0g4WEdxSDNaQTZqd2NKSzJCRGpLRzdxNFBnWmY0QkRONG5O?=
 =?utf-8?B?QXo2dEhRSWZZY1Iyc1RIZkt3L2c0a3k5WVl0Q251b1hNaUV0SzlncEU2eVFa?=
 =?utf-8?B?OWIvd3draEhvRThVVW1EQnNxRTVpZnVUTWNMTkhCN2VWeHBRYU1PRjAvcVND?=
 =?utf-8?B?TEVkU0hNMkhlaW8zUWw0OU5KUmZQNXJWcGdOSVdIQVZ2dFBLcDdwVTNqMnAw?=
 =?utf-8?B?UGZYWnAxbmpnNFRTRWRncGw0L0tlMkIvcmdtdHVaMkowTFNZWVpFc0FqWEp0?=
 =?utf-8?B?NjNuUkg1aWxETjBKNWNzdExyQW1qaGpKc0ZmV2lRWmJLUUplSmFQanpYSzZB?=
 =?utf-8?B?NCtNbzNnQ2lEYjRJUWFneGp2VnB2TytMd29ZTDJoM1hpYkZqMkJPOW1lN3d2?=
 =?utf-8?B?elRoRFgyRGMwQ2c5YlJPMGZjZW1yZXdNbTk0L3M4NUVhYVFvV3V5WGdvZk5R?=
 =?utf-8?B?ZFN1dTNwWGpZcE5tRGl1ZU1tdjNUOUdBUVJPdUdZaDN5ODJoa3BTVDRhTGM5?=
 =?utf-8?B?QzljaWpXRnFzelZveGJZclpaVXVDbkw2NG95VVBrUXlXNGlUMUFQVzdGN1Yy?=
 =?utf-8?B?Q3VYMXJ0VEZuK1FNWklxRkloc1J5S1JzaEROaXBsaUwxNUFFdHk4eXZsakZ2?=
 =?utf-8?B?SFFGTWEyRjY2TWdOZzQ5alJyeDd0anJDZ0VkSXhQaVFRS3lXT3NiRHY4VGdp?=
 =?utf-8?B?dFIycjN6SmhxMzFidURCYTJLM29jNm56L21jeHA1NE5lVFRtM0tMTzdQS04z?=
 =?utf-8?B?OXk2SzJoRGEvd243L2syNGk4dEg1V0w2bCtocHRKRk8rb0tUbUVIcllYeGJo?=
 =?utf-8?B?YUlOM1pVSHVTMHdpajFQeEFRQlE4RjFsVmw3eHhpL2Zja1hpUlcydmh6WGlr?=
 =?utf-8?B?Wm5EWXQ0R1cxRkJBd0lhNndCbHJnQlJ1Q2s3VUZDemkra1FQUTVBbUhseW9L?=
 =?utf-8?B?T3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3712D87FFD39774B8A140A11A1A2AE8B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9mLqSfmPNGmAh9V06LWW3K8zk8vOoH4UzyQyupOY3lYF0JfZsL/5J31vpL8K8LpFdl8NGNUM0rzJrs0vCo8ndV3abCZYJ8+Q5ABf1zb+jc+PQYwnDGwYX4vogAPWyQPw5YuS5mpdkIZD2PMjDE+TBJmTnT6APpr4YxfJ1hWPIWo5ibnxrk8AZNOpsaBLfRoWu2BeKv0t25ESKYLAocDROV8EOyfcZYT9CHNxyXQzM4hXAQXidDXPP85fpZOljaf72ZU+Sx2tQrOSuBDxBm8ewinv/pEuEHTVOPd7OAxoKkL1kjAAatJRwQQFUf8dueLlGo0jf6GZ0MH0sbJrOIMN6edMiePwKGnnKnT7qZl5z2TQFcbBOrfQOfe8tCugfaYA//0DpgbmQvQIzfrEF+5U69CAdgzOtJ58PtZQjlcTcYRVOrbd0uCZMK3Dfg11LsLOYdz1RNWuYRImGavLlASa2O2FVM/4ZOIbJSF0CVRLWKYNqJ0hLGLIIjzfdmlz1Aax/gyr+cfd4hHMWjLwDzBmPW1PEjGA/aF35mTAejuhcHyNmMtooxWwzSlw5f/8To24/eukCrAspmocLbWvYVCio4JGfqR7hVWwXqP4be01WCPSzKEf1rX2J1cDACUcj+nXMqsgXCFBGKwuHpx/KyEurYIpIJPsSxil8W1lrlphqRoICkYl8C+McWHhEBcz6HmHq3bzvUc+EUu8XDPGZCSPkOQuLk3Po7aLIlBSG4d3zEu/Q4XezA6J+i50VWctdzbO1PXXZNAh3QcXXfVK9BMnkWE9xBWgEGTMN/647s4a3+9wqDR07ma5gTD99kf4MFuW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe72e71-d8ac-4bd0-738f-08db0e98484a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 14:32:21.3088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CQB5uTcCEzVp817QJRto3K/bVOpj8DkfhvakBQVSADWLCJgVQ43RG6UwlTHUh4FhmF/sWKAv36yGNoh0oU6H3jGZijCG+XJfKXxouxJzRTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB5122
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTQuMDIuMjMgMDg6NDIsIEZvcnphIHdyb3RlOg0KW3NuaXBdDQoNCj4gSWhhdmUgc2V0IGJn
X3JlY2xhaW1fdGhyZXNob2xkIHRvIDc1IGFuZCBtYW5hZ2VkIHRvIGNhdGNoIG9uZSAgOikNCj4g
DQo+IA0KPiBkbWVzZzoNCj4gLS0tLS0tLS0tLQ0KPiBbNDU0MTIuOTAwMTc3XSBCVFJGUyBpbmZv
IChkZXZpY2Ugc2RpMSk6IHJlY2xhaW1pbmcgY2h1bmsgNTAxNjk4MjgyNzgyNzIgDQo+IHdpdGgg
MjkzJSB1c2VkIDAlIHVudXNhYmxlDQo+IFs0NTQxMi45MDAyMTRdIEJUUkZTIGluZm8gKGRldmlj
ZSBzZGkxKTogcmVsb2NhdGluZyBibG9jayBncm91cCANCj4gNTAxNjk4MjgyNzgyNzIgZmxhZ3Mg
ZGF0YXxyYWlkMTANCg0KW3NuaXBdDQoNCj4gdHJhY2luZzoNCj4gLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KPiANCj4gIyB0cmFjZXI6IG5vcA0KPiAjDQo+ICMgZW50cmllcy1pbi1idWZmZXIvZW50
cmllcy13cml0dGVuOiAxMi8xMiAgICNQOjYNCj4gIw0KPiAjICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBfLS0tLS09PiBpcnFzLW9mZi9CSC1kaXNhYmxlZA0KPiAjICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIC8gXy0tLS09PiBuZWVkLXJlc2NoZWQNCj4gIyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgLyBfLS0tPT4gaGFyZGlycS9zb2Z0aXJxDQo+ICMgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8fCAvIF8tLT0+IHByZWVtcHQtZGVwdGgNCj4gIyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHx8fCAvIF8tPT4gbWlncmF0ZS1kaXNhYmxlDQo+ICMg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8fHx8IC8gICAgIGRlbGF5DQo+ICMgICAgICAg
ICAgIFRBU0stUElEICAgICBDUFUjICB8fHx8fCAgVElNRVNUQU1QICBGVU5DVElPTg0KPiAjICAg
ICAgICAgICAgICB8IHwgICAgICAgICB8ICAgfHx8fHwgICAgIHwgICAgICAgICB8DQo+ICAgICBr
d29ya2VyL3UxMjo2LTMxNzQwICAgWzAwM10gLi4uLi4gNDU0MTIuOTgxNjM0OiANCj4gYnRyZnNf
cmVjbGFpbV9ibG9ja19ncm91cDogNzc0NWUyZjctNWM2Ny00YjE4LTg0NGItOGU5MzM5OWY3YjBi
OiBiZyANCj4gYnl0ZW5yPTUwMTY5ODI4Mjc4MjcyIGxlbj01MzY4NzA5MTIwIHVzZWQ9MzE0OTE2
ODY0MCBmbGFncz02NShEQVRBfFJBSUQxMCkNCg0KSnVzdCBsb29raW5nIGF0IHRoaXMgb25lIHVz
ZWQvbGVuKjEwMCBzaG91bGQgYmUgfjU4LCBub3QgMjkzLg0KDQpXaWxkIGd1ZXNzIGNhbiB5b3Ug
dHJ5IHRoaXMgcGF0Y2ggKGNvbXBpbGUgdGVzdGVkIG9ubHkpOg0KZGlmZiAtLWdpdCBhL2ZzL2J0
cmZzL2Jsb2NrLWdyb3VwLmMgYi9mcy9idHJmcy9ibG9jay1ncm91cC5jDQppbmRleCA1YjEwNDAx
ZDgwM2IuLmExNzcxMjQyOWZjMyAxMDA2NDQNCi0tLSBhL2ZzL2J0cmZzL2Jsb2NrLWdyb3VwLmMN
CisrKyBiL2ZzL2J0cmZzL2Jsb2NrLWdyb3VwLmMNCkBAIC0xODM2LDcgKzE4MzYsNyBAQCB2b2lk
IGJ0cmZzX3JlY2xhaW1fYmdzX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KIA0KICAg
ICAgICAgICAgICAgIGJ0cmZzX2luZm8oZnNfaW5mbywNCiAgICAgICAgICAgICAgICAgICAgICAg
ICJyZWNsYWltaW5nIGNodW5rICVsbHUgd2l0aCAlbGx1JSUgdXNlZCAlbGx1JSUgdW51c2FibGUi
LA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBiZy0+c3RhcnQsIGRpdl91NjQoYmct
PnVzZWQgKiAxMDAsIGJnLT5sZW5ndGgpLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBiZy0+c3RhcnQsIGRpdjY0X3U2NChiZy0+dXNlZCAqIDEwMCwgYmctPmxlbmd0aCksDQogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRpdjY0X3U2NCh6b25lX3VudXNhYmxlICogMTAw
LCBiZy0+bGVuZ3RoKSk7DQogICAgICAgICAgICAgICAgdHJhY2VfYnRyZnNfcmVjbGFpbV9ibG9j
a19ncm91cChiZyk7DQogICAgICAgICAgICAgICAgcmV0ID0gYnRyZnNfcmVsb2NhdGVfY2h1bmso
ZnNfaW5mbywgYmctPnN0YXJ0KTsNCg0K
