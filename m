Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 050ED17D457
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Mar 2020 16:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgCHPM5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Mar 2020 11:12:57 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42403 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgCHPM4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 Mar 2020 11:12:56 -0400
Received: by mail-pl1-f193.google.com with SMTP id t3so693191plz.9;
        Sun, 08 Mar 2020 08:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cgdmVaotCqvIxS8gqfrNIRqaTKZrOP5zKy0GJ+jAJmY=;
        b=TShcULSGabcDj3R2WjP3NCGxhDmj7/8LzFo13Rpx6DQA0yyJYG5ekQdCIf36Ret/gR
         j87ESIqYawZvAqYc8uLbOc+uny6wKdHrgRczVxxFdKLN2d66rqwgBuv5Tb+xVhWk+9dy
         45WRmp+1ZOir94FWjzT2uIR/IYiqm8ieWPHwvZICzGa/4Xzk450JHrnHDZIzkOnf3NHf
         au0yxmLASUmkthBOIb3bfFjwOv+WSzL4zOsUYlFowngwiQHIjmv+bDML/r5iK2MDRrlT
         iD4kPnsAUSRv9S7k67muH6S8WyGfquxtwPX6YO7OhCpTTjueBqdfnh61Lw+EiV0r0+bQ
         8BmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cgdmVaotCqvIxS8gqfrNIRqaTKZrOP5zKy0GJ+jAJmY=;
        b=SuIziWkJzmXzX7S15qv9Td0hoGoiATqGt0NQnqXSo66xgoGtpapkw/OlVcKREEFgSo
         8zAoELeydmRONALPukoNfbdCKf/Y4CQsLmhsi4RnqKao45hyNmwawEqPYPI+CZ76HQJ5
         YsJT5y1VP1ghCyc71uxRajfmPMhLMUKRhjSPo0Dd9JoXcEjHr7As9QaUeVEzfyt58CuY
         wBL9sdlFgtS4A3TYkAvx1Z3C5M27XnqBDMP+VkoevQ7Nd07l0quZuxGW86Z6KccTDgJM
         QxVHvhMEQ2wdGRu2WtWmFKFgJkaPvqT1tp3LPPTyoOuiRhq8KfwS1i3a6UjYPPcGKJLC
         6BDg==
X-Gm-Message-State: ANhLgQ3pHyz/iKkZYn3+eKwPoMzyA8aexD2l8oi1plOFO9uTWOfCKAG4
        rmzGz8FOpHYs9SjGOSwEYMc=
X-Google-Smtp-Source: ADFU+vuJ+eY2KRbDghNAZxsIvp6jY6k5Q8RKI6HqnezmLxmX+FI2o9DtOyfqapSt0oUrrL0JFJrxIA==
X-Received: by 2002:a17:902:bcc9:: with SMTP id o9mr4682514pls.287.1583680375399;
        Sun, 08 Mar 2020 08:12:55 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id k1sm20148153pgg.56.2020.03.08.08.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 08:12:54 -0700 (PDT)
Date:   Sun, 8 Mar 2020 23:12:56 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     dsterba@suse.com, nborisov@suse.com, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [ fstests PATCHv3 2/2] btrfs: Test subvolume delete --subvolid
 feature
Message-ID: <20200308150231.GD3128153@desktop>
References: <20200224031341.27740-1-marcos@mpdesouza.com>
 <20200224031341.27740-3-marcos@mpdesouza.com>
 <20200301134026.GK3840@desktop>
 <20200301170654.GA12013@hephaestus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200301170654.GA12013@hephaestus>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 01, 2020 at 02:06:54PM -0300, Marcos Paulo de Souza wrote:
> On Sun, Mar 01, 2020 at 09:54:06PM +0800, Eryu Guan wrote:
> > On Mon, Feb 24, 2020 at 12:13:41AM -0300, Marcos Paulo de Souza wrote:
> > > From: Marcos Paulo de Souza <mpdesouza@suse.com>
> > > 
> > > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > 
> > Looks fine to me overall, but it'd be better to have commit message to
> > describe the test.
> > 
> > Also, it'd be great if btrfs folks could help review it.
> 
> Indeed, a commit message makes things better. I'm attaching here a new version
> of the patch containing a commit message. This new version also bumps the test
> number from 203 -> 207, since other messages were merged after I sent my patch.

Thanks! Would you please send a formal patch to the list?

> 
> While adding the commit message I found in Josef's commit that he added a new
> btrfs test 206, but groups contained test 204[1]. Is it a typo?

Ah, it is, my bad. This is a merge error and easy enough to fix, I've
fixed it in my local tree. Thanks for pointing it out!

Thanks,
Eryu

