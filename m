Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38BECBC551
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 11:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504413AbfIXJ6V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 05:58:21 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44766 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504402AbfIXJ6U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 05:58:20 -0400
Received: by mail-vs1-f65.google.com with SMTP id w195so889634vsw.11
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2019 02:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=obsS+57j5QyE6CfGaqBj7rJkm0WLDP4l4dPO3+BYklg=;
        b=hs009mNpetJKLI7nVEhFdBdCvNVYnoHzDWBN4pcF9helzoEz8OhgUbUzO67rdwRBEg
         +E+6klhJo5nsL4lWKBl+ojsPzDTmZoyczY0O7fISCSAx2Kyla9OArOscbepyNRICojk5
         CQ/rupmgrQcbUiMVvMRm5X+hrmOnNEK+GBSFTJ9hSAtkvejGZF3VxpK4TzHkFX3A3ij1
         ulYQOXh9nbTtxEzgKXLeSqh6khVFgiTotdk9MNem9YNqdkLBn8roh9ayXG0s/TyN3HOQ
         LFfmiTsVV68fIMlWZ3KRAfSaLzHYUr//WxAcxs0InUM34kxh6wLLIjuWdnff0hZYcWvI
         fxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=obsS+57j5QyE6CfGaqBj7rJkm0WLDP4l4dPO3+BYklg=;
        b=BBeZlL+zvP2Uh/eEdHfQHs90N8EpcrSiVp+T4hwz+k1M8x7wN6Z9XrdjBJtBS30Ri4
         sFtoUne66pvZmbd18sUqlmU4+mgDOZrlm0W7iBSwrQ9zKRLmlKmcAmVGQkrzFokycGbm
         3/RCvUKYmIocnRjzljU2Dd+DRrVsmjT6/DJ2zFjdQ9aBy1AiacOrI8HwwJMeLbaZMJZ5
         dizIH0WCbkxuZNM0VT+JcpkFe6Dtz+I2pWG+tOfhWzZJb68lpOWvxLmbJJBqeiB8T7cT
         KHBQQmqgeaHL0w4uZGzrZUGwz9qP2B0Q5UhOaFtkBfPntN+Sguc4CmfjBkKi1TK+ej4L
         3RBQ==
X-Gm-Message-State: APjAAAXwlwRcDjvFZFmtoTmqYP61fnwHFCrKRL5bLqBNNVliQr6ZDVE3
        6x80E8cGLz/ewDwRstlyN8Tz6NtYPxOAMzuTaWQ=
X-Google-Smtp-Source: APXvYqy5safntFpsBat7inzQ4TtDXO9zZG5BKtzOfoZs1iLvcpPM9NKh6IEEhJmlNqBTTheP7uAGPz8o+nUEs1/5Z+A=
X-Received: by 2002:a67:5c4:: with SMTP id 187mr965425vsf.14.1569319099346;
 Tue, 24 Sep 2019 02:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <CA+X5Wn7Rtw4rTqXTG8wrEc883uFV7JpGo-zD8FhhD9gM+_Vpfg@mail.gmail.com>
 <CAL3q7H41BpuVTHOAMOFcVvVsJuc4iR10KKPDVfgEsG=ZEpwmWw@mail.gmail.com>
