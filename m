Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7B91BDC08
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Apr 2020 14:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgD2MX6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Apr 2020 08:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726686AbgD2MX5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Apr 2020 08:23:57 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A6FC03C1AD
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Apr 2020 05:23:56 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id e8so2172176ilm.7
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Apr 2020 05:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vxinJGtwcXn5tKMO5NhxhZ0ZiUcrBLA9oYXQOfTvEG8=;
        b=Yj/w+rhnxjvm3Djh29RtCCCBX/+t3qvMNYVvUccyuufbyofT1iLcScUtMSsnT55y/6
         DaWyVUxOja6E58gw9Ihu1S1vcQiFHsech4nFvG1dN6LgwUpOTnN60iRp/t3F+H+g+qBP
         OSvwoJYjzNmHcZ8jA8zbgtzPbyBMlfRJkq4cI07krnNe6NsMFA3ehtAbe8Pq7EX9oX3r
         ohfPxe0J6Z4yvNZ8+hNMXHFrSz41aPd9WsxfF8O0olQO1ytPrSJge+sczQiM1hBH9pyL
         smB2ey4fVLAbFJejpz/eDWwiXNbYiCAWfO+8JEU09y/crpiEx/d6F/e7spPqynWxoGc2
         l8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vxinJGtwcXn5tKMO5NhxhZ0ZiUcrBLA9oYXQOfTvEG8=;
        b=MDBJLjx/VuMvgKomoKznsdwE2/oVN0rE5oVGdOHCl17MiD8S0BOSD37Z+hr9soBd4v
         oaSEKO/l3SLp0vVtwaFxWOMclC7WYampiwJlZgB08eJ4p4pU2l/zLhy6dBq6AmSu9zh9
         Tc38nEW7YIqtt7QFFfdXObMeTWoprMtJXV8uv5bZNuoeyX0a/P54/528mWvtFcRASbF3
         EzS/sUPrE3ECJIEW3z9TTiESiEb5rB8oglDdCeg4igUCRsRRdGQcihX/S0VTFTBD5u8U
         XASE0VCwiul2tQyqlax2+Z01N1HGj3OoFwXTaMGtxWx6kXAyvP2qgygtQqLGnb0G5JRQ
         /rXA==
X-Gm-Message-State: AGi0Puag2HMRwXN+ufOr1KE2X3bOwwNqUXGcmOJ2n0X55qX9B3pttwpH
        43Vo1QDYeaWffnn8SEoKSiXNwoAM0Uk71PugVMrmU0TogW8=
X-Google-Smtp-Source: APiQypLp4iQw0cq7vD5yZtunHbWwB6L2uI97oZDCXNryvFjcrIr2wv8rI0ULEfXbUzqk2XNDiZhOzHcehTI6tnsEOSA=
X-Received: by 2002:a92:ce0d:: with SMTP id b13mr30415405ilo.55.1588163035628;
 Wed, 29 Apr 2020 05:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200411211414.GP13306@hungrycats.org> <b3e80e75-5d27-ec58-19af-11ba5a20e08c@gmx.com>
 <20200428045500.GA10769@hungrycats.org> <ea42b9cb-3754-3f47-8d3c-208760e1c2ac@gmx.com>
 <20200428145145.GB10796@hungrycats.org> <b1e24eb6-a8ee-dd87-b8b7-0c0e95b2a060@gmx.com>
In-Reply-To: <b1e24eb6-a8ee-dd87-b8b7-0c0e95b2a060@gmx.com>
From:   =?UTF-8?Q?Sebastian_D=C3=B6ring?= <moralapostel@gmail.com>
Date:   Wed, 29 Apr 2020 14:23:41 +0200
Message-ID: <CADkZQamNXN6NjBqxun=uupRX1mOKEYDyVN4-ow8Q1qWf=vQouA@mail.gmail.com>
Subject: Re: Balance loops: what we know so far
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I think I'm also running into this kind of balancing loop. I'm seeing
thousands of these repeating messages in syslog:


Apr 29 11:56:49 rockpro64 kernel: [12044.645247] BTRFS info (device
dm-3): found 36652 extents, stage: move data extents
Apr 29 11:56:49 rockpro64 kernel: [12045.134649] BTRFS info (device
dm-3): found 36652 extents, stage: move data extents
Apr 29 11:56:50 rockpro64 kernel: [12045.648773] BTRFS info (device
dm-3): found 36652 extents, stage: move data extents
Apr 29 11:56:50 rockpro64 kernel: [12046.172767] BTRFS info (device
dm-3): found 36652 extents, stage: move data extents
Apr 29 11:56:51 rockpro64 kernel: [12046.666079] BTRFS info (device
dm-3): found 36652 extents, stage: move data extents
Apr 29 11:56:51 rockpro64 kernel: [12047.199652] BTRFS info (device
dm-3): found 36652 extents, stage: move data extents


