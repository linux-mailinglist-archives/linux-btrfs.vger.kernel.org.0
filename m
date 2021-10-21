Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CDD435FC8
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 12:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhJUK6w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 06:58:52 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:60248 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230235AbhJUK6v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 06:58:51 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19L9CvM9016730;
        Thu, 21 Oct 2021 10:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=h1c8ruS4mwm51jhAekweoWcB5xlMfplJobG+q7tv4dM=;
 b=KogXImn78Ao5GeXPaMKk2LVKvnk2T7lXlPFHVaLFceLZyVRW2PbtKeyLmM1blon0YXuf
 zHk18yzfcWjsCx6lIkM3+Issj1GOG2RFbpgX7iwbh4wxTKmbpC5obFy2PDKKzDRF2mjb
 WDLPkHl4b3OowphsB9rjGAe+JjP1DXPtJso3+yIMqWs3YlYPdG4e/LL5B57kkW5DvUt4
 6HBD6Ve9E9TQIaQvQSGUopMJWUJd9DEq+DKd3XuL9k8tDReW8RU+5VTO9hstUWREBWr/
 nPo6mR5Wp89alPjF+WUjZGEMcbq8kZPQOCI3KgVH9sARVGJHQLYF4Cnl7vqpamt6aq/p Lw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btkwj5jjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 10:56:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19LAtcvd062877;
        Thu, 21 Oct 2021 10:56:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by userp3030.oracle.com with ESMTP id 3bqkv1p22u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 10:56:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vai7zfgsIXjcbR2HFVOQh/mnhoxH9dYf6stufFdumpuCtxO0cXVmUa8LCrTHgT58TBvgOQanY5ktQU1F0j8lJQq+cj5s88Si1WxdRUfCjqnRxd6C/g5oVIVeiqb7Ab+ZKy1g2l+LSyTxjqafcC8CyAqgeXOPWY4tFSSG49DENr/nuPLQ5p8jPAql97PCe7276nZkCYOw/vPrMpZdMiqycMZBU078p7+iKaNMpWNywvQBqozS1mhLSqZuASHQGPKCGb14npvW0CdnZU+ycb9Wfn9w2VNe6hriXtlkArGnQacz2k+R4r1o1yXpl52DPEe+FrDU4fO1jAa1070JuX9/fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1c8ruS4mwm51jhAekweoWcB5xlMfplJobG+q7tv4dM=;
 b=R70UTlkxRX5yPcKoQa7BW3JE80D3o1p0EbAQqoaidfv/Q/p1MC7lepwSJOs/1qxXpy81boYDdIwIqIK6I3YzTeGE69qGRf1dFuZOC7R2l1b5GSozxYVmD4G9yfbKR6wBlZH12D/JGwCVL3FbgOeMZ+cLYzZZFt7k5YNtzOQj9C4aUO5VZyt48kFpTeqzycAuz72eoB4s7P29cXruNmtPjJDZXRp+7tfuX1zvOyUxFWYBN94McmBPN4hEVl4Bws4qzauTRgtaxf2uIoBy87/feRHPC3Hoinr5Rjv9/ZfR8RsWAaBXmapN+WXwLUe+musjyLorgJg4lLOTKB4wf8e8rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1c8ruS4mwm51jhAekweoWcB5xlMfplJobG+q7tv4dM=;
 b=FAd/B12d242XjRQXnBx6fcfnTI4LhK5ZMZbiSQFvZmO9gARERxw427jJ355cmAir1I1ZxZmnMna1eOuRnDtUm3SSVRAty3JA/x9PThMwM84Cp5yz5nTZ0aptQRD7D4F52NC0IJ70tb0tlYqNly9FHyBMbK4/eqGNLfz/YDyf2no=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB4123.namprd10.prod.outlook.com (2603:10b6:5:210::10)
 by DS7PR10MB5118.namprd10.prod.outlook.com (2603:10b6:5:3b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Thu, 21 Oct
 2021 10:56:28 +0000
Received: from DM6PR10MB4123.namprd10.prod.outlook.com
 ([fe80::99af:5f7e:6cb7:922]) by DM6PR10MB4123.namprd10.prod.outlook.com
 ([fe80::99af:5f7e:6cb7:922%8]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 10:56:28 +0000
Message-ID: <30861144-9327-8d61-49fc-505174d45caf@oracle.com>
Date:   Thu, 21 Oct 2021 18:56:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v9] btrfs: consolidate device_list_mutex in prepare_sprout
 to its parent
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <8afc1ed3ef688557bbb0dfae1e23d47e53cb645f.1634813005.git.anand.jain@oracle.com>
In-Reply-To: <8afc1ed3ef688557bbb0dfae1e23d47e53cb645f.1634813005.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::35)
 To DM6PR10MB4123.namprd10.prod.outlook.com (2603:10b6:5:210::10)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SGXP274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend Transport; Thu, 21 Oct 2021 10:56:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c37f22ea-ac11-4761-9d68-08d994816eeb
