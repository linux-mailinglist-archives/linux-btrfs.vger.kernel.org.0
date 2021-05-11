Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C895B37A6D1
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 May 2021 14:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbhEKMgu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 May 2021 08:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhEKMgu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 May 2021 08:36:50 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE92C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 11 May 2021 05:35:43 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 5so6052360qvk.0
        for <linux-btrfs@vger.kernel.org>; Tue, 11 May 2021 05:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=kRer444YA6tA+SjW39pIT9FEMWRG3tUq6qXCnUfdYEQ=;
        b=XYyqkTBagf54SuDnDX56htm7WmKWG8q/EZ7EH1zUPI9G2SDaHBkQUxa8GP3IrvPOh+
         PPbqcTfkEafhLPIgOgYVSdA4v5j+R2Vnt7jWhF5FP97xl4EPFAh2Gg1qPKxOtuQ9m5zW
         8TaSKCmCNu9uY6KG+C6863UDRGDniP0Y9Cu8yTsNaHdUCXlwoegUKEBTY7y7/8NcEEaE
         95YEStJ+hTgKpzBYqw4uT0Q8P2Ic/z17fFnZA0tMOFLhIvd4ukD/JvBi3UHrsYmNtx4/
         Udd0FSDRKzMfs6HyDjyfzAz5JNl2aTH4Xr+lv/kQi1stxb+mma+o7l7Lt7svVPmNDfnZ
         9dvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=kRer444YA6tA+SjW39pIT9FEMWRG3tUq6qXCnUfdYEQ=;
        b=Hc1hIM0Zuf0o6Uz3yiShDzlV+4Ob1Y4CC80GMa08BqDt+gnHC2svMNQGO5p82Db32f
         koY/G/wA3JeRWeYAjpcjEYsUveF2NmP6E/FaYfXvMkQriNxDRLCZhSHXBHU7njn31A5r
         fAuvplu5QEx1F0Ti/OMk52N8Fg+Nm08R4cjNRhtKD+UNOWSpdm1kXmo0I7JMl44ClKdH
         G63bJ5UMcBFhFPm00clgjKK9F+SPyF2Jlr6hHC7ohQLSJlR/azEEn3sJXeRUzR8kIYdw
         dNhq4B0gkBJzy9hCkxjVHbo6nerPjWOQQov4tf7UUcM4L8Wt3V4dqZBVasgzVShEbMIi
         kbvQ==
X-Gm-Message-State: AOAM530eBGYA1f6O9RpNm7Q23td3VnHR3yIm0jvy6sZmd0KrZjioyoyy
        SETdrvKXbt7V8dF18VpxxSueN/3NCIHGDymfsejhDEXvG+M=
X-Google-Smtp-Source: ABdhPJzF9FXEG4U20QV29KG4RIOq2uj2xpnE4akoZl6Y8zBoY1qqVan2gAwfXo6T0FnEDKDkToX8swslDjFdId7C3XY=
X-Received: by 2002:a0c:cdcb:: with SMTP id a11mr28870247qvn.62.1620736542816;
 Tue, 11 May 2021 05:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <93c4600e-5263-5cba-adf0-6f47526e7561@in.tum.de>
 <CAL3q7H7mFmNhhCUTeYG_56gsz1p2G_sN=1GuPBjdbB=sC-EQyw@mail.gmail.com> <ad414944-2418-3728-ac1a-5d4d37e37ac1@in.tum.de>
