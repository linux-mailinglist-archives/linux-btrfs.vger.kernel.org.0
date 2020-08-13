Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C0E2438EB
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Aug 2020 12:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgHMKtc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 06:49:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:48524 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbgHMKtS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 06:49:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F352FB67A;
        Thu, 13 Aug 2020 10:49:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9B846DA7D6; Thu, 13 Aug 2020 12:48:15 +0200 (CEST)
Date:   Thu, 13 Aug 2020 12:48:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove the dead copied check in
 btrfs_copy_from_user()
Message-ID: <20200813104815.GE2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200813061533.85671-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813061533.85671-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 13, 2020 at 02:15:33PM +0800, Qu Wenruo wrote:
> There is btrfs specific check in btrfs_copy_from_user(), after
> iov_iter_copy_from_user_atomic() call, we check if the page is uptodate
> and if the copied bytes is smaller than what we expect.
> 
> However that check will never be triggered due to the following reasons:
> - PageUptodate() check conflicts with current behavior
>   Currently we ensure all pages that will go through a partial write
>   (some bytes are not covered by the write range) will be forced
>   uptodate.
> 
>   This is the common behavior to ensure we get the correct content.
>   This behavior is always true, no matter if my previous patch "btrfs:
>   refactor how we prepare pages for btrfs_buffered_write()" is applied.

Would it make sense to add an assert here? Checking for the page
up-to-date status.

> - iov_iter_copy_from_user_atomic() only returns 0 or @bytes
>   It won't return a short write.

And maybe for that one too, I'm not able to navigate through the maze of
the iov_iter_* macros.

> So we're completely fine to remove the (PageUptodate() && copied <
> count) check, as we either get copied == 0, and break the loop anyway,
> or do a proper copy.
> 
> This will revert commit 31339acd07b4 ("Btrfs: deal with short returns from
> copy_from_user").

As this is a very old patch, the changes outside of btrfs are likely to
make the piece of code redundant.
