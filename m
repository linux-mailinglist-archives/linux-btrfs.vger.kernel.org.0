Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BDB25DB52
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Sep 2020 16:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbgIDOVT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Sep 2020 10:21:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:34784 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730443AbgIDOVR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Sep 2020 10:21:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0EFE1B19E;
        Fri,  4 Sep 2020 14:21:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6093ADA6E0; Fri,  4 Sep 2020 16:20:01 +0200 (CEST)
Date:   Fri, 4 Sep 2020 16:20:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/4][v2] Lockdep fixes
Message-ID: <20200904142000.GX28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1598996236.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1598996236.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 01, 2020 at 05:40:34PM -0400, Josef Bacik wrote:
> v1->v2:
> - Included the add_missing_dev patch in the series.
> - Added a patch to kill the rcu protection for fs_info->space_info.
> - Fixed the raid sysfs init stuff to be completely out of link_block_group, as
>   it causes a lockdep splat with the rwsem conversion.
> 
> Hello,
> 
> These are the last two lockdep splats I'm able to see in my testing.  We have
> like 4 variations of the same lockdep splat that's addressed by 
> 
> btrfs: do not create raid sysfs entries under chunk_mutex
> 
> Basically this particular dependency pulls in the kernfs_mutex under the
> chunk_mutex, and so we have like 4 issues in github with slightly different
> splats, but are all fixed by that fix.  With these two patches (and the one I
> sent the other day for add_missing_dev) I haven't hit any lockdep splats in 6
> runs of xfstests on 3 different VMs in the last 12 hours.  That means it should
> take Dave at least 2 runs before he hits a new one.  Thanks,
> 
> Josef Bacik (4):
>   btrfs: fix lockdep splat in add_missing_dev
>   btrfs: init sysfs for devices outside of the chunk_mutex

So the two patches were in misc-next and I started to see lockdep
complaining in btrfs/011, which is very early in the test list and this
makes it impossible to notice further lockdep reports.

I'll move the patches to a topic branch and will retest misc-next to see
what's the actual list of lockdep things to fix, so we have a clean
state before the eb rwsem switch.
