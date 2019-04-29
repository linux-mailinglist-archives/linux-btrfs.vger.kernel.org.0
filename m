Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8653AE9F6
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2019 20:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbfD2SQZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Apr 2019 14:16:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:37418 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728748AbfD2SQZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Apr 2019 14:16:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 69718ACE3;
        Mon, 29 Apr 2019 18:16:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2AD3CDA86C; Mon, 29 Apr 2019 20:17:24 +0200 (CEST)
Date:   Mon, 29 Apr 2019 20:17:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH][v2] btrfs: track odirect bytes in flight
Message-ID: <20190429181724.GX20156@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20190410195610.84110-1-josef@toxicpanda.com>
 <20190425205247.99177-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425205247.99177-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 25, 2019 at 04:52:47PM -0400, Josef Bacik wrote:
> When diagnosing a slowdown of generic/224 I noticed we were not doing
> anything when calling into shrink_delalloc().  This is because all
> writes in 224 are O_DIRECT, not delalloc, and thus our delalloc_bytes
> counter is 0, which short circuits most of the work inside of
> shrink_delalloc().  However O_DIRECT writes still consume metadata
> resources and generate ordered extents, which we can still wait on.
> 
> Fix this by tracking outstandingn odirect write bytes, and use this as
> well as the delalloc byts counter to decide if we need to lookup and
> wait on any ordered extents.  If we have more odirect writes than
> delalloc bytes we'll go ahead and wait on any ordered extents
> irregardless of our flush state as flushing delalloc is likely to not
> gain us anything.

Ok, that helps.

> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v1->v2:
> - updated the changelog
> 
>  fs/btrfs/ctree.h        |  1 +
>  fs/btrfs/disk-io.c      | 15 ++++++++++++++-
>  fs/btrfs/extent-tree.c  | 17 +++++++++++++++--
>  fs/btrfs/ordered-data.c |  9 ++++++++-
>  4 files changed, 38 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 7e774d48c48c..e293d74b2ead 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1016,6 +1016,7 @@ struct btrfs_fs_info {
>  	/* used to keep from writing metadata until there is a nice batch */
>  	struct percpu_counter dirty_metadata_bytes;
>  	struct percpu_counter delalloc_bytes;
> +	struct percpu_counter odirect_bytes;

I've changed odirect to dio everywhere, as this is the common reference
to direct IO kernel code, O_DIRECT is for userspace.
