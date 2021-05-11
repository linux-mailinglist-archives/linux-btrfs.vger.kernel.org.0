Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A814A37A632
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 May 2021 14:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhEKMDA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 May 2021 08:03:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:39750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230225AbhEKMC7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 May 2021 08:02:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B4703ADCE;
        Tue, 11 May 2021 12:01:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 79DCEDA96D; Tue, 11 May 2021 13:59:23 +0200 (CEST)
Date:   Tue, 11 May 2021 13:59:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/4] btrfs: make read time repair to be only submitted
 for each corrupted sector
Message-ID: <20210511115923.GH7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210503020856.93333-1-wqu@suse.com>
 <20210510204141.GE7604@twin.jikos.cz>
 <67f8a098-3e54-da13-129c-7dce08e1d310@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67f8a098-3e54-da13-129c-7dce08e1d310@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 11, 2021 at 09:07:26AM +0800, Qu Wenruo wrote:
> I'm afraid there is a bug in the patchset.
> 
> If we had a data read for 16 sectors in one page, one sector is bad and 
> can't be repaired, we will under flow subage::readers number.
> 
> The cause is there are two call sites calling end_page_read().
> 
> One in btrfs_submit_read_repair(), one in end_bio_extent_readpage().
> The former one is just calling end_page_read() for the good copy, while 
> the latter one is calling end_page_read() for the full range.
> 
> The direct fix is to make btrfs_submit_read_repair() to handle both 
> cases, and skip the call in end_bio_extent_readpage().
> 
> So I need to update the patchset to include a proper fix for it.
> 
> But on the other hand, I'm also wondering should we use 
> btrfs_subpage::readers as an atomic.
> For a more idiot proof way, we can also go 16bit map for reader/writer 
> accounting, by that even we call end_page_read() twice for the same 
> range, it won't cause anything.
> 
> Any advice on btrfs_subpage::readers implementation?

At this point do what you think would work safely even if the
performance would not be great, eg. using a spinlock around the bitmap.
We'll have to optimize all the bitmaps anyway but not before the
subpage support is finished.
