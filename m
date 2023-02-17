Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4086B69A5B9
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Feb 2023 07:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjBQGtM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Feb 2023 01:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBQGtL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Feb 2023 01:49:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602D549891
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 22:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676616502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OJEVjshpjfF2MtkM8NQnJjTWsKM2ja1ZIl8pezomRb8=;
        b=P78URnAJzWnjNSCzl84qw7O9BzPnQ4lxbTSrC9JF3Tk49SBjSROsqsSIW3Fy/0wJgz4SL3
        IDKm7wy6KKL3qcz6JANki6zk9cHvzZwWNcfKgdlxFjNi6kzbYdk6GiE6O9OkWoX/Qv3g0i
        4Qdgi6vKP3TunXBnG1yf2n3MankTMFI=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-208-bK5S1OY-NF2-OKyP_rrmjQ-1; Fri, 17 Feb 2023 01:48:21 -0500
X-MC-Unique: bK5S1OY-NF2-OKyP_rrmjQ-1
Received: by mail-pf1-f197.google.com with SMTP id u31-20020a056a00099f00b005a8de178393so2558145pfg.23
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 22:48:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJEVjshpjfF2MtkM8NQnJjTWsKM2ja1ZIl8pezomRb8=;
        b=V7A235U+dd8+QtSQje7fMJ/xHt3EsmKP9Zf8jYg3B/EC58hN4PqN4dco+xHu+D8j3b
         0t7+HnVTnZ+l3WztVnHFPJHex1jMjbZeBgtWjMKh9lzOU08piYvqBHzxHmZK1xH/0n3r
         uUl4LmZ6DGaaQdgzHlfDPwDcFnIT5ej9Zzs6Faza4s/RYB/YaJaE3s57zC923ckuNTXA
         0rKbwMwkm8Fed0N+0sS5E5qgYbcqy1guGZG7ttrKsP94rP2dID+DNrh8uWIDHjWBIGrn
         57EA2qdzM2CEtdhVvR3BJVHWT5B4vMS9f8p0Q/7YRTEJB/Zcbm0EZ7o7Fq0ow30Ztg8z
         Harw==
X-Gm-Message-State: AO0yUKWu/SfA9j7DdoLLClOKUgDJOjpQohAKqMEqTiWazmQ7iH8KiE5P
        +HQrPn8UKR8E8sWmmFryC/OK5fngIQ3DrlaHybgCV7EIOFcWwcWGOI1Uot9M9rA8oPDiDXa2Vu1
        Q0zYM4qISPX38VEinVWm8QJ648dR8frRP2A==
X-Received: by 2002:a17:902:ebd0:b0:19a:aa9c:c651 with SMTP id p16-20020a170902ebd000b0019aaa9cc651mr137068plg.62.1676616499725;
        Thu, 16 Feb 2023 22:48:19 -0800 (PST)
X-Google-Smtp-Source: AK7set9DPpyaaEGpymrRsYCAzr4lVDKcTUWJhLNKvKOMTdjtI8enCDPH5daLU29SlJt6QvR70jo7Lg==
X-Received: by 2002:a17:902:ebd0:b0:19a:aa9c:c651 with SMTP id p16-20020a170902ebd000b0019aaa9cc651mr137053plg.62.1676616499221;
        Thu, 16 Feb 2023 22:48:19 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b0019608291564sm2370857plw.134.2023.02.16.22.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 22:48:18 -0800 (PST)
Date:   Fri, 17 Feb 2023 14:48:14 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: Re: [PATCH v6] btrfs: test block group size class loading logic
Message-ID: <20230217064814.ykhfcmhss3iojfkc@zlang-mailbox>
References: <160e7557f66a6a34fd052d6834909aa02a702956.1676503163.git.boris@bur.io>
 <CAL3q7H42GK2xu9ZSAKiDUG8ZRJzgudk-3DHE9f95Sqwc0iPKyQ@mail.gmail.com>
 <20230216144952.wcr7r3hdesu2x2le@zlang-mailbox>
 <Y+5PKtUX/8gyNX/w@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+5PKtUX/8gyNX/w@zen>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 16, 2023 at 07:43:38AM -0800, Boris Burkov wrote:
