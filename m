Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A30512CB24
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Dec 2019 23:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfL2W2G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Dec 2019 17:28:06 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45720 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfL2W2F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Dec 2019 17:28:05 -0500
Received: by mail-ot1-f67.google.com with SMTP id 59so43977843otp.12
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Dec 2019 14:28:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1/egouknvO4uhlLVwKaiO63786Ude2oMponSS3srR9I=;
        b=iJ5ux7yYcHscjvTEa63x2h225MPEC9kxLN4ZW0OLm0bVxOXP9uJw7m33X3zFOL770o
         ZH6nSJq/wuzQDxtGnkugfn1mqvGqiUNQAkmtVlOKu4uQdDWyb7R4kpLpMgnyHFr6CQ5P
         PsaXFFTd3E8zyCDMyvHyIHKozIsdzCHZUCb6CkhRdaUYDMxpihtKJSLwOsRKy0q3Sx9r
         QQhNNzZIWl6oLYXn87T/ayZFLt/Njw4A9fZL5kx+dJ8aYL8L98mRiPn861d7oTqtKu0j
         DYLwi9HxW+QCBeJwIcYqoA9sm3UMv8DtP/BJAfaurh+9BADpxhSrgoELIBZW0a0GzlFd
         megw==
X-Gm-Message-State: APjAAAUSEJyeWFUifu5k5Gg7ktrrxiydDT6B8B7wVj2q0N6mhDogViBc
        M8ErzwregPhe82m6imNnYIn7AOP8Ah+y0LB2VtQtKW2sL10=
X-Google-Smtp-Source: APXvYqzVbPzvsSAVjCWP1Qc4T+CzReSWUzFyQ8CNGUhTacU6CmM6C+B1Py/9TNyqisxo8CaFEuzIVwxAZxyCBzO1vew=
X-Received: by 2002:a05:6830:1cd3:: with SMTP id p19mr66876839otg.118.1577658484941;
 Sun, 29 Dec 2019 14:28:04 -0800 (PST)
MIME-Version: 1.0
References: <CAOB=O_jxu5JOe=JiYVW_VZ1rgs9+mdHpAHkscXkc4MVRLrBKDw@mail.gmail.com>
 <CAJCQCtQwLrZxfc7xb8FpVcV9r9rpEpD0SRPebRtRpS5SPYM_3A@mail.gmail.com>
In-Reply-To: <CAJCQCtQwLrZxfc7xb8FpVcV9r9rpEpD0SRPebRtRpS5SPYM_3A@mail.gmail.com>
From:   Patrick Erley <pat-lkml@erley.org>
Date:   Sun, 29 Dec 2019 14:27:53 -0800
Message-ID: <CAOB=O_hLvVaSdnvXwFeC5h6=AySnb4Fh9Fzx-zjFmw92odSLzQ@mail.gmail.com>
Subject: Re: read time tree block corruption detected
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Should I --force it while mounted, or run the checks from RO mount status?

On Sun, Dec 29, 2019 at 2:07 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Sun, Dec 29, 2019 at 1:44 PM Patrick Erley <pat-lkml@erley.org> wrote:
> >
> > On a system where I've been tinkering with linux-next for years, my /
> > has got some errors.  When migrating from 5.1 to 5.2, I saw these
> > errors, but just ignored them and went back to 5.1, and continued my
> > tinkering.  Over the holidays, I decided to try to upgrade the kernel,
> > saw the errors again, and decided to look into them, finding the
> > tree-checker page on the kernel docs, and am writing this e-mail.
> >
> > My / does not contain anything sensitive or important, as /home and
> > /usr/src are both subvolumes on a separate larger drive.
> >
> > btrfs fi show:
> > Label: none  uuid: 815266d6-a8b9-4f63-a593-02fde178263f
> > Total devices 2 FS bytes used 93.81GiB
> > devid    1 size 115.12GiB used 115.11GiB path /dev/nvme0n1p2
> > devid    3 size 115.12GiB used 115.11GiB path /dev/sda3
> >
> > Label: none  uuid: 4bd97711-b63c-40cb-bfa5-aa9c2868cf98
> > Total devices 1 FS bytes used 536.48GiB
> > devid    1 size 834.63GiB used 833.59GiB path /dev/sda5
> >
> > Booting a more recent kernel, I get spammed with:
> > [    8.243899] BTRFS critical (device nvme0n1p2): corrupt leaf: root=5
> > block=303629811712 slot=30 ino=5380870, invalid inode generation: has
> > 13221446351398931016 expect [0, 2997884]
> > [    8.243902] BTRFS error (device nvme0n1p2): block=303629811712 read
> > time tree block corruption detected
> >
> > There are 6 corrupted inodes:
> > cat dmesg.foo  | grep "BTRFS critical" | sed -re
> > 's:.*block=([0-9]*).*ino=([0-9]+).*:\1 \2:' | sort | uniq
> > 303629811712 5380870
> > 303712501760 3277548
> > 303861395456 5909140
> > 304079065088 2228479
> > 304573444096 3539224
> > 305039556608 1442149
> >
> > and they all have the same value for the inode generation.  Before I
> > reboot into a livecd and btrfs check --repair, is there anything
> > interesting that a snapshot of the state would show?  I have 800gb
> > unpartitioned on the nvme, so backing up before is already in the
> > plans, and I could just as easily grab an image of the partitions
> > while I'm at it.
>
> I'm not certain whether btrfs check can fix these kinds of errors yet.
> Can you use btrfs-progs v5.4 and just do a 'btrfs check' and also
> again with 'btrfs check --mode=lowmem' ? I'm curious if either mode
> sees the same problem the kernel tree checker sees.
>
> --
> Chris Murphy
