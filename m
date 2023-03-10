Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207F36B3986
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Mar 2023 10:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjCJJC4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Mar 2023 04:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjCJJBM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Mar 2023 04:01:12 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C3C10A281
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Mar 2023 00:57:21 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTiPv-1q02YW3n7F-00U6TO; Fri, 10
 Mar 2023 09:57:14 +0100
Message-ID: <22ceb4aa-3b37-76f9-4b7b-b045071ca3a2@gmx.com>
Date:   Fri, 10 Mar 2023 16:57:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 14/20] btrfs: simplify btree block checksumming
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-15-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230309090526.332550-15-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:tRGTYvNRCv76PhrMzrLHqXeMZK77q4QZpSM726kKdZ0eUvFczXx
 mtgNyfnbl4oPa5gp8O+Hs/74F0oKs2xiT/gZyLEyi4rfzJ1gx4+76B5Qz01tWZflXqfhG1d
 d9mQJ9lMvXvLc/0N3XrP/npi1eXTmAyvoFiA/pxanAKhRjP9FzAIWlZMm27vMEQI7e3dVgW
 EAWHb6VRhWt1/aQ+LvrhA==
UI-OutboundReport: notjunk:1;M01:P0:oQiVm5itcsA=;O/p4o5sWg0arKGb7btB74lAUfGn
 fL6HhZ/xn+IKwaRWepPQ6hWkOUIcREKKjZXly2p5OkRR66tVMJvVRjyMiwIxvU7AfyUQeK4d9
 4iGvi8a5NmAUuAkxTIZsIT8dhFYax/DvGXmqj6V7t68zokWONmRzOHhpTWrSE3R4CM9tBtSgE
 XHB+sHue9o7wpcvwz1QcL7czbTu1nWdjEBwsHN+AwRYDl2HQbJpuCneRgewDiQ66ETFKhucqK
 n3vjYIxl1l9Anlm9iH1QMKikbAkVSY64nybcOAASMw8CG8yZ9sr3KTSkzOUgxGnv0397VmT5d
 J03cv1GLjedCOzosPGq2pQrDXYjQbXGfm/bns1AlShimRX5pqMaWZfJmFGIf576pfu3CXH309
 ajdg6bbG8XSMPvPrNmsMPnnSz2Dpik+NlLnfOqamWl5YENKVZj9QB0BKUSpBxg30hiHiNXOMz
 iGbrynnkHvV+hgvmI4PPAO+WWvMk5AexCtd3RJoyV6e8NfaXFVmpQLYM9z5pam6UmF8Jie0m1
 okwXNU+18p7204CLKsyO0CSnXNptaPIHSQf1uLypXeg2PbDDFHOkzW10Xy4fWk8kWMcYtmAwG
 JWoWkaYJMudqBc2I0HOC8mxlczlTSERfqKCTfZnW03kBI96DMmAGxyPfMRdL+DjFG28nlbtyu
 p56htPgHVzMbYJGn8B3HaUQNweoGyYQ+9lc0BWXLp2koRXQwtwYd8Ehjzl7tqwS4X0PozUpyh
 Zua+FOht5slxjSc9kUb0uHcSh+lP445NJdmS0V80KJ383vvKswzD7Z/SLfChAid9vJIkZVee6
 4cnTeL1vE9BYiysiqgYjR6xlwDpuLWCRt8Nph8Oyq63p7cIXQ96giWc75UfFD4PMP/quZf822
 fcqTfZtAVeuvldM8DHdPKdut+0Mw/sf+b/Y466womZILwRh9ElE8uQnEs78xumJn9NGxpJoPc
 zmLsVJui9HA/NseWyRLLLWUWm/U=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/9 17:05, Christoph Hellwig wrote:
> The checksumming of btree blocks always operates on the entire
> extent_buffer, and because btree blocks are always allocated contiguously
> on disk they are never split by btrfs_submit_bio.
> 
> Simplify the checksumming code by finding the extent_buffer in the
> btrfs_bio private data instead of trying to search through the bio_vec.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

The whole idea of never merging metadata bios, and let 
btrfs_submit_bio() to handle split, really help a lot to cleanup the eb 
grabbing.

Thanks,
Qu

