Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877914BF5D8
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 11:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiBVKab (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 05:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiBVKa2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 05:30:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4184115AF05
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 02:30:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9E35B81964
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 10:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C182C340E8
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 10:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645525800;
        bh=MeT4dCLc4wu4w9HAszOFW1V0aWE0cEEuGP33kwUOe7E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A6SWREjkKNH6LTiAX1tQrREjhULPGZCRpvOJQKlvYvVwRbXj2q3OUF22LBDF0DKXq
         r80OE7vNOhfY3/YABjBILF9M+V5ciCTOc0wGP28/oJanZG09PvX4tRkob1XhamYJuz
         iSA9SJr6GBfOkAPzETnD+2AguKdadANc7sVSroRKMk9htXeb/JxGySrNNcdnjEpiIo
         19OFI7gCtkX156eIu/l/0DtldsnpZGWoCQR1plYSFFFGhqazh8uHxQ1L6pWCq09cQm
         fkgB/Kj/PiN9b17D2PjSO20P3LPHzTo6VLEiZbRuzmSRb9b2GIEoAmlsiuF68fqh3v
         UQ+7IhiIOf5Ug==
Received: by mail-qk1-f175.google.com with SMTP id t21so14769348qkg.6
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 02:30:00 -0800 (PST)
X-Gm-Message-State: AOAM531r81x99uxqRWvSUbAcUa/dlx7G4fzpBJ6u6dUITcCmVPdYZII1
        gS/p1pHC0l4DWYkUcsSk6ttKEDMZx1LxMqn3j7Y=
X-Google-Smtp-Source: ABdhPJxMVYDl0l2vM1FvlMbZthzb1DW1FqWsCBBRyA4gS1iuPaG+IPouJXAcLG/Dn4ayZjn2NegqPBOWqAQrn7soMck=
X-Received: by 2002:a37:af81:0:b0:502:7ea:34e7 with SMTP id
 y123-20020a37af81000000b0050207ea34e7mr15177190qke.737.1645525799537; Tue, 22
 Feb 2022 02:29:59 -0800 (PST)
MIME-Version: 1.0
References: <20220221181141.DD77.409509F4@e16-tech.com> <CAL3q7H6NZMSAMxEidQsZWibyrmyEFMM4tGX_RDiRbVs1Gm8XgQ@mail.gmail.com>
 <20220222075154.1347.409509F4@e16-tech.com>
In-Reply-To: <20220222075154.1347.409509F4@e16-tech.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 22 Feb 2022 10:29:23 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5P4NxBtD+qj_Yu8+wLsgHE9ftO2kRS7d+1S=jZPdnmuw@mail.gmail.com>
Message-ID: <CAL3q7H5P4NxBtD+qj_Yu8+wLsgHE9ftO2kRS7d+1S=jZPdnmuw@mail.gmail.com>
Subject: Re: [PATCH 1/7] btrfs: fix lost prealloc extents beyond eof after
 full fsync
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 21, 2022 at 11:52 PM Wang Yugui <wangyugui@e16-tech.com> wrote:
>
> Hi,
>
> > >
> > > xfstest btrfs/261 PASSED 40 times without this patch.
> > >
> > > so there is some problem in xfstest btrfs/261?
> >
> > Not that I can see, it always fails for me on an unpatched kernel:
>
> xfstest btrfs/261 always fails on unpatched kernel 5.17.0-rc4 here too.

I don't get it.
So earlier you said the test passed without the patch, but now you are
saying the opposite?
Did I misunderstand something?

>
> Thanks a lot.
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/02/22
>
>
> >
> > $ ./check btrfs/261
> > FSTYP         -- btrfs
> > PLATFORM      -- Linux/x86_64 debian9 5.17.0-rc4-btrfs-next-112 #1 SMP
> > PREEMPT Wed Feb 16 11:20:50 WET 2022
> > MKFS_OPTIONS  -- /dev/sdc
> > MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> >
> > btrfs/261 8s ... - output mismatch (see
> > /home/fdmanana/git/hub/xfstests/results//btrfs/261.out.bad)
> >     --- tests/btrfs/261.out 2022-02-15 11:53:34.273201027 +0000
> >     +++ /home/fdmanana/git/hub/xfstests/results//btrfs/261.out.bad
> > 2022-02-21 10:34:59.781769394 +0000
> >     @@ -5,6 +5,3 @@
> >      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >      List of extents after power failure:
> >      0: [0..32767]: data
> >     -1: [32768..34815]: unwritten
> >     -2: [34816..40959]: hole
> >     -3: [40960..43007]: unwritten
> >     ...
> >     (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/261.out
> > /home/fdmanana/git/hub/xfstests/results//btrfs/261.out.bad'  to see
> > the entire diff)
> > Ran: btrfs/261
> > Failures: btrfs/261
> > Failed 1 of 1 tests
> >
> > And should fail regardless of the page size, which is the only factor
> > I think could make a difference.
> >
> > To figure it out, change the test like this:
> >
> > diff --git a/tests/btrfs/261 b/tests/btrfs/261
> > index 8275e6a5..540a2de2 100755
> > --- a/tests/btrfs/261
> > +++ b/tests/btrfs/261
> > @@ -65,7 +65,15 @@ $XFS_IO_PROG -c "pwrite 0 4K" -c "fsync"
> > $SCRATCH_MNT/foo | _filter_xfs_io
> >
> >  # Simulate a power failure and then mount again the filesystem to
> > replay the log
> >  # tree.
> > -_flakey_drop_and_remount
> > +#_flakey_drop_and_remount
> > +_load_flakey_table $FLAKEY_DROP_WRITES
> > +_unmount_flakey
> > +
> > +$BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV >>$seqres.full 2>&1
> > +
> > +_load_flakey_table $FLAKEY_ALLOW_WRITES
> > +_mount_flakey
> > +
> >
> >  # After the power failure we expect that the preallocated extents, beyond the
> >  # inode's i_size, still exist.
> >
> > Run it and then provide the contents of the file results/btrfs/261.full
> >
> > >
> > > Best Regards
> > > Wang Yugui (wangyugui@e16-tech.com)
> > > 2022/02/21
> > >
> > > > From: Filipe Manana <fdmanana@suse.com>
> > > >
> > > > When doing a full fsync, if we have prealloc extents beyond (or at) eof,
> > > > and the leaves that contain them were not modified in the current
> > > > transaction, we end up not logging them. This results in losing those
> > > > extents when we replay the log after a power failure, since the inode is
> > > > truncated to the current value of the logged i_size.
> > > >
> > > > Just like for the fast fsync path, we need to always log all prealloc
> > > > extents starting at or beyond i_size. The fast fsync case was fixed in
> > > > commit 471d557afed155 ("Btrfs: fix loss of prealloc extents past i_size
> > > > after fsync log replay") but it missed the full fsync path. The problem
> > > > exists since the very early days, when the log tree was added by
> > > > commit e02119d5a7b439 ("Btrfs: Add a write ahead tree log to optimize
> > > > synchronous operations").
> > > >
> > > > Example reproducer:
> > > >
> > > >   $ mkfs.btrfs -f /dev/sdc
> > > >   $ mount /dev/sdc /mnt
> > > >
> > > >   # Create our test file with many file extent items, so that they span
> > > >   # several leaves of metadata, even if the node/page size is 64K. Use
> > > >   # direct IO and not fsync/O_SYNC because it's both faster and it avoids
> > > >   # clearing the full sync flag from the inode - we want the fsync below
> > > >   # to trigger the slow full sync code path.
> > > >   $ xfs_io -f -d -c "pwrite -b 4K 0 16M" /mnt/foo
> > > >
> > > >   # Now add two preallocated extents to our file without extending the
> > > >   # file's size. One right at i_size, and another further beyond, leaving
> > > >   # a gap between the two prealloc extents.
> > > >   $ xfs_io -c "falloc -k 16M 1M" /mnt/foo
> > > >   $ xfs_io -c "falloc -k 20M 1M" /mnt/foo
> > > >
> > > >   # Make sure everything is durably persisted and the transaction is
> > > >   # committed. This makes all created extents to have a generation lower
> > > >   # than the generation of the transaction used by the next write and
> > > >   # fsync.
> > > >   sync
> > > >
> > > >   # Now overwrite only the first extent, which will result in modifying
> > > >   # only the first leaf of metadata for our inode. Then fsync it. This
> > > >   # fsync will use the slow code path (inode full sync bit is set) because
> > > >   # it's the first fsync since the inode was created/loaded.
> > > >   $ xfs_io -c "pwrite 0 4K" -c "fsync" /mnt/foo
> > > >
> > > >   # Extent list before power failure.
> > > >   $ xfs_io -c "fiemap -v" /mnt/foo
> > > >   /mnt/foo:
> > > >    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
> > > >      0: [0..7]:          2178048..2178055     8   0x0
> > > >      1: [8..16383]:      26632..43007     16376   0x0
> > > >      2: [16384..32767]:  2156544..2172927 16384   0x0
> > > >      3: [32768..34815]:  2172928..2174975  2048 0x800
> > > >      4: [34816..40959]:  hole              6144
> > > >      5: [40960..43007]:  2174976..2177023  2048 0x801
> > > >
> > > >   <power fail>
> > > >
> > > >   # Mount fs again, trigger log replay.
> > > >   $ mount /dev/sdc /mnt
> > > >
> > > >   # Extent list after power failure and log replay.
> > > >   $ xfs_io -c "fiemap -v" /mnt/foo
> > > >   /mnt/foo:
> > > >    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
> > > >      0: [0..7]:          2178048..2178055     8   0x0
> > > >      1: [8..16383]:      26632..43007     16376   0x0
> > > >      2: [16384..32767]:  2156544..2172927 16384   0x1
> > > >
> > > >   # The prealloc extents at file offsets 16M and 20M are missing.
> > > >
> > > > So fix this by calling btrfs_log_prealloc_extents() when we are doing a
> > > > full fsync, so that we always log all prealloc extents beyond eof.
> > > >
> > > > A test case for fstests will follow soon.
> > > >
> > > > CC: stable@vger.kernel.org # 4.19+
> > > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > > ---
> > > >  fs/btrfs/tree-log.c | 43 +++++++++++++++++++++++++++++++------------
> > > >  1 file changed, 31 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > > > index a483337e8f41..71a5a961fef7 100644
> > > > --- a/fs/btrfs/tree-log.c
> > > > +++ b/fs/btrfs/tree-log.c
> > > > @@ -4732,7 +4732,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
> > > >
> > > >  /*
> > > >   * Log all prealloc extents beyond the inode's i_size to make sure we do not
> > > > - * lose them after doing a fast fsync and replaying the log. We scan the
> > > > + * lose them after doing a full/fast fsync and replaying the log. We scan the
> > > >   * subvolume's root instead of iterating the inode's extent map tree because
> > > >   * otherwise we can log incorrect extent items based on extent map conversion.
> > > >   * That can happen due to the fact that extent maps are merged when they
> > > > @@ -5510,6 +5510,7 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
> > > >                                  struct btrfs_log_ctx *ctx,
> > > >                                  bool *need_log_inode_item)
> > > >  {
> > > > +     const u64 i_size = i_size_read(&inode->vfs_inode);
> > > >       struct btrfs_root *root = inode->root;
> > > >       int ins_start_slot = 0;
> > > >       int ins_nr = 0;
> > > > @@ -5530,13 +5531,21 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
> > > >               if (min_key->type > max_key->type)
> > > >                       break;
> > > >
> > > > -             if (min_key->type == BTRFS_INODE_ITEM_KEY)
> > > > +             if (min_key->type == BTRFS_INODE_ITEM_KEY) {
> > > >                       *need_log_inode_item = false;
> > > > -
> > > > -             if ((min_key->type == BTRFS_INODE_REF_KEY ||
> > > > -                  min_key->type == BTRFS_INODE_EXTREF_KEY) &&
> > > > -                 inode->generation == trans->transid &&
> > > > -                 !recursive_logging) {
> > > > +             } else if (min_key->type == BTRFS_EXTENT_DATA_KEY &&
> > > > +                        min_key->offset >= i_size) {
> > > > +                     /*
> > > > +                      * Extents at and beyond eof are logged with
> > > > +                      * btrfs_log_prealloc_extents().
> > > > +                      * Only regular files have BTRFS_EXTENT_DATA_KEY keys,
> > > > +                      * and no keys greater than that, so bail out.
> > > > +                      */
> > > > +                     break;
> > > > +             } else if ((min_key->type == BTRFS_INODE_REF_KEY ||
> > > > +                         min_key->type == BTRFS_INODE_EXTREF_KEY) &&
> > > > +                        inode->generation == trans->transid &&
> > > > +                        !recursive_logging) {
> > > >                       u64 other_ino = 0;
> > > >                       u64 other_parent = 0;
> > > >
> > > > @@ -5567,10 +5576,8 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
> > > >                               btrfs_release_path(path);
> > > >                               goto next_key;
> > > >                       }
> > > > -             }
> > > > -
> > > > -             /* Skip xattrs, we log them later with btrfs_log_all_xattrs() */
> > > > -             if (min_key->type == BTRFS_XATTR_ITEM_KEY) {
> > > > +             } else if (min_key->type == BTRFS_XATTR_ITEM_KEY) {
> > > > +                     /* Skip xattrs, logged later with btrfs_log_all_xattrs() */
> > > >                       if (ins_nr == 0)
> > > >                               goto next_slot;
> > > >                       ret = copy_items(trans, inode, dst_path, path,
> > > > @@ -5623,9 +5630,21 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
> > > >                       break;
> > > >               }
> > > >       }
> > > > -     if (ins_nr)
> > > > +     if (ins_nr) {
> > > >               ret = copy_items(trans, inode, dst_path, path, ins_start_slot,
> > > >                                ins_nr, inode_only, logged_isize);
> > > > +             if (ret)
> > > > +                     return ret;
> > > > +     }
> > > > +
> > > > +     if (inode_only == LOG_INODE_ALL && S_ISREG(inode->vfs_inode.i_mode)) {
> > > > +             /*
> > > > +              * Release the path because otherwise we might attempt to double
> > > > +              * lock the same leaf with btrfs_log_prealloc_extents() below.
> > > > +              */
> > > > +             btrfs_release_path(path);
> > > > +             ret = btrfs_log_prealloc_extents(trans, inode, dst_path);
> > > > +     }
> > > >
> > > >       return ret;
> > > >  }
> > > > --
> > > > 2.33.0
> > >
> > >
>
>
