Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A00534503B
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Mar 2021 20:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhCVTti (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Mar 2021 15:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhCVTtK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Mar 2021 15:49:10 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B21C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Mar 2021 12:49:08 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id d191so9837022wmd.2
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Mar 2021 12:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OwmniD5P9NXGIYifrYhDThYke8Yt9+5pYMZ9dgOe2N0=;
        b=FiHnffoBb+QZn4ICWN6++vMkfjS+VGjhI89ti0X1dwl1qWSnZBIbkiZYGTgYifX7S7
         1fSDcGU2vLzkDJUK5TEoPspj1SeC8S5Qr1UVyRNe0o1UwlBbS71szfq9XVPyQbRicVno
         W0jfwVYVjvvN/01W31rVr/8i9WRzyIX7VcHygW+gjZ8S5l00gVCCw5hSPcWQngcKJl8b
         Z6NUQzpW9FXSqYWB6sdoMukqs01KsXft2KBNNnlpM3fUs+8DfzyoUkimYT5lrfOBjnDx
         1ut98YGwBHEDTmBWMCwhqAiOloENrisa/+b74H+xqeV8dvhp/EmONi+0xhN2GfmrxfQA
         5MKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OwmniD5P9NXGIYifrYhDThYke8Yt9+5pYMZ9dgOe2N0=;
        b=WCnGL+hk5VhdCuJqgirrxVS0tHKjmfO5Y40U/1nvaFE8XX2VPRORwtliO01LqJ25xE
         smlQPbJvW5oSs7wLldGVQ6vXuhF4dz0apZzObcrT0LGfhjC6Ye7acIaolOeGw4nh/Un7
         CODB2MajtrZRr7YOXrRs/Su9HtSoxTiSijSQnB+p13TdisxJBhMqglyXvwtaY8QHyoL/
         EfZjjur8OEADNkStnEcAkz74EJT3n/XsdRuXvO7l7XlBjYis0akC/VMdvm+AazG6P4M6
         Cf0XSIwDsR426NtAV+nv/dEcvl5P+J2ibiHHKGQaZ5do00DCqlLPEaIELDjZSOzG6fCL
         zJtw==
X-Gm-Message-State: AOAM530k/H/Pn6S0NG9hPh8wa3cVBriny6GSJjntyE7hr1PnCYLWPX/e
        A+ig87SJgbjfpl+YMvKQofxysQtb6vG2HfWACYTo5w==
X-Google-Smtp-Source: ABdhPJwVKDSmh/wlCn+KYGZLp3J+XTt5d7A0InT/e1LBg1sI7zGNhkCaQzneeCagz5hZ1hCSeRAptkNBM+jt6WW3vOQ=
X-Received: by 2002:a1c:7d4e:: with SMTP id y75mr100944wmc.168.1616442547508;
 Mon, 22 Mar 2021 12:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB6JtU54uEOotj=H-DG_7oeUT5KZQG5uM-ibiC2YDbV5Nw@mail.gmail.com>
 <CAJCQCtSBc-Dmks2jdgr-Bcpdh_iLvVevtGOa4LdYgHc2eZE6Hg@mail.gmail.com>
 <CAGdWbB4dN45=4T_WbF7tXmm2UsmF0bh=Lb_z-H=QVQWaW=C=Bw@mail.gmail.com>
 <CAGdWbB61y3CXTbSxe9Rc7ijs9vsLg7qcX4JZ_WpW-73m_1-6_g@mail.gmail.com>
 <CAJCQCtRyhh6AY25+RwikJKk_HUW1xveVxYzGvPpFDdWq618KUg@mail.gmail.com> <CAGdWbB7kCM8DzbS5TzZg=DhsdjTE5nij1SuEnibi3B=OqPBRow@mail.gmail.com>
In-Reply-To: <CAGdWbB7kCM8DzbS5TzZg=DhsdjTE5nij1SuEnibi3B=OqPBRow@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 22 Mar 2021 13:48:50 -0600
Message-ID: <CAJCQCtSNsVkTaZb4Zbz7AeTVUNgxca5hOfaQGHQTUf8DsY-Nrg@mail.gmail.com>
Subject: Re: parent transid verify failed / ERROR: could not setup extent tree
To:     Dave T <davestechshop@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 22, 2021 at 12:32 AM Dave T <davestechshop@gmail.com> wrote:
>
> On Sun, Mar 21, 2021 at 2:03 PM Chris Murphy <lists@colorremedies.com> wrote:
> >
> > On Sat, Mar 20, 2021 at 11:54 PM Dave T <davestechshop@gmail.com> wrote:
> > >
> > > # btrfs check -r 2853787942912 /dev/mapper/xyz
> > > Opening filesystem to check...
> > > parent transid verify failed on 2853787942912 wanted 29436 found 29433
> > > parent transid verify failed on 2853787942912 wanted 29436 found 29433
> > > parent transid verify failed on 2853787942912 wanted 29436 found 29433
> > > Ignoring transid failure
> > > parent transid verify failed on 2853827723264 wanted 29433 found 29435
> > > parent transid verify failed on 2853827723264 wanted 29433 found 29435
> > > parent transid verify failed on 2853827723264 wanted 29433 found 29435
> > > Ignoring transid failure
> > > leaf parent key incorrect 2853827723264
> > > ERROR: could not setup extent tree
> > > ERROR: cannot open file system
> >
> > btrfs insp dump-t -t 2853827723264 /dev/
>
> # btrfs insp dump-t -t 2853827723264 /dev/mapper/xzy
> btrfs-progs v5.11
> parent transid verify failed on 2853827608576 wanted 29436 found 29433
> parent transid verify failed on 2853827608576 wanted 29436 found 29433
> parent transid verify failed on 2853827608576 wanted 29436 found 29433
> Ignoring transid failure
> leaf parent key incorrect 2853827608576
> WARNING: could not setup extent tree, skipping it
> parent transid verify failed on 2853827608576 wanted 29436 found 29433
> Ignoring transid failure
> leaf parent key incorrect 2853827608576
> Couldn't setup device tree
> ERROR: unable to open /dev/mapper/xzy
>
> # btrfs insp dump-t -t 2853787942912 /dev/mapper/xzy
> btrfs-progs v5.11
> parent transid verify failed on 2853827608576 wanted 29436 found 29433
> parent transid verify failed on 2853827608576 wanted 29436 found 29433
> parent transid verify failed on 2853827608576 wanted 29436 found 29433
> Ignoring transid failure
> leaf parent key incorrect 2853827608576
> WARNING: could not setup extent tree, skipping it
> parent transid verify failed on 2853827608576 wanted 29436 found 29433
> Ignoring transid failure
> leaf parent key incorrect 2853827608576
> Couldn't setup device tree
> ERROR: unable to open /dev/mapper/xzy
>
> # btrfs insp dump-t -t 2853827608576 /dev/mapper/xzy
> btrfs-progs v5.11
> parent transid verify failed on 2853827608576 wanted 29436 found 29433
> parent transid verify failed on 2853827608576 wanted 29436 found 29433
> parent transid verify failed on 2853827608576 wanted 29436 found 29433
> Ignoring transid failure
> leaf parent key incorrect 2853827608576
> WARNING: could not setup extent tree, skipping it
> parent transid verify failed on 2853827608576 wanted 29436 found 29433
> Ignoring transid failure
> leaf parent key incorrect 2853827608576
> Couldn't setup device tree
> ERROR: unable to open /dev/mapper/xzy

That does not look promising. I don't know whether a read-write mount
with usebackuproot will recover, or end up with problems.

Options:

a. btrfs check --repair
This probably fails on the same problem, it can't setup the extent tree.

b. btrfs check --init-extent-tree
This is a heavy hammer, it might succeed, but takes a long time. On 5T
it might take double digit hours or even single digit days. It's
generally faster to just wipe the drive and restore from backups than
use init-extent-tree (I understand this *is* your backup).

c. Setup an overlay file on device mapper, to redirect the writes from
a read-write mount with usebackup root. I think it's sufficient to
just mount, optionally write some files (empty or not), and umount.
Then do a btrfs check to see if the current tree is healthy.
https://raid.wiki.kernel.org/index.php/Recovering_a_failed_software_RAID#Making_the_harddisks_read-only_using_an_overlay_file

That guide is a bit complex to deal with many drives with mdadm raid,
so you can simplify it for just one drive. The gist is no writes go to
the drive itself, it's treated as read-only by device-mapper (in fact
you can optionally add a pre-step with the blockdev command and
--setro to make sure the entire drive is read-only; just make sure to
make it rw once you're done testing). All the writes with this overlay
go into a loop mounted file which you intentionally just throw away
after testing.

d. Just skip the testing and try usebackuproot with a read-write
mount. It might make things worse, but at least it's fast to test. If
it messes things up, you'll have to recreate this backup from scratch.

As for how to prevent this? I'm not sure. About the best we can do is
disable the drive write cache with a udev rule, and/or raid1 with
another make/model drive, and let Btrfs detect occasional corruption
and self heal from the good copy. Another obvious way to avoid the
problem is, stop having power failures, crashes, and accidental USB
cable disconnections :)

It's not any one thing that's the problem. It's a sequence of problems
happening in just the right (or wrong) order that causes the problem.
Bugs + mistake + bad luck = problem.

-- 
Chris Murphy
