Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A612458FB5
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Nov 2021 14:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239476AbhKVNwh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Nov 2021 08:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhKVNwf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Nov 2021 08:52:35 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EFFC061574
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Nov 2021 05:49:29 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id be32so37822426oib.11
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Nov 2021 05:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=NiBavOIqzwiNcG7zQ+hRsKyLN4YVgZdOO/tvtiObapg=;
        b=lHM17f0aNexFjVCHNAaoME+ltg2coenNIwtT/bCHPf1Di9w2m4NACIxjGERyT7JXBU
         EifbJQQmnrhhNgarBICt/jqfPrZE1X6m0Hq4G5EQEKLd3Sw9ucaSEAX6DvWSAxOFhYjt
         dyoaphqFd8hVcRgBvbtWzZ2My2NMpsQlVZX8N2tOXt7/KgwQf7W6/O4fmg+tmBXBx6HL
         qGJxcQgGR8aFkWzp+MwDWRR6iZCTv7sGKdYo/wlWQz6ZaJx0pXVFLsSblyzY24BGn4ET
         GjYh8nF4gahvGaWpIXf5SCM9L+PE3xuQ2bqzp/oy3RiWUwNXmLef8DZRxqwJRpdb+pmG
         JWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=NiBavOIqzwiNcG7zQ+hRsKyLN4YVgZdOO/tvtiObapg=;
        b=vtPymGqy9LYBGzpCs1BvCsOMwN/c5HkCYDMOsyxrIPFvoRnR860kjNJxrTd7Zxkglz
         K7hd3Hd5wAfh61npMjX8Qkbr7dZWUDzDNQaIdr60bMOOzdNy+cWxXTh3qows2HdbT3R/
         oJh6rXXIlru9Ud15IWZkdf7dWj050CXUCGy9Y8Ne6LKmUZSsQU/WJIeRBFulfZ7kPiGj
         q/hWP4e8MvoC4x2xpJTs0LJbmqUX9CvLFcrxWrIpyVJu/ru9pz2smVQI3R6u9kQfjZcG
         kd9du6C1gA50nz+vNgJbru/9w36xdSXDQNZdNiruhsznkPYZmzwy9R6mgvpN32O44Bv+
         Va6g==
X-Gm-Message-State: AOAM530iou23bKudJuARa8k1LAQpXGKY0haoWAiwS0VDxJi5gQYAebn3
        1PXBs5u7lq8TQ7H2Sh2MsVanXBdsVyi8WliolJYmXS9l9yQ=
X-Google-Smtp-Source: ABdhPJx/yj2qD6UzBBRbcJAjljVhBNtQ6usRwV+mWMcGuls9WUAePpFBqBk0idCChJwDTCp40ztu0mhp9+l+RE6jqSM=
X-Received: by 2002:a05:6808:f8c:: with SMTP id o12mr21030960oiw.50.1637588968715;
 Mon, 22 Nov 2021 05:49:28 -0800 (PST)
MIME-Version: 1.0
References: <CAHzMYBT+pMxrnDXrbTJqP-ZrPN5iDHEsW_nSjjD3R_w3wq5ZLg@mail.gmail.com>
 <20210721174433.GO19710@twin.jikos.cz> <CAHzMYBQnP=rqa_mf9TXAEK3Yrpjezff0cE=pBsunbBT63wHeSQ@mail.gmail.com>
In-Reply-To: <CAHzMYBQnP=rqa_mf9TXAEK3Yrpjezff0cE=pBsunbBT63wHeSQ@mail.gmail.com>
From:   Jorge Bastos <jorge.mrbastos@gmail.com>
Date:   Mon, 22 Nov 2021 13:49:18 +0000
Message-ID: <CAHzMYBSE6jeEcOfOerc-99M9_j-4XDLcEw_w=hGLxAzr9bmWwA@mail.gmail.com>
Subject: Re: "bad tree block start, want 419774464 have 0" after a clean
 shutdown, could it be a disk firmware issue?
To:     dsterba@suse.cz, Jorge Bastos <jorge.mrbastos@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello all,

Small update on this issue, it happened again to the same disk:

Nov 22 13:32:15 TV1 emhttpd: shcmd (126): mount -t btrfs -o
noatime,space_cache=v2 /dev/md20 /mnt/disk20
Nov 22 13:32:15 TV1 kernel: BTRFS info (device md20): enabling free space tree
Nov 22 13:32:15 TV1 kernel: BTRFS info (device md20): using free space tree
Nov 22 13:32:15 TV1 kernel: BTRFS info (device md20): has skinny extents
Nov 22 13:32:16 TV1 kernel: BTRFS error (device md20): bad tree block
start, want 1589201485824 have 620757024
Nov 22 13:32:16 TV1 kernel: BTRFS error (device md20): bad tree block
start, want 1589201485824 have 620757024
Nov 22 13:32:16 TV1 kernel: BTRFS error (device md20): failed to read
block groups: -5

This is a new filesystem, previous one was unrecoverable, again it
happened on boot after a clean shutdown, I have over a 100 similar
btrfs filesystems, more than 10 using this same disk model with no
other issues for years, so the same thing happening to the same disk
in a space of a few months suggests to me it's not just a firmware
issue, something else must be going one, maybe something in the disk
is going bad, controller is an LSI 9207 HBA with 17 more disks
connected, for now I'm going to restore the data to a different disk
and see if it doesn't happen again, might also use this disk in a
small zfs pool I have to see if it also gives issues there.

Regards,
Jorge Bastos

On Wed, Jul 21, 2021 at 7:14 PM Jorge Bastos <jorge.mrbastos@gmail.com> wrote:
>
> On Wed, Jul 21, 2021 at 6:47 PM David Sterba <dsterba@suse.cz> wrote:
> >
> > For the record summing up the discussion from IRC with Zygo, this
> > particular firmware 80.00A80 on WD Green is known to have problematic
> > firmware and would explain the observed errors.
> >
> > Recommendation is not to use WD Green or periodically disable the write
> > cache by 'hdparm -W0'.
> >
>
> Thank you for the reply, yes, from now on I intend to disable write
> cache on those disks, since I still have a lot of them in use.
>
> Jorge
