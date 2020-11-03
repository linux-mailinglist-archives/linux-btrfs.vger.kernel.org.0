Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532032A59D6
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 23:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbgKCWNU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 17:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729828AbgKCWNS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Nov 2020 17:13:18 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E045FC061A04
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Nov 2020 14:13:17 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id j7so19994264oie.12
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Nov 2020 14:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ubZCQN0z5OCZOkn8D+XOK0MPv6Ks03+bhCl6JxJrkdQ=;
        b=NW1Hp68+sDp78R3m3jNPRoU+XCAgABGe0szB0cjLPhnPPlE94gx2smC2MLBP375B7S
         Z+cKC64Tj5moalJa0IofqQJBGPB9Q9WbSgiZpbQ5cguwvlkmy/EVNtAZE8vf3ZLu58TB
         BcGsjQpm+nyL7KHHFlPVmuctc3Sd8xGt2PhGo1IMQUYaMLQR6SI1IUpT9SY7LUrjH600
         ggS2R/ghPgltE9Tc2cpVBfJ6HixUEUUaqrSGH/uqcYAxfgSXFCbSw/VvqusNKsn33MJU
         tfraBi0TsTnNLyY4xKHs1aC89M/ctWEHcIWx+BMjx4fNu0DOoEPqXeAjocqXaVVvUipU
         2u1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ubZCQN0z5OCZOkn8D+XOK0MPv6Ks03+bhCl6JxJrkdQ=;
        b=d+hMOFVIIvgH1ieSQohzCX8K35+YugvOkp7pcYh+Wnyc7dwLsuAsMtT3UJs7ywnwgK
         URyxmkkUFepx7e4goyUk9bRn6u1IJ3H0cP/wlB516/cKJ5bfl29ts1iN/mRrTsvLsx0n
         9M75JOLU3Ox/uhZUU0z7GjUkS6izRGO8pXvl8VUMr1zqBJyc9MTIzZ1K8exw+RA2sr2k
         BhnMt/ID74CT/8yR75SxnEvYc73cjvghiwXOorYqHN66jlMSZWfaZileUFb3BqP0zz5K
         eJ3OVzE25MXN8flIKBx2qD/MakYIUk2fej81ckAJo7i7bVu7Dv/5m/7B6+1Q0LTKFYVR
         6Hfw==
X-Gm-Message-State: AOAM532SWqUEjJvVSfsTGePQcTKu+3tk2/kRnybWpeSAK1IDQJ+HJ8M+
        n1EeAqU6hA7Pi2p5jgrO310+Va3clOuzEZyBWMNgdydtpxE=
X-Google-Smtp-Source: ABdhPJzXIwv4VArTtAMJl8dGt2i8icFnpNOiMi18nxWZoqaYD/lEa3ldxnFngYkhUV0EIs5Jwy3OANJwcVBYHtZiJx8=
X-Received: by 2002:aca:2111:: with SMTP id 17mr787549oiz.139.1604441597196;
 Tue, 03 Nov 2020 14:13:17 -0800 (PST)
MIME-Version: 1.0
References: <em2ffec6ef-fe64-4239-b238-ae962d1826f6@ryzen> <20201021134635.GT5890@hungrycats.org>
 <em85884e42-e959-40f1-9eae-cd818450c26d@ryzen> <20201021193246.GE21815@hungrycats.org>
 <em33511ef4-7da1-4e7c-8b0c-8b8d7043164c@desktop-g0r648m> <20201021212229.GF21815@hungrycats.org>
 <emeabab400-3f6d-4105-a4fd-67b0b832f97a@desktop-g0r648m> <20201021213854.GG21815@hungrycats.org>
 <em26d5dfe8-37cb-454c-9c03-a69cfb035949@desktop-g0r648m> <emf9252c3e-00b0-4c4a-a607-b61df779742f@desktop-g0r648m>
 <20201103194045.GB28049@hungrycats.org> <em37950c9c-2dbf-41b9-89cd-2390bc503bd1@desktop-g0r648m>
