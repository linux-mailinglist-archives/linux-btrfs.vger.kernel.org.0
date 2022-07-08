Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BE956B279
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jul 2022 08:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237141AbiGHGBI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 02:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiGHGBG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 02:01:06 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140045.outbound.protection.outlook.com [40.107.14.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32248796B9
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 23:01:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDuL82It4qBnbSrnuIsWmG0f0eJi94SVwlLo2KragJB9xK2uw9VH6VvmeXpdl94uAr19Ww2oJQa9oBna0gHitiAiA4loj3RX5nwt99MmbVcY+89MThXwKDCDzWq+oILvTdeo/CutpPAZO8275102ROPdji24tymcS1W1Ai/V8WdX/fOsVTkLB3XLChnlEMlqrD4gTn6gXcG4XoZZXs1ZPdfCSNf/kxx90EdoNOSY8Nlg7KbmyX4LEp34WHYkpeS5Z3kaTwr1yz5SKEBhjc8TkM9jLB4NE3jSv7iJebn9DHZscIoCsqVB6CGnSyuXdPvDVhrV1+nIhCDMZd7bqj3usg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ew5Ellk12YaHftujnvksEjGPfEAOL/dIxMW0nu5vygs=;
 b=YZSE5cW79WQAESsKxSdf2Bs8UAlLkhvoK/lwcSVFOrL//ZDSpAn5CE69b8xDfoa6+7hFgXr286qM0GNmHwChxdpHG2UvIEvDoqQQTSbMzEJgk0kPQB0Of9MQvubhKthctxMUvruvpVoV26GhUihu0gOV2d3zLhPAP8CxA4WUABup5EfGP21liEqxqbLOYPspfOfdQq2nK+SEMrW9++QbkcoARHFPJ7v99kSy9AQENyx7XkCaiIZmCVM57eFXQzdzsQMb2sisqW2SqFhibUjffGJKB2yutyzd1awfmb82eoF9m0pMaSjS13jkOz6dMff/AD7TXzWGRboyZHqAMUf5/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ew5Ellk12YaHftujnvksEjGPfEAOL/dIxMW0nu5vygs=;
 b=O3Si072U7qq7WZh0h73v96h4Pg54LPm/vbxxg6dxf4BijVQCb+Gm3xLrTEAat0KMLQP57CKs+qyFwSNwTjkJOnPIFglTMVE36sQ6A2Yd1HHS8k02s2dqiO7Ji8TQWW3el1XIoC17ggd4y19zRfgzwzv9ehkYq3u4tBu+KDvQA5/4HDWom4k//j0JxTypZwTmjvlwy5mO3JI8QiXsfRMMojz8iLWPDkD3FYVbbQLWNPYT475fb2uW0Pam8fcIJxiGAWs7MRLaiEauvNCixfecxlfgAaZBGl+4w5nH/sflMWFkj9W75L+cEpYQkhV+HZhMbBSdRmgE+v7V4XfJ8H3WgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AS8PR04MB7781.eurprd04.prod.outlook.com (2603:10a6:20b:2a6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 06:01:01 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::c48:27de:73e5:ea97]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::c48:27de:73e5:ea97%9]) with mapi id 15.20.5417.020; Fri, 8 Jul 2022
 06:01:01 +0000
Message-ID: <1d43c273-5af3-6968-de18-d70a346b51aa@suse.com>
Date:   Fri, 8 Jul 2022 14:00:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Denis Roy <denisjroy@gmail.com>, dsterba@suse.cz,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <6a3407a3-2f24-c959-a00c-ec183ca466ed@gmail.com>
 <3ed7ee56-24fe-4fe6-b9ec-857adc8924cf@gmx.com>
 <20220707165623.GI15169@twin.jikos.cz>
 <70241659-fa66-0b65-0efe-1a426d05dcb4@gmail.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: BTRFS critical (device md126): corrupt node: root=1
 block=13404298215424 slot=307, unaligned pointer, have 12567101254720864896
 should be aligned to 4096
In-Reply-To: <70241659-fa66-0b65-0efe-1a426d05dcb4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::45) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d3496ed-6aa3-4191-7759-08da60a73bf1
X-MS-TrafficTypeDiagnostic: AS8PR04MB7781:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z792hnVkRf5zLTocXtANWXN2E2CD00M5aSrwG+8WOAfM4KD9EV9nAJB9/ROpvv/0x+Cv2j+j03wx3x6rKaEtNumkR/BWBeJx6+xgXCk7Gjd4ehMyIBAkLHdtkY0yXikWIkOnLf7MbPvD1VXpCN72cKS3ZiZYuR3Mr7L2V+M3iqBlrC9B+1YTl4QvESt53YUUhmALzvH/W8G5l91fxOwb9c0x4/bj9oZRl6dJgBgda9kxVZWQ3OJoPIt//c5P7kmrsUIdUHTZVVZ0gvHcPT97hMuiGUJRgvWbT2Bp/TES38qRBzh0av9HVHzUK4r2ArcMN6WeqxJJ+FrQUKncIEMvlV0i2KY8AR+TdWXisuIeEBdIFc4BMKezMFJDh8QOZzv+XLAOavsMm4jg6O6tLMxOLY9fI9mkK9FTKBI6bHd7pDXSgw9IC9p9bj3BUF9f/2mDDQZkdXZ2lkQg+WbAR/jBg3xFntRbl1DAtAOsIsIb1ic8dQuE+/lcdrwuL0QBt+Us5DjlyERXJFNin+DQs4PaCZtLJ5UCjW28maypa75e67JvyYWXVBovSvDwQ9Jz/joa3cYa7hA4TTIs4N+VGvHktskm7o1M5pgxx3T+AjLIQd/IdAANI5OqvwX5KY63JM3J10fAoyMkBx1qni7hbYhaksdSWu8dTr6Nlg81W/GGgpUdU5wxfr/q45SV8rmaGNHSCoxR2/B3eiXRyCEC2yiinBQ4T8yjq6xxbyM5QUbsx/cio0cq1nt+vvd68/9h5CKxx42MhVQ5xrPjH+6RiG1WlKq2T1UH3yzwGJ+HD7qqxlAI70XxXrYAsOViL0zGgZABHuO0RWIf3kfDVNZazQ7Hjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(396003)(346002)(366004)(376002)(83380400001)(186003)(6506007)(8676002)(66946007)(66556008)(66476007)(36756003)(31686004)(2616005)(53546011)(6512007)(110136005)(86362001)(6666004)(31696002)(41300700001)(316002)(478600001)(2906002)(8936002)(6486002)(38100700002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M01zcUNKSlFub3kvaVNpQ0J2dVMreDg1QWhWYTBFNDZpTm9rcTZ5aVNyVytB?=
 =?utf-8?B?QVpOZ0g3UTcvL1ZwQjA1aUw1bjQvRTQxY1owL1UrNmlacEdCVTN1YmdUNVVV?=
 =?utf-8?B?QXh1Q3U2cUpkblM5clFvS0kyTVFHZGJNcGNyRGpzQnBHOWdzZ0prQnNsV1gv?=
 =?utf-8?B?ZDRkKzdkR1hpbzBIUEUydjVkY1B2OHhjaENZZGVQWENBY3FEbDdqd0FPMk5w?=
 =?utf-8?B?RkYyd2NuVFlvUnVPazN3VlJwWWRkK2xFRlY3UEVvM2wwb3I5cG9WdHpUMXZE?=
 =?utf-8?B?Z0I4RU5BQ1AwTzRkQTFpN3pYMUVvMFBoNkhXQ1hMeEVJRkI5N3BxZ1M0VnZw?=
 =?utf-8?B?MDhHU1RXWmZmV2k3SGx2eVhWWm56MWI2cHk3TnJxeUEyWFdXQ1VXQWhmb3RQ?=
 =?utf-8?B?Q2lIUjI4THA4aElLTG1KRjRxYWt4ZHdURjdpTkxuckRsSENYWXRXZkdFazZl?=
 =?utf-8?B?ZHNpZnN0THlrY0VmR2Z1a0VDUC9QZWNhUHkxOW5qZFZ0azB1M3laSGUyOHE2?=
 =?utf-8?B?cFEyOVVwUmNnMFBteDFheDNtSG9WU2VzMWEzWEVML1hMcmQ5NTFaeTVSY0Nm?=
 =?utf-8?B?bXZUT2JQNkxWcDFOQjNnSkJrcTd2eFZSQ2lBRXU4dGdUT055OW1Oc0kvSXRM?=
 =?utf-8?B?S09RNEZleks4Ump1SlZSSXFkTy9tL1ZiQjQwL280aTJDRytRbWQ3azZjc3VU?=
 =?utf-8?B?Si91MFFsamhTb1JEMURBcEhFRWZ0Tnpmb3c2WllOM3BwUjZlQWNTYTVBWUlU?=
 =?utf-8?B?NFlTSHlVQ200a0dTcWFOb1lZMWNBc3FGN2VUUWdIS0lZMWR4TWd2bG9sdUVQ?=
 =?utf-8?B?ZlNzSXZqenZOYy9yU2h5dFlyRGFyYXJ6QWI4eWsyRzB3SlRyN2t4WU9XUW9L?=
 =?utf-8?B?TWpQQXpoS2pKOUovYVdkSEgyWTF5cUtaOEd2c1ZheDdEVmExanVJeFBIZzRJ?=
 =?utf-8?B?V2Y0WE9YcTJMelpLS0JVbkx6TnlJTTRHdXlMb3JMOFVVakZZb1hBOUhOdUVp?=
 =?utf-8?B?dG5JK1Vkb2lPWXBUczdnMlR0SVQ4cXZFMlNobTNmMThYOWtlQkEzenpYOURr?=
 =?utf-8?B?d2VEYVN6QU5qbDRPQ2JXc2tkbFV6MGlWQTkwYm1qbDdpMm9jbGxOaW1YYVNQ?=
 =?utf-8?B?MHJuS29FeDUwVUVaelB3Q1pPbVJwdEFJSFhFZnRSRE5EL0hBVXZXMTRWeW9Y?=
 =?utf-8?B?a0oydkROQk5VSE5nY0t1ZEJPdEFuTzVnRXcvK1FqNGFJLzN0QXFmbzRIM1dm?=
 =?utf-8?B?SStLeXZFYytrYldTNEpqaUkxQW1obS9IbzZlUWlFVDBRN2d6K055ZHlTQ3Jh?=
 =?utf-8?B?VEI0dHkzSG1xQzhoS2tQMFlGSk1aYVpkaHZIY2h5bHZsNUt3bmNTNzVVS1RX?=
 =?utf-8?B?TXB5UW1HYkN1OE5Ockt1SHQwN3dvRUx3TVhKeHI3OEVaVXIwcDJJWjRyNkpR?=
 =?utf-8?B?RW4vVk9IQmVKdWFXNW51ejZVK1FIY2VhVEFOVkJicHRQNWZIYUFsN3JzNlJj?=
 =?utf-8?B?K1hoUzN6akhBVlhkbHY4Wi8rVTkrRi9lN3JJMHhodGF6UC9YcEtpQlEwQWoy?=
 =?utf-8?B?d1JVaHB2UHFLaGFEYjBxY3QxTis0TWhKRlB4STN2Ny9nd2g3dmVpZXF0d0h3?=
 =?utf-8?B?S3AzY1JBY0w5RGk0aUlueE5mUDZIWW5FeTBOcWVwWXlyV3V6MlJhWGw5aTcw?=
 =?utf-8?B?KzVDU2ZNVjhlb01rTXIzbFJDaEEwN0dDbUFML0dDZ0UvSXltMjc5dmZJT3B2?=
 =?utf-8?B?TUdUL1A1UkxKK1RCZ3MwcGJkS2JIWlNqbWVZSk9ZWDVKcG53ay9YNzFKN2NO?=
 =?utf-8?B?c0RMMk5GRmh5QWxPK2VxemZOZkNIaGloeVhwcjhwUUNRNzZmWkorS1RvUGtp?=
 =?utf-8?B?UlhZSlJpUHV2RkNXYnVqd2dmWnBLVy8rL3hUOG1mdEhrN2wrMittSC9ZMmlh?=
 =?utf-8?B?Z3VYK05oZExQbEpYem5qcXRGQVVNYkJuMDk0NSthVEorK1lPZXpNck5mTGVJ?=
 =?utf-8?B?cHBQNllUdUdEOGo1bHhZZjVXVzdESS93YTRzekNDOWxlZUo3MldzUm82TW9W?=
 =?utf-8?B?SnV0d0g1ek0wZFR0VWZTaGRYa0F4VEUwTTNXaC9FU2hMcGJUK2NQODZmZE5I?=
 =?utf-8?B?ZjA1SkFBVFBpZFdmVGMxOXdGekJVejUwckt1V3g2VmhKVXFFZ09DUTIwOWtp?=
 =?utf-8?Q?AWPXRPOWQI0olyzpz/FUsko=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3496ed-6aa3-4191-7759-08da60a73bf1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 06:01:01.0643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCLNPFYMwquJMKiYT0DdpsqsTD9VTO7h0pCZOhlw5PIgZpe5ZWRD5Zr4q8zEn4H2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7781
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/8 13:50, Denis Roy wrote:
>      key (7652251795456 EXTENT_ITEM 72057594063093760) block 
> 12567101254720864896 (383517494345729) gen 72340209471334675
>      key (2959901138859622420 EXTENT_CSUM 3664676558733568) block 
> 2234066886193184768 (68178310735876) gen 18374696375462128179
>      key (1153765929541501184 EXTENT_CSUM 0) block 0 (0) gen 0
>      key (0 UNKNOWN.0 0) block 0 (0) gen 0

The above dump shows the tree node is completely corrupted by some weird 
data.

The offending slot is not aligned, and its offset (extent size for 
EXTENT_ITEM) is definitely not correct.

But the offset looks like a bitflip:

hex(72057594063093760) = '0x100000001800000'

Ignoring the high bit, 0x1800000 is completely sane for the size of an 
data extent.

The next slot even has incorrect type, (EXTENT_CSUM) should not occur in
extent tree, but this time I can not find a pattern in the corrupted type.

The offset, 3664676558733568, is also not aligned but without a solid 
corruption pattern.

And finally we have an UNKNOWN key, which should not occur there at all.


So this looks like that tree node is by somehow screwed up in the middle.
I don't have any clue how this could happen, but considering the 
checksum still passed, it must happen at runtime.


For now, I can only recommend to go kernel newer than 5.11 which 
introduced mandatory write-time tree block sanity check, and should 
reject such bad tree block before it can be written to disk.

Thanks,
Qu
