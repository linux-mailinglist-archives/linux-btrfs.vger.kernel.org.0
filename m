Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53366305FD4
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 16:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbhA0Pjo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 10:39:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:35770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236254AbhA0PhR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 10:37:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE9DF207CC
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 15:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611761796;
        bh=R6L5QSpeMTKSCmyXluWdw1vZ1dXmotvBvGuq8NoNfkI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j8RdS5NNwx46O3Ej1fqRS3WmoebORnZw8QtL0uuttsanoPZV82POBWnOSV7ljJhVo
         OVhOvDE+Nc4LEsC4/WOXxs2ccDM90a82NjO21bdigxPR4LCtSlP5pAXFku8LRAo3su
         EEEFd+odiSsMn5qepQ61ponTs5Jc2zHubOEn6GQ44Phbcv6kvIDNpQgLDVLHbLgjkV
         sGE64miveE/wNawujPzmhpZXhTKvAWlnKz0GotJfFT2GhHjI3+lmb9o8O5gsx+9WMO
         iS4dZ6Vh29o8RDoojTBn3BjTwdbXuBPnheXEL4Sf+o+HhAyUKeV9Xpy6id7HuNHZiN
         5HnafB0xI30Iw==
Received: by mail-qt1-f171.google.com with SMTP id h16so557075qth.11
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 07:36:36 -0800 (PST)
X-Gm-Message-State: AOAM530hBwYaiE4qtTy7ieH2fGxH47s0X58TkWIaNsxBx1an2FGAQJpN
        hV1TzR33WNONr7ah1+PtB2i1M0ZdQixi6fZJ+OM=
X-Google-Smtp-Source: ABdhPJxSilg2EtsPqitApNEYvfhoSyltM83x0bLBSU9hTYsim1SL1+SVRrDALQrFdDFcqsZQ+gF8BLZ1fNoeyzX7MPs=
X-Received: by 2002:ac8:7762:: with SMTP id h2mr10058819qtu.259.1611761795724;
 Wed, 27 Jan 2021 07:36:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1611742865.git.fdmanana@suse.com> <77b21c64a5aed56e5602c59558c1b09254f3b494.1611742865.git.fdmanana@suse.com>
 <1a949e1e-4138-abef-bff7-0ce525be6ae3@toxicpanda.com>
In-Reply-To: <1a949e1e-4138-abef-bff7-0ce525be6ae3@toxicpanda.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 27 Jan 2021 15:36:24 +0000
X-Gmail-Original-Message-ID: <CAL3q7H674gb03GJh3owLSVBndSO0JsT3STVHJDeOGU72_Ar4LQ@mail.gmail.com>
Message-ID: <CAL3q7H674gb03GJh3owLSVBndSO0JsT3STVHJDeOGU72_Ar4LQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] btrfs: remove unnecessary check_parent_dirs_for_sync()
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 27, 2021 at 3:23 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 1/27/21 5:34 AM, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Whenever we fsync an inode, if it is a directory, a regular file that was
> > created in the current transaction or has last_unlink_trans set to the
> > generation of the current transaction, we check if any of its ancestor
> > inodes (and the inode itself if it is a directory) can not be logged and
> > need a fallback to a full transaction commit - if so, we return with a
> > value of 1 in order to fallback to a transaction commit.
> >
> > However we often do not need to fallback to a transaction commit because:
> >
> > 1) The ancestor inode is not an immediate parent, and therefore there is
> >     not an explicit request to log it and it is not needed neither to
> >     guarantee the consistency of the inode originally asked to be logged
> >     (fsynced) nor its immediate parent;
> >
> > 2) The ancestor inode was already logged before, in which case any link,
> >     unlink or rename operation updates the log as needed.
> >
> > So for these two cases we can avoid an unnecessary transaction commit.
> > Therefore remove check_parent_dirs_for_sync() and add a check at the top
> > of btrfs_log_inode() to make us fallback immediately to a transaction
> > commit when we are logging a directory inode that can not be logged and
> > needs a full transaction commit. All we need to protect is the case where
> > after renaming a file someone fsyncs only the old directory, which would
> > result is losing the renamed file after a log replay.
> >
> > This patch is part of a patchset comprised of the following patches:
> >
> >    btrfs: remove unnecessary directory inode item update when deleting dir entry
> >    btrfs: stop setting nbytes when filling inode item for logging
> >    btrfs: avoid logging new ancestor inodes when logging new inode
> >    btrfs: skip logging directories already logged when logging all parents
> >    btrfs: skip logging inodes already logged when logging new entries
> >    btrfs: remove unnecessary check_parent_dirs_for_sync()
> >    btrfs: make concurrent fsyncs wait less when waiting for a transaction commit
> >
> > Performance results, after applying all patches, are mentioned in the
> > change log of the last patch.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> I'm having a hard time with this one.
>
> Previously we would commit the transaction if the inode was a regular file, that
> was created in this current transaction, and had been renamed.  Now with this
> patch you're only committing the transaction if we are a directory and were
> renamed ourselves.  Before if you already had directories A and B and then did
> something like
>
> echo "foo" > /mnt/test/A/blah
> fsync(/mnt/test/A/blah);
> fsync(/mnt/test/A);
> mv /mnt/test/A/blah /mnt/test/B
> fsync(/mnt/test/B/blah);
>
> we would commit the transaction on this second fsync, but with your patch we are
> not.  I suppose that's keeping in line with how fsync is allowed to work, but
> it's definitely a change in behavior from what we used to do.  Not sure if
> that's good or not, I'll have to think about it.  Thanks,

Yes. Because of the rename (or a link), we will set last_unlink_trans
to the current transaction, and when logging the file that will cause
logging of all its old parents (A). That was added several years ago
to fix corruptions, and it turned out to be needed later as well to
ensure we have
a behaviour similar to xfs and ext4 (and others) regarding strictly
ordered metadata updates (I added several tests to fstests over the
years for all the cases).
There's also the fact that on replay we will delete any inode refs
that aren't in the log (that one was added in commit 1f250e929a9c
("Btrfs: fix log replay failure after unlink and link combination").

For that example we also have A updated in the log by the rename. So
we know the log is consistent.

So that's why the whole check_parents_for_sync() is not needed.

Thanks.

>
> Josef
