Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16F6570852
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2019 20:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731511AbfGVSUd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jul 2019 14:20:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45468 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731505AbfGVSUc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jul 2019 14:20:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id r1so17758627pfq.12
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2019 11:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xyyJ/aAHfthH+InZB+MnZ/stXyT2IZJmPuzfCQRjzLo=;
        b=G9drgAQfoLI+DzVeoHqGkJdUFC6nUNqZI73C64hypjsSZGg5Q8Qz/jFryvWqFn7h+L
         KEVe32bz0CcG3lv0GubyR62VG/wk2bkkyh19X0iIb1t74Jjy7xc9MKhNRQTQGzJkbhc7
         nCt0AvJZUSUX2UXUj3wFwIHq+dQ01erC0TCt51fTMvYsblXE2Lf6IZWr902h0aweElg/
         gSphN+9ELZJWUKTsHv+vhWoiax34KkmZnBRjr7mAL83MYmkLVXyZKRqcqJHJVUvd+JZ3
         49edv7IhUNUBBCT94x4/aU4HQTkeAlSDc8XhxTrBffC0FkXM0E7GOpcEpr5LC2mMBhFy
         lmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xyyJ/aAHfthH+InZB+MnZ/stXyT2IZJmPuzfCQRjzLo=;
        b=q2l8nsLlHNzUxTY6jvFssK9rvzS39qz5JHkORaKAq97LNl6/Bbecu3g7Wpd3I3ftBW
         znWUXv5J641FsNDKQYw/ohoDw7nUZOUcejkW/z0oiK62vRhxYI+OxpTDKYSQ4C4PG/3p
         MEXfsTFP76lp8Q+9Lb6D7WcXnL9JQCmr26kNJx3zc40koEEBhuYRkI0pXqnmTGfoBMY3
         lXt1tgGUY/hcavrU30TsBjrQXbfIkZybsl404F7wWZiXFJG5ccm05QTb7v2jQrOt2Kaf
         v1ZD0LgGbgl2ebxy7QMb466n1cXwJosB15AJ+EYlXSiHI/kgaMhw+c7b9nyE/Rdso9yr
         iuZQ==
X-Gm-Message-State: APjAAAVmmQXSQ04UROuRf5NeUi2GVddYsIcLdrdbN469ZoOW2wRSvrv2
        D28H00YvnyABX9yN79c1XP6YSA==
X-Google-Smtp-Source: APXvYqwfjI2/+2AD9Xbo72rj+jcvhj+1N8IF7QmAjQ94N+BEGkZpwouGIFh8R+jmJZMMFke1JnLezA==
X-Received: by 2002:a17:90a:ab01:: with SMTP id m1mr75220336pjq.69.1563819631939;
        Mon, 22 Jul 2019 11:20:31 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::2:a31b])
        by smtp.gmail.com with ESMTPSA id l4sm40366336pff.50.2019.07.22.11.20.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 11:20:31 -0700 (PDT)
Date:   Mon, 22 Jul 2019 11:20:25 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH 2/2] btrfs-progs: receive: don't lookup clone root for
 received subvolume
Message-ID: <20190722182025.GA22836@vader>
References: <cover.1563600688.git.osandov@fb.com>
 <6af59460e12a8120bf643a923f5fa6bd3b135b20.1563600688.git.osandov@fb.com>
 <CAL3q7H6Z1RiuGODKfuV3Dq3gge8Bdkocdn0VGOrP=14ftkbe-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H6Z1RiuGODKfuV3Dq3gge8Bdkocdn0VGOrP=14ftkbe-g@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 22, 2019 at 01:16:35PM +0100, Filipe Manana wrote:
