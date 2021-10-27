Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A187743C368
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Oct 2021 08:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240200AbhJ0HBz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Oct 2021 03:01:55 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45210 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231686AbhJ0HBz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Oct 2021 03:01:55 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19QNDiil022807;
        Tue, 26 Oct 2021 23:59:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=xJccF6vJa6eGsTIFPRGkPbsToZjwQ7KpmY/3BOJPEks=;
 b=ohTOKbTux7jQ6LY/ujvH4gWVC+HaV17V9Ax7IZEISnHDbSudrZh4MueBCGQWYUEUyIQ3
 m638j+e7DwKd8804xXIkFNGc4+h3l5az3765IptDArHHCdIWPWqtw1zMmuJuiZfcUFrC
 zIY+ZpDajVF4ojRti5OJjWACGdo4nfS/QnI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bxkkcdxae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 26 Oct 2021 23:59:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 26 Oct 2021 23:58:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9ONGfJBp/+YHDS9OXmbMTSipwB8xoU0KuizC6By8L3EM6m2wdWsBBj5RtUmJ71KT32Wi0Nlx8NhwxiboFW83NqFROoQcNAHcg/ACKG470mJHEXmpDr+s/NiB306Qp3Zbi8vLXBxWBpFPZVcGGjll5kM72NTjAjyEAh2S5JP7mBEUyVcQNlDdEdI4yuf+RmopS+0lUoPFPDmleTejoNvb1ZcSaPmTEt175C/YciPcYKKJSgOEdtk7pr+4cG0PGUcJ0QfdDQ821L7MgbYh/DycdyST8houbVgmh6+eLckRBs0WyabymoohCl3TaaeExQeUbFBhYWJhRhEllxXaBV3jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJccF6vJa6eGsTIFPRGkPbsToZjwQ7KpmY/3BOJPEks=;
 b=Vxn80+LZMbmoQPQis3yVuaqlb4KFfiEQ4rg6MkWQTHRAMq5xvfeacr5oRYsvRIOGMVaAXPcrYaZdAUPg/EtjkyDzb8Xvordj+iNt0W0qgFMbQ3gNWr6CK1TE+/vpM40SPhm7p4CSHAHrNmZtIl5cayIi/mDQZ1kp+Mz/IwYmIiv9Sp2opA/AJdxvmGL9SUnAOSmrlZvGH2V7REL33xzv5KRcc0pygIPRA+De2pBf1xCorMEqQHPAhcWbWOwBc5BQf1ZVY2qofDA2Co2tPN16GoxFwLgWGzBxtNGH0+5ZD02Iui7O12ZshCkNMPEX+SKX+xCHO01fjhqnBhwENzuC0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: opensource.wdc.com; dkim=none (message not signed)
 header.d=none;opensource.wdc.com; dmarc=none action=none header.from=fb.com;
Received: from MW4PR15MB4410.namprd15.prod.outlook.com (2603:10b6:303:bf::10)
 by MW4PR15MB4428.namprd15.prod.outlook.com (2603:10b6:303:105::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 06:58:58 +0000
Received: from MW4PR15MB4410.namprd15.prod.outlook.com
 ([fe80::d182:98ae:c999:2a51]) by MW4PR15MB4410.namprd15.prod.outlook.com
 ([fe80::d182:98ae:c999:2a51%6]) with mapi id 15.20.4649.014; Wed, 27 Oct 2021
 06:58:58 +0000
Message-ID: <285f0f7f-a2df-7f23-2ba3-8ad3c12293ad@fb.com>
Date:   Tue, 26 Oct 2021 23:58:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH] btrfs: sysfs: set / query btrfs stripe size
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>
References: <20211026165915.553834-1-shr@fb.com>
 <PH0PR04MB74165B2A0D395AD9A45310C79B859@PH0PR04MB7416.namprd04.prod.outlook.com>
 <9a0a442c-8409-3401-da85-9032259a7bc5@opensource.wdc.com>
