Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168A0394C5E
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 May 2021 15:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhE2Nuq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 May 2021 09:50:46 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41252 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhE2Nup (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 May 2021 09:50:45 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14TDn3lx027275;
        Sat, 29 May 2021 13:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=BUwj74rNyPSJ6YNrI0kQEUCnKTGKNJtwlXj7mH/k37U=;
 b=eqibOSfv4fK6IwqOAZWBmWh1Gwg0JgYvxURR2hnA8r9eN5Nw/8p+sN6QCOXWNF3RPNVT
 FHMxf+W7KiiZkjY+X2K5wbwsF86PJWHCOGzFRqnrNN/hWAEKgv8QaLukm4Hj4rqB5/G9
 qIWWNnMSkyi2kPZTbTmlWpkCOsK7yidhJaf5QkLhMBctxOKqxaLFI51TGn/LcaDb9Azg
 EyEU+y5tHcwWilM/WEkq5909xg+8T8kqjCGdF8P9HXzaLOXdHHHptz7vzTS2R3e6Kx8v
 LH8bP9dpSYghAm1B6T4IwSTI/mrPzrVsF91SHqrKAlpAvwHnzDTJQSzMueb9I/7o3r/T /g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 38ub4cgnbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 May 2021 13:49:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14TDij2K102079;
        Sat, 29 May 2021 13:49:03 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by aserp3020.oracle.com with ESMTP id 38ude2xdf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 May 2021 13:49:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ek48AlQMeT+937vjJ6ikav46+1bGrMZbKXlUGnKVuQI+DXIFHQqFpxpX09TAyMqwBzLKV23KBaAgGfdz0Nga+asn6TS7pgntSwxMaSD2UKPSftOfD+htKFOF9f2OhhtSe75iuvGo0gfTEGUlte8d0u+0c3lQwzLfpItYqPyhm7+i7sBbYRnNiK4X5llJ8O0mmVlS0snGJae+X8F6egqmXa2+hosDAq4MyQbH4RoSQxsoWdO2uMe/V14yDOvkpaFvxfCdz+FrrLM1GxAdrn9kwyhR4RwGfg9pN2/tQ3kc2aEGcXp5XhiBcNEJrLQwKHY70M8unxO1d2Ov9LlLzE0g/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUwj74rNyPSJ6YNrI0kQEUCnKTGKNJtwlXj7mH/k37U=;
 b=L5mV+fdostfIUkBQEya8uKWMTGdQyRbd4JmVMKAsSq0kK5+IhLNCl31FNXsRVD+fRsa0ns+xQqbJFIGAkAqAMnPkbuEJoA3aTdA5VPoN9NT2XUNgGidIbWSCtADVeUP+S2qDgd8l2efubMUK+jOELX4faISoRllbhkOkbYcjkcrPdBUR0N1GpNAgFXaeU8Tywj/pLgTciUcWLmLAaIC1vuW5Sn1CfY5d9uQhAwIoHxLNkVUE+6egyo/o3DENCsI7VLjyAqjgVwzHtU46SxmuxmzO39rAwOFdP77A2YSfMfelmBanaFDVqFbgPFVmTRmGRMZI7dN0x6JB51JdSAwIUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUwj74rNyPSJ6YNrI0kQEUCnKTGKNJtwlXj7mH/k37U=;
 b=qxsQB0SaLM+fRx6YNb0cnWUJJV5hYfxlYryGWCS6sKw8C6IifzijJb5Uu1iQRRCh19ZwJdA/dH+cEnwYhiqW8FlY1g3Bp/axYZWGewynEBMj8eWHYJbfYOYEx43XrSm66cvZXgklABtApycAhqYLe0Wtx3DMs47KCc6w/yKGMbI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3791.namprd10.prod.outlook.com (2603:10b6:208:1bb::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Sat, 29 May
 2021 13:48:58 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%8]) with mapi id 15.20.4173.028; Sat, 29 May 2021
 13:48:58 +0000
