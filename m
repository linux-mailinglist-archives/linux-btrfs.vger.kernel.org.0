Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA57B97F87
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 17:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfHUP6r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 11:58:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:39040 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727581AbfHUP6r (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 11:58:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8A314AEA1
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2019 15:58:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5D902DA7DB; Wed, 21 Aug 2019 17:59:12 +0200 (CEST)
Date:   Wed, 21 Aug 2019 17:59:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/6] Refactor nocow path
Message-ID: <20190821155912.GC2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190805144708.5432-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805144708.5432-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 05, 2019 at 05:47:02PM +0300, Nikolay Borisov wrote:
> This series aims at making the nocow path code more understanble. This done by 
> doing the following things: 
> 
> 1. Re-arranging and renaming some variables so that they have more expressive
> names, as well as reducing their scope. Patch 1 does this. 
> 
> 2. Since run_delalloc_nocow open-codes traversal of the btree it contains a lot
> of checks which do not pertain to the nocow logic per-se, but are there to 
> ensure the code has found the correct EXTENT_ITEM. The nocow logic itself 
> contains some subtle checks which are non-obvious at first. Patch 2 rectifies 
> this by adding appropriate comments.
> 
> 3. Patch 3 duplicates the call to btrfs_add_ordered_extent into each branch for 
> REGULAR or PREALLOC extents. Despite this duplication I think the code flow 
> becomes more streamlined and easier to understand. It also does away with one 
> of the local variables. 
> 
> 4. Patch 4 moves extent checking code into the branch it pertains to. 
> 
> 5. Patch 5 simplifies the conditions of the main 'if' in that function 
> 
> 6. Finally, patch 6 removes the BUG_ON that will be triggered in case 
> btrfs_add_ordered_extent returned ENOMEM. Now it's replaced with proper graceful
> error handling. 
> 
> This patchset has been tested with a full xfstest run with -onodatacow option
> mount options set. 
> 
> Nikolay Borisov (6):
>   btrfs: Refactor run_delalloc_nocow
>   btrfs: Improve comments around nocow path
>   btrfs: Simplify run_delalloc_nocow
>   btrfs: Streamline code in run_delalloc_nocow in case of inline extents

I'll add 1-4 to misc-next, the remaining patches have some comments.
