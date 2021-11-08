Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88EC4447D25
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 10:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbhKHKAL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 05:00:11 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:20074 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233943AbhKHKAK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Nov 2021 05:00:10 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A89CBJW031571;
        Mon, 8 Nov 2021 09:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=08FJGkT7Q4WH8T/jhbFHpI76LCDsOgOGZhyEreabUfM=;
 b=SfeTSNg6YjhDeLgw/sx/wjzRDA2+wq0WtAyK8hMeLg50RkSiDjQnEpG25IBxglv6V+Yw
 yOg70pNYnJcyzo9fvS3UTAKYCusWMzyPD40NnpqZWfVeIXmBTsMWgNH3rd/E4YIFL2v8
 33MDRbQAMakkfP4uBMI9or//PwFOQZCuu2XXJuPIOoFDBUxC4tPvis+U7cUu/9tZIkfH
 vv9y3Qi4WXA2LKBswsLYs93k5GsmifBh05/kV12OVynal/8YdJAIev9ADhz0+P4/HpGh
 mhZUAoZ73ONZUqYKF+WjpwbZXPyT4NxV2s5tzS+7PeDpUi0+VEIpTtn+SOQD9tiI/Ta/ WQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c6usn9q3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Nov 2021 09:57:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A89qCXU087889;
        Mon, 8 Nov 2021 09:57:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by aserp3020.oracle.com with ESMTP id 3c5hh1rack-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Nov 2021 09:57:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVciQkyXY2gVzMIEQ2IytXEErEKqA7/Gnsfjv9EpKx/taONGHLlq8pe9OYtZopjL5Nc4+fWIOK9mDYQj9W50haanlSMpN8xMLnkZ495j0H2ef4XfLbLu3pAeAMI4HWyQMcZBxGFNqJskbnF28/hGzeKg5xDFCVFwovZ1XwWNEbPDEzLv+4VwqQGF3omCoXk7p8aoed4X05L8+4zBHNdzdA2Aus6ttP01Qyp8SIPIhmGOZMtqCzrKT9Nd8OIJcXap6dbnCa16yrcVs+ea1yRF0HOU55tIVdiVkJ9WK7ZusryzBMIunxI5OinPFWsXCd4IlO2xToNJSb7vZyeBANIPLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08FJGkT7Q4WH8T/jhbFHpI76LCDsOgOGZhyEreabUfM=;
 b=CJlRd0bbgmsIDWvm2hM6iM7n4dtfLF6B7MqkS1z3l4/IVwt+aibvISvpReh7q8uRd3ayPdO8v+N8bar+MWIXVEvULEkkWXMnkRs7PvCfLj8jKxpLP8HWyh/pAO5KwPBYzxCxsKsNBBK6yLfjxFPMk4gPbJ1wm/TVKD00vUc+wpp//3emu5+Exr9HgPUibv4wJ5FMdb/ZdxFgHDXs9K2RgV1W6dAVPWaKU2GjBBt6Y+L3syrwdeW/89m7V5om0/zBTUZ7gijNCisepISee1RVvPOwf4D8TeHQPSdk1XfhGvsr/F4tuY9+6iW3dH5vLc00uPgEz9w+7oDsvR6c98SFag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08FJGkT7Q4WH8T/jhbFHpI76LCDsOgOGZhyEreabUfM=;
 b=m1o4VTUF2ibtuvSzNLaGU73ocz8aYzdKcfy1QnSx7yryEPKJSBlo4Ua7GUgoCiWs1VNX59FDhARLnB1TiuGszO/VhUAN5S90yABoGty1UD55IIpOmYAAptbILlr9YsxvhJY3v9NB7tsNSeQ2h9Apullm1mGgnAMAEyJbrBgndfc=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2899.namprd10.prod.outlook.com (2603:10b6:208:78::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Mon, 8 Nov
 2021 09:57:20 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038%5]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 09:57:20 +0000
