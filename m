Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1511C0B29
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 May 2020 02:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgEAADT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 20:03:19 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:32952 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgEAADT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 20:03:19 -0400
Received: by mail-ua1-f65.google.com with SMTP id g35so3254216uad.0;
        Thu, 30 Apr 2020 17:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=89Z7r8iD/0NKOVoXCJcX8FvWsMx9t7cw7PfWtZ+Xwlg=;
        b=elsTxTUcbmnckuI9DwHhcFGcxxESdvwHqtL3EjbXImzmWNN1EmIsxuVOw1HetUrY/l
         4J7m6mgCvRrBtdu+K304ZTvUInuBviffHlzFDBgqUAnQUXUZCf+PqqFNZQ9wMblOZSgl
         1YJRfHYyVmUyBRK0qvgKFdKQx51cvRZzIImYGToBuykYd+vKsR89xh8xNxqfq6+rBLjB
         3iFQWCs/7+/tQRYU8sV4hCyv9Gzu3uw/fygJ9eoQ2IKxX8GPfqDmAoULD5SosUr9vDiS
         lBgZcj8YXZ+c2dFJPX1bF66rSuXF+fbkG12PVe1JbjvB8dG0Zuvj0/60Afmk8xTHTSdp
         5PGg==
X-Gm-Message-State: AGi0Puagl/xUhijBN98xnmQe4Vbw2c4VfU8OA+e0L4EGaymYtmE2+baG
        S9aoSsu7p8nxBP2l59IXuMo=
X-Google-Smtp-Source: APiQypJh1P49t8x/agbwYJf0OrNUf+alwRMWkCbXlYwf0+PXDf/yyr5brZNxy/qfVUaufSFxg2MRwg==
X-Received: by 2002:ab0:7025:: with SMTP id u5mr1045186ual.130.1588291398085;
        Thu, 30 Apr 2020 17:03:18 -0700 (PDT)
Received: from google.com (69.104.231.35.bc.googleusercontent.com. [35.231.104.69])
        by smtp.gmail.com with ESMTPSA id k184sm379805vke.42.2020.04.30.17.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 17:03:13 -0700 (PDT)
Date:   Fri, 1 May 2020 00:03:12 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        cl@linux.com, linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] percpu: make pcpu_alloc() aware of current gfp context
Message-ID: <20200501000312.GA188766@google.com>
References: <20200430164356.15543-1-fdmanana@kernel.org>
 <20200430144018.c855f031b321d68e5c89b30c@linux-foundation.org>
 <20200430222347.GA164259@google.com>
 <CAL3q7H4MU+_Niwg63RzHu6+orXZsQt26eEXLOODfmpgTwUuacw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4MU+_Niwg63RzHu6+orXZsQt26eEXLOODfmpgTwUuacw@mail.gmail.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 30, 2020 at 11:43:20PM +0100, Filipe Manana wrote:
> On Thu, Apr 30, 2020 at 11:23 PM Dennis Zhou <dennis@kernel.org> wrote:
> >
> > On Thu, Apr 30, 2020 at 02:40:18PM -0700, Andrew Morton wrote:
> > > On Thu, 30 Apr 2020 17:43:56 +0100 fdmanana@kernel.org wrote:
> > >
> > > > From: Filipe Manana <fdmanana@suse.com>
> > > >
> > > > Since 5.7-rc1, on btrfs we have a percpu counter initialization for which
> > > > we always pass a GFP_KERNEL gfp_t argument (this happens since commit
> > > > 2992df73268f78 ("btrfs: Implement DREW lock")).  That is safe in some
> > > > contextes but not on others where allowing fs reclaim could lead to a
> > > > deadlock because we are either holding some btrfs lock needed for a
> > > > transaction commit or holding a btrfs transaction handle open.  Because
> > > > of that we surround the call to the function that initializes the percpu
> > > > counter with a NOFS context using memalloc_nofs_save() (this is done at
> > > > btrfs_init_fs_root()).
> > > >
> > > > However it turns out that this is not enough to prevent a possible
> > > > deadlock because percpu_alloc() determines if it is in an atomic context
> > > > by looking exclusively at the gfp flags passed to it (GFP_KERNEL in this
> > > > case) and it is not aware that a NOFS context is set.  Because it thinks
> > > > it is in a non atomic context it locks the pcpu_alloc_mutex, which can
> > > > result in a btrfs deadlock when pcpu_balance_workfn() is running, has
> > > > acquired that mutex and is waiting for reclaim, while the btrfs task that
> > > > called percpu_counter_init() (and therefore percpu_alloc()) is holding
> > > > either the btrfs commit_root semaphore or a transaction handle (done at
> > > > fs/btrfs/backref.c:iterate_extent_inodes()), which prevents reclaim from
> > > > finishing as an attempt to commit the current btrfs transaction will
> > > > deadlock.
> > > >
> > >
> > > Patch looks good and seems sensible, thanks.
> > >
> >
> > Acked-by: Dennis Zhou <dennis@kernel.org>
> >
> > > But why did btrfs use memalloc_nofs_save()/restore() rather than
> > > s/GFP_KERNEL/GFP_NOFS/?
> >
> > I would also like to know.
> 
> For 2 reasons:
> 
> 1) It's the preferred way to do it since
> memalloc_nofs_save()/restore() was added (according to
> Documentation/core-api/gfp_mask-from-fs-io.rst);
> 

Thanks. I didn't realize it completely superceded GFP_NOFS.

> 2) According to Documentation/core-api/gfp_mask-from-fs-io.rst,
> passing GFP_NOFS to __vmalloc() doesn't work, so one has to use the
> memalloc_nofs_save()/restore() API for that. And pcpu_alloc() calls
> helpers that end up calling __vmalloc() (through pcpu_mem_zalloc()).
> 
> And that's it.
> 

I'm starting to remember a bit more. I guess it's not great how
percpu manages GFP_ATOMIC as !GFP_KERNEL for the possible vmalloc()
calls. At the time I believe the whitelist was the only way to deal with
the recursive case. If I get a chance I'll look at the flags again and
see if we can't do something better/ more aligned today.

> 
> >
> > Thanks,
> > Dennis
