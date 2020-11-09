Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227FC2AB634
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Nov 2020 12:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgKILKl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 06:10:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:51764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729197AbgKILKk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Nov 2020 06:10:40 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DF3E208FE
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Nov 2020 11:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604920239;
        bh=deA+sQc8DO9jMk1W29xW8ugCOdL2At+kSnaGcSJV4Ik=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eFSEDc2mocbWSUYXIJZgB2MIErncqbWgvkU10Bau4dQL8zSztwe36buksC1CPVlGm
         pwX99C9prdFNtBLXNx6vshzXiMZR7PVKefEghhVwfuWdf9N+FeikUUy+qTYhWldqp6
         XYsTIhqELZZk8aRGNTm8tB3327iZgrvfow7030xM=
Received: by mail-qk1-f173.google.com with SMTP id r7so7482446qkf.3
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Nov 2020 03:10:39 -0800 (PST)
X-Gm-Message-State: AOAM531uOXYTYywa+93TLJyJ4NQxl8I1Zt55NqGWhYCwbrQjx1x4N8U+
        o09ryCOzW5wlf3gWgD8KBgOlc5RXzW1vZyiW7pE=
X-Google-Smtp-Source: ABdhPJzvVmS/SRuqxONa+3mToMcR92szINXuxXflCeits/SEma+OGrRJB439va/PtXdXAgcpUmuEIFqvVJRmPy433/A=
X-Received: by 2002:a37:4117:: with SMTP id o23mr12656504qka.479.1604920238654;
 Mon, 09 Nov 2020 03:10:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604486892.git.fdmanana@suse.com> <aeebaf45f19779b8f869cc16db0bcfe8ba4dcf2d.1604486892.git.fdmanana@suse.com>
 <2f50f521-05f6-8c84-3e84-c529ff1e9e0b@suse.com>
In-Reply-To: <2f50f521-05f6-8c84-3e84-c529ff1e9e0b@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 9 Nov 2020 11:10:27 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6pQdptzwCte3cF4R95AxCxfe+Cut=3DFKqbpbOQEV7Gg@mail.gmail.com>
Message-ID: <CAL3q7H6pQdptzwCte3cF4R95AxCxfe+Cut=3DFKqbpbOQEV7Gg@mail.gmail.com>
Subject: Re: [PATCH 4/4] btrfs: update the number of bytes used by an inode atomically
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 9, 2020 at 10:34 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 4.11.20 =D0=B3. 13:07 =D1=87., fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
>
> <snip>
>
> > So fix this by:
> >
> > 1) Making btrfs_drop_extents() not decrement the vfs inode's number of
> >    bytes, and instead return the number of bytes;
> >
> > 2) Making any code that drops extents and adds new extents update the
> >    inode's number of bytes atomically, while holding the btrfs inode's
> >    spinlock, which is also used by the stat(2) callback to get the inod=
e's
> >    number of bytes;
>
> Since synchronization is going to be provided by the btrfs_inode's lock,
> then how about switching to __inode_(sub|add)_bytes functions which do
> not take the vfs_inode's lock? Or do we need both (btrfs' and vfs' inode
> locks) ?

Because the synchronization is only meant for the races with stat(2),
and don't want to break existing users of inode_get_bytes(), specially
those outside btrfs.

Thanks.

>
> >
> > 3) For ranges in the inode's iotree that are marked as 'delalloc new',
> >    corresponding to previously unallocated ranges, increment the inode'=
s
> >    number of bytes when clearing the 'delalloc new' bit from the range,
> >    in the same critical section that decrements the inode's
> >    'new_delalloc_bytes' counter, delimited by the btrfs inode's spinloc=
k.
> >
> > An alternative would be to have btrfs_getattr() wait for any IO (ordere=
d
> > extents in progress) and locking the whole range (0 to (u64)-1) while i=
t
> > it computes the number of blocks used. But that would mean blocking
> > stat(2), which is a very used syscall and expected to be fast, waiting
> > for writes, clone/dedupe, fallocate, page reads, fiemap, etc.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> <snip>
