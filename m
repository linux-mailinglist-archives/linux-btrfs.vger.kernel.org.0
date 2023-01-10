Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986D0664F8E
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 00:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbjAJXDZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Jan 2023 18:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbjAJXDW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Jan 2023 18:03:22 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2079.outbound.protection.outlook.com [40.107.14.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112701C907
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 15:03:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeRrl1HTM8ZvKLd8JFZZ5dfA+MKpHgY5Q/XvK3i3abwDCQDjCPVZg/26Cl+bMgQB5bOsGZy9Efbqg7ZsYWJdOr75ah0bpKltcgx+/A7KkAJtHwSqhSBR6kWjBPt9t1VT/gRAWgvwEPfpmQYAKrwdHhNPwfNixwiIAdGhsoNIdNZl0FKeyoS1ZOtBq+Fnu/azdYjymcycSBeE9DVow3uCsFCc4rmN6l2gZ8ljY9xfMyDduUs16XZCJXEAaMP3z+30Xl9VtLzMi0Srpw5mH5CBp0h+heLqUMqa4q2PVmbq7jyTWH65CVx3NCbejLb49iixrGQJGAe+so8xZcrFv6HlKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2HCHblOl+zzWo7My7WHeQ8X+b9YI6NRjtRCUs9xhFQ=;
 b=ZMEWrpr76v1Fw8k7hD/tNjBgc1lmNI5WmwDgLKE8vkijE+PnwuOb5mZFfHg6RYhIN7Wz/NGYljGSrEmEMnb7exhM7CdqrdxWSK0G2KUVUyLTo7/KhB/2fpmt4+ARLwCZebvgsQgl7mclmbFCFr5z3W7EX1NgbovUTs18OuJIkxYJps4xdi7vD8yZ1ELzMVsOkt4CeOl/cmk2EUSEE7oakS1BMtXB8JvIvbIaC0FDxe7FDStKII0VZQMG3KV1g0kv2jJb1gv2zt5zFyBRz+fIGcxFtU8e7lIF6lIna7h9LF0xBzclway/EnO0yz3jWEQE+HqJUXAOqcIaJGrylIg/RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2HCHblOl+zzWo7My7WHeQ8X+b9YI6NRjtRCUs9xhFQ=;
 b=KHl5vXVR1UoBl7KerEUS7Mp6+RzYoyNtlBwZm1eU+KzSyGLUh3CqqRHviJHD2z3cZcDsUGw/CwBtTBUDQbt9i7nyHzCVzE3sspMEzgicgyJZRxvtKKTyRrNB2TZ4MFWGPZMiPQPkTHLrxUsbnD+gdjx2alhpXyFbyyUCb4qn9msP8cn1ssJrOKNpmUYVzxX/XbDgCG5vU9ng69/JwQgcmyTiCso2k/a/hFOvPnOTbeRLwaJCYL74j69NiZLGrSFPSB39sZx5CE4ywBKMT1VDHvSv667s42xTxTPSxePlWHVBvNh5beuN/NOzhg3lEYuAMbOtSs1pUTfbruIkMjafKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM9PR04MB8745.eurprd04.prod.outlook.com (2603:10a6:20b:43e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 23:03:15 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::5c50:6906:e9a4:5b9f]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::5c50:6906:e9a4:5b9f%7]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 23:03:15 +0000
