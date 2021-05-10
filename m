Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2611379815
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 May 2021 22:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbhEJUCu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 May 2021 16:02:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:41528 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229877AbhEJUCs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 May 2021 16:02:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 766E2B05E;
        Mon, 10 May 2021 20:01:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 75DC8DB228; Mon, 10 May 2021 21:59:13 +0200 (CEST)
Date:   Mon, 10 May 2021 21:59:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: return whole extents in fiemap
Message-ID: <20210510195913.GB7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <274e5bcebdb05a8969fc300b4802f33da2fbf218.1617746680.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <274e5bcebdb05a8969fc300b4802f33da2fbf218.1617746680.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 06, 2021 at 03:31:18PM -0700, Boris Burkov wrote:
> `xfs_io -c 'fiemap <off> <len>' <file>`
> can give surprising results on btrfs that differ from xfs.
> 
> btrfs spits out extents trimmed to fit the user input. If the user's
> fiemap request has an offset, then rather than returning each whole
> extent which intersects that range, we also trim the start extent to not
> have start < off.
> 
> Documentation in filesystems/fiemap.txt and the xfs_io man page suggests
> that returning the whole extent is expected.
> 
> Some cases which all yield the same fiemap in xfs, but not btrfs:
> dd if=/dev/zero of=$f bs=4k count=1
> sudo xfs_io -c 'fiemap 0 1024' $f
>   0: [0..7]: 26624..26631
> sudo xfs_io -c 'fiemap 2048 1024' $f
>   0: [4..7]: 26628..26631
> sudo xfs_io -c 'fiemap 2048 4096' $f
>   0: [4..7]: 26628..26631
> sudo xfs_io -c 'fiemap 3584 512' $f
>   0: [7..7]: 26631..26631
> sudo xfs_io -c 'fiemap 4091 5' $f
>   0: [7..6]: 26631..26630
> 
> I believe this is a consequence of the logic for merging contiguous
> extents represented by separate extent items. That logic needs to track
> the last offset as it loops through the extent items, which happens to
> pick up the start offset on the first iteration, and trim off the
> beginning of the full extent. To fix it, start `off` at 0 rather than
> `start` so that we keep the iteration/merging intact without cutting off
> the start of the extent.
> 
> after the fix, all the above commands give:
> 0: [0..7]: 26624..26631
> 
> The merging logic is exercised by xfstest generic/483, and I have
> written a new xfstest for checking we don't have backwards or
> zero-length fiemaps for cases like those above.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Added to misc-next, thanks.

> @@ -4975,7 +4975,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
>  		  u64 start, u64 len)
>  {
>  	int ret = 0;
> -	u64 off = start;
> +	u64 off = 0;

I've moved the initialization out of the declaration block and added a
comment, among all the others it looks as yet another zero init but this
must be zero for a specific reason.
