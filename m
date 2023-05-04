Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4DC6F785F
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 23:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjEDVzV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 17:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjEDVzT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 17:55:19 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2083.outbound.protection.outlook.com [40.107.247.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C004B1435D
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 14:55:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mab/5+qIt7zS7Wrn/LdNzwgtGl71aYZSUwLa0zIHZrXk/IqxWOuyT8VasUfV4wjwifNUf6cGTgc8j/+v10CN9nVw1N0in1m9/ObFK7izyFBMUw3jFR00CIQvM64PnkBV4RARbdK9OfSm0wvpJaZ+dIzs3Ezr8/bztK31FTIJ+QvKxA1iNU64Yp20FKS46UVx/5XHbX25VilZq24X2ffkchybsJdYSIWnC4ynaKPeafIwUmdXn6cI/bptonuvGIMkT73W/nCz9+uiDBkfh7Uylr5ML3hg1KD7jas24Crri5wrJ6GpLtpX3T3WDf58HM4HX52iiXp0XkrFjoji9qekGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B90crt6nLjLKliUY58osyaSmMpnu03ZLABqTR36NE7E=;
 b=OufbjKi2hH5lyhzKUMTflmHJGIZVnbWdIAGexVQUCN0bbxAQCEI6m/8Txxfe9VLM/Wt2k6HNsQ64aPAEwV6NmgDcOCsPOjBy8vKRNc7P8MZKaCpnqJNFr9Zxa8/ghnjz4weqJyVQRH1E3CuaQ3eVn2LMrNZGBH/Yp5vhQIg2bVAxujmDMd1bXtjbEfOKCMtfe5cj/c/qSGlAfkEW1gqkQ6Rjh/H3BnzA0pXPAZf0oR+LlXxxDyBy1SYiysDJkFu3055J9yrl0F8DJD9ihikmb4Fc1i0MpOsp8ggDJ1p4Ja7YP+lfTZmypJsDVMBe2YNkJ/zxTEInb48CTowQ1XtAcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B90crt6nLjLKliUY58osyaSmMpnu03ZLABqTR36NE7E=;
 b=LFMfJAT5FFgruXGeorw9hUQWXuBqURHBF8nFiU2cllI8Fo1fx684qMA6CMTaKAl9cp1SSNZf2OKLnAQdhAsaPLjef/KHT4ydT5iQXVLjRqDNDQ2hHjlfPvDUaqOZXnnfSLK325i3LO6DBWGiqFhIawETP0FvxAlig3z4hKQOURtZpaMg+1FneJUd90ohHE6s9KIXrJV8ZpBysa0UH6YqvNgtzeknbgxaYx10XZss6ejLmlzXSrmO51bOCJ7iRRaj+BEaqgE/Zf38ClNNkyxkk5Vz2EiVHLqU7qGovCZ2GIR+RifglseWrG/Cg8fAvBGulTv2eXVs4iCRf+gPRFLE8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PAXPR04MB9153.eurprd04.prod.outlook.com (2603:10a6:102:22b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Thu, 4 May
 2023 21:55:10 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2%5]) with mapi id 15.20.6363.027; Thu, 4 May 2023
 21:55:10 +0000
