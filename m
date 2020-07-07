Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C8F216EF9
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 16:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgGGOjR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 10:39:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:35260 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728100AbgGGOjP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Jul 2020 10:39:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 217E9ACA7;
        Tue,  7 Jul 2020 14:39:14 +0000 (UTC)
Subject: Re: [PATCH 13/23] btrfs: add the data transaction commit logic into
 may_commit_transaction
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200630135921.745612-1-josef@toxicpanda.com>
 <20200630135921.745612-14-josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <216b0050-3684-9c74-16e6-8a776a23f41e@suse.com>
Date:   Tue, 7 Jul 2020 17:39:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200630135921.745612-14-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 30.06.20 г. 16:59 ч., Josef Bacik wrote:
> Data space flushing currently unconditionally commits the transaction
> twice in a row, and the last time it checks if there's enough pinned
> extents to satisfy it's reservation before deciding to commit the
> transaction for the 3rd and final time.
> 
> Encode this logic into may_commit_transaction().  In the next patch we
> will pass in U64_MAX for bytes_needed the first two times, and the final
> time we will pass in the actual bytes we need so the normal logic will
> apply.
> 
> This patch exists soley to make the logical changes I will make to the
> flushing state machine separate to make it easier to bisect any
> performance related regressions.
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Tested-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

On a second pass through I'm now somewhat reluctant to merge this code.
may_commit_transaction has grown more logic which pertain solely to
metadata. As such I think we should separate that logic (i.e current
may_commit_transaction) and any further adjustments we might want to
make for data space info. For example all the delayed refs/trans
reservation checks etc. make absolutely no sense for data space info.

> ---
>  fs/btrfs/space-info.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index e041b1d58e28..fb63ddc31540 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -579,21 +579,33 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
>   * will return -ENOSPC.
>   */
>  static int may_commit_transaction(struct btrfs_fs_info *fs_info,
> -				  struct btrfs_space_info *space_info)
> +				  struct btrfs_space_info *space_info,
> +				  u64 bytes_needed)
>  {
>  	struct reserve_ticket *ticket = NULL;
>  	struct btrfs_block_rsv *delayed_rsv = &fs_info->delayed_block_rsv;
>  	struct btrfs_block_rsv *delayed_refs_rsv = &fs_info->delayed_refs_rsv;
>  	struct btrfs_block_rsv *trans_rsv = &fs_info->trans_block_rsv;
>  	struct btrfs_trans_handle *trans;
> -	u64 bytes_needed;
>  	u64 reclaim_bytes = 0;
>  	u64 cur_free_bytes = 0;
> +	bool do_commit = false;
>  
>  	trans = (struct btrfs_trans_handle *)current->journal_info;
>  	if (trans)
>  		return -EAGAIN;
>  
> +	/*
> +	 * If we are data and have passed in U64_MAX we just want to
> +	 * unconditionally commit the transaction to match the previous data
> +	 * flushing behavior.
> +	 */
> +	if ((space_info->flags & BTRFS_BLOCK_GROUP_DATA) &&
> +	   bytes_needed == U64_MAX) {
> +		do_commit = true;
> +		goto check_pinned;
> +	}
> +
>  	spin_lock(&space_info->lock);
>  	cur_free_bytes = btrfs_space_info_used(space_info, true);
>  	if (cur_free_bytes < space_info->total_bytes)
> @@ -607,7 +619,7 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
>  	else if (!list_empty(&space_info->tickets))
>  		ticket = list_first_entry(&space_info->tickets,
>  					  struct reserve_ticket, list);
> -	bytes_needed = (ticket) ? ticket->bytes : 0;
> +	bytes_needed = (ticket) ? ticket->bytes : bytes_needed;
>  
>  	if (bytes_needed > cur_free_bytes)
>  		bytes_needed -= cur_free_bytes;
> @@ -618,6 +630,7 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
>  	if (!bytes_needed)
>  		return 0;
>  
> +check_pinned:
>  	trans = btrfs_join_transaction(fs_info->extent_root);
>  	if (IS_ERR(trans))
>  		return PTR_ERR(trans);
> @@ -627,7 +640,8 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
>  	 * we have block groups that are going to be freed, allowing us to
>  	 * possibly do a chunk allocation the next loop through.
>  	 */
> -	if (test_bit(BTRFS_TRANS_HAVE_FREE_BGS, &trans->transaction->flags) ||
> +	if (do_commit ||
> +	    test_bit(BTRFS_TRANS_HAVE_FREE_BGS, &trans->transaction->flags) ||
>  	    __percpu_counter_compare(&space_info->total_bytes_pinned,
>  				     bytes_needed,
>  				     BTRFS_TOTAL_BYTES_PINNED_BATCH) >= 0)
> @@ -743,7 +757,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
>  		btrfs_wait_on_delayed_iputs(fs_info);
>  		break;
>  	case COMMIT_TRANS:
> -		ret = may_commit_transaction(fs_info, space_info);
> +		ret = may_commit_transaction(fs_info, space_info, num_bytes);
>  		break;
>  	default:
>  		ret = -ENOSPC;
> 
