Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD57C2901D0
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Oct 2020 11:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395254AbgJPJ0A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Oct 2020 05:26:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395031AbgJPJ0A (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Oct 2020 05:26:00 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DC65206DD;
        Fri, 16 Oct 2020 09:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602840359;
        bh=ZIFdCdaDAkaPMybI9x5q3GOJwy0ogix4SCHyqwGyE7I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mh5tCoR8FWDTlsL0SDstCjrH2yZGm0hN3VKGp2zKF/oK4SrHxiWuZbKB8ZCOHmdb2
         qHZ0fh0Bw8juJHUfUuSqNM0pyWe4yQZfFBX0Soxeujjr6wTZzxkNc31QsohsSqGY4+
         me9dbaUOhGsfTPG3RxU9pp/GnfEONi8K8gR5lvYo=
Received: by mail-qt1-f176.google.com with SMTP id z33so1193844qth.8;
        Fri, 16 Oct 2020 02:25:59 -0700 (PDT)
X-Gm-Message-State: AOAM533d9wSBNOl8mdYoWaZ09TtczJqoR21AXIz4WsFKLO7+c4BSbf8y
        g5MbJOr6mkL7vchU/0PPlQtMpZu5rMtMa2cAdZU=
X-Google-Smtp-Source: ABdhPJzac7iB5EEvVUiAI0+5S2np1DZmnSowCY/Cr0hgtoywO3pJ8CkEahASJwwR6qouJkEn9L/LuMF5RkpY3pctIgY=
X-Received: by 2002:ac8:5a53:: with SMTP id o19mr2346093qta.183.1602840358071;
 Fri, 16 Oct 2020 02:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <aa8318c5beb380a9e99142d1b5e776b739d04bdb.1602774113.git.fdmanana@suse.com>
 <20201015161355.GI7037@quack2.suse.cz> <20201016055757.GA7322@dread.disaster.area>
 <20201016084613.GJ7037@quack2.suse.cz>
In-Reply-To: <20201016084613.GJ7037@quack2.suse.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 16 Oct 2020 10:25:47 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4XNkQwQP2b2wToDfjaVccR3MvtivMD3f6eYpjLmjJSWA@mail.gmail.com>
Message-ID: <CAL3q7H4XNkQwQP2b2wToDfjaVccR3MvtivMD3f6eYpjLmjJSWA@mail.gmail.com>
Subject: Re: [PATCH] generic: test the correctness of several cases of
 RWF_NOWAIT writes
To:     Jan Kara <jack@suse.cz>
Cc:     Dave Chinner <david@fromorbit.com>,
        fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 16, 2020 at 9:46 AM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 16-10-20 16:57:57, Dave Chinner wrote:
> > On Thu, Oct 15, 2020 at 06:13:56PM +0200, Jan Kara wrote:
> > > On Thu 15-10-20 16:36:38, fdmanana@kernel.org wrote:
> > > > From: Filipe Manana <fdmanana@suse.com>
> > > >
> > > > Verify some attempts to write into a file using RWF_NOWAIT:
> > > >
> > > > 1) Writing into a fallocated extent that starts at eof should work;
> > >
> > > Why? We need to update i_size which requires transaction start and e.g.
> > > ext4 does not support that in non-blocking mode...
> >
> > Right, different filesystems behave differently given similar
> > pre-conditions. That's not a bug, that's exactly how RWF_NOWAIT is
> > expected to be implemented by each filesystem....
> >
> > > > 2) Writing into a hole should fail;
> > > > 3) Writing into a range that is partially allocated should fail.
> >
> > Same for these - these are situations where a -specific filesystem
> > implementation- might block, not a situation where the RWF_NOWAIT
> > API specification says that IO submission "should fail" and hence
> > return EAGAIN.
> >
> > > > This is motivated by several bugs that btrfs and ext4 had and were fixed
> > > > by the following kernel commits:
> > > >
> > > >   4b1946284dd6 ("btrfs: fix failure of RWF_NOWAIT write into prealloc extent beyond eof")
> > > >   260a63395f90 ("btrfs: fix RWF_NOWAIT write not failling when we need to cow")
> > > >   0b3171b6d195 ("ext4: do not block RWF_NOWAIT dio write on unallocated space")
> > > >
> > > > At the moment, on a 5.9-rc6 kernel at least, ext4 is failing for case 1),
> > > > but when I found and fixed case 1) in btrfs, around kernel 5.7, it was not
> > > > failing on ext4, so some regression happened in the meanwhile. For xfs and
> > > > btrfs on a 5.9 kernel, all the three cases pass.
> >
> > Sure, until we propagate IOMAP_NOWAIT far enough into the allocation
> > code that allocation will either succeed without blocking or fail
> > without changing anything.  At which point, the filesystem behaviour
> > is absolutely correct according to the RWF_NOWAIT specification, but
> > the test is most definitely wrong.
> >
> > IOWs, I think any test that says "RWF_NOWAIT IO in a <specific
> > situation> must do <specific thing>" is incorrect. RWF_NOWAIT simply
> > does not not define behaviour like this, and different filesystems
> > will do different things given the same file layouts...
>
> I agree with this. That being said it would be still worthwhile to have
> some tests verifying RWF_NOWAIT behavior is sane - that we don't block with
> RWF_NOWAIT (this is a requirement), and that what used to work with
> RWF_NOWAIT didn't unexpectedly regress (this is more a sanity check)... I'm
> not sure how to test that in an automated way through.

Yes, my intention was to serve more as a regression test than anything
else (as it's not a new feature anyway).
I only excluded here cases that are obviously btrfs specific like when
trying to write into a file range that has extents shared by
snapshots.

Thanks.

>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