In-Reply-To: <em37950c9c-2dbf-41b9-89cd-2390bc503bd1@desktop-g0r648m>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Tue, 3 Nov 2020 14:13:05 -0800
Message-ID: <CAE1WUT7_P=mEfOni5BUsc8Qyo88TdK9KZCzGQEuuv9kQygEEuQ@mail.gmail.com>
Subject: Re: Re[2]: parent transid verify failed: Fixed but re-appearing
To:     Hendrik Friedel <hendrik@friedels.name>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        lakshmipathi.ganapathi@collabora.com,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 3, 2020 at 2:09 PM Hendrik Friedel <hendrik@friedels.name> wrote:
>
> Hello Zygo, hello Lakshmipathi,
>
> @Lakshmipathi: as you suggested I consulted the BTRFS-Mailing list on
> this issue:
> https://github.com/Lakshmipathi/dduper/issues/39
>
> Zygo was so kind to help me and he suspects the error to lie within
> dduper.
> >>  > > Sure, more scrubs are better.  They are supposed to be run regularly
> >>  > > to detect drives going bad.
> >>  > btrfs scrub start -Bd /dev/sda1
> >>  >
> >>  >
> >>  > scrub device /dev/sda1 (id 1) done
> >>  >         scrub started at Wed Oct 21 23:38:36 2020 and finished after 13:45:29
> >>  >         total bytes scrubbed: 6.56TiB with 0 errors
> >>  >
> >>  > But then again:
> >>  > dduper --device /dev/sda1 --dir /srv/dev-disk-by-label-DataPool1/dduper_test/testfiles -r --dry-run
> >>  > parent transid verify failed on 16500741947392 wanted 358407 found 358409
> >>  > Ignoring transid failure
> >
> >Wait...is that the kernel log, or the output of the dduper command?
> >
> It is on the commandline once I run the command; thus I suspect it is
> the dduper output. But of course sometimes the Kernel-Messages appear
> directly on the commandline. I do not know how to tell.

Kernel logs would be on dmesg. Check the entries against your current dmesg.

>
> >
> >commit 3e5f67f45b553045a34113cafb3c22180210a19f (tag: v0.04, origin/dockerbuild)
> >Author: Lakshmipathi <lakshmipathi.ganapathi@collabora.com>
> >Date:   Fri Sep 18 11:51:42 2020 +0530
> >
> >file deduper:
> >
> >     194 def btrfs_dump_csum(filename):
> >     195     global device_name
> >     196
> >     197     btrfs_bin = "/usr/sbin/btrfs.static"
> >     198     if os.path.exists(btrfs_bin) is False:
> >     199         btrfs_bin = "btrfs"
> >     200
> >     201     out = subprocess.Popen(
> >     202         [btrfs_bin, 'inspect-internal', 'dump-csum', filename, device_name],
> >     203         stdout=subprocess.PIPE,
> >     204         close_fds=True).stdout.readlines()
> >     205     return out
> >
> >OK there's the problem:  it's dumping csums from a mounted filesystem by
> >reading the block device instead of using the TREE_SEARCH_V2 ioctl.
> >Don't do that, because it won't work.  ;)
> I trust you on this ;-) But I am surprised I am the only one reporting
> this issue. Will it *always* not work, or does it not work in some cases
> and my situation is making it extremely unlikely to work?

It always won't work.

> >
> >The "parent transid verify failed" errors are harmless.  They are due
> >to the fact that a process reading the raw block device can never build
> >an accurate model of a live filesystem that is changing underneathi it.
> >
> >If you manage to get some dedupe to happen, then that's a bonus.
> >
> >
> >>  >
> >>  > > >  Anything else, I can do?
> >>  > >
> >>  > > It looks like sda1 might be bad and it is working by replacing lost
> >>  > > data from the mirror on sdj.  But this replacement should be happening
> >>  > > automatically on read (and definitely on scrub), so you shouldn't ever
> >>  > > see the same error twice, but it seems that you do.
> >>  >
> >>  > Well, it is not the same error twice.
> >
> >Earlier you quoted some duplicate lines.  Normally those get fixed after the
> >first line, so you never see the second.
> >
> I see.
>
> Regards,
> Hendrik
>

Best regards,
Amy Parker
(they/them)
