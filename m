Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90735AAB8F
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 11:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbiIBJiL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 05:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbiIBJiJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 05:38:09 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60075.outbound.protection.outlook.com [40.107.6.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB977AA34B
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 02:38:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AO1NFVPJnO2AKXxJBMXbCu/Js1QnswPe63EBopxbfKlz2rXe/ImjRaKw9WOYo0iNHZNYYntB3B5+EBeU1W2MuV/MZcMDTzbTkb1+YASOe1kBgJyIFBHELWHPfVr2TrZrM5lezMQAVzswVrGEZJ+SE7XIgc5U5dCEuA3bRJaMmmVaNHdP2jGiA9TrETucahI1HQS5OnD6imp+cZenxqRdWS+Fe6SERz+l60a3IY4/9pye/Se/waWP3Y5YeGJmtO4MYeX9R7R7oZlk2mb8POx9GrLLV7YhfDyG9CBly5KUSVIgqvzJ+JIVtO/TM53gGOR/a//JVjvRZLO1v47k2VLXzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDvJFGxP9G1yxF2/e0U+e4YR/WjTTJU+//MBMSfxUT8=;
 b=g3IqYwX62vvaUzpsyOWnV37vY+KEM9g+VOpKO41zKoZkraDmqpOuFYgtSpVkXErZhLItxEp2K0JKQLIvArOInmPb8zqvzURfPch0oQ1pTi4r90CluRAtW+X//bW/O5Fdjy+hTvDe3V4uNBjLwq+Sz8Gq3x4+iMEwejB8v9SNGqbsbWHIfGOSDFnBjm3D/iKcW73jtxoW8p8ROFfLJ93xAHC8D9+W3Nnfm3EocukDYEo2Dy6GitkHpOWEwxGnGrRqre4ZZZ9a7ND4EIk7SfTPhNCcDhvQ4pQWWIa9EcnAqqmU64CyjU3yKpZ1Jc7pnWfkcnKOZRV0q0+NGO2h9L7xYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDvJFGxP9G1yxF2/e0U+e4YR/WjTTJU+//MBMSfxUT8=;
 b=deFKgMSMQ+tAAk/Xmm4F877Ar0jj971DBvw7wlrJcatBIDLVDd9PnFMq6Kw5fu2+2DnA0v+r9k8fPFbtL72WerEpxENCGLSg4bYj2foA6SqxqrCUwW3BlNoaCya+4tZyyn0pjvflMd4DIUwCmwOTM27A8ROEH9XVuIdNBJ1Ci+KiAImytBxd29VEo/5vOIpKgKwBiXvnRe5ydowaA1CoF5nckAI1vLNvsMGEz3MHpct6153hqOC4q/k0ymvJ/kf6IbsiozLk5q1/rh1T82UGWVsXVv/xBIIM/t0XhJrwK0YupcVVCxrv+b1UC4c+I5UsJ2uuCdrn5Zx16QTy1zK2dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM6PR04MB4376.eurprd04.prod.outlook.com (2603:10a6:20b:1d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 2 Sep
 2022 09:38:02 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::987c:9190:1b0:f3ab]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::987c:9190:1b0:f3ab%5]) with mapi id 15.20.5588.014; Fri, 2 Sep 2022
 09:38:02 +0000
Message-ID: <2b614da3-0fe2-f2fc-1754-ecbdcd1620d9@suse.com>
Date:   Fri, 2 Sep 2022 17:37:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 3/5] btrfs-progs: separate block group tree from extent
 tree v2
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1660024949.git.wqu@suse.com>
 <5eef4fd2d55a02dab38a6d1dec43dbcd82652508.1660024949.git.wqu@suse.com>
 <20220831191442.GL13489@twin.jikos.cz>
 <66396669-7174-dd04-aaa9-d8322bc39fdb@gmx.com>
 <ab123921-773a-9e1b-1d49-9e82614a37d9@gmx.com>
 <20220902092140.GP13489@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20220902092140.GP13489@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0027.prod.exchangelabs.com (2603:10b6:a02:80::40)
 To AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 819720d6-5fe5-4b0a-42b2-08da8cc6d4aa
