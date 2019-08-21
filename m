Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD7AB97E64
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 17:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfHUPSI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 11:18:08 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42111 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfHUPSI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 11:18:08 -0400
Received: by mail-qt1-f195.google.com with SMTP id t12so3445308qtp.9
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2019 08:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pgYn1rGI4YoGltcJSIe6H01/dw3UoWQZVznm+SGFreA=;
        b=C7VIUP83UNgriWCvh2b9JEyrNBeakfGUYu18RrkWqI6I4DQoV5Oz5z6+Y/RT5de3SA
         30M5XRsuEzJxRPalcj5d/1nzg0c5W8gi5fCpVKmYjQnQsxk1BkNdIqTXWsYiuoETjnNa
         /mwGWqL21P165nfkNGThUPoHXlnwsqzFsTSVMLHseYX6jSxWX4u54066aZEtqw/ufbiv
         504U0y4RHOKP2gCQiHCQ+NGxUEVIaLkZ7p1QPH05wqyaa2cvmi/bV+pKcBwGMBiW46sI
         IV6OIg3v8wZsKWfDDMMaCUrIWQAuqxwrKqXW4oxDgduccykPtOnWYncn8dSSj6Mndbfr
         N/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pgYn1rGI4YoGltcJSIe6H01/dw3UoWQZVznm+SGFreA=;
        b=IOU7whfKiElg4RwOfcbcwE666dAVKdkyPp0IzXcAeQFMZwT9I6siF3kg+7tdscnJiQ
         I92+qO47kI/Q471S8fDXtP2Cd+C6Nhq7B+fQOMIbZwm/54UaTLdyH68bkQzv9mI6qQjN
         Vma4WA1YkDN0UuAnX7aoJ45kKT+LV2n5HMiA+ekJNYzxI00XlBcat3GugOaPqgTLB5G3
         ZJNh6xPeG4HnqGkM4NIg73dD08rupiL8ImGLTjMRUVDhk7usSvxAPJJnA9MZsWBFtnCT
         cBYjaGJsX/PEc6Wg2372ologSvIJgo/lx4zGVIhpI+xJ6WM7rkGXjEP9KglDwsXeJBC0
         lNeg==
X-Gm-Message-State: APjAAAVkG8UvvwlPNXkGX9+3LKPl5TnJnS7LlxVcSvLcWogGYY8oO4Wt
        ceCsFb0S+V7ttXUY0OJLflWwow==
X-Google-Smtp-Source: APXvYqyumQ4gR0pQTJ8XXxs6BVHPYzUiX5mdrGy0QJaJ9iNR98dV9fgYkefqjpuI55H5ZOoDQyvg/Q==
X-Received: by 2002:aed:3745:: with SMTP id i63mr24233664qtb.20.1566400687401;
        Wed, 21 Aug 2019 08:18:07 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id v24sm13039006qth.33.2019.08.21.08.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 08:18:06 -0700 (PDT)
Date:   Wed, 21 Aug 2019 11:18:04 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 0/2] Btrfs: workqueue cleanups
Message-ID: <20190821151803.cuyq2yzpdnwgwrmb@MacBook-Pro-91.local>
References: <cover.1565717247.git.osandov@fb.com>
 <20190821132021.GA18575@twin.jikos.cz>
 <20190821132446.GB18575@twin.jikos.cz>
 <20190821141453.GI18575@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821141453.GI18575@twin.jikos.cz>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 21, 2019 at 04:14:53PM +0200, David Sterba wrote:
> On Wed, Aug 21, 2019 at 03:24:46PM +0200, David Sterba wrote:
> > On Wed, Aug 21, 2019 at 03:20:21PM +0200, David Sterba wrote:
> > > On Tue, Aug 13, 2019 at 10:33:42AM -0700, Omar Sandoval wrote:
> > > > From: Omar Sandoval <osandov@fb.com>
> > > > 
> > > > This does some cleanups to the Btrfs workqueue code following my
> > > > previous fix [1]. Changed since v1 [2]:
> > > > 
> > > > - Removed errant Fixes: tag in patch 1
> > > > - Fixed a comment typo in patch 2
> > > > - Added NB: to comments in patch 2
> > > > - Added Nikolay and Filipe's reviewed-by tags
> > > > 
> > > > Thanks!
> > > > 
> > > > 1: https://lore.kernel.org/linux-btrfs/0bea516a54b26e4e1c42e6fe47548cb48cc4172b.1565112813.git.osandov@fb.com/
> > > > 2: https://lore.kernel.org/linux-btrfs/cover.1565680721.git.osandov@fb.com/
> > > > 
> > > > Omar Sandoval (2):
> > > >   Btrfs: get rid of unique workqueue helper functions
> > > >   Btrfs: get rid of pointless wtag variable in async-thread.c
> > > 
> > > The patches seem to cause crashes inside the worques, happend several
> > > times in random patches, sample stacktrace below. This blocks me from
> > > testing so I'll move the patches out of misc-next for now and add back
> > > once there's a fix.
> > 
> > Another possibility is that the cleanup patches make it more likely to
> > happen and the root cause is "Btrfs: fix workqueue deadlock on dependent
> > filesystems".
> 
> With just the deadlock fix on top<F2>, crashed in btrfs/011;
> 

It's because we're doing

wq = work->wq;

after we've done set_bit(WORK_DONE_BIT, &work->flags).  The work could be freed
immediately after this and thus doing work->wq could give you garbage.  Could
you try with this diff applied and verify it goes away?

diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
index 6b8ad4a1b568..10a04b99798a 100644
--- a/fs/btrfs/async-thread.c
+++ b/fs/btrfs/async-thread.c
@@ -252,9 +252,9 @@ static inline void thresh_exec_hook(struct __btrfs_workqueue *wq)
 	}
 }
 
-static void run_ordered_work(struct btrfs_work *self)
+static void run_ordered_work(struct __btrfs_workqueue *wq,
+			     struct btrfs_work *self)
 {
-	struct __btrfs_workqueue *wq = self->wq;
 	struct list_head *list = &wq->ordered_list;
 	struct btrfs_work *work;
 	spinlock_t *lock = &wq->list_lock;
@@ -356,7 +356,7 @@ static void normal_work_helper(struct btrfs_work *work)
 	work->func(work);
 	if (need_order) {
 		set_bit(WORK_DONE_BIT, &work->flags);
-		run_ordered_work(work);
+		run_ordered_work(wq, work);
 	}
 	if (!need_order)
 		trace_btrfs_all_work_done(wq->fs_info, wtag);