From:   Stefan Roesch <shr@fb.com>
In-Reply-To: <9a0a442c-8409-3401-da85-9032259a7bc5@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:208:236::20) To MW4PR15MB4410.namprd15.prod.outlook.com
 (2603:10b6:303:bf::10)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c0a8:11c9::149c] (2620:10d:c091:480::1:2e6c) by MN2PR05CA0051.namprd05.prod.outlook.com (2603:10b6:208:236::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.11 via Frontend Transport; Wed, 27 Oct 2021 06:58:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e129dc6-e522-4f5d-91eb-08d999173fc8
X-MS-TrafficTypeDiagnostic: MW4PR15MB4428:
X-Microsoft-Antispam-PRVS: <MW4PR15MB442854994A39D7C1AFAA2029D8859@MW4PR15MB4428.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yb+j9ea0VvPP3oWl1/gsra/5PRzRXX4Pz3wR2v6Mdcwp8BarBM7y2iL3T6KpEOWdcZHfLy38EKGttVw7w3GTNIYeD+nuhhyrF8cGhlk0l2zFFp4GqB7fg5jR1OmaHvYpnS7Wf9FSHZxoywtRPpF0CRhG0qMoodr8O4wYMPWY9bt8FSs+6WsfqJCLL4KSw3tfv30/fD2UUeYs8L2OsYlPlHRMFHpPqvpkifSKR/VHmg8Qh/UtrYhRTzq61Yt3WVFFH58EvKT+EgseLNdGsLQoEmaTcyd/qI5gMKEvRD/Gl6b5C7R97NNrPbZ/6P9c+Bv9oG0OMaIz9BvOaqjQCryifUSdht/qNlwr4rTTIEp+wRT8pNzkcrUtO+cwSx/F+fxOAcqJMqASyVGiicd2U2YeaUIu2eu6AGEZLK0shwguuparmYz2Jf8izwo258rZhTkT/fo/p+LUc4LEM5/n3NwFo9/0tlu5nwFGVti7L7RBBQBY8VHuHQJmOFoW4flS69TD2A8gS66dX362pT8RVJwCcU+//P34Ysf4zJCAHeUjSuLZOevFMcZxH8thmSsNpCeunrEpFEuEOs2x0J3c4bU8O17kMr4Cz4bBZFSxXd8i4M0MaoehwsrbWzmaUIJjQbfbA0hsQ9kgKDNlXx012irh1icuOFcEj89RGLrSOg63offJ0QXVg2OvvX4e2OQ7MC6svAPxr4Y/6EFIxZYciUh/sS8en988C9PRWH0964gf5gs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4410.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(66476007)(66946007)(31686004)(86362001)(508600001)(2616005)(186003)(110136005)(66556008)(4326008)(6636002)(2906002)(38100700002)(36756003)(316002)(6666004)(5660300002)(31696002)(83380400001)(8676002)(53546011)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjdJUnlWOEVXVjY4RlQyRWduMWxxM1lOYjVtbkxrOXhXZUZkSElwY3NMaE1K?=
 =?utf-8?B?dDZBaDZEdldxVmZxVmJsWGkrUmNaRExrRlZ1b1F4RkpzYkY2WGxjNDE0YmRK?=
 =?utf-8?B?Ujk4TVkyZnJkL0NSSTdOMjdYbWVKZCtRdVhHRHlJVjVkZlRrbmxBS0dJNU02?=
 =?utf-8?B?d0p0TUdPbHRITGRJK2wzRkdXUUczL3VTOEJUaFRJbHVkRDluVE9uRXUxcWk0?=
 =?utf-8?B?WVVMWnlqS1VScm1qd01OaEV3dVpwSW0xOWFuZnB4THNiaHV3L0dLY2N1Lzd6?=
 =?utf-8?B?QnBMNmhJcU9iTS9iZHNZZythcEt4UG5IbitTbVJMOS8rUHh1ZTRLMEdFUmZL?=
 =?utf-8?B?M1VvWlc0ckhKMitsajV2bC8rY2F2U3JBMkhXdENGL01DR2p3WGR3bTQrZkg3?=
 =?utf-8?B?OVdSVGhtWDM0U3VKeHVWNDBYU3BwY0FVbmQwaWxCemhBZlRBOXVGVlpvK2pD?=
 =?utf-8?B?MEs5VVlpMGtsTjlBTjBILzNFTEU2RVg0S0pleW1Nb3B0Z3FhQWwrNnM2L2FU?=
 =?utf-8?B?MHBhYXFxNFczZXl6dEdOSm9BMjhFU0JUYWEwamlVaUtYaGNURjVpYm5nOGdM?=
 =?utf-8?B?L3htZmEzN2pIM1F6ZUVYdkkxcy9HVkRrZWhWK2o1WHZpLzR0WE4vMjNHNEE3?=
 =?utf-8?B?ZUpySXBRQU15ZXBoL2IxZnIwY1VScWwxcTdFeWJhTFhCQ2E0Vi8vak1jN0NV?=
 =?utf-8?B?bXN4L2F3MTQyTlZWdzFJcnZNays1WWtBVEIvdytEcVlHaE9iZTltWm5jTG1I?=
 =?utf-8?B?dnZReFFwQU9kWFV0clNDZTBVa3oyLzFUWlN3enJtL1JLcVNKMmJzZERSOU5Y?=
 =?utf-8?B?bU9jWG9qWVk0ZS9KeWZyc0RmN2JGWThwcFhPUkRkQ3B4amtwdWtvWFR6a1pv?=
 =?utf-8?B?VkM3ZUFsK0hGMy9lc3htbXF4K3dObWZ1OUhIV0RTaGQ4dGZVaUY0ck4wUWsx?=
 =?utf-8?B?N3FrRXZYeXRjTFA5RXRpTXhkRlk4NURPdGNRUC95ZTVpeG42Q2ptNzV1NkFv?=
 =?utf-8?B?UkFUMGFoSXVZWU4wVEJCWklwdFRXR05lWFExdFhweFh1emdVVkNuanE5YktI?=
 =?utf-8?B?V3JjOW9NakZnaE9idS9LWXltSWxlZE53UUJmcVVvdEtWRmV6c1Iwd3BGTlhH?=
 =?utf-8?B?Nm9UN0R6dUw3d3hhbFZuZU5DcllXeUo3V2k4K1B3R2p5RFVGYjBIY3lpeW1r?=
 =?utf-8?B?WVFqL0ZhM2Z0RDA0aHZNTVFPZmhtOS9iS3Fxb3NCTnkrT2FsbDhVSFVTazRJ?=
 =?utf-8?B?VEp3U3FiU29mdEN1aHQ2VGRHMEhtTGZtZ2NjWHg0YXdjenJ5QTBsWDhjemRS?=
 =?utf-8?B?MFFZV2dGbythNjNVaDU5aWxEckxiYnc0dUdndmZDSWZ3TG5KWjBFTENtNFlV?=
 =?utf-8?B?OG16aUlhVG02N0E0dFk3eDhpK2Z2dUd5TTBFQnMwRi9NOWhabHVDQjAzSEhD?=
 =?utf-8?B?blZ0enluRE0xbUFHcW10K2M1Y2xGSWR0V3ZLUHBMRkEzYnpVWWhkV1FkOGtQ?=
 =?utf-8?B?SnQrYVNNR1Y4UG90MzA0MzVXeUVPOWVYeHB6cDlVSjJjREdUTFQvSjNzMm1n?=
 =?utf-8?B?RUhkOFNQQmNCbnpsN2ZvSEg5RkJKNkRiZGh2N0JpY1h0V1Z3ektLKzVXTVdF?=
 =?utf-8?B?TVBENkFXNm1aWm9tUVpEQkNIcHVBbWNCNnYvVFNzSnZHa0JhM211QjRZNkpR?=
 =?utf-8?B?VWVCUXhwVDFTc1pnYWp1U2I1b0RWMEtnazdzV0RGdXhVMEVFRmxoWWkzaGFk?=
 =?utf-8?B?c0tzN283YzNEMzJjaytKc0tCRFBjNkxjd05uMmxJRWcvZ1poK3QwYXZJZGlJ?=
 =?utf-8?B?NXBBV1dTcUlDSXJtTTZHUEZFenVKUVdseURTU0ZmMTdHanpJUHhBU1VvV0Y0?=
 =?utf-8?B?cUdpL2cwU0xlajNwUno2WE50K2NEZW82TXNTWEYwZ2dQSGNqOFQwc1NBOWM0?=
 =?utf-8?B?Z3RXSC93VnkwRFVqMWVsUVhLb0xEY2UwS2xOU1FocTF1RXRoa0NNQjNMYUQz?=
 =?utf-8?B?TG9BeERkQTltNW82cHBJSm54bGdUOWZLc1hSbTFmUUNoMVowSlNRallnc2tz?=
 =?utf-8?B?elpieDNxQU1hUkRrZVRhOGdkUFIyZm9NNCtla2NWWVpaMHdtMHprWC9FeFdq?=
 =?utf-8?Q?0Jn24f3ORsU4g15S6XuT50I82?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e129dc6-e522-4f5d-91eb-08d999173fc8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4410.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 06:58:58.4984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mcY/m5Rod/7RRrtM9elE4+poJQ5aQ3t/JKkA1e1j+dbr+R5lNkhCk+JqGe7WXtpD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4428
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: FIEEjb9k3xS2uwDK3_EEkmiH-piGvt0Z
X-Proofpoint-GUID: FIEEjb9k3xS2uwDK3_EEkmiH-piGvt0Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-27_02,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 clxscore=1011
 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2110270041
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10/26/21 11:51 PM, Damien Le Moal wrote:
> On 2021/10/27 15:28, Johannes Thumshirn wrote:
>> On 26/10/2021 18:59, Stefan Roesch wrote:
>>
>> [...]
>>
>>> +/*
>>> + * Compute stripe size depending on block type.
>>> + */
>>> +static u64 compute_stripe_size(struct btrfs_fs_info *info, u64 flags)
>>> +{
>>> +	if (flags & BTRFS_BLOCK_GROUP_DATA) {
>>> +		return SZ_1G;
>>> +	} else if (flags & BTRFS_BLOCK_GROUP_METADATA) {
>>> +		/* For larger filesystems, use larger metadata chunks */
>>> +		return info->fs_devices->total_rw_bytes > 50ULL * SZ_1G
>>> +			? 5ULL * SZ_1G
>>> +			: SZ_256M;
>>> +	} else if (flags & BTRFS_BLOCK_GROUP_SYSTEM) {
>>> +		return SZ_32M;
>>> +	}
>>> +
>>> +	BUG();
>>> +}
>>> +
>>> +/*
>>> + * Compute chunk size depending on block type and stripe size.
>>> + */
>>> +static u64 compute_chunk_size(u64 flags, u64 max_stripe_size)
>>> +{
>>> +	if (flags & BTRFS_BLOCK_GROUP_DATA)
>>> +		return BTRFS_MAX_DATA_CHUNK_SIZE;
>>> +	else if (flags & BTRFS_BLOCK_GROUP_METADATA)
>>> +		return max_stripe_size;
>>> +	else if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
>>> +		return 2 * max_stripe_size;
>>> +
>>> +	BUG();
>>> +}
>>> +
>>> +/*
>>> + * Update maximum stripe size and chunk size.
>>> + *
>>> + */
>>> +void btrfs_update_space_info_max_alloc_sizes(struct btrfs_space_info *space_info,
>>> +					     u64 flags, u64 max_stripe_size)
>>> +{
>>> +	spin_lock(&space_info->lock);
>>> +	space_info->max_stripe_size = max_stripe_size;
>>> +	space_info->max_chunk_size = compute_chunk_size(flags,
>>> +						space_info->max_stripe_size);
>>> +	spin_unlock(&space_info->lock);
>>> +}
>>> +
>>>  static int create_space_info(struct btrfs_fs_info *info, u64 flags)
>>>  {
>>>  
>>> @@ -203,6 +251,10 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
>>>  	INIT_LIST_HEAD(&space_info->priority_tickets);
>>>  	space_info->clamp = 1;
>>>  
>>> +	space_info->max_stripe_size = compute_stripe_size(info, flags);
>>> +	space_info->max_chunk_size = compute_chunk_size(flags,
>>> +						space_info->max_stripe_size);
>>> +
>>>  	ret = btrfs_sysfs_add_space_info_type(info, space_info);
>>>  	if (ret)
>>>  		return ret;
>>
>> [...]
>>
>>   
>>> +/*
>>> + * Return space info stripe size.
>>> + */
>>> +static ssize_t btrfs_stripe_size_show(struct kobject *kobj,
>>> +				      struct kobj_attribute *a, char *buf)
>>> +{
>>> +	struct btrfs_space_info *sinfo = to_space_info(kobj);
>>> +
>>> +	return btrfs_show_u64(&sinfo->max_stripe_size, &sinfo->lock, buf);
>>> +}
>>
>>
>> This will return the wrong values for a fs on a zoned device.
>> What you could do is:
>>
>> static ssize_t btrfs_stripe_size_show(struct kobject *kobj,
>> 				struct kobj_attribute *a, char *buf)
>>
>> {
>> 	struct btrfs_space_info *sinfo = to_space_info(kobj);
>> 	struct btrfs_fs_info *fs_info = to_fs_info(get_btrfs_kobj(kobj));
>> 	u64 max_stripe_size;
>>
>> 	spin_lock(&sinfo->lock);
>> 	if (btrfs_is_zoned(fs_info))
>> 		max_stripe_size = fs_info->zone_size;
>> 	else
>> 		max_stripe_size = sinfo->max_stripe_size;
>> 	spin_unlock(&sinfo->lock);
> 
> This will not work once we have stripped zoned volume though, won't it ?
> Why is not max_stripe_size set to zone size for a simple zoned btrfs volume ?
> 

My intention was to not support zoned volumes with this patch. However I missed 
the correct check in the function btrfs_stripe_size_show. The intent was to return
-EINVAL for zoned volumes. 

Any thoughts?

>>
>> 	return btrfs_show_u64(&max_stripe_size, NULL, buf);
>> }
>>
>> [...]
>>
>>> +	if (fs_info->fs_devices->chunk_alloc_policy == BTRFS_CHUNK_ALLOC_ZONED)
>>> +		return -EINVAL;
>>
>> Nit: As we can't mix zoned and non-zoned devices 'if (btrfs_is_zoned(fs_info))'
>> should do the trick here as well and is way more readable. 
>>
>>
> 
> 
