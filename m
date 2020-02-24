Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1698E16A394
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 11:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgBXKLj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 05:11:39 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36722 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgBXKLi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 05:11:38 -0500
Received: by mail-vs1-f67.google.com with SMTP id a2so5330010vso.3
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Feb 2020 02:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=FBybtksC57TT5mwwN9u8hMEd6k4CsYX8mjETUuoydqQ=;
        b=cx9wWPgxmRcnpEsNVwyRpn3EV0DfwykfjBuRs8GxrVWqgK7+cgEv/Vagh3Dyr8Lyac
         kSP6jUWrwBLV7xTl2WIUcjyg/n87TcWch315ui1wrFP0YHQgP55nwTeXgv1lx4jmBM04
         yTH7mBXOn0V3kgiGS0jVP6t4KfMFdSdlO1Ib5/xCCSg6OTVegqYZlo8+oif4WYDv5TWZ
         fQQJdNCgUbCP4f2zK4XsV5COR6jRGHct3ZsDgCUpRTNmgCoiOIf3OCDO4kNUMygVmZnh
         ZPgTM9ZYyUYi43BoR8nlE/a5DilQoIOsOjUR/TQQmEr6ijTSJ38CFwOYEeKl5gyU8su5
         c1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=FBybtksC57TT5mwwN9u8hMEd6k4CsYX8mjETUuoydqQ=;
        b=V2x7UuKGhZgNAyoqfj12t22tM3RmrPFDS8m2abD524MNk6rolgVscpMXykRZyYR7eQ
         71+Po8SAaLGGYynYDl1GCdRnQjRwjUHmjap02EzxHacuy5wk2FpoTQjTUDcb7dbEoVfY
         pXmjyrYDYbeM940fxbhBW04acGu3gRl3DJ81D6f/AnlJCpT96qB/VWq3QWpTJvEFCWb3
         3xSBf5VsecNRUlri0Ve75Bz2fodt1KUocplvf4Q7k+/mDOrcaBgRGJ6ddODDQV8ITtES
         gfganWaONZMMANV98PigsMudc7HwuV8rMmG2LMrSzzGP5ZbJl7nB01hfkSq1HlDVaUrA
         PoXw==
X-Gm-Message-State: APjAAAUskQQCOu/uNBvdubOnS4ExrmktObTxY6H57HVpvQ3lYYgAeQY5
        tdnFxhdBleiFPGcHrz6vrgNn6whXyxHT/JRzu4s=
X-Google-Smtp-Source: APXvYqwAreHtJgeUTHLvi58P/6uM6Nx8CreUUzMZMmMBqsuNW9e//K/qWSQg4O2HfefidIJOoKucfgIW1mjj2OYiZ1s=
X-Received: by 2002:a67:8010:: with SMTP id b16mr25440966vsd.90.1582539097194;
 Mon, 24 Feb 2020 02:11:37 -0800 (PST)
MIME-Version: 1.0
References: <20200223234246.GA1208467@mit.edu> <0c0fa96f-60d6-6a66-3542-d78763bbe269@suse.com>
In-Reply-To: <0c0fa96f-60d6-6a66-3542-d78763bbe269@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 24 Feb 2020 10:11:26 +0000
Message-ID: <CAL3q7H5s2pZV-KExti7M5+yVG7N7zFVVzGvNdAiZCthMfNSoQg@mail.gmail.com>
Subject: Re: btrfs: sleeping function called from invalid context
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 24, 2020 at 12:30 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 24.02.20 =D0=B3. 1:42 =D1=87., Theodore Y. Ts'o wrote:
> > Hi, I noticed this when I was doing some build tests; is this a known i=
ssue?
> >
>
> So this is fallout from 28553fa992cb28be6a65566681aac6cafabb4f2d because
> it's being called while we have locked extent buffers (before calling
> btrfs_free_Path which is holding a rwlock (a variant of spinlock). And
> actually unlocking btrfs' extent requires allocating structures to
> reflect the new state. This allocation is currently done with GFP_NOFS
> which implies DIRECT_RECLAIM hence the maybe sleep from slab allocator
> is triggered.
>
> Filipe, can the unlock be done _after_ freeing the path or even better -
> reduce the critical section altogether in btrfs_truncate_inode_items?
>
> I don't think '[PATCH] Btrfs: fix deadlock during fast fsync when
> logging prealloc extents beyond eof' actually fixes the problem since
> the unlock can happen under the path again.

The problem is that that patch was made against the integration branch
(misc-next) where truncate doesn't use btree search paths with
spinning locks anymore, so it didn't trigger that problem during
development.
The patch was then picked into 5.6-rc2, where we still use spinning
locks, whence people reporting the issue (before Ted, Dave Jones and a
few others had reported it as well).

The solution was to pick a patch from the integration branch into 5.6-rc3:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D52e29e331070cd7d52a64cbf1b0958212a340e28

That solves the sleep in invalid context warnings.
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
