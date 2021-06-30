Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52DA3B82CB
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jun 2021 15:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbhF3NXM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Jun 2021 09:23:12 -0400
Received: from mout.gmx.net ([212.227.15.19]:34961 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234679AbhF3NXM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Jun 2021 09:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625059241;
        bh=HHwuVXgl7hXmvB7lGy8Rkndf4KxxeNVsJKDsgtTdhuw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=FF3gS0QFYs/m00xX1hX0JADxdXRCx7Ysn5cNq3Y4aK3wtV/5X1f2xZUZrAtBCkyfd
         R7EWXPDrK1ZLmp6mmuGpBN8vC25vz/a29xmyW+pfhG0gz6XZ1mvU1hUok37jF5gkmM
         4q6pT2vLGNbT1KSbS9//vzCv8bGu1te9V/i5xIc8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MQ5vW-1lcX3Q1Gs4-00M7ke; Wed, 30
 Jun 2021 15:20:40 +0200
Subject: Re: [PATCH v2 3/4] btrfs: rework btrfs_decompress_buf2page()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210630125512.325889-1-wqu@suse.com>
 <20210630125512.325889-4-wqu@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <78c8a1a8-4555-92f2-3f05-ff72a590fe7c@gmx.com>
Date:   Wed, 30 Jun 2021 21:20:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630125512.325889-4-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9fqsyTnxzvrkONFrhGU8AznqamfHMo1gNwOfq7Ld3GEUAdGVipX
 P1s7oB5Tlg948sX5U8lE4jXTSKx7nT6Uj2KRR85F8SQF2DB2C3fPRDD6d4+8qoAhw4HTJk7
 9bbXa5oFe5y4ZY3DkvvA2yQ3PFyIdWs5Eeu//HKzix7WlaFO9YRxQn3MpFVLq7Gr4ZNHGGW
 Ioekh/FPRrQxOwgtklz1w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rema/ttRfKw=:Hrdkb4DwZ0itmOu5Rah4Bp
 GilohSYD7A2Vxpym7tiXSvzS3tm3uReAxlk+x4EwwlasBg+FbE8QXzCOBhIBh2xhztK3nDzqH
 sGJpuWCggSAb83PFwE/i8IDuocqcmTRfceHITE9GWV4GcvebKxQjN17mnrsEJSBGrg92sXhAh
 RJ9MAe7hpmpzLQEthkk21LsZVO8936hbB1GbaILv/IFEO7QnekgF+Rp55wzfvENqytGHA28xf
 7kqlpbh2A+EvApXxevzPUtC2beSPrOx+D9MFSjK2YnY5KLHqit+juQH2vIxOEnZTS9F0P1DPM
 o7fPV0aB+8jIRrkk9pA7m8mjQwy+1VGHM3jalzw0kNYBXxUr0y186y8W2UCBFHZsNgOyeOcTo
 OG0SGKGBI1zVyL1k+zGTdmP4emSHzh7ZRylu8XmkXVhzpmU1q/TgqnWgwrqQ+njVMmG/7jKp2
 wtMB9F5Zy7btY7jwNgtzvsMSnydTtkMj0Oq73kh5Qy4d9fR1Am5GWEqO8/RAi8pogqI/IJSZX
 1DWpMho+aOJwDbJR/C2Uzq/MQG/90El1L5DCrE6bHxZU4ATXg4Iac6kgMPJFu3n7iKZ9TVsAm
 Esad8wJvRmQeQApgkW2PDef+SfKTIiodzUtMrP39iw5elnyrJPjKGcJmZOcwEmwln+DLDjqdt
 ibHVFiopPcLZmEqjFbCvLPjxNlpkJgTnIJJKJ+o77anxIxg1K4m+q9cwkudhKhY/q9bocAlUl
 Wf1cHO8+t9Cy3zXgqpwcTnTuWJLm1WHz5Ls8UxPzTuh172mMntoh71yx7bnVhpqoUrj1Dd/8o
 yWgb84T8FQXJvsZROIxxP5UKD8+Fstia7FFG54Uu9feJlSwPLm5Ju/rlvliHx2pQhYfNLSfK6
 MeT/wg2mKsO453uneYX0tdSGVXaDR7o9mnOcTIFEsHw5hOepMWEK46O+M8MFc1n2nwLJpmYy5
 XeFTegeW5VjyoEPsbPTF/hlRNdreaR3XM6b22nc0xpxSbnWWH/Y/bjyUs1DoP6vZpEnYGxtky
 i//ieYTVaCeC8mas90g/TpbKLVpHXOaAUmaE3TZqrICD87o+vUj/rYYlh4UtNnV+clMaNLrz8
 cwGB3+2EupxDjAzKdLyoL92s+Lz5TfEastSyJQ70UtH/sQRZVTRCyZPgw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/30 =E4=B8=8B=E5=8D=888:55, Qu Wenruo wrote:
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
>   fs/btrfs/compression.c | 140 +++++++++++++++++++----------------------
>   fs/btrfs/compression.h |   5 +-
>   fs/btrfs/lzo.c         |   8 +--
>   fs/btrfs/zlib.c        |  12 ++--
>   fs/btrfs/zstd.c        |   6 +-
>   5 files changed, 74 insertions(+), 97 deletions(-)
>
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 8318e56b5ab4..80d40c200bae 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -1263,96 +1263,82 @@ void __cold btrfs_exit_compress(void)
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
> +	struct bio *orig_bio =3D cb->orig_bio;
> +	u32 cur_offset;	/* Offset inside the full decompressed extent */
>
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
> +	cur_offset =3D decompressed;
> +	/* The main loop to do the copy */
> +	while (cur_offset < decompressed + buf_len) {
> +		struct bio_vec bvec =3D bio_iter_iovec(orig_bio,
> +						     orig_bio->bi_iter);
> +		size_t copy_len;
> +		u32 copy_start;
> +		u32 bvec_offset; /* Offset inside the full decompressed extent */
>
> -	/* copy bytes from the working buffer into the pages */
> -	while (working_bytes > 0) {
> -		bytes =3D min_t(unsigned long, bvec.bv_len,
> -				PAGE_SIZE - (buf_offset % PAGE_SIZE));
> -		bytes =3D min(bytes, working_bytes);
> +		bvec =3D bio_iter_iovec(orig_bio, orig_bio->bi_iter);
>
> -		memcpy_to_page(bvec.bv_page, bvec.bv_offset, buf + buf_offset,
> -			       bytes);
> -		flush_dcache_page(bvec.bv_page);
> +		/*
> +		 * cb->start may underflow, but minusing that value can still
> +		 * give us correct offset inside the full decompressed extent.
> +		 */
> +		bvec_offset =3D page_offset(bvec.bv_page) + bvec.bv_offset
> +			      - cb->start;
>
> -		buf_offset +=3D bytes;
> -		working_bytes -=3D bytes;
> -		current_buf_start +=3D bytes;
> +		/* Haven't reached the bvec range, exit */
> +		if (cur_offset + buf_len <=3D bvec_offset)
Here we should use "if (decompressed + buf_len <=3D bvec_offset)"

I forgot to re-format the patchset...
The correct one is pushed to test machine and github, but not the
patchset...

Thanks,
Qu
> +			return 1;
>
> -		/* check if we need to pick another page */
> -		bio_advance(bio, bytes);
> -		if (!bio->bi_iter.bi_size)
> -			return 0;
> -		bvec =3D bio_iter_iovec(bio, bio->bi_iter);
> -		prev_start_byte =3D start_byte;
> -		start_byte =3D page_offset(bvec.bv_page) - disk_start;
> +		copy_start =3D max(cur_offset, bvec_offset);
> +		copy_len =3D min(bvec_offset + bvec.bv_len,
> +			       decompressed + buf_len) - copy_start;
> +		ASSERT(copy_len);
>
>   		/*
> -		 * We need to make sure we're only adjusting
> -		 * our offset into compression working buffer when
> -		 * we're switching pages.  Otherwise we can incorrectly
> -		 * keep copying when we were actually done.
> +		 * Extra range check to ensure we didn't go beyond
> +		 * @buf + @buf_len.
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
> -		}
> +		ASSERT(copy_start - decompressed < buf_len);
> +		memcpy_to_page(bvec.bv_page, bvec.bv_offset,
> +			       buf + copy_start - decompressed, copy_len);
> +		cur_offset +=3D copy_len;
> +
> +		bio_advance(orig_bio, copy_len);
> +		/* Finished the bio */
> +		if (!orig_bio->bi_iter.bi_size)
> +			return 0;
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
