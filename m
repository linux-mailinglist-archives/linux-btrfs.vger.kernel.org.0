Return-Path: <linux-btrfs+bounces-20106-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B25B0CF4C25
	for <lists+linux-btrfs@lfdr.de>; Mon, 05 Jan 2026 17:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0571831126D2
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jan 2026 16:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8956309EF5;
	Mon,  5 Jan 2026 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDdzvhFn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAF931DDA4
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Jan 2026 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767630187; cv=none; b=InDx/rbjjLQ84T8+y9aHj6g8r7uIbHSpuqpziyzpkONlPMwZDkbkVi3OeE/126JoqAGOFXQvRQaw/fjssHZhbjsOQjtieQuMPV5538im7oxg8u1DX1x1yr/j+Uie9fh+hL+/ihWuhbiweRnIWuugwXSCoSOV+YrA1s03qPEykUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767630187; c=relaxed/simple;
	bh=KCDYm5B7n4J3N1HDTck2bGaxk45jnuFVNtD8YIOA1r8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1xh6Vhnn0A29pLg4m1VtYPMOLksg/izKCF8bXJNHXVtoApC63RuC72YP5VIHUpxatsrRptd/LdjDcdqte19oivY7l4j8ZYGlIgrrvBm0gJqjrzYw+48jeAdbwEoBLx38WIrP4/MgybjqRETN3Rk2llPZ55/H1816bl/DEBTmKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDdzvhFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88137C19424
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Jan 2026 16:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767630186;
	bh=KCDYm5B7n4J3N1HDTck2bGaxk45jnuFVNtD8YIOA1r8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sDdzvhFnoCXd9PtOX7DZoAvv5FviDA4GzPxiA7CLR7de5lFuJsYYi9EaoZTl3WF6T
	 /SSXqdQnScyaQDGT2w4KmHDFiPmU/ZXFO1ic5gObnrdbcyrBTjU0WeDeKMrCHiUkOB
	 m3zEB2DSPxMesy43C2QvD+U5HNwF5EofaYykuwS5LNCBAj+TE8R6WcdroC7ZmLTQsW
	 eHfA2XV/VY9YnBs3ZQjp3R5KM2qvwzc9iUMlxgGaYLJB9mBsNscyoABnbQUac97n+L
	 45OokrOhy6esQy3PU6bXiHCicKBVMDky6mWukcL868E+F3xmR9Qb85sKtNtvRqPCTy
	 di9w5KlXmT6HA==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b8010b8f078so26262866b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jan 2026 08:23:06 -0800 (PST)
X-Gm-Message-State: AOJu0YyxkZ8hfMDyz5VWt9rBlUZtZxeZ96tCBNvZNS6YcJ0Wegph6hoc
	WdnvHKfqELp9bOztlyR4yWFNZ9qHd5qSsIirtogXpnSimkNOI+6n+o5rZlB5XH6jKTK40hp5ljM
	U5btd/poovzx8WtaK+3e2Mk3UvGHQoZw=
X-Google-Smtp-Source: AGHT+IHsFKlLybpf17m13vzVs9Wc5wf8AEuk75neSRsMbGzLhfx14A72516Mg3Agvj57h2u8VOsgRPVJbLLDDmdzeyI=
X-Received: by 2002:a17:906:d551:b0:b84:200d:15b5 with SMTP id
 a640c23a62f3a-b8426bb8790mr36525666b.31.1767630185087; Mon, 05 Jan 2026
 08:23:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3cb8fdeec6e3bf977682d1074bf3e7ba1719b98c.1765466812.git.fdmanana@suse.com>
In-Reply-To: <3cb8fdeec6e3bf977682d1074bf3e7ba1719b98c.1765466812.git.fdmanana@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 5 Jan 2026 16:22:28 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7AY2iC+Z8LEv8+TawbuXJdwoXei_0d+NEccVYE5Wu3PA@mail.gmail.com>
X-Gm-Features: AQt7F2rIvozY87jBv-flxCjNEjK8tkqdff9snu8adOa6xqW7lJJ8zJZRa79IO2M
Message-ID: <CAL3q7H7AY2iC+Z8LEv8+TawbuXJdwoXei_0d+NEccVYE5Wu3PA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: test power failure after fsync and rename
 exchanging directories
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>, 
	Zorro Lang <zlang@kernel.org>, Zorro Lang <zlang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 3:42=E2=80=AFPM <fdmanana@kernel.org> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> Test renaming one directory over another one that has a subvolume inside
