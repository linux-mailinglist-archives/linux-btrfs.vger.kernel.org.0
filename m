Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 611A012D2BF
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 18:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfL3ReC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Dec 2019 12:34:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:38332 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbfL3ReB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 12:34:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1A9AEB21A;
        Mon, 30 Dec 2019 17:34:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 47623DA790; Mon, 30 Dec 2019 18:33:53 +0100 (CET)
Date:   Mon, 30 Dec 2019 18:33:52 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 19/22] btrfs: keep track of discard reuse stats
Message-ID: <20191230173352.GW3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dennis Zhou <dennis@kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <cover.1576195673.git.dennis@kernel.org>
 <f5283c2dd8d15699456846bc89e9ee77cc56b049.1576195673.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5283c2dd8d15699456846bc89e9ee77cc56b049.1576195673.git.dennis@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 13, 2019 at 04:22:28PM -0800, Dennis Zhou wrote:
> Keep track of how much we are discarding and how often we are reusing
> with async discard.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/ctree.h            |  3 +++
>  fs/btrfs/discard.c          |  7 +++++++
>  fs/btrfs/free-space-cache.c | 14 ++++++++++++++
>  fs/btrfs/sysfs.c            | 36 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 60 insertions(+)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index dddf51e27bed..edfbe6060e8d 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -474,6 +474,9 @@ struct btrfs_discard_ctl {
>  	u32 delay;
>  	u32 iops_limit;
>  	u64 bps_limit;
> +	u64 discard_extent_bytes;
> +	u64 discard_bitmap_bytes;
> +	atomic64_t discard_bytes_saved;
>  };
>  
>  /* delayed seq elem */
> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> index 55ad357e65f3..fe73814526ef 100644
> --- a/fs/btrfs/discard.c
> +++ b/fs/btrfs/discard.c
> @@ -419,11 +419,15 @@ static void btrfs_discard_workfn(struct work_struct *work)
>  				       block_group->discard_cursor,
>  				       btrfs_block_group_end(block_group),
>  				       minlen, maxlen, true);
> +		WRITE_ONCE(discard_ctl->discard_bitmap_bytes,
> +			   discard_ctl->discard_bitmap_bytes + trimmed);

The same argument is used for read and write, this does not seem to be a
clear usage pattern for WRITE_ONCE, is there are cleaner way to do that?

>  	} else {
>  		btrfs_trim_block_group_extents(block_group, &trimmed,
>  				       block_group->discard_cursor,
>  				       btrfs_block_group_end(block_group),
>  				       minlen, true);
> +		WRITE_ONCE(discard_ctl->discard_extent_bytes,
> +			   discard_ctl->discard_extent_bytes + trimmed);
