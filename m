Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6530E3BBCF5
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jul 2021 14:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhGEMoT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jul 2021 08:44:19 -0400
Received: from mout.gmx.net ([212.227.17.21]:42007 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230247AbhGEMoT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Jul 2021 08:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625488900;
        bh=1AkE8hhyVJRxO1fbW5ah/JML4urBW0glC3M+eNFuIlw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=LQnabzGRp/0u6I+g2tfbnBZWY/gJOYuzwImU7MW6sQj19uzvkmA0oWPwJ71KnCERG
         qAL8hIp00kK1HGkV0NTv8RV2eMnGXlzP4GzqNgguT9BXatKPpYiLiJo5Nc7mr1HxmM
         cLz1V/AS2OYly/2SLke1KyF1N0rR9rijqocfQcc4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeCtj-1lRrym3qWF-00bNSs; Mon, 05
 Jul 2021 14:41:40 +0200
Subject: Re: [PATCH RFC] btrfs: rework lzo_compress_pages() to make it subpage
 compatible
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210629122329.314947-1-wqu@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <7f4fc49d-909c-79e1-11f0-0e4fdfc3e060@gmx.com>
Date:   Mon, 5 Jul 2021 20:41:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629122329.314947-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nu9lXJyFhTaxR3+FJMr10aswFw7+ezQuKp2wJFDM6m/ma5g0oPS
 y4lirkFJb6nNPtNjvfDYXNZ+C7aY6h0KdwGJya42tw4YEyqvCtcoC7UUBkE/k45wUy0eoce
 6BiUbe2a9qnCiqN6PI2Mmm+409E6dVdGLOLTiviue00JcUabOAVASYHj4o5qwMOZ1BVQjuT
 83hHv+ya+62TALuYwNRiQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WMqkQcDOoUk=:IWC8idkbyQTs4S44+DG6tO
 Sw5a2sol5FvZOWEvI2g5FZaSPTV+zyU539a5q+0A6ESg0F+mNCJtXtO1P4zR+27qrCllIFP3W
 pKOnq98ZyyyvbSgWrxAdFQU6DN58K6e8Vw19XAJQ90HTtdf9kaRTKwhn2oAZLz/oZfj2dEkab
 f1dsNbrLAbPpwWXw+vxaK5fua3q2d5361fRYjys191Yj5TTWm3RCS50MKFXGk9FKVINTNB5Ck
 4MAnvuKoK/xNGOlH9eTv+KHL3v5Sh5EciVB39/PKz6KPsy1JrR0tU2YFAcUcsf3E+lgtQBdwe
 y/5wlcx53cxvSB3wojoBw3il7C2kY/xloI4qHzgSFt/wEIL8qmz52K1q2xOey+RNHoLNYvtq5
 2HPFYG24Z06jKXyXrG5KrJukb0kjnnP5rmPQEIKPcfMp+wwqIncyRneHIPeXrnpAp8gHPrazF
 2Ut/gssdLi9Bpr7+Xy7SLyhW9KbZR2kO2vtju2taVsgA8X3M4sZiUD92cm36rAWPGyvnZNAkD
 dCkZm/Q3/8bEWoWTWSH+K51BCIu6KE/YMMbwXMmWSjYaOTMZHP5Rh3TSDxK1NL//vnEPVyM6t
 BS8Dk41jtH3gxrOqvu0fVg+B0V5t5GiIOdOYt2EFzIsn74TQI1Xvg2huB80TMHKsjDC+2xDxN
 W8ZTDnasGLvI6btdY2irN+cNstGgSrXWMZj6N8k8Wbc3znD3pwaH4Lix5kT07WxfMHaBfyWGl
 QLThYxz0+zUqD3ljFAx60CR4lL5zDZVgT7hra8qs+2xkIEHWbrv59UUpher/cw4hxskuvxr6V
 2nQk0WylKZ5rUmwG/UXjF0FXWo3XnPFAk3LW2Rsx53//51EdEt6f3Vg4aB/iKy/5oKxtuMNLB
 xGdivku3iOwQ9v43hhcjV4OvwA/cQLfGYCLXS/VzORnKTcU1rBnguESmuDwg1IDssqgDuKs78
 QYOGW7os5RHb+MEjQ0Gps/phFu/JWYzCFVNpLM/l9NbePnZsfysCrs4gYnRgOvVBNDz6jqAtJ
 2rZHkCaaT+Wh9qWYVEXGQApZbLvq0UQOe7Z2RIyeL7Q0JVnyGnsMcCQsqeTq6e/FT5y1Myd64
 lxbDuBx553DqSVCBNbZtoXRLLynDZC2weswy0o6J4xpfwG4dt2kz+6oyg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/29 =E4=B8=8B=E5=8D=888:23, Qu Wenruo wrote:
> There are several problems in lzo_compress_pages() preventing it from
> being subpage compatible:
>
> - No page offset is calculated when reading from inode pages
>    For subpage case, we could have @start which is not aligned to
>    PAGE_SIZE.
>
>    Thus the destination where we read data from must take offset in page
>    into consideration.
>
> - The padding for segment header is bound to PAGE_SIZE
>    This means, for subpage case we can skip several corners where on x86
>    machines we need to add padding zeros.
>
> The rework will:
>
> - Update the comment to replace "page" with "sector"
>
> - Introduce a new helper, copy_compressed_data_to_page(), to do the copy
>    So that we don't need to bother page switches for both input and
>    output.
>
>    Now in lzo_compress_pages() we only care about page switching for
>    input, while in copy_compressed_data_to_page() we only care the page
>    switching for output.
>
> - Only one main cursor
>    For lzo_compress_pages() we use @cur_in as main curor.
>    It will be the file offset we are currently at.
>
>    All other helper variables will be only declared inside the loop.
>
>    For copy_compressed_data_to_page() it's similar, we will have
>    @cur_out at the main cursor, which records how many bytes are in the
>    output.
>
> - Get rid of kmap()/kunmap()
>    Instead of using __GFP_HIGHMEM and needs to do kmap()/kunmap(), just
>    get rid of that GFP flag, so we can use page_address() and never
>    bother the kmap()/kunmap() thing.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Reason for RFC:
>
> The patch itself seems not only easier to read, but already passes
> fstests -g compress with "-o compress=3Dlzo" tests.
>
> Haven't yet run the full test suits with "-o compress=3Dlzo", but so far
> so good.
>
> So the main reason for RFC is, if the style is OK.
>
> There are at least 4 functions need similar rework, and one of them
> is in high priority as it affects subpage read path for compressed
> data. (namely lzo_decompress_bio()).
>
> While the lzo|zlib/zstd_compress_pages() functions are in low priority, =
as for
> subpage write support we will only support range which is PAGE_SIZE
> aligned, thus the existing functions can work without big problems.
>
> Personally speaking I'm pretty happy with the refactor.
>
> Even with my excessive comments style, we still reach net 0 for changed
> lines.
>
> Thus any feedback on the style if appreciated.
> ---
>   fs/btrfs/lzo.c | 284 ++++++++++++++++++++++++-------------------------
>   1 file changed, 142 insertions(+), 142 deletions(-)
>
> diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
> index cd042c7567a4..18681153fea6 100644
> --- a/fs/btrfs/lzo.c
> +++ b/fs/btrfs/lzo.c
> @@ -14,6 +14,7 @@
>   #include <linux/lzo.h>
>   #include <linux/refcount.h>
>   #include "compression.h"
> +#include "ctree.h"
>
>   #define LZO_LEN	4
>
> @@ -31,19 +32,19 @@
>    *     payload.
>    *     One regular LZO compressed extent can have one or more segments=
.
>    *     For inlined LZO compressed extent, only one segment is allowed.
> - *     One segment represents at most one page of uncompressed data.
> + *     One segment represents at most one sector of uncompressed data.
>    *
>    * 2.1 Segment header
>    *     Fixed size. LZO_LEN (4) bytes long, LE32.
>    *     Records the total size of the segment (not including the header=
).
> - *     Segment header never crosses page boundary, thus it's possible t=
o
> - *     have at most 3 padding zeros at the end of the page.
> + *     Segment header never crosses sector boundary, thus it's possible=
 to
> + *     have at most 3 padding zeros at the end of the sector.
>    *
>    * 2.2 Data Payload
> - *     Variable size. Size up limit should be lzo1x_worst_compress(PAGE=
_SIZE)
> - *     which is 4419 for a 4KiB page.
> + *     Variable size. Size up limit should be lzo1x_worst_compress(sect=
orsize)
> + *     which is 4419 for a 4KiB sectorsize.
>    *
> - * Example:
> + * Example with 4K sectorsize:
>    * Page 1:
>    *          0     0x2   0x4   0x6   0x8   0xa   0xc   0xe     0x10
>    * 0x0000   |  Header   | SegHdr 01 | Data payload 01 ...     |
> @@ -111,170 +112,169 @@ static inline size_t read_compress_length(const =
char *buf)
>   	return le32_to_cpu(dlen);
>   }
>
> +/*
> + * Will do:
> + *
> + * - Write a segment header into the destination
> + * - Copy the compressed buffer into the destination
> + * - Make sure we have enough space in the last sector to fit a segment=
 header
> + *   If not, we will pad at most (LZO_LEN (4)) - 1 bytes of zeros.
> + *
> + * Will allocate new pages when needed.
> + */
> +static int copy_compressed_data_to_page(char *compressed_data,
> +					size_t compressed_size,
> +					struct page **out_pages,
> +					u32 *cur_out,
> +					const u32 sectorsize)
> +{
> +	u32 sector_bytes_left;
> +	u32 orig_out;
> +	struct page *cur_page;
> +
> +	/*
> +	 * We never allow a segment header crossing sector boundary, previous
> +	 * run should ensure we have enough space left inside the sector.
> +	 */
> +	ASSERT((*cur_out / sectorsize) =3D=3D
> +	       (*cur_out + LZO_LEN - 1) / sectorsize);
> +
> +	cur_page =3D out_pages[*cur_out / PAGE_SIZE];
> +	/* Allocate a new page */
> +	if (!cur_page) {
> +		cur_page =3D alloc_page(GFP_NOFS);
> +		if (!cur_page)
> +			return -ENOMEM;
> +		out_pages[*cur_out / PAGE_SIZE] =3D cur_page;
> +	}
> +
> +	write_compress_length(page_address(cur_page) + offset_in_page(*cur_out=
),
> +			      compressed_size);
> +
> +	*cur_out +=3D LZO_LEN;
> +	orig_out =3D *cur_out;
> +	/* *cur_out is increased, let the main loop to grab a proper page */
> +	cur_page =3D NULL;
> +
> +	/* Copy compressed data */
> +	while (*cur_out - orig_out < compressed_size) {
> +		u32 copy_len =3D min_t(u32, sectorsize - *cur_out % sectorsize,
> +				     orig_out + compressed_size - *cur_out);
> +
> +		/* Grab a page or allocate a new one */
> +		if (!cur_page) {
> +			cur_page =3D out_pages[*cur_out / PAGE_SIZE];
> +			if (!cur_page) {
> +				cur_page =3D alloc_page(GFP_NOFS);
> +				if (!cur_page)
> +					return -ENOMEM;
> +				out_pages[*cur_out / PAGE_SIZE] =3D cur_page;
> +			}
> +		}
> +
> +		memcpy(page_address(cur_page) + offset_in_page(*cur_out),
> +		       compressed_data + *cur_out - orig_out, copy_len);
> +
> +		*cur_out +=3D copy_len;
> +
> +		/* If we reached page boudnary, go to next page */
> +		if (IS_ALIGNED(*cur_out, PAGE_SIZE)) {

Here missing a put_page() and will cause memory leakage.

Already fixed in my github compression branch.

Thanks,
Qu
> +			/* Let next iteration to grab a page */
> +			cur_page =3D NULL;
> +		}
> +	}
> +
> +	/*
> +	 * Check if we can fit the next segment header into the remaining spac=
e
> +	 * of the sector.
> +	 */
> +	sector_bytes_left =3D round_up(*cur_out, sectorsize) - *cur_out;
> +	if (sector_bytes_left >=3D LZO_LEN)
> +		return 0;
> +
> +	/* The remaining size is not enough, pad it with zeros */
> +	memset(page_address(cur_page) + offset_in_page(*cur_out), 0,
> +	       sector_bytes_left);
> +	*cur_out +=3D sector_bytes_left;
> +	return 0;
> +}
> +
>   int lzo_compress_pages(struct list_head *ws, struct address_space *map=
ping,
>   		u64 start, struct page **pages, unsigned long *out_pages,
>   		unsigned long *total_in, unsigned long *total_out)
>   {
>   	struct workspace *workspace =3D list_entry(ws, struct workspace, list=
);
> +	const u32 sectorsize =3D btrfs_sb(mapping->host->i_sb)->sectorsize;
> +	struct page *page_in =3D NULL;
>   	int ret =3D 0;
> -	char *data_in;
> -	char *cpage_out, *sizes_ptr;
> -	int nr_pages =3D 0;
> -	struct page *in_page =3D NULL;
> -	struct page *out_page =3D NULL;
> -	unsigned long bytes_left;
> -	unsigned long len =3D *total_out;
> -	unsigned long nr_dest_pages =3D *out_pages;
> -	const unsigned long max_out =3D nr_dest_pages * PAGE_SIZE;
> -	size_t in_len;
> -	size_t out_len;
> -	char *buf;
> -	unsigned long tot_in =3D 0;
> -	unsigned long tot_out =3D 0;
> -	unsigned long pg_bytes_left;
> -	unsigned long out_offset;
> -	unsigned long bytes;
> +	u64 cur_in =3D start;	/* Points to the file offset of input data */
> +	u32 cur_out =3D 0;	/* Points to the current output byte */
> +	u32 len =3D *total_out;
>
>   	*out_pages =3D 0;
>   	*total_out =3D 0;
>   	*total_in =3D 0;
>
> -	in_page =3D find_get_page(mapping, start >> PAGE_SHIFT);
> -	data_in =3D kmap(in_page);
> -
>   	/*
> -	 * store the size of all chunks of compressed data in
> -	 * the first 4 bytes
> +	 * Skip the header for now, we will later come back and write the tota=
l
> +	 * compressed size
>   	 */
> -	out_page =3D alloc_page(GFP_NOFS | __GFP_HIGHMEM);
> -	if (out_page =3D=3D NULL) {
> -		ret =3D -ENOMEM;
> -		goto out;
> -	}
> -	cpage_out =3D kmap(out_page);
> -	out_offset =3D LZO_LEN;
> -	tot_out =3D LZO_LEN;
> -	pages[0] =3D out_page;
> -	nr_pages =3D 1;
> -	pg_bytes_left =3D PAGE_SIZE - LZO_LEN;
> -
> -	/* compress at most one page of data each time */
> -	in_len =3D min(len, PAGE_SIZE);
> -	while (tot_in < len) {
> -		ret =3D lzo1x_1_compress(data_in, in_len, workspace->cbuf,
> -				       &out_len, workspace->mem);
> -		if (ret !=3D LZO_E_OK) {
> -			pr_debug("BTRFS: lzo in loop returned %d\n",
> -			       ret);
> +	cur_out +=3D LZO_LEN;
> +	while (cur_in < start + len) {
> +		u32 sector_off =3D (cur_in - start) % sectorsize;
> +		u32 in_len;
> +		size_t out_len;
> +
> +		/* Get the input page first */
> +		if (!page_in) {
> +			page_in =3D find_get_page(mapping, cur_in >> PAGE_SHIFT);
> +			ASSERT(page_in);
> +		}
> +
> +		/* Compress at most one sector of data each time */
> +		in_len =3D min_t(u32, start + len - cur_in,
> +			       sectorsize - sector_off);
> +		ASSERT(in_len);
> +		ret =3D lzo1x_1_compress(page_address(page_in) +
> +				       offset_in_page(cur_in), in_len,
> +				       workspace->cbuf, &out_len,
> +				       workspace->mem);
> +		if (ret < 0) {
> +			pr_debug("BTRFS: lzo in loop returned %d\n", ret);
>   			ret =3D -EIO;
>   			goto out;
>   		}
>
> -		/* store the size of this chunk of compressed data */
> -		write_compress_length(cpage_out + out_offset, out_len);
> -		tot_out +=3D LZO_LEN;
> -		out_offset +=3D LZO_LEN;
> -		pg_bytes_left -=3D LZO_LEN;
> -
> -		tot_in +=3D in_len;
> -		tot_out +=3D out_len;
> -
> -		/* copy bytes from the working buffer into the pages */
> -		buf =3D workspace->cbuf;
> -		while (out_len) {
> -			bytes =3D min_t(unsigned long, pg_bytes_left, out_len);
> -
> -			memcpy(cpage_out + out_offset, buf, bytes);
> -
> -			out_len -=3D bytes;
> -			pg_bytes_left -=3D bytes;
> -			buf +=3D bytes;
> -			out_offset +=3D bytes;
> -
> -			/*
> -			 * we need another page for writing out.
> -			 *
> -			 * Note if there's less than 4 bytes left, we just
> -			 * skip to a new page.
> -			 */
> -			if ((out_len =3D=3D 0 && pg_bytes_left < LZO_LEN) ||
> -			    pg_bytes_left =3D=3D 0) {
> -				if (pg_bytes_left) {
> -					memset(cpage_out + out_offset, 0,
> -					       pg_bytes_left);
> -					tot_out +=3D pg_bytes_left;
> -				}
> -
> -				/* we're done, don't allocate new page */
> -				if (out_len =3D=3D 0 && tot_in >=3D len)
> -					break;
> -
> -				kunmap(out_page);
> -				if (nr_pages =3D=3D nr_dest_pages) {
> -					out_page =3D NULL;
> -					ret =3D -E2BIG;
> -					goto out;
> -				}
> -
> -				out_page =3D alloc_page(GFP_NOFS | __GFP_HIGHMEM);
> -				if (out_page =3D=3D NULL) {
> -					ret =3D -ENOMEM;
> -					goto out;
> -				}
> -				cpage_out =3D kmap(out_page);
> -				pages[nr_pages++] =3D out_page;
> +		ret =3D copy_compressed_data_to_page(workspace->cbuf, out_len,
> +						   pages, &cur_out, sectorsize);
> +		if (ret < 0)
> +			goto out;
>
> -				pg_bytes_left =3D PAGE_SIZE;
> -				out_offset =3D 0;
> -			}
> -		}
> +		cur_in +=3D in_len;
>
> -		/* we're making it bigger, give up */
> -		if (tot_in > 8192 && tot_in < tot_out) {
> +		/*
> +		 * Check if we're making it bigger after two sectors.
> +		 * And if we're making it bigger, give up.
> +		 */
> +		if (cur_in - start > sectorsize * 2 &&
> +		    cur_in - start < cur_out) {
>   			ret =3D -E2BIG;
>   			goto out;
>   		}
>
> -		/* we're all done */
> -		if (tot_in >=3D len)
> -			break;
> -
> -		if (tot_out > max_out)
> -			break;
> -
> -		bytes_left =3D len - tot_in;
> -		kunmap(in_page);
> -		put_page(in_page);
> -
> -		start +=3D PAGE_SIZE;
> -		in_page =3D find_get_page(mapping, start >> PAGE_SHIFT);
> -		data_in =3D kmap(in_page);
> -		in_len =3D min(bytes_left, PAGE_SIZE);
> -	}
> -
> -	if (tot_out >=3D tot_in) {
> -		ret =3D -E2BIG;
> -		goto out;
> +		/* Check if we have reached page boundary */
> +		if (IS_ALIGNED(cur_in, PAGE_SIZE))
> +			page_in =3D NULL;
>   	}
>
> -	/* store the size of all chunks of compressed data */
> -	sizes_ptr =3D kmap_local_page(pages[0]);
> -	write_compress_length(sizes_ptr, tot_out);
> -	kunmap_local(sizes_ptr);
> +	/* Store the size of all chunks of compressed data */
> +	write_compress_length(page_address(pages[0]), cur_out);
>
>   	ret =3D 0;
> -	*total_out =3D tot_out;
> -	*total_in =3D tot_in;
> +	*total_out =3D cur_out;
> +	*total_in =3D cur_in - start;
>   out:
> -	*out_pages =3D nr_pages;
> -	if (out_page)
> -		kunmap(out_page);
> -
> -	if (in_page) {
> -		kunmap(in_page);
> -		put_page(in_page);
> -	}
> -
> +	*out_pages =3D DIV_ROUND_UP(cur_out, PAGE_SIZE);
>   	return ret;
>   }
>
>
