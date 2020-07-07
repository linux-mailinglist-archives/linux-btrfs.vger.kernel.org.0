Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAD12174E0
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 19:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgGGROm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 13:14:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:57084 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbgGGROm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Jul 2020 13:14:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D75E5ADA3;
        Tue,  7 Jul 2020 17:14:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C9A2DDA818; Tue,  7 Jul 2020 19:14:22 +0200 (CEST)
Date:   Tue, 7 Jul 2020 19:14:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: start deprecation of mount option inode_cache
Message-ID: <20200707171422.GD16141@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200623185032.14983-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623185032.14983-1-dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 23, 2020 at 08:50:32PM +0200, David Sterba wrote:
> Remaining issues:
> 
> - if the option was enabled, new inodes created, the option disabled
>   again, the cache is still stored on the devices and there's currently
>   no way to remove it

The diffstat of the removal is

 b/fs/btrfs/Makefile           |    2 
 b/fs/btrfs/ctree.h            |    5 
 b/fs/btrfs/disk-io.c          |    2 
 b/fs/btrfs/free-space-cache.c |   88 ------
 b/fs/btrfs/inode.c            |   72 ++++-
 b/fs/btrfs/ioctl.c            |    1 
 b/fs/btrfs/relocation.c       |    1 
 b/fs/btrfs/super.c            |   10 
 b/fs/btrfs/transaction.c      |   16 -
 b/fs/btrfs/tree-log.c         |    2 
 fs/btrfs/inode-map.c          |  580 ------------------------------------------
 fs/btrfs/inode-map.h          |   16 -
 12 files changed, 72 insertions(+), 723 deletions(-)

whoever would like to claim it in the 5.11 develoment time will have to
provide fix for the remaining issue(s).
