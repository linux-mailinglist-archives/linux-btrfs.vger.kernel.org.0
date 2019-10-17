Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDF9DB670
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 20:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbfJQSka (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Oct 2019 14:40:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:47628 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727766AbfJQSka (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Oct 2019 14:40:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1B432AE1A;
        Thu, 17 Oct 2019 18:40:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2C375DA808; Thu, 17 Oct 2019 20:40:40 +0200 (CEST)
Date:   Thu, 17 Oct 2019 20:40:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: check for the full sync flag while holding the
 inode lock during fsync
Message-ID: <20191017184039.GP2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20191016152852.22180-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016152852.22180-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 16, 2019 at 04:28:52PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We were checking for the full fsync flag in the inode before locking the
> inode, which is racy, since at that that time it might not be set but
> after we acquire the inode lock some other task set it. One case where
> this can happen is on a system low on memory and some concurrent task
> failed to allocate an extent map and therefore set the full sync flag on
> the inode, to force the next fsync to work in full mode.
> 
> A consequence of missing the full fsync flag set is hitting the problems
> fixed by commit 0c713cbab620 ("Btrfs: fix race between ranged fsync and
> writeback of adjacent ranges"), BUG_ON() when dropping extents from a log
> tree, hitting assertion failures at tree-log.c:copy_items() or all sorts
> of weird inconsistencies after replaying a log due to file extents items
> representing ranges that overlap.
> 
> So just move the check such that it's done after locking the inode and
> before starting writeback again.
> 
> Fixes: 0c713cbab620 ("Btrfs: fix race between ranged fsync and writeback of adjacent ranges")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Oh the joys of fsync and tree-log, thanks for the fix, queued for 5.4-rc.
