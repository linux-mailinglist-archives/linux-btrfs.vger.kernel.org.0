Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F68485A0B
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 21:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244055AbiAEUdI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jan 2022 15:33:08 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39802 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244036AbiAEUdG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jan 2022 15:33:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAFDC618DE
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jan 2022 20:33:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28708C36AE0
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jan 2022 20:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641414785;
        bh=JivcVcQtQ9y4g0noSIvjhVK6/oN+Tj4YAamBxHecBAs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n0xDEvcLv2mq+69x5dT0rw421cHvpeoU7L58xo7P7kToggnqFHeKXfnuGkvdVTXD2
         znRYiopzRCHE0Mzq4JqvRO6G8HFHVgZNt2FVV8GcQWVz6kJFY0oTybCplRehQnF7DA
         0ihtt1T5Z4bvqLLrVsPAWRCyBQOYV99319ppbPfvn9iHR8Srg2+Q4EKfRMc6DYbqO1
         f4A0Ip26jgFrGM01z7IxWvL0xsgCvH/+CfAOvq+i4jhOq3+6QgWImIt/ZvjwkdkqjI
         CpXg3HEGi6WR/C1wZ/O+mSzxnHSw8EvW3v58f2EX2HOmqpVhjHP6Q7C2CVqY6h4uCJ
         nQoLDvEruO5cg==
Received: by mail-qk1-f180.google.com with SMTP id i187so615059qkf.5
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Jan 2022 12:33:05 -0800 (PST)
X-Gm-Message-State: AOAM533WfehzVXYwOErtGRBtYoKtXz/fyLAP+sWuhL/7RrIur5iAlyFs
        gEavilSD9STu0jq3fQZiY9dxjp7C60kf0iUjBVI=
X-Google-Smtp-Source: ABdhPJxVNapjoa1KWZJupfGgx8Z6GyLE39OIs4wrDGRi7DKIpKwVcJxlWDEeagTEE+qCEQjbDjWDUoUvcyymdUOeYQk=
X-Received: by 2002:a05:620a:4092:: with SMTP id f18mr38513024qko.629.1641414784237;
 Wed, 05 Jan 2022 12:33:04 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtRnyUHEwV1o9k565B_u_RwQ2OQqdXHtcfa-LWAbUSB7Gg@mail.gmail.com>
 <YdXdtrHb9nTYgFo7@debian9.Home> <CAJCQCtSd8B-qgW=eehcLDxb6oHoj69UiMtvixz=WwWCuy_Fggg@mail.gmail.com>
In-Reply-To: <CAJCQCtSd8B-qgW=eehcLDxb6oHoj69UiMtvixz=WwWCuy_Fggg@mail.gmail.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 5 Jan 2022 20:32:28 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4L4QkexSCCowJEx8MTjRgAQhQ0n=mjDjnQdGtVYKTPBA@mail.gmail.com>
Message-ID: <CAL3q7H4L4QkexSCCowJEx8MTjRgAQhQ0n=mjDjnQdGtVYKTPBA@mail.gmail.com>
Subject: Re: [bug] GNOME loses all settings following failure to resume from suspend
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 5, 2022 at 6:40 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Wed, Jan 5, 2022 at 11:04 AM Filipe Manana <fdmanana@kernel.org> wrote:
> >
> > Looking at the code before that patch, it explicitly skips fsync after
> > a rename pointing out to:
> >
> > https://btrfs.wiki.kernel.org/index.php/FAQ#What_are_the_crash_guarantees_of_overwrite-by-rename.3F
> >
> > I'm afraid that information is wrong, perhaps it might have been true in
> > some very distant past, but certainly not for many years.
>
> However, the system does suspend correctly and before that there
> should be "Filesystems sync" message from the kernel (this is the case
> on my laptops, unconfirmed for the GNOME bug case). [1]
>
> If the sequence is:
>
> write to file
> no fsync
> "filesystem sync" (I guess that's syncfs for all mounted filesystems? no idea)
> suspend
> crash
>
> Still seems like the file should be either old or new, not 0 length?

Nop, it can still be 0.

So where that message is printed, before it, ksys_sync() is called,
which will indeed call btrfs' sync_fs() callback (btrfs_sync_fs()).

However btrfs_sync_fs() will only wait for existing ordered extents to
complete, and then commit the current transaction.
Ordered extents are created when writeback is started.

In the rename path (btrfs_rename()) we trigger writeback with
filemap_flush() (mm/filemap.c), but that does not guarantee that
I/O is started for all dirty pages:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/filemap.c?h=v5.16-rc8#n462

/**
 * filemap_flush - mostly a non-blocking flush
 * @mapping: target address_space
 *
 * This is a mostly non-blocking flush.  Not suitable for data-integrity
 * purposes - I/O may not be started against all dirty pages.
 *
 * Return: %0 on success, negative error code otherwise.
 */
int filemap_flush(struct address_space *mapping)
{
return __filemap_fdatawrite(mapping, WB_SYNC_NONE);
}
EXPORT_SYMBOL(filemap_flush);

I.e., we have no guarantee that writeback was started by the time the
rename returns to user space.

Regardless of that, it was not safe... a crash can happen after the
rename and before ksys_sync() is called.

>
>
> > I don't think I have a wiki account enabled, but I'll see if I get that
> > updated soon.
>
> Thanks Felipe!

Filipe

Thanks.

>
> [1] "Filesystems sync" message appears to come from here
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/power/main.c?h=v5.16-rc8#n62
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/power/main.c?h=v5.16-rc8#n195
>
>
>
>
> --
> Chris Murphy
