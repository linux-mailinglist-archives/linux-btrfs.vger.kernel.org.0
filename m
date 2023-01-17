Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F22670E5F
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jan 2023 01:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjARAFA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Jan 2023 19:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjARAE0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Jan 2023 19:04:26 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87C9C1325
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Jan 2023 15:17:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTgnaJO2wPK56q7EM+vkEqv2RR41fdYvPHZr06V40O4bYCbQb1WtUkrEsEa+94PXYG69UtqGN8ZIGJfTBUTGqvPOppeN4ch0nZeBp4WCcLp7gcD3NSsRu7FSAbgtUPmuPS7oYAHKtBvgsJSPYpaoayIDVP3OD7UtS3NEuz5V2mjz9rU8QVcn6auZZ+iomNfAR8OYb3Ukl45Ru3kKkc2urEc9Psm7NtyxwnrHnhcpLUSCTB/25bTgJp9iHBNAFM6Xh8wTuEk8EGbevbrpJG3DbksIP7Nud10v0BnVudKMbZOMfolBY/6dmQCkGtYuUDjsUC6+AqEPJpaKYglzT6fk5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uXAWCQxMtUTZF2a6wjWD2NexOnMcZvdKKyBTCyBA3Y=;
 b=TZFnd9hchAUqqHWZ+HSGBiQbJhcmlfKyK0VLq5bmRN4Mip2MxAbjX0tMJu/12e9+SFmQU8F/V6br4usnNLhwQ5VoRsvTfXX8S0rDDIRRFV69QQLC/uxUH2Jk9YGNKNSoSyYnobkcnBSumVLXHJt/gmRjSGV8OA+3DqvpRaecg6uILGYX3gajpe0MF/qd+pdGVPh6hnUt3tZWScnNtvw/RAywRdjsJT2G9kVgL2RGiuMsF/QVR9heZvUR8+6YkBPtaSKKiNAEKvNi5Qg5ZVoP81olWQH/S6jqrdfd79kkaXtkmL8AzrUOa2ptki1MN3fMKQMeiP+S6S5VAM17tV4ppQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uXAWCQxMtUTZF2a6wjWD2NexOnMcZvdKKyBTCyBA3Y=;
 b=dRl4Y2uF9aO5kTxPlZSlHwIxXQtShQBahlEvhHdsf3MSZY4eWpm9qMwBk5FQBbwvO0pP12xpUYjYC+7D/vTUSYP0elsz3C1tDakskvB3VdX5aPHqh9y/i0DI8c6ftvPIwRzVu2ppAtulHvXDd2Qa2v8cbmNve4HxNr5J6wfn1vv8FhAUNGnBIYRgSyDAN0kHDHwwr+pWjGJ8F1fKkyq5ETQensB3QbL5WGfEMXj31VwWLpnojiIH7DknSTEYlgrUkTaTT0rSD0G9gLqxHFQLI41jG3JSLeEcVC/mITcyJZ8ts67ZWZ9k0khbwWVpx9JifKCMn4D9AfeS5zISUoqLEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PAXPR04MB8349.eurprd04.prod.outlook.com (2603:10a6:102:1bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Tue, 17 Jan
 2023 23:17:26 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::5c50:6906:e9a4:5b9f]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::5c50:6906:e9a4:5b9f%8]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 23:17:26 +0000