Can I help you to debug this in any way? I'm not too familiar with the
internal btrfs tools.

Best regards,
Sebastian


Am Mi., 29. Apr. 2020 um 07:36 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gmx.co=
m>:
>
>
>
> On 2020/4/28 =E4=B8=8B=E5=8D=8810:51, Zygo Blaxell wrote:
> > On Tue, Apr 28, 2020 at 05:54:21PM +0800, Qu Wenruo wrote:
> >>
> >>
> >> On 2020/4/28 =E4=B8=8B=E5=8D=8812:55, Zygo Blaxell wrote:
> >>> On Mon, Apr 27, 2020 at 03:07:29PM +0800, Qu Wenruo wrote:
> >>>>
> >>>>
> >>>> On 2020/4/12 =E4=B8=8A=E5=8D=885:14, Zygo Blaxell wrote:
> >>>>> Since 5.1, btrfs has been prone to getting stuck in semi-infinite l=
oops
> >>>>> in balance and device shrink/remove:
> >>>>>
> >>>>>   [Sat Apr 11 16:59:32 2020] BTRFS info (device dm-0): found 29 ext=
ents, stage: update data pointers
> >>>>>   [Sat Apr 11 16:59:33 2020] BTRFS info (device dm-0): found 29 ext=
ents, stage: update data pointers
> >>>>>   [Sat Apr 11 16:59:34 2020] BTRFS info (device dm-0): found 29 ext=
ents, stage: update data pointers
> >>>>>   [Sat Apr 11 16:59:34 2020] BTRFS info (device dm-0): found 29 ext=
ents, stage: update data pointers
> >>>>>   [Sat Apr 11 16:59:35 2020] BTRFS info (device dm-0): found 29 ext=
ents, stage: update data pointers
> >>>>>
> >>>>> This is a block group while it's looping, as seen by python-btrfs:
> >>>>>
> >>>>>   # share/python-btrfs/examples/show_block_group_contents.py 193491=
3175552 /media/testfs/
> >>>>>   block group vaddr 1934913175552 length 1073741824 flags DATA used=
 939167744 used_pct 87
