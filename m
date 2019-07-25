Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE8FF74772
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2019 08:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfGYGoa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Jul 2019 02:44:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:51326 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725808AbfGYGoa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Jul 2019 02:44:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2ED05B039
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2019 06:44:28 +0000 (UTC)
Subject: Re: [PATCH v2 1/5] btrfs: extent_io: Do extra check for extent buffer
 read write functions
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20190725061222.9581-1-wqu@suse.com>
 <20190725061222.9581-2-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8b314cb7-880f-a5fc-0f8f-dd45116351a1@suse.com>
Date:   Thu, 25 Jul 2019 09:44:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725061222.9581-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 25.07.19 г. 9:12 ч., Qu Wenruo wrote:
> Although we have start, len check for extent buffer reader/write (e.g.
> read_extent_buffer()), those checks has its limitations:
> - No overflow check
>   Values like start = 1024 len = -1024 can still pass the basic
>    (start + len) > eb->len check.
> 
> - Checks are not consistent
>   For read_extent_buffer() we only check (start + len) against eb->len.
>   While for memcmp_extent_buffer() we also check start against eb->len.
> 
> - Different error reporting mechanism
>   We use WARN() in read_extent_buffer() but BUG() in
>   memcpy_extent_buffer().
> 
> - Still modify memory if the request is obviously wrong
>   In read_extent_buffer() even we find (start + len) > eb->len, we still
>   call memset(dst, 0, len), which can eaisly cause memory access error
>   if start + len overflows.
> 
> To address above problems, this patch creates a new common function to
> check such access, check_eb_range().
> - Add overflow check
>   This function checks start, start + len against eb->len and overflow
>   check.
> 
> - Unified checks
> 
> - Unified error reports
>   Will call WARN() if CONFIG_BTRFS_DEBUG is configured.
>   And also do btrfs_warn() message for non-debug build.
> 
> - Exit ASAP if check fails
>   No more possible memory corruption.
> 
> - Add extra comment for @start @len used in those functions
>   Even experienced developers sometimes get confused with the @start
>   @len with logical address in those functions.
>   I'm not sure what's the cause, maybe it's the extent_buffer::start
>   naming.
>   For now, just add some comment.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=202817
> [ Inspired by above report, the report itself is already addressed ]
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 76 +++++++++++++++++++++++---------------------
>  1 file changed, 39 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index db337e53aab3..d44a629e0cce 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5429,6 +5429,28 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
>  	return ret;
>  }
>  
> +/*
> + * Check if the [start, start + len) range is valid before reading/writing
> + * the eb.
> + * NOTE: @start and @len are offset *INSIDE* the eb, *NOT* logical address.

With proper naming a comment like that should be redundant.

> + *
> + * Caller should not touch the dst/src memory if this function returns error.
> + */
> +static int check_eb_range(const struct extent_buffer *eb, unsigned long start,
> +			  unsigned long len)
> +{
> +	/* start, start + len should not go beyond eb->len nor overflow */
> +	if (unlikely(start > eb->len || start + len > eb->len ||
> +		     len > eb->len)) {
> +		btrfs_warn(eb->fs_info,
> +"btrfs: bad eb rw request, eb bytenr=%llu len=%lu rw start=%lu len=%lu\n",
> +			   eb->start, eb->len, start, len);
> +		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
>  void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
>  			unsigned long start, unsigned long len)
>  {
> @@ -5440,12 +5462,8 @@ void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
>  	size_t start_offset = offset_in_page(eb->start);
>  	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
>  
> -	if (start + len > eb->len) {
> -		WARN(1, KERN_ERR "btrfs bad mapping eb start %llu len %lu, wanted %lu %lu\n",
> -		     eb->start, eb->len, start, len);
> -		memset(dst, 0, len);
> +	if (check_eb_range(eb, start, len))
>  		return;
> -	}
>  
>  	offset = offset_in_page(start_offset + start);
>  
> @@ -5554,8 +5572,8 @@ int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
>  	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
>  	int ret = 0;
>  
> -	WARN_ON(start > eb->len);
> -	WARN_ON(start + len > eb->start + eb->len);
> +	if (check_eb_range(eb, start, len))
> +		return -EINVAL;
>  
>  	offset = offset_in_page(start_offset + start);
>  
> @@ -5609,8 +5627,8 @@ void write_extent_buffer(struct extent_buffer *eb, const void *srcv,
>  	size_t start_offset = offset_in_page(eb->start);
>  	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
>  
> -	WARN_ON(start > eb->len);
> -	WARN_ON(start + len > eb->start + eb->len);
> +	if (check_eb_range(eb, start, len))
> +		return;
>  
>  	offset = offset_in_page(start_offset + start);
>  
> @@ -5639,8 +5657,8 @@ void memzero_extent_buffer(struct extent_buffer *eb, unsigned long start,
>  	size_t start_offset = offset_in_page(eb->start);
>  	unsigned long i = (start_offset + start) >> PAGE_SHIFT;
>  
> -	WARN_ON(start > eb->len);
> -	WARN_ON(start + len > eb->start + eb->len);
> +	if (check_eb_range(eb, start, len))
> +		return;
>  
>  	offset = offset_in_page(start_offset + start);
>  
> @@ -5684,6 +5702,10 @@ void copy_extent_buffer(struct extent_buffer *dst, struct extent_buffer *src,
>  	size_t start_offset = offset_in_page(dst->start);
>  	unsigned long i = (start_offset + dst_offset) >> PAGE_SHIFT;
>  
> +	if (check_eb_range(dst, dst_offset, len) ||
> +	    check_eb_range(src, src_offset, len))
> +		return;
> +
>  	WARN_ON(src->len != dst_len);
>  
>  	offset = offset_in_page(start_offset + dst_offset);
> @@ -5872,7 +5894,6 @@ static void copy_pages(struct page *dst_page, struct page *src_page,
>  void memcpy_extent_buffer(struct extent_buffer *dst, unsigned long dst_offset,
>  			   unsigned long src_offset, unsigned long len)
>  {
> -	struct btrfs_fs_info *fs_info = dst->fs_info;
>  	size_t cur;
>  	size_t dst_off_in_page;
>  	size_t src_off_in_page;
> @@ -5880,18 +5901,9 @@ void memcpy_extent_buffer(struct extent_buffer *dst, unsigned long dst_offset,
>  	unsigned long dst_i;
>  	unsigned long src_i;
>  
> -	if (src_offset + len > dst->len) {
> -		btrfs_err(fs_info,
> -			"memmove bogus src_offset %lu move len %lu dst len %lu",
> -			 src_offset, len, dst->len);
> -		BUG();
> -	}
> -	if (dst_offset + len > dst->len) {
> -		btrfs_err(fs_info,
> -			"memmove bogus dst_offset %lu move len %lu dst len %lu",
> -			 dst_offset, len, dst->len);
> -		BUG();
> -	}
> +	if (check_eb_range(dst, dst_offset, len) ||
> +	    check_eb_range(dst, src_offset, len))
> +		return;

I'm not sure about this. If the code expects memcpy_extent_buffer to
never fail then it will make more sense to do the range check outside of
this function. Otherwise it might silently fail and cause mayhem up the
call chain. Or just leave the BUG (I'd rather not).

>  
>  	while (len > 0) {
>  		dst_off_in_page = offset_in_page(start_offset + dst_offset);
> @@ -5917,7 +5929,6 @@ void memcpy_extent_buffer(struct extent_buffer *dst, unsigned long dst_offset,
>  void memmove_extent_buffer(struct extent_buffer *dst, unsigned long dst_offset,
>  			   unsigned long src_offset, unsigned long len)
>  {
> -	struct btrfs_fs_info *fs_info = dst->fs_info;
>  	size_t cur;
>  	size_t dst_off_in_page;
>  	size_t src_off_in_page;
> @@ -5927,18 +5938,9 @@ void memmove_extent_buffer(struct extent_buffer *dst, unsigned long dst_offset,
>  	unsigned long dst_i;
>  	unsigned long src_i;
>  
> -	if (src_offset + len > dst->len) {
> -		btrfs_err(fs_info,
> -			  "memmove bogus src_offset %lu move len %lu len %lu",
> -			  src_offset, len, dst->len);
> -		BUG();
> -	}
> -	if (dst_offset + len > dst->len) {
> -		btrfs_err(fs_info,
> -			  "memmove bogus dst_offset %lu move len %lu len %lu",
> -			  dst_offset, len, dst->len);
> -		BUG();
> -	}
> +	if (check_eb_range(dst, dst_offset, len) ||
> +	    check_eb_range(dst, src_offset, len))
> +		return;

DITTO as previous comment.

>  	if (dst_offset < src_offset) {
>  		memcpy_extent_buffer(dst, dst_offset, src_offset, len);
>  		return;
> 
