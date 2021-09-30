Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7D541DB4E
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Sep 2021 15:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351741AbhI3NoK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Sep 2021 09:44:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39068 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351736AbhI3NoI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Sep 2021 09:44:08 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18UDc6H7011309;
        Thu, 30 Sep 2021 13:42:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=V5fzHfLdfrJTQRLqH5qT4XtIv5b9I0sMvuESllOihvM=;
 b=rDKR+wAw2ChNtV7Vn38IrGsOxUieNYhdv9KMHt4tREbSnvtzjWyLPzrNn6/XG9T/Zjiw
 wdKZSfocjPu8OQBP4rAG5nxZE8+XL2CnCEj4rlKrS+Z2SQRJlIwkupM98F+QSTOKLpcR
 LwaS1+tKc2ywuUxxg85UxAQNLUkINhgmfNWOUaruJR6EK6w50n3oO45raoBhuLfj515Y
 gGPm8l0bhtWFBzA/TAgz4YB5bdn3UyV0gCWAesF4ElJCQqOVlaG5cxud6Q4ze2IySsCW
 o/ckXd9GDlM5LBtzNpHGMDMyELd1LrX1WHiaNixJnjtD8DwFYcdujLIJ+AG6fgFKAFxP vg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bdb2dhatb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 13:42:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18UDeEIA130541;
        Thu, 30 Sep 2021 13:42:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by userp3020.oracle.com with ESMTP id 3bc3cfwf6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 13:42:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVJPCrFGeVTvLPfb4TpA1Oj2s/x29uYmRonuWwGH/vYLiyOMVkwi0A3RSM1go5Kw+gu1EKXOVPrVor4Je1y5qR9yDFl4M0cXc6JlKb7+BHXPAL2ZRNMfwzZDrd4LZgRvqdRzf7NAk2HaU9omZYx0QZYnIwi0oPe4E7+hawMxg6gnQnPQrLvY44wPNi6mU2fF+EWeDetesgy/5b57BB/tD+qeKmYfJLT/YITE+SVD2fnF0h4A7Bsk0Dm6+eF24HeX+sGl+tSSd6BWhpTMERxG38XUDiRrd1Sj8kqaZuOXS7KhFvFPKOFr+xd4kFyz4JGwOq4SYcBI+nGh5JLpwkpLMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=V5fzHfLdfrJTQRLqH5qT4XtIv5b9I0sMvuESllOihvM=;
 b=RyipLE3eSybbR8egIZcGsIC7U6FfQJaQ+APtjdYHz4TwVdmxwh+0y7o1d5eTu0XU5ARR5a7OX2MR3SqoTYJMDm0YgLgeAa71vhFa21P5PDneL8D8jTLNoeEzSJwsukCekzuwUHkuHkj6D804HGcM/LqU++rz3LqVN3dAwwaIfxVbSle1CymyLrxdPeZ4yHyU3dbPLtYHkWJVYvlGjhWmCxYvY0Z4I3Se5sPCD33QJscDEv6wWMwF8jI2R+FM1oIiencsLoRk/QtOw8sPzJabaRCnjXh5ZVaSam2PRVijYgoQS95k3XVHKdnXJaaxXLzOWKG/uN+rMNp3CkoVNFL5RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5fzHfLdfrJTQRLqH5qT4XtIv5b9I0sMvuESllOihvM=;
 b=snCFVVVchIpyBLwDU9XLgmfALQ0YZthe/TGradAi1g81bvSgxg9S8088aXS1O2LDVWC1ahee67+e3mqB4YgrQCfPQxe7E15FpG0vDVlEn2W7BInVcxdkoASsSEugX6w/caLiJuiA9sh53oWED4n53GPE1XVUFq3dm9aUth0/s8w=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2898.namprd10.prod.outlook.com (2603:10b6:208:75::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Thu, 30 Sep
 2021 13:42:17 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4544.022; Thu, 30 Sep 2021
 13:42:16 +0000
Subject: Re: [PATCH v7] btrfs: consolidate device_list_mutex in prepare_sprout
 to its parent
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     nborisov@suse.com
References: <6585e7d938e6600189c1bc7b61a7c76badef18dd.1633003671.git.anand.jain@oracle.com>
Message-ID: <e5e89f86-7927-27b6-55ee-58ba31817529@oracle.com>
Date:   Thu, 30 Sep 2021 21:42:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <6585e7d938e6600189c1bc7b61a7c76badef18dd.1633003671.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0217.apcprd06.prod.outlook.com
 (2603:1096:4:68::25) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR06CA0217.apcprd06.prod.outlook.com (2603:1096:4:68::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Thu, 30 Sep 2021 13:42:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ae26a40-d3a6-44e2-5d4f-08d984181dd3
X-MS-TrafficTypeDiagnostic: BL0PR10MB2898:
X-Microsoft-Antispam-PRVS: <BL0PR10MB28985AD20C1E6DDD4D444684E5AA9@BL0PR10MB2898.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7+Ps3ANrRVrb1TdoOtkruelzyLi6mJCXx5tkJHHmIPWbpsi/v5ndZXy+7MsjhNnLvxsZYzn2m//C5wBOPyKvSUA/qU9A0W4harDu+Krg8pOBfCA4vl0FBYQpLo+1qAs2u/BmzH/vQ4peosvaUhSMJd3S69WJdGs108XDT3lkonNvOI9FPx3NAPxUthdyabJsbqGAfU8YBEcS0M9VFZL1EKLvXADsO+OTNkLwxv/aZBZd9FB7n7EoSXWZ4Lfz3MLPP1h6sU6txUVWMePdrB+BlfWT7W+LLJWe3WW4b9L0o2Mk8lRxj90iE21zux6PRQdMgSxnndQELxiG0he4ltky+l8DtrPiKN/uO11qykrRMKfwFHw1Oa33Cl63BwSUFXgXMFoPH8Lg46CKSJ6TdFs5/gREg/n82qm5dPR77HChXG/ucjx66bew5hi0Qyzqm8vUy8eWNkWAoU+TrLKfeK8eAuXe6/oNWTwmh+eaxiiOM5DbD4wooXOSRzGOH060hRI0OQlI/eO5szFDfVeipKwIiwriJWrgZXW2kErFnCAdeL+8kN9KxJQdcfZyVoXvUBC/yL8BdLP6aC6eJVzNeHoLEZQuyaW0jFnexKqNsPnL6+AySX1lwgKlYiyV/ZM1O3bi7xIdWp5LGnDQayGdfBFNB5GHapKBe1Lg2xyXbBDPts3JskIZ2DvVD4T8RRi4OsTgUheNwe9QRnestv5M5niMh42Df0gcjZbMzC2Yfewf9Cw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(16576012)(2616005)(956004)(38100700002)(31696002)(83380400001)(44832011)(36756003)(6666004)(26005)(53546011)(4326008)(508600001)(316002)(186003)(2906002)(86362001)(66946007)(66476007)(6486002)(66556008)(6916009)(31686004)(8936002)(5660300002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L202bFBaYkgwbDFuWlZiRjJNemZ1OEMwOG1MNW5LVUx6em94Ykw1cWFRUXJL?=
 =?utf-8?B?MnRiSElkYUlrNTJKY0R4a3FPd2NPVHB0OUVralhQTkpFSjE4OE1qdDk1N0ti?=
 =?utf-8?B?allTZGxPY2Z0R3lYbkxSbjltMHpCMmwyMkQyS3Y1TUtSVUF3RWI4Qkt3WUQ3?=
 =?utf-8?B?aVl6SHNNTkdyOTJ4T1NNSmlKNGdrb2ZBOHhFcExmS3lUUm4wOXhWTVByVHZC?=
 =?utf-8?B?L3IyMm9VajI3SnR2aVFvZ1hXTTBEcEF6NWhXdXRSSU52WFdheXRNeE9JK2RW?=
 =?utf-8?B?MzZBQklwV29rTmIwTVV2aTRpSzFDcTdkZko0cHFpcWE1WFB2YUdsTzdReElN?=
 =?utf-8?B?VHFBNWZza2lPYzdTa1NZM3U0dmRhMGZlM0pyWGlCaGVQMWlSN0pySUw4NUNv?=
 =?utf-8?B?MU5uNlhJRzl4R3ZBYzRVOS9hcXMwYUxoVWU4ZG9RSENLd3AzM3ZzQ2tjY0tW?=
 =?utf-8?B?UGZiQmczaHIyWUVWM0wzK0p4TG5LMlhuWWtGZG5iQ2FpOGhxVUtQL0hnSDRr?=
 =?utf-8?B?K3llN0hEeEx1V0FIMWEwRkhud1VUVzhBMWRIdU8zUUZ3MmY0eVFYTjdrNXMz?=
 =?utf-8?B?RkhLRTBWcU9oY0RqYk5xMmV4emE2T3FCV05OaHRyS2pONXp1b2lDSm1BNU5R?=
 =?utf-8?B?S3VtdDN2eEgwa0RTc1NrMmxBQzMzc1lQSm9GSTRHUU5XaWRNNUNCeHJoWGhQ?=
 =?utf-8?B?T2ZYK3RrQ25BWnJOc0ZwVlMybXdSRzFvaElyTnZVSDNNbCtFdkcrZndFbnd2?=
 =?utf-8?B?VSszZ1hLeVRKc3JRMSt1RW9xWkJRWUU3cmxTOHY1RzFOcmd2SmJBMWIrUWNx?=
 =?utf-8?B?M1Q0NEJLOWxYempxaEdkZVdQOEFOUk82ZCtxZFlLYzFWTGRWcjZ0VnpJUmta?=
 =?utf-8?B?NGgybkExRy9Sem13M0hvU3gxeDZsNFVTVDUxeENJdm9Od0xQTjFGdkRnRElG?=
 =?utf-8?B?WUZRcHpKT2sraERHOHEvazY0UHRIaFdzRzc3ZVl2eDNkWXJsa0htMEtFd0pY?=
 =?utf-8?B?ckpYczNBZ0grc0wxcFZPQitVeGZCYU8zaWZqeDdkQ1hOS0NsaHhXSGJtaGhE?=
 =?utf-8?B?UjRaajNkLytsRHRvMTVhdmt3bGMwTGZGU3RMMDNKWFJLTG1Db0thWi9OUWZQ?=
 =?utf-8?B?MmtBeUI5Y21vaUZMaHluWThZM3RaLzUvNVpOeHB6anhaa05QZXBLckFRYURv?=
 =?utf-8?B?ejRlN3dWbGRkRWwrK3VsVUQzZHo2cWZWS093bHorSGc5SHgybVl1L0ZxZ3py?=
 =?utf-8?B?S1Yxb2dzR0lPb0wyZGk4WXdWbDlrc2tseTExem90aEtQUWNNYUwzT1VnK1Nu?=
 =?utf-8?B?RzU0S2hVcUFtVDdoNEJ1ZTJpU1FtTnhKdVM2M2RPUVdOVUwxMXV0WUdFY0pm?=
 =?utf-8?B?QjVzbFVQV2dUQ2JwZXRzQ055Q3VJU2FETittYlhiQytsSGJRYXh6dEQzMFcw?=
 =?utf-8?B?OGdkVDJacVhGRGNWNER2d0VZMHZBZStDSmMwYnpSVkQzejRwU1FRcGNlUERj?=
 =?utf-8?B?S1FsTXMyVEhYckRKRFFEVUZ5aFBaNWY2UFNXd2dGd1cybEptQXRYRHU1aFV6?=
 =?utf-8?B?cGQ3cmtuS1ZZVVNZWExNRzkrTUplaklUdnZVcSs3eStmenJITldnaHMrR295?=
 =?utf-8?B?c1VxYzVPQWdVM2gzUlFiZkVqcUdtV09mNkdNOXhueHVuSkFnSkhZcmRvVGZn?=
 =?utf-8?B?U1dVWlFEdnVDbHU4S1RWN0hZbDR1YkI2VmJubnpDU0FsbWxUVnN5R05ielBi?=
 =?utf-8?Q?eIKO69eN7braDeZ3moHRjNHPS6roiJfQE9Ps5ur?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae26a40-d3a6-44e2-5d4f-08d984181dd3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 13:42:16.8608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wP9CX2/7K5cIPXD0nbKQFJpO1Ef1RfVBPnd3ctwULLSf/r9YMx+osiN2w2MtxeTLiN9ivdjNF3h9qQMAAQwKrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2898
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10122 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109300086
X-Proofpoint-GUID: N6sEfycdUiNDfhxjNAMkbOJA2VvPbzwT
X-Proofpoint-ORIG-GUID: N6sEfycdUiNDfhxjNAMkbOJA2VvPbzwT
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 30/09/2021 20:16, Anand Jain wrote:
> btrfs_prepare_sprout() splices seed devices into its own struct fs_devices,
> so that its parent function btrfs_init_new_device() can add the new sprout
> device to fs_info->fs_devices.
> 
> Both btrfs_prepare_sprout() and btrfs_init_new_device() needs
> device_list_mutex. But they are holding it sequentially, thus creates a
> small window to an opportunity to race. Close this opportunity and hold
> device_list_mutex common to both btrfs_init_new_device() and
> btrfs_prepare_sprout().
> 
> This patch splits btrfs_prepare_sprout() into btrfs_alloc_sprout() and
> btrfs_splice_sprout(). This split is essential because device_list_mutex
> shouldn't be held for btrfs_alloc_sprout() but must be held for
> btrfs_splice_sprout(). So now a common device_list_mutex can be used
> between btrfs_init_new_device() and btrfs_splice_sprout().


s/btrfs_alloc_sprout/btrfs_init_sprout/g
s/btrfs_splice_sprout/btrfs_setup_sprout/g

The changelog did not follow the new function names. My bad.

Before I update these and send another reroll, I will wait for the 
comments, if any.

Thanks, Anand

> This patch also moves the lockdep_assert_held(&uuid_mutex) from the
> starting of the function to just above the line where we need this lock.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v7:
>   . Not part of the patchset "btrfs: cleanup prepare_sprout" anymore as
>   1/3 is merged and 2/3 is dropped.
>   . Rename btrfs_alloc_sprout() to btrfs_init_sprout() as it does more
>   than just alloc and change return to btrfs_device *.
>   . Rename btrfs_splice_sprout() to btrfs_setup_sprout() as it does more
>   than just the splice.
>   . Add lockdep_assert_held(&uuid_mutex) and
>   lockdep_assert_held(&fs_devices->device_list_mutex) in btrfs_setup_sprout().
> 
> v6:
>   Remove RFC.
>   Split btrfs_prepare_sprout so that the allocation part can be outside
>   of the device_list_mutex in the parent function btrfs_init_new_device().
> 
>   fs/btrfs/volumes.c | 73 +++++++++++++++++++++++++++++++++-------------
>   1 file changed, 53 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 8e2b76b5fd14..10227b13a1a6 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2378,21 +2378,14 @@ struct btrfs_device *btrfs_find_device_by_devspec(
>   	return btrfs_find_device_by_path(fs_info, device_path);
>   }
>   
> -/*
> - * does all the dirty work required for changing file system's UUID.
> - */
> -static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
> +static struct btrfs_fs_devices *btrfs_init_sprout(struct btrfs_fs_info *fs_info)
>   {
>   	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
>   	struct btrfs_fs_devices *old_devices;
>   	struct btrfs_fs_devices *seed_devices;
> -	struct btrfs_super_block *disk_super = fs_info->super_copy;
> -	struct btrfs_device *device;
> -	u64 super_flags;
>   
> -	lockdep_assert_held(&uuid_mutex);
>   	if (!fs_devices->seeding)
> -		return -EINVAL;
> +		return ERR_PTR(-EINVAL);
>   
>   	/*
>   	 * Private copy of the seed devices, anchored at
> @@ -2400,7 +2393,7 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
>   	 */
>   	seed_devices = alloc_fs_devices(NULL, NULL);
>   	if (IS_ERR(seed_devices))
> -		return PTR_ERR(seed_devices);
> +		return seed_devices;
>   
>   	/*
>   	 * It's necessary to retain a copy of the original seed fs_devices in
> @@ -2411,9 +2404,10 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
>   	old_devices = clone_fs_devices(fs_devices);
>   	if (IS_ERR(old_devices)) {
>   		kfree(seed_devices);
> -		return PTR_ERR(old_devices);
> +		return old_devices;
>   	}
>   
> +	lockdep_assert_held(&uuid_mutex);
>   	list_add(&old_devices->fs_list, &fs_uuids);
>   
>   	memcpy(seed_devices, fs_devices, sizeof(*seed_devices));
> @@ -2422,7 +2416,41 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
>   	INIT_LIST_HEAD(&seed_devices->alloc_list);
>   	mutex_init(&seed_devices->device_list_mutex);
>   
> -	mutex_lock(&fs_devices->device_list_mutex);
> +	return seed_devices;
> +}
> +
> +/*
> + * Splice seed devices into the sprout fs_devices.
> + * Generate a new fsid for the sprouted readwrite btrfs.
> + */
> +static void btrfs_setup_sprout(struct btrfs_fs_info *fs_info,
> +			       struct btrfs_fs_devices *seed_devices)
> +{
> +	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
> +	struct btrfs_super_block *disk_super = fs_info->super_copy;
> +	struct btrfs_device *device;
> +	u64 super_flags;
> +
> +	/*
> +	 * We are updating the fsid, the thread leading to device_list_add()
> +	 * could race, so uuid_mutex is needed.
> +	 */
> +	lockdep_assert_held(&uuid_mutex);
> +
> +	/*
> +	 * Below threads though they parse dev_list they are fine without
> +	 * device_list_mutex:
> +	 *   All device ops and balance - as we are in btrfs_exclop_start.
> +	 *   Various dev_list read parser - are using rcu.
> +	 *   btrfs_ioctl_fitrim() - is using rcu.
> +	 *
> +	 * For-read threads as below are using device_list_mutex:
> +	 *   Readonly scrub btrfs_scrub_dev()
> +	 *   Readonly scrub btrfs_scrub_progress()
> +	 *   btrfs_get_dev_stats()
> +	 */
> +	lockdep_assert_held(&fs_devices->device_list_mutex);
> +
>   	list_splice_init_rcu(&fs_devices->devices, &seed_devices->devices,
>   			      synchronize_rcu);
>   	list_for_each_entry(device, &seed_devices->devices, dev_list)
> @@ -2438,13 +2466,10 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
>   	generate_random_uuid(fs_devices->fsid);
>   	memcpy(fs_devices->metadata_uuid, fs_devices->fsid, BTRFS_FSID_SIZE);
>   	memcpy(disk_super->fsid, fs_devices->fsid, BTRFS_FSID_SIZE);
> -	mutex_unlock(&fs_devices->device_list_mutex);
>   
>   	super_flags = btrfs_super_flags(disk_super) &
>   		      ~BTRFS_SUPER_FLAG_SEEDING;
>   	btrfs_set_super_flags(disk_super, super_flags);
> -
> -	return 0;
>   }
>   
>   /*
> @@ -2532,6 +2557,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>   	struct super_block *sb = fs_info->sb;
>   	struct rcu_string *name;
>   	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
> +	struct btrfs_fs_devices *seed_devices;
>   	u64 orig_super_total_bytes;
>   	u64 orig_super_num_devices;
>   	int ret = 0;
> @@ -2615,18 +2641,25 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>   
>   	if (seeding_dev) {
>   		btrfs_clear_sb_rdonly(sb);
> -		ret = btrfs_prepare_sprout(fs_info);
> -		if (ret) {
> -			btrfs_abort_transaction(trans, ret);
> +
> +		/* GFP_KERNEL alloc should not be under device_list_mutex */
> +		seed_devices = btrfs_init_sprout(fs_info);
> +		if (IS_ERR(seed_devices)) {
> +			btrfs_abort_transaction(trans, (int)PTR_ERR(seed_devices));
>   			goto error_trans;
>   		}
> +	}
> +
> +	mutex_lock(&fs_devices->device_list_mutex);
> +	if (seeding_dev) {
> +		btrfs_setup_sprout(fs_info, seed_devices);
> +
>   		btrfs_assign_next_active_device(fs_info->fs_devices->latest_dev,
>   						device);
>   	}
>   
>   	device->fs_devices = fs_devices;
>   
> -	mutex_lock(&fs_devices->device_list_mutex);
>   	mutex_lock(&fs_info->chunk_mutex);
>   	list_add_rcu(&device->dev_list, &fs_devices->devices);
>   	list_add(&device->dev_alloc_list, &fs_devices->alloc_list);
> @@ -2688,7 +2721,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>   
>   		/*
>   		 * fs_devices now represents the newly sprouted filesystem and
> -		 * its fsid has been changed by btrfs_prepare_sprout
> +		 * its fsid has been changed by btrfs_sprout_splice().
>   		 */
>   		btrfs_sysfs_update_sprout_fsid(fs_devices);
>   	}
> 
