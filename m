Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82AAF374B52
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 May 2021 00:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbhEEWlw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 May 2021 18:41:52 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:32981 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229602AbhEEWlw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 May 2021 18:41:52 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0FA165C0180;
        Wed,  5 May 2021 18:40:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 05 May 2021 18:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=v/oxCzio1sovVr8VxTccdRB/yNq
        3GjT3fmhHkZj3sfE=; b=J+qbxcwayDWC2J8n2zOyaYsWvFiQgsVHLCEz12O9llG
        /KX7quTttyDzx97qZu64AoxeUMQWEdvAeFgkNSGWisn4aEEe3u84Wvhs+QZ9KADD
        IZkwcJOQpp2zA5Pck0p6qN2kI2+gxFO8OqHz3mpAsJuEoftbU3+zKU3z0xim49PC
        pJJDPvGA3F053fT/gUFHmvN6uR9ZRuLsG5JIX4WPqe/mciNfnf98G/hkpQIG6j5Z
        svyzMCD0QvlQK1VmYNAghMhFKAlmvDMf1G3K8v/o7ggUjhQ4Ttv1lo27Uc0ORYA1
        HnT3I57UkAOvoPo+VwWrNZ73VZKY0uekIsQYcckfCfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=v/oxCz
        io1sovVr8VxTccdRB/yNq3GjT3fmhHkZj3sfE=; b=t1MLVVdLFL+32QrNt07izo
        pZa7YJlbco8RUy/37a5ev5v/pachDbSaarZB8fL5giWK5zeO4IrTEAd6qpFfYlU/
        Bjbz2NJCIl5Y0AQckVLR8VmwCvAb2iKV9Xf/eU7T/9oC/E7sKYcmn5y8ZhQTNwBX
        h7CAvsdMXIBi+hwAY2ZZw6zx46QDDLdUTdTb7+JUTsOhfrhDSWs2KuGeaF11PX+a
        tKHR3gOAzgp+NQpg6nim6sfvuKhENlPkmhiJF0KTeV/iMzXyFPhqlGF6zWErKs86
        t3uXNpquxTWr0FcmI2UaHmCMje0y7zLCdocNvSHBV/io3SlY4DIYLqgJc5nbFvbg
        ==
X-ME-Sender: <xms:9h6TYPRT9eRr1HDWR-pLl86qUwh-fIRNYRL_Y9cFSqW-TFaDYd9VIA>
    <xme:9h6TYAwTyCpg7j8GxGrXQy36Rf4VVGOZ-7gKkb7uLUWk0HZXK24-9ZNaYzvWV_8CL
    _ntITQHgXXKClRqFC4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdefledguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhephe
    duveelkeeiteelveeiuefhudehtdeigfehkeeffeegledvueevgefgudeuveefnecukfhp
    pedvtdejrdehfedrvdehfedrjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:9h6TYE08veZiB5O2Qz-IC4ni_85tjtXNa6_3h-srtYi0pgdUg6dC2g>
    <xmx:9h6TYPBGn-QOL5s4v3OfXPrFWS4nOeqNrVU8IUC-yy2ZvVtxGiTdzA>
    <xmx:9h6TYIiYEDMaL56PgQ6FzQx9QIw9vQEztXR07jOJe0N3IJCkkmrxPw>
    <xmx:9x6TYLsuUyRwv5dGSdliwjRfNTgqeeMiCKw52_5NRy9-ZzPj1WMn6w>
Received: from localhost (unknown [207.53.253.7])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Wed,  5 May 2021 18:40:54 -0400 (EDT)
Date:   Wed, 5 May 2021 15:40:52 -0700
From:   Boris Burkov <boris@bur.io>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     dsterba@suse.com, josef@toxicpanda.com, clm@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: add goto in btrfs_defrag_file for error
 handling
Message-ID: <YJMe9CLl6zib1WvF@zen>
References: <1620177988-6664-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620177988-6664-1-git-send-email-tiantao6@hisilicon.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 05, 2021 at 09:26:28AM +0800, Tian Tao wrote:
> ret is assigned -EAGAIN at line 1455 and then reassigned defrag_count
> at line 1547 after exiting the while loop.this causes the
> btrfs_defrag_file function to not return the correct value in the event
> of an error, this patch fixed this issue.

This looks like a correct fix, in that it locally improves what it
claims to improve. However, I have some questions about the style and
consistency of the function as a whole as a result. I think Dave had
a similar comment in his very first reply on v1.

The loop has the following early exit points:
fs unmounted
cancellation
swapfile/error in cluster_pages_for_defrag
newer_off == (u64)-1
error (ENOMEM or ENOENT) in find_new_extents

To me, it is confusing that of all these, only cancellation goes to a
label called "error". I would expect at least the swapfile/cluster case
to also jump to error. find_new_extents is interesting, because ENOENT
could be semantically special as an error and warrant a break rather
than a goto error, so we ought to figure that out correctly too.

If there is some good reason that only cancellation should receive this
treatment, and that some early exit cases should break or goto out_ra
then I would at least name the new label "cancel" and write a comment or
a note in the git commit explaining the difference.

Thinking out loud, I suspect a way to really fix this messy function is
to do something like lift the contents of the while loop into a helper
function which returns the next incremental defrag_count, an error, or 0
for done.

Thanks for the fix,
Boris

> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
> 
> v2: rewrite the patch, patch name and commit message.
> ---
>  fs/btrfs/ioctl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index ee1dbab..5713450 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1453,7 +1453,7 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
>  		if (btrfs_defrag_cancelled(fs_info)) {
>  			btrfs_debug(fs_info, "defrag_file cancelled");
>  			ret = -EAGAIN;
> -			break;
> +			goto error;
>  		}
>  
>  		if (!should_defrag_range(inode, (u64)i << PAGE_SHIFT,
> @@ -1531,6 +1531,8 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
>  		}
>  	}
>  
> +	ret = defrag_count;
> +error:
>  	if ((range->flags & BTRFS_DEFRAG_RANGE_START_IO)) {
>  		filemap_flush(inode->i_mapping);
>  		if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
> @@ -1544,8 +1546,6 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
>  		btrfs_set_fs_incompat(fs_info, COMPRESS_ZSTD);
>  	}
>  
> -	ret = defrag_count;
> -
>  out_ra:
>  	if (do_compress) {
>  		btrfs_inode_lock(inode, 0);
> -- 
> 2.7.4
> 
