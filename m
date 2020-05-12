Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23131D0271
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 May 2020 00:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731307AbgELWgy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 May 2020 18:36:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:54108 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727899AbgELWgy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 May 2020 18:36:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B15C9AD5D;
        Tue, 12 May 2020 22:36:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F0685DA70B; Wed, 13 May 2020 00:36:01 +0200 (CEST)
Date:   Wed, 13 May 2020 00:36:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     stijn rutjens <rutjensstijn@gmail.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: allow setting per extent compression
Message-ID: <20200512223601.GG18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, stijn rutjens <rutjensstijn@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CA+UfgrWR1rn-VbHHcK0+2cN08m0C529NtY-ofUMNX3mM4NoTaw@mail.gmail.com>
 <20200414145801.GR5920@twin.jikos.cz>
 <CA+UfgrV2sBYjLQg35OtezUs1r2HSge5TTX+rbWoqBgo66HzD5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+UfgrV2sBYjLQg35OtezUs1r2HSge5TTX+rbWoqBgo66HzD5w@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 21, 2020 at 01:46:59PM +0200, stijn rutjens wrote:
> ""Hi,
> I've added an ioctl flag to notify the interface we want to use the
> upper 4 bits for the compression level (which has significantly
> decreased the size of the patch). How do you want to split the patch
> up?

I'd like to see the patches to answer that.

> > > @@ -1572,9 +1576,9 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
> > >                       filemap_flush(inode->i_mapping);
> > >       }
> > >
> > > -     if (range->compress_type == BTRFS_COMPRESS_LZO) {
> > > +     if ((range->compress_type & 0xF) == BTRFS_COMPRESS_LZO) {
> > >               btrfs_set_fs_incompat(fs_info, COMPRESS_LZO);
> > > -     } else if (range->compress_type == BTRFS_COMPRESS_ZSTD) {
> > > +     } else if ((range->compress_type & 0xF) == BTRFS_COMPRESS_ZSTD) {
> > >               btrfs_set_fs_incompat(fs_info, COMPRESS_ZSTD);
> > >       }
> >
> > For further iterations of the patch, I suggest to split it into more
> > patches by logical change, like adding helpers, extending the ioctl,
> > adding asserts, etc.
> 
> The ioctl interface is now extended (see patch-extend-ioctl.patch)
> for the other patch, see patch-extend-inode.patch
> Where should asserts be added?

Where are the patches? Your mail does not have any attachments.
