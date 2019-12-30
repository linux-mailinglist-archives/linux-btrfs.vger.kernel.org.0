Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4368E12D2D8
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 18:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfL3RkD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Dec 2019 12:40:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:39266 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbfL3RkC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 12:40:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 04FC5ACBD;
        Mon, 30 Dec 2019 17:40:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 36587DA790; Mon, 30 Dec 2019 18:39:54 +0100 (CET)
Date:   Mon, 30 Dec 2019 18:39:54 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 18/22] btrfs: only keep track of data extents for async
 discard
Message-ID: <20191230173954.GX3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dennis Zhou <dennis@kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <cover.1576195673.git.dennis@kernel.org>
 <7dbf1733c917f37122c630d392622d70021cdbdb.1576195673.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dbf1733c917f37122c630d392622d70021cdbdb.1576195673.git.dennis@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 13, 2019 at 04:22:27PM -0800, Dennis Zhou wrote:
> As mentioned earlier, discarding data can be done either by issuing an
> explicit discard or implicitly by reusing the LBA. Metadata chunks see
> much more frequent reuse due to well it being metadata. So instead of
> explicitly discarding metadata blocks, just leave them be and let the
> latter implicit discarding be done for them.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/block-group.h |  6 ++++++
>  fs/btrfs/discard.c     | 11 +++++++++--
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 601e1d217e22..ee8441439a56 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -182,6 +182,12 @@ static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
>  	return (block_group->start + block_group->length);
>  }
>  
> +static inline bool btrfs_is_block_group_data(
> +					struct btrfs_block_group *block_group)
> +{
> +	return (block_group->flags & BTRFS_BLOCK_GROUP_DATA);

What happens for mixed data and metadata block groups? As this is a
special mode that will likely lead to fragmented block groups I think
that async discard won't be able to help much.

I'd suggest to make the test explicit only for the separate block group
types and comment that mixed bg's are not supported.
