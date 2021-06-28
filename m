Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E146C3B5C93
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 12:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbhF1Klc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 06:41:32 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:65058 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231935AbhF1Klb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 06:41:31 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15SAc6Y5025018;
        Mon, 28 Jun 2021 10:39:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=4n2F2e6X4g48Fs4H+c4rJt7LUtWjHao6BG+FxtyGexk=;
 b=Shh0JUidcKbUpG2RXEr8ce7LObjhRsqjPB18nwFDW2EEpssUch9VxAEkrnqqNaL2UmnR
 tqaLkcBVIlTnkIxZ+/P1HZoMYGJhbBQ81bfaKBaIFc84Q/pGrtWUYwMLGK8OVwXMBc0S
 /q29SEnwbzjAIAaFWfyXuLGSjaXEhc3ji67Pm5gwL+B3JYKOQrjhvxWFBtD8PnVqf8bG
 NV90YG2dcVD8IYXa9Yn/H6Yo8JK+pHns4XYLmk4eeDSwOLMZ25Tc2Yki5lCYObJEFA3K
 yjdCohl8QLKUC8upi3FGYDE2kqxd4980SE3PLUXXAMOppG7dU89BB5KB8eg9FxqvB1pO Gg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39f6pq8qnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 10:39:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15SAZv7x131964;
        Mon, 28 Jun 2021 10:39:01 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by aserp3030.oracle.com with ESMTP id 39dt9cj33c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 10:39:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADMrLvpfwYRviLTHKXqMk/x+Ctm1Z3QaeggA9xNxWaYnNKnKShgyVhQOwijrCESa57QyNxMlhnteYi996AUGy77HTEId9uJJfxvVt6rYR/fslUPunhAlYAo2qTSpEKxpeI5Dcwj8dtK9Qptby2DH9+L4ZtV8nQK+CzmdFUtLG4Zt2pRXMjpwa6oH8MpqUHTKxsRN1GhJ+0OnFCZc4Xxs0bmkiFT53hy5I2TFUkMBFEsy1/THnAef9+7MQY5lrvTJKiBui3iod1VKq91LA59MITya+598kCU5GHvqcVF2whCoHqByKOCo8XLEYDmdO0Xv4G6symw0ZAG0Oix90zZObQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4n2F2e6X4g48Fs4H+c4rJt7LUtWjHao6BG+FxtyGexk=;
 b=AmZrT2rYItj7yGrqUw0HzFB4XU1qb9HhQND5/IPuiaByDq5JnVYl6Cuyefj9OvMlcKLtj5wha6snLu9WyRpcv6nAFq4xkOLEmI1FriELl6zGdck+Ge5vCkFJ496JlUU/fjAhKsyLT2ykMEVyi0uIt51hbaTTP4dJ1MUubRDmYYA6dA7LPO1bXahWNQY0O8j+6rwCj8sFnRmtJkyIQUXw5SFnYE3UlsZlRlh4pU5hKqXNtQObtyyO8mnh5fk/JeQCJtedWc/V2WWbkrhvmSyWOavGRXD/e1Ou6VGNWF6GEgvFl3gpwJvAWQKLYvB682vNRDq5EnPUhj17YzmPpOlsRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4n2F2e6X4g48Fs4H+c4rJt7LUtWjHao6BG+FxtyGexk=;
 b=X0mjZXSs6aGKr6FZsloHjG2QzxnNc0beSJabdazwHAZK5KSxZyC1p0JJGjhkCMVoL6m0XEIrt9VdYXqVMxNH6+N+6syD20MsI2U1fkd7S3t1tIFYI4KO1Qf1Rzp9qnIRnJ/KVf6YdjuDCEoHQM9I7GBTZs7NGLsrPSNckoU+g/o=
Authentication-Results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4046.namprd10.prod.outlook.com (2603:10b6:208:1b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Mon, 28 Jun
 2021 10:38:58 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%3]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 10:38:58 +0000
