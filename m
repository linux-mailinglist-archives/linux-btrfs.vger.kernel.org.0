Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F8D295088
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 18:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444381AbgJUQOo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 12:14:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:36326 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390626AbgJUQOn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 12:14:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C2373ABA2;
        Wed, 21 Oct 2020 16:14:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1662FDA7C5; Wed, 21 Oct 2020 18:13:12 +0200 (CEST)
Date:   Wed, 21 Oct 2020 18:13:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/3] Lockdep fixes for misc-next
Message-ID: <20201021161311.GG6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1603137558.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1603137558.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 19, 2020 at 04:02:28PM -0400, Josef Bacik wrote:
> Hello,
> 
> Here's a few lockdep fixes for misc-next+my rwsem patch.  Nothing too crazy, but
> the last one is a little wonkey because qgroups does a backref resolution while
> adding delayed refs.  Generally we do the right thing with searching the commit
> roots and skipping the locking, with the exception of looking up fs roots if we
> have to resolve indirect refs.  This obviously uses the normal lookup and
> locking stuff, which is problematic in the new world order.  For now I'm fixing
> it with a special helper for backref lookups that either finds the root in
> cache, or generates a temporary root that's not inserted into the fs roots radix
> tree and is only used to do the backref resolution.  Thanks,
> 
> Josef
> 
> Josef Bacik (3):
>   btrfs: drop the path before adding qgroup items when enabling qgroups
>   btrfs: protect the fs_info->caching_block_groups differently
>   btrfs: add a helper to read the tree_root commit root for backref
>     lookup

I'll add 1 and 3 to misc-next for now.
