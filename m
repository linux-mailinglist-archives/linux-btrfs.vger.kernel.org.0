Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8B24653AF
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 18:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351769AbhLAROT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 12:14:19 -0500
Received: from dibed.net-space.pl ([84.10.22.86]:54475 "EHLO
        dibed.net-space.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351285AbhLAROA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 12:14:00 -0500
Received: from router-fw.i.net-space.pl ([192.168.52.1]:55346 "EHLO
        tomti.i.net-space.pl") by router-fw-old.i.net-space.pl with ESMTP
        id S2119634AbhLARKT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Dec 2021 18:10:19 +0100
X-Comment: RFC 2476 MSA function at dibed.net-space.pl logged sender identity as: dkiper
Date:   Wed, 1 Dec 2021 18:10:17 +0100
From:   Daniel Kiper <dkiper@net-space.pl>
To:     Qu Wenruo <wqu@suse.com>
Cc:     grub-devel@gnu.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] fs/btrfs: Make extent item iteration to handle gaps
Message-ID: <20211201171017.2xilrf6suksk66wg@tomti.i.net-space.pl>
References: <20211028094457.161711-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028094457.161711-1-wqu@suse.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 28, 2021 at 05:44:57PM +0800, Qu Wenruo via Grub-devel wrote:
> [BUG]
> Grub btrfs implementation can't handle two very basic btrfs file
> layouts:
>
> 1. Mixed inline/regualr extents
>    # mkfs.btrfs -f test.img
>    # mount test.img /mnt/btrfs
>    # xfs_io -f -c "pwrite 0 1k" -c "sync" -c "falloc 0 4k" \
> 	       -c "pwrite 4k 4k" /mnt/btrfs/file
>    # umount /mnt/btrfs
>    # ./grub-fstest ./grub-fstest --debug=btrfs ~/test.img hex "/file"
>
>    Such mixed inline/regular extents case is not recommended layout,
>    but all existing tools and kernel can handle it without problem
>
> 2. NO_HOLES feature
>    # mkfs.btrfs -f test.img -O no_holes
>    # mount test.img /mnt/btrfs
>    # xfs_io -f -c "pwrite 0 4k" -c "pwrite 8k 4k" /mnt/btrfs/file
>    # umount /mnt/btrfs
>    # ./grub-fstest ./grub-fstest --debug=btrfs ~/test.img hex "/file"
>
>    NO_HOLES feature is going to be the default mkfs feature in the incoming
>    v5.15 release, and kernel has support for it since v4.0.
>
> [CAUSE]
> The way GRUB btrfs code iterates through file extents relies on no gap
> between extents.
>
> If any gap is hit, then grub btrfs will error out, without any proper
> reason to help debug the bug.
>
> This is a bad assumption, since a long long time ago btrfs has a new
> feature called NO_HOLES to allow btrfs to skip the padding hole extent
> to reduce metadata usage.
>
> The NO_HOLES feature is already stable since kernel v4.0 and is going to
> be the default mkfs feature in the incoming v5.15 btrfs-progs release.
>
> [FIX]
> When there is a extent gap, instead of error out, just try next item.
>
> This is still not ideal, as kernel/progs/U-boot all do the iteration
> item by item, not relying on the file offset continuity.
>
> But it will be way more time consuming to correct the whole behavior
> than starting from scratch to build a proper designed btrfs module for GRUB.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>

Daniel
