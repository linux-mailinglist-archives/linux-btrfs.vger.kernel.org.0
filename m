Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7C935AF68
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Apr 2021 19:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbhDJRzq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Apr 2021 13:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbhDJRzp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Apr 2021 13:55:45 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6E4C06138A;
        Sat, 10 Apr 2021 10:55:30 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id i22so2752596ila.11;
        Sat, 10 Apr 2021 10:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TpDRmfHYxRpBMa2SbmSiCER1vp7MLZQgt69n2xmjiyk=;
        b=AhD4Qu3/7+BykOk3nyrJr7EMQWcrMHXHbrESB+PqhUgKBMzP771wiXH6XjCp2wVszA
         AS1AHoXm9ca9PtsLTBdmhCHBPeKVZTqJ2Z0o0oUg50CEM/e0yvG6ae2FL/FSiW475Fkh
         tUyWADyXZcHQLY0AX0pha5eA1pezPrw9ClguPmh/UiH6oYy/rHdK7w6vDL//DxtuHpQm
         vNH2xaRAc7vz7LJjy+k7OU4LEH7hB/AeFgXTVXVe/40uX3k71qDyUGiFxHh+fA9Uzutr
         /s5m16DnInwtT7wh8UKWTE8BVO1nMvSGW0L7ajpBdDRK/Au87eqDMmuUN8S1cFqVp333
         S88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TpDRmfHYxRpBMa2SbmSiCER1vp7MLZQgt69n2xmjiyk=;
        b=N5BzHyNOkSFt+VO5m3Jx3PtNV22my58UaCs24676YtQ51L3ZUzkqjJZAtk3gNpo0UG
         /jCikgpWSs8ueG6Qr0nuQ6S2f8T6WUU+H1uT0vh6JzGFSvcP5MQcAiS2QorBQ8x+l3hZ
         4Urg+X+ec0rT/pQNU5IjGMtq5sI6hwRWVxF/Lrw1NHPWBgGHe4PQ6eReiZX6YcLUY6IY
         Zek7qGReKJiQpZjT6nwcgHXHHqyQMkCsrOt1gIKK/LtglRfX6ypEBCHlCRtROen2hvLs
         IBJvrTZ4hdbDW0ueJeYf09s78oR/cthAo7zwx9SKUplF/SiU8ra9Uzuwqyygoptj6KyJ
         sSAA==
X-Gm-Message-State: AOAM532HiqqJ9EJobq2qSOc7KMPb08E4qawCo0Dyib9bdVH+KNDPutFR
        iMDbe95xvh5/uOSniVhjCjphTJTsHT2PgXHgkReKD/tV
X-Google-Smtp-Source: ABdhPJyEOPYNw2FcOANmrflpFx/vZlfE+pli5qotpS+BPHqaQaomlhYGW0QlPrL6im7iWmuJIcBET5XtTa2Fsek6OKM=
X-Received: by 2002:a92:2c08:: with SMTP id t8mr15985626ile.72.1618077329917;
 Sat, 10 Apr 2021 10:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTp0aXBssEr4ZXGX=DS_+RyGghmoANCKDdxG59QWu8LVA@mail.gmail.com>
 <CAOQ4uxht70nODhNHNwGFMSqDyOKLXOKrY0H6g849os4BQ7cokA@mail.gmail.com> <CAJCQCtRGdBzyskifrYLbBGAAm0g7VeC6GeD7xBN-hRqE3GAWYA@mail.gmail.com>
In-Reply-To: <CAJCQCtRGdBzyskifrYLbBGAAm0g7VeC6GeD7xBN-hRqE3GAWYA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 10 Apr 2021 20:55:18 +0300
Message-ID: <CAOQ4uxhU2KX=jKKL5EZ102z_+6KyVKAOoAzSp2K8i0PMGJUg4A@mail.gmail.com>
Subject: Re: btrfs+overlayfs: upper fs does not support xattr, falling back to
 index=off and metacopy=off.
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 10, 2021 at 8:36 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> I can reproduce the bolt testcase problem in a podman container, with
> overlay driver, using ext4, xfs, and btrfs. So I think I can drop
> linux-btrfs@ from this thread.
>
> Also I can reproduce the title of this thread simply by 'podman system
> reset' and see the kernel messages before doing the actual reset. I
> have a strace here of what it's doing:
>
> https://drive.google.com/file/d/1L9lEm5n4-d9qemgCq3ijqoBstM-PP1By/view?usp=sharing
>

I'm confused. The error in the title of the page is from overlayfs mount().
I see no mount in the strace.
I feel that I am missing some info.
Can you provide the overlayfs mount arguments
and more information about the underlying layers?

> It may be something intentional. The failing testcase,
> :../tests/test-common.c:1413:test_io_dir_is_empty also has more
> instances of this line, but I don't know they are related. So I'll
> keep looking into that.
>
>
> On Sat, Apr 10, 2021 at 2:04 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> > As the first step, can you try the suggested fix to ovl_dentry_version_inc()
> > and/or adding the missing pr_debug() and including those prints in
> > your report?
>
> I'll work with bolt upstream and try to further narrow down when it is
> and isn't happening.
>
> > > I can reproduce this with 5.12.0-0.rc6.184.fc35.x86_64+debug and at
> > > approximately the same time I see one, sometimes more, kernel
> > > messages:
> > >
> > > [ 6295.379283] overlayfs: upper fs does not support xattr, falling
> > > back to index=off and metacopy=off.
> > >
> >
> > Can you say why there is no xattr support?
>
> I'm not sure. It could be podman specific or fuse-overlayfs related.

Not sure how fuse-overlayfs is related.
This is a message from overlayfs kernel driver.

> Maybe something is using /tmp in one case and not another for some
> reason?
>
> > Is the overlayfs mount executed without privileges to create trusted.* xattrs?
> > The answer to that may be the key to understanding the bug.
>
> Yep. I think tmpfs supports xattr but not user xattr? And this example
> is rootless podman, so it's all unprivileged.
>

OK, so unprivileged overlayfs mount support was added in v5.11
and it requires opt-in with mount option "userxattr", which could
explain the problem if tmpfs is used as upper layer.

Do you know if that is the case?
I sounds to me like it may not be a kernel regression per-se,
but a regression in the container runtime that started to use
a new kernel feature?
Need more context to understand.

Perhaps the solution will be to add user xattr support to tmpfs..

Thanks,
Amir.
