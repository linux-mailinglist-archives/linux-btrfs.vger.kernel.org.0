Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B800039127E
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 May 2021 10:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbhEZInW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 May 2021 04:43:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52308 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhEZInV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 May 2021 04:43:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14Q8dr9V068550;
        Wed, 26 May 2021 08:41:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=4UBHmpDVcEbI9CJpiJMIgLOxPMeRsZ9QlwKPvxV67UU=;
 b=FecFZJ5omRVI2NiuZPiLRxPjmrARVDELnW2gBATe4ha/54mGJL8k8sY/zt7ujfwZ26Yj
 QJJqy6ktZLUsJn7SF/TIUQuigzbrOTAdtzhy12AxN1tMEnHxSWkL9Nf5dh4c914/lrIH
 cQRO9EmxB06/uKtLsMDRyhbzupLAa2Ix2wWxJMdalMTkMWDiDflGswZ9/TRr6jUQVQnk
 wHNumCpDcJ7VAhr8vosjz0yJ45ud1/wEs7fv6V9elEI26aM+xKn1DghEAAhxMUfVUnn6
 Qwn7a27zFjoD7sqS/XMVQEtrLcCeCfl3LqlGCmgKRB33R783zdeQGEfv4d2wKYnBOcoR VQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 38ptkp88xd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 08:41:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14Q8aFbM110406;
        Wed, 26 May 2021 08:41:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by userp3020.oracle.com with ESMTP id 38qbqt1u7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 08:41:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWtBrZqVKPiAvs5iJTpbJVtAxyjgRVdXf/h+BvhEPG+c5f8OWeYfMSPXds91pwKlX+SC9IZq9jQZWmbt9IsbyAKOzsRRmX06Mh32IH6e7L4bIAlrIZ4/zH2FmSH31n56xEhW2TChKRHfkW7/l+xTVl3QRZcdDcXFDHagO2SbGWCnH6D+OuIVQECrSkQiNPBA0OTTZq7JbigwxXaoeOdTQaRub6sFHnWds6mJwjQ4upnigK9XKeGJSAWUxVTnhdd0LLLovOPrkiUiGUvDbiyzEqipveEDQUMfhShYlVsD4P+vRGw1QWxi/2UkxX4SVT7ASfTtUO7GLvReyAXRNL1D0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UBHmpDVcEbI9CJpiJMIgLOxPMeRsZ9QlwKPvxV67UU=;
 b=OIz7MkH+C7v1VpSmu5+mNjrOyM9NR8swclKIP7iqIFAFUpcc/scOLAKpbqbcpniT99zbZrO2DSvmI1JxgQR5fXIkCiZUKq+vlaJXEGXaZW1soKIK9SLkM3zXKIwot3+tIlRYQZZraPZjM4mqEGYVnoroHOYRrPGoCdx3An54V4o2RkgWLtOUQglCCSpDIeq6SzqcQnbHkRyw8tr3CDZZzLar+5nvhF1HHSqLF5Y/OXGGtzo7xJ82Wj89xFiHxwQA5E2jV50/KnshQXs3aYqocQCcYC2eG+Y5mWwfS9ArpDRA4QLiYZLqRdjdOxeAexf7ItXOWFmQUpYtv6ldjPJnXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UBHmpDVcEbI9CJpiJMIgLOxPMeRsZ9QlwKPvxV67UU=;
 b=li/GicAN8pQXnmMXl9/UG13OenJY/wgKZMjJenet7by6Gxe+7+2+Qb3rmcepaTPKKAoL6SiX2OjjuPUctCCB5eMZkzFvvzTk5EbM9Ecv114sqJjBHZ9k2It7au4XalC/aRFdxTJgRWZpq5b860a235vw6kHSSQYX18W1lfsPBOs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4046.namprd10.prod.outlook.com (2603:10b6:208:1b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 26 May
 2021 08:41:43 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%8]) with mapi id 15.20.4173.021; Wed, 26 May 2021
 08:41:43 +0000
Subject: Re: [PATCH 6/9] btrfs: reduce compressed_bio members' types
To:     David Sterba <dsterba@suse.com>
References: <cover.1621961965.git.dsterba@suse.com>
 <1a3c6cddd909d922948a22ac1f287293e0deb665.1621961965.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <fe145cfe-e8b9-ca83-5bf7-347db9f49ed0@oracle.com>
