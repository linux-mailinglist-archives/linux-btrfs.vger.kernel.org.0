Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8961240B2D
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 18:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgHJQaU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 12:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgHJQaT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 12:30:19 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E0EC061756
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 09:30:19 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id r7so4519266vsq.5
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 09:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=BMwIaO4OCaqaTJsbr86ynZmy4GEQypp7zz2G6AEqhlc=;
        b=fUCZLKO8UZAV8jPGjjKm5YcbbKxiiIpCwo0dPEzczd5AQ9JDYNpcu0F3imejg4RZkm
         zDtW7LczMjjAFtDwbeFUl2X5UG+qOs1SwPLnnIbTtc5Cf4tSxZNRjjk6AUm1gXg72Pp9
         WmsZfc1qOPaZGtIs0MdDeW+Tg7Q6XlzD6HtPN63UWnhaNz0V6fUTANelxHj4zbSD1jX6
         xfPLuN1RuE0obGw/HNwmAJV9DDE8YPfLqHOzYT6rgioNgoBJF7VIAxmkaIh4pa2k/PF1
         RukNJil6cc5f5dXvpLmAr+VkYOBzzqprPUW+KEp+ppOdvwbst6RyH7RsWx6LEvKiFX4W
         Fuew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=BMwIaO4OCaqaTJsbr86ynZmy4GEQypp7zz2G6AEqhlc=;
        b=WDBPjYFmaqS6OJ8dVqe4sA3uml/DPWwp1GrSK5Uhjl2RkH822BbmZj7N+QrRJfY7dd
         kFUWAlZ7F2+Oo0dfu+LK3Z31+GhMIdLIbs/xaL8AM8ps7fDmEtA77cqpglDGjadAM9l+
         dUmHCE96rhtxa46VqCSx5McAbtM2aKcKpZAbbFeojety3RGeptjS2fF58w+QGqJELrxb
         JBSiyt2Vi+p+Djr7hyY+TummFbn2pZLCTPyZ7BDQL4RJZwNQB3XlEB9bA5suwAiHDoqx
         DZdKW3BACT7u9eIDXyq9/I/kfAGfyetTKwxXXTaHApGYBbb4IBfa4BvmvP2Jh+dCMc/u
         322Q==
X-Gm-Message-State: AOAM531U7ZLD9Ib9ML5jlpzxP/7091ymNBbe815dmmeGf8ThyEu+dd6Y
        R1AkS5NtHMPBs9EK6+dM10umeMY3U6Oph7qAzMY=
X-Google-Smtp-Source: ABdhPJyCf0NuVQLX/EHYIoqICtwXKptv1gIypJSnFKPPnEdtQYcvkUfdrScDPokCmmd0y+E0snxCR7lmzfKAsmSrae4=
X-Received: by 2002:a67:e40a:: with SMTP id d10mr19172184vsf.95.1597077017532;
 Mon, 10 Aug 2020 09:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200810154242.782802-1-josef@toxicpanda.com> <20200810154242.782802-2-josef@toxicpanda.com>
 <CAL3q7H6=9nz-srTGqJF6oVdikP8BXMJGGQQSgAjyrt+Nyw8eLg@mail.gmail.com>
