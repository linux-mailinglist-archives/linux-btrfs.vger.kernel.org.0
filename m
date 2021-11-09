Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C6F44A464
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 02:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241773AbhKICAz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 21:00:55 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40198 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239122AbhKICAy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Nov 2021 21:00:54 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A8ImnXP018071;
        Mon, 8 Nov 2021 17:58:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=AIzeoGgaMJ6S6PNi5ftorQrvomK9ZLQ2dID22Es/7Gc=;
 b=BSKIfYCQ6OOvWjb6gUOBP06u05rjB8Lfn37EOekUEDpYVnrV7Zl32KFevejJAyUtcvm7
 tEwEH/xd68nA72m6AtstXSCkJ0GGgAXeWaBxjSqi5VM53XNtOKBkRHcWyKvU0J7ZyHdY
 GCpKjEKOi84k9+f9toWW1n9ZeREaE6+4Xyo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c71e6q48b-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 08 Nov 2021 17:58:06 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 8 Nov 2021 17:57:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtVDEFcv2x8pj4omPWxde3mRP/vDKJ+4XLbjcVcEttxidmUFT1qcBlfwIXK7h3ldEiv8tAPTZypp7nZ5neSblLkbi4Zdbx1qsADnYKZbanMfKzPB3ZIDrUXwJnJGfU4FRJE7FNa94Kxkthzc780TtO1mNugggBw3NFVBoaM5aHN1xDf/G7ei6Jh1TRDnvS/emF44yKYxYwKSmKYJzR9IgLrR8bLPhW95SQiokHZjaWYQUyISauPJr2NCFd3iDJ/ONlfCiUOpyhPFoNs7RElGRmBIj4bUgxURl9jogL6hrjVPxcmzubu1p0Y9uP/yokcJ5ig7xkspEDKmgRB/oeHHSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIzeoGgaMJ6S6PNi5ftorQrvomK9ZLQ2dID22Es/7Gc=;
 b=Pl9rCmiyc/sVdhPX1vV4LLZ1WESRzq1kKg83a9/uqF86uv+5sY/3H3CF21rbVjgInyGblMWvnQ4SeX8iySfO3PhSZk3/PMyCEx6KobV7r+4cNBfcKARcZsxeXu9v2JitLIvpKZq6vSFg4WxoE5p4bh18Am9MDlAij1ItghzzhPe6ElvhMOqqjQC+Yiz0xyAs+iO0v2RzJhKLLoTL9YK9B3EvjUVcC/dnBaqu2S3WdsuHjemF7HvsWPh2OLoqDDZrQbStTlEbMsXSi3vpPjsfU7yxFXES263lwDTndR6og9UOJ9GmN38XCSNrJb43CmZWvGMHGzRNX3afjR2wLHc0uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=fb.com;
