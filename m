Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3DB8267F
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2019 23:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbfHEVAE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Aug 2019 17:00:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46001 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730036AbfHEVAE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Aug 2019 17:00:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so6811095wre.12
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Aug 2019 14:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9vocE39myszHyxQd5MFLurjPKevzVChf79OrWrbsKkM=;
        b=ktSWt8/JNZFvdzUpZUu6JwEV7iA+YMZHEEJBqMh/FmfgVjbSK4yLuiQuhXDDwt5Zlq
         YgJ01GfeYATkw0IDl1uu/xOqWXW/QRUIOX+h3RJGfQEF/eL7+9/S3vzaqIF+E9zYrQhV
         HEnYpJ9V7kBIBMROe9/Bdjgfk7wws+FwgvwRLZOA2qmYooL33UhCSJVOw7H/KGKEPQNI
         EgfOxZSowvFWIk6voVXJ09yggHQmtFubSkNsMdkDRoNus2HGOXgR3iDATbP1xGfnfa7H
         Wx6j9kRxHv0dQp05iKSBVA2HhJbU+qcz+rOtHIr/3pOo2qPPEbxXM41XkHhGX+NDlr15
         wneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9vocE39myszHyxQd5MFLurjPKevzVChf79OrWrbsKkM=;
        b=RKnihZvqOzEe6gwbee7mRv38wZxPgDd/zWwbP5QOFDEikLGF0kPK150mvf4sYRhh6L
         HHyR+Yi4ADpezoMV8CWTtFa8Ro9eA8EiMu/pAhgiGJLc/nXebixKPqh9v9kI+FjzqFVz
         U5UnfjVxkOn154bZimU24cJy3McR2a1MAYvcbEIwRcEPWtshGWiGfz0xe6Cgq7Y042Od
         TVEpJL7ff3KUq/lh32rAtN33R1C6Ldaj1aCLQYqw/ZEeacoc9wjDdU1mh0bKfH3G8jms
         qf6gsE6xxJeiGnWOGjjLx7R7gbQQ+C6g4mJtaDVAgtDzNA/VfuttVpANDJL2aWtxUJel
         tK2g==
X-Gm-Message-State: APjAAAVshGMqnqxPDZ5Q2TOh/WClB61JmG5UaZEL0GTY2vBiXeEPeKT/
        N/9HahQWjqEunP5T6uVJHZL9IpkLLnNpJRF5zFaXMDxy/zY=
X-Google-Smtp-Source: APXvYqxChBpsMUTJRuL1nMhgb4xQYVP++DPvPbrwuQ9DnmWR7aIfnHSJZZOG23hFKqVe1+wr/FJD5Vk2S6qWIu5KteI=
X-Received: by 2002:adf:dd01:: with SMTP id a1mr55491wrm.12.1565038802976;
 Mon, 05 Aug 2019 14:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAEg-Je9XTvEtg=Mpb1xKkO6Lzd3-yzSK7GcfbKH13uuf-u-wTA@mail.gmail.com>
 <CAJCQCtSPZwcg5y-d+mOhmyCdvq1dpzLUg05kPUg7CYhZp6Oz_Q@mail.gmail.com> <20190612095851.GG3563@twin.jikos.cz>
In-Reply-To: <20190612095851.GG3563@twin.jikos.cz>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 5 Aug 2019 14:59:51 -0600
Message-ID: <CAJCQCtQTk35fnaHLKhj9SLWVs=WftOJ11AxM-BN0Q-vARQ50SA@mail.gmail.com>
Subject: Re: APFS improvements (e.g. firm links, volume w/ subvols
 replication) as ideas for Btrfs?
To:     David Sterba <dsterba@suse.cz>, Josef Bacik <josef@toxicpanda.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 12, 2019 at 3:58 AM David Sterba <dsterba@suse.cz> wrote:
>
> On Tue, Jun 11, 2019 at 10:03:51PM -0600, Chris Murphy wrote:

> > There are a couple of things going on. One is something between VFS
> > and Btrfs does this goofy assumption that bind mounts are subvolumes,
> > which is definitely not true. I bring this up here:
> > https://lore.kernel.org/linux-btrfs/CAJCQCtT=-YoFJgEo=BFqfiPdtMoJCYR3dJPSekf+HQ22GYGztw@mail.gmail.com/
>
> The subvolumes build on top of the bind mount API internally but it is
> or should be a different kind of object.
>
> > Near as I can tell, Btrfs kernel code just needs to be smarter about
> > distinguishing between bind mounts of directories versus the behind
> > the scene bind mount used for subvolumes mounted using -o subvol= or
> > -o subvolid= ; I don't think that's difficult. It's just someone needs
> > to work through the logic and set aside the resources to do it.
>
> I tried to fix that and got half way through, then hit the difficult
> problems mainly with nested subvolumes. For leaf subvolumes, the
> difference between
>
>   subvolume/dir/dir/dir (bind mounted)
>
> and
>
>   subvolume (mounted with -o)
>
> is to traverse back the path until the subvolume is hit, which in both
> cases would be 'subvolume'. Howvever, with nested subvolumes it's not
> easy to see where to stop
>
>   subvol1/dir/dir/subvol2/dir/dir/subvol3/dir/dir
>
> and take 3 cases:
>
>   mount -o subvol=subvol1
>   mount -o subvol=subvol2
>   mount -o subvol=subvol3
>
> the backward path traversal will always say it's subvol3 (that's wrong
> from users POV). Keeping track of the exact subvolume that was mounted
> is not trivial because it partially has to duplicate the internal VFS
> information which makes it hard to keep consistent after moves.
>
> There was a concept proposal called 'fs view' that would add proper
> subvolume abstraction for subvolumes to VFS but I don't know how far
> this got.

I guess I'm curious why in these cases the subvolid number is correct
in mount and mountinfo, but the subvol name is wrong? And if it's not
just anomalous that the id is correct, why not just use that and do a
lookup of id to name instead of however the name is currently
determined?

-- 
Chris Murphy
