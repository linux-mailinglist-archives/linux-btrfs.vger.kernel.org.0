Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F176426161
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Oct 2021 02:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbhJHAhW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Oct 2021 20:37:22 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:53412 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231373AbhJHAhV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 Oct 2021 20:37:21 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197NiAuf025313;
        Fri, 8 Oct 2021 00:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=LWBZx7ABC2sM8fK4vaVdFXzjT/Y4268N10qo0k5uc1o=;
 b=piXBZOwZkzUyWlx8nKOkYn7uuIT9hhaSorjZOxBtLRI242b6nwjTr6+txL0VKRUlX8EI
 vjkHAHjgDkEwoxozTyGh2jGpmuQQsAtIkTviftukoIJOq5O3AiYRnWpP9VqF0yf93rq2
 V3OJNsZLcAzVPrf7mR3QwTE+bppo4ZlZmmTSbYXGUsSvYeBpWmWbwcNYs0zZUAN+NlM1
 FDaSKN1IJAFzEJTi/gB+FUTwg7lSWVDzyb93lYO369hS2yqevNBjUEno2oBMqrX0gIhy
 uw0IVEiK6wHhDexX5rguDytUs/iYII4Fw0EOQobtvkHxCXMXvJXTxB9RAGTXK2md7HVD DA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bhy2dd3sq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Oct 2021 00:35:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1980EniQ073823;
        Fri, 8 Oct 2021 00:35:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by userp3030.oracle.com with ESMTP id 3bf0sb3krw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Oct 2021 00:35:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUeME2tkZB38oZUqTbw9CjWHlkHTHdufO43WnDQKh569mQ90wi2WoY64hndEcGdsE+O2lL2+wTUedgg+SCnduWu8SbIZbYBAHLARl3mYkNVzUfDnnntYNKX2DfAlQ22pHl5bMh3DL+jT7zt1EYsl1fElHMvwg3hWXKnEx8dx38WDPhfncQ1qHHMnQIDUDiipA6QjuvbVMcbXodpTlxTfz94UaC7nd2gZVkDDN9vik+uyqHmedwkZ0UYgvVxT8iJGlojgZ5m0hSHvEI9jGTWnZUIAQV0KDI7KlODY32wLATCxpDdzENBmTiRrQndc1YhSNHzZAxAYvWt6gnBo4BMJrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWBZx7ABC2sM8fK4vaVdFXzjT/Y4268N10qo0k5uc1o=;
 b=kmgLNTubipDeKhp0FiRsff6+nAWL+qd9j9nC5loIxC0G20XsXaK1FrRm8mJfM7JIPY6B04jq6c9VBV7fJ4MrXfcMUxgqr+2m4UMIQFIt+VSVI5TFLYBdOn7DQoDcKJcL6bCDF5rbXvrkG9npExtXEsfMuPNUXUk9poBrTEx6xFd9perjRHJuOglOqhDwZXORQNsvjGgLSYxxOknI7eK60htzWGrg/AyEIr50aCkHnNEEkS9TLu6ubGiZsk+kP4UzU3K/wMr28IX3yeYT3LeYbGxQqMatKh8BCPE1EVQLmTtrC5oQcDwJzJ455r6yB2qVqnRTSOVFXKKPJ+y5SHlm3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWBZx7ABC2sM8fK4vaVdFXzjT/Y4268N10qo0k5uc1o=;
 b=EUiYItYDVXcFSy7JHqc6uD9Y8MuTLfHj+nRljoKqkRjiRnLkGz//tJOcFKs52TcRzzdGPf7BnnJzlX52/RIkUGOcwfjslCP/FPArwABBx2CVR438SKv9uzpbddLPQlTeslTDHLyyePlQt7La6b49hwh3BWMgan+SWcIqCi50Djg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4096.namprd10.prod.outlook.com (2603:10b6:208:115::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Fri, 8 Oct
 2021 00:35:17 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4566.022; Fri, 8 Oct 2021
 00:35:16 +0000
