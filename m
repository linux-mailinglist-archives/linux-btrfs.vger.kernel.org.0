Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A383D2656
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 17:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbhGVOVR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 10:21:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232537AbhGVORz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 10:17:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16C6661278
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jul 2021 14:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626965910;
        bh=qZdkRyyG8RttYl637tjZcmTeVJpnZB54jqutUjrIVZU=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=MapvPJ3deLSW10Pny7UpdgMcgOgxpi5KUIZqZpU7MNsGrBVvVHDU0ecWqUKUww2XU
         HniRXp/0dZN74QVXUJpFWRDxLEsov8QE/vr1m4LxGe+qP6EfXVyRupSAMoKi8pSUvD
         HX5zJC5Mt31uC5HaieB9RZtLnk3Rl4hLe9W4lYaHUsJxd1svbAw0F8HSyHoCG7x45C
         QNfHPnCw7RlC5FYsLvFgp+EeDnyTw8da5/9Dyg5Imir9Eq7/9YXeylObSgeAODykvm
         zzWZU505d9CQUXFZGUDQpPQA1LxMFcn8gJVgmhhWyFN96j71vOrdt9jldhj/Wc7NL8
         y/uhBTsTTyBYQ==
Received: by mail-qv1-f46.google.com with SMTP id o9so2716908qvu.5
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jul 2021 07:58:30 -0700 (PDT)
X-Gm-Message-State: AOAM530HncGzzuOBNeSKcloY23PWKbeZB4C6visz4o0aNd3BR5ausexs
        NbvWjosAXqpNo6EgjH4/5T9TatibnbV2B6O0jQs=
X-Google-Smtp-Source: ABdhPJw2dLzBNr3YBA/YvPMArZmxP/s9HZS4iAvHXIXxuIbtMKEB2SpuT/STpp8ZUkOYAnoSyoyhqzblrinwrBAjfNQ=
X-Received: by 2002:ad4:5227:: with SMTP id r7mr192482qvq.41.1626965909296;
 Thu, 22 Jul 2021 07:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <19938c9b47e3e14784c9d17f062da1a51261864f.1626885079.git.fdmanana@suse.com>
 <20210722132344.GT19710@twin.jikos.cz>
In-Reply-To: <20210722132344.GT19710@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 22 Jul 2021 15:58:18 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4n0FQK5kJyPirtzyPgvT67wgL=pe54=7O_6VXF2771PA@mail.gmail.com>
Message-ID: <CAL3q7H4n0FQK5kJyPirtzyPgvT67wgL=pe54=7O_6VXF2771PA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix lock inversion problem when doing qgroup
 extent tracing
To:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 22, 2021 at 2:26 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Jul 21, 2021 at 05:31:48PM +0100, fdmanana@kernel.org wrote:
> >  int btrfs_find_all_roots(struct btrfs_trans_handle *trans,
> >                        struct btrfs_fs_info *fs_info, u64 bytenr,
> >                        u64 time_seq, struct ulist **roots,
> > -                      bool ignore_offset)
> > +                      bool ignore_offset, bool skip_commit_root_sem)
>
> AFAICS, all callers pass false for ignore_offset, it's obvious from the
> patch that updated all call sites.
>
> > +     ret = btrfs_find_all_roots(NULL, trans->fs_info, bytenr, 0, &old_root,
> > +                                false, true);
>
> >                               ret = btrfs_find_all_roots(NULL, fs_info,
> >                                               record->bytenr, 0,
> > -                                             &record->old_roots, false);
> > +                                             &record->old_roots, false, false);
>
> >                       ret = btrfs_find_all_roots(trans, fs_info,
> > -                             record->bytenr, BTRFS_SEQ_LAST, &new_roots, false);
> > +                        record->bytenr, BTRFS_SEQ_LAST, &new_roots, false, false);
>
> >               ret = btrfs_find_all_roots(NULL, fs_info, found.objectid, 0,
> > -                                        &roots, false);
> > +                                        &roots, false, false);
>
> >       ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots,
> > -                     false);
> > +                     false, false);
>
> >       ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots,
> > -                     false);
> > +                     false, false);
>
> >       ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots,
> > -                     false);
> > +                     false, false);
>
> >       ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots,
> > -                     false);
> > +                     false, false);
>
> >       ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots,
> > -                     false);
> > +                     false, false);
>
> >       ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots,
> > -                     false);
> > +                     false, false);
>
> >       ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots,
> > -                     false);
> > +                     false, false);
>
> >       ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots,
> > -                     false);
> > +                     false, false);
>
> >       ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &old_roots,
> > -                     false);
> > +                     false, false);
>
> >       ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots,
> > -                     false);
> > +                     false, false);
>
> The ignore_offset was added for the BTRFS_IOC_LOGICAL_INO_V2 ioctl, but
> it's not used anywhere with btrfs_find_all_roots, only
> btrfs_find_all_roots_safe that does the lookup by find_parent_nodes and
> passed further to low level helpers.
>
> It's been there since c995ab3cda3f ("btrfs: add a flag to
> iterate_inodes_from_logical to find all extent refs for uncompressed
> extents"), and the parameter was added to btrfs_find_all_roots maybe for
> completeness but I'd rather remove it.
>
> As your patch is a fix and for stable@, the cleanup should be a
> followup.

Yes, agreed. Just sent out a patch for that.
Thanks.

>
> Added to misc-next, thanks.
