Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466AF5B9704
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 11:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiIOJH6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 05:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiIOJH5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 05:07:57 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10042.outbound.protection.outlook.com [40.107.1.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AEA96FD8
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 02:07:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JO8kSZlB/KrdUYfnMSgoDXQr5HgwVFuVJ6bohV1nQ+s5tDhF//0uWUOAbiCXHX5pmgHcaH3ow+XzRPy/k+XlFQeNUFCd00jr1uGHMs62AajgPu+YmiFkdkw6hA3F09mNPLMqpXbfR6RcdjrZJ+eolQw9GXWIIfUtAS3JbdoOCAku/pBJ2LQlHx6Zj5pNgyR19umB4Ez2dzPbGn77Ot2h+B7jRNhiRqScBc2wlo5FwoOGw+O0YKbbO94wCQeNDsWNgn4NVunxhr2bwuoSGc1QLQ0URG5OY+nT/j73oW8Hi3YCZvyn6vD9PcvrMZudDyB48WXbQadm7Xt2ih+bU8LinQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrgMVPTPLljXNUFFskdDObo00y2YEFcC9wN6T/h+30k=;
 b=MtrMP5CsOSax9PzUMy3c/UiR3Ds1qCZ6nNREkW67OvP9F58lIV3Z6T9Lg2330zilSwF1+vX7zpGzsZ/EFNPMlhZCXuPdgTqIZJMR/58J2FLriDe/V2Cjj9qVdBu9HHZ2xcb5PKCZFnUPFejxSmqP5ral/jhTMj8DEXett5ZBLLeIRLtVgqyKBpHgA3AmKKQJhwdNtLfaJ+wZjeyI8t6HsSu1J5whuj+MHx+wFbtadJbmWxmDF0Yw7L0YoNq71OdCqLyN6mgS5tpIcrgzT9qR5HNZISexWJZWPs8n246Kde+6N1i6aHE9JRiLwgSeXz/Bqjvjvcfy4CdR/9J42jLezw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrgMVPTPLljXNUFFskdDObo00y2YEFcC9wN6T/h+30k=;
 b=zkxVWiv9D3A2B19XZ9vG9I5nqR91uHNna7BJwkZyqhO6fHDEO1Iwqq0Mh3Ae3YLWzTnYlddt2HQIUunHY2nO0GLzmectt+gImvjdZ0fTVqKX7/GqKmW/Pf3KL/ywT9yFBuDOzFFRQ42wkdFzGvKG9nGHaWjoTYqPJoYy64goWEwDDXYyAPE/cZLvHgBysTi4nSpPKMas619gH1lYOSCdXX2eQ2hxv/vm9zS8h0k8l/kxfjhc7bhbRGDlINMMziTMOzx0OJTuRSSAwxLGX2p5g25pWwzTEbLx6w+xPYV6OlE08umeXXlL4638rflBQqhfS9EEq0uKZ6jui2lZSw6fng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.14; Thu, 15 Sep
 2022 09:07:50 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9%5]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 09:07:50 +0000