Subject: Re: [PATCH] btrfs: Remove redundant assignment of variable ret
To:     Colin King <colin.king@canonical.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211007232716.30456-1-colin.king@canonical.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <8f48a898-55e3-b539-9c4c-19714d827b2c@oracle.com>
Date:   Fri, 8 Oct 2021 08:35:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211007232716.30456-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SI2P153CA0015.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.6 via Frontend Transport; Fri, 8 Oct 2021 00:35:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c6bab56-73ab-4146-15cb-08d989f37dd9
X-MS-TrafficTypeDiagnostic: MN2PR10MB4096:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4096907AE4D2A79B19BE450BE5B29@MN2PR10MB4096.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /VAGZ7dU7zq4CF7HKdvikTbwVzpY5q5yKO72jIjbOUe8A7pWO8P/KJZiT5JQ/wY/bIZ3SUCqj9/bbixo6dngntHJB2sM9Y1Mb5wC2qvu8mYwfJuGwWH3UqbRTza9fMu5Wv7GBtvm5Lmge6m8BLfvdDnsQYGlbvlbl0YZEP5YNCEAOeh5+t91O0dBh5l68g5t8XUq6oCsdrRS8yJauh57iMisHylXptzxgyHv5bdL9762YIcGNV9gRr0JgpvPvsDpyzdgdmkDYmb0eNJoCt70zIMpDAvJKY2K0wj7NajD5ogxXZVWrvGRnBnULrbCSpOJixIIGgyYhcqowm7JwaaKjYFeIkmn/XJHhcVJM4i1X76V3SRahbxubrpj7Ksk1BPbR3vtDBCfBz43L69T+W/l+Xo6P40cZBw1eaCfIEEN69FUYPozb9HoYeV9mT24jRSXGMHRvsbvCucb5/xM7Iow1RrT4c5B+cHOKb6W3RqS2sR1Dvkqu6Zf5DQCdsjhpW879ID17Buy+ehNyQSWb76y7MxZMLWgR4uFshoybrlLsgYDkosufGkFsnKUBMIE/1GlvBc7dLYrmyZofsQRapNHZwIEFObeEFVpU4Zh+nCNl1f+3Hqh6wqn+jAUN7N/aBWeCpLGJGzSAR4AhJXPqA0QKEKsEjUQK7kU4AoVdT41ji2oSk13jWVl6XhIvqVYhDFkM0dDioz80JMW8vrQo4McWx/VgZ6y7D4QXBNIxzTtu7o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(26005)(36756003)(31696002)(31686004)(44832011)(186003)(4326008)(110136005)(16576012)(5660300002)(53546011)(2616005)(6486002)(83380400001)(316002)(956004)(66946007)(8676002)(66476007)(66556008)(2906002)(86362001)(508600001)(6666004)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZE9XZVhVeFJsYUplV0NtQ0NPWWppa2lYUjhsVzRKUkttZWg2N1l6VFJQOWR3?=
 =?utf-8?B?SEFRVkdFOGFmUE1HTG9kdVhnNldLU25DWDFVN1pKUmhZRklkdVFaemZJWjk1?=
 =?utf-8?B?U3pyZ1I4aW90MTQ0RWxwT0lNMFVTejBPUGZ3TlhmYVJJUnB2ek0rTFZ0dDhi?=
 =?utf-8?B?aVR1ZWhad3FLUHp6ZEZBQ0JTTDhmV3k5eGlEU2RYT3ZFeEZLQkM2NmhlY1lU?=
 =?utf-8?B?b1dGQjlnZ1lyeEdpR2o2eUJFKzZ2dXozb0xGNXRidm8zVVAxblJucnZ0WG5s?=
 =?utf-8?B?aTl5a2tRamRZTVhFQTN3dFU1bkFWbURrMnRLemNpSmU4MkI3aUJDa1R2NnJW?=
 =?utf-8?B?TkVJQ1B1UnJrclMzKzJFaVYxMVg0RWh1Y00xYTVRMXlPaHNLb3kvS2Rhenhr?=
 =?utf-8?B?enJKWmxTLzQ5bTNLNW5sbmQwV2JPNkphVjlicmFJb1NHWXVuUHhlZmZjd0Jt?=
 =?utf-8?B?a3N5TXJpTnh6M08wVyt5T1BaZGdKdTVtbGszLzZKblk2TS9weXliTTQ1K1Nz?=
 =?utf-8?B?VXhKeDZSNitwcTVnMXdtVElrWS9yZTJZMmJaZnZkNzR2b0RTbm5GL1VKQ3Y3?=
 =?utf-8?B?YUYzODFUZ1lUTTNCVHB1UmcvcHBkTjk1bVRsMG9sSkFmTW5abWlnZEdVMFEy?=
 =?utf-8?B?SjI0MW0rVkdQOXAya05rSENCby9ha1pDbEZwbFVYelpDUVRic0NSWnVvd2lJ?=
 =?utf-8?B?OHVhY2FSbUkzM0xMTXJ1d1NNZzZNSGdxRkpyS0U3Q3BKUU5rQVZqRGVFejVy?=
 =?utf-8?B?ZFZ6QlZzYTdwNFhPaFVqbDZHM3U2UDhSemY3d1R0b2I5NitITW1xUVlWNkUy?=
 =?utf-8?B?cW53MEhtR1RIb3VKaE92Y3BpdjJzQlNYYXZMNXFhaWgwcHhMd2d6bFFkSzZD?=
 =?utf-8?B?MENGUlUwb3d0LzlqVGl6WE95L1hJUU1JNnNKdEtsNEZrekhsNThqRkcxaU5p?=
 =?utf-8?B?WGJobkhuVGJreWxFMS9XaGFqNmNRcHExclN4UnNHcWhQbHpaaUM2aWJRVjJC?=
 =?utf-8?B?ODRoUnpyU3VRUFFBWHRyVGlFM3hONi9MY0pmcmFBUzloeWZjZ1hyWlZNSGRM?=
 =?utf-8?B?OTRpSWJsSU10eWUyZ1V4c01Ma04xa2xJUCtrY0pwMGw4S2hiNDNzZjBxYzhh?=
 =?utf-8?B?bkZIZ1JkVUpvbUpVaUIvYmNkYnpKRVlQdHowbi85RmtmNldIZVQ5aFpKL1Nt?=
 =?utf-8?B?US9tamFRNDh2eTdFM1pBNEVzS2JQWnF1Z0Q3cE5HODcxT3hqcWFFSGlKN0lM?=
 =?utf-8?B?WEJLSTIzVHVMRTByK1lqRzJIaEo2dGlwbDJOeThmU0tJalNWSlJtV0J4SklB?=
 =?utf-8?B?V0lhWlVGWGUyOXFnOEM5WGpQa1pYaEtUajR5R05uanc0UExmaXFBQTR4Mm82?=
 =?utf-8?B?UzdneHZzRUgxc3pkN2ExV0lyK2tpSjhtMU5PVlpzWDFTUENvSmkyMTBJT1lD?=
 =?utf-8?B?dXI3ejR6cHRMVlpVeWU1RDIxZTJJb1pkTS9lMm9xVWNETlJWbWoxZS95Mlhr?=
 =?utf-8?B?Yzdzc1dXMXgxSnpwZ0ZTTkYreS9ycEFyTjF3WnI1OWJ4NEJ0U2NRTzN1azVn?=
 =?utf-8?B?NWNzU2t4WEl0blpNQlVVMHI5a2V1Tmxjc3c2c3QzU2FBcDdqa0tacE9senVB?=
 =?utf-8?B?bkVXdkVuSmZnTjdzT0pVVnRIS0RYV0pTSzg3QTNxS1duRko0czduT29qd0pi?=
 =?utf-8?B?TjlvUnRXUmRpTkhIRU02Uzh0Y2lTR1lncEg3Ui9yUVQzVXlFcEVCWFpmdy8z?=
 =?utf-8?Q?7Aopugr7sSB6GMMpjFUyk9roRlLSYvyo4XgPrXb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6bab56-73ab-4146-15cb-08d989f37dd9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 00:35:16.5133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ThJzipNtAj/noTRTKwe8p6sFxchul4qDpoPHLE/nNLKkzDl39Ys8M1vQL423nwuHCwyTm2suhZuYqUOsKOICrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4096
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10130 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110080000
X-Proofpoint-ORIG-GUID: HUPDHBuU3YDMoHeY8wuN88GOQRnBcB1u
X-Proofpoint-GUID: HUPDHBuU3YDMoHeY8wuN88GOQRnBcB1u
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 08/10/2021 07:27, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable ret is being assigned a value that is never read, it is
> updated later on with a different value. The assignment is redundant and
> can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   fs/btrfs/free-space-cache.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 8ea04582e34b..2a6d02971357 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -735,8 +735,6 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
>   		return 0;
>   	}
>   
> -	ret = -1;
> -

Essentially we had goto out; when the inode generation check failed few
lines below.  However, the commit a67509c30079 (Btrfs: add an io_ctl
struct and helpers for dealing with the space cache) replaced it with
return 0; and then ret = -1 did not make any sense.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

>   	leaf = path->nodes[0];
>   	header = btrfs_item_ptr(leaf, path->slots[0],
>   				struct btrfs_free_space_header);
> 

