Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE65444B377
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 20:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237907AbhKITrP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 14:47:15 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:21190 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236838AbhKITrO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Nov 2021 14:47:14 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A9JXHcL029332;
        Tue, 9 Nov 2021 11:44:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=GmJlHQvf1bhttRxbSfuW4hliYA1Lk3OcmBobGI6hmYg=;
 b=Zve22giFGnwHQjzem675IvooPNCSoOB2GCGG2hBmJbq4Q3zHtOw+KhSBGlwTObffRZND
 fP+0xBljHy4/JlYcae5ikXsTBrx1F1ftfRDtv3Ku8A6ud4HXsonsYn5ytfKjvpMiXZYO
 nAdgy/rgrkxxKrHM1RU5lTEVNB6UNhBio0w= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c7y8b83ru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Nov 2021 11:44:25 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 9 Nov 2021 11:44:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LALThU45vl3jVtf9bqrEzOpE+usevjQpD0BogK9nWEdrXOZ/g/6G6JHW9VGvCIPQekzSk+NGCHIoKyliLZpfnkDN8b9y5rxIArKVpq9EjCqPM4iqvP7q1hnbF30DzvpaCZvl37Dqr20ObfRKx2b5EK4TplybFKFuFCDKBMB+vwCSpNPh4BkXAbv95wE+j521SBVsvNYlNCDtU3dkbgu4HdA6LCOFMLflfDR7PJM63hi2pxG726JyJVO5ffwaPDoiPJHrurWEMNVdRbPIUV/7Ep7GQ7CnkNTvioq/cWnpYh/mrZ6XTBiJL8mOJfpKE7iBiSzzBBqL3idyEYuOluVfjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmJlHQvf1bhttRxbSfuW4hliYA1Lk3OcmBobGI6hmYg=;
 b=BxflUHJyrlZmomeKGj61bYM/3QWZjrhdD2uqcNwcx482E9c49FtedYhDnv9Gt8rH6dazGiNRnWjmbazNpl/29bYCjzcNYHu4YhIxDCPNQDBfVuT6/xqyKIfTeDgeVegBy+24fKdZtMUuS0Zsd2rG24DKRSTTO76HMim9IKLyZB5dlgQaXtDtB39JloVFzET5JmHOW5K37BdB+OFUo1n+8rOjPlSzeaVPI51gwyZFwigiUZW6zt6O07UJLRoO/q+Gfgh1u9IjRrL0SQOqUmIzDqol8iRmTt7OgLkP9zo64RbZ1ma5FnpWGv7Kpj2e7mhp6enckoOmJQHmhXG59gE7Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4410.namprd15.prod.outlook.com (2603:10b6:303:bf::10)
 by CO6PR15MB4194.namprd15.prod.outlook.com (2603:10b6:5:352::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Tue, 9 Nov
 2021 19:44:22 +0000
Received: from MW4PR15MB4410.namprd15.prod.outlook.com
 ([fe80::6d16:2cb6:9c06:c719]) by MW4PR15MB4410.namprd15.prod.outlook.com
 ([fe80::6d16:2cb6:9c06:c719%3]) with mapi id 15.20.4690.015; Tue, 9 Nov 2021
 19:44:22 +0000
Message-ID: <43cb7fb9-3f6c-2fd7-323c-eae8e036a103@fb.com>
Date:   Tue, 9 Nov 2021 11:44:18 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v4 1/4] btrfs: store chunk size in space-info struct.
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, <linux-btrfs@vger.kernel.org>,
        <kernel-team@fb.com>
References: <20211029183950.3613491-1-shr@fb.com>
 <20211029183950.3613491-2-shr@fb.com>
 <6e8e8da7-00e7-4f64-5def-d9f0481aa0a5@suse.com>
