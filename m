Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C13110EC94
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2019 16:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfLBPme (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Dec 2019 10:42:34 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34639 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbfLBPme (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Dec 2019 10:42:34 -0500
Received: by mail-vs1-f65.google.com with SMTP id g15so134457vsf.1
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Dec 2019 07:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=XLtt0zHYW0DggB+BGYQaSsqJvNh352Kwrjrx5awlrjU=;
        b=bcE3tPpFgc6yti8eSuseEzP78BgphK0RS8ldBHWB0oyLFh8l1rPpws1Vt4zcHsZ71x
         n8CKRw0IfFLlqHCC5Qxb5Puo2LGNmipcop4wujEd+dqMr+tFhL8hKlAPV5qKe0RlDo20
         8QQBKlgB/zcSM9HyIFMMPrvlGsWZooD4Bhbx3fk2930Y9YPscLwGvf/2niIIKPbq6MJ7
         FlDaOGKmgH5izrWyyvPTsZCiWu2lbKXI1SIB153j4Id/J4a/wN1u4XIPBTaj7DGa9Zj0
         3zTq6nTHSl/scDPWP4kAe9O8cOBb3beURw3NJkbq00jsR3aYgcE7aYwWdLp9xcCWfP/R
         hVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=XLtt0zHYW0DggB+BGYQaSsqJvNh352Kwrjrx5awlrjU=;
        b=YqPRIxlUpMvSqYmeT/IB973VOytirsX55UbXttS2Lo4H+b9A0ctq6m4zn5QKbhU3k2
         b+lmmUo/dj4M3T5M14dKAHfXHYj95bk63p/I7w0lB1ZT9ZK88NzQ61CM+t+b8sVKZkuc
         DAJxszIj4+BcI7SPXd+bttWQuRHOQnx5he/88q4UZFisoWSquwfmnh51pTgIN8yHBf6Z
         oY8LdcsNtW/x8BhZDHDJ8op5vUbVrYtaemCKKl1/h0UNjvgn2nYfkuRavw+Aa2jjcx9G
         HvIemQ/HH2WKSv+D/zhVq5Z4DxO8vI94Kpi5IFwc3Z7uRkeawrbHrdsKJfnZTDgSMLT1
         s6qw==
X-Gm-Message-State: APjAAAXqry+IhvqKXKRUh/Y+Wrnh4io6TobYNkfpIL1InhL/l3RMS6TF
        KccrlS15tE60bYUaXYSIDqYrqlCst1qKcun6Zk8=
X-Google-Smtp-Source: APXvYqy09CToIy3HxbfLsUCYPdcUcjt0wKT+8qznhxLoSL8eI0cyaMNFCKjLwDCzpzqamxwrGf/p+/oXBMxmDYlk5aE=
X-Received: by 2002:a67:8703:: with SMTP id j3mr16889400vsd.99.1575301351989;
 Mon, 02 Dec 2019 07:42:31 -0800 (PST)
MIME-Version: 1.0
References: <20191202094450.1377-1-anand.jain@oracle.com> <1575296676-16470-1-git-send-email-anand.jain@oracle.com>
In-Reply-To: <1575296676-16470-1-git-send-email-anand.jain@oracle.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 2 Dec 2019 15:42:21 +0000
Message-ID: <CAL3q7H6n3Cwi6WobN1FY5ZZyhwGFLGvXbV5-Sp2q4=xGn6ZBLw@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: fix warn_on for send from readonly mount
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 2, 2019 at 2:26 PM Anand Jain <anand.jain@oracle.com> wrote:
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
> Fix this by removing the warn_on completely because:
>
> 1) Having orphan items means we could have files to delete (link count
> of 0) and dealing with such cases could make send fail for several
> reasons.
>    If this happens, it's not longer a problem since the following
> commit:
>    46b2f4590aab71d31088a265c86026b1e96c9de4
>    Btrfs: fix send failure when root has deleted files still open

The convention for mentioning commits is
first_12_or_slighly_more_hash_characters ("subject").
scripts/checkpatch.pl warns about it, and given this has been around
for years, you should already be familiar with it.

>
> 2) Orphan items used to indicate previously unfinished truncations, in
> which case it would lead to send creating corrupt files at the
> destination (i_size incorrect and the file filled with zeroes between
> real i_size and stale i_size).
>    We no longer need to create orphans for truncations since commit:
>    f7e9e8fc792fe2f823ff7d64d23f4363b3f2203a
>    Btrfs: stop creating orphan items for truncate

And I didn't expect you to literally copy-paste what I wrote before.
For a changelog we want something better written, organized and more
detailed then an informal e-mail reply, like this:

"
The warning exists because having orphanized inodes could confuse send
and cause it to fail or produce incorrect streams.
The two cases that would cause problems were:

1) Inodes that were unlinked - these are orphanized and remain with a
link count of 0, having no references (names).
   These caused send operations to fail because it expected to always
find at least one path for an inode.
   This is no longe a problem since send is now able to deal with such
inodes since
   commit 46b2f4590aab ("Btrfs: fix send failure when root has deleted
files still open") and treats them as having
   been completely removed (the state after a orphan cleanup is performed).

2) Inodes that were in the process of being truncated. These resulted
in send not knowing about the truncation
    and potentially issue write operations full of zeroes for the
range from the new file size to the old file size.
    This is no longer a problem because we no longer create orphan
items for truncations since
    commit  f7e9e8fc792f ("Btrfs: stop creating orphan items for truncate")=
.

In other words the warning was there to provide a clue in case
something went wrong. Instead of being a warning
against the root's "->orphan_cleanup_state" value, it could have been
more accurate by checking if there were actually
any orphan items, and then issue a warning only if any exists, but
that would be more expensive to check.
Since orphanized inodes no longer cause problems for send, just remove
the warning.
"

>
> Reported-by: Christoph Anton Mitterer <calestyo@scientia.net>
> Suggested-by: Filipe Manana <fdmanana@gmail.com>

Also s/@gmail.com/@suse.com/ (preferable).

Thanks.

> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2:
>  Remove WARN_ON() completely.
>
>  fs/btrfs/send.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index ae2db5eb1549..091e5bc8c7ea 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -7084,12 +7084,6 @@ long btrfs_ioctl_send(struct file *mnt_file, struc=
t btrfs_ioctl_send_args *arg)
>         spin_unlock(&send_root->root_item_lock);
>
>         /*
> -        * This is done when we lookup the root, it should already be com=
plete
> -        * by the time we get here.
> -        */
> -       WARN_ON(send_root->orphan_cleanup_state !=3D ORPHAN_CLEANUP_DONE)=
;
> -
> -       /*
>          * Userspace tools do the checks and warn the user if it's
>          * not RO.
>          */
> --
> 1.8.3.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
