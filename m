Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4935C13DD63
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2020 15:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgAPO3o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jan 2020 09:29:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:39414 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbgAPO3o (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jan 2020 09:29:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4DF8DB370;
        Thu, 16 Jan 2020 14:29:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C2099DA791; Thu, 16 Jan 2020 15:29:28 +0100 (CET)
Date:   Thu, 16 Jan 2020 15:29:28 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: statfs: Don't reset f_bavail if we're over
 committing metadata space
Message-ID: <20200116142928.GX3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200115034128.32889-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115034128.32889-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 15, 2020 at 11:41:28AM +0800, Qu Wenruo wrote:
> [BUG]
> When there are a lot of metadata space reserved, e.g. after balancing a
> data block with many extents, vanilla df would report 0 available space.
> 
> [CAUSE]
> btrfs_statfs() would report 0 available space if its metadata space is
> exhausted.
> And the calculation is based on currently reserved space vs on-disk
> available space, with a small headroom as buffer.
> When there is not enough headroom, btrfs_statfs() will report 0
> available space.
> 
> The problem is, since commit ef1317a1b9a3 ("btrfs: do not allow
> reservations if we have pending tickets"), we allow btrfs to over commit
> metadata space, as long as we have enough space to allocate new metadata
> chunks.
> 
> This makes old calculation unreliable and report false 0 available space.
> 
> [FIX]
> Don't do such naive check anymore for btrfs_statfs().
> Also remove the comment about "0 available space when metadata is
> exhausted".

This is intentional and was added to prevent a situation where 'df'
reports available space but exhausted metadata don't allow to create new
inode.

If it gets removed you are trading one bug for another. With the changed
logic in the referenced commit, the metadata exhaustion is more likely
but it's also temporary.

The overcommit and overestimated reservations make it hard if not
impossible to do any accurate calculation in statfs/df. From the
usability side, there are 2 options:

a) return 0 free, while it's still possible to eg. create files
b) return >0 free, but no new file can be created

The user report I got was for b) so that's what the guesswork fixes and
does a). The idea behind that is that there's really low space, but with
the overreservation caused by balance it's not.

I don't see a good way out of that which could be solved inside statfs,
it only interprets the numbers in the best way under circumstances. We
don't have exact reservation, don't have a delta of the
reserved-requested (to check how much the reservation is off).