In-Reply-To: <ad414944-2418-3728-ac1a-5d4d37e37ac1@in.tum.de>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 11 May 2021 13:35:31 +0100
Message-ID: <CAL3q7H6WmvatgNpGA6pqPBfe6TjPViwwCJo=wrjBOZRN0q0LuQ@mail.gmail.com>
Subject: Re: Leaf corruption due to csum range
To:     Philipp Fent <fent@in.tum.de>
Cc:     Wang Yugui <wangyugui@e16-tech.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 11, 2021 at 12:35 PM Philipp Fent <fent@in.tum.de> wrote:
>
> On 11.05.21 10:18, Wang Yugui wrote:
> > Is this a server with ECC memory?
>
> My machine does not have ECC memory. So I guess a random bitflip is a
> possibility, but I would rule this out. Memtester didn't report any
> errors in an extended test, and I run quite a lot of write heavy
> databases like sql server. This sql server workload is the only
> application where I ever got csum errors. And I really get them *every
> time* I run it. I think is more likely an issue in sql server's write
> pattern.
>
>
> On 11.05.21 10:56, Filipe Manana wrote:
> > Most likely it's a race when adding checksums. In this case for the
> > log tree (fsync).
> > Try to see if there are reflink operations (clone and dedupe) done by
> > sql server (or maybe docker), in case there aren't, that excludes
> > shared extents being the cause of the problem.
>
> I now also ran the sql server docker container under sysdig, which gave
> me the following breakdown of executed system calls of the container:
> CALLS/S  TOT TIME  AVG TIME SYSCALL
>   13.05   702.41s     420ms futex
>   12.11     193us     124ns gettid
>    7.55    1.05ms    1.09us mprotect
>    6.55      70ms      84us nanosleep
>    5.70     128us     175ns getcpu
>    5.44    1.04ms    1.49us read
>    5.41    1.18ms    1.71us mmap
>    5.25    1.99ms    2.96us openat
>    4.44     122us     215ns close
>    4.23     308us     568ns fstat
>    1.50     298us    1.55us access
>    1.11      21us     153ns getpid
>    1.08      38us     279ns rt_sigprocmask
>    0.94      41us     343ns lseek
>    0.91     542us    4.67us munmap
>    0.77      25us     260ns sigaltstack
>    0.77      22us     226ns set_robust_list
>    0.70     616us    6.92us clone
>    0.55     653us    9.33us sendto
>    0.53    88.96s     1.30s recvfrom
>    0.44     867us      15us madvise
>    0.44      11us     198ns rt_sigaction
>
> Filipe's suspicion of a race condition might be a good lead. There are
> several clone operations in the trace and the majority of runtime seems

Not familiar with sysdig myself, but those clone calls are likely to
be the system call for creating process [1], and not the ioctl for
cloning [2] or dedupe [3].

strace would be clear to me, which I'm more familiar with (or even
better, bpftrace).

Also, seeing that mmap is in the log, I just remembered that 5.13-rc1
includes a fix for races between mmap writes and fsync that could fix
that:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D885f46d87f29a94eafe3cc707d5c4dea2be248f3

The changelog identifies logging file extent items with overlapping
ranges, as the result of the race, but thinking out loud now, I think
it could also result in logging checksum items with overlapping ranges
because of that.
If you want to test it, either try 5.13-rc1 or pick that patch and all
its dependencies into 5.12.x (the dependencies are listed at the end
of the changelog, all of them landed in 5.13-rc1).

I'll see if later today or tomorrow I can get the reproducer to run here.

[1] https://man7.org/linux/man-pages/man2/clone.2.html
[2] https://man7.org/linux/man-pages/man2/ioctl_ficlonerange.2.html
[3] https://man7.org/linux/man-pages/man2/ioctl_fideduperange.2.html

> to be spent contending locks, so I assume there are multiple threads at
> work.
> I've attached the full sysdig log (~1MB), not sure if this helps.
>
> Is there a way to increase the btrfs log output, so I could try to
> observe which leafs are written? CONFIG_BTRFS_DEBUG looks like something
> I could enable. Is this the right approach to narrow down a race?

There's no way to log which leaves are written and dump their contents
on the fly.
That would produce tremendous amount of text to log.

Most likely this is a race condition that the sql server workload is
good for triggering (at least on your box).

Thanks

>
> Thanks.



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