Date:   Wed, 26 May 2021 16:41:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <1a3c6cddd909d922948a22ac1f287293e0deb665.1621961965.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:c97e:3e12:797:83c8]
X-ClientProxiedBy: SG2PR03CA0151.apcprd03.prod.outlook.com (2603:1096:4:c9::6)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:c97e:3e12:797:83c8] (2406:3003:2006:2288:c97e:3e12:797:83c8) by SG2PR03CA0151.apcprd03.prod.outlook.com (2603:1096:4:c9::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.11 via Frontend Transport; Wed, 26 May 2021 08:41:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe36bb8a-4d46-45f6-5ed4-08d92022167d
X-MS-TrafficTypeDiagnostic: MN2PR10MB4046:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4046DC521DFC61C9F4FA2283E5249@MN2PR10MB4046.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bgn0rRi+3nZTyojaGc1x5uBicLD88Hi3FJJumfkNQlf1EdmIXP7boICBQRTleNylRkKiNN0tgIJYd+EjI/z5I1mQQsIvOwEf5ng0/b0bW8M07dQ0J3Yzx/AOy83QZuhG4IKpeXfuCKoQgyaGIoBByzBDM6BY+x/ZMiOi3X5ey6KF32vjb02WChb1LFCRQL+T9oQRSIROQk1gDIus4O0iSdeQszfLROFzIteBIRg6FdF9IQWQEJCzrI+WgZF5CsWgqX/wYon/vSyVLP6ZnOpVHBIEixdEkyMtSsJ6oS79QnyoWn0HRIoVdFLd/LUiXDSUq4ofhIHgxKIbPG5k9QUuR2fOhtZuQKqnYIp4pBuagztDN3+PZlJ5d29N66fkKadvmq2YhpwEUDL6wGBYXw48knbAyM12RLGrmAkVgj8r4WIFk21cp3ZWB7hZEZ5n5zKe5CyGAbjKAf6jqYyHtKvKJldR/bjxeeQjq46dZC6uDZUqGIq0ytlsozzOiH3mZQVxXmAIhGRybGuKWH1fFRjio09+ou+/WBA8nPYEtEXQLxtkHc8ZN7sjctWGJkQ8XIXeFGnyW/9V7SaSemNtRZ+gq255tsxdYZpKlrWTP91fnMIavgUGLPOojTIuGSqfVxLAT7KgVPctHjlYxy017r3SK5DmSYZeom6M079bxV6jObV1BNL6SzhTyh2eI5JAf9+eb7Z8E0POGhjymuANTZ755g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(39860400002)(346002)(136003)(478600001)(31686004)(8936002)(38100700002)(4326008)(6486002)(31696002)(6666004)(2616005)(316002)(5660300002)(44832011)(16526019)(186003)(86362001)(2906002)(8676002)(66556008)(66476007)(83380400001)(6916009)(66946007)(36756003)(53546011)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YzdqNDZDMzM4T0ZycUxNcTR3WGJmVjZobC9hMGNhTEN2eVdFL3VPTHVycDZ1?=
 =?utf-8?B?dmM3Y2piUzhDY0ViQWNDYllsSjFyZlloRVhONmI2dUVpZVZ6dGVUOVdSbWRk?=
 =?utf-8?B?enNFUkluWGV0MkhtU0Y2MUE1bUhrMHBQTmU4OERGVDc5M251d0d0T0dXdkdT?=
 =?utf-8?B?aWx0YWtEa1dTUlo0L3psdmFLTy9kNDhJU2dEM0l2UVgrMEtsaFF1NEV3QzJh?=
 =?utf-8?B?Mk1nWURvc1JIemViWDN6b1d3SmhqQmhNMVBsRE1TTzBJR1JFSHhVczNIZXk0?=
 =?utf-8?B?MVlnNXViNkZuRFlNYU1URW1QV1UvQ0pPd3RlV29LdmtuMkt2L1dYeDU2VS9v?=
 =?utf-8?B?ZGpleDNrTjUrRHBsZGpyK3NncUhDUDBGaVdwYjJ3TkpiVnpxTDlzaGkzN1VJ?=
 =?utf-8?B?MVVjUVJ1RkozYmNidUZDTm92L2VxV2tOckJkV3p6ZS8zNkRjR083NjNrUGVX?=
 =?utf-8?B?YlVIZ284Wjc1R3o4eW9tdjkxV2duMVdaM2M3d2N3Z1pJZExsaFdrazV4eFhm?=
 =?utf-8?B?OUVnVDBjcElEamdtb2dDa3FuSkhLYWx3SlpvRnJ2cnRoN3JOcTMxZXNSdk5r?=
 =?utf-8?B?U0FRdTJtMmN4NThLaWh2RmU0bjU4OG1DLzRaY1dFOVltcUpOeHg2VmxLUThW?=
 =?utf-8?B?LzJTWWttNmg0cEV1Q1QvNWlxKzdibGczdTAwK3o5V1AzR0NFTFAwL0FuVXZ6?=
 =?utf-8?B?bk8wOFdyUWE2ZWNXdElrdHZhL2txd3FRaVFhODdYM2p6OFI1YUI4MHdHQWg2?=
 =?utf-8?B?aXA2eG9WWGxPQ2tsRHZRT2NPc3FBYnNvTlMxVituNjdRcytkTU9RWWZsUlpt?=
 =?utf-8?B?eHkyWDRNVVpJQ2JKMWxaaXhNVWJYVExvaFdaNXdQKzFZV2dnTVBHZE9lRnhY?=
 =?utf-8?B?VjRqeWxMOEF3T0NJUU80RU1BNm1VOFVVdXNoL3B4dmNWYjR4Sk1RMmxadjM0?=
 =?utf-8?B?TmIvbkIxV0pIK1BzSS8rVlBJL3JmNWxSMFNkNUlhK1ZwVXRPV2hhTzRLV2ZF?=
 =?utf-8?B?S3hGd2txT2Z1YnkvNGhtY3A2TEpqcGNqVjFFVk9Ob2JTV0I2c3J0WnFnNGY2?=
 =?utf-8?B?Z2ZqbHpicDI0OXBxeFZhZlV5MjhYV1B5VUVQcDVQczYrTFQ1a003K25YZWFH?=
 =?utf-8?B?VFRYMmlNUDZIRWQ2Qlg0Y3VIbzhqV2s0cHBvQ25FOEFtQkU5NjV5QzNvckFn?=
 =?utf-8?B?RWhhYngwU0ZQS2dMdWw0NUhIcXdLNC84WXNhcUtnYkhlbEYrT3dpZHM2aDZw?=
 =?utf-8?B?UjBIN21pV0NmdlROV1VHUWxmUGFTN0J2QmxTWGxqd1ZIaGpsaWU3Zk5rVEdh?=
 =?utf-8?B?dDVKNHlpSkRFRDBzeWc1MUN5NFZCTkVwNnRSR3J4cWRqblgyQjZkRllmTlBD?=
 =?utf-8?B?cTJBOHhhQ0pYWnBRYU5rQm9TbkszTjhxbXFhOERYckJvY3NxWEFHRFBXanRv?=
 =?utf-8?B?SXhnbXlNTytib0dJcXFiemMrbXAvLzZIbFQ4dVl1cXhXRklvZFBVbFpmWG5q?=
 =?utf-8?B?UnJwa0hUd0dwcVFRaXNlWHAySXNmUERlY3RYZFllRGFLbFM2UTlPTiswTXMv?=
 =?utf-8?B?dEhNS3p2NE5HYlN2d2c0TlBBc3g1NzNkUUluRTBrdFFFVGZ0N1ZWVTRXUjFS?=
 =?utf-8?B?QjVaa2ZIZEpVZ0NmNDNWbGNyeS9ZTS9sUjRCSENlSzdsSTY2SitDdkpUcC9n?=
 =?utf-8?B?d1JySHBXSS9kR1o4TlM2RXJiU3dOQVJOZ3oyZ29YektCdXBuQzdaWmQrWllO?=
 =?utf-8?B?U2hMZUJCMHh5RHBDLzNtSDJNTVBjR1YyQ1FBZ0lUQy8zTTYrcjR1RnNuMXRu?=
 =?utf-8?B?ZGVzdC8xVStzRTF4b0tYYW42SVhEVnp3QXphWCs0LzZoUDZVOS8weWZjNWQv?=
 =?utf-8?Q?fkbeAXH1ESHGp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe36bb8a-4d46-45f6-5ed4-08d92022167d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 08:41:43.2199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9cAyxWhkQs0vMeZhkKSR43/6fcXRFtyxUXy47VE0P/y6mY/AnMZCpkdPT/OuNEHXNfsho8PuW7YMMoS5wFUbzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4046
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105260056
X-Proofpoint-GUID: 24H0tialKy7gdMtEmlrhVNc26wmlijMa
X-Proofpoint-ORIG-GUID: 24H0tialKy7gdMtEmlrhVNc26wmlijMa
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105260056
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 26/05/2021 01:08, David Sterba wrote:
> Several members of compressed_bio are of type that's unnecessarily big
> for the values that they'd hold:
> 
> - the size of the uncompressed and compressed data is 128K now, we can
>    keep is as int
> - same for number of pages
> - the compress type fits to a byte
> - the errors is 0/1
> 
> The size of the unpatched structure is 80 bytes with several holes.
> Reordering nr_pages next to the pages the hole after pending_bios is
> filled and the resulting size is 56 bytes. This keeps the csums array
> aligned to 8 bytes, which is nice. Further size optimizations may be
> possible but right now it looks good to me:
> 
> struct compressed_bio {
>          refcount_t                 pending_bios;         /*     0     4 */
>          unsigned int               nr_pages;             /*     4     4 */
>          struct page * *            compressed_pages;     /*     8     8 */
>          struct inode *             inode;                /*    16     8 */
>          u64                        start;                /*    24     8 */
>          unsigned int               len;                  /*    32     4 */
>          unsigned int               compressed_len;       /*    36     4 */
>          u8                         compress_type;        /*    40     1 */
>          u8                         errors;               /*    41     1 */
> 
>          /* XXX 2 bytes hole, try to pack */
> 
>          int                        mirror_num;           /*    44     4 */
>          struct bio *               orig_bio;             /*    48     8 */
>          u8                         sums[];               /*    56     0 */
> 
>          /* size: 56, cachelines: 1, members: 12 */
>          /* sum members: 54, holes: 1, sum holes: 2 */
>          /* last cacheline: 56 bytes */
> };
> 

The following member types of struct compressed_bio are changed here:

-       unsigned long len;
+       unsigned int len;

-       int compress_type;
+       u8 compress_type;

-       unsigned long nr_pages;
+       unsigned int nr_pages;

-       unsigned long compressed_len;
+       unsigned int compressed_len;

-       int errors;
+       u8 errors;

There are no warnings.

But in btrfs_submit_compressed_write()

Essentially struct compressed_bio is updated from struct async_extent.

struct async_extent {
         u64 start;
         u64 ram_size;
         u64 compressed_size;
         struct page **pages;
         unsigned long nr_pages;
         int compress_type;
         struct list_head list;
};

which can be looked into later.

For now, with the patch
  btrfs: optimize users of members of the struct compressed_bio
which is sent to ML.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/compression.c |  2 +-
>   fs/btrfs/compression.h | 20 ++++++++++----------
>   2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 9a0c26e4e389..c006f5d81c2a 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -507,7 +507,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>   		}
>   		if (bytes_left < PAGE_SIZE) {
>   			btrfs_info(fs_info,
> -					"bytes left %lu compress len %lu nr %lu",
> +					"bytes left %lu compress len %u nr %u",
>   			       bytes_left, cb->compressed_len, cb->nr_pages);
>   		}
>   		bytes_left -= PAGE_SIZE;
> diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
> index 8001b700ea3a..00d8439048c9 100644
> --- a/fs/btrfs/compression.h
> +++ b/fs/btrfs/compression.h
> @@ -31,6 +31,9 @@ struct compressed_bio {
>   	/* number of bios pending for this compressed extent */
>   	refcount_t pending_bios;
>   
> +	/* Number of compressed pages in the array */
> +	unsigned int nr_pages;
> +
>   	/* the pages with the compressed data on them */
>   	struct page **compressed_pages;
>   
> @@ -40,20 +43,17 @@ struct compressed_bio {
>   	/* starting offset in the inode for our pages */
>   	u64 start;
>   
> -	/* number of bytes in the inode we're working on */
> -	unsigned long len;
> -
> -	/* number of bytes on disk */
> -	unsigned long compressed_len;
> +	/* Number of bytes in the inode we're working on */
> +	unsigned int len;
>   
> -	/* the compression algorithm for this bio */
> -	int compress_type;
> +	/* Number of bytes on disk */
> +	unsigned int compressed_len;
>   
> -	/* number of compressed pages in the array */
> -	unsigned long nr_pages;
> +	/* The compression algorithm for this bio */
> +	u8 compress_type;
>   
>   	/* IO errors */
> -	int errors;
> +	u8 errors;
>   	int mirror_num;
>   
>   	/* for reads, this is the bio we are copying the data into */
> 

