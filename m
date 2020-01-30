Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39CA914E3CF
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 21:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgA3US7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 15:18:59 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55835 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgA3US7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 15:18:59 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so5219369wmj.5
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jan 2020 12:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BsxZfCZO2KY6hYRjtxlhR6RadPtS7akT+jP0xgxU6SM=;
        b=HAlm3bS7LYXCFk+MPAYgPDKasA7eqkOiKCRdaIH6IT5vmb2yuRhkP0RuuOXjk+w4am
         Kp2m6nJyjevXhCsz8twh2wvei/NIYqTwwf7t5xA7vls/CDuC1ke2AS3MD/saw5RxGRj4
         IbGzLo4rogGSxKgjXnG2XRKNpZuZbN8+6rlsD2akvr87vfwyhL4Ph5RmuAhOfa8i0vNR
         1qxqvx8jUuymvFKcfLVMac1PYt24eWF+KJObGxEdW+YYTta5meRICsHI0n0O4VeEuDZO
         zldTOiK2qsr3sFBA6HPcTk6IEShtLHO87vwA+2aPob+0cJCYfyh9MFUjmQkGmHXulwXM
         yw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BsxZfCZO2KY6hYRjtxlhR6RadPtS7akT+jP0xgxU6SM=;
        b=R/45QThCt8ximl8bGVEclx++bHtjpRgDKEm427JKTFe86YzGF8b0n+GZLYkUeea0q5
         DxunJgZbu8xQVq6t7UAzRgOJNKZnxs1w8mmQs+MQ5zA32jSUyJXTQGwu77h9dolyTmEX
         r+SjSUZNSxmAQnBiFSfAEngCX4DF8wCG8M828ftCuw5vE2uXrGrz6aGmj2LkocZWCm3l
         nRvsylUMoETSlCtZZo44nSLCmqhvbePNmNi7iFL7fksTGD0GZp6PuGXE4d+AIXfqAO4d
         /i/BSaXSEmUC9P6dYHMyMdcd1aYcQa49fF/3MyvJj7W73/VF/hAWXCNIofmqtXdx/luD
         pNpA==
X-Gm-Message-State: APjAAAV6fg9HNc93JpieyLzg4yMcIM/1ZT7BKN84mZUE2W1OaFCQrLFw
        zrELZTgy6/3YEBKcdiwzoejV/uI3XXvrc7mqzxaiEw==
X-Google-Smtp-Source: APXvYqzAp6YHpzVxPy9blzNVoHC1uWxEIj5t9aEGjEUrqVYs2nf2NWto1ovE5+oQ0355+9h8gQzWqc6tDD41l9zNUts=
X-Received: by 2002:a05:600c:20f:: with SMTP id 15mr7270527wmi.128.1580415537384;
 Thu, 30 Jan 2020 12:18:57 -0800 (PST)
MIME-Version: 1.0
References: <112911984.cFFYNXyRg4@merkaba> <10361507.xcyXs1b6NT@merkaba>
 <CAJCQCtQgqg2u78q2vZi=bEy+bkzX48M+vHXR00dsuNYWaxqRKg@mail.gmail.com> <21104414.nfYVoVUMY0@merkaba>
