Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B42538CF05
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 22:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhEUU0I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 16:26:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:39498 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229532AbhEUU0H (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 16:26:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621628683;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MNe2SGqu4Z0cuZpS9knUqA2lYdwXpzUnIbAFtZypeBA=;
        b=qYwU578YUnSh9ZaCQjhqkrg4k51CyM3Oshp/qGB+sFFqmLs26aJ43lng+UJe8ZXYL/gCxl
        cj3RFehlkV7D4MHndfzgi3PZHiEmbeVDcKkSNC4ZxwX6X+5kkyqPpYbm+wITSAq0OSBuCl
        jYht08IPwlpDu0yx3C8fzc9pXaKewbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621628683;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MNe2SGqu4Z0cuZpS9knUqA2lYdwXpzUnIbAFtZypeBA=;
        b=TmO+GJ0c3Bz30y+MMIZdvqbE6qMTsrlX9td8YGfaQ7Bl4iHzkeVJs02TXvV6fs2HxXBgY7
        7Umih0U9XSVLHKDg==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5C3B1AAA6;
        Fri, 21 May 2021 20:24:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D07E6DA730; Fri, 21 May 2021 22:22:08 +0200 (CEST)
Date:   Fri, 21 May 2021 22:22:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Subject: Re: [Patch v2 07/42] btrfs: pass btrfs_inode into
 btrfs_writepage_endio_finish_ordered()
Message-ID: <20210521202208.GQ7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
References: <20210427230349.369603-1-wqu@suse.com>
 <20210427230349.369603-8-wqu@suse.com>
 <c72f998f-88c4-8554-815a-d2c25c651393@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c72f998f-88c4-8554-815a-d2c25c651393@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 21, 2021 at 10:27:08AM -0400, Josef Bacik wrote:
> On 4/27/21 7:03 PM, Qu Wenruo wrote:
> > There is a pretty bad abuse of btrfs_writepage_endio_finish_ordered() in
> > end_compressed_bio_write().
> > 
> > It passes compressed pages to btrfs_writepage_endio_finish_ordered(),
> > which is only supposed to accept inode pages.
> > 
> > Thankfully the important info here is the inode, so let's pass
> > btrfs_inode directly into btrfs_writepage_endio_finish_ordered(), and
> > make @page parameter optional.
> > 
> > By this, end_compressed_bio_write() can happily pass page=NULL while
> > still get everything done properly.
> > 
> > Also, to cooperate with such modification, replace @page parameter for
> > trace_btrfs_writepage_end_io_hook() with btrfs_inode.
> > Although this removes page_index info, the existing start/len should be
> > enough for most usage.
> > 
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> This was merged into misc-next yesterday it looks like, and it's caused both of 
> my VM's that do compression variations to panic on different tests, one on 
> btrfs/011 and one on btrfs/027.  I bisected it to this patch, I'm not sure 
> what's wrong with it but it needs to be dropped from misc-next until it gets 
> fixed otherwise it'll keep killing the overnight xfstests runs.  Thanks,

The single patch can't be removed due to dependencies, so I'll put the
whole series to a topic branch again so misc-next works.