> ---
>   fs/btrfs/disk-io.c | 121 ++++++++++-----------------------------------
>   1 file changed, 25 insertions(+), 96 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 6795acae476993..e007e15e1455e1 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -312,12 +312,35 @@ int btrfs_read_extent_buffer(struct extent_buffer *eb,
>   	return ret;
>   }
>   
> -static int csum_one_extent_buffer(struct extent_buffer *eb)
> +/*
> + * Checksum a dirty tree block before IO.
> + */
> +blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio)
>   {
> +	struct extent_buffer *eb = bbio->private;
>   	struct btrfs_fs_info *fs_info = eb->fs_info;
> +	u64 found_start = btrfs_header_bytenr(eb);
>   	u8 result[BTRFS_CSUM_SIZE];
>   	int ret;
>   
> +	/*
> +	 * Btree blocks are always contiguous on disk.
> +	 */
> +	if (WARN_ON_ONCE(bbio->file_offset != eb->start))
> +		return BLK_STS_IOERR;
> +	if (WARN_ON_ONCE(bbio->bio.bi_iter.bi_size != eb->len))
> +		return BLK_STS_IOERR;
> +
> +	if (test_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags)) {
> +		WARN_ON_ONCE(found_start != 0);
> +		return BLK_STS_OK;
> +	}
> +
> +	if (WARN_ON_ONCE(found_start != eb->start))
> +		return BLK_STS_IOERR;
> +	if (WARN_ON_ONCE(!PageUptodate(eb->pages[0])))
> +		return BLK_STS_IOERR;
> +
>   	ASSERT(memcmp_extent_buffer(eb, fs_info->fs_devices->metadata_uuid,
>   				    offsetof(struct btrfs_header, fsid),
>   				    BTRFS_FSID_SIZE) == 0);
> @@ -344,8 +367,7 @@ static int csum_one_extent_buffer(struct extent_buffer *eb)
>   		goto error;
>   	}
>   	write_extent_buffer(eb, result, 0, fs_info->csum_size);
> -
> -	return 0;
> +	return BLK_STS_OK;
>   
>   error:
>   	btrfs_print_tree(eb, 0);
> @@ -359,99 +381,6 @@ static int csum_one_extent_buffer(struct extent_buffer *eb)
>   	 */
>   	WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG) ||
>   		btrfs_header_owner(eb) == BTRFS_TREE_LOG_OBJECTID);
> -	return ret;
> -}
> -
> -/* Checksum all dirty extent buffers in one bio_vec */
> -static int csum_dirty_subpage_buffers(struct btrfs_fs_info *fs_info,
> -				      struct bio_vec *bvec)
> -{
> -	struct page *page = bvec->bv_page;
> -	u64 bvec_start = page_offset(page) + bvec->bv_offset;
> -	u64 cur;
> -	int ret = 0;
> -
> -	for (cur = bvec_start; cur < bvec_start + bvec->bv_len;
> -	     cur += fs_info->nodesize) {
> -		struct extent_buffer *eb;
> -		bool uptodate;
> -
> -		eb = find_extent_buffer(fs_info, cur);
> -		uptodate = btrfs_subpage_test_uptodate(fs_info, page, cur,
> -						       fs_info->nodesize);
> -
> -		/* A dirty eb shouldn't disappear from buffer_radix */
> -		if (WARN_ON(!eb))
> -			return -EUCLEAN;
> -
> -		if (WARN_ON(cur != btrfs_header_bytenr(eb))) {
> -			free_extent_buffer(eb);
> -			return -EUCLEAN;
> -		}
> -		if (WARN_ON(!uptodate)) {
> -			free_extent_buffer(eb);
> -			return -EUCLEAN;
> -		}
> -
> -		ret = csum_one_extent_buffer(eb);
> -		free_extent_buffer(eb);
> -		if (ret < 0)
> -			return ret;
> -	}
> -	return ret;
> -}
> -
> -/*
> - * Checksum a dirty tree block before IO.  This has extra checks to make sure
> - * we only fill in the checksum field in the first page of a multi-page block.
> - * For subpage extent buffers we need bvec to also read the offset in the page.
> - */
> -static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct bio_vec *bvec)
> -{
> -	struct page *page = bvec->bv_page;
> -	u64 start = page_offset(page);
> -	u64 found_start;
> -	struct extent_buffer *eb;
> -
> -	if (fs_info->nodesize < PAGE_SIZE)
> -		return csum_dirty_subpage_buffers(fs_info, bvec);
> -
> -	eb = (struct extent_buffer *)page->private;
> -	if (page != eb->pages[0])
> -		return 0;
> -
> -	found_start = btrfs_header_bytenr(eb);
> -
> -	if (test_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags)) {
> -		WARN_ON(found_start != 0);
> -		return 0;
> -	}
> -
> -	/*
> -	 * Please do not consolidate these warnings into a single if.
> -	 * It is useful to know what went wrong.
> -	 */
> -	if (WARN_ON(found_start != start))
> -		return -EUCLEAN;
> -	if (WARN_ON(!PageUptodate(page)))
> -		return -EUCLEAN;
> -
> -	return csum_one_extent_buffer(eb);
> -}
> -
> -blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio)
> -{
> -	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
> -	struct bvec_iter iter;
> -	struct bio_vec bv;
> -	int ret = 0;
> -
> -	bio_for_each_segment(bv, &bbio->bio, iter) {
> -		ret = csum_dirty_buffer(fs_info, &bv);
> -		if (ret)
> -			break;
> -	}
> -
>   	return errno_to_blk_status(ret);
>   }
>   
