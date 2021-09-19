Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034C7410DB3
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 00:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhISW7E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Sep 2021 18:59:04 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:41538 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233210AbhISW7C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Sep 2021 18:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1632092253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=12XhmiX84IcnXVAXtZ7/XpinVBxgW+zeWRdGb51ay9A=;
        b=nRjKwiQ/eMSWT4IfhlpqQPKEOPkYyx1Btk+BK3fwKZ5FMT9sJ57D1t7HgdganQqrOeTRyk
        yZMFjPzdFcK1GRZkVT4Oe9QHN/udNkG+QG/cpZWtAI5WaQu4D0Dw/Fn/MrXLHM0icLMD//
        /1QaMtdXKstcEZ7ZBqUp4vnBxm8T+OQ=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2055.outbound.protection.outlook.com [104.47.6.55]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-21-4Ln0e-gHMNqFQwTqLDhf9g-1; Mon, 20 Sep 2021 00:57:32 +0200
X-MC-Unique: 4Ln0e-gHMNqFQwTqLDhf9g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsqvQqjWKSAE+Rq48HPQUDajT9sOKGFEbPPa1dPxw1WmuqcdMZRMO7twM5tHnKYeIsQCKl5lU8GhwfmHFFMleqfCldqg2LrUit3NmMH4vOf7/IY8gVYPf5/HJlGLozirpIXFrU+HYkMA3YP00CC9Hfn7LfFsRAUvFKU1ObZy22dibiE0reOSGMcl/7ARmmOxRjUPazxfdIbXeI5nehpXALVZEsk7iXpfSQmbUPtTLiEXURJQpiLtTVn9hnKPbQkuq/5ev4HLBb+mZYdR1/xg8t4dM4rzpQ35nHynyPvt6rB+8U2De4YTyjOe5lCLrZCuBcg8ZDRjXZGbZ6pLxlum1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=12XhmiX84IcnXVAXtZ7/XpinVBxgW+zeWRdGb51ay9A=;
 b=UbAwRKSxg8osxDXqsT2E7YD/eO4kWVk/xblCoR2nGKtFYnxZDmyDxeK0dqJPcRtwsfjtlyH5rsaE/2JCTFnxF/nU0+3vrOifLoKrij5m5ChsMhZ5FFDJR1i9eam/ZxkN6myCEf/2L3feOoYeBPbBBPxzc8L62Es8+5KYQXEXowJvNSRNhmMZhf4/tpIbyNSEiOPiymfeobuQLetZ1mpB8YNAwjFO+MkaUA6EAOyR0ycu1e5h3vB9hvJUBQXOh0K9DD6TSuC/jaEoVISER2qzHgOAGPOrYWLvCit+cZJsxK7mxGgcIpMudPBRNkA3QAWOmDJ3Q6QAl6SAFP3v/PtIgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: armlinux.org.uk; dkim=none (message not signed)
 header.d=none;armlinux.org.uk; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB5079.eurprd04.prod.outlook.com (2603:10a6:20b:4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.18; Sun, 19 Sep
 2021 22:57:29 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097%5]) with mapi id 15.20.4523.018; Sun, 19 Sep 2021
 22:57:29 +0000
Message-ID: <1159c919-39aa-0a03-6963-b367863ded7b@suse.com>
Date:   Mon, 20 Sep 2021 06:57:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <E1mS5UF-002wsg-0c@rmk-PC.armlinux.org.uk>
 <b4f6ec59-daa8-d4bd-d6b9-25d854eb70c3@gmx.com>
 <YUe94+ksRJrkqp16@shell.armlinux.org.uk>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs: fix initialiser warning in fs/btrfs/tree-checker.c
