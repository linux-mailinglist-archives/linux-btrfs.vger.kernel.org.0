Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D2C6E4334
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Apr 2023 11:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjDQJG0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 05:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjDQJGZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 05:06:25 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2074.outbound.protection.outlook.com [40.107.105.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BE2189
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 02:06:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fW7CXA0XflBX8moGy0zv5DVnfB0xj05efZNdgGMTcA+8BTwGl4Nro8Y4FDfgZxAzbW5zEtcvWtpBh0ofJvQXSdgWJyfSxyQoajk3/Gpffa0rRIAJwNPk7S7fNYfN1Vg6vFh7UrllOMLj0ToWVo/V10eDSYGGkDg4lU72uWyZg9kDBAvHgSUY0vFtgGmTTuvApbpyqBBBOsBwxHAQy3b5Q0iQzDrsn6q2T23Br7nGQv5/HsIxTRTxCgZ1B+XY5Ow6QzJCHngzUK5dPj60WgAzWQexq43pyRpVzv9/Zoyv6CfgyeYsnOnEn4hk8obzhD8j2/DN7fCSRdSLHZnZfjew/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLtogbjVs8jkHbXlXqSmQiaJID2w5yhzElcgBCMtFm8=;
 b=mvwbvvAyLiGY2h4xdMStIckmsYpfoxmobJS7LzJiavuTFrTeKW2Qc7Ka3rJKhESaIG36gi6ccB+CSx20xv+ioWSxkQ80pW+On9Fl+xVwdfYb9+Qi7QU/NmpGX+BE10NHz9d18EWENcwwpBUfStutC1kDS/eYr6EMdLQzffS/h3TPgm4EhakWZHXk9yPnYxYddrmklPTOuXh2dfETLeTiJWsPdzYNjZk4dManqTT2kLZ9AJxysUrO/OIbbD9vKc156iqRF7dISYzzlVp/x0aYGZBsW6IE2g6IeghYORFT8eTRqwgpeM9/+k/nSFI0BUElI9BIU1zV3psq4kyu3SIsTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLtogbjVs8jkHbXlXqSmQiaJID2w5yhzElcgBCMtFm8=;
 b=ZHGki9qqWzH2T4jNNZJ3b9TXefMXkFIvNV2QMV1H/q98u4WlqdjXyhMMKUZSdHNVHclf+RSaOa47GOWZsY7CIfS5nCDK9MPqhyBnqwyZ73CuzhXTKidbBqpEWQvEhXZIppaZlNANe+ind8GNhDpDBBdDn2JAEsmt9V7Feb1BNvOzmivTomhmAhCq2BbnJnOMCe17fL50i6u08G8B4wwoo9BJH/dG1CXex1s3kGZU4EbzvNZD1z2L5pv9GKML6xLeKB2TYpYrQl+UfihafPInFhRFUhMyU4eeocdgb7L5Eg39sTvW8HYxS0RVE8jLtRvhswhnl/MXeFYoomE/8IBYQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by GV1PR04MB9150.eurprd04.prod.outlook.com (2603:10a6:150:25::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 09:06:20 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2%3]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 09:06:20 +0000
Message-ID: <c59bc889-17c1-8f77-d374-9a1704745eec@suse.com>
Date:   Mon, 17 Apr 2023 17:06:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Torstein Eide <torsteine@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAL5DHTGEzg2evkVEQMfcCo+kyq_7XcgGJfjLcH6OaQWrvqMAiQ@mail.gmail.com>
 <182e4a51-53c2-94e5-71c8-3125832dd2ec@gmx.com>
 <352ecefe-cf65-ce53-dd25-15445e3f484e@gmx.com>
 <CAL5DHTEXVvNzTfdxJCYeTSn=yGqZ7Mnk78-Rhfx63cjzJagmdQ@mail.gmail.com>
 <932806e4-045f-3a2a-f972-3149d37acc30@gmx.com>
 <CAL5DHTEYeEXLrV0+=d2wsYpxZvW2+Ku61CC3hLFNOUtOMTxi2A@mail.gmail.com>
 <4adbf458-97ac-535c-cd26-2f1f724cf5d3@gmx.com>
 <CAL5DHTHQp-8EvwwcjJRuZR90Tn9LnV6aQKVkkRfZi+dx+H203A@mail.gmail.com>
 <5640ce1f-b6ca-1060-f0b6-60851856374b@gmx.com>
 <CAL5DHTFAUCKBmW_j737j8dzRvaBnKWa9Wo5VtvoAgW8f93oR9A@mail.gmail.com>
 <789e7082-9494-63c4-dcc3-5b522532e298@gmx.com>
 <CAL5DHTF39+08JQRiK9Wv359oWqdG5nR9jXLUcnZP=JKW3nFy9w@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: scrub/balance a specif LBA range
In-Reply-To: <CAL5DHTF39+08JQRiK9Wv359oWqdG5nR9jXLUcnZP=JKW3nFy9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0143.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::28) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|GV1PR04MB9150:EE_
X-MS-Office365-Filtering-Correlation-Id: 8baa5573-1ed0-41fb-f482-08db3f23027d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rLtfrO36zQLd8Hi48jh2WKQ941PMEX9O2Ax6O4rPWFjF+0DPcAixL/51JHc2RsmnmVaABJG1YYioue1fvac0W0PNm5lPCtQqwnLMUwC+M1RygmvFGyjlZ75RCLWeJthVN1vAVJB3hNmzSsXhZfcG/DBXLKXJ/48mWHJuVw2FMquQ6n2+GLNUxaykFLw5N9b2mg/lTRCY4xTYR4DZzEIlSILORFd5PMTPtIQ2MH7mc8uvHiJs3n6rNZWGSYD+gHq5b9vgtgU9vAQQOSlI1ycwQ0l4NMKKWqfFrn7NcC8vOEVx1q0U1sD/y9VYc6bHSFKZHDQyj+yCP9kL14ICcVh7DxGJayMn9CT7zbNEZJ9nAwQHo7rjOpPmeXgRntjKJ6M7iP1XAM6X6R1aMtEbhlTVKQkkvsBJVsXkzrpusUiVJGOViFADjDhmR2ZngctsksbJuILgK5nLIIV7qIXTxxxjT0pvibtaO2NhYtOlbfMoaCi8oKvj1BjZ/X4WlNzUQLWNE5J12/t/V3/UQCM6etBeUKU8gZm7noTu7tCd75sSRsPJtLKQ0RO8l4a9Sh+M5+q5Tw3yx8pQUq46dhb1iuseU/buHKMTrmty8LaLf8BSEcJ63mStQ0d5KbY4pR7tmVyWLfdXG1cX92iSaTte2yS/fQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(5660300002)(2616005)(86362001)(31696002)(83380400001)(53546011)(186003)(6506007)(6512007)(38100700002)(8676002)(8936002)(110136005)(478600001)(6666004)(6486002)(316002)(41300700001)(36756003)(66476007)(66556008)(4326008)(66946007)(31686004)(2906002)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUFac2lnYkZtYTRuNzVTTnBiSlJjYUh0L0JOUjFvQW5sS1dBUG91bnZ6cWgy?=
 =?utf-8?B?QzBOVWxWWE9kWURQNWdRV2hjc28rZXZzN1UwVnJOREZONUVPUEdYU2JOUDhk?=
 =?utf-8?B?c0hjUFhJM05CeGR2djIzVWdnLzVOaVEvRWJ2a1JkKzB0b2xQZEttWTl4andk?=
 =?utf-8?B?dktKRDdQS3l6V0c0Y09pQm1HaXgrbW5BWVJMTTF3ejJFRXIwaEQ4eVV2ZnNK?=
 =?utf-8?B?bjMzaFVZRzdocTR1eWdGTzFmVStwa0Y0emtWU0laVlN2QXo5ZU1nMXlrOS9T?=
 =?utf-8?B?K1IvY1JGV1JsVmx1TkJEdWNqazF1eTk2dzRDVHNJa3hoK3ZWOXNEam9DTXRW?=
 =?utf-8?B?MTF0ZFQrOW1Ka21hZWVKN244d0I1L1B1NjFHYTlrZk5tbGhXUHVHZHZMeVRs?=
 =?utf-8?B?bXI1Vk5WY2J6WnZJUFVGUEdMb0luTndoOHl5UEx3VEc1Y3RUcmc4OFhqTHpG?=
 =?utf-8?B?cFNFbFZvOXhLTUVRNXp2dWdzVGxsNmMrZ3ZuK01ZdVd1QVhqR2ZxclNwb2d6?=
 =?utf-8?B?S0FtS2NUditaZWs1Yk4yV0lDRGtCdVBFOWZDU1BwSGVvWTY5N1pvTThVcmhu?=
 =?utf-8?B?UER6KzZWc1dsbGJtVHJmQW9Va0FxdjRZRnlvZmRudEQyRUZGaDF2V3pYajVN?=
 =?utf-8?B?eS9lL3N3c2tjaWVGWFc0SElkei8xZ2FJbTdPV044RTE2cnhlUWs2S0pzNys1?=
 =?utf-8?B?OUxaeDFBdG1FYmJaL3V5R0JSK0ZyOUtSL1o1K0R0SDVPZUZHVHljTEI0UC92?=
 =?utf-8?B?Z1crcUhtUEZHNFlDVVUzdjRydVZxN3dURUJiN0pnK202VXBKNlhPT1NnSlJ4?=
 =?utf-8?B?d0djaGczVUxIWEU3UnFsbG9KaG1oS3JTRlVkVTJTNC95R3VLUDQrK1huKzBO?=
 =?utf-8?B?dEFLVEJsTkd4WmVnbW5USE42VFhQMWJpTFdwRkNpdDkwdnVmZUFhbWcwNllx?=
 =?utf-8?B?WGpBYWRCUDM5YmhRQm1LcUJuYXFFYnlaZjJBYjNZUWU5RnpWdng3K0lCeGNo?=
 =?utf-8?B?eGxTR2psdDY3UXV4YVJ2NXVMMkFaQTV2QUJTZ3VYRUtjVTlXWWRrTzNNbThj?=
 =?utf-8?B?R0VEVmFkdEcrTzNUU094Nmx1M3JlUVloeCtMYnplbDlJTEovbStqcGtYV2JE?=
 =?utf-8?B?a1NqY3l6NitrTzRlMGRzM2hLVVJOM2VvcFFUbkx3WCtYQzFBaWoveTJSRnZB?=
 =?utf-8?B?NjhHaEluWWhYZldwWlFKZDNtZURheVYySmgxZTYzZjZDTFpsSnZtWDUwN1M1?=
 =?utf-8?B?SWRvbXlDa1BHeWJyU1NMVml0bHhweEJDTHVjU3Z2b2dZenZYbFA1bkFoMVN1?=
 =?utf-8?B?eWFvb2M0UlpZRjhlYStodmpKVyt4SmlqdnVVWlBaMzFsK28vcVFxL25Wd29D?=
 =?utf-8?B?b281d25YNkxSMjRGSHZGSDJ4NWt3V3NsMWVMbXVLNG9Ma2hVbDYrTmQ0djRq?=
 =?utf-8?B?OXFFVUNyVW1ZRFB2cTZScXR5dGgxVS9sTDRjY1I1dXE5L0pHTlJ5SkxhM3Jk?=
 =?utf-8?B?aVNyTDBwS3I1OWMrNmJrMVJPb1I2VWJ2NENRanJIT1U4R205WHdSZS9zRlNz?=
 =?utf-8?B?eUE4S1owWHlMVHBqKzdFRVdGTkNTdWI0bEE5WTh3b2tMejgvWFNVeDNSTFkr?=
 =?utf-8?B?TEFqSGF2ME5vdEZ4WkF3VWtYdTQ0MmV6YmdxMlFQUVVud1pTNk5vQkpTWFpl?=
 =?utf-8?B?b0VYeThWQWp1dTkrTFJIOS9BZGptZElZN0pEaGNqOS9WZk8wWVY5ZWMvaDJu?=
 =?utf-8?B?eERZclJ0a01iRzVaMVRhRVQ4c3hLTWwwQTFhU1U5MWpHQjF2NitxR0lTeEkv?=
 =?utf-8?B?VDRVM0lhbmVoQlEvbjZSeWZKejdlSWQ5eFRyRHF5QXdDbFNMSGNuWHkveVcy?=
 =?utf-8?B?bGxYVldBSUdKcHNWRithVDJmQmlaMGMwTjFhUzA3NzRjSXV0TDhLNEVRZWpM?=
 =?utf-8?B?dnBUaW8vUUtJaHdFL005Z2RnMUV6cTJPaFh6bUJNTUhncE1IUUxqSlFSS0xG?=
 =?utf-8?B?d1hKZGxlb051cHd6UzhzOERINWlKTTFHWFN2MTc3MER0c1NoS2NOdDJVbjQv?=
 =?utf-8?B?Tkt5ZGR6NzlvMi9MRjRRRTZzUDBmOWZMWHJycFhwMUt1RWN2cDgzRVVTQUJ0?=
 =?utf-8?B?djNZL0tvOVlJNUxGdWJBU1ZtbzZTU1dXWk9XcDlGckg0WG5GbTJHalJISnRv?=
 =?utf-8?Q?yDfrmmXnZyfwKBkKtqeFA5g=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8baa5573-1ed0-41fb-f482-08db3f23027d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 09:06:20.4338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l16HIG73u0fjuEwAu1TNAnOIYWSOsO6/3JwyikJQHrswdF/BnRcHsEjeLdzbF8LY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9150
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/17 15:00, Torstein Eide wrote:
[...]
> It is top level subvolume (5) I have mounted.

Oh, I can confirm it's a bug in btrfs-progs....

Btrfs-progs should be able to resolve the subvolume path and open that 
subvolume directory without manual mounting that subvolume.

Let me fix it first.

I know I'm already asking for too much, but you may want to prepare a 
build environment to build btrfs-progs from source, so you can later use 
my fixes to properly resolve the logical bytenr to files...

Thanks for the bug report,
Qu
