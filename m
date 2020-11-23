Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4872C1115
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Nov 2020 17:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732365AbgKWQw3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Nov 2020 11:52:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:52326 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbgKWQw3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Nov 2020 11:52:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A9945ACBD;
        Mon, 23 Nov 2020 16:52:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 60A08DA818; Mon, 23 Nov 2020 17:50:40 +0100 (CET)
Date:   Mon, 23 Nov 2020 17:50:40 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v7 01/12] btrfs: lift rw mount setup from mount and
 remount
Message-ID: <20201123165040.GF8669@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1605736355.git.boris@bur.io>
 <ac259f3ceafae5a8bb9b6c554375588705aa55b2.1605736355.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac259f3ceafae5a8bb9b6c554375588705aa55b2.1605736355.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 18, 2020 at 03:06:16PM -0800, Boris Burkov wrote:
> Mounting rw and remounting from ro to rw naturally share invariants and
> functionality which result in a correctly setup rw filesystem. Luckily,
> there is even a strong unity in the code which implements them. In
> mount's open_ctree, these operations mostly happen after an early return
> for ro file systems, and in remount, they happen in a section devoted to
> remounting ro->rw, after some remount specific validation passes.
> 
> However, there are unfortunately a few differences. There are small
> deviations in the order of some of the operations, remount does not
> cleanup orphan inodes in root_tree or fs_tree, remount does not create
> the free space tree, and remount does not handle "one-shot" mount
> options like clear_cache and uuid tree rescan.
> 
> Since we want to add building the free space tree to remount, and since
> it is possible to leak orphans on a filesystem mounted as ro then
> remounted rw

The statement is not specific if the orphans are files or roots. But I
don't agree that a leak is possible, or need a proof of the claim above.

The mount-time orphan cleanup will start early, but otherwise orphan
cleanup is checked and started on dentry lookups (btrfs_lookup_dentry).
Deleted but not clened tree roorts are all found and removed, regardless
of rw or ro->rw mount.

So I wonder if you claim there's a leak just by lack of an explicit call
on the remount path.