Message-ID: <e3e4bfba-4007-b317-328f-55c99e3b32d5@oracle.com>
Date:   Mon, 8 Nov 2021 17:57:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] fstests: btrfs: make nospace_cache related test cases
 to work with latest v2 cache
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20211108071440.25807-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20211108071440.25807-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SI2PR02CA0004.apcprd02.prod.outlook.com (2603:1096:4:194::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Mon, 8 Nov 2021 09:57:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1eb148e-2407-43a9-5381-08d9a29e273b
X-MS-TrafficTypeDiagnostic: BL0PR10MB2899:
X-Microsoft-Antispam-PRVS: <BL0PR10MB28997CE453342B713FFA08E8E5919@BL0PR10MB2899.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qlzts/Cxo6l7Nn9nqOjHu3itkLKGV6EhnzZNnb+1dyk81kokYTZfdWyX85mP1HSCvIJG8d1YnoiGdba2tahUfPvURYB/Ts5Q02eZDJp28LCR3dXe20A4V5eWWz1Wbo70HWMB4EclgeIxxqtuCC4fkN/ZpRFVUbA3SFDabehuEDq6y/0ksFYtGmRTyBzM3jRAFOgSASZNtfqliFfvEThT8sxFFwVXb2dk2JqbKpJwh2RUV2/EcMVXg9LjWBhUjPBlF1qWY7mLIFNJIZ1FLMpjH3YmG7A/ujwgvjWoD32H+ZkSMRsPX6WJ+QYr3Y0dwaHmwLjiZWwniy8tZ2yiPU8UxzAI8Lz1Ju/afSBerOPilaHN2rFZehW9LhyadtPBQT54IMITcKKOmNqwQsgLtXcRPLsYFPvRHFlGV7nZM47YnsljhAcGAqzUkYeo42sUh2ZUG8GmOs7mmGUgoTU6QBYh7MT+BR0MYlVvzs5XLRWR0Mg0zDbO0GmWwBQhFahnhMFhgMqwTw468aW/DJNNNjWBHNCelI4j4qHGpWtR6spIa9ACiyrR9qyV0SKLzsqP1J9ljwkpAiBVs8Wty69m1JRPI5Mx8KtBAUgSUnoZuBvjieIVBuQqk87p34Es9LArm0ms9CKEvwd8iUNnAX7IYB8ja9m5RaRIthMgNBmUAyAXgqK/OIZ+706NWuIisQJ32Y65u/I4CkCSras+T+aUCTsAjBaUWGJsXSsEBlU3rw2g6yw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(26005)(4326008)(31686004)(6666004)(2616005)(186003)(956004)(16576012)(316002)(2906002)(83380400001)(44832011)(36756003)(66556008)(31696002)(66476007)(8676002)(66946007)(8936002)(53546011)(6486002)(86362001)(508600001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1JrdUlVUGhZTnR6cDNJMVNIeEJ1NDVZY05OdFZpdFovUFB2YnR2QkNNYWk2?=
 =?utf-8?B?VlMzY0xDYTZoSHNHS1ArZkNMZkZGM0w1S3RQUmVpdjQyQ3E2WFFqSkNnUDBN?=
 =?utf-8?B?eGE4a1FrNWVBY2NWZ1RQYi9yYnRkUlZOVlBpdWM4ZUlnYUp0Rk5IU0pKbVpo?=
 =?utf-8?B?NW1SOTRWRkRNMkM0ZnMwSlByNDB1YnVydFVEUjQ4MjVYYmJwMWJ1THltR3Av?=
 =?utf-8?B?OFFleFg0RXN2aksyNHJYQy8ybUFmcGhodHVub0tpUWtqYTVVV3hyajNwWUxM?=
 =?utf-8?B?OGU1bnFRMEhlUEoyblRhMExvbkw5Z0RnMTI3QkttOFJEK3ZHWllmb1hIY0RL?=
 =?utf-8?B?VXJRb3hvZjZxTU1pSHBxQXhpZXlta3lLQ0VZYlVRS1dhWXNGYUZ6ZkZsRS9G?=
 =?utf-8?B?U3NaeDZrcG45VWtBdG52K0NaaHBCdDJxQjVacnBldGV2MjhkUmFScDE1VDZk?=
 =?utf-8?B?VTNFbTl1VTYyZWJ0SGR6UGEvMDA0ejM5Qlg3RktVYUdrZmF3elIwcmZ5Nzcy?=
 =?utf-8?B?dzNpU1BmejFLbW50TmtxV0xxeXpDdHVtUVRlcS95U3pFaHhWY0lRMUZrZzN4?=
 =?utf-8?B?Q0NPYnVTWTBBZlFhR0ZiVkdmRzZyTldmT2UzckduSUkyY2IyUy9qQ1piZ2hJ?=
 =?utf-8?B?c2N3VWJDS1loVG01dy9uTnV1c0tmTkxITGdlK0kwS3RPbUhoT004M1EyaHVm?=
 =?utf-8?B?L1FnWmp5QS92MCsyYjFZKzBUN3BpTE5ZZml1bWdLSTA4UUo4QmNtU0VPbkp2?=
 =?utf-8?B?czJ5Vjd5Z2tuRGM3bkY5UzJ2dURTd05kTXBKcVVMZVlvMXRTNlU1ZXM1cS8w?=
 =?utf-8?B?QUczZ21MUEhGZmRWMUVOdkV0Nnc3ZXErWjdZaGpjTzl3TlZpRER0ekdtUTN6?=
 =?utf-8?B?VDMyODRUeVE1S2lZUjlUbXlIWElSems5dlhaSnU5M0RsMndvalVrbVBGM2NV?=
 =?utf-8?B?eVRudkcrT1B1RVIxcWVud2phc0lUNnFXYnd3MG9HbTJ0VmttWWUrTjhpaFhX?=
 =?utf-8?B?OU9PVEZoRUExczFub1JZQjZMS1JmMHJ6RVozeitGVldwZVc5MU8zQVIvMVdB?=
 =?utf-8?B?bGtlTDhvRVRkcE5CSDdvV1ZGMTJmT3FIdUV5YjRjaGZRclkrVEgvSnY5WFRQ?=
 =?utf-8?B?QXZpVE11ZFBxVXJJM1RnNmFDNi9TQ29QclJzRkpDZHdIMUxram13S25qcGZx?=
 =?utf-8?B?dHhUckMwNVlvUGFuTHBNazVzTExEUE9YVjc0bjBXdC9OajBnNG00SkRybWdI?=
 =?utf-8?B?WFJ3eFQ4SFV0TUhNLy84UnQvWW5ud2FRdkxmM0pBcm9DcTA1V3VVWVRkbjZN?=
 =?utf-8?B?aUxEengrRFNNYlU3Ty9obDVrWnB6WTR6OGZWNTZoWFUwWVpJUURaY2pRTmdp?=
 =?utf-8?B?eHd5Uk10Zm93alE4eGVsVU5uYmYrVC9JNDBJMmMyamVrVDlrV2VVcTVldEN3?=
 =?utf-8?B?cU9JMWpDL3FXS0ZjVDhOTm5XTVA0SkowMkxrazVTTHJyRkhaVlZPR2NHd0xr?=
 =?utf-8?B?dWtQU3dONEZ5QytIYWFObUlzdTVZaTVOMEd4UktOdi9jNmJpSXZjV2h0Nks4?=
 =?utf-8?B?c3dFSFh4YnRQVS84SEFDS0luVWpXTmVZYTRCN1dmSWdBNWZheTNSRE4vMnFK?=
 =?utf-8?B?b0JzSnpVTHhUaUlJR2xSQTV5WSs5U0pCWVd3dHRxY2RnZ1JEamFJdXNNak5Q?=
 =?utf-8?B?SHFTdnl2dSt1TWJ4eVpEaDZlTzJMLzNWcFBXdVlGWnR5RjIvVk1MQldlZFM0?=
 =?utf-8?B?dFVDQ3RBZnJMZTdHenBOajRtNVNLbFg4S1VNUzFtVVhQMExqRVNHd0dUb0dP?=
 =?utf-8?B?ODluWVYrdHRNbjBBamd3bDRMd0w5TmVBQjcxMytQbi9MWnVFM3NydisyUmdB?=
 =?utf-8?B?bmg4WVFPeS93VGpmK2hKb01BRk9XVFlXaFNyUWJHWFQxS0tnVWtwVXVMNmVz?=
 =?utf-8?B?UWJ0aFlPUkR1TU5nOC8xRTlGTEFvQTRuWk9obHcwK3pLMTB5UU05NHFsU2Rt?=
 =?utf-8?B?VVJabnpiRkRVWTQycXgvYlFPRDFFeGhtR3Fhei9ncGdnRTlWTjhvTE5Qb1FJ?=
 =?utf-8?B?RVdQckFwVHJGTnhkc3R5SWJucGx0a1NSZnJIcHBSR2hxa3FuK3BTcjNNZExi?=
 =?utf-8?B?RHlaaVBQK0hIaFpZTWNvVXdXOXA0S05DRDQwQ3NkcXNEV1lYTU95bTAyaWhQ?=
 =?utf-8?Q?55v2e/lgIUbBsquD+fo4uTw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1eb148e-2407-43a9-5381-08d9a29e273b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 09:57:19.9942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CcyK7v+9P+vfbJNykl2UDXE1ka8SPv3EVRIKYsSoyUgoZsIckZqtU1XfK3sU7em6O24a5ah8MqoefLG9O9vYxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2899
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10161 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111080063
X-Proofpoint-ORIG-GUID: e1s_JcA1H1m1N_6PgUtdMsG5MRsTWyId
X-Proofpoint-GUID: e1s_JcA1H1m1N_6PgUtdMsG5MRsTWyId
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 08/11/2021 15:14, Qu Wenruo wrote:
> In the coming btrfs-progs v5.15 release, mkfs.btrfs will change to use
> v2 cache by default.
> 
> However nospace_cache mount option will not work with v2 cache, as it
> would make v2 cache out of sync with on-disk used space.
> 
> So mounting a btrfs with v2 cache using "nospace_cache" will make btrfs
> to reject the mount.
> 
> There are quite some test cases relying on nospace_cache to prevent v1
> cache to take up data space.
> 
> For those test cases, we no longer need the "nospace_cache" mount option
> if the filesystem is already using v2 cache.
> Since v2 cache is using metadata space, it will no longer take up data
> space, thus no extra mount options for those test cases.
> 
> By this, we can keep those existing tests to run without problem for
> both v1 and v2 cache.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Introduce a new helper _scratch_no_v1_cache_opt() to generate needed
>    mount option
>    By this, it could be more future proof for extent-tree-v2
> 
> ---
>   common/btrfs    | 9 +++++++++
>   tests/btrfs/102 | 2 +-
>   tests/btrfs/140 | 5 ++---
>   tests/btrfs/141 | 5 ++---
>   tests/btrfs/142 | 5 ++---
>   tests/btrfs/143 | 5 ++---
>   tests/btrfs/151 | 4 ++--
>   tests/btrfs/157 | 7 +++----
>   tests/btrfs/158 | 7 +++----
>   tests/btrfs/170 | 4 ++--
>   tests/btrfs/199 | 4 ++--
>   tests/btrfs/215 | 2 +-
>   12 files changed, 31 insertions(+), 28 deletions(-)
> 
> diff --git a/common/btrfs b/common/btrfs
> index ac880bdd..1ed82bb5 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -445,3 +445,12 @@ _scratch_btrfs_is_zoned()
>   	[ `_zone_type ${SCRATCH_DEV}` != "none" ] && return 0
>   	return 1
>   }
> +
> +_scratch_no_v1_cache_opt()
> +{
> +	if $BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV |\
> +	   grep -q "FREE_SPACE_TREE"; then
> +		return
> +	fi
> +	echo -n "-onospace_cache"
> +}



Only some of the affected test cases here already call
    _require_btrfs_command inspect-internal dump-tree
The remaining test cases need an update.

Thanks, Anand


> diff --git a/tests/btrfs/102 b/tests/btrfs/102
> index e5a1b068..c1678b5d 100755
> --- a/tests/btrfs/102
> +++ b/tests/btrfs/102
> @@ -22,7 +22,7 @@ _scratch_mkfs >>$seqres.full 2>&1
>   # Mount our filesystem without space caches enabled so that we do not get any
>   # space used from the initial data block group that mkfs creates (space caches
>   # used space from data block groups).
> -_scratch_mount "-o nospace_cache"
> +_scratch_mount $(_scratch_no_v1_cache_opt)
>   
>   # Need an fs with at least 2Gb to make sure mkfs.btrfs does not create an fs
>   # using mixed block groups (used both for data and metadata). We really need
> diff --git a/tests/btrfs/140 b/tests/btrfs/140
> index 5a5f828c..77d1cab9 100755
> --- a/tests/btrfs/140
> +++ b/tests/btrfs/140
> @@ -60,9 +60,8 @@ echo "step 1......mkfs.btrfs" >>$seqres.full
>   mkfs_opts="-d raid1 -b 1G"
>   _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>   
> -# -o nospace_cache makes sure data is written to the start position of the data
> -# chunk
> -_scratch_mount -o nospace_cache
> +# makes sure data is written to the start position of the data chunk
> +_scratch_mount $(_scratch_no_v1_cache_opt)
>   
>   $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" |\
>   	_filter_xfs_io_offset
> diff --git a/tests/btrfs/141 b/tests/btrfs/141
> index cf0979e9..9bde0977 100755
> --- a/tests/btrfs/141
> +++ b/tests/btrfs/141
> @@ -59,9 +59,8 @@ _check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
>   mkfs_opts="-d raid1 -b 1G"
>   _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>   
> -# -o nospace_cache makes sure data is written to the start position of the data
> -# chunk
> -_scratch_mount -o nospace_cache
> +# make sure data is written to the start position of the data chunk
> +_scratch_mount $(_scratch_no_v1_cache_opt)
>   
>   $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" |\
>   	_filter_xfs_io_offset
> diff --git a/tests/btrfs/142 b/tests/btrfs/142
> index 1318be0f..ffe298d6 100755
> --- a/tests/btrfs/142
> +++ b/tests/btrfs/142
> @@ -37,9 +37,8 @@ _check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
>   mkfs_opts="-d raid1 -b 1G"
>   _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>   
> -# -o nospace_cache makes sure data is written to the start position of the data
> -# chunk
> -_scratch_mount -o nospace_cache,nodatasum
> +# make sure data is written to the start position of the data chunk
> +_scratch_mount -o nodatasum $(_scratch_no_v1_cache_opt)
>   
>   $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" |\
>   	_filter_xfs_io_offset
> diff --git a/tests/btrfs/143 b/tests/btrfs/143
> index 6736dcad..1f55cded 100755
> --- a/tests/btrfs/143
> +++ b/tests/btrfs/143
> @@ -44,9 +44,8 @@ _check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
>   mkfs_opts="-d raid1 -b 1G"
>   _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>   
> -# -o nospace_cache makes sure data is written to the start position of the data
> -# chunk
> -_scratch_mount -o nospace_cache,nodatasum
> +# make sure data is written to the start position of the data chunk
> +_scratch_mount -o nodatasum $(_scratch_no_v1_cache_opt)
>   
>   $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" |\
>   	_filter_xfs_io_offset
> diff --git a/tests/btrfs/151 b/tests/btrfs/151
> index 099e85cc..b343271f 100755
> --- a/tests/btrfs/151
> +++ b/tests/btrfs/151
> @@ -31,8 +31,8 @@ _scratch_dev_pool_get 3
>   # create raid1 for data
>   _scratch_pool_mkfs "-d raid1 -b 1G" >> $seqres.full 2>&1
>   
> -# we need an empty data chunk, so nospace_cache is required.
> -_scratch_mount -onospace_cache
> +# we need an empty data chunk, so need to disable v1 cache
> +_scratch_mount $(_scratch_no_v1_cache_opt)
>   
>   # if data chunk is empty, 'btrfs device remove' can change raid1 to
>   # single.
> diff --git a/tests/btrfs/157 b/tests/btrfs/157
> index 0cfe3ce5..e779e33a 100755
> --- a/tests/btrfs/157
> +++ b/tests/btrfs/157
> @@ -64,9 +64,8 @@ _check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
>   mkfs_opts="-d raid6 -b 1G"
>   _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>   
> -# -o nospace_cache makes sure data is written to the start position of the data
> -# chunk
> -_scratch_mount -o nospace_cache
> +# make sure data is written to the start position of the data chunk
> +_scratch_mount $(_scratch_no_v1_cache_opt)
>   
>   # [0,64K) is written to stripe 0 and [64K, 128K) is written to stripe 1
>   $XFS_IO_PROG -f -d -c "pwrite -S 0xaa 0 128K" -c "fsync" \
> @@ -94,7 +93,7 @@ $XFS_IO_PROG -f -d -c "pwrite -S 0xbb $phy1 64K" $devpath1 > /dev/null
>   
>   # step 3: read foobar to repair the bitrot
>   echo "step 3......repair the bitrot" >> $seqres.full
> -_scratch_mount -o nospace_cache
> +_scratch_mount $(_scratch_no_v1_cache_opt)
>   
>   # read the 2nd stripe, i.e. [64K, 128K), to trigger repair
>   od -x -j 64K $SCRATCH_MNT/foobar
> diff --git a/tests/btrfs/158 b/tests/btrfs/158
> index ad374eba..52d67001 100755
> --- a/tests/btrfs/158
> +++ b/tests/btrfs/158
> @@ -56,9 +56,8 @@ _check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
>   mkfs_opts="-d raid6 -b 1G"
>   _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>   
> -# -o nospace_cache makes sure data is written to the start position of the data
> -# chunk
> -_scratch_mount -o nospace_cache
> +# make sure data is written to the start position of the data chunk
> +_scratch_mount $(_scratch_no_v1_cache_opt)
>   
>   # [0,64K) is written to stripe 0 and [64K, 128K) is written to stripe 1
>   $XFS_IO_PROG -f -d -c "pwrite -S 0xaa 0 128K" -c "fsync" \
> @@ -85,7 +84,7 @@ $XFS_IO_PROG -f -d -c "pwrite -S 0xbb $phy1 64K" $devpath1 > /dev/null
>   
>   # step 3: scrub filesystem to repair the bitrot
>   echo "step 3......repair the bitrot" >> $seqres.full
> -_scratch_mount -o nospace_cache
> +_scratch_mount $(_scratch_no_v1_cache_opt)
>   
>   $BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >> $seqres.full 2>&1
>   
> diff --git a/tests/btrfs/170 b/tests/btrfs/170
> index 15382eb3..3efe085d 100755
> --- a/tests/btrfs/170
> +++ b/tests/btrfs/170
> @@ -27,9 +27,9 @@ _require_xfs_io_command "falloc" "-k"
>   fs_size=$((2 * 1024 * 1024 * 1024)) # 2Gb
>   _scratch_mkfs_sized $fs_size >>$seqres.full 2>&1
>   
> -# Mount without space cache so that we can precisely fill all data space and
> +# Mount without v1 cache so that we can precisely fill all data space and
>   # unallocated space later (space cache v1 uses data block groups).
> -_scratch_mount "-o nospace_cache"
> +_scratch_mount $(_scratch_no_v1_cache_opt)
>   
>   # Create our test file and allocate 1826.25Mb of space for it.
>   # This will exhaust the existing data block group and all unallocated space on
> diff --git a/tests/btrfs/199 b/tests/btrfs/199
> index 6aca62f4..7fa678e7 100755
> --- a/tests/btrfs/199
> +++ b/tests/btrfs/199
> @@ -67,7 +67,7 @@ loop_dev=$(_create_loop_device "$loop_file")
>   loop_mnt=$tmp/loop_mnt
>   
>   mkdir -p $loop_mnt
> -# - nospace_cache
> +# - _scratch_no_v1_cache_opt
>   #   Since v1 cache using DATA space, it can break data extent bytenr
>   #   continuousness.
>   # - nodatasum
> @@ -75,7 +75,7 @@ mkdir -p $loop_mnt
>   #   Disabling datasum could reduce the margin caused by metadata to minimal
>   # - discard
>   #   What we're testing
> -_mount -o nospace_cache,nodatasum,discard $loop_dev $loop_mnt
> +_mount -o nodatasum,discard $(_scratch_no_v1_cache_opt) $loop_dev $loop_mnt
>   
>   # Craft the following extent layout:
>   #         |  BG1 |      BG2        |       BG3            |
> diff --git a/tests/btrfs/215 b/tests/btrfs/215
> index fa622568..d62b2ff6 100755
> --- a/tests/btrfs/215
> +++ b/tests/btrfs/215
> @@ -30,7 +30,7 @@ _require_non_zoned_device $SCRATCH_DEV
>   _scratch_mkfs > /dev/null
>   # disable freespace inode to ensure file is the first thing in the data
>   # blobk group
> -_scratch_mount -o nospace_cache
> +_scratch_mount $(_scratch_no_v1_cache_opt)
>   
>   pagesize=$(get_page_size)
>   blocksize=$(_get_block_size $SCRATCH_MNT)
> 

