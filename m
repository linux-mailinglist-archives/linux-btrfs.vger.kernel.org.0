Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B4B710A29
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 12:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240360AbjEYKdM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 06:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjEYKdK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 06:33:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BC9183
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 03:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1685010785; x=1685615585; i=quwenruo.btrfs@gmx.com;
 bh=/ySBnxdOEJ1rjMWAxwo86CohBn4F8XrqrqqEPDQkh7w=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=TZKM2pWtDtv4IRZ6uNIM5EoFfFWUOnmih8m2+LNi1H42J7qUMG9uMkquZGr1OPoNYHMPg7T
 qwycagB7vdojjWwvlbbrz56y12Hdbr5QuFyBarPOuIlDGD93InhiCNXQV92o5QeFwAZt9EgpP
 nv7KxQLOyGOC2JBnnuoxEo2XATMjOZo2TN9ApMTtKUYM8uV7ycZVbnuubMFdqukDEYmreQOgd
 L9/LiXFJLHGuCyQ1rYvxGzUJClDzBgFBrWRCL80o7S2s3ESxOzhXIJT7QEeULgzCjARWANG6t
 rgibKXCVoy7B1RZTVKdAAOh9itRUz/zegZYpI4dnFcK+sFw3Uatg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2mFY-1q7nem1t8e-0138Dx; Thu, 25
 May 2023 12:33:05 +0200
Message-ID: <9394d0cc-7cf4-38e7-763f-18c983a6b55b@gmx.com>
Date:   Thu, 25 May 2023 18:33:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 4/9] btrfs: open code set_extent_dirty
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1684967923.git.dsterba@suse.com>
 <2d4be0b36bb199c70308f945320def249512b0d9.1684967923.git.dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <2d4be0b36bb199c70308f945320def249512b0d9.1684967923.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Uuc1FYCLdORHxcgC/3cyy7DfRQIfvKnqP7F/4QIFzLgPXQSfG+6
 UefV9NRbUMtyn8L2iPJdXyLmiVWwx9Ppz/FYJeTF0UgggxuH982oR8Kf48IRGH1tOCh2h4M
 D7ODayi0rqtyoDnzJ15SJSCqcKB/HXymv3/ZDrjph+9vgyGSDkkV2FP4EI7YwnfUz4k5HrE
 xQhhokKGts5TgnnO3KRgQ==
UI-OutboundReport: notjunk:1;M01:P0:gfe++9WOw74=;5LctbbFM7HlnlRK9nMMCKvcYzLV
 4jFdgd+yuQ3Joosz09dzw319uzdvodPST63QMIgqAE4+gpWTfWSPqXHgGNETmP3J/tXbnSH2K
 L4yIf6xI4/8WcIQqiKfWkf7UmAJfEwv2UaIqA4+hw/qwGkwf1sc+hRO/JNg5KIeki7ZBN707m
 Nppp69epCrizkB1HTfOcjS2u/kTrD5kpaGG/dC8Ya5bf1a8FDuo/BpFiRRPjUIONm3fNxikOH
 3jijdwsoonFshYIt/IPKQw4Cjgk7nsYD3A8BCNXnP51/gEa5u9emWn5gJiVcrJ2uaaS9q/IZo
 b9L0smQEau4MM6fiq2qrq0/kcNR/ByaRU0VLnLLJZ4rgLKK8okwFEvXrdGKM900IpxpZEnDVx
 68t5AiDNxqQi/XPT6RduWb78SBvLOkwQY2pwyyz247D2b0o3YMsSzzeceiZLaMuphBT3SVDfT
 ODuciNlI5XZCuqi8BNuZ8wGOUzkTrNv/fKIpYhJCop3ZFGv7HYxZeR//zb4uQM/EtgFzUn1kK
 yNOQvkxTD7iNF0oChxuXUMa2hQIeggzkqQR7xSkdae+fXZnuJK2I+nFjPCx9vd6zMx0HQDazk
 a/9Smq9ELoAewYMG6uZDai9A/zG4YiOgIkR5xKmy1kTHa9iJdOFlafMMWag9RNb63n4dord1/
 UdeY72rd3xKEJYJ7SWJXT6TLi9rF/OdsDqzudJuP6L1VXsz5zO0fbiv49ZeMuhnU1Y+ZxfQCl
 3okZe2kP8MHdLYf7vL0rxMS6wO28tfc49dZQAV4rmtKOuiw/LIWXhoZQ8sDQfKHGIugNmfu1Q
 rVIJMeicoX+uS0lDTUHsnKdfE5w0S6ugwG/1hQ/7rm+HVj6DR1bdX4i2IOR9AcFA/CT6lNI1u
 03d5vfkMZgQDdZm3sEiCQ42kwADtn6WwrSff6V+Um56lvSpYzjjgvp8zVNOP04cIGqNE/FI7h
 +6z3RfRVKEg0o6uwkGj9YngVF8U=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/25 07:04, David Sterba wrote:
