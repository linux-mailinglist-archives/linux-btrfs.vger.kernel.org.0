Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3405D3E0B1B
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Aug 2021 02:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbhHEANf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Aug 2021 20:13:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24254 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229991AbhHEANb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Aug 2021 20:13:31 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1750AnSr029740;
        Thu, 5 Aug 2021 00:13:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Wv8G9Q8ZIkh8GNQgzX00xh4ukicsbkvFv+T9e6UiImw=;
 b=uogTK0ZIV+a0M6G3IABmmsLAjRwBxMKY2SUryY0cIZshP/pZwQzqBNuARsLxCaoQGcYW
 24TYIQKLtpACi9cWwf4FYZ/DDxpOx6aB2kzqyLVC0MqZgViTPzPqFbSPpidY6a6gcxRM
 IcpMgaw9QhnPwJSmhwxCdPuKFnUS445on8BaGiDKD7IY7bhGfmxaZA8AjHvDofOQXCeG
 33+qR1eN8Sbnh5V86WwTwLsdPb6HG+JC1Mc/vOvLhRMoN8+kC1wrtyO0kUe9BPso7Mt/
 qzYauQWTDlt6nbHR1Zo0x1wLVuSl04swYWL+ff+ky3qyz7Bqa9d3r89fE2lZUHK2LQCC Og== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Wv8G9Q8ZIkh8GNQgzX00xh4ukicsbkvFv+T9e6UiImw=;
 b=UAP19mkrL9SxU8Q9Vg6zcskdrtKcRBNgLqIC4gaT43u49IJSRtKTzbby52jdn/YEPmWd
 lXJVExSXq5v2NAmJio2JB5hRAXw9HbI6utGuAQEnxVfRS7ljhcecHTzqKZKrfwAlt2ez
 yG9U+uGp3N4Bwses4RXoxeWc5Nn8TUigvVpPQDMHFZeagK5D+dtNXAvd0iX/o3/+0dQA
 dW0Jqpz/YiDWuCPmOCPdCpJmoMoI+ZLTK+DXE2oJaMpN252C2Ee6xa2kTxZw/45NohuG
 CzV1Fl/8lJxvKSlLlkBp/dJyyH+JA0JoE+N3j0yCRGbb9Z0EcS90OXVe6ljouGeB5dEJ pw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a7hxpjpey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Aug 2021 00:13:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1750BY4d089946;
        Thu, 5 Aug 2021 00:13:14 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by userp3030.oracle.com with ESMTP id 3a4un2nhdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Aug 2021 00:13:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAWSlERraMUELEvn+DSnNv21i07gH2B229CBAxTIYeA8yyEoKzW2n8LAvIttRxB09M1KtKkzLFgKmon2EPtn1L/C62KxTO+w+rE718Sg+eE8fLQsnpY6Fs0KH/4J3RLDX8532h+MwrVMaYt/Bh8PBAuitnoScnWRzz7WOBCzcWpPbBBawDBrhQTkQY/BWcjIdc6eqRt2yhTQPHIYt5MzSrlbBDFIfeF4wQ79LYGAnYt4SHi7TYlYblicxbCwTF2s7/DCggflFZLtil3vxnruoWt91DrQmXDhEtXLo1ukDGKdLqPFxJFQxgxP1TDy2rgjz7OVI0yoTaSNmUtYlPa+5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wv8G9Q8ZIkh8GNQgzX00xh4ukicsbkvFv+T9e6UiImw=;
 b=AuHuzFcCuZVaMvW5zXWarQnQTzfGhIUEaVhA7sd4Znatlc+ce0oW/EgwqkpNwJrvwlSKmKxjWljzNfVFVu7rCb7gzYsCoP7tRruoyRbY+7KXpWZVY1Z6lCe3ULR0mD8+vhP5FqrGMGx3Li9rzPOi/bgVOJ0Rrho8RvUtzbEX3EsIQDyYmKRpVouW7za5sMk/Oo+PkvoCjJdAVG439dFTlcK81eeCmamQd3G40oloG7iYOwmWianWwK6WVJa48yEiJY45GJyoW8/UcP+0Eif8M6WGw4a+hg6XBnHnfvZ3DTv2etEmNFkHx3axY7RKUFfl5leGS9JmIL6fNXi1ofDfYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wv8G9Q8ZIkh8GNQgzX00xh4ukicsbkvFv+T9e6UiImw=;
 b=shBq8RMtH5Cu6GNj3GYQIpwbAt/AJCAVxKhbQ791ggP4cWKbvu9jwCyWiPHIvstP4aYEn2eYFNVbgh4hiUGIrc+r2GP73O5eOtleOnPkG2fzEolfjhuYEF5eWL17NXFnDBeq+q390u+8nEXg3d1tX/28KzgaB+NWZ2StjuNC0W8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4979.namprd10.prod.outlook.com (2603:10b6:208:30d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Thu, 5 Aug
 2021 00:13:12 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%4]) with mapi id 15.20.4394.016; Thu, 5 Aug 2021
 00:13:12 +0000
