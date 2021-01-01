Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD782E82EE
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Jan 2021 05:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbhAAEyy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Dec 2020 23:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbhAAEyy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Dec 2020 23:54:54 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8D6C061573
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Dec 2020 20:54:14 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id l200so23654401oig.9
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Dec 2020 20:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dk+qNsp9FvrShCWBPdlBOuD19HWMbI7ZbbJmudIvkvA=;
        b=TvPWo0Juqqb6iTE8xr/QDroMWBFM2o7ozTj7qSgu8Nu4QCo+IYbCmYxmoxZ6jSf/Su
         t0QPRLjxJDqi3aiVPMtu48JwVkjqHA6O9tQfKO1QDsvBy/A3JyAkg5DZSn/uCydFzL/T
         WWmBoqVag1lL2oDaa8otw9whyuI+Q3XU9nZ7Do+e1d0MzLfzPC2ImXtSj7ExEjZbnedH
         2/9yo3QIScfOfJktnP9JWKrzyTMS7m01X8qvXdg7AOtsdZRzfNyKFi9HxnIXgJEPL4gh
         CFa9ISCBJ0K/BQey2JyFt1vEvM8pT2gVpGpGyqO6OBhg1z2SwlQobfMWHevI7NKjpQhw
         oLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dk+qNsp9FvrShCWBPdlBOuD19HWMbI7ZbbJmudIvkvA=;
        b=txpbW3kavJ+J6PCPuu1hXyFp2AondeU9fvzMS56+hTGaE0ZgOHF9A7nCZiitJ1Gs5h
         haBuWGHwqCLXuZ7dP14rPDqDriXqRr7ti+snjtHwihMgL0SDv/w02NX1Uafyz/pbayBH
         bgLrUwnOLn1TRGHsVEm8+nazeGIvH+Q+zSEaLKDUzjj909FT2DxnC77yyHNTNB0ikjF9
         LI7P7coA4dwKqFaVwRFiksNN0SZtRqSVRkIaZltejO1qi+uj7s154n+744vjdeFDBv0Y
         IK7cfIMAFnsbUTGr4tZiHWiwvcqngRB0KIfalu4aGEuiEwE24GCXtpkCUePyQVCaxpbQ
         fPqQ==
X-Gm-Message-State: AOAM533F1bnLnobJYedXHTeGAkRTB6HG6x1g8BfbJLUgbJKcJiNHxfvx
        VWXvBiLFXkRwAZosxCY1vOhSm0bBg3H9pQ85Gq0=
X-Google-Smtp-Source: ABdhPJyQNmciIliWI3a2Q5RcVtvvcJyQNkB5fZK6cxFB084Uuc7534lzxhoRbXwznVvq5KOiZHQsrbYlaObqSXZqHfw=
X-Received: by 2002:a05:6808:3bc:: with SMTP id n28mr9892637oie.118.1609476853835;
 Thu, 31 Dec 2020 20:54:13 -0800 (PST)
MIME-Version: 1.0
References: <CANg_oxw16zS21c-XqpxdwY06E2bqgBgiFSJAHXkC9pS2d4ewQQ@mail.gmail.com>
 <c81089eb-2e1b-8cb4-d08e-5a858b56c9ec@lechevalier.se> <CANg_oxwKbzmMcz3590KhRz5eSgK+_s8thGio8q90KyDHm44Dow@mail.gmail.com>
 <f472181d-d6a4-f5f4-df7f-03bc7788b45a@gmail.com> <CANg_oxzP_Dzn89=4W_EZjGQWgB0CYsqyWMHN_3WzwebPVQChfg@mail.gmail.com>
 <20201231172812.GS31381@hungrycats.org> <CANg_oxw1Arpmkm+si_fUVzgEmVfF_UYy0Fc-d+AuMyK543W_Dw@mail.gmail.com>
 <d151361d-5865-f537-ba59-41e1cd3eb8ab@gmail.com> <CANg_oxztFRbw+NqHbnvvK6HS3g67hDkSgk6TpMbd-zgYSv9URw@mail.gmail.com>
 <20201231213650.GT31381@hungrycats.org>
In-Reply-To: <20201231213650.GT31381@hungrycats.org>
From:   john terragon <jterragon@gmail.com>
Date:   Fri, 1 Jan 2021 05:54:03 +0100
Message-ID: <CANg_oxzg8DD-0oxzD_18V-gGa7z3eFuffGuqbpGG-bL2oQ2-ag@mail.gmail.com>
Subject: Re: hierarchical, tree-like structure of snapshots
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        sys <system@lechevalier.se>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Although I'm glad that a bug has been uncovered, maybe it's best if I
stick with good old rsync for backups.
It would be kind of ironic if the first data loss that I experienced
in many years of btrfs use would be caused by an ancillary backup
tool.

