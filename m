Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B229EDED0B
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 15:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbfJUNDe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 09:03:34 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:37073 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbfJUNDd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 09:03:33 -0400
Received: by mail-ed1-f43.google.com with SMTP id r4so9945345edy.4
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 06:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ln31ItBN6c43yOKakjwFCr7pqh/RYcQKe74wxeRuEWw=;
        b=RVZ1ytdRlWmzBPr2jUvoOAU1+6s5aZV9sq3J3fn/iTiuQ7jeChP4fTIlfj1YCoh71F
         Fvu+kRKlU2XzKbE1muHR8FdC7+fsfsGZ0uxTpus5Al7dE3RW9g5924+kjPu7ZHDz/hRr
         k2xMKDlBwSZ4bVW1IoRUsr8sHpayiDnsNjyOlOoMIbY5tRjSyUkD0gODnFxfNpquJJPC
         TH7h8gJck5L2dL/jhOy9jQav8tTu2SIkICtOarag+cNtSTrvelRpRM4oF4qT2C/Hza6s
         c0mr74QScMvIyDbazKanvelWkKgcZjES8wefOGiwrndBdilF1ghF3ik+dr+dA+w0ICNB
         4Etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ln31ItBN6c43yOKakjwFCr7pqh/RYcQKe74wxeRuEWw=;
        b=f+thQRoCQBLAUGLolQuPH3NRhJU7TXo16Zy1jKoHZNxieDV+WoVpUj6035uVamq0RP
         XBaVd9YH4wUG5KjmsLBMI6GDhCRySlIPP/lWkbU3TgbCCcq2GmISEzheYuRGd8jth1Dt
         f+lKiezewtsglfOB3JrgKBFDGwAwA6wLLNOivM07q5vpZ6Y8KnL5cqhDiCVSgRpRSB5c
         AxMOcrhyxIpfB0z33wKTC7OovLHnexzuxCTs3ZYy6PZwWY+LJnO5WVSpDYbalb+bUKii
         YeYqVphWIgJHPvEsCWidi1H5vyTnwlkfJYihVT0XdD4WJRqAWvZBGB155OiZL5auWeeW
         asXA==
X-Gm-Message-State: APjAAAV28YrUkWMLQWe+j4y/TBgUjauwiz+YciVDJRSKMsfXlfW2gCZP
        EejS0Q2M3DRS9H/j2WXyWZRL7sY8rkOsLUvDPgvqTyY=
X-Google-Smtp-Source: APXvYqxIezNDMl3+UJr6vgRKqY+SpJ46XqPVMVVQyw7/psZCUWORbu6sQF8el/CkxXMkOsQNoouUxSgyMunank0mK74=
X-Received: by 2002:a05:6402:1acd:: with SMTP id ba13mr7638856edb.141.1571663011986;
 Mon, 21 Oct 2019 06:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAKbQEqE7xN1q3byFL7-_pD=_pGJ0Vm9pj7d-g+rRgtONeH-GrA@mail.gmail.com>
 <CAKbQEqG35D_=8raTFH75-yCYoqH2OvpPEmpj2dxgo+PTc=cfhA@mail.gmail.com>
 <4608b644-0fa3-7212-af45-0f4eebfb0be9@gmx.com> <CAKbQEqG8Sb-5+wx4NMfjORc-XnCtytuoqRw4J9hk2Pj9BNY_9g@mail.gmail.com>
 <CAKbQEqGwYCB1N+MQVYLNVm5o10acOFAa_JyO8NefGZfVtdyVBQ@mail.gmail.com>
 <fe882b36-0f7b-5ad5-e62e-06def50acd30@gmx.com> <CAKbQEqEuYqxO8pFk3sDQwEayTPiggLAFtCT8LmoNPF4Zc+-uzw@mail.gmail.com>
 <e0c57aba-9baf-b375-6ba3-1201131a2844@gmail.com>
In-Reply-To: <e0c57aba-9baf-b375-6ba3-1201131a2844@gmail.com>
From:   Christian Pernegger <pernegger@gmail.com>
Date:   Mon, 21 Oct 2019 15:02:55 +0200
Message-ID: <CAKbQEqFdY8hSko2jW=3BzpiZ6H4EV9yhncozoy=Kzroh3KfD5g@mail.gmail.com>
Subject: Re: first it froze, now the (btrfs) root fs won't mount ...
To:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[Please CC me, I'm not on the list.]

Am Mo., 21. Okt. 2019 um 13:47 Uhr schrieb Austin S. Hemmelgarn
<ahferroin7@gmail.com>:
> I've [worked with fs clones] like this dozens of times on single-device volumes with exactly zero issues.

Thank you, I have taken precautions, but it does seem to work fine.

> There are actually two possible ways I can think of a buggy GPU driver causing this type of issue: [snip]

Interesting and plausible, but ...

> Your best option for mitigation [...] is to ensure that your hardware has an IOMMU [...] and ensure it's enabled in firmware.

It has and it is. (The machine's been specced so GPU pass-through is
an option, should it be required. I haven't gotten around to setting
that up yet, haven't even gotten a second GPU, but I have laid the
groundwork, the IOMMU is enabled and, as far as one can tell from logs
and such, working.)

> However, there's also the possibility that you may have hardware issues.

Don't I know it ... The problem is, if there are hardware issues,
that's the first I've seen of them, and while I didn't run torture
tests, there was quite a lot of benchmarking when it was new. Needle
in a haystack. Some memory testing can't hurt, I suppose. Any other
ideas (for hardware testing)?

Back on the topic of TRIM: I'm 99 % certain discard wasn't set on the
mount (not by me, in any case), but I think Mint runs fstrim
periodically by default. Just to be sure, should any form of TRIM be
disabled?
The only other idea I've got is Timeshift's hourly snapshots. (How)
would btrfs deal with a crash during snapshot creation?


In other news, I've still not quite given up, mainly because the fs
doesn't look all that broken. The output of btrfs inspect-internal
dump-tree (incl. options), for instance, looks like gibberish to me of
course, but it looks sane, doesn't spew warnings, doesn't error out or
crash. Also plain btrfs check --init-extent-tree errored out, same
with -s0, but with -s1 it's now chugging along. (BTW, is there a
hierarchy among the super block slots, a best or newest one?)

Will keep you posted.

Cheers,
C.
