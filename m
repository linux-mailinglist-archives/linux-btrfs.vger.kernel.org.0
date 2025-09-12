Return-Path: <linux-btrfs+bounces-16801-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFEBB54D0B
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Sep 2025 14:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4A73A01172
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Sep 2025 12:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9649C3148CD;
	Fri, 12 Sep 2025 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o44q+v4X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF3531354D
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Sep 2025 12:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678740; cv=none; b=hxISPsY0SvF42kkRb+dBOHw3B1oocR6KUzKN+tBScKm57ZEw82LuV5LNr0gj0QDY1mPKFbihl5PFWWJO+n7vNSyJhO4bIHA9LLNKT5buIQrAQ/K5TkGYdGajm1hF+CmjMk8LKSPMl/H0c85AB1VxiXWoAHYCv5NJkikK4gPAFSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678740; c=relaxed/simple;
	bh=0pC1lfWk6+jP6+pC3zHuddf5lzlzyoZws/rukNAJBK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WfcSCq8FtzoTNnGR9KzI4PjfjEyI+1kmuW6kbB9UPRnXGHlHy6/nWaLRgszTnH53yjyzuUdA5RmCw5900smaqkFNtNDart4ANBEGecWUGq7oEpm4JgrkudOyN25ppk3ojn6YFLhxbwKCZgXUqjvDEmqkRohFjEp+c3t6TaImuFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o44q+v4X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369D0C4CEFB
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Sep 2025 12:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757678740;
	bh=0pC1lfWk6+jP6+pC3zHuddf5lzlzyoZws/rukNAJBK0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=o44q+v4X9uBY+fOhR8I0a+m0sPV7dWBaw0UV8/l5FI2Aqb5CVvjn9ctIHsB4iARLV
	 A48GG8VCJxbodGIolgTJFMc1nC9J10+NqXwD/PH4zKOJ/VmxR8Ffrc1nKQUwlO+Zch
	 fAuvBQ7jT18zUZJjGXltkWVooEN0f2KCWozwTu/uH0NPRCLKJ/xKtyKpeLCzjq9J5V
	 ti+pCJzTTJXd8/spYW98XpXzeDycl9nUCV2yGlXXhBlgjI4CTbK/ZLWKUDWobyUGup
	 TEGqMBoutVFwv10UC2T28qlEIx4Gqx7OqaJ63uQep7WfQL7b5T1Fz+wh+iub4B/DuT
	 qVf6mR1lXqQ4Q==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b00a9989633so332594666b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Sep 2025 05:05:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkwtKXA7VZDkEohQtgeDBlj4TY8LnJCDZ5EsPvwZnLtvO89lANTF7K9jwG3yZEEEwQje/NcT0651Bswg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7YvA8RYavo42yDELQI0unlFWUiBI61QwwOKyMPamztU3Ft5SW
	rtw1XJq/JfyOQpSUJv5bxJCQfOPJpLp5ylMtYYfjLZ2YhoDTZXz7683Uid83A/USG9Ff1vQICMm
	zEOIt1urTdnCZ8S80wjjk6nw6v0w5Yi8=
X-Google-Smtp-Source: AGHT+IGSis3VWPvPE8EHuaD2eyQKcjAN/PNXshIi9wptgez6ZiNHhiu53EwK9NDprvGTW5Z6Ea6AFn8vad4kWlB2M/k=
X-Received: by 2002:a17:907:3f0b:b0:afe:6648:a243 with SMTP id
 a640c23a62f3a-b07a629104dmr737215366b.3.1757678738663; Fri, 12 Sep 2025
 05:05:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912093412.1900895-1-austinchang@synology.com>
