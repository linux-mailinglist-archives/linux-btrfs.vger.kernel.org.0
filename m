Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CB047B93A
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Dec 2021 05:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbhLUEp2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Dec 2021 23:45:28 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:35959 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229441AbhLUEp1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Dec 2021 23:45:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1640061926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GyAsmPMveGrvt/UK5KYyREMRYLvcasSTBpNHrZULIkU=;
        b=Hc+PFmprK5+8XwjEyjW5xA1weMWfMcK8tzAWRlr6AowNxhNCt3d5jjbL/fRVYj1lf2vUN9
        E+rjM3YFX2UsMYc4DZicrLwZsMc7YPSLpvtJ9nRFSWIQCN4TbuCbLbNWNLKphN2cDP0NiM
        aTGvcP/+70E/UHscLM7ziM1uTEDksbk=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2055.outbound.protection.outlook.com [104.47.5.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-0hg398_WMMOTPfUAUeJjng-1; Tue, 21 Dec 2021 05:45:25 +0100
X-MC-Unique: 0hg398_WMMOTPfUAUeJjng-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+y/fQOdYYo4D/DJOgbO4D8MTLxKtn03TUECUX2mxFuGlNMjAf1jCcjxivarW1hNRngh7bHqnd0E5kRkZOAKMrtKtB9RIrrjwxQihRbLOPOKQWxCnweoP0CJX2CMncMmq0Cm7Ybs5uhppa+O5o3Yk/TnBu8Odh8lPNIjttD4A2BKsfTgNJMSbrQ8Vt0Jm8Z87T+XjwFos0x4JqOOGhVPmjpi88oEQqmfoQtaKsVThr/dLTcvkM3Jid4RnFPA/SNXENhW/ajjn8u9xjEGnwBr62Xveng5eKNhepiup/R8vp9HmNbpltp2rVQcMcuIDUwD8+3OpvE/8CXc41f7J0QJdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyAsmPMveGrvt/UK5KYyREMRYLvcasSTBpNHrZULIkU=;
 b=XWz25X14FTg0XNQjblxAS8iCHt4FavS1eR0YXxIjtsoNa7WnuQMsevvLqrkwdH2/5cWMExeJiLF92epG5GyAh72vCoOapjGMcNttJSoLW3dAUYL4rTAn7RjbhGtt7f8PfrWqNz3eqI3zhZPmQSRMgg8bw1g/bLPcU0QbedHSMtF5NxzXWOGw2qUE62WyX+J5QqbtcT2oT5quBKovwm5tHQj80pE77KohEfqaOTrvzxGbTvXGUXVAd0xvngUcjPcL0aMeGuT8bTyDhuGuL4gziWQOC04C9Xen+/WkJxDq7Mm1rrdpUeyfgTAhX2+FvnVI9u58FFdTj7adcJi0N9eEXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by DB9PR04MB8445.eurprd04.prod.outlook.com (2603:10a6:10:2bc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Tue, 21 Dec
 2021 04:45:23 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::7547:9d8a:d148:986e]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::7547:9d8a:d148:986e%5]) with mapi id 15.20.4778.018; Tue, 21 Dec 2021
 04:45:23 +0000
Message-ID: <eeadde9a-f5f5-a1e8-4f6d-567072d838aa@suse.com>
Date:   Tue, 21 Dec 2021 12:45:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: unable to use all spaces
Content-Language: en-US
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Jingyun He <jingyun.ho@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAHQ7scWFUthGXGs72M9VYPHc2eiZ2hSSs6LJd6XVL2oQO2fgLw@mail.gmail.com>
 <20211215155059.GB28560@twin.jikos.cz>
 <1010d177-a983-d95f-1927-690114805b8f@gmx.com>
 <YcFMM8MfNU4LrUc1@hungrycats.org>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <YcFMM8MfNU4LrUc1@hungrycats.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::14) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b149517a-60c3-4710-4f19-08d9c43cb34c
