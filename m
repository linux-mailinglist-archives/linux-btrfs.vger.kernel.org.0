Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65D7E13CB1D
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2020 18:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgAORfF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 12:35:05 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38355 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgAORfE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 12:35:04 -0500
Received: by mail-vs1-f68.google.com with SMTP id v12so10947972vsv.5
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jan 2020 09:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=94b1+JKKzBEjrmofJ0dnfX7TxsGXMt+AWdMCK+aR1sQ=;
        b=tiFzDG8ddFFkC8JirXd+hRNuokxRGut+2TBGwn5gJnU7D/GbPZvQ/P9Uf5rF1f+sFe
         aUKXoHIY1QYgHhrVwmIxTs1NEFxnLbEHrPjHbLJMURAWPgJKXkZcYtr+huleCYWwqnOu
         tVMV5m/5ivKDlRlkf7m70+zWDFEpbejxjzHfmKPt8njjhE0HSjzZAnx+F7DvGEtHZVoU
         KicR8U7g9rnP+pO4K6YvD8AfvdrV4Cji4Bq/iQFvuKaB9y/wpHhgJQm/GgBuKatYy/oy
         FCwm2+fh5cMNPwlB2ZDgwCSR5AOvEuYUEJ6i8QXCShPOZUgpvj9xr16v6fwqZy2MDplo
         yEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=94b1+JKKzBEjrmofJ0dnfX7TxsGXMt+AWdMCK+aR1sQ=;
        b=lJnp4Yp5yMBTHgUCH+pkVJihNVuSJpd4iH52FwnBee+t2YuD2KSk/HwHOYvXN6SaBx
         aqvD9MQNrCBm2NgpggKUbDFr5/1YM6+7RFBdORRxG7KPrypAfopb2+9BpeKyl1GdoViB
         yUSz7dpBzp+8uM8KUY7XprZcqTqfLhROkqTU7wCR+dARvcADjhEgyh9eoKfZ7RWZU+mL
         NgzUTBYOTlFW3DI02iHjE04eefE7Epk8gMeRjms+ZH4sTaeE2Nu2m8wqGKw2pTv5La1p
         zi1DAHYknhhfjgGFMEk8/DxX/vJzujvNAlcR2DGIB14Wdm1MCv9PK3dTQg+z1CwkUus5
         fujA==
X-Gm-Message-State: APjAAAWIySQCk/jteefVExswD4bO06P/7mWzwEEiHqHgKbHvjlxEddkB
        4uIiHr8cL1W2LOyVyuTjqKIkXwKWyY02vCkDJAM=
X-Google-Smtp-Source: APXvYqzyGFkDOxhUp0ho5hIBvGQLw4ikazIe5rRiSGDxpgZIVMAsZOIEE7th10g95CDo11S3IWk/Ou/OANKt6iOCBao=
X-Received: by 2002:a67:f60e:: with SMTP id k14mr4863340vso.14.1579109703970;
 Wed, 15 Jan 2020 09:35:03 -0800 (PST)
MIME-Version: 1.0
References: <20200107194237.145694-1-josef@toxicpanda.com> <20200107194237.145694-4-josef@toxicpanda.com>
 <CAL3q7H6eDnVxVj7qE0Naw_VNzhQR=vvNGM+57kHrmx7vZSfsYQ@mail.gmail.com> <20374930-aa36-cd59-54e8-334b2ce8b58e@toxicpanda.com>
In-Reply-To: <20374930-aa36-cd59-54e8-334b2ce8b58e@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 15 Jan 2020 17:34:53 +0000
Message-ID: <CAL3q7H4+kard0WiLgLRYC4shCuwzSvY2LmDevjt6iT1Ex9cbMg@mail.gmail.com>
Subject: Re: [PATCH 3/5] btrfs: use the file extent tree infrastructure
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 15, 2020 at 5:20 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 1/15/20 12:12 PM, Filipe Manana wrote:
> > On Tue, Jan 7, 2020 at 7:43 PM Josef Bacik <josef@toxicpanda.com> wrote=
:
> >>
> >> We want to use this everywhere we modify the file extent items
> >> permanently.  These include
> >>
> >> 1) Inserting new file extents for writes and prealloc extents.
> >> 2) Truncating inode items.
> >> 3) btrfs_cont_expand().
> >> 4) Insert inline extents.
> >> 5) Insert new extents from log replay.
> >> 6) Insert a new extent for clone, as it could be past isize.
> >>
> >> We do not however call the clear helper for hole punching because it
> >> simply swaps out an existing file extent for a hole, so there's
> >> effectively no change as far as the i_size is concerned.
> >>
> >> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> >> ---
> >>   fs/btrfs/delayed-inode.c |  4 +++
> >>   fs/btrfs/file.c          |  6 ++++
> >>   fs/btrfs/inode.c         | 59 ++++++++++++++++++++++++++++++++++++++=
+-
> >>   fs/btrfs/tree-log.c      |  5 ++++
> >>   4 files changed, 73 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> >> index d3e15e1d4a91..8b4dcf4f6b3e 100644
> >> --- a/fs/btrfs/delayed-inode.c
> >> +++ b/fs/btrfs/delayed-inode.c
> >> @@ -1762,6 +1762,7 @@ int btrfs_fill_inode(struct inode *inode, u32 *r=
dev)
> >>   {
> >>          struct btrfs_delayed_node *delayed_node;
> >>          struct btrfs_inode_item *inode_item;
> >> +       struct btrfs_fs_info *fs_info =3D BTRFS_I(inode)->root->fs_inf=
o;
> >>
> >>          delayed_node =3D btrfs_get_delayed_node(BTRFS_I(inode));
> >>          if (!delayed_node)
> >> @@ -1779,6 +1780,9 @@ int btrfs_fill_inode(struct inode *inode, u32 *r=
dev)
> >>          i_uid_write(inode, btrfs_stack_inode_uid(inode_item));
> >>          i_gid_write(inode, btrfs_stack_inode_gid(inode_item));
> >>          btrfs_i_size_write(BTRFS_I(inode), btrfs_stack_inode_size(ino=
de_item));
> >> +       btrfs_inode_set_file_extent_range(BTRFS_I(inode), 0,
> >> +                                         round_up(i_size_read(inode),
> >> +                                                  fs_info->sectorsize=
));
> >
> > Why set it here when we have already done it at btrfs_read_locked_inode=
()?
> > This seems duplicated.
> >
>
> Because if btrfs_fill_inode() returns true it means we had a delayed inod=
e in
> memory still and we skip the reading of the inode off of disk, so it's an=
 either
> or case, not a duplicate.  Thanks,

Oh, yes, I missed that.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>
> Josef



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
