Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE1F417868D
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 00:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgCCXkj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 18:40:39 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40686 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbgCCXkj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Mar 2020 18:40:39 -0500
Received: by mail-yw1-f67.google.com with SMTP id t192so230229ywe.7
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Mar 2020 15:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VoszLMNRJXfZytUhY6+IZ8Llte96Zv83W4L2RthXZQ4=;
        b=gRtCd+jedwNeE6pfhPS07OjPO+exyWMgnt3rSSKVWKULQ1qy+Mjb9u3Afws4tXTV2T
         GSL5tujrD33kfqyfulgLQQYwAEk/3c2tc9rn5J9d59LvseW4W6+EZc5LCulvNqGkRUPF
         LcECmaQEnHxiCA4Dap7QkX1oTEMNQnUJqDiFB97krKszXjpkjUU2MMDZ+eTwla1LKYtA
         1B8bHkAi2IO5khVs5gf9iAm+jAWs9VD9kvWI8Yux57yvv5QdG39/of3C3nHmoAqJQaPn
         W87eQ1S0FVnY0t+AsKuyumsy3HKF/n4rYMllpqJmhZUHbLX/cZZP4gBjEMdJaqetDiF3
         sXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VoszLMNRJXfZytUhY6+IZ8Llte96Zv83W4L2RthXZQ4=;
        b=EE2nZ4Xvdx11jKBL8UWvfZ41+AY2+OOFywKIRJ6Ij+F0OL9SEaKhe8bBLsa8F1n+7v
         8PsPPk/92Dk+F7n6HwqWG3JXutGTSUARS6Bwh0pEw6a6tmhOOApLD1vJNLv9er57raXR
         RxwyPvJneGlgDiJzfl3bjpX72d/fUab8IXFDEgPtgZfpOmiScb7qX7Lza2DzuKR6njBa
         ImVlwgf32qCLAeLqaBwd+7SP/SuDEK6wbtLlQ++VvBK196zy6uXS9P1EsHp/Z79g50wz
         N92hnNnojHVzGmKvSpmwBSjm21nENkcDgzRUN4aaC1K6BD+rCcHfIQ0zdW0J4FuQNyDq
         AzgA==
X-Gm-Message-State: ANhLgQ2A6eabX1lUFxiQmQMcwDZlZrNbSMsy8Q9kBWj2gi2oLleClJli
        7b/HgrezLwbf8gkXJjDtJpeK3+s3bcpfFoo1+yRI2LCu
X-Google-Smtp-Source: ADFU+vt/sFjch/MlYgs3RgnXRt1ltIOpdB0x0p9TSeDoDb0VkRGMMirsmQnMQvs4tJ2diwg8zHI3/gj6+FIZEQDWZv8=
X-Received: by 2002:a81:5256:: with SMTP id g83mr256672ywb.79.1583278838318;
 Tue, 03 Mar 2020 15:40:38 -0800 (PST)
MIME-Version: 1.0
References: <CAAW2-ZfunSiUscob==s6Pj+SpDjO6irBcyDtoOYarrJH1ychMQ@mail.gmail.com>
 <2fe5be2b-16ed-14b8-ef40-ee8c17b2021c@gmx.com> <CAAW2-Zfz8goOBCLovDpA7EtBwOsqKOAP5Ta_iS6KfDFDDmn47g@mail.gmail.com>
 <60fba046-0aef-3b25-1e7d-7e39f4884ffe@gmx.com> <CAAW2-ZdczvEfgKb++T9YGSOMxJB+jz3_mwqEt2+-g0Omr7tocQ@mail.gmail.com>
 <CAG_8rEfjNPwT4g2DwbS9atsurLvYazt7aV4o77HGv-fssNmheQ@mail.gmail.com>
 <CAJCQCtTYBOUDmWBAA4BAenkyZS6uY+f6Ao33uHMmr_16M_1Buw@mail.gmail.com>
 <CAG_8rEcXpWUyUqmi3fe8BicZXQODJP2ZS69Z=BBcBPfAQBuSHA@mail.gmail.com> <CAJCQCtR7prMai9dYndLZ4Wg4tSL7kHZaLLK8c5p_4fDG2qoYnA@mail.gmail.com>
