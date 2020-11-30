Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1DC12C8B22
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Nov 2020 18:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387611AbgK3RdA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Nov 2020 12:33:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:58096 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387404AbgK3RdA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Nov 2020 12:33:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3E450AC90;
        Mon, 30 Nov 2020 17:32:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B1249DA6E1; Mon, 30 Nov 2020 18:30:47 +0100 (CET)
Date:   Mon, 30 Nov 2020 18:30:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/6] btrfs: some performance improvements for dbench
 alike workloads
Message-ID: <20201130173047.GH6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1606305501.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1606305501.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 25, 2020 at 12:19:22PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This patchset mostly fixes some races that result in an fsync falling back
> to a transaction commit unncessarily or logging more metadata than it needs
> to. It also addresses link and rename operations logging inodes that were
> fsynced in the previous transaction but they don't need to be logged in
> the current transaction. All these cases can be triggered often by dbench.
> 
> Finally it avoids blocking an fsync for a significant time window when the
> previous transaction is still committing. All these together resulted in
> about +12% throughput with dbench and -8% maximum latency, as mentioned in
> the changelog of the last patch.
> 
> There will be more changes to improve performance with dbench or similar
> workloads, but these have been cooking and testing for about one week and
> are independent from what's coming next.

Looking forward to more perf improvements, much appreciated.

> Filipe Manana (6):
>   btrfs: fix race causing unnecessary inode logging during link and rename
>   btrfs: fix race that results in logging old extents during a fast fsync
>   btrfs: fix race that causes unnecessary logging of ancestor inodes
>   btrfs: fix race that makes inode logging fallback to transaction commit
>   btrfs: fix race leading to unnecessary transaction commit when logging inode
>   btrfs: do not block inode logging for so long during transaction commit

Added to misc-next, thanks.
