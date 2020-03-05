Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A61417AD46
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2020 18:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgCERaG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Mar 2020 12:30:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:54014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbgCERaG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Mar 2020 12:30:06 -0500
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 214AA20637
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Mar 2020 17:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583429406;
        bh=TBkyLisp1uGK+ksyKyYsb3z8KBJnhZcNcrMya5lks/o=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=uYgLsk3/oK4u/0ZIinISQDcJeWmhNB8dcxBo7bvQqRIy+SImH68GHB9Kd6WoCnWfY
         AZufAGxMzkFCt4390IM+RH5vm4k9aC7JOtdybXfpPaA13L17jUuoSxmiUmgqbZ/wUs
         2IaiDdcLHPVoPW0T2davCqU4QTiamINk8qa8H5so=
Received: by mail-vs1-f50.google.com with SMTP id t12so4087732vso.13
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Mar 2020 09:30:06 -0800 (PST)
X-Gm-Message-State: ANhLgQ28DYs6VJGvDpaGA5uq2P/XtnxPbPifNsfWV4DiC3kSeAKaJMMx
        CZTgp3o5EwTjDJu+3ywELQXeyPxwhy1wezS4me0=
X-Google-Smtp-Source: ADFU+vtBKAYni8sE0KFhHbiZVKSd58V2wgJfve2mETVnRYbogcrI8QZvMvkQv72oAh59t8FQXxxEeKb+gm24205fOjU=
X-Received: by 2002:a05:6102:2268:: with SMTP id v8mr5860715vsd.90.1583429405201;
 Thu, 05 Mar 2020 09:30:05 -0800 (PST)
MIME-Version: 1.0
References: <20200224171327.3655282-1-fdmanana@kernel.org> <5e044000-09e8-ade1-69a6-44cfc59fdc48@toxicpanda.com>
 <CAL3q7H7twdkw1LphkCWexABjT=WGxKHQvq7hsq+99VF5KJE3Uw@mail.gmail.com>
 <20200305141959.GC2902@twin.jikos.cz> <CAL3q7H7v4iVheXM_hCt2jaK+JK360ZjA-Ff6FZTGOhm4Zho23w@mail.gmail.com>
 <20200305163850.GE2902@twin.jikos.cz>
In-Reply-To: <20200305163850.GE2902@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 5 Mar 2020 17:29:53 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7wQO3bwwa6So_9FDd7xzpTzN631MD9BzqzNF7nm4Jnpw@mail.gmail.com>
Message-ID: <CAL3q7H7wQO3bwwa6So_9FDd7xzpTzN631MD9BzqzNF7nm4Jnpw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] Btrfs: implement full reflink support for inline extents
To:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 5, 2020 at 4:39 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Thu, Mar 05, 2020 at 03:03:14PM +0000, Filipe Manana wrote:
> > On Thu, Mar 5, 2020 at 2:20 PM David Sterba <dsterba@suse.cz> wrote:
> > >
> > > On Thu, Mar 05, 2020 at 11:57:52AM +0000, Filipe Manana wrote:
> > > > So this actually isn't safe.
> > > >
> > > > It can bring back the race that leads to file extent items with
> > > > overlapping ranges. Not because of the hole detection part but because
> > > > of the part where we copy extent items from the fs/subvolume tree into
> > > > the log tree using btrfs_search_forward(), as we copy all extent
> > > > items, including the ones outside the fsync range - so we could race
> > > > in the same way as we did during hole detection with ordered extent
> > > > completion for ordered extents outside the range.
> > > >
> > > > I'll have to rework this a bit.
> > >
> > > Ok, I'll remove the branch from for-next. Thanks.
> >
> > Wrong thread, the comment was meant for:
> > https://patchwork.kernel.org/patch/11419793/
>
> Saw it just now and taht was a bit wtf if my mail did not make it
> through. So, reflink stays in for-next.

Nah, I just picked the wrong thread. V4 of the reflinks patchset is
good as far as I can tell.
Thanks.