Subject: Re: [PATCH] btrfs: zoned: remove fs_info->max_zone_append_size
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
References: <fb36e9a074e51af822fe97f2759e62394ec17eaf.1624871611.git.johannes.thumshirn@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <c6e645b1-ceb1-bbd6-a58a-e6b696f6be8e@oracle.com>
Date:   Mon, 28 Jun 2021 18:38:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <fb36e9a074e51af822fe97f2759e62394ec17eaf.1624871611.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR06CA0185.apcprd06.prod.outlook.com (2603:1096:4:1::17)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR06CA0185.apcprd06.prod.outlook.com (2603:1096:4:1::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend Transport; Mon, 28 Jun 2021 10:38:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5716dfc6-4f99-42cb-a5ef-08d93a20efc2
X-MS-TrafficTypeDiagnostic: MN2PR10MB4046:
X-Microsoft-Antispam-PRVS: <MN2PR10MB40467135E1112AE4B40B0F71E5039@MN2PR10MB4046.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UghiUIJWEaaI56H89JxrAWnPb86EGWp0ncvf+OErupJBrw+XjRYDzlHR0do1P3Za0gSgLoxrzwc/CiV2FQI8ZfH4zt3HAhVS+aPzufRS/vmpHTM2xuLbr7J3/tiXC0MzcssNVVi5B5+CXQa32CwUzsJ1OG3CxtnWma00G62OXnxExNkwkNC4Ki9vumsNXExNheXzcDwEoINE2VgSn2HlGW4GICCw0j37V7CFKO8i5OlGjVG94HXOWoaEPPM3PG4tjcduOm2uUVcUNuTuFK11z8/nYyR6AXNLoPdkFrCivwL0QPkfE7boqR0lOvXMskJNm4sM1je1H+0qqlInflpeSX8FhMgTBFbo0SzdwOHBgrFHhPDIJinkAHCf81juJKJwcynXxDRiKPGd9Vfa8/1oF9Q57JMVHZwuZbVfsEMZ4ISxLE5tJECI+iE65sL25/6jRU2jRFjmkKPPGYC4WXfrc3sfz5UKVd9u3oITr+FXQUwtjPh7WvYSIHFrvL3Iqnst0Sm3STuVCFAlCJjjK+uhQ0klniDtZ9prmT3g4rI2pX+DjZoW3uymsY3QzFn8zURhgzEQiZth09eX1/IkhakBv+pEV2BiQCPDL4n8QsPdTK0BHExO6527E8QCl21iBAtR38LoO/sxSchG96z2mEEWwuzNJWpbXD+VWDSnJMHfM8SOCaLIrAqbu7d9wXw65Gbx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(346002)(366004)(376002)(8936002)(316002)(110136005)(26005)(186003)(31686004)(83380400001)(38100700002)(16576012)(4326008)(86362001)(6486002)(2906002)(31696002)(956004)(66946007)(5660300002)(66476007)(16526019)(6666004)(53546011)(2616005)(66556008)(8676002)(478600001)(36756003)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTBKV1dFTzlkeERvNk1qZXBETHJES3IzNXM0amhyeTQxa1JDVEdESWJ4N1JE?=
 =?utf-8?B?L0pmWkRPRlgwMUxRTWZvZmI5eUhSczZNMitON2liZ3lqYmZ6bjI4R3RCUHJC?=
 =?utf-8?B?WHNxYk52dzlOYVBESFJiVUpXRTVOcnZVTDRMTldTbG9lUktqM3lhRy9GWE1C?=
 =?utf-8?B?UlFBc29BTjdmempxZzZ4RFE3NC90VFF5eGxWRDlZRHh6UHBoSTh4MVdvb3RF?=
 =?utf-8?B?V0NsSEMyK3hKUnFaTmxlR2JnaDhlQ2Y5VHIyUis5dVIrbFFWUU5PdjRRWkZX?=
 =?utf-8?B?RFRwVjdqcXRBaUs1SitUMlFNNVpkNGhOZ3pTbzZnQ2NwMnNJNVQ3TVplTjVD?=
 =?utf-8?B?dmpTR0dtTWo5azIzWkZTVGY4K2VzNzl2MlZJVDc4MmJmbytTYU5KMkRZdmZS?=
 =?utf-8?B?alFLMDNIK0FSNzNuK0ZkYmtiVHdML0N3SmFaUzhGT2VWdUs1MkliSzBrZGtn?=
 =?utf-8?B?MW5QNDN4N1BQcHpJVTZpYStxY3lUemlFMTJzMThjRGZqalB1cTdFcUcyaXlU?=
 =?utf-8?B?dlNIbmV2T0U2TjhKdmJZMjVPa2UrMGtjSFpRelRqVnVzMm0weElXSHgyVGVM?=
 =?utf-8?B?MW9NcGpnU2h5bmFHREZDV2pUZUt3MWJMQ2xxUHdjdGoxUENlMnRRWldmNkFw?=
 =?utf-8?B?amIyR096QWszZWxab0ZUZmY3cEdFUEhkVW42ZjVEbUdZVWdsUDhVd2I0UVdL?=
 =?utf-8?B?eGd1VFFocGJ6RXVFYitXMXFFTHF0c2YxRXUzZ0VKZ01oQzFTNzN0TWI0ZEho?=
 =?utf-8?B?YTRzc1R0Mk9kVzRHODRzSUZrMHhKRkRKR205VEkrQVZxTEl1dmRlai9sNEZa?=
 =?utf-8?B?MmduM1NPN2FhK3FjSjFaODlYMEE2dnFuaHFSdS94dlFQNXJ1cHMrMGwrWTBN?=
 =?utf-8?B?NjJQa3NrRUcxMHVxQTNEVkZxMDRpcEJ6T2VUbFQrdG9BRVpHNDVzUFNXV1dj?=
 =?utf-8?B?V1VYVXVFRlhQY2dFdTZyWm5FamNlSUZNWmhBSVZxK3QxRWpWL1RCWGM4T3dv?=
 =?utf-8?B?YnNuMGNjTzVzY3JCWlUwbUFwWEVacjI1R0g2a01KTmEySDRQOHBYZTlGbkRz?=
 =?utf-8?B?eWxyNXF5dTRqYWxmK3dORDA3VWh4bDg5bE1Nd3ZRWXlpUGFXOHFJMFFRRDYx?=
 =?utf-8?B?WUgrK044RTd5c2Q2M0V6N1A1OVV6QmFGNTZ5RFBkM2c3Z3FCb1htaGcyU2Nj?=
 =?utf-8?B?ZW1NUjdpKzNoaEVCc2lPTzhVNjQ4NTU4SzJzTGo5MFdVRlYvQWZVc2FRby9C?=
 =?utf-8?B?V3VuUmlscFg1SFZiWlp0OFI5VkFCL3lMZE5MRGxyRUY1cXJEbUVsbUFISHVi?=
 =?utf-8?B?TFhVeVk5VW14YS9hbnpVaHc3em1FME9EVFBlN2ZnaEFWajM4THRDdEx0cjNT?=
 =?utf-8?B?MFVyblZITW9HYW9DY1V1S2kwT29sTlc2bEk2QXBsTXJhYmhhc0FNRHViYXpE?=
 =?utf-8?B?WFJkN0Y2S09WbDFITWNWVlN1MnBRbDhSVWM3aUxWWGNJNTZLRzRYZ1dXNUYz?=
 =?utf-8?B?UG5JNjFzUjNRcHpnWDh5a2o3Ym9UTjU3RUVjakZzaGcxb0tXOGpBRDUxejFZ?=
 =?utf-8?B?UlJCaWQ5dTF3L0hqSGV5NDA5SWhTMU1Vc3Z4TFdxemphNEFsckdlbnk4T29D?=
 =?utf-8?B?N0xOOUdrTkFaYjkrOGVCNVhCckNXZ21xMFQxOE55SmJYNDROdnNWRXdoekkx?=
 =?utf-8?B?VW1TOWtJc3VaeW1hZHJ5cXo3UzRzcjduQTZTaWNkeHpIZTB5eHU1QjNwbVYz?=
 =?utf-8?Q?EARpJgxuEkuwkqMV0mQqKChbUTupsIWEzy5h9wy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5716dfc6-4f99-42cb-a5ef-08d93a20efc2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 10:38:58.6945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2s3zxekmDf/SYqnnYU3eewKq1vQuwoLfEd+pYXBg/GEUU1rkH/UrDj4MeBh2W1gCO377w4sFU+o6bLVY4QLHBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4046
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10028 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106280074
X-Proofpoint-GUID: KfjulYqq6yfhhGFI1asyRkz83mPLZ5k9
X-Proofpoint-ORIG-GUID: KfjulYqq6yfhhGFI1asyRkz83mPLZ5k9
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/6/21 5:13 pm, Johannes Thumshirn wrote:
> Remove fs_info->max_zone_append_size, it doesn't serve any purpose.
> 


Commit 862931c76327 (btrfs: introduce max_zone_append_size) add it.
The purpose of it is to limit all IO append size. So now, we shall
only track the max_zone_append_size in
device->zone_info->max_zone_append_size, which is per device.

btrfs_check_zoned_mode() found the lowest of these per device
max_zone_append_size but it didn't do much about it.

It looks like I am missing the big picture.

Thanks, Anand

> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/ctree.h     | 2 --
>   fs/btrfs/extent_io.c | 1 -
>   fs/btrfs/zoned.c     | 4 ----
>   3 files changed, 7 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index d7ef4d7d2c1a..7a9cf4d12157 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1014,8 +1014,6 @@ struct btrfs_fs_info {
>   		u64 zoned;
>   	};
>   
> -	/* Max size to emit ZONE_APPEND write command */
> -	u64 max_zone_append_size;
>   	struct mutex zoned_meta_io_lock;
>   	spinlock_t treelog_bg_lock;
>   	u64 treelog_bg;
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 9e81d25dea70..1f947e24091a 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3266,7 +3266,6 @@ static int calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
>   		return 0;
>   	}
>   
> -	ASSERT(fs_info->max_zone_append_size > 0);
>   	/* Ordered extent not yet created, so we're good */
>   	ordered = btrfs_lookup_ordered_extent(inode, logical);
>   	if (!ordered) {
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 297c0b1c0634..fa481d1ce524 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -619,7 +619,6 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
>   	}
>   
>   	fs_info->zone_size = zone_size;
> -	fs_info->max_zone_append_size = max_zone_append_size;
>   	fs_info->fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_ZONED;
>   
>   	/*
> @@ -1318,9 +1317,6 @@ bool btrfs_use_zone_append(struct btrfs_inode *inode, u64 start)
>   	if (!btrfs_is_zoned(fs_info))
>   		return false;
>   
> -	if (!fs_info->max_zone_append_size)
> -		return false;
> -
>   	if (!is_data_inode(&inode->vfs_inode))
>   		return false;
>   
> 

