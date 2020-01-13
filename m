Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65C22139D8A
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 00:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgAMXlw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jan 2020 18:41:52 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37865 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbgAMXlw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jan 2020 18:41:52 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so10446122wru.4
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2020 15:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q3yjL8sl3ogNg8EuVjfYdl5n+a9JrJKeHMmEUYwpmMI=;
        b=UQfBrwkri4g0gcx+IcbBGyPc0Gpfmb4ORTK3Af0u2df27EkbVzgMKPHGTILPAUakHR
         8Ln4M+CYc/5ru70yFNUAO06hiC9OOR8LNt7TwEAoZ3p8u1PxcZlfGv3ezLnF6iPUDig1
         UhRk8oPS0h5py0L6fF6KuYUI9s4Ps5v7nGP/8udP5BS+I5G2bGm/Kw7sjvu5a9n2O//k
         ofM9Ap9MI3OSbsBd3vltdZkfy0bInJmVsTJr/a4nyfRzQ0sC6axvgwpVrxuDHAPKcUth
         kVT9y84md7yIATWujckRXs6unujGTxBeeVs/h0E5KJEhzTawfU32nMJPvtgBeWGBS8L9
         jKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q3yjL8sl3ogNg8EuVjfYdl5n+a9JrJKeHMmEUYwpmMI=;
        b=TCEHEC89OUFJseI/ht/++eXnTvAv0gUj/ISvQGAODrQe6aHYCclBFYo2mtKdPIQbFK
         E+gPgwWFM2wuXNtBTk5zRyoNmVX3Aoscd7Q+Ws7xfASkurude8mGAADzq/utP11QIGAX
         p7YElSMP7TyrPOyLMLrP8Q8nqN/ErSp1FtRYx1f3yiBNq2VQmwmAwatbTfUf/SVHJQ7h
         F9XToqpObBh3/+k5uM4VkjA6viKdkOjJuH5Q0McyNJvSSJ13VuyTjJwGTItHTd6nSHIz
         VaXQ4svC3NLiuQn8LLFt0JAY6pnPuNDnxm9PbmdqRfEfJMaMo9gjdkPgc/oEBlPlmke1
         LQDQ==
X-Gm-Message-State: APjAAAUgf1s6VGXVTRSHgqe0U1l8iH0wLxvkTcpo736iHxigQyhsR2LX
        70XQWZXIYqLrpMleZ9oZuWwA2GgUrnbcV9zebOZ3ng==
X-Google-Smtp-Source: APXvYqy9Papb0H/DA2KhhY/T9bdrzBRVd+EyjTncLkHhmb8UkZ2kWlBekXnsKguhucanf1Hneb5CXNqBlNRt+tnFBIw=
X-Received: by 2002:adf:ea4e:: with SMTP id j14mr21921915wrn.101.1578958910021;
 Mon, 13 Jan 2020 15:41:50 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.99999.375.2001131400390.21037@trent.utfs.org>
 <CAJCQCtS9rx0M30zLxkND5MYTwLEPxYG=8BuRB3b1Bi8Vr3KTqg@mail.gmail.com>
 <alpine.DEB.2.21.99999.375.2001131514010.21037@trent.utfs.org> <CAJCQCtShpdS81pvc1m26yPmriaE7_3=MZTFkbXknp9+Wehwr5w@mail.gmail.com>
In-Reply-To: <CAJCQCtShpdS81pvc1m26yPmriaE7_3=MZTFkbXknp9+Wehwr5w@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 13 Jan 2020 16:41:34 -0700
Message-ID: <CAJCQCtSmDx10PQvA8j58NcGyEV9La5FRLYj=q-EHTTXwJF+8ZQ@mail.gmail.com>
Subject: Re: file system full on a single disk?
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Christian Kujau <lists@nerdbynature.de>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 13, 2020 at 4:29 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Mon, Jan 13, 2020 at 4:21 PM Christian Kujau <lists@nerdbynature.de> wrote:
> >
> > On Mon, 13 Jan 2020, Chris Murphy wrote:
> > > It's a reporting bug. File system is fine.
> >
> > Well, I received some ENOSPC notifications from various apps, so it was a
> > real problem.
>
> Oh it's a real problem and a real bug. But the file system itself is OK.
>
> >
> > > > I'm running a --full-balance now and it's progressing, slowly. I've seen
> > > > tricks on the interwebs to temporarily add a ramdisk, run another balance,
> > > > remove the ramdisk again - but that seems hackish.
> > >
> > > I'd stop the balance. Balancing metadata in particular appears to make
> > > the problem more common. And you're right, it's hackish, it's not a
> > > great work around for anything these days, and if it is, good chance
> > > it's a bug.
> >
> > For now, the balancing "helped", but the fs still shows only 391 GB
> > allocated from the 924 GB device:
> >
> > =======================================================================
> > # btrfs filesystem show /
> > Label: 'root'  uuid: 75a6d93a-5a5c-48e0-a237-007b2e812477
> >         Total devices 1 FS bytes used 388.00GiB
> >         devid    1 size 824.40GiB used 391.03GiB path /dev/mapper/luks-root
> >
> > # df -h /
> > Filesystem             Size  Used Avail Use% Mounted on
> > /dev/mapper/luks-root  825G  390G  433G  48% /
> > =======================================================================
> >
> > > In theory it should be enough to unmount then remount the file system;
> > > of course for sysroot that'd be a reboot.
> >
> > OK, I'll try a reboot next time.
> >
> > > There may be certain workloads that encourage it, that could be worked
> > > around temporarily using mount option metadata_ratio=1.
> >
> > I'll do that after it happens again, to see if this was a one-off or
> > happens regularily. The file system is rather new (created Dec 14) and
> > apart from spinning up some libvirt VMs (but no snapshots involved) the
> > workload is a mix of web browsing and compiling things, no nothing too
> > fancy.
>
> A less janky option is to use 5.3.18, or grab 5.5.0-rc6 from koji.
> I've been using 5.5.0 for a while for other reasons (i915 gotchas),
> and the one Btrfs bug I ran into related to compression has been fixed
> as of rc5.
>
> https://koji.fedoraproject.org/koji/buildinfo?buildID=1428886
>

This is the latest patchset as of about a week ago, and actually I'm
not seeing it in 5.5rc6. A tested fix may not be ready yet.
https://patchwork.kernel.org/project/linux-btrfs/list/?series=223921

Your best bet is likely to stick with 5.4.10 and just use mount option
metadata_ratio=1. This won't cause some other weird thing to happen.
It'll just ask Btrfs to allocate a metadata block group each time a
data block group is created, or approximately 256M metadata BG for
each 1G data BG. And also it's useful to know if that doesn't help. I
myself haven't run into this bug or I'd try it.


-- 
Chris Murphy
