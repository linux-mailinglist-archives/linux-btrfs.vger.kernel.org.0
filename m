Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08A126FFBD
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Sep 2020 16:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgIROY3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Sep 2020 10:24:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:40388 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgIROY3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Sep 2020 10:24:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 26797AD33;
        Fri, 18 Sep 2020 14:25:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 631F6DA6E0; Fri, 18 Sep 2020 16:23:14 +0200 (CEST)
Date:   Fri, 18 Sep 2020 16:23:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 0/4] btrfs: free space tree mounting fixes
Message-ID: <20200918142313.GF6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1600282812.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1600282812.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 17, 2020 at 11:13:37AM -0700, Boris Burkov wrote:
> A few fixes for issues with mounting the btrfs free space tree
> (aka space_cache v2). These are not dependent, and are only related
> loosely, in that they all apply to mounting the file system with
> the free space tree.
> 
> The first patch fixes -o remount,space_cache=v2.
> 
> The second patch fixes /proc/mounts with regards to the space_cache
> options (space_cache, space_cache=v2, nospace_cache)
> 
> The third patch fixes the slight oversight of not cleaning up the
> space cache free space object or free space inodes when migrating to
> the free space tree.
> 
> The fourth patch stops re-creating the free space objects when we
> are not using space_cache=v1.
> 
> changes for v3:
> Patch 1/4: Change failure to warning logging.
> Patch 2/4: New; fixes mount option printing.
> Patch 3/4: Fix orphan inode vs. delayed iput bug, change remove function
>            to take inode as a sink.
> Patch 4/4: No changes.
> 
> changes for v2:
> Patch 1/3: made remount _only_ work in ro->rw case, added comment.
> Patch 2/3: added btrfs_ prefix to non-static function, removed bad
>            whitespace.
> 
> Boris Burkov (4):
>   btrfs: support remount of ro fs with free space tree
>   btrfs: use sb state to print space_cache mount option
>   btrfs: remove free space items when creating free space tree
>   btrfs: skip space_cache v1 setup when not using it

This passed fstests so I'll add it to for-next, there are still some
minor coding style issues to fix but nothing that would affect
functionality.