X-MS-TrafficTypeDiagnostic: DS7PR10MB5118:
X-Microsoft-Antispam-PRVS: <DS7PR10MB51181968FC75A145E7E6894CE5BF9@DS7PR10MB5118.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HZe0LLSqJgvacRgsf/uBwqXEIt2NwuXiwodiYLBIOKjdFdo0h4v8iDqVva0vn+JG+KsEPDUSOlsKw127jOVLo01LfmxGDPkjOOYERl/ZXC11R+c4G5L9BT29Y9qL3odfjsLMtSUYFaaLO7a12yqflFxNqQm7NkdBRIXmLA7UHmMURDfpFGaC90TLHvgKuxtYQTVpz2qyv/TOYaqhXgeXkxkfeq0mgQyh/vFXhLd0BveUA6aJPwXX4HKupcOXsRvYCE+xoMyma6FSSTCgbx2u3UDjcMiqpqQod3Qk4r4JZUaQMsizccBS3npL/IkjM9fZVPsniwhZadsQsFsqBar2Pos0q5Dt0WIh/pBpcDjkKez71qSWvZUuy67OBINrq0O5Xs83WccFh1jOe5zXwdxWyiyNUY5aJghy3j//ZZdit754wwD1NE2DyLHuh40q8AW2ubDYXR8bJPS2x4NERkglfEf0A50V7YkpgFkUZgppKUNYovnoadBHVxorY6fU/p/v8kj6/F1Zgt93kbRN6l2lRFPEpWTOMOksR8yopMtbTBieK7gtuiEDfnoRqnXMCrM/80yIWdcHTNLPSxFqsCvKDpDg7f9rouvRuj6gSuWAb1OCcIz0b3nK04lmQUmiVHOi9LfY1bqnduPbtcwqfCKN8LFyd6In59A2TjtPOFHPBx/l0YqzgnZn4TqEXFaAcdzzUESxAuFIw0XzIPrww0if8VWgX7eFbDC8k6ddqjMKlzA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4123.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(5660300002)(66946007)(86362001)(6486002)(6916009)(508600001)(66476007)(2906002)(4326008)(2616005)(956004)(26005)(44832011)(83380400001)(66556008)(16576012)(6666004)(316002)(53546011)(36756003)(186003)(8676002)(31686004)(8936002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEJyQk1BQ2xvWDRGREpFSUZHL3hXTmNsWWtNTTh0MzBIamlNcW9HcEtNYzZZ?=
 =?utf-8?B?bXovRHhxYzR0aXlJaEcyeDBlczhFQUNwaWUrOGtTWVkrMVhBQ25qb2ZHVXJQ?=
 =?utf-8?B?OHlGL1NGK1lTQnhOejFaOGRuYy9MdkZFSTRjYWJoVk5pQVR6SVpCTEQyU0ZW?=
 =?utf-8?B?VkhzMFdOS0x0aHdJRHQ5bGRjOEM3TXBUNzBPTHBHVHlXT0I4QnZyazRzNFJO?=
 =?utf-8?B?djV1TGREVG5WSk5kMTMrd2ZyMG5Gb1ZFbGYxajJ4ZDB2S3Bpa3NUZ05ZcytT?=
 =?utf-8?B?d2Y2S2N1aXRYKzNyUkVuTjhYMWl2bHc1NmwrUW5EWnpwcGJ1UWlTNmFIcUNZ?=
 =?utf-8?B?eFFRV2FuMU5hTVdMTlhycTVWSTcvRExZTXV5NjZRZ1pzSGthc1ZoWEloUWE3?=
 =?utf-8?B?QnVyejdrN2NMdnRDUlNNZWkwc1NvMWxoaStkZ1c5amZNOVlsUU1LWFlOSHNN?=
 =?utf-8?B?aDNBSklTYTVETWNONnFobElpLzJ6RXlFeWxoQWNDQ3pXZEpzRFV1YXozdGk2?=
 =?utf-8?B?WlJIaUFid3BSNDBYOHJlaVM0K21SclBoNHRBclN3VnBqdUFaUU9DWWlBVVBW?=
 =?utf-8?B?eFhxQ1dEeEVsUm8ySmlhcWsxMUNoajc5ODJNckdXTktaNTMxZU5BYnNFUWZ4?=
 =?utf-8?B?SU1GRitaOG8vaExFZEQwYjIxbG4xYnJVclpTTnRXMGRLc0ljN1JyZVhGN2Zr?=
 =?utf-8?B?NWxKNFVXSVE3M2dmbDZwSE5SV3lGTVplWWVLUm5xTW1oWFVBZ09mQ3lBbFlo?=
 =?utf-8?B?bjJ6bCtrQVBRVHAyMHhDZlA1WkVYd0tyZ2F4czNDS2tOaWFXamVJM0xSaDMv?=
 =?utf-8?B?akVNNS9qUGtaVndqL29YbFdCaU1oS1BGTDIrV2Y1eUlLTmw3azdkWlJKc0Nn?=
 =?utf-8?B?aVAyTnNlREFva1dxbG5taTloaEZlUlhhNGtZVDllN2g5NWJYSTZmTW9odWNI?=
 =?utf-8?B?RUxpcVNORXlML2lYVWZkUTUyMTJYUFo1ODlIbWlHaHFRL3RacG14WTdodncv?=
 =?utf-8?B?OWs2U1BZQUNtRXRteGNSQ3RMSkpCZ3VmcUs4SXJIL0RmTDJROFhlSjI2b2tR?=
 =?utf-8?B?NXBsRWNFYnVYWlhwNzlPN01vazdzeWtIVGNnWlFPOW1KcXJBM3NSZGNhOEhv?=
 =?utf-8?B?OFFLMlp5c0xQbVZnZWV6aXV3TlJpZzR4MGFUY2JhYmxHVDNWZXUvelg3UjFH?=
 =?utf-8?B?QlFxTXZGQUtyM2xsQmpkcjdzbVBsZmlWV3NJcnN0a2pDUWttd3NtNGNnL2o3?=
 =?utf-8?B?akpXV1RaVWFyeUxOTGh1MEhyRzVVbytuZkdTdHdrdUJtdXJqVGo1ZzkxQlE4?=
 =?utf-8?B?Y3FCcWJRbGhWYTVwOWJoRjBha3lVbHhEdFJjSDJiN1VzaFZzRE5Eb05qNjRm?=
 =?utf-8?B?enRPUnlPWFM3QTFUK2NOSFMrdzEwRDBtMVE3aXZjVG12UFBNQy9PaTh4RXJS?=
 =?utf-8?B?VXFIeDBkVnJXY2tsajNRVWZhUU9uL1RObFEzOTlOd3lMcGRoU1BVRTR2VXZw?=
 =?utf-8?B?TDRpSWlwODlNZmoyMkM5YXhmYmwrZ2VSOE84czUxTzNtRWNXNXg2ZXF1bG5E?=
 =?utf-8?B?aU0yLzFxeFNtZWlWWGFWSzlNVzkrVW5aNDRPQ1o4d1pBOVNoc2ZwaWd5NitW?=
 =?utf-8?B?WXF2L0tYWXIzU2M5dXZvampHK3l1RjNZRzNNSlBPQkU2d2JaRkVxQW4zSlpI?=
 =?utf-8?B?M3g0clg3bWVGSWp4WVo0MDk2KzZwWklNSHY4V1BHVXB5VDdxRlBnR0Rkem5l?=
 =?utf-8?B?MjZ1aVd3d01adFBITlZUcGNFUis0Y3dDcUphMUtjaHNsUHloMGNveVlhV012?=
 =?utf-8?B?RDZFTXZMcUVjRk92UUt0b29OK3N1VkwyWGNoUzdOZDBsdUZPRDFMV1d6R0Qw?=
 =?utf-8?B?Y1h3OWROTUswWGJLOTNGam1EZDRDaHpIN3Z3TWlEQld6NGIrSVEyNkxIZ05U?=
 =?utf-8?Q?R+n5BLFc6B9mPvZiHX1pf+JC/yn6q7Nh?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c37f22ea-ac11-4761-9d68-08d994816eeb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4123.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 10:56:28.5548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anand.jain@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5118
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10143 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210056
X-Proofpoint-ORIG-GUID: Dcl5kI05W2nN1VruAtyso_kfsv48lfJk
X-Proofpoint-GUID: Dcl5kI05W2nN1VruAtyso_kfsv48lfJk
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 21/10/2021 18:49, Anand Jain wrote:
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
> This patch splits btrfs_prepare_sprout() into btrfs_init_sprout() and
> btrfs_setup_sprout(). This split is essential because device_list_mutex
> shouldn't be held for allocs in btrfs_init_sprout() but must be held for
> btrfs_setup_sprout(). So now a common device_list_mutex can be used
> between btrfs_init_new_device() and btrfs_setup_sprout().