> On Thu, Feb 16, 2023 at 10:49:52PM +0800, Zorro Lang wrote:
> > On Thu, Feb 16, 2023 at 12:11:39PM +0000, Filipe Manana wrote:
> > > On Wed, Feb 15, 2023 at 11:37 PM Boris Burkov <boris@bur.io> wrote:
> > > >
> > > > Add a new test which checks that size classes in freshly loaded block
> > > > groups after a cycle mount match size classes before going down
> > > >
> > > > Depends on the kernel patch:
> > > > btrfs: add size class stats to sysfs
> > > >
> > > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > > ---
> > > > Changelog:
> > > > v6:
> > > > Actually include changes for v5 in the commit.
> > > > v5:
> > > > Instead of using _fixed_by_kernel_commit, use require_fs_sysfs to handle
> > > > the needed sysfs file. The test is skipped on kernels without the file
> > > > and runs correctly on new ones.
> > > > v4:
> > > > Fix dumb typo in _fixed_by_kernel_commit (left out leading underscore
> > > > copy+pasting). Re-tested happy and sad case...
> > > >
> > > > v3:
> > > > Re-add fixed_by_kernel_commit, but for the stats patch which is
> > > > required, but not a fix in the strictest sense.
> > > >
> > > > v2:
> > > > Drop the fixed_by_kernel_commit since the fix is not out past the btrfs
> > > > development tree, so the fix is getting rolled in to the original broken
> > > > commit. Modified the commit message to note the dependency on the new
> > > > sysfs counters.
> > > >
> > > >
> > > >  tests/btrfs/283     | 50 +++++++++++++++++++++++++++++++++++++++++++++
> > > >  tests/btrfs/283.out |  2 ++
> > > >  2 files changed, 52 insertions(+)
> > > >  create mode 100755 tests/btrfs/283
> > > >  create mode 100644 tests/btrfs/283.out
> > > >
> > > > diff --git a/tests/btrfs/283 b/tests/btrfs/283
> > > > new file mode 100755
> > > > index 00000000..2c26b41e
> > > > --- /dev/null
> > > > +++ b/tests/btrfs/283
> > > > @@ -0,0 +1,50 @@
> > > > +#! /bin/bash
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
> > > > +#
> > > > +# FS QA Test 283
> > > > +#
> > > > +# Test that mounting a btrfs filesystem properly loads block group size classes.
> > > > +#
> > > > +. ./common/preamble
> > > > +_begin_fstest auto quick mount
> > > 
> > > I'm still curious why the 'mount' group, and I've asked for that before.
> > > 
> > > We aren't testing a new mount option, so it feels weird for me.
> > 
> > Agree, the "mount" group looks not make sense.
> 
> My mistake, sorry for overlooking this. My reasoning is that it tests
> the behavior on a fresh mount rather than while the fs is live, but it
> is not specific to mounting logic. Happy to remove it.
> 
> > 
> > The btrfs/283 has been taken in v2023.02.05. So please make a rebase.
> 
> Done. Is there any way we can try to script this process for the future
> with placeholders or something? It's kind of a drag to deal with
> in general. I'm happy to send some proposal if it's something you'd be
> interested in taking.

The ./new command will choose a proper number for a new case, but that number
might be taken after several weeks passed. One way is: the contributor can use
./tools/mvtest to take a new number on his local develop branch, then rebase on
the upstream for-next branch, then send it again.

It's easy for the new case developer, but a little hard for me to merge a
taken number. I have to create a temporary branch, then remove that (already)
taken case clearly, then merge the new patch, then change its number, then git
cherrypick it to official branch. If the patch is big and complex, I might need
to deal with more conflict (that's risk).

There's another way you can try when you create a new case, you can take a
bigger enough number (e.g. 999, 900) for your new case. Darrick always would
like to do that, when he send lots of new cases to me. After I merge that
patch, I'll use ./tools/mvtest to give it a proper number.

If you have any better idea, feel free to send your patch.

Thanks,
Zorro

> 
> > 
> > The "fixed_by_kernel_commit xxxx" part has been added and removed several times,
> > does this case need it or not? Or maybe you want a _wants_kernel_commit (just
> > ask for sure) ?
> 
> Thanks for checking. I personally don't think it needs it. The commit it
> wants/needs is the commit that adds the sysfs file. I think that is
> adequately skipped and documented by the _require_fs_sysfs that Filipe
> suggested. If someone is really interested in this behavior, it is not
> too hard to find the kernel commit from the sysfs file.
> 
> > 
> > Others look good to me.
> > 
> > Thanks,
> > Zorro
> > 
> > > 
> > > Otherwise, it looks fine now. Thanks.
> > > 
> > > > +
> > > > +sysfs_size_classes() {
> > > > +       local uuid="$(findmnt -n -o UUID "$SCRATCH_MNT")"
> > > > +       cat "/sys/fs/btrfs/$uuid/allocation/data/size_classes"
> > > > +}
> > > > +
> > > > +_supported_fs btrfs
> > > > +_require_scratch
> > > > +_require_btrfs_fs_sysfs
> > > > +_require_fs_sysfs allocation/data/size_classes
> > > > +
> > > > +f="$SCRATCH_MNT/f"
> > > > +small=$((16 * 1024))
> > > > +medium=$((1024 * 1024))
> > > > +large=$((16 * 1024 * 1024))
> > > > +
> > > > +_scratch_mkfs >/dev/null
> > > > +_scratch_mount
> > > > +# Write files with extents in each size class
> > > > +$XFS_IO_PROG -fc "pwrite -q 0 $small" $f.small
> > > > +$XFS_IO_PROG -fc "pwrite -q 0 $medium" $f.medium
> > > > +$XFS_IO_PROG -fc "pwrite -q 0 $large" $f.large
> > > > +# Sync to force the extent allocation
> > > > +sync
> > > > +pre=$(sysfs_size_classes)
> > > > +
> > > > +# cycle mount to drop the block group cache
> > > > +_scratch_cycle_mount
> > > > +
> > > > +# Another write causes us to actually load the block groups
> > > > +$XFS_IO_PROG -fc "pwrite -q 0 $large" $f.large.2
> > > > +sync
> > > > +
> > > > +post=$(sysfs_size_classes)
> > > > +diff <(echo $pre) <(echo $post)
> > > > +
> > > > +echo "Silence is golden"
> > > > +# success, all done
> > > > +status=0
> > > > +exit
> > > > diff --git a/tests/btrfs/283.out b/tests/btrfs/283.out
> > > > new file mode 100644
> > > > index 00000000..efb2c583
> > > > --- /dev/null
> > > > +++ b/tests/btrfs/283.out
> > > > @@ -0,0 +1,2 @@
> > > > +QA output created by 283
> > > > +Silence is golden
> > > > --
> > > > 2.39.1
> > > >
> > > 
> > 
> 

