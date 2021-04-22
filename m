Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0676367F2B
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Apr 2021 13:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbhDVLAg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Apr 2021 07:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235949AbhDVLAf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Apr 2021 07:00:35 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A27C06174A
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Apr 2021 04:00:00 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id d19so10092781qkk.12
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Apr 2021 04:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=mvgx56I8iMsl4jtuPkfHGgoVn4hWldjZFgWHW8PnlmI=;
        b=S4K7K+pBp6lB2TH+fIloYE7qJ7yIf1ylCB6NRUSQJy4GHcEAON6dn+Qic9L5IjrINq
         UixbTb3+HWsy4EEEwHsGZVxwBB9SNNgW+T+ZAz34jhAKrgWfhp96s0IHtwZd/ESp6OVr
         ivcQh6cawpvd3LSEpw1EaqbQCIrL0o2YbZFWYjWuYEbz1SYzM8RVWDcehtIb8eyehfio
         jJ/xFVZCIh02ChUb1P0KPCtx7PAAmwWKhRK4MLN0Tw1cGpj+zece91TTFQbNE3YLr4Ua
         kTItSDC2Xn9dGKPr4Ig3bm9TF+AflNedU0nIsJ5SxboebXOiYpEOQQCgRX23zJsbsfGo
         6+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=mvgx56I8iMsl4jtuPkfHGgoVn4hWldjZFgWHW8PnlmI=;
        b=HxnnpZtg79FZpLyhjmLvMajm4Hk97K2/4242ncEu4X8wwb6pzUKtPtDE0QslS3KxHE
         b7wCyAXRKLBqAVJXDHvi7Cu3KCVuLNX0MS98/7LIXvEp0G5/RiIAJQdUPyDDmKHjAVKX
         cIXCbOdabTB24edVdFhUw1c60hAkTc/DzVHzhJFO1apIRT96yBPbyw1skxG5hMG8dU/y
         f69QqdhiACcEVb+015/EiDfx97mzFmNB7wu7ggY15P/ImBeAoZaSa+XYYURH0/2jwZky
         VDxngnrY5jwf3AaNMQ5XmkWTkemVthk8YH7atxBvNLWB04ltZi2Faan7ntUtyX4wAaET
         QgUw==
X-Gm-Message-State: AOAM533zVkTHXnS4Wpj9Y2TBud37Tt26NiiscsRrjPC/Ww9q4SsuJ9CJ
        t7gTeCNQ9MsXk/dQi/EHFbjCwIp0D1+DARHHGSE=
X-Google-Smtp-Source: ABdhPJyaH6ZplTL3QtNMAmNxLezILFfBE+tzb1ytYy2iMWiqu6kZMR19+6X0hVaU9Zz0NFvPBFhMmZ4qdDEbvpdaUdk=
X-Received: by 2002:a37:bb04:: with SMTP id l4mr3068330qkf.383.1619089199569;
 Thu, 22 Apr 2021 03:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210421201725.577C.409509F4@e16-tech.com> <CAL3q7H6V+x_Pu=bxTFGsuZLHf2mh_DOcthJx7HCSYCL79rjzxw@mail.gmail.com>
 <20210421235733.9C11.409509F4@e16-tech.com> <CAL3q7H7j7eZ0r1xYJiQGr3+yuwnqkpbRoA3HxY=e8Ut8VDRCRA@mail.gmail.com>
 <9b4400ca-d0a3-621d-591c-dc377d0bed58@gmx.com>
In-Reply-To: <9b4400ca-d0a3-621d-591c-dc377d0bed58@gmx.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 22 Apr 2021 11:59:48 +0100
Message-ID: <CAL3q7H6cC+PrrxjozYYFV7wH7LUsS0mf=7djHccJ0J6E0c+Bmw@mail.gmail.com>
Subject: Re: 'ls /mnt/scratch/' freeze(deadlock?) when run xfstest(btrfs/232)
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Wang Yugui <wangyugui@e16-tech.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 22, 2021 at 12:19 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/4/22 =E4=B8=8A=E5=8D=8812:03, Filipe Manana wrote:
> > On Wed, Apr 21, 2021 at 4:57 PM Wang Yugui <wangyugui@e16-tech.com> wro=
te:
> >>
> >> Hi,
> >>
> >>> That's the problem, qgroup flushing triggers writeback for an inode
> >>> for which we have a page dirtied and locked.
> >>> This should fix it:  https://pastebin.com/raw/U9GUZiEf
> >>>
> >>> Try it out and I'll write a changelog later.
> >>> Thanks.
> >>
> >> we run xfstest on two server with this patch.
> >> one passed the tests.
> >> but one got a btrfs/232 error.
> >>
> >> btrfs/232 32s ... _check_btrfs_filesystem: filesystem on /dev/nvme0n1p=
1 is inconsistent
> >> (see /usr/hpc-bio/xfstests/results//btrfs/232.full for details)
> >> ...
> >> [4/7] checking fs roots
> >> root 5 inode 337 errors 400, nbytes wrong
> >> ERROR: errors found in fs roots
> >
> > Ok, that's a different problem caused by something else.
> > It's possible to be due to the recent refactorings for preparation to
> > subpage block size.
>
> This error looks exactly what I have seen during subpage development.
> The subpage bug is caused by incorrect btrfs_invalidatepage() though,
> and not yet merged into misc-next anyway.

Ok, I vaguely remembered you encountering problems with that and
mentioning it somewhere.
I couldn't reproduce it overnight.

>
> I guess it's some error path not clearing extent states correctly, thus
> leaving the inode nbytes accounting wrong.
>
> BTW, the new @in_reclaim_context parameter for start_delalloc_inodes()
> is already in misc-next:

Well, yes, it was added to 5.11 and then backported to the relevant
stable releases.

> commit 3d45f221ce627d13e2e6ef3274f06750c84a6542
> Author: Filipe Manana <fdmanana@suse.com>
> Date:   Wed Dec 2 11:55:58 2020 +0000
>
>      btrfs: fix deadlock when cloning inline extent and low on free
> metadata space
>
> We only need to make btrfs_start_delalloc_snapshot() to accept the new
> parameter and pass in_reclaim_context =3D true for qgroup.

Correct.
I initially thought about removing the argument and always skip the
flagged inodes, but that would make snapshotting not wait for inline
cloning in progress (which is why I introduced the parameter back
then).
Not that it could cause any problem, just a matter of being consistent
and preserving the behaviour of waiting for any ongoing inline extent
cloning.

>
> Thanks,
> Qu
> >
> > Will try to look into that later.
> >
> > Thanks.
> >
> >> ...
> >>
> >> Best Regards
> >> Wang Yugui (wangyugui@e16-tech.com)
> >> 2021/04/21
> >>
> >
> >



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