Message-ID: <583a78e0-8dd0-b6e1-ca50-4977940013b9@suse.com>
Date:   Wed, 11 Jan 2023 07:03:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/8] btrfs: do not check header generation in
 btrfs_clean_tree_block
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1670451918.git.josef@toxicpanda.com>
 <ef73c4c67028f9e7d770dca236367f1ea0b56b55.1670451918.git.josef@toxicpanda.com>
 <0507a942-2a82-f086-2be5-a9ac64e4c1d3@gmx.com>
 <6f22220e-f660-92d2-5241-fb9a353090ac@gmx.com>
 <20230110153343.GF11562@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20230110153343.GF11562@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0186.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::11) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AM9PR04MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: 4712db2a-53af-4fd6-583a-08daf35edb13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sphTR67+p4YPqzElHaozoYtBMAgFNhRVLva0kEmznh5qDWzZGsRp8wK8Wya2srmnWihlfg8c2NL1mCv1Th+xzTz49lV5Uhn60Qt/qDLXOswcL1TeFJlLzuT7t61QtEqpatUdy6cD/6NUF/oVSU0YVefnUpLsPE/v5RWB1gn5z0jr43PpijrxlgWD0AsCJkXP0w3nVFXhlw/dVgEe2nG+Xykbbm43uCtjnvefEf/ZT4Lphf+6jDHqsFacW6bKQ8YAoo/T9H8Sqxk7gG48mZuDjam/DGLyDhRkWCgyw8NIUt2OdAj1cvRqJRUZ5tQyeEWZDWleEBEosoXN7nr8bNbqEd2+9D0ssdYa58lhnoG6xRx2a+BpydgrvrCGrsNxnBDbyedf0sVOL+qdKMnxpmO5OkpnenvO+OMYvwn7zR73y6bUMVsEoaCRGKmqJy+w7i/pQuysdVIdfOj+3nqWDQuIi3HPN4J9Pv47dBfFhrw4h1cHUBF5lxjIIKshQuuNdhwjUXVDbxMboh0nwhjPu0LdN+QyoK8YuAqVOmquF5nz5AZWfE1BFM+Dz8HKzowrTPhPGhxZ1yLcsplLAnFh8z3aoarFIMBQy9oZhTff8V0BusEaHyApmMLovNPn/H4KRqFbei/kfD3U/wC08QC/w9vwL5RhIXouIxBGzHjzqZanDbT9Qzia/A3X39BNpbBV7NWKrkJmRpGQJXEDfWvOizuo0dcWub7XBeH5d8gT6ufAG+I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199015)(5660300002)(8936002)(41300700001)(31686004)(2906002)(66946007)(36756003)(83380400001)(6916009)(66476007)(66556008)(8676002)(4326008)(316002)(6666004)(186003)(6506007)(6512007)(478600001)(6486002)(86362001)(53546011)(31696002)(2616005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTJKY2ZrVDFuVHFUc25QWDErQ1g5RUVnV095MHJjL0xEZVZGM0lNcFU0VDlw?=
 =?utf-8?B?NjlBM3pJYTBwTjNWOGpOemNhRGI3T2FIUjRVUjg3TUp2Z1htZmRyNWdwNjVS?=
 =?utf-8?B?aThZaFAzT3VZcWk2WWJhU3k4eWovbVpSeS91YXZyT3FzdHVIemVWMnJ0aTNL?=
 =?utf-8?B?T21rOUdPb21HdlRXbEo5cVVQKzBvM3NkbTNiaEpuSGxWYTJrVHM3RDl5VEpl?=
 =?utf-8?B?Z2hKc3ZiUHcyWDlrbHUxV2pKNUc5TW1ubDk1YWV4cTc0UzBiazAxdUN6VHZD?=
 =?utf-8?B?TW9DbTVjUitrTCtFZUdzUnBKRmtnTjJRVlo1N1ZENEI2THZGc1N1ZW92cjJn?=
 =?utf-8?B?SWc1bVVDVmNLYmFSL2EyOE9TbWRDZWc2V2RNZ3dLa1l1NEUvUjVROXBnVkRh?=
 =?utf-8?B?c0lQSVpyVlpxOWJtUm9LOXlLZEhZTHJkRWJSSzJIV21MdVVIQ0tZcWdXaEVs?=
 =?utf-8?B?RzUxNGdSbzg3Y3lZVVBSZmdiZFNRREtVUUNPRThMTHNZM3dSL0JoZzdOWkE5?=
 =?utf-8?B?Y2xVQjVFVWJFejdoZ2huRXQxM0RUekhObklybmF4MGZNQXBuMkVaT1AzMjNv?=
 =?utf-8?B?WWxIWTVlbFNFWjVkV0tmcmROdXoyYkRtUStXWXdvVFZKeUxnUUh3MXF6ZDFp?=
 =?utf-8?B?U0pBdjUyVHB3dW5jczg5amczTWtrdHg1Nyt6L0pQdUR3WmxXWExTL2txbUNM?=
 =?utf-8?B?S0dlTmswdWhvdVk2bG5FRlVIeGczV1R5M3U3aEhWd3hLY3FUb0I3RCtYeDM5?=
 =?utf-8?B?Z1ZBQWlwTzQrQTNxbTVDUWt4bmxEVEpMMERYV28yZ0dKUUVpdG5iTjBxSTBt?=
 =?utf-8?B?ZkozZmt2U2ZqRkVHdFRjWFpzMW51SWU5ME5OUlRZK252MkFMbm54ZUdHTTVS?=
 =?utf-8?B?QzV6Q01HNWd1V09wUTZialMrQlV4djU5N1R0V05rYTNaUllEdnJLNmN0SEtU?=
 =?utf-8?B?ZUpyR3FSMTJ4c0VsdFhmaVNXYVdCeS96NkcwT0dpQ2tkdjRRektqbmF5aGZ3?=
 =?utf-8?B?RTdLU3JwcU5UVlFBNk1jcDQyczRlRGtGVEpib1lVaGVyV01hbEdtQ2FNU2Js?=
 =?utf-8?B?Q3JxNmxsU3h5VUJndkxONURNWVZteXcwWjl1WUUxMWt6Snc0cUVmYkp2TWhr?=
 =?utf-8?B?OXozRURHSnlYME1WZjBNRE5JckdqcTdkcEZaZFgzRnJURlROdmpEREVXMFpV?=
 =?utf-8?B?c1RSbWRRSjZ6UkE1eTFDSWFURU5qVkozdGVOcHNaYTVoTmNqZ3I1bHJNZHRk?=
 =?utf-8?B?YzlRMFpROVZDTVY1UUxpM3RURkkvdE1hYkl2cjJkZHlGRU1IbXRTR3hickFm?=
 =?utf-8?B?T2RpZ29MVG05Tm5ydjluUThuZG5aZnNrMzI3MFZ4V3ovc1RHU2VVYVlYc0py?=
 =?utf-8?B?VkpGVlZ3UUxzYndWUm1KMUppM0dDZy81cFgzNHkrN0VqZm9kVjlab3NVajc4?=
 =?utf-8?B?TkRYUy9rNXd4clBreGcweTRKaGlUczBsakhGZlBJVHpFSEMvbzl0T3VibFh3?=
 =?utf-8?B?T2g5d2svNUI2Wm5GbllGSFRDMitlOHlXTTBUTUs2cEg0Ti9tRnllaWtVWlJs?=
 =?utf-8?B?bkI5YlVzcitudTdERTVzV0ljRStlRnJGcjV2RTYwN0hrWU1OTTQwcldHYWJK?=
 =?utf-8?B?RGF2YkNtWi9wSEJpTDhNSit4dVEydHdyMkVyekJLdkJDdy9ORGkzdFNSRjVl?=
 =?utf-8?B?U09tenppNU5Ka1M2RVVVazNaOVlwb0hRdFlnSUdHSTFBYW9GQ0pGaFNnMG50?=
 =?utf-8?B?QUM1YUNsMlJ4czJwd3hZbC9GUkNBZ0lxRXFDblBWRktPRjQ2c0FBcDc5SzI2?=
 =?utf-8?B?b3FWSHVEZmFtZDlVUCtoc3RLaTZtTTJtdTREdFpCbWdIN0xzZVNjOGh6TlM0?=
 =?utf-8?B?SkZRcVZuRGJRNU9QdW1Lb0NaTEZUUVJPUElPUGhEajhsQlNYYSttNTV3Rkdr?=
 =?utf-8?B?bVFBajYvY20rbEhBY2MrRW5TelNjdkZQUmpMYzlLRHlBYXRPTVkwQjVkMklQ?=
 =?utf-8?B?bEJNcWpOUVBqNEg3SkpkVFg4c0JPNTY3a1cyaTNXTDlPNUxRbkI4VnhyQ3Jz?=
 =?utf-8?B?TDZxOUo3eWp0K0t2WnBUV2c3dmJxUThXOGptaUs0Q1pMOWVOZ01qd1JDdm1Q?=
 =?utf-8?B?VWc4MmRrL1N3ZDBBRVFlZElwN2h0UWg2ZWJPczdLSE1TeDNibFJBcnU5NEtE?=
 =?utf-8?Q?Y1qUqk44HCrkOhcT7+brZ+k=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4712db2a-53af-4fd6-583a-08daf35edb13
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 23:03:15.7437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77Hn1wPZ1/Tcn9O9r/EJQPGo5PT6cBDt/y0Se8oQhxvSmfdnuc5SoMl7mxhFQNm+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8745
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/10 23:33, David Sterba wrote:
> On Sat, Dec 17, 2022 at 10:10:24AM +0800, Qu Wenruo wrote:
>> On 2022/12/16 13:32, Qu Wenruo wrote:
>>> On 2022/12/8 06:28, Josef Bacik wrote:
>>>> This check is from an era where we didn't have a per-extent buffer dirty
>>>> flag, we just messed with the page bits.  All the places we call this
>>>> function are when we have a transaction open, so just skip this check
>>>> and rely on the dirty flag.
>>>>
>>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>>
>>> This patch is failing a lot of test cases, mostly scrub related
>>> (btrfs/072, btrfs/074).
>>>
>>> Now we will report all kinds of errors during scrub.
>>> Which seems weird, as scrub doesn't use the regular extent buffer
>>> helpers at all...
>>>
>>> Maybe it's related to the generation we got during the extent tree search?
>>> As all the failures points to generation mismatch during scrub.
>>
>> I got some extra digging, and it turns out that, if we unconditionally
>> clear the EXTENT_BUFFER_DIRTY flags, we can miss some tree blocks
>> writeback for commit root.
>>
>> Here is some trace for one extent buffer:
>>
>>       btrfs_init_new_buffer: eb 7110656 set generation 13
>>       btrfs_clean_tree_block: eb 7110656 gen 13 dirty 0 running trans 13
>>       __btrfs_cow_block: eb 7110656 set generation 13
>>
>> Above 3 lines are where the eb 7110656 got created as a cowed tree block.
>>
>>       update_ref_for_cow: root 1 buf 6930432 gen 12 cow 7110656 gen 13
>>
>> The eb 7110656 is cowed from 6930432, and that's created at transid 13.
>>
>>       update_ref_for_cow: root 1 buf 7110656 gen 13 cow 7192576 gen 14
>>
>> But that eb 7110656 got CoWed again in transaction 14. Which means, eb
>> 7110656 is no longer referred in transid 14, but is still referred in
>> transid 13.
>>
>>       btrfs_clean_tree_block: eb 7110656 gen 13 dirty 1 running trans 14
>>
>> Here inside update_ref_for_cow(), we clear the dirty flag for eb 7110656.
>>
>> This has a consequence that, the tree block 7110656 will not be written
>> back, even it's still referred in transid 13.
>>
>> This is where the problem is, previously we will continue writing back
>> eb 7110656, as its transid is not the running transid, meaning some
>> commit root still needs it.
>>
>> Especially note that, I have added trace output for any tree block write
>> back (in btree_csum_one_bio()).
>> But there is no such trace, meaning the tree block is never properly
>> written back.
>>
>> This also exposed another problem, if we didn't properly writeback tree
>> blocks in commit root, we break COW, thus no proper transactional
>> protection for our metadata.
>>
>>       scrub_simple_mirror: tree 7110656 mirror 1 wanted generation 13
>>                            running trans 14
>>       scrub_checksum_tree_block: tree generation mismatch, tree 7110656
>>                                  mirror 1 running trans 14, has 15 want 13
>>       scrub_checksum_tree_block: tree generation mismatch, tree 7110656
>>                                  mirror 0 running trans 14, has 15 want 13
>>
>> The above lines just shows the scrub failure for it.
>> As the tree block is not properly written back, we just read out some
>> garbage.
>>
>> And unfortunately our scrub code only checks bytenr, then generation,
>> not even checking the fsid, thus we got the generation mismatch error.
>>
>>       ...
>>       btree_csum_one_bio: eb 7110656 gen 26
>>
>> There is an example to prove that, I have added tree block writeback
>> trace event.
>>
>> Thus I'd prefer to have at least a comment explaining why we can not
>> just clean the dirty bit for a dirty eb which is not dirtied during the
>> current running transaction.
> 
> I've temporarily removed the patchset from for-next so we don't have
> test failures over the holidays, now it's time to add it back, but based
> on the above there are changes needed, right? If yes, I'll wait for the
> update.

I believe we should drop this patch from the series.

But since it's at the very beginning of the series, and a lot of later 
patches are depending on it, it needs some work to resolve it.

Thanks,
Qu
