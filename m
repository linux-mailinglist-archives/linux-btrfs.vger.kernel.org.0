Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8480D14EC8A
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 13:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgAaMfK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 07:35:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:50898 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728500AbgAaMfJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 07:35:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2C1ABAC7C;
        Fri, 31 Jan 2020 12:35:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 70644DA7E5; Fri, 31 Jan 2020 13:34:48 +0100 (CET)
Date:   Fri, 31 Jan 2020 13:34:48 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: statfs: Don't reset f_bavail if we're over
 committing metadata space
Message-ID: <20200131123448.GA3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200115034128.32889-1-wqu@suse.com>
 <38a5dc98-7233-0252-4ba3-76c59d7b21e7@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38a5dc98-7233-0252-4ba3-76c59d7b21e7@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 30, 2020 at 04:05:10PM -0500, Josef Bacik wrote:
> On 1/14/20 10:41 PM, Qu Wenruo wrote:
> > [BUG]
> > When there are a lot of metadata space reserved, e.g. after balancing a
> > data block with many extents, vanilla df would report 0 available space.
> > 
> > [CAUSE]
> > btrfs_statfs() would report 0 available space if its metadata space is
> > exhausted.
> > And the calculation is based on currently reserved space vs on-disk
> > available space, with a small headroom as buffer.
> > When there is not enough headroom, btrfs_statfs() will report 0
> > available space.
> > 
> > The problem is, since commit ef1317a1b9a3 ("btrfs: do not allow
> > reservations if we have pending tickets"), we allow btrfs to over commit
> > metadata space, as long as we have enough space to allocate new metadata
> > chunks.
> > 
> > This makes old calculation unreliable and report false 0 available space.
> > 
> > [FIX]
> > Don't do such naive check anymore for btrfs_statfs().
> > Also remove the comment about "0 available space when metadata is
> > exhausted".
> > 
> > Please note that, this is a just a quick fix. There are still a lot of
> > things to be improved.
> > 
> > Fixes: ef1317a1b9a3 ("btrfs: do not allow reservations if we have pending tickets")
> 
> This isn't the patch that broke it.  The patch that broke it is the patch that 
> introduced this code in the first place.
> 
> And this isn't the proper fix either, because technically we have 0 available if 
> we don't have enough space for our global reserve _and_ we don't have any 
> unallocated space.  So for now the best "quick" fix would be to make the 
> condition something like
> 
> if (!mixed && block-rsv->space_info->full &&
>      total_free_meta - thresh < block_rsv->size)

Yes, that seems to be the missing part of my patch that added the above
check. In the testcase there was no remaining metadata space so the
->full == 1 was implied.
