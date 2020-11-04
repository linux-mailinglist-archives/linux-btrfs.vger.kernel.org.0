Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27832A6BDB
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 18:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbgKDRgq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 12:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730254AbgKDRgq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Nov 2020 12:36:46 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B00C0613D3
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 09:36:46 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id o129so5251196ooo.11
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Nov 2020 09:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Jfl6pFhKpce4uT4ixb8fnp2LkzNG9KNTLwgoyo2OTKE=;
        b=GTzKXXphh4t+wkRp6MEQRRlvU/17f1IU0jjtxhvMfe8JWfS7hmqYJWAvYk6Fj8uO+e
         NCxE+fGCC92fSl9Lr1xqaToyiibJsD6NoBBgeYv2bULB/T6z8LLqDu3108ctQz98hCSA
         XNWQIKQnYz1a+IJ8eOkwZPsyTvY4IGd/Hcf1a0UzHbHukEqVWOvH5CyVtQkFiJlGOigy
         vHw9F+7axGAEcmpXXzNBnLbJuWICSZO6AmYvusA6gvnThe/AtuRD2X2xgx4KOKPxEcji
         vtnO5FpeLgmLq/VEX26TlwY5XQ5HlPhYlt4bBFFYem6Tlk51kh0QyaN7y1WMhGZtlJfb
         lmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jfl6pFhKpce4uT4ixb8fnp2LkzNG9KNTLwgoyo2OTKE=;
        b=Sxi+6IfUJ+wcl8bVDSwdxpLKd61kICMh/PiBvccAUfuaoSxPypJsJ4YvBi/onU57JH
         zBGQ3BRQDQco7TW4daUfVxPOHPRFDBAxRe+9fkAiH7TJTiylkD9lWXYuEdfEDM6Srtlh
         P4vhnciTWHUoG4BDadhGC3er1913OLcuerVLihPF2vnqUoMjq2NwgvD1OfTe6SApGPGK
         dbB/XVGQmiAiiivv/LPa5KfTMvs0DHfMEG+o8EYTi0UvUpJc3NIYJhOQAalP+s6nFosR
         AO2LsPkge6V/LBIJ0nc4YtTqQtcN0l6hsFthMumJUc1AlElrfo/49TS3lX4UkBAvOCT5
         rPbw==
X-Gm-Message-State: AOAM533ivgCGHl9G7o5ecn/+pWAqacXELffUVh7qMmy7aFT0XJyyqHq8
        Oq13mqOr4gsV62cZ6KK50oiVt20HXwn/IG7KmJa64aHixEU=
X-Google-Smtp-Source: ABdhPJwfNGJqQYi9icJE6tdAObR4x5e8qggX2x6ydIMxT7OUPxP6g9pmKjIXcCVSmNKQmnm1419Agx1QITqN1zNqqT8=
X-Received: by 2002:a4a:9cc3:: with SMTP id d3mr19435785ook.4.1604511405347;
 Wed, 04 Nov 2020 09:36:45 -0800 (PST)
MIME-Version: 1.0
References: <cover.1603460665.git.josef@toxicpanda.com> <afb3c72b04191707f96001bc3698e14b4d3400a8.1603460665.git.josef@toxicpanda.com>
 <CAL3q7H5ddLEFbisuFmauK9=XX+sEPy-O4R7X1kp67YH4N1hfcw@mail.gmail.com>
In-Reply-To: <CAL3q7H5ddLEFbisuFmauK9=XX+sEPy-O4R7X1kp67YH4N1hfcw@mail.gmail.com>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Wed, 4 Nov 2020 09:36:33 -0800
Message-ID: <CAE1WUT48tsn4KXqzi_YbbFC7f3PnpdEbjO=rvnRJcSVdMBuODw@mail.gmail.com>
Subject: Re: [PATCH 4/8] btrfs: cleanup btrfs_discard_update_discardable usage
To:     fdmanana@gmail.com
Cc:     Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 4, 2020 at 7:56 AM Filipe Manana <fdmanana@gmail.com> wrote:
>
> On Fri, Oct 23, 2020 at 5:12 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > This passes in the block_group and the free_space_ctl, but we can get
> > this from the block group itself.  Part of this is because we call it
> > from __load_free_space_cache, which can be called for the inode cache a=
s
> > well.  Move that call into the block group specific load section, wrap
> > it in the right lock that we need, and fix up the arguments to only tak=
e
> > the block group.  Add a lockdep_assert as well for good measure to make
> > sure we don't mess up the locking again.
>
> So this is actually 2 different things in one patch:
>
> 1) A cleanup to remove an unnecessary argument to
> btrfs_discard_update_discardable();
>
> 2) A bug because btrfs_discard_update_discardable() is not being
> called with the lock ->tree_lock held in one specific context.
>
> Shouldn't we really have this split in two patches?

Absolutely, yes. We should split this into two patches.