From:   Stefan Roesch <shr@fb.com>
In-Reply-To: <6e8e8da7-00e7-4f64-5def-d9f0481aa0a5@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR16CA0045.namprd16.prod.outlook.com
 (2603:10b6:208:234::14) To MW4PR15MB4410.namprd15.prod.outlook.com
 (2603:10b6:303:bf::10)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c0a8:11c9::13dd] (2620:10d:c091:480::1:f92a) by MN2PR16CA0045.namprd16.prod.outlook.com (2603:10b6:208:234::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Tue, 9 Nov 2021 19:44:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6946179-0669-4311-0469-08d9a3b953d9
X-MS-TrafficTypeDiagnostic: CO6PR15MB4194:
X-Microsoft-Antispam-PRVS: <CO6PR15MB41942183486761E4167EF2CFD8929@CO6PR15MB4194.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qPn64MCUrhIQU7YrDrYb6PucdSTY9eOEbCQJMQx9V44USRv+N/2fOVBa481ht+KTCtbdilEjrxDku1S42Rg75gsfPa6HJLvk8T/Rig1Y5toCVRdD7HhLFlNLTQSi2c2AfamEhAaO98b42y7+rOZ+UTxwzI/UstC6SuZYtHgCjDMdrR6xIcswwlBQz5gs+x+1KZE68il7WhAmnDPqKJ8Exq91tmRplwKiXuMci4iM3iJ3XPcmk8fUUTN+PfhZGTbGngrD/mKw1z7PUgKjhu1JLY8f8KcuwyL4wrQ6zSA/FF7geuOVCVhF/uN3OBdqJOUyVMj/qID3sfrt0sB0w6YuRMm1OuhHeQaitsZxb6kyG5/RexCd/QqFyEBZ0GFv2uo2VP+7dnCRzN5bPugFk5RK/MFalSkJq1D/+UPWsqHnGFv9kXqrcZKQWDT5cEO/Q324FAizUcYomBzFAUzQC7dgSaBskgE3PzY03v/7PLT1OB8JJgyhL9oE/6IGX/PaTXtm0sQC/el4iGboWX/D+RWUK/KeeJbbxf55hKovRol5gzOGp03Uf7mzwl55Fv8DSgGH/IyFKDq0FwWw8F0gQFSij5s4Qc1lDd6jtVf9Qli9YWPFdSnMfYZXuQw1PbLLc9XHaYODvWZ0WCO2yApTcahOexth/vX5izlqR+PO+BnIveGbXZ0BJeG/+eoevRF8jqEjwHqXHCJWBkoQUWhM2n/uVrcMGimYLJwOVYcd9LCJu18=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4410.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31696002)(186003)(31686004)(36756003)(53546011)(66946007)(38100700002)(8936002)(316002)(6666004)(83380400001)(86362001)(66556008)(66476007)(8676002)(6486002)(2906002)(5660300002)(2616005)(508600001)(6636002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHRwSDJRM3hQNGJQajAyLzNYdFd0Z25jVnpLNlpPK1p5Vmh4RkYrQUJDS2dX?=
 =?utf-8?B?R3VzNVQxTzZ1MEFZZFhDQ2loMGVreWQwTHF0K2VzRjFoWndyNkxtZ2cxTG4v?=
 =?utf-8?B?VytBR1p1QTJvL2FRWVRJdWRaK01kamoydGlrNmVlVGxTbHVEVXUzME1XcFpG?=
 =?utf-8?B?UEt3b0ZTSC9iQVZsWHJEbGQyV21kYnVXNlVLdlBOcGdCVmlldUpTeUkvTVgz?=
 =?utf-8?B?QVd2QS9XQ3Y2MDI2NTdPcHpocWdhTzhhaHBFcVpiRFZGS3Q5MlpIUmxQQjRk?=
 =?utf-8?B?YTQyL0hNWEtYWngrdE40RVg5dXJnUjVSVWUxejYyOGFJR1hNZC82MFRwRUZy?=
 =?utf-8?B?eTBvN01YZEx6c1lITTN2TmxXbHl5M0ZraTd1VFpJZ1hrRHljc3d2TGVLVnJU?=
 =?utf-8?B?QnZnSUQ0ekNBdzI1OURUeUdUUzh2dnFXcXNyRnJGay9XRVRFUHIzUUpCUWoy?=
 =?utf-8?B?R0YrbnE5b2JKOG5zWHRVOEVUcTR1b2cwemlGTmlXS1hRTUkyWXdlS0pINUw4?=
 =?utf-8?B?MjFpQnFFSEN1czdSdThINnRIK2d3K0FYeG9KWEYxaDg5N0E2SE51KzZRT0oy?=
 =?utf-8?B?SXA5ZTVkMThqcGJGekpOamFLL0RYWkU1dk92Y1cveUlmYnRzR04vSVp1d2pl?=
 =?utf-8?B?U0cyWm1uOHFRWTJySzJZd2JVQURYUDMyQVlyeFJvUGVJZXhPUzFkem9LYzl6?=
 =?utf-8?B?N01CT2xzVXB5Ymd3cGkzdVhsRy9peVQvNTMva1RrQzVSbkxzQmV5aHlha2da?=
 =?utf-8?B?dWRGY0ZnQTdQUmtjSzVVWjVTWGo4Ym9DUGtXMlQ4MlZ0MW9zVXk3UWgzUHZP?=
 =?utf-8?B?WXNTQTBFTWdyZCs1Y1lEV2kzcmkyNUZ2QzNPYlJIcVhUUlowTjdEZU0yOEpG?=
 =?utf-8?B?NkxGMU1mUkZnVXJtRkNudnl2WlFTbjRMZ2t3K2F6Tk0vZ21sTFo1NTdNVTF0?=
 =?utf-8?B?TXFOV3ZsQXJjY2E3Mm9RTEFiSDZpZjBTM3RIWGtPRFZvcENHa2ZOR1oyb3ND?=
 =?utf-8?B?TWJ6ZFdqNFR1MWxFdDJoMHREMkVMWitSY3RNaEJkTzBoVld2RHFUTldrREd4?=
 =?utf-8?B?RjRpYVVJczh6VXhvSlljRy9ETHZ5US9zSlJ6ZXkzd1FiSWoyd3B2aHhTczBD?=
 =?utf-8?B?TzhOUXJVR1lqTVI1UUlFUkpmdUpIM2p4d1hDZllmUjg0c3RiUjNMTnl4UkY5?=
 =?utf-8?B?cUt0TnhzRU1LaHNPS2srMTRHU1c4VVJ0R0ZIMmRxZDBsaGRlWHo4ZDAzZTVn?=
 =?utf-8?B?RzRLZlo1MWJUbldiN3Rjc1pLdFpKZkpFbnhxQ2w5aHNZME9XRVBIMFR6Zytz?=
 =?utf-8?B?YzJBMEN3THFaYW5GRnVmeWJYaWNaZXdaT1Q1UmI1UHdScmU5Umw3SXdMSkpY?=
 =?utf-8?B?d2srSm0yRDRrQ0JrN3l5bHdRUDBNVTRXWUhabXA5MXBIQVVIUExWaG5HYUNJ?=
 =?utf-8?B?ZXZJYUc5SEU3M250RWNubUJQTGdKYUswdWJ6Q1lzYkNwZWdxWElPTTh0RkhQ?=
 =?utf-8?B?SnJ6RmFGYkF5ZFFIRHpCSG5xVkRSTy9ZbURsaDRXdmQxMHJBYUdwMlJuUXh5?=
 =?utf-8?B?RXdiOGYzeVBmQndPQkJtNHovRkpsaU54cmNFaWtrOTRDdHYwS1FCTjc1cUda?=
 =?utf-8?B?L251VEowcGN3c1lIcW5CYUtwZlVnaUl6bE5iaFFDS0o3V1FLK2pkcWNmV2lt?=
 =?utf-8?B?T1JJK0pNWDlqT0FwaXRzZCtQZWN6UHRnUzdudEdKaUhTSEtMQ0kyalk1RUNE?=
 =?utf-8?B?YnRtRTBmUkc4aFd4UlUvZmhoMjNGRkE4YUlzTXdYVG9GNGkrSnhNa2RMYTdv?=
 =?utf-8?B?NFhEMUhxcFdZbFEwcDVyd2hBL0R4a2hnNHhQU0pySWhRYTlya1VvVjE5MnU1?=
 =?utf-8?B?VkNvSUhvN20xUnJ5ZDEreUFpMDBWVk9kaUZaWWRUN1JyYlZ4ZUk0UmQwU214?=
 =?utf-8?B?L3V5U3Q4SzFBRHc4bDdaY3Y0SWdlWUxUdGtpZjBsdlFQYlRrTUJQcmpXRzlG?=
 =?utf-8?B?aG8yYUNIYitBc1BmSlVCSGlJRy9uaHVWOEdhKzBiM1pURXFjaVR6QUY0QTVB?=
 =?utf-8?B?QlJPQW9TRjd5cEdHL1U1Mkl0VUw3M1B6VnBldThSOFhHSHdlNjl6bHFxazgz?=
 =?utf-8?Q?vDpg8p5lwxvIcwERLRD983lsZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6946179-0669-4311-0469-08d9a3b953d9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4410.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 19:44:22.4726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4QPksPfXhio17kuTfmJL9hUS2E3m2M5qtA7t19iQZPAlAJEjoplooLYjhQRSV5Z7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR15MB4194
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: foQhWmn-O9bGp8K_Wa-tWePPZ_sbjBoN
X-Proofpoint-GUID: foQhWmn-O9bGp8K_Wa-tWePPZ_sbjBoN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-09_05,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111090109
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11/5/21 1:52 AM, Nikolay Borisov wrote:
> 
> 
> On 29.10.21 г. 21:39, Stefan Roesch wrote:
>> The chunk size is stored in the btrfs_space_info structure.
>> It is initialized at the start and is then used.
>>
>> Two api's are added to get the current value and one to update
>> the value.
> 
> There is just a single API added to update the size, there is no api to
> get the value, one has to directly read default_chunk_size. Additionally
> if it's going to be changed then does the "default_" prefix really mean
> anything?
>

I changed the name to chunk_size.
 
>>
>> These api's will be used to be able to expose the chunk_size
>> as a sysfs setting.
>>
>> Signed-off-by: Stefan Roesch <shr@fb.com>
>> ---
>>  fs/btrfs/space-info.c | 51 +++++++++++++++++++++++++++++++++++++++++++
>>  fs/btrfs/space-info.h |  3 +++
>>  fs/btrfs/volumes.c    | 28 ++++++++----------------
>>  3 files changed, 63 insertions(+), 19 deletions(-)
>>
>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
>> index 48d77f360a24..7370c152ce8a 100644
>> --- a/fs/btrfs/space-info.c
>> +++ b/fs/btrfs/space-info.c
>> @@ -181,6 +181,56 @@ void btrfs_clear_space_info_full(struct btrfs_fs_info *info)
>>  		found->full = 0;
>>  }
>>  
>> +/*
>> + * Compute chunk size depending on block type for regular volumes.
>> + */
>> +static u64 compute_chunk_size_regular(struct btrfs_fs_info *info, u64 flags)
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
>> + * Compute chunk size for zoned volumes.
>> + */
>> +static u64 compute_chunk_size_zoned(struct btrfs_fs_info *info)
>> +{
>> +	return info->zone_size;
>> +}
> 
> nit: This is trivial and so can simply be open-coded in
> compute_chunk_size, yes it's static and will likely be compiled out but
> it adds a bit of cognitive load when reading the code. In any case I'd
> leave this to David to decide whether to leave the function or not.
> 

