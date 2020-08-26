Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A230D252BBC
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 12:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbgHZKvy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 06:51:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:44872 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728572AbgHZKvw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 06:51:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7155CB19B;
        Wed, 26 Aug 2020 10:52:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8815ADA730; Wed, 26 Aug 2020 12:50:42 +0200 (CEST)
Date:   Wed, 26 Aug 2020 12:50:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/8] Lockdep fixes
Message-ID: <20200826105042.GC28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1597936173.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1597936173.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 20, 2020 at 11:18:23AM -0400, Josef Bacik wrote:
> Hello,
> 
> While reworking the btrfs locking to use a rwsem I discovered a few more lockdep
> issues because of the new locking.  These are stand alone fixes that are safe
> enough to go into 5.9, so I've broken them out from the overall locking rework.
> I addressed the issues that Filipe pointed out (I think I did anyway), and run
> the whole series through xfstests and saw no more lockdep messages.
>  
> fs/btrfs/ctree.c       |   6 +-
>  fs/btrfs/dev-replace.c |   6 +-
>  fs/btrfs/extent-tree.c |   2 +-
>  fs/btrfs/extent_io.c   |   8 +--
>  fs/btrfs/extent_io.h   |   6 +-
>  fs/btrfs/ioctl.c       |  27 ++++++---
>  fs/btrfs/scrub.c       | 122 +++++++++++++++++++++++------------------
>  fs/btrfs/volumes.c     |  23 ++++----
>  fs/btrfs/volumes.h     |   3 +
>  9 files changed, 121 insertions(+), 82 deletions(-)

Added to misc-next, thanks.
