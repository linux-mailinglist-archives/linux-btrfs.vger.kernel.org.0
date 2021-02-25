Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A9732487B
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Feb 2021 02:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbhBYBWa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Feb 2021 20:22:30 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:56268 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbhBYBW2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Feb 2021 20:22:28 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11P1JV0f055141;
        Thu, 25 Feb 2021 01:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=8VrC2wDEJvSJtlmHXqmRXvqQcipGaoHgwxXua3gEYG8=;
 b=Pt8VidWVw3VvkJndFJbsHziaqWv6Wp6md0xd50N+I2GcqaccQFDPBKRp9tPOHWAZ2kNJ
 NEVE4DIU3mLzq3CvoN3gZQ+1+V8+DDjGId0ymEo97gAnXmfPQnSQOEutQnmdv3P9puHU
 C0ZgHHi+crsvzef44UVeDBQD9W+ia7phyGnJMCDhwUW6MAoFyptUXWQBlCKZ8Qwl5fem
 sOZ/5fp3wQ1JDp3RPwQU8jdy+GRmmWJM6Oscu1a0xg02TdpD+VDAzgwYVd/8S/TohCTZ
 NKhWdzQRxO4HJGbmzseoN17lS+GfBkaz6uAsUQdNjGhyedne9Sjt0AZfejPJFntmv7vr Bg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 36tsur4wb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 01:21:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11P1KDwZ166955;
        Thu, 25 Feb 2021 01:21:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by userp3020.oracle.com with ESMTP id 36uc6tuqks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 01:21:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6YFUKGl0N8VsCURQVoL7olTGQmrjFvMzP7n7xqtJhi8kkVSupme9XPmiua6nhSAnFHfW5hxFS66NsdHuY0HCwsk5LzpEGf1+5Ja10J974TN+yr9JJMePlWWIXdeSkmSl9Utk3HFkCR+Pn66lawMdJZmI6GngKeg1QK+cUsDPYA8cHTOGjhtbjLU4HN8rKmr3ojoF6+0wiWl/CfLxwnP077MmCHVDedKqoyohqyMZKda7jff3nVU/gAl1zXDNCHGh64zeJzyCq0VC+eeJlnqCz6SaLrJ+mnE4XFLjDJkF+MDcTdUS2jacjGeQZ5rM/qDsVrOM3af6unbjz/WAyGerg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VrC2wDEJvSJtlmHXqmRXvqQcipGaoHgwxXua3gEYG8=;
 b=NA2QQqxYenXohju7hmPRfJiX+rae2jjM7BXKQgmpUePq2vb4iABb6s+zGrPnsd5aonPPqpKsPqYVQO+BtbH/VOcDVcyZOqL2lUqsSAxPbp5Y6+nxffnB54upC9tjUrHJXWY+Uu+sKVKUgxF1cUTqy4ZGL8AJkYF+xo6ESuIaGVKA3iiBRJuV7b7Ljhm/OUqgYJ9dcTGr9LshT7VBY4iy/ENucMvtQidMnyZSdxeYYN/2AHEP1VJ1o1u0xZHt4Z8G9CfquMR/mMQpaZO55P4YvUEqSl/7tJWMHb/fx4hpgCvXMX/c/Q5V2k57pTaqh/xnH6WGcnB/oc2iZQa7tq4kVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VrC2wDEJvSJtlmHXqmRXvqQcipGaoHgwxXua3gEYG8=;
 b=DjX54UnDUy+OPe35FTIhoMQ78D8CM9CsgVj0gec2o1th8DU78/5KZj2XwEITLN9OG1FGjvtoJVpD9z0sqSvc7VPVFukeiY81L07VnAHHUTUXK8OfmcyMkOAMdEMxyVaaNgVGoKi9fQGdIjrcVdhnCOId2bnkk1STYkFTKKjkqm4=
Authentication-Results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4014.namprd10.prod.outlook.com (2603:10b6:208:182::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Thu, 25 Feb
 2021 01:21:40 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125%8]) with mapi id 15.20.3890.019; Thu, 25 Feb 2021
 01:21:40 +0000
Subject: Re: [PATCH 4/5] btrfs: scrub_checksum_tree_block() drop its function
 declaration
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, josef@toxicpanda.com
References: <cover.1613019838.git.anand.jain@oracle.com>
 <b19539f16f4292749e201032459f5b2686709f0a.1613019838.git.anand.jain@oracle.com>
 <20210212143639.GJ1993@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <d0f695b1-70b9-99d1-9b45-c5b21bc07b42@oracle.com>
