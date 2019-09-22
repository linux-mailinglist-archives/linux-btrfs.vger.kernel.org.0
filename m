Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9052BABF3
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2019 00:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387771AbfIVW2a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Sep 2019 18:28:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39863 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfIVW2a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Sep 2019 18:28:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id r3so11858464wrj.6
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Sep 2019 15:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v11f5kmg9anhuADvlPIu6z9Uc/2mgo7q8AdgKbjwKrI=;
        b=K1NTi4sy8/1sG+0l04FtiVOE7PeFCLkYn43JJGbJJ1GjyOC99Gkmg9YXqPDD+94uRA
         v8pKfX94Zf9v9Vx2WTSYF/fu0IQETHg+px6adWMcqT7Z4itCovY+0SEcR8LHV6upTgE0
         EJXxYdcNoxrndJiUE6X/fMAu6owzBXDERegeYvjSFsEsuj7iDlgFW85tE/rVkgb301yI
         exM+wvhHVrqgVhiI1waMkerlzi/bH77Cycnyud1n8T/2JQOQJVIF8GuEDaGEh3ta0mwy
         rWwqaVpU3/nfBffJkL/FNDwL/oVySordbrwxgb1c/uaq5Y9mdYjIL86HxAH3LIzCK33P
         pJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v11f5kmg9anhuADvlPIu6z9Uc/2mgo7q8AdgKbjwKrI=;
        b=eUqEBN22kraLB5aFBb9HOjit71gV5GlXel/iL3x4C7Vdz8O0ugDrzmFPKfh4Srx5MS
         EHSrBy2Qe2UYXwkIHnALYb4I4fCAK16SE7V+UX7N6Bhoj8NQsIrEUqK1xI7k58b3Ov0u
         pShKKRKqJQFHBvYnXjFU6/rRpgTd5KkbBYLv8huANKcTbNopqfqR069s/zuidxizoaJT
         pSlXYWkr8vXQ8gWg8Kiq0bPV5mQn4ODjy8IlWyWdYLIE9VL9sMC2O0pJhkjKeTbcQk2X
         ZCcKrPhDAIyDbMDwaWvTAk3k3MnonyYbyp6NN7AEjE5k//fEGbgzliTBnwXWyqpbhEAw
         QPng==
X-Gm-Message-State: APjAAAXwFkRxavJ761te66QySxcDySd5QkImTlheQb/8L9Bs9RUcoj0h
        hlCAUL3e4+vqO9G2sqbdlqci6a8lyvB6gSskssK7/sboCcHqrg==
X-Google-Smtp-Source: APXvYqxxtMaWcuHMz/mN7qofZ8xU3Y+zfhXrv6f+Fg06ttxZdspZdNVdu7A75JRdeL1WC0Ivw26F5/bBc3aaNpjZxH0=
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr6802523wrr.390.1569187512557;
 Sun, 22 Sep 2019 14:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <94ebf95b-c8c2-e2d5-8db6-77a74c19644a@petezilla.co.uk>
 <CAJCQCtRAnJR+Z8Z8Bq91YXiMpfmwOiHK0tQ+9zAJvSVvexHnxg@mail.gmail.com> <54fa8ba3-0d02-7153-ce47-80f10732ef14@petezilla.co.uk>
In-Reply-To: <54fa8ba3-0d02-7153-ce47-80f10732ef14@petezilla.co.uk>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 22 Sep 2019 15:25:01 -0600
Message-ID: <CAJCQCtQLk1m8yAxPPDLVZBr3MehdDD3EpNZ6O_OCRsO-FFzRNw@mail.gmail.com>
Subject: Re: Balance ENOSPC during balance despite additional storage added
To:     Pete <pete@petezilla.co.uk>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Sep 22, 2019 at 1:07 PM Pete <pete@petezilla.co.uk> wrote:
>
> On 9/22/19 6:47 PM, Chris Murphy wrote:
>
> >> Unfortunately I don't seem to have any more info in dmesg of the enospc
> >> errors:
> >
> > You need to mount with enospc_debug to get more information, it might
> > be useful for a developer. This -28 error is one that has mostly gone
> > away, I don't know if the cause was ever discovered, but my
> > recollection is once you're hitting it, you're better off creating a
> > new file system rather than chasing it.
> >
> > But you could use 5.2.15 or newer, mount with enospc_debug, and do
> > filtered balance. You could start with 1% increments, e.g. -dusage=1,
> > -dusage=2, up to 5. And then do it in 5% increments up to 70. The idea
> > of that is just to try and avoid enospc while picking off the low
> > hanging fruit first (the block groups with the most free space). At
> > that point I would then start a full balance, no filter. Maybe that'll
> > get it back on track. I haven't ever experienced this so this strategy
> > is totally a spitball method of trying to fix it. There is some degree
> > of metadata rewrites that happens as part of balance, and balance is
> > pretty complicated, and not entirely deterministic - meaning it's
> > plausible the filtered balance followed by a full balance could fix
> > it. But I don't understand it well enough.
>
> OK, I'm building 5.2.17 now.  Keen to avoid the corruption errors I was
> hit by a few weeks back...  May take a time as I'm in the middle of a
> slow backup.

Did you see corruption on this same file system? The 5.2 corruption
bug has been fixed in 5.2.15.
https://www.spinics.net/lists/stable-commits/msg129532.html

I'm not aware of a way to fix it though.


> I note that a filtered balance, though not hitting enospc and not
> reporting any errors did seemed to relocate a chunk/extent (sorry, I
> forget the terminology) but running it a second, third and so on time
> got the same result.  As if the balance reported doing some work, but
> did not actually do it.  I also had to reboot at one point as it seemed
> to get stuck in a loop but alas I can't repeat this.  With the extra
> logical volume added there is certainly no lack of space relative to the
> size of the filesystem.

For sure you're running into some kind of bug.

--
Chris Murphy
