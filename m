Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8E44A130
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 14:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbfFRMx4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 08:53:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:38924 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725913AbfFRMx4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 08:53:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BC44AAF11;
        Tue, 18 Jun 2019 12:53:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B2EE9DA871; Tue, 18 Jun 2019 14:54:42 +0200 (CEST)
Date:   Tue, 18 Jun 2019 14:54:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCHSET v2 btrfs/for-next] blkcg, btrfs: fix cgroup writeback
 support
Message-ID: <20190618125442.GL19057@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Tejun Heo <tj@kernel.org>,
        dsterba@suse.com, clm@fb.com, josef@toxicpanda.com, axboe@kernel.dk,
        jack@suse.cz, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
References: <20190615182453.843275-1-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190615182453.843275-1-tj@kernel.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jun 15, 2019 at 11:24:44AM -0700, Tejun Heo wrote:
> Hello,
> 
> Changes from v1[1]
> 
>   * 0001-cgroup-blkcg-Prepare-some-symbols-for-module-and-CON.patch
>     added.  It collects and adds symbol exports and dummy function def
>     to fix module and different config builds.
> 
> When writeback is executed asynchronously (e.g. for compression), bios
> are bounced to and issued by worker pool shared by all cgroups.  This
> leads to significant priority inversions when cgroup IO control is in
> use - IOs for a low priority cgroup can tie down the workers forcing
> higher priority IOs to wait behind them.
> 
> This patchset adds an bio punt mechanism to blkcg and updates btrfs to
> issue async IOs through it.  A bio tagged with REQ_CGROUP_PUNT flag is
> bounced to the asynchronous issue context of the associated blkcg on
> bio_submit().  As the bios are issued from per-blkcg work items,
> there's no concern for priority inversions and it doesn't require
> invasive changes to the filesystems.  The mechanism should be
> generally useful for IO control support across different filesystems.
> 
> This patchset contains the following 9 patches.  The first three are
> my blkcg patches to implement the needed mechanisms.  The latter five
> are Chris Mason's btrfs cleanup and update patches.  Please let me
> know how the patches should be routed.  Given that there currently
> aren't other users, it's likely the easiest to route all through btrfs
> tree.

That would be easiest so to avoid synchronization between two trees,
provided that all non-btrfs commits have acks/reviews.

However, as it's rc5, I'm not at all comfortable to add this patchset to
5.3 queue, the changes seem to be intrusive and redoing bio submission
path is something that will affect all workloads. I did quick tests on
fstests (without cgruops enabled) and this was fine, but that's the
minimum that must work. Wider range of workloads would be needed, I can
do that with mmtests, but all of that means that 5.3 is infeasible.

So this opens more possibilites regarding the patchset routing. Both
parts can go separately through their usual trees.
