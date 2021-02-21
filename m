Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470663208A4
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Feb 2021 06:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbhBUFhb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 21 Feb 2021 00:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhBUFh1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 21 Feb 2021 00:37:27 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85D2C061574
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Feb 2021 21:36:46 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id o82so10559631wme.1
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Feb 2021 21:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rkjnsn-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MjOVsrkVVqXCATB2sf6xYv0Rmyf6ybiCEk4bAHcqZNk=;
        b=zuHxeVHlMQoaezfRsfWDRr6WKdXPm7ROq+IWqpyAGWchr0y3VSfNbSC5o4upvQDZ2Q
         ozJNmXB6vSsAf2dBCBbxeeyUSc6i1+aZvs29hWMI94auS74DmhqMK53qhqwlIlbP17Y4
         FnzxksIoHul8XIwPu2aJWzku4YLjhWks2Q7mUDU+jJNYPLqc6vg8KeVSP3JQ3auldvkb
         zB7qoMROxllC+FCCbxx7odZ4cOfjVFuqbrM1dbCxv3u7cmF3H6tspH2lh4hoFFmrp1g0
         f1h9aEv04piT4cry5EikYYFPXyVneW/R3GdIoK/dcAkXqvlYVX/Uu39yBaFhYXI/MvXh
         b6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MjOVsrkVVqXCATB2sf6xYv0Rmyf6ybiCEk4bAHcqZNk=;
        b=c2TZ0lRnestAK1gQAc9TfEWq8ToGkYZq6ZKrsZsTxy/YEgK32qxMtrUeI258atkgf2
         kLjwSHxyVrAkHU10KbXqOoGoQv073Caelc2UZQKCzSjjRx5W8+b+SDpa8dIp8l9vwsIc
         vyXk6hyNcDOHNLwJWy3VMEh+0HkchjPTRmxJqlz7mODYUOFxz3Y8WJM8tIATI4vaODOi
         Gr3Y+pjVRum9sT1vvZtB+n+s9ee4riokc0binMB+F+X41ubaW6E05gVt64ei8kcDwqkI
         yvP+R2yWPHOsKLZORD2qDHhRUUl/AWbDImgxzyGblN/C+wKTljEUNtg5R+NLWyWmTMdN
         IKrQ==
X-Gm-Message-State: AOAM531GmDeOo5wKrGN6sk+B74IssnU6FImM0gYRVNPT6hR3JipvpGL2
        TVV6RzyY7kZYJfdQ8SkR7eUpcvlcvCGB3itRgB97cDTZhO3w6oTi
X-Google-Smtp-Source: ABdhPJxQ7yHnW7VtzyWAftxKrzutURMD1NfyHc2z05HFHz8TgWl5At5+69nV+OxN8kKjixD/FtkRRHY7ToVv1Tkc46c=
X-Received: by 2002:a05:600c:35c2:: with SMTP id r2mr13490749wmq.54.1613885805170;
 Sat, 20 Feb 2021 21:36:45 -0800 (PST)
MIME-Version: 1.0
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <90ce8de3-c759-da91-f89e-3d1ac7b3d049@gmx.com> <2ac19a21-1674-b34a-7e0a-8a5744f0513a@gmx.com>
 <CAMj6ewPbivS1yZOmvT22hJsMxHGK-fWhyGgm3PJ4TVUbo04Eew@mail.gmail.com>
 <b06c1665-7547-2321-3863-4c68c9818f90@gmx.com> <CAMj6ewOze4Ngw7ydj_Ry2nLeyvWs_dB=fuGJ2zBdCEepTiC6yA@mail.gmail.com>
 <c6c8cb80-455a-181b-ada5-83001d387044@gmx.com> <CAMj6ewP-xUUa2G448HhPDPV9ZB7XiYVf4eCv+SMMtLH5MzTJ8g@mail.gmail.com>
 <08061b36-c49d-9604-49dc-7e85720b5040@gmx.com> <CAMj6ewM2wr2tRrMjRk+sztH0nD7RG1J4tXKfoekg3-rqEL3RWA@mail.gmail.com>
 <50599154-2ab4-2184-7562-f0758cf216eb@gmx.com> <CAMj6ewPGbkxH-OdsRt+xKQyLUUgR3J7dV7Xcf9XMq2-E=n3-tA@mail.gmail.com>
 <b040e855-c0a6-cd75-c26a-4ed73ffeb08d@gmx.com> <CAMj6ewOJpH_Lo3JcL540-ACwvbFNr33XS0LixEt+wAzf-T4vag@mail.gmail.com>
 <707ded00-c6e1-ba27-c12a-3ed7111620d8@gmx.com> <CAMj6ewON-ADoVKRL8yhy+vYaKoxGd=YwdpZkrDRRRG_8aOMjeA@mail.gmail.com>
 <aaf9f863-9f16-704f-9682-ac52626d0acc@gmx.com>
