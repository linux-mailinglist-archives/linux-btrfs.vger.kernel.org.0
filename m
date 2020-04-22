Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC831B4EC0
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 23:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgDVVDy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 17:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgDVVDx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 17:03:53 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACA7C03C1A9
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Apr 2020 14:03:52 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s10so4302249wrr.0
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Apr 2020 14:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bZWlcFWeuKxfBPfxujCGUcJROpA4Wgo9zS8JOmQWvOI=;
        b=LxJ3EhV6giVuYnqA0GoDlkNlZSOpCk3Yea2IPDRx2JTQo9Naxzb14TTBmOUNj4/0+6
         grhpuaBarzLpa5xvq4QAef5XcdZrplW4FPXQ+bkzkWF6zu1UCgF9tLpHANAXhdY0zLT9
         2B1FauRKc59++JaKU6YgeIqDRonyOpUbvLUTrS1XJEpFcpo4OXRon6bJ0BlBnhLOdENy
         LgV8djMa+6ReP9C0VSNj/1Kwk/u98R22Ccjzg48sA8K2xWk60nLzRA9D6p4HFpZla5Rj
         lVhgHJNuscbDECY2jcNXtP7RyBCPxSiNeCu9qmFT6CEhZRnLhmaZKuKWIfwfSDmZu4JC
         xcbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bZWlcFWeuKxfBPfxujCGUcJROpA4Wgo9zS8JOmQWvOI=;
        b=DmwgjhImo9IFknFfZJSSNmEB/wYj+PJD7E7767EM1sn8fbqYhZy40X3IyRWJ+OFRMG
         0BIkentqQoqeYq6M+xw9YTjhJf3/bI2QqqRBmotXy5/gZpJ1jdBFNnr2sNpS/mOPBCt1
         +GSjkrtz0QMXjuv0h9HwWAGHXOxOdSKAtRaUgX5KTEGVceJxPuxMdoUgGkUP8xbLomAS
         1orddAEImgs6gRHfffxtExAYrvPNf+ZmIxcQU2Wed7wPyoc9k3xPWP82CgxHsvj1CuJv
         x5kgH3eA95sgoUQTWpGTKTWq0j1ZzLR1fon8Cj8wJusVCAn3QEcM4qSC9UEu0bjOO/TH
         cntg==
X-Gm-Message-State: AGi0PubY3LmURY6uwqFR7ftVBq33GiUJPdpZ2pIhhWZa5LImeUiCdSM3
        vFub8upeX9GHOTN0XBh26DffgHhEdZ2GnIwDfFWZaxmc
X-Google-Smtp-Source: APiQypKNGZU3WPSG41fFVg0W4E1FMu39JxzFEA57ywn/QZlMtTTXiY2WiL/3h9lK7+0O2igrIdeOu095RTa0hVoTqVI=
X-Received: by 2002:adf:84c2:: with SMTP id 60mr1009638wrg.65.1587589430722;
 Wed, 22 Apr 2020 14:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <03fdc397-4fca-335f-03d8-f93a96d92105@peter-speer.de>
In-Reply-To: <03fdc397-4fca-335f-03d8-f93a96d92105@peter-speer.de>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 22 Apr 2020 15:03:34 -0600
Message-ID: <CAJCQCtTnA6Dro2XwEm0S7ohUnf_CMGb7giHsBfh4_KtWE4vR6g@mail.gmail.com>
Subject: Re: Recommended Partitioning & Subvolume Layout | Newbie Question
To:     Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 22, 2020 at 10:42 AM Stefanie Leisestreichler
<stefanie.leisestreichler@peter-speer.de> wrote:
>
> Hi.
> I wonder how to partition my Disks when I want to use btrfs in a RAID 1
> configuration.
> I have /dev/sda1 and /dev/sdb1 for UEFI/ESP (no btrfs) and think about
> using just 1 more GPT-Partition on each disk /dev/sd[a|b]2 for btrfs. I
> am planing to create a btrfs-RAID 1 on those two partitions.
>
>
> This is what the wiki says about partitioning:
> > Do it the old fashioned way, and create a number of partitions according to your needs? Or create one big btrfs partition and use subvolumes where you would normally create different partitions?
> >
> > What are the considerations for doing it either way?
>
> My use case is a KVM Host running Arch Linux with 3-4 Virtual Machines.
> I want to have the ability to take snapshots when my system will be
> updated to restore a running system if something is broken by the
> update. I read about the mount option which disables CoW for database
> and VM images.
>
> About the subvolume layout and partitioning I am unsure even I read the
> wiki. What do people familar with btrfs recommend for such setup?

The gotcha with Btrfs is that it's very flexible, so there are no
strict rules, only consequences to any decision :D

One example is to install openSUSE using defaults, and see how they do
it with roughly a dozen subvolumes to carve out what does and does not
get snapshot and rolled back.

Another example is on Fedora where only boot, root, and home
subvolumes are created and mounted at /boot, /, /home accordingly.
It's fairly easy to do snapshots and rollbacks manually, because you
only need to rollback the root subvolume (if there were no kernel
updates). e.g.

## mount the top level file system and cd to it
# mv root rootold
# btrfs sub snap root.20200420 root
# reboot

It's that simple. The system doesn't care that you're renaming a
currently booted 'root' subvolume to 'rootold' and then creating a new
'root' from a prior snapshotted 'root'. And now grub and fstab don't
need modification because you've merely substituted an older subvolume
of the same name that they're looking for anyway.

What's the gotcha? Well, my /var has been rolled back, and also the
systemd journal. OK so I could make /var/lib/libvirt and /var/log
subvolumes so they don't get snapshot and rolled back. What I tend to
do is put those in the top level of the file system, and have fstab
entries to mount them to the proper location during startup, that way
I don't have to worry about manually fixing things on a rollback.

The more carving you do, the more help you're likely to want when
making snapshots and rollbacks. Something like snapper, found on
opensuse by default, or something like timeshift on Mint/Ubuntu.

For throw away test machines, I tend to go with the very simple
approach, few subvolumes, and just accept that any rollback means a
kind of data loss for logs and other things in /var. These tend to be
VMs, so I don't really care about the journal being rolled back, and I
don't have nested VMs. To some degree, such a workflow is better
served by containers, but it just depends on your use case and what
tools you're familiar with.

-- 
Chris Murphy
