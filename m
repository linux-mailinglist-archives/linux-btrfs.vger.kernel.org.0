Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0145A360D6
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2019 18:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbfFEQHn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jun 2019 12:07:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:56212 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728646AbfFEQHn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jun 2019 12:07:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5D943AF3F
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jun 2019 16:07:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D2115DA866; Wed,  5 Jun 2019 18:08:33 +0200 (CEST)
Date:   Wed, 5 Jun 2019 18:08:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: check/lowmem: Reset path in repair mode to
 avoid incorrect item from being passed to lowmem check.
Message-ID: <20190605160833.GC9896@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190517140003.32285-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517140003.32285-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 17, 2019 at 10:00:03PM +0800, Qu Wenruo wrote:
> In lowmem mode, we check fs roots and free space cache by iterating
> each root item and inode item, using btrfs_next_item() and a path
> pointing to the root tree.
> 
> However in repair mode, check_fs_root() can modify the fs root, thus
> CoWs the tree root, and the old path in check_fs
> 
> It could lead to strange behavior, e.g. after repairing a fs tree, the
> path can point to a fs tree.
> Since no ROOT_ITEM exists in fs tree, all remaining trees are skipped in
> repair mode.
> 
> This bug exists from the early time of lowmem mode repair, and is only
> exposed by recent free space inode check code. (Fs tree inodes are
> passed to free space inode check, causing false alerts and repair
> failure).
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

I'll add it to devel, however the lowmem mode of test-check does not
work now, so can't really test it.