Message-ID: <29028862-29f4-09a1-eff4-165e47781788@suse.com>
Date:   Wed, 18 Jan 2023 07:17:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5] btrfs: update fs features sysfs directory
 asynchronously
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <c750a14702a842dcd359b05ee79700ae0d0f550f.1673608117.git.wqu@suse.com>
 <20230117162025.GB11562@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20230117162025.GB11562@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN6PR17CA0051.namprd17.prod.outlook.com
 (2603:10b6:405:75::40) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PAXPR04MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e11b9a-49b7-40a3-f907-08daf8e0ff51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y3pLZzfOqfn0Bb78TQYnzS0oup1fKHPguDM4p5cqAY5kJ3QOg+fIz0tj/GAB8bjZEVVq9T0InblBckcCUVzBQWLz6HKwb/OBHBg465DlAn93kU08vOQ/o8kDCo+NNP1F+5PI7LHoC4M+C2pJMuDspQ/RDEQlfLJnBO6NnwmvNM9Jf4RSCX2HZhCmkDgqFzGHZZ7Uitwx3kiYpYQjL7DD6jHSb97dPcbZBiIHSVCOCNctJmdDcIdbEenGVfS167InRowMrz6JP1aydwP4qkJ0FumU8jMTSl1fq7xrOQ4TBR7N8DZM+cpCv8KPAbZDjZuxzOaPTcMXAB6T+SB1/Eu3baZSpZjP+mhdcIB7wSnEIPsS/7SinzdDqdMPqi7i8S+zctGgsJ6FnI45i0nlwUmxaExVfe6Zrtq0Wn7RSehHj9fVifcltZPnRMjDdjRNvuV6NyGWpMu5LSQUWwYjOSM8GtRqJNN3YgQkOcO48YUX/1bqPAJv/agJKts4LbaUqfgw8IWhclEDP5Cf6UU9AYa5/YYfE0YHheVWPBje33et3mHUHbdHlE0ThWX4uViLw4X8xFQj9SWtsfqUn9LNmip5kOSwHSBf/HAO9V4rosdd6q2UutZI6aF1iNP+7undREXw9JkDSMQVEW3wL3HtesmNGkA3DAshld0rPmAQ0ZxKZ6MBfYI00BIV1jMsM6alJsvNNjLmIUuOdjjNbgI+VoI1AlTYLvKkWfZHdHhch8SmFSg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199015)(66899015)(31686004)(36756003)(8936002)(86362001)(15650500001)(66476007)(8676002)(66556008)(66946007)(31696002)(2906002)(5660300002)(6916009)(4326008)(38100700002)(83380400001)(6666004)(6486002)(316002)(41300700001)(2616005)(53546011)(6512007)(6506007)(478600001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDhjTUxvZjdMdFl1TGJmemZ1eHMwa0YvWEgvNVlOakVHcTNGMkNwV1FzcDM3?=
 =?utf-8?B?Y3BlRXdnUHV3Tm0yMDVtUjdva00rQVdmTEJ2a1hzdW5CL1VvdkR0dTF0NHZx?=
 =?utf-8?B?THdSd3ZOenBRSGdab2dKWGx3SExWV0NzZUtiM0ZteldwY0lrd3ZMeXJ5OThE?=
 =?utf-8?B?ODFUM3FUTG5UdU0yYVF0a3hkQmJOZCt6MGx2TnBYVzVuZXRBdnJvMjRINmtJ?=
 =?utf-8?B?elRYN0RldG1RNXVjdTlaMTdOM3lTSHlrYmxWZnMzRlNMekJlYmRyTnJkSTFq?=
 =?utf-8?B?Q3JWWFdIQ1YxdUJCbjUzSUNGRlFYbDVmY1pISUcxa2JGRjR4eVovc2dPcXUx?=
 =?utf-8?B?U3NOYVQxR2QyZmdHRTJKVmV6STliRTd6Ym1nOVhtU3Z3Mk9HaXVRWnJ0bkoy?=
 =?utf-8?B?N0VtZ2Vsanh1SlVsY3JhM3dKa1dTd3N5d2RRVVlZdjl5ZkFWd2daeGpBZisy?=
 =?utf-8?B?WGpZU0VRa0hOV1ZJRGV3c1NMZExCNEdFcXpYakhYd0FBeDVjazQ1TnNPRFZy?=
 =?utf-8?B?d21PV1BKTzZ3UHJYY1VLYzN4T1Z4RFJiL3lUTVBYVnp0ZDZzZUZWdlFkdlVp?=
 =?utf-8?B?RnJ6RE5Jc3NPY01iNzhoTDhkaDU4UGtGWm5xb29jakl3MndId0d0UGxGS3dy?=
 =?utf-8?B?RWlFWXY0L3RLeVArY0VXRldyVWJYRmJIM3p3QmdqcmRkcW8wb01waUpPNVlx?=
 =?utf-8?B?MHIyVEQyLytiTVAyb3ZubGZzZWF5SjlaZHd3ajA3dUVpM09RQlRZaGhybDlj?=
 =?utf-8?B?N3djUXk0RDBabXdBeHNiQVlRak9kSjh4U0tSTFNzbm9mZitHTVFneE9ISFFF?=
 =?utf-8?B?b3B2V1ZGbk9NaGJjbjkvWE5NUW92cmZGQlM1VkdNdFNBd0hOMS93MUg4V3ZX?=
 =?utf-8?B?ZGFHNmptVTRDN09IaWlJNzgza1poalFHV3FoU0FhT1UrbGpnMk55WjBxYUpt?=
 =?utf-8?B?VS83V3pHVnJhZzNBWXdYVWZobWY5V3JwT0NDckp1V1d2WkwwS0pBZUprcUpF?=
 =?utf-8?B?ckNyMW1vbHluaGhuRzZMd0ZBUTVmaCtkck42TmtvcGxEcU5OZGQyam5FY0Vu?=
 =?utf-8?B?V0hvRTRjTDZRR1cvNHg4REdkN3R6QmVCRHh0V1J4Y293STlzZGNuemZQa3B1?=
 =?utf-8?B?RXpNcElLdXoyZWpiSDdxczlPRTJxc2tjSGhOd1FPZUdGQ2xIUW91U1dQb29l?=
 =?utf-8?B?bmtXWkZsRDZwTUpwQVJ0d2lTUGd0c25tUG1mVm9YSFB3bmJIelpTM0hPUWhQ?=
 =?utf-8?B?NjdOQ1hqaDdRQ3NTZXFvQTNMcFlVQmMxYWtQb0k5d1JvdE5obUd4TFpHZmpo?=
 =?utf-8?B?TFh5REdGTFV0TmpqMHZHRkNLZXkvK1Fkb0F0cnJzTCtoQnJhNENZZG90SXFw?=
 =?utf-8?B?ZUt4YzRHekxXUE00bWZiYjhIZ3BQQnd0UTFINHpnVHU4cHo4MGZyMWlQb3d3?=
 =?utf-8?B?dXc1Q2RCWUJIbkJ5OHhsdjN2bDR3QmVtQ01QMVJzWkN2M2VmQXVxQnpZM0NO?=
 =?utf-8?B?TXhiS3FuK2RZUXMrbUZ4NEtmajhlMTNWMmhOMWRPZ3lyMCsvaGVZdzMwLzVL?=
 =?utf-8?B?NjNMb1dJRjJMTjBQdllkYXlQc2hVc3pDQzhBL0VYS3AxbSsvRmxISHlxVm1y?=
 =?utf-8?B?QVgvakZjeEFXbzVDOGhEVGc2bjA5MHR5emZPcEZ2MGhnbExJQTVnYTRUVnB4?=
 =?utf-8?B?LzFGQy9wa1Irb0pYdVdnMXdQbmJocVl6RDdBUFJsVmxWRDdlb3FrNW9QRUZW?=
 =?utf-8?B?alpRVUNtOGVtRTRRbFdjWjZoUTNqd2FiVkRZZXpjdERVQ0o4bXRSQXAyR3VD?=
 =?utf-8?B?VEhoZnhNOWdJMlRDTGJZT1NWTXYyTVR3SmdzZUxCcmJrNy8yQ0x3Wnc2bEVZ?=
 =?utf-8?B?SDhPU282UVY5UUhvblprWTlsWHJZNHZ2STRWVjZBNFlSZFBKU1lHTEl3dkFq?=
 =?utf-8?B?NHZneHJhUVNMVjExWFpzeWFWdDZlaUJSWE56bTJ4Z2lTdVRNUXB6VjNkUkpD?=
 =?utf-8?B?WHFBeXY4cnJ2bUdFeFZWczBQblU4SWhIRlBjNUhDdndyUUkvbXdxNDJLN3B6?=
 =?utf-8?B?OEdyejZhUWc1YUdXNTV1cHZPREJTR0ZTMVdaMFVVMWh0b1oxU0FsVHduWDdO?=
 =?utf-8?B?ajJQcGRrWFJkTFZHQTJyaWYxc3RXNnZnSlFtbGVWZ1ZDUUh1c1FWMCs0UGVN?=
 =?utf-8?Q?n9aXlX4MP6Mwq5vOciYNgVU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e11b9a-49b7-40a3-f907-08daf8e0ff51
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 23:17:26.7521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ZKs67BBTrNFnf/mpspUQgqCS0i8g+sV3nyCxIHpG3aT6uPp/mV37uMOYsJstrLA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8349
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/18 00:20, David Sterba wrote:
> On Fri, Jan 13, 2023 at 07:11:39PM +0800, Qu Wenruo wrote:
>> [BUG]
>> >From the introduction of per-fs feature sysfs interface
>> (/sys/fs/btrfs/<UUID>/features/), the content of that directory is never
>> updated.
>>
>> Thus for the following case, that directory will not show the new
>> features like RAID56:
>>
>>   # mkfs.btrfs -f $dev1 $dev2 $dev3
>>   # mount $dev1 $mnt
>>   # btrfs balance start -f -mconvert=raid5 $mnt
>>   # ls /sys/fs/btrfs/$uuid/features/
>>   extended_iref  free_space_tree  no_holes  skinny_metadata
>>
>> While after unmount and mount, we got the correct features:
>>
>>   # umount $mnt
>>   # mount $dev1 $mnt
>>   # ls /sys/fs/btrfs/$uuid/features/
>>   extended_iref  free_space_tree  no_holes  raid56 skinny_metadata
>>
>> [CAUSE]
>> Because we never really try to update the content of per-fs features/
>> directory.
>>
>> We had an attempt to update the features directory dynamically in commit
>> 14e46e04958d ("btrfs: synchronize incompat feature bits with sysfs
>> files"), but unfortunately it get reverted in commit e410e34fad91
>> ("Revert "btrfs: synchronize incompat feature bits with sysfs files"").
>>
>> The exported by never utilized function, btrfs_sysfs_feature_update() is
>> the leftover of such attempt.
>>
>> The problem in the original patch is, in the context of
>> btrfs_create_chunk(), we can not afford to update the sysfs group.
>>
>> As even if we go sysfs_update_group(), new files will need extra memory
>> allocation, and we have no way to specify the sysfs update to go
>> GFP_NOFS.
> 
> We do have a way now, the memalloc_nofs_save/_restore interface that was
> not available back then.
> 
>> [FIX]
>> This patch will address the old problem by doing asynchronous sysfs
>> update in cleaner thread.
>>
>> This involves the following changes:
>>
>> - Make __btrfs_(set|clear)_fs_(incompat|compat_ro) helpers to set
>>    BTRFS_FS_FEATURE_CHANGED flag when needed
>>
>> - Update btrfs_sysfs_feature_update() to use sysfs_update_group()
>>    And drop unnecessary arguments.
>>
>> - Call btrfs_sysfs_feature_update() in cleaner_kthread
>>    If we have the BTRFS_FS_FEATURE_CHANGED flag set.
>>
>> - Wake up cleaner_kthread in btrfs_commit_transaction if we have
>>    BTRFS_FS_FEATURE_CHANGED flag
>>
>> By this, all the previously dangerous call sites like
>> btrfs_create_chunk() need no new changes, as above helpers would
>> have already set the BTRFS_FS_FEATURE_CHANGED flag.
>>
>> The real work happens at cleaner_kthread, thus we pay the cost of
>> delaying the update to sysfs directory, but the delayed time should be
>> small enough that end user can not distinguish.
> 
> Cleaner is not a bad first choice, though it can get busy with a lot of
> work with cleanings subvolumes and defrag, so the actual change in sysfs
> cannot be predicted. The transaction kthread can also try to check for
> the presence of the BTRFS_FS_FEATURE_CHANGED bit and do the change
> there.

Yeah, that's another alternative.

If you have extra preference between the two, I'm OK to use either.

> 
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> --- a/fs/btrfs/fs.h
>> +++ b/fs/btrfs/fs.h
>> @@ -130,6 +130,12 @@ enum {
>>   	BTRFS_FS_32BIT_ERROR,
>>   	BTRFS_FS_32BIT_WARN,
>>   #endif
>> +
>> +	/*
>> +	 * Indicate if we have some features changed, this is mostly for
>> +	 * cleaner thread to update the sysfs interface.
>> +	 */
>> +	BTRFS_FS_FEATURE_CHANGED,
> 
> Please keep the BTRFS_FS_32BIT_ last so they don't mix up with the other
> bits. Updated.

OK, would follow this in the future patches.
> 
>>   };
>>   
>>   /*
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index 45615ce36498..b9f5d1052c0c 100644
>> --- a/fs/btrfs/sysfs.c
>> +++ b/fs/btrfs/sysfs.c
>> @@ -2272,36 +2272,23 @@ void btrfs_sysfs_del_one_qgroup(struct btrfs_fs_info *fs_info,
>>    * Change per-fs features in /sys/fs/btrfs/UUID/features to match current
>>    * values in superblock. Call after any changes to incompat/compat_ro flags
>>    */
>> -void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info,
>> -		u64 bit, enum btrfs_feature_set set)
>> +void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info)
>>   {
>> -	struct btrfs_fs_devices *fs_devs;
>>   	struct kobject *fsid_kobj;
>> -	u64 __maybe_unused features;
>> -	int __maybe_unused ret;
>> +	int ret;
>>   
>>   	if (!fs_info)
>>   		return;
>>   
>> -	/*
>> -	 * See 14e46e04958df74 and e410e34fad913dd, feature bit updates are not
>> -	 * safe when called from some contexts (eg. balance)
>> -	 */
>> -	features = get_features(fs_info, set);
>> -	ASSERT(bit & supported_feature_masks[set]);
>> -
>> -	fs_devs = fs_info->fs_devices;
>> -	fsid_kobj = &fs_devs->fsid_kobj;
>> -
>> +	fsid_kobj = &fs_info->fs_devices->fsid_kobj;
>>   	if (!fsid_kobj->state_initialized)
>>   		return;
>>   
>> -	/*
>> -	 * FIXME: this is too heavy to update just one value, ideally we'd like
>> -	 * to use sysfs_update_group but some refactoring is needed first.
>> -	 */
>> -	sysfs_remove_group(fsid_kobj, &btrfs_feature_attr_group);
>> -	ret = sysfs_create_group(fsid_kobj, &btrfs_feature_attr_group);
>> +	ret = sysfs_update_group(fsid_kobj, &btrfs_feature_attr_group);
>> +	if (ret < 0)
>> +		btrfs_err(fs_info,
>> +			  "failed to update /sys/fs/btrfs/%pU/features: %d",
>> +			  fs_info->fs_devices->fsid, ret);
> 
> Is the error level necessary? It's not a serious problem, I'd rather
> make it a warning.

I'm fine either way.

> 
> Otherwise OK, the stale status wrt features is finally fixed, thanks. I
> checked the fix I'd worked on. It built on top of the (now removed)
> pending operations, your approach is similar and just moves the unsafe
> part to the cleaner.
> 
> A stable backport would be good too, but I see that this patch fails
> even on 6.1 due to the moved code in 6.2.

If needed, I can do the backports manually.
Just add a Cc: tag, and I'd handle it when I got the backport failure patch.

Thanks,
Qu
