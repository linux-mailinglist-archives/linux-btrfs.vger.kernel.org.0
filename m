Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2150131588C
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Feb 2021 22:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbhBIVWP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Feb 2021 16:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbhBIUj1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Feb 2021 15:39:27 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AE7C0698CD
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Feb 2021 12:26:58 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id n6so10804785wrv.8
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Feb 2021 12:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t887Mrotcb3azIiQkBBxJS1vSfb2K9dq1H7ePy38UN0=;
        b=uoUosk2w1pNeB5fM/MOReVWLi2LyreheTlO8EVkaHT/Ub+4u3tgcB9f8IM66CdlkcL
         yU06eBOZ4gOOOOUsIf975eFIgwgnjleKTHQRe7Sa8NWnC9m9qpjlvfd9SjAQtN8HvPVZ
         NtFDANlrLBzL5SKcdAQd1YHYIRRJ1uK48dn8nyL3S/l+BYH2HdJ7O/qNxMuZoWJmHuIA
         Q7aPXIVczMx10WuELYmcsHcF3hU2qbwPZ8ChfsXI8aTp/lUJZ6KFaCsNsUTRZRXtQ19t
         OUzMf8wPh+xRDbhxrVmHjwSX5APbHL7p34hH9XDuS2SnYeD978uOZHQBtgJudBLvSGEV
         RO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t887Mrotcb3azIiQkBBxJS1vSfb2K9dq1H7ePy38UN0=;
        b=BSlWFH73oQANIi/biHmj2d+oCQpRkht/B59rBGebYAOHEACKbS6O2GBP8KnpKUab+W
         tMmWWLnO6VK96TCpFgESdgZO5IzizzQJXcRvHNA4wcuEF4qlIV/+R74oUpAc+mWZpUct
         8mbluH94ttejo3uJxZGqFH/7Ovid+XdaBtq2TT+pjkYtWOp0ntNKF4ICT/4dA8qdVCRP
         SHyC/dYs6l5k5TQgHfYJU2gJuTzk/cx1Lg/HBQqa743DjRHc2vG6pN1U0sVF+K3sYEcy
         X0whWBBn3s+sZWb41Iqoa0141qjSwWTQZ3iGqTF7XHUtcQy6VTyJMTh6lVU4HR8zSC1W
         /ZfQ==
X-Gm-Message-State: AOAM531U7gXJ2r3AbALXmuyIABsvDMnU8dSOzT2XuVBGCWMsNL7VZehO
        7z3ShHL3XTSSiTwxjBY8d9tR9xNcV9t+bGWf/ETTxA==
X-Google-Smtp-Source: ABdhPJxImYFpAbXJVUijcnhhUBsSYPBqWnUkJnWOsrSZRIplxXRkp/vnpY5Bv1C3Et8q8yU+Lgs8YSNQ2y/ApamFMHo=
X-Received: by 2002:adf:ec52:: with SMTP id w18mr27202551wrn.65.1612902416959;
 Tue, 09 Feb 2021 12:26:56 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSx=HcCRMiE0eganPWJVTB+b4zfb_mnd68L2VapGGKi7Q@mail.gmail.com>
 <3897f126-e977-d842-f91d-b48b74958f3d@libero.it> <CAJCQCtScUYMoMpw==HTbBB6s0BFnXuT=MvSuVJYEVBrA7-RbHA@mail.gmail.com>
 <839d9baa-8df5-7efd-94ee-b28f282ef9ec@inwind.it> <CAJCQCtSqESuYawuh6E8b6Xd=z4D13J2=v-6rn8+0mwuThXNtkg@mail.gmail.com>
 <7650c455-297a-f746-c59e-3104fdbf8896@inwind.it>
In-Reply-To: <7650c455-297a-f746-c59e-3104fdbf8896@inwind.it>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 9 Feb 2021 13:26:40 -0700
Message-ID: <CAJCQCtR1fCSFYYbo7YvDPTmhALNvUyZB5C4zfMsUH-iU0xs6zQ@mail.gmail.com>
Subject: Re: is BTRFS_IOC_DEFRAG behavior optimal?
To:     Goffredo Baroncelli <kreijack@inwind.it>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 9, 2021 at 12:45 PM Goffredo Baroncelli <kreijack@inwind.it> wrote:
>
> On 2/9/21 8:01 PM, Chris Murphy wrote:
> > On Tue, Feb 9, 2021 at 11:13 AM Goffredo Baroncelli <kreijack@inwind.it> wrote:
> >>
> >> On 2/9/21 1:42 AM, Chris Murphy wrote:
> >>> Perhaps. Attach strace to journald before --rotate, and then --rotate
> >>>
> >>> https://pastebin.com/UGihfCG9
> >>
> >> I looked to this strace.
> >>
> >> in line 115: it is called a ioctl(<BTRFS-DEFRAG>)
> >> in line 123: it is called a ioctl(<BTRFS-DEFRAG>)
> >>
> >> However the two descriptors for which the defrag is invoked are never sync-ed before.
> >>
> >> I was expecting is to see a sync (flush the data on the platters) and then a
> >> ioctl(<BTRFS-defrag>. This doesn't seems to be looking from the strace.
> >>
> >> I wrote a script (see below) which basically:
> >> - create a fragmented file
> >> - run filefrag on it
> >> - optionally sync the file             <-----
> >> - run btrfs fi defrag on it
> >> - run filefrag on it
> >>
> >> If I don't perform the sync, the defrag is ineffective. But if I sync the
> >> file BEFORE doing the defrag, I got only one extent.
> >> Now my hypothesis is: the journal log files are bad de-fragmented because these
> >> are not sync-ed before.
> >> This could be tested quite easily putting an fsync() before the
> >> ioctl(<BTRFS_DEFRAG>).
> >>
> >> Any thought ?
> >
> > No idea. If it's a full sync then it could be expensive on either
> > slower devices or heavier workloads. On the one hand, there's no point
> > of doing an ineffective defrag so maybe the defrag ioctl should  just
> > do the sync first? On the other hand, this would effectively make the
> > defrag ioctl a full file system sync which might be unexpected. It's a
> > set of tradeoffs and I don't know what the expectation is.
> >
> > What about fdatasync() on the journal file rather than a full sync?
>
> I tried a fsync(2) call, and the results is the same.
> Only after reading your reply I realized that I used a sync(2), when
> I meant to use fsync(2).
>
> I update my python test code

Ok fsync should be least costly of the three.

The three unique things about systemd-journald that might be factors:

* nodatacow file
* fallocated file in 8MB increments multiple times up to 128M
* BTRFS_IOC_DEFRAG, whereas btrfs-progs uses BTRFS_IOC_DEFRAG_RANGE

So maybe it's all explained by lack of fsync, I'm not sure. But the
commit that added this doesn't show any form of sync.

https://github.com/systemd/systemd/commit/f27a386430cc7a27ebd06899d93310fb3bd4cee7



-- 
Chris Murphy
