Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0E5E4AC9
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2019 14:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504287AbfJYMLu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Oct 2019 08:11:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504278AbfJYMLt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Oct 2019 08:11:49 -0400
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ECF221929
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Oct 2019 12:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572005508;
        bh=hsHQOnuiFMtgWmEuNPY06AFIXmHuNaqu3NHBfyoB/iQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G06Z1ZsVV5G4zIlreqr6b3iqcA1u+kIyoMwlLv7TEXT2tC89TnwxnKPPefpnq3dHK
         f3CJXEjOqjL2KXZTRkbpqFBSLQoqxd2zN2C6Z9uZTK8Rg5TYL/mWRhc25tE8VxOQyy
         5fLTG1yguHsAvak/W58iq4KlgvpqBoxKsIPOkRNI=
Received: by mail-vk1-f171.google.com with SMTP id s129so412064vkh.0
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Oct 2019 05:11:48 -0700 (PDT)
X-Gm-Message-State: APjAAAUNyjXOX3HyeqU+RCoVicEYCrBRVnpPnaEf1oIACMrwup6r3l9X
        WGexNW5PpHaTy9Uo3DwZv8HTMWtVrRi90ABF7aM=
X-Google-Smtp-Source: APXvYqw4OmqAu9J8BV7kat0hZ426EWmnie7njcavwhWKuguw6V7Lbcp/0pnNJ1VC5/YiRUrAjmic5HKVM7aq3X8FWVo=
X-Received: by 2002:a1f:2a02:: with SMTP id q2mr1808288vkq.65.1572005507375;
 Fri, 25 Oct 2019 05:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20191025095242.15996-1-fdmanana@kernel.org> <20191025120843.ujydwo3w3twmdl3o@MacBook-Pro-91.local>
In-Reply-To: <20191025120843.ujydwo3w3twmdl3o@MacBook-Pro-91.local>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 25 Oct 2019 13:11:35 +0100
X-Gmail-Original-Message-ID: <CAL3q7H69tP1ipSqFF3yJYM3QVmH8U4sg_jp2zVC5uVFcVVCjTA@mail.gmail.com>
Message-ID: <CAL3q7H69tP1ipSqFF3yJYM3QVmH8U4sg_jp2zVC5uVFcVVCjTA@mail.gmail.com>
Subject: Re: [PATCH] Btrfs: remove unnecessary delalloc mutex for inodes
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 25, 2019 at 1:08 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Fri, Oct 25, 2019 at 10:52:42AM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > The inode delalloc mutex was added a long time ago by commit f248679e86fea
> > ("Btrfs: add a delalloc mutex to inodes for delalloc reservations"), and
> > the reason for its introduction is not very clear from the change log. It
> > claims it solves bogus warnings from lockdep, however it lacks an example
> > report/warning from lockdep, or any explanation.
> >
> > Since we have enough concurrentcy protection from the locks of the space
> > info and block reserve objects, and such lockdep warnings don't seem to
> > exist anymore (at least on a 5.3 kernel I couldn't get them with fstests,
> > ltp, fs_mark, etc), remove it, simplifying things a bit and decreasing
> > the size of the btrfs_inode structure. With some quick fio tests doing
> > direct IO and mmap writes I couldn't observe any significant performance
> > increase either (direct IO writes that don't increase the file's size
> > don't hold the inode's lock for their entire duration and mmap writes
> > don't hold the inode's lock at all), which are the only type of writes
> > that could see any performance gain due to less serialization.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> The problem was taking the i_mutex in mmap, which is how I was protecting
> delalloc reservations originally.  The delalloc mutex didn't come with all of
> the other dependencies.  That's what the lockdep messages were about, removing
> the lock isn't going to make them appear again.
>
> We _had_ to lock around this because we used to do tricks to keep from
> over-reserving, and if we didn't serialize delalloc reservations we'd end up
> with ugly accounting problems when we tried to clean things up.
>
> However with my recentish changes this isn't the case anymore.  Every operation
> is responsible for reserving its space, and then adding it to the inode.  Then
> cleaning up is straightforward and can't be mucked up by other users.  So we no
> longer need the delalloc mutex to safe us from ourselves.

Yes, thanks. That's what I thought, and couldn't see any reason for it
being needed given the current (much better) way of reserving space.

>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>
> Thanks,
>
> Josef