In-Reply-To: <CAL3q7H6=9nz-srTGqJF6oVdikP8BXMJGGQQSgAjyrt+Nyw8eLg@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 10 Aug 2020 17:30:06 +0100
Message-ID: <CAL3q7H5b6+6_xPz=qRkv9EeKpnXFujNO8G+3R8TNW=0dj95i9A@mail.gmail.com>
Subject: Re: [PATCH 01/17] btrfs: drop path before adding new uuid tree entry
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 10, 2020 at 5:28 PM Filipe Manana <fdmanana@gmail.com> wrote:
>
> On Mon, Aug 10, 2020 at 4:44 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > With the conversion to the rwsemaphore I got the following lockdep spla=
t
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > WARNING: possible circular locking dependency detected
> > 5.8.0-rc7-00167-g0d7ba0c5b375-dirty #925 Not tainted
> > ------------------------------------------------------
> > btrfs-uuid/7955 is trying to acquire lock:
> > ffff88bfbafec0f8 (btrfs-root-00){++++}-{3:3}, at: __btrfs_tree_read_loc=
k+0x39/0x180
> >
> > but task is already holding lock:
> > ffff88bfbafef2a8 (btrfs-uuid-00){++++}-{3:3}, at: __btrfs_tree_read_loc=
k+0x39/0x180
> >
> > which lock already depends on the new lock.
> >
> > the existing dependency chain (in reverse order) is:
> >
> > -> #1 (btrfs-uuid-00){++++}-{3:3}:
> >        down_read_nested+0x3e/0x140
> >        __btrfs_tree_read_lock+0x39/0x180
> >        __btrfs_read_lock_root_node+0x3a/0x50
> >        btrfs_search_slot+0x4bd/0x990
> >        btrfs_uuid_tree_add+0x89/0x2d0
> >        btrfs_uuid_scan_kthread+0x330/0x390
> >        kthread+0x133/0x150
> >        ret_from_fork+0x1f/0x30
> >
> > -> #0 (btrfs-root-00){++++}-{3:3}:
> >        __lock_acquire+0x1272/0x2310
> >        lock_acquire+0x9e/0x360
> >        down_read_nested+0x3e/0x140
> >        __btrfs_tree_read_lock+0x39/0x180
> >        __btrfs_read_lock_root_node+0x3a/0x50
> >        btrfs_search_slot+0x4bd/0x990
> >        btrfs_find_root+0x45/0x1b0
> >        btrfs_read_tree_root+0x61/0x100
> >        btrfs_get_root_ref.part.50+0x143/0x630
> >        btrfs_uuid_tree_iterate+0x207/0x314
> >        btrfs_uuid_rescan_kthread+0x12/0x50
> >        kthread+0x133/0x150
> >        ret_from_fork+0x1f/0x30
> >
> > other info that might help us debug this:
> >
> >  Possible unsafe locking scenario:
> >
> >        CPU0                    CPU1
> >        ----                    ----
> >   lock(btrfs-uuid-00);
> >                                lock(btrfs-root-00);
> >                                lock(btrfs-uuid-00);
> >   lock(btrfs-root-00);
> >
> >  *** DEADLOCK ***
> >
> > 1 lock held by btrfs-uuid/7955:
> >  #0: ffff88bfbafef2a8 (btrfs-uuid-00){++++}-{3:3}, at: __btrfs_tree_rea=
d_lock+0x39/0x180
> >
> > stack backtrace:
> > CPU: 73 PID: 7955 Comm: btrfs-uuid Kdump: loaded Not tainted 5.8.0-rc7-=
00167-g0d7ba0c5b375-dirty #925
> > Hardware name: Quanta Tioga Pass Single Side 01-0030993006/Tioga Pass S=
ingle Side, BIOS F08_3A18 12/20/2018
> > Call Trace:
> >  dump_stack+0x78/0xa0
> >  check_noncircular+0x165/0x180
> >  __lock_acquire+0x1272/0x2310
> >  lock_acquire+0x9e/0x360
> >  ? __btrfs_tree_read_lock+0x39/0x180
> >  ? btrfs_root_node+0x1c/0x1d0
> >  down_read_nested+0x3e/0x140
> >  ? __btrfs_tree_read_lock+0x39/0x180
> >  __btrfs_tree_read_lock+0x39/0x180
> >  __btrfs_read_lock_root_node+0x3a/0x50
> >  btrfs_search_slot+0x4bd/0x990
> >  btrfs_find_root+0x45/0x1b0
> >  btrfs_read_tree_root+0x61/0x100
> >  btrfs_get_root_ref.part.50+0x143/0x630
> >  btrfs_uuid_tree_iterate+0x207/0x314
> >  ? btree_readpage+0x20/0x20
> >  btrfs_uuid_rescan_kthread+0x12/0x50
> >  kthread+0x133/0x150
> >  ? kthread_create_on_node+0x60/0x60
> >  ret_from_fork+0x1f/0x30
> >
> > This problem exists because we have two different rescan threads,
> > btrfs_uuid_scan_kthread which creates the uuid tree, and
> > btrfs_uuid_tree_iterate that goes through and updates or deletes any ou=
t
> > of date roots.  The problem is they both do things in different order.
> > btrfs_uuid_scan_kthread() reads the tree_root, and then inserts entries
> > into the uuid_root.  btrfs_uuid_tree_iterate() scans the uuid_root, but
> > then does a btrfs_get_fs_root() which can read from the tree_root.
>
> Ok, the get_fs_root() is through  btrfs_check_uuid_tree_entry().
>
> >
> > It's actually easy enough to not be holding the path in
> > btrfs_uuid_scan_kthread() when we add a uuid entry, as we already drop
> > it further down and re-start the search when we loop.  So simply move
> > the path release before we add our entry to the uuid tree.
> >
> > This also fixes a problem where we're holding a path open after we do
> > btrfs_end_transaction(), which has it's own problems.
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/volumes.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index d7670e2a9f39..3ac44dad58bb 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -4462,6 +4462,7 @@ int btrfs_uuid_scan_kthread(void *data)
> >                         goto skip;
> >                 }
> >  update_tree:
> > +               btrfs_release_path(path);
>
> We can actually do the release right after reading from the eb, so we
> avoid 3 path releases in different places.
> The end result would be:
>
> https://pastebin.com/2gH54HBw

Well, it should be https://pastebin.com/t5nDBhVR

>
> Either way, it looks good to me.
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>
> Thanks.
>
> >                 if (!btrfs_is_empty_uuid(root_item.uuid)) {
> >                         ret =3D btrfs_uuid_tree_add(trans, root_item.uu=
id,
> >                                                   BTRFS_UUID_KEY_SUBVOL=
,
> > @@ -4486,6 +4487,7 @@ int btrfs_uuid_scan_kthread(void *data)
> >                 }
> >
> >  skip:
> > +               btrfs_release_path(path);
> >                 if (trans) {
> >                         ret =3D btrfs_end_transaction(trans);
> >                         trans =3D NULL;
> > @@ -4493,7 +4495,6 @@ int btrfs_uuid_scan_kthread(void *data)
> >                                 break;
> >                 }
> >
> > -               btrfs_release_path(path);
> >                 if (key.offset < (u64)-1) {
> >                         key.offset++;
> >                 } else if (key.type < BTRFS_ROOT_ITEM_KEY) {
> > --
> > 2.24.1
> >
>
>
> --
> Filipe David Manana,
>
> =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you'=
re right.=E2=80=9D



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
