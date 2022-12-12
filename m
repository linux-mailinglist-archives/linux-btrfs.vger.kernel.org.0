Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32422649B04
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 10:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiLLJXR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 04:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiLLJWX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 04:22:23 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32259FC9
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 01:22:20 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNbkp-1pJhpW0dBL-00P6wv; Mon, 12
 Dec 2022 10:22:14 +0100
Message-ID: <d6cb4a8b-a853-7487-4b15-36cd883cd29b@gmx.com>
Date:   Mon, 12 Dec 2022 17:22:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/4] btrfs: remove trans parameter of merge_ref
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1670835448.git.johannes.thumshirn@wdc.com>
 <730412da5b804df3b373aee79429c8ecaebf2535.1670835448.git.johannes.thumshirn@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <730412da5b804df3b373aee79429c8ecaebf2535.1670835448.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:mvkn7UkskfnMVf6fcLj7GRaFL8a3mUboO588PPXSzMNn6aDykW5
 nyZQFHsj6hm/o8IkOsSasNFdKfuHcgSqBG/d6hZ3bLUxilXD45W8p1wNtdva3MXsg+QV9oa
 9q+jme0mtkrZr/9c2nfSneFNtC+9pVA8jvgto556FHTLxeXsJdq+tEcuYJDwfG7clJSa3Jl
 PdyJZTlB7QJclL+hRj4kg==
UI-OutboundReport: notjunk:1;M01:P0:QNKpSUT1m9k=;Afhxwzh2VFTNyVTJGH9DlJJRmOu
 ehZSYQEtmrM3YBl7l9TVLTQ80DhB3PIkvcEwH2uGhO/PBcZyFnExkB2tJhNJRVq76zn+BsvOe
 ZWkzfDjad17+xXEHgjube1yi6pLltYbtIfn/NBNlshup9Ctp2Duockib+xkpjWe0dQho6dpe0
 XweGV8bB5hIENnEbiE3pAyitMwdxQc+wstnaCMLWo2oMOZOXcvcs/It57NukYXhqaZYHW/6UV
 V4OCcV3Demskt/Ipq3nCZi9BX4sfSi6hQpMbqYamSpghqdtMC5T2aOwtIGeGwzTBmFIsm/nBB
 RUPMg/nwVdYNm7tfcX0w5BDM0wXcjcN43hkKsdfNTwdQjcJRjWYRq2eHSoCii8d5ecoEP2aK1
 lXqijtOo38dpvl/wzafQHJKDLQQCMuxKsJ013Cb+KTdW6CQd8Nsg5shn6Y8GlY0EdDZEluDDu
 MLR5jEpcK2/CIxzD4oIQ579r5d2gqaMyP2HyY4Ux9dAkkjU3GWoydXYZ+R6O3w2dbhzwDQ4Vt
 yjqgGOjoIUwZn/KDzVvT1LZ6yYfnSqjxyRds96CvqFetvxCRlaxONbwoaFe7AvBvDz6L7yyGa
 igzZGpRm8hKLFENtM/R932iAeD381Lu3VUSGYEyACNB+GVpE7hgzJ+fpFCzNkluxedZvm/kg1
 b/9YGvCWghSNQGpnK3QEeoGBerss/eN5STjqVzIE05wcdEDnOR7w2I4/p9zNbafTcF++XpcP0
 OHIQNIX8LoSTKyXe8bnXNJR5YkWZbj6uzmZdPjxrZBEhsyZdMKm857U5358J2gWdTV46KNVos
 6WvYXQW0TzYtpw/Jgs65il/eePsaaPEnKq8yHWMzWkxX1k+2JAGXhNUqYEK4O6V7c0fm/dN/m
 GR6ShskN129WUSIWkHSPQ6YRCMoX92Pjw4wnB3ZYqkprCuuIV6oDX0di1+BCp8clS7meIeoPS
 f8N+AeHGNmfypvyEadHGyJTorFU=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/12 17:02, Johannes Thumshirn wrote:
> Now that drop_delayed_ref() doesn't get the btrfs_trans_handle passed in
> anymore, we can get rid of it in merge_ref() as well.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/delayed-ref.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 663e7493926f..046ba49b8f94 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -451,8 +451,7 @@ static inline void drop_delayed_ref(struct btrfs_delayed_ref_root *delayed_refs,
>   	atomic_dec(&delayed_refs->num_entries);
>   }
>   
> -static bool merge_ref(struct btrfs_trans_handle *trans,
> -		      struct btrfs_delayed_ref_root *delayed_refs,
> +static bool merge_ref(struct btrfs_delayed_ref_root *delayed_refs,
>   		      struct btrfs_delayed_ref_head *head,
>   		      struct btrfs_delayed_ref_node *ref,
>   		      u64 seq)
> @@ -523,7 +522,7 @@ void btrfs_merge_delayed_refs(struct btrfs_trans_handle *trans,
>   		ref = rb_entry(node, struct btrfs_delayed_ref_node, ref_node);
>   		if (seq && ref->seq >= seq)
>   			continue;
> -		if (merge_ref(trans, delayed_refs, head, ref, seq))
> +		if (merge_ref(delayed_refs, head, ref, seq))
>   			goto again;
>   	}
>   }
