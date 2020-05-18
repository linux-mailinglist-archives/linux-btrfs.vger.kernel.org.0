Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DC91D7B5C
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 May 2020 16:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgEROgN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 May 2020 10:36:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:40636 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbgEROgN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 May 2020 10:36:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 314DFACCE;
        Mon, 18 May 2020 14:36:14 +0000 (UTC)
Date:   Mon, 18 May 2020 09:36:08 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/9] btrfs: Switch to iomap_dio_rw() for dio
Message-ID: <20200518143608.uv3h3ugvteefzdel@fiona>
References: <20200327161348.to4upflzczkbbpfo@fiona>
 <20200507061430.GA8939@infradead.org>
 <20200507113741.GJ18421@twin.jikos.cz>
 <20200507121037.GA25363@infradead.org>
 <20200508031405.br4dcibcyuoluxum@fiona>
 <20200509135914.GA4962@infradead.org>
 <20200510040601.bub3du7g5kepeakw@fiona>
 <20200512145807.GA23409@infradead.org>
 <20200512171927.tk46sbriqvhasvsq@fiona>
 <20200515141305.GA27936@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515141305.GA27936@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On  7:13 15/05, Christoph Hellwig wrote:
> 
> FYI, generic/475 always fail on me for btrfs, due to the warnings on
> transaction abort.
> 
> Anyway, I have come up with a version that seems to mostly work.
> 
> The main change is that btrfs_sync_file stashes away the journal handle.

Unfortunately, this will not fly. I tested this week and found
transactions begin in writepage() etc. We could work on stashing journal
handle in those functions as well, but it looks hackish. We might revert
to it as a last resort.

In the meantime, I am trying to revert the allocations in case of an
error.

> I also had to merge parts of the ->iomap_end patch into the main iomap
> one.  I also did some cleanups to my iomap changes while looking over it.
> Let me know what you thing, the tree is here:
> 
>     git://git.infradead.org/users/hch/misc.git btrfs-dio
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-dio

-- 
Goldwyn