> On Sat, Jul 20, 2019 at 3:34 PM Omar Sandoval <osandov@osandov.com> wrote:
> >
> > From: Omar Sandoval <osandov@fb.com>
> >
> > When we process a clone request, we look up the source subvolume by
> > UUID, even if the source is the subvolume that we're currently
> > receiving. Usually, this is fine. However, if for some reason we
> > previously received the same subvolume, then this will use paths
> > relative to the previously received subvolume instead of the current
> > one. This is incorrect, since the send stream may use temporary names
> > for the clone source. This can be reproduced as follows:
> >
> > btrfs subvol create subvol
> > dd if=/dev/urandom of=subvol/foo bs=1M count=1
> > cp --reflink subvol/foo subvol/bar
> > mkdir subvol/dir
> > mv subvol/foo subvol/dir/
> > btrfs property set subvol ro true
> > btrfs send -f stream subvol
> > mkdir first second
> > btrfs receive -f stream first
> > btrfs receive -f stream second
> >
> > The second receive results in this error:
> >
> > ERROR: cannot open first/subvol/o259-7-0/foo: No such file or directory
> >
> > Fix it by always cloning from the current subvolume if its UUID matches.
> > This has the nice side effect of avoiding unnecessary UUID tree lookups
> > in that case. Also, while we're here, get rid of some code that has been
> > commented out since it was added.
> >
> > Fixes: f1c24cd80dfd ("Btrfs-progs: add btrfs send/receive commands")
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  cmds/receive.c | 34 ++++++++--------------------------
> >  1 file changed, 8 insertions(+), 26 deletions(-)
> >
> > diff --git a/cmds/receive.c b/cmds/receive.c
> > index a3e62985..ed089af2 100644
> > --- a/cmds/receive.c
> > +++ b/cmds/receive.c
> > @@ -753,15 +753,14 @@ static int process_clone(const char *path, u64 offset, u64 len,
> >         if (ret < 0)
> >                 goto out;
> >
> > -       si = subvol_uuid_search(&rctx->sus, 0, clone_uuid, clone_ctransid,
> > -                               NULL,
> > -                               subvol_search_by_received_uuid);
> > -       if (IS_ERR_OR_NULL(si)) {
> > -               if (memcmp(clone_uuid, rctx->cur_subvol.received_uuid,
> > -                               BTRFS_UUID_SIZE) == 0) {
> > -                       /* TODO check generation of extent */
> > -                       subvol_path = rctx->cur_subvol_path;
> > -               } else {
> > +       if (memcmp(clone_uuid, rctx->cur_subvol.received_uuid,
> > +                  BTRFS_UUID_SIZE) == 0) {
> > +               subvol_path = rctx->cur_subvol_path;
> > +       } else {
> > +               si = subvol_uuid_search(&rctx->sus, 0, clone_uuid, clone_ctransid,
> > +                                       NULL,
> > +                                       subvol_search_by_received_uuid);
> > +               if (IS_ERR_OR_NULL(si)) {
> 
> Hi Omar,
> 
> This, and the change log, look good.
> 
> >                         if (!si)
> >                                 ret = -ENOENT;
> >                         else
> > @@ -769,23 +768,6 @@ static int process_clone(const char *path, u64 offset, u64 len,
> >                         error("clone: did not find source subvol");
> >                         goto out;
> >                 }
> > -       } else {
> > -               /*if (rs_args.ctransid > rs_args.rtransid) {
> > -                       if (!r->force) {
> > -                               ret = -EINVAL;
> > -                               fprintf(stderr, "ERROR: subvolume %s was "
> > -                                               "modified after it was "
> > -                                               "received.\n",
> > -                                               r->subvol_parent_name);
> > -                               goto out;
> > -                       } else {
> > -                               fprintf(stderr, "WARNING: subvolume %s was "
> > -                                               "modified after it was "
> > -                                               "received.\n",
> > -                                               r->subvol_parent_name);
> > -                       }
> > -               }*/
> > -
> 
> Isn't this unrelated? Shouldn't go to a separate patch?

It didn't seem worth it to make a separate patch when I'm moving this
code around anyways, but I noticed that there's a similar check in
another location, so I'll just make it a separate patch.

> Also, would you please create a test case as well?

Will do.

Thanks!
