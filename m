Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F4035339E
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Apr 2021 13:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236698AbhDCLLJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Apr 2021 07:11:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:38538 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236707AbhDCLLH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 3 Apr 2021 07:11:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2142AABB1;
        Sat,  3 Apr 2021 11:11:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D53E7DAE77; Sat,  3 Apr 2021 13:08:53 +0200 (CEST)
Date:   Sat, 3 Apr 2021 13:08:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
Message-ID: <20210403110853.GD7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210325071445.90896-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325071445.90896-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 25, 2021 at 03:14:32PM +0800, Qu Wenruo wrote:
> This patchset can be fetched from the following github repo, along with
> the full subpage RW support:
> https://github.com/adam900710/linux/tree/subpage
> 
> This patchset is for metadata read write support.

> Qu Wenruo (13):
>   btrfs: add sysfs interface for supported sectorsize
>   btrfs: use min() to replace open-code in btrfs_invalidatepage()
>   btrfs: remove unnecessary variable shadowing in btrfs_invalidatepage()
>   btrfs: refactor how we iterate ordered extent in
>     btrfs_invalidatepage()
>   btrfs: introduce helpers for subpage dirty status
>   btrfs: introduce helpers for subpage writeback status
>   btrfs: allow btree_set_page_dirty() to do more sanity check on subpage
>     metadata
>   btrfs: support subpage metadata csum calculation at write time
>   btrfs: make alloc_extent_buffer() check subpage dirty bitmap
>   btrfs: make the page uptodate assert to be subpage compatible
>   btrfs: make set/clear_extent_buffer_dirty() to be subpage compatible
>   btrfs: make set_btree_ioerr() accept extent buffer and to be subpage
>     compatible
>   btrfs: add subpage overview comments

Moved from topic branch to misc-next.
