Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708735B976D
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 11:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiIOJaE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 05:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiIOJaD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 05:30:03 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70058.outbound.protection.outlook.com [40.107.7.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71F213F6D
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 02:29:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEwSqhh5Qx/QbRXxijPLhbG6IHW4z90//AwqFHsPa6HfHNY/Tp/3OCMR/RDNmx4jroqFZCGyRIPNiQgtWp8vx/465PqxCy6jCHVdWGk56+znAd7vVKBK1BPumvv536yCV1pzzu4RaqoqZMNHjUzGn8NYnytQp1qMID72uqFWb5t08KVGrRdmNQAqMYdFP6YJA66kYQ4vyB3zNTNUWz4R4Tup5Q7nNogvQ4LBe1EGyvVKbEMEwL/qXnpFdafFx6JwMr1nvXg+4H/EH5870CAvE1hTN/DgvI0hbKSr9Hd3ghepjVGCNvSPH/ufNsxrVTw01+BLZF+kIhmA4iB//Yua+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSSegyHy7RTCXfvYMGiN7kh+beFF6Bd7wVFWMtMMivM=;
 b=kFYd3JXaunLPkafc8hymzHKDvugkFKc578yujBK/k/j1xapc2Ox+4uAIbHBO+1R033ZDMk1zKH4N971O6zh/00YHiSXC+eDa99DdVWiVO7lnA6+0GLQmNa0cSzT7TX/Ym1slXQ0mM+xutSJR0QriOi6IsCKpXYYdsQ4EA9g3RLtv/99wetO5dJ3uLeGfSmJ/u2bpA4XQcsgBH2Lq5f7VwqOreydzxaXivTw5oGBo2ka5xzanORP6jW3dAIhkberOW3iYO9AdqIELoc4u1SfK2bax5BAtEBrvlEeM6cj0rTYvZ5PMJhQ9xEgbgYUtjfqhtwAX/YJRUc4V2jIpnYHvEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSSegyHy7RTCXfvYMGiN7kh+beFF6Bd7wVFWMtMMivM=;
 b=XuOoQxqG97lML8r3BDVgISqSsD03PV9HndgmxHWcka3bjw0gWTsD+LxJBmxvyy+1dDLCZjv77u87tWGDpzCE8SjycLbuaqU0OhuEbHvQe4MeGBP5wD68GACHKHf0M5kW/y3bihevL+gnHmKYMjtZW3J9QaUNu0vOEj9bZj5lfEhjzThh9MoPw/65pIqbPjYaLlQnjNjL36s6xCY1RcpjcJa6L/z4FmpP7nOSK+MInI4k/I/gzK1KDD0bKJzcRWKMcCCMZ6PrJEmScE95rLD6vuK3qZkDH4316vF1AM7IHJsGswWTB57La0UUTLYkcypSkNUeMbnmYWVL5YWIYYYikQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM7PR04MB7032.eurprd04.prod.outlook.com (2603:10a6:20b:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 09:29:57 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9%5]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 09:29:57 +0000
Message-ID: <5cefccd0-72fc-94fd-7eba-e27195c817a5@suse.com>
Date:   Thu, 15 Sep 2022 17:29:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 16/17] btrfs: move btrfs_next_old_item into ctree.c
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663167823.git.josef@toxicpanda.com>
 <6b4e55458868b7d8f7b61be137fe9f9d7860dea1.1663167824.git.josef@toxicpanda.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <6b4e55458868b7d8f7b61be137fe9f9d7860dea1.1663167824.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0722.namprd03.prod.outlook.com
 (2603:10b6:408:110::7) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AM7PR04MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: cb958762-092a-41d8-4f1f-08da96fcda89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mokJN/7dlHNtq03nTgRUj2E+yaMWwyX9jRP72OmqdDsh8JhsXvZF5ZHSVXTYcUsT9apxKahk5zxxHVEo3P/Ie4nG3pUQfxZFPvnoSl+Awo+fiR4dVo/4NObQtlKiT2yUCPYwROjV/lofz1mWKr5brboo+9HgIh6FJLq9uLX5Ao/BdQtWcJrxWZRvgPWcxIQH9cBb+Xm7W1gMJ1OaQGeFCSrqq11pZDn/JwoZz3gKSG1eNhsAWzC2bBqGUhM9id/jpex8/BG6sIpNXLlxFfZuJ4a65xESwDRnL42oJlaHssjOlyZfJteId+9rFjnXSInCXG5GhOophx/1BiIrD6lGdzjPLd5t+2N9XQUoCYtCkCGIuxRC9be4zH94ZGBkglOdhMqfCX+cbt+aOUwxAzxyvQJaf24mvqVyPGVXYI7glCqnHpdwZPidI5szKsLVxWJnrjXBj+OfdAhsjKA9XPM6i6EwITgeOT57A8ks2Jg7TW/JlOSxgQ9L3l5y9mABB1LgflN4iPVW+44V2r3Ac7omRZkQ7kPNZDG8bKfdL+N+22d73HAFeWL5NgtyBdfCo9/49JRfZ6ecyUgr1gJChpznKz6Y1p+yRSWcfmylcSAqazYoJxA2uqOV0uB7woV+f06Sv9DJMXbvKgKdDgoNT9kzPnML7kCFMKibakNWtcAJ3OZp6w4iWB2EXrXW8i+P8YpRy2waUZWT1s3IMykgoszx4pK3wgR42+BA9G9vhC/bKNKTMcIHI2ClDYGsOG9w3NY/ULadlq3zi3/lQ7GITdK1klygyNs6Upn0T/QuaGTHrsA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199015)(2906002)(6486002)(66946007)(316002)(478600001)(86362001)(66476007)(31686004)(83380400001)(36756003)(8936002)(38100700002)(41300700001)(6512007)(5660300002)(6666004)(31696002)(8676002)(66556008)(6506007)(53546011)(2616005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YytWZWc1Q0o2OXA0S3VWMlc4MjlTQWVldzlNQlNUREU4bGNzRFhtSTdDb0NW?=
 =?utf-8?B?MHB4cTJYZXBrN0RvZVIzZVNPelU3THMySDBqRWNSSWxGM0NTN2tCZGR0L25K?=
 =?utf-8?B?d3VZYVlVTm5kWmY1ems0THlDVkRQYTM2VFlDR2hsM21YVDhjRFhHczZSSTI5?=
 =?utf-8?B?K2VvQzFOU2kyTy9IYnEzNTczZkVxZ1NFQWlIV09aZ1ozMGJ5VWNLeERoVk1S?=
 =?utf-8?B?ZGZLZmhiOVZhM1dZNEgrSEZqWmNoaEUwSDQrSDJEeCtqd2ZzZkhubktwVXFr?=
 =?utf-8?B?Q200aG96V0RhejFDakQwTkIwT1BFZkkvWCsyQ0lib3lOaExBbXZWQnVIVE9H?=
 =?utf-8?B?QWxmWHlZWVR0TGJSa2NxYllSMXBJTDROUXdsQ1FVb0lyV0svM3lJVlJybmQ3?=
 =?utf-8?B?L01wYUpuZHluZFA5SVJjTUlXOERhZmQwMTRIR2JIL0J4VEduN0thZ0w0bFl4?=
 =?utf-8?B?RTBHa2NZMHNlalowTGpLZ2hDem9aOHBOVlRPczFTRUFrbmx1MUhJSXlyVHhx?=
 =?utf-8?B?Zm9sRmVZZUtYL2xTOFN5aThDbll3S0tWZHU4RmRLMVNpeG40WnVaOHRZeVFo?=
 =?utf-8?B?c0VJME9ZeFJtMTJUS28xUlZLbkphMmh0VnUycnBydnZCUGM1MktUUUhkdGVQ?=
 =?utf-8?B?eDBEZDRSSDhaVko3WVlUZS9XdHp2UEVaUW1Mc2JkSC93UnB3cnlOUlJacWlJ?=
 =?utf-8?B?MHdqNXo0VmRtUlBubEJ0TXBaYlR2VSt5YkxvdFdqcXNJVkdEU2Q0ZEtzNTdH?=
 =?utf-8?B?ZXFQVEplZEdUVVlNM2l5SmVqR2JMWkNoYWc4SEVva3NFaUJMUkxkaVdqa1Ro?=
 =?utf-8?B?SVIvWGxwTUdWdDlKdFNKWGk2TURXN3M3TGt2QTFkWVp5RDM2bkxyVjkxanR0?=
 =?utf-8?B?ZWhpanRWamFFYmo5UGkzTmRacU9rYWpSSWdLN3BnRkFJYUozd3dHOFh0T3Q0?=
 =?utf-8?B?aEJIdnVaV1lWV29oU2o2TU5QU3VCQUwvY2pLcnp0KzZqVVBuN0xFTEplZTQ5?=
 =?utf-8?B?VUxGSWlJSU5DS3hPbTBDc0ozQzJ6WjQ1S0ZDMVhkcVpuT05EQjV1bzU5ZERx?=
 =?utf-8?B?TVBPZEo1OVpDeDNmUk0zQkxObm1RTXFVZkhIa3ZsdTJ2T1dpYWRYM3RSUnRH?=
 =?utf-8?B?Z0VDYWR2SDhJZDNHd2R2YXZOTnFmNnZkSVBJUHpBaXkycWFNWlNsZnJzRjAy?=
 =?utf-8?B?aldNYitQRW5aMEpsYThsUUhFeXFwYTBRcEszUGt0Q3IzTmhMRFlyVFp1ckM4?=
 =?utf-8?B?QzAxQTFCUFUxZkkwTi9YY1RVOFljWmNUdmlJdzdTV045Y3B4ZlpiWTl1bDF6?=
 =?utf-8?B?VFAzeTQxKzg0NWFNbVYrLzVHZGVFMVYza2s0WGk1eCtRNThodGl5U3pQcDZy?=
 =?utf-8?B?ZXpMTjNuRkZ2a0d3Sk5MS1ZuRjJydWE5alQ1YldobDBwVkNTeWowOTBjYnR3?=
 =?utf-8?B?SkNzVHFTWnRZcmxzN3dSdWh2L2p5Vm56WEovZENCSGc0aGo0b25EcFg5eHVt?=
 =?utf-8?B?cHhxMkFBOW0zQldDNE1ERTlWUGkzTkJuSjNtWXFMczJWbTZKVGlUMnRHcG5s?=
 =?utf-8?B?LzVTb0xudEl5YXY3WGduR1Iwa0dnRlVtdUlvT2tTalRKS0FHeFdYZ3V4bHBL?=
 =?utf-8?B?VHNNdTJ6OFk2WHlaSDkwalRTU1VmYUJpZTFCWjZiQVJLZjBBbmM3dkJkVmJM?=
 =?utf-8?B?S1RtSDBJSUlKRytaeVNoK1FhSHJFNi9FK2hCcWErN0g0TlJXb2Z2UnhOMWxL?=
 =?utf-8?B?cmhHczJIa2hHNkVpTEZ6RWZRemlqUk0xdHZxYWg0ZVp1dDFZblJHTkVpaGEw?=
 =?utf-8?B?cU5jd1lHUmRSSkJiUHlRSDBzOERxcHhDS3NpU3RBZmpkVThiWDZHc0liQnhO?=
 =?utf-8?B?N1htQ0tNOW5naG52TWJJMW5idEFHWmpNSElsL2RZSlRyeHhQZGhUUFlhcC95?=
 =?utf-8?B?aVhuaFJzZ0t3QzBOWmdKcm1EdHJMb3l5QTZjU05sRC9DUG45ckh6QkljMkdv?=
 =?utf-8?B?REJlcnBHTWlrZkxNa01UeXE1RlJ0cTc1NzZzeFNjR0RTbmFNQy9wa2htbHRw?=
 =?utf-8?B?cnlCUHlCazN0OGZ1dmpzSkxOY1dpZjdyd2FsM3VFV0drV2FTTE1KWDlUa0I3?=
 =?utf-8?B?SWljSy9GM0RpZjQxT0poeXNFa1dkTVRMZkFaQW41WjBydEhDdTUzc01tV3lt?=
 =?utf-8?Q?znB4t3QHi4DOpPH7BgzM6d0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb958762-092a-41d8-4f1f-08da96fcda89
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 09:29:57.0733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O48ESJP6gDwbv94TLNDY3z5Zf7ddGcvdT+iwf/GuGZ07cQqLxtsYpUkt4MJV4BNA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7032
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/14 23:06, Josef Bacik wrote:
> This uses btrfs_header_nritems, which I will be moving out of ctree.h.
> In order to avoid needing to include the relevant header in ctree.h,
> simply move this helper function into ctree.c.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Since it's only used by backref, uninlining it looks fine.


Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/ctree.c |  9 +++++++++
>   fs/btrfs/ctree.h | 10 ++--------
>   2 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 1f0355c74fe6..0f7f93bc2582 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -4775,6 +4775,15 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
>   	return ret;
>   }
>   
> +int btrfs_next_old_item(struct btrfs_root *root, struct btrfs_path *p,
> +			u64 time_seq)
> +{
> +	++p->slots[0];
> +	if (p->slots[0] >= btrfs_header_nritems(p->nodes[0]))
> +		return btrfs_next_old_leaf(root, p, time_seq);
> +	return 0;
> +}
> +
>   /*
>    * this uses btrfs_prev_leaf to walk backwards in the tree, and keeps
>    * searching until it gets past min_objectid or finds an item of 'type'
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index af6f6764d9a4..42dec21b3517 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2836,14 +2836,8 @@ int btrfs_get_next_valid_item(struct btrfs_root *root, struct btrfs_key *key,
>   		(path)->slots[0]++						\
>   	)
>   
> -static inline int btrfs_next_old_item(struct btrfs_root *root,
> -				      struct btrfs_path *p, u64 time_seq)
> -{
> -	++p->slots[0];
> -	if (p->slots[0] >= btrfs_header_nritems(p->nodes[0]))
> -		return btrfs_next_old_leaf(root, p, time_seq);
> -	return 0;
> -}
> +int btrfs_next_old_item(struct btrfs_root *root, struct btrfs_path *p,
> +			u64 time_seq);
>   
>   /*
>    * Search the tree again to find a leaf with greater keys.