Subject: Re: [PATCH 3/6] btrfs: introduce try-lock semantics for exclusive op
 start
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1621526221.git.dsterba@suse.com>
 <9a99c2204e431bc7a40bd1fb7c26ebb5fa741910.1621526221.git.dsterba@suse.com>
 <dc12e388-70b9-1349-1e20-85a7fc60d350@oracle.com>
 <20210528123041.GA14136@suse.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <e17818ca-aef9-36b9-7677-cc49f24ea21e@oracle.com>
Date:   Sat, 29 May 2021 21:48:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210528123041.GA14136@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:f9af:8dd2:386:125a]
X-ClientProxiedBy: SG2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:3:18::24) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:f9af:8dd2:386:125a] (2406:3003:2006:2288:f9af:8dd2:386:125a) by SG2PR02CA0036.apcprd02.prod.outlook.com (2603:1096:3:18::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Sat, 29 May 2021 13:48:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4120702a-ab8e-4fd5-d1b3-08d922a881b7
X-MS-TrafficTypeDiagnostic: MN2PR10MB3791:
X-Microsoft-Antispam-PRVS: <MN2PR10MB379107EEAE7F08959C675E56E5219@MN2PR10MB3791.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: spWwt5NjwOzgMCE4idUkqrf7s6fXtQXQqHEmlYsxFi53iQLU2+V4vqwijqBmirOWaeynTDqiB0b7XKW01xAG8ac0luxbdNDmcqLAaK1TTsMI3hdNcXzogPhcELPInQFSo5LYYLpiTRmMZNkcuNfSAi9CsL7kNEEhN2TbJHOkeTsDGhBCaDU4SNA04NUVJ95M1kX3MjlN9bxlNKFAxbCseIIHaal3KSgdTd+B9eJhwQ4yIDuXP94mZoJLlGaL5zvX6B6ww9hNBRIsZLM004zd0+WlXhOu6+a0jwVEKct9Oxk0vu3IG3/gfSdYMrQCcyWdNAILwujm0UxYRk8+9tQKejkCzGXh9nZ2MD+VWBcp1BR0gFENji32rEeLXDOlTFoKAKuFjOlI0axdQFE6NRWMRmokuYAjlNhscY/w+P4QyHCsIyN3Za7FjChNvl1+nQUwNUyL+6T4D1uct42wG4Q2qCopm58x3FHtx+gdKYoAx4TtAlKIDxJOyDQxcnn12fv2Zb06Ti7H6PMrIrtbpnn+iMhuKUioPwVRqlVdInxH7k1Hc5DNoHfq1b1XMFgv2nGtDeuIaHKAghl2t3o83PzUp6/1X5jT3pBwotYiGW9djL9uYTaI1JnBSPoV2areT8mRVfOr8m0axc8/9rm/dO08QvCaBG17aQ7FpGkpw90FZhIwvkuRIQZjHxx+FG3dXCyhqmA9nFDaGwQaZifgITakhuZkLikOzRa/Gl7MY1fSiJUhOotEM+cRF1yYvtBwCHGtQsKNJE4hrbTB5zWEiSo4lNWmOaJLX1m6cKyInZo80NZtZpsimkVV2exTMYJmcoZLs9x8TAQUsRlVQ0JfS+Ro7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(396003)(136003)(39860400002)(376002)(83380400001)(5660300002)(186003)(16526019)(31696002)(66476007)(66556008)(66946007)(6666004)(316002)(53546011)(31686004)(36756003)(2616005)(86362001)(44832011)(2906002)(6486002)(38100700002)(8676002)(8936002)(966005)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?djcvRG1vdG9zcWVOdVZjQUFpQzlUTDRnUjBsR0ZHaXRTcVdFb0RBZUhReVR1?=
 =?utf-8?B?MlhFYmVCQzcwcHFDelBwclZCcjYzYnFqTDFGZGxsczdMeFVpTTZrQXhrSjht?=
 =?utf-8?B?QWJxVWNCWG9VWFBIMEx6NE10SEU1SGc2RVV0NXErdGdISjBFWnJzTnNmaWt2?=
 =?utf-8?B?NkJIK3lVcWF1eUpiSXluQlJNem9zTkFLem1wNFIrTkVkNHEray9peURLWGFa?=
 =?utf-8?B?WFZuTHd1blZ3dGdFWWxuRyt5T0VZSkJvaTBBLzUvKzZrQ1V4Vmg2QVhwR2FD?=
 =?utf-8?B?MVNyK0VFT0RhUUNiRTZzcUFORm9GdXpqK084N0kxTnpsdW90TjVOdGFUaEZI?=
 =?utf-8?B?UCs2ZkVXc2x6M21ZcjZFZUxaNWFlVUNIQ3BYZkNUeXcySi9VakpSMW4vQkNI?=
 =?utf-8?B?N3g0ZlVhaTIxUVA3K3M4czNkdjFIbzBLekRoWS9UWkJSNTFOTnlvMnpUbEFQ?=
 =?utf-8?B?aEJlcE82KzhmdjJ4QSttaWVVZGZqM3h1NldmbmcydjNvNFRrdXUxZ1F2MzdL?=
 =?utf-8?B?WWMvODl4Z0FPaDc4NCtGenF6UnhWVU12WWkzcXRFRDhaMXpHSW9KVkF3Qk9r?=
 =?utf-8?B?M3RnZnp4VjNZYnQ0RHZPTndKcUgrc0VNTENCa2h5Wlc5NlplQkwreXRlcEtm?=
 =?utf-8?B?NVVmT2ROcUFKNlFtakpQMzNzeFZWV2NZeVpPbXFTckVxZjgxQlM3RkhGOFR5?=
 =?utf-8?B?Nm5XM21FR3Y4Q1ViNnhxajlqbVhqY1BWa2VjYUVaMUlpNnZEd0VLRGJieEps?=
 =?utf-8?B?YVBtcjY4MlNpcjM3dC9PRmpWdXFwYW95SjhtejRVUHFlNmRZbFFSSE1jSUFE?=
 =?utf-8?B?N05CVGRneXl5QW5PMXdtVUthMmM3MCt1TEttWWV0K3l2b1NyV1NIY0dPRkhG?=
 =?utf-8?B?NXQrUzRIM0drZ3FSVHlZUGVNdlZTcWdrQ2owL3pweUFhZGZNQTRZKy9COUpZ?=
 =?utf-8?B?NFRpRWpkVEkrbGdxSFc3QVhiN1FNQ1BkRmlBaTJGbXdEcTVKR3N6Wm0zY041?=
 =?utf-8?B?SVlka3BVUmZMcFg4VFlyVDZmcnpGV0N2bHVvdi8xTmlnbFV2NFlNSE1KZkdL?=
 =?utf-8?B?Tkx0WFQxSGtSdm4yRjlZYWxOcTZqWDFGR1dvZ1lzYkNCSkVURjV5SnFUSElm?=
 =?utf-8?B?bnZDUlhxdy83MGpWYzZ1d2crYStybXNnb0RIV2d3Sk9UVE42YnNhaXBNTnh2?=
 =?utf-8?B?WG5QTzJKYURaelJ5MFJVa1FkaExTZDl6dkEzNm14M0dpZk94NC9JVFJ6c3Bt?=
 =?utf-8?B?SHpyTlJRaTRuMlp1Y3NWQ2lMTmg2M0VtYkp3NGhRMnl0Y0ZBeDVDZHFkVG81?=
 =?utf-8?B?eFlUbVJ4TEVkaEl4T1dyQW9jZEsrWUgvVWhsWTYzbFpieVBWOTRjb05oLzdB?=
 =?utf-8?B?SVlSMkkwZCtibzhBcDNTTGF2QnZTdmRUWThONE5QM0xzR1NsbGoyQUhCRTNE?=
 =?utf-8?B?c05KK09GT1g4V3ZUekQvSnFyMnlTR2IwbGp6WGwyaE5NR3dMWG1iNGY3S1JU?=
 =?utf-8?B?aTZsK2NXdExrVXpsaCtaV1VqaXhXaXhLQk9WYWZ3RjY3UHVQMERWUndtTWJ4?=
 =?utf-8?B?VVp4RmozVjlWTlhKbjh3d3JWVlpCZ1lOWUZodmVKUGlaemRBaHo3SEdIcGM4?=
 =?utf-8?B?c2pNU0orRXZxblYwTnpVNnU1WTZDaGhQcG04SFBHVmt3aStCNFE5RlI0TTZT?=
 =?utf-8?B?RytQVUZuUlVHTVBQSnBZbFIrL3gwOVlVTHhkSFdkdDgydzdsaHJ1OVhUQnpH?=
 =?utf-8?B?V1NXVGRtSnNGVStkMUdvVTloMm1qWFlsOEZZK3I2dUM4NFFqNDdhUUdiNjhI?=
 =?utf-8?B?cFF6SzVuSnZ4TXJSNlZkazhTTDdqNUIxV1o5YUM4ekNYZFdpaWFVM0FrbWRG?=
 =?utf-8?Q?BS+GKK/b778/Z?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4120702a-ab8e-4fd5-d1b3-08d922a881b7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2021 13:48:57.9726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fkhr2tHj/ZcEg+zqq7EyYyg6/N/XNukHcqZeGeekGlukKd1kjkTPbRo4fmS2q1xKgkgInXaBiIfC6l4zE8qu5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3791
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9999 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=990 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105290105
X-Proofpoint-GUID: 6DdUGOpZZXMvsjg4kFfT9-JAGLfoKgot
X-Proofpoint-ORIG-GUID: 6DdUGOpZZXMvsjg4kFfT9-JAGLfoKgot
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9999 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105290105
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/05/2021 20:30, David Sterba wrote:
> On Thu, May 27, 2021 at 03:43:46PM +0800, Anand Jain wrote:
>> On 21/05/2021 20:06, David Sterba wrote:
>>    Nit:
>>    This function implements a conditional lock. But the function name
>>    misleads to some operation similar to spin_trylock() or
>>    mutex_trylock(). How about btrfs_exclop_start_cond_lock() instead?
> 
> The semantics is same as spin_trylock so it's named like it. Try lock is
> a conditional lock so I would not want to cause confusion by using
> another naming scheme.
> 
> https://elixir.bootlin.com/linux/latest/source/include/linux/spinlock_api_smp.h#L86
> 
> static inline int __raw_spin_trylock(raw_spinlock_t *lock)
> {
> 	preempt_disable();
> 	if (do_raw_spin_trylock(lock)) {
> 		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
> 		return 1;
> 	}
> 	preempt_enable();
> 	return 0;
> }
> 
> bool btrfs_exclop_start_try_lock(struct btrfs_fs_info *fs_info,
>                                  enum btrfs_exclusive_operation type)
> {
>         spin_lock(&fs_info->super_lock);
>         if (fs_info->exclusive_operation == type)
>                 return true;
> 
>         spin_unlock(&fs_info->super_lock);
>         return false;
> }
> 
> The code flow is the same.
> 

Oh. Ok, now I understand your POV.

I looked up the document to check what it says, and it matched with
my understanding too, as below.

https://www.kernel.org/doc/htmldocs/kernel-locking/trylock-functions.html
-----
::
They can be used if you need no access to the data protected with the 
lock when some other thread is holding the lock.
::
----

Mainly ...trylocks are non-blocking/non-waiting locks.

However, btrfs_exclop_start_try_lock() can be blocking.

But as this is trivial should be ok. Thanks for clarifying.

- Anand
