Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B509194A79
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2019 18:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfHSQgj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Aug 2019 12:36:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:57252 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726987AbfHSQgj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Aug 2019 12:36:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7E601AE96;
        Mon, 19 Aug 2019 16:36:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1FB60DA7DA; Mon, 19 Aug 2019 18:37:05 +0200 (CEST)
Date:   Mon, 19 Aug 2019 18:37:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] Btrfs: fix workqueue deadlock on dependent filesystems
Message-ID: <20190819163704.GG24086@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
References: <0bea516a54b26e4e1c42e6fe47548cb48cc4172b.1565112813.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bea516a54b26e4e1c42e6fe47548cb48cc4172b.1565112813.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 06, 2019 at 10:34:52AM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> We hit a the following very strange deadlock on a system with Btrfs on a
> loop device backed by another Btrfs filesystem:
> 
> 1. The top (loop device) filesystem queues an async_cow work item from
>    cow_file_range_async(). We'll call this work X.
> 2. Worker thread A starts work X (normal_work_helper()).
> 3. Worker thread A executes the ordered work for the top filesystem
>    (run_ordered_work()).
> 4. Worker thread A finishes the ordered work for work X and frees X
>    (work->ordered_free()).
> 5. Worker thread A executes another ordered work and gets blocked on I/O
>    to the bottom filesystem (still in run_ordered_work()).
> 6. Meanwhile, the bottom filesystem allocates and queues an async_cow
>    work item which happens to be the recently-freed X.
> 7. The workqueue code sees that X is already being executed by worker
>    thread A, so it schedules X to be executed _after_ worker thread A
>    finishes (see the find_worker_executing_work() call in
>    process_one_work()).
> 
> Now, the top filesystem is waiting for I/O on the bottom filesystem, but
> the bottom filesystem is waiting for the top filesystem to finish, so we
> deadlock.
> 
> This happens because we are breaking the workqueue assumption that a
> work item cannot be recycled while it still depends on other work. Fix
> it by waiting to free the work item until we are done with all of the
> related ordered work.
> 
> P.S.:
> 
> One might ask why the workqueue code doesn't try to detect a recycled
> work item. It actually does try by checking whether the work item has
> the same work function (find_worker_executing_work()), but in our case
> the function is the same. This is the only key that the workqueue code
> has available to compare, short of adding an additional, layer-violating
> "custom key". Considering that we're the only ones that have ever hit
> this, we should just play by the rules.
> 
> Unfortunately, we haven't been able to create a minimal reproducer other
> than our full container setup using a compress-force=zstd filesystem on
> top of another compress-force=zstd filesystem.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Added to misc-next, thanks.
