Return-Path: <linux-btrfs+bounces-12041-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9CFA53E47
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 00:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56FC83A5D69
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 23:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91DF207675;
	Wed,  5 Mar 2025 23:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwuH8Oca"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177EB2E3365
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 23:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741216504; cv=none; b=iYKDx01AekIWaky3tQeJiyQcRp1ifxy0l6XwkPd9eiFlJ/yIP2kIupamaR9RzwMXE5WhKeeVbRjHTFFtCU/q44hPyKgLBEKrHCRPiklsINcaDewtd0uQAZTdjyDOFCP6/TqwHPZsirGN1AEUQV8PiFAnEED9cV87bk6g1dTRnDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741216504; c=relaxed/simple;
	bh=I9qmnDpuTNvJpEq8eZiJpsgWdWVEHm2IyIAOTTN76zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhhmtGkT0urswFyMM3OofTWVuW8BLBWj9DBMMocVTVz0LbfHP//inn7Q27TAnxysF5+51myNQzWMiJdHST0l98+gGNMuZClDj7VHCs8PLzu5mPhzb44102A4geSU2rlW+BS+G7B2Fi20z/ZmrRguuA1cRFcbZP2nXYj1Cw8ZOP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwuH8Oca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8658C4CEE7
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 23:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741216503;
	bh=I9qmnDpuTNvJpEq8eZiJpsgWdWVEHm2IyIAOTTN76zw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NwuH8OcabZXxS9EGtZczrOXo/AJv9QQQO4ju01qS/eogqD7oQFBlSTAnIgcxd2ZY8
	 pgdUdo3HZkOsw3roV7GyJvqzX2IPEaNbtnkMWJhWrGtaYSJwwiyoPPyZ+hxpoic13Z
	 uekgkXH+bWyalyzuWMpzKQSlWhV5l6XIm1zocFqqaQAXQQQyC/j8IYqQDn7jYm58jI
	 Zlns8q2oAbN/ALMggHAYiHrtx9xC9xp2rXkfPppbjdJdX10D2k++hN98dZF7x3OJt1
	 vkbO15MIc/uPeCieCu0Dmp7kEzC/O9iP/5atzkPpbXzGRnnlBGSJhAPq9yrXPeexKT
	 jt+8ePvU3Bnig==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaec61d0f65so13484666b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Mar 2025 15:15:03 -0800 (PST)
X-Gm-Message-State: AOJu0YxMJWhYJz0h1ArWM6/r9mVVxRYpCaj7FkaVsSAYQxp5uA3StvQU
	Qyat0OaEkBJZkD3l970bBnQXVN4+Cy9Y3xfbdVO2ZVH4QBLxJ7DG6MmvuQYpQeh6EuqaprXx+o0
	UEbkhdsGF78QRzOsLvxeWAZHTIko=
X-Google-Smtp-Source: AGHT+IFbF+8D3DnZzPSJaljwyo5dsmUHrdkl6YXiN38whBRu8KXcnXDAM6lwdvIUBp/XBPrKMtfpGT0UmAEkKjxDpmE=
X-Received: by 2002:a17:907:72ca:b0:ac1:fb00:2b38 with SMTP id
 a640c23a62f3a-ac20d92d67cmr554222966b.25.1741216502180; Wed, 05 Mar 2025
 15:15:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741198394.git.fdmanana@suse.com> <e1cf2949e4b03fba268f923947543bbf4a7b6752.1741198394.git.fdmanana@suse.com>
 <74baca21-ea92-46f1-a85a-d5834eeaa430@suse.com> <674580db-c8c9-4b8c-baf3-3071fa4a2d01@suse.com>