Message-ID: <a67b963c-1f2a-bf68-c0b3-08dda678c629@suse.com>
Date:   Thu, 15 Sep 2022 17:07:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 04/17] btrfs: move btrfs on disk definitions out of
 ctree.h
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663167823.git.josef@toxicpanda.com>
 <058e41f7732823196f030916c04134418688cbe9.1663167823.git.josef@toxicpanda.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <058e41f7732823196f030916c04134418688cbe9.1663167823.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0092.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::33) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PAXPR04MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: bd0b6463-d0b0-4d97-76cf-08da96f9c3f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Si/JsJrnqJN6a8vMI6oMavY9afah/r9S9+C3rQCc67ndFbM0fObTQRHhrba9lY84dqV+32OoRmqt6gk16MxCnh6SiGtyWjrskpaQ4QI2KHky+xpI8kh2oNSML4Jsk0atCSq7WbAxrcB5xEdzBSVNDF8d6Rcq1zqEGgD5yNTKDVyjBQlbNV0cXw0LJQFTIZrAKHVN0r8yAM6rb/e8iB640c+2V5wQhVynyVrSz4KhsKD75/DjjljKWzKAL1FQhZr5XRBmYLA7oCu6zrwRU38OLnFDFndzbS5AqDCEwbBkakE1EK9ZfxLqfBmjh/UTeRteUK/8eCNqiWZoHCOnjb011FI/AWuJKLOshuqO6eV7fD95vv10TDcmsuJQsJTmXfRgPOu+Bp7woMV/6L0OM/sozCttQJQcf1xHpREmCJjul81rzNNjwxfCUyPSqYv20HL8vakhkeccf8hmP5nkxgj0+87o+Qb3qsaltFCzrInQLT9AJ3yed+C3V/7H1h8aQzhfH1PsfI6HDWgESVBx4g9DArbp2VJK470gV7faNLkYDNuN1fKyivN0odeTD8HUz9fNdoBn2J8nqeOQJsepzLDeOkE+enEAd2zjDDsd3/A77qqJeH9fMy9n7RSu3ff8Ms5BT5wsWuxRpSSPHfF1yrahYk5HqeNMtgZlR3Deg5vK5TBCSUevfKlKpI6GVGn5k6H1Rcd22rO74rIy2M2rJdoZcd4X27v2CohrNkZyLQZJmzO4KCcvugdJMP2aKRiccvTSQcrm77XZIBjyEkCAZY9K+/eky813mCGaxJRFVQHkiqE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199015)(36756003)(6512007)(6506007)(2906002)(53546011)(31696002)(6666004)(41300700001)(86362001)(66556008)(38100700002)(66946007)(478600001)(6486002)(8676002)(66476007)(31686004)(2616005)(8936002)(186003)(5660300002)(30864003)(83380400001)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1k3bEF4QmN0NVFqQm9qdUZZUUhsZ3dQZnpKM1MvcXhNTUMxWjVJN2pDRlh0?=
 =?utf-8?B?bTRZNUU4ZmdLYjhOaG5QcXkvNzRWd3J5Nmc1bDRoUlNBWUl2ZjJOcVJva25z?=
 =?utf-8?B?SkgvSE5UeHVYb0I0TXR3ak05cHJjZnhiY0kwM0RxSjh0TktvM2gyS2lnYVFz?=
 =?utf-8?B?RkZmNjNxZFdXRFFwcTQwWUN3a0ROZ0N6ZjhiWU9SZHdvZmJGQ1N2dDk2a3ZS?=
 =?utf-8?B?WnBmK0VpRm5Gd3Y2UGtOMUw1bTRrZWtUL2E3U0gyb045ZVV1TGt4Y2lGRHND?=
 =?utf-8?B?VzFiU1FqN2FIRUZJcnJUOVI2QUVIYlN4bEp1ODk1YUJZbXRMSTFEblN3QUZh?=
 =?utf-8?B?QmZIL2VTaktzRThhWDdJQnBiUVJzWVM3U21Nb1ltb0pTc1FYOTQxTUZOTE1X?=
 =?utf-8?B?WDBZbktCemkxZHpoQ3J3czJRQnNBczVpSDdpdVBsQW53UFVROEhJRVJPN2Jz?=
 =?utf-8?B?SW9XL0wzTjlqZGVsVWxmd0ZTMnRFTC9EQnU0Qjdhdks2eTVRVnUxbDBkZ1VI?=
 =?utf-8?B?R2VvTmUydUlzM2VaZnozOWNvMUhiTjA5Q2hjSFlVQWZjYnhaVWljSXh3cFJX?=
 =?utf-8?B?V1pScnlOSGdmcklPamUrQjdxNEhPUnRHSU5yWnBhempyNHpjU050eUh1Vzhp?=
 =?utf-8?B?cXVMKytBcjE0SjdrSFdoUXl0cWpuaTBXK3luZGxxSzRFekxWRnc3a1ZkVmJ6?=
 =?utf-8?B?SlFLK0k2SUk1TExwNThmWjV2ajJKTUd6KzB0dTZWYmd5b3c4Ry9iUHRmZDZZ?=
 =?utf-8?B?MW5DZVJNK2U5blRnNml4cXBJNVhVcERlR1lJR0NUUnJrWTZmV0ZqMG5iVTJP?=
 =?utf-8?B?R25vSGZ1U0J2UXIzSEorS0EzbFVQNmVDUFlOUjNQVHV0cmR1MmtpMmIvNVVQ?=
 =?utf-8?B?emdqMVlKdHJGbHM0akFGQjZrbUpyUlV3OENqY3NXSEx4VjRqSVBkTFJjbStC?=
 =?utf-8?B?cHN1VzhjVEpBRzE4aG54WGR1WnlLeGxXa3lYd0V0aHZxYjV6S0NxQWJsbm9i?=
 =?utf-8?B?N0ZCbkNGblFsTWJ1a1diTW1EeVJNWTZCNUo5QndtTm5jK2IwL0hqdWxlMUQz?=
 =?utf-8?B?RnlNYTA4NE1PeThoN3FxeVd1cS80K3lyVW13TXVHaDdFRXlVdVMvTHpTVmVn?=
 =?utf-8?B?elNUOTQ4N1hFaWhvMDVoR1pGeHN5U2VKWkppZUIzTDVlU0pwd0JaSklUM2l3?=
 =?utf-8?B?dGRKSWxURlhseHlzRitFaHBaWm9KZkxXYzhidUgzVzV4US9ZciszSHMvUEIw?=
 =?utf-8?B?RkNheUtXSXR5ZWwvZ05ScDlmbUhEZVA1Qm1qdEU4Q1F1aDZJRVE4eUNVNDJh?=
 =?utf-8?B?a3FoSHFtU1pPR2pFQ3Q0NFRTaGdUQitXUWlZMW13RHEvVkRPamE3UkZzUGJE?=
 =?utf-8?B?ZURyRzZJRXBLZmdRWXNraFVKdUJwRnNUelpsdWp0bldlYWNnNWFhNDNXSFpx?=
 =?utf-8?B?cWdMR1l4TUM3K2E4OG9KRjFNb21welNjNy9lTGc2Sk9lN2VmRWJLZ2NHcCs3?=
 =?utf-8?B?YWpkUW1mRGh3MXhQNE54WGxHQ0htNWN2R25RVGxBMzJwZ3pwOVlGNWJhT21a?=
 =?utf-8?B?UG4rWDVQTFVrT3E1dHZZUXpGeDJsaXlGN2F6RFpjNjFCQ0l6SXNCclcwbDMx?=
 =?utf-8?B?eWNEWnBvcUZ1RDIxY1B4bXg4WHJKbXU0eVVFZmxvWFVoOXdySTl1M3BiT1Ba?=
 =?utf-8?B?aW5OdXlpS3d1b2V4czZhK3FmbEN3QUFTQUNBOUlSZGFBQXlhT2pwNURKOGFN?=
 =?utf-8?B?Sm8zV0NHR2NlYmM4VnpWNGgwZUQvNzRBQVhUbno0T1JobHNKK0Q1RUpIK0tE?=
 =?utf-8?B?WDBxWlZ5UXV2YjZJdFB1MlcwamFZZ1N2M1BCSzZHTFhmeVQ4a0FDQ3dyaVVv?=
 =?utf-8?B?T1VGY0doL0dZOUZaTmlrRDQ4OUd3dlByczlMN1NIYkpCSVlLUXN6RjRPcE90?=
 =?utf-8?B?YlEzKzdIdUlPamp6NHZwRVhzOC8vR0lpQi9yQVVOQWw1RVhJbXBjcll2Qms2?=
 =?utf-8?B?MTh6NHpNT3YwdURYOThOY1RvUDNqWTZUQ0NVY0NPSnFvdXFHWUQvQWNpS1Bp?=
 =?utf-8?B?dDZNTHkybmozUmVHK1l5U2xNYS96V0w3VUNUSmhzWkpXR0djRCtKMlF4TENs?=
 =?utf-8?B?REdhN2t3WkRHZ0lRRS9kQWdWSjQzQ0hMcmx3VUxIOUNwOFhUbitjWDU1RnBz?=
 =?utf-8?Q?hDtIguNonqIKm6PLRRtyvFM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0b6463-d0b0-4d97-76cf-08da96f9c3f1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 09:07:50.8031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJv2ZqxcKhb+pU8k977xhlkBI1HgQvkiMgXPs3HnaIBtTMYk6EjikY7vgu8agI24
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8253
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
> The bulk of our on-disk definitions exist in btrfs_tree.h, which user
> space can use.

