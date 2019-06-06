Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC9037521
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2019 15:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfFFNYt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jun 2019 09:24:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfFFNYt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Jun 2019 09:24:49 -0400
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAE8A20872
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2019 13:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559827488;
        bh=VZi6GkDDDzmSZVou0xXSk/lWtFjn467ltFARz8xX+fk=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=YwgtVGtmZ7VN9BOjT/yx1YyaJKYTmvtpyMCFNK1ywvJeYH5Qaqe4hW1CHXSaYdkJA
         I7Z76Pr4eu57FIZJzoyciOw9eQXiswK+zYKqgm0PUyzIyrZOJcApNHO+5YFfyVWVIj
         9iMXY9C5YX4aydtiz2tWvNkb6ISOlgm4d5pBCwyU=
Received: by mail-vs1-f51.google.com with SMTP id c24so1175853vsp.7
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Jun 2019 06:24:48 -0700 (PDT)
X-Gm-Message-State: APjAAAXNdEXcT2dy9+SYZgdng/SOT566P3nbrk2/odqvbBUc5N2LJz29
        Y4tgXVToiHMl7oDoTf7J2rG57dFHcWZogg9qQ8Y=
X-Google-Smtp-Source: APXvYqxEVGxUwGCvGaWtgjtwRUGwAq6dYUPWG53yKlOwiQbc7HBSFRlHfhjGDvuMXiyHMswcpii5JXs3GqsmIUuxRmA=
X-Received: by 2002:a67:de08:: with SMTP id q8mr6653798vsk.206.1559827487839;
 Thu, 06 Jun 2019 06:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190422154409.16323-1-fdmanana@kernel.org> <20190513163216.GF3138@twin.jikos.cz>
 <CAL3q7H4LD1F=D7ERBNTeSTBWUOTnTS-oyBoN3KVBV-uZ0t+QLg@mail.gmail.com> <20190513180012.GI3138@twin.jikos.cz>
In-Reply-To: <20190513180012.GI3138@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 6 Jun 2019 14:24:36 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4L=2SnzDJ+O8X7DojnucBgz2QZDN7xw4AtBdozUkKjWA@mail.gmail.com>
Message-ID: <CAL3q7H4L=2SnzDJ+O8X7DojnucBgz2QZDN7xw4AtBdozUkKjWA@mail.gmail.com>
Subject: Re: [PATCH] Btrfs: prevent send failures and crashes due to
 concurrent relocation
To:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 13, 2019 at 6:59 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, May 13, 2019 at 05:43:55PM +0100, Filipe Manana wrote:
> > On Mon, May 13, 2019 at 5:31 PM David Sterba <dsterba@suse.cz> wrote:
> > >
> > > On Mon, Apr 22, 2019 at 04:44:09PM +0100, fdmanana@kernel.org wrote:
> > > > From: Filipe Manana <fdmanana@suse.com>
> > > > --- a/fs/btrfs/send.c
> > > > +++ b/fs/btrfs/send.c
> > > > @@ -6869,9 +6869,23 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
> > > >       if (ret)
> > > >               goto out;
> > > >
> > > > +     mutex_lock(&fs_info->balance_mutex);
> > > > +     if (test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags)) {
> > > > +             mutex_unlock(&fs_info->balance_mutex);
> > > > +             btrfs_warn_rl(fs_info,
> > > > +           "Can not run send because a balance operation is in progress");
> > > > +             ret = -EAGAIN;
> > > > +             goto out;
> > > > +     }
> > > > +     fs_info->send_in_progress++;
> > > > +     mutex_unlock(&fs_info->balance_mutex);
> > >
> > > This would be better in a helper that hides that the balance mutex from
> > > send.
> >
> > Given the large number of cleanup patches that open code helpers that
> > had only one caller, this somewhat surprises me.
>
> Fair point, though I'd object that there are cases where the function
> name says in short what happens without the implementation details and
> this helps code readability. I struck me when I saw 'send_in_progress
> protected by balance_mutex'. You can find functions that are called just
> once, that's not an anti-pattern in general.
>
> I'll take a fresh look later, the setup phase of btrfs_ioctl_send is not
> exactly short so the added check does not stand out.

So, several weeks passed, and this prevents a quite serious bug from happening.
Any progress on that or was I supposed to do something about it?

Thanks.