> it and fsync a file in the other directory that was previously renamed.
> We want to verify that after a power failure we are able to mount the
> filesystem and it has the correct content (all renames visible).
>
> This exercises a bug fixed by the following kernel patch:
>
>   "btrfs: always detect conflicting inodes when logging inode refs"
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Ping.

Zorro, this missed the last update.


> ---
>  tests/btrfs/340     | 75 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/340.out | 15 +++++++++
>  2 files changed, 90 insertions(+)
>  create mode 100755 tests/btrfs/340
>  create mode 100644 tests/btrfs/340.out
>
> diff --git a/tests/btrfs/340 b/tests/btrfs/340
> new file mode 100755
> index 00000000..d52893ae
> --- /dev/null
> +++ b/tests/btrfs/340
> @@ -0,0 +1,75 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 SUSE S.A.  All Rights Reserved.
> +#
> +# FS QA Test 340
> +#
> +# Test renaming one directory over another one that has a subvolume insi=
de it
> +# and fsync a file in the other directory that was previously renamed. W=
e want
> +# to verify that after a power failure we are able to mount the filesyst=
em and
> +# it has the correct content (all renames visible).
> +#
> +. ./common/preamble
> +_begin_fstest auto quick subvol rename log
> +
> +_cleanup()
> +{
> +       _cleanup_flakey
> +       cd /
> +       rm -r -f $tmp.*
> +}
> +
> +. ./common/filter
> +. ./common/dmflakey
> +. ./common/renameat2
> +
> +_require_scratch
> +_require_dm_target flakey
> +_require_renameat2 exchange
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +       "btrfs: always detect conflicting inodes when logging inode refs"
> +
> +_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> +_require_metadata_journaling $SCRATCH_DEV
> +_init_flakey
> +_mount_flakey
> +
> +# Create our test directories, one with a file inside, another with a su=
bvolume
> +# that is not empty (has one file).
> +mkdir $SCRATCH_MNT/dir1
> +echo -n > $SCRATCH_MNT/dir1/foo
> +
> +mkdir $SCRATCH_MNT/dir2
> +_btrfs subvolume create $SCRATCH_MNT/dir2/subvol
> +echo -n > $SCRATCH_MNT/dir2/subvol/subvol_file
> +
> +_scratch_sync
> +
> +# Rename file foo so that its inode's last_unlink_trans is updated to th=
e
> +# current transaction.
> +mv $SCRATCH_MNT/dir1/foo $SCRATCH_MNT/dir1/bar
> +
> +# Rename exchange dir1 with dir2.
> +$here/src/renameat2 -x $SCRATCH_MNT/dir1 $SCRATCH_MNT/dir2
> +
> +# Fsync file bar, we just renamed from foo.
> +# Until the kernel fix mentioned above, it would result in logging dir2 =
without
> +# logging dir1, causing log replay to attempt to remove the inode for di=
r1 since
> +# the inode for dir2 has the same name in the same parent directory. Not=
 only
> +# this was not correct, since we did not delete the directory, but it wo=
uld also
> +# result in a log replay failure (and therefore mount failure) because w=
e would
> +# be attempting to delete a directory with a non-empty subvolume inside =
it.
> +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/dir2/bar
> +
> +# Simulate a power failure and then mount again the filesystem to replay=
 the
> +# journal/log. We should be able to replay the log tree and mount succes=
sfully.
> +_flakey_drop_and_remount
> +
> +echo -e "Filesystem contents after power failure:\n"
> +ls -1R $SCRATCH_MNT | _filter_scratch
> +
> +_unmount_flakey
> +
> +# success, all done
> +_exit 0
> diff --git a/tests/btrfs/340.out b/tests/btrfs/340.out
> new file mode 100644
> index 00000000..7745c639
> --- /dev/null
> +++ b/tests/btrfs/340.out
> @@ -0,0 +1,15 @@
> +QA output created by 340
> +Filesystem contents after power failure:
> +
> +SCRATCH_MNT:
> +dir1
> +dir2
> +
> +SCRATCH_MNT/dir1:
> +subvol
> +
> +SCRATCH_MNT/dir1/subvol:
> +subvol_file
> +
> +SCRATCH_MNT/dir2:
> +bar
> --
> 2.47.2
>
>

