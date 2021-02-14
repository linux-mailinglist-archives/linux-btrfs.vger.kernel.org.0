Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE5E31B37F
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Feb 2021 00:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhBNXwr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Feb 2021 18:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhBNXwo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Feb 2021 18:52:44 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91052C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Feb 2021 15:52:04 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id u14so7070631wri.3
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Feb 2021 15:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P64PCaIuzAeOyFCTtQV6gYFxqIYFkvxMPdTlMMc4Cdw=;
        b=WfZTO1FJ9Uv0FdxhNDB6SQlKAwzjTUttyEux+7/kzxp6obtA4pXmbdben7gSHotv9D
         hdA2D3CxVbJT1247kQZZaTj0aFQFN4pN575ePNiQ+cpwgsoFfumZilutVx8/pmyrUFS4
         vUOzbf67zp5+l4ZouG/792+LnI/fZQlU5YNRxUjPzHbgA9Gjid3jLZtj3OagRrUVT1sZ
         b7x0oEjTfvpwQMHPFFsm8wBodtgDlreRjz0/d6xVqTBtGefu2t6f0VHxbP9t2nJ+1ATg
         4hDhSEFHr456Z06Wl8ueNrB77NeWMumdar9lwfWN23n5odF+ep5vwXBq/7W5GdbtdT8Y
         ZsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P64PCaIuzAeOyFCTtQV6gYFxqIYFkvxMPdTlMMc4Cdw=;
        b=kG/JH2RDKPKA7gSsjmV+TPX08jsTxRBnoCp8tMmuYvoSt5eLOnGk71Vr4iRz0b6SsW
         ghpnHNJD+pThr2XJX/kXq02fyrr56kRHRv2kHLawmjus8tscfwQLA3zoozVZEShPHxl5
         Vd3/IXXiBc9xRR81EHb44i8YFrhNDe9pTQJhJkBYi3GPUeeUFURO+RX70GTP/xYqgbgq
         qdStcAN7n4Lefod4+JRQBqaJ4Pp02Gp/HK3fRzIk/pp+ESxH6uDRSXo6xW9kgPPXNN74
         jyV7QygHAIabbSMBHFqFWLyLZKbhk1sQycpzIrn/lRhzmyoD2/rCb9oPR8SNF/rlE7Nr
         PC0w==
X-Gm-Message-State: AOAM531tsM99aVnX79E0yMeMqX+xccHpFrDBolzT22+NYJC5rP7B1Plq
        Ot/wiDiFd2ysQB9E3oW9G/OKo/tXIobTyKuUUwCccA==
X-Google-Smtp-Source: ABdhPJxtJfz6CBE6ARI6J/sdFB9drewV8mOelg8HKAp7r15u7Gh6W1aFCWEQ5LUoQjiNIALE6sw6Cr/SJnVFANB/t0Q=
X-Received: by 2002:adf:f0ce:: with SMTP id x14mr2204126wro.252.1613346723117;
 Sun, 14 Feb 2021 15:52:03 -0800 (PST)
MIME-Version: 1.0
References: <CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com>
 <CAJCQCtRhxUx3R5_VgWGN0hvpJ=ET6j4Wr73Ph0jKWcCizA=CgQ@mail.gmail.com> <CAEg-Je_Yu3NVyaT7EDBHaQsLJZfL7he5bzri3HbgaDoYKFKKDQ@mail.gmail.com>
In-Reply-To: <CAEg-Je_Yu3NVyaT7EDBHaQsLJZfL7he5bzri3HbgaDoYKFKKDQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 14 Feb 2021 16:51:46 -0700
Message-ID: <CAJCQCtTZs5Ygym4W1M6RPaz7BaxSEysYpSQiUOcc3OyxBKbbLw@mail.gmail.com>
Subject: Re: Recovering Btrfs from a freak failure of the disk controller
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Feb 14, 2021 at 4:24 PM Neal Gompa <ngompa13@gmail.com> wrote:
>
> On Sun, Feb 14, 2021 at 5:11 PM Chris Murphy <lists@colorremedies.com> wrote:
> >
> > On Sun, Feb 14, 2021 at 1:29 PM Neal Gompa <ngompa13@gmail.com> wrote:
> > >
> > > Hey all,
> > >
> > > So one of my main computers recently had a disk controller failure
> > > that caused my machine to freeze. After rebooting, Btrfs refuses to
> > > mount. I tried to do a mount and the following errors show up in the
> > > journal:
> > >
> > > > Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3): disk space caching is enabled
> > > > Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3): has skinny extents
> > > > Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sda3): corrupt leaf: root=401 block=796082176 slot=15 ino=203657, invalid inode transid: has 888896 expect [0, 888895]
> > > > Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): block=796082176 read time tree block corruption detected
> > > > Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sda3): corrupt leaf: root=401 block=796082176 slot=15 ino=203657, invalid inode transid: has 888896 expect [0, 888895]
> > > > Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): block=796082176 read time tree block corruption detected
> > > > Feb 14 15:20:49 localhost-live kernel: BTRFS warning (device sda3): couldn't read tree root
> > > > Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): open_ctree failed
> > >
> > > I've tried to do -o recovery,ro mount and get the same issue. I can't
> > > seem to find any reasonably good information on how to do recovery in
> > > this scenario, even to just recover enough to copy data off.
> > >
> > > I'm on Fedora 33, the system was on Linux kernel version 5.9.16 and
> > > the Fedora 33 live ISO I'm using has Linux kernel version 5.10.14. I'm
> > > using btrfs-progs v5.10.
> >
> > Oh and also that block:
> >
> > btrfs insp dump-t -b 796082176 /dev/sda3
> >
>
> So, I've attached the output of the dump-s and dump-t commands.
>
> As for the other commands:
>
> # btrfs check --readonly /dev/sda3
> > Opening filesystem to check...
> > parent transid verify failed on 796082176 wanted 888894 found 888896

Not good. So three different transids in play.

Super says generation 888894

Leaf block says its generation is 888896, and two inodes have transid
888896 including the one the tree checker is complaining about.
Somehow the super has an older generation than both what's in the leaf
and what's expected.




> > parent transid verify failed on 796082176 wanted 888894 found 888896
> > parent transid verify failed on 796082176 wanted 888894 found 888896
> > Ignoring transid failure
> > ERROR: could not setup extent tree
> > ERROR: cannot open file system
>
> # mount -o ro,rescue=all /dev/sda3 /mnt
> > mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sda3, missing codepage or helper program, or other error.

Do you get the same kernel messages as originally reported? Or
something different?



-- 
Chris Murphy
