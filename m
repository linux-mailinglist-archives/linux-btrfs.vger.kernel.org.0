Return-Path: <linux-btrfs+bounces-8956-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACEF9A0819
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 13:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FA1D282B82
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 11:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2272076B0;
	Wed, 16 Oct 2024 11:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BV9kZYCw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433B31C07EA;
	Wed, 16 Oct 2024 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729077025; cv=none; b=FshOAPfVjrIizaJEWnyop/urkKpdu8X0z/MqKkYa2ATzYVEQopOrFXDaBWsVNGHjMcSHAFtEE5TxBaSqqBJoxSUmo+zlJvvh8rnkrLfkfJ2TpWDcYU9e/OHJBucarDJAJ2IEHZKvV65cErZmwbrlN/p+jhKuXQQERaANMc0ns8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729077025; c=relaxed/simple;
	bh=O2cuOoIXjcfjaimiMrzckaCV2XXDjo9KLgsWqT+luQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZdKB0CBoG58j+T8KBnFFJN9VD1tjHLkz3DlzNG2f5JD6lwW/8B65PPaTOK63tPpps33k0N+Icf3Apk2pjTJyUKnCW1m/zPGzws2yUfR6ZsOt9BzXQxkY/IM7zz7kmzk2rWRwyUiFPx5jpo1WY39HvxeaJ3bBOCMV+iav/xZMi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BV9kZYCw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA0FC4CEC5;
	Wed, 16 Oct 2024 11:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729077024;
	bh=O2cuOoIXjcfjaimiMrzckaCV2XXDjo9KLgsWqT+luQw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BV9kZYCwBmZj/r3vEMdQemadan0oXxTxSgMElJNEUAHkat32Y56asTulL6oOgjetN
	 Wy6ZSy+Jl7VVUUtqx1FrvkALrRkk1waScmUp9l6ZsY0ROnwMUkKx7NHWjQmR4g8t2X
	 4vhAaq+3n83qA0bmubzPO3wTx1PhgG2dD0hzkIPFAiCNq3xoFzrMHHaEdDu3Xj7gu7
	 4bU5GtZbjY6Mi2VfxYWNHpkYqevWg4b9phlWG9ypCM2rw9XwNh4UGfGo9NTmIv4D9X
	 cCijjxJgr7/swQrUoedcT9jxlbe58M/HeEiN0N3pKtbeLlbkVSl+Axh7e7K1qgnpgP
	 Ud0xLaVfLIZhA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f1292a9bso4375137e87.2;
        Wed, 16 Oct 2024 04:10:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWPKyyOUF2MOa2gGlloHPQee+OPzK/CMS6/CxLiBoCTEPt18mCQgaBt3VDegpcphq+JADh4v/G32zRqxw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yys282glspFyyc19lx4jgtH0t6Gle4hTql8N68mVEXoI2ziC95p
	vpTlF08+bN7OdY+gbxVS/PU2hUGK8u9L+EM3wAUB8CqzjDx11D6xUBFjbAhkj5bd3A7Ze3imKhf
	nkSn6f5IGVr19aGMpwOiffbmESfs=
X-Google-Smtp-Source: AGHT+IEi1BAJJ1+jZyt4SL/39rY0gpC0lnJ3Kgns6uXEBXlkaK2vToY4EH/gLeBfx8nCr7OnJNfZsFz2084/ronfIA8=
X-Received: by 2002:a05:6512:4506:b0:52c:fd46:bf07 with SMTP id
 2adb3069b0e04-53a0704058dmr1066359e87.49.1729077023193; Wed, 16 Oct 2024
 04:10:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015153957.2099812-1-maharmstone@fb.com>
In-Reply-To: <20241015153957.2099812-1-maharmstone@fb.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 16 Oct 2024 12:09:46 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4wLLTLi_sfKEQB8qsQ6G7VxWBfK_4FwSi4qL5Z3bkycQ@mail.gmail.com>
Message-ID: <CAL3q7H4wLLTLi_sfKEQB8qsQ6G7VxWBfK_4FwSi4qL5Z3bkycQ@mail.gmail.com>
Subject: Re: [PATCH] generic: add test for missing btrfs csums in log when
 doing async on subpage vol