In-Reply-To: <YUe94+ksRJrkqp16@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0144.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::29) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0144.namprd03.prod.outlook.com (2603:10b6:a03:33c::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Sun, 19 Sep 2021 22:57:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 988b012d-eafc-45cd-887a-08d97bc0db33
X-MS-TrafficTypeDiagnostic: AM6PR04MB5079:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB507965803D52AEC6DDA1F850D6DF9@AM6PR04MB5079.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BI4b87WXvKX/qOHc+uJPLKd50sr9RC9ytKQzaXobB8Muk9NjC42HaJ4TuGNNtyFOacROn88zDuGe1GaxVGwKRKbv0vCqu8ZcCLrETMUGCYKDV9IPwEAxO+tydS7WdIlvytf1+HeQmuYQic3fCx0qwXFLsDFKdMsbxfbhvqvAqwzg7kmAJMvI0iuyilFXUV5xyfUEOvrj5M/+s9tRdqNUtOep+Ja+TEQl9EFzgz2Df2GRw4j3SCmy3X6Mjm7mQ1zclqa94ZWcWG73/wyDoaPejQ7kBrUJEjxdl88q6huZIi1Osk3o8r3YcU812ICAokXTog5Ab4L2Pu0HwGdsxNJ6qg6UYXHqng6YfZr6ttgHb8VvIdeAfiKh1aSz4EAsvq6UqKHNTuIbS9Nrcm7d5pt8m4xK8J2Pxyq6DRHxEmQUEIBU6KT8luz4RwuydUTsVOTWQ9OJW3BBsaRbFkxJX60u4GJngF5LxB4E+6RxxSindlWsvTuL1WWNkzWxRY5VU0uT+l4x+AfA/ncQjbMPhORyv1zt6fKJ258LdRO0I3H4KTPemd7vrRNtvQ4BbCYr4YSOFVqp8HBg7GpBCb2Y0iNrwpf91tAm/xuG9t0+JG58eIRAcJgz7SfH8sErz7f164u/mE0wqZu+IOCyWJ58UwgYM5DVzG0i6e/cAkvpRzNMTBgy7GxlEaIfEYYKby6e7HIb/amQwPhFHh2qjGHv11tWZSl7Je9dMyUDbUN+HRNRBX8J6HiZAluZKF6++U+WZS0+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(39850400004)(366004)(136003)(31696002)(31686004)(478600001)(186003)(2616005)(956004)(26005)(36756003)(66556008)(6666004)(110136005)(2906002)(316002)(5660300002)(16576012)(66946007)(66476007)(8936002)(8676002)(86362001)(38100700002)(54906003)(53546011)(4326008)(6486002)(6706004)(83380400001)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTJHL2RJa3JKbDFSdThCRjV3eVdIZjlHR0haQXNJUXJQSmM5eGVSNVJKTkV1?=
 =?utf-8?B?RXVFeDZnMnZZYmdpQ3gwTUJ6R1B1WWtDTmFLYWxHN1RhQjk3ZDBaSUs1OU0r?=
 =?utf-8?B?ZlBIaVhubk1hYVdaVkFBMEFVQnJ6blViTTZXQ3Bod1JjWklNaTBIWU5mZUNL?=
 =?utf-8?B?WnNMQnNCTllGbFZTc2ZpYzFnOXh4c0o2MEZHL0lWRE9WaDRhWHRGdnNrTktG?=
 =?utf-8?B?SVpPQzdPcGxGNHdrWXRKUlRCbHpHUlF0MDFCb2hTbHZGWEFNY2N4ajRLeGNv?=
 =?utf-8?B?M3lWa0o1ZUY4UUlCRlVYc3R3VktJd3N5aEtUR1dicGZuRmFxeHpxM08vUUZi?=
 =?utf-8?B?VWs5Y1d1bUFMRzVoWE9ndGMyWS81MWNCRjREc0oyTHhkNGdYOXZ0bkVMUWxH?=
 =?utf-8?B?VWJFM2hCZUxvMURUYW5xWENFeExUMW1NMm1DZDZDcFY5Z2U3enN2U1JjQklD?=
 =?utf-8?B?Y1B1UjdxcWYxNSthbEhyV1JGelRTODJtTldORGJBM1J6MEhyV1ZlMnMrNTNh?=
 =?utf-8?B?a1A1VzYveGo2V0NJaDVWWlNXT3Y5ekwzY0o1YmhwbTJSODJVMlRVS1VteVFn?=
 =?utf-8?B?UGdxbHU1S1dXc0VGaG53bGx5ODRmd05XTlh0TExNeUdRc2VYOVowbTNVUXpB?=
 =?utf-8?B?VTlyYWM0azZsekFkR0RpaUhobUlFRGEvQzM5RlVQWGo4WW9WaTMzWllSTlNO?=
 =?utf-8?B?ak9aVXRWMXBCVlV1MTI5RlJHNUxGL0lCMEJ2WTZLM2lqMVNzdENiS3FmM0x4?=
 =?utf-8?B?MjZSWElOS3l2YnJaSFlUOTVwL2NIMkZCelpNc0NNM1ZVd2tjOTNVWWNJbThz?=
 =?utf-8?B?TnNxNk9ZemovT1FJZEI1VStMNGFCeXI5Tk9QWGtWZDNSekxlcitna3FTOGl1?=
 =?utf-8?B?UEQxSzY3bFVHZWprYXVUSzdIb1lFRW4zc3g0YnduZzRhdUhUWlQ5WXF4NFg5?=
 =?utf-8?B?YXRVS3AwNVFPM3ZPRmtQL3V2U3BmWFRkQXB3bjBwZ0VhNkdmTEZPWkpGQ1lX?=
 =?utf-8?B?YW1BbXZPUzhMVmFLQTdVdEZvUXk3ei9aVXdoSDZTVW9CazdEM1dRUW5HVHBB?=
 =?utf-8?B?akNpN1lyVk16WFZDMnhKYnVaTTZ2bmh1ZzRCdWtOVUZEQWtaeERtd2twODNU?=
 =?utf-8?B?UXh4c0hwanNJdWJpYTNBcVpCUitXb2JFUE0rTXdIN3ZOMDE0RkpKQzI2YnRY?=
 =?utf-8?B?TDJhVXdTNUJTbzhyRDFnaXhQNDNyNW5GOVNyTlNKWnUycGFkM2ViWmRXNzhm?=
 =?utf-8?B?bVZMcmFLR2RGYWFhbnRzMjdwSzI0WGErY0M3ZVhyQjlWTXVpclkzQzBlaDh6?=
 =?utf-8?B?YXlBY3NTRENZaktLR2JvTHhzYXAzTUxrTEdMVklWRlRMVldDM0gyVFhEVysz?=
 =?utf-8?B?ZUpSTlZ1Q20yVkdvalFZYk1IUVpKNkRkeEtYN0xPdUFjVFdBbXpMYXhiVmUw?=
 =?utf-8?B?TlFCbHFGcGVVTnVHbUkzRFM2RnBhNk9OY1FjZDJRNWJLNjZXM1RzZGlSQ0R1?=
 =?utf-8?B?Ty9yNHBNZmEwRmxRdnUzYUI3R0hYaUQvRFQzRS9vcjhadnRZVFpZMnBZYytB?=
 =?utf-8?B?UlI0a3R4dGtFSlowTU8vai9PN0V4M1U0VXZ2WnZSZmZ3bHlHYmp6YXgzd3l5?=
 =?utf-8?B?Z0FQbjVXeElMR09paTdreS9pZE5nWTNZOWludldXSGdmSzFTVVA4ODBuK21V?=
 =?utf-8?B?U0hudEI0M3F4b1lScTNiMHNsVTlOeXR4ODF2ZlZ0b3g3U24zOXozeUJHSXRl?=
 =?utf-8?Q?zdm8Ny/xbVn2nwHL3Oe6LHI6CRHKgSPEiSo/vMi?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 988b012d-eafc-45cd-887a-08d97bc0db33
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2021 22:57:29.4247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HrqfMHTHN4KldwuUjIq/N+ByglDqmD+nHZ65Red8HtQDV43x1Z9IDpapfNipalag
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5079
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/20 06:46, Russell King (Oracle) wrote:
> On Mon, Sep 20, 2021 at 06:44:58AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/9/20 06:40, Russell King (Oracle) wrote:
>>> Debian gcc 10.2.1 complains thusly:
>>>
>>> fs/btrfs/tree-checker.c:1071:9: warning: missing braces
>>> around initializer [-Wmissing-braces]
>>>     struct btrfs_root_item ri = { 0 };
>>>            ^
>>> fs/btrfs/tree-checker.c:1071:9: warning: (near initialization for 'ri.inode') [-Wmissing-braces]
>>>
>>> Fix it by removing the unnecessary '0' initialiser, leaving the
>>> braces.
>>
>> This should be a compiler bug.
>>
>> = { 0 }; is completely fine here, in fact = { }; would be more problematic.
>>
>> What's the compiler version? I haven't hit such problem for GCC 11.1.0
>> nor clang 12.0.1.
> 
> I just realised that it's not the compiler I thought it was - It's
> GCC 4.9.4 used on 32-bit ARM.

That's bare minimal GCC version required for kernel build.

I'm not sure if that old version has all the correct backports.

> 
> = { }; is not a problem for that version of GCC. Why do you think it's
> problematic?
> 

Isn't initialization with empty initializers against C89/90 standard?

Thanks,
Qu

