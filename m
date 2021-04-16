Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3679E36218D
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 15:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbhDPN66 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 09:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhDPN6y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 09:58:54 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5B4C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 06:58:28 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id h13so10210988qka.2
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 06:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=N9CbcFnLa3gFHzSpFxx7nCxitZFAQRHVoF5bvYsNBMc=;
        b=DsYjOGjusbctx2c8KM9rSZT9UJibIDUEMW3esx23nsFYLb3BlaU46YrPN18N/b2ZAC
         C7JqpYZcoITxGz7Fog6o3RHJy05zZZG2esg35Gz1meiXX8XW2arsjM0bGRGlwnSLpzS+
         AmH9ieGKZyhdndGBOVpG1h9KR4x67b/rJ6JRK7tfvXSDhWftyyucjY9NFsU1vrt1S2kM
         ixxpjTqPuLMgvHDc6gc5mDlPCejDQ35z4yMuaowJkVbhtio8OxmUb/+X82EjIlIPBzz0
         Ijb9jg4EAVMqY9FK71B9JGds8hQkq9/JnRWXT2kBCsrwmdxwQzwyhtguiQ/TU0l+KmZc
         ubIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N9CbcFnLa3gFHzSpFxx7nCxitZFAQRHVoF5bvYsNBMc=;
        b=VXUdNDDOMGHrTJnzqObAGwa/W8Wzqv4S4udZo3E8I1AT+OR4tvwa4PNxepaqt6ysFX
         QJQYRqlm6M4SxmxKzEtrftntffLzcSn/r1xab1vbWwVIRF24GSnG1CZiRRbW4it3uqSV
         kPKuJdItcyYGKcF2o0gH5irjLkvRKG43SCSvv7NmWY4XV7TnCufoZx850YxlOOmmMNlR
         K0lAkZDjU35szP+g/va0ycdYzQO1eH8JiX8BbUqDZAPsXwQbtVZfzudZyH7yN3aD4yOk
         Xlb1Wbh4+rAvVyloh2oG8QFwhUd/4FwAWEZzqczaCxZGGTDPel+fDgaecAQt2Me2v/Ez
         YthA==
X-Gm-Message-State: AOAM532NxWnup/HDfC/EUXLMNx24o1s4l2RB2g/WDzy7kJIfR23C7wtn
        PL5GUVF65in4Oc4sH6AtGk5GHj+yCcJM3w==
X-Google-Smtp-Source: ABdhPJzAnra3Xc/v2uOUWB/AT+FbSvaO5sMFiphiOBsQh1BP5XDL9KdhCA9BOcFdcHfbXTgPoSPc8w==
X-Received: by 2002:a37:a794:: with SMTP id q142mr8748800qke.216.1618581507326;
        Fri, 16 Apr 2021 06:58:27 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h8sm3876198qta.53.2021.04.16.06.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 06:58:26 -0700 (PDT)
Subject: Re: [PATCH 08/42] btrfs: pass btrfs_inode into
 btrfs_writepage_endio_finish_ordered()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210415050448.267306-1-wqu@suse.com>
 <20210415050448.267306-9-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c648d759-a7fa-74ea-28b2-4503a85d5ead@toxicpanda.com>
