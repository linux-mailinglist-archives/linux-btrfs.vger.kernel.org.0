Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4743B80F8
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jun 2021 12:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbhF3KxU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Jun 2021 06:53:20 -0400
Received: from mout.gmx.net ([212.227.15.19]:53225 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229882AbhF3KxT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Jun 2021 06:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625050248;
        bh=SteWlTFGexHsOX1Quw4QCAN6KARsyJOGCoUwi/YFrZc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=N8rBbmTrcBzF3SCvbQV7ogaa0snWMZxZF4RXPpfexHXksYarz8pVXrdOEQe/+Ct/Y
         /h122+TtKkfxi/Mp/GHVbCo5A+YGQVYjieaEtEPun08fDtQJURT1vDa2FrMoDqFoxv
         bVZ0F6O+EarfIuBtdOjwu+fo0Y/QrWEp7j1/bRDo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mqs0R-1lUD8r0H1l-00mpvL; Wed, 30
 Jun 2021 12:50:48 +0200
Subject: Re: [PATCH 3/4] btrfs: rework btrfs_decompress_buf2page()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210630093233.238032-1-wqu@suse.com>
 <20210630093233.238032-4-wqu@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <3c12e04d-812a-87cd-4e4c-fabff10bc0d3@gmx.com>
Date:   Wed, 30 Jun 2021 18:50:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630093233.238032-4-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f5SHdzm7mfdg7wkLLFXVshZPxbkj4IA3LWC7i5cCcrIuNHYl4Sm
 BLRzIamJwpjsUX6OG0Q4ftRXOOAgfmqPKXuituWvr+D9RUb3ImdByXWtYrS94UjOFTSVr68
 CeIQk56WMtKnsMmOy4reHzibaQzIRH62kEeYggiSfoSya2Hyl1Tz4C4jWUMA0YU+2ko0/Pj
 /z1R3osp6wTUP+OvFWIzw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RuIf494XmrE=:hMZ4BUX+uab1ko0pnBHc1u
 dG9LCY/Hxc48hnGAEYieiwaPDkmvS0QaKMHS+ov/xE0sms5NunK3jbPTfArdeAyoUnvj4FciO
 dDOoh6d+Oc2MuJ0krrMD0H39JCpKWAAoRJuvM3QkIvB1V9jZJyRuME6G6F31i5ptG9SoHujLy
 vS4mU6nKiCmOw9eJbsFMmM9GuXig+vVqZ4flEoNUv5T5tNDLUvkXKbQ8I7awjdONQ9tOtUymD
 CGSNgLse5OfhJUrnWbxOONcAU2e3eylW9SszdV4vGxVWWx5o4X3RVZK/xMb4kZRvbNerybp8k
 aqx27m09AINf4xrWNkvgeSM44qhMOZbiWTNB45LhHkJjdNEIn9OfX0YuPdzc8Pai2XxNAzY1s
 j0MzkrN44KY4NBquDH3dQU7KSpyNrXEASXtdBju0gFMi4IFkbAeeWRF1BXsQMCqhwgQoxJJ0P
 pxQWe8roFPOirELcFsSqAsQzdYgaWelDUp5P0RdxLeq+cNm8/4T5+z/6wTKLvRyeIimBzcoWN
 Gxab7xuEoR8e6FhEWXELsj4I0DjYSmd42PosSgMOjKD2nI8WzmxFi5uwG2HJxvXNLqfoCKtKg
 LMav1dkL6vz35U2hQaDLKUl/BAc2POe4BysLOr8mIkhsxzaWrBLN6LhbvhzuxKjKSJDTJThKa
 hqQCdVmSORRGqLbF1jaeO++v2Z+AE5faJeH9I9r5VFyFiwoOlqOCLAx/L7lBsNdWh6pPz2WdS
 sqwDV8Jkkj2t3laSNo6vGoWus/BGaIF7bFj/HvQiET42yQprkTB55x4EE+dzLD8dB+CKjJWi/
 O0+agfcb46E1xOKdp5wexMZW+8MDMY6iNcc9LBCpGMkqez0TXbQkaUbwQbg6dosWd9W1GLSQ+
 gtqI1m2Vrbk1fd4yEqU/tLwBzJOWLv0vFqlnemaTmsJmowT1Q/GmMMA5xHT9wcuOGzY1oALI/
 lVuR07nKmcbUFGDgq9WRO7Y7sWzYM2KUrY5LcpjwXokwO9Wre3oC6y2y939UxZVfhaI5MHWn3
 cHxv/KYjrgCjaS9sTonSpy6Rz/htpRRtyGloAvNjp3dHWqwVo27JS+dTsMk2mWOkT3D0oCSCQ
 16qh30dXfEJ4zZSsXSn1SNtC6IKFCOYbMxKokE+OYA5i2aeBkUjRRujVA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/30 =E4=B8=8B=E5=8D=885:32, Qu Wenruo wrote:
> There are several bugs inside the function btrfs_decompress_buf2page()
>
> - @start_byte doesn't take bvec.bv_offset into consideration
>    Thus it can't handle case where the target range is not page aligned.
>
> - Too many helper variables
>    There are tons of helper variables, @buf_offset, @current_buf_start,
>    @start_byte, @prev_start_byte, @working_bytes, @bytes.
>    This hurts anyone who wants to read the function.
>
> - No obvious main cursor for the iteartion
>    A new problem caused by previous problem.
>
> - Comments for parameter list makes no sense
>    Like @buf_start is the offset to @buf, or offset inside the full
>    decompressed extent? (Spoiler alert, the later case)
>    And @total_out acts more like @buf_start + @size_of_buf.
>
>    The worst is @disk_start.
>    The real meaning of it is the file offset of the full decompressed
>    extent.
>
> This patch will rework the whole function by:
>
> - Add a proper comment with ASCII art to explain the parameter list
>
> - Rework parameter list
>    The old @buf_start is renamed to @decompressed, to show how many byte=
s
>    are already decompressed inside the full decompressed extent.
>    The old @total_out is replaced by @buf_len, which is the decompressed
>    data size.
>    For old @disk_start and @bio, just pass @compressed_bio in.
>
> - Use single main cursor
>    The main cursor will be @cur_file_offset, to show what's the current
>    file offset.
>    Other helper variables will be declared inside the main loop, and onl=
y
>    minimal amount of helper variables:
>    * offset_inside_decompressed_buf:	The only real helper
>    * copy_start_file_offset:		File offset we start memcpy
>    * bvec_file_offset:			File offset of current bvec
>
> Even with all these extensive comments, the final function is still
> smaller than the original function, which is definitely a win.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/compression.c | 159 ++++++++++++++++++++---------------------
>   fs/btrfs/compression.h |   5 +-
>   fs/btrfs/lzo.c         |   8 +--
>   fs/btrfs/zlib.c        |  12 ++--
>   fs/btrfs/zstd.c        |   6 +-
>   5 files changed, 89 insertions(+), 101 deletions(-)
>
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 8318e56b5ab4..28f24c8ac3c1 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -1263,96 +1263,93 @@ void __cold btrfs_exit_compress(void)
>   }
>
>   /*
> - * Copy uncompressed data from working buffer to pages.
> + * Copy decompressed data from working buffer to pages.
>    *
> - * buf_start is the byte offset we're of the start of our workspace buf=
fer.
> + * @buf:		The decompressed data buffer
> + * @buf_len:		The decompressed data length
> + * @decompressed:	Number of bytes that is already decompressed inside t=
he
> + * 			compressed extent
> + * @cb:			The compressed extent descriptor
> + * @orig_bio:		The original bio that the caller wants to read for
>    *
> - * total_out is the last byte of the buffer
> + * An easier to understand graph is like below:
> + *
> + * 		|<- orig_bio ->|     |<- orig_bio->|
> + * 	|<-------      full decompressed extent      ----->|
> + * 	|<-----------    @cb range   ---->|
> + * 	|			|<-- @buf_len -->|
> + * 	|<--- @decompressed --->|
> + *
> + * Note that, @cb can be a subpage of the full decompressed extent, but
> + * @cb->start always has the same as the orig_file_offset value of the =
full
> + * decompressed extent.
> + *
> + * When reading compressed extent, we have to read the full compressed =
extent,
> + * while @orig_bio may only want part of the range.
> + * Thus this function will ensure only data covered by @orig_bio will b=
e copied
> + * to.
> + *
> + * Return 0 if we have copied all needed contents for @orig_bio.
> + * Return >0 if we need continue decompress.
>    */
> -int btrfs_decompress_buf2page(const char *buf, unsigned long buf_start,
> -			      unsigned long total_out, u64 disk_start,
> -			      struct bio *bio)
> +int btrfs_decompress_buf2page(const char *buf, u32 buf_len,
> +			      struct compressed_bio *cb, u32 decompressed)
>   {
> -	unsigned long buf_offset;
> -	unsigned long current_buf_start;
> -	unsigned long start_byte;
> -	unsigned long prev_start_byte;
> -	unsigned long working_bytes =3D total_out - buf_start;
> -	unsigned long bytes;
> -	struct bio_vec bvec =3D bio_iter_iovec(bio, bio->bi_iter);
> -
> -	/*
> -	 * start byte is the first byte of the page we're currently
> -	 * copying into relative to the start of the compressed data.
> -	 */
> -	start_byte =3D page_offset(bvec.bv_page) - disk_start;
> -
> -	/* we haven't yet hit data corresponding to this page */
> -	if (total_out <=3D start_byte)
> -		return 1;
> -
> -	/*
> -	 * the start of the data we care about is offset into
> -	 * the middle of our working buffer
> -	 */
> -	if (total_out > start_byte && buf_start < start_byte) {
> -		buf_offset =3D start_byte - buf_start;
> -		working_bytes -=3D buf_offset;
> -	} else {
> -		buf_offset =3D 0;
> -	}
> -	current_buf_start =3D buf_start;
> -
> -	/* copy bytes from the working buffer into the pages */
> -	while (working_bytes > 0) {
> -		bytes =3D min_t(unsigned long, bvec.bv_len,
> -				PAGE_SIZE - (buf_offset % PAGE_SIZE));
> -		bytes =3D min(bytes, working_bytes);
> -
> -		memcpy_to_page(bvec.bv_page, bvec.bv_offset, buf + buf_offset,
> -			       bytes);
> -		flush_dcache_page(bvec.bv_page);
> -
> -		buf_offset +=3D bytes;
> -		working_bytes -=3D bytes;
> -		current_buf_start +=3D bytes;
> -
> -		/* check if we need to pick another page */
> -		bio_advance(bio, bytes);
> -		if (!bio->bi_iter.bi_size)
> -			return 0;
> -		bvec =3D bio_iter_iovec(bio, bio->bi_iter);
> -		prev_start_byte =3D start_byte;
> -		start_byte =3D page_offset(bvec.bv_page) - disk_start;
> +	const u64 orig_file_offset =3D cb->start;

This part can underflow when the compressed extent is reflinked to a
lower file offset.

Thus we can't use file_offset as the main cursor, as underflowed value
can easily screw up later max/min calculation.

This can be exposed by btrfs/097.

I'll need to find a better cursor for this case then.

Thanks,
Qu

> +	const u64 buf_file_offset =3D orig_file_offset + decompressed;
> +	struct bio *orig_bio =3D cb->orig_bio;
> +	u64 cur_file_offset =3D buf_file_offset;
> +
> +	/* The main loop to do the copy */
> +	while (cur_file_offset < buf_file_offset + buf_len) {
> +		struct bio_vec bvec =3D bio_iter_iovec(orig_bio,
> +						     orig_bio->bi_iter);
> +		size_t copy_len;
> +		u32 offset_inside_decompressed_buf;
> +		u64 copy_start_file_offset;
> +		u64 bvec_file_offset;
> +
> +		bvec =3D bio_iter_iovec(orig_bio, orig_bio->bi_iter);
> +		bvec_file_offset =3D page_offset(bvec.bv_page) + bvec.bv_offset;
> +
> +		/* Haven't reached the bvec range, exit */
> +		if (buf_file_offset + buf_len <=3D bvec_file_offset)
> +			return 1;
> +
> +		copy_start_file_offset =3D max(bvec_file_offset, cur_file_offset);
> +		copy_len =3D min(bvec_file_offset + bvec.bv_len,
> +			       buf_file_offset + buf_len) -
> +			   copy_start_file_offset;
> +		ASSERT(copy_len);
> +		ASSERT(copy_len <=3D buf_file_offset + buf_len -
> +				   copy_start_file_offset);
>
>   		/*
> -		 * We need to make sure we're only adjusting
> -		 * our offset into compression working buffer when
> -		 * we're switching pages.  Otherwise we can incorrectly
> -		 * keep copying when we were actually done.
> +		 * Extra range check to ensure we didn't go beyond
> +		 * @buf + @buf_len.
> +		 *
> +		 * (copy_start_file_offset - orig_file_offset) is the offset
> +		 * inside the full decompressed extent.
> +		 * then (- decompressed) we got the offset inside the
> +		 * decompressed data @buf, which should not exceed @buf_len.
>   		 */
> -		if (start_byte !=3D prev_start_byte) {
> -			/*
> -			 * make sure our new page is covered by this
> -			 * working buffer
> -			 */
> -			if (total_out <=3D start_byte)
> -				return 1;
> -
> -			/*
> -			 * the next page in the biovec might not be adjacent
> -			 * to the last page, but it might still be found
> -			 * inside this working buffer. bump our offset pointer
> -			 */
> -			if (total_out > start_byte &&
> -			    current_buf_start < start_byte) {
> -				buf_offset =3D start_byte - buf_start;
> -				working_bytes =3D total_out - start_byte;
> -				current_buf_start =3D buf_start + buf_offset;
> -			}
> +		offset_inside_decompressed_buf =3D copy_start_file_offset -
> +						 orig_file_offset -
> +						 decompressed;
> +		ASSERT(offset_inside_decompressed_buf < buf_len);
> +		memcpy_to_page(bvec.bv_page, bvec.bv_offset,
> +			       buf + offset_inside_decompressed_buf,
> +			       copy_len);
> +		cur_file_offset +=3D copy_len;
> +
> +		/* Check if we need to advanced to next bvec */
> +		if (cur_file_offset >=3D bvec_file_offset + bvec.bv_len) {
> +			bio_advance(orig_bio, copy_len);
> +			/* Finished the bio */
> +			if (!orig_bio->bi_iter.bi_size)
> +				return 0;
>   		}
>   	}
> -
>   	return 1;
>   }
>
> diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
> index c359f20920d0..399be0b435bf 100644
> --- a/fs/btrfs/compression.h
> +++ b/fs/btrfs/compression.h
> @@ -86,9 +86,8 @@ int btrfs_compress_pages(unsigned int type_level, stru=
ct address_space *mapping,
>   			 unsigned long *total_out);
>   int btrfs_decompress(int type, unsigned char *data_in, struct page *de=
st_page,
>   		     unsigned long start_byte, size_t srclen, size_t destlen);
> -int btrfs_decompress_buf2page(const char *buf, unsigned long buf_start,
> -			      unsigned long total_out, u64 disk_start,
> -			      struct bio *bio);
> +int btrfs_decompress_buf2page(const char *buf, u32 buf_len,
> +			      struct compressed_bio *cb, u32 decompressed);
>
>   blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, =
u64 start,
>   				  unsigned int len, u64 disk_start,
> diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
> index 2bebb60c5830..2dbbfd33e5a5 100644
> --- a/fs/btrfs/lzo.c
> +++ b/fs/btrfs/lzo.c
> @@ -301,8 +301,6 @@ int lzo_decompress_bio(struct list_head *ws, struct =
compressed_bio *cb)
>   	char *buf;
>   	bool may_late_unmap, need_unmap;
>   	struct page **pages_in =3D cb->compressed_pages;
> -	u64 disk_start =3D cb->start;
> -	struct bio *orig_bio =3D cb->orig_bio;
>
>   	data_in =3D kmap(pages_in[0]);
>   	tot_len =3D read_compress_length(data_in);
> @@ -407,15 +405,15 @@ int lzo_decompress_bio(struct list_head *ws, struc=
t compressed_bio *cb)
>   		buf_start =3D tot_out;
>   		tot_out +=3D out_len;
>
> -		ret2 =3D btrfs_decompress_buf2page(workspace->buf, buf_start,
> -						 tot_out, disk_start, orig_bio);
> +		ret2 =3D btrfs_decompress_buf2page(workspace->buf, out_len,
> +						 cb, buf_start);
>   		if (ret2 =3D=3D 0)
>   			break;
>   	}
>   done:
>   	kunmap(pages_in[page_in_index]);
>   	if (!ret)
> -		zero_fill_bio(orig_bio);
> +		zero_fill_bio(cb->orig_bio);
>   	return ret;
>   }
>
> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
> index 2c792bc5a987..767a0c6c9694 100644
> --- a/fs/btrfs/zlib.c
> +++ b/fs/btrfs/zlib.c
> @@ -286,8 +286,6 @@ int zlib_decompress_bio(struct list_head *ws, struct=
 compressed_bio *cb)
