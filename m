Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748A03457F3
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Mar 2021 07:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbhCWGpm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Mar 2021 02:45:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50572 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhCWGp2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Mar 2021 02:45:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12N6j430135492;
        Tue, 23 Mar 2021 06:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=rf6nYq9L7eb87nhAQJTvNgf/vmgL0gJ94vqJ7g0XJMs=;
 b=Hk8vgG4AHRnwTFsAJNkKROME5zNDrOHHuRAtWS5xGJnQxoqFXAdhxEddtjG2a14Gpstl
 kalTbEztSRMs7gg8NWrhy9/qn3smAy0+4SDFP3YYsp8mG24O26nz2BewLrQ6jwJrzwSY
 +CUxStF/LjGO+BRjPIKMKBPuJBw0kbEzkOWjfqweCw4Wy/QJzTEdduadY8BhB90YBSVd
 o9OYAV7Zv3q5E9KxDZbJ32EWADZzqQQskLbT+kQLxbYeW6iFC+yQVsmHKUQYWyTDIQHu
 NsQ+w6xnNmktojUPcsMpcDwyLam926ARTQUCvx+iHPThZdeyDI7WqWlMa6kDD82U3jOk uA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37d8fr5t48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 06:45:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12N6j7IL036869;
        Tue, 23 Mar 2021 06:45:21 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by aserp3030.oracle.com with ESMTP id 37dtmp46e5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 06:45:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeHq8L5GLDRK0l+6y04i08y/cSwqhvzIs3vckD3jaZI4RmwcbPu9NjAHstUglIu3NMj/V8uPtB+hJ8LllE0zxlQh8FeiQFeb4BfQuN7zzuH7YfLTyasAzSoCGAbZu8UvnLGJUbxTKcdPBWVaZbpGeGLpzL5PKOMfAyBxKqeK0YUga3R9Ov47LJV7Gzk7Ibny6M7EbKQp95+MY/wvq5wQPrCSiiG2hTsu2PtnyZ9A++8PBjcPGKbQkTvENQp+Ke6sky9D8w4NWy3Y3Z+S4pdGX5uxJ3lz1va5PWOdep9u7XPqWmnmHJxizjzMrgfWbPip9BaFAjhEUD71657mc26Vug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rf6nYq9L7eb87nhAQJTvNgf/vmgL0gJ94vqJ7g0XJMs=;
 b=TJ1H+RqYzHpFosIfaLh/0mI5Ldha+Cl+pXX/wlnpGNi1N5YWJ1zc5iHW/YZb+cF+QLE+mGpFy21cI9U4vXKkSKmURqMkIV+uHuXEE/fUz7GJkHsT+n1sX7AWiklqFVOepocc4N7BCvb6dcBit/IIPZzPhjY7eY6c2tY7sqfyTVh0eiUc9NWUkQNlQFZyrFkJnYUEWeVDlaYFQlZsZdzetHldHNFWW/eNhdRNEjzMlTgf2RS1MaOXtPYs1kYDk4uLEQy6gJrRuqberzGJEuptejpVGPwmYfQShyAcm52h2oEzqMv9zVXOENlsSnYDq9F7/1G+ovCcB7ofym9Qr0v+aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rf6nYq9L7eb87nhAQJTvNgf/vmgL0gJ94vqJ7g0XJMs=;
 b=a1V37e0BmafqlpruL0FAdiUK1lBYpVt13RRl8XmQOFzUfm4JIwSrMjw5tjfsqDSxmIYXw59zefMrm7w6JOk13L7GMjHaIRYFRXUEctzbxwSAqp5cyTrXfSZ4/c3h4CpR7wt62OaauLUjloysFS1SpIacYQ/+tBkom9s1n9PuAUA=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4929.namprd10.prod.outlook.com (2603:10b6:208:324::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 06:45:19 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::9aa:6ac:8d40:c076]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::9aa:6ac:8d40:c076%6]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 06:45:19 +0000
