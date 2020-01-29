Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02E4414CCFF
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2020 16:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgA2PLY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 10:11:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:47158 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgA2PLY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 10:11:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3A7AAABE7;
        Wed, 29 Jan 2020 15:11:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E821ADA730; Wed, 29 Jan 2020 16:11:03 +0100 (CET)
Date:   Wed, 29 Jan 2020 16:11:02 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/3] fixup work fixes
Message-ID: <20200129151102.GF3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200121165144.2174309-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121165144.2174309-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 21, 2020 at 11:51:41AM -0500, Josef Bacik wrote:
> This series is to address a few issues with the fixup worker we hit in
> production.
> 
> The first of this is a resend of
> 
>   Btrfs: keep pages dirty when using
> 
> I've cleaned this up based on the feedback and added a bunch more comments to
> make it clear what is happening and why we're doing it.
> 
> The next patch is a cleanup that is made possible by the previous patch, again
> to clear up the fixup workers job.
> 
>   btrfs: drop the -EBUSY case in __extent_writepage_io
> 
> And finally the deadlock fix that I submitted earlier.  I noticed while trying
> to backport this onto our kernel that we had changed the error case with the
> above patch from Chris, and actually we really, really need Chris's fix as well.
> There is also a change in the error handling from v1 where we now set the page
> error properly but only once we've locked the page and verified we're still
> responsible for COW'ing the page.  Thanks,

Reviewed-by: David Sterba <dsterba@suse.com>

Very tricky stuff that fixup worker, it's like the worst present a
filesystem can get from memory management.

Estimated Merge target is 5.6, post rc1 so we have enough time for
testing. It'll appear either in misc-next or for-next.
