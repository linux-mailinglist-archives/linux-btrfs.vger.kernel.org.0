Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A13B29F39C
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 18:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgJ2Ru2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 13:50:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:55376 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgJ2Ru1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 13:50:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8853EAD63;
        Thu, 29 Oct 2020 17:50:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0A5E4DA7CE; Thu, 29 Oct 2020 18:48:49 +0100 (CET)
Date:   Thu, 29 Oct 2020 18:48:48 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v3 10/12] btrfs: implement space clamping for preemptive
 flushing
Message-ID: <20201029174848.GQ6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Nikolay Borisov <nborisov@suse.com>
References: <cover.1602249928.git.josef@toxicpanda.com>
 <5ddb5076afa5872f8edf3bb4ea17aacec8e079fd.1602249928.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ddb5076afa5872f8edf3bb4ea17aacec8e079fd.1602249928.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 09, 2020 at 09:28:27AM -0400, Josef Bacik wrote:
> +static inline void maybe_clamp_preempt(struct btrfs_fs_info *fs_info,
> +				       struct btrfs_space_info *space_info)
> +{
> +	u64 ordered = percpu_counter_sum_positive(&fs_info->ordered_bytes);
> +	u64 delalloc = percpu_counter_sum_positive(&fs_info->delalloc_bytes);
> +
> +	/*
> +	 * If we're heavy on ordered operations then clamping won't help us.  We
> +	 * need to clamp specifically to keep up with dirty'ing buffered
> +	 * writers, because there's not a 1:1 correlation of writing delalloc
> +	 * and freeing space, like there is with flushing delayed refs or
> +	 * delayed nodes.  If we're already more ordered than delalloc then
> +	 * we're keeping up, otherwise we aren't and should probably clamp.
> +	 */
> +	if (ordered < delalloc)
> +		space_info->clamp = min(space_info->clamp + 1, 8);

So the divisor will go up to 2^8 = 256, is that intentional?

> --- a/fs/btrfs/space-info.h
> +++ b/fs/btrfs/space-info.h
> @@ -22,6 +22,9 @@ struct btrfs_space_info {
>  				   the space info if we had an ENOSPC in the
>  				   allocator. */
>  
> +	int clamp;		/* Used to scale our threshold for preemptive
> +				   flushing. */

Struct comments should go on the line before so we don't have this
awkward formatting but the rest of the struct has that so let it be. One
thing I'm missing is that it's power of two, I'll add it there.

> +
>  	unsigned int full:1;	/* indicates that we cannot allocate any more
>  				   chunks for this space */
>  	unsigned int chunk_alloc:1;	/* set if we are allocating a chunk */
> -- 
> 2.26.2
