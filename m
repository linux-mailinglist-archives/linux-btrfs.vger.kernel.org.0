Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA8D311717C
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 17:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfLIQX6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 11:23:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:53134 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726230AbfLIQX6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Dec 2019 11:23:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 49F9DABF6;
        Mon,  9 Dec 2019 16:23:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6347FDA783; Mon,  9 Dec 2019 17:23:48 +0100 (CET)
Date:   Mon, 9 Dec 2019 17:23:48 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix hole extent items with a zero size after
 range cloning
Message-ID: <20191209162348.GL2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20191205165841.18524-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205165841.18524-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 05, 2019 at 04:58:41PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Normally when cloning a file range if we find an implicit hole at the end
> of the range we assume it is because the NO_HOLES feature is enabled.
> However that is not always the case. One well known case [1] is when we
> have a power failure after mixing buffered and direct IO writes against
> the same file.
> 
> In such cases we need to punch a hole in the destination file, and if
> the NO_HOLES feature is not enabled, we need to insert explicit file
> extent items to represent the hole. After commit 690a5dbfc51315
> ("Btrfs: fix ENOSPC errors, leading to transaction aborts, when cloning
> extents"), we started to insert file extent items representing the hole
> with an item size of 0, which is invalid and should be 53 bytes (the size
> of a btrfs_file_extent_item structure), resulting in all sorts of
> corruptions and invalid memory accesses. This is detected by the tree
> checker when we attempt to write a leaf to disk.
> 
> The problem can be sporadically triggered by test case generic/561 from
> fstests. That test case does not exercise power failure and creates a new
> filesystem when it starts, so it does not use a filesystem created by any
> previous test that tests power failure. However the test does both
> buffered and direct IO writes (through fsstress) and it's precisely that
> which is creating the implicit holes in files. That happens even before
> the commit mentioned earlier. I need to investigate why we get those
> implicit holes to check if there is a real problem or not. For now this
> change fixes the regression of introducing file extent items with an item
> size of 0 bytes.
> 
> Fix the issue by calling btrfs_punch_hole_range() without passing a
> btrfs_clone_extent_info structure, which ensures file extent items are
> inserted to represent the hole with a correct item size. We were passing
> a btrfs_clone_extent_info with a value of 0 for its 'item_size' field,
> which was causing the insertion of file extent items with an item size
> of 0.
> 
> [1] https://www.spinics.net/lists/linux-btrfs/msg75350.html
> 
> Fixes: 690a5dbfc51315 ("Btrfs: fix ENOSPC errors, leading to transaction aborts, when cloning extents")
> Reported-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
