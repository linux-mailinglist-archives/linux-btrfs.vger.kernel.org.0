Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D67F54EBA0
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jun 2022 22:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiFPUxd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jun 2022 16:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiFPUxc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jun 2022 16:53:32 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C06E57B34
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jun 2022 13:53:29 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 25GKPgPm013492;
        Thu, 16 Jun 2022 13:53:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=rqrZqRBgZIP0masZ9aFA/phLzdljD1ZZukd10QWqWTg=;
 b=e447Bch2ePXl1ZxGtDyfbmuGWJUBYIgD2mHbjPfTqTi6KHakZpLw/0uN3zmLRqkj7LgF
 buoSxPDEVbiEtxx+ahg1geyUiKNzPlhzRS1RKcAgBaTitrxpYg3uBKrUBR4sNYs40tPK
 ug4mbYllv9EYCgANDRze3p2zTU+uE6PHLo4= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by m0089730.ppops.net (PPS) with ESMTPS id 3gr09vnr6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jun 2022 13:53:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fu2oIO/FXaLYNYsi34uuv81MOEYfUIgwBTG5LFb1fjNG7OlfD9d8iTxZ/4DV2t27ISVttKTU+Eie1J9yHydNqOGT9ECPjgWxpu0hpoFBT0Tkt4M3gYeDm/02886s1pib8qu7/M/IeVsv1SUgu9VjdwHZQkCYLzPz3f7Ut3SH+QZ1yL5Wy7UwF2hiPZ3R39OrIrAjBVKyYqkqmmh2+4cMjA6Ze9dxBkocWGFCvm/3Wcq7dlYanOfd4NgI28CNwSokOmqzvj7eGB6pb9f7ie1vUx3QAVxbPNTYCS0XOchTGibxgZIYnyXf0mtHOZDUcrbtJrIFmRO9ktbDQ8sTJepiSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqrZqRBgZIP0masZ9aFA/phLzdljD1ZZukd10QWqWTg=;
 b=RzzpeYWYILgYYqUZGcELZpy6NKUbiEGFeCkcDawpnoNG0VrKmDc1RHCdJMxixyhkMrDSVUcbaisor5Rkjh7D6Z/YP9/DkLSdpLII24hVv5A3yCWIRdIdenE2EQVL010i/SmN2er2aRtThvGws8BQtBtEve4rd5VRQ21Ylpgfl1MucA5H86We4jXSbAGXswr1kYA6+rAPvxajBP7Bl8nooP+hiv/trhkoQUO8HomZNQ9FnO62cyB+MP8nxMve0f5ObMrrXAP8L1XvmB14xzQMa22l+he6eBxiIHXtUrX4s6oDCJJhzzcayY+Peix3n/Ew4GUMlCDmeCt+g5mmNFhiEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MWHPR15MB1791.namprd15.prod.outlook.com (2603:10b6:301:4e::20)
 by BLAPR15MB3827.namprd15.prod.outlook.com (2603:10b6:208:254::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 16 Jun
 2022 20:53:22 +0000
Received: from MWHPR15MB1791.namprd15.prod.outlook.com
 ([fe80::e17e:e90d:7675:24b8]) by MWHPR15MB1791.namprd15.prod.outlook.com
 ([fe80::e17e:e90d:7675:24b8%11]) with mapi id 15.20.5353.015; Thu, 16 Jun
 2022 20:53:22 +0000
Message-ID: <dfeef6ea-0dfb-915a-5b98-6a465bc01d84@fb.com>
Date:   Thu, 16 Jun 2022 13:53:19 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v1 1/3] btrfs: store chunk size in space-info struct.
Content-Language: en-US
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Josef Bacik <josef@toxicpanda.com>, boris@bur.io
References: <20220208193122.492533-1-shr@fb.com>
 <20220208193122.492533-2-shr@fb.com> <20220404163623.GS15609@twin.jikos.cz>