> >> [...]
> >>>>>
> >>>>> All of the extent data backrefs are removed by the balance, but the
> >>>>> loop keeps trying to get rid of the shared data backrefs.  It has
> >>>>> no effect on them, but keeps trying anyway.
> >>>>
> >>>> I guess this shows a pretty good clue.
> >>>>
> >>>> I was always thinking about the reloc tree, but in your case, it's d=
ata
> >>>> reloc tree owning them.
> >>>
> >>> In that case, yes.  Metadata balances loop too, in the "move data ext=
ents"
> >>> stage while data balances loop in the "update data pointers" stage.
> >>
> >> Would you please take an image dump of the fs when runaway balance hap=
pened?
> >>
> >> Both metadata and data block group loop would greatly help.
> >
> > There's two problems with this:
> >
> >       1) my smallest test filesystems have 29GB of metadata,
> >
> >       2) the problem is not reproducible with an image.
>
> OK, then when such loop happened, what we need is:
> - Which block group is looping
>   Obviously
>
> - The extent tree dump of that block group
>   You have done a pretty good job on that.
>
> - Follow the backref to reach the root
>   In balance case, the offending backref should always using parent
>   bytenr, so you need to step by step to reach the root, which should
>   have backref points back to itself.
>
> - Root tree dump of the looping fs.
>   To find out which reloc tree it belongs to.
>   And show the ref number of that reloc tree.
>
> >
> > I've tried using VM snapshots to put a filesystem into a reproducible
> > looping state.  A block group that loops on one boot doesn't repeatably
> > loop on another boot from the same initial state; however, once a
> > booted system starts looping, it continues to loop even if the balance
> > is cancelled, and I restart balance on the same block group or other
> > random block groups.
> >
> > I have production filesystems with tens of thousands of block groups
> > and almost all of them loop (as I said before, I cannot complete any
> > RAID reshapes with 5.1+ kernels).  They can't _all_ be bad.
> >
> > Cancelling a balance (usually) doesn't recover.  Rebooting does.
> > The change that triggered this changes the order of operations in
> > the kernel.  That smells like a runtime thing to me.
> >
> >>>> In that case, data reloc tree is only cleaned up at the end of
> >>>> btrfs_relocate_block_group().
> >>>>
> >>>> Thus it is never cleaned up until we exit the balance loop.
> >>>>
> >>>> I'm not sure why this is happening only after I extended the lifespa=
n of
> >>>> reloc tree (not data reloc tree).
> >>>
> >>> I have been poking around with printk to trace what it's doing in the
> >>> looping and non-looping cases.  It seems to be very similar up to
> >>> calling merge_reloc_root, merge_reloc_roots, unset_reloc_control,
> >>> btrfs_block_rsv_release, btrfs_commit_transaction, clean_dirty_subvol=
s,
> >>> btrfs_free_block_rsv.  In the looping cases, everything up to those
> >>> functions seems the same on every loop except the first one.
> >>>
> >>> In the non-looping cases, those functions do something different than
> >>> the looping cases:  the extents disappear in the next loop, and the
> >>> balance finishes.
> >>>
> >>> I haven't figured out _what_ is different yet.  I need more cycles to
> >>> look at it.
> >>>
> >>> Your extend-the-lifespan-of-reloc-tree patch moves one of the
> >>> functions--clean_dirty_subvols (or btrfs_drop_snapshot)--to a differe=
nt
> >>> place in the call sequence.  It was in merge_reloc_roots before the
> >>> transaction commit, now it's in relocate_block_group after transactio=
n
> >>> commit.  My guess is that the problem lies somewhere in how the behav=
ior
> >>> of these functions has been changed by calling them in a different
> >>> sequence.
> >>>
> >>>> But anyway, would you like to give a try of the following patch?
> >>>> https://patchwork.kernel.org/patch/11511241/
> >>>
> >>> I'm not sure how this patch could work.  We are hitting the found_ext=
ents
> >>> counter every time through the loop.  It's returning thousands of ext=
ents
> >>> each time.
> >>>
> >>>> It should make us exit the the balance so long as we have no extra
> >>>> extent to relocate.
> >>>
> >>> The problem is not that we have no extents to relocate.  The problem =
is
> >>> that we don't successfully get rid of the extents we do find, so we k=
eep
> >>> finding them over and over again.
> >>
> >> That's very strange.
> >>
> >> As you can see, for relocate_block_group(), it will cleanup reloc tree=
s.
> >>
> >> This means either we have reloc trees in use and not cleaned up, or so=
me
> >> tracing mechanism is not work properly.
> >
> > Can you point out where in the kernel that happens?  If we throw some
> > printks at it we might see something.
>
> The merge happens at merge_reloc_roots().
> The cleanup happens at clean_dirty_subvols().
>
> In theory, all reloc trees will either marked as orphan (due to new
> changes in original subvolume) or merged in merge_reloc_roots(), and
> queued for cleanup.
> Then in clean_dirty_subvolumes() reloc trees all get cleaned up.
>
> If there are any reloc tree remaining after clean_dirty_subvolumes()
> then it could be the cause of such loop.
>
> Thanks,
> Qu
> >
> >> Anyway, if image dump with the dead looping block group specified, it
> >> would provide good hint to this long problem.
> >>
> >> Thanks,
> >> Qu
> >>
> >>>
> >>> In testing, the patch has no effect:
> >>>
> >>>     [Mon Apr 27 23:36:15 2020] BTRFS info (device dm-0): found 4800 e=
xtents, stage: update data pointers
> >>>     [Mon Apr 27 23:36:21 2020] BTRFS info (device dm-0): found 4800 e=
xtents, stage: update data pointers
> >>>     [Mon Apr 27 23:36:27 2020] BTRFS info (device dm-0): found 4800 e=
xtents, stage: update data pointers
> >>>     [Mon Apr 27 23:36:32 2020] BTRFS info (device dm-0): found 4800 e=
xtents, stage: update data pointers
> >>>     [Mon Apr 27 23:36:38 2020] BTRFS info (device dm-0): found 4800 e=
xtents, stage: update data pointers
> >>>     [Mon Apr 27 23:36:44 2020] BTRFS info (device dm-0): found 4800 e=
xtents, stage: update data pointers
> >>>     [Mon Apr 27 23:36:50 2020] BTRFS info (device dm-0): found 4800 e=
xtents, stage: update data pointers
> >>>     [Mon Apr 27 23:36:56 2020] BTRFS info (device dm-0): found 4800 e=
xtents, stage: update data pointers
> >>>     [Mon Apr 27 23:37:01 2020] BTRFS info (device dm-0): found 4800 e=
xtents, stage: update data pointers
> >>>     [Mon Apr 27 23:37:07 2020] BTRFS info (device dm-0): found 4800 e=
xtents, stage: update data pointers
> >>>     [Mon Apr 27 23:37:13 2020] BTRFS info (device dm-0): found 4800 e=
xtents, stage: update data pointers
> >>>     [Mon Apr 27 23:37:19 2020] BTRFS info (device dm-0): found 4800 e=
xtents, stage: update data pointers
> >>>     [Mon Apr 27 23:37:24 2020] BTRFS info (device dm-0): found 4800 e=
xtents, stage: update data pointers
> >>>     [Mon Apr 27 23:37:30 2020] BTRFS info (device dm-0): found 4800 e=
xtents, stage: update data pointers
> >>>
> >>> The above is the tail end of 3320 loops on a single block group.
> >>>
> >>> I switched to a metadata block group and it's on the 9th loop:
> >>>
> >>>     # btrfs balance start -mconvert=3Draid1 /media/testfs/
> >>>     [Tue Apr 28 00:09:47 2020] BTRFS info (device dm-0): found 34977 =
extents, stage: move data extents
> >>>     [Tue Apr 28 00:12:24 2020] BTRFS info (device dm-0): found 26475 =
extents, stage: move data extents
> >>>     [Tue Apr 28 00:18:46 2020] BTRFS info (device dm-0): found 26475 =
extents, stage: move data extents
> >>>     [Tue Apr 28 00:23:24 2020] BTRFS info (device dm-0): found 26475 =
extents, stage: move data extents
> >>>     [Tue Apr 28 00:25:54 2020] BTRFS info (device dm-0): found 26475 =
extents, stage: move data extents
> >>>     [Tue Apr 28 00:28:17 2020] BTRFS info (device dm-0): found 26475 =
extents, stage: move data extents
> >>>     [Tue Apr 28 00:30:35 2020] BTRFS info (device dm-0): found 26475 =
extents, stage: move data extents
> >>>     [Tue Apr 28 00:32:45 2020] BTRFS info (device dm-0): found 26475 =
extents, stage: move data extents
> >>>     [Tue Apr 28 00:37:01 2020] BTRFS info (device dm-0): found 26475 =
extents, stage: move data extents
> >>>
> >>>
> >>>> Thanks,
> >>>> Qu
> >>>>
> >>>>>
> >>>>> This is "semi-infinite" because it is possible for the balance to
> >>>>> terminate if something removes those 29 extents (e.g. by looking up=
 the
> >>>>> extent vaddrs with 'btrfs ins log' then feeding the references to '=
btrfs
> >>>>> fi defrag' will reduce the number of inline shared data backref obj=
ects.
> >>>>> When it's reduced all the way to zero, balance starts up again, usu=
ally
> >>>>> promptly getting stuck on the very next block group.  If the _only_
> >>>>> thing running on the filesystem is balance, it will not stop loopin=
g.
> >>>>>
> >>>>> Bisection points to commit d2311e698578 "btrfs: relocation: Delay r=
eloc
> >>>>> tree deletion after merge_reloc_roots" as the first commit where th=
e
> >>>>> balance loops can be reproduced.
> >>>>>
> >>>>> I tested with commit 59b2c371052c "btrfs: check commit root generat=
ion
> >>>>> in should_ignore_root" as well as the rest of misc-next, but the ba=
lance
> >>>>> loops are still easier to reproduce than to avoid.
> >>>>>
> >>>>> Once it starts happening on a filesystem, it seems to happen very
> >>>>> frequently.  It is not possible to reshape a RAID array of more tha=
n a
> >>>>> few hundred GB on kernels after 5.0.  I can get maybe 50-100 block =
groups
> >>>>> completed in a resize or balance after a fresh boot, then balance g=
ets
> >>>>> stuck in loops after that.  With the fast balance cancel patches it=
's
> >>>>> possibly to recover from the loop, but futile, since the next balan=
ce
> >>>>> will almost always also loop, even if it is passed a different bloc=
k
> >>>>> group.  I've had to downgrade to 5.0 or 4.19 to complete any RAID
> >>>>> reshaping work.
> >>>>>
> >>>>
> >>>
> >>>
> >>>
> >>
> >
> >
> >
>