On Thu, Dec 31, 2020 at 10:36 PM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> On Thu, Dec 31, 2020 at 09:48:54PM +0100, john terragon wrote:
> > On Thu, Dec 31, 2020 at 8:42 PM Andrei Borzenkov <arvidjaar@gmail.com> wrote:
> > >
> >
> > >
> > > How exactly you create subvolume with the same content? There are many
> > > possible interpretations.
> > >
> >
> > Zygo wrote that any subvol could be used with -p. So, out of
> > curiosity, I did the following
> >
> > 1) btrfs sub create X
> > 2) I unpacked some source (linux kernel) in X
> > 3) btrfs sub create W
> > 4) I unpacked the same source in W (so X and W have the same content
> > but they are independent)
> > 5) btrfs sub snap -r X X_RO
> > 6) btrfs sub snap -r W W_RO
> > 7) btrfs send W_RO | btrfs receive /mnt/btrfs2
> > 8) btrfs send -p W_RO X_RO | btrfs receive /mnt/btrfs2
> >
> > And this is the exact output of 8)
> >
> > At subvol X_RO
> > At snapshot X_RO
> > ERROR: chown o257-1648413-0 failed: No such file or directory
>
> Yeah, I only checked that send completed without error and produced a
> smaller stream.
>
> I just dumped the send metadata stream from the incremental snapshot now,
> and it's more or less garbage at the start:
>
>         # btrfs sub create A
>         # btrfs sub create B
>         # date > A/date
>         # date > B/date
>         # mkdir A/t B/u
>         # btrfs sub snap -r A A_RO
>         # btrfs sub snap -r B B_RO
>         # btrfs send A_RO | btrfs receive --dump
>         At subvol A_RO
>         subvol          ./A_RO                          uuid=995adde4-00ac-5e49-8c6f-f01743def072 transid=7329268
>         chown           ./A_RO/                         gid=0 uid=0
>         chmod           ./A_RO/                         mode=755
>         utimes          ./A_RO/                         atime=2020-12-31T15:51:31-0500 mtime=2020-12-31T15:51:48-0500 ctime=2020-12-31T15:51:48-0500
>         mkfile          ./A_RO/o257-7329268-0
>         rename          ./A_RO/o257-7329268-0           dest=./A_RO/date
>         utimes          ./A_RO/                         atime=2020-12-31T15:51:31-0500 mtime=2020-12-31T15:51:48-0500 ctime=2020-12-31T15:51:48-0500
>         write           ./A_RO/date                     offset=0 len=29
>         chown           ./A_RO/date                     gid=0 uid=0
>         chmod           ./A_RO/date                     mode=644
>         utimes          ./A_RO/date                     atime=2020-12-31T15:51:38-0500 mtime=2020-12-31T15:51:38-0500 ctime=2020-12-31T15:51:38-0500
>         mkdir           ./A_RO/o258-7329268-0
>         rename          ./A_RO/o258-7329268-0           dest=./A_RO/t
>         utimes          ./A_RO/                         atime=2020-12-31T15:51:31-0500 mtime=2020-12-31T15:51:48-0500 ctime=2020-12-31T15:51:48-0500
>         chown           ./A_RO/t                        gid=0 uid=0
>         chmod           ./A_RO/t                        mode=755
>         utimes          ./A_RO/t                        atime=2020-12-31T15:51:48-0500 mtime=2020-12-31T15:51:48-0500 ctime=2020-12-31T15:51:48-0500
>         # btrfs send B_RO -p A_RO | btrfs receive --dump
>         At subvol B_RO
>         snapshot        ./B_RO                          uuid=4aa7db26-b219-694e-9b3c-f8f737a46bdb transid=7329268 parent_uuid=995adde4-00ac-5e49-8c6f-f01743def072 parent_transid=7329268
>         utimes          ./B_RO/                         atime=2020-12-31T15:51:33-0500 mtime=2020-12-31T15:51:52-0500 ctime=2020-12-31T15:51:52-0500
>         link            ./B_RO/date                     dest=date
>         unlink          ./B_RO/date
>         utimes          ./B_RO/                         atime=2020-12-31T15:51:33-0500 mtime=2020-12-31T15:51:52-0500 ctime=2020-12-31T15:51:52-0500
>         write           ./B_RO/date                     offset=0 len=29
>         utimes          ./B_RO/date                     atime=2020-12-31T15:51:41-0500 mtime=2020-12-31T15:51:41-0500 ctime=2020-12-31T15:51:41-0500
>         rename          ./B_RO/t                        dest=./B_RO/u
>         utimes          ./B_RO/                         atime=2020-12-31T15:51:33-0500 mtime=2020-12-31T15:51:52-0500 ctime=2020-12-31T15:51:52-0500
>         utimes          ./B_RO/u                        atime=2020-12-31T15:51:52-0500 mtime=2020-12-31T15:51:52-0500 ctime=2020-12-31T15:51:52-0500
>         # btrfs send A_RO | btrfs receive -v /tmp/test
>         At subvol A_RO
>         At subvol A_RO
>         receiving subvol A_RO uuid=995adde4-00ac-5e49-8c6f-f01743def072, stransid=7329268
>         write date - offset=0 length=29
>         BTRFS_IOC_SET_RECEIVED_SUBVOL uuid=995adde4-00ac-5e49-8c6f-f01743def072, stransid=7329268
>         # btrfs send B_RO -p A_RO | btrfs receive -v /tmp/test
>         At subvol B_RO
>         At snapshot B_RO
>         receiving snapshot B_RO uuid=4aa7db26-b219-694e-9b3c-f8f737a46bdb, ctransid=7329268 parent_uuid=995adde4-00ac-5e49-8c6f-f01743def072, parent_ctransid=7329268
>         ERROR: link date -> date failed: File exists
>
> The btrfs_compare_trees function can handle arbitrary tree differences,
> but something happens in one of the support functions and we get a
> bogus link command.  The rest of the stream is OK though:  we fill
> in the contents of B_RO/date, rename A_RO/t to B_RO/u, and update all
> the timestamps.
>
> Oh well, I didn't say send didn't have any bugs.  ;)
