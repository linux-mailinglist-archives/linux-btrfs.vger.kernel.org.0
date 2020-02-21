Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32C3216806B
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2020 15:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgBUOhf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 09:37:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:52526 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbgBUOhf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 09:37:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C5F02AFBC;
        Fri, 21 Feb 2020 14:37:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B4AFBDA70E; Fri, 21 Feb 2020 15:37:15 +0100 (CET)
Date:   Fri, 21 Feb 2020 15:37:13 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2 1/3] Btrfs: move all reflink implementation code into
 its own file
Message-ID: <20200221143713.GI2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        Filipe Manana <fdmanana@suse.com>
References: <20200221110450.2636543-1-fdmanana@kernel.org>
 <20200221110508.2641768-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221110508.2641768-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 21, 2020 at 11:05:08AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The reflink code is quite large and has been living in ioctl.c since ever.
> It has grown over the years after many bug fixes and improvements, and
> since I'm planning on making some further improvements on it, it's time
> to get it better organized by moving into its own file, reflink.c
> (similar to what xfs does for example).
> 
> This change only moves the code out of ioctl.c into the new file, it
> doesn't do any other change.

Makes sense.

> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2989,6 +2989,8 @@ int btrfs_dirty_pages(struct inode *inode, struct page **pages,
>  		      size_t num_pages, loff_t pos, size_t write_bytes,
>  		      struct extent_state **cached);
>  int btrfs_fdatawrite_range(struct inode *inode, loff_t start, loff_t end);
> +
> +/* reflink.c */
>  loff_t btrfs_remap_file_range(struct file *file_in, loff_t pos_in,
>  			      struct file *file_out, loff_t pos_out,
>  			      loff_t len, unsigned int remap_flags);

Let's create reflink.h with all the relevant declarations for reflink
moved out of ctree.h too.

I see only BTRFS_MAX_DEDUPE_LEN and declaration of btrfs_remap_file_range,
that's not much for now but it's cleaner and for future extensions.
Thanks.
