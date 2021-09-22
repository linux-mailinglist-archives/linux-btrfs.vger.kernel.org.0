Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42834145A0
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Sep 2021 11:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbhIVJ66 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Sep 2021 05:58:58 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:30953 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234610AbhIVJ6w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Sep 2021 05:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1632304641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KIDRJf1zDfBUhJl8RWr3TpKlb0BTTZUMW8AcQGC9kfg=;
        b=YxQu3zKKizlSB+gvlMUtC+jSSg3ANvQdeahFy39ET0iamAxv04ZNBtt/t9rfKY97iDkA6s
        NLj3t2TDCxe4vA13iqVORbBBPmvSoKpMYYuLP2JjyJjliMaxlbrHK5rOGRrdzJ6kHCH7eN
        voudU8KinQ45GOrrLKyOfwTHXDVke/g=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2050.outbound.protection.outlook.com [104.47.5.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-22-TEU2YznmO1egfp8anQSgPg-1; Wed, 22 Sep 2021 11:57:20 +0200
X-MC-Unique: TEU2YznmO1egfp8anQSgPg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvysyUKmCrnE/dxLPNIzWk0V69Tw3mtell4nqxWX1y2656H4imqj6ABeR2+zntpOTUqHV6/iqgcceyU+qkrD3W43Sc81olAikiBpoGT1yWwxWmSAo1CPw/hnyZdmlUP6UBZvN5nJ6CYcDHdaWfDzK7TFoHvVYijhFPBpoi1BWVXBbX6yc300yfjbUWTvRP5AxqTT5SftpuxvheI2dhEMslqy1xX5IFEBx6F3ezMRazfJoh2xnSw0aSA+3UQzV5iaac+/AvOysvsAiWygsnZPyqgpbLiyS1872oXsB0Aaz/P9HllZshRHLeb+JmtxvBeyZxmgzS3vQ4HfEMNR016O0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=KIDRJf1zDfBUhJl8RWr3TpKlb0BTTZUMW8AcQGC9kfg=;
 b=mduFTGgkHg+5kZpbeS+IOL934tYBHIvNn8yxHCUsNg+xSwN/OzGZr0jBQhqnZQFZg94N7rOnMBYnVqRdsN6hiJx9Y6WoDREYhWruQT0WT9+2QH4FkBPizrPOnnJHQw6ReTaPGMF3eWJ5NDtPvin8AFn54n3XYBth3oTb5cIXAUzpryCj3KBLUbqIFQAyg2N6/IvZknZy1PuLFMrkep9h1flt2w3qtHOgmuvPhWObLjuL6EDyx38jqJMuczJsNOy70k80CB3GhHluAizCdyCaYRQx9Nq7jQJqT3okOBCyGzacAh3trhoZf0MvV707RmTw61u4qRvXRDuYZAq7csoFZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB5511.eurprd04.prod.outlook.com (2603:10a6:20b:98::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.18; Wed, 22 Sep
 2021 09:57:19 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097%5]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 09:57:19 +0000
Message-ID: <b32d1d47-bcfd-7fe2-c480-1f56f2b13616@suse.com>
Date:   Wed, 22 Sep 2021 17:57:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH RFC 0/3] btrfs: refactor how we handle btrfs_io_context
 and slightly reduce memory usage for both btrfs_bio and btrfs_io_context
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20210922082706.55650-1-wqu@suse.com>
In-Reply-To: <20210922082706.55650-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::16) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY5PR03CA0006.namprd03.prod.outlook.com (2603:10b6:a03:1e0::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 09:57:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 017d9be6-4cbc-45f1-7488-08d97daf5d52
X-MS-TrafficTypeDiagnostic: AM6PR04MB5511:
X-Microsoft-Antispam-PRVS: <AM6PR04MB551177E3C8B68A420EFC1C6DD6A29@AM6PR04MB5511.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yxjBP/RK/WPC7JzxGHY2lFDFjDWfQudlb5HBzyJACAE9f306wZS5jYnqkuhJ9GtUyXevxzDZdVG15Gdn4OuoayJgcpSlJ95x3ED0igTcQOmaBdgHCulXLrwV5ZaYY2ZnOAFjvkyzCNoXk7QCMz/TP5+mlp+LpMfizMLDmq/PBnkTeTmyGFdyE+CUdttPyYEIKX79cIz8zWK8tTY4m4SfJPemLuLGTEr+bjzhcpVoghqwykPoaZHo+PijX3NVFans42/RmnlRAFajEOGEyeuF1ljZCgAb9tu1HZqs90tNUlF4UWJdoSlRyBSEdXR15XdeH7hK0MhFd1pFzTyRbVJDR1nPgXCFHQou2WaSdUvfe8YqBss3ByLHUXYDVPUnSswJjsN21DUZp80phfW8jpYkCzC/Fx3v4dtvaifXGAjacQrF2FpUgRHKCuvu24S/Ttj7NwGPy+8dlAATq9FEayBZctfieXd33eO3T70L2sZsUB3Xp3edAq0QQ27j6WarmiqMqBCMIE9zTHg6gRdjcQncmqP/ll8KS2BDsm0G5j0pcExvHAMXnxSM7g94icmBBOh/tE4LwpKzdAKEgOGnzOwmlkAvtP2lRsHE81SLjo8SBYg5RLbvaASKzTO8Dr4tTDLUJY+eNcdTktZzE/EpthT+wlU5CGP/EhbTXryZ+rDWg/5f7P0m4T++Z3+nHpRNYnfbqNRpcJH4+PyuzKaaq0VzhY8jK5Sm85mpVPDLFhCc2n+Y7VP3X0Qy/PSisLBtz0Y4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(186003)(6706004)(86362001)(83380400001)(2616005)(508600001)(66946007)(31696002)(66476007)(66556008)(6666004)(36756003)(5660300002)(16576012)(8676002)(26005)(38100700002)(6486002)(8936002)(316002)(6916009)(31686004)(53546011)(2906002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3Zqc2hQTXZSTXBsNUdTT3VRRDBvbm1IZm5xaHBjWGtwWTgzZHBnbWQ5UUlU?=
 =?utf-8?B?eGV3cWNBYjhDenpHMXJGT3FlOEFScjJUQTJ6NjNtMVE0d1lCc1BzQUFHMUx4?=
 =?utf-8?B?eVZybW9FRERtU2ZJellFbDQrTDlLKzkyT0pwWHl1bkROWGJuSnZWbjBZSTY4?=
 =?utf-8?B?bTRmWnh5WENTUFpHYXZQYlVPQkhBZ3dpcTlCN0JaOGgxcnpsNVQ4NmwvK2gv?=
 =?utf-8?B?aHJRTkJxSThYUWEyMVdKZG9nQUZWTjc1b3p1NktzYmJNeVcxcy91VGIyOGdP?=
 =?utf-8?B?R2I4dlYxcHI1M3dyc0lpK3Q2Qks0dW03YWdpWGhna0VWQ2QxTHFmbGxOeW9z?=
 =?utf-8?B?NGNRZ3kzZnZhTUhNYU5Gc0hYNjRaQ1JXQjRXZWZmQUZNTzcxUnNDeTVZZXhE?=
 =?utf-8?B?MjNuMXNzMW5sY2ZRTzJKb2dVLzhrUHNobkw0YVpzakgrczYzNkNMSzY3a21p?=
 =?utf-8?B?YVJlYldUUFZZbjhSa0sxYkxMeFRYUlFnL2h4em11eGJ3OGFwdG1XSjZxeUNq?=
 =?utf-8?B?aXo4N3BIOGh4aVYzelFCTXlHdmFmVXh2eVZPNHBMTXBUaHh0Mk9UcFcrUXdU?=
 =?utf-8?B?aVVlL3lsMU5XeGlRejBuRUtDSFF1b0hsRnZKN2dtQnRwcDRLbUxWVjYzV3d2?=
 =?utf-8?B?Qk9SMEFaT20vSTJXd0FUbmNBeVhUUGwzNXoxSG53akExcHV6dmwwUmVITkhx?=
 =?utf-8?B?aXlEa2duamNUb3NEMFEwa0xZM0oyZ0VTVXE1UVNiVGVkWlhiY2FSZHZMTGdq?=
 =?utf-8?B?ZXlNNGtSSGpVQXZqQ1NERUZwVm9BbVY4dDZSNXU5U0pYaGJSZDdNY2dXZ2Vx?=
 =?utf-8?B?d2x2SkZUeldSL053eUJ1QTJWRExEUzN1eSthRlUyUDNtZ3pkWG9jOW9MMU5F?=
 =?utf-8?B?RHA4V2lwRzFxVmtnWEJNUlA2SE8xTk5SZ3BDY0FneFVGa2h6NlpNRTFqMUJ6?=
 =?utf-8?B?ajc5Zzh4c1VpYVdYNUliZVpmUEpHUERQL2NrclpWS0lDTGlWby9HR05Rb0Na?=
 =?utf-8?B?TWU4N0t5RkdSZU9Ec3pmVXNGa25PTDdpc2lPd3BNTDE5b1cyb1dGNGVMUEpv?=
 =?utf-8?B?bVFFWmxtZ0UxeFFrd0NDWERTMVFXWnQxQVJtVTRPQTl1QTF5aURSc3JzM09U?=
 =?utf-8?B?ZFJQZURHbVhXYWRLT00yNUNvZmc5eHJRbytjQUZWUEhXYUpGV1VOekF1VE1T?=
 =?utf-8?B?bWFNbWFScnJtMFZOR21WUXBMdURCL1V1NDRVb1lSdytxL3dOb25NSlgzTEwr?=
 =?utf-8?B?cng0cy9JWU1jUEw0Z3dIeU5VVGVKc0kzb3QwOHYzQ2lETlRYNUs0eG9zNytO?=
 =?utf-8?B?bnF1eXBWTXAycmJkMitNdkRpQVVhRkxRU21oQUoyOFJSRmRXTXlzUXBUblNx?=
 =?utf-8?B?UmpaNmhseWFjUzluWVN2RFExVG5xdnYzazFVR0lSWEN5anRxd1E3TWhZQ25M?=
 =?utf-8?B?UDF0U1hCaDgxR2FsWVc5SHFNZCtzRlZaREhESHJZamw4UHozdlZqelUveXZG?=
 =?utf-8?B?S2p1N2Zwd3JDQjQ4MVNCYUI3ZThQc3M5dktaOStPdURWSkw4Zng3WjRhTHZE?=
 =?utf-8?B?bUFSNVhkL3B6YTRadk9NUW95eEN4Uks4ZFgrU0dkNDFVdDlIOWQvR1pJcWhH?=
 =?utf-8?B?YldmeW1SQ1NRV2l0KzRRUmhhMDgwSENyK3NzVjFzczI1ZDlLUW5pK0pmaHNz?=
 =?utf-8?B?QXYxdU03RTZEVUhkZU8wR2JFajRERHh5ZGhwZlZsWWxZV3BSeVdsOTRIMld1?=
 =?utf-8?Q?RaRxftdqejXz/zOhXHkzCi0JHfyo4X8WS+qjJEC?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 017d9be6-4cbc-45f1-7488-08d97daf5d52
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 09:57:19.0897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zl0cTeVek1o2JMbcSb6LDZPQA6xyGhJNeupQzoqIitSC/WSvu19dTu7q8fPYgXq1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5511
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/22 16:27, Qu Wenruo wrote:
> Currently btrfs_io_context is utilized as both bio->bi_private for
> mirrored stripes, and stripes mapping for RAID56.
> 
> This makes some members like btrfs_io_context::private to be there.
> 
> But in fact, since almost all bios in btrfs have btrfs_bio structure
> appended, we don't really need to reuse bio::bi_private for mirrored
> profiles.
> 
> So this patchset will:
> 
> - Introduce btrfs_bio::bioc member
>    So that btrfs_io_context don't need to hold @private.
>    This modification is still a net increase for memory usage, just
>    a trade-off between btrfs_io_context and btrfs_bio.
> 
> - Replace btrfs_bio::device with btrfs_bio::stripe_num
>    This reclaim the memory usage increase for btrfs_bio.
> 
>    But unfortunately, due to the short life time of btrfs_io_context,
>    we don't have as good device status accounting as the old code.
> 
>    Now for csum error, we can no longer distinguish source and target
>    device of dev-replace.
> 
>    This is the biggest blockage, and that's why it's RFC.

OK, here I'm over-thinking.

The truth is, dev-replace only affects two types of operations, WRITE 
and GET_READ_MIRRORS.

The former case won't need to bother csum mismatch, while the latter 
case won't result a bio used directly for read.

Thus it brings no behavior change.

Thanks,
Qu
> 
> The result of the patchset is:
> 
> btrfs_bio:		size: 240 -> 240
> btrfs_io_context:	size: 88 -> 80
> 
> Although to really reduce btrfs_bio, the main target should be
> csum_inline.
> 
> Qu Wenruo (3):
>    btrfs: add btrfs_bio::bioc pointer for further modification
>    btrfs: remove redundant parameters for submit_stripe_bio()
>    btrfs: replace btrfs_bio::device member with stripe_num
> 
>   fs/btrfs/compression.c |  6 ++----
>   fs/btrfs/ctree.h       |  2 ++
>   fs/btrfs/extent_io.c   |  2 --
>   fs/btrfs/inode.c       | 30 +++++++++++++++++++++++++++---
>   fs/btrfs/raid56.c      |  1 -
>   fs/btrfs/volumes.c     | 23 +++++++++++++----------
>   fs/btrfs/volumes.h     | 11 ++++++++---
>   7 files changed, 52 insertions(+), 23 deletions(-)
> 

