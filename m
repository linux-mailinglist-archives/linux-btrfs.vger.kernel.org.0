Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842E320B4C6
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jun 2020 17:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgFZPhq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jun 2020 11:37:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:32824 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbgFZPhq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jun 2020 11:37:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4AC21AC49;
        Fri, 26 Jun 2020 15:37:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4410BDA703; Fri, 26 Jun 2020 17:37:32 +0200 (CEST)
Date:   Fri, 26 Jun 2020 17:37:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5 3/3] btrfs: refactor btrfs_check_can_nocow() into two
 variants
Message-ID: <20200626153732.GH27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200623232352.668681-1-wqu@suse.com>
 <20200623232352.668681-4-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623232352.668681-4-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 24, 2020 at 07:23:52AM +0800, Qu Wenruo wrote:
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 339d739b2d29..3e2596f2ab74 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4541,10 +4541,8 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
>  	ret = btrfs_check_data_free_space(inode, &data_reserved, block_start,
>  					  blocksize);
>  	if (ret < 0) {
> -		if ((BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
> -					      BTRFS_INODE_PREALLOC)) &&
> -		    btrfs_check_can_nocow(BTRFS_I(inode), block_start,
> -					  &write_bytes, false) > 0) {
> +		if (btrfs_check_nocow_lock(BTRFS_I(inode), block_start,
> +					   &write_bytes) > 0) {
>  			/* For nocow case, no need to reserve data space. */
>  			only_release_metadata = true;
>  		} else {

I don't see the pairing btrfs_check_nocow_unlock in this function,
there's still the btrfs_drew_write_unlock.