X-MS-TrafficTypeDiagnostic: DB9PR04MB8445:EE_
X-Microsoft-Antispam-PRVS: <DB9PR04MB84458AAB3CA48CEFA82189B3D67C9@DB9PR04MB8445.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zLbXzclNa5T04yN5sm1ffLFeKIhc4AGsSdpZPYiBQCJYQ5bPRgd9cyRZanpXbC3nqdJL4bksnbcWF4vhcVfu2qQdv/LAPSJsq21Dfw13qxhpJ9eksGxBOasJRvvoW5TkNET/GWm3hNfbSbvd4bBQykRW13gz7Xs2DNmqW+xq1kSeSivwDKegB1WJMe3XN1ejnnMFJLjYLqvbbIPd/TFXwsSXAqOudYPG9+oNwFrkAm17ouPIpLMtAWQDbaN5100IhTy96iZ2ZdB7ZFMNLlXgoHlPqz/mnY960orZo5BPrVZmiPZFXjxLFDzCPVxNMT25S/DKeWHcDm9Azrm99vLtf4sbH1432Bzgu9mJT28gpJEvhSlecrudmMJRJ7toRt4CJN184SCChoCmxOWunIMuKQByuUTGnVwKpRvKFgKLtrdnLmdeZh93VixKfMTxDcyBlaCrmtdrbX3fYCeG7mINbfNNJ5NU4wNIZXuBDb+E+CbEZVzCSKNG6O0p+Q+LiaAn/OTDrllTHctRfA76+KZkAbtBWMYAJIsk3b6bArb2PnGEtE8g2AOiHYSXsygvaBhOI6mySMJNJSBwnD6mX655ujwyhCJLDOkG/UY2Ip/xzesuf6/yXtNsNesrFLbjb3CHTtZAQobGs0kKbIQM6Py+sY+qVdLyVEEZgzFN7a4Vv1jLZ43Ti4CXcMURK91N5U42LpQiOKtzhNJjpw6xGtkL8j8k0MXHRyEwlEjM1DLfqUs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(53546011)(6506007)(31696002)(36756003)(6666004)(508600001)(186003)(5660300002)(8676002)(316002)(86362001)(4326008)(2616005)(2906002)(110136005)(26005)(8936002)(6486002)(66946007)(83380400001)(6512007)(66476007)(66556008)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWZSaFUyR0IxMlZQVUpteSsyMEpHdStyVFBEbzR3RlcrSjFUekJiZ2JVSHNi?=
 =?utf-8?B?NC94MkVRQllGbGxET1NjUkxoTTlNcWJSU2piRVRoWEk3bCtNVHBwR055K0Fv?=
 =?utf-8?B?V0dvUUdBTXBIL0UwMXlFTUhRTkZnQjkvTVJzelVtVnpJRFQ0YWdweTJicHdU?=
 =?utf-8?B?UmxxdXgrWnVIU1ppWmhHWEtxQlN5M2YyWW4weHU1bFBkdzJBdk5YcjMwTmFt?=
 =?utf-8?B?TDRqbFpMdURGZVg0SHc3ZHNpQ0tCeHpTYnBLM3JaQ1NuNU5kdEhRZEowTHdN?=
 =?utf-8?B?QkQzOElHZTZYZmJXUWpkTHpsNEV3RFkxem5yMWVEb2dkSis1WjdOeGNNYWJT?=
 =?utf-8?B?eGdadlBuTTF1NmdpQ216N1RBUFBlS0RkRXZLM3JWTnJwa2lRakR6UVFxeGpZ?=
 =?utf-8?B?ZUNsaGhkQ3EyWE04WklQMk9aUHQwZmo1QU9sOGpoaEo1eHk2YURYRUwxa2R1?=
 =?utf-8?B?cEowTS9wMEk5Sk82LzNaNmxLc2ZWSTIxQXdyNDNrWmRaM1poQ3pXVzBQRFZY?=
 =?utf-8?B?bERJNG1ScjcvWHAvNjFlLytlWi9LdjlOU0NDR3FHT2xqMGkrdysrNllVZmZB?=
 =?utf-8?B?UlpCODNrbHRqRTVPZzExWGpkeDFxelJkUGJ5WGt1SEdNZ0xkQk1BdVUvTXl0?=
 =?utf-8?B?UzN0aGRpdWNDOGxzSEZUTkc0eEd4WDVpR2RqUXd2VVF6SzFjYW1mMUw5dzlr?=
 =?utf-8?B?ZWF4NnNXazAwNUtBOXFPUUhjU2ZvT0xCTTY2MFdDM3FXR3M2VUp3MVdrZkpv?=
 =?utf-8?B?bUdzVnM1VHVsb0UzcjEwZWVvdVJrMEhZeTR3YlNWWEZEN1AyTks4NHJHQ0Jk?=
 =?utf-8?B?bXNJWjNTSkk2alNSTG1pZHArUzZsM2JqdklwZUliaGRRUGs1Tmxtc1JrZWpp?=
 =?utf-8?B?WUZvSWdmOERBbEk1ZndmRS9BRWN2Y1Rhb2NPcVNkVFFOT2VDY2JaSUx4NTRn?=
 =?utf-8?B?Tkt0SlBHT2pBNXZNOFhSdHo3c21iOTN5M0M5QXhtTEphUVE2K3l0VEVMbHY3?=
 =?utf-8?B?S2VJaVNZblplYUppbHpVN2pPVzlEeXAwd2xXMzNhd2NiNjdleDc2MnRYUXFT?=
 =?utf-8?B?ZDZqUldnekx6dk1NU2lZOXltOURJV096NlJvZUFtQUF6amxIbnZ0T0VVN3A0?=
 =?utf-8?B?bmpTNEhSZFdjQTRDcXdaWEhsMFNnS3BwLzJXRFVubktlM1VjaUFCNnJBY2pu?=
 =?utf-8?B?WEZtbXVkZVNsUzM3a0ZDcTFmYTZTalZ0NUVpZmU3d05qNVJIdU5hQTY1NENL?=
 =?utf-8?B?K3lodlFDakZYNm5ickhlYzlOZHNmL0VGa0pUNi82NjR4YVpIdjF3UEs3OFZm?=
 =?utf-8?B?NmViNC80bXlUdXBBYUg1akQyK0RCRUNTSFpDSmpaK2YwSWZ4dWZpU1pkQjJD?=
 =?utf-8?B?MzhUZ0F2UHFSRkpIUWdRYVZwNTUxT2VsM1ZRa3JVR0tiY3dJelNmQ3lUVWhD?=
 =?utf-8?B?cWIvbWJWcG5SaFdGcTg2eEo2bm1hWGZwOTg5WWpmdjZyRlJQblRSNkw2eW9O?=
 =?utf-8?B?VW9WbUFBNmFxQzQ5V3dqbjI5ZFFpZHc1dW5jcWkzaFhTSTdQS0ZaVk8yai91?=
 =?utf-8?B?cjhETkZqdDVoRWsybG9vRW1OakVQNEwydzZkdFI2N2JzRXBjSmZDMWJwaXQy?=
 =?utf-8?B?OTlyb0VaYitUVnV2TW45WXVXY0ROUGs4ZGhpU2VCSzRkb3FEc1JwVUpmK2g1?=
 =?utf-8?B?N3cxRlZNSWovRW8xNjFyUW9ENDdwZktkNG53RmloVFZzdjFLZXVMQ0VCdm0z?=
 =?utf-8?B?UVNWZjBqaFFiOGppR1V6Yy9YSy9jL1pjWStpcERGbno3VFE5eU5UTG9lNG00?=
 =?utf-8?B?STlFVUJQbXNWcXdYbkNqUFNHSXBYdlRZb2xqMllDVEk2aVdTWTZxVW5NK2R2?=
 =?utf-8?B?YzFJNXVyVmpYNW02S3VtWXg1NTJNUGIvQ3N5U1pXWExsL1I5MnVkRFdlR215?=
 =?utf-8?B?cDB2b1VUZ29hUVVCUDBITEltOVZscG1odWVyMUFNUHVFWGxwSmo0L0tCVnYz?=
 =?utf-8?B?MnM3aXc2cjEwY3MyK0M2QTFNWWZmT0tBVnQwUXRic2FIWnRXSUtTcE12K3pE?=
 =?utf-8?B?MEVWUFR6bGVvcHdGbWxYbXJyQ0JHaDk3OUVrbStjcU9Fd3Rtd1o4ayt5ZDJC?=
 =?utf-8?Q?i8Y8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b149517a-60c3-4710-4f19-08d9c43cb34c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 04:45:23.5933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2nTIjP87sRJ/VL9tfWP1bCXekVuWXmCkiOlYu+5ZRqqoyN24VOKwy1wDMbsz3xv6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8445
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/21 11:38, Zygo Blaxell wrote:
> On Thu, Dec 16, 2021 at 07:58:39AM +0800, Qu Wenruo wrote:
>> On 2021/12/15 23:50, David Sterba wrote:
>>> On Wed, Dec 15, 2021 at 10:31:13PM +0800, Jingyun He wrote:
>>>> Hello,
>>>> I have a 14TB WDC HM-SMR disk formatted with BTRFS,
>>>> It looks like I'm unable to fill the disk full.
>>>> E.g. btrfs fi usage /disk1/
>>>> Free (estimated): 128.95GiB (min: 128.95GiB)
>>>>
>>>> It still has 100+GB available
>>>> But I'm unable to put more files.
>>>
>>> We'd need more information to diagnose that, eg. output of 'btrfs fi df'
>>> to see if eg. the metadata space is not exhausted or if the remaining
>>> 128G account for the unusable space in the zones (this is also in the
>>> 'fi df' output).
>>
>> A little off-topic, but IMHO we should really make our 'fi usage' and
>> vanilla 'df' to take metadata and unallocated space into consideration.
>>
>> The vanilla 'df' command reporting more space than what we can really
>> use is already causing new btrfs users problems.
>>
>> We can keep teaching users, but there are still tools relying completely
>> on vanilla 'df' output to reserve their space usage.
>>
>> Thus it's not really something can be purely solved by education.
>>
>> My purpose is to make vanilla 'df' output to take metadata/unallocated
>> space into consideration.
>>
>> Unfortunately I don't have solid plan yet.
>> But maybe we can start by returning 0 available space when no more
>> unallocated space.
> 
> It's a really bad idea to abruptly flip to zero free space.

