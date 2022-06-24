Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B655559AD8
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jun 2022 16:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbiFXODC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jun 2022 10:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbiFXODB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jun 2022 10:03:01 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50082.outbound.protection.outlook.com [40.107.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6702190
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jun 2022 07:02:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ia0otPOTTiu26CvXfHJW5c4Bs0BUgBrB+pS8EQVRGZBiD+9uPYADYonkJt5MSEDBMfyXUHH2hI0qv9F+26CwhAn4xELQn4299HazwZzSDgb7nfgXJu6tqvHywSbDapYV6ymQlhuP6pXzji85pmjd45WlSdPE8UE9BQdg2z79j4KHkuVPHcs8xbodGTFWVCH4eboBVWhuUdjkKEM9uPx+fAGOV3tgKKWJh4qTefIdFdKxGf/zP2qNTDuijM0Gel6CMygX2BzRgIwcf9Kw6TcIGlPdIc1XSC0wpmj8EnGSVyIjuAQQQ6lu0gHGcJpvVkNuzwV+9ADVIOovmyJKcgVItA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhozsOuH4FjTdVXmh5F92FTW/6nVj/2EyxasLSqNPwo=;
 b=HGztLripu9R70+nCXfPmqpWkz9s6/FPcunRObQT8sO0VWD3SdmCfbquHbr9Av10+wkl6tZN766f+oRqvti6xY0LNfbAVpBPhVdHVmff2y9yvu8svyOcE1h74Vfdodou+iH/2whcknDvNOV5qgBXHFAIUcEBxGC0omwSqIXRE2a7ySD/QGKEB4iAfUGRGz4NW7ckWGZ/lwv92F5TxUsttVhXlBASb38+xlcvUPFWkIEXO//8J+7Kh2YpgIlca2ufjqo/3ZEAItjS7mAGzg1Eb+XpBHAKfv/B71iU2In4kdPIddMDEG+1In+X37OS1jbfW8+4i5rTJ6emGYDcGlppMiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhozsOuH4FjTdVXmh5F92FTW/6nVj/2EyxasLSqNPwo=;
 b=bs4ZBX32osuw+VtNtJCuMWLEE+A7alcNsJV1wFBDRR0jkixUIdOQt+6jmmkVdmdJ7a/I4+oHuYFHRDVpIjxDccd/M1WEtg0Ed9NwiyRPZQNQpZTKkVjT5L0jh3CCD3cmW4a+sEbDBmBlnVbqbdjmQnFHl6j4IL713g1PS6k7vRmmTigpRxwtzk11OhBXCYpOczgIuGw2Orzpoe+SWTrL8kuBp3rVusXUVCASwmLvERuPaE6aAq7ohckJNy9LPJA3qn956L4V47KybZhoU3KrcnfkKOz6wFmQ2rfCb9bol7b1DA1EbF0NAMwcO4LCaqWdL/qmi0CxfJpuOjv2Zg/JXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM9PR04MB8472.eurprd04.prod.outlook.com (2603:10a6:20b:417::15)
 by PA4PR04MB7936.eurprd04.prod.outlook.com (2603:10a6:102:c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Fri, 24 Jun
 2022 14:02:55 +0000
Received: from AM9PR04MB8472.eurprd04.prod.outlook.com
 ([fe80::5043:18f:a30:fad3]) by AM9PR04MB8472.eurprd04.prod.outlook.com
 ([fe80::5043:18f:a30:fad3%5]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 14:02:55 +0000
Message-ID: <75cb4383-72e3-58d6-ca23-fbfa9be65617@suse.com>
Date:   Fri, 24 Jun 2022 22:02:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] btrfs: remove MIXED_BACKREF sysfs file
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220624080123.1521917-1-nborisov@suse.com>
 <20220624080123.1521917-2-nborisov@suse.com>
 <21f7eb10-09d7-826c-48c3-ded892984d50@gmx.com>
 <3e01475c-8296-4cf1-14cd-5774d780b6e2@suse.com>
 <27f72ec4-a365-20ba-03f1-8d603a66e011@gmx.com>
 <20220624134706.GV20633@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20220624134706.GV20633@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0018.namprd10.prod.outlook.com
 (2603:10b6:a03:255::23) To AM9PR04MB8472.eurprd04.prod.outlook.com
 (2603:10a6:20b:417::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c58103d7-b732-46aa-e49c-08da55ea3c34
X-MS-TrafficTypeDiagnostic: PA4PR04MB7936:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CShdwmpqI3sONLDZZrfCvxYt89QtnjkQI7pOh++8tLs/rZchH7Q9zADjTiSlI9+SnfbP4TNJOVnQSq2AWFbEbniB8G/Zhv29YerAHEH1VW9wqsSIYbCoLs0y29EvyDRFd2RpzXgZSSzxIcdmchSX/FAjwjNGCidB7iF2/dC+87KVZAan7+TpxWMD5FSW9RTUZJYM8nLBi494azDx1UYD9AkzTcN0vkDABMc7IPq9lWvffqujYXmPaGkyDuW7gks8zORF1q6siLZgjA2E8TEhcfcvrUC7IpXTUuXBmO510MvXKk8UirbI38gxciULi1hUKdHHkvsb2gvpIRBtEMiECqso/UvHH8FjLrIbuT8UShIpx9EZ5rVnRVme06dAPLkeSIq+Au4XDLPeiRxa5b9pj8KF8Z2JPocu7Zw1tpX7KV5PmCTo7tGv7EE2ND9pX2iECpSqwRyX+5agAzsMlNUjq2Fn4ou8VnMQJsvQJQp2OIUX4zvZxzWuoA4y2Dd0/y7BwBbpC2gBkYvppxeQEoDjjqXxjbjyOfBmaF53QZGXXMB8JBH8qHVk2qKAvnPamxsPzoHccfm/ngcMUnhKPdZIatooINTozNbVNNdNmrhI8wt5cck+vx5BYkuKvHGqidKzZKvMRtqzYRN7DMREdyy2yxCbq+i6DoSKdwOQbtnVGJA4tg6PTeVZ6dkbGgVbqgE2asrN9NCPedfsUGlOcdDJ8kDkd3Ky9vN0y817z4ynaKtyPdNWbVWyQnYb8/msn0i6NiwtO++gRgluhkxuErimXraCnXHWZEX6GgDVKRQpGsqitolPQNhJRONoZ+ROkqUi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8472.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(39860400002)(136003)(396003)(366004)(38100700002)(86362001)(478600001)(31696002)(316002)(8936002)(2906002)(5660300002)(8676002)(6486002)(110136005)(66946007)(186003)(6666004)(83380400001)(53546011)(6506007)(66476007)(66556008)(31686004)(6512007)(41300700001)(2616005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wkk5d2g1WHJEOCtuU2lGYmdtZTg4dmlicC96a0FIU1UvMC9RdXM0V2FMcFMx?=
 =?utf-8?B?UDV2Rm85VTIzbEpVcE50di8veTJySHQ4WkhVKzdXenJqUWZob1Fod2lpUzN0?=
 =?utf-8?B?T2x6elJ5eFEvUno1cTV0aDN2bEFDdXM3U2RlbVJpUEJ5Smp6cjZ2R0JFMUY4?=
 =?utf-8?B?RkNxSVE0cjkrdUxHQmk2d3dmcENRMERZSlM4MnlUeGE5MGwxSW5VZFAva0J2?=
 =?utf-8?B?aW5JZXQzc2ZrNEN3cTFlRDBvOERxd25XTm41SERLRDRLN2lJeUY0Y09IMTk0?=
 =?utf-8?B?bDBXQmxWckZKZnU3WENNVUtRZUl2eGlVSmJuaHlaTkdBYWNIZjBnM3NDQWhY?=
 =?utf-8?B?bE16Q3NBTTRqM1VldFpxeE1WZDhOK0o1TzRVdGlyZ0IrRXRmd3V3OXRCdWww?=
 =?utf-8?B?YnpiU3VESys5VWw3R2FObkZqM2NTZ21VY1hkTEJMdWUxZkhkdHpXRmEyZStZ?=
 =?utf-8?B?OWR3cldGV1RGaTY5N1BxeGFvK1hLbUlCZEs4MU5hcWJqVlcvNjQ2SDVWVjJI?=
 =?utf-8?B?cnFGTndTTDlYWENXWHJpaGNVRlhwYVFlRUxWQVY5U2ZSYjIzZUM1bm9JcUFK?=
 =?utf-8?B?Z1Y1eVV4U0htZGhDbnJXaVZmUHN4TUlPVEpoR0NwcDhNdngzZUt1bWVjRFVT?=
 =?utf-8?B?Y3p4eWJldVE0SmRweXp1LzQ4aGc5OEU5eGp5cXA5NTNpRUErTU81bVFucmtV?=
 =?utf-8?B?NG9Sb1FGd0lpVU5nMTRMNFVldGZxNjNuMTZOdzlKbmRhL2tERFU4YkdFVTZC?=
 =?utf-8?B?YUxkdmdDZHFhUmp3cDNDNWsraC8zRHQxbE12bnF4cmFMUkNFNjFZQlZtcllE?=
 =?utf-8?B?RlRkZlI4SUowR3ROQ0M2QTBIdzg5Q0NFNnpjc3pqejFvN0E4TGRDd2tTN2k0?=
 =?utf-8?B?cHpocHd2cE4yQmhTYS9MbytlTXFraXMvK2FZd2NwbnNya1pabmYwRmhuQTJW?=
 =?utf-8?B?dlRFUTN5SVZXNmhQdmE2TGw2dUErcW1BM1Z3ZHk1N21HN3NpWXhCOTNwRXlZ?=
 =?utf-8?B?WGJkd2pkOVlRN0FpcHFKN3duQlRHcmhVYkszNTVKRjQvRllhWW9aWm9FUEFi?=
 =?utf-8?B?d3FLMmxpNFYrdktDcjFWUjZ4ZVJUdjNtQVQ0WWR1UUxvYlhBRVV2emNPUDRR?=
 =?utf-8?B?RHhpSzc5aGxVSTkzVFM2eUdKcm85VWNESjhZOTRiaDhTZHNCK0RsSTBkUUp0?=
 =?utf-8?B?M1FTVWJ3aDVJTGpvYUlRZTBjelV4RS9hLzNoWG8wOGE4QkRQWVZiUHI2TTlT?=
 =?utf-8?B?dkEwWVcrSlVod3VBN09JTndjeUZGYjBKbFFrNkVFU0Vwa2xyWU9YcUFVMGwv?=
 =?utf-8?B?SWM2VCtsNFFtcXRLZHVERjkranNoOEhOZEx3ZUxKanJWcFExOUpoTm9rME81?=
 =?utf-8?B?NFdWVzM2RXBJN2xjV2NCeUdUejkrWTVBS2xRZkxFR0dGUVR5NUtMSUFCQzdw?=
 =?utf-8?B?S1RCRFR0YUgvQzNNVFNybmtib2xWTHNxZ3BGYUJSeGFjY0Z3R0VNYjdwZkhK?=
 =?utf-8?B?dGN2OEliclg3Kzd4RHVHUE03Ums3bVQxWStBNjBxM1BRSnZZNUc2NWxHdmdG?=
 =?utf-8?B?MmlkUnNPemY0eVJJNm9POVNDMmh6QTV1dWcwMExWOFZoa0RMeGE3SlZiakhs?=
 =?utf-8?B?NFlMaEZQT3RIa1VSQmt1MnEwYjVaMnZEbEpzTDJ2bkQwRisrMzIrQm14eDcz?=
 =?utf-8?B?Z2x3V0RuOXJhTlhCL3dheWlZeW9hemlxTGFxNDNXWThtMmRaKzZJaWVRNk5t?=
 =?utf-8?B?Rk00TmFyWkJzdFo3bXJQdTdZVlNqd0c0d3FraksvUTNld081M1Q5b3dNQVVr?=
 =?utf-8?B?TUlkWTAySU9ncEI3N2ptYm10UDBDMW8rcUdYOWpQaS9OK2tKRjY2d2VMVzR5?=
 =?utf-8?B?Ykd6M2QzbFZqbU5ML1M3eXdGNE4rQmd2VnErMUNkQWxNeDNyQ3l1OEo2UEEz?=
 =?utf-8?B?VVJtVUY3R2JTSzBkdy84czM1MlRsaThzbG1GbDlLZVlUOFUyZXlwQ2hUU1Fq?=
 =?utf-8?B?OGtyS0tlYnhmcEdRTGtxYzdMSW5WZm10RTgybXVQQ3U4N3orR3hWQWRWTVhh?=
 =?utf-8?B?TmJPR1h2eFBZM0VhaW15MHUwa1k4MWpjS2ovbnBvK1J4V1ZRUVRSOUp6b1FV?=
 =?utf-8?B?Q0ViZ2dsOTFxRFdEUFNTQWZvR000cnN5aWpJNktHeGRRMGo4OGY4Q2hEaFJr?=
 =?utf-8?Q?JQ2GhI098L6HHKX0asizP50=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c58103d7-b732-46aa-e49c-08da55ea3c34
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8472.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 14:02:55.0759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNrCb9JppWV84xs/gYHqJ97wFFnfWyaeDVKtAYujyuuzl4LXrtv3q2V6uHQLmfeE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7936
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/24 21:47, David Sterba wrote:
> On Fri, Jun 24, 2022 at 07:46:12PM +0800, Qu Wenruo wrote:
>> On 2022/6/24 19:32, Nikolay Borisov wrote:
>>> On 24.06.22 г. 11:13 ч., Qu Wenruo wrote:
>>>>
>>>> I don't think that's the correct way to go.
>>>>
>>>> In fact, I think sysfs should have everything, no matter how long
>>>> supported it is.
>>>
>>> I disagree, for things which are considered stand alone features - yes.
>>> Like free space tree 2, but for something like backrefs, heck I think
>>> we've even removed code which predates mixed backrefs so I'm not
>>> entirely use the filesystem can function with that feature turned off,
>>> actually it's not possible to create a non-mixedbackref file system
>>> since this behavior is hard-coded in btrfs-progs. Also the commit for
>>> the backrefs states:
>>>
>>>
>>> This commit introduces a new kind of back reference for btrfs metadata.
>>> Once a filesystem has been mounted with this commit, IT WILL NO LONGER
>>> BE MOUNTABLE BY OLDER KERNELS.
>>
>> That means we're hiding incompat features from the user.
>>
>> Even if it's not tunable and should always be enabled, we still need to
>> add that.
> 
> I think the mixed_backref is an exception because it's been part of the
> default format for so long that we don't even remember there was
> something else. For users it does not mean anything today, moreover it
> could be confused with mixed block groups.

Then after some time, there will be some "smart" users find that we have 
one incompat bit without any explanation.

Thanks,
Qu
