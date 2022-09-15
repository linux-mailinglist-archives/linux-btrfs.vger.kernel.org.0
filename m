Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E30C5B9754
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 11:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiIOJXE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 05:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIOJXC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 05:23:02 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36C889CFA
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 02:23:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhC+uJh82ok4NEtMw+tzLL1cY2VXoguR/fJJ6sn3eSxUJ7M+z+fgI21Q1cCbi7tLqoLkymj1qdlKBWGJ9LYneqAuKsrzlt83jYgzHAGglU6QheZFJdknwq6fKWyw0DVc+YU7zIrfla5WvBiOyYSvuEbNU7ubOU6/haWGiOTCRe1t4fHYj8RW5uJX+rzoy9NRf+HdDpQ0m24g3bwXr9RzP6YrL7SziU+N/vWR3kHr0fgTBnt7/4DTE/Yn9yvL4+bBMymtwjM6OCrUE4Sd1BXrsFXFAD03DvxLSPfgEDHSltHJGU/OCx/Cdsd+auWOoqpPQMgP6YN5qjjztXnxlvyTDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Fb+2zgEnaROsyyDDycpxELYSYuRLrIe2Qd/Z1xqf6c=;
 b=Mrrq+lVBaIs1S1A5Q6kP/XtQDv6JgxrP60AvtIWgCxF/HMWF491//Z8/gc2xWyDjonRxeYlIg+16Ieu9o2Wkmy44w8g2cwyJN/ump7nBUesplwvclQFkt84TfQia6Vy+I+aHhMkFDqAg8ZRL2TenNQ8IT4vFfutuc7GNECpOSV88NzLNq9GGfxursHZVMWiV5IikSig1LJXgaDHoHr9+pOprPGcmV1u0FAi9UQ+AmCHKREtvLTYHjrPQ5ncEPlUahT472fxBnJcJaHsHp9v2P2oHfxkgaGPAr6jXwUsKzmbqYiga81nZt5F/gTW1ooHKA1/M/L3xoC5Ci0ar9LMWow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Fb+2zgEnaROsyyDDycpxELYSYuRLrIe2Qd/Z1xqf6c=;
 b=mu/yhaOKVACV91naGsDRjG75b4pJWJFhX6yst1aHaRVowoy5rLfI9IULfzfJfLIvuNLoIzr7veU0iWMMTB1vfsHwKO/lYyuVoX1iZXms7dSXZImdC58rB5NYrlaSDuewt2ig3XPFC6RhcxhiaNwDfeNL3/PTZa5SyTcUTyDt19jF/IJv3vR829bOc0FtTzFxkNVru4T5AjZn+sA4LOmSItwAB98Zop8kMXMaSHUllkkY8okACcgMZj91g9mnOfBv9bj80lCkCoATk5e4p57UV7M56PTb/Mmst9d+sDv1YIrbZUro4Sr3KAUu+Lg8I6FTEG0KKtUl/tzXjR+IkiPdgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM8PR04MB7793.eurprd04.prod.outlook.com (2603:10a6:20b:240::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 09:22:58 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9%5]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 09:22:58 +0000
