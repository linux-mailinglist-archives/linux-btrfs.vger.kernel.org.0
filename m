Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4C83C2B28
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Jul 2021 00:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhGIWGC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 18:06:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:39269 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229552AbhGIWGB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 9 Jul 2021 18:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625868195;
        bh=dxkvt4hv4sVlAMvEry25vTSDdKzhqgnp3CAm6yo5Rto=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=G9R+zmULawr3f+SeDmGUOfCgWB1eU257d61ZgH3wCUpQbe49nt0VJwrwZ5t8yOY+n
         AnXmk1WD/kqmhshELo6NKfqfy9P4F7esnxO9oP/hKB6xmv7gwNrcKJ+bPlBCLe5eYa
         QTKTNo9dGM+n+rMHb5qw+zyetsqTjQ131xiNP6aI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MC34h-1lsOCa3BL3-00CVCq; Sat, 10
 Jul 2021 00:03:15 +0200
Subject: Re: [PATCH v6 03/15] btrfs: rework btrfs_decompress_buf2page()
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210705020110.89358-1-wqu@suse.com>
 <20210705020110.89358-4-wqu@suse.com> <20210709185334.GH2610@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <807ad707-f006-b155-f680-4e927a0fc5d1@gmx.com>
Date:   Sat, 10 Jul 2021 06:03:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210709185334.GH2610@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TGhzkBlEpKfEgdCCD9r+31lTq+a4SiBzxwSaQGhyzbPkUWT7MNs
 SH9d03hpTa5J0c4nxbfER3cnkSg51rmbDJOi2Jx5KEq3ArLvWEC3PDjRkhLxugVE3YKib1l
 hWgkyeCHrYPJFtpzMVnFh563XHbb6pHUn2FkTqQN01GZ3HI5gk5+WnuiiEskaO+Not0hY/4
 3PqD+LZkHGH+4l4uSB/GA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SVrpZ+X+ulc=:jay8e1W2C5ewAAMW9PNPPF
 pLoWfVcldUu3z5TdTYRdGnj6Yjs8oJ5VP0qpzuEt7i2IDr+0tQyc6CFtC8b8UdFuU6c/gQGV0
 KrWJWXsQtPHP0xL3qvf4UN/bVyPKUXwAA4zx1Ri8H3J+zIOhBWONHaHr7Tjhyl24HcDTT6FGz
 0DIT2a7/klcB/O12yelrsOSgH2L+ePfYXPcLdrpgWn9qxDlN+7jRWSYgKmhSzZvzS5IZ3NO6R
 J4ie8PwxwwUDMOrvWzcsGVdiJg1L9PXKuvquBwtVa4XxCYrPIWBfsN0HX263z6drjsRcVHI97
 gEJvtvpF8ZkQIPYX5zQLLs7nko3cGhbW0a1RsTwBIipMyrGfIS+m+xx8aZMYNAlnFS5sH90v2
 NMOs8Cw3ohAhrX0DVmYHEYsCeSKUMconuxBJuH16X+i9E+aAkCyMDJfxVsKFLZ5NcLwWxBQQX
 nqwxal5mvjiDFHPKrg5tw5w5AVi8xDFtHgVArS7NoHI/4CznsQQC/cquVrfItDqIoxgfr+sms
 1dSAlBjiAOtCVCOn6S2i2ynhtnmUq2qOuFTi7m6VvMdR9Ux139+zQGvZcud1es5HM1gIKdVum
 TYzdjvQ2XkagJZMGSruYX5ymUSLAHWMoszehoKWf7x1xiK4jz/a3f85Bju1x9iD8NsaqEWeBG
 hwU0rq1KShX0Di17y9/MgLS4l8zqf9DysksY088HIPClsSZkP2IdPtNkoFx6R7HJzDYSNeVA4
 3JzuXMw+l1vLmuqHVL48t2vkQgmsX0urL+tt2ZA5U/qJ3E/1QW6Ic79021J49HsAeqFfMpSDQ
 BnX8AVOT+m6HLCW1jkWpbJGbHeSgb7yD6UCZOFiVrc3gMaDN7Ro6IJBsWVW9p5t1Zb0hE1gbY
 JAJHN5Qrhc0xkXb1jxbagn8PzmBd9gW/jIGpXJMawnvKnyjjnWJVP4lKSc4OizEYab8yRXCeV
 igaIU4Dt7xroOzKKxFgvKJUD3V/Fl+u+4RcLXSdQjMZbiuqqeKEZTCONw041CJf+4iq4XdssM
 0WbklYOQXggU/AbivQ5HQwR/Z7k9vfbL5LvZYW2uFPDI6zLJJVhAIdr9l9qMePLxtKI/dfoIP
 eafl71vMhToYBIzEkd8aWoRWIKWIdl6o009e6oGSjSPSCYiMCQDKNBHtk9wEx0GDrQPzgZl5W
 xtSv2ZncD6C5eAILv76as/0DrJK3itSoUEIeaYUfuy6lDYnVcu6nfmuaKsx14wh7yP8Nw=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/10 =E4=B8=8A=E5=8D=882:53, David Sterba wrote:
