Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFDB636DE0A
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 19:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241519AbhD1RSb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Apr 2021 13:18:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:53544 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhD1RS3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Apr 2021 13:18:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 92F89ACF9;
        Wed, 28 Apr 2021 17:17:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CD2BCDA783; Wed, 28 Apr 2021 19:15:20 +0200 (CEST)
Date:   Wed, 28 Apr 2021 19:15:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: fix silent data loss after failure
 splitting ordered extent
Message-ID: <20210428171520.GO7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <0aba70d8929db6eeb640c795f512957db7a0b34a.1619011437.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0aba70d8929db6eeb640c795f512957db7a0b34a.1619011437.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 21, 2021 at 02:31:50PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> On a zoned filesystem, sometimes we need to split an ordered extent into 3
> different ordered extents. The original ordered extent is shortened, at
> the front and at the rear, and we create two other new ordered extents to
> represent the trimmed parts of the original ordered extent.
> 
> After adjusting the original ordered extent, we create an ordered extent
> to represent the pre-range, and that may fail with -ENOMEM for example.
> After that we always try to create the ordered extent for the post-range,
> and if that happens to succeed we end up returning success to the caller
> as we overwrite the 'ret' variable which contained the previous error.
> 
> This means we end up with a file range for which there is no ordered
> extent, which results in the range never getting a new file extent item
> pointing to the new data location. And since the split operation did
> not return an error, writeback does not fail and the inode's mapping is
> not flagged with an error, resulting in a subsequent fsync not reporting
> an error either.
> 
> It's possibly very unlikely to have the creation of the post-range ordered
> extent succeed after the creation of the pre-range ordered extent failed,
> but it's not impossible.
> 
> So fix this by making sure we only create the post-range ordered extent
> if there was no error creating the ordered extent for the pre-range.
> 
> Fixes: d22002fd37bd97 ("btrfs: zoned: split ordered extent when bio is sent")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
