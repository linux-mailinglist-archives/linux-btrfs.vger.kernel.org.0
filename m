Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EACD8E1CD4
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2019 15:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390204AbfJWNhs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 09:37:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:47200 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732361AbfJWNhr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 09:37:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0EB14B591;
        Wed, 23 Oct 2019 13:37:45 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] btrfs: extent-tree: Ensure we trim ranges across
 block group boundary
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191023125648.30840-1-wqu@suse.com>
 <20191023125648.30840-3-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <93a74f3e-24c8-03b9-021e-368548d42984@suse.com>
Date:   Wed, 23 Oct 2019 16:37:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023125648.30840-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 23.10.19 г. 15:56 ч., Qu Wenruo wrote:
> [BUG]
> When deleting large files (which cross block group boundary) with discard
> mount option, we find some btrfs_discard_extent() calls only trimmed part
> of its space, not the whole range:
> 
>   btrfs_discard_extent: type=0x1 start=19626196992 len=2144530432 trimmed=1073741824 ratio=50%
> 
> type:		bbio->map_type, in above case, it's SINGLE DATA.
> start:		Logical address of this trim
> len:		Logical length of this trim
> trimmed:	Physically trimmed bytes
> ratio:		trimmed / len
> 
> Thus leading some unused space not discarded.
> 
> [CAUSE]
> When discard mount option is specified, after a transaction is fully
> committed (super block written to disk), we begin to cleanup pinned
> extents in the following call chain:
> 
> btrfs_commit_transaction()
> |- write_all_supers()
> |- btrfs_finish_extent_commit()
>    |- find_first_extent_bit(unpin, 0, &start, &end, EXTENT_DIRTY);
>    |- btrfs_discard_extent()
> 
> However pinned extents are recorded in an extent_io_tree, which can
> merge adjacent extent states.
> 
> When a large file get deleted and it has adjacent file extents across
> block group boundary, we will get a large merged range.
> 
> Then when we pass the large range into btrfs_discard_extent(),
> btrfs_discard_extent() will just trim the first part, without trimming
> the remaining part.
> 
> Furthermore, this bug is not that reliably observed, as if the whole
> block group is empty, there will be another trim for that block group.
> 
> So the most obvious way to find this missing trim needs to delete large
> extents at block group boundary without empting involved block groups.
> 
> [FIX]
> - Allow __btrfs_map_block_for_discard() to modify @length parameter
>   btrfs_map_block() uses its @length paramter to notify the caller how
>   many bytes are mapped in current call.
>   With __btrfs_map_block_for_discard() also modifing the @length,
>   btrfs_discard_extent() now understands if it needs to do next trim.
> 
> - Call btrfs_map_block() in a loop until we hit the range end
>   Since we now know how many bytes are mapped each time, we can iterate
>   through each block group boundary and issue correct trim for each
>   range.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent-tree.c | 40 ++++++++++++++++++++++++++++++----------
>  fs/btrfs/volumes.c     |  6 ++++--
>  2 files changed, 34 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 49cb26fa7c63..45df45fa775b 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1306,8 +1306,10 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
>  int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
>  			 u64 num_bytes, u64 *actual_bytes)
>  {
> -	int ret;
> +	int ret = 0;
>  	u64 discarded_bytes = 0;
> +	u64 end = bytenr + num_bytes;
> +	u64 cur = bytenr;
>  	struct btrfs_bio *bbio = NULL;
>  
>  
> @@ -1316,15 +1318,22 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
>  	 * associated to its stripes that don't go away while we are discarding.
>  	 */
>  	btrfs_bio_counter_inc_blocked(fs_info);
> -	/* Tell the block device(s) that the sectors can be discarded */
> -	ret = btrfs_map_block(fs_info, BTRFS_MAP_DISCARD, bytenr, &num_bytes,
> -			      &bbio, 0);
> -	/* Error condition is -ENOMEM */
> -	if (!ret) {
> -		struct btrfs_bio_stripe *stripe = bbio->stripes;
> +	while (cur < end) {
> +		struct btrfs_bio_stripe *stripe;
>  		int i;
>  
> +		/* Tell the block device(s) that the sectors can be discarded */
> +		ret = btrfs_map_block(fs_info, BTRFS_MAP_DISCARD, cur,
> +				      &num_bytes, &bbio, 0);
> +		/*
> +		 * Error can be -ENOMEM, -ENOENT (no such chunk mapping) or
> +		 * -EOPNOTSUPP. For any such error, @num_bytes is not updated,
> +		 * thus we can't continue anyway.
> +		 */
> +		if (ret < 0)
> +			goto out;
>  
> +		stripe = bbio->stripes;
>  		for (i = 0; i < bbio->num_stripes; i++, stripe++) {
>  			u64 bytes;
>  			struct request_queue *req_q;
> @@ -1341,10 +1350,19 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
>  						  stripe->physical,
>  						  stripe->length,
>  						  &bytes);
> -			if (!ret)
> +			if (!ret) {
>  				discarded_bytes += bytes;
> -			else if (ret != -EOPNOTSUPP)
> -				break; /* Logic errors or -ENOMEM, or -EIO but I don't know how that could happen JDM */
> +			} else if (ret != -EOPNOTSUPP) {
> +				/*
> +				 * Logic errors or -ENOMEM, or -EIO but I don't
> +				 * know how that could happen JDM
> +				 *
> +				 * Ans since there are two loops, explicitly
> +				 * goto out to avoid confusion.
> +				 */
> +				btrfs_put_bbio(bbio);
> +				goto out;
> +			}
>  
>  			/*
>  			 * Just in case we get back EOPNOTSUPP for some reason,
> @@ -1354,7 +1372,9 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
>  			ret = 0;
>  		}
>  		btrfs_put_bbio(bbio);
> +		cur += num_bytes;

Shouldn't  you keep the number of bytes requested to discard and deduct
from the actual amount being discarded.

Say you want to discard 1G but for whatever reason this has to be done
in, say, 1 chunk of 750mb and a second chunk of 250 mb. On the first go
you will discard 750mb and add them to cur, numbytes at this point are
750mb then you call btrfs_map_block with num_bytes being 750mb whereas
they should have been 250mb. And if the code manages to map the 2nd
750mb it could potentially trim more than requested and corrupt data.

>  	}
> +out:
>  	btrfs_bio_counter_dec(fs_info);
>  
>  	if (actual_bytes)
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index a6db11e821a5..f66bd0d03f44 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5578,12 +5578,13 @@ void btrfs_put_bbio(struct btrfs_bio *bbio)
>   * replace.
>   */
>  static int __btrfs_map_block_for_discard(struct btrfs_fs_info *fs_info,
> -					 u64 logical, u64 length,
> +					 u64 logical, u64 *length_ret,
>  					 struct btrfs_bio **bbio_ret)
>  {
>  	struct extent_map *em;
>  	struct map_lookup *map;
>  	struct btrfs_bio *bbio;
> +	u64 length = *length_ret;
>  	u64 offset;
>  	u64 stripe_nr;
>  	u64 stripe_nr_end;
> @@ -5617,6 +5618,7 @@ static int __btrfs_map_block_for_discard(struct btrfs_fs_info *fs_info,
>  
>  	offset = logical - em->start;
>  	length = min_t(u64, em->start + em->len - logical, length);
> +	*length_ret = length;
>  
>  	stripe_len = map->stripe_len;
>  	/*
> @@ -6031,7 +6033,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
>  
>  	if (op == BTRFS_MAP_DISCARD)
>  		return __btrfs_map_block_for_discard(fs_info, logical,
> -						     *length, bbio_ret);
> +						     length, bbio_ret);
>  
>  	ret = btrfs_get_io_geometry(fs_info, op, logical, *length, &geom);
>  	if (ret < 0)
> 