X-MS-TrafficTypeDiagnostic: AM6PR04MB4376:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tOgfUfNA63fm2p1pNR9T0jf4AHc3KMENRXLR6WnnQO35wNQ8dw9gffPzZzpl+r75PisfEvU717O8sLZlqF8cvB4SecPZVfPZf9u5P7rG/rWm1Zb5X6+oPXCdtNxBey3yZ3ccC9JdwAUVa3kkMhKnDjhxyUQenPt6rjeCgHOb8Vqy9sbaqPaUAuz7NimuyOuNWf0DANbC/s02sM9Rdj6945FH3d4bDmMmiPfH4uOG/GNB+JVgwa+qDlBd4YQM4ACXHtXnPxoYFuKDS6n1Sr4c99FQeI5sZegv6mwklacpimvN7HRHqSimFjU44Qvw0V+f2BzHx19hXqt9N7wYRtKXfJjuaA8Q+N3LzGNk2sjN6Yv3HP6r6uZQvjnQndghofGbaOJnhfD3o9YRtWGnUJDY10zzZiH3gVyTJt1SmFJYPmQoiXwrcMrJH5FWqGz4EHBnAY2QTUVNDGUPxUMT8Awv8sMxlgcLpiyG+F/mPC1ipbKEGu+OCc+hFqZocFGFCKDHHyNNv5lXh1XKEbIZBLnvwBbVi99jiZLD8l0PrcxahUBbT+XKMvvS/PL0b7Jz9AUFQ2Qlmb2/mP1mYQDxFO6fXIo2vh2WYNljjoPmMVthh8hKyvdDduBvoXt5xvPXU8EWdsbu4bclGiZNTG/nBIV00s3wr2ThyEegEnEAer8N7qMcuawlSYFGVndI9/PzzAkV+JBe5oqt4Aa3bMVHTZWM4HdT4SYoyQIHQdYIKORWbQbX1Ji/9j+ZtvfdOvQlU0ojg4NFf6GdWhIGtudDoVl4TmNt8bQJ4ABvDHqzxv1wO6k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(346002)(39860400002)(376002)(6512007)(53546011)(6666004)(6506007)(6486002)(478600001)(41300700001)(83380400001)(2616005)(186003)(2906002)(8936002)(5660300002)(316002)(66476007)(8676002)(66556008)(66946007)(31696002)(86362001)(38100700002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVBLN2l5QXdWRmZ3UytDRGtFTURtVUFMWDIxS1lLb1JuTmswQm5BTFBHMWYy?=
 =?utf-8?B?WXBUM3Z3MUNFeWE1SkJzbXhHZGVFUG1CdTdkV1hPU2ZiZGxUSjlncE1lTkZl?=
 =?utf-8?B?dFV5RDZiOGR4eVJlOExyNEpLTzZCSzVxMmN3Q21PSTR6U3c5bmlqWGdadGxW?=
 =?utf-8?B?aGhueEJJUkI5N3hPckZvUzV5L1J3MEVJU1NFeWRsL2lraDR3UURoT1k5MkZt?=
 =?utf-8?B?c01EdTdqejZyaWQ5d1l3SUxZSzdjMHdSOHlTZWlqYXM4ajJWMGFIeFRtWUhN?=
 =?utf-8?B?QVY5NHlWYWVjWmNBdk5wY01ES1lxaFo5U1BJNWRoZ1RyMFpzZFl5NUcrem5a?=
 =?utf-8?B?RXFEd2pXWEladG4wQ1RjZmFLSzJ6M1NrWG4wVTduendFSlJEeTUwNDl1N0JF?=
 =?utf-8?B?ZytKMTFlZGlkUjNsTEJCYUZWOTBUVHozWC9PUURrMmo2cVBnUkR4TjZHZWh1?=
 =?utf-8?B?YWlXWkp5VGYxMmVTbkRTZWVTZFZBL0xqYjJqSEsva3I0V0VzR3JPQ2I0Undh?=
 =?utf-8?B?dzZrekJlRithMkRMb1FxK1RVb1A0SjlXa3VUR3JrQVYvalJVa0E3NGVlZm9I?=
 =?utf-8?B?TTB1c3ZXUm15WEtybUVSS1laV0ZQSlZPN2VRUzJ3amxxWDBRRG1TUjN3M1Uy?=
 =?utf-8?B?NEFhcFFzSy9vVnluSEc0aHRhQjRsK05walhUWTZNQVVVUlhaSGt6STh4SWRT?=
 =?utf-8?B?azZyd3J2N3AwQVcwSXhjZmRnbCtBRFp5Z05rdHJ0bjl4UFF6LzZEV2xlMWM1?=
 =?utf-8?B?SitiK05lcXNUdnZvbU5BL3RuVXR1RTNvWWpHOFVXTlV6MW55dFRUdzJwVllL?=
 =?utf-8?B?UmgyTkFtUmZJT1IrT1VPVGwvT3V4ZytLQmlLazQ1RGUwZkZIV2oyYXFnRnUy?=
 =?utf-8?B?dWtHaThhQlFJbUtqdDg2UllEcjk3R1h4TEYyb1FtZHlSZXhteHMyM25UaFJy?=
 =?utf-8?B?NFVSMWlhb2RxZnNObmo1andNZ1Zpb2Vicm9iSWwwbUIzdXFMYmZFTGkxTnA0?=
 =?utf-8?B?NzVkN3Y1MHFhTm1sUTJHZmd3WjFBSkdCNEltSmErR1Qwa0l6MlJWUEZzRDhD?=
 =?utf-8?B?NDRrMzRXR3orRUhpdjFqeXR1VVM1MkpQdTlNUjFxQ3dIdHRycXpETEMrcnIw?=
 =?utf-8?B?Y1ZjcC9JMXpuZjdMOStBZFQ5RlJoQndlOHc4SmtSSlh6Z1VFdFVMU0F1c3FB?=
 =?utf-8?B?OGgvNllzQ2tMeTRxYWdYZndlWkhJMzBmVHRyTXVsV3dwaFlVaWxWTklYMG1i?=
 =?utf-8?B?RzFqMWV4SFBTMlJPNzY5VzRNYTl0TnAyVTJVcEozMG54QmU2T2RZeHVMYU0r?=
 =?utf-8?B?TzUxRTRBSWZBYm1Xc0V3U3ZVT2lXS2R2OWVZUVdLYTAvL0oxbHc2OEtNaUNz?=
 =?utf-8?B?M2hwWDc3SXFidndtUmhOUDNNZTdPdCt3dVd4aWh1NXZKc1pOazMvb2UzdWk4?=
 =?utf-8?B?c29SckFOSTFiK0hMVFBCY3RiMjlmMVR3M2h2YTlFUkhMK1FHZEgxRmw4TDUz?=
 =?utf-8?B?aHpJdGI2VzVWRkRQMUJKQXZuNlpqWm1ndFRNb05QaGxhWElUeDk1VkhFSVdw?=
 =?utf-8?B?TGwwMUxmTVhIdlE3WThzdk5wck5OYlZJRmRSbUYwcW5iS2IyR0IxOURrdkxF?=
 =?utf-8?B?ZFQyVDM3em5Ma0Y2dFROODlaNXdPTmdPT3R1bVJVQW9lZzhCYXZHTWN0OFdK?=
 =?utf-8?B?eTN6YTF4N3U4b1ViZzI5a1BFamQ5UVMzbHV1SjFsbUxUSmlVNUVVTDdGWlBu?=
 =?utf-8?B?YXkrWDdncjY4TTV4c1BGd0p6RGg4amtwTU5KS1hVd0NYZFJHMVlFVEZKK281?=
 =?utf-8?B?Y3MrUTlPRlplWi8zbCt1Skd4SGVpLzNPQzE0dFJva0tCMjkwb2FmSEMvdUE0?=
 =?utf-8?B?dmpheFhwWmprOS9FdU1aS2xSejNERlBlRW1GQ0hvbjhXZnlkSzM4RCs4NVFZ?=
 =?utf-8?B?bWpUbitoNG96WDFNVEVnZ004NzF3VmhMQXc3UTd2amRNYTBBd1FiUklRWDRL?=
 =?utf-8?B?T2tuMHBwbDVZVW1nOE5lU3M0WGEzUTFqWG00Umo2S2R2UkFBdnRiYmJYRHJi?=
 =?utf-8?B?Njk5Rm8raHp5R0MyU3JCRjhlYzkrM1JVa3RDR2VXTGxHSnJFTUdFS25iakpF?=
 =?utf-8?B?VnRHQXlvZDFDZ3FMaEU4VmRBVFdPU1BGdGNWZWZJUmQwcHg0aEc0K3VnTkti?=
 =?utf-8?Q?t6D9AxJRp54KnsrjEIv9EXU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 819720d6-5fe5-4b0a-42b2-08da8cc6d4aa
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2022 09:38:02.6625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYOsg9vu3m4GZ8lclt0s5/RimlaFeJOuVL9VDZGpx/uIJ6xU1j16cEZghLhAS6pb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4376
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/2 17:21, David Sterba wrote:
> On Thu, Sep 01, 2022 at 08:15:07PM +0800, Qu Wenruo wrote:
>>>>> --- a/common/fsfeatures.c
>>>>> +++ b/common/fsfeatures.c
>>>>> @@ -172,6 +172,14 @@ static const struct btrfs_feature
>>>>> runtime_features[] = {
>>>>>            VERSION_TO_STRING2(safe, 4,9),
>>>>>            VERSION_TO_STRING2(default, 5,15),
>>>>>            .desc        = "free space tree (space_cache=v2)"
>>>>> +    }, {
>>>>> +        .name        = "block-group-tree",
>>>>> +        .flag        = BTRFS_RUNTIME_FEATURE_BLOCK_GROUP_TREE,
>>>>> +        .sysfs_name = "block_group_tree",
>>>>> +        VERSION_TO_STRING2(compat, 6,0),
>>>>> +        VERSION_NULL(safe),
>>>>> +        VERSION_NULL(default),
>>>>> +        .desc        = "block group tree to reduce mount time"
>>>>
>>>> Like explaining that this is a runtime feature and I have not noticed
>>>> until I tried to test it expecting to see it among the mkfs-time
>>>> features but there was nothing in 'mkfs.btrfs -O list-all'.
>>>>
>>>> This is a mkfs-time feature as it creates a fundamental on-disk
>>>> structure, basically a subset of extent tree.
>>>
>>> This comes to the decision to make bg-tree feature as a compat RO flag.
>>>
>>> As we didn't put free-space-tree into "-O" options, but "-R" options.
>>> So the same should be done for most compat RO flags.
>>>
>>> Furthermore I remember I discussed about this before, extent tree change
>>> should not need a full incompat flag, as pure read-only tools, like
>>> btrfs-fuse should still be able to read the subvolume/csum/chunk/root
>>> trees without any problem.
>>>
>>> So following above reasons, bg-tree is compat RO, and compat RO goes
>>> into "-R" options, I see no reason to put it into "-O" options.
>>
>> After more consideration, I believe we shouldn't split all the features
>> (including quota) between "-O" and "-R" options.
> 
> After reading your previous I got to the same conclusion.
> 
>> Firstly, although free space tree is compat RO (and a lot of future
>> features will also be compat RO), it's still a on-disk format change (a
>> new tree, some new keys).
>>
>> It's even a bigger change compared to NO_HOLES features.
>> No to mention the block group tree.
>>
>> Now we have a very bad split for -R and -O, some of them are on-disk
>> format change that is large enough, but still compat RO.
> 
> Agreed.
> 
>> Some of them should be compat RO, but still set as incompt flags.
>>
>> To me, end users should not really bother what the feature is
>> implemented, they only need to bother:
>>
>> - What the feature is doing
>> - What is the compatibility
>>     The incompat and compat RO doesn't make too much difference for most
>>     users, they just care about which kernel version is compatible.
>>
>> So from this point of view, -O/-R split it not really helpful from the
>> very beginning.
>>
>> It may make sense for quota, which is the only exception, it's supported
>> from the very beginning, without a compat RO/incompat flag.
>>
>> But for more and more features, -O/-R split doesn't make much sense.
> 
> Yeah, the free-space-tree is misplaced and I did not realize that back
> then. That something is possible to switch on at run time by a mount
> option should not be the only condition to put the option to the -R option.
> 
> Quota are maybe still a good example of the runtime feature, there's a
> command to enable and disable it. There are additional structures
> created or deleted but it's not something fundamental. The distinction
> in the options should hint at what's the type "what if I don't select
> this now, can I turn it on later?", perhaps documentation should be more
> explicit about that.

Quota tree is a special case, just because it's from day-one, thus no 
compat/compat ro/incompat flags needed at all.

To me, we can accept one exception.

> 
> For compatibility we need to keep free-space-tree under -R but we can
> add an alias to -O and everything of that sort add there too, like the
> block group tree.

That's simple, make -R deprecated, and treat -R just as -O internally, 
and put all features including quota into -O.

Of course, we may need some small changes, as now one fs feature needs 1 
or 0 compat/compat ro/incompat flags set.
But everything else, from the compat/safe/default string can be 
inherited from the existing format.

By this, we have the minimal code change, while still keeps the same 
compatibility (in fact, greatly enlarged -O options)

Thanks,
Qu