In-Reply-To: <20250912093412.1900895-1-austinchang@synology.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 12 Sep 2025 13:05:01 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6BCwfi1uzajac9+2TQaMkCK0_Z89tYvYqRdq_O0E-ySw@mail.gmail.com>
X-Gm-Features: Ac12FXxsBXEfepYM8piN_eUCWlb55qnStDR9S6mKVCuCxro9bcM_AhSPXZi7G-M
Message-ID: <CAL3q7H6BCwfi1uzajac9+2TQaMkCK0_Z89tYvYqRdq_O0E-ySw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: mark dirty bit for out of bound prealloc extents
To: austinchang <austinchang@synology.com>
Cc: dsterba@suse.com, linux-btrfs@vger.kernel.org, robbieko@synology.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 10:36=E2=80=AFAM austinchang <austinchang@synology.=
com> wrote:
>
> In btrfs_fallocate(), when the allocated range overlaps with a prealloc
> extent and the extent starts after i_size, the range doesn't get marked
> dirty in file_extent_tree.
>
> It affects btrfs_find_contiguous_extent_bit() in
> btrfs_inode_safe_disk_i_size_write() procedure and can produce wrong
> on-disk i_size.
>
> This would be reproducible since the commit
> 41a2ee7("btrfs: introduce per-inode file extent tree"), and became hidden
> since 3d7db6e("btrfs: don't allocate file extent tree for non regular fil=
es")

The format to use in kernel change logs is:

<first 12 characters of commit> <single splace> ("btrfs: ...")

So for example:

41a2ee75aab0 ("btrfs: introduce per-inode file extent tree")

> stops initializing file_extent_tree. A quick example as follows:
>
> btrfs sub cre sub1
> touch sub1/file
> fallocate -n -o 1359872 -l 540672 sub1/file
> btrfs sub snap sub1 sub2
> fallocate -n -p -o 1359872 -l 395859 sub2/file
> fallocate -o 1359872 -l 395859 sub2/file
> echo 3 > /proc/sys/vm/drop_caches
> ls -l sub2/file
>
> The correct size should be 1755731 instead of 1753088.
>
> Fix by adding a call to btrfs_inode_set_file_extent_range() for such
> extents.

This is a too terse and incomplete explanation.

First, let the example be explicit that for this to trigger it needs
to run without the no-holes feature enabled (which is a default for
quite some time now).

Second, why do we need snapshots and subvolumes?
The first paragraph doesn't explain the whole picture, since without
creating a RW snapshot and doing the second and third fallocates on
the snapshot, the problem doesn't reproduce.
So snapshotting seems to be a necessary condition - but why?

The subvolume creation is an unnecessary step, we can just use the
default subvolume and make the example more concise.

Also please make the reproducer easier to follow, with comments, with
more friendly values, explanation for any magic values and without
unnecessary steps.
For example, this:

"
The following reproducer triggers the problem:

$ cat test.sh
#!/bin/bash

DEV=3D/dev/sdi
MNT=3D/mnt/sdi

mkfs.btrfs -f -O ^no-holes $DEV
mount $DEV $MNT

touch $MNT/file
# Add a 2M extent at file offset 1M without increasing i_size.
fallocate -n -o 1M -l 2M $MNT/file

# Maybe add a comment here explaining why we need the snapshot.
btrfs subvolume snapshot $MNT $MNT/snap

# Use a length not aligned to sector size - 1M + 123 bytes.
len=3D$((1 * 1024 * 1024 + 123))

# Now punch a hole at the start of the new allocated extent for a
# length that is smaller than the extent's length and unaligned.
fallocate -n -p -o 1M -l $len $MNT/snap/file

# Now allocate the range which we punched a hole for and allow
# fallocate to increase the file's i_size.
fallocate -o 1M -l $len $MNT/snap/file

# Check the file size, should be 2M + 123 bytes (1M + $len).
du --bytes $MNT/snap/file

# Unmount and mount again the fs.
umount $MNT
mount $DEV $MNT

# The file size should be the same as before.
du --bytes $MNT/snap/file

umount $MNT

Running reproducer gives the following result:

$ ./test.sh
(...)
Create snapshot of '/mnt/sdi' in '/mnt/sdi/snap'
2097275 /mnt/sdi/snap/file
2097152 /mnt/sdi/snap/file

The difference is exactly 123 bytes ...
"

This makes it a lot easier to understand without magic values and
making it clear that an unaligned length is needed to trigger the
problem.

But please explain why the snapshotting is needed to trigger the
problem as well as the unaligned range.

Once that is clear and we have a minimal reproducer, we should also
have a test for fstests to prevent regressions.


>
> Signed-off-by: austinchang <austinchang@synology.com>

Here missing a Fixes tag:

Fixes: 41a2ee75aab0 ("btrfs: introduce per-inode file extent tree")

> ---
>  fs/btrfs/file.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 204674934..e78646389 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -3209,6 +3209,11 @@ static long btrfs_fallocate(struct file *file, int=
 mode,
>                         }
>                         qgroup_reserved +=3D range_len;
>                         data_space_needed +=3D range_len;
> +               } else {
> +                       ret =3D btrfs_inode_set_file_extent_range(BTRFS_I=
(inode),
> +                                       em->start, em->len);
> +                       if (ret < 0)
> +                               break;

This is an odd place for this.
I'd rather have this placed in the most logical place which is
btrfs_fallocate_update_isize(), since it's where we update i_size and
this is closely related.

So:

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 4daec404fec6..6adc07ca6125 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2855,12 +2855,22 @@ static int btrfs_fallocate_update_isize(struct
inode *inode,
 {
        struct btrfs_trans_handle *trans;
        struct btrfs_root *root =3D BTRFS_I(inode)->root;
+       u64 range_start;
+       u64 range_end;
        int ret;
        int ret2;

        if (mode & FALLOC_FL_KEEP_SIZE || end <=3D i_size_read(inode))
                return 0;

+       range_start =3D round_down(i_size_read(inode), root->fs_info->secto=
rsize);
+       range_end =3D round_up(end, root->fs_info->sectorsize);
+
+       ret =3D btrfs_inode_set_file_extent_range(BTRFS_I(inode), range_sta=
rt,
+                                               range_end - range_start);
+       if (ret)
+               return ret;
+
        trans =3D btrfs_start_transaction(root, 1);
        if (IS_ERR(trans))
                return PTR_ERR(trans);

Thanks.

>                 }
>                 btrfs_free_extent_map(em);
>                 cur_offset =3D last_byte;
> --
> 2.34.1
>
>
> Disclaimer: The contents of this e-mail message and any attachments are c=
onfidential and are intended solely for addressee. The information may also=
 be legally privileged. This transmission is sent in trust, for the sole pu=
rpose of delivery to the intended recipient. If you have received this tran=
smission in error, any use, reproduction or dissemination of this transmiss=
ion is strictly prohibited. If you are not the intended recipient, please i=
mmediately notify the sender by reply e-mail or phone and delete this messa=
ge and its attachments, if any.
>