Previously I tried to move some members to btrfs_tree.h, but didn't get 
approved, mostly due to the fact that, we have those members exposed 
through uapi is for TREE_SEARCH ioctl.

But I'm not buying that reason at all.

To me, all on-disk format, no matter if it's exposed through tree-search 
should be in btrfs_tree.h.

Although I'd prefer to rename btrfs_tree.h to btrfs_ondisk_format.h.

Thus to David:

Can we make it clear that, btrfs_tree.h is not only for tree search 
ioctl, but also all the on-disk format thing?

Reject once that's fine, but reject twice from two different guys, I 
think it's not correct.

>  Keep things consistent and move the rest of the on disk
> definitions out of ctree.h into btrfs_tree.h.  Note I did have to update
> all u8's to __u8, but otherwise this is a strict copy and paste.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu


> ---
>   fs/btrfs/ctree.h                | 215 +-------------------------------
>   include/uapi/linux/btrfs_tree.h | 213 +++++++++++++++++++++++++++++++
>   2 files changed, 214 insertions(+), 214 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 5cf18a120dff..c3a8440d3223 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -50,8 +50,6 @@ struct btrfs_ref;
>   struct btrfs_bio;
>   struct btrfs_ioctl_encoded_io_args;
>   
> -#define BTRFS_MAGIC 0x4D5F53665248425FULL /* ascii _BHRfS_M, no null */
> -
>   /*
>    * Maximum number of mirrors that can be available for all profiles counting
>    * the target device of dev-replace as one. During an active device replace
> @@ -63,8 +61,6 @@ struct btrfs_ioctl_encoded_io_args;
>    */
>   #define BTRFS_MAX_MIRRORS (4 + 1)
>   
> -#define BTRFS_MAX_LEVEL 8
> -
>   #define BTRFS_OLDEST_GENERATION	0ULL
>   
>   /*
> @@ -133,81 +129,9 @@ enum {
>   	BTRFS_FS_STATE_COUNT
>   };
>   
> -#define BTRFS_BACKREF_REV_MAX		256
> -#define BTRFS_BACKREF_REV_SHIFT		56
> -#define BTRFS_BACKREF_REV_MASK		(((u64)BTRFS_BACKREF_REV_MAX - 1) << \
> -					 BTRFS_BACKREF_REV_SHIFT)
> -
> -#define BTRFS_OLD_BACKREF_REV		0
> -#define BTRFS_MIXED_BACKREF_REV		1
> -
> -/*
> - * every tree block (leaf or node) starts with this header.
> - */
> -struct btrfs_header {
> -	/* these first four must match the super block */
> -	u8 csum[BTRFS_CSUM_SIZE];
> -	u8 fsid[BTRFS_FSID_SIZE]; /* FS specific uuid */
> -	__le64 bytenr; /* which block this node is supposed to live in */
> -	__le64 flags;
> -
> -	/* allowed to be different from the super from here on down */
> -	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
> -	__le64 generation;
> -	__le64 owner;
> -	__le32 nritems;
> -	u8 level;
> -} __attribute__ ((__packed__));
> -
> -/*
> - * this is a very generous portion of the super block, giving us
> - * room to translate 14 chunks with 3 stripes each.
> - */
> -#define BTRFS_SYSTEM_CHUNK_ARRAY_SIZE 2048
> -
> -/*
> - * just in case we somehow lose the roots and are not able to mount,
> - * we store an array of the roots from previous transactions
> - * in the super.
> - */
> -#define BTRFS_NUM_BACKUP_ROOTS 4
> -struct btrfs_root_backup {
> -	__le64 tree_root;
> -	__le64 tree_root_gen;
> -
> -	__le64 chunk_root;
> -	__le64 chunk_root_gen;
> -
> -	__le64 extent_root;
> -	__le64 extent_root_gen;
> -
> -	__le64 fs_root;
> -	__le64 fs_root_gen;
> -
> -	__le64 dev_root;
> -	__le64 dev_root_gen;
> -
> -	__le64 csum_root;
> -	__le64 csum_root_gen;
> -
> -	__le64 total_bytes;
> -	__le64 bytes_used;
> -	__le64 num_devices;
> -	/* future */
> -	__le64 unused_64[4];
> -
> -	u8 tree_root_level;
> -	u8 chunk_root_level;
> -	u8 extent_root_level;
> -	u8 fs_root_level;
> -	u8 dev_root_level;
> -	u8 csum_root_level;
> -	/* future and to align */
> -	u8 unused_8[10];
> -} __attribute__ ((__packed__));
> -
>   #define BTRFS_SUPER_INFO_OFFSET			SZ_64K
>   #define BTRFS_SUPER_INFO_SIZE			4096
> +static_assert(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
>   
>   /*
>    * The reserved space at the beginning of each device.
> @@ -216,69 +140,6 @@ struct btrfs_root_backup {
>    */
>   #define BTRFS_DEVICE_RANGE_RESERVED			(SZ_1M)
>   
> -/*
> - * the super block basically lists the main trees of the FS
> - * it currently lacks any block count etc etc
> - */
> -struct btrfs_super_block {
> -	/* the first 4 fields must match struct btrfs_header */
> -	u8 csum[BTRFS_CSUM_SIZE];
> -	/* FS specific UUID, visible to user */
> -	u8 fsid[BTRFS_FSID_SIZE];
> -	__le64 bytenr; /* this block number */
> -	__le64 flags;
> -
> -	/* allowed to be different from the btrfs_header from here own down */
> -	__le64 magic;
> -	__le64 generation;
> -	__le64 root;
> -	__le64 chunk_root;
> -	__le64 log_root;
> -
> -	/*
> -	 * This member has never been utilized since the very beginning, thus
> -	 * it's always 0 regardless of kernel version.  We always use
> -	 * generation + 1 to read log tree root.  So here we mark it deprecated.
> -	 */
> -	__le64 __unused_log_root_transid;
> -	__le64 total_bytes;
> -	__le64 bytes_used;
> -	__le64 root_dir_objectid;
> -	__le64 num_devices;
> -	__le32 sectorsize;
> -	__le32 nodesize;
> -	__le32 __unused_leafsize;
> -	__le32 stripesize;
> -	__le32 sys_chunk_array_size;
> -	__le64 chunk_root_generation;
> -	__le64 compat_flags;
> -	__le64 compat_ro_flags;
> -	__le64 incompat_flags;
> -	__le16 csum_type;
> -	u8 root_level;
> -	u8 chunk_root_level;
> -	u8 log_root_level;
> -	struct btrfs_dev_item dev_item;
> -
> -	char label[BTRFS_LABEL_SIZE];
> -
> -	__le64 cache_generation;
> -	__le64 uuid_tree_generation;
> -
> -	/* the UUID written into btree blocks */
> -	u8 metadata_uuid[BTRFS_FSID_SIZE];
> -
> -	/* future expansion */
> -	u8 reserved8[8];
> -	__le64 reserved[27];
> -	u8 sys_chunk_array[BTRFS_SYSTEM_CHUNK_ARRAY_SIZE];
> -	struct btrfs_root_backup super_roots[BTRFS_NUM_BACKUP_ROOTS];
> -
> -	/* Padded to 4096 bytes */
> -	u8 padding[565];
> -} __attribute__ ((__packed__));
> -static_assert(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
> -
>   /*
>    * Compat flags that we support.  If any incompat flags are set other than the
>    * ones specified below then we will fail to mount
> @@ -336,43 +197,6 @@ static_assert(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
>   	(BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF)
>   #define BTRFS_FEATURE_INCOMPAT_SAFE_CLEAR		0ULL
>   
> -/*
> - * A leaf is full of items. offset and size tell us where to find
> - * the item in the leaf (relative to the start of the data area)
> - */
> -struct btrfs_item {
> -	struct btrfs_disk_key key;
> -	__le32 offset;
> -	__le32 size;
> -} __attribute__ ((__packed__));
> -
> -/*
> - * leaves have an item area and a data area:
> - * [item0, item1....itemN] [free space] [dataN...data1, data0]
> - *
> - * The data is separate from the items to get the keys closer together
> - * during searches.
> - */
> -struct btrfs_leaf {
> -	struct btrfs_header header;
> -	struct btrfs_item items[];
> -} __attribute__ ((__packed__));
> -
> -/*
> - * all non-leaf blocks are nodes, they hold only keys and pointers to
> - * other blocks
> - */
> -struct btrfs_key_ptr {
> -	struct btrfs_disk_key key;
> -	__le64 blockptr;
> -	__le64 generation;
> -} __attribute__ ((__packed__));
> -
> -struct btrfs_node {
> -	struct btrfs_header header;
> -	struct btrfs_key_ptr ptrs[];
> -} __attribute__ ((__packed__));
> -
>   /* Read ahead values for struct btrfs_path.reada */
>   enum {
>   	READA_NONE,
> @@ -1633,43 +1457,6 @@ do {									\
>   #define btrfs_clear_pending(info, opt)	\
>   	clear_bit(BTRFS_PENDING_##opt, &(info)->pending_changes)
>   
> -/*
> - * Inode flags
> - */
> -#define BTRFS_INODE_NODATASUM		(1U << 0)
> -#define BTRFS_INODE_NODATACOW		(1U << 1)
> -#define BTRFS_INODE_READONLY		(1U << 2)
> -#define BTRFS_INODE_NOCOMPRESS		(1U << 3)
> -#define BTRFS_INODE_PREALLOC		(1U << 4)
> -#define BTRFS_INODE_SYNC		(1U << 5)
> -#define BTRFS_INODE_IMMUTABLE		(1U << 6)
> -#define BTRFS_INODE_APPEND		(1U << 7)
> -#define BTRFS_INODE_NODUMP		(1U << 8)
> -#define BTRFS_INODE_NOATIME		(1U << 9)
> -#define BTRFS_INODE_DIRSYNC		(1U << 10)
> -#define BTRFS_INODE_COMPRESS		(1U << 11)
> -
> -#define BTRFS_INODE_ROOT_ITEM_INIT	(1U << 31)
> -
> -#define BTRFS_INODE_FLAG_MASK						\
> -	(BTRFS_INODE_NODATASUM |					\
> -	 BTRFS_INODE_NODATACOW |					\
> -	 BTRFS_INODE_READONLY |						\
> -	 BTRFS_INODE_NOCOMPRESS |					\
> -	 BTRFS_INODE_PREALLOC |						\
> -	 BTRFS_INODE_SYNC |						\
> -	 BTRFS_INODE_IMMUTABLE |					\
> -	 BTRFS_INODE_APPEND |						\
> -	 BTRFS_INODE_NODUMP |						\
> -	 BTRFS_INODE_NOATIME |						\
> -	 BTRFS_INODE_DIRSYNC |						\
> -	 BTRFS_INODE_COMPRESS |						\
> -	 BTRFS_INODE_ROOT_ITEM_INIT)
> -
> -#define BTRFS_INODE_RO_VERITY		(1U << 0)
> -
> -#define BTRFS_INODE_RO_FLAG_MASK	(BTRFS_INODE_RO_VERITY)
> -
>   struct btrfs_map_token {
>   	struct extent_buffer *eb;
>   	char *kaddr;
> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
> index 1f7a38ec6ac3..e6bf902b9c92 100644
> --- a/include/uapi/linux/btrfs_tree.h
> +++ b/include/uapi/linux/btrfs_tree.h
> @@ -10,6 +10,10 @@
>   #include <stddef.h>
>   #endif
>   
> +#define BTRFS_MAGIC 0x4D5F53665248425FULL /* ascii _BHRfS_M, no null */
> +
> +#define BTRFS_MAX_LEVEL 8
> +
>   /*
>    * This header contains the structure definitions and constants used
>    * by file system objects that can be retrieved using
> @@ -360,6 +364,43 @@ enum btrfs_csum_type {
>   #define BTRFS_FT_XATTR		8
>   #define BTRFS_FT_MAX		9
>   
> +/*
> + * Inode flags
> + */
> +#define BTRFS_INODE_NODATASUM		(1U << 0)
> +#define BTRFS_INODE_NODATACOW		(1U << 1)
> +#define BTRFS_INODE_READONLY		(1U << 2)
> +#define BTRFS_INODE_NOCOMPRESS		(1U << 3)
> +#define BTRFS_INODE_PREALLOC		(1U << 4)
> +#define BTRFS_INODE_SYNC		(1U << 5)
> +#define BTRFS_INODE_IMMUTABLE		(1U << 6)
> +#define BTRFS_INODE_APPEND		(1U << 7)
> +#define BTRFS_INODE_NODUMP		(1U << 8)
> +#define BTRFS_INODE_NOATIME		(1U << 9)
> +#define BTRFS_INODE_DIRSYNC		(1U << 10)
> +#define BTRFS_INODE_COMPRESS		(1U << 11)
> +
> +#define BTRFS_INODE_ROOT_ITEM_INIT	(1U << 31)
> +
> +#define BTRFS_INODE_FLAG_MASK						\
> +	(BTRFS_INODE_NODATASUM |					\
> +	 BTRFS_INODE_NODATACOW |					\
> +	 BTRFS_INODE_READONLY |						\
> +	 BTRFS_INODE_NOCOMPRESS |					\
> +	 BTRFS_INODE_PREALLOC |						\
> +	 BTRFS_INODE_SYNC |						\
> +	 BTRFS_INODE_IMMUTABLE |					\
> +	 BTRFS_INODE_APPEND |						\
> +	 BTRFS_INODE_NODUMP |						\
> +	 BTRFS_INODE_NOATIME |						\
> +	 BTRFS_INODE_DIRSYNC |						\
> +	 BTRFS_INODE_COMPRESS |						\
> +	 BTRFS_INODE_ROOT_ITEM_INIT)
> +
> +#define BTRFS_INODE_RO_VERITY		(1U << 0)
> +
> +#define BTRFS_INODE_RO_FLAG_MASK	(BTRFS_INODE_RO_VERITY)
> +
>   /*
>    * The key defines the order in the tree, and so it also defines (optimal)
>    * block layout.
> @@ -389,6 +430,108 @@ struct btrfs_key {
>   	__u64 offset;
>   } __attribute__ ((__packed__));
>   
> +/*
> + * every tree block (leaf or node) starts with this header.
> + */
> +struct btrfs_header {
> +	/* these first four must match the super block */
> +	__u8 csum[BTRFS_CSUM_SIZE];
> +	__u8 fsid[BTRFS_FSID_SIZE]; /* FS specific uuid */
> +	__le64 bytenr; /* which block this node is supposed to live in */
> +	__le64 flags;
> +
> +	/* allowed to be different from the super from here on down */
> +	__u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
> +	__le64 generation;
> +	__le64 owner;
> +	__le32 nritems;
> +	__u8 level;
> +} __attribute__ ((__packed__));
> +
> +/*
> + * this is a very generous portion of the super block, giving us
> + * room to translate 14 chunks with 3 stripes each.
> + */
> +#define BTRFS_SYSTEM_CHUNK_ARRAY_SIZE 2048
> +
> +/*
> + * just in case we somehow lose the roots and are not able to mount,
> + * we store an array of the roots from previous transactions
> + * in the super.
> + */
> +#define BTRFS_NUM_BACKUP_ROOTS 4
> +struct btrfs_root_backup {
> +	__le64 tree_root;
> +	__le64 tree_root_gen;
> +
> +	__le64 chunk_root;
> +	__le64 chunk_root_gen;
> +
> +	__le64 extent_root;
> +	__le64 extent_root_gen;
> +
> +	__le64 fs_root;
> +	__le64 fs_root_gen;
> +
> +	__le64 dev_root;
> +	__le64 dev_root_gen;
> +
> +	__le64 csum_root;
> +	__le64 csum_root_gen;
> +
> +	__le64 total_bytes;
> +	__le64 bytes_used;
> +	__le64 num_devices;
> +	/* future */
> +	__le64 unused_64[4];
> +
> +	__u8 tree_root_level;
> +	__u8 chunk_root_level;
> +	__u8 extent_root_level;
> +	__u8 fs_root_level;
> +	__u8 dev_root_level;
> +	__u8 csum_root_level;
> +	/* future and to align */
> +	__u8 unused_8[10];
> +} __attribute__ ((__packed__));
> +
> +/*
> + * A leaf is full of items. offset and size tell us where to find
> + * the item in the leaf (relative to the start of the data area)
> + */
> +struct btrfs_item {
> +	struct btrfs_disk_key key;
> +	__le32 offset;
> +	__le32 size;
> +} __attribute__ ((__packed__));
> +
> +/*
> + * leaves have an item area and a data area:
> + * [item0, item1....itemN] [free space] [dataN...data1, data0]
> + *
> + * The data is separate from the items to get the keys closer together
> + * during searches.
> + */
> +struct btrfs_leaf {
> +	struct btrfs_header header;
> +	struct btrfs_item items[];
> +} __attribute__ ((__packed__));
> +
> +/*
> + * all non-leaf blocks are nodes, they hold only keys and pointers to
> + * other blocks
> + */
> +struct btrfs_key_ptr {
> +	struct btrfs_disk_key key;
> +	__le64 blockptr;
> +	__le64 generation;
> +} __attribute__ ((__packed__));
> +
> +struct btrfs_node {
> +	struct btrfs_header header;
> +	struct btrfs_key_ptr ptrs[];
> +} __attribute__ ((__packed__));
> +
>   struct btrfs_dev_item {
>   	/* the internal btrfs device id */
>   	__le64 devid;
> @@ -472,6 +615,68 @@ struct btrfs_chunk {
>   	/* additional stripes go here */
>   } __attribute__ ((__packed__));
>   
> +/*
> + * the super block basically lists the main trees of the FS
> + * it currently lacks any block count etc etc
> + */
> +struct btrfs_super_block {
> +	/* the first 4 fields must match struct btrfs_header */
> +	__u8 csum[BTRFS_CSUM_SIZE];
> +	/* FS specific UUID, visible to user */
> +	__u8 fsid[BTRFS_FSID_SIZE];
> +	__le64 bytenr; /* this block number */
> +	__le64 flags;
> +
> +	/* allowed to be different from the btrfs_header from here own down */
> +	__le64 magic;
> +	__le64 generation;
> +	__le64 root;
> +	__le64 chunk_root;
> +	__le64 log_root;
> +
> +	/*
> +	 * This member has never been utilized since the very beginning, thus
> +	 * it's always 0 regardless of kernel version.  We always use
> +	 * generation + 1 to read log tree root.  So here we mark it deprecated.
> +	 */
> +	__le64 __unused_log_root_transid;
> +	__le64 total_bytes;
> +	__le64 bytes_used;
> +	__le64 root_dir_objectid;
> +	__le64 num_devices;
> +	__le32 sectorsize;
> +	__le32 nodesize;
> +	__le32 __unused_leafsize;
> +	__le32 stripesize;
> +	__le32 sys_chunk_array_size;
> +	__le64 chunk_root_generation;
> +	__le64 compat_flags;
> +	__le64 compat_ro_flags;
> +	__le64 incompat_flags;
> +	__le16 csum_type;
> +	__u8 root_level;
> +	__u8 chunk_root_level;
> +	__u8 log_root_level;
> +	struct btrfs_dev_item dev_item;
> +
> +	char label[BTRFS_LABEL_SIZE];
> +
> +	__le64 cache_generation;
> +	__le64 uuid_tree_generation;
> +
> +	/* the UUID written into btree blocks */
> +	__u8 metadata_uuid[BTRFS_FSID_SIZE];
> +
> +	/* future expansion */
> +	__u8 reserved8[8];
> +	__le64 reserved[27];
> +	__u8 sys_chunk_array[BTRFS_SYSTEM_CHUNK_ARRAY_SIZE];
> +	struct btrfs_root_backup super_roots[BTRFS_NUM_BACKUP_ROOTS];
> +
> +	/* Padded to 4096 bytes */
> +	__u8 padding[565];
> +} __attribute__ ((__packed__));
> +
>   #define BTRFS_FREE_SPACE_EXTENT	1
>   #define BTRFS_FREE_SPACE_BITMAP	2
>   
> @@ -526,6 +731,14 @@ struct btrfs_extent_item_v0 {
>   /* use full backrefs for extent pointers in the block */
>   #define BTRFS_BLOCK_FLAG_FULL_BACKREF	(1ULL << 8)
>   
> +#define BTRFS_BACKREF_REV_MAX		256
> +#define BTRFS_BACKREF_REV_SHIFT		56
> +#define BTRFS_BACKREF_REV_MASK		(((u64)BTRFS_BACKREF_REV_MAX - 1) << \
> +					 BTRFS_BACKREF_REV_SHIFT)
> +
> +#define BTRFS_OLD_BACKREF_REV		0
> +#define BTRFS_MIXED_BACKREF_REV		1
> +
>   /*
>    * this flag is only used internally by scrub and may be changed at any time
>    * it is only declared here to avoid collisions