Subject: Re: [PATCH] btrfs: sysfs: advertise zoned support among features
To:     David Sterba <dsterba@suse.com>
Cc:     johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        naohiro.aota@wdc.com, linux-btrfs@vger.kernel.org
References: <20210728165632.11813-1-dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <5d40cac5-2048-6a9b-292b-52046a1793cd@oracle.com>
Date:   Thu, 5 Aug 2021 08:13:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210728165632.11813-1-dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0172.apcprd06.prod.outlook.com
 (2603:1096:1:1e::26) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR06CA0172.apcprd06.prod.outlook.com (2603:1096:1:1e::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Thu, 5 Aug 2021 00:13:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4d71894-e865-4fb1-d3cb-08d957a5d007
X-MS-TrafficTypeDiagnostic: BLAPR10MB4979:
X-Microsoft-Antispam-PRVS: <BLAPR10MB4979375D324640B324743097E5F29@BLAPR10MB4979.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SnVGbzaJhNfycp8gL38/CfZle1x8gW+9oNb5UWI7IZSvaH1RDNavpzpUiRMKPGS9qh1dsEptGl6GXkRMarYTJLplxqrUUeGv0EiVZpju8cETStQr6dSNXQ4K/BVgUKSSO4RRrhZco1HiDsITvqDy7Uu3EId9fXkztqkW6oHvnVMncaigKSOKLedRfZS8QX0GrKzvI8w3bLamp/Kv13Ztx5azNmNblrSBbEYTYNfzY9mVnEofGW9uhqMCYbhi2HibHjzNtHHsubo5aDwduobSJ6JBVn8qMq8i+SUxLHV5EMsIEH15j8dlkrlcCB9SJgwge7ud7jZjR/Jvt6H9Z6GFH5qJEcKIP6wtf7Z2GfqGnZv7/opmAf2OmfKRMfmzzzsnXEAP5v6w6OBPmWyoF0DrFAc7znolxU74T7irf3jwxTUTB0Xb44AYTs4MFEZ+MNEawT5k+JJSbNuN5xC4bS47eXuooEQPpJ+yz/zGvSGIolj87zPrSYqWbrtkJ7SIpjcHea22rkDDYoxd2Mria34bnVRl6/HhgFg+LL6wyt418Xez9CVrCkhVWh7sIPx08ZbWsc26JCvYK62lKSGsBmzDf19AfWTX4sE3guwAM3QZDvNb4CgULdY1ZCqzs4l8+nGXbhdT25AW87D8uwFdHFfxX1/Pk1Fjs+kXRiqZMwGKIjVeA+1ldOjt+Csk2CDJmY/xe5UGjhIpojRZshdFBAE6GV0KlZ9veIw7K/+Sfb1ctQA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(366004)(39860400002)(346002)(136003)(31696002)(8676002)(478600001)(316002)(36756003)(44832011)(4326008)(956004)(2616005)(83380400001)(31686004)(16576012)(66476007)(6916009)(38100700002)(66946007)(8936002)(186003)(26005)(53546011)(6666004)(6486002)(5660300002)(66556008)(86362001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3hFZE5lbnBjWUE0eXM1cmttcTNSK3BRRWJnamlhemxab3RmY2hCZXU0aVFG?=
 =?utf-8?B?d3VNR1NqUHM4K2l6cG1oY1Uwd2VzbjBWYmx5TWg5dnkyMDJMZjVJblQ3a3NX?=
 =?utf-8?B?eHBBa1M1Zk5DbVVPYTFWZWVoMjJBTXlFaXRPUGNmbkhQTHEwZ0ZKYkNUeWdv?=
 =?utf-8?B?eVh0NWVIV1RjbUVnOFhxVitLY2RIK1NzRDNhR2pOZnkrWFFldXNUMS8wVHBs?=
 =?utf-8?B?c0NZdThkS2FUeVJMWjlDN2ptVS9lVldreGkvNVQrRFpCQThsYW5DVmE3U0Zu?=
 =?utf-8?B?Kys3cjhWNlI1Wk8wWWxVQXRRZERraGwwZThlUTR1TW1UTElMNXlLTFRHcFU3?=
 =?utf-8?B?K3VhVStxUjhKSDBvWENWaGxSL1BsZ3cyeHpuMjRYWDBmaVRmRm5QN3pTT3FP?=
 =?utf-8?B?TVdIWVl0aE83KzVSL3VIMjRvOU1DVXh4WWo0UnR1cnhSYWZjYmY5SENRVXVp?=
 =?utf-8?B?OHlkQ1grYkVhUm9FQWdXbnEwMTR2b25Ralo0QUovdGtxZ3hlalVpcTNhQkw2?=
 =?utf-8?B?ZGNHQ3RIamVuTDdyY0ppYzk4bElyc0hEUWYxdjlsK0FqMmwzV29Fdndtb0c4?=
 =?utf-8?B?RDBSNGcrZkUrdWxWYjcraitEbGo2eVRIZ2N2V0R5NGtwaHZTVTNPb0w1NExK?=
 =?utf-8?B?a05xaXJoWEUzckZrQVFoVG9kMVhEeEVIdE9xQW9nTkdiSnhTTWI1bHViNThB?=
 =?utf-8?B?eUpBVDYxVDhoUWpZSWhGV0toNnphMTJLd29JY01zajZWN21QYXBjbjFjMEQ1?=
 =?utf-8?B?UERVbGhvenY4VDF5RjhjRCtOSXRPN1VidFAzRHNMaU1qaGNZY0RYSTJ3S3hw?=
 =?utf-8?B?SGJWdzg3d1hlN0xPWDVBbVBDSWtVR1Y0eGF5V2x3WEZMRGozM2RKODJsUk9P?=
 =?utf-8?B?M1VDakgwOUFPZEhCMHFHSFkvZkIzVUZ0cTFqeUZQc2d5TEwyejVpaVl5cDlk?=
 =?utf-8?B?WXJrMmh0STF0dkhwd0VZSjFOVnFFei9EaFRaWjJ6SzU4R3NRc2FxdmhhU2tF?=
 =?utf-8?B?SlpHcnE4TCt1c2duVXZZazNKVGZzalA4eC9obk4wZU9tVFNpRkUwbEd0bjVS?=
 =?utf-8?B?bVJUWnRFV3JrRm0xRjFOc0RXUElMNnU4UnJPZ25zNm9sTUdZWlpPcks3Slpx?=
 =?utf-8?B?QjFmR2FxR05pSDdDUUpwclZ0UWM2KzRyVjZER2UwUDBIQ25pamIzVEtuSThR?=
 =?utf-8?B?K2xQVnVjN2hZd2xIMGxoamVZNWVVNHdXR3pmVGV1cmFPcWlINzNzWjVmV2xQ?=
 =?utf-8?B?U0t6blRPLzFENngrSkpFd0sxTVJSYUZqTVNsSDZnTGdGeTRoa3Y5bEdhSElT?=
 =?utf-8?B?eWk3bjBiNXh6ckQwcDhkT0FMeWhCdkxWUWhQMjN4K0dWZ1I0amVqUkM1Nnh5?=
 =?utf-8?B?d01JQ24yMVNxWnFFdHJoTWlYSmtQN0kvaksxY3dlbW5GbkxxanZBQk9ZZE1q?=
 =?utf-8?B?UTBYUHBVOGRpMVcrT01FK0J1T2FRdFN2RkkwVlBXRmltVjUwcE9XbE9wV3Nh?=
 =?utf-8?B?VGs4QnNXUzZweUVHamx2djlFV1YzQ2E3QWlWS0cycFhqSUU0ZWNndEY0Rmhn?=
 =?utf-8?B?ZW84NHIyRDQ3TlArR3BqejN2V3BIRFIrMTNMSDBzZ3Z1ZWt4N3pENlVaWDNh?=
 =?utf-8?B?NzV4L080SGR6dkUxTVl5ZVA0MkxSV2tmTUJkcG9TWE5UTDVFZWxQY01TRTlU?=
 =?utf-8?B?R3JDbHFlS3JBZHdtMmRkREJyS0JqS0laVGZYOHNsdzNXbE41bWJMdmF5WXFT?=
 =?utf-8?Q?cmEfoz5RZ1yoy0iivgQv6q4tdKtRFfkaWZ4p0Kd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d71894-e865-4fb1-d3cb-08d957a5d007
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 00:13:12.2254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdXiRejF9T/YmQw+DErgGOJYKM9wSr+NEmzZs3R1XfP5oLDIKZ8AHsZnao0EXVHJtISuVSCH+bq0uroJC57BeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4979
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10066 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108050000
X-Proofpoint-GUID: Uuyfp7fLK_UBIBABcUZwwxXdhlL_rsnM
X-Proofpoint-ORIG-GUID: Uuyfp7fLK_UBIBABcUZwwxXdhlL_rsnM
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/07/2021 00:56, David Sterba wrote:
> We've hidden the zoned support in sysfs under debug config for the first
> releases but now the stability is reasonable, though not all features
> have been implemented.
> 
> As this depends on a config option, the per-filesystem feature won't
> exist as such filesystem can't be mounted. The static feature will print
> 1 when the support is built-in, 0 otherwise.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
> 
> The merge target is not set, depends if everybody thinks it's the time
> even though there are still known bugs. We're also waiting for
> util-linux support (blkid, wipefs), so that needs to be synced too.
> 
>   fs/btrfs/sysfs.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index bfe5e27617b0..7ad8f802ab88 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -263,8 +263,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);
>   BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
>   BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
>   BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
> -/* Remove once support for zoned allocation is feature complete */
> -#ifdef CONFIG_BTRFS_DEBUG
> +#ifdef CONFIG_BLK_DEV_ZONED
>   BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
>   #endif
>   #ifdef CONFIG_FS_VERITY
> @@ -285,7 +284,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
>   	BTRFS_FEAT_ATTR_PTR(metadata_uuid),
>   	BTRFS_FEAT_ATTR_PTR(free_space_tree),
>   	BTRFS_FEAT_ATTR_PTR(raid1c34),
> -#ifdef CONFIG_BTRFS_DEBUG
> +#ifdef CONFIG_BLK_DEV_ZONED
>   	BTRFS_FEAT_ATTR_PTR(zoned),
>   #endif
>   #ifdef CONFIG_FS_VERITY


  Looks good until here.


> @@ -384,12 +383,19 @@ static ssize_t supported_sectorsizes_show(struct kobject *kobj,
>   BTRFS_ATTR(static_feature, supported_sectorsizes,
>   	   supported_sectorsizes_show);
>   
> +static ssize_t zoned_show(struct kobject *kobj, struct kobj_attribute *a, char *buf)
> +{
> +	return scnprintf(buf, PAGE_SIZE, "%d\n", IS_ENABLED(CONFIG_BLK_DEV_ZONED));
> +}
> +BTRFS_ATTR(static_feature, zoned, zoned_show);
> +
>   static struct attribute *btrfs_supported_static_feature_attrs[] = {
>   	BTRFS_ATTR_PTR(static_feature, rmdir_subvol),
>   	BTRFS_ATTR_PTR(static_feature, supported_checksums),
>   	BTRFS_ATTR_PTR(static_feature, send_stream_version),
>   	BTRFS_ATTR_PTR(static_feature, supported_rescue_options),
>   	BTRFS_ATTR_PTR(static_feature, supported_sectorsizes),
> +	BTRFS_ATTR_PTR(static_feature, zoned),
>   	NULL
>   };

  We don't need this part. btrfs_supported_feature_attrs will
  take care of showing zoned if when enabled on the mounted btrfs.

  As of now, this patch fails with
     [ 44.464597] sysfs: cannot create duplicate filename 
'/fs/btrfs/features/zoned'

Thanks, Anand