To: Mark Harmstone <maharmstone@fb.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 4:42=E2=80=AFPM Mark Harmstone <maharmstone@fb.com>=
 wrote:
>
> Adds a test for a bug we encountered on Linux 6.4 on aarch64, where a
> race could mean that csums weren't getting written to the log tree,
> leading to corruption when it was replayed.
>
> The patches to detect log this tree corruption are in btrfs-progs 6.11.

This shouldn't be needed right?
Because after log replay the csums are missing and 'btrfs check'
detects (IIRC) missing csums for extents referred by file extent items
in a subvolume tree - if it doesn't then it should be improved.

>
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---
> This is a genericized version of the test I originally proposed as
> btrfs/333.
>
>  tests/generic/757     | 71 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/757.out |  2 ++
>  2 files changed, 73 insertions(+)
>  create mode 100755 tests/generic/757
>  create mode 100644 tests/generic/757.out
>
> diff --git a/tests/generic/757 b/tests/generic/757
> new file mode 100755
> index 00000000..6ad3d01e
> --- /dev/null
> +++ b/tests/generic/757
> @@ -0,0 +1,71 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test 757
> +#
> +# Test async dio with fsync to test a btrfs bug where a race meant that =
csums
> +# weren't getting written to the log tree, causing corruptions on remoun=
t.
> +# This can be seen on subpage FSes on Linux 6.4.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick metadata log recoveryloop
> +
> +_fixed_by_kernel_commit e917ff56c8e7 \
> +       "btrfs: determine synchronous writers from bio or writeback contr=
ol"

For generic tests what we do is:

[ $FSTYP =3D=3D "btrfs" ] && _fixed_by_kernel_commit .....

As long as the failure has not been observed and fixed on other filesystems=
.
In case one day a regression happens in another fs, we just add a
corresponding line using the same logic.

Otherwise if the test one days fails on another fs and fstests
suggests that that commit is missing, it would be odd.

Everything else looks good, so with that fixed (maybe Zorro can change
that when picking the patch):

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.


> +
> +fio_config=3D$tmp.fio
> +
> +. ./common/dmlogwrites
> +
> +_require_scratch
> +_require_log_writes
> +
> +cat >$fio_config <<EOF
> +[global]
> +iodepth=3D128
> +direct=3D1
> +ioengine=3Dlibaio
> +rw=3Drandwrite
> +runtime=3D1s
> +[job0]
> +rw=3Drandwrite
> +filename=3D$SCRATCH_MNT/file
> +size=3D1g
> +fdatasync=3D1
> +EOF
> +
> +_require_fio $fio_config
> +
> +cat $fio_config >> $seqres.full
> +
> +_log_writes_init $SCRATCH_DEV
> +_log_writes_mkfs >> $seqres.full 2>&1
> +_log_writes_mark mkfs
> +
> +_log_writes_mount
> +
> +$FIO_PROG $fio_config > /dev/null 2>&1
> +_log_writes_unmount
> +
> +_log_writes_remove
> +
> +prev=3D$(_log_writes_mark_to_entry_number mkfs)
> +[ -z "$prev" ] && _fail "failed to locate entry mark 'mkfs'"
> +cur=3D$(_log_writes_find_next_fua $prev)
> +[ -z "$cur" ] && _fail "failed to locate next FUA write"
> +
> +while [ ! -z "$cur" ]; do
> +       _log_writes_replay_log_range $cur $SCRATCH_DEV >> $seqres.full
> +
> +       _check_scratch_fs
> +
> +       prev=3D$cur
> +       cur=3D$(_log_writes_find_next_fua $(($cur + 1)))
> +       [ -z "$cur" ] && break
> +done
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/generic/757.out b/tests/generic/757.out
> new file mode 100644
> index 00000000..dfbc8094
> --- /dev/null
> +++ b/tests/generic/757.out
> @@ -0,0 +1,2 @@
> +QA output created by 757
> +Silence is golden
> --
> 2.44.2
>
>