Date:   Fri, 16 Apr 2021 09:58:26 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210415050448.267306-9-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/15/21 1:04 AM, Qu Wenruo wrote:
> There is a pretty bad abuse of btrfs_writepage_endio_finish_ordered() in
> end_compressed_bio_write().
> 
> It passes compressed pages to btrfs_writepage_endio_finish_ordered(),
> which is only supposed to accept inode pages.
> 
> Thankfully the important info here is the inode, so let's pass
> btrfs_inode directly into btrfs_writepage_endio_finish_ordered(), and
> make @page parameter optional.
> 
> By this, end_compressed_bio_write() can happily pass page=NULL while
> still get everything done properly.
> 
> Also, to cooperate with such modification, replace @page parameter for
> trace_btrfs_writepage_end_io_hook() with btrfs_inode.
> Although this removes page_index info, the existing start/len should be
> enough for most usage.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/compression.c       |  4 +---
>   fs/btrfs/ctree.h             |  3 ++-
>   fs/btrfs/extent_io.c         | 16 ++++++++++------
>   fs/btrfs/inode.c             |  9 +++++----
>   include/trace/events/btrfs.h | 19 ++++++++-----------
>   5 files changed, 26 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 2600703fab83..4fbe3e12be71 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -343,11 +343,9 @@ static void end_compressed_bio_write(struct bio *bio)
>   	 * call back into the FS and do all the end_io operations
>   	 */
>   	inode = cb->inode;
> -	cb->compressed_pages[0]->mapping = cb->inode->i_mapping;
> -	btrfs_writepage_endio_finish_ordered(cb->compressed_pages[0],
> +	btrfs_writepage_endio_finish_ordered(BTRFS_I(inode), NULL,
>   			cb->start, cb->start + cb->len - 1,
>   			bio->bi_status == BLK_STS_OK);
> -	cb->compressed_pages[0]->mapping = NULL;
>   
>   	end_compressed_writeback(inode, cb);
>   	/* note, our inode could be gone now */
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 2c858d5349c8..505bc6674bcc 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3175,7 +3175,8 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
>   		u64 start, u64 end, int *page_started, unsigned long *nr_written,
>   		struct writeback_control *wbc);
>   int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end);
> -void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
> +void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
> +					  struct page *page, u64 start,
>   					  u64 end, int uptodate);
>   extern const struct dentry_operations btrfs_dentry_operations;
>   extern const struct iomap_ops btrfs_dio_iomap_ops;
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 7d1fca9b87f0..6d712418b67b 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2711,10 +2711,13 @@ blk_status_t btrfs_submit_read_repair(struct inode *inode,
>   
>   void end_extent_writepage(struct page *page, int err, u64 start, u64 end)
>   {
> +	struct btrfs_inode *inode;
>   	int uptodate = (err == 0);
>   	int ret = 0;
>   
> -	btrfs_writepage_endio_finish_ordered(page, start, end, uptodate);
> +	ASSERT(page && page->mapping);
> +	inode = BTRFS_I(page->mapping->host);
> +	btrfs_writepage_endio_finish_ordered(inode, page, start, end, uptodate);
>   
>   	if (!uptodate) {
>   		ClearPageUptodate(page);
> @@ -3739,7 +3742,8 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
>   		u32 iosize;
>   
>   		if (cur >= i_size) {
> -			btrfs_writepage_endio_finish_ordered(page, cur, end, 1);
> +			btrfs_writepage_endio_finish_ordered(inode, page, cur,
> +							     end, 1);
>   			break;
>   		}
>   		em = btrfs_get_extent(inode, NULL, 0, cur, end - cur + 1);
> @@ -3777,8 +3781,8 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
>   			if (compressed)
>   				nr++;
>   			else
> -				btrfs_writepage_endio_finish_ordered(page, cur,
> -							cur + iosize - 1, 1);
> +				btrfs_writepage_endio_finish_ordered(inode,
> +						page, cur, cur + iosize - 1, 1);
>   			cur += iosize;
>   			continue;
>   		}
> @@ -4842,8 +4846,8 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
>   		if (clear_page_dirty_for_io(page))
>   			ret = __extent_writepage(page, &wbc_writepages, &epd);
>   		else {
> -			btrfs_writepage_endio_finish_ordered(page, start,
> -						    start + PAGE_SIZE - 1, 1);
> +			btrfs_writepage_endio_finish_ordered(BTRFS_I(inode),
> +					page, start, start + PAGE_SIZE - 1, 1);
>   			unlock_page(page);
>   		}
>   		put_page(page);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 554effbf307e..752f0c78e1df 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -951,7 +951,8 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
>   			const u64 end = start + async_extent->ram_size - 1;
>   
>   			p->mapping = inode->vfs_inode.i_mapping;
> -			btrfs_writepage_endio_finish_ordered(p, start, end, 0);
> +			btrfs_writepage_endio_finish_ordered(inode, p, start,
> +							     end, 0);
>   
>   			p->mapping = NULL;
>   			extent_clear_unlock_delalloc(inode, start, end, NULL, 0,
> @@ -3058,16 +3059,16 @@ static void finish_ordered_fn(struct btrfs_work *work)
>   	btrfs_finish_ordered_io(ordered_extent);
>   }
>   
> -void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
> +void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
> +					  struct page *page, u64 start,
>   					  u64 end, int uptodate)
>   {
> -	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
>   	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>   	struct btrfs_ordered_extent *ordered_extent = NULL;
>   	struct btrfs_workqueue *wq;
>   
>   	ASSERT(end + 1 - start < U32_MAX);
> -	trace_btrfs_writepage_end_io_hook(page, start, end, uptodate);
> +	trace_btrfs_writepage_end_io_hook(inode, start, end, uptodate);
>   
>   	ClearPagePrivate2(page);
>   	if (!btrfs_dec_test_ordered_pending(inode, &ordered_extent, start,
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index 0551ea65374f..556967cb9688 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -654,34 +654,31 @@ DEFINE_EVENT(btrfs__writepage, __extent_writepage,
>   
>   TRACE_EVENT(btrfs_writepage_end_io_hook,
>   
> -	TP_PROTO(const struct page *page, u64 start, u64 end, int uptodate),
> +	TP_PROTO(const struct btrfs_inode *inode, u64 start, u64 end,
> +		 int uptodate),
>   
> -	TP_ARGS(page, start, end, uptodate),
> +	TP_ARGS(inode, start, end, uptodate),
>   
>   	TP_STRUCT__entry_btrfs(
>   		__field(	u64,	 ino		)
> -		__field(	unsigned long, index	)

You don't need to remove this, you could just do something like

(start & PAGE_MASK) >> PAGE_SHIFT

Check my math there, I'm a little foggy this morning.  I'd rather err on the 
side of not removing stuff from tracepoints that we can still get.  Especially 
once we start dealing with bugs from subpage support, it may be useful to track 
per-page operations via the tracepoints.  Otherwise this is a solid change.  Thanks,

Josef
