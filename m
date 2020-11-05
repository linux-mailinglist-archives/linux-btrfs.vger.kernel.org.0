Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD942A8367
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 17:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgKEQWw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 11:22:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:50296 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgKEQWw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Nov 2020 11:22:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 45DB8AAF1;
        Thu,  5 Nov 2020 16:22:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6CBCADA6E3; Thu,  5 Nov 2020 17:21:12 +0100 (CET)
Date:   Thu, 5 Nov 2020 17:21:12 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/14] Another batch of inode vs btrfs_inode cleanups
Message-ID: <20201105162112.GL6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201102144906.3767963-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102144906.3767963-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 02, 2020 at 04:48:52PM +0200, Nikolay Borisov wrote:
> Here is another batch which  gets use closer to unified btrfs_inode vs inode
> usage in functions.
> 
> Nikolay Borisov (14):
>   btrfs: Make btrfs_inode_safe_disk_i_size_write take btrfs_inode
>   btrfs: Make insert_prealloc_file_extent take btrfs_inode
>   btrfs: Make btrfs_truncate_inode_items take btrfs_inode
>   btrfs: Make btrfs_finish_ordered_io btrfs_inode-centric
>   btrfs: Make btrfs_delayed_update_inode take btrfs_inode
>   btrfs: Make btrfs_update_inode_item take btrfs_inode
>   btrfs: Make btrfs_update_inode take btrfs_inode
>   btrfs: Make maybe_insert_hole take btrfs_inode
>   btrfs: Make find_first_non_hole take btrfs_inode
>   btrfs: Make btrfs_insert_replace_extent take btrfs_inode
>   btrfs: Make btrfs_truncate_block take btrfs_inode
>   btrfs: Make btrfs_cont_expand take btrfs_inode
>   btrfs: Make btrfs_drop_extents take btrfs_inode
>   btrfs: Make btrfs_update_inode_fallback take btrfs_inode

With a few fixups it's now in a topic branch and it does not conflict
with the pending branches. I will postpone merging it until we have the
core changes in (like the preemptive flushing and such) but so far it
seems to be smoother than expected. Thanks.