In-Reply-To: <CAL3q7H41BpuVTHOAMOFcVvVsJuc4iR10KKPDVfgEsG=ZEpwmWw@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 24 Sep 2019 10:58:08 +0100
Message-ID: <CAL3q7H4wDdzfA+H0HPk7oKNO3PDiN1nYHpRu5v6rRXvxQFVLbQ@mail.gmail.com>
Subject: Re: WITH regression patch, still btrfs-transacti blocked for... (forever)
To:     James Harvey <jamespharvey20@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Sep 15, 2019 at 2:55 PM Filipe Manana <fdmanana@gmail.com> wrote:
>
> On Sun, Sep 15, 2019 at 1:46 PM James Harvey <jamespharvey20@gmail.com> w=
rote:
> >
> > For several weeks, I've had an enormous amount of frustration when
> > under heavy I/O load with a filesystem putting processes using it into
> > permanent uninterruptible sleep.  Sometimes the filesystem allows
> > reads and only locks up writing processes, sometimes it locks up both.
> >
> > I really, really want this fixed, so will be happy to perform further
> > diagnostics.
> >
> > I've ruled out hardware.  I have two identical Xeon/ECC machines that
> > have been functioning perfectly for years (other amdgpu crashes and a
> > btrfs encryption kernel crash that Qu patched.)  I can replicate this
> > on both machines, using completely separate hardware.
> >
> > I am running into this within QEMU, and originally thought it must be
> > a virtio issue.  But, I believe I've ruled that out.  Within the VM,
> > after a filesystem lock condition starts, I have always been able to
> > dd the entire block device to /dev/null, and I have always been able
> > to dd part of the block device to /tmp, and re-write it back onto
> > itself.  Additionally, as a test, I created a new LVM volume, and
> > within the VM setup LVM and 2 btrfs volumes within it.  When the heavy
> > I/O volume locked up, I could still properly use the other "dummy"
> > volume that was (from the VM's perspective) on the same underlying
> > block device.
> >
> > I've also had a few VM's under minimal I/O load have BTRFS related
> > "blocked for" problems for several minutes, then come out of it.
> >
> > The VM is actually given two LVM partitions, one for the btrfs root
> > filesystem, and one for the btrfs heavy I/O filesystem.  Its root
> > filesystem doesn't also start having trouble, so it doesn't lock up
> > the entire VM.  Since I saw someone else mention this, I'll mention
> > that no fstrim or dedupe has been involved with me.
> >
> > I started to report this as a BTRFS issue about 4 days ago, but saw it
> > had already been reported and a proposed patch was given for a
> > "serious regression" in the 5.2 kernel.
> >
> > Because the heavy I/O involves mongodb, and it really doesn't do well
> > in a crash, and I wasn't sure if there could be any residual
> > filesystem corruption, I just decided to create a new VM and rebuild
> > the database from its source material.
> >
> > Running a custom compiled 5.2.14 WITH Filipe Manana's "fix unwritten
> > extent buffers and hangs on future writeback attempts" patch, it ran
> > for about a day under heavy I/O.  And, then, it went into a state
> > where anything reading or writing goes to uninterruptible sleep.
> >
> > Here is everything logged near the beginning of the lockup in the VM.
> > The host has never logged a single thing related to any of these
> > issues.
> >
> > Host and VM are up to date Arch Linux, linux 5.2.14 with Filipe's
> > patch, and QEMU 4.1.0.
> >
> > The physical drive is a Samsung 970 EVO 1TB NVMe, and a host LVM
> > partition is given to QEMU.  I've used both virtio-blk and
> > virtio-scsi.  I don't use QEMU drive caching, because with this drive,
> > I've found it's faster not to.
> >
> >
> > View relevant journalctl here: http://ix.io/1VeT
> >
> >
> > You'll see they're different looking backtraces than without the
> > patch, so I don't actually know if it's related to the original
> > regression that several others reported or not.
>
> It's a different problem.
>
> A fsync task is trying to get an inode that is being freed, while
> holding a transaction open, and the vfs waits (at btrfs_iget5() ->
> find_inode()) for the inode to be freed before returning.
> Another task which is freeing the inode and running eviction is trying
> to commit the transaction, but it can't, because the fsync task is
> holding the transaction open.
> So, there's a deadlock between those two tasks.
>
> All the other tasks are also trying to commit the transaction but
> can't because of those 2 tasks that are deadlocking.
>
> So getting an inode while fsync'ing another one turns out to be a bad
> idea as it can cause this type of deadlock, which I haven't thought
> about when I added that code in commit [1].
> The problem goes all way back to kernel 4.10, and commit [1]
> introduced this issue, which was meant to fix a performance regression
> that could be detected with dbench (it came to my knowledge through
> the SUSE performance team at the time).
>
> Commit [2] while fixing a data loss (actually entire file) caused by
> fsync after rename scenarios, introduced the performance regression,
> but just because before we had
> incorrect fsync behaviour that lead to the file/data loss, that is we
> were not doing enough work to avoid the file loss. But it was deadlock
> safe, since it was simple and
> just triggered a transaction commit instead of trying to get and log
> other inodes.
>
> That was back in 2016, and a few other commits built on top that just
> added a few more "get other inode" operations while fsync'ing a file.
> So I'll have to undo the performance optimization and just fallback to
> transaction commits whenever that file loss scenario is detected.
>
> I'll send a fix this week for that. Thanks for the report!
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D44f714dae50a2e795d3268a6831762aa6fa54f55
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D56f23fdbb600e6087db7b009775b95ce07cc3195
>

So the good news is that on upcoming 5.4 the problem can't happen, due
to a large patch series from Josef regarding space reservation
handling which, as a side effect, solves that problem and doesn't
introduce new ones with concurrent fsyncs.

However that's a large patch set which depends on a lot of previous
cleanups, some of which landed in the 5.3 merge window,
Backporting all those patches is against the backport policies for
stable release [1], since many of the dependencies are cleanup patches
and many are large (well over the 100 lines limit).

On the other it's not possible to send a fix for stable releases that
doesn't land on Linus' tree first, as there's nothing to fix on the
current merge window (5.4) since that deadlock can't happen there.

So it seems like a dead end to me.

Fortunately, as you told me privately, you only hit this once and it's
not a frequent issue for you (unlike the 5.2 regression which
caused you the hang very often). You can workaround it by mounting the
fs with "-o notreelog", which makes fsyncs more expensive,
so you'll likely see some performance degradation for your
applications (higher latency, less throughput).

[1] https://www.kernel.org/doc/html/v4.15/process/stable-kernel-rules.html

> >
> > After that, everything that was reading/writing is hung, and anything
> > new that tries to do so is also hung.  It doesn't report more "task...
> > blocked" messages, even for new processes attempting reads/writes.
>
>
>
> --
> Filipe David Manana,
>
> =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you'=
re right.=E2=80=9D



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