> The helper is used a few times, that it's setting the DIRTY extent bit
> is still clear.
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/block-group.c    |  7 ++++---
>   fs/btrfs/extent-io-tree.h |  6 ------
>   fs/btrfs/extent-tree.c    | 15 +++++++++------
>   3 files changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 590b03560265..ec463f8d83ec 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -3521,9 +3521,10 @@ int btrfs_update_block_group(struct btrfs_trans_h=
andle *trans,
>   			spin_unlock(&cache->lock);
>   			spin_unlock(&space_info->lock);
>
> -			set_extent_dirty(&trans->transaction->pinned_extents,
> -					 bytenr, bytenr + num_bytes - 1,
> -					 GFP_NOFS | __GFP_NOFAIL);
> +			set_extent_bit(&trans->transaction->pinned_extents,
> +				       bytenr, bytenr + num_bytes - 1,
> +				       EXTENT_DIRTY, NULL,
> +				       GFP_NOFS | __GFP_NOFAIL);
>   		}
>
>   		spin_lock(&trans->transaction->dirty_bgs_lock);
> diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
> index 293e49377104..0fc54546a63d 100644
> --- a/fs/btrfs/extent-io-tree.h
> +++ b/fs/btrfs/extent-io-tree.h
> @@ -175,12 +175,6 @@ static inline int clear_extent_uptodate(struct exte=
nt_io_tree *tree, u64 start,
>   				  cached_state, GFP_NOFS, NULL);
>   }
>
> -static inline int set_extent_dirty(struct extent_io_tree *tree, u64 sta=
rt,
> -		u64 end, gfp_t mask)
> -{
> -	return set_extent_bit(tree, start, end, EXTENT_DIRTY, NULL, mask);
> -}
> -
>   static inline int clear_extent_dirty(struct extent_io_tree *tree, u64 =
start,
>   				     u64 end, struct extent_state **cached)
>   {
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 5c7c72042193..47cfb694cdbf 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2507,8 +2507,9 @@ static int pin_down_extent(struct btrfs_trans_hand=
le *trans,
>   	spin_unlock(&cache->lock);
>   	spin_unlock(&cache->space_info->lock);
>
> -	set_extent_dirty(&trans->transaction->pinned_extents, bytenr,
> -			 bytenr + num_bytes - 1, GFP_NOFS | __GFP_NOFAIL);
> +	set_extent_bit(&trans->transaction->pinned_extents, bytenr,
> +		       bytenr + num_bytes - 1, EXTENT_DIRTY, NULL,
> +		       GFP_NOFS | __GFP_NOFAIL);
>   	return 0;
>   }
>
> @@ -4829,16 +4830,18 @@ btrfs_init_new_buffer(struct btrfs_trans_handle =
*trans, struct btrfs_root *root,
>   		 * EXTENT bit to differentiate dirty pages.
>   		 */
>   		if (buf->log_index =3D=3D 0)
> -			set_extent_dirty(&root->dirty_log_pages, buf->start,
> -					buf->start + buf->len - 1, GFP_NOFS);
> +			set_extent_bit(&root->dirty_log_pages, buf->start,
> +				       buf->start + buf->len - 1,
> +				       EXTENT_DIRTY, NULL, GFP_NOFS);
>   		else
>   			set_extent_bit(&root->dirty_log_pages, buf->start,
>   				       buf->start + buf->len - 1,
>   				       EXTENT_NEW, NULL, GFP_NOFS);
>   	} else {
>   		buf->log_index =3D -1;
> -		set_extent_dirty(&trans->transaction->dirty_pages, buf->start,
> -			 buf->start + buf->len - 1, GFP_NOFS);
> +		set_extent_bit(&trans->transaction->dirty_pages, buf->start,
> +			       buf->start + buf->len - 1, EXTENT_DIRTY, NULL,
> +			       GFP_NOFS);
>   	}
>   	/* this returns a buffer locked for blocking */
>   	return buf;
