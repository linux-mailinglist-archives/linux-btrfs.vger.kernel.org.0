Return-Path: <linux-btrfs+bounces-21527-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOAgOfCpiWnfAQUAu9opvQ
	(envelope-from <linux-btrfs+bounces-21527-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 10:33:36 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6692C10D97A
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 10:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E85C7301738E
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 09:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AE2322C6D;
	Mon,  9 Feb 2026 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfRlTAZU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9820B17D2
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 09:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770629592; cv=none; b=fVH4+91p3YK2KPHYALTM3maumAugGNUls1N1C/UMHzAuuoMljv0vkVVAmuV74+r9YrLvJxt+iDepH+YYJlQbt+1K/O7eLRdA2qR9tlMCmzZ//6sr+snfNRy8zUuLUBIDFKutFfXHN3L3SX+XFT60X/uJyAv8aCoJJ3UBIsccDoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770629592; c=relaxed/simple;
	bh=Cwetngl46StkbjBucGkivRAJM+lpr+HcwYyuXW0diFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQi3aO5N1uEOG06cZGElhodyVfy8gQWN8uGmESZgwLR8fam2Etxocr1eQOs0KrnNl+TxpC9afK1KtCkS6xGRSh1CEfkjPoWxEvvNIqdYR9RYQmhVgyhm5cTB5r25En5jMzAJSZinWUZ/HSLGt6daoZy2JFZKrib5OX5u0CX0cRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfRlTAZU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40751C19424
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 09:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770629592;
	bh=Cwetngl46StkbjBucGkivRAJM+lpr+HcwYyuXW0diFU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qfRlTAZUzxwkuR4U8AqdvImu2FN/xeacb+5i4jCXudmoAcxpmuVfyjrsscq1g0tE3
	 QhC/RyhYTpybjrxzYaSbVSQHeie4byb2GlgxGBtVbud7HlRjlh/Qrp32AP4h7HTpvu
	 gCeAONmQRLN3+qzuSan1RLfkkRqLQdTjlXyCCPfeBh63duYWTcgY0btoziNL+GNwxm
	 NVEg9mM91Gy+lZ7hymLSktz7kQbiOH6Ev+2whOyLTSCkynbffMDh6+uhmCiorYPyk3
	 mPuhSVEEIhwfSPmHKTP+z43DiFoHbSZfSgs/dYTVF69qHV047uzSos8QOCnK/EZFGQ
	 wvJdvHfOsUG+Q==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-658b511573cso7051783a12.0
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Feb 2026 01:33:12 -0800 (PST)
X-Gm-Message-State: AOJu0Ywn1uVDtCaR9KYIolNtbwu/OQrvO2gq6ObRYs/k1cHN/8oPcw3A
	5Gx7LeEAw7zN7dV9KHu0Zf5oCCXXSnRxz1HMYEc9MgW4PTtW93Xk3Vdxo8D26QHznoJjWSkDAO0
	gTE4Bojc33ME1HxichYoR3gmwR8ZbFPI=
X-Received: by 2002:a17:906:f582:b0:b8a:f3c0:c09 with SMTP id
 a640c23a62f3a-b8edf46b9e4mr636769966b.59.1770629590789; Mon, 09 Feb 2026
 01:33:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209031009.28070-1-wqu@suse.com>
In-Reply-To: <20260209031009.28070-1-wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 9 Feb 2026 09:32:33 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7m+RkPVdczv2WZAnimtgXiPAes8HWyeydkyKKNg8V-Xg@mail.gmail.com>
X-Gm-Features: AZwV_QhByepmfAEG8MFqJOL4xtywbU6fKBoXygHolTMQ7ZBXP3Rgtgw1a9lJep4
Message-ID: <CAL3q7H7m+RkPVdczv2WZAnimtgXiPAes8HWyeydkyKKNg8V-Xg@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs: add a regression test for incorrect inode
 incompressible flag
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21527-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6692C10D97A
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 3:10=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> Since kernel commit 59615e2c1f63 ("btrfs: reject single block sized
> compression early"), a single block write at file offset 0, which can
> not be inlined due the inode size, will mark the inode incompressible.
>
> This is not the expected behavior is caused by that commit.

Something odd with this sentence.
But given the previous paragraph, it's not needed.

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
>     to the NOCOMPRESS flag.
>
> - Unmount the fs
>
> - Make sure that:
>   * The inode has no NOCOMPRESS flag
>   * File extent at file offset 1M is being compressed
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
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

Please end the sentence with punctuation - some of the other comments
end with punctuation, others don't.

> +$BTRFS_UTIL_PROG inspect dump-tree -t 5 $SCRATCH_DEV >> $seqres.full

Please use the full command name "inspect-internal".
Also missing at the top:

_require_btrfs_command inspect-internal dump-tree


> +
> +# Check the NOCOMPRESS flag of the inode.

Here there is punctuation.

> +$BTRFS_UTIL_PROG inspect dump-tree -t 5 $SCRATCH_DEV |\

inspect-internal

> +grep -A 4 -e "item .* key ($ino INODE_ITEM 0)" | grep -q NOCOMPRESS
> +[ $? -eq 0 ] && echo "inode $ino has NOCOMPRESS flag"
> +
> +# Check the file extent at fileoffset 1m

Here, punctuation is missing again.

> +$BTRFS_UTIL_PROG inspect dump-tree -t 5 $SCRATCH_DEV |\

inspect-internal

With those minor fixes:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

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