>   	unsigned long total_pages_in =3D DIV_ROUND_UP(srclen, PAGE_SIZE);
>   	unsigned long buf_start;
>   	struct page **pages_in =3D cb->compressed_pages;
> -	u64 disk_start =3D cb->start;
> -	struct bio *orig_bio =3D cb->orig_bio;
>
>   	data_in =3D kmap(pages_in[page_in_index]);
>   	workspace->strm.next_in =3D data_in;
> @@ -326,9 +324,8 @@ int zlib_decompress_bio(struct list_head *ws, struct=
 compressed_bio *cb)
>   		if (buf_start =3D=3D total_out)
>   			break;
>
> -		ret2 =3D btrfs_decompress_buf2page(workspace->buf, buf_start,
> -						 total_out, disk_start,
> -						 orig_bio);
> +		ret2 =3D btrfs_decompress_buf2page(workspace->buf,
> +				total_out - buf_start, cb, buf_start);
>   		if (ret2 =3D=3D 0) {
>   			ret =3D 0;
>   			goto done;
> @@ -348,8 +345,7 @@ int zlib_decompress_bio(struct list_head *ws, struct=
 compressed_bio *cb)
>   			data_in =3D kmap(pages_in[page_in_index]);
>   			workspace->strm.next_in =3D data_in;
>   			tmp =3D srclen - workspace->strm.total_in;
> -			workspace->strm.avail_in =3D min(tmp,
> -							   PAGE_SIZE);
> +			workspace->strm.avail_in =3D min(tmp, PAGE_SIZE);
>   		}
>   	}
>   	if (ret !=3D Z_STREAM_END)
> @@ -361,7 +357,7 @@ int zlib_decompress_bio(struct list_head *ws, struct=
 compressed_bio *cb)