Message-ID: <980eb6a3-3cfd-3522-6053-aad3e730d8eb@suse.com>
Date:   Fri, 5 May 2023 05:55:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 6/9] btrfs: auto hierarchy for simple qgroups of nested
 subvols
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1683075170.git.boris@bur.io>
 <b311f17d76094253b5b38be3ea845438628f17ad.1683075170.git.boris@bur.io>
 <f488fc4e-3a5b-c3f6-1958-25f91c9d378e@gmx.com>
 <ZFPehaADwnSseFiG@devvm9258.prn0.facebook.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <ZFPehaADwnSseFiG@devvm9258.prn0.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0081.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::22) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PAXPR04MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: f17b2fa0-e4fa-4215-4895-08db4cea3b66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1a3jiyhdEmaIrBiuJ0bYFC1Pj3Ii9v2TdoppPTw1CnWknPQsqAOqwdLZsXE76SLSxqmAP0AhNfQUKzQiZlNvIR+MbFU5iklA3aQ384NV++OiaRd/w+skxjSSivKOHzvOG5wyHk/tdHqZsVZ0Yc3ZxkT+lXuWw2nmj5rpebehB4Q0gWe1Ko5uUEPNGBmVSohebmHf1HznyOEJ/ZQzZwh0Wq1dKr7cUG6yj7azwE4bzrf7ugEROIx2a6GN4joWZuhnBjK7QihVEGCrVwxMP/JglXC8YkuULYHnQIgwNTiJgG1e9C/M235wLyXLwV1PDi4weTSL/Tz5w4uL0rjBS+7bFLsXF5MO7Dunk+mliP8WAZH5Jm+zvK2iz9E8Z8MQyH5MRu9CZH9tnWJQCEt4pocF79r6tqCIUFuvGxVS0AU56bR74BGX+UfZ+VAVXVpwlKYw5ek1/UlWXtny1Itt7Q9XN+lYcUz8Vf2FIdIjnEFl95QbP/wi3GMnGsEX3+NMtv0VSNjv/+LQu780ZF+w1p/RyIWr+lgJM8HPKbCQ/Le8ntxQbqP81yftI3HA/kL1sk19goi/YseR3Oa+Hqx4IfamBONoUscmLa6f27MCN/fhNEqATRnA7n8QByTGKI/2en5QxbUri4sPP4bN3wZDU3lKKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199021)(31696002)(86362001)(36756003)(83380400001)(478600001)(316002)(110136005)(4326008)(6666004)(66946007)(66556008)(6486002)(66476007)(41300700001)(8936002)(8676002)(5660300002)(2906002)(38100700002)(186003)(53546011)(6506007)(6512007)(2616005)(31686004)(66899021)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3pxQkU4Z1FaVlZSS1JzL29tYW40aENhcHZJdmJZb3l5dEJsWkRKdkVuTmhi?=
 =?utf-8?B?RXU5M2FicUJRM3o1eCtqT1JEL01sY3YwaFhKcnIvZ3RmNGdFSzNxUkJDZVY3?=
 =?utf-8?B?WFFqMmxqb2JsRy84d3FaOU9uaXZ4REwzN1JOdThWV1AxbG5mazdMSXd3VWJv?=
 =?utf-8?B?RndTQ3EySmJ3QlQ3L05JczhYN3pnaEZVK0dsVUQzcW1zdVFraVZBVE5YVGc3?=
 =?utf-8?B?REluMTVTV2MyMFlPdzkyUWMwYWRacGhRcUtFVzFSQTZwVFUzbEl2M0MreFdX?=
 =?utf-8?B?cEdERkQ0QVFQbzNNZHhzdkE5ZXkxcFgxdGJOa0hvRmJDWWlKa0xNd1NBdDRP?=
 =?utf-8?B?VkFVcW5sUFlXMTRHS2oyWmFtMjM4U3hTNWJIczJid0Vtczhtc2Z3aXVGWGJ0?=
 =?utf-8?B?N0dLQVJFMlB0WGNWVGlnMnQ3SnRkRXRQWkN6NUdwWlFYdjYxU1hDUXdSMkNL?=
 =?utf-8?B?a3FBQWtlWWFPYW5wNHFuVlpmdW9ESEx1cWEzRmJhR211S08yS3N0SzJzZWY0?=
 =?utf-8?B?RjJxYkRwNkw4cDU4MWNNYTJDaTJaQVNZTlhUYjdDZWxqUjB2R0lycDN4SDkv?=
 =?utf-8?B?YWxIeVNQcG40Z2pKT3kwaXloK0g3akJSRDM2TGNydXNGM2NSeVhWQThmVmpQ?=
 =?utf-8?B?ZEFveGQwM3Jxd1NsUG1KOGNHUzJXYTRNcFk5VFRFQk5HNm14eml5cnkzVjBZ?=
 =?utf-8?B?NForMDd5S1p0MjF0TWlSaGczV2FLcUp5NkxIZjNTUjU2ZmxJZG5Vb3FOYlhp?=
 =?utf-8?B?NnZxUHE4RnJVMG5kaG1Cbmp0bCtmZDJNb0JzT1duc0grZGtxWTl5ZlEvcUxj?=
 =?utf-8?B?c1oyelZXTU00UXpJSkhxNlhTMXlxV1Y1Sng1TlUzaTgvUlYyRmxpUitxR3Q1?=
 =?utf-8?B?aDJOMTNMdTA0Q09lU21uZmxBbUlHczUweFp2elBFUFRzQnVjTndaZEFFVktP?=
 =?utf-8?B?d0o1MnJNSDdRTjdaWE9tSHhhZ3dzbFNDOUFnd2VvdDFrMGVSV1lkNS9hQTlm?=
 =?utf-8?B?cG5NcHdMakVIdmxrWHdJQitoZnBuZGhaSTdJM3ZZa0tRVWwvOEo0VlNjL3lD?=
 =?utf-8?B?KzVMblBMcnMxSVlzNTdXQmlSYkZ1M1BINXllUnE4andYZVRtOUlFYVdiRkNy?=
 =?utf-8?B?NktqVEtzc3ozeXJINW5DcTRlK2tGdlhYTFB2QmVtWVBJTTIvcTVFc3poWlJT?=
 =?utf-8?B?ay9pVldqS2VTZGJwb3FlWVlKTzcyamQvN1V1cHdZZGlVejZUOGVWSTlGQnVV?=
 =?utf-8?B?OFhxZXNNQ01CTis1K2N4cFZ6M1l1TzlpbHFPQXltU0tKTXZwdFFhWGVGVmt4?=
 =?utf-8?B?dUlPWkNDdjNaNHRPc3pIRTdLckZtRE9kTTQ4NTZhUkFGRUNEMk9zdkthTzVO?=
 =?utf-8?B?c2l0cUxDL3lSL1kySWIxa3Z3Q3BCaU01eWU3NkloenU5c0J3SEhiaXNKSUc2?=
 =?utf-8?B?L3ZPR0I1YXdhODg4OFVzcDlpQk4rZXhWNTBhd3ArYkExZndJMm1JS3BGSi9G?=
 =?utf-8?B?MzU4bHAvR0dwN05FQXI1YWpQRGluTDNIOWhIYXdpUGc5THh1b2dlVStZVWpS?=
 =?utf-8?B?UzdDWmVzVCtPMTdtTHZsL3VnSjByYUdMKzJkZ0g4ZCtjZWliMldhTEk5cGdm?=
 =?utf-8?B?aXoreFJGdVlEOEM3OFRnRVU0VnVuMFl4alNpdk1acWVScW5QNGtPRmp1aUIx?=
 =?utf-8?B?Y2V0Tk50TmQ2a1ZhalI5TVpoM0hTNUp0d1RkTEpweFFyelpTbVpYNjdSRWFQ?=
 =?utf-8?B?WVJPeklLdi9ucWp2Y0hYbDFqNG83SGNtemZlcFJqK2gySmcxSy9odVlua0Vv?=
 =?utf-8?B?anRXT0JPNGs2TkMrd1dyK2ljd0tXV1EvbGZ0UFUyc1Q5MUp6ckZaaGZKUjAw?=
 =?utf-8?B?WmVuR1k1dzJ5cDFxMHh2bklIWTJtU2ZJalpkN3BYUjdYSmxwTmViZUdKbUdm?=
 =?utf-8?B?QlJSYm8rQkIraXdib2llY1AwUlRaU3I5SGlPcjJLZXdIVExFMWpqcVNzSHM3?=
 =?utf-8?B?WnRKQWhIVVFSS2p0WTFsd3NHZDN3R2taMFpmaC9hVXJUbHpjd2d6cFN0OTZD?=
 =?utf-8?B?bXdwM2dUWTI5M2gwTElTNlp3VTVNSEQ3VlNkSHNiRThyVHptWlhnL1FmcDZ3?=
 =?utf-8?B?ejNxZEVWUE45MGRMdjFleVh4MldqOTBPY0pHS1puSjNpVnY1L3B3TlIrTm5h?=
 =?utf-8?Q?r1aC4l75+fmjE/RkMrgGNr4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f17b2fa0-e4fa-4215-4895-08db4cea3b66
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 21:55:10.6632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBx+lrtCmOSdHzwKMUFH3yzkZWojAOUbRWE+L7cymZbLuhCp9Ay0tOL6urTfdxb7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9153
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/5 00:34, Boris Burkov wrote:
> On Wed, May 03, 2023 at 12:47:40PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2023/5/3 08:59, Boris Burkov wrote:
>>> Consider the following sequence:
>>> - enable quotas
>>> - create subvol S id 256 at dir outer/
>>> - create a qgroup 1/100
>>> - add 0/256 (S's auto qgroup) to 1/100
>>> - create subvol T id 257 at dir outer/inner/
>>>
>>> With full qgroups, there is no relationship between 0/257 and either of
>>> 0/256 or 1/100. There is an inherit feature that the creator of inner/
>>> can use to specify it ought to be in 1/100.
>>>
>>> Simple quotas are targeted at container isolation, where such automatic
>>> inheritance for not necessarily trusted/controlled nested subvol
>>> creation would be quite helpful. Therefore, add a new default behavior
>>> for simple quotas: when you create a nested subvol, automatically
>>> inherit as parents any parents of the qgroup of the subvol the new inode
>>> is going in.
>>>
>>> In our example, 257/0 would also be under 1/100, allowing easy control
>>> of a total quota over an arbitrary hierarchy of subvolumes.
>>>
>>> I think this _might_ be a generally useful behavior, so it could be
>>> interesting to put it behind a new inheritance flag that simple quotas
>>> always use while traditional quotas let the user specify, but this is a
>>> minimally intrusive change to start.
>>
>> I'm not sure if the automatically qgroup inherit is a good idea.
>>
>> Consider the following case, a subvolume is created under another subvolume,
>> then it got inherited into qgroup 1/0.
> 
> I am not sure I follow this concern. We automatically inherit
> relationships of the inode containing subvolume, not its qgroup.
> 
> So if X/0 is in a different qgroup Q/1 and subvol Y is created with its
> inode in X, Y/0 will be in Q/1, not X/0. I don't believe we would ever
> introduce a dependency that would violate the level invariants.
> 
>>
>> But don't forget that a subvolume can be easily moved to other directory,
>> should we also change which qgroup it belongs to?
> 
> I think this is a great point and I haven't spent enough time thinking
> about it. Currently, the answer is no, but that might be surprising to a
> user.
> 
> I imagine it gets even worse if you mount the same subvolume multiple times..
> 
>>
>>
>> Another point is, if a container manager tool wants to do the same inherit
>> behavior, it's not that hard to query the owner group of the parent
>> directory, then pass "-i" option for "btrfs subvolume create" or "btrfs
>> subvolume snapshot" commands.
>>
>> As the old saying goes, kernel should only provide a mechanism, not a
>> policy. To me, automatically inherit qgroup owner looks more like a policy.
> 
> This is targeted at the case where the container management tool does
> not own creating a subvol.
> 
> If we did it your way, then the second something running in a container
> creates a subvol (a reasonable operation, for faster bulk deletes, e.g.),
> they would trivially "escape" their disk limit. At that point you would
> have to do convoluted things like LD_PRELOAD or convincing all users to
> use a subvol creation util/lib (might be running some code we can't or
> don't want to modify too..)

Oh, I totally missed such situation.

Indeed we can not limits the programs inside the container, which is 
completely unaware of the new simple quota situation.

Then the automatic inherit makes more sense, and it may also bring new 
concerns, like if some one wants to disable the automatic inherit 
behavior, but how do we avoid such disable inside the container.

I'd say when container is involved, nothing is going to be simple anymore...

Thanks,
Qu
> 
> If we can do it automatically in the kernel, there really is value
> there.
> 
> IMO, a useful analogy here is cgroups. When you put a process in a
> cgroup, all its child processes automatically get rolled up into the
> same cgroup, which is important for the same reasons as what I described
> above. You can then do weird stuff and move procs to a different cgroup,
> but by default everything is neatly nested, which I think is a good
> behavior for simple quotas too.
> 
> If the functionality is not totally unpalatable, but it's too confusing
> to make it default for only simple quotas, I can add an ioctl or subvol
> creation flag or something that opts a subvol in to having its nested
> subvols inherit its parent qgroups. That would be something the
> container runtime could use to opt in.
> 
> Thanks for the review,
> Boris
> 
>>
>> Thanks,
>> Qu
>>
>>>
>>> Signed-off-by: Boris Burkov <boris@bur.io>
>>> ---
>>>    fs/btrfs/ioctl.c       |  2 +-
>>>    fs/btrfs/qgroup.c      | 46 +++++++++++++++++++++++++++++++++++++++---
>>>    fs/btrfs/qgroup.h      |  6 +++---
>>>    fs/btrfs/transaction.c |  2 +-
>>>    4 files changed, 48 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>> index ca7d2ef739c8..4d6d28feb5c6 100644
>>> --- a/fs/btrfs/ioctl.c
>>> +++ b/fs/btrfs/ioctl.c
>>> @@ -652,7 +652,7 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
>>>    	/* Tree log can't currently deal with an inode which is a new root. */
>>>    	btrfs_set_log_full_commit(trans);
>>> -	ret = btrfs_qgroup_inherit(trans, 0, objectid, inherit);
>>> +	ret = btrfs_qgroup_inherit(trans, 0, objectid, root->root_key.objectid, inherit);
>>>    	if (ret)
>>>    		goto out;
>>> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
>>> index e3d0630fef0c..6816e01f00b5 100644
>>> --- a/fs/btrfs/qgroup.c
>>> +++ b/fs/btrfs/qgroup.c
>>> @@ -1504,8 +1504,7 @@ static int quick_update_accounting(struct btrfs_fs_info *fs_info,
>>>    	return ret;
>>>    }
>>> -int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
>>> -			      u64 dst)
>>> +int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src, u64 dst)
>>>    {
>>>    	struct btrfs_fs_info *fs_info = trans->fs_info;
>>>    	struct btrfs_qgroup *parent;
>>> @@ -2945,6 +2944,42 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
>>>    	return ret;
>>>    }
>>> +static int qgroup_auto_inherit(struct btrfs_fs_info *fs_info,
>>> +			       u64 inode_rootid,
>>> +			       struct btrfs_qgroup_inherit **inherit)
>>> +{
>>> +	int i = 0;
>>> +	u64 num_qgroups = 0;
>>> +	struct btrfs_qgroup *inode_qg;
>>> +	struct btrfs_qgroup_list *qg_list;
>>> +
>>> +	if (*inherit)
>>> +		return -EEXIST;
>>> +
>>> +	inode_qg = find_qgroup_rb(fs_info, inode_rootid);
>>> +	if (!inode_qg)
>>> +		return -ENOENT;
>>> +
>>> +	list_for_each_entry(qg_list, &inode_qg->groups, next_group) {
>>> +		++num_qgroups;
>>> +	}
>>> +
>>> +	if (!num_qgroups)
>>> +		return 0;
>>> +
>>> +	*inherit = kzalloc(sizeof(**inherit) + num_qgroups * sizeof(u64), GFP_NOFS);
>>> +	if (!*inherit)
>>> +		return -ENOMEM;
>>> +	(*inherit)->num_qgroups = num_qgroups;
>>> +
>>> +	list_for_each_entry(qg_list, &inode_qg->groups, next_group) {
>>> +		u64 qg_id = qg_list->group->qgroupid;
>>> +		*((u64 *)((*inherit)+1) + i) = qg_id;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>    /*
>>>     * Copy the accounting information between qgroups. This is necessary
>>>     * when a snapshot or a subvolume is created. Throwing an error will
>>> @@ -2952,7 +2987,8 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
>>>     * when a readonly fs is a reasonable outcome.
>>>     */
>>>    int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>>> -			 u64 objectid, struct btrfs_qgroup_inherit *inherit)
>>> +			 u64 objectid, u64 inode_rootid,
>>> +			 struct btrfs_qgroup_inherit *inherit)
>>>    {
>>>    	int ret = 0;
>>>    	int i;
>>> @@ -2994,6 +3030,9 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>>>    		goto out;
>>>    	}
>>> +	if (!inherit && btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
>>> +		qgroup_auto_inherit(fs_info, inode_rootid, &inherit);
>>> +
>>>    	if (inherit) {
>>>    		i_qgroups = (u64 *)(inherit + 1);
>>>    		nums = inherit->num_qgroups + 2 * inherit->num_ref_copies +
>>> @@ -3020,6 +3059,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>>>    	if (ret)
>>>    		goto out;
>>> +
>>>    	/*
>>>    	 * add qgroup to all inherited groups
>>>    	 */
>>> diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
>>> index b300998dcbc7..aecebe9d0d62 100644
>>> --- a/fs/btrfs/qgroup.h
>>> +++ b/fs/btrfs/qgroup.h
>>> @@ -272,8 +272,7 @@ int btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info);
>>>    void btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info);
>>>    int btrfs_qgroup_wait_for_completion(struct btrfs_fs_info *fs_info,
>>>    				     bool interruptible);
>>> -int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
>>> -			      u64 dst);
>>> +int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src, u64 dst);
>>>    int btrfs_del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
>>>    			      u64 dst);
>>>    int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid);
>>> @@ -367,7 +366,8 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
>>>    int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans);
>>>    int btrfs_run_qgroups(struct btrfs_trans_handle *trans);
>>>    int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>>> -			 u64 objectid, struct btrfs_qgroup_inherit *inherit);
>>> +			 u64 objectid, u64 inode_rootid,
>>> +			 struct btrfs_qgroup_inherit *inherit);
>>>    void btrfs_qgroup_free_refroot(struct btrfs_fs_info *fs_info,
>>>    			       u64 ref_root, u64 num_bytes,
>>>    			       enum btrfs_qgroup_rsv_type type);
>>> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
>>> index 0edfb58afd80..6befcf1b4b1f 100644
>>> --- a/fs/btrfs/transaction.c
>>> +++ b/fs/btrfs/transaction.c
>>> @@ -1557,7 +1557,7 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
>>>    	/* Now qgroup are all updated, we can inherit it to new qgroups */
>>>    	ret = btrfs_qgroup_inherit(trans, src->root_key.objectid, dst_objectid,
>>> -				   inherit);
>>> +				   parent->root_key.objectid, inherit);
>>>    	if (ret < 0)
>>>    		goto out;
>>
