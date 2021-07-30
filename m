Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C565A3DB467
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jul 2021 09:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbhG3HSn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Jul 2021 03:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237775AbhG3HSk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Jul 2021 03:18:40 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DE8C061765
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jul 2021 00:18:36 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id x66so2438071vsb.1
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jul 2021 00:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D15pokXBL/I5gJU0P70zkw18CmA6/e8A1wCKqftQ0jo=;
        b=SelIT/vtgcNRB5mPXijJtBqG7k2rfe3avRxhQIKcwriibkwOQ6G8fwGFSykbXaMnY+
         ft1VFxdfb8HJvMxKk6zPdM5O+5am17GFZ1gEtwutHdq5QuST9uW46dW38jCkGZ/zbV/4
         s6FCFy3ylqh0YivuoVbTijf/RIBxlLYirqbn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D15pokXBL/I5gJU0P70zkw18CmA6/e8A1wCKqftQ0jo=;
        b=Ib5NpojcCGkQ63cu/RsoQSKZdDYPuMg0QpZibvKHqN1+IYrrwAjYTlLn0aby7RiCxn
         XP3CQJbainVYaiBc+AWaLjvgY4513H/2OYK6OxjR3k/5NdQVKcRFQG6uvAAthDa5k9L8
         SoUOvuwuKKaEWnTXnAtxCXiyi3xnEQlxDhvH3Xn2dl7Ru+HoMskQHKg5DWFIVzS5AFMi
         eBZLDvx/JaHZTkI8rRC0Avv2uagNHox2CXjRdqT3/aS+Hyc85fB/Y863Ga6Jb0ZGN75o
         uAnj1BjYMnKpIwIWYYnyR7/n1pv5iHt14yuoN/BAwdU85+09+QYIuesiArgiF7y6Rhz7
         c6RA==
X-Gm-Message-State: AOAM530ZZQT/ueQKUuNWqegm4LgdCl1fQT8zGMtfzJ3xQKGfUf1bjuY0
        r/jOJSFFd5ZH0B5H0PMPjR8EKiCL6pWCle9cg8Tosw==
X-Google-Smtp-Source: ABdhPJxqa7+cfyfqujKlXCApdXFNS1/wQN/0ZS8Ux3Akkj3dGFBMOhQ5JphC5fQ9ajynAXCpmYopPDXoRpIz61Cq+lM=
X-Received: by 2002:a67:c009:: with SMTP id v9mr478988vsi.47.1627629515318;
 Fri, 30 Jul 2021 00:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <162742546548.32498.10889023150565429936.stgit@noble.brown>
 <YQNG+ivSssWNmY9O@zeniv-ca.linux.org.uk> <162762290067.21659.4783063641244045179@noble.neil.brown.name>
 <CAJfpegsR1qvWAKNmdjLfOewUeQy-b6YBK4pcHf7JBExAqqUvvg@mail.gmail.com> <162762562934.21659.18227858730706293633@noble.neil.brown.name>
In-Reply-To: <162762562934.21659.18227858730706293633@noble.neil.brown.name>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 30 Jul 2021 09:18:24 +0200
Message-ID: <CAJfpegtu3NKW9m2jepRrXe4UTuD6_3k0Y6TcCBLSQH7SSC90BA@mail.gmail.com>
Subject: Re: [PATCH 01/11] VFS: show correct dev num in mountinfo
To:     NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 30 Jul 2021 at 08:13, NeilBrown <neilb@suse.de> wrote:
>
> On Fri, 30 Jul 2021, Miklos Szeredi wrote:
> > On Fri, 30 Jul 2021 at 07:28, NeilBrown <neilb@suse.de> wrote:
> > >
> > > On Fri, 30 Jul 2021, Al Viro wrote:
> > > > On Wed, Jul 28, 2021 at 08:37:45AM +1000, NeilBrown wrote:
> > > > > /proc/$PID/mountinfo contains a field for the device number of the
> > > > > filesystem at each mount.
> > > > >
> > > > > This is taken from the superblock ->s_dev field, which is correct for
> > > > > every filesystem except btrfs.  A btrfs filesystem can contain multiple
> > > > > subvols which each have a different device number.  If (a directory
> > > > > within) one of these subvols is mounted, the device number reported in
> > > > > mountinfo will be different from the device number reported by stat().
> > > > >
> > > > > This confuses some libraries and tools such as, historically, findmnt.
> > > > > Current findmnt seems to cope with the strangeness.
> > > > >
> > > > > So instead of using ->s_dev, call vfs_getattr_nosec() and use the ->dev
> > > > > provided.  As there is no STATX flag to ask for the device number, we
> > > > > pass a request mask for zero, and also ask the filesystem to avoid
> > > > > syncing with any remote service.
> > > >
> > > > Hard NAK.  You are putting IO (potentially - network IO, with no upper
> > > > limit on the completion time) under namespace_sem.
> > >
> > > Why would IO be generated? The inode must already be in cache because it
> > > is mounted, and STATX_DONT_SYNC is passed.  If a filesystem did IO in
> > > those circumstances, it would be broken.
> >
> > STATX_DONT_SYNC is a hint, and while some network fs do honor it, not all do.
> >
>
> That's ... unfortunate.  Rather seems to spoil the whole point of having
> a flag like that.  Maybe it should have been called
>    "STATX_SYNC_OR_SYNC_NOT_THERE_IS_NO_GUARANTEE"

And I guess just about every filesystem would need to be fixed to
prevent starting I/O on STATX_DONT_SYNC, as block I/O could just as
well generate network traffic.

Probably much easier fix btrfs to use some sort of subvolume structure
that the VFS knows about.  I think there's been talk about that for a
long time, not sure where it got stalled.

Thanks,
Miklos