Message-ID: <048bd930-6634-1dc2-1551-52766d4fefeb@suse.com>
Date:   Thu, 15 Sep 2022 17:22:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 12/17] btrfs: move btrfs_print_data_csum_error into
 inode.c
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663167823.git.josef@toxicpanda.com>
 <95d99a944771363259f2de25de22dffd7867d127.1663167823.git.josef@toxicpanda.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <95d99a944771363259f2de25de22dffd7867d127.1663167823.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0066.namprd05.prod.outlook.com
 (2603:10b6:a03:74::43) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AM8PR04MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: d70856ec-cba2-4206-996f-08da96fbe0be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nSZxUczH+7/YprSjiL3fOztXdlz0eRHFwb2BssWo+tAy83Hlbdinn2lsRdD62v5DUBoXmNJcVthDeIoqKAQithuNWfRaDtE4zJw/zvPzW5usuH0MSe/mGSm1h70vEf9mdcK04ncVl6x7O2O0hTSDCpSfeZ6WeZt5KcshReRJEJipnAfFGi3nVV8M8+/P0Kxdjzv5ieqGTR7Lpygye6bnMNpOIajonGorFQiei7M4Tdo7bL9AjmAlSt8ckMK8aTnwrxP/15j+zbYWNGcjZiGXTHJ11RM18pOLzJpiY21YRrXD4038S4OB5REkDOsuP0CyV4x6AEExYJzecCfGLMlp6nWD2/cp2Ki0qza2j3TqKLIaKthwHEjRWFtpWddbxQVPiSjOOb7jfMCVwzAdsi4VGvwVoBhQ7/ED54BqH06KWvAAKCdKP5ikj38vtnI4S2mldss3/m0sBhK8bRtA/cUUBB/W7Sv8A9nLplRLskaX3dT6bmGSMVkPEDMMijTZTK3x6ao+CVJFkDXXpJR/mSIHoPT0rVJ8djyhbXA/juUYt7H50A4qwKawj/W4iyDuLJUJKnO+jXZzP7/167q91GVgery2Bf20uAw6Nxsr9DoS51ZTCXhJcb89HXbuNtnU0pvgpOWbyYJ1KNUHW6SXppxUSCprFjJLLyG5FyTke7VXPVED9HOgETyyI2Lr9U/O2aGrrlf4SFDp73E6nqMLuWxW4tP2vDHhgdHJaE5MjlG7hmGhAwpEBHpmmf/A5wOA04fHTpTw14FZvLw8Tyxqh9lQSbtYngqch7cjByTNlIwn++Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199015)(31686004)(6512007)(316002)(41300700001)(66476007)(66946007)(66556008)(8676002)(36756003)(86362001)(478600001)(8936002)(6486002)(5660300002)(31696002)(2906002)(53546011)(6666004)(38100700002)(186003)(6506007)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3JOQU5sUnZ5bUFuM0FaU1czQWNxU0tqanI5YzA1Q0hxVlZtRE1OeU80ZmVh?=
 =?utf-8?B?UDU3enFYbHl4ZUEzbUhramdmcXB4dEVlNEVadlV5cnZLTXVaOWRPRWdvR0Fy?=
 =?utf-8?B?WGtkWUI3bWZxSVN6S1NqRjZ0ZFNHakRkQmduVUMrWUxDVFF3VVlzUVBwSXpq?=
 =?utf-8?B?bXl4eUI4cVVteG5Ra2s0eVladjR5S2pxdkhRV3pSR0w2TmJTSzlxRnVwVzV3?=
 =?utf-8?B?S29mMXlkL0oxWm9SL0hJTVdYeFFhZEN2dU43NlhZUDZRL2F5cEs1c0xpaUpt?=
 =?utf-8?B?d0wwNzcyUG9BcmIwQWZzRlNYcnU0cXJlcXVZOFozVWhvVUtjNWYxTFBjNS9x?=
 =?utf-8?B?RVBENkFDZWxQeHBrY1Y3elFnY09vcHNlKzdQOWtrL3pTOXNoUWI2Rkg1WWhJ?=
 =?utf-8?B?cXBYbHkxWVl2MEkyZE14dG5sRHJNR2svTXRkOEtXVVNOTktLaHRkQWp2dWZC?=
 =?utf-8?B?QzBybDFJbGhSaTFRelhxRXB0MGVpS0xxekdvOHp1ZG1xNXRZY1ErT09CUWlp?=
 =?utf-8?B?YzFjZHFLRkJoMktsS2o3THVmbCtyL21yNVh1TzRwdVB1SDBUVEVTc0gvdVEv?=
 =?utf-8?B?Vm5HdUVidWZVVnQxVk1pTU5NV0ZkM0x1SGd0d21ETS91MGtPbEQ1NHQ3RVV1?=
 =?utf-8?B?eXFWSnFFcm9DOXJtZEN0Ukp6MlFvVnF4TUFIVzFGWENMOHo2T3VGeGNEY3Ny?=
 =?utf-8?B?RjF4QlRjOUkwek5IM280VFhyY3B3S1BXMlJ2aFZPbXpuK0VvWjNZWUlISDBT?=
 =?utf-8?B?VVVUNzR5QkVwSlhWaTJnN200UVVIbW1PNlFQa3h5WFg3ODlYUnNQOVp1WDVC?=
 =?utf-8?B?eWJLVk9vdTNBckp4aUpLV2tnMCswYitDKzE5SzIzUHNxbzBXREhYcXVQdUVT?=
 =?utf-8?B?ektoVnVwSmkxSlpnQmRMeGFSRGlvcHdIMm00WXlWK0FvcmQxcXJibEFWcUZq?=
 =?utf-8?B?anNhb1R4dGFDNmJzVEVKWjEyRXp5S2FRRFh3c0VWOHRrUk5RQWE0bGk4dDly?=
 =?utf-8?B?cDMwWnpkQWRZLzhWN2FVSktIN2NaMDg3aWtXeGowbHdha1ZpcDVHK1lmeUVU?=
 =?utf-8?B?VStiVTBRRlF6aEJ3YWZOQ1lqbk4rMXRUSXFoOVNYWTZZN0crKytrZ00wMCtQ?=
 =?utf-8?B?aHZ0REtlYVJGbUlmVUdWVngwMHpDOWp6bm85QlFPZS83MSt6NkNNTG5wazR5?=
 =?utf-8?B?ZlVQWmNJNERHNkVRbWQyVCtKSC9LTDV0MEFTc3k5Rm13dTFNb3hZeHVlL2xz?=
 =?utf-8?B?YXMxdEJHWkxrRHVaVEVveE1mWC80R3RMRVJzWnNiOVNQay8vZGRJZXdvYWp4?=
 =?utf-8?B?cEFRSjIwNFJheGpuSlAyQTR1eHZiL1h0VEhaWGx5cXRxbUU3TVN6SFVuai85?=
 =?utf-8?B?Q2FBUGllelNrVGF6QzVleFlUYjYzUzJ5RHl4TU1jbnA5MXFOSjRWNHlyZ2tp?=
 =?utf-8?B?NUdWa3ZPRXdQOUVpN2Vla2thOHkyemNxd1Vsd3lQRStyZ0dMUXRIY3FML2Rv?=
 =?utf-8?B?czEzMnVXRitZWGo0U1RRMjVvYWVRdXNLNFg0RlFOci91RDk5aXZhQzdkQWJ0?=
 =?utf-8?B?NmREVDhyRHJjZU1ySXRNWnNtK3lxUEFERUlxZXBQOURaTHA4N1MySVpLeDZK?=
 =?utf-8?B?QXZBQkM2dTJid0l5RDFwVEROSEFMcDc1eWVybHpJLytxOEgvdUYvS2tWQXVi?=
 =?utf-8?B?Q1RBTG85TzB3TUYyRVNEell0ZWo4V0pMQVdrRWpyTVRIenp0RXI5bVB6YXNi?=
 =?utf-8?B?ZVEwOHAzZ2dLVS81cUNiZldQWEgweVM4KzFGKzc0d243SWs0N3lpT1VtZGZt?=
 =?utf-8?B?SndLeExMdVhheXA1L3lHNDVnSnV1L3h4Nk5IalBSR1FhZHI1NDVTOWU5Ti9p?=
 =?utf-8?B?R1lqa1pjVWorUC9KdWhlSGRBb2tpRFBzdjFGTDRlT0JSRFdmUDhYR2RjS3F0?=
 =?utf-8?B?Mk4wSG4ydmFOcnFlMDdHdXRpb2hBWnZUSXUrRWk1RU5hZS80YW5nNXE2dzRC?=
 =?utf-8?B?Y2I3MzBQcDhpbGFNYUM4WFVxcnEvSlp1aUpoYTJVVXJYdHRLUnBWZ29RVld1?=
 =?utf-8?B?d0ptSWZVeWtoWlRZTCtseitnZlpUM0lsTnJGTHdGOUV6QlBCbGpSS0tJTGhO?=
 =?utf-8?B?cjRrTjFuMDFJb0lkUUs3N0cyWkhkNmJxc0NtUERiMHpVek93VUw3UDhYVkRl?=
 =?utf-8?Q?EqSqYcJB1p9Grqd4PKbn2og=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d70856ec-cba2-4206-996f-08da96fbe0be
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 09:22:58.2890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEl4ohRxQDUqexIvSIDJjkfttqyOqnJxfgzEKsTtmaRH6GZVy11s/uI+ZsHj57CX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7793
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
> This isn't used outside of inode.c, there's no reason to define it in
> btrfs_inode.h.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just a small nitpick below.

> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 6fde13f62c1d..998d1c7134ff 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -125,6 +125,31 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
>   				       u64 ram_bytes, int compress_type,
>   				       int type);
>   
> +static inline void btrfs_print_data_csum_error(struct btrfs_inode *inode,

IIRC for static function there is no need for explicit inline keyword.

Under most cases the compiler should be more clever than us.

Thanks,
Qu

> +		u64 logical_start, u8 *csum, u8 *csum_expected, int mirror_num)
> +{
> +	struct btrfs_root *root = inode->root;
> +	const u32 csum_size = root->fs_info->csum_size;
> +
> +	/* Output minus objectid, which is more meaningful */
> +	if (root->root_key.objectid >= BTRFS_LAST_FREE_OBJECTID)
> +		btrfs_warn_rl(root->fs_info,
> +"csum failed root %lld ino %lld off %llu csum " CSUM_FMT " expected csum " CSUM_FMT " mirror %d",
> +			root->root_key.objectid, btrfs_ino(inode),
> +			logical_start,
> +			CSUM_FMT_VALUE(csum_size, csum),
> +			CSUM_FMT_VALUE(csum_size, csum_expected),
> +			mirror_num);
> +	else
> +		btrfs_warn_rl(root->fs_info,
> +"csum failed root %llu ino %llu off %llu csum " CSUM_FMT " expected csum " CSUM_FMT " mirror %d",
> +			root->root_key.objectid, btrfs_ino(inode),
> +			logical_start,
> +			CSUM_FMT_VALUE(csum_size, csum),
> +			CSUM_FMT_VALUE(csum_size, csum_expected),
> +			mirror_num);
> +}
> +
>   /*
>    * btrfs_inode_lock - lock inode i_rwsem based on arguments passed
>    *
