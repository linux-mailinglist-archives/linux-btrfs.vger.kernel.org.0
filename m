Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD5F554C7
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2019 18:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbfFYQoN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jun 2019 12:44:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:53022 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726397AbfFYQoN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jun 2019 12:44:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 52BDAAFA9;
        Tue, 25 Jun 2019 16:44:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 61232DA8F6; Tue, 25 Jun 2019 18:44:57 +0200 (CEST)
Date:   Tue, 25 Jun 2019 18:44:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/11] btrfs: move the space_info code out of
 extent-tree.c
Message-ID: <20190625164457.GR8917@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org
References: <20190618200926.3352-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618200926.3352-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 18, 2019 at 04:09:15PM -0400, Josef Bacik wrote:
> This is the first pass at making extent-tree.c much smaller.  I've purposefully
> done no other cleanups or changes.  The places where I needed to modify callers
> were done in separate patches.  The only time I moved and changed callers in
> large chunks was the moving of reserve_metadata_bytes out of extent-tree.c, and
> that was just to rename the users of reserve_metadata_bytes to
> btrfs_reserve_metadata_bytes.
> 
> There is 0 functional change in this series.  The next step is to move the other
> space reservation code that is specific to delayed_refs, inodes, etc.  But I
> wanted to start with this to make sure we're all onboard with this approach
> before I do other things.
> 
> The diffstat for the whole series is the following
> 
>  fs/btrfs/Makefile           |    2 +-
>  fs/btrfs/ctree.h            |   97 +---
>  fs/btrfs/extent-tree.c      | 1277 +++----------------------------------------
>  fs/btrfs/free-space-cache.c |    1 +
>  fs/btrfs/ioctl.c            |    1 +
>  fs/btrfs/space-info.c       | 1103 +++++++++++++++++++++++++++++++++++++
>  fs/btrfs/space-info.h       |  135 +++++
>  fs/btrfs/super.c            |    1 +
>  fs/btrfs/sysfs.c            |    1 +
>  fs/btrfs/volumes.c          |    1 +
>  10 files changed, 1343 insertions(+), 1276 deletions(-)

With the removed copyright notice, patches added to misc-next.
