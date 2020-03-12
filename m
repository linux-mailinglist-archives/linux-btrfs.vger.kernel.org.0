Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFD36183AAA
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Mar 2020 21:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgCLUdv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Mar 2020 16:33:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:55422 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbgCLUdv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Mar 2020 16:33:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1D3EEACCE;
        Thu, 12 Mar 2020 20:33:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5EA47DA7A7; Thu, 12 Mar 2020 21:33:24 +0100 (CET)
Date:   Thu, 12 Mar 2020 21:33:24 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH v3 0/4] Btrfs: make ranged fsyncs always respect the
 given range
Message-ID: <20200312203324.GI12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org, josef@toxicpanda.com
References: <20200309124108.18952-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309124108.18952-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 09, 2020 at 12:41:04PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This patchset fixes a bug when not using NO_HOLES and makes ranged fsyncs
> respect the given file range when using the NO_HOLES feature.
> 
> The bug is about missing file extents items representing a hole after doing
> a ranged fsync on a file and replaying the log.
> 
> Btrfs doesn't respect the given range for a fsync when the inode's has the
> "need full sync" bit set - it treats the fsync as a full ranged one, operating
> on the whole file, doing more IO and cpu work then needed.
> 
> That behaviour was needed to fix a corruption bug. Commit 0c713cbab6200b
> ("Btrfs: fix race between ranged fsync and writeback of adjacent ranges")
> fixed that bug by turning the ranged fsync into a full ranged one.
> 
> Later the hole detection code of fsync was simplified a lot in order to
> fix another bug when using the NO_HOLES feature - done by commit
> 0e56315ca147b3 ("Btrfs: fix missing hole after hole punching and fsync when
> using NO_HOLES"). That commit now makes it easy to avoid turning the ranged
> fsyncs into non-ranged fsyncs.
> 
> This patchset does those two changes. The first patch fixes the bug mentioned
> before, patches 2 and 3 are preparation cleanups for patch 4, which is the
> one that makes fsync respect the given file range when using NO_HOLES.
> 
> V3: Updated patch one so that the ranged is set to full before locking the
>     inode. To make sure we do writeback and wait for ordered extent
>     completion as much as possible before locking the inode.
>     Remaining patches are unchanged.
> 
> V2: Added one more patch to the series, which is the first patch, that
>     fixes the bug regarding missing holes after doing a ranged fsync.
> 
>     The remaining patches remain the same, only patch 4 had a trivial
>     conflict when rebasing against patch 1 and got its changelog
>     updated. Now all fstests pass with version 2 of this patchset.
> 
> Filipe Manana (4):
>   Btrfs: fix missing file extent item for hole after ranged fsync
>   Btrfs: add helper to get the end offset of a file extent item
>   Btrfs: factor out inode items copy loop from btrfs_log_inode()
>   Btrfs: make ranged full fsyncs more efficient

Moved from for-next to misc-next, thanks.
