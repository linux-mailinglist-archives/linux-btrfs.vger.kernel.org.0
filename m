Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9A754EBAB
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jun 2022 22:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378569AbiFPU5K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jun 2022 16:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiFPU5J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jun 2022 16:57:09 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349785FF0C
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jun 2022 13:57:06 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25GKPTA4001711;
        Thu, 16 Jun 2022 13:57:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=8soF/QcEYcX7UL7vnL3rHGmmeTBWkGimpWww2NvUSyw=;
 b=OnzMxQChuY3GvfYfNseIOIgCNzveRZw60lfwWRpa2Ha2l0LY0pWWHRepZy4/1SNvbJnm
 njKxYC+kSz0FGaATJyOpWteWq1FOL9uITh5n+cuHOlF86EN1rK3pUWP5lLSgbRqLgIWD
 eWKa6NzFnJe0v+40Fa78MkpE7SXi6MintNM= 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gp8ax3f5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jun 2022 13:57:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8K6w7RnQ1PrjjRSnB7P8X2sjbyw/qhxfwN157ZiuCsf4w60/7GR3kUEc3uZWHgjavVYX+i4lBp/A3XiA4XzAMO8HJGY1NcCi8wN/jfCWXGel90piPrYykfjHGnTNWRHRsQvEl0utPe1cA0gZUZARzK7DkbQjcGxxRRYOUASLphTjFuotBnPJ4kQF29Fhdv87U3TRhaLnTCdHNMIz1vPeNsKKok6hvpTJwKTR+Sadsbiv1Z+wKDxUFnWr3zmUTbdOYzf+0/P6NxWindaToVhpvz2uhFWoLMW4HAop4kpmrWe2wepEl7dWDP4kQFCQUYXJsLaqfkhPf4rJPAF1KyoWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8soF/QcEYcX7UL7vnL3rHGmmeTBWkGimpWww2NvUSyw=;
 b=j+FaTh6m3+Eedkf6jGjx/k6TF6ua+LII88StxXJ45ONoDFgfm7P0ip1I/j1vF/yuFdBMHFZsOKBkfC7dXq8aJZxiWmVcOFKBrl3dDQIO+d9hRI9upyPj4r3AZiwAV3JNPBrlTamdCJMxZgcqVAWkCuHriy9MTWr++P3lqtoBao2nuqEekhR+gQ3R+rKGBvegT5WXb9DPGejrchAmOEPbUqKvze3fIv5ITlcb7JjeFDpjNGJZHlgOJOxId++1cgAZ6tMP+OKm++brzFV+QhlGNOUBjZXiqdaYqR3uhXF8eqAgOTCMMIInC2V6iUi60bBa0dnn9Lx46zeruBdV5DdYkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MWHPR15MB1791.namprd15.prod.outlook.com (2603:10b6:301:4e::20)
 by CH2PR15MB3718.namprd15.prod.outlook.com (2603:10b6:610:c::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Thu, 16 Jun
 2022 20:56:59 +0000
Received: from MWHPR15MB1791.namprd15.prod.outlook.com
 ([fe80::e17e:e90d:7675:24b8]) by MWHPR15MB1791.namprd15.prod.outlook.com
 ([fe80::e17e:e90d:7675:24b8%11]) with mapi id 15.20.5353.015; Thu, 16 Jun
 2022 20:56:59 +0000
Message-ID: <86582032-4239-f05b-2374-686abd04146f@fb.com>
Date:   Thu, 16 Jun 2022 13:56:56 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v1 2/3] btrfs: expose chunk size in sysfs.
Content-Language: en-US
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Josef Bacik <josef@toxicpanda.com>, boris@bur.io
References: <20220208193122.492533-1-shr@fb.com>
 <20220208193122.492533-3-shr@fb.com> <20220404165201.GT15609@twin.jikos.cz>