> This patch also moves the lockdep_assert_held(&uuid_mutex) from the
> starting of the function to just above the line where we need this lock.
Err.

David, Could you pls remove the above two lines in the changelog at the 
time of merge? If you prefer, I can resend/reroll to v10. Whichever is 
better.

Thanks, Anand


> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v9:
>   Moved back the lockdep_assert_held(&uuid_mutex) to the top of the func
>     per Josef comment.
>   Add Josef RB.
> 
> v8:
>   Change log update:
>   s/btrfs_alloc_sprout/btrfs_init_sprout/g
>   s/btrfs_splice_sprout/btrfs_setup_sprout/g
>   No code change.
> 
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
>   fs/btrfs/volumes.c | 71 +++++++++++++++++++++++++++++++++-------------
>   1 file changed, 52 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 9eab8a741166..6aad62c9a0fb 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2422,21 +2422,15 @@ struct btrfs_device *btrfs_find_device_by_devspec(
>   	return device;
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
>   	lockdep_assert_held(&uuid_mutex);
>   	if (!fs_devices->seeding)
> -		return -EINVAL;
> +		return ERR_PTR(-EINVAL);
>   
>   	/*
>   	 * Private copy of the seed devices, anchored at
> @@ -2444,7 +2438,7 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
>   	 */
>   	seed_devices = alloc_fs_devices(NULL, NULL);
>   	if (IS_ERR(seed_devices))
> -		return PTR_ERR(seed_devices);
> +		return seed_devices;
>   
>   	/*
>   	 * It's necessary to retain a copy of the original seed fs_devices in
> @@ -2455,7 +2449,7 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
>   	old_devices = clone_fs_devices(fs_devices);
>   	if (IS_ERR(old_devices)) {
>   		kfree(seed_devices);
> -		return PTR_ERR(old_devices);
> +		return old_devices;
>   	}
>   
>   	list_add(&old_devices->fs_list, &fs_uuids);
> @@ -2466,7 +2460,41 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
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
> @@ -2482,13 +2510,10 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
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
> @@ -2579,6 +2604,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>   	struct super_block *sb = fs_info->sb;
>   	struct rcu_string *name;
>   	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
> +	struct btrfs_fs_devices *seed_devices;
>   	u64 orig_super_total_bytes;
>   	u64 orig_super_num_devices;
>   	int seeding_dev = 0;
> @@ -2662,18 +2688,25 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
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
> @@ -2735,7 +2768,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>   
>   		/*
>   		 * fs_devices now represents the newly sprouted filesystem and
> -		 * its fsid has been changed by btrfs_prepare_sprout
> +		 * its fsid has been changed by btrfs_sprout_splice().
>   		 */
>   		btrfs_sysfs_update_sprout_fsid(fs_devices);
>   	}
> 
