Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACC5312AE51
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Dec 2019 20:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfLZTie (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Dec 2019 14:38:34 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:32986 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfLZTie (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Dec 2019 14:38:34 -0500
Received: by mail-ot1-f66.google.com with SMTP id b18so11714789otp.0
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Dec 2019 11:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F2Ob/4H0ArBKHr7eZk4vjxKC50JohA2X/dkB3lP3I2Y=;
        b=Ne+QXh5MJILzzTZ5J4LGykcAoGN85sQnCCenk56NMoQCHdmusGRJtgizvTWfa+YrvD
         Brk2PMnyVZaV5f+dTPfjP6WWSn/Dc/1iNmRDv3HFAx2RlUqMTeEE+wbCGgrM1MuPYrnz
         lI7m7GJfnL3Djcdu78grbtXZEB0QHk0u0MpC9f6aRvO71yrqYMUM1jIYUO/2xOB6D8pM
         +LG1ml74gNtUSu+uoXhPmmB60ofH5RckLwnPTv5UWgl4NviRyV6xb0BRq7ttNLz4MEbb
         7rfyxAYgmF8+oTIytZZIB4tFOM3BEUlIJ/hZCGGppc9VpPx5WpNjubB02mst7AuXSLMw
         GN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F2Ob/4H0ArBKHr7eZk4vjxKC50JohA2X/dkB3lP3I2Y=;
        b=G1eovKvaCgZHlBBJsm79uyS9LnYd6/fOx72TK1afbGWljOKVaeMlXtg5lY6eTW3ySt
         M1JILXfFJgu54ZqaY2i9a0zIINTBCXFW2gb1q+vmKyEZoBJOwL4pEczrj0ycQDqQKPWX
         1Rb+0VGJW7uKKQqyEVPoVmuBNTsOKqhdKT3wFJsWtpQFXBq7jFfF8AEhzAPIjzitw7Oh
         bzCy8svZ7uWNdZZgAKMA6gbZa5DtfmEQYMObvvd/nuj4OMSTl9CsIdsc+z960rpp0Z7q
         lJK8QO4dIIWl5J9C+v/7zDpvyU5ngsxzsbl/DlmEO9/6/Tu6/wSLHQdW2cQ6HjD1wn2x
         t8LA==
X-Gm-Message-State: APjAAAWpfRMMgpiA4TOhvcH+sdVxUxgkkQs+jjHqpKxoD4BWrgy9JrGM
        QY4OZOyiSUeFEJHc5gdO5GfdJDzhcH5I7e3G3g1PUbjn
X-Google-Smtp-Source: APXvYqzBvkxkmSQFBN7yoSaS5w63AdI1Mp5yyHvHB8nGm+3i483R7KziH8qPg6/dBTEj95g17W1VcJwcBnFhBjAIePQ=
X-Received: by 2002:a9d:6f0a:: with SMTP id n10mr54051744otq.54.1577389112646;
 Thu, 26 Dec 2019 11:38:32 -0800 (PST)
MIME-Version: 1.0
References: <CAHs_hg00v9zmMAXp7E=7Xe_ZD5kgB2tVBOFCt5UQuJRp+yESAg@mail.gmail.com>
 <3826413f-f81d-de13-8437-4e5b762d812f@gmx.com> <20191226054058.GC13306@hungrycats.org>
 <50661176-b04c-882b-d87c-ee5c0395c3f6@gmx.com>
In-Reply-To: <50661176-b04c-882b-d87c-ee5c0395c3f6@gmx.com>
From:   Martin <mbakiev@gmail.com>
Date:   Thu, 26 Dec 2019 14:37:56 -0500
Message-ID: <CAHs_hg3RNROnHc9--RDeBfJSwN6Lx4qRfoi0ZNf2Bi3+4LSksQ@mail.gmail.com>
Subject: Re: Deleting a failing drive from RAID6 fails
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I appreciate the replies, and as a general update I ended up cleaning
out large amount of unneeded files, hoping the corruption would be in
one of those and retried the device deletion - it completed
successfully.
Not really sure why the files were ever unrecoverably corrupted - the
system has never crashed or lost power since this filesystem was
created.
It's a Fedora server and somewhat regularly updated, and this btrfs FS
was created about 2 years ago maybe - not really sure which kernel
version, but most recently running kernel 5.3.16 when I noticed the
hard drive failing. Not really sure when it first started having
problems.

Thanks,
Martin

On Thu, Dec 26, 2019 at 1:50 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/12/26 =E4=B8=8B=E5=8D=881:40, Zygo Blaxell wrote:
> > On Thu, Dec 26, 2019 at 01:03:47PM +0800, Qu Wenruo wrote:
> >>
> >>
> >> On 2019/12/26 =E4=B8=8A=E5=8D=883:25, Martin wrote:
> >>> Hi,
> >>>
> >>> I have a drive that started failing (uncorrectable errors & lots of
> >>> relocated sectors) in a RAID6 (12 device/70TB total with 30TB of
> >>> data), btrfs scrub started showing corrected errors as well (seemingl=
y
> >>> no big deal since its RAID6). I decided to remove the drive from the
> >>> array with:
> >>>     btrfs device delete /dev/sdg /mount_point
> >>>
> >>> After about 20 hours and having rebalanced 90% of the data off the
> >>> drive, the operation failed with an I/O error. dmesg was showing csum
> >>> errors:
> >>>     BTRFS warning (device sdf): csum failed root -9 ino 2526 off
> >>> 10673848320 csum 0x8941f998 expected csum 0x253c8e4b mirror 2
> >>>     BTRFS warning (device sdf): csum failed root -9 ino 2526 off
> >>> 10673852416 csum 0x8941f998 expected csum 0x8a9a53fe mirror 2
> >>>     . . .
> >>
> >> This means some data reloc tree had csum mismatch.
> >> The strange part is, we shouldn't hit csum error here, as if it's some
> >> data corrupted, it should report csum error at read time, other than
> >> reporting the error at this timing.
> >>
> >> This looks like something reported before.
> >>
> >>>
> >>> I pulled the drive out of the system and attempted the device deletio=
n
> >>> again, but getting the same error.
> >>>
> >>> Looking back through the logs to the previous scrubs, it showed the
> >>> file paths where errors were detected, so I deleted those files, and
> >>> tried removing the failing drive again. It moved along some more. Now
> >>> its down to only 13GiB of data remaining on the missing drive. Is
> >>> there any way to track the above errors to specific files so I can
> >>> delete them and finish the removal. Is there is a better way to finis=
h
> >>> the device deletion?
> >>
> >> As the message shows, it's the data reloc tree, which store the newly
> >> relocated data.
> >> So it doesn't contain the file path.
> >>
> >>>
> >>> Scrubbing with the device missing just racks up uncorrectable errors
> >>> right off the bat, so it seemingly doesn't like missing a device - I
> >>> assume it's not actually doing anything useful, right?
> >>
> >> Which kernel are you using?
> >>
> >> IIRC older kernel doesn't retry all possible device combinations, thus
> >> it can report uncorrectable errors even if it should be correctable.
> >
> >> Another possible cause is write-hole, which reduced the tolerance of
> >> RAID6 stripes by stripes.
> >
> > Did you find a fix for
> >
> >       https://www.spinics.net/lists/linux-btrfs/msg94634.html
> >
> > If that bug is happening in this case, it can abort a device delete
> > on raid5/6 due to corrupted data every few block groups.
>
> My bad, always lost my track of to-do works.
>
> It looks like one possible cause indeed.
>
> Thanks for reminding me that bug,
> Qu
>
> >
> >> You can also try replace the missing device.
> >> In that case, it doesn't go through the regular relocation path, but d=
ev
> >> replace path (more like scrub), but you need physical access then.
> >>
> >> Thanks,
> >> Qu
> >>
> >>>
> >>> I'm currently traveling and away from the system physically. Is there
> >>> any way to complete the device removal without reconnecting the
> >>> failing drive? Otherwise, I'll have a replacement drive in a couple o=
f
> >>> weeks when I'm back, and can try anything involving reconnecting the
> >>> drive.
> >>>
> >>> Thanks,
> >>> Martin
> >>>
> >>
> >
> >
> >
>
