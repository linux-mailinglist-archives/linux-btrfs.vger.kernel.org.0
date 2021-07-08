Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66933BFAB0
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jul 2021 14:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhGHMzQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jul 2021 08:55:16 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40824 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhGHMzQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jul 2021 08:55:16 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8DBF5201BF;
        Thu,  8 Jul 2021 12:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625748753;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TgLVJaNdKY70gVNGdPkihC8wiWwBv6Wj7xgqSR3JdnA=;
        b=h7aAGI5SnBVlU2zYnTj7VftfPQmVmfTdz0OfNqHb4KxKUPoGHwD7w7sNqooalRhgvQc92g
        rDwEDNL25kQE2WVxfMDey0/lnB97nOQwIkLZ9FFfAkfEBsZFxDFaRNsvxeYXIQozOVRNSd
        tb80j1SZKHkWSKXwGNlVkzQ2StySkmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625748753;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TgLVJaNdKY70gVNGdPkihC8wiWwBv6Wj7xgqSR3JdnA=;
        b=Mea4ckys/nWDjFj0mCcHdH6zB2gOlsTJvCAKv1kWIiOkpZOBmmdL/ez88cfTVsGh7yAUJa
        Fh4oHguNTJxuwFBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 86A95A3B97;
        Thu,  8 Jul 2021 12:52:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5F20BDAF79; Thu,  8 Jul 2021 14:49:59 +0200 (CEST)
Date:   Thu, 8 Jul 2021 14:49:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/6] Remove highmem allocations, kmap/kunmap
Message-ID: <20210708124959.GZ2610@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Neal Gompa <ngompa13@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <cover.1625043706.git.dsterba@suse.com>
 <CAEg-Je_N8_rSfVjRD_R1J+ecH1tDW9syZawQavKXRBXQUofjag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEg-Je_N8_rSfVjRD_R1J+ecH1tDW9syZawQavKXRBXQUofjag@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 08, 2021 at 08:45:12AM -0400, Neal Gompa wrote:
> On Thu, Jul 8, 2021 at 7:48 AM David Sterba <dsterba@suse.com> wrote:
> >
> > The highmem was maybe was a good idea long time ago but with 64bit
> > architectures everywhere I don't think we need to take it into account.
> > This does not mean this 32bit won't work, just that it won't try to use
> > temporary pages in highmem for compression and raid56. The key word is
> > temporary. Combining a very fast device (like hundreds of megabytes
> > throughput) and 32bit machine with reasonable memory (for 32bit, like
> > 8G), it could become a problem once low memory is scarce.
> >
> > David Sterba (6):
> >   btrfs: drop from __GFP_HIGHMEM all allocations
> >   btrfs: compression: drop kmap/kunmap from lzo
> >   btrfs: compression: drop kmap/kunmap from zlib
> >   btrfs: compression: drop kmap/kunmap from zstd
> >   btrfs: compression: drop kmap/kunmap from generic helpers
> >   btrfs: check-integrity: drop kmap/kunmap for block pages
> >
> >  fs/btrfs/check-integrity.c | 11 +++-------
> >  fs/btrfs/compression.c     |  6 ++----
> >  fs/btrfs/inode.c           |  3 +--
> >  fs/btrfs/lzo.c             | 42 +++++++++++---------------------------
> >  fs/btrfs/raid56.c          | 10 ++++-----
> >  fs/btrfs/zlib.c            | 42 +++++++++++++-------------------------
> >  fs/btrfs/zstd.c            | 33 +++++++++++-------------------
> >  7 files changed, 49 insertions(+), 98 deletions(-)
> >
> 
> I'd be concerned about the impact of this on SBC devices. All Fedora
> ARM images have zstd compression applied to them, and it would suck if
> we had a performance regression here because of this.

How much memory do the SBC devices have?
