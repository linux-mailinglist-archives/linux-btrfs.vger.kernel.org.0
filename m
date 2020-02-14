Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C136F15F89E
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 22:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389481AbgBNVRc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 16:17:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:37934 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388965AbgBNVRc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 16:17:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A0CEBB234;
        Fri, 14 Feb 2020 21:17:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 61911DA7A0; Fri, 14 Feb 2020 22:17:14 +0100 (CET)
Date:   Fri, 14 Feb 2020 22:17:14 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: add a find_contiguous_extent_bit helper and use
 it for safe isize
Message-ID: <20200214211713.GG2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200212183831.78293-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212183831.78293-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 12, 2020 at 01:38:31PM -0500, Josef Bacik wrote:
> Filipe noticed a race where we would sometimes get the wrong answer for
> the i_disk_size for !NO_HOLES with my patch.  That is because I expected
> that find_first_extent_bit() would find the contiguous range, since I'm
> only ever setting EXTENT_DIRTY.  However the way set_extent_bit() works
> is it'll temporarily split the range, loop around and set our bits, and
> then merge the state.  When it loops it drops the tree->lock, so there
> is a window where we can have two adjacent states instead of one large
> state.  Fix this by walking forward until we find a non-contiguous
> state, and set our end_ret to the end of our logically contiguous area.
> This fixes the problem without relying on specific behavior from
> set_extent_bit().
> 
> Fixes: 79ceff7f6e5d ("btrfs: introduce per-inode file extent tree")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> Dave, I assume you'll want to fold this in to the referenced patch, if not let
> me know and I'll rework the series to include this as a different patch.

Folding looks like a good option, the patch adds other helper for
btrfs_inode_clear_file_extent_range so this patch fits in nicely.

> +/**
> + * find_contiguous_extent_bit: find a contiguous area of bits
> + * @tree - io tree to check
> + * @start - offset to start the search from
> + * @start_ret - the first offset we found with the bits set
> + * @end_ret - the final contiguous range of the bits that were set
> + *
> + * set_extent_bit anc clear_extent_bit can temporarily split contiguous ranges
> + * to set bits appropriately, and then merge them again.  During this time it
> + * will drop the tree->lock, so use this helper if you want to find the actual
> + * contiguous area for given bits.  We will search to the first bit we find, and
> + * then walk down the tree until we find a non-contiguous area.  The area
> + * returned will be the full contiguous area with the bits set.
> + */

This summarizes why it's needed so the changelog does not need to be
updated AFAICS. Patch updated and misc-next pushed. Thanks.
