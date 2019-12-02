Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11D8A10E980
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2019 12:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfLBLXu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Dec 2019 06:23:50 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39089 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfLBLXu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Dec 2019 06:23:50 -0500
Received: by mail-ua1-f65.google.com with SMTP id r13so11495171uan.6
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Dec 2019 03:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=QUyRpwQMuExYJkclYOoMZfxbeUy2m2FmAlGtgYbpZqQ=;
        b=egrNM0Hxo9TyGF4S79UQvgoHe1v4Dd3Ohxnvx/wU5wBgogRW91crOcIUQXeKrLeV7/
         529/bm0MbUZncTkc4AYJImfIOG/dRbhvadZSR5aa8bgJhLnJTXXCOVvqo02DgevQifhi
         hJECJG3AvIJLoOaSaQhZX31a5jy/Kve9uvxHJ1Ds0993sAAXtULCpPe7vCW/Sa75oCnD
         usWz4bjSMYNK1kwlUVc729by8noJ1EEFRQyD296lTkz4DUotYU6tCZjgaojBrDrkQ7yy
         NucTuV0P+FoOv5rGXh8CebUW8iWpLluiO6w293ixJclQfjZBgg6XUy/aLtmr8UcPnJAo
         L9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=QUyRpwQMuExYJkclYOoMZfxbeUy2m2FmAlGtgYbpZqQ=;
        b=KVePuzEqLLGArMuRx+YoQM6cOKevMi5ed5jzXvoAldT+xiVxWVCSJVxtVb1xp3Vdw6
         SOead8AP8SAbO4tTYolrDYLK13LudZIDVlfPJOrxra0cIcGrsFC8ZzPCmq3oxzthsNqo
         +QTOdnSxTB/CTydB7Sb3ESEaedT5BJ1W+sdoW72f4vfC+P5Wb7c0zqRqKbfCFmNDHq9b
         YgCZus+6kt6HmYEv8zU384ny3ZUK/2EiNnTYJ4T8tuilGSLY59uopER6eoouyIjGaZQG
         GME9tEdCMod8pBJ0cbnv003XY3K7pspbhOx9AqCClxyuaaHCN3XciQnhTBJ+dKQsi7nn
         eRZw==
X-Gm-Message-State: APjAAAWXuO7fJasS+xD+fiozkbXwbMFMyjcKgHmRTVpzemJs7K0m2vHs
        eHPyf8XrURrT8X1qzvKY4Dx0u8+j9DVWLwt1meY=
X-Google-Smtp-Source: APXvYqwDM2ST1Uq63E6hOywWOZu/rPXMksumQOw5jh9+H5RMOwy4Cl3kLUmkp+SrrO3Sshfz9s7cPRucjY3l5rd8bNs=
X-Received: by 2002:ab0:1492:: with SMTP id d18mr3262225uae.0.1575285827894;
 Mon, 02 Dec 2019 03:23:47 -0800 (PST)
MIME-Version: 1.0
References: <20191202094450.1377-1-anand.jain@oracle.com>
In-Reply-To: <20191202094450.1377-1-anand.jain@oracle.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 2 Dec 2019 11:23:36 +0000
Message-ID: <CAL3q7H7GyL2aY2mZ+hhR1CtEuiWi=Z0RwCgGgr39uWdKcYh5Ag@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix warn_on for send from readonly mount
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Christoph Anton Mitterer <calestyo@scientia.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 2, 2019 at 9:46 AM Anand Jain <anand.jain@oracle.com> wrote:
>
> We log warning if root::orphan_cleanup_state is not set to
> ORPHAN_CLEANUP_DONE in btrfs_ioctl_send(). However if the filesystem is
> mounted as readonly we skip the orphan items cleanup during the lookup
> and root::orphan_cleanup_state remains at the init state 0 instead of
> ORPHAN_CLEANUP_DONE (2).
>
> WARNING: CPU: 0 PID: 2616 at /Volumes/ws/btrfs-devel/fs/btrfs/send.c:7090=
 btrfs_ioctl_send+0xb2f/0x18c0 [btrfs]
> ::
> RIP: 0010:btrfs_ioctl_send+0xb2f/0x18c0 [btrfs]
> ::
> Call Trace:
> ::
> _btrfs_ioctl_send+0x7b/0x110 [btrfs]
> btrfs_ioctl+0x150a/0x2b00 [btrfs]
> ::
> do_vfs_ioctl+0xa9/0x620
> ? __fget+0xac/0xe0
> ksys_ioctl+0x60/0x90
> __x64_sys_ioctl+0x16/0x20
> do_syscall_64+0x49/0x130
> entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Reproducer:
>   mkfs.btrfs -fq /dev/sdb && mount /dev/sdb /btrfs
>   btrfs subvolume create /btrfs/sv1
>   btrfs subvolume snapshot -r /btrfs/sv1 /btrfs/ss1
>   umount /btrfs && mount -o ro /dev/sdb /btrfs
>   btrfs send /btrfs/ss1 -f /tmp/f
>
> Fix this by checking for the expected ORPHAN_CLEANUP_DONE only if the
> filesystem is in writable state.

I wonder if you know why the warning is there in the first place...

In my opinion we could remove the warning completely because:

1) Having orphan items means we could have files to delete (link count
of 0) and dealing with such cases could make send fail for several
reasons.
    If this happens, it's not longer a problem since the following commit:

    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D46b2f4590aab71d31088a265c86026b1e96c9de4

2) Orphan items used to indicate previously unfinished truncations, in
which case it would lead to send creating corrupt files at the
destination (i_size incorrect and the file filled with zeroes between
real i_size and stale i_size).
    We no longer need to create orphans for truncations since commit:

    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Df7e9e8fc792fe2f823ff7d64d23f4363b3f2203a

I think that information needs to be in the changelog. And, as said
before, I think the warning could go away completely.

Thanks.

>
> Reported-by: Christoph Anton Mitterer <calestyo@scientia.net>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/send.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index ae2db5eb1549..e3acec8aa8de 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -7085,9 +7085,11 @@ long btrfs_ioctl_send(struct file *mnt_file, struc=
t btrfs_ioctl_send_args *arg)
>
>         /*
>          * This is done when we lookup the root, it should already be com=
plete
> -        * by the time we get here.
> +        * by the time we get here, unless the filesystem is readonly whe=
re the
> +        * orphan_cleanup_state is never started.
>          */
> -       WARN_ON(send_root->orphan_cleanup_state !=3D ORPHAN_CLEANUP_DONE)=
;
> +       if (!sb_rdonly(file_inode(mnt_file)->i_sb))
> +               WARN_ON(send_root->orphan_cleanup_state !=3D ORPHAN_CLEAN=
UP_DONE);
>
>         /*
>          * Userspace tools do the checks and warn the user if it's
> --
> 2.23.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
