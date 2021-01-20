Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A39E2FD3E6
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 16:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388381AbhATPX2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 10:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732023AbhATPJM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 10:09:12 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D439C0613C1
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jan 2021 07:08:30 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id 19so25589670qkm.8
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jan 2021 07:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=o3sHudAba8mxvCtjHDJK0MBVskEXRleGngNseXiGKQI=;
        b=GXnE7EFLYjJndeXpIYsQgvHE/zvhWulYyI1VYQmb26ExObt0yqirXE8fWF4EoE0LDF
         1Xndx7O2DFIbYM7/vvMGij7KgLeNeSRD11+ktlgaWkUhn9yMR5A31bvcD3/3SzoR5oYE
         4FCzEdpdBRf41sllkddye0rN8jhKU5Qg8L7xabw/fUnstyIiMqHSRT3xnem0SHz0/h3H
         1cPMNXXCfwOi+801vyaU3RUqGJ2Y3iW+F0tymk/HELdkZB7cBbvlYHLZvjJgCSrptIUb
         WNYm+8fKr1R4IKqDntB5KGL1PbRUuEJUlCuXSJqmXn8R3BwvrJ3joPaiEzuJkLRN6nfO
         QFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o3sHudAba8mxvCtjHDJK0MBVskEXRleGngNseXiGKQI=;
        b=hB4dRVZcMTZimbenybn1sMIWCz5VlHV3734Y0il7unVUusGuT2n/emORqAJOJX/8/M
         i94jfs+0RFi5fPZ+WdCp0W3wNGa9U6MUVmS5kpqGQ8O+jRxUIJu+UuVNIR6GcSpwaJFp
         TpLxeVfaCKw08l9ud1EvzoijfkSTdLgzSXaoYJ4lzpu9mAGrVqo1bcIEDyewr70wPSEl
         Ke4G+peUt9g81LNfun7VPYNYaUYzERf/6nqmIRIfGdyF4KZSrMG4A9bovEKK5J1Xn8Rn
         EUwJPw2zdlzAgeuS8VpB5T/enstlO3BxQKYF+XuEZ30ioGoHUvwkzu/gVaMJrxoRugaz
         vkIA==
X-Gm-Message-State: AOAM530zEop0IgNEIQYO6kZEaEM6EhRwAsKrN51AxezBfvZ/i0R14BHv
        FKVg+Ft3vb3QYzlPs5zmPUu1v90PXKWnjZzWwwI=
X-Google-Smtp-Source: ABdhPJww3KtnUBHhWC919JWH3o44vM6CBNFNTqtUCibqTSUTM0Xwp6cjDjUlH/9V+SMC7AkdUrrKXA==
X-Received: by 2002:ae9:e858:: with SMTP id a85mr3022724qkg.279.1611155309356;
        Wed, 20 Jan 2021 07:08:29 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 1sm1453288qki.50.2021.01.20.07.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 07:08:27 -0800 (PST)
Subject: Re: [PATCH v4 13/18] btrfs: introduce read_extent_buffer_subpage()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-14-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <9d2c3346-0194-5f9a-8c0f-05eb4acbc2dc@toxicpanda.com>
Date:   Wed, 20 Jan 2021 10:08:27 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210116071533.105780-14-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/16/21 2:15 AM, Qu Wenruo wrote:
> Introduce a new helper, read_extent_buffer_subpage(), to do the subpage
> extent buffer read.
> 
> The difference between regular and subpage routines are:
> - No page locking
>    Here we completely rely on extent locking.
>    Page locking can reduce the concurrency greatly, as if we lock one
>    page to read one extent buffer, all the other extent buffers in the
>    same page will have to wait.
> 
> - Extent uptodate condition
>    Despite the existing PageUptodate() and EXTENT_BUFFER_UPTODATE check,
>    We also need to check btrfs_subpage::uptodate_bitmap.
> 
> - No page loop
>    Just one page, no need to loop, this greately simplified the subpage
>    routine.
> 
> This patch only implemented the bio submit part, no endio support yet.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/extent_io.c | 70 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 70 insertions(+)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 9414219fa28b..291ff76d5b2e 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5718,6 +5718,73 @@ void set_extent_buffer_uptodate(struct extent_buffer *eb)
>   	}
>   }
>   
> +static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
> +				      int mirror_num)
> +{
> +	struct btrfs_fs_info *fs_info = eb->fs_info;
> +	struct extent_io_tree *io_tree;
> +	struct page *page = eb->pages[0];
> +	struct bio *bio = NULL;
> +	int ret = 0;
> +
> +	ASSERT(!test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags));
> +	ASSERT(PagePrivate(page));
> +	io_tree = &BTRFS_I(fs_info->btree_inode)->io_tree;
> +
> +	if (wait == WAIT_NONE) {
> +		ret = try_lock_extent(io_tree, eb->start,
> +				      eb->start + eb->len - 1);
> +		if (ret <= 0)
> +			return ret;
> +	} else {
> +		ret = lock_extent(io_tree, eb->start, eb->start + eb->len - 1);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret = 0;
> +	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags) ||
> +	    PageUptodate(page) ||
> +	    btrfs_subpage_test_uptodate(fs_info, page, eb->start, eb->len)) {
> +		set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
> +		unlock_extent(io_tree, eb->start, eb->start + eb->len - 1);
> +		return ret;
> +	}
> +
> +	clear_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
> +	eb->read_mirror = 0;
> +	atomic_set(&eb->io_pages, 1);
> +	check_buffer_tree_ref(eb);

We need btrfs_subpage_clear_error() here as well.  Thanks,

Josef
