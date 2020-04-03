Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6785219DB4A
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Apr 2020 18:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404251AbgDCQTU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Apr 2020 12:19:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:60184 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404204AbgDCQTU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Apr 2020 12:19:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 03797ABEF;
        Fri,  3 Apr 2020 16:19:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7AA43DA727; Fri,  3 Apr 2020 18:18:43 +0200 (CEST)
Date:   Fri, 3 Apr 2020 18:18:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 11/15] btrfs: put direct I/O checksums in
 btrfs_dio_private instead of bio
Message-ID: <20200403161843.GG5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Christoph Hellwig <hch@lst.de>
References: <cover.1583789410.git.osandov@fb.com>
 <95b275ed47f1e4bdaba53040fe6de9eefdf3a5fd.1583789410.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95b275ed47f1e4bdaba53040fe6de9eefdf3a5fd.1583789410.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 09, 2020 at 02:32:37PM -0700, Omar Sandoval wrote:
> -	file_offset -= dip->logical_offset;
> -	file_offset >>= inode->i_sb->s_blocksize_bits;
> -	csum_size = btrfs_super_csum_size(btrfs_sb(inode->i_sb)->super_copy);
> -	io_bio->csum = orig_io_bio->csum + csum_size * file_offset;

> -		ret = btrfs_lookup_and_bind_dio_csum(inode, dip, bio,
> -						     file_offset);
> -		if (ret)
> -			goto err;
> +		u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
> +		size_t csum_offset;
> +
> +		csum_offset = ((file_offset - dip->logical_offset) >>
> +			       inode->i_sb->s_blocksize_bits) * csum_size;

Please split the expression like it used to be in the original code
(above).

> +		btrfs_io_bio(bio)->csum = dip->sums + csum_offset;
>  	}
>  map:
>  	ret = btrfs_map_bio(fs_info, bio, 0);
> @@ -8047,13 +8018,25 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
>  				loff_t file_offset)
>  {
>  	struct btrfs_dio_private *dip = NULL;
> +	size_t dip_size;
>  	struct bio *bio = NULL;
>  	struct btrfs_io_bio *io_bio;
>  	bool write = (bio_op(dio_bio) == REQ_OP_WRITE);
> +	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
>  
>  	bio = btrfs_bio_clone(dio_bio);
>  
> -	dip = kzalloc(sizeof(*dip), GFP_NOFS);
> +	dip_size = sizeof(*dip);
> +	if (!write && csum) {
> +		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> +		u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
> +		size_t nblocks = (dio_bio->bi_iter.bi_size >>
> +				  inode->i_sb->s_blocksize_bits);

		nblocks = dio_bio->bi_iter.bi_size >> inode->i_sb->s_blocksize_bits;

This overflows 80 chars/line but is IMHO more readable than the split
line.