Subject: Re: [PATCH v2 2/2] btrfs: zoned: automatically reclaim zones
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Filipe Manana <fdmanana@suse.com>
References: <cover.1616149060.git.johannes.thumshirn@wdc.com>
 <58648eb48c6cb2b35d201518c8dc430b7797bcaa.1616149060.git.johannes.thumshirn@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <f747fac1-fd6d-701f-6c8c-2cf779b3a145@oracle.com>
Date:   Tue, 23 Mar 2021 14:45:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <58648eb48c6cb2b35d201518c8dc430b7797bcaa.1616149060.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:68c2:409a:60c0:e8b7]
X-ClientProxiedBy: SG2PR06CA0219.apcprd06.prod.outlook.com
 (2603:1096:4:68::27) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:68c2:409a:60c0:e8b7] (2406:3003:2006:2288:68c2:409a:60c0:e8b7) by SG2PR06CA0219.apcprd06.prod.outlook.com (2603:1096:4:68::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Tue, 23 Mar 2021 06:45:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb7877eb-2db1-4f2b-39ae-08d8edc73952
X-MS-TrafficTypeDiagnostic: BLAPR10MB4929:
X-Microsoft-Antispam-PRVS: <BLAPR10MB4929497DEE0BA7EE42BA9C4EE5649@BLAPR10MB4929.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Wog0DO7haIQFuGc13DO19VhZe3Q9mCJqWpm7PNB4H+VV6mf53622kA4cMlUjIaGJMokt2smn0BZwoO+DMEz7dX73Tg625xEL7bOTYfYj9TCJlR2MlZASDUtLFxb/8wxsNOMhohPNdPJHUXiUzAcZ1/HZItS7BdtxSudw+RZE5uiQ6ivab/BosF4b7RyU9m27HmVDCVjp+/TYY80OpNOOyyLob8YqujNW641bzjyWgydPruAHNYO1zCQiKRarRL19ix/GPFRkQgpaWCQ5tEw66mZBl/M41P8UuqeLf8JIzdiunuvQHucxaOgWN3jNNaddZcJKT7OKinubBmSewQDtSfACp2I0wUQgtUOAIxRFZ7sbNOAGCno4r0bI2JFhfIrXxs35hID50zsE0ArL28Nx/4UGGIhYT4l3bKBIOIJdSSrZBVryczOePiySmstZ5cbbzT9eMitLLZTGvjLH7OwOd6DiIJOJndOzjuEldp0LIkvEfeHpRYAgwanHrC294rKfV/KMhtdkl6cKdugmOi0s0xxJU2K/gu/50S3nMV409O1+sPpa5Jo00A7q6Fw5FPosQaoHcQxzxxrOnkeVUxlQVXA683ilSKmCO8PR/NVThiOpyC1LdZf9GdXiB77edgWI2BNdYF6xy13Mt9PXqsxbP77x15TkrgIK/tX27PuQXneazHsvKSNy1keYPvWRo7laEuVkXmdtl3eQblRLLAkYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(366004)(136003)(396003)(346002)(31696002)(38100700001)(31686004)(316002)(8936002)(110136005)(66556008)(86362001)(6666004)(66476007)(8676002)(53546011)(66946007)(478600001)(4326008)(54906003)(16526019)(2616005)(186003)(83380400001)(2906002)(36756003)(30864003)(5660300002)(44832011)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VjRYMTJ0MGlPMEs5ekFtd0FZOTBQQ3BUQVZSTWk1YkRoVUk2bDR6NFhvd2pa?=
 =?utf-8?B?WTQ5Ym5RMVRuWkZNZGh4c1FzcjZsL0FRYVQ1S1VpcWJJYzlXcGczMzlmK2R6?=
 =?utf-8?B?dDhnbFBEWk85VUJLbWxLQ090Ym1HWUYyVDk0eE43M0dLa3FaZTZnS1lvNGth?=
 =?utf-8?B?NXhOa2dpZktPWFRJeG5xWW9mQ1V5RzdicmtCaC9XV2JqUkVCSTcvUUw2d0ZU?=
 =?utf-8?B?Ym5oYlV6cTBOQVgxU1hxZmxSMUd5SmFNbExXQmpJQmZtVkZwQTAvNXNEQXBJ?=
 =?utf-8?B?dktzTFRGekowcXljK29SbnJyQURJQS9HckQvNnN3cHdWUkJTdkVMeWgyMGRE?=
 =?utf-8?B?MWNPZ3UvaVlrWldzanFCTjQ4Rmt3Z0NGdDlIUm5hZmdjR0oySnhzUzhFcXhX?=
 =?utf-8?B?ckkxRDlUWVVwVlFNTkFmWFcwamZRdDc2VkxtNXN4SGpialRjZ3U0WkhtalZL?=
 =?utf-8?B?cFI1ZmVEc0J0R1FQaEJKb2MzOUcxMHVhOEpaUmpXcVhBWWxtbVo3VUtHdDR4?=
 =?utf-8?B?bmRGb2M3VUNTUlZCNWk1TXBhcVFDNXV5YzJWWmprQUtPOTZTUkZQZ1g1Y051?=
 =?utf-8?B?bGNpZlpiSW5UaytCVC9aVURWVFNqWnF3QmF6NWVqeHRlUGlsRURKMzY2VTBI?=
 =?utf-8?B?ODhYbStXVm1QZzhGb0U3WmlmdlRhOHgyMVVRUnpydGNtY04wSmlwWWhJNzh5?=
 =?utf-8?B?N081Wk9oOGlKV3VFWFZERk9iT281MVFZUHNMcjA4NDROdElRTjNrTTVCSk02?=
 =?utf-8?B?VEFLSTN6SHlOdlJtejUvOUxJWlRRdXJpOWl6MWN2amY4TGkwVTltY1hwa1Jx?=
 =?utf-8?B?MWFOQnNrWnllRzBDTStNWWlBRnE4MFBZemFqdFY1ZjN3TXJDZERqd1N2MGpH?=
 =?utf-8?B?WkVscGpUYmNZSVc3clhIbG9KaHFOS2FodHVyZFpYdURXck9iZFhUTVBYZjYr?=
 =?utf-8?B?TXZUVlRHRlJOY0NFa01TQ3hiamRXRlgwZnMwczUzUzlHK1VNUHlUUjJicytS?=
 =?utf-8?B?dWJRcVdWc0xuakRTSFNvZ25zVHY4cXV3UXFlN3BCVlhUcnBIOHJkNXRtVUQ5?=
 =?utf-8?B?SnNOcTJpbW5STXZpQ2ZkbUtCNUZVbmNTak1tZzRLU3pkblo0MGVuUE5Cd0Nw?=
 =?utf-8?B?eVhEaEluZUhnd3FwUEs1ODRQN3ZFazFJdlRsUmUxRE9YNkIxQ1VjVGpsT1R1?=
 =?utf-8?B?ZkNBeHpmYjhOTnVMUmtZYndwVnhVS1dVellGMXA0aTF6T3g2aWtJa3loUUly?=
 =?utf-8?B?Z3FnOGJ1NzBqQndUVExub0pSQWM5Ym5ReG1DZHRGQmNDcmRjKzcvZkYzZGtu?=
 =?utf-8?B?VGxUUUg5cmFQbkxDYVowSm12QXBlNWUwN0c5b0xicXFwQlNnWmxkUGlUbkl1?=
 =?utf-8?B?NTh2VzdQOE1Gb0ViYlc4N1ZIR0RzZzlUMUhRRnBQS0hETml4UzBScE5hd0Rr?=
 =?utf-8?B?S2RoRU4yUTdoRXVWU1RCK1hiTGdZY1lENFUxZkcvcEJHNUs3TTRad0l0NG1C?=
 =?utf-8?B?RHIwaGZianowT0d3NlNpLzdkY3BRMWVnekxyVDhMNWRNaC9XRzZkUDlEWlVx?=
 =?utf-8?B?MUR6Ry9xZDJhQ0xIRFY4R1dFZXRvTjVjVEt1TENsa2VFZzM1R1Y2V0J1bXZ0?=
 =?utf-8?B?VjR2bHhsUUlXNFloWDdudkxkZytrZCs0d1cweVFQN3JBcTBtZ241NWl5UmdR?=
 =?utf-8?B?ZlhRQnczbVM0dGxUZjI1YThFT3l4MjcrSzJxM3JMS3M0R0Zpd3JlaDhMSzZy?=
 =?utf-8?B?SThmYi9iNlQ0dzlseGRkd3BzSWpLclI1QTByenFDWFdjWC95MFJjNEQzTGhn?=
 =?utf-8?B?UjB2bXpDOGcrL0ZXbHo2alZOSjBRZVBvYUt3U1YwYkl4UGZhejBYanY3QVYv?=
 =?utf-8?Q?vqnT75yScD0Pn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7877eb-2db1-4f2b-39ae-08d8edc73952
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 06:45:19.0224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbURZjInOtQLJpQG3HnOeoeQyoSkf47IDCzBToSEypjSevTwjIS+MSHqxnNRp4H0NZN6uYts8WwVhIx5B3H0Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4929
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230045
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230045
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 19/03/2021 18:48, Johannes Thumshirn wrote:
> When a file gets deleted on a zoned file system, the space freed is not
> returned back into the block group's free space, but is migrated to
> zone_unusable.
> 
> As this zone_unusable space is behind the current write pointer it is not
> possible to use it for new allocations. In the current implementation a
> zone is reset once all of the block group's space is accounted as zone
> unusable.
> 
> This behaviour can lead to premature ENOSPC errors on a busy file system.
> 
> Instead of only reclaiming the zone once it is completely unusable,
> kick off a reclaim job once the amount of unusable bytes exceeds a user
> configurable threshold between 51% and 100%. It can be set per mounted
> filesystem via the sysfs tunable bg_reclaim_threshold which is set to 75%
> per default.
> 
> Similar to reclaiming unused block groups, these dirty block groups are
> added to a to_reclaim list and then on a transaction commit, the reclaim
> process is triggered but after we deleted unused block groups, which will
> free space for the relocation process.
> 

Still, in the code below, I don't see the zone write pointer reset of
the zone_unusable done here. Where does that happen? Or what did I miss?

> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
> 

> AFAICT sysfs_create_files() does not have the ability to provide a is_visible
> callback, so the bg_reclaim_threshold sysfs file is visible for non zoned
> filesystems as well, even though only for zoned filesystems we're adding block
> groups to the reclaim list. I'm all ears for a approach that is sensible in
> this regard.

All per mounted filesystem kobjects remain visible, even if it doesn't
make sense in some configs. So it is consistent with the rest.

Thanks, Anand

> 
> 
>   fs/btrfs/block-group.c       | 84 ++++++++++++++++++++++++++++++++++++
>   fs/btrfs/block-group.h       |  2 +
>   fs/btrfs/ctree.h             |  3 ++
>   fs/btrfs/disk-io.c           | 11 +++++
>   fs/btrfs/free-space-cache.c  |  9 +++-
>   fs/btrfs/sysfs.c             | 35 +++++++++++++++
>   fs/btrfs/volumes.c           |  2 +-
>   fs/btrfs/volumes.h           |  1 +
>   include/trace/events/btrfs.h | 12 ++++++
>   9 files changed, 157 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 9ae3ac96a521..af9026795ddd 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1485,6 +1485,80 @@ void btrfs_mark_bg_unused(struct btrfs_block_group *bg)
>   	spin_unlock(&fs_info->unused_bgs_lock);
>   }
>   
> +void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_block_group *bg;
> +	struct btrfs_space_info *space_info;
> +	int ret = 0;
> +
> +	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
> +		return;
> +
> +	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE))
> +		return;
> +
> +	mutex_lock(&fs_info->reclaim_bgs_lock);
> +	while (!list_empty(&fs_info->reclaim_bgs)) {
> +		bg = list_first_entry(&fs_info->reclaim_bgs,
> +				      struct btrfs_block_group,
> +				      bg_list);
> +		list_del_init(&bg->bg_list);
> +
> +		space_info = bg->space_info;
> +		mutex_unlock(&fs_info->reclaim_bgs_lock);
> +
> +		/* Don't want to race with allocators so take the groups_sem */
> +		down_write(&space_info->groups_sem);
> +
> +		spin_lock(&bg->lock);
> +		if (bg->reserved || bg->pinned || bg->ro) {
> +			/*
> +			 * We want to bail if we made new allocations or have
> +			 * outstanding allocations in this block group.  We do
> +			 * the ro check in case balance is currently acting on
> +			 * this block group.
> +			 */
> +			spin_unlock(&bg->lock);
> +			up_write(&space_info->groups_sem);
> +			goto next;
> +		}
> +		spin_unlock(&bg->lock);
> +
> +		ret = inc_block_group_ro(bg, 0);
> +		up_write(&space_info->groups_sem);
> +		if (ret < 0) {
> +			ret = 0;
> +			goto next;
> +		}
> +
> +		btrfs_info(fs_info, "reclaiming chunk %llu", bg->start);
> +		trace_btrfs_reclaim_block_group(bg);
> +		ret = btrfs_relocate_chunk(fs_info, bg->start);
> +		if (ret)
> +			btrfs_err(fs_info, "error relocating chunk %llu",
> +				  bg->start);
> +
> +next:
> +		btrfs_put_block_group(bg);
> +		mutex_lock(&fs_info->reclaim_bgs_lock);
> +	}
> +	mutex_unlock(&fs_info->reclaim_bgs_lock);
> +	btrfs_exclop_finish(fs_info);
> +}
> +
> +void btrfs_mark_bg_to_reclaim(struct btrfs_block_group *bg)
> +{
> +	struct btrfs_fs_info *fs_info = bg->fs_info;
> +
> +	mutex_lock(&fs_info->reclaim_bgs_lock);
> +	if (list_empty(&bg->bg_list)) {
> +		btrfs_get_block_group(bg);
> +		trace_btrfs_add_reclaim_block_group(bg);
> +		list_add_tail(&bg->bg_list, &fs_info->reclaim_bgs);
> +	}
> +	mutex_unlock(&fs_info->reclaim_bgs_lock);
> +}
> +
>   static int read_bg_from_eb(struct btrfs_fs_info *fs_info, struct btrfs_key *key,
>   			   struct btrfs_path *path)
>   {
> @@ -3390,6 +3464,16 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
>   	}
>   	spin_unlock(&info->unused_bgs_lock);
>   
> +	mutex_lock(&info->reclaim_bgs_lock);
> +	while (!list_empty(&info->reclaim_bgs)) {
> +		block_group = list_first_entry(&info->reclaim_bgs,
> +					       struct btrfs_block_group,
> +					       bg_list);
> +		list_del_init(&block_group->bg_list);
> +		btrfs_put_block_group(block_group);
> +	}
> +	mutex_unlock(&info->reclaim_bgs_lock);
> +
>   	spin_lock(&info->block_group_cache_lock);
>   	while ((n = rb_last(&info->block_group_cache_tree)) != NULL) {
>   		block_group = rb_entry(n, struct btrfs_block_group,
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 3ecc3372a5ce..e75c79676241 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -264,6 +264,8 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
>   			     u64 group_start, struct extent_map *em);
>   void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info);
>   void btrfs_mark_bg_unused(struct btrfs_block_group *bg);
> +void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info);
> +void btrfs_mark_bg_to_reclaim(struct btrfs_block_group *bg);
>   int btrfs_read_block_groups(struct btrfs_fs_info *info);
>   int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
>   			   u64 type, u64 chunk_offset, u64 size);
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 34ec82d6df3e..0b438b97fed4 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -938,6 +938,7 @@ struct btrfs_fs_info {
>   	struct list_head unused_bgs;
>   	struct mutex unused_bg_unpin_mutex;
>   	struct mutex reclaim_bgs_lock;
> +	struct list_head reclaim_bgs;
>   
>   	/* Cached block sizes */
>   	u32 nodesize;
> @@ -978,6 +979,8 @@ struct btrfs_fs_info {
>   	spinlock_t treelog_bg_lock;
>   	u64 treelog_bg;
>   
> +	int bg_reclaim_threshold;
> +
>   #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>   	spinlock_t ref_verify_lock;
>   	struct rb_root block_tree;
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index f9250f14fc1e..d4fccf113df1 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1815,6 +1815,13 @@ static int cleaner_kthread(void *arg)
>   		 * unused block groups.
>   		 */
>   		btrfs_delete_unused_bgs(fs_info);
> +
> +		/*
> +		 * Reclaim block groups in the reclaim_bgs list after we deleted
> +		 * all unused block_groups. This possibly gives us some more free
> +		 * space.
> +		 */
> +		btrfs_reclaim_bgs(fs_info);
>   sleep:
>   		clear_and_wake_up_bit(BTRFS_FS_CLEANER_RUNNING, &fs_info->flags);
>   		if (kthread_should_park())
> @@ -2797,12 +2804,14 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>   	mutex_init(&fs_info->reloc_mutex);
>   	mutex_init(&fs_info->delalloc_root_mutex);
>   	mutex_init(&fs_info->zoned_meta_io_lock);
> +	mutex_init(&fs_info->reclaim_bgs_lock);
>   	seqlock_init(&fs_info->profiles_lock);
>   
>   	INIT_LIST_HEAD(&fs_info->dirty_cowonly_roots);
>   	INIT_LIST_HEAD(&fs_info->space_info);
>   	INIT_LIST_HEAD(&fs_info->tree_mod_seq_list);
>   	INIT_LIST_HEAD(&fs_info->unused_bgs);
> +	INIT_LIST_HEAD(&fs_info->reclaim_bgs);
>   #ifdef CONFIG_BTRFS_DEBUG
>   	INIT_LIST_HEAD(&fs_info->allocated_roots);
>   	INIT_LIST_HEAD(&fs_info->allocated_ebs);
> @@ -2891,6 +2900,8 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>   	fs_info->swapfile_pins = RB_ROOT;
>   
>   	fs_info->send_in_progress = 0;
> +
> +	fs_info->bg_reclaim_threshold = 75;
>   }
>   
>   static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block *sb)
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 9988decd5717..e54466fc101f 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -11,6 +11,7 @@
>   #include <linux/ratelimit.h>
>   #include <linux/error-injection.h>
>   #include <linux/sched/mm.h>
> +#include "misc.h"
>   #include "ctree.h"
>   #include "free-space-cache.h"
>   #include "transaction.h"
> @@ -2539,6 +2540,7 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
>   static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
>   					u64 bytenr, u64 size, bool used)
>   {
> +	struct btrfs_fs_info *fs_info = block_group->fs_info;
>   	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
>   	u64 offset = bytenr - block_group->start;
>   	u64 to_free, to_unusable;
> @@ -2569,8 +2571,13 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
>   	}
>   
>   	/* All the region is now unusable. Mark it as unused and reclaim */
> -	if (block_group->zone_unusable == block_group->length)
> +	if (block_group->zone_unusable == block_group->length) {
>   		btrfs_mark_bg_unused(block_group);
> +	} else if (block_group->zone_unusable >=
> +		   div_factor_fine(block_group->length,
> +				   fs_info->bg_reclaim_threshold)) {
> +		btrfs_mark_bg_to_reclaim(block_group);
> +	}
>   
>   	return 0;
>   }
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 6eb1c50fa98c..bf38c7c6b804 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -965,6 +965,40 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
>   }
>   BTRFS_ATTR_RW(, read_policy, btrfs_read_policy_show, btrfs_read_policy_store);
>   
> +static ssize_t btrfs_bg_reclaim_threshold_show(struct kobject *kobj,
> +					       struct kobj_attribute *a,
> +					       char *buf)
> +{
> +	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
> +	ssize_t ret;
> +
> +	ret = scnprintf(buf, PAGE_SIZE, "%d\n", fs_info->bg_reclaim_threshold);
> +
> +	return ret;
> +}
> +
> +static ssize_t btrfs_bg_reclaim_threshold_store(struct kobject *kobj,
> +						struct kobj_attribute *a,
> +						const char *buf, size_t len)
> +{
> +	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
> +	int thresh;
> +	int ret;
> +
> +	ret = kstrtoint(buf, 10, &thresh);
> +	if (ret)
> +		return ret;
> +
> +	if (thresh <= 50 || thresh > 100)
> +		return -EINVAL;
> +
> +	fs_info->bg_reclaim_threshold = thresh;
> +
> +	return len;
> +}
> +BTRFS_ATTR_RW(, bg_reclaim_threshold, btrfs_bg_reclaim_threshold_show,
> +	      btrfs_bg_reclaim_threshold_store);
> +
>   static const struct attribute *btrfs_attrs[] = {
>   	BTRFS_ATTR_PTR(, label),
>   	BTRFS_ATTR_PTR(, nodesize),
> @@ -976,6 +1010,7 @@ static const struct attribute *btrfs_attrs[] = {
>   	BTRFS_ATTR_PTR(, exclusive_operation),
>   	BTRFS_ATTR_PTR(, generation),
>   	BTRFS_ATTR_PTR(, read_policy),
> +	BTRFS_ATTR_PTR(, bg_reclaim_threshold),
>   	NULL,
>   };
>   
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index fb785ff53a27..c78b5ce49d47 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3098,7 +3098,7 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
>   	return ret;
>   }
>   
> -static int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
> +int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
>   {
>   	struct btrfs_root *root = fs_info->chunk_root;
>   	struct btrfs_trans_handle *trans;
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index d4c3e0dd32b8..9c0d84e5ec06 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -484,6 +484,7 @@ void btrfs_describe_block_groups(u64 flags, char *buf, u32 size_buf);
>   int btrfs_resume_balance_async(struct btrfs_fs_info *fs_info);
>   int btrfs_recover_balance(struct btrfs_fs_info *fs_info);
>   int btrfs_pause_balance(struct btrfs_fs_info *fs_info);
> +int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset);
>   int btrfs_cancel_balance(struct btrfs_fs_info *fs_info);
>   int btrfs_create_uuid_tree(struct btrfs_fs_info *fs_info);
>   int btrfs_uuid_scan_kthread(void *data);
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index 0551ea65374f..a41dd8a0c730 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -1903,6 +1903,18 @@ DEFINE_EVENT(btrfs__block_group, btrfs_add_unused_block_group,
>   	TP_ARGS(bg_cache)
>   );
>   
> +DEFINE_EVENT(btrfs__block_group, btrfs_add_reclaim_block_group,
> +	TP_PROTO(const struct btrfs_block_group *bg_cache),
> +
> +	TP_ARGS(bg_cache)
> +);
> +
> +DEFINE_EVENT(btrfs__block_group, btrfs_reclaim_block_group,
> +	TP_PROTO(const struct btrfs_block_group *bg_cache),
> +
> +	TP_ARGS(bg_cache)
> +);
> +
>   DEFINE_EVENT(btrfs__block_group, btrfs_skip_unused_block_group,
>   	TP_PROTO(const struct btrfs_block_group *bg_cache),
>   
> 

