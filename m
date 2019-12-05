Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1388B114040
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 12:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbfLELnu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 06:43:50 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38922 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbfLELnt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Dec 2019 06:43:49 -0500
Received: by mail-ua1-f67.google.com with SMTP id r13so1112540uan.6
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Dec 2019 03:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=vAxgTXGqNq2jLaG5xmt3ahHVcWZLnmU99Qk1vBjmqWI=;
        b=CfL/kPmhXWjbK8TNfWw802AN1ufvtq275jRxwKJIxxnM/aEj0jy5fAgbER4IEomuWC
         Uuh4AwhxFENmNjPs4/2EVCOPQFgRur1h6N0kqJsNDJ4iAinqB9+SFrlih/Tdv07XF5em
         3XYSB8Mucq/pgZvReH5XYT53vPYTSpOTa4Qo3uzJiPAA8ca5pQSjaiSBx60aAIe8uUB9
         VtfULVE5v0C/y15QWWhDVSa899wm7NTq6LXVNNZwr8aZdUWbpiOVe8UZ//xjv4JF8yXL
         qWRBZW34NpqmjfM9vOzC5Ru1gxd6N/7nf+Nhzk5d1rfCgw+Ds//1jDTQ0E6KUhappKgf
         a3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=vAxgTXGqNq2jLaG5xmt3ahHVcWZLnmU99Qk1vBjmqWI=;
        b=IOwVSMy1A7U62dpYSbHVK5yAkYfE/ED07SOV1Ue10NFATZYKPi0Hr0993inP8TO4e5
         lZhIcdUVMg6zli7GCDQ4q+Tu4mIlHuBpw7fb1qAAfkmeAIEZl8DTEhciQAYP6Wapxup4
         Aelc/ouRMOM9KXXKsKrvBuHTpl4T2sMVFE0gXBaJ052IdAGDP8rLjHfVWPXxiCCUQABZ
         6I2y7sfilWXnfZ7YubWO7WqBJpe30XVckq4836mAXwZxcG0E/yV96o6dQgxxId4AF4iA
         G243/2e7pjl9sK0ECiMkSmncYknnsC2VPm3/EWhNcisJUKZeLt4EU3aNRE5fh5piNGnP
         07eA==
X-Gm-Message-State: APjAAAUkVik6fsjPbrZEWjf7J77h35HqaZYN1eLpHhkbEi8WHUsIS68f
        sBf2uxAdMwzZWV/6UprPBeYyOdz0Zw5BSfGR78g=
X-Google-Smtp-Source: APXvYqziX5ldHz1eaT134nfvo6tBJG3MfYCjy01iXl4BvqP80i2ADfeeEDefonLfxfU8haXM/h131t3K6uBwRzwO+ng=
X-Received: by 2002:a9f:3e84:: with SMTP id x4mr6718444uai.83.1575546227985;
 Thu, 05 Dec 2019 03:43:47 -0800 (PST)
MIME-Version: 1.0
References: <20191202094450.1377-1-anand.jain@oracle.com> <20191205113907.8269-1-anand.jain@oracle.com>
In-Reply-To: <20191205113907.8269-1-anand.jain@oracle.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 5 Dec 2019 11:43:37 +0000
Message-ID: <CAL3q7H635MDHBAEA0UZZKOn6kz=Hwna2YyM7RLZ=MbYqJOcimQ@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs: fix warn_on for send from readonly mount
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 5, 2019 at 11:39 AM Anand Jain <anand.jain@oracle.com> wrote:
>
> We log warning if root::orphan_cleanup_state is not set to
> ORPHAN_CLEANUP_DONE in btrfs_ioctl_send(). However if the filesystem is
> mounted as readonly we skip the orphan items cleanup during the lookup
> and root::orphan_cleanup_state remains at the init state 0 instead of
> ORPHAN_CLEANUP_DONE (2). So during send in btrfs_ioctl_send() we hit
> the warning as below.
>
>   WARN_ON(send_root->orphan_cleanup_state !=3D ORPHAN_CLEANUP_DONE);
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
> The warning exists because having orphan inodes could confuse send
> and cause it to fail or produce incorrect streams.
> The two cases that would cause such send failures, which are already
> fixed are:
>
> 1) Inodes that were unlinked - these are orphanized and remain with a lin=
k
> count of 0. These caused send operations to fail because it expected to
> always find at least one path for an inode. However this is no longer a
> problem since send is now able to deal with such inodes since commit
> 46b2f4590aab ("Btrfs: fix send failure when root has deleted files still
> open") and treats them as having been completely removed (the state after
> a orphan cleanup is performed).
>
> 2) Inodes that were in the process of being truncated. These resulted in
> send not knowing about the truncation and potentially issue write
> operations full of zeroes for the range from the new file size to the old
> file size. This is no longer a problem because we no longer create orphan
> items for truncation since commit f7e9e8fc792f ("Btrfs: stop creating
> orphan items for truncate").
>
> As such before these commits, the WARN_ON here provided a clue in case
> something went wrong. Instead of being a warning against the
> root::orphan_cleanup_state value, it could have been more accurate by
> checking if there were actually any orphan items, and then issue a warnin=
g
> only if any exists, but that would be more expensive to check. Since
> orphanized inodes no longer cause problems for send, just remove the warn=
ing.
>
> Reported-by: Christoph Anton Mitterer <calestyo@scientia.net>
> Link: https://lore.kernel.org/linux-btrfs/21cb5e8d059f6e1496a903fa7bfc0a2=
97e2f5370.camel@scientia.net/
> Suggested-by: Filipe Manana <fdmanana@gmail.com>

s/gmail.com/suse.com/
(David can probably do that when he picks the patch)

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks

> [ Remove warn_on() part, and its reasoning ]
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v3: Commit log updated.
> v2: Remove WARN_ON() completely.
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