I removed the function.

>> +
>> +/*
>> + * Compute chunk size depending on volume type.
>> + */
> 
> <snip>
> 
> 
>>  static int create_space_info(struct btrfs_fs_info *info, u64 flags)
>>  {
>>  
>> @@ -202,6 +252,7 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
>>  	INIT_LIST_HEAD(&space_info->tickets);
>>  	INIT_LIST_HEAD(&space_info->priority_tickets);
>>  	space_info->clamp = 1;
>> +	space_info->default_chunk_size = compute_chunk_size(info, flags);
>>  
>>  	ret = btrfs_sysfs_add_space_info_type(info, space_info);
>>  	if (ret)
> 
> <snip>
> 
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 546bf1146b2d..563e5b30060d 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -5063,26 +5063,16 @@ static void init_alloc_chunk_ctl_policy_regular(
>>  				struct btrfs_fs_devices *fs_devices,
>>  				struct alloc_chunk_ctl *ctl)
>>  {
>> -	u64 type = ctl->type;
>> +	struct btrfs_space_info *space_info;
>>  
>> -	if (type & BTRFS_BLOCK_GROUP_DATA) {
>> -		ctl->max_stripe_size = SZ_1G;
>> -		ctl->max_chunk_size = BTRFS_MAX_DATA_CHUNK_SIZE;
>> -	} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
>> -		/* For larger filesystems, use larger metadata chunks */
>> -		if (fs_devices->total_rw_bytes > 50ULL * SZ_1G)
>> -			ctl->max_stripe_size = SZ_1G;
>> -		else
>> -			ctl->max_stripe_size = SZ_256M;
>> -		ctl->max_chunk_size = ctl->max_stripe_size;
>> -	} else if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
>> -		ctl->max_stripe_size = SZ_32M;
>> -		ctl->max_chunk_size = 2 * ctl->max_stripe_size;
>> -		ctl->devs_max = min_t(int, ctl->devs_max,
>> -				      BTRFS_MAX_DEVS_SYS_CHUNK);
>> -	} else {
>> -		BUG();
>> -	}
>> +	space_info = btrfs_find_space_info(fs_devices->fs_info, ctl->type);
>> +	ASSERT(space_info);
>> +
>> +	ctl->max_chunk_size = space_info->default_chunk_size;
>> +	ctl->max_stripe_size = space_info->default_chunk_size;
> 
> Those are racy accesses, no ? Chunk allocation happens under
> chunk_mutex, not the space_info lock ? Perhaps it could be turned into
> an atomic?
> 

Good catch. I replaced it with an atomic.

>> +
>> +	if (ctl->type & BTRFS_BLOCK_GROUP_SYSTEM)
>> +		ctl->devs_max = min_t(int, ctl->devs_max, BTRFS_MAX_DEVS_SYS_CHUNK);
>>  
>>  	/* We don't want a chunk larger than 10% of writable space */
>>  	ctl->max_chunk_size = min(div_factor(fs_devices->total_rw_bytes, 1),
>>