From:   Stefan Roesch <shr@fb.com>
In-Reply-To: <20220404165201.GT15609@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR20CA0041.namprd20.prod.outlook.com
 (2603:10b6:300:ed::27) To MWHPR15MB1791.namprd15.prod.outlook.com
 (2603:10b6:301:4e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ec7f875-21b0-425b-9736-08da4fdac11c
X-MS-TrafficTypeDiagnostic: CH2PR15MB3718:EE_
X-Microsoft-Antispam-PRVS: <CH2PR15MB3718C5C64ADBD3BB140D1F5BD8AC9@CH2PR15MB3718.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tP9NDRS/co6KPtc74Dobh7r67BfscIhu4rWIzxfkAiugPGQcNJRJyxRpbYANDe6DsdCHDdX5g63iQ9EFlZgPAQufg2y9EKK7iKr2cIlbmvjeUHgWXxvJ1txFiGkCh1qOrFKmZfQuQ0k8lmcfIxNaVULGZFCCdgmAHsWVaBvMShicoZzX+XzWehactsRGnE6XjUg+IezT3PT08xm5/DKyzn1P/i0+T/woKR6dkaKOn6JIhsmrcFzW3HT23wdzTwih6Caa18QmpWb85rQ76Fn9YUdcv3m152x8jiocZ5rFN3RbYY5FLTHNyFw20qgu0TgbH+m1RmvseprzjaeLDt7l55/taLtXwp+jR2kjyjWoTdRQbeB9pTW5AXilzUtUT25SxSFBRSfhWQ7xdqA/suNq4mm2mHW72rZ2+UMRArKbTIvgIptHA2cxUmu/3KQM96BIRKLDrVq9nPoDxbQQ7cgI26rgdM7tNLi4e7G4nsaO0kfOwEJQTEKpLPvBa4xXQ0YGvXQXhB9nzO3d9VhjczwxEKF8jQEHKmADSA8xJ2FEO6moj59ol5v2kZ1RWRtsqlqXIgk/57sz4feDZ5WIbbnpeT59SbLbXVBGq6r0RGXLozEYhgoQ53LhWGhjM9cwU+5kvNX5ugY0AqO5tpwGS6Aw18RnahrD6fq1RGc5jcrB5xy18s5T+ZQAffBdNknEQs+1mnq+/nMkQVyifgp/U+9cIu+7sCzJ6Xk6FndBU9QB0eD/2WGJm/U8eZJN+cCR8Tqh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR15MB1791.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(508600001)(6486002)(8936002)(5660300002)(6512007)(186003)(83380400001)(2616005)(2906002)(6666004)(86362001)(53546011)(6506007)(31696002)(66946007)(66556008)(66476007)(8676002)(316002)(36756003)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDVHV3Jqc2dLZWdCeGRiSXFCWmJEYU1PMFByamlaNC9pdUNSdTRkQlRhWkRD?=
 =?utf-8?B?dnYrQW16OXZJSnhkMVdPS3dBZlNlNEd0NmNsUkNJdnNOcVZCNUZubDByZ0Qr?=
 =?utf-8?B?cm1hTTBhZE4xcDZxN3pFbVN1MXU2bER1dUc5a2lVak0rMFJNb1Arb0FOMkRo?=
 =?utf-8?B?TVVjbkxpRnUrbU40ZTZRL1VtNnN0QUxhNzkyUU9TOTgzL2R5VWNlc0FtK1dE?=
 =?utf-8?B?TG02MGViNmd6ZW1Kd2RkVzhrOVhPdEJ5YUVmallLemdOV29Ba0w3cVhZNjIy?=
 =?utf-8?B?YWw4QmRNTnpwUE92OFJMam1Ga3JsZU9aYWwzbiswK0treWJjekFLcmFVYjU2?=
 =?utf-8?B?WEZlbEhZbTZNWnF3Zlp3eUxLeGtJMVR3MEI0Q1NjS0dvb1RieUY0Tkthcmk2?=
 =?utf-8?B?bjBHOElQNFFQMDBTUk9qYkl4YzdKaC9nZHhCVHVZM1l3N0dRRFpiMDFwcGt6?=
 =?utf-8?B?Z3ZSeGxXcEkrSVNTT1JTdGFZT2lNUWJtdm9aQ0JvYVZlMmpBeHRaQXBscXlF?=
 =?utf-8?B?Q0U5UjQ5ZnFkUFVSTlR5QUt4TnhRQ25kQ2J0U1VYQzB6VFp0RVV2TjRoTk1X?=
 =?utf-8?B?cHVOdnVPblVVbjg0MjlYa3lLRXMvcHlGOXFZY1J4NU9vRnpheWRsK2M4dklt?=
 =?utf-8?B?Qnd5MUQ3c0JBbmtzODBkc3hZS3NoOG1IS3Z0MWQ0aWYyeHVINE9ZVExGWmc3?=
 =?utf-8?B?ME1ZbTllRTJhN3ArTzhKY3d4VitBMml5TWZoTUNKTkw5N21Iekw3RTNoOEVF?=
 =?utf-8?B?dkNpL0wxblE4TmFTQzY4VjY3d0JWUWZWaXg3ekl5RDl5QytmK0d4UWQ2MDVv?=
 =?utf-8?B?ZTVqV0hRT1p3bzVob3pTS09PUlc0ZDdNc1VER2Q2YmtvN3ZtbWdCTElNcjVz?=
 =?utf-8?B?akNSTnQ0YWgySGRPTFZHZ3U2bFAvUXhFak5sQTQ4RVFnR2wrYVgzL1pGMU54?=
 =?utf-8?B?Qm5iZEluK2N5L29sNEx6VXVBUWRZWmIrSEFuQkJwMHR3NURoT0NDcnFCQWFH?=
 =?utf-8?B?eHVzdW5vZktBejc5bnA1VjA1aTczNXVnUTJMclh0VjlWNmU4eUcvSEdPRDRZ?=
 =?utf-8?B?Tk9SWjVCTXZZb1BMUkVvaE1rUTVyOTloT0Z6bFNzSDhLUlRwOTd1TjVCZDJj?=
 =?utf-8?B?cDhkejltakF6UDdQa1BaRU5PTmFmYlUzWUJDYi9xQ2pzVUVJNEZ5ZVlwWmkr?=
 =?utf-8?B?NG9aMXIrcFNpRmRsenVOWDRYOVFQZUN3cURvbzJQcytheGlybm9aV0w4V2Jv?=
 =?utf-8?B?aGFWNm51bGJLVzZkc2M0cFBLTytCb01taFBwTm8vdVBva1U0NjR1ZFBhSlhR?=
 =?utf-8?B?cUR2OExQS0oxZlhubzZzYjM3UFYwTlZvNGREUUxhZHhuaFlrZ2RKQnNXTTFh?=
 =?utf-8?B?V1pySlV6WTdoTVVZeDlLNmlETDhTNzFxQmdXOWM4UzVoZmgrMndnQkpLSGVC?=
 =?utf-8?B?M0hwL0NnZG1MWndEL2pVb1pjQS9Xczc4ZU5hbWgza3M4NjV0elBzZzVzQmVL?=
 =?utf-8?B?a1JzbkRYejB4cDhLVTlKUFZDZVc2cjVPRTB4UFVtTU9QTk14UHMvNC9va0JV?=
 =?utf-8?B?aUNpOEFPbVEwRVBEL05yWlFaS2JDcWc3TWdMN3c5aW13amk0K2FiUmFxSTh5?=
 =?utf-8?B?d2NDWFhvWExIam5JZHBKZEtyd1RuOHhCa2VIcWpZdm94bzd2LzRnUnpIWnUw?=
 =?utf-8?B?S1AxNHpERXlIQkxCL1I2b2ROUUo0ZzlBbDVaMEtiSFg0K3JvMStRc1NCRXNZ?=
 =?utf-8?B?dDI3NGMzSGJoRUJJUWdvYWhqK2ZTbkljbVIyQ0RHeklUelBtLytCM1VyVEhB?=
 =?utf-8?B?QW0wejFEemh6UDkzbWdtczFVeFpDdHh3ODJvKzZmVHkxMXR2amlQN0E1aGFJ?=
 =?utf-8?B?azI4L3lzaUJid08wdmhwNDB0SmRzWEp6cEFiSWJ6UXhQWWUxeUdzK0ZhTXJQ?=
 =?utf-8?B?bW5nUUczSFhCYUlDb2JyV0hzVDRDUkxZeEFNWGhQTDFnNjl2YjJFU3lNbHhi?=
 =?utf-8?B?bE9QWHo4c2xNc1llWTdJWWxkVVFSVEprRi9WZHZNZEMxZ3NTOWk2VjZsNkl5?=
 =?utf-8?B?VTVTMGswMUdLdUowSG45WEgzU25td0lDN1NhTjJsZHh2bzFjNDl0alhaTDVO?=
 =?utf-8?B?R3FoMnhxenpHWFZCYTZYRG43akZobzduOVR1NGVMODNLZmJ1UVFiOHpZVWc2?=
 =?utf-8?B?MGtiMUJyQ0p6Y2liQ1dYeTAyTXBBR1NKZlJ3bVRhcFFDbHIwaVBaMEcwMlRz?=
 =?utf-8?B?clJBalo4TVNmbXlnM3FTZVFrdkM3S2NkSGRNTk9UdnMxSGJmYk5WVzRwbVJG?=
 =?utf-8?B?bDhiaE9meWJHUEM0KzdqTEtOVi8yOVo2RCsrL2VCMTdSTjA1Z2xoZTZHdVpC?=
 =?utf-8?Q?vcX7wF4zlUaMikLo=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec7f875-21b0-425b-9736-08da4fdac11c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR15MB1791.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 20:56:58.9250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwnGNad1NYbZBtgXwJ4iUcMqp1sO97i6Q8w55JoMMsRAcvPkoZTJNuh2etxe8XqU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3718
X-Proofpoint-GUID: cmbGrMKlQ3KA4BCkZdunZN4qM88YjvLS
X-Proofpoint-ORIG-GUID: cmbGrMKlQ3KA4BCkZdunZN4qM88YjvLS
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



On 4/4/22 9:52 AM, David Sterba wrote:
> On Tue, Feb 08, 2022 at 11:31:21AM -0800, Stefan Roesch wrote:
>> This adds a new sysfs entry in /sys/fs/btrfs/<uuid>/allocation/<block
>> type>/chunk_size. This allows to query the chunk size and also set the
>> chunk size.
>>
>> Signed-off-by: Stefan Roesch <shr@fb.com>
>> ---
>>  fs/btrfs/sysfs.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 94 insertions(+)
>>
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index beb7f72d50b8..ca337117f15b 100644
>> --- a/fs/btrfs/sysfs.c
>> +++ b/fs/btrfs/sysfs.c
>> @@ -21,6 +21,7 @@
>>  #include "space-info.h"
>>  #include "block-group.h"
>>  #include "qgroup.h"
>> +#include "misc.h"
>>  
>>  /*
>>   * Structure name                       Path
>> @@ -92,6 +93,7 @@ static struct btrfs_feature_attr btrfs_attr_features_##_name = {	     \
>>  
>>  static inline struct btrfs_fs_info *to_fs_info(struct kobject *kobj);
>>  static inline struct btrfs_fs_devices *to_fs_devs(struct kobject *kobj);
>> +static inline struct kobject *get_btrfs_kobj(struct kobject *kobj);
>>  
>>  static struct btrfs_feature_attr *to_btrfs_feature_attr(struct kobj_attribute *a)
>>  {
>> @@ -708,6 +710,81 @@ static ssize_t btrfs_space_info_show_##field(struct kobject *kobj,	\
>>  }									\
>>  BTRFS_ATTR(space_info, field, btrfs_space_info_show_##field)
>>  
>> +/*
>> + * Return space info chunk size.
>> + */
> 
> Comment not necessary.
> 

Removed the comment.

>> +static ssize_t btrfs_chunk_size_show(struct kobject *kobj,
>> +				     struct kobj_attribute *a, char *buf)
>> +{
>> +	struct btrfs_space_info *sinfo = to_space_info(kobj);
>> +
>> +	return sysfs_emit(buf, "%llu\n", atomic64_read(&sinfo->chunk_size));
>> +}
>> +
>> +/*
>> + * Store new user supplied chunk size in space info.
>> + *
>> + * Note: If the new chunk size value is larger than 10% of free space it is
>> + *       reduced to match that limit.
>> + */
>> +static ssize_t btrfs_chunk_size_store(struct kobject *kobj,
>> +				      struct kobj_attribute *a,
>> +				      const char *buf, size_t len)
>> +{
>> +	struct btrfs_space_info *space_info = to_space_info(kobj);
>> +	struct btrfs_fs_info *fs_info = to_fs_info(get_btrfs_kobj(kobj));
>> +	u64 val;
>> +	int ret;
>> +
>> +	if (!capable(CAP_SYS_ADMIN))
>> +		return -EPERM;
>> +
>> +	if (!fs_info) {
>> +		pr_err("couldn't get fs_info\n");
> 
> What's the reason for such error message? I would end up in the system
> log without any context so it does not bring any value to user nor does
> it tell what wen wrong.
> 
> Checking other functions, there's no such check in most of them and I
> don't think it's needed, the filesystem can't be unmounted with open
> file references to sysfs.
>

I removed the check.
 
>> +		return -EPERM;
>> +	}
>> +
>> +	if (sb_rdonly(fs_info->sb))
>> +		return -EROFS;
>> +
>> +	if (!fs_info->fs_devices)
>> +		return -EINVAL;
>> +
>> +	if (btrfs_is_zoned(fs_info))
>> +		return -EINVAL;
>> +
>> +	if (!space_info) {
>> +		btrfs_err(fs_info, "couldn't get space_info\n");
> 
> Same as the error message above.
> 

Removed the check.

> Also I'm not sure there could be a NULL space_info, it's one of the core
> data structures used all the time.
> 
>> +		return -EPERM;
>> +	}
>> +
>> +	/* System block type must not be changed. */
>> +	if (space_info->flags & BTRFS_BLOCK_GROUP_SYSTEM)
>> +		return -EINVAL;
> 
> This would probably be EPERM, EINVAL is for invalid values (like out of
> range).
>

I changed the return value to EPERM.
 
>> +
>> +	ret = kstrtoull(buf, 10, &val);
> 
> As this is supposed to be used by humans, it's better to use memparse
> that also translates the K/M/G suffix so it's easy to write '256M' etc.
> 
>> +	if (ret)
>> +		return ret;
>> +
>> +	val = min(val, BTRFS_MAX_DATA_CHUNK_SIZE);
>> +
>> +	/*
>> +	 * Limit stripe size to 10% of available space.
>> +	 */
>> +	val = min(div_factor(fs_info->fs_devices->total_rw_bytes, 1), val);
>> +
>> +	/* Must be multiple of 256M. */
>> +	val &= ~(SZ_256M - 1);
> 
> Where does this requirement come from?

One of the reviewers wanted it to be multiple of 256M to avoid fragmentation.

> 
>> +
>> +	/* Must be at least 256M. */
>> +	if (val < SZ_256M)
>> +		return -EINVAL;
>> +
>> +	btrfs_update_space_info_chunk_size(space_info, val);
>> +
>> +	return val;
>> +}
>> +
>>  SPACE_INFO_ATTR(flags);
>>  SPACE_INFO_ATTR(total_bytes);
>>  SPACE_INFO_ATTR(bytes_used);
>> @@ -718,6 +795,8 @@ SPACE_INFO_ATTR(bytes_readonly);
>>  SPACE_INFO_ATTR(bytes_zone_unusable);
>>  SPACE_INFO_ATTR(disk_used);
>>  SPACE_INFO_ATTR(disk_total);
>> +BTRFS_ATTR_RW(space_info, chunk_size, btrfs_chunk_size_show,
>> +	      btrfs_chunk_size_store);
>>  
>>  /*
>>   * Allocation information about block group types.
>> @@ -735,6 +814,7 @@ static struct attribute *space_info_attrs[] = {
>>  	BTRFS_ATTR_PTR(space_info, bytes_zone_unusable),
>>  	BTRFS_ATTR_PTR(space_info, disk_used),
>>  	BTRFS_ATTR_PTR(space_info, disk_total),
>> +	BTRFS_ATTR_PTR(space_info, chunk_size),
>>  	NULL,
>>  };
>>  ATTRIBUTE_GROUPS(space_info);
>> @@ -1099,6 +1179,20 @@ static inline struct btrfs_fs_info *to_fs_info(struct kobject *kobj)
>>  	return to_fs_devs(kobj)->fs_info;
>>  }
>>  
>> +/*
>> + * Get btrfs sysfs kobject.
>> + */
>> +static inline struct kobject *get_btrfs_kobj(struct kobject *kobj)
>> +{
>> +	while (kobj) {
>> +		if (kobj->ktype == &btrfs_ktype)
>> +			return kobj;
>> +		kobj = kobj->parent;
>> +	}
>> +
>> +	return NULL;
>> +}
> 
> There's the to_fs_info helper to get fs_info from any kobj, why is
> get_btrfs_kobj needed to traverse back?

The kobj for the new sysfs entry is not of type btrfs_ktype. Instead the
kobj->parent->parent is of type btrfs_ktype.