> 
> [1]: https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=1d6d14db1165db1ffc87fbddcf97eb70fdf84607
> 
> > 
> > Thanks,
> > Eryu
> > 
> > > ---
> > > Changes from v2:
> > > * Added 'Created subvolume...' into 203.out to match the subvolume creating command
> > > * Changed awk to $AWK_PROG, suggested by Eryu
> > > * Changed _run_btrfs_util_prog to $BTRFS_UTIL_PROG, suggested by Eryu
> > > * Use _scratch_unmount instead of executing umount by hand, sugested by Eryu
> > > * Created a local function to delete and list subvolumes, suggested by Eryu
> > > 
> > > Changes from v1:
> > > * Added some prints printing what is being tested
> > > * The test now uses the _btrfs_get_subvolid to get subvolumeids instead of using
> > >   plain integers
> > > 
> > > 
> > >  tests/btrfs/203     | 68 +++++++++++++++++++++++++++++++++++++++++++++
> > >  tests/btrfs/203.out | 17 ++++++++++++
> > >  tests/btrfs/group   |  1 +
> > >  3 files changed, 86 insertions(+)
> > >  create mode 100755 tests/btrfs/203
> > >  create mode 100644 tests/btrfs/203.out
> > > 
> > > diff --git a/tests/btrfs/203 b/tests/btrfs/203
> > > new file mode 100755
> > > index 00000000..0f662db1
> > > --- /dev/null
> > > +++ b/tests/btrfs/203
> > > @@ -0,0 +1,68 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
> > > +#
> > > +# FSQA Test No. 203
> > > +#
> > > +# Test subvolume deletion using the subvolume id, even when the subvolume in
> > > +# question is in a different mount space.
> > > +#
> > > +seq=`basename $0`
> > > +seqres=$RESULT_DIR/$seq
> > > +echo "QA output created by $seq"
> > > +tmp=/tmp/$$
> > > +status=1	# failure is the default!
> > > +
> > > +# get standard environment, filters and checks
> > > +. ./common/rc
> > > +. ./common/filter
> > > +. ./common/filter.btrfs
> > > +
> > > +# real QA test starts here
> > > +_supported_fs btrfs
> > > +_supported_os Linux
> > > +_require_scratch
> > > +_require_btrfs_command subvolume delete --subvolid
> > > +
> > > +_scratch_mkfs > /dev/null 2>&1
> > > +_scratch_mount
> > > +
> > > +_delete_and_list()
> > > +{
> > > +	local subvol_name="$1"
> > > +	local msg="$2"
> > > +
> > > +	SUBVOLID=$(_btrfs_get_subvolid $SCRATCH_MNT "$subvol_name")
> > > +	$BTRFS_UTIL_PROG subvolume delete --subvolid $SUBVOLID $SCRATCH_MNT | _filter_scratch
> > > +
> > > +	echo "$msg"
> > > +	$BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | $AWK_PROG '{ print $NF }'
> > > +}
> > > +
> > > +# Test creating a normal subvolumes
> > > +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol1 | _filter_scratch
> > > +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol2 | _filter_scratch
> > > +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol3 | _filter_scratch
> > > +
> > > +echo "Current subvolume ids:"
> > > +$BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | $AWK_PROG '{ print $NF }'
> > > +
> > > +# Delete the subvolume subvol1, and list the remaining two subvolumes
> > > +_delete_and_list subvol1 "After deleting one subvolume:"
> > > +_scratch_unmount
> > > +
> > > +# Now we mount the subvol2, which makes subvol3 not accessible for this mount
> > > +# point, but we should be able to delete it using it's subvolume id
> > > +$MOUNT_PROG -o subvol=subvol2 $SCRATCH_DEV $SCRATCH_MNT
> > > +_delete_and_list subvol3 "Last remaining subvolume:"
> > > +_scratch_unmount
> > > +
> > > +# now mount the rootfs
> > > +_scratch_mount
> > > +# Delete the subvol2
> > > +_delete_and_list subvol2 "All subvolumes removed."
> > > +_scratch_unmount
> > > +
> > > +# success, all done
> > > +status=0
> > > +exit
> > > diff --git a/tests/btrfs/203.out b/tests/btrfs/203.out
> > > new file mode 100644
> > > index 00000000..3301852b
> > > --- /dev/null
> > > +++ b/tests/btrfs/203.out
> > > @@ -0,0 +1,17 @@
> > > +QA output created by 203
> > > +Create subvolume 'SCRATCH_MNT/subvol1'
> > > +Create subvolume 'SCRATCH_MNT/subvol2'
> > > +Create subvolume 'SCRATCH_MNT/subvol3'
> > > +Current subvolume ids:
> > > +subvol1
> > > +subvol2
> > > +subvol3
> > > +Delete subvolume (no-commit): 'SCRATCH_MNT/subvol1'
> > > +After deleting one subvolume:
> > > +subvol2
> > > +subvol3
> > > +Delete subvolume (no-commit): 'SCRATCH_MNT/subvol3'
> > > +Last remaining subvolume:
> > > +subvol2
> > > +Delete subvolume (no-commit): 'SCRATCH_MNT/subvol2'
> > > +All subvolumes removed.
> > > diff --git a/tests/btrfs/group b/tests/btrfs/group
> > > index 79f85e97..e7744217 100644
> > > --- a/tests/btrfs/group
> > > +++ b/tests/btrfs/group
> > > @@ -204,3 +204,4 @@
> > >  200 auto quick send clone
> > >  201 auto quick punch log
> > >  202 auto quick subvol snapshot
> > > +203 auto quick subvol
> > > -- 
> > > 2.25.0
> > > 

