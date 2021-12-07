Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE82C46BA99
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 13:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbhLGMEu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 07:04:50 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:38858 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236039AbhLGMEr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Dec 2021 07:04:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1638878476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9OkToZdO4Q8aCVPsm40XSP5jlnQgt/rGZ4RRti3XI/s=;
        b=KdzQVaMugKQRxVsGML+DXYBS1d/WOt8VQbnsawClpSlfIeNrU4wxL161Q4zlVqhpC1s2uz
        6J10J8MF4NlP8BvIg1rDD4iTt39ZqbA7au9Y66yFdljdinsS09wuQMX00xXgHh1JGsp88R
        uweHrXtjma8FbGj5t6cuN89uoinWMWQ=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2057.outbound.protection.outlook.com [104.47.6.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-14-aJjVWEInPCa87HiFCQ-LYA-1; Tue, 07 Dec 2021 13:01:15 +0100
X-MC-Unique: aJjVWEInPCa87HiFCQ-LYA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaMUISccdWLc4Go9s1c4GSGOvklzx11+r+Kt+yLatOsoO7qWjSpItICKxjc4xGAQ1VFCb8cY0rQXeXlzRCBdMahT5bknsq/Pp3pzddsjvMm14vlyL/xGq3HCa9XKmh9F2G0MxQ7GktGAIigK5EiEzzyt4vWXItcX2p6UxuMqH7jAcBtErWF0iBsooJaI2wUOq80zjABD+qX+/bB5cgqpoqIyfQtqUJWb9q+bkc70PtYd4Dpq6KQrt55roXOF4ZlAN5Oq3VEZ84gNu2EpOlF2t9ZaVcd0yTyCnownFB9SKlAfO4r7oayOMOyTf9sXdqQ6tfDwoVG++IEX5DDmKPdtuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OkToZdO4Q8aCVPsm40XSP5jlnQgt/rGZ4RRti3XI/s=;
 b=DloZOAlyfdUkiR7aykDSep6x2DckslUL8en669CkFzqEcAf2q6ejnQ4OBVbwSCDwEhd+Z2njpVaOBiOa9CpnMrkWICEtPQIyqqttJT36/5fkNyC+pKhy38PH3BHf08rhaDMqIKNt9IBjk1hDyvD554giSXeef9y/QvfIM4k+d5stMomqJnAz9DKEFQOgrFeKNPDKH5g5vp9HxFHWENyuK7JfCnZbd6mdYpe+t0PjWIDHx5AYSi4NIYN72ZdXiwHvbo4fosWR341Kv3EGnj6V17TxS62Q+rl8cAJM7Zj4BXJrPiJANL48jjH4C7CY37nMIm4V/yZxnIiDiLaqPbivGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by DU0PR04MB9227.eurprd04.prod.outlook.com (2603:10a6:10:352::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22; Tue, 7 Dec
 2021 12:01:14 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::7547:9d8a:d148:986e]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::7547:9d8a:d148:986e%4]) with mapi id 15.20.4755.021; Tue, 7 Dec 2021
 12:01:14 +0000
