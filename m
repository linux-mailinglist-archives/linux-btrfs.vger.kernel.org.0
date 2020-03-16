Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C666186963
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Mar 2020 11:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbgCPKt3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Mar 2020 06:49:29 -0400
Received: from verein.lst.de ([213.95.11.211]:53730 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730478AbgCPKt3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Mar 2020 06:49:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 006CB68CEC; Mon, 16 Mar 2020 11:49:26 +0100 (CET)
Date:   Mon, 16 Mar 2020 11:49:26 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 12/15] btrfs: get rid of one layer of bios in direct I/O
Message-ID: <20200316104926.GB14886@lst.de>
References: <cover.1583789410.git.osandov@fb.com> <f9d0f9e8b8d11ff103654387f4370f50c6c074ae.1583789410.git.osandov@fb.com> <20200310163835.GD6361@lst.de> <20200311091940.GF252106@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311091940.GF252106@vader>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 11, 2020 at 02:19:40AM -0700, Omar Sandoval wrote:
> On Tue, Mar 10, 2020 at 05:38:35PM +0100, Christoph Hellwig wrote:
> > On Mon, Mar 09, 2020 at 02:32:38PM -0700, Omar Sandoval wrote:
> > > 1. The bio created by the generic direct I/O code (dio_bio).
> > > 2. A clone of dio_bio we create in btrfs_submit_direct() to represent
> > >    the entire direct I/O range (orig_bio).
> > > 3. A partial clone of orig_bio limited to the size of a RAID stripe that
> > >    we create in btrfs_submit_direct_hook().
> > > 4. Clones of each of those split bios for each RAID stripe that we
> > >    create in btrfs_map_bio().
> > 
> > Just curious:  what is number 3 useful for?
> 
> The next thing we do with bio 2 (which has a logical block address) is
> to map it to physical block addresses on each device (btrfs_map_bio()).
> That mapping is per-stripe, so we either have to avoid building bios
> that cross a stripe (which is what buffered I/O does)

And which seems inherently sensible..

> or we have to
> split up the bio (which is what direct I/O does). We probably want to
> move towards the first approach for direct I/O, as well, but reworking
> get_blocks would conflict with the iomap series, and it looks like that
> would be easier to do using iomap instead, anyways.

True.
