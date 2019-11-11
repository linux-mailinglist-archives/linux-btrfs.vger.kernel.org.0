Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 308EBF8043
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2019 20:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfKKThp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Nov 2019 14:37:45 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39878 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfKKTho (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Nov 2019 14:37:44 -0500
Received: by mail-wm1-f66.google.com with SMTP id t26so502772wmi.4
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2019 11:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=QIW8r97PydM3zg+QulJcmULK8g50XEHJEstlE2D7FGI=;
        b=mOIStuihsgMysXJsCsu6tCmmKuQLSAnMLU+GTsHagRdxDD5fXNWVOscO3WU08kv8tm
         swubhl23FWQwhoR7XqxzrftxOUd6lEQ6NJzkpBlL9+xfK4+yczMmCRl3JAxNktTfDi0Y
         MstxkfOSks6nhKPAm7vF02teMjNblb0Vu2LAVRJPHlMGXyHQfrYIau12b7wCw2yV4znT
         oQyQ6XKMhAHuzejf54mlvtMusAozhxJbDGACtGDd6K9MrwKpcmB6emXZUTCuPTxoxpfy
         8I5C+8ZXEgWMFkDqaVcpCCsIthZ4SYNJpbWa9rMvPXbRejj+U7UXuYlWYFUXoqoQLoGW
         P8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=QIW8r97PydM3zg+QulJcmULK8g50XEHJEstlE2D7FGI=;
        b=ZEpVtdIsejJEW8oA2cDMpa/DDsy3AkJ7tYvWwPTdviesT6dTePdzdyIGHhLuvcdVUE
         1SA6vBFqcSf7h9gtKA+nLODzCJ/mYBvcFbXNfrqWxuva6d86KcEQLbTGyQrQAPtUp89M
         R5qNx/y4sHpLUWh/uJ9E2Qn9G879OJE59wrwafFtYy9wLtbZEwLdPiwrwfYH3M3br9dS
         o8M7lMxPyjYjCDhAtrUnAF2c8e/hinb2cllTcS39w+VyYNBx0RpjDmbZoKzkYh9lZWEz
         iuP+RQjot9TnYbncqVBqs/K4MV6WRshlY+wg5yX+HMXrQGCKSIEIsl/KTaVGbhLO7ntG
         Lytg==
X-Gm-Message-State: APjAAAXGRxPuZdT0nvTwISSrdwlpVkYuCw9rE7+09USvNBC7UBHNO6g6
        On6cYAReiCtuK62a9XjAPjqUlh9sbF5FyF7TV/7AHIOQoO9Jaw==
X-Google-Smtp-Source: APXvYqyWa8r8nfpxNNXReSiL5jEV62qnJZd9DlRiH/lpFaHw/ZaJUKaEMvaPsRKdWilM7QNjt8FmZz0XkRuE5gueNhg=
X-Received: by 2002:a05:600c:2389:: with SMTP id m9mr550103wma.65.1573501062585;
 Mon, 11 Nov 2019 11:37:42 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtS1v7waFA=ERafSCSCHmPJVytdFZkJLqNTC3U3Gw3Y7tA@mail.gmail.com>
 <d1874d17-700a-d78d-34be-eec0544c9de2@gmail.com> <CAJCQCtTpLTJdRjD7aNJEYXuMO+E65=GiYpKP3Wy5sgOWYs3Hsw@mail.gmail.com>
 <20191104193454.GD3001@twin.jikos.cz>
In-Reply-To: <20191104193454.GD3001@twin.jikos.cz>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 11 Nov 2019 19:37:08 +0000
Message-ID: <CAJCQCtSiDQA4919YDTyQkW7jPkxMds1K32ym=HgO6KHQLzHw+w@mail.gmail.com>
Subject: Re: Does GRUB btrfs support log tree?
To:     David Sterba <dsterba@suse.cz>,
        Chris Murphy <lists@colorremedies.com>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 4, 2019 at 7:34 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Sun, Oct 27, 2019 at 09:05:54PM +0100, Chris Murphy wrote:
> > > > Since log tree writes means a
> > > > full file system update hasn't happened, the old file system state
> > > > hasn't been dereferenced, so even in an SSD + discard case, the system
> > > > should still be bootable. And at that point Btrfs kernel code does log
> > > > replay, and catches the system up, and the next update will boot the
> > > > new state.
> > > >
> > > > Correct?
> > > >
> > >
> > > Yes. If we speak about grub here, it actually tries very hard to ensure
> > > writes has hit disk (it fsyncs files as it writes them and it flushes
> > > raw devices). But I guess that fsync on btrfs just goes into log and
> > > does not force transaction. Is it possible to force transaction on btrfs
> > > from user space?
>
> * sync/syncfs
> * the ioctl BTRFS_IOC_SYNC (calls syncfs)
> * ioctls BTRFS_IOC_START_SYNC + BTRFS_IOC_WAIT_SYNC
>
> > The only fsync I ever see Fedora's grub2-mkconfig do is for grubenv.
> > The grub.cfg is not fsync'd. When I do a strace of grub2-mkconfig,
> > it's so incredibly complicated. Using -ff -o options, I get over 1800
> > separate PID files exported. From what I can tell, it creates a brand
> > new file "grub.cfg.new" and writes to that. Then does a cat from
> > "grub.cfg.new" into "grub.cfg" - maybe it's file system specific
> > behavior, I'm not sure.
> >
> > I'm pretty sure "sync" will do what you want, it calls syncfs() and
> > best as I can tell it does a full file system sync, doesn't use the
> > log tree. I'd argue grub-mkconfig should write all of its files, and
> > then sync that file system, rather than doing any fsync at all.
>
> This would work in most cases. I'm not sure, but the update does not
> seem to be atomic. Ie. all old kernels match the old grub.cfg, or there
> are new kernels that match the new cfg.
>
> Even if there's not fsyncs and just the final sync, some other activity
> in the filesystem can do the sync before between updates of kernels and
> grub.cfg. Like this
>
> start:
>
> - kernel1
> - grub.cfg (v1)
>
> update:
>
> - add kernel2
> - remove kernel1
> - <something calls sync>
> - update grub.cfg (v2)
> - grub calls sync
>
> If the crash happens after sync and before update, kernel1 won't be
> reachable and kernel2 won't be in the grub.cfg.

Right. It's probably a bad practice to remove the fallback kernel,
which would be variably defined depending on the distribution, unless
the method of updating the kernel is atomic by design, proven by
testing.

In the single kernel case it could be done atomically with generic
filenaming, i.e. vmlinuz and initramfs, no versioning in the filename,
and a static bootloader configuration that's never updated, only ever
looks for vmlinuz and initramfs. The update would write out
vmlinuz.new and initramfs.new, and then sync. And then rename()
vmlinuz.new vmlinuz, and initramfs.new initramfs. Since it's two
files, it's not strictly atomic, likely more than one sector changes.
But it might be good enough?

I'm not really sure what the best practice is though. I asked about
this in a UEFI, EFI System partitioning (and thus FAT) context and it
seems like there really aren't any atomicity guarantees possible at
all which is a bit troubling. About the only way to do it is like on
Android with an A and B partition for the kernel and initramfs as
blobs, rather than being stored on file systems, and then indicate A
vs B by setting a partition attribute to indicate to the bootloader A
vs B priority with the other being fallback.

Anyway, the lack of a generic (file system independent) way to handle
this use case is actually a bit concerning.

-- 
Chris Murphy