From:   Stefan Roesch <shr@fb.com>
In-Reply-To: <20220404163623.GS15609@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR1601CA0010.namprd16.prod.outlook.com
 (2603:10b6:300:da::20) To MWHPR15MB1791.namprd15.prod.outlook.com
 (2603:10b6:301:4e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e4a0208-833e-44af-daed-08da4fda3fce
X-MS-TrafficTypeDiagnostic: BLAPR15MB3827:EE_
X-Microsoft-Antispam-PRVS: <BLAPR15MB38277128E9DBB799962A5743D8AC9@BLAPR15MB3827.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3n0IU0yBFe9Zr9jxRfiCzomxrhQZH12/89kML6d7PhFQt0DciQ6SAq0f7vnOdOEOa3smWu2k7oTLZDrlO3QFPrK1uHch8ddw6EBfULDMFHktSBy3mma1O1pNbHaUqebnIZT9RUZ41S1opKrVd3tWAsk24frjIDd38gTeenNSoWPBn//QdHht2HhQk+V7G28qzv0UVPW48z4nMyMvMU9oVd4F7lQJ/+GchOiY5yPoBt8QbwiI2Lc+HIgjEf3PRVeWi8v3tNj1GsApUf58Ptkrzk/qw3R4ojEgKV8nmYbWcLw/Z6KHY4+XwzYi5AdYEKWXorbrwtTjwnfzBpOWYwRqKZfE6lW070x2Vjvm2ABAwGhSTVNH8XAZqqlWHl3Y5GYc0RcwXzAUGk91x72EEboPV0kwTT2t36iikchNJWB20aDRiGSajikGyRpW2C70Kpwm6pu76hqqb6xiRS1FMK6ZavMWYfFAYsXNx4Z8GKPMRNbe2yg63LieX7+lKogx9yYngj+B6C/mfT46w+mTEm4LIGW0TQGLR/5FZWfjojA6Ga0aGpWE7hSIG65519ugcvMp9eg6fRjbx1xJO/xF4hQZ59bjEwCWxIFhAq4zTmVKmkSaNz2TfB3TxuTv+DIWo6naMrNXbELkPD49sYU/QHsglCHCnoyso7nOs+gv1bCR68BgNzppXKMgxq6Cwe6UKj13mpu5w8fJy7Xw0Vl6GC5aOLiwnefXZZzgaUG5UAn4FhVyOu7GEAl6DxA9xv32i+u0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR15MB1791.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(8936002)(83380400001)(5660300002)(508600001)(31686004)(6486002)(66476007)(6512007)(31696002)(53546011)(2616005)(2906002)(86362001)(6506007)(6666004)(36756003)(316002)(38100700002)(8676002)(66946007)(66556008)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTY1NlpKcmZJZWhYSFM3dkVpSmxaN3BEdFVOV09iSlU1ZUp0aE8xN3BBanBP?=
 =?utf-8?B?RDdTelpSSnhYSVZSWDhLL1hvK3hyMHJMMC9pV3QwaVMvUzBVM3lOYytIOVJI?=
 =?utf-8?B?ZHFLYVNEMGd1czZPK1ArU2dOSGZESVNudUQ2K0V4QlduUWdkNGtrOGpGUGFW?=
 =?utf-8?B?Nncvd0NSNDdhTEFQaTZkODg0NXhSamYyR1JwVzhUYmQzQ3U1bE96RTR1TGlJ?=
 =?utf-8?B?YzJud1IyRDVZN2wvWEpWQld4YlMxd2RDSmsreklkMkQ1T1Nsc1QvQ05wRCtn?=
 =?utf-8?B?Y29KcldJZVFYbHcwVFVBdUtmejJhNXR2Y25zS0V3cHBYemR0VUZROVRaZ090?=
 =?utf-8?B?SndjSDNmeU0wdVlhSkI1V2k5REpzUHJSSzBzUzFTSkpiTVZWbDBUQjlqZFpU?=
 =?utf-8?B?WVBzSnZjeisvSVpQbWhTUEN4QmdTeEF5VUhkNHM0VGlnMmxXeDI3Y3ZwRFVx?=
 =?utf-8?B?cmdoQWxMeE52aTU4alFGTmw4MlpvUEdmWUFHMGtvYkdQOGJ1S0M2ajliTEpr?=
 =?utf-8?B?YktlcGs2VmZSejZHTCsxR003SkswSEVVaTdQeVdWcVdSWFhORXorNkhlb2Rx?=
 =?utf-8?B?YkJWQk5QSVRGcitNVGswWGNuTW1oL2dXOTNSME1WYnBCUnpHNGIwK1ZUcktn?=
 =?utf-8?B?UFBNeXhTQU1UbnY4ZDRSaldWZjhQRGJhNTk4Tm9FK1ZMR3Z6Y2lrTEJjMFdp?=
 =?utf-8?B?dmN6M0d4ZlZOc3ljQ3FZTG5pU0VITmJFaGhEalNJODJtR2l4dTJYVG1lbmZ2?=
 =?utf-8?B?SmNsTU9BejdHbGlvUkRhWmFvZjBjU0JSNmE4L1VCMnZhWGdyZXl5N21PQWFP?=
 =?utf-8?B?UjFNOUVmMzNmS3VQSlNsN2dDVVJkMTYwbDJiV2NzME9ySjlaRmdqbXM3dUl0?=
 =?utf-8?B?Qmc3blQ5UE51cWJXdXRQLzRCOThyMmdCYXdZNHgzSUdJQXBZTWFBRzRXek83?=
 =?utf-8?B?cWJSMnNBSFJ4NjBSMlQxdWREVXM0d05mVVdaWC90RGRROEsvQ3ZWYTVIN3R1?=
 =?utf-8?B?d1FvazNpanYyR3NUelMzeWgvZ1ZMVjdpTXBJb1dCejZyMElGZ0VOZ1ErNitW?=
 =?utf-8?B?c2tKejhHUGRwWUVqa3FuN0UzOVVaS29vQUV2UjF1aExGTmh5MlUyUlE2VXhx?=
 =?utf-8?B?YXgwelNBSTRTNFdtb2g0RUtjcGpidkpwWEZ2NEgzb1MwcWdpblh1cENXL3hO?=
 =?utf-8?B?YVlaeXFDaFg2KzI0L3BLeDJldlYvWk5Zb1JXdXhsKzh1c2tmeVlFa1BNbWF0?=
 =?utf-8?B?a1JMcUNHWW1ISGNCM3BZdEE5N05QT3FRYWlKSFJXbzNaR29sbk13cHIwVjNr?=
 =?utf-8?B?ZnZXRDhhREMyMHQyK29QSU8zRUhJU3R3QzRnN2IzT1R1TE0zSTZDeHVVK3dt?=
 =?utf-8?B?K1FndVVZMTNKM1Qya1kwVGpjT0tpTDl6bDZwWXFZMkxzWnFBU3U4bXJSQWky?=
 =?utf-8?B?WXJObjZnWHloYWZZNHA2N2dhN2x1RTVxdXNDQjFSRFdseWEyRStQNll0bysv?=
 =?utf-8?B?dzBRVE53c1dscm56S1A3RWNnbHVwdFFnNFN4clBrK1VPcG9qYVI2Z2VYZ2Jy?=
 =?utf-8?B?dGNJc1ZLTndEWTdNUnR6YTY5SGlaZ1Bpcm8yYkpyaStub1dQME0vcDBuTHZH?=
 =?utf-8?B?cnFzWHo1WXBNYXNOdFJQbWtMVTRsaThBUUordlExcHRUTjlOTVI3NDcxRS9V?=
 =?utf-8?B?L1hnR2RVWm84eUJJU3VVaElRMitiQ3k0UDJuMy93Zm5xenR2dVFSbkpsUmxQ?=
 =?utf-8?B?QWFaelkxZFd2MEx5SUcvK081cDNaYlEwRHlVbnFDQjdQWEExd3ZRblFKTGUz?=
 =?utf-8?B?VThBZWFNZS80VEE5M2ptcjM3ajU1RGh2a2xCRWpmUFJ5cXBFNEF3M2F6akdI?=
 =?utf-8?B?TUdkU0N1cTA3R2hyZVcraStSd3E1L051dzM5cHc5MzFFWDhNMlJhMHpvZ3E3?=
 =?utf-8?B?eGZURkcvRVRFRDhLeDBLQVZ1MlBCazdhQU9wNWN6NGNhQ1FmWGhxWEppc3ln?=
 =?utf-8?B?QnNIOE91ajdWSVlodEZueDI4cXg1V2ZkU281ZEx2OHg5ZTF6cGUwVklIdkt5?=
 =?utf-8?B?dGdEYUFUbHhaaWFGRUJLcnQ2d2I4SFk1NXdjWlJrbVN5cmN3L25mMlQrVU94?=
 =?utf-8?B?N1drZDdwMFN3OVZyLzJVcG04Mk9CRlI4RkpsM3JFdkpadjNpdHRNd1hYdjNh?=
 =?utf-8?B?UmhyekM0bkJlZm1nY2Yxd2VNeHRaVzBqOW5wTHdZYjRrK1MrdU1oYTJpQ0N3?=
 =?utf-8?B?d3N2enZROEtFY3A2cmxWWnVpWGJqWGZUcWRxTDlsM0EzNW5VbytUcjZaWjIz?=
 =?utf-8?B?d2xGNGpRQ1g5UTFPSXB6aVRBamNFTWRBelpTWDRlaXhSakVMVFlGL1E1NFBp?=
 =?utf-8?Q?pnNKnlEMtUOoqC+Y=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4a0208-833e-44af-daed-08da4fda3fce
X-MS-Exchange-CrossTenant-AuthSource: MWHPR15MB1791.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 20:53:21.9894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKcd9N4R0n+4IIcaXRc8T55cB0WNo0hQ/BJK93KnT3yH1UrgnivqpLjSMYpAdxr1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3827
X-Proofpoint-GUID: DV8iLjuPS1mn1CP03Kale-_UT5zk3IqW
X-Proofpoint-ORIG-GUID: DV8iLjuPS1mn1CP03Kale-_UT5zk3IqW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-16_18,2022-06-16_01,2022-02-23_01
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 4/4/22 9:36 AM, David Sterba wrote:
> On Tue, Feb 08, 2022 at 11:31:20AM -0800, Stefan Roesch wrote:
>> The chunk size is stored in the btrfs_space_info structure.
>> It is initialized at the start and is then used.
>>
>> A new api is added to update the current chunk size.
>>
>> This api is used to be able to expose the chunk_size
>> as a sysfs setting.
>>
>> Signed-off-by: Stefan Roesch <shr@fb.com>
>> ---
>>  fs/btrfs/space-info.c | 41 +++++++++++++++++++++++++++++++++++++++++
>>  fs/btrfs/space-info.h |  3 +++
>>  fs/btrfs/volumes.c    | 28 +++++++++-------------------
>>  3 files changed, 53 insertions(+), 19 deletions(-)
>>
>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
>> index 294242c194d8..302522a250d8 100644
>> --- a/fs/btrfs/space-info.c
>> +++ b/fs/btrfs/space-info.c
>> @@ -181,6 +181,46 @@ void btrfs_clear_space_info_full(struct btrfs_fs_info *info)
>>  		found->full = 0;
>>  }
>>  
>> +/*
>> + * Compute chunk size depending on block type for regular volumes.
>> + */
>> +static u64 compute_chunk_size_regular(struct btrfs_fs_info *info, u64 flags)
> 
> compute_chunk_size_regular
> 
> We've been using 'calculate' or 'calc' for such helper elsewhere, please
> rename it for consistency.
> 

