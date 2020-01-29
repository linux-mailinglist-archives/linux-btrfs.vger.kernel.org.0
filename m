Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 040BE14CD02
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2020 16:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgA2PM7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 10:12:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:47656 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbgA2PM7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 10:12:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 36081AAA6;
        Wed, 29 Jan 2020 15:12:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 99044DA730; Wed, 29 Jan 2020 16:12:39 +0100 (CET)
Date:   Wed, 29 Jan 2020 16:12:39 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH][v3] btrfs: do not do delalloc reservation under page lock
Message-ID: <20200129151239.GG3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200121165144.2174309-4-josef@toxicpanda.com>
 <20200121193452.2175678-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121193452.2175678-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 21, 2020 at 02:34:52PM -0500, Josef Bacik wrote:
> Thankfully the stars have to align just right to hit this.  First you
> have to end up in the fixup worker, which is tricky by itself (my
> reproducer does DIO reads into a MMAP'ed region, so not a common
> operation).  Then you have to have less than a page size of free data
> space and 0 unallocated space so you go down the "commit the transaction
> to free up pinned space" path.  This was accomplished by a random
> balance that was running on the host.  Then you get this deadlock.
> 
> I'm still in the process of trying to force the deadlock to happen on
> demand, but I've hit other issues.  I can still trigger the fixup worker
> path itself so this patch has been tested in that regard, so the normal
> case is fine.
> 
> Fixes: 87826df0ec36 ("btrfs: delalloc for page dirtied out-of-band in fixup worker")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v2->v3:
> - Use a delayed iput in the fixup worker.  I *think* we can deadlock if we do
>   the final iput and need to flush space, which may trigger the fixup worker
>   which is busy doing our iput.  Err on the side of caution and use a delayed
>   iput.

Sounds serious so I've turned this into a comment.