Received: from MW4PR15MB4410.namprd15.prod.outlook.com (2603:10b6:303:bf::10)
 by MWHPR15MB1343.namprd15.prod.outlook.com (2603:10b6:320:25::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Tue, 9 Nov
 2021 01:57:58 +0000
Received: from MW4PR15MB4410.namprd15.prod.outlook.com
 ([fe80::6d16:2cb6:9c06:c719]) by MW4PR15MB4410.namprd15.prod.outlook.com
 ([fe80::6d16:2cb6:9c06:c719%3]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 01:57:58 +0000
Message-ID: <aabdab98-f712-8345-decc-c83e84f009c2@fb.com>
Date:   Mon, 8 Nov 2021 17:57:53 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v4 2/4] btrfs: expose chunk size in sysfs.
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, <linux-btrfs@vger.kernel.org>,
        <kernel-team@fb.com>
References: <20211029183950.3613491-1-shr@fb.com>
 <20211029183950.3613491-3-shr@fb.com>
 <1b9cde85-a7ee-42f9-f7ed-49169757e86a@suse.com>
From:   Stefan Roesch <shr@fb.com>
In-Reply-To: <1b9cde85-a7ee-42f9-f7ed-49169757e86a@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0091.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::6) To MW4PR15MB4410.namprd15.prod.outlook.com
 (2603:10b6:303:bf::10)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c0a8:11c9::13dd] (2620:10d:c091:480::1:7cd1) by BL1PR13CA0091.namprd13.prod.outlook.com (2603:10b6:208:2b9::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.5 via Frontend Transport; Tue, 9 Nov 2021 01:57:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cdf5e28-4264-4f5c-5ecd-08d9a3245a5b
X-MS-TrafficTypeDiagnostic: MWHPR15MB1343:
X-Microsoft-Antispam-PRVS: <MWHPR15MB13435BEAB28037D98A181199D8929@MWHPR15MB1343.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vMH3w/vpLkxSW5kGIm56YNURXfSXwb0kInmiiWXZLwSAU4q8Hby77dBT9ZEEruuh5mgKHdrD/cR6ke8x0x03j5Udvb/e0CuJX0Kt4qvv7xw0X+B3nDfnQu4TtcSlStKwr2DfInMKDy3up1SEn/hM0+kzNQVDyCXwrvXQ7cobtCpWDPADmMn8Ne2JCMewC9TjrNAKXf6rGyoxK7nLuvHPoRMZsQxh9ZslrbjywrcjP+M3LWb0T+aDjoDcWNpFVPJcZ0I3cFMoyxgfIbs4vAUlt3WX4yJNWsbLbrYZKfORzTntd3ZiY01jBKKasm0Kr4jP7O/7vluvu2syDuwa7+wEf1j27DxEbo+UJri5RMNtWo8kL7fPtN3ibDLZQKiaGLlwjPV828YfZFZUYGBrqZexxv7nbpSdLJWSWHJzA3xtSwV9iBezZYcYnbURIC5FpBE3hRjPKaFRZLG39s2RQo6ELZzT5IFFAX/SLZhziGQkP3GNk7pw9+3NcfWM67+7HBTU/KFlIG6djy2kZBU8D8Ryf4f9chen3jjR/hA8YloYJbPeNau8YEpY78aB0C6X/VqJva2tV7Z3HP5wuIokrTY9109RXqg1RH+GXPBORt+7UE1FBC8GBwM+GUHUVa2/VQ/4OofVfM4ygwEja4OLXngsOwS/fk3PSL7ajYmGG2H8jw2dB4qoD2v6swL0xAXs1aYmOTBoRQeKCXOrw8BSmo4R18Pv9FrDVwkf1IdT4xg/O8U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4410.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(38100700002)(86362001)(5660300002)(186003)(8936002)(2616005)(6636002)(36756003)(53546011)(316002)(508600001)(66946007)(66476007)(66556008)(8676002)(6666004)(31696002)(2906002)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2Rld3BDWHlPMkZPS3FpSnJxcitiK1BoUTZaMWVpTm9hei9WK3F0VnJFZmZn?=
 =?utf-8?B?YTAvcGczRXB0VitLVU0zbFZaa2pKa0FGbW9KRTl0K2xJZ253SHd1UjlMcVNS?=
 =?utf-8?B?R0NGWldndGFPWUdRSEpWU1luYUZtTGsweU9Xa2ExRjNmOHk5THQzL0NvbzVa?=
 =?utf-8?B?eU5JR1U2QXQxOC9XMUh4M1pQRWVyWE5BQXpEcUFnWDZVdHJsbnF2SWVPcE10?=
 =?utf-8?B?Y29xRzhGSW90alhiUTVSbXEwSFQySlBuWVBPZGxYK1NUNHorVXBZTVloQWlM?=
 =?utf-8?B?eFZuc3gzS0YzR0xINUxDWGhyZ0lmY0NNaGl1cHU5UHRCT1pnNWZpQTFhMFVR?=
 =?utf-8?B?Y0dpaUs2TUJGVUxJem0xaWlQd1FiYmVlcG1hbVhHaU9YS250YzRzYXZZQVRU?=
 =?utf-8?B?WlZIWm1UUndpYmU2RUZBbENRWXoreXBiOTBRRkhFemVPZXlsRjhDaGVHVGJY?=
 =?utf-8?B?UkkvRm5rV2RqMUxjT1MrUEw2VFRaMUhxSktUOW5nT3JXaFVPK2I0R0dGRHJQ?=
 =?utf-8?B?S1dtWXJ1eTZmL0JYTFMzMlI3U0tLajZ3d245OVgrbGZoRThWWEhyd1JaOVZV?=
 =?utf-8?B?aDhIdVZVSTZ4SXUxNHZjOTQ5SVRIdHVLcXE5WE5qajBzekVLb1BPd3VPdmZU?=
 =?utf-8?B?K3Q4TXpjNi9mcGNtWHpLUFFyNkRpRDFSSmdrcTFwSG1kUUdhMXVoYm5GMW5V?=
 =?utf-8?B?MWdxYjBla0dRa3RkdWNLczZEbkZRN2IxRjdnRWFRTVFra2JaZTBqYnl5SHMw?=
 =?utf-8?B?d0tqUlhHVzdGWDh3OURSWk9HQ1hMcUZRQk1KTXR3VDdzUlNtUWMxclExSzAw?=
 =?utf-8?B?V2lJR1FkZlhpUXJtdmVYb05CRXhkUzY2VUpFbDBoTDN6OUZGSVh5YVlDUzhm?=
 =?utf-8?B?UHJyWW9xK1RXK3UzdUdNN1dVUWkwN0wxQTdOaEh0UUNRNjJwRmwrdmF1emtT?=
 =?utf-8?B?QmkrVzR1dGRrUTVXeHJFT3gzMFNLWlRHVXpOaXJ6blZQR3haanFFK0tMbEVi?=
 =?utf-8?B?L3FsUEw0U1ZiVGU1ZjVEa2hwN2thdVkvNDJKVzRsdWxsOEhOWEozZlBUSmtk?=
 =?utf-8?B?Y1pVTmpodmJjdGx5RHRuWm54Wk9rQW8weFc3MzlESzdRT01JTGhIQW9wUnU0?=
 =?utf-8?B?RlBZOGpDSGtack9FZ3FPdGpiYkxkWjdvZjBJd25aOE5IYXphdnIzekpHOUND?=
 =?utf-8?B?cU16MG9jTFZHQjhzakRjbjlOdmZGaUprOTFETzVZSnlCb0ZDb2hmWXYwa3kv?=
 =?utf-8?B?cjdNUDBBOHkyblVsZ01UUmN1aG9JaWM5TXA4T28zTUZFU1JYRTVBbEliZ24v?=
 =?utf-8?B?YkFUOS9hbVJoc1d3eFZTZUx4T0RzdUFRQTB2ZThmOGZpSzFQejJlcXB6RXln?=
 =?utf-8?B?b093T3B5MnpPMzcrdko0dFNCdTFWM1FzUnhwdUFJem9oN1AreFY5SzZ1NzBX?=
 =?utf-8?B?RDBoMDUrOENuQlhIcCtIdUhTeVRFMGI0eHg3Y1pNWkNaWkJZWFZXc3dmeStn?=
 =?utf-8?B?VTVZL2ljOUtJODc1YlB1YmthbDljK1NLYkFHdGpSSzlIUlBEdTNURVVyYTZS?=
 =?utf-8?B?VXNCRFpjK3ZWb0J5OGJqcTRMcWRLdEJpb001Uk5JZkx6bnJnSTBiNmQ0UXRT?=
 =?utf-8?B?V3pYY1hSUWlwVXQvVDh2eFIzTUo4dWtmVDJGa1lydWd6N2ptbzk1WnBBNHNk?=
 =?utf-8?B?ekRZMHRTL1U5MUhPTWNPMC9keWlXOVAvWDk4ejQrQlo0RWhDMkVzajZMRUE0?=
 =?utf-8?B?dkFwRmJaK1JEMWlhL2RtNk5kUE1YWHFpQkZuWXloVHczUDJJQXRweC9GUEFW?=
 =?utf-8?B?ZkszcWhlQkpkODlsbzZQcG9LT016eEFtNFNrMlEyYTFidWxGYVR4YThMNlNQ?=
 =?utf-8?B?dzBqdVk2T0dJNjBMZkl1K1JKcHQwejIrckhuOXFFMGVaZDdlVS9zdEk1SEhN?=
 =?utf-8?B?cFc2RE5mSmZidDJPQkdYWVArSmFyTUROdXlHMURxTHpnamZmbWpMQlNPNEZD?=
 =?utf-8?B?U05tMVU4MDVLT0RqWVZuS1BSZHVWdk02TEdxY3hGVDZkZ1ppWUpjajVhVzM1?=
 =?utf-8?B?QUkxQXRxeWYxcURTRFptUGhEV3lQeHlHdEo2cnpCQjk3MWZmQnZiY1NpTWhu?=
 =?utf-8?Q?TWKWXaW9aHfDILZDr2yc8wu0t?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cdf5e28-4264-4f5c-5ecd-08d9a3245a5b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4410.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 01:57:58.1625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EURMIDzakqwZRKNHaI2WwbrGHvryXf9wQqfDeTl+OaFASAyFFMfcnTTK0VtQFMHv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1343
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 1OJpu9Y4Lmo2571kkx01IHcYR31f3XTn
X-Proofpoint-GUID: 1OJpu9Y4Lmo2571kkx01IHcYR31f3XTn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-08_07,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111090007
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11/5/21 2:27 AM, Nikolay Borisov wrote:
> 
> 
> On 29.10.21 г. 21:39, Stefan Roesch wrote:
>> This adds a new sysfs entry in /sys/fs/btrfs/<uuid>/allocation/<block
>> type>/chunk_size. This allows to query the chunk size and also set the
>> chunk size.
>>
>> Signed-off-by: Stefan Roesch <shr@fb.com>
>> ---
>>  fs/btrfs/sysfs.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 80 insertions(+)
>>
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index f9eff3b0f77c..3b0bcbc2ed2e 100644
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
>> @@ -708,6 +710,67 @@ static ssize_t btrfs_space_info_show_##field(struct kobject *kobj,	\
>>  }									\
>>  BTRFS_ATTR(space_info, field, btrfs_space_info_show_##field)
>>  
>> +/*
>> + * Return space info chunk size.
>> + */
>> +static ssize_t btrfs_chunk_size_show(struct kobject *kobj,
>> +				     struct kobj_attribute *a, char *buf)
>> +{
>> +	struct btrfs_space_info *sinfo = to_space_info(kobj);
>> +
>> +	return btrfs_show_u64(&sinfo->default_chunk_size, &sinfo->lock, buf);
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
>> +		return -EPERM;
>> +	}
>> +
>> +	ret = kstrtoull(buf, 10, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * Limit stripe size to 10% of available space.
>> +	 */
>> +	val = min(div_factor(fs_info->fs_devices->total_rw_bytes, 1), val);
>> +	btrfs_update_space_info_chunk_size(space_info, space_info->flags, val);
> 
> I wonder if we need to enforce some sort of alignment i.e 128/256m
> otherwise we give the user to give all kinds of funky byte sizes?
> 
> <snip>
> 

That makes sense. As the default size is 256M. I propose the following:
- Sizes smaller than 256M are not allowed.
- Sizes are aligned on 256M boundary otherwise.

