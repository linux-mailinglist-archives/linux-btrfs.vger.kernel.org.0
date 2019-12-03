Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C097B10F9C2
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 09:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLCIY3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Dec 2019 03:24:29 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:32889 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfLCIY3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Dec 2019 03:24:29 -0500
Received: by mail-pj1-f66.google.com with SMTP id r67so1230993pjb.0
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Dec 2019 00:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=31Wazc/ZTiWcb1CXcXJeEg0Mz0oNeqHL2X/90OnuYrM=;
        b=j5o7BMK2ZXxEEORVo5Na68Zpr7mBavPX+ck25DD6gnPsKPABMIXcAbM2H3RTO9fMl+
         IaWSWEMvBEoy/0Aj9twf+jOTx5XyR47oDaKHx8hjubl0qldlet/ETiXtE0HUtGFbN3le
         NvE1fHb32TrJadjzdQN6kX9GxkNfb3TWo6iBbybqbpALisE8ldpCioerd6K3f6zIt3UH
         L+EKmTGvXBHE42tAyv7tzYIm6lmTdCaEow4pWBSDTn0QRItTXrxGinww8Y/jJOqggi3Y
         pzdGLRtmeMII/uJpJoV1Jf+b9ZCn/ouml/s1n2bAlOQHnxhFaJ8KVYgSsMnEbWTsPKh0
         IDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=31Wazc/ZTiWcb1CXcXJeEg0Mz0oNeqHL2X/90OnuYrM=;
        b=Tm/nCSvDbeXW0SadVA6DAa1IVlBzwOr59ZXAUaD1Iceqd0oTcYl2CPDHpfse7MHl2u
         dCjoE8TtDqcPQVXDM5bauXXrM2dIh4B7sgnyGMFS7fTEWajxF3WS11uJSD+q3W0h/RvT
         xEnzeZajphs2JB28Tf+02qpAKYp7p7QMm/i9aSOniq9A3iXFhiYbG+gV9FJvu0/+gC38
         xOJKyILjrIzhqA+SddC5gTIUcqD5/GPhtXeQptF38VLv/JXjpUSW7vkjWOfjRFb9vsK1
         NbVKO/FVEFlLEb7R/xJbXgxImoNXnbDKCO5xV1kf2UhaH2QegPEPACBtLKFzyNzq73Sf
         szZA==
X-Gm-Message-State: APjAAAUm4zxikxKJC9eDNcO3NRfVNXpIiWW/cg0hxN4/tTOHEqglRGT9
        fJY+cqXrAmIIfjEdsCo0VU7KcA==
X-Google-Smtp-Source: APXvYqwEseCpUZLzzrjv9zB+GdINJs0a5tpJtzJAw8DMG1h+OtnIah9FDAcvrtsMmIYH2JekPuiXdw==
X-Received: by 2002:a17:90a:2469:: with SMTP id h96mr4132142pje.121.1575361468517;
        Tue, 03 Dec 2019 00:24:28 -0800 (PST)
Received: from vader ([2620:10d:c090:180::c0f1])
        by smtp.gmail.com with ESMTPSA id d22sm2347780pgg.52.2019.12.03.00.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 00:24:27 -0800 (PST)
Date:   Tue, 3 Dec 2019 00:24:26 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
Subject: Re: [PATCH] btrfs: remove unused condition check in
 btrfs_page_mkwrite()
Message-ID: <20191203082426.GC829117@vader>
References: <a84442bc-304b-2514-272e-ea89aae4b992@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a84442bc-304b-2514-272e-ea89aae4b992@huawei.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 03, 2019 at 04:16:43PM +0800, Yunfeng Ye wrote:
> The condition '!ret2' is always true. so remove the unused condition
> check.
> 
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>

For this sort of change, one should mention how the code got in this
state. In this case, commit 717beb96d969 ("Btrfs: fix regression in
btrfs_page_mkwrite() from vm_fault_t conversion") left behind the check
after moving this code out of the goto.

Ohter than that,

Reviewed-by: Omar Sandoval <osandov@fb.com>

> ---
>  fs/btrfs/inode.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 56032c518b26..eef2432597e2 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9073,7 +9073,6 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
>  		ret = VM_FAULT_SIGBUS;
>  		goto out_unlock;
>  	}
> -	ret2 = 0;
> 
>  	/* page is wholly or partially inside EOF */
>  	if (page_start + PAGE_SIZE > size)
> @@ -9097,12 +9096,10 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
> 
>  	unlock_extent_cached(io_tree, page_start, page_end, &cached_state);
> 
> -	if (!ret2) {
> -		btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
> -		sb_end_pagefault(inode->i_sb);
> -		extent_changeset_free(data_reserved);
> -		return VM_FAULT_LOCKED;
> -	}
> +	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
> +	sb_end_pagefault(inode->i_sb);
> +	extent_changeset_free(data_reserved);
> +	return VM_FAULT_LOCKED;
> 
>  out_unlock:
>  	unlock_page(page);
> -- 
> 2.7.4
> 
