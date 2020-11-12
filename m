Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423452B0C99
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 19:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgKLS12 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 13:27:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:59696 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbgKLS10 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 13:27:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 280E4AFF8;
        Thu, 12 Nov 2020 18:27:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 923ABDA6E1; Thu, 12 Nov 2020 19:25:42 +0100 (CET)
Date:   Thu, 12 Nov 2020 19:25:42 +0100
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/14] Another batch of inode vs btrfs_inode cleanups
Message-ID: <20201112182542.GW6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201102144906.3767963-1-nborisov@suse.com>
 <20201105162112.GL6756@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105162112.GL6756@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 05, 2020 at 05:21:12PM +0100, David Sterba wrote:
> On Mon, Nov 02, 2020 at 04:48:52PM +0200, Nikolay Borisov wrote:
> > Here is another batch which  gets use closer to unified btrfs_inode vs inode
> > usage in functions.
> > 
> > Nikolay Borisov (14):
> >   btrfs: Make btrfs_inode_safe_disk_i_size_write take btrfs_inode
> >   btrfs: Make insert_prealloc_file_extent take btrfs_inode
> >   btrfs: Make btrfs_truncate_inode_items take btrfs_inode
> >   btrfs: Make btrfs_finish_ordered_io btrfs_inode-centric
> >   btrfs: Make btrfs_delayed_update_inode take btrfs_inode
> >   btrfs: Make btrfs_update_inode_item take btrfs_inode
> >   btrfs: Make btrfs_update_inode take btrfs_inode
> >   btrfs: Make maybe_insert_hole take btrfs_inode
> >   btrfs: Make find_first_non_hole take btrfs_inode
> >   btrfs: Make btrfs_insert_replace_extent take btrfs_inode
> >   btrfs: Make btrfs_truncate_block take btrfs_inode
> >   btrfs: Make btrfs_cont_expand take btrfs_inode
> >   btrfs: Make btrfs_drop_extents take btrfs_inode
> >   btrfs: Make btrfs_update_inode_fallback take btrfs_inode
> 
> With a few fixups it's now in a topic branch and it does not conflict
> with the pending branches. I will postpone merging it until we have the
> core changes in (like the preemptive flushing and such) but so far it
> seems to be smoother than expected. Thanks.

Moved to misc-next.
