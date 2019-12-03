Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56C6D10FCA3
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 12:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfLCLpu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Dec 2019 06:45:50 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44674 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCLpu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Dec 2019 06:45:50 -0500
Received: by mail-vs1-f66.google.com with SMTP id p6so2099778vsj.11
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Dec 2019 03:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=nnSkodAF2rEFKiOP2xjN5ff4jnGhe6TJzUp/lbvu8LE=;
        b=tcOWydzUhgPMEJlpelY+qmoMABIIxAARhxH1CAylhvLrIsYXRrdzqhvxjMWTuDcFlM
         xRTe/xzjm/oVtnx/UL5unNiV2jCm/gnNi8Q6KZQeaVGkM8UJSO1Kc4ROqyP9cJgP8H7W
         EpWrQL2M9A/02ItLrIINeYZpL316AyHvKMFwJpU72QMG5gFObDkbCCSZA6OOGQvKgQpD
         Gv94AON+XStE/p+RdeMZPLL1s2d91YWpV4wj+lO1QqeJ1Oe5IhlSFgjzcTYd/O8sTeM5
         26wpV4PFoDu2JINnPpQP50HfjvQWLmkiayqiXQID8k0xnWzwHuvJDi+FYD3EVMtERJ80
         kQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=nnSkodAF2rEFKiOP2xjN5ff4jnGhe6TJzUp/lbvu8LE=;
        b=j8ZhhAGsEXUyrooK/2+MLHidPw6vz9qbUtzCs/u+9R0iSaleX8VKzhoD5RpkMXoXLa
         c+cRxScZ1MYkHC/iCiulKuYy5yGu35+7eK6hOKrmlY94JyjPn0Zji7hpz8IqdC/AuClk
         Ihj8J8L0lWHgZeKQBVPddqhPKxbUne7qYkDG999gsE7LkAiSvJEvd7lT/LEST1ZUU5sL
         knSh/20SlN+IWEoFkuCkh4+uKflvQM+AP+pIgbDTiC3Ur/Aa+JWJGJWA6585+im4u8Ft
         DqM6xwuBTEHTfHmrtTDawWNM5qRamms79SIjNRiicDEWg6E5tvvaSL/9DPphs2ni0/uf
         whIQ==
X-Gm-Message-State: APjAAAXPWIY67vkptMdLG44Wi1GKuBhBhS9/J9njsaHi7IfRDfPGNxlj
        pXGG0o8KDeaS2sE02/Hpc7rf3n9/xlh4ebBPu7o=
X-Google-Smtp-Source: APXvYqxC005c1c5OG1HSrb145UjmrqF1NJZO0KmUuoGslAI7AyUivu4Sa0L9RdfH3/yp+yWkbdxuEbuNyhzepBmB/dk=
X-Received: by 2002:a05:6102:18f:: with SMTP id r15mr2517789vsq.206.1575373548613;
 Tue, 03 Dec 2019 03:45:48 -0800 (PST)
MIME-Version: 1.0
References: <20191202094450.1377-1-anand.jain@oracle.com> <1575296676-16470-1-git-send-email-anand.jain@oracle.com>
 <CAL3q7H6n3Cwi6WobN1FY5ZZyhwGFLGvXbV5-Sp2q4=xGn6ZBLw@mail.gmail.com> <3527299a-e707-e1c3-926a-1195f592f954@oracle.com>
