Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 734B013BE2
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 May 2019 21:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfEDTFv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 May 2019 15:05:51 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34663 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbfEDTFv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 May 2019 15:05:51 -0400
Received: by mail-lf1-f65.google.com with SMTP id v18so4345529lfi.1
        for <linux-btrfs@vger.kernel.org>; Sat, 04 May 2019 12:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gXQQYBJ7AAoEug9M/7FERXacFQXInv+/mLszDy7wx+Q=;
        b=amwpfm6lL1zhprLmXQudiiSC8W7eOhy8YfpKR/UfDIDd9g1AMqcMWXKIVsPnKIKVPE
         DEVgluVMnjcSizKQtof/tukT3Xi8uPEvSn2jPryEkAfJdEpw42LGrJgepv9RvBJYmsCa
         zX92gI6O2VtYqQF1FxvRdlH9fyN4KAYjy3IwBUO2nZn+IT+bZeYh7uVe0qAYMUw2RD8e
         HmI84QIQz4ZIE3hG8LGDVmkaosSHHOpJYZfHRjkX6dc0PPz2A33pUMNg7qmuhKXAs2ez
         5/CM4wHdq1IfcFitjHI5wo8go+aerGQqG4ZjFgYsV+S/VGilydr+x+513EfMZLuk9lMG
         82kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXQQYBJ7AAoEug9M/7FERXacFQXInv+/mLszDy7wx+Q=;
        b=FkrUwTZOmsFRWIXkSu1+DfL/mSzeCklsR1EW/1p8L7SodbEtjNnSsUF4uhGmjJkvbP
         6sdOrYhS3wkZbDBwKmKMTpXwMsM/N35HkaSTfRR00oLMTZi0hcNq/z9ceHq7QJde5v5N
         e0pgOgbl4kISD+MaYw2IIAkmir0ssSDi+GajvNGVIdcMOE6SJoKwq+lzcBw9mDxrsWIj
         41jA8GakasVFthjdD+OxL4LmZEVlAas3hUuvGfnuu1p8l/toGfKwWoWCJmgHLenz6jN/
         h13pMVM5kAg/TPJIndD1EyhBl8eb02qTnA4BusLrR0jB8l535955z/wn9YXmmcSe9Mrn
         mYLw==
X-Gm-Message-State: APjAAAVCjxKgy73CF0pH5NmQNhiWciZo6myAIK3PagFB4KDAN6X/msNs
        /OfltPwQp/7A7Alrw/BfrztDs6lpdwmZNhXUaxtKYg==
X-Google-Smtp-Source: APXvYqzcPwnqX5GWrMxatQGc0LOXPEBWVLN7K2JNmIRXjm8T7LVRlR3TuQ8mZOgjho+jpm5T/ozdb/JSU2vCzhOxWVg=
X-Received: by 2002:a19:4a04:: with SMTP id x4mr8458058lfa.124.1556996748542;
 Sat, 04 May 2019 12:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <em9eba60a7-2c0d-4399-8712-c134f0f50d4d@ryzen> <e6918268-1e3e-6c2d-853c-aa1eaf8e9693@gmx.com>
 <ema5c33b0a-936b-48f6-99ba-4c5a50e8a88a@ryzen> <CAJCQCtTHFi8uR1JndoXju0HvfGvBwXK6Pq4oqJiop82FaT_J-A@mail.gmail.com>
 <emebc18462-5243-43f8-be24-79a932d90a57@ryzen>
In-Reply-To: <emebc18462-5243-43f8-be24-79a932d90a57@ryzen>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 4 May 2019 13:05:37 -0600
Message-ID: <CAJCQCtSdD32h_xTBVOxEZOp0XijqA0j=HsS5YgdePVhpdgtuRg@mail.gmail.com>
Subject: Re: Re[4]: Rough (re)start with btrfs
To:     Hendrik Friedel <hendrik@friedels.name>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 4, 2019 at 3:31 AM Hendrik Friedel <hendrik@friedels.name> wrote:
>
>  >I should have read this before replying earlier.
>  >
>  >You can also do a one time clean mount with '-o
>  >clear_cache,space_cache=v2' which will remove the v1 (default) space
>  >cache, and create a v2 cache. Subsequent mount will see the flag for
>  >this feature and always use the v2 cache. It's a totally differently
>  >implementation and shouldn't have this problem.
>
> So, you have a suspicion already about what caused the problem? Why is
> v2 then not default? Is it worth chasing the Bug in v1?

v2 is expected to become the default soon

There's known contention for certain workloads when using v1 because
the cache information is stored as if it were a hidden data file,
whereas v2 uses its own btree. But from the sound of it Qu has enough
information to maybe track down the v1 problem and fix it, and
probably should be fixed as v1 is the default and is still supported
and will be forever. But the time frame for a fix may be a while, I'm
not sure.


> For me, the question now is, whether we should chase this Bug or not. I
> encountered it three times while filling a 8TB drive with 7TB. Now, I
> have 1TB left and I am not sure I can reproduce, but I can try.

I don't think it's necessary unless Qu specifically asks.


>
>  >Qu would know better but usually developers ask for sysrq+w when
>  >there's blocked tasks.
>
> I am wondering, whether there is a -long term- a better way than this.
> Ideally, btrfs would automatically create a
> btrfs-bug-DD-MM-YY-hh-mm-ss.tar.gz with all the info you need and inform
> the User about it and where to issue the bug.

No Linux file system has such a thing. And to create such a package
would happen in user space, not the kernel code. Most of Btrfs is
kernel code, same as ext4 and XFS and other file systems. What is
usually the case, if the file system gets confused, it should dump
information into the kernel messages, and the file system developers
do control what kinds of info, error, and warning kernel messages get
dumped into dmesg. Normally that's enough. But since Btrfs is in the
kernel, it depends on other things that happen in the kernel and it's
sometimes necessary to get more information on demand. There really
isn't a way to automate sysrq - you wouldn't want to constantly dump
that amount of information into kernel message buffer and then burden
the system logger with quite a lot of extraneous information.



>
>  >You know what? Try changing the scheduler from mq-deadline to none.
>  >Change nothing else. Now try to reproduce. Let's see if it still
>  >happens.
>
> Wouldn't it make sense first to try to reproduce without changing
> anything?

I assumed it was a persistent problem rather than a transient one. So
yes you should first discover the reproduce steps. That's ideal too
for the developers because often they need to reproduce to see on
their own system what's going on, and often times they have Btrfs
debug option set in their kernels which most distros do not enable. So
they can see more things than we do.

Once you have a reproducer, then you can change the scheduler and see
if your reproduce steps still reproduce the problem.



>
>  >Also, what are the mount options?
> rw,noatime,nospace_cache,subvolid=5,subvol=/
> But noatime and nospace_cache I added just today.

OK that all looks good.


-- 
Chris Murphy
