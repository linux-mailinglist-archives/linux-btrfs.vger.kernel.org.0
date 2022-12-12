Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AD4649B02
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 10:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbiLLJXJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 04:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbiLLJWJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 04:22:09 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D577F585
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 01:21:49 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTzfG-1pUP5B0yMU-00R3Gv; Mon, 12
 Dec 2022 10:21:44 +0100
Message-ID: <395c6c66-7b34-a4c6-2b63-68c9b2e5ac76@gmx.com>
Date:   Mon, 12 Dec 2022 17:21:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/4] btrfs: drop unused trans parameter of
 drop_delayed_ref
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1670835448.git.johannes.thumshirn@wdc.com>
 <96d11175d7b70318858469941ab125c3007b6a6e.1670835448.git.johannes.thumshirn@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <96d11175d7b70318858469941ab125c3007b6a6e.1670835448.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:KU7OWtB5PLVqOJTiANgmUJmy6IEhH85GFn9u3N6KhRnMvEt+ZFb
 lN1L02vbYgCSLQGJAUzN3vTulzey5jVW7Jiy7BS4qM3RfY1RZ4gj+2eiiz/nK/XzO33z4d0
 cwyjdxv5Gb1s6WkwandB4dydEcyIHdRegKzEn8orUUPrlhTAEtx1xFDQloR3A+cErAHFB44
 Ti0pfyQcBM20BJVbB+HIA==
UI-OutboundReport: notjunk:1;M01:P0:IX5DlbKZLOg=;jwc/uzx5LQKSNOYLmNppMouLVby
 pxdj5yQe+9597EY6Q5LAZ/cxAwfLvlV+DsyuWPB6Ob2M4+Qruau7Tx9jBAwEamss1yxjb7FKC
 /GiRMtAte7vkcLMIO//DxHFdNq4IumcrhxkGwLKPz99z5nG0hmJSxpNh3RA8Ql8757X5DSXi4
 0vZBazRWy1TocBkHgT9hpmAAik2YPSdYdICP5T0v/5aiCLZuhEt3/f0ZdmEtMJR/RbjKscqUs
 a7Ev18+WSJYnv6QrGVhzCHWRvt6ippZK152YmKqCBPvTRF8aW9e6D9l4v143uXTMTD2Q68GBz
 4OInP/S59uO39dKSKYiOHgx/fkzBbERp21hStc4COdKPug5KkMVwM3htZr28kzszwNuzb7Gxu
 QbCW1wuB/GpbgM7PbgUXRIpNes2lPo6BnSAjjfpSioEhXAjJFLxzhnnr7ZB3eQq7QIAhc3+j/
 enxlNas06vDU7aR48mf3GhLcl7nFRASxaSkisCU+jLj2s2Nadvk5oUvLQtou9jO/+qk2jZhoR
 diOm3m0HLmvMtwHFIVTBMqEhfbGUsVC1jGgmhy5KW2MqAZmChOMp5lOqiFXjUxjeiAybOHFjW
 ust+MwPGHHIC1BwJxc0XS9klcKEYQuQO+p+xYFg7ISn+Z7RYXRZ41Rcm1y6AMqafbDy4zGTnv
 qifMhgGqTBjs3v7YtUQlZCqLCr9IG/vb3yaqcZxULQDG125asJlpGRi1AHiaJzoaxHT3rj7FK
 K3B6DbFcqWOLmVEHrp645GZnUWfb5rWBNmAlyD4lxZywHxjofmm5tGx8+dATrbz3sO/qrWka6
 dhJ/h5b+NyBmeucMX0gT+GdbW8jcCYX5hRPVCtJEj4JsSH9veSOK9gi+wnUuP9O7iyDfQrwDi
 nNidE0ciMQt0ihew3Cqh8FJeEzPIMfsffOhsQGemBNgC2KSSvwHx3FUI4vtHOnSpxFI30hlQe
 M1pw8r/BrJKdpORrbcvctlTJ1p4=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/12 17:02, Johannes Thumshirn wrote:
> drop_delayed_ref() doesn't use the btrfs_trans_handle it gets passed in,
> so remove it.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/delayed-ref.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 573ebab886e2..663e7493926f 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -437,8 +437,7 @@ int btrfs_delayed_ref_lock(struct btrfs_delayed_ref_root *delayed_refs,
>   	return 0;
>   }
>   
> -static inline void drop_delayed_ref(struct btrfs_trans_handle *trans,
> -				    struct btrfs_delayed_ref_root *delayed_refs,
> +static inline void drop_delayed_ref(struct btrfs_delayed_ref_root *delayed_refs,
>   				    struct btrfs_delayed_ref_head *head,
>   				    struct btrfs_delayed_ref_node *ref)
>   {
> @@ -482,10 +481,10 @@ static bool merge_ref(struct btrfs_trans_handle *trans,
>   			mod = -next->ref_mod;
>   		}
>   
> -		drop_delayed_ref(trans, delayed_refs, head, next);
> +		drop_delayed_ref(delayed_refs, head, next);
>   		ref->ref_mod += mod;
>   		if (ref->ref_mod == 0) {
> -			drop_delayed_ref(trans, delayed_refs, head, ref);
> +			drop_delayed_ref(delayed_refs, head, ref);
>   			done = true;
>   		} else {
>   			/*
> @@ -641,7 +640,7 @@ static int insert_delayed_ref(struct btrfs_trans_handle *trans,
>   
>   	/* remove existing tail if its ref_mod is zero */
>   	if (exist->ref_mod == 0)
> -		drop_delayed_ref(trans, root, href, exist);
> +		drop_delayed_ref(root, href, exist);
>   	spin_unlock(&href->lock);
>   	return ret;
>   inserted:
