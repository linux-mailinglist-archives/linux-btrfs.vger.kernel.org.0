Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F5E3EF93E
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 06:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbhHRE0N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 00:26:13 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:60356 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229448AbhHRE0M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 00:26:12 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17I4G4Qt015563;
        Wed, 18 Aug 2021 04:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rOD4cXVy5ROnLr3gfGhjBwrLIyiZvab9D5Oux43lWkk=;
 b=hU/XyWnYs1CaQI9GmSjcWQOp2GXyE8BQ9CkHDvszHx6UJgRathGGOihY5673wz2VIHFj
 TeAWTraWG69GbTGuLvMAIqwNI6azqMb9RUBQLF1Cj0EpIEdKqw4Vb+2iHdJ5+6C/vmxb
 2Wad7WmOVZmIaIB/wlRWo8HCoy2AjHSvLnrrNN4UwbfcJ/6JIL+r41tb+obNzukykKmX
 dQrykU+COG69Ypr4+QGL6oiXgIeqtMGwoE1ypXZQryUPmCS9Oon1BTf4oG3TIwfdzWvG
 yvsMzJJYVmGyal+suCjEL83u67YVFnJLlJNK9e+qquh6PpCUB2G//riY/D2lk1VIj3zk IA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=rOD4cXVy5ROnLr3gfGhjBwrLIyiZvab9D5Oux43lWkk=;
 b=M2JRIOecvZDn9P3v+aHHqL7OlGXm3Fp/lQp0Hq5bH4oBnVFJxthubdJcwJANkGMT2XoI
 6kdfM9YHBR60TFuuJjnjDekB3SpPQ693bur6QbOrr2UcdSfduQeTwhoqd9vuDlo0PSdJ
 SFSZefPfy32sD9AspADkyCQMpeJK5AvBmNLMBgXKlJy8WJdC0aqrQAQV5bzWvqR6B68R
 URupmJeeHyljxaJWCu7CeUh63xD0ev6qIm4+TlxRKX3lp/C5hIqwA1+yWtqrMUaVHWz7
 3h4rsjWzMUdOhEbiQ0aGbpQKQOR2MrheejlG1f4MiD3J5p877jVx6k2erDyErGkE2q1k 6A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgmbdkc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 04:25:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17I4EnEa114633;
        Wed, 18 Aug 2021 04:25:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by aserp3020.oracle.com with ESMTP id 3ae5n8rd5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 04:25:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6NOAY/GquAfKCYp8Z6wLmMGwSxmnrmgKHQjyIV/hpnvjJkIfpbnBshQcfT00uHcSZTa1LD//rUJOlOn3O8S6rET9wxJkEbY75m8hOlps4fI47Mm20mjaikOuGJWX2SX0+4oOldLuQRgjeltg3pUQ2suuXA0ya1TjqdocflUgCmMnvoACKc6KlYk1Uksp6iBSctBW7cs2FIt6zrwlv0rHUH6ZcOTP14BuQ6WfgOuCbBdlmCCm1/sQjpscG8RLrpcAT6pPB4MnPRx/nnQw7eixuSchcGtTgsHvONEClAjXQ7oNLB2FAKuijCpXjQ+qe+GB+Zqmc5riMpuSkC/RtWq+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOD4cXVy5ROnLr3gfGhjBwrLIyiZvab9D5Oux43lWkk=;
 b=WdML7cydtQzKAaDm8hbEXXVfqxQcCvruRKFNlO1Hj1MkyjcOS3SG5ejZE+j+ZjtBIHXlFLsNrmHReyV4oyiPAUMxC+LYKlDEAC3+1tlDPwGA5cfBG+3CJG88KBLM++V1XKdMuKz1NGkrzCNMpsYZaUk6v+xJo5tWEP5hbbrmIvt5N+LV0lSTs+OOMsZZ4M8N3icIcL/b7s/RkK7zXGnzVwmSE/I3M9r3AF40e6Osh53EWa/hQifbaPw75SM+kOuI0VMrBYZR+x+AQpF7iVwEeJzwAOmc1KHMlRD9JxDWtd+3u5nWN/dRM7ax6aSSAxcKRY/CJJYmEqZPUbAfcasNmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOD4cXVy5ROnLr3gfGhjBwrLIyiZvab9D5Oux43lWkk=;
 b=gsbkodQiRL8VuxDBIXbqcVaGBDiTBDbddbEbIORLK0X+fO4/IzLF9mOqAEryekFWTRppZgtPt4hs6RNzrfPkrraBmFxqUcCimHUWunOnWBOto2PRe9PFkirz1su9Gf0EALAj7lkKZu3QfJ1jZZmGDivTGDhLdSftI4ntxz05Yi0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4190.namprd10.prod.outlook.com (2603:10b6:208:19a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 18 Aug
 2021 04:25:25 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4415.023; Wed, 18 Aug 2021
 04:25:25 +0000
Subject: Re: [PATCH] btrfs: update comment for fs_devices::seed_list in
 btrfs_rm_device
To:     Su Yue <l@damenly.su>
References: <20210818041548.5692-1-l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <ce1a0cc1-b616-36e3-8c58-4edde5f924cf@oracle.com>
Date:   Wed, 18 Aug 2021 12:25:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210818041548.5692-1-l@damenly.su>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0133.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::13) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR01CA0133.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Wed, 18 Aug 2021 04:25:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c136113d-b7f1-4bdf-e40c-08d962003395
X-MS-TrafficTypeDiagnostic: MN2PR10MB4190:
X-Microsoft-Antispam-PRVS: <MN2PR10MB41905137F83A7487B43E3DA4E5FF9@MN2PR10MB4190.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:486;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dhVMR4XpflWA+nRRndJQ5/iDE3ya40MFdLgo66hCzjFiEKN70pcbeehY61e/5IXsqXVRO6O/GkI9jhS6yu6kviFwydelqk1sbDV1H75sdYM23BWGRA7KrRcykZ+yEkM+LlJ3YlLZYKj7FcQM9agL2xlH7FLaANm+c2Kid4j83HQ3skOJoFh3BsedrzesXfq0EiZKoGlKcNG2x3H1R0fjM3g2Ivnm+MZcsIcoA9wF1d79AL7ezizUY2UYlSS2RfizWEEbCF77MbycUmZgY0KDO4nAYXAQ37kWKb6k+aY8hD+bIx3JdtoFvZuiVuRrDu5I97DpZenZhb1ZdoI+nsgLi46EIWYRiDSmzHil1LUNJbyV1gJPIyO+MMjGz00dAFIARfcMkZ3sRgqJxrBV8Pt0S0tFwKjzwXPR9U/Oy9O8rb0ssQGyegXJbGPPsD4NrMmwCl8Ii6+CfFcpxfL9EZbp5Rku1HTMLn8t+iqlGWjkWaY3jrEIm/+6ZMoH1phnOrN49xhFXi9dGqA7KxzFHKL64AinqI1lliQ+IW4PltmJKYEKTTi4/mhIRvqzgqZtlb/Qrw4cdFS8TK1InheG6x8vg0br3AitdC+1/CEfOPtK7bC80o4OvqGe6EGrTDIak7V9ElswOKVfJ429+2JuHwCsJO/MJ4yB+0SF70Rwq7LF7aTKOksVuaonLaJiqhzy9xkrkfj4GLgWgq0rDPRsh7QE5zuqiYqSAgdAI/SgteZbQD4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(366004)(376002)(346002)(4744005)(31696002)(66556008)(66946007)(66476007)(86362001)(6666004)(5660300002)(31686004)(83380400001)(2906002)(36756003)(2616005)(15650500001)(38100700002)(8936002)(4326008)(8676002)(6486002)(26005)(478600001)(6916009)(186003)(44832011)(53546011)(316002)(956004)(16576012)(781001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUM1bzk2UmJvLzc2K2pOT1RmdkVKT1hNWkVRRU9NSXhFMi9qSDIya0diajA2?=
 =?utf-8?B?MW5UZUFnSitld20vRWVOVlFlTVBkY2FPZ3RscFNsZFdvT2pxWFVPdTRjUE81?=
 =?utf-8?B?R1FrZ0VaNkdKeXpJRVJWNDk5WDBGTmtBK090TmFBR0k0MEFjTTNsdnRhM1hM?=
 =?utf-8?B?RWVpMGlOaG9vTzF5QzNoVWxUb1dsTWZSaVFCdnV5d2ZldVNvczdtRDBRNkhu?=
 =?utf-8?B?VVZPQlgzQWVsN1hsakZPelZOc28yVlJ4cE9uRWZrYzU3SUM0Z1BOQ1hRNkUr?=
 =?utf-8?B?R1lBOEl3S3VYZllza1llZE5nb01RL3FWTXJRRTRsUjhTL2lxL3N3VEpwWXB6?=
 =?utf-8?B?VFpVNU9tT1ZWaGh6ZlZwTlBRc2xGa0ZVdnVVN2ozU0VrdmR0eHp5KytXOUpK?=
 =?utf-8?B?TGV5S1dpN1FKM3EwSzFzUkRYTy9MNzBqZGhrT2IvVi8za3hwclpUUWJNbVM2?=
 =?utf-8?B?VUlSczh5M3F2a2JOTmhwckNSZnpwNGt5cmFOamFhcWZjc2JVYXNlaElEajlT?=
 =?utf-8?B?UXZ4bGhOOGdhZUd0aWZ2amZxeWNPRHJyRzlJckZjbXp6L3JvL1ZtZGhDUUV1?=
 =?utf-8?B?MFNndFhOZnFRYS9ESWZ3Zm9TM2xteHZLN0Fnak5GaXcvRmNsVEdSUm1laGo2?=
 =?utf-8?B?OGtqaEJYZ3dCZUNtVUQ4RjRDNmJ2d0hmdktLdmNSYWxXVTZ6WXd2L0tyOWUy?=
 =?utf-8?B?aXR4NGxqWTNJMktkZjF1Zi9ET21tRmVEcmVEblpST2JHMldpZWhEcXkvRUp2?=
 =?utf-8?B?R0NCaDNONVB4bFNBZUhZNEFBNk5EYkhVS3JSaVZSRTFGUnJFWDJFaFJjdkdB?=
 =?utf-8?B?a1lXR1RjRmZzbHMzWVBlYXZKZThYdFM2TCtHSm1maDlvd0MwWGJCTndYc2JQ?=
 =?utf-8?B?REU2eWZaaXV6MkIyL3BGd1VUa0hobnhxYjZaS2NnSWxwbmh2U2pnWE5jaUE1?=
 =?utf-8?B?UjBSYkNJRlNNQmFzblFPUjNhUUh4U0ZOaGtDWFpRZ1NOcXVabVNaTzhxcXpF?=
 =?utf-8?B?bERySWZIbE5LeVBucm5ETVVkMFFZbkFVdWlrdVNRS0M2akNXUlc5YkttSzdB?=
 =?utf-8?B?Q3ZIMFkyUlRhNDE4TWxTUEM0WDdxMDBObXRjM2tYalpxV256M3NlWGtKbGo1?=
 =?utf-8?B?cGYweVZtN1dtYXc1SnhXSkt0eFArUTArT0FEN01McHA2MGdnc2tsQS9rZHhM?=
 =?utf-8?B?aUdwMENmUytwRnM4SGEvZW9EUXdwTUN6WGsvWHZ6NkdFV3lqL3RqNHduZGdN?=
 =?utf-8?B?TzdZY1U4WHAyaElQMng5NHVVNVR6UWJBcUgzaXpRVllZVWhHRG1rUk9sRFpM?=
 =?utf-8?B?UVVVcURFVkJMOGNvRmlQL3NHQUkrNFlMZlRuVkdoWEVEZ1JpeXZUZnlYNjda?=
 =?utf-8?B?R1U5ZjMveVgwS21KdC9wc1hVVEgySktkTjh6d29qZ3VOcDFZSnRBdGpVYmN0?=
 =?utf-8?B?Q01HTE5EZEhtaG5iYmMwc2xDUmZJMTQ2NWJobWUwOTN3Ui9iYXE0aUxBRUw2?=
 =?utf-8?B?bXBVcXlCSC9lZEdqK1pnbXN5K1FWZXhmRWU1UTRoWk1sMktEaWhNajFXZjhM?=
 =?utf-8?B?TlNwbWM3eVhHUmtKckJ6eWVwUXFKdFI4dUtwNzFpeUh0bThiN0dDbTM1MzdW?=
 =?utf-8?B?a1NoS0tuQTYxd1A2ZVRVSDN1bnVFUFRHUVFLaEs4dmY1VytHOTVyQm0xMm9T?=
 =?utf-8?B?SzNZSkhTVEN1OWRLUk5hQWlWT2xXbTlFWUN4ZzJBNXVJRUdTZVZWN0syaGhD?=
 =?utf-8?Q?J5bzuyeEAPaKG4yxUBPcEXWbJA8fHGRFPh+FSbK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c136113d-b7f1-4bdf-e40c-08d962003395
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 04:25:25.6251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MbGNrCpvq937SdDwyoXH+GXTYpg1+1Gsq9ixXySEnqB3bpZOW0bvuvGqp1Fi1qOse/Atx6Er13g7XJlVcCyAJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4190
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108180026
X-Proofpoint-ORIG-GUID: bsTHylL8q3RZ3fEh-4FKoqqwaSGo1mXI
X-Proofpoint-GUID: bsTHylL8q3RZ3fEh-4FKoqqwaSGo1mXI
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/08/2021 12:15, Su Yue wrote:
> Update it since commit 944d3f9fac61 ("btrfs: switch seed device to
> list api") did conversion from fs_devices::seed to fs_devices::seed_list.
> 
> Signed-off-by: Su Yue <l@damenly.su>

Reviewed-by: Anand Jain <anand.jain@oracle.com>


> ---
>   fs/btrfs/volumes.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 70f94b75f25a..fcc2fede9ffc 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2203,7 +2203,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
>   	/*
>   	 * In normal cases the cur_devices == fs_devices. But in case
>   	 * of deleting a seed device, the cur_devices should point to
> -	 * its own fs_devices listed under the fs_devices->seed.
> +	 * its own fs_devices listed under the fs_devices->seed_list.
>   	 */
>   	cur_devices = device->fs_devices;
>   	mutex_lock(&fs_devices->device_list_mutex);
> 

