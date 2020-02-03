Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD2B150F06
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 18:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgBCR7r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 12:59:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:49306 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728109AbgBCR7r (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Feb 2020 12:59:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0941EABE7;
        Mon,  3 Feb 2020 17:59:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3F179DA7A1; Mon,  3 Feb 2020 18:59:34 +0100 (CET)
Date:   Mon, 3 Feb 2020 18:59:34 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/6][v3] btrfs: fix hole corruption issue with !NO_HOLES
Message-ID: <20200203175933.GB2654@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200117140224.42495-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117140224.42495-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 17, 2020 at 09:02:18AM -0500, Josef Bacik wrote:
> v2->v3:
> - Rebased onto misc-next.
> - Added a patch to stop using ->leave_spinning in truncate_inode_items.
> 
> v1->v2:
> - fixed a bug in 'btrfs: use the file extent tree infrastructure' that would
>   result in 0 length files because btrfs_truncate_inode_items() was clearing the
>   file extent map when we fsync'ed multiple times.  Validated this with a
>   modified fsx and generic/521 that reproduced the problem, those modifications
>   were sent up as well.
> - dropped the RFC
> 
> ----------------- Original Message -----------------------
> We've historically had this problem where you could flush a targeted section of
> an inode and end up with a hole between extents without a hole extent item.
> This of course makes fsck complain because this is not ok for a file system that
> doesn't have NO_HOLES set.  Because this is a well understood problem I and
> others have been ignoring fsck failures during certain xfstests (generic/475 for
> example) because they would regularly trigger this edge case.
> 
> However this isn't a great behavior to have, we should really be taking all fsck
> failures seriously, and we could potentially ignore fsck legitimate fsck errors
> because we expect it to be this particular failure.
> 
> In order to fix this we need to keep track of where we have valid extent items,
> and only update i_size to encompass that area.  This unfortunately means we need
> a new per-inode extent_io_tree to keep track of the valid ranges.  This is
> relatively straightforward in practice, and helpers have been added to manage
> this so that in the case of a NO_HOLES file system we just simply skip this work
> altogether.
> 
> I've been hammering on this for a week now and I'm pretty sure its ok, but I'd
> really like Filipe to take a look and I still have some longer running tests
> going on the series.  All of our boxes internally are btrfs and the box I was
> testing on ended up with a weird RPM db corruption that was likely from an
> earlier, broken version of the patch.  However I cannot be 100% sure that was
> the case, so I'm giving it a few more days of testing before I'm satisfied
> there's not some weird thing that RPM does that xfstests doesn't cover.
> 
> This has gone through several iterations of xfstests already, including many
> loops of generic/475 for validation to make sure it was no longer failing.  So
> far so good, but for something like this wider testing will definitely be
> necessary.  Thanks,

I've reviewed the series and will add it to for-next. The i_size
tracking seems to be an important part that we want to merge before
NO_HOLES is default in mkfs. It would be good to steer more focus on
that during testing. If everything goes fine, the mkfs default can
happen in 5.7. Thanks.