In-Reply-To: <CAJCQCtR7prMai9dYndLZ4Wg4tSL7kHZaLLK8c5p_4fDG2qoYnA@mail.gmail.com>
From:   Steven Fosdick <stevenfosdick@gmail.com>
Date:   Tue, 3 Mar 2020 23:40:26 +0000
Message-ID: <CAG_8rEf-kdju-OPhVUVWF8qNMM=xiUnWuBgODiwzGnRMzJYNpg@mail.gmail.com>
Subject: Re: USB reset + raid6 = majority of files unreadable
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Jonathan H <pythonnut@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, 29 Feb 2020 at 06:31, Chris Murphy <lists@colorremedies.com> wrote:

> s/might/should

I do think it is worth looking at the possibility that the "write
hole", because it well documented, is being blamed for all cases that
data proves to be unrecoverable when some of these may be due to a bug
or bugs.  From what I've found about the write hole this is because of
uncertainty over which of several discs actually got written to so
when copies don't match there is no way to know which one is right.
In the case of a disc failure, though, surely the copy that is right
is the one that doesn't involve the failed disc?  Or is there
something else I don't understand?

> I'm curious why you had to use force, but yes that should check all of
> them. If this is a mounted file system, there's 'btrfs scrub' for this
> purpose though too and it can be set to run read-only on a read-only
> mounted file system.

In the case of 'btrfs check' the filesystem was mounted r/o but I had
things reading it so didn't want to unmount it completely.  It
requires --force to work on a mounted filesyetem even if the mount is
r/o.

I did try running a scrub but had to abandon it as it wasn't proving
very useful.  It wasn't fixing the errors and wasn't providing any
messages that would help diagnose or fix them some other way - it only
seems to provide a count of the errors it didn't fix.  That seems to
be general thing in that there seem plenty of ways an overall 'failed'
status can be returned to userspace, usually without anything being
logged.  That obviously makes sense if the request was to do something
stupid but if instead the error return is because corruption has been
found would it not be better to log an error?

> That looks like a bug. I'd try a newer btrfs-progs version. Kernel 5.1
> is EOL but I don't think that's related to the usage info. Still, tons
> of btrfs bugs fixed between 5.1 and 5.5...
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/diff/fs/btrfs/?id=v5.5&id2=v5.1
>
> Including raid56 specific fixes:z
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/diff/fs/btrfs/raid56.c?id=v5.5&id2=v5.1

This was in response to posting dodgy output from btrfs fi usage.  My
output was from btrfs-progs v5.4 which, when I checked yesterday,
seemed to be the latest.  I am also running Linux 5.5.7.  It may have
been slightly older when the disk failed but would still have been
5.5.x

Since my previous e-mail I have managed to get a 'btrfs device remove
missing' to work by reading all the files from userspace, deleting
those that returned I/O error and restoring from backup.  Even after
that the summary information is still wacky:

WARNING: RAID56 detected, not implemented
Overall:
    Device size:   16.37TiB
    Device allocated:   30.06GiB
    Device unallocated:   16.34TiB
    Device missing:      0.00B
    Used:   25.40GiB
    Free (estimated):      0.00B (min: 8.00EiB)
    Data ratio:       0.00
    Metadata ratio:       2.00
    Global reserve: 512.00MiB (used: 0.00B)

is the clue in the warning message?  It looks like it is failing to
count any of the RAID5 blocks.

Point taken about device replace.  What would device replace do if the
remove step failed in the same way that device remove has been failing
for me recently?

I'm a little disappointed we didn't get to the bottom of the bug that
was causing the free space cache to become corrupted when a balance
operation failed but when I asked what I could do to help I got no
reply to that part of my message (not just from you, from anyone on
the list).
