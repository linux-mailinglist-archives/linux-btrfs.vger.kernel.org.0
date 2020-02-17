Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C78C1612B4
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 14:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgBQNKP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 08:10:15 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35148 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgBQNKP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 08:10:15 -0500
Received: by mail-pf1-f194.google.com with SMTP id y73so8877167pfg.2;
        Mon, 17 Feb 2020 05:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a+yDUU9TIHk8Twh90LmCjRC3Qz78kOz6L565IaPsqqY=;
        b=Uk6bPDxKhPv7jHBnUlTBrX3ESzhRDQrFFhcNFn/+LwXmz5Iu8pDHDUnTUWpqYD1F1z
         4+S2Wv7/ahYFHKYm04LZHJ7JnLGPMVX4gWwir9/CdOqXjFLMNFOkPwe24LDLFNkHRzmv
         y4uKNPj1x7jrP1xdIydi8K3v3GHnBx4SqScUfYDDsQzNd7cYPseABMvP2giiAmbR85PA
         hXy6uCiAtu8lRJzJZlRP6LciMr363FGaYQAUtRLx7BKq2/4j2ZfZyV/v7SrRlJqRRtI9
         KOTFn7Tb2RzlI0f4XGkJaYe2BmUpnD+TC7jPgNeUMz3DSlKst52FxyM51a1zv2ewadii
         lyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a+yDUU9TIHk8Twh90LmCjRC3Qz78kOz6L565IaPsqqY=;
        b=ms85eozNzcQogVpCUFS6In476U+B8qE+Phouk9mIUWu9Vhy+BAvGq1xWZ4b+xhYuFc
         HYrqycvTbqsXU/31pqba39k5/v5YdWPLlDAFvolAPF1Scu+vLvHwe4vawVUflJeoYKlj
         2pATQyhdSQ95eKePg+4PTEU3S7kBaNWeRrwUdkKgnkkGSQ5C09CSd8EguJSfZ4xK+Oe5
         lxJ17tR6ADf2t2W4GD1XPnu2qUeurvQuWR6PXptI+qyYphy/u04TybFNiKj6FoA3uIzI
         bfAoQNzMb8MhafNmqT4uSVcQqKO2cxj8mGZnDAZ3zE7C6uYToWh1HuPqbFSj+u5PrlFK
         BC+g==
X-Gm-Message-State: APjAAAWvC46Q7m8b5nokG7WfwKAszKQz1Ywg2ptHcuH2gDAhy405larr
        0bKj+MYjVNoUdInvUKhHlKj3tvTgQ1k=
X-Google-Smtp-Source: APXvYqyU4LBjKc0XHNVccZ6Wjx9wIQNNbGPzdrUxiMgtQqZjG4fU/UjdL7PJnkSICGtGWnWusQttcg==
X-Received: by 2002:a17:90b:1256:: with SMTP id gx22mr19883622pjb.94.1581945014811;
        Mon, 17 Feb 2020 05:10:14 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id b1sm950824pgs.27.2020.02.17.05.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 05:10:14 -0800 (PST)
Date:   Mon, 17 Feb 2020 21:10:08 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCHv2 2/2]  btrfs: Test subvolume delete --subvolid feature
Message-ID: <20200217131006.GM2697@desktop>
References: <20200207131951.15859-1-marcos.souza.org@gmail.com>
 <20200207131951.15859-3-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207131951.15859-3-marcos.souza.org@gmail.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 07, 2020 at 10:19:51AM -0300, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
> Changes from v1:
> * Added some prints printing what is being tested
> * The test now uses the _btrfs_get_subvolid to get subvolumeids instead of using
>   plain integers
> 
>  tests/btrfs/203     | 73 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/203.out | 14 +++++++++
>  tests/btrfs/group   |  1 +
>  3 files changed, 88 insertions(+)
>  create mode 100755 tests/btrfs/203
>  create mode 100644 tests/btrfs/203.out
> 
> diff --git a/tests/btrfs/203 b/tests/btrfs/203
> new file mode 100755
> index 00000000..b9f1391f
> --- /dev/null
> +++ b/tests/btrfs/203
> @@ -0,0 +1,73 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FSQA Test No. 203
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
> +# Test creating a normal subvolumes
> +_run_btrfs_util_prog subvolume create $SCRATCH_MNT/subvol1 | _filter_scratch
> +_run_btrfs_util_prog subvolume create $SCRATCH_MNT/subvol2 | _filter_scratch
> +_run_btrfs_util_prog subvolume create $SCRATCH_MNT/subvol3 | _filter_scratch

The usa of _run_btrfs_util_prog is deprecated, please use bare
$BTRFS_UTIL_PROG commands, and do filter as needed.

> +
> +echo "Current subvolume ids:"
> +$BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | awk '{ print $NF }'

Use $AWK_PROG instead of bare awk. And I noticed this pattern repeated
for several times, make it a local helper function?

> +
> +# Delete the subvolume subvol1 using it's subvolume id
> +SUBVOLID=$(_btrfs_get_subvolid $SCRATCH_MNT subvol1)
> +$BTRFS_UTIL_PROG subvolume delete --subvolid $SUBVOLID  $SCRATCH_MNT | _filter_scratch
> +
> +echo "After deleting one subvolume:"
> +# should present only two subvolumes
> +$BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | awk '{ print $NF }'
> +
> +umount $SCRATCH_MNT

Does _scratch_unmount work here?

> +
> +# Now we mount the subvol2, which makes subvol3 not accessible for this mount
> +# point, but we should be able to delete it using it's subvolume id
> +$MOUNT_PROG -o subvol=subvol2 $SCRATCH_DEV $SCRATCH_MNT
> +SUBVOLID=$(_btrfs_get_subvolid $SCRATCH_MNT subvol3)
> +$BTRFS_UTIL_PROG subvolume delete --subvolid $SUBVOLID $SCRATCH_MNT | _filter_scratch
> +
> +echo "Last remaining subvolume:"
> +$BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | awk '{ print $NF }'
> +
> +umount $SCRATCH_MNT

_scratch_unmount

> +
> +# now mount the rootfs
> +_scratch_mount
> +
> +# Delete the subvol2
> +SUBVOLID=$(_btrfs_get_subvolid $SCRATCH_MNT subvol2)
> +$BTRFS_UTIL_PROG subvolume delete --subvolid $SUBVOLID  $SCRATCH_MNT | _filter_scratch
> +
> +echo "All subvolumes removed."
> +$BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | awk '{ print $NF }'
> +
> +umount $SCRATCH_MNT

_scratch_unmount

Thanks,
Eryu

> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/203.out b/tests/btrfs/203.out
> new file mode 100644
> index 00000000..bca18c32
> --- /dev/null
> +++ b/tests/btrfs/203.out
> @@ -0,0 +1,14 @@
> +QA output created by 203
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
> index 79f85e97..e7744217 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -204,3 +204,4 @@
>  200 auto quick send clone
>  201 auto quick punch log
>  202 auto quick subvol snapshot
> +203 auto quick subvol
> -- 
> 2.24.0
> 
