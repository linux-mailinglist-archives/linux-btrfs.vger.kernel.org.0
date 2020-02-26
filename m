Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6719C1704AF
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2020 17:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgBZQpr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Feb 2020 11:45:47 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:51672 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgBZQpp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Feb 2020 11:45:45 -0500
Received: by mail-wm1-f45.google.com with SMTP id t23so3863307wmi.1
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2020 08:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BSyyf5zoUUeJwv3/nrFKZcY8+tmaIx6cwk+1dOdGhS4=;
        b=eBstcZnLW6y9M9QHFqP8/HhV11uQrGGYs5U4QlntslIY9wvrKfQ01u5Tgbz/inBAd+
         3xcan7YZrJ0eBPg/Wt4QPn/vFzQj4tJzooGNzpGt2aBff/jEyzeiNlBXOa4xT+WrNPbv
         tpZp89REwco2d9/8yU9Fm6T1zSqqlp0FKbkH3gFtvBY18+CR5qQcmwCR4rfKnZ30oJtE
         mWi2ozhCjCI8bnfU8sgpq0oqf9vW9xzIi2exxLRytdwoXQpyCB7smXivdP954CQrWxz6
         HFDWmHaGewHzPjHcHLK9p1RLb7Wyl8r7ZFKsnoUVEl+Mut2dn+PSTq6dEss+t0qRWCe3
         Yc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BSyyf5zoUUeJwv3/nrFKZcY8+tmaIx6cwk+1dOdGhS4=;
        b=ddn8ITeSXnuQtWGv7H/Idwu70okoegpJOzEy4z8g3qwX4nlRS1lKFWBXFFxQ9JkH4Q
         2awnGPzvT1555892QUbylTyR2O2iO8qZMU3lFTQOFdFSh3cXqeBb/hjlrz3UelrvDzG6
         PFG0KU2ablGURCA4JkDTZPB7VrecRFF3o0om8nn+8ysJKBwzHFrGdlkXQg4KcDxvTXfu
         J/nWJp6hZulI5z4EPWvwZapezpwo+1tIdEfFXD0GTKzeI2SUUO9/G/xQx9j4mVlG9pm0
         Qvs8xiR3gyxP2Dc3swyZ2WnkKHSz9CGjFlQQAAaDtsH+TI7p7khlE2v6CJg8oWFgZJEg
         GjFQ==
X-Gm-Message-State: APjAAAXMDhv5AeQ8TBTbyK53rKWCIbHAC1TOG7DeEzluPDLez9UDp99Q
        DFMTGZ9X/4F+enCm4Vo/H924qdGDHljvSGZKedMylYk=
X-Google-Smtp-Source: APXvYqxMkpOM6iDzrdB2SJK7iRwnNBPygiDx5jOjP0ZAdEy7TXat/BxloBeQyuhUExrm8lJ72Fo2jIaE5kEilfDcMWk=
X-Received: by 2002:a1c:a1c3:: with SMTP id k186mr6380413wme.179.1582735543636;
 Wed, 26 Feb 2020 08:45:43 -0800 (PST)
MIME-Version: 1.0
References: <CAAW2-ZfunSiUscob==s6Pj+SpDjO6irBcyDtoOYarrJH1ychMQ@mail.gmail.com>
 <2fe5be2b-16ed-14b8-ef40-ee8c17b2021c@gmx.com> <CAAW2-Zfz8goOBCLovDpA7EtBwOsqKOAP5Ta_iS6KfDFDDmn47g@mail.gmail.com>
 <60fba046-0aef-3b25-1e7d-7e39f4884ffe@gmx.com>
In-Reply-To: <60fba046-0aef-3b25-1e7d-7e39f4884ffe@gmx.com>
From:   Jonathan H <pythonnut@gmail.com>
Date:   Wed, 26 Feb 2020 08:45:17 -0800
Message-ID: <CAAW2-ZdczvEfgKb++T9YGSOMxJB+jz3_mwqEt2+-g0Omr7tocQ@mail.gmail.com>
Subject: Re: USB reset + raid6 = majority of files unreadable
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 25, 2020 at 8:37 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> It's great that your metadata is safe.
>
> The biggest concern is no longer a concern now.

Glad to hear.

> More context would be welcomed.

Here's a string of uncorrectable errors detected by the scrub: http://ix.io/2cJM

Here is another attempt to read a file giving an I/O error: http://ix.io/2cJS
The last two lines are produced when trying to read the file a second time.

Here's the state of the currently running scrub: http://ix.io/2cJU
I had to cancel and resume the scrub to run `btrfs check` earlier, but
otherwise it has been uninterrupted.

> Anyway, even with more context, it may still lack the needed info as
> such csum failure message is rate limited.
>
> The mirror num 2 means it's the first rebuild try failed.
>
> Since only the first rebuild try failed, and there are some corrected
> data read, it looks btrfs can still rebuild the data.
>
> Since you have already observed some EIO, it looks like write hole is
> involved, screwing up the rebuild process.
> But it's still very strange, as I'm expecting more mirror number other
> than 2.
> For your 6 disks with 1 bad disk, we still have 5 ways to rebuild data,
> only showing mirror num 2 doesn't look correct to me.

I'm sort of curious why so many files have been affected. It seems
like most of the file system has become unreadable, but I was under
the impression that if the write hole occurred it would at least not
damage too much data at once. Is that incorrect?

> BTW, since your free space cache is already corrupted, it's recommended
> to clear the space cache.

It's strange to me that the free space cache is giving an error, since
I cleared it previously and the most recent unmount was clean.

> For now, since it looks like write hole is involved, the only way to
> solve the problem is to remove all offending files (including a super
> large file in root 5).
>
> You can use `btrfs inspect logical-resolve <bytenr> <mnt>" to see all
> the involved files.
>
> The full <bytenr> are the bytenr shown in btrfs check --check-data-csum
> output.

The strange thing is if you use `btrfs inspect logical-resolve` on all
of the bytenrs mentioned in the check output, I get that all of the
corruption is in the same file (see http://ix.io/2cJP), but this does
not seem consistent with the uncorrectable csum errors the scrub is
detecting.

I've been calculating the offsets of the files mentioned in the
relocation csum errors (by adding the block group and offset),
resolving the files with `btrfs inspect logical-resolve` and deleting
them. But it seems like the set of files I'm deleting is also totally
unrelated to the set of files the scrub is detecting errors in. Given
the frequency of relocation errors, I fear I will need to delete
almost everything on the file system for the deletion to complete. I
can't tell if I should expect these errors to be fixable since the
relocation isn't making any attempt to correct them as far as I can
tell.
