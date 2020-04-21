Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F291B32C6
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 00:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgDUWvb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Apr 2020 18:51:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:47974 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgDUWva (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Apr 2020 18:51:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 35507ABBD;
        Tue, 21 Apr 2020 22:51:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 74DE2DA70B; Wed, 22 Apr 2020 00:50:47 +0200 (CEST)
Date:   Wed, 22 Apr 2020 00:50:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 11/15] btrfs: put direct I/O checksums in
 btrfs_dio_private instead of bio
Message-ID: <20200421225047.GO18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
References: <cover.1587072977.git.osandov@fb.com>
 <c6a8fd5e2811e07532c63cec0aee48047b8f32a2.1587072977.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6a8fd5e2811e07532c63cec0aee48047b8f32a2.1587072977.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 16, 2020 at 02:46:21PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> The next commit will get rid of btrfs_dio_private->orig_bio. The only
> thing we really need it for is containing all of the checksums, but we
> can easily put the checksum array in btrfs_dio_private and have the
> submitted bios reference the array. We can also look the checksums up
> while we're setting up instead of the current awkward logic that looks
> them up for orig_bio when the first split bio is submitted.
> 
> (Interestingly, btrfs_dio_private did contain the
> checksums before commit 23ea8e5a0767 ("Btrfs: load checksum data once
> when submitting a direct read io"), but it didn't look them up up
> front.)
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  fs/btrfs/btrfs_inode.h |  3 ++
>  fs/btrfs/inode.c       | 70 +++++++++++++++++++-----------------------
>  2 files changed, 34 insertions(+), 39 deletions(-)
> 
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index b965fa5429ec..94476a8be4cc 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -324,6 +324,9 @@ struct btrfs_dio_private {
>  	 */
>  	blk_status_t (*subio_endio)(struct inode *, struct btrfs_io_bio *,
>  			blk_status_t);
> +
> +	/* Checksums. */
> +	u8 sums[];

I've renamed it to 'csums'
