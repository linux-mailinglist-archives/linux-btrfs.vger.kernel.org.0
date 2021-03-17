Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B5A33F460
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 16:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhCQPtW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 11:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbhCQPtH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 11:49:07 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14FBC061762
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Mar 2021 08:49:06 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 130so39287816qkh.11
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Mar 2021 08:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=9Uk5piFAma7oXWQtx7uU/9a9jR+YT/XdLz1LhXTLafY=;
        b=g+DGFrI9+B6kxRnXJ7wfINB3cAaMT1BdqlLldGeL0AEZu3fO2ny3HB47cMPHpg3DDT
         xs5puePgXThm+wXfqLG6yTJ0TpfA5RevjsJ+6QGb57gG2m5oKnTyKyooAd7JR9VEHYjf
         1fDogbaLscnmoYTcAa/vmcd0Ho++y31nVQNSHvTbr/ThEsEVMISqxgiTsxq+VZX0+3Zb
         2lONZBJfQMgBhiZMJwh540VJo1oyL14x3pfKfZW5hl7qkUruKPQ/n/j41AfwoGP6oWdG
         4kgcO+re0CqLTR6M31/E5BOEoiZyaFAKoeQVjIzjdDnt0aGB8lxIPfyKmwassFbzrVHU
         iaqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=9Uk5piFAma7oXWQtx7uU/9a9jR+YT/XdLz1LhXTLafY=;
        b=tzJlTArf/g1Hsb20bkCbP5KL3T1YMan9PaacMDDhmeDMH1MyvCpWMkCPn17yPnJqjw
         GXHZ69DkmjGYnrfGGJZkyjwPIfNqsmWHSj47czibGtR+zYEG/VeJmJhVuTz+p186ez12
         hCNfJ0Y+yV4sPj36V53cBKHxxe2u6RohEcFYhF342p31U+HwL4G1UGlr/OfhW8af9QKT
         wAj6CsfXvpVjxre5jpnGwS2XLr+wlbUkuV82FS0faR4W2S1WiFBtGDc2cZqeU5NPdf2L
         1N5r8hd6RADWWFaVuhtx6E58sf855MOfgWI3rowlXvelsadggo3qpWlI7VjQIkdAENCz
         GUvw==
X-Gm-Message-State: AOAM533ug0xFjTC6WJQpsQQPcR485sT+SU72JpkLM1oxmWflzvNjJIgQ
        qx8rH/ExS5lyDzjRXqqzBr9NFpgO7bgmdcVKqKq1/q2oxZ0=
X-Google-Smtp-Source: ABdhPJw/9qU3kbzzddwPcDvCkUxpGDWlOh5jP4TBFK5C/NSFZPO6S1IvFRRkkK8mkTuHqZzzhHR8X3nqjy6vpAm1EFc=
X-Received: by 2002:a37:a8d3:: with SMTP id r202mr5562846qke.383.1615995639953;
 Wed, 17 Mar 2021 08:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <321e2ff322469047563dfce030814d58a8632a60.1615977471.git.johannes.thumshirn@wdc.com>
 <CAL3q7H6rqxFu8TUcKNbr-h73Xa66xi3tgyT5A0Vyw5z3kYhq-A@mail.gmail.com> <PH0PR04MB7416DB1D352F9F2BB0BAA6DD9B6A9@PH0PR04MB7416.namprd04.prod.outlook.com>
In-Reply-To: <PH0PR04MB7416DB1D352F9F2BB0BAA6DD9B6A9@PH0PR04MB7416.namprd04.prod.outlook.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 17 Mar 2021 15:40:28 +0000
Message-ID: <CAL3q7H63Hjh+uhjMkgG56Vy7YMtWtuequWOfJ0_nD4+mkd0VZA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: zoned: automatically reclaim zones
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 17, 2021 at 3:31 PM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 17/03/2021 16:26, Filipe Manana wrote:
> >> +void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info)
> >> +{
> >> +       struct btrfs_block_group *bg;
> >> +       struct btrfs_space_info *space_info;
> >> +       int ret =3D 0;
> >> +
> >> +       if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
> >> +               return;
> >> +
> >> +       if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE))
> >> +               return;
> >> +
> >> +       mutex_lock(&fs_info->delete_unused_bgs_mutex);
> >> +       mutex_lock(&fs_info->reclaim_bgs_lock);
> >
> > Could we just use delete_unused_bgs_mutex? I think you are using it
> > only because btrfs_relocate_chunk() asserts it's being held.
> >
> > Just renaming delete_unused_bgs_mutex to a more generic name like
> > reclaim_bgs_lock, and just use that should work.
>
> Do I understand you correctly, that btrfs_delete_unused_bgs and btrfs_rec=
laim_bgs
> should use the same mutex? I was thinking about that but then didn't want=
 to
> have one mutex protecting two lists.

Correct, that's what I meant.

Since btrfs_delete_unused_bgs() and btrfs_reclaim_bgs() can never run
in parallel, and since they are already locking
delete_unused_bgs_mutex,
I don't see a reason not to do it.

The other cases that take the mutex, adding blocks groups to one of
the lists, are fast and are relatively rare specially for empty block
groups.

>
> >
> >> +       while (!list_empty(&fs_info->reclaim_bgs)) {
> >> +               bg =3D list_first_entry(&fs_info->reclaim_bgs,
> >> +                                     struct btrfs_block_group,
> >> +                                     bg_list);
> >> +               list_del_init(&bg->bg_list);
> >> +
> >> +               space_info =3D bg->space_info;
> >> +               mutex_unlock(&fs_info->reclaim_bgs_lock);
> >> +
> >> +               down_write(&space_info->groups_sem);
> >
> > Having a comment on why we lock groups_sem would be good to have, just
> > like at btrfs_delete_unused_bgs().
> >
>
> OK
>
> >> +
> >> +               spin_lock(&bg->lock);
> >> +               if (bg->reserved || bg->pinned || bg->ro ||
> >> +                   list_is_singular(&bg->list)) {
> >> +                       /*
> >> +                        * We want to bail if we made new allocations =
or have
> >> +                        * outstanding allocations in this block group=
.  We do
> >> +                        * the ro check in case balance is currently a=
cting on
> >> +                        * this block group.
> >
> > Why is the list_is_singular() check there?
> >
> > This was copied from the empty block group removal case -
> > btrfs_delete_unused_bgs(), but here I don't see why it's needed, since
> > we relocate rather than remove block groups.
> > The list_is_singular() from btrfs_delete_unused_bgs() is there to
> > prevent losing the raid profile for data when the last data block
> > group is removed (which implies not using space cache v1).
> >
> > Other than that, overall it looks good.
>
> Ah OK, yes this was a copy.
>
>
> >> +               /*
> >> +                * Reclaim block groups in the reclaim_bgs list after =
we deleted
> >> +                * all unused block_groups. This possibly gives us som=
e more free
> >> +                * space.
> >> +                */
> >> +               btrfs_reclaim_bgs(fs_info);
> >
> > Now with the cleaner kthread doing relocation, which can be a very
> > slow operation, we end up delaying iputs and other work delegated to
> > it for a very long time.
> > Not saying it needs to be fixed right away, perhaps it's not that bad,
> > I'm just not sure at the moment. We already do subvolume deletion in
> > this kthread, which is also a slow operation.
>
> Noted.



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