> On Mon, Jul 05, 2021 at 10:00:58AM +0800, Qu Wenruo wrote:
>> There are several bugs inside the function btrfs_decompress_buf2page()
>>
>> - @start_byte doesn't take bvec.bv_offset into consideration
>>    Thus it can't handle case where the target range is not page aligned=
.
>>
>> - Too many helper variables
>>    There are tons of helper variables, @buf_offset, @current_buf_start,
>>    @start_byte, @prev_start_byte, @working_bytes, @bytes.
>>    This hurts anyone who wants to read the function.
>>
>> - No obvious main cursor for the iteartion
>>    A new problem caused by previous problem.
>>
>> - Comments for parameter list makes no sense
>>    Like @buf_start is the offset to @buf, or offset inside the full
>>    decompressed extent? (Spoiler alert, the later case)
>>    And @total_out acts more like @buf_start + @size_of_buf.
>>
>>    The worst is @disk_start.
>>    The real meaning of it is the file offset of the full decompressed
>>    extent.
>>
>> This patch will rework the whole function by:
>>
>> - Add a proper comment with ASCII art to explain the parameter list
>>
>> - Rework parameter list
>>    The old @buf_start is renamed to @decompressed, to show how many byt=
es
>>    are already decompressed inside the full decompressed extent.
>>    The old @total_out is replaced by @buf_len, which is the decompresse=
d
>>    data size.
>>    For old @disk_start and @bio, just pass @compressed_bio in.
>>
>> - Use single main cursor
>>    The main cursor will be @cur_file_offset, to show what's the current
>>    file offset.
>>    Other helper variables will be declared inside the main loop, and on=
ly
>>    minimal amount of helper variables:
>>    * offset_inside_decompressed_buf:	The only real helper
>>    * copy_start_file_offset:		File offset we start memcpy
>>    * bvec_file_offset:			File offset of current bvec
>>
>> Even with all these extensive comments, the final function is still
>> smaller than the original function, which is definitely a win.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/compression.c | 140 +++++++++++++++++++---------------------=
-
>>   fs/btrfs/compression.h |   5 +-
>>   fs/btrfs/lzo.c         |   8 +--
>>   fs/btrfs/zlib.c        |  12 ++--
>>   fs/btrfs/zstd.c        |   6 +-
>>   5 files changed, 74 insertions(+), 97 deletions(-)
>>
>> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
>> index 8318e56b5ab4..af1b0f722e14 100644
>> --- a/fs/btrfs/compression.c
>> +++ b/fs/btrfs/compression.c
>> @@ -1263,96 +1263,82 @@ void __cold btrfs_exit_compress(void)
>>   }
>>
>>   /*
>> - * Copy uncompressed data from working buffer to pages.
>> + * Copy decompressed data from working buffer to pages.
>>    *
>> - * buf_start is the byte offset we're of the start of our workspace bu=
ffer.
>> + * @buf:		The decompressed data buffer
>> + * @buf_len:		The decompressed data length
>> + * @decompressed:	Number of bytes that is already decompressed inside =
the
>> + * 			compressed extent
>> + * @cb:			The compressed extent descriptor
>> + * @orig_bio:		The original bio that the caller wants to read for
>>    *
>> - * total_out is the last byte of the buffer
>> + * An easier to understand graph is like below:
>> + *
>> + * 		|<- orig_bio ->|     |<- orig_bio->|
>> + * 	|<-------      full decompressed extent      ----->|
>> + * 	|<-----------    @cb range   ---->|
>> + * 	|			|<-- @buf_len -->|
>> + * 	|<--- @decompressed --->|
>> + *
>> + * Note that, @cb can be a subpage of the full decompressed extent, bu=
t
>> + * @cb->start always has the same as the orig_file_offset value of the=
 full
>> + * decompressed extent.
>> + *
>> + * When reading compressed extent, we have to read the full compressed=
 extent,
>> + * while @orig_bio may only want part of the range.
>> + * Thus this function will ensure only data covered by @orig_bio will =
be copied
>> + * to.
>> + *
>> + * Return 0 if we have copied all needed contents for @orig_bio.
>> + * Return >0 if we need continue decompress.
>>    */
>> -int btrfs_decompress_buf2page(const char *buf, unsigned long buf_start=
,
>> -			      unsigned long total_out, u64 disk_start,
>> -			      struct bio *bio)
>> +int btrfs_decompress_buf2page(const char *buf, u32 buf_len,
>> +			      struct compressed_bio *cb, u32 decompressed)
>>   {
>> -	unsigned long buf_offset;
>> -	unsigned long current_buf_start;
>> -	unsigned long start_byte;
>> -	unsigned long prev_start_byte;
>> -	unsigned long working_bytes =3D total_out - buf_start;
>> -	unsigned long bytes;
>> -	struct bio_vec bvec =3D bio_iter_iovec(bio, bio->bi_iter);
>> -
>> -	/*
>> -	 * start byte is the first byte of the page we're currently
>> -	 * copying into relative to the start of the compressed data.
>> -	 */
>> -	start_byte =3D page_offset(bvec.bv_page) - disk_start;
>> -
>> -	/* we haven't yet hit data corresponding to this page */
>> -	if (total_out <=3D start_byte)
>> -		return 1;
>> +	struct bio *orig_bio =3D cb->orig_bio;
>> +	u32 cur_offset;	/* Offset inside the full decompressed extent */
>>
>> -	/*
>> -	 * the start of the data we care about is offset into
>> -	 * the middle of our working buffer
>> -	 */
>> -	if (total_out > start_byte && buf_start < start_byte) {
>> -		buf_offset =3D start_byte - buf_start;
>> -		working_bytes -=3D buf_offset;
>> -	} else {
>> -		buf_offset =3D 0;
>> -	}
>> -	current_buf_start =3D buf_start;
>> +	cur_offset =3D decompressed;
>> +	/* The main loop to do the copy */
>> +	while (cur_offset < decompressed + buf_len) {
>> +		struct bio_vec bvec =3D bio_iter_iovec(orig_bio,
>> +						     orig_bio->bi_iter);
>> +		size_t copy_len;
>> +		u32 copy_start;
>> +		u32 bvec_offset; /* Offset inside the full decompressed extent */
>>
>> -	/* copy bytes from the working buffer into the pages */
>> -	while (working_bytes > 0) {
>> -		bytes =3D min_t(unsigned long, bvec.bv_len,
>> -				PAGE_SIZE - (buf_offset % PAGE_SIZE));
>> -		bytes =3D min(bytes, working_bytes);
>> +		bvec =3D bio_iter_iovec(orig_bio, orig_bio->bi_iter);
>>
>> -		memcpy_to_page(bvec.bv_page, bvec.bv_offset, buf + buf_offset,
>> -			       bytes);
>> -		flush_dcache_page(bvec.bv_page);
>
> This got deleted, why?

Forgot that one, will be added back.

Thanks for catching this,
Qu
>
>> +		/*
>> +		 * cb->start may underflow, but minusing that value can still
>> +		 * give us correct offset inside the full decompressed extent.
>> +		 */
>> +		bvec_offset =3D page_offset(bvec.bv_page) + bvec.bv_offset
>> +			      - cb->start;
>>
>> -		buf_offset +=3D bytes;
>> -		working_bytes -=3D bytes;
>> -		current_buf_start +=3D bytes;
>> +		/* Haven't reached the bvec range, exit */
>> +		if (decompressed + buf_len <=3D bvec_offset)
>> +			return 1;
>>
>> -		/* check if we need to pick another page */
>> -		bio_advance(bio, bytes);
>> -		if (!bio->bi_iter.bi_size)
>> -			return 0;
>> -		bvec =3D bio_iter_iovec(bio, bio->bi_iter);
>> -		prev_start_byte =3D start_byte;
>> -		start_byte =3D page_offset(bvec.bv_page) - disk_start;
>> +		copy_start =3D max(cur_offset, bvec_offset);
>> +		copy_len =3D min(bvec_offset + bvec.bv_len,
>> +			       decompressed + buf_len) - copy_start;
>> +		ASSERT(copy_len);
>>
>>   		/*
>> -		 * We need to make sure we're only adjusting
>> -		 * our offset into compression working buffer when
>> -		 * we're switching pages.  Otherwise we can incorrectly
>> -		 * keep copying when we were actually done.
>> +		 * Extra range check to ensure we didn't go beyond
>> +		 * @buf + @buf_len.
>>   		 */
>> -		if (start_byte !=3D prev_start_byte) {
>> -			/*
>> -			 * make sure our new page is covered by this
>> -			 * working buffer
>> -			 */
>> -			if (total_out <=3D start_byte)
>> -				return 1;
>> -
>> -			/*
>> -			 * the next page in the biovec might not be adjacent
>> -			 * to the last page, but it might still be found
>> -			 * inside this working buffer. bump our offset pointer
>> -			 */
>> -			if (total_out > start_byte &&
>> -			    current_buf_start < start_byte) {
>> -				buf_offset =3D start_byte - buf_start;
>> -				working_bytes =3D total_out - start_byte;
>> -				current_buf_start =3D buf_start + buf_offset;
>> -			}
>> -		}
>> +		ASSERT(copy_start - decompressed < buf_len);
>> +		memcpy_to_page(bvec.bv_page, bvec.bv_offset,
>> +			       buf + copy_start - decompressed, copy_len);
>> +		cur_offset +=3D copy_len;
>> +
>> +		bio_advance(orig_bio, copy_len);
>> +		/* Finished the bio */
>> +		if (!orig_bio->bi_iter.bi_size)
>> +			return 0;
>>   	}
>> -
>>   	return 1;
>>   }
>>
>> diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
>> index c359f20920d0..399be0b435bf 100644
>> --- a/fs/btrfs/compression.h
>> +++ b/fs/btrfs/compression.h
>> @@ -86,9 +86,8 @@ int btrfs_compress_pages(unsigned int type_level, str=
uct address_space *mapping,
>>   			 unsigned long *total_out);
>>   int btrfs_decompress(int type, unsigned char *data_in, struct page *d=
est_page,
>>   		     unsigned long start_byte, size_t srclen, size_t destlen);
>> -int btrfs_decompress_buf2page(const char *buf, unsigned long buf_start=
,
>> -			      unsigned long total_out, u64 disk_start,
>> -			      struct bio *bio);
>> +int btrfs_decompress_buf2page(const char *buf, u32 buf_len,
>> +			      struct compressed_bio *cb, u32 decompressed);
>>
>>   blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode,=
 u64 start,
>>   				  unsigned int len, u64 disk_start,
>> diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
>> index 2bebb60c5830..2dbbfd33e5a5 100644
>> --- a/fs/btrfs/lzo.c
>> +++ b/fs/btrfs/lzo.c
>> @@ -301,8 +301,6 @@ int lzo_decompress_bio(struct list_head *ws, struct=
 compressed_bio *cb)
>>   	char *buf;
>>   	bool may_late_unmap, need_unmap;
>>   	struct page **pages_in =3D cb->compressed_pages;
>> -	u64 disk_start =3D cb->start;
>> -	struct bio *orig_bio =3D cb->orig_bio;
>>
>>   	data_in =3D kmap(pages_in[0]);
>>   	tot_len =3D read_compress_length(data_in);
>> @@ -407,15 +405,15 @@ int lzo_decompress_bio(struct list_head *ws, stru=
ct compressed_bio *cb)
>>   		buf_start =3D tot_out;
>>   		tot_out +=3D out_len;
>>
>> -		ret2 =3D btrfs_decompress_buf2page(workspace->buf, buf_start,
>> -						 tot_out, disk_start, orig_bio);
>> +		ret2 =3D btrfs_decompress_buf2page(workspace->buf, out_len,
>> +						 cb, buf_start);
>>   		if (ret2 =3D=3D 0)
>>   			break;
>>   	}
>>   done:
>>   	kunmap(pages_in[page_in_index]);
>>   	if (!ret)
>> -		zero_fill_bio(orig_bio);
>> +		zero_fill_bio(cb->orig_bio);
>>   	return ret;
>>   }
>>
>> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
>> index 2c792bc5a987..767a0c6c9694 100644
>> --- a/fs/btrfs/zlib.c
>> +++ b/fs/btrfs/zlib.c
>> @@ -286,8 +286,6 @@ int zlib_decompress_bio(struct list_head *ws, struc=
t compressed_bio *cb)
>>   	unsigned long total_pages_in =3D DIV_ROUND_UP(srclen, PAGE_SIZE);
>>   	unsigned long buf_start;
>>   	struct page **pages_in =3D cb->compressed_pages;
>> -	u64 disk_start =3D cb->start;
>> -	struct bio *orig_bio =3D cb->orig_bio;
>>
>>   	data_in =3D kmap(pages_in[page_in_index]);
>>   	workspace->strm.next_in =3D data_in;
>> @@ -326,9 +324,8 @@ int zlib_decompress_bio(struct list_head *ws, struc=
t compressed_bio *cb)
>>   		if (buf_start =3D=3D total_out)
>>   			break;
>>
>> -		ret2 =3D btrfs_decompress_buf2page(workspace->buf, buf_start,
>> -						 total_out, disk_start,
>> -						 orig_bio);
>> +		ret2 =3D btrfs_decompress_buf2page(workspace->buf,
>> +				total_out - buf_start, cb, buf_start);
>>   		if (ret2 =3D=3D 0) {
>>   			ret =3D 0;
>>   			goto done;
>> @@ -348,8 +345,7 @@ int zlib_decompress_bio(struct list_head *ws, struc=
t compressed_bio *cb)
>>   			data_in =3D kmap(pages_in[page_in_index]);
>>   			workspace->strm.next_in =3D data_in;
>>   			tmp =3D srclen - workspace->strm.total_in;
>> -			workspace->strm.avail_in =3D min(tmp,
>> -							   PAGE_SIZE);
>> +			workspace->strm.avail_in =3D min(tmp, PAGE_SIZE);
>>   		}
>>   	}
>>   	if (ret !=3D Z_STREAM_END)
>> @@ -361,7 +357,7 @@ int zlib_decompress_bio(struct list_head *ws, struc=
t compressed_bio *cb)
>>   	if (data_in)
>>   		kunmap(pages_in[page_in_index]);
>>   	if (!ret)
>> -		zero_fill_bio(orig_bio);
>> +		zero_fill_bio(cb->orig_bio);
>>   	return ret;
>>   }
>>
>> diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
>> index 9451d2bb984e..f06b68040352 100644
>> --- a/fs/btrfs/zstd.c
>> +++ b/fs/btrfs/zstd.c
>> @@ -547,8 +547,6 @@ int zstd_decompress_bio(struct list_head *ws, struc=
t compressed_bio *cb)
>>   {
>>   	struct workspace *workspace =3D list_entry(ws, struct workspace, lis=
t);
>>   	struct page **pages_in =3D cb->compressed_pages;
>> -	u64 disk_start =3D cb->start;
>> -	struct bio *orig_bio =3D cb->orig_bio;
>>   	size_t srclen =3D cb->compressed_len;
>>   	ZSTD_DStream *stream;
>>   	int ret =3D 0;
>> @@ -589,7 +587,7 @@ int zstd_decompress_bio(struct list_head *ws, struc=
t compressed_bio *cb)
>>   		workspace->out_buf.pos =3D 0;
>>
>>   		ret =3D btrfs_decompress_buf2page(workspace->out_buf.dst,
>> -				buf_start, total_out, disk_start, orig_bio);
>> +				total_out - buf_start, cb, buf_start);
>>   		if (ret =3D=3D 0)
>>   			break;
>>
>> @@ -614,7 +612,7 @@ int zstd_decompress_bio(struct list_head *ws, struc=
t compressed_bio *cb)
>>   		}
>>   	}
>>   	ret =3D 0;
>> -	zero_fill_bio(orig_bio);
>> +	zero_fill_bio(cb->orig_bio);
>>   done:
>>   	if (workspace->in_buf.src)
>>   		kunmap(pages_in[page_in_index]);
>> --
>> 2.32.0
