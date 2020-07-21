Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BBC228402
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 17:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbgGUPli (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 11:41:38 -0400
Received: from verein.lst.de ([213.95.11.211]:52755 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbgGUPli (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 11:41:38 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 85F1F68AFE; Tue, 21 Jul 2020 17:41:33 +0200 (CEST)
Date:   Tue, 21 Jul 2020 17:41:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Dave Chinner <david@fromorbit.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org
Subject: Re: RFC: iomap write invalidation
Message-ID: <20200721154132.GA11652@lst.de>
References: <20200713074633.875946-1-hch@lst.de> <20200720215125.bfz7geaftocy4r5l@fiona> <20200721145313.GA9217@lst.de> <20200721150432.GH15516@casper.infradead.org> <20200721150615.GA10330@lst.de> <20200721151437.GI15516@casper.infradead.org> <20200721151616.GA11074@lst.de> <20200721152754.GD7597@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721152754.GD7597@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 21, 2020 at 08:27:54AM -0700, Darrick J. Wong wrote:
> On Tue, Jul 21, 2020 at 05:16:16PM +0200, Christoph Hellwig wrote:
> > On Tue, Jul 21, 2020 at 04:14:37PM +0100, Matthew Wilcox wrote:
> > > On Tue, Jul 21, 2020 at 05:06:15PM +0200, Christoph Hellwig wrote:
> > > > On Tue, Jul 21, 2020 at 04:04:32PM +0100, Matthew Wilcox wrote:
> > > > > I thought you were going to respin this with EREMCHG changed to ENOTBLK?
> > > > 
> > > > Oh, true.  I'll do that ASAP.
> > > 
> > > Michael, could we add this to manpages?
> > 
> > Umm, no.  -ENOTBLK is internal - the file systems will retry using
> > buffered I/O and the error shall never escape to userspace (or even the
> > VFS for that matter).
> 
> It's worth dropping a comment somewhere that ENOTBLK is the desired
> "fall back to buffered" errcode, seeing as Dave and I missed that in
> XFS...

Sounds like a good idea, but what would a good place be?
