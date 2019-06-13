Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9B243E2D
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2019 17:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731745AbfFMPsB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jun 2019 11:48:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731742AbfFMJYR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jun 2019 05:24:17 -0400
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D201E21743
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2019 09:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560417857;
        bh=/Eh2g2POUo1j1OEjHp3862MXf69XGcC8IMeMRxFAqNM=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=q4k2suuZWKwo9N5QgHIECpefsXiAxqDc4Lkh550H6hB8LkEi5F8n+OUwVYLL4b55e
         l3FDWrWP4xwWhFIaRuJbBxhJnWAw5w/g4MY6rkCyWO1wEc25tVOv7dMO6689mjTW1h
         M2aU1Ps67INUq84l/BqMQ7daQcadzljOCe/EGfXA=
Received: by mail-ua1-f50.google.com with SMTP id j8so7036287uan.6
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2019 02:24:16 -0700 (PDT)
X-Gm-Message-State: APjAAAXJpYGyuyAyKVFQmZH9/T5/njbU+Eadil/y4oNQnh/VkLMbOO7z
        lBKrjLwvG1ZIakprtFXzOKq9iRrRQbKkW9Wyehw=
X-Google-Smtp-Source: APXvYqxYyNnJOcI1nClSedOuHsA/YB8YRIp79L8qOgExGwx2PrKUNfIJ1QcEz3FL9vOoKfSo+mQxf/BQsQdTzB9irJg=
X-Received: by 2002:ab0:5a64:: with SMTP id m33mr22536188uad.135.1560417856009;
 Thu, 13 Jun 2019 02:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190422154409.16323-1-fdmanana@kernel.org> <20190513163216.GF3138@twin.jikos.cz>
 <CAL3q7H4LD1F=D7ERBNTeSTBWUOTnTS-oyBoN3KVBV-uZ0t+QLg@mail.gmail.com>
 <20190513180012.GI3138@twin.jikos.cz> <CAL3q7H4L=2SnzDJ+O8X7DojnucBgz2QZDN7xw4AtBdozUkKjWA@mail.gmail.com>
In-Reply-To: <CAL3q7H4L=2SnzDJ+O8X7DojnucBgz2QZDN7xw4AtBdozUkKjWA@mail.gmail.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 13 Jun 2019 10:24:05 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7Z3VS7nu3f9NJSmERSgEC_3NLkLPy2vv8jQ7ci7dPe=A@mail.gmail.com>
Message-ID: <CAL3q7H7Z3VS7nu3f9NJSmERSgEC_3NLkLPy2vv8jQ7ci7dPe=A@mail.gmail.com>
Subject: Re: [PATCH] Btrfs: prevent send failures and crashes due to
 concurrent relocation
To:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 6, 2019 at 2:24 PM Filipe Manana <fdmanana@kernel.org> wrote:
>
> On Mon, May 13, 2019 at 6:59 PM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Mon, May 13, 2019 at 05:43:55PM +0100, Filipe Manana wrote:
> > > On Mon, May 13, 2019 at 5:31 PM David Sterba <dsterba@suse.cz> wrote:
> > > >
> > > > On Mon, Apr 22, 2019 at 04:44:09PM +0100, fdmanana@kernel.org wrote:
> > > > > From: Filipe Manana <fdmanana@suse.com>
> > > > > --- a/fs/btrfs/send.c
> > > > > +++ b/fs/btrfs/send.c
> > > > > @@ -6869,9 +6869,23 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
> > > > >       if (ret)
> > > > >               goto out;
> > > > >
> > > > > +     mutex_lock(&fs_info->balance_mutex);
> > > > > +     if (test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags)) {
> > > > > +             mutex_unlock(&fs_info->balance_mutex);
> > > > > +             btrfs_warn_rl(fs_info,
> > > > > +           "Can not run send because a balance operation is in progress");
> > > > > +             ret = -EAGAIN;
> > > > > +             goto out;
> > > > > +     }
> > > > > +     fs_info->send_in_progress++;
> > > > > +     mutex_unlock(&fs_info->balance_mutex);
> > > >
> > > > This would be better in a helper that hides that the balance mutex from
> > > > send.
> > >
> > > Given the large number of cleanup patches that open code helpers that
> > > had only one caller, this somewhat surprises me.
> >
> > Fair point, though I'd object that there are cases where the function
> > name says in short what happens without the implementation details and
> > this helps code readability. I struck me when I saw 'send_in_progress
> > protected by balance_mutex'. You can find functions that are called just
> > once, that's not an anti-pattern in general.
> >
> > I'll take a fresh look later, the setup phase of btrfs_ioctl_send is not
> > exactly short so the added check does not stand out.
>
> So, several weeks passed, and this prevents a quite serious bug from happening.
> Any progress on that or was I supposed to do something about it?
>
> Thanks.

Ping.
