Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75FE3337C31
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Mar 2021 19:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhCKSMi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Mar 2021 13:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhCKSMP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Mar 2021 13:12:15 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71597C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Mar 2021 10:12:15 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id l4so21605946qkl.0
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Mar 2021 10:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=4OLpvwUCy2uXsyPSaaF7pIp2fH7lOar8dWD6Oh6yvNo=;
        b=K0RSE2ZFgHxMUBA/mt6PkAIrXX8E4xx8KXwCdbxfGuOCMCm9vZZGO5rjcaw2NWHnzg
         ZUqAAkPjrQ7YhAvH8ntC/Ak45hfMnl3l5IThXRs0nYGSgXn0rShBdX0RbKe/IwR6JLDv
         XOfTXiye1O+FBsXj45EI538vIJObEURaGnIJLZQhxwIuhPuJmo9SkLaftbsK2ksF5WC8
         KtUZ1jdecaQBOWaKlT0x8B4eVxjQHIQlIen0w77IkLRCUyABvfNkpanQmeAYRurKDy+E
         KzaL5HF4dRqkvZXtTy/dMoioC0aEWNBNe+1jPGBxhADSSwFXfW2lP2H2OoCfXVNKW1k1
         eGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=4OLpvwUCy2uXsyPSaaF7pIp2fH7lOar8dWD6Oh6yvNo=;
        b=BJ23PiBbxWg49/ZFjmJ38epkmQxGSD+5HoGO0FB0gadTCyBZ9kGspB81MbcX90Cvv6
         6jyMNcrBXBZZJXBUnUb7ajT5E6iRQLJ6iQm3/FuGripmNyBmF10TECYSg5lsqKt8Kv9Z
         cPR7LcY4nML+jtswdYuwR8+DEf6ZnhxzZmrowV2s87FuBuEejl09hbNydJDfGW+ewAz5
         PTKx3jN2WY4g3hgeMQ/ja6NFBmKuIZ3CgfmO36Sefoiq2SBxzznv+Qv3+D3Qlv8780C3
         eI+GoV8QngGheMzShOWxVyQtLPv9+N5eo4X84RHONfn7ep5nIQcpbMerZ4UHZsXemIuw
         uPZQ==
X-Gm-Message-State: AOAM531GY7FI7KSzw7GlGYoeBzeOnDkmTg2g7srfaQgMtIj7/CpM/N/g
        3EfKKPcjgI/X15TLChWiND0Sl/u/H6J9Th+5G7gRcjXd
X-Google-Smtp-Source: ABdhPJzhCPD+ULq9Kf9LaBXjPuF6Q1TVXw91YqkYAm/K08MxTE63MuqRY4taH6CfFqU/U0XbCZRVnemjMOX7+He00iw=
X-Received: by 2002:a05:620a:119a:: with SMTP id b26mr9024269qkk.438.1615486334677;
 Thu, 11 Mar 2021 10:12:14 -0800 (PST)
MIME-Version: 1.0
References: <010201781d22d3e9-78ba2d74-fc45-4455-813d-367e789d3e9b-000000@eu-west-1.amazonses.com>
 <CAL3q7H79BO0qgTUVmbW2kzcUqtp4vgRLK8vNT95+Sz7tgWDdMQ@mail.gmail.com> <010201782276b01f-7930fadd-7b4b-4f45-bd66-6862adb594f4-000000@eu-west-1.amazonses.com>
In-Reply-To: <010201782276b01f-7930fadd-7b4b-4f45-bd66-6862adb594f4-000000@eu-west-1.amazonses.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 11 Mar 2021 18:12:03 +0000
Message-ID: <CAL3q7H4kfr=hyRQ4OaezoFVgsHEiyJoesxbDOVo7QdXuuked9g@mail.gmail.com>
Subject: Re: Multiple files with the same name in one directory
To:     Martin Raiber <martin@urbackup.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 11, 2021 at 6:05 PM Martin Raiber <martin@urbackup.org> wrote:
>
> On 11.03.2021 15:43 Filipe Manana wrote:
> > On Wed, Mar 10, 2021 at 5:18 PM Martin Raiber <martin@urbackup.org> wro=
te:
> >> Hi,
> >>
> >> I have this in a btrfs directory. Linux kernel 5.10.16, no errors in d=
mesg, no scrub errors:
> >>
> >> ls -lh
> >> total 19G
> >> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> >> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> >> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> >> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> >> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> >> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> >> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> >> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> >> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> >> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> >> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> >> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> >> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> >> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> >> ...
> >>
> >> disk_config.dat gets written to using fsync rename ( write new version=
 to disk_config.dat.new, fsync disk_config.dat.new, then rename to disk_con=
fig.dat -- it is missing the parent directory fsync).
> > That's interesting.
> >
> > I've just tried something like the following on 5.10.15 (and 5.12-rc2):
> >
> > create disk_config.dat
> > sync
> > for ((i =3D 0; i < 10; i++)); do
> >     create disk_config.dat.new
> >     write to disk_config.dat.new
> >     fsync disk_config.dat.new
> >     mv -f disk_config.dat.new disk_config.dat
> > done
> > <power fail>
> > mount fs
> > list directory
> >
> > I only get one file with the name disk_config.dat and one file with
> > the name disk_config.dat.new.
> > File disk_config.dat has the data written at iteration 9 and
> > disk_config.dat.new has the data written at iteration 10 (expected).
> >
> > You haven't mentioned, but I suppose you had a power failure / unclean
> > shutdown somewhere after an fsync, right?
> > Is this something you can reproduce at will?
>
> I think I rebooted via "echo b > /proc/sysrq-trigger". But at that point =
it probably didn't write to disk_config.dat anymore (for more than the comm=
it interval). I'm also not sure about the delay of me noticing those multip=
le files (since it doesn't cause any problems) -- can't reproduce.
>
> This is the same machine and file system with ENOSPC in btrfs_async_recla=
im_metadata_space -> flush_space -> btrfs_run_delayed_refs. Could be that s=
omething went wrong with the error handling/remount-ro w.r.t. to the tree l=
og?

It could be a bug between aborting a transaction (the error
handling/remount ro) and an fsync in progress yes.
I'll have to look at that and see if it's possible.

Thanks for the report.


>
> >
> >> So far no negative consequences... (except that programs might get con=
fused).
> >>
> >> echo 3 > /proc/sys/vm/drop_caches doesn't help.
> >>
> >> Regards,
> >> Martin Raiber
>
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