> From 2541e8ef08d45030f97073ef1e5bc9196ef22e4d Mon Sep 17 00:00:00 2001
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> Date: Sun, 26 Jan 2020 23:44:22 -0300
> Subject: [PATCHv4] btrfs: Test subvolume delete --subvolid feature
> 
> Now btrfs can delete subvolumes based in ther subvolume id. This makes
> easy for the user willing to delete a subvolume that cannot be accessed
> by the mount point, since btrfs allows to mount a specific subvolume and
> hiding the other from the mount point.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
> Changes from v3:
> * Changes test 203 -> 207, since other tests were merged
> * The first patch was merged, so remove it from sending again
>   [https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=2f9b4039253d3a6f91cb2a22639a243b5a27e110]
> 
> Changes from v2:
> * Added Reviewed-by from Nikolay to patch 0001
> * Changed awk to $AWK_PROG, suggested by Eryu
> * Changed _run_btrfs_util_prog to $BTRFS_UTIL_PROG, suggested by Eryu
> * Use _scratch_unmount instead of executing umount by hand, sugested by Eryu
> * Created a local function to delete and list subvolumes, suggested by Eryu
> 
> Changes from v1:
> * Added some prints printing what is being tested
> * The test now uses the _btrfs_get_subvolid to get subvolumeids instead of using
>   plain integers
> * New patch expanding the funtionality of _require_btrfs_command, which now
>   check for argument of subcommands
> 
>  tests/btrfs/207     | 68 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/207.out | 17 ++++++++++++
>  tests/btrfs/group   |  1 +
>  3 files changed, 86 insertions(+)
>  create mode 100755 tests/btrfs/207
>  create mode 100644 tests/btrfs/207.out
> 
> diff --git a/tests/btrfs/207 b/tests/btrfs/207
> new file mode 100755
> index 00000000..bec5baea
> --- /dev/null
> +++ b/tests/btrfs/207
> @@ -0,0 +1,68 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FSQA Test No. 207
> +#
> +# Test subvolume deletion using the subvolume id, even when the subvolume in
> +# question is in a different mount space.
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/filter.btrfs
> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_scratch
> +_require_btrfs_command subvolume delete --subvolid
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +
> +_delete_and_list()
> +{
> +	local subvol_name="$1"
> +	local msg="$2"
> +
> +	SUBVOLID=$(_btrfs_get_subvolid $SCRATCH_MNT "$subvol_name")
> +	$BTRFS_UTIL_PROG subvolume delete --subvolid $SUBVOLID $SCRATCH_MNT | _filter_scratch
> +
> +	echo "$msg"
> +	$BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | $AWK_PROG '{ print $NF }'
> +}
> +
> +# Test creating a normal subvolumes
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol1 | _filter_scratch
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol2 | _filter_scratch
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol3 | _filter_scratch
> +
> +echo "Current subvolume ids:"
> +$BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | $AWK_PROG '{ print $NF }'
> +
> +# Delete the subvolume subvol1, and list the remaining two subvolumes
> +_delete_and_list subvol1 "After deleting one subvolume:"
> +_scratch_unmount
> +
> +# Now we mount the subvol2, which makes subvol3 not accessible for this mount
> +# point, but we should be able to delete it using it's subvolume id
> +$MOUNT_PROG -o subvol=subvol2 $SCRATCH_DEV $SCRATCH_MNT
> +_delete_and_list subvol3 "Last remaining subvolume:"
> +_scratch_unmount
> +
> +# now mount the rootfs
> +_scratch_mount
> +# Delete the subvol2
> +_delete_and_list subvol2 "All subvolumes removed."
> +_scratch_unmount
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/207.out b/tests/btrfs/207.out
> new file mode 100644
> index 00000000..e3f7daa4
> --- /dev/null
> +++ b/tests/btrfs/207.out
> @@ -0,0 +1,17 @@
> +QA output created by 207
> +Create subvolume 'SCRATCH_MNT/subvol1'
> +Create subvolume 'SCRATCH_MNT/subvol2'
> +Create subvolume 'SCRATCH_MNT/subvol3'
> +Current subvolume ids:
> +subvol1
> +subvol2
> +subvol3
> +Delete subvolume (no-commit): 'SCRATCH_MNT/subvol1'
> +After deleting one subvolume:
> +subvol2
> +subvol3
> +Delete subvolume (no-commit): 'SCRATCH_MNT/subvol3'
> +Last remaining subvolume:
> +subvol2
> +Delete subvolume (no-commit): 'SCRATCH_MNT/subvol2'
> +All subvolumes removed.
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index e3ad347b..1acf6af7 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -209,3 +209,4 @@
>  204 auto quick punch
>  205 auto quick clone compress
>  204 auto quick log replay
> +207 auto quick subvol
> -- 
> 2.25.0
> 

