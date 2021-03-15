Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523DE33ADD9
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Mar 2021 09:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhCOIqf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Mar 2021 04:46:35 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:1994 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhCOIq0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Mar 2021 04:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615797986; x=1647333986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1B9aqyVVcoPhB+KLsCgg5ZFVw4242B4N/LJxLf59390=;
  b=HB38Ex2Sl1N3h3n0JomBStd3m6gjpMMKBo7DGeFll5RthxshLx6FMZiR
   PQel0S7Hl7BjL9CjSdfRKsNnRiwbt74R5GjzlIWvGgtK7+/rghQQ/e5wN
   8E4dz2Vahkzc4tgt/Qh3C30nRVc5tFvxM3XWgM2+rQ3YBgVbfjEhpHqO2
   L4xuYFfMEG7i10K5d3MAakH+fwMpmhmluDDgWhhRjcSq2p5Iy5sRl7HXq
   jG4fNexxVH5174b1+bR8fSd0mCSuUZxH0+Q/0OCjULw9GlnNtEdMCnDNJ
   r0/Hz2fRkKPSanuM7djcaxQqBYsV9+Brzpi7bERTLfYAQeaYQdTDAzYkZ
   Q==;
IronPort-SDR: +hhEUd1DnhA3ioPzr/3jXgRqcyh/5MNooTcj/C8ScwL4ZGTq/rHKvWtpqpHVm1UrPKZruA/UBm
 0sYRAv7La6wxXF7TyMD9vkDey+p+Br2OOvIHRANRXeL/H6J/UV1Rfl+uxTc5pBQz/wN3A03rXz
 RfqNXvO7uXHAW8Z+WDp+tC4B6d2Pdvfumxx7R14d8XOyALmVHR7di+osHGZtJmekLHWWYn+ZU6
 b7WuNTY0GdpCplK7tW56Qbzvm1yKK9Et2BzSyalCXUFmlxEihWRTm08h5qZ2D5ttuSUKIm4iqf
 MTo=
X-IronPort-AV: E=Sophos;i="5.81,249,1610380800"; 
   d="scan'208";a="166645050"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2021 16:46:26 +0800
IronPort-SDR: 0kauH/ZjorYZ1Mo/od7Rk1oJKufKp6lhR+Ewkshaevklgg/OMRoEsgzSOu9tlt9v92cILQ9Dmw
 1ZzdYhV2WTx+8FQieAE2pTtKDUa2RQqT8ZGbSljocDsMPl66BoD8DgbabXf0/PE8DXajGRw4M7
 IbPQljN0nb2fxHdHgLKWj23fIaH7wEftX2cY3+ocFJ+bmkmHeSgvHqd5p0LzYh0x4DKMfvLzep
 2tGDsgaGNRj6n2W+A2vRR9oraJlQkAxX3udyLKYwRonuTCDHbk+uzsj1gjuEr+ELRe3ZNJeqp1
 L8edzjm++J+o4T/wt5BbvcsZ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 01:28:52 -0700
IronPort-SDR: +6HCpqnxUM5yiIi/OGXauIUVhaG8Y/kFkrklwBgE+zrD9vOXF7w7mf9CS7QkhH83FLIJ7QzrEO
 ogELxzWibfUhJOIBImcXOgxIpbsr89FAtXhX9+HkHY9LNRaMeWNhPW90Qa7stJXjH6dUlAaKZ5
 mHT/i3PxhuXHmrz+oMmvd1Um2tz2LcOsk2jj8neTH1RDM+k1I/O3Q4yYV8SC5YAXD/vbSOGnjx
 1ECfCyaZsQHitTDhPXeErS16/3q5mLu9teERMlrMQAoElP4Ub/b4mXD2FdLA023efsDL6qTfMq
 uQg=
WDCIronportException: Internal
Received: from g03c9y2.ad.shared (HELO naota-xeon) ([10.225.48.23])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 01:46:26 -0700
Date:   Mon, 15 Mar 2021 17:46:24 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: fix linked list corruption after log root
 tree allocation failure
Message-ID: <20210315084547.jz4fupfpodsbr4ec@naota-xeon>
References: <b4746dac89274ef11314a6abacc58a27c5935a1f.1615475093.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4746dac89274ef11314a6abacc58a27c5935a1f.1615475093.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good to me. Thanks.
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>

On Thu, Mar 11, 2021 at 03:13:30PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When using a zoned filesystem, while syncing the log, if we fail to
> allocate the root node for the log root tree, we are not removing the
> log context we allocated on stack from the list of log contextes of the
> log root tree. This means after the return from btrfs_sync_log() we get
> a corrupted linked list.
> 
> Fix this by allocating the node before adding our stack allocated context
> to the list of log contextes of the log root tree.
> 
> Fixes: 3ddebf27fcd3a9 ("btrfs: zoned: reorder log node allocation on zoned filesystem")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/tree-log.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 2f1acc9aea9e..92a368627791 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -3169,10 +3169,6 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
>  
>  	mutex_lock(&log_root_tree->log_mutex);
>  
> -	index2 = log_root_tree->log_transid % 2;
> -	list_add_tail(&root_log_ctx.list, &log_root_tree->log_ctxs[index2]);
> -	root_log_ctx.log_transid = log_root_tree->log_transid;
> -
>  	if (btrfs_is_zoned(fs_info)) {
>  		if (!log_root_tree->node) {
>  			ret = btrfs_alloc_log_tree_node(trans, log_root_tree);
> @@ -3183,6 +3179,10 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
>  		}
>  	}
>  
> +	index2 = log_root_tree->log_transid % 2;
> +	list_add_tail(&root_log_ctx.list, &log_root_tree->log_ctxs[index2]);
> +	root_log_ctx.log_transid = log_root_tree->log_transid;
> +
>  	/*
>  	 * Now we are safe to update the log_root_tree because we're under the
>  	 * log_mutex, and we're a current writer so we're holding the commit
> -- 
> 2.28.0
> 
