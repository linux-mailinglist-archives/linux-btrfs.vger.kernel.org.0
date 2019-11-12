Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 215C3F9761
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2019 18:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfKLRkN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Nov 2019 12:40:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:33126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbfKLRkN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Nov 2019 12:40:13 -0500
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C74AF21A49
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2019 17:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573580411;
        bh=v4hpnraotvgUjGjxkfP2nck6+g4eiwEFQlho/qAQ1Ys=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JjxeRPp1AD9qvbc+pYaUQf16owtPVidOUS8kV/hOrk25VZmevpaA/IsAX1xr5jo5h
         fcwOYwrWvwOkvApFzNDGL1Y/8ObbDsIR8cROtRiFeHBckhjUNxXZms3BfZJ9bB0/qi
         2BZLNcgPJIs2HJDFwqetxM1UGyYRGaRhh+dn6VZQ=
Received: by mail-ua1-f47.google.com with SMTP id i31so4974655uae.13
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2019 09:40:11 -0800 (PST)
X-Gm-Message-State: APjAAAWcOuhCT8BRWCNCWPGDpVuLLXwwCmo07xjB1u97WS6hkYmuovpA
        qEJHKiD9PX2dwWce1WDf95lMyAzvGoHEbT/4SuI=
X-Google-Smtp-Source: APXvYqyS7HOYphBNVWErbALvEmhV2DOnM92hkY5V+mdPsZD9P8Hy9EwSvMxuL6/5WD8DHy+sIrf13c91TkFHu1GWuhA=
X-Received: by 2002:ab0:6842:: with SMTP id a2mr4999003uas.0.1573580410807;
 Tue, 12 Nov 2019 09:40:10 -0800 (PST)
MIME-Version: 1.0
References: <20191112151331.3641-1-fdmanana@kernel.org> <20191112173459.7c6piekqjfjidjon@macbook-pro-91.dhcp.thefacebook.com>
In-Reply-To: <20191112173459.7c6piekqjfjidjon@macbook-pro-91.dhcp.thefacebook.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 12 Nov 2019 17:39:59 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4rdkfpdsdq4k75Yn+wibOxXnWsmVxTeaXNPAHZ6t7cvQ@mail.gmail.com>
Message-ID: <CAL3q7H4rdkfpdsdq4k75Yn+wibOxXnWsmVxTeaXNPAHZ6t7cvQ@mail.gmail.com>
Subject: Re: [PATCH] Btrfs: fix missing hole after hole punching and fsync
 when using NO_HOLES
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 12, 2019 at 5:35 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Tue, Nov 12, 2019 at 03:13:31PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When using the NO_HOLES feature, if we punch a hole into a file and then
> > fsync it, there is a case where a subsequent fsync will miss the fact that
> > a hole was punched:
> >
> > 1) The extent items of the inode span multiple leafs;
> >
> > 2) The hole covers a range that affects only the extent items of the first
> >    leaf;
> >
> > 3) The fsync operation is done in full mode (BTRFS_INODE_NEEDS_FULL_SYNC
> >    is set in the inode's runtime flags).
> >
> > That results in the hole not existing after replaying the log tree.
> >
> > For example, if the fs/subvolume tree has the following layout for a
> > particular inode:
> >
> >   Leaf N, generation 10:
> >
> >   [ ... INODE_ITEM INODE_REF EXTENT_ITEM (0 64K) EXTENT_ITEM (64K 128K) ]
> >
> >   Leaf N + 1, generation 10:
> >
> >   [ EXTENT_ITEM (128K 64K) ... ]
> >
> > If at transaction 11 we punch a hole coverting the range [0, 128K[, we end
> > up dropping the two extent items from leaf N, but we don't touch the other
> > leaf, so we end up in the following state:
> >
> >   Leaf N, generation 11:
> >
> >   [ ... INODE_ITEM INODE_REF ]
> >
> >   Leaf N + 1, generation 10:
> >
> >   [ EXTENT_ITEM (128K 64K) ... ]
> >
> > A full fsync after punching the hole will only process leaf N because it
> > was modified in the current transaction, but not leaf N + 1, since it was
> > not modified in the current transaction (generation 10 and not 11). As
> > a result the fsync will not log any holes, because it didn't process any
> > leaf with extent items.
> >
> > So fix this by detecting any leading hole in the file for a full fsync
> > when using the NO_HOLES feature if we didn't process any extent items for
> > the file.
> >
> > A test case for fstests follows soon.
> >
> > Fixes: 16e7549f045d33 ("Btrfs: incompatible format change to remove hole extents")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> This adds an extra search for every FULL_SYNC, can we just catch this case in
> the main loop, say we keep track of the last extent we found,

It's already doing that by checking if "last_extent == 0" before
calling the new function.
Having last_extent == 0, no extents processed is very rare (hitting
that specific item layout and hole range).

> and then when we
> end up with ret > 1 || a min_key that's past the end of the last extent we saw
> we know we had a hole punch?  Thanks,
>
> Josef
