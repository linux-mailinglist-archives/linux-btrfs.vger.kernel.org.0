Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E841B3377
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 01:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgDUXjJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Apr 2020 19:39:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:58614 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbgDUXjJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Apr 2020 19:39:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 53DBBAC37;
        Tue, 21 Apr 2020 23:39:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 87BF3DA70B; Wed, 22 Apr 2020 01:38:25 +0200 (CEST)
Date:   Wed, 22 Apr 2020 01:38:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 15/15] btrfs: unify buffered and direct I/O read repair
Message-ID: <20200421233825.GQ18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
References: <cover.1587072977.git.osandov@fb.com>
 <65f462557c05818d83fe8e141b24f143e2af347e.1587072977.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65f462557c05818d83fe8e141b24f143e2af347e.1587072977.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 16, 2020 at 02:46:25PM -0700, Omar Sandoval wrote:
> +blk_status_t btrfs_submit_read_repair(struct inode *inode,
> +				      struct bio *failed_bio, u64 phy_offset,
> +				      struct page *page, unsigned int pgoff,
> +				      u64 start, u64 end, int failed_mirror,
> +				      submit_bio_hook_t *submit_bio_hook)
>  {
>  	struct io_failure_record *failrec;
> -	struct inode *inode = page->mapping->host;
> +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
>  	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
> +	struct btrfs_io_bio *failed_io_bio = btrfs_io_bio(failed_bio);
> +	int icsum = phy_offset >> inode->i_sb->s_blocksize_bits;
>  	bool need_validation;
> -	struct bio *bio;
> -	int read_mode = 0;
> +	struct bio *repair_bio;
> +	struct btrfs_io_bio *repair_io_bio;
>  	blk_status_t status;
>  	int ret;
>  
> +	btrfs_info(btrfs_sb(inode->i_sb),
> +		   "Repair Read Error: read error at %llu", start);

This is a new message, there's another one with 'repair read error' but
at 'debug' level, so I'd set that one to debug too. Or maybe drop it
altogether, we want to use the uevents mechanism to communicate such
things to user and not flood the system log.