Date:   Thu, 25 Feb 2021 09:21:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210212143639.GJ1993@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR03CA0168.apcprd03.prod.outlook.com
 (2603:1096:4:c9::23) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.102] (39.109.186.25) by SG2PR03CA0168.apcprd03.prod.outlook.com (2603:1096:4:c9::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9 via Frontend Transport; Thu, 25 Feb 2021 01:21:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9095d2e0-11a3-4ff0-7a95-08d8d92bb3d7
X-MS-TrafficTypeDiagnostic: MN2PR10MB4014:
X-Microsoft-Antispam-PRVS: <MN2PR10MB40148CF36C6206E9FB89CB57E59E9@MN2PR10MB4014.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MNnrLWi7WMeim1Knoe3LvTZ/h/I4Sy0n9vqeCICO1/YPLgK68bfp8zMrGrlywjam9QVOAaS9lz2uiFip2Qifx3M3i6FyVzMfX5nYbfIFbh8PjmLPuAfkNTAgQ9+4PXy4hMif4pAmZWWc+IqpJLeSMRdXULDFk13bzoIM4B+zHNJYKThdkHRc588/gRdpDmc8BJ8TBwuHPeM44zgj8qW749Js7xyEXpL4zub+QvYj2gqZ6CY1smH6X1bWLlQkYWlnsQnEo4Y+AAmdYnNwRKe31JbkEVQfkYDeGxxkH2FgpgMVzR+aUoo9jF2ikzFZHqSL6kvi5bswtMyhtnVER32MRRAJKoIpswjGGiRLCvWoNSGCUKByJaAG2KAc5iJ+CDmU8yZ099ohSGZF344HjvULakVyDNS50vTcegs8hjdZJ1VJVuMQF8rKSwIn/IPZzn1gSl+jywMGSDMAbbW63EKv0pqNwqO8Bnci+AsXQ0hchHH14qldv1GD11LABYjsztPVhuTkAz2BU/RfQFjpgWz2S8ZHVGpxrg0en7KSayiUurHwBjMhKXN5rJhT4IpnYFf5BhUp1Is2QVbJmttcKSGtqrpg2FXKfA18la8VQ2+RBJc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(366004)(396003)(39860400002)(16576012)(2906002)(53546011)(316002)(44832011)(86362001)(4744005)(66556008)(5660300002)(6486002)(6666004)(31696002)(36756003)(186003)(31686004)(478600001)(66476007)(8936002)(16526019)(2616005)(66946007)(83380400001)(956004)(26005)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y0dvaFRTYnBxc3pYNVpSSUxtNUlXSFpkWVY5cG9qUWMreVZVcEdad2IrMTcv?=
 =?utf-8?B?OFM4M2ZYM29WOXVmSUQxMitBZjdXVWlVM0oyR2l1T2x6RWNsbE1KazVKWkd0?=
 =?utf-8?B?a0E5bzFETGxRaG4yU0NSdjRFK3FsOG9lengybDExNWdxbnlzREVBUGV0ai9P?=
 =?utf-8?B?amQ3M1V4U0JZYmdsMnBZdnBSUG1FN09CNHZGN2pkNGZOanpRNDZoVmN1OGYx?=
 =?utf-8?B?NElzWU9acWZhQ0t6ZmNiQTNtdHV5RldBS2NIYzcya2ZrdXhWeDVCbzlyTTNQ?=
 =?utf-8?B?MjhRUmZwejJpVEkzVnJUZjlNZDNxMFdmYzlnYno0QjZSSE1MMGZqYU1oWDBa?=
 =?utf-8?B?SVJFVmZNSGgrUFBaRkVCdzk3T25OS3k3TGk5WURGQkJlUHhReUYzdktNMmg4?=
 =?utf-8?B?WllPM25ET3IwY0xzK09xOGVXUUN0YkR5cy9IdnZtT3dneEw3S2QwMThWSFNK?=
 =?utf-8?B?Y2QySU5zMWNvZnBtL2hLR2xVWkV1c3pWR0NtRit1bitjeWRPczNxcHpHbE9F?=
 =?utf-8?B?RWtjTDVNbU9qYkU4MXlRVmpTRVlONUp0MFlwUXhpR00rRHhVZ1hTd2ozeVFo?=
 =?utf-8?B?V1pHaGNxQVRvRy9Ic2E0T1N5eXJYNi9NRDVuY0c1R011VXdiZkRQR3JKWlVl?=
 =?utf-8?B?MkRYTFAxUmw5V3l3R2R1MlhnbWFEMlAzYzMzOTA3T2xUb2NIdEc0ZCtyYXlL?=
 =?utf-8?B?VXAzWUFhTG1wc2Q4c1BoclB5RHllaWR6RzF4YitualZRU1NQYURzM3grU0tr?=
 =?utf-8?B?Z1JwWE40U0tTZWVYMm5jLzh1YjRnOEF2dzBuSU5KSWxqWnpvNXI3SXdBL1VF?=
 =?utf-8?B?QzlRM3c0ZTFiQWM1aFgycmtRbEFLVkhCRTV0elV2RlErRGFacXJaNEJQR2Ey?=
 =?utf-8?B?RWswTng3QVVkcXVYM21yb2YzRzFzUE1iSTNIelE3czlFUiswdlBRY095MkZV?=
 =?utf-8?B?M2k4RjNSMTlTSzBZbm1sZXdQeCtucXlDK2Q3RUFOdm10bzhRNllnSTg4ZEdF?=
 =?utf-8?B?UjI5WndnQ3N0OG1TbG8wd1VtYmd4VHdSWXBJTEw5cE5ERDB1TlNyZnZhTWFM?=
 =?utf-8?B?L2tvaGh3K3pOUkdkbldUYjZUbnYvbFNmMU04c0JQUmpyY2M1Y2dWTk91ZW95?=
 =?utf-8?B?eTNDd1E4MkJ6aTBZWFZiSVVXVGZxTUIvSmNnSDJhRzRENWhGZU9YNGxPZVdE?=
 =?utf-8?B?RVVZL3czZnJ1NXNQNlcrRFRJb2ZCdldvazdoWjBJN1VzbE1vcmJPRHBUaG5k?=
 =?utf-8?B?WlJmdzVRUVlxNmo1a0NEaGZlT0JQOFJBOTFZeVF2aWpqR0IvYTlyNUZtUnNG?=
 =?utf-8?B?d2kxUzhXRTMwUDZDeWd1bDRvTVAyN3N5YXJLaVFQdWw1eXVHOWV1WHI4MnBP?=
 =?utf-8?B?QXZLeEswamUxeE5oZXZ4R2dvcHZ5VWRIS3owU1BRUkp1bW9aWXBrRS92ekZL?=
 =?utf-8?B?RThSV3ZlQkJvWW9hdUY5NnY3dkhCdzBqbkd3cjhCcjRpMzhJYy9pSUdSOUN6?=
 =?utf-8?B?b01RV25rOXdBeHRlY1ZkUFU0K09qUmZKWnh6Z0dBQmlwU1JCbWhHbm1FTGpC?=
 =?utf-8?B?VGthVzBjNXZEMUZ4a1kweTZjWVNLdEdSTWY0Q2RVL21MOFc0bFVtLzdnU29w?=
 =?utf-8?B?MXVlRjRGdTZ0MjFkbXFxQnIxTnQxSGYrNld4YnNlR3NObnJSeE9lQmZXQjhG?=
 =?utf-8?B?ejJaOEhKOWpVbVRmdU1nMTlHT0FNWHgvNnJHV2l5OTdjV1lDUHlOZ2w1YURp?=
 =?utf-8?Q?L+n7dvyHEBm8njEyAXIr6YGLHhYJE3ET8Rm6Zk0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9095d2e0-11a3-4ff0-7a95-08d8d92bb3d7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 01:21:40.1440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6jtL0T715CxOldj52GQjcHOxaRRLFnLoBiAJ9flmyJN7xN5u/xZrY6eTAcqzgiIqbA8/HG1ZBMQyWyLvjohtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4014
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102250007
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102250007
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/02/2021 22:36, David Sterba wrote:
> On Wed, Feb 10, 2021 at 09:25:18PM -0800, Anand Jain wrote:
>> Move the static function scrub_checksum_tree_block() before its use in
>> the scrub.c, and drop its declaration.
>>
>> No functional changes.
> 

> We've rejected patches that move static function within one file unless
> there's another reason for it other than removing the prototype.

Ok.
Patches 1-3 aren't of this type. I suppose they will be integrated?

Thanks, Anand
