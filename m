Return-Path: <linux-btrfs+bounces-21535-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEHFGsGviWndAgUAu9opvQ
	(envelope-from <linux-btrfs+bounces-21535-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 10:58:25 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4EA10DDF7
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 10:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48D973037140
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 09:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC34D366054;
	Mon,  9 Feb 2026 09:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ho8/cku6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BB0366040
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 09:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770630897; cv=none; b=NnkVlalj3YcFgYFq9HjJI4HaT3hDTEHE+k7sq4bvOHPIlk5hE+1Xh3t/446t4GVgZiN1px5cX00Ig7K8QcdNIxgMMdpAeVGB1qN7TreZkbvWUH7J1joIleOjTFkUk+p++4U3T4rXzX1vdKRudpOYGVywNiuLNViW3yrhPXu4blo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770630897; c=relaxed/simple;
	bh=hYODIDh8W+YitfT96sel4kiJsxob5ho0S42GjgaBDVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IfPG/sF0nJByNSxlI4zS1j33TDHpVIu774+2985WEXno9x2XjldpOUv1b/1KJlbocwp8fSt2FvzPz70jJnOKxhikVGHOtunzSkVkDgX4wxqWITtmoQ7lYy+sLLMocBZpNQ/8+i3GU9X28qk4DtTtg+NOI4uXpjkAk57wQc8QREE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ho8/cku6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B508C19423
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 09:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770630896;
	bh=hYODIDh8W+YitfT96sel4kiJsxob5ho0S42GjgaBDVg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ho8/cku6OwaRl/MpbvUAEQBmMyqMtp2VGqTARLVqTMSzMx7mP4OznzWOltb6upxm+
	 YKDtJ3ZVUzClEpWdlozg59cybWw6f1z5c1rg6aZFbSLb3m+fMEY44Rd55k3Ki6z3uX
	 y8w7etaqRdtxByNRG2iOBVhXgIdWYYPZUyKuXjh6Ovpx72p9eDeKoj+u1gROrCqEvZ
	 pd7uRjod84Wd1nAaYx76l/vZe2swIjYQ0PLXSvBzOO1wNXCJcuufcENX/20iZbe5bQ
	 g0+OURCxqShHrWXLRZO3jzrmTjKC3udpsw/JxDKZ/nYWCYh+CXwQohigq+2tNuDkdy
	 rsmEahiEQS45g==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6597a7bd7d6so4332056a12.3
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Feb 2026 01:54:56 -0800 (PST)
X-Gm-Message-State: AOJu0Yyg6vy6cXF+bCJdBWxilVjhTZvqaWdBIs/gKKV97Ufr1JCxIWfo
	PdwfmOeAf734NJ+vpvqQ4vw+hPGGg2gJPxecbP98miW2ANxCzxfGGcvYdQNAYGB5xY29Cs89NNB
	Vl7jTsrum/nbDNyvca1Ki1brACEwTQUQ=
X-Received: by 2002:a17:907:3c93:b0:b8e:99f8:8c4d with SMTP id
 a640c23a62f3a-b8edf3497cemr625190366b.51.1770630895187; Mon, 09 Feb 2026
 01:54:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209095020.128806-1-wqu@suse.com>
In-Reply-To: <20260209095020.128806-1-wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 9 Feb 2026 09:54:18 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4_pRExfW6U67YfMK7hXouXspAXXJHPWM2t3yGC3AY0CQ@mail.gmail.com>
X-Gm-Features: AZwV_Qg9tSDQEvDvwRSzTaHl32fKL5yh49LkWTAzJUyxDzNjKitt0KKyAbZrrf4
Message-ID: <CAL3q7H4_pRExfW6U67YfMK7hXouXspAXXJHPWM2t3yGC3AY0CQ@mail.gmail.com>
Subject: Re: [PATCH v2] fstests: btrfs: add a regression test for incorrect
 inode incompressible flag
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21535-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0B4EA10DDF7
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 9:50=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> Since kernel commit 59615e2c1f63 ("btrfs: reject single block sized
> compression early"), a single block write at file offset 0, which can
> not be inlined due the inode size, will mark the inode incompressible.
>
> [REGRESSION TEST]
> The new regression test will do:
>
> - Create and mount the fs with compression,max_inline=3D2k
>
> - Do the following operations:
>   * Truncate the inode to 2 * blocksize
>     This will rule out any future inlined writes.
>
>   * Buffered write [0, 2K)
>     Which will not be inlined.
>
>   * Sync
>     For affected kernels, this will set the inode with NOCOMPRESS
>     and reject all future compression on that inode.
>
>   * Buffered write [1M, 2M)
>     For affected kernels, the range will not be compressed due
>     to the NOCOMPRESS inode flag.
>
> - Unmount the fs
>
> - Make sure that:
>   * The inode has no NOCOMPRESS flag
>   * File extent at file offset 1M is being compressed
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Remove an unnessary sentence
>   Which is confusing because I missed the "and" to connect the two
>   sentences, and it's not needed after the first paragraph anyway.
>
> - Use full "btrfs inspect-internal" group name instead
>
> - Add missing punctures
> ---
>  tests/btrfs/343     | 47 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/343.out |  2 ++
>  2 files changed, 49 insertions(+)
>  create mode 100755 tests/btrfs/343
>  create mode 100644 tests/btrfs/343.out
>
> diff --git a/tests/btrfs/343 b/tests/btrfs/343
> new file mode 100755
> index 00000000..78079eff
> --- /dev/null
> +++ b/tests/btrfs/343
> @@ -0,0 +1,47 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 SUSE S.A.  All Rights Reserved.
> +#
> +# FS QA Test 343
> +#
> +# A regression test to make sure a single-block write at file offset 0 w=
on't
> +# incorrectly mark the inode incompressible.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick compress
> +
> +_require_scratch

Still missing a:

_require_btrfs_command inspect-internal dump-tree

As noted in the review of the first version.
Otherwise it looks good, thanks.

> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +       "btrfs: fix the inline compressed extent check in inode_need_comp=
ress()"
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount "-o compress,max_inline=3D2048"
> +
> +blocksize=3D$(_get_block_size $SCRATCH_MNT)
> +
> +# Create a sparse file which is 2 * blocksize, then try a small write at
> +# file offset 0 which should not be inlined.
> +# Sync so that [0, 2K) range is written, then write a larger range which
> +# should be able to be compressed.
> +$XFS_IO_PROG -f -c "truncate $((2 * $blocksize))" -c "pwrite 0 2k" -c sy=
nc \
> +               -c "pwrite 1m 1m" $SCRATCH_MNT/foobar >> $seqres.full
> +ino=3D$(stat -c "%i" $SCRATCH_MNT/foobar)
> +_scratch_unmount
> +
> +# Dump the fstree into seqres.full for debug
> +$BTRFS_UTIL_PROG inspect dump-tree -t 5 $SCRATCH_DEV >> $seqres.full
> +
> +# Check the NOCOMPRESS flag of the inode.
> +$BTRFS_UTIL_PROG inspect dump-tree -t 5 $SCRATCH_DEV |\
> +grep -A 4 -e "item .* key ($ino INODE_ITEM 0)" | grep -q NOCOMPRESS
> +[ $? -eq 0 ] && echo "inode $ino has NOCOMPRESS flag"
> +
> +# Check the file extent at fileoffset 1m
> +$BTRFS_UTIL_PROG inspect dump-tree -t 5 $SCRATCH_DEV |\
> +grep -A 4 -e "item .* key ($ino EXTENT_DATA 1048576)" | grep -q "compres=
sion 0"
> +[ $? -eq 0 ] && echo "inode $ino file offset 1M is not compressed"
> +
> +echo "Silence is golden"
> +# success, all done
> +_exit 0
> diff --git a/tests/btrfs/343.out b/tests/btrfs/343.out
> new file mode 100644
> index 00000000..2eb30e4f
> --- /dev/null
> +++ b/tests/btrfs/343.out
> @@ -0,0 +1,2 @@
> +QA output created by 343
> +Silence is golden
> --
> 2.51.2
>
>