In-Reply-To: <21104414.nfYVoVUMY0@merkaba>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 30 Jan 2020 13:18:41 -0700
Message-ID: <CAJCQCtSgK1f3eG5XzaHmV+_xAgPFhAGvnyxuUOmGRMCZfKaErw@mail.gmail.com>
Subject: Re: With Linux 5.5: Filesystem full while still 90 GiB free
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Martin Raiber <martin@urbackup.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 30, 2020 at 1:02 PM Martin Steigerwald <martin@lichtvoll.de> wrote:
>
> Chris Murphy - 30.01.20, 17:37:42 CET:
> > On Thu, Jan 30, 2020 at 3:41 AM Martin Steigerwald
> <martin@lichtvoll.de> wrote:
> > > Chris Murphy - 29.01.20, 23:55:06 CET:
> > > > On Wed, Jan 29, 2020 at 2:20 PM Martin Steigerwald
> > >
> > > <martin@lichtvoll.de> wrote:
> > > > > So if its just a cosmetic issue then I can wait for the patch to
> > > > > land in linux-stable. Or does it still need testing?
> > > >
> > > > I'm not seeing it in linux-next. A reasonable short term work
> > > > around
> > > > is mount option 'metadata_ratio=1' and that's what needs more
> > > > testing, because it seems decently likely mortal users will need
> > > > an easy work around until a fix gets backported to stable. And
> > > > that's gonna be a while, me thinks.
> > > >
> > > > Is that mount option sufficient? Or does it take a filtered
> > > > balance?
> > > > What's the most minimal balance needed? I'm hoping -dlimit=1
> > >
> > > Does not make a difference. I did:
> > >
> > > - mount -o remount,metadata_ratio=1 /daten
> > > - touch /daten/somefile
> > > - dd if=/dev/zero of=/daten/someotherfile bs=1M count=500
> > > - sync
> > > - df still reporting zero space free
> > >
> > > > I can't figure out a way to trigger this though, otherwise I'd be
> > > > doing more testing.
> > >
> > > Sure.
> > >
> > > I am doing the balance -dlimit=1 thing next. With metadata_ratio=0
> > > again.
> > >
> > > % btrfs balance start -dlimit=1 /daten
> > > Done, had to relocate 1 out of 312 chunks
> > >
> > > % LANG=en df -hT /daten
> > > Filesystem             Type   Size  Used Avail Use% Mounted on
> > > /dev/mapper/sata-daten btrfs  400G  311G     0 100% /daten
> > >
> > > Okay, doing with metadata_ratio=1:
> > >
> > > % mount -o remount,metadata_ratio=1 /daten
> > >
> > > % btrfs balance start -dlimit=1 /daten
> > > Done, had to relocate 1 out of 312 chunks
> > >
> > > % LANG=en df -hT /daten
> > > Filesystem             Type   Size  Used Avail Use% Mounted on
> > > /dev/mapper/sata-daten btrfs  400G  311G     0 100% /daten
> > >
> > >
> > > Okay, other suggestions? I'd like to avoid shuffling 311 GiB data
> > > around using a full balance.
> >
> > There's earlier anecdotal evidence that -dlimit=10 will work. But you
> > can just keep using -dlimit=1 and it'll balance a different block
> > group each time (you can confirm/deny this with the block group
> > address and extent count in dmesg for each balance). Count how many it
> > takes to get df to stop misreporting. It may be a file system
> > specific value.
>
> Lost the patience after 25 attempts:
>
> date; let I=I+1; echo "Balance $I"; btrfs balance start -dlimit=1 /daten
> ; LANG=en df -hT /daten
> Do 30. Jan 20:59:17 CET 2020
> Balance 25
> Done, had to relocate 1 out of 312 chunks
> Filesystem             Type   Size  Used Avail Use% Mounted on
> /dev/mapper/sata-daten btrfs  400G  311G     0 100% /daten
>
>
> Doing the -dlimit=10 balance now:
>
> % btrfs balance start -dlimit=10 /daten ; LANG=en df -hT /daten
> Done, had to relocate 10 out of 312 chunks
> Filesystem             Type   Size  Used Avail Use% Mounted on
> /dev/mapper/sata-daten btrfs  400G  311G     0 100% /daten
>
> Okay, enough of balancing for today.
>
> I bet I just wait for a proper fix, instead of needlessly shuffling data
> around.

What about unmounting and remounting?

There is a proposed patch that David referenced in this thread, but
it's looking like it papers over the real problem. But even if so,
that'd get your file system working sooner than a proper fix, which I
think (?) needs to be demonstrated to at least cause no new
regressions in 5.6, before it'll be backported to stable.


-- 
Chris Murphy
