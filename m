Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A05332254
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Mar 2021 10:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhCIJur (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Mar 2021 04:50:47 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34380 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhCIJu2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Mar 2021 04:50:28 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1299TKDD100707;
        Tue, 9 Mar 2021 09:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=bJ1LVTCX1/BzpqgFNFem8gPnFzzJShjMY3DwVavT4K4=;
 b=PukKn1c93k+S0cGASMdh2cXLQ9M83RGu7MSTvaXvwFbCmlwGf3mt8yt54SXim3DzXZaF
 u1lQIe88ZvYmSLlCrpm5Oq1PtT+l2h9xJPpJkBjleuA4ygl7oIwhkhTn9FauwwGGLPpK
 8P8DM6SAAW26Iymk3K7/Kx0bfJtFxi2Y7OprH7Hz7FJuuooOWkUXY2g5Bkt9jH7lV7E9
 1A1R7xu8ZaNIqylaMXahAX3vEcX6nBcy/ny/XPc73C5RfObPa/FTAxLe7mHtpSocR0cy
 AVP1qrWv+tcuSjGEcrFduyCxzO0tjNxeX33U8AieIn8Y8Bw7rCCZtXB1jo94cDgafPsv 8Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 3742cn6m3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Mar 2021 09:50:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1299VOvB148189;
        Tue, 9 Mar 2021 09:50:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by aserp3030.oracle.com with ESMTP id 374kang78n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Mar 2021 09:50:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCZvHUPMdEGsICqEex3e1KdbHqrWQW4gneZiklkFH4c0WRbv1kubfJqmyar0RstOXrHwtX45O7IikegOWotGCjKDOm2J2JXLL38g7hAJzC9WOYO3G8vQfYrTBpt7LdpbZpmtmOO4/uurIvZQ8/FjaeTEQwrKjRahK2QF8JxzXHhBZMVYMoI1YZ06vLOq2BGjTQniTzZn1xEf58Ik5DUow5vEypT9HhKA1jIvnDPNxJw9rlDKbbJ63qUdmOt5vzZ6sXI4Td8C42TNbDHKr47ZCpA9MVxrWzeOSBRoVyQTJBUCR3883EEBdYpwjjwaBnVkuLqoG4+AOyLh1ekF47ntiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJ1LVTCX1/BzpqgFNFem8gPnFzzJShjMY3DwVavT4K4=;
 b=mQlBOGGCiWcIfMCr86uuOldu/7DLufkSpnQKZ85n3iamaZtR6gqkMGIIvkfC+EjNcw3NTlB3xdj1BGAwyhj9S9dQ61yewAQ7M294fMCRxRhauKjE/ozaV5DcAtfP18NLy+yxhyPKxITCr9tqrSO9PVz/iRy9S5PaksEitH4TbpS63+Vf3kGLV7LgMikb+lG7cHw1tUm/+xQohTSszUP7JoT78HGYwcQkmR7lIhlMWpTYMHGxUvIF9gCkLBb/mhi8chMzax/eAdMSAqLDxJ+NusrNZDGj0XX4X/IyQc1tcWCb0GM7iJoJtRpo8ARTuMRJGBT9oPyxvPTpjze5vCnjVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJ1LVTCX1/BzpqgFNFem8gPnFzzJShjMY3DwVavT4K4=;
 b=N03rucKgmqXNiIkorR+F9wvyt0wKREOPsI3Ic1jlEy6vWwkUFFe3eUHqN3JmyGxh4vPYq1h1LK7LEb/BQZaYPdz4+N1muJFpnSUppytu7f4QkZ1w+YmTLKRQPbHbVFmDFeLIjj8kM/h588XTzR0obk41ehIurcRh9+y0Wuj360w=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5139.namprd10.prod.outlook.com (2603:10b6:208:307::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 09:50:15 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125%8]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 09:50:15 +0000
Subject: Re: [PATCH] btrfs: turn btrfs_destroy_delayed_refs() into void
 function
To:     Yang Li <yang.lee@linux.alibaba.com>, clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1615282374-29598-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <6a9300f4-2a28-5faa-a4f8-d39b9c300413@oracle.com>
Date:   Tue, 9 Mar 2021 17:50:04 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <1615282374-29598-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR0401CA0012.apcprd04.prod.outlook.com
 (2603:1096:3:1::22) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR0401CA0012.apcprd04.prod.outlook.com (2603:1096:3:1::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Tue, 9 Mar 2021 09:50:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1444d0c8-911b-4da3-2ac5-08d8e2e0bd18
X-MS-TrafficTypeDiagnostic: BLAPR10MB5139:
X-Microsoft-Antispam-PRVS: <BLAPR10MB51395369D1A2B1B5FB280F2BE5929@BLAPR10MB5139.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:113;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jUpZCQ3FQukC38Jbw0r+7FqMwQY8SGvrhqpB/QFZaEbgJAJwXstW84GctKXaRppQPFmdunDRCRJC0yh7GGOUuJKi0TuAAPrlZ/yMxcIDoJijSxCKB993kIhklIH2R/9yAr229kMYECoTYAgw+Pki+eDWT8XUjk5WXDKyWD0yBhC2t6MRdHgM1IliLWMWEmxdH9rjVecx7HGswbbGicl0FW+uydnTdA9peZNGMCnK3FyD75Ug3M0UPNFeA2tpM1k6wXuwEVtiR/rWCH6IfhIlaKptw0u83lRPU8IKnFqkAD0BJbUx1AgSs+vRIOtCnOTCYL3GOHUUB1kB6PR32d39NItKSL+mBdmI4Xjr2gbcyOaPTQk5a6dDNrVMzLqbP6x+Fycj8eL9gQa24kfOo+QuQJkRqXBT0GlMyq3R5VGwSVSNe58YhL1uZRhQwZd1fxPoRZM44DMdqYDRKSiYJ4ynkKDz69v2qNZtu9uKWGHvlEfEayqYQMZ2ciDPcBzWLo/kgAwHnZoBTCI5ICZcRuv7xxi8/mYAH7U9h7sYlON0VJ71hEFfEHXQpdh2TTTGS729064Nl3fKqH8DXc7NiGkjZjLnH+FK/d/FB0/Ki1AJ1tg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(376002)(366004)(39860400002)(8936002)(2906002)(316002)(16576012)(66946007)(66476007)(8676002)(2616005)(4326008)(44832011)(6666004)(31686004)(956004)(5660300002)(478600001)(53546011)(16526019)(186003)(36756003)(6486002)(31696002)(86362001)(26005)(83380400001)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TUlSNTRVSWQyMDF2QVh3NHJIL0lGVCtwS3lTWnhTZEpTUmhMY3MyNElxU0F5?=
 =?utf-8?B?S0hyQndaSk1QenBtWG04ZDNuS1hyblo1R2tPWWs1UlRSRTU3blNyYlkzMFYy?=
 =?utf-8?B?NU9TQnlhcUlKV2hzaGM0QURlYWVBVUtDUElGUjdGL1VGSkUxV2hRemVTMmpy?=
 =?utf-8?B?TVoxTlRETWI5MFNGQ0xmOXdxM2xwakRKQnZKdTVWUnhDejNUdFJmSkxpRnJh?=
 =?utf-8?B?WmxySHR4K3NjMHduMUtJSks3bFY3dTdnOEM5MWNzM1pvaVRWWG1iSXRQbU5R?=
 =?utf-8?B?eHRPcDhYbTVHUG9qOUVGc2F3TFFyTmRwajJtU1I4d2pleTdxbjJSMXViN0hh?=
 =?utf-8?B?VlFmY2R5TDFUSzhWS3BhTUF2MXRLeEtpV2toY2dpeFlxT3pGVS9RZkRrQUpY?=
 =?utf-8?B?QitIS1NaYzFlK0lTeU5aUExmNlVrbit3WXl4QVhzK3pnUUtkZnIxZ0FVYy9C?=
 =?utf-8?B?Sm5jM1lJWHYrZmZORzhCR29qTjk3WmZkQ29vcU9nZHFDZnl1Um5BR0UySE12?=
 =?utf-8?B?dVRZazhabU0rZGtncFpBeHphWk9KSjdKVSs2b2N4YzNmVEZWWDB5V1N5eDJB?=
 =?utf-8?B?QmF3ckxSQ3hLbVQxNThvcGZZNjJrQ0pRVHkrQWM2RGhRbGlWVURtV2JiTjVt?=
 =?utf-8?B?QmFHMUFobmtoYnEyRzdsbm0wSEJmMmlDOC9VbWhCZjRHQ2pTY3dlYXVxSi9y?=
 =?utf-8?B?WEpCYktoZnlWRGlQZnFGQjg5Y1RGek1qWDRtWUUvdGJWWjBxT1hwOEN2NWtL?=
 =?utf-8?B?M3BIS0gzRElOSkZDcFZqZDcvOEJrNDUvSW8rbGhBWWRvVjNHN1d0ZUlyQVFk?=
 =?utf-8?B?S1BnMWxLWmdYejFrVHNDazB3UjI1M1BRUHFMVmI4c1c5N0lrQWE0NFhzOUhH?=
 =?utf-8?B?a3lRY1BDUVZZanJvY1dCZ0RHWGkvaEI4RTB0NmRDeEp3a0wzc2kwVlNxcmRV?=
 =?utf-8?B?NUR2Q2RHMmY4b1F6dUNDd3F3S2Q0SVNXODZvRVg1OTNWdkRkTHh6eGs1bjdS?=
 =?utf-8?B?VFNuSUlWWWF0T1J3Vkxod2t1c010VWdtZnhUemN6N0JKUnBCbEJjNkNUbCtH?=
 =?utf-8?B?aUhXS3NobUNhMWZpVGR4SUZxSG54eHQxYVRZVXpLeHN6R2dzeHVrNWVpQVEv?=
 =?utf-8?B?ZkdmS2FyYm5JcEhwQU54Vkw2YXNtS01rQlUxcks1ZHpUZnl6eUhhbmxUUG1P?=
 =?utf-8?B?QndKSmZOUjFLczUwcDFjS0t5RXlzS1gwSzhPMlc2M3lTTXo2eklQV09ZS3lD?=
 =?utf-8?B?TkNVMXlHdE0rTGo5cXdFeVBOcDZlQlVib1RTY2lnbUlZUnFJNWhzeEFjSlBE?=
 =?utf-8?B?ZENHVzdKSVlYSmFWTTlKdVczc3dPY1BZbE4rQ292ZG9hTTRubjhIODRETFh3?=
 =?utf-8?B?VUEvL1JKQWNBYmp2djZDdGFSS2wvR2hEclNwdW9jV1RqNUkrT3VReE5aUXp6?=
 =?utf-8?B?eEpsaGlRMysxK0xvTVhMeVZTN0crRTFNQ3ZLQTZjRUxHZXU3K3hLMnpqWnhS?=
 =?utf-8?B?UVFzdkp4MkdKWWNkVHpDQzVjcHNtdDVqbHV1TWl1cDMyM3NIaWNwV1ZXSXFt?=
 =?utf-8?B?SkJHaDREOFUzTHFCeHdZSTR3UTE5eldiL0ZzNzUxWmM5VEFrTWdCT2RtTUJq?=
 =?utf-8?B?QW5ZclMwWVB2WHdxSitMQjhXTVU1YjdaRCtrS0N3VndjZDBJa3Rkc1JtOVdO?=
 =?utf-8?B?dUpISjFHNmRYS2FEOGtMM0FUQ1llM0dBYVRzTDgrUEZ2Y1RiTS90dnFNcWVs?=
 =?utf-8?Q?MdmGnhENRAnRFG/nY69hIz6q10bqziACxpJTfuI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1444d0c8-911b-4da3-2ac5-08d8e2e0bd18
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 09:50:15.2231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ht0PEMdmNzktpz3TVzaFk/dlm6HbBbXaEbtiU0MW25X/kDhoewdR2HgZimm92uAnqyV7tJmLbXg+lSuPXogREw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5139
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9917 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103090047
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9917 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 clxscore=1011 phishscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103090047
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/3/21 5:32 pm, Yang Li wrote:
> This function always return '0' and no callers use the return value.
> So make it a void function.
> 
> This eliminates the following coccicheck warning:
> ./fs/btrfs/disk-io.c:4522:5-8: Unneeded variable: "ret". Return "0" on
> line 4530
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

> ---
>   fs/btrfs/disk-io.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 41b718c..b75d2d9 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -52,7 +52,7 @@
>   
>   static void end_workqueue_fn(struct btrfs_work *work);
>   static void btrfs_destroy_ordered_extents(struct btrfs_root *root);
> -static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
> +static void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
>   				      struct btrfs_fs_info *fs_info);

  A nit...
  The declare here can be removed without moving the code.

Thanks, Anand

>   static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root);
>   static int btrfs_destroy_marked_extents(struct btrfs_fs_info *fs_info,
> @@ -4513,13 +4513,12 @@ static void btrfs_destroy_all_ordered_extents(struct btrfs_fs_info *fs_info)
>   	btrfs_wait_ordered_roots(fs_info, U64_MAX, 0, (u64)-1);
>   }
>   
> -static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
> +static void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
>   				      struct btrfs_fs_info *fs_info)
>   {
>   	struct rb_node *node;
>   	struct btrfs_delayed_ref_root *delayed_refs;
>   	struct btrfs_delayed_ref_node *ref;
> -	int ret = 0;
>   
>   	delayed_refs = &trans->delayed_refs;
>   
> @@ -4592,8 +4591,6 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
>   	btrfs_qgroup_destroy_extent_records(trans);
>   
>   	spin_unlock(&delayed_refs->lock);
> -
> -	return ret;
>   }
>   
>   static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root)
> 

