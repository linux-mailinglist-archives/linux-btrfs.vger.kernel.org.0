Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C5A3A6746
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Jun 2021 15:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbhFNNDY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Jun 2021 09:03:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48904 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbhFNNDX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Jun 2021 09:03:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15ECxGdV064587;
        Mon, 14 Jun 2021 13:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=f6KrBd7dbhxUv8IxfjmXxtPvHfB2vcKBTaiy8SN1PGM=;
 b=fSK+V0dgrN8tRwfPl2wLFyLm0OpB850zz9HzIdN3zRW+XXoC8jJ6UUbYOzApwk5Z7N6d
 lQkjrY8928IdVaXZAtCC5qrkpnPeIw/F/gqshxQdlAFNRIB5MHSggdJ5wAXqd9ShZIs9
 AN+yXmzHeBiJQZGxw/MkKEkXV3yjld8q8YdHqQh6UGG6rfHrqx7MdlCkUcD5pRtDmf8g
 ajh1P5RW6kK86V9TBeJ3FsB4XVmoNTwo10iefcPbpnp9rLsF/T8+aVml93JMrsgs8cGI
 lW2bVPH4IbSLAfLYWjMIhWwJ6eBKy7yOGCO834x2TalYYSou9/nvnkzb59er9laMF/jV fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 394njnuadx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 13:01:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15ED1Cjx100191;
        Mon, 14 Jun 2021 13:01:14 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2041.outbound.protection.outlook.com [104.47.73.41])
        by aserp3030.oracle.com with ESMTP id 3959cja56s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 13:01:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKLm9s0AMg4Tgn5f6b8xbm77aUu1q9/ifV7x42uepNK2Lv72L0eT3ZP4ZyI1+VM1bFRQSTMIYIZVZRFMIePccRbfuYwJmPUKi3kFy3JTKKVJdKNUCQ1cB06qAw2VsAxqJ3kZjYgQHRtQfRjXzrUX2GQsx/XkZS+ZWcBh773JlVHEQSeX0YYDGvQel+A2LTy2oxFlW/dTvqDmas4fd74XpMBW4G8IrD3pp69DFRk4kBTZfRr85ZuVUPoqayl4VROPL22LkUzeFPhm1d3mn6ThfOupkSyX67plAbT6kdqTKNIcxfWsFmV3OOCpPECc8whfPcYKBWJFX78/OAp5HQ/AfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6KrBd7dbhxUv8IxfjmXxtPvHfB2vcKBTaiy8SN1PGM=;
 b=bmHPptThNASYCqyDZTrXwfpzruW+IJIwS9cCURvdv9gDDE2+I04nzTO0ZYk6zDRkvHs5xg7ttAmrO6zLIqmG62BK3tqi15ktwo731GQ5zW2C/YJJMKVBdYPOatPMz+YefVM99O6bFM4YVdBfULlFanLor8Xk67iWwZGc7dspY6poDdNXm+E6sfX+V7HDib3Fb8LQGOtx5XVr3BGM5RuHThttdLzYTmdrSPPIASyTsVWP9CrDCe1ChyjZiF8Q4+MR0ruy3wXxC0asE3WuBwmnMPjVOSSfLTAzGwtJqFiaSfef8Yqi6vLfmw1b6BYd6hYW7w7bxDo/PeNwnXm5L/t8pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6KrBd7dbhxUv8IxfjmXxtPvHfB2vcKBTaiy8SN1PGM=;
 b=eLC6EhHsL5OsObV0Vi8GIPlg2kS3B5roAnGcBJlSYSLbhqygFiplQU4p6BOzPxOlb0fIc3hIcqZFD1LupO1C40/ACTfMVQ8pkqzopn5WnOSo7cHqZGuOEZ86uDH8fM9siet/UIFvrNANWnhjGOHFcHXRt6Ts3vrQGMVco7YRiyM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4093.namprd10.prod.outlook.com (2603:10b6:208:114::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Mon, 14 Jun
 2021 13:01:01 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%9]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 13:01:01 +0000
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v2] btrfs: sysfs: export dev stats in devinfo directory
To:     David Sterba <dsterba@suse.com>
Cc:     osandov@osandov.com, linux-btrfs@vger.kernel.org
References: <20210611133622.12282-1-dsterba@suse.com>
X-Mozilla-News-Host: news://nntp.lore.kernel.org
Message-ID: <db167846-026b-c7bc-9533-7dc3a8f47673@oracle.com>
Date:   Mon, 14 Jun 2021 21:00:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <20210611133622.12282-1-dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:54::24) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR02CA0060.apcprd02.prod.outlook.com (2603:1096:4:54::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Mon, 14 Jun 2021 13:00:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 648c686f-3de1-4cc2-3488-08d92f347595
X-MS-TrafficTypeDiagnostic: MN2PR10MB4093:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4093117608806AF717F3D93FE5319@MN2PR10MB4093.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C8eNFL9n6P5GWx+p9oWQ7grk8mVYwXCbVFe4XJQDxAlVM8STVfviOU2dNdnHl3hoO7uWAzEmJViMlwxyOg5MNt+ePEOJ9jSsit9z/LqSLrz/mYFB7gxL2Jr6hwlFa91JjXkEw4ytvz+K6KN+KZMJT7oI0W3ipQ9m612Ljb4CecizbA1izLDaRR8xaV9EvU499rMV8Gk3FdmorkyFujamzkOJy/4DEFyBXYp9zekks3Qqf/g/+1McoyquTVqq+YVPyc+4aVJrIz0VYUEQ2fMLr8MVerO0uCsp19M4I9R/0Mfrvaw9OjTxwUxBf9FI/bzJJ/ZAZoCcM08KZm2QuF72UBh9ulTYBc9SkGoBkqfvR+qq+HWO4o8NtNi1JEhQXorov5knyS2U8+eHCJXqsu2BjQFpBuoR9EYZSx7/y22UiKEKv20UErQeKA03v5cX+uN+e4qNePrOUeNEe14XSCxkHuiC3A7wYuqZiZtDJJrpOwlhRWwDAI0WcbexIeZsdW0U2p2jm+42BsWxv81V55wYQdE3/gjG/MGy2ZGc0nftaqKLPFBmyimz7LCKZghNX5FdKbntU3T2aD1tcz0FzNsd9+gB7CyNcGTgSUyBu9Y+22ICA4UVwV6HFeNldMHqPkoiglnVVHqngwMuCFPxdGBDFTTGiRZ/6jG7OOEYbWTzHpez0mrfzQI67i2WnnV/JrbX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(376002)(346002)(366004)(6916009)(16526019)(31696002)(86362001)(5660300002)(31686004)(8676002)(36756003)(38100700002)(2906002)(44832011)(83380400001)(186003)(26005)(6666004)(8936002)(478600001)(16576012)(316002)(6486002)(66946007)(66556008)(66476007)(2616005)(956004)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1cxQjRXNzN4c2I2WHhWQ0gwZkpod3F3NzZiTEVIRkF3OC9JN09nUDNjUHhJ?=
 =?utf-8?B?bHo5WmlFVVJvemVPRlZRQU1rdjd0akdHMkpwMjV6OXI0eU02TEZwTHVWdys4?=
 =?utf-8?B?WXFuMG5MRGR1VnZoRzJ6MGlQS21QcFNCdUFtcnVsMDlDVlRGWEhuY1grTVlv?=
 =?utf-8?B?T1Fna001dU0yZ1oxSS9wZ3RCVXM0UW1Rc01Yc0J3RHU2NGxUalhoMDQrUWZJ?=
 =?utf-8?B?VkMvLzVQeW8rS1huaEZsaDhQTEZTQStwUEtUS1BCV256emcrTUx2ZElBbTM0?=
 =?utf-8?B?NzYrSEZGK2xBakRKbHltWENoait0bGVvb245NHA0ZVlSU01DT1loOHB2WHIx?=
 =?utf-8?B?K0VLc2s3SzNCOGE1b0hJQ0c4WGYyVldhbU9IQ3o2cU11UmFIZnhUZXFMWHlj?=
 =?utf-8?B?RHVHSWFLM3RFVVhiaFRDM2dKR3Q3RG1JMVBHVlJiZ1hwdHYvQnF1T0huclFq?=
 =?utf-8?B?RHdVMVI1WjdrK3FGYkQxUlBMQkdra3VUeWVEa1B4bFZzMFNTWXhFaEg4Vzlo?=
 =?utf-8?B?SFVCQXJGWDRoTXpmeSs1N2Z2SElmS3J3OS8zOU44QlFOUGdueVFkTnZ5TFNW?=
 =?utf-8?B?YkhlR0dUbnpueWtqY0V5YVgrbnJCdnAySEJEa2phV3BiWGZFckt6NllONWxL?=
 =?utf-8?B?U1ZmTjVNaEFSemZHSHROcmVOV2RlODZGN3VVSEdZZXM4aWplVnAyS0dIYlJT?=
 =?utf-8?B?RjBUU3ZyVlAwdmdiOGZQVFNzMVZndGYwVXFnSGNSOXRCNWZndU5JZHdpMmVH?=
 =?utf-8?B?MWNSSzk2SktrOGtLR010OTR2WTNmZG9ldzhMSGEyRCtzekQxbjJRL1NuSTUx?=
 =?utf-8?B?MnNwZGJicHlDMkh3UHVxK1JIaUZhNzVlNWFIZ0tGM3RWampQcURyd0hGd1I5?=
 =?utf-8?B?MXkwZnVRK0psVVU5TitUclZybzBTbXZmRnhmRFVWMVd0bUhUeVJmdXB5aDFL?=
 =?utf-8?B?Nm5CK2dXYXNiNHZ5clp4bzA1RU8zc3V2aW1GZTJzbTRBdVBxNjJTUmxKOGl1?=
 =?utf-8?B?dVV6SVdRNzUvRzB4T24rTmkyNXhpY3JUV05RSFhqamgyZ2g4KytvbUlmUnZU?=
 =?utf-8?B?cGhDRFdpUWlSTlpMczFqb2QvTGFjVytJWDFKMG1CVHFtSUdTendiTTVOcUNn?=
 =?utf-8?B?Nm1PM2JJOFVTNFRsSlRMbmhOYXZzazcwQWVZTjhkYkNGekZwemF0bG1Nbyth?=
 =?utf-8?B?K3FDK0h5YVppOER3THEvcFZPOFVxYkVOWkxaYlVYWlB4WXUwZ3VqMVg5cStD?=
 =?utf-8?B?NGFwaFNVRTF0cnFzU2dzb2MrOTJOM0ZQNkc5YVhjQ2E3QVRRUmV5SzEwWStm?=
 =?utf-8?B?c1ZzczFnV1J4WkdQWU9ueG41dklJL25JK0ljUW1WY1pKRE9TdCsxaFMzUnUw?=
 =?utf-8?B?NEh1S0RpTUFZMVRmZUNLUmtOVEh4ZzlrcUdWRUVBNHQ2eXFVTW0yblFFRzdT?=
 =?utf-8?B?QzNCSmVieU9QanY0L2FlSWlISDNGZDB0dzkwMmtIV2xnK1BGbE1WdGlrOGk2?=
 =?utf-8?B?ZzR3ZFplUzZnSXBXYlJ3VWpHUElzS0l4YWp5a3JBZFVCMVhGYi9FR0pDRE85?=
 =?utf-8?B?QXk0MWQzU1lRakJNTjVxZnppODFYcWtZVGFLWjd4YXFDRUFMN3ByUUNrZDIr?=
 =?utf-8?B?RHNNNWZ1UWYrVWdKNVZLRmI3UjM2STlvdGRGTXNTYnlDYTNKKzl6ZEtqRldB?=
 =?utf-8?B?ZDdGZnVCMU9LMU85bS9sTGtWZm9zMXB6VkI3V0VkUGNFNFFoR25Xa0RPUEo5?=
 =?utf-8?Q?77LJL3T7fNwcbX4JBA3tyAB9w7j8j1RLexqO9qi?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 648c686f-3de1-4cc2-3488-08d92f347595
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 13:01:00.9831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zqm6/FaYvjY0QlZdqvpv6VrzkTm5jrf2dfFDxD7gof3tQKNk+TV43Yf/LqDayKj19H5eiHlhLYwYx+WaYT3X7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4093
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10014 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106140089
X-Proofpoint-GUID: RMJFPaZ9u_2myX_uFtzElX3t9vhDXVEH
X-Proofpoint-ORIG-GUID: RMJFPaZ9u_2myX_uFtzElX3t9vhDXVEH
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10014 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 clxscore=1015 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106140089
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> The stats are all in one file as it's the snapshot of all available
> stats. The 'one value per file' is not very suitable here. The stats
> should be valid right after the stats item is read from disk, shortly
> after initializing the device.
> 
> In case the stats are not yet valid, print just 'invalid' as the file
> contents.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
> 
> v2:
> - print 'invalid' separtely and not among the values
> - rename file name to 'error_stats' to leave 'stats' available for any
>    other kind of stats we'd like in the future
> 
>   fs/btrfs/sysfs.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 4b508938e728..ebde1d09e686 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1495,7 +1495,36 @@ static ssize_t btrfs_devinfo_writeable_show(struct kobject *kobj,
>   }
>   BTRFS_ATTR(devid, writeable, btrfs_devinfo_writeable_show);
>   
> +static ssize_t btrfs_devinfo_error_stats_show(struct kobject *kobj,
> +		struct kobj_attribute *a, char *buf)
> +{
> +	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
> +						   devid_kobj);
> +
> +	if (!device->dev_stats_valid)
> +		return scnprintf(buf, PAGE_SIZE, "invalid\n");

and

Nit:
Instead of invalid, IMO, not yet valid is closer to what this error 
implies. And matches with the ioctl Warning message.

7743         btrfs_warn(fs_info, "get dev_stats failed, not yet valid");


> +
> +	/*
> +	 * Print all at once so we get a snapshot of all values from the same
> +	 * time. Keep them in sync and in order of definition of
> +	 * btrfs_dev_stat_values.
> +	 */
> +	return scnprintf(buf, PAGE_SIZE,
> +		"write_errs %d\n"
> +		"read_errs %d\n"
> +		"flush_errs %d\n"
> +		"corruption_errs %d\n"
> +		"generation_errs %d\n",
> +		btrfs_dev_stat_read(device, BTRFS_DEV_STAT_WRITE_ERRS),
> +		btrfs_dev_stat_read(device, BTRFS_DEV_STAT_READ_ERRS),
> +		btrfs_dev_stat_read(device, BTRFS_DEV_STAT_FLUSH_ERRS),
> +		btrfs_dev_stat_read(device, BTRFS_DEV_STAT_CORRUPTION_ERRS),
> +		btrfs_dev_stat_read(device, BTRFS_DEV_STAT_GENERATION_ERRS));
> +}
> +BTRFS_ATTR(devid, error_stats, btrfs_devinfo_error_stats_show);
> +
>   static struct attribute *devid_attrs[] = {
> +	BTRFS_ATTR_PTR(devid, error_stats),
>   	BTRFS_ATTR_PTR(devid, in_fs_metadata),
>   	BTRFS_ATTR_PTR(devid, missing),
>   	BTRFS_ATTR_PTR(devid, replace_target),
> 


write_errs 0
read_errs 0
flush_errs 0
corruption_errs 1
generation_errs 0


Another option was to print all errors in a single line. A single line
will help continuous monitoring of the error_stats. But it is not a big
deal.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

