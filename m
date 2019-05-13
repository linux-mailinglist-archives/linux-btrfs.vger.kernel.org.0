Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D30321BB32
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2019 18:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbfEMQoI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 May 2019 12:44:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728109AbfEMQoI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 May 2019 12:44:08 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E09B2084E
        for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2019 16:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557765847;
        bh=9bFoseEdNucDWHno6S9iTT7VX4adhxHVLEuxUtjGvNk=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=KPlKkoRdsOHuXyxOtLh8Vt3urIU3ifeGuZCOoJkPbyaf2v99KOEclozy9Ut3u+ZV1
         aLolXY9NVIdw/6awxxJ44yenCqFPIyR8vXXo1f+mpIYFFwtfULQEBQ+JkrY/mn53Fz
         ZtN2VzyN83cW0w2JfOy8zxq6fBE8heM/SyWb/Wbc=
Received: by mail-vs1-f47.google.com with SMTP id j184so8417490vsd.11
        for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2019 09:44:07 -0700 (PDT)
X-Gm-Message-State: APjAAAVnUJmiM5NmfqsuZ4A2AFoP3ZOW6SntHqxHDy1mT1A4Yq7Tda+W
        6SX822UIorTWZhKcCCYEIi/dw2gd31Eqcsu5YjQ=
X-Google-Smtp-Source: APXvYqytO6uoDJ5kaAYg6O+fJRHgYclbHhrwzzxD6zW4Sjckidf9AHx8pUwnIF+miMbRcRbitpVEWqm0O07KvYAKZzw=
X-Received: by 2002:a67:8b44:: with SMTP id n65mr1130287vsd.99.1557765846436;
 Mon, 13 May 2019 09:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190422154409.16323-1-fdmanana@kernel.org> <20190513163216.GF3138@twin.jikos.cz>
In-Reply-To: <20190513163216.GF3138@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 13 May 2019 17:43:55 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4LD1F=D7ERBNTeSTBWUOTnTS-oyBoN3KVBV-uZ0t+QLg@mail.gmail.com>
Message-ID: <CAL3q7H4LD1F=D7ERBNTeSTBWUOTnTS-oyBoN3KVBV-uZ0t+QLg@mail.gmail.com>
Subject: Re: [PATCH] Btrfs: prevent send failures and crashes due to
 concurrent relocation
To:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 13, 2019 at 5:31 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, Apr 22, 2019 at 04:44:09PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > --- a/fs/btrfs/send.c
> > +++ b/fs/btrfs/send.c
> > @@ -6869,9 +6869,23 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
> >       if (ret)
> >               goto out;
> >
> > +     mutex_lock(&fs_info->balance_mutex);
> > +     if (test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags)) {
> > +             mutex_unlock(&fs_info->balance_mutex);
> > +             btrfs_warn_rl(fs_info,
> > +           "Can not run send because a balance operation is in progress");
> > +             ret = -EAGAIN;
> > +             goto out;
> > +     }
> > +     fs_info->send_in_progress++;
> > +     mutex_unlock(&fs_info->balance_mutex);
>
> This would be better in a helper that hides that the balance mutex from
> send.

Given the large number of cleanup patches that open code helpers that
had only one caller, this somewhat surprises me.
Same for the other similar comments below.

>
> eg.
>
>         if (!btrfs_send_can_start(fs_info)
>                 return -EAGAIN;
>
> > +
> >       current->journal_info = BTRFS_SEND_TRANS_STUB;
> >       ret = send_subvol(sctx);
> >       current->journal_info = NULL;
> > +     mutex_lock(&fs_info->balance_mutex);
> > +     fs_info->send_in_progress--;
> > +     mutex_unlock(&fs_info->balance_mutex);
>
>         btrfs_send_end();
>
> >       if (ret < 0)
> >               goto out;
> >
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index db934ceae9c1..8145b62e3912 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -4203,6 +4203,14 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
> >                          get_raid_name(meta_index), get_raid_name(data_index));
> >       }
> >
> > +     if (fs_info->send_in_progress) {
> > +             btrfs_warn_rl(fs_info,
> > +"Can not run balance while send operations are in progress (%d in progress)",
> > +                           fs_info->send_in_progress);
> > +             ret = -EAGAIN;
> > +             goto out;
> > +     }
>
> Similar here.
>
> As the operation compatibility is done on the filesystem level, it would
> be better to hide all the logic in helpers, now that there's more than
> the per-subvolume send_in_progress.
