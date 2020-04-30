Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8831C0A7E
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 May 2020 00:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgD3Wnd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 18:43:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgD3Wnd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 18:43:33 -0400
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6243207DD;
        Thu, 30 Apr 2020 22:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588286612;
        bh=4opDyevPEQA05BIebhqthwKvc88Qikpbmp5ElQzkcvA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eixKTQabEP6pogD65jtw5/ajbPgaParFaH6H9RUuJW4MSrqfI1f03tMssC6lQDtSj
         ZknH5IO8MTGkV+M1BoMH2lU40rPTlli+9oBLoWTDtKn6dL32+M+agtd8KoCTi28Zlm
         amLq2YYIiqqr7FzewHA7V+5j9oHWhUKSdp0YrvjY=
Received: by mail-vs1-f52.google.com with SMTP id m24so5292692vsq.10;
        Thu, 30 Apr 2020 15:43:32 -0700 (PDT)
X-Gm-Message-State: AGi0PuarVnSNi9YBHZC11YLBDwxWjcyamY4mDQ2jeGfqbht4GTAQbgLz
        VV0dHij8vB8gzGN6BvTUZ4S1s7tGk3mDzt2poPA=
X-Google-Smtp-Source: APiQypKBvZqPY2A+rSMgvxUX9ofrT5ebA1P6k8+agvgFeAtoWekv+bjI69FEf/NDx52Odx1ftd7hMnl0LV9xyAf4eSo=
X-Received: by 2002:a67:407:: with SMTP id 7mr1023429vse.95.1588286611719;
 Thu, 30 Apr 2020 15:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200430164356.15543-1-fdmanana@kernel.org> <20200430144018.c855f031b321d68e5c89b30c@linux-foundation.org>
 <20200430222347.GA164259@google.com>
In-Reply-To: <20200430222347.GA164259@google.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 30 Apr 2020 23:43:20 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4MU+_Niwg63RzHu6+orXZsQt26eEXLOODfmpgTwUuacw@mail.gmail.com>
Message-ID: <CAL3q7H4MU+_Niwg63RzHu6+orXZsQt26eEXLOODfmpgTwUuacw@mail.gmail.com>
Subject: Re: [PATCH] percpu: make pcpu_alloc() aware of current gfp context
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        cl@linux.com, linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 30, 2020 at 11:23 PM Dennis Zhou <dennis@kernel.org> wrote:
>
> On Thu, Apr 30, 2020 at 02:40:18PM -0700, Andrew Morton wrote:
> > On Thu, 30 Apr 2020 17:43:56 +0100 fdmanana@kernel.org wrote:
> >
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Since 5.7-rc1, on btrfs we have a percpu counter initialization for which
> > > we always pass a GFP_KERNEL gfp_t argument (this happens since commit
> > > 2992df73268f78 ("btrfs: Implement DREW lock")).  That is safe in some
> > > contextes but not on others where allowing fs reclaim could lead to a
> > > deadlock because we are either holding some btrfs lock needed for a
> > > transaction commit or holding a btrfs transaction handle open.  Because
> > > of that we surround the call to the function that initializes the percpu
> > > counter with a NOFS context using memalloc_nofs_save() (this is done at
> > > btrfs_init_fs_root()).
> > >
> > > However it turns out that this is not enough to prevent a possible
> > > deadlock because percpu_alloc() determines if it is in an atomic context
> > > by looking exclusively at the gfp flags passed to it (GFP_KERNEL in this
> > > case) and it is not aware that a NOFS context is set.  Because it thinks
> > > it is in a non atomic context it locks the pcpu_alloc_mutex, which can
> > > result in a btrfs deadlock when pcpu_balance_workfn() is running, has
> > > acquired that mutex and is waiting for reclaim, while the btrfs task that
> > > called percpu_counter_init() (and therefore percpu_alloc()) is holding
> > > either the btrfs commit_root semaphore or a transaction handle (done at
> > > fs/btrfs/backref.c:iterate_extent_inodes()), which prevents reclaim from
> > > finishing as an attempt to commit the current btrfs transaction will
> > > deadlock.
> > >
> >
> > Patch looks good and seems sensible, thanks.
> >
>
> Acked-by: Dennis Zhou <dennis@kernel.org>
>
> > But why did btrfs use memalloc_nofs_save()/restore() rather than
> > s/GFP_KERNEL/GFP_NOFS/?
>
> I would also like to know.

For 2 reasons:

1) It's the preferred way to do it since
memalloc_nofs_save()/restore() was added (according to
Documentation/core-api/gfp_mask-from-fs-io.rst);

2) According to Documentation/core-api/gfp_mask-from-fs-io.rst,
passing GFP_NOFS to __vmalloc() doesn't work, so one has to use the
memalloc_nofs_save()/restore() API for that. And pcpu_alloc() calls
helpers that end up calling __vmalloc() (through pcpu_mem_zalloc()).

And that's it.

Thanks.

>
> Thanks,
> Dennis
