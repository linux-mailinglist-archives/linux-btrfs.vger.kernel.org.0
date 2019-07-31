Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC5227C7B6
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2019 17:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfGaP5k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Jul 2019 11:57:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:54150 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725209AbfGaP5k (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Jul 2019 11:57:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7C8AEABE9;
        Wed, 31 Jul 2019 15:57:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EF8B0DA7ED; Wed, 31 Jul 2019 17:58:13 +0200 (CEST)
Date:   Wed, 31 Jul 2019 17:58:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Jungyeon Yoon <jungyeon.yoon@gmail.com>
Subject: Re: [PATCH 0/3] btrfs: Part 2 of enhanced defence against fuzzed
 images
Message-ID: <20190731155813.GP28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Jungyeon Yoon <jungyeon.yoon@gmail.com>
References: <20190716090034.11641-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716090034.11641-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 16, 2019 at 05:00:31PM +0800, Qu Wenruo wrote:
> This wave has the following features:
> - Hunt down BUG_ON() in btrfs_delete_delayed_dir_index()
>   EEXIST can cause BUG_ON(). And all callers of this function has
>   already handled error by aborting transacation.
> 
> - Only allocate extents from the same block group type
>   This is a very tricky bug, needs MIXED_GROUP super flag with regular
>   block groups (separate META and DATA) and corrupted extent tree.
> 
> - ROOT_ITEM check for tree checker
>   This kills the unaligned bytenr, invalid level and incorrect reloc
>   tree.
> 
> Reported-by: Jungyeon Yoon <jungyeon.yoon@gmail.com>
> 
> Qu Wenruo (3):
>   btrfs: delayed-inode: Kill the BUG_ON() in
>     btrfs_delete_delayed_dir_index()
>   btrfs: extent-tree: Make sure we only allocate extents from block
>     groups with the same type
>   btrfs: tree-checker: Add ROOT_ITEM check

Added to misc-next, with some minor updates, thanks.