I renamed it.

> Also the common name for struct btrfs_fs_info is 'fs_info' and it can be
> made const.
>

I made it const and called it fs_info.
 
>> +{
>> +	ASSERT(flags & BTRFS_BLOCK_GROUP_TYPE_MASK);
>> +
>> +	if (flags & BTRFS_BLOCK_GROUP_DATA)
>> +		return SZ_1G;
>> +	else if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
>> +		return SZ_32M;
>> +
>> +	/* Handle BTRFS_BLOCK_GROUP_METADATA */
>> +	if (info->fs_devices->total_rw_bytes > 50ULL * SZ_1G)
>> +		return SZ_1G;
>> +
>> +	return SZ_256M;
>> +}
>> +
>> +/*
>> + * Compute chunk size depending on volume type.
>> + */
>> +static u64 compute_chunk_size(struct btrfs_fs_info *info, u64 flags)
> 
> Same.

Same as above.

> 
>> +{
>> +	if (btrfs_is_zoned(info))
>> +		return info->zone_size;
>> +
>> +	return compute_chunk_size_regular(info, flags);
>> +}
>> +
>> +/*
>> + * Update default chunk size.
> 
> That's not very helpful comment but the function is sort and clear
> enough so I don't think it needs it anyway.
> 

I removed it.

>> + *
>> + */
>> +void btrfs_update_space_info_chunk_size(struct btrfs_space_info *space_info,
>> +					u64 chunk_size)
>> +{
>> +	atomic64_set(&space_info->chunk_size, chunk_size);
>> +}
>> +
>>  static int create_space_info(struct btrfs_fs_info *info, u64 flags)
>>  {
>>  
>> @@ -202,6 +242,7 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
>>  	INIT_LIST_HEAD(&space_info->tickets);
>>  	INIT_LIST_HEAD(&space_info->priority_tickets);
>>  	space_info->clamp = 1;
>> +	btrfs_update_space_info_chunk_size(space_info, compute_chunk_size(info, flags));
>>  
>>  	ret = btrfs_sysfs_add_space_info_type(info, space_info);
>>  	if (ret)
>> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
>> index d841fed73492..c1a64bbfb6d1 100644
>> --- a/fs/btrfs/space-info.h
>> +++ b/fs/btrfs/space-info.h
>> @@ -23,6 +23,7 @@ struct btrfs_space_info {
>>  	u64 max_extent_size;	/* This will hold the maximum extent size of
>>  				   the space info if we had an ENOSPC in the
>>  				   allocator. */
>> +	atomic64_t chunk_size;  /* chunk size in bytes */
> 
> Why is this an atomic? I don't see the atomic semantics used anywhere,
> ie. not losing increments/decrements. For plain atomic_set/atomic_read
> it's exactly the same as an int or long. The right annotation here is
> READ_ONCE and WRITE_ONCE, which is used for other values updated from
> sysfs.
> 

I removed the atomic and used READ_ONCE and WRITE_ONCE.

>>  
>>  	int clamp;		/* Used to scale our threshold for preemptive
>>  				   flushing. The value is >> clamp, so turns