Message-ID: <a91e60a4-7f5a-43eb-3c10-af2416aade9f@suse.com>
Date:   Tue, 7 Dec 2021 20:01:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH RFC 0/2] btrfs: remove the metadata readahead mechanism
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20211207074400.63352-1-wqu@suse.com>
 <Ya8/NpvxmCCouKqg@debian9.Home>
 <e019c8d6-4d59-4559-b56a-73dd2276903c@gmx.com>
 <Ya9L2qSe+XKgtesq@debian9.Home>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <Ya9L2qSe+XKgtesq@debian9.Home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::19) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by BY3PR03CA0014.namprd03.prod.outlook.com (2603:10b6:a03:39a::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Tue, 7 Dec 2021 12:01:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e1bccb5-19e1-42b0-573a-08d9b979445a
X-MS-TrafficTypeDiagnostic: DU0PR04MB9227:EE_
X-Microsoft-Antispam-PRVS: <DU0PR04MB9227170F09CF7BAB39B5FF6FD66E9@DU0PR04MB9227.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aUoqmYGFBL/8L5zpIOmMfb8vhkXMcfAxRH7hwolDhdEz0k8Xkc9zLbIxDkcx8jZo7weP+IxrOoKnQGftb8tgf++CtGiOvOsL6j1/Ow5XtVpJONPckLY8cLF8jciVBDfQI3NRM6CMRt4aVXX22d7S2MC76e6glmkMDndvEw09T1rbHtcunzv51P/maS1Kr5Kals9nbByG2iA0iJPQ7So7l3ePRgIbEDcSwG9wUU6vPVSA5NLH9ip0AUBPhEAbvlpqDNiFq3hRaZkIWrgJmtCNhowPogi2wsj1/T2G2bgpovuDu1BqmDWY/ZXJXhobXQW9W+a9y6l+BcC4LGRJPk/Sr0WghRrw33cSEqdlUUYt2+1BwfdV9PrICoU0bK+0+BCWttcorXqq7EmF0kTTJOJgVYY6WWxArg2MopMCSATUfOmcNh7XpbqiYGE0cWi0QncU04WMRENSTUmZWWSYpHO1kvo2H1U9yayUJf0jS/i+jWYhO0ufQzvxWzXn2RtQIxJHU2YXo5/i4MHD6BMBPdlK9OFZ7JQN91WLI13SxKNCbZTU5BCGTxP0KeOHYck0OO0sOwsAtf/GnzjIGSO8BLQt1r3Xijr/rX1s8ihWvm1bW7X7A2AtcyXA+wKZEyS5k4LnK1vqNgeJAThBdlW6RtOY9DXOStdXFlz/zhoPcGS4V/sPO1o+QAh9M6MVTzGGo0mqx0t12CVpwRLZnpvBQNNV2SXLtonAxMrfnveDQlYHPio/1L2Oz2S2bjQvgQgwNJEq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(186003)(53546011)(26005)(66476007)(66946007)(86362001)(66556008)(4326008)(83380400001)(6486002)(8676002)(956004)(2616005)(16576012)(38100700002)(36756003)(8936002)(31696002)(2906002)(6706004)(316002)(508600001)(6666004)(5660300002)(110136005)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlFIK2pzdEpVNForQlN6R1ZTZVdyLy9NSjdGczF4cnBuWGpaU1R6Ti9zdUx6?=
 =?utf-8?B?MUJ1aTcrdEpGUlVHL3piRHd2bUN5RVBOUlZXMHBDOHlraXVKZkVPdU5RbmNH?=
 =?utf-8?B?NXpCeHM0V0J1eGp6THl3R09zbzBsU2JzTm5lbVk5S2pqNG1mYklQZjlnbS9i?=
 =?utf-8?B?YVE2cWpjdmxvOVY2d3ZYckpmOWJ4b0dGQzM5c0JGWVlIdW91MkhuQ1R2eVVJ?=
 =?utf-8?B?dEdBb0p2aTFYWWpMcUQzOTY1TVpIanVvYlhad21uTkUzS1F4TCtUTWxLWmFW?=
 =?utf-8?B?eTJrWjBxeFpwTy9HZUQvRzB4MzE1eEFMZlU3d1haMzl2QlQyVUlabUdFUkl1?=
 =?utf-8?B?WE8zZitUK1dsYkIxNFJWSTd6SldTc2Y1ZXNXWGdhN09FWFowYXJnMmllWDYy?=
 =?utf-8?B?UW9iRGVMRTNPbkJydmpody9sWFU0U0J6M2wyUHJoS1lmWkxxbjRsN284SUVu?=
 =?utf-8?B?Qkx1VXd6UG8zYXE5NXlMK0h3TVBxeVpFTFZnTWZTOW5pYzZ1SXBqSmtDVjh5?=
 =?utf-8?B?dy9oSnNGdlE5MEU4QnF3ZzkyQnFIOWVmOXFibktqTU1uK0NEekZleHNZMHhu?=
 =?utf-8?B?MHpVRUZ3UElNREpOdVhMdzJBNlZJQU5CUEd4NG1ma1JUTEYvdC9mcVJnVDBK?=
 =?utf-8?B?VGNSZkwvMWpqL1dCNTMwakhTN3V3S3ZRKy8vK3hOTHp5SVJzbDZGMFhacy9B?=
 =?utf-8?B?Uk9LUmMxTE82NXVmZkJlSFE4NlNvb245a1VFSyswdTV0bU94a1pFc3V2dE1s?=
 =?utf-8?B?L2FCNi9HNWw0a3h0OUhaL1E2TjZEMWZGa3RjejM2TFZMZU9OSFNsUzFLZ3hL?=
 =?utf-8?B?UE5UNStjbzNQMXhGZ0Z6aGhmem1od1NTVmhDSFU2UXlOcW80aGt3V3BpKy9J?=
 =?utf-8?B?WVlzU01pejR4U2JjSlFLRTJIRFk1WldmTjY2d1ptSGFzbDN5UGYzRFNDVnJG?=
 =?utf-8?B?SHNEWi92UjVyeGVPZFpwWnAxQTVYOWJjUTdxa2VOVmtsbUhXU29nQWo4NGpP?=
 =?utf-8?B?aVgvTG5TNnRhN3RYNEhna2htYmFDVkpzWWNhK01JY3k2UFhyWUVrQmk4V2xN?=
 =?utf-8?B?dkVSWkNHajhqOTJZSCtzVy9XOGU0N25mbnJaRjhsR1F6RWIyY25FejBCOWpt?=
 =?utf-8?B?QWpDU3QvOVZLOFZZbFQ1Vy9sVSt0NzBLbUl3YzNDdDZSemFjaS82M1lCSEx2?=
 =?utf-8?B?MEpGNTdkUkZIcUk0dURSa2lGZld1WEliRG5zR1BWV2xjV1duOE4ycE81eStS?=
 =?utf-8?B?aG1Jam5yZEJlSDcxbkZGbGZETlluVUIxYnJnaGJ5VzlRbVF3eVFZby96UkYy?=
 =?utf-8?B?OE5IMVoxaDFPTlNpVDhQRFdWT3JYOUNVRjcyV0pGYWNvOHE0UzZ6ZFFJRXo4?=
 =?utf-8?B?SW9VYjZEdWJkeFdmaWJRcmhxMUZUbGk3cHFROUdmV3VmUHhteVBLOHE1K3h1?=
 =?utf-8?B?VDZYVSs1VmhQdTgxUTBZTktPWlFTZzE2bXZxakQ2dGRMblJreWd5RU5Eb3Jh?=
 =?utf-8?B?UG9nUFN5TUFpeW1jb2Rvb3JuYkdyNjFUQjBIVjdVK0h5T24vYThYb205elRE?=
 =?utf-8?B?cXU2cEorcjNtY1lRMk1JbEpaNnpSSHZ4YzhtL3VyVmZaVjJQbmpOd3FBdEVk?=
 =?utf-8?B?U3V1VUNZSFRZWDFQeVNnb3AwRTJNV00xSjBiWnZsMzlma3JvTHc1TStuakp6?=
 =?utf-8?B?dDd4UHFyTGt0NXFWaUlieUtESXMraXhxR1VMNjl2WGVJMjB4Q3VMNDdwNXlY?=
 =?utf-8?B?N29sNU9RZFFqenJ6TWR4a0tnSHNXS2xsci9sWTNIaUVudzlVQk95R0RpMlpj?=
 =?utf-8?B?a1JEalNnQWdhNG83UTVnQ0J4cmlpSHNleklQZWhpMXJ2VW5DWjl2OGQvZ0V2?=
 =?utf-8?B?eG55RmhNOTZ3OTRodzIxOERzMS9DaGtudnZTQzE4NDJHcXdZdjFKV0JIODJo?=
 =?utf-8?B?SkV5VUlZUVZkQlp2VVVlQWZnNWQ5eitqN0tnbTNTRFplMy9CTW5mZGtIb2JZ?=
 =?utf-8?B?VlVZSWxEODVhT0FWa1ZsRGN5d2o2THVJV2xObDFqeGMrUHNMWExGaGRad0RH?=
 =?utf-8?B?aFdHdndIaEJYaU5JQ21nUHo2S29lUk5JKzI5Y2w1OWI2NkYyWWJPSUgxTkFq?=
 =?utf-8?Q?7aA4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1bccb5-19e1-42b0-573a-08d9b979445a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 12:01:13.9994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2AHG3u+WaaPHJ1KmOSnNqonSPjpnq9RwRxxLRJQC3pL7GFJruWyM9o9PmqYoUBDL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9227
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/7 19:56, Filipe Manana wrote:
> On Tue, Dec 07, 2021 at 07:43:49PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/12/7 19:02, Filipe Manana wrote:
>>> On Tue, Dec 07, 2021 at 03:43:58PM +0800, Qu Wenruo wrote:
>>>> This is originally just my preparation for scrub refactors, but when the
>>>> readahead is involved, it won't just be a small cleanup.
>>>>
>>>> The metadata readahead code is introduced in 2011 (surprisingly, the
>>>> commit message even contains changelog), but now only one user for it,
>>>> and even for the only one user, the readahead mechanism can't provide
>>>> much help in fact.
>>>>
>>>> Scrub needs readahead for commit root, but the existing one can only do
>>>> current root readahead.
>>>
>>> If support for the commit root is added, is there a noticeable speedup?
>>> Have you tested that?
>>>
>>
>> Will craft a benchmark for that.
>>
>> Although I don't have any HDD available for benchmark, thus would only
>> have result from SATA SSD.
>>
>>>>
>>>> And the code is at a very bad layer inside btrfs, all metadata are at
>>>> btrfs logical address space, but the readahead is kinda working at
>>>> device layer (to manage the in-flight readahead).
>>>>
>>>> Personally speaking, I don't think such "optimization" is really even
>>>> needed, since we have better way like setting IO priority.
>>>
>>> Have you done any benchmarks?
>>> How? On physical machines or VMs?
>>>
>>> Please include such details in the changelogs.
>>>
>>>>
>>>> I really prefer to let the professional block layer guys do whatever
>>>> they are good at (and in fact, those block layer guys rock!).
>>>> Immature optimization is the cause of bugs, and it has already caused
>>>> several bugs recently.
>>>>
>>>> Nowadays we have btrfs_path::reada to do the readahead, I doubt if we
>>>> really need such facility.
>>>
>>> btrfs_path:reada is important and it makes a difference.
>>> I recently changed send to use it, and benchmarks can be found in the
>>> changelogs.
>>
>> For the "such facility" I mean the btrfs_reada_add() facility, not the
>> btrfs_path::reada one.
>>
>>>
>>> There are also other places where it makes a difference, such as when
>>> reading a large chunk tree during mount or when reading a large directory.
>>>
>>> It's all about reading other leaves/nodes in the background that will be
>>> needed in the near future while the task is doing something else. Even if
>>> the nodes/leaves are not physically contiguous on disk (that's the main
>>> reason why the mechanism exists).
>>
>> Unfortunately, not really in the background.
>>
>> For scrub usage, it kicks readahead and wait for it, not really doing it
>> in the background.
>>
>> (Nor btrfs_path::reada either though, btrfs_path reada also happens at
>> tree search time, and it's synchronous).
> 
> No, the btrfs_path::reada mechanism is not synchronous - it does not wait
> for the reads (IO) to complete.
> 
> btrfs_readahead_node_child() triggers a read for the extent buffer's
> pages but does not wait for the reads to complete. I.e. we end up calling:
> 
>      read_extent_buffer_pages(eb, WAIT_NONE, 0);
> 
> So it does not wait on the read bios to complete.
> Otherwise that would be pointless.

Oh, forgot the WAIT_NONE part...

Then to be honest, there is even less meaning to have btrfs_reada_add() 
facility, the path reada is better than that.

> 
>>
>> Another reason why the existing btrfs_reada_add() facility is not
>> suitable for scrub is, our default tree block size is way larger than
>> the scrub data length.
>>
>> The current data length is 16 pages (64K), while even one 16K leaf can
>> contain at least csum for 8M (CRC32) or 1M (SHA256).
>> This means for most readahead, it doesn't make much sense as it won't
>> cross leaf boundaries that frequently.
>>
>> (BTW, in this particular case, btrfs_path::reada may perform better than
>> the start/end based reada, as that would really do some readahead)
>>
>> Anyway, only benchmark can prove whether I'm correct or wrong.
> 
> Yep, and preferably on a spinning disk and bare metal (no VM).

Unfortunately, that's what I don't have...

Physical machines either is the main ITX desktop I use for development 
and VM testing, or laptops without SATA interface for HDD.

And even worse, I don't have any HDD available for testing yet. (The 
only HDDs are utilized by my NAS)

I'll go for VM with SATA SSD (directly passed to VM) first, then try to 
get a physical machine (maybe NUC with 2.5in HDD then).

Thanks,
Qu

> 
> Thanks.
> 
>>
>> Thanks,
>> Qu
>>>
>>>>
>>>> So here I purpose to completely remove the old and under utilized
>>>> metadata readahead system.
>>>>
>>>> Qu Wenruo (2):
>>>>     btrfs: remove the unnecessary path parameter for scrub_raid56_parity()
>>>>     btrfs: remove reada mechanism
>>>>
>>>>    fs/btrfs/Makefile      |    2 +-
>>>>    fs/btrfs/ctree.h       |   25 -
>>>>    fs/btrfs/dev-replace.c |    5 -
>>>>    fs/btrfs/disk-io.c     |   20 +-
>>>>    fs/btrfs/extent_io.c   |    3 -
>>>>    fs/btrfs/reada.c       | 1086 ----------------------------------------
>>>>    fs/btrfs/scrub.c       |   64 +--
>>>>    fs/btrfs/super.c       |    1 -
>>>>    fs/btrfs/volumes.c     |    7 -
>>>>    fs/btrfs/volumes.h     |    7 -
>>>>    10 files changed, 17 insertions(+), 1203 deletions(-)
>>>>    delete mode 100644 fs/btrfs/reada.c
>>>>
>>>> --
>>>> 2.34.1
>>>>
> 

