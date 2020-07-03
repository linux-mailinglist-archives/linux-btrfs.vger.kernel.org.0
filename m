Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE5D2139CC
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jul 2020 14:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgGCMIe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jul 2020 08:08:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:56660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbgGCMIe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jul 2020 08:08:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E3718AC2D;
        Fri,  3 Jul 2020 12:08:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 77787DA87C; Fri,  3 Jul 2020 14:08:14 +0200 (CEST)
Date:   Fri, 3 Jul 2020 14:08:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/4] btrfs: only commit the delayed inode when doing a
 full fsync
Message-ID: <20200703120812.GY27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200702113159.153135-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702113159.153135-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 02, 2020 at 12:31:59PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Commit 2c2c452b0cafdc ("Btrfs: fix fsync when extend references are added
> to an inode") forced a commit of the delayed inode when logging an inode
> in order to ensure we would end up logging the inode item during a full
> fsync. By committing the delayed inode, we updated the inode item in the
> fs/subvolume tree and then later when copying items from leafs modified in
> the current transaction into the log tree (with copy_inode_items_to_log())
> we ended up copying the inode item from the fs/subvolume tree into the log
> tree. Logging an up to date version of the inode item is required to make
> sure at log replay time we get the link count fixup triggered among other
> things (replay xattr deletes, etc). The test case generic/040 from fstests
> exercises the bug which that commit fixed.
> 
> However for a fast fsync we don't need to commit the delayed inode because
> we always log an up to date version of the inode item based on the struct
> btrfs_inode we have in-memory. We started doing this for fast fsyncs since
> commit e4545de5b035c7 ("Btrfs: fix fsync data loss after append write").
> 
> So just stop committing the delayed inode if we are doing a fast fsync,
> we are only wasting time and adding contention on fs/subvolume tree.
> 
> This patch is part of a series that has the following patches:
> 
> 1/4 btrfs: only commit the delayed inode when doing a full fsync
> 2/4 btrfs: only commit delayed items at fsync if we are logging a directory
> 3/4 btrfs: stop incremening log_batch for the log root tree when syncing log
> 4/4 btrfs: remove no longer needed use of log_writers for the log root tree
> 
> After the entire patchset applied I saw about 12% decrease on max latency
> reported by dbench.

That's impressive. Getting reliable perf improvements in the low
percents is hard and 10+ is beyond expectations.

As the patches are short I'd like to tag them for stable. The closest
one that applies to all is 5.4, that I determined from the commit
references in the changelogs. However I'd appreciate if you could take a
look if it's worth to tag the patches for older stable trees where it
applies (since 4.4). I don't have full overview of all the logging or
fsync updates so might miss some dependency. Thanks.
