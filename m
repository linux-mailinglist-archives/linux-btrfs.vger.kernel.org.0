Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D118438DBBA
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 May 2021 17:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbhEWP47 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 May 2021 11:56:59 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:40724 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbhEWP44 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 May 2021 11:56:56 -0400
Received: by mail-ed1-f42.google.com with SMTP id t3so28990532edc.7
        for <linux-btrfs@vger.kernel.org>; Sun, 23 May 2021 08:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=R/jpuSQ4NpCzM3hHdg+fsFkc4J/YmuLY4H12C7ZanGE=;
        b=TeqAj/s0z396IgXsHKdi3XP9sc246s+QSkWsnNv8a9IAtkLD2RxS5YhvWOdttdPJD2
         xMOjKvzjSpFU+MdU8iaS9lyH6lWuVoSczCUmdrmngSwdfQLqwl9uMnKdDHBqG1Cg0iBx
         CpXIc9/sMZmF+tIKfAO/10lWqhcws7UkIyy9W/LXfVHc3As+T6pbHS4NxbU7z+mXFK6Q
         iTi+NauxlGD39nGCQPt91C0xHNjCXKWEFV6/phV9//K9E+fxQ1T3A/OCI1nFWObqqK7n
         u8esGcQSMIYMNVmN1oFFLnzVI/+EBGJfIFYDN5TjZMfLuAmRFZWexFXb5lrpr0SUEjEu
         YRog==
X-Gm-Message-State: AOAM533OxnRjQ8Ys7CRIYy0ZpiY61x26BzdyAaOBSlHHO5vIl9mxrqyx
        a8RF6GYHnljXx/5t0E1s1oif3sGb8/RrVaYFQZ3KWcZL9obbvQ==
X-Google-Smtp-Source: ABdhPJwZ8eeRqJHxIqugngMGyNsnKAtjZOu3eIRP5CAuRoZvPk+TU+JMu+bdGm0DAxRKB/jCrmeWoQt8AE4mjYmxK6g=
X-Received: by 2002:a50:9f6b:: with SMTP id b98mr21573084edf.318.1621785327341;
 Sun, 23 May 2021 08:55:27 -0700 (PDT)
MIME-Version: 1.0
From:   Andreas Falk <mail@andreasfalk.se>
Date:   Sun, 23 May 2021 16:55:16 +0100
Message-ID: <CADw67XBxEvo_doMWCFChUhEhQxDVg4XuzQvTTMOhE=A+wFbuMg@mail.gmail.com>
Subject: btrfs check discovered possibly inconsistent journal and now the
 errors are gone
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey,

I want to start with clarifying that I've got backups of my important
data so what I'm asking here is primarily for my own education to
understand how btrfs works and to make restoring things more
convenient.

I'm running a small home server with family photos etc with btrfs in
raid1 and we recently experienced a power cut. I wasn't around when it
got turned back on and when I finally got to it everything had run for
~2h with the filesystem mounted in readwrite mode so I ran (after the
fact I realized that I should have probably unmounted immediately and
made sure /etc/fstab had everything in readonly mode):

$ sudo btrfs check --readonly --force /dev/sdb

and it seemed to mostly run fine but after a while it started printing
messages like this along with what looked like some paths that were
problematic (from what I remember, but these are not my exact
messages):

parent transid verify failed on 31302336512 wanted 62455 found 62456
parent transid verify failed on 31302336512 wanted 62455 found 62456
parent transid verify failed on 31302336512 wanted 62455 found 62456

along with (these are my exact messages from a log that I saved):

The following tree block(s) is corrupted in tree 259:
tree block bytenr: 17047541170176, level: 0, node key:
(18446744073709551606, 128, 25115695316992)
The following tree block(s) is corrupted in tree 260:
tree block bytenr: 17047541170176, level: 0, node key:
(18446744073709551606, 128, 25115695316992)
tree block bytenr: 17047547396096, level: 0, node key:
(18446744073709551606, 128, 25187668619264)
tree block bytenr: 17047547871232, level: 0, node key:
(18446744073709551606, 128, 25124709920768)
tree block bytenr: 17047549526016, level: 0, node key:
(18446744073709551606, 128, 25195576877056)
tree block bytenr: 17047551426560, level: 0, node key:
(18446744073709551606, 128, 25162283048960)
tree block bytenr: 17047551803392, level: 0, node key:
(18446744073709551606, 128, 25177327333376)

I didn't have time to look into it deeper at the time and decided to
just shut it down cleanly until today when I'd have some time to look
further at it. I booted it today (still in readwrite unfortunately)
and immediately modified /etc/fstab to not mount any of the volumes,
disabled services that might touch them and then rebooted it again to
make sure it's not touching the disks anymore. Then I ran a check
again:

$ sudo btrfs check --readonly --progress /dev/sdb

and now it's no longer finding any problems or printing any paths that
are problematic.

From what I've understood from this[a] article, the errors I saw were
likely due to an inconsistent journal.

Now for my questions:

1. I'm guessing that my reboots, in particular the ones where I still
had it mounted in readwrite mode somehow cleared the journal and
that's why I'm no longer seeing any errors. Does this sound
plausible/correct? The errors being gone without me manually clearing
them feels scary to me.
2. Is there any way to identify the paths again that were problematic
based on the values in the log that I posted above so I can figure out
what to restore from backups rather than doing a full restore?

a. https://ownyourbits.com/2019/03/03/how-to-recover-a-btrfs-partition/

Thank you,
Andreas