In-Reply-To: <674580db-c8c9-4b8c-baf3-3071fa4a2d01@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 5 Mar 2025 23:14:24 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7WLOE9BjM6dC1TaSnomxTT41j9DNDB3=0mQWAcEA4JYQ@mail.gmail.com>
X-Gm-Features: AQ5f1JobjqaSEBjUwlWQrXAyb8R1VHA0JIUJXmEfzmQD9XQNODovBCqOzAuEDEw
Message-ID: <CAL3q7H7WLOE9BjM6dC1TaSnomxTT41j9DNDB3=0mQWAcEA4JYQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] btrfs: fix non-empty delayed iputs list on unmount
 due to endio workers
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 10:50=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2025/3/6 09:16, Qu Wenruo =E5=86=99=E9=81=93:
> >
> >
> > =E5=9C=A8 2025/3/6 04:47, fdmanana@kernel.org =E5=86=99=E9=81=93:
> >> From: Filipe Manana <fdmanana@suse.com>
> >>
> >> At close_ctree() after we have ran delayed iputs either through
> >> explicitly
> >> calling btrfs_run_delayed_iputs() or later during the call to
> >> btrfs_commit_super() or btrfs_error_commit_super(), we assert that the
> >> delayed iputs list is empty.
> >>
> >> Sometimes this assertion may fail because delayed iputs may have been
> >> added to the list after we last ran delayed iputs, and this happens du=
e
> >> to workers in the endio_workers workqueue still running. These workers
> >> can
> >> do a final put on an ordered extent attached to a data bio, which resu=
lts
> >> in adding a delayed iput. This is done at btrfs_bio_end_io() and its
> >> helper __btrfs_bio_end_io().
> >
> > But the endio_workers workqueue is only utilized by data READ
> > operations, in function btrfs_end_io_wq(), which is called in
> > btrfs_simple_end_io().
> >
> > Furthermore, for the endio_workers workqueue, for data inodes it only
> > handles btrfs_check_read_bio(), which shouldn't generate ordered extent
> > either.
> >
> > Did I miss something here?
>
> Oh, I missed the recently disabled (for subpage) uncached io.
>
> So I guess the real fixes tag should be that not-yet-upstreamed uncached
> io patch.

Oh yes, I picked a wrong commit somehow.

Since the uncached stuff is not in Linus' tree, I'll remove the Fixes
tag and just mention it happens for uncached IO added recently and the
subject of the patch that introduced it.

Thanks.

>
> Thanks,
> Qu
>
> >
> > Thanks,
> > Qu
> >
> >>
> >> Fix this by flushing the endio_workers workqueue before running delaye=
d
> >> iputs at close_ctree().
> >>
> >> David reported this when running generic/648.
> >>
> >> Reported-by: David Sterba <dsterba@suse.com>
> >> Fixes: ec63b84d4611 ("btrfs: add an ordered_extent pointer to struct
> >> btrfs_bio")
> >> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >> ---
> >>   fs/btrfs/disk-io.c | 9 +++++++++
> >>   1 file changed, 9 insertions(+)
> >>
> >> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> >> index d96ea974ef73..b6194ae97361 100644
> >> --- a/fs/btrfs/disk-io.c
> >> +++ b/fs/btrfs/disk-io.c
> >> @@ -4340,6 +4340,15 @@ void __cold close_ctree(struct btrfs_fs_info
> >> *fs_info)
> >>        */
> >>       btrfs_flush_workqueue(fs_info->delalloc_workers);
> >> +    /*
> >> +     * We can also have ordered extents getting their last reference
> >> dropped
> >> +     * from the endio_workers workqueue because for data bios we keep=
 a
> >> +     * reference on an ordered extent which gets dropped when running
> >> +     * btrfs_bio_end_io() in that workqueue, and that final drop
> >> results in
> >> +     * adding a delayed iput for the inode.
> >> +     */
> >> +    flush_workqueue(fs_info->endio_workers);
> >> +
> >>       /*
> >>        * After we parked the cleaner kthread, ordered extents may have
> >>        * completed and created new delayed iputs. If one of the async
> >> reclaim
> >
> >
>