>
> Other than that, it looks good. Thanks.
>
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/discard.c          |  7 ++++---
> >  fs/btrfs/discard.h          |  3 +--
> >  fs/btrfs/free-space-cache.c | 14 ++++++++------
> >  3 files changed, 13 insertions(+), 11 deletions(-)
> >
> > diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> > index 741c7e19c32f..5a88b584276f 100644
> > --- a/fs/btrfs/discard.c
> > +++ b/fs/btrfs/discard.c
> > @@ -563,15 +563,14 @@ void btrfs_discard_calc_delay(struct btrfs_discar=
d_ctl *discard_ctl)
> >  /**
> >   * btrfs_discard_update_discardable - propagate discard counters
> >   * @block_group: block_group of interest
> > - * @ctl: free_space_ctl of @block_group
> >   *
> >   * This propagates deltas of counters up to the discard_ctl.  It maint=
ains a
> >   * current counter and a previous counter passing the delta up to the =
global
> >   * stat.  Then the current counter value becomes the previous counter =
value.
> >   */
> > -void btrfs_discard_update_discardable(struct btrfs_block_group *block_=
group,
> > -                                     struct btrfs_free_space_ctl *ctl)
> > +void btrfs_discard_update_discardable(struct btrfs_block_group *block_=
group)
> >  {
> > +       struct btrfs_free_space_ctl *ctl;
> >         struct btrfs_discard_ctl *discard_ctl;
> >         s32 extents_delta;
> >         s64 bytes_delta;
> > @@ -581,8 +580,10 @@ void btrfs_discard_update_discardable(struct btrfs=
_block_group *block_group,
> >             !btrfs_is_block_group_data_only(block_group))
> >                 return;
> >
> > +       ctl =3D block_group->free_space_ctl;
> >         discard_ctl =3D &block_group->fs_info->discard_ctl;
> >
> > +       lockdep_assert_held(&ctl->tree_lock);
> >         extents_delta =3D ctl->discardable_extents[BTRFS_STAT_CURR] -
> >                         ctl->discardable_extents[BTRFS_STAT_PREV];
> >         if (extents_delta) {
> > diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
> > index 353228d62f5a..57b9202f427f 100644
> > --- a/fs/btrfs/discard.h
> > +++ b/fs/btrfs/discard.h
> > @@ -28,8 +28,7 @@ bool btrfs_run_discard_work(struct btrfs_discard_ctl =
*discard_ctl);
> >
> >  /* Update operations */
> >  void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl);
> > -void btrfs_discard_update_discardable(struct btrfs_block_group *block_=
group,
> > -                                     struct btrfs_free_space_ctl *ctl)=
;
> > +void btrfs_discard_update_discardable(struct btrfs_block_group *block_=
group);
> >
> >  /* Setup/cleanup operations */
> >  void btrfs_discard_punt_unused_bgs_list(struct btrfs_fs_info *fs_info)=
;
> > diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> > index 5ea36a06e514..0787339c7b93 100644
> > --- a/fs/btrfs/free-space-cache.c
> > +++ b/fs/btrfs/free-space-cache.c
> > @@ -828,7 +828,6 @@ static int __load_free_space_cache(struct btrfs_roo=
t *root, struct inode *inode,
> >         merge_space_tree(ctl);
> >         ret =3D 1;
> >  out:
> > -       btrfs_discard_update_discardable(ctl->private, ctl);
> >         io_ctl_free(&io_ctl);
> >         return ret;
> >  free_cache:
> > @@ -929,6 +928,9 @@ int load_free_space_cache(struct btrfs_block_group =
*block_group)
> >                            block_group->start);
> >         }
> >
> > +       spin_lock(&ctl->tree_lock);
> > +       btrfs_discard_update_discardable(block_group);
> > +       spin_unlock(&ctl->tree_lock);
> >         iput(inode);
> >         return ret;
> >  }
> > @@ -2508,7 +2510,7 @@ int __btrfs_add_free_space(struct btrfs_fs_info *=
fs_info,
> >         if (ret)
> >                 kmem_cache_free(btrfs_free_space_cachep, info);
> >  out:
> > -       btrfs_discard_update_discardable(block_group, ctl);
> > +       btrfs_discard_update_discardable(block_group);
> >         spin_unlock(&ctl->tree_lock);
> >
> >         if (ret) {
> > @@ -2643,7 +2645,7 @@ int btrfs_remove_free_space(struct btrfs_block_gr=
oup *block_group,
> >                 goto again;
> >         }
> >  out_lock:
> > -       btrfs_discard_update_discardable(block_group, ctl);
> > +       btrfs_discard_update_discardable(block_group);
> >         spin_unlock(&ctl->tree_lock);
> >  out:
> >         return ret;
> > @@ -2779,7 +2781,7 @@ void __btrfs_remove_free_space_cache(struct btrfs=
_free_space_ctl *ctl)
> >         spin_lock(&ctl->tree_lock);
> >         __btrfs_remove_free_space_cache_locked(ctl);
> >         if (ctl->private)
> > -               btrfs_discard_update_discardable(ctl->private, ctl);
> > +               btrfs_discard_update_discardable(ctl->private);
> >         spin_unlock(&ctl->tree_lock);
> >  }
> >
> > @@ -2801,7 +2803,7 @@ void btrfs_remove_free_space_cache(struct btrfs_b=
lock_group *block_group)
> >                 cond_resched_lock(&ctl->tree_lock);
> >         }
> >         __btrfs_remove_free_space_cache_locked(ctl);
> > -       btrfs_discard_update_discardable(block_group, ctl);
> > +       btrfs_discard_update_discardable(block_group);
> >         spin_unlock(&ctl->tree_lock);
> >
> >  }
> > @@ -2885,7 +2887,7 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block=
_group *block_group,
> >                         link_free_space(ctl, entry);
> >         }
> >  out:
> > -       btrfs_discard_update_discardable(block_group, ctl);
> > +       btrfs_discard_update_discardable(block_group);
> >         spin_unlock(&ctl->tree_lock);
> >
> >         if (align_gap_len)
> > --
> > 2.26.2
> >
>
>
> --
> Filipe David Manana,
>
> =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you'=
re right.=E2=80=9D

Best regards,
Amy Parker
(they/them)
