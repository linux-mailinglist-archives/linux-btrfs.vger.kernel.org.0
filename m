Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 152E4D6CB8
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 03:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfJOBFJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Oct 2019 21:05:09 -0400
Received: from mail-vs1-f53.google.com ([209.85.217.53]:37996 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbfJOBFJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Oct 2019 21:05:09 -0400
Received: by mail-vs1-f53.google.com with SMTP id b123so12024487vsb.5
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2019 18:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kDxasH+HxjQV6mnQ7zdP4eXJA5sN15jI1TP0M1U+Fwo=;
        b=V27o4hKWwDa/xhOJgUOo9C30y3cVt5Tyo4L2gfDlKrePXcy9WOSXTa9S37IHBdKKdq
         Q1gnRpJJNhgi4oDVus/RcaURm95dXbWwKh8R6Q8Ln1B/1YY16jBFs3bt841+mhPWSqHP
         6i4K2/lhEx/3SixMGgYCRNnirPiHgpeaie/WeTVnaMIsiw+vtAQsdU+c5dgTbhfx0Frp
         n42xGCR+dFCu9VxHoUB6/MGuKPBs8hfO+NVdllkRiv6G8FVeN90wq/5bdgH61wWv1YJ4
         oPN13guaAR27EcgKq3zDk6tzalPT3/3uinZqOalQ14b78jbDBC4QoWPS6y+armoWdkxF
         l2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kDxasH+HxjQV6mnQ7zdP4eXJA5sN15jI1TP0M1U+Fwo=;
        b=If3WGQGhRAzDWWZxUk0DhwnVmJdphbuHrkMPn/d7BZE6T+Lrl+YbmxGFhA1U02CucP
         2l/gsBijPfaMmSJUgMP7z1HSztBBpM1C+h/8MFgOMU8aLHbdObkPyrUvXvc766Sh672J
         g3DG8WY+KslHSdfzBcMVxmXezwK8Mhikg05yESmhbf0V2kVXUscbJ88m+9Tt8OJ1zVAz
         Rde5akbpIGm8QkMRPVQ1Av4z754Je7yXZC6EeuKWPQkwF2cSgQ73N1mv6gIFoRhohMl/
         Bu8d8eqRHChIL4d0tRc8O+7NwaszOOvXjD2l9JAvY1Lf2OzLSp2zAwpRptSLFJF0rZWV
         t7HA==
X-Gm-Message-State: APjAAAUbFvuvkw33nJv/4/wo0oggVPbsUyHbgXfIKSrM/iYA232Cqa4Y
        A/Pn8JHHKypEWjXojM0/QtaAAoJeM45WS+GJEq40T3K1
X-Google-Smtp-Source: APXvYqzDfPGIGf+qVEKt+iZvtaxCvnr2yoRbA7ThBsW+cicyv18MYkKPbypXqxyW8J1aFbHTCX4x73lXShaoiFCjy68=
X-Received: by 2002:a05:6102:525:: with SMTP id m5mr18791052vsa.177.1571101507350;
 Mon, 14 Oct 2019 18:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <CA+X5Wn72nYqoMLLHAUZeO43_rLL9c=zwjDYG9MKV+rcZ7x6SXw@mail.gmail.com>
 <CAJCQCtT6=msmaMJg-GrV8x=oPUEwuMjHxtXLQMrtSDHkq-DDZw@mail.gmail.com>
In-Reply-To: <CAJCQCtT6=msmaMJg-GrV8x=oPUEwuMjHxtXLQMrtSDHkq-DDZw@mail.gmail.com>
From:   James Harvey <jamespharvey20@gmail.com>
Date:   Mon, 14 Oct 2019 21:04:56 -0400
Message-ID: <CA+X5Wn6DbccBXWe0uA2n-mRq-hU0WP20YTFDNw-mEWcdXxO=Hg@mail.gmail.com>
Subject: Re: 5.3.0 deadlock: btrfs_sync_file / btrfs_async_reclaim_metadata_space
 / btrfs_page_mkwrite
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Oct 13, 2019 at 9:46 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Sat, Oct 12, 2019 at 5:29 PM James Harvey <jamespharvey20@gmail.com> wrote:
> >
> > Was using a temporary BTRFS volume to compile mongodb, which is quite
> > intensive and takes quite a bit of time.  The volume has been
> > deadlocked for about 12 hours.
> >
> > Being a temporary volume, I just used mount without options, so it
> > used the defaults:  rw,relatime,ssd,space_cache,subvolid=5,subvol=/
> >
> > Apologies if upgrading to 5.3.5+ will fix this.  I didn't see
> > discussions of a deadlock looking like this.
>
> I think it's a bug in any case, in particular because its all default
> mount options, but it'd be interesting if any of the following make a
> difference:
>
> - space_cache=v2
> - noatime

Interesting.

This isn't 100% reproducible.  Before my original post, after my
initial deadlock, I tried again and immediately hit another deadlock.
But, yesterday, in response to your email, I tried again still without
"space_cache=v2,noatime" to re-confirm the deadlock.  I had to
re-compile mongodb about 6 times to hit another deadlock.  I was
almost at the point of thinking I wouldn't see it again.

After re-confirming it, I re-created the BTRFS volume to use
"space_cache=v2,noatime" mount options.  It deadlocked during the
first mongodb compilation.  w > sysrq_trigger is a little bit
different.  No trace including "btrfs_sync_log" or
"btrfs_async_reclaim_metadata_space".  Only traces including the
"btrfs_btrfs_async_reclaim_metadata_space".  Viewable here:
http://ix.io/1YGe

Who knows, maybe as a particular volume has more use, it becomes less
likely to deadlock.  IF it is space cache related, maybe as the tree
gets filled out, it becomes less likely?  Or, maybe I'm looking too
much into variance, and just the way the dice rolled was that it
happened on the first retry on the new volume.  My initial deadlock
was right after volume creation, as well.

I'll also mention this is on 32 cores and a Samsung 970 EVO NVMe, and
a multithreaded compilation, so perhaps it requires a pretty high load
to run into this.

Also, as I'm testing some issues with the mongodb compilation process
(upstream always forces debug symbols...), as a workaround to be able
to test its issues, I've used a temporary ext4 volume for it, which I
haven't had a single issue with.