In-Reply-To: <aaf9f863-9f16-704f-9682-ac52626d0acc@gmx.com>
From:   Erik Jensen <erikjensen@rkjnsn.net>
Date:   Sat, 20 Feb 2021 21:36:33 -0800
Message-ID: <CAMj6ewMMwQFJKkQwziKFQmGVsTxi-cViijYTghhnahB=Gndcig@mail.gmail.com>
Subject: Re: "bad tree block start" when trying to mount on ARM
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Su Yue <l@damenly.su>, Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 19, 2021 at 10:01 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> On 2021/2/20 =E4=B8=8B=E5=8D=8812:28, Erik Jensen wrote:
> > [...]
> > Brainstorming some ideas, is compacting the address space something
> > that could be done offline? E.g., maybe some two-pass process: first
> > something balance-like that bumps all of the metadata up to a compact
> > region of address space, starting at a new 16TiB boundary, and then a
> > follow up pass that just strips the top bits off?
>
> We need btrfs-progs support for off-line balancing.
>
> I used to have this idea, but see very limited usage.
>
> This would be the safest bet, but needs a lot of work, although in user
> space.

Would any of the chunks have to actually be physically moved on disk
like happens in a real balance, or would it just be a matter of
adjusting the bytenrs in the relevant data structures? If the latter,
it seems like it could do something relatively straightforward like
start with the lowest in-use bytenr, adjust it to the first possible
bytenr, adjust the second-lowest to be just after it, et cetera.

While I'm sure this would still be a complex challenge, and would need
to take precautions like marking the filesystem unmountable while it's
working and keeping a journal of its progress in case of interruption,
maybe it'd less onerous than reimplementing all of the rebalance logic
in userspace?

> > Or maybe once all of the bytenrs are brought within 16TiB of each
> > other by balance, btrfs could just keep track of an offset that needs
> > to be applied when mapping page cache indexes?
>
> But further balance/new chunk allocation can still go beyond the limit.
>
> This is biggest problem other fs don't need to bother.
> We can dynamically allocate chunks while others can't.

That's true, but no more so than for the offline address-space
compaction option above, or for doing a backup, format, restore cycle.
Obviously it would be ideal if the issue didn't occur in the first
place, but given that it does, it would be nice if there was *some*
way to get the filesystem back into a usable state for a while at
least, even if it required temporarily hooking the drives up to a
64-bit system to do so.

Now, if I had known about the issue beforehand, I probably would have
unmounted the filesystem and used dd when changing my drive
encryption, rather than calling btrfs replace a bunch of times, in
which case I probably never would have triggered the issue in the
first place. :)

> > Or maybe btrfs could use multiple virtual inodes on 32-bit systems,
> > one for each 16TiB block of address space with metadata in it? If this
> > were to ever grow to need more than a handful of virtual inodes, it
> > seems like a balance *would* actually help in this case by compacting
> > the metadata higher in the address space, allowing the virtual inodes
> > for lower in the address space to be dropped.
>
> This may be a good idea.
>
> But the problem of test coverage is always here.
>
> We can spend tons of lines, but at the end it will not really be well
> tested, as it's really hard

I guess this would involve replacing btrfs_fs_info::btree_inode with
an xarray of inodes on 32-bit systems, and allocating inodes as
needed? It looks like inode structs have a lot going on, and I
definitely don't have the knowledge base to judge if this would be a
tractable change to implement or not. (E.g., would calling
new_inode(fs_info->sb) whenever needed cause any issues, or would it
just work as expected?) It looks like chunk metadata can span more
than one page, so another question is whether those can ever be
allocated such that they cross a 16 TiB boundary? If so, it appears
that would be much harder to try to make work. (Presumably such
boundary-spanning allocations could be prevented going forward, but
there could still be existing filesystems that would have to be
rejected.)

> > Or maybe btrfs could just not use the page cache for the metadata
> > inode once the offset exceeds 16TiB, and only cache at the block
> > layer? This would surely hurt performance, but at least the filesystem
> > could still be accessed.
>
> I don't believe it's really possible, unless we override the XArray
> thing provided by MM completely and implemented a btrfs only structure.
>
> That's too costy.

Makes sense.

> > Given that this issue appears to be not due to the size of the
> > filesystem, but merely how much I've used it, having the only solution
> > be to copy all of the data off, reformat the drives, and then restore
> > every time filesystem usage exceeds a certain thresholds is=E2=80=A6 no=
t very
> > satisfying.
>
> Yeah, definitely not a good experience.
>
> >
> > Finally, I've never done kernel dev before, but I do have some C
> > experience, so if there is a solution that falls into the category of
> > seeming reasonable, likely to be accepted if implemented, but being
> > unlikely to get implemented given the low priority of supporting
> > 32-bit systems, let me know and maybe I can carve out some time to
> > give it a try.
> >
> BTW, if you want things like 64K page size, while still keep the 4K
> sector size of your existing btrfs, then I guess you may be interested
> in the recent subpage support.
>
> Which allow btrfs to mount 4K sector size fs with 64K page size.
>
> Unfortunately it's still WIP, but may fit your usecase, as ARM support
> multiple page sizes (4K, 16K, 64K).
> (Although we are only going to support 64K page for now)

So, basically I'd need this change plus the Bootlin large page patch,
and then hope I never cross the 256 TiB mark for chunk metadata? (Or
at least, not until I find an AArch64 board that fits my needs.) Would
this conflict with your graceful error/warning patch at all? Is there
an easy way to see what my highest bytenr is today?

Also, I see read-only support went into 5.12. Do you have any idea
when write support will be ready for general use?

Thanks!
