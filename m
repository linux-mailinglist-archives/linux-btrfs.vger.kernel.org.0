Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23312B6335
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2019 14:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfIRM2E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Sep 2019 08:28:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbfIRM2E (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Sep 2019 08:28:04 -0400
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F1F7205F4
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Sep 2019 12:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568809683;
        bh=afcqkhx03wJEjb1natguZJxj7qFO9V4lkGDSWQcF424=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D5+wA9H7MMgRFGmzIv/OCMWtEiLsJBzG3QfWS859xdL5ssJvh1M+RHyK8X0ocVyes
         AE2pb8HxpC82WjVGDb+hJ7Osla2+gfAB5RUX3gZPl6009JafMqak7DNcN9cR/Af5iR
         LDsN3fTHiJSQD2Wotf/2DfNcrJD6QrXcAjbDkVZ4=
Received: by mail-ua1-f53.google.com with SMTP id 107so2266149uau.5
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Sep 2019 05:28:03 -0700 (PDT)
X-Gm-Message-State: APjAAAXpO+hRR20uCUPJYHxILa0iNi/X7ZdEGZyVRK4uvHIKt9ZntofV
        FBGX2vMTUTerYBI++6SJF3JDj8TNC9jt4i/4xdM=
X-Google-Smtp-Source: APXvYqzd+PeRjU7eK7l8j3WeTBz5XhA00TkLLYTLZjM49hGd+ZLt6sh7U/cOG9F305UKd8h5iQR/oYGsaeHyTJ9HnfU=
X-Received: by 2002:ab0:70a2:: with SMTP id q2mr2021006ual.83.1568809682725;
 Wed, 18 Sep 2019 05:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190918120852.764-1-fdmanana@kernel.org> <35dbd7db-ab20-111b-3ba4-01a0cd947f58@gmx.com>
In-Reply-To: <35dbd7db-ab20-111b-3ba4-01a0cd947f58@gmx.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 18 Sep 2019 13:27:51 +0100
X-Gmail-Original-Message-ID: <CAL3q7H44rF04QKQni_Su1O1wBm=2kkDjdE6oqTA0oB6bzT6Ubw@mail.gmail.com>
Message-ID: <CAL3q7H44rF04QKQni_Su1O1wBm=2kkDjdE6oqTA0oB6bzT6Ubw@mail.gmail.com>
Subject: Re: [PATCH] Btrfs: fix selftests failure due to uninitialized i_mode
 in test inodes
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 18, 2019 at 1:22 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/9/18 =E4=B8=8B=E5=8D=888:08, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Some of the self tests create a test inode, setup some extents and then=
 do
> > calls to btrfs_get_extent() to test that the corresponding extent maps
> > exist and are correct. However btrfs_get_extent(), since the 5.2 merge
> > window, now errors out when it finds a regular or prealloc extent for a=
n
> > inode that does not correspond to a regular file (its ->i_mode is not
> > S_IFREG). This causes the self tests to fail sometimes, specially when
> > KASAN, slub_debug and page poisoning are enabled:
> >
> >   $ modprobe btrfs
> >   modprobe: ERROR: could not insert 'btrfs': Invalid argument
> >
> >   $ dmesg
> >   [ 9414.691648] Btrfs loaded, crc32c=3Dcrc32c-intel, debug=3Don, asser=
t=3Don, integrity-checker=3Don, ref-verify=3Don
> >   [ 9414.692655] BTRFS: selftest: sectorsize: 4096  nodesize: 4096
> >   [ 9414.692658] BTRFS: selftest: running btrfs free space cache tests
> >   [ 9414.692918] BTRFS: selftest: running extent only tests
> >   [ 9414.693061] BTRFS: selftest: running bitmap only tests
> >   [ 9414.693366] BTRFS: selftest: running bitmap and extent tests
> >   [ 9414.696455] BTRFS: selftest: running space stealing from bitmap to=
 extent tests
> >   [ 9414.697131] BTRFS: selftest: running extent buffer operation tests
> >   [ 9414.697133] BTRFS: selftest: running btrfs_split_item tests
> >   [ 9414.697564] BTRFS: selftest: running extent I/O tests
> >   [ 9414.697583] BTRFS: selftest: running find delalloc tests
> >   [ 9415.081125] BTRFS: selftest: running find_first_clear_extent_bit t=
est
> >   [ 9415.081278] BTRFS: selftest: running extent buffer bitmap tests
> >   [ 9415.124192] BTRFS: selftest: running inode tests
> >   [ 9415.124195] BTRFS: selftest: running btrfs_get_extent tests
> >   [ 9415.127909] BTRFS: selftest: running hole first btrfs_get_extent t=
est
> >   [ 9415.128343] BTRFS critical (device (efault)): regular/prealloc ext=
ent found for non-regular inode 256
> >   [ 9415.131428] BTRFS: selftest: fs/btrfs/tests/inode-tests.c:904 expe=
cted a real extent, got 0
> >
> > This happens because the test inodes are created without ever initializ=
ing
> > the i_mode field of the inode, and neither VFS's new_inode() nor the bt=
rfs
> > callback btrfs_alloc_inode() initialize the i_mode. Initialization of t=
he
> > i_mode is done through the various callbacks used by the VFS to create
> > new inodes (regular files, directories, symlinks, tmpfiles, etc), which
> > all call btrfs_new_inode() which in turn calls inode_init_owner(), whic=
h
> > sets the inode's i_mode. Since the tests only uses new_inode() to creat=
e
> > the test inodes, the i_mode was never initialized.
> >
> > This always happens on a VM I used with kasan, slub_debug and many othe=
r
> > debug facilities enabled. It also happened to someone who reported this
> > on bugzilla (on a 5.3-rc).
> >
> > Fix this by setting i_mode to S_IFREG at btrfs_new_test_inode().
> >
> > Fixes: 6bf9e4bd6a2778 ("btrfs: inode: Verify inode mode to avoid NULL p=
ointer dereference")
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D204397
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> However I'm interested why it doesn't get triggered reliably.
> As I have selftest compiled in everytime.
>
> Is there anything racy caused the bug?

Nop (otherwise I would have noted that in the changelog).

It's just garbage due to uninitialized memory.
In this case, btrfs is a module and only used for testing, since a
btrfs inode was never allocated before attempting to load the module
and run the selftests, we get the garbage. If we had a non-testing
inode allocated and freed before running the tests, the i_mode of the
test inode would match the one from previously freed inode.

>
> Thanks,
> Qu
>
> > ---
> >  fs/btrfs/tests/btrfs-tests.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.=
c
> > index b5e80563efaa..99fe9bf3fdac 100644
> > --- a/fs/btrfs/tests/btrfs-tests.c
> > +++ b/fs/btrfs/tests/btrfs-tests.c
> > @@ -52,7 +52,13 @@ static struct file_system_type test_type =3D {
> >
> >  struct inode *btrfs_new_test_inode(void)
> >  {
> > -     return new_inode(test_mnt->mnt_sb);
> > +     struct inode *inode;
> > +
> > +     inode =3D new_inode(test_mnt->mnt_sb);
> > +     if (inode)
> > +             inode_init_owner(inode, NULL, S_IFREG);
> > +
> > +     return inode;
> >  }
> >
> >  static int btrfs_init_test_fs(void)
> >
>