Indeed, so my plan is to ensure we have a smooth change between metadata 
exhausted and last unallocated space get allocated.

>  If df reports
> "3.7TB free", and then you write 4K, and then df reports "zero free",
> it's no better than if the write had just returned ENOSPC with 3.7TB free.
> If the number provides no predictive information about how the filesystem
> will respond to near-future allocations, then it's useless.
> 
> Worse, automated responses to a reported low free space number might
> get triggered, and wipe out significant amounts of data in a futile
> attempt to get some usable free space (it's futile because the required
> response is data balance not file deletion, and if there are snapshots
> the response will make the metadata problem worse for a long time before
> making it better).
> 
> If we have good information about the ratio of data to metadata on
> the filesystem, we could gradually reduce the reported free space,
> always reporting a number between zero and the true number of free data
> blocks (i.e. the lower of "true free data blocks" and "estimated data
> blocks that could be allocated if all the remaining metadata space was
> completely consumed at the current data:metadata ratio").  That would
> mean that instead of 3.7TB free, we might report 3.5TB free if we have
> 0.8MB of free space for metadata, and it would drop to 1.7TB as we
> drop to 0.4MB of free metadata space (after deducting global reserve).
> In this situation, writing 4K to the filesystem might decrease the free
> space reported by 4MB, but it would happen while 4MB is 0.2% of the free
> space on the filesystem, far enough in advance of reaching zero that an
> attentive sysadmin or robot could avoid a disaster before it happens.

Exactly what I'm thinking.

But I don't really have a good formula for that yet to implement in kernel.

> 
> On the other hand, if we are tracking those statistics and they're
> accurate, we could use them to preallocate more metadata and prevent
> surprising shortages of metadata space.

That's against the metadata over-commit behavior.

For now, we don't allocate extra new metadata space as long as it can be 
covered by the unallocated space.

One problem of preallocate is, it can be reclaimed if we don't really 
use that space immediately.

And during the window of reclaim, if we really need that space as it's 
the last free metadata block group, we can hit -ENOSPC immaturely.

Thanks,
Qu

>  We'd also have to stop metadata
> balance from wiping out preallocations.  We'd have correct df free space
> numbers based on that--if we need 1% of the filesystem for metadata,
> we'd actually allocate 1% of the filesystem for metadata, and df would
> report 1% less free space.
> 
> We already had the abrupt zeroing behavior and removed it in 5.4 for
> that reason (and also the fact that the zero trigger calculation had a
> long-standing bug).
> 
> The entire discussion is moot as long as df is as wildly inaccurate as
> it is now.  Step 0 of this plan would be to give df a working algorithm
> to figure out how much space the filesystem has.
> 
>> Maybe later we can have more comprehensive available space calculation.
>>
>> (Other fses like ext4/xfs already does similar behavior by
>> under-reporting available space)
> 
> ext4 has "superuser reserved" space which isn't really underreporting,
> it's just taking the real free space number (which ext4 can compute
> accurately) and subtracting a user-configured constant value.  root can
> still fill the filesystem all the way to zero, less a few blocks for
> directories and indirect block lists.
> 
> ext4 does preallocate space for metadata and the filesystem does give
> ENOSPC with non-zero df free when metadata runs out.  There's a data
> block to inode ratio that is fixed at mkfs time, and you get up to (size
> of filiesystem / that number) of inodes and not a single file more.
> The other ext4 "metadata" (indirect block lists and directories) is
> stored in its data blocks, so it shows up in df's available space number
> and behaves the way users expect.  ext4 has no snapshots or reflinks
> so the other btrfs special metadata cases can't happen on ext4.
> 
>> Thanks,
>> Qu
>>>
>>>> Do you know if there are any mkfs/mount options that I can use to
>>>> reach maximum capacity? like mkfs.ext4 -m 0 -O ^has_journal -T
>>>> largefile4
>>>
>>> There are no such options and the space should be used at the full range
>>> with respect to the chunk allocations.
> 