>   	if (data_in)
>   		kunmap(pages_in[page_in_index]);
>   	if (!ret)
> -		zero_fill_bio(orig_bio);
> +		zero_fill_bio(cb->orig_bio);
>   	return ret;
>   }
>
> diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
> index 9451d2bb984e..f06b68040352 100644
> --- a/fs/btrfs/zstd.c
> +++ b/fs/btrfs/zstd.c
> @@ -547,8 +547,6 @@ int zstd_decompress_bio(struct list_head *ws, struct=
 compressed_bio *cb)
>   {
>   	struct workspace *workspace =3D list_entry(ws, struct workspace, list=
);
>   	struct page **pages_in =3D cb->compressed_pages;
> -	u64 disk_start =3D cb->start;
> -	struct bio *orig_bio =3D cb->orig_bio;
>   	size_t srclen =3D cb->compressed_len;
>   	ZSTD_DStream *stream;
>   	int ret =3D 0;
> @@ -589,7 +587,7 @@ int zstd_decompress_bio(struct list_head *ws, struct=
 compressed_bio *cb)
>   		workspace->out_buf.pos =3D 0;
>
>   		ret =3D btrfs_decompress_buf2page(workspace->out_buf.dst,
> -				buf_start, total_out, disk_start, orig_bio);
> +				total_out - buf_start, cb, buf_start);
>   		if (ret =3D=3D 0)
>   			break;
>
> @@ -614,7 +612,7 @@ int zstd_decompress_bio(struct list_head *ws, struct=
 compressed_bio *cb)
>   		}
>   	}
>   	ret =3D 0;
> -	zero_fill_bio(orig_bio);
> +	zero_fill_bio(cb->orig_bio);
>   done:
>   	if (workspace->in_buf.src)
>   		kunmap(pages_in[page_in_index]);
>