In-Reply-To: <3527299a-e707-e1c3-926a-1195f592f954@oracle.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 3 Dec 2019 11:45:37 +0000
Message-ID: <CAL3q7H4EZWmqR8oe-Y2V_CZ2yfDZC42yfwMQuZeZHdQv7sQGeQ@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: fix warn_on for send from readonly mount
To:     Anand Jain <anandsuveer@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 2, 2019 at 11:59 PM Anand Jain <anandsuveer@gmail.com> wrote:
>
> On 12/2/19 11:42 PM, Filipe Manana wrote:
> > On Mon, Dec 2, 2019 at 2:26 PM Anand Jain <anand.jain@oracle.com> wrote=
:
> >>
> >> We log warning if root::orphan_cleanup_state is not set to
> >> ORPHAN_CLEANUP_DONE in btrfs_ioctl_send(). However if the filesystem i=
s
> >> mounted as readonly we skip the orphan items cleanup during the lookup
> >> and root::orphan_cleanup_state remains at the init state 0 instead of
> >> ORPHAN_CLEANUP_DONE (2).
> >>
> >> WARNING: CPU: 0 PID: 2616 at /Volumes/ws/btrfs-devel/fs/btrfs/send.c:7=
090 btrfs_ioctl_send+0xb2f/0x18c0 [btrfs]
> >> ::
> >> RIP: 0010:btrfs_ioctl_send+0xb2f/0x18c0 [btrfs]
> >> ::
> >> Call Trace:
> >> ::
> >> _btrfs_ioctl_send+0x7b/0x110 [btrfs]
> >> btrfs_ioctl+0x150a/0x2b00 [btrfs]
> >> ::
> >> do_vfs_ioctl+0xa9/0x620
> >> ? __fget+0xac/0xe0
> >> ksys_ioctl+0x60/0x90
> >> __x64_sys_ioctl+0x16/0x20
> >> do_syscall_64+0x49/0x130
> >> entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >>
> >> Reproducer:
> >>    mkfs.btrfs -fq /dev/sdb && mount /dev/sdb /btrfs
> >>    btrfs subvolume create /btrfs/sv1
> >>    btrfs subvolume snapshot -r /btrfs/sv1 /btrfs/ss1
> >>    umount /btrfs && mount -o ro /dev/sdb /btrfs
> >>    btrfs send /btrfs/ss1 -f /tmp/f
> >>
> >> Fix this by removing the warn_on completely because:
> >>
> >> 1) Having orphan items means we could have files to delete (link count
> >> of 0) and dealing with such cases could make send fail for several
> >> reasons.
> >>     If this happens, it's not longer a problem since the following
> >> commit:
> >>     46b2f4590aab71d31088a265c86026b1e96c9de4
> >>     Btrfs: fix send failure when root has deleted files still open
> >
> > The convention for mentioning commits is
> > first_12_or_slighly_more_hash_characters ("subject").
> > scripts/checkpatch.pl warns about it, and given this has been around
> > for years, you should already be familiar with it.
> >
> >>
> >> 2) Orphan items used to indicate previously unfinished truncations, in
> >> which case it would lead to send creating corrupt files at the
> >> destination (i_size incorrect and the file filled with zeroes between
> >> real i_size and stale i_size).
> >>     We no longer need to create orphans for truncations since commit:
> >>     f7e9e8fc792fe2f823ff7d64d23f4363b3f2203a
> >>     Btrfs: stop creating orphan items for truncate
> >
> > And I didn't expect you to literally copy-paste what I wrote before.
> > For a changelog we want something better written, organized and more
> > detailed then an informal e-mail reply, like this:
> >
> > "
> > The warning exists because having orphanized inodes could confuse send
> > and cause it to fail or produce incorrect streams.
> > The two cases that would cause problems were:
> >
> > 1) Inodes that were unlinked - these are orphanized and remain with a
> > link count of 0, having no references (names).
> >     These caused send operations to fail because it expected to always
> > find at least one path for an inode.
> >     This is no longe a problem since send is now able to deal with such
> > inodes since
> >     commit 46b2f4590aab ("Btrfs: fix send failure when root has deleted
> > files still open") and treats them as having
> >     been completely removed (the state after a orphan cleanup is perfor=
med).
> >
> > 2) Inodes that were in the process of being truncated. These resulted
> > in send not knowing about the truncation
> >      and potentially issue write operations full of zeroes for the
> > range from the new file size to the old file size.
> >      This is no longer a problem because we no longer create orphan
> > items for truncations since
> >      commit  f7e9e8fc792f ("Btrfs: stop creating orphan items for trunc=
ate")..
> >
> > In other words the warning was there to provide a clue in case
> > something went wrong. Instead of being a warning
> > against the root's "->orphan_cleanup_state" value, it could have been
> > more accurate by checking if there were actually
> > any orphan items, and then issue a warning only if any exists, but
> > that would be more expensive to check.
> > Since orphanized inodes no longer cause problems for send, just remove
> > the warning.
> > "
>
>   Ah. Generally your commits has the best change logs. Its very hard
>   to either match or satisfy your level. ;-). But I am trying and not
>   there yet.

Thank you, you flatter me.

If you send a new version, a link tag could also be added:

Link: https://lore.kernel.org/linux-btrfs/21cb5e8d059f6e1496a903fa7bfc0a297=
e2f5370.camel@scientia.net/

thanks

>
> Thanks. Anand
>
> >>
> >> Reported-by: Christoph Anton Mitterer <calestyo@scientia.net>
> >> Suggested-by: Filipe Manana <fdmanana@gmail.com>
> >
> > Also s/@gmail.com/@suse.com/ (preferable).
> >
> > Thanks.
> >
> >> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> >> ---
> >> v2:
> >>   Remove WARN_ON() completely.
> >>
> >>   fs/btrfs/send.c | 6 ------
> >>   1 file changed, 6 deletions(-)
> >>
> >> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> >> index ae2db5eb1549..091e5bc8c7ea 100644
> >> --- a/fs/btrfs/send.c
> >> +++ b/fs/btrfs/send.c
> >> @@ -7084,12 +7084,6 @@ long btrfs_ioctl_send(struct file *mnt_file, st=
ruct btrfs_ioctl_send_args *arg)
> >>          spin_unlock(&send_root->root_item_lock);
> >>
> >>          /*
> >> -        * This is done when we lookup the root, it should already be =
complete
> >> -        * by the time we get here.
> >> -        */
> >> -       WARN_ON(send_root->orphan_cleanup_state !=3D ORPHAN_CLEANUP_DO=
NE);
> >> -
> >> -       /*
> >>           * Userspace tools do the checks and warn the user if it's
> >>           * not RO.
> >>           */
> >> --
> >> 1.8.3.1
> >>
> >
> >
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
