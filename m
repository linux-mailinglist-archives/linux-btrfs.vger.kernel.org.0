Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59F1FFCA2B
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2019 16:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfKNPpv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Nov 2019 10:45:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:57776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbfKNPpv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Nov 2019 10:45:51 -0500
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F26D2070E
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2019 15:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573746350;
        bh=D8gZIO1ndCKllmVvnhtXs2q8PjKsYZ0nO13OxAY0vuI=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=w+QTEFJIO2/n725zp+GlfmCqzbL3mgsy0uvYl06KQQHUuLCYzQy7QKTjsA5O11jQW
         PuTi6YNwC/oYMZraBXGpnmVzRwxTxpga65HV5N296z8CyBbNgzDRdxh6qtP4fqs4AT
         rnUT2IbrvFOfUGnUoo6eCvoV9CTekk94IIY3rSg4=
Received: by mail-vs1-f49.google.com with SMTP id c25so4178706vsp.0
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2019 07:45:50 -0800 (PST)
X-Gm-Message-State: APjAAAUGytRZ7EodbvWHVIdb793AEU5Y89Vbum0w4LoUkDqthYoNP3Js
        46t9VlRZzl3ppjXPt+1kzvhSt1j37LrcXg6VqME=
X-Google-Smtp-Source: APXvYqyr/JTHHoW0tY5oxTDVp+ZOp2gHlXb9FfGk5LwMRiCA5O16efDX8ylfa4aeIX2gWV0Cn5hLUvbcShYjKn57Wx8=
X-Received: by 2002:a05:6102:2375:: with SMTP id o21mr6235677vsa.90.1573746349318;
 Thu, 14 Nov 2019 07:45:49 -0800 (PST)
MIME-Version: 1.0
References: <20191112151331.3641-1-fdmanana@kernel.org> <20191114151817.GJ3001@twin.jikos.cz>
In-Reply-To: <20191114151817.GJ3001@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 14 Nov 2019 15:45:38 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7SwZD0mzv2Aqpo58a47e=iGxp4kqmadVQ=+AzfEco_uA@mail.gmail.com>
Message-ID: <CAL3q7H7SwZD0mzv2Aqpo58a47e=iGxp4kqmadVQ=+AzfEco_uA@mail.gmail.com>
Subject: Re: [PATCH] Btrfs: fix missing hole after hole punching and fsync
 when using NO_HOLES
To:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 14, 2019 at 3:18 PM David Sterba <dsterba@suse.cz> wrote:
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
> Added to misc-next, thanks.

Actually, could you hold on a bit for this one?
There's nothing wrong with it, I'm simply fixing other cases and
realized I can fix them all in a single patch.
If I take too long or end up not being able to fix all as I'm
expecting, I'll let you know, otherwise I'll send a very different v2
tomorrow.

Thanks.
