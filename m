Return-Path: <linux-btrfs+bounces-21683-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHmyFXwFk2nF0wEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21683-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 12:54:36 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF902143294
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 12:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A69A23013EE1
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 11:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A037305E32;
	Mon, 16 Feb 2026 11:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlqBxvl6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DA02FD1BF
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Feb 2026 11:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771242873; cv=none; b=dYNf65IsjtquvQotRdIK7L1YLMATnXgImiABcADXQO1H7yGXrSGvoQAw4145gYVEF18GF4knjjK7VyQFPib+KmdVewRPCp+h5g/CirvsYbnW8hHyqkXh3K2vohuNnPylieWKZONJexdTpDEpY9LGrzhCnOojWkOzMGxVU6S2eZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771242873; c=relaxed/simple;
	bh=ypWu3wVdPWoc7+P5m/sWvgG9Gy2dfvQfVsgDhOYL5Zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ketjtoNlavxoZUjo6PtnKu6vgSaocxS0yNGlqWH/sxPQnvTfxflLCFhO6c5GzJODVHoY4vFQXZdogCYfum8GAt/1gQqmCUMMQg9nM/bJKgaT1l1kzta/P4xniYRVOIFfcbjYF0V8/ceORCEOR/0NZDP1xImV3NEB17mem+b2SkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlqBxvl6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374F7C116C6
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Feb 2026 11:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771242873;
	bh=ypWu3wVdPWoc7+P5m/sWvgG9Gy2dfvQfVsgDhOYL5Zk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nlqBxvl63hMOw3nHTnNsq7/4XSdGTtVWjFKuyc1RJvzLpNjosK+Cxuq/k1sOtmpLG
	 IuT3633Q1xWJTKrWysEb2hf2rcS4t6jAhcE3Ow5hJyqqCYM4wy+K0KDQXIYwDQjtd8
	 cYCrhGi8OcnHj+qLvqDX1hEuWl5DvqvNfyNAY7KiYdmV2NcNueaTEDfB7QvZ/Lq2xK
	 PA0aePQBcO4JoUdGurwVAQz1JikZexxhyaFG12EbYEg0mV1xopm5+JNN304y5dfTBq
	 d4IcAHuVhGanvbUZY+p1V2Tgrm3W82Tm32fU09vQns57EUic8LkUIAj4NzmkxMoyXI
	 +wV2BepW+/Akg==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8fa449e618so409618066b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Feb 2026 03:54:33 -0800 (PST)
X-Gm-Message-State: AOJu0YxU7N3O2qkhXnjgaUaSqYchx+DPKvoJT0kye+/lgaUECzuZZ6m3
	DbdcJ1fSZ92yrn77djLDlXJUdKidWlXKUvXgyfd3wWdOFjcxp0Yd8PT+ZCRSitafsrIm/VMmsfZ
	I2o9HISvsz0HDi5cjbO4x4E1AiKUdEus=
X-Received: by 2002:a17:907:7254:b0:b8e:9d66:f5fb with SMTP id
 a640c23a62f3a-b8fb3e0fa22mr500521566b.0.1771242871774; Mon, 16 Feb 2026
 03:54:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216033958.83632-1-wqu@suse.com>
In-Reply-To: <20260216033958.83632-1-wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 16 Feb 2026 11:53:55 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4R86w1QF5tK-HXVwtCi5TreLdSt2nRBeGHWPJv1P6FcA@mail.gmail.com>
X-Gm-Features: AaiRm52wGDjOZ9HHX0d8nvmvJ5XCVKYseQuUu9rAf2-GFDAn1mdcteoCJHIuJTc
Message-ID: <CAL3q7H4R86w1QF5tK-HXVwtCi5TreLdSt2nRBeGHWPJv1P6FcA@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs: add a test case for failed compressed
 inline attempt
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21683-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF902143294
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 3:40=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> There is a long existing behavior that if a compressed inline attempt
> failed, the whole inode is marked incompressible.
>
> Furthermore, the default threshold for compressed inline implies a
> pretty high compression ratio (2K max inline vs 4K block size, thus 50%
> compression ratio).
>
> This makes btrfs to mark inodes incompressible prematurely.
>
> [TEST]
> The new test case is based on the previous btrfs/343 one, which will do:
>
> - Create and mount the fs with compress,max_inline=3D4
>   4 bytes will be too small for any header, thus all compressed inline
>   writes should fail.
>
> - Do the following operations:
>   * Buffered write [0, blocksize / 2)
>     Which can be inlined if using the default max_inline mount option
>     and 4K fs block.
>     But the new max_inline=3D4 will reject such compressed inline attempt=
.
>
>     And such one block write should not trigger compression thus no
>     compression ratio based check.
>
>   * Sync
>     For unpatched kernels, this will set the inode with NOCOMPRESS flag
>     and reject all future compression on that inode.
>
>   * Buffered write [1M, 2M)
>     For unpatched kernels, the range will not be compressed due to the
>     NOCOMPRESS flag.
>
> - Unmount the fs
>
> - Maker sure that:
>   * The inode has no NOCOMPRESS flag
>   * File extent at file offset 1M is being compressed
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/344     | 53 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/344.out |  2 ++
>  2 files changed, 55 insertions(+)
>  create mode 100755 tests/btrfs/344
>  create mode 100644 tests/btrfs/344.out
>
> diff --git a/tests/btrfs/344 b/tests/btrfs/344
> new file mode 100755
> index 00000000..4695104f
> --- /dev/null
> +++ b/tests/btrfs/344
> @@ -0,0 +1,53 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 SUSE S.A.  All Rights Reserved.
> +#
> +# FS QA Test 344
> +#
> +# Check if a failed inline attempt for compression write will mark
> +# the whole inode as incompressible
> +#
> +. ./common/preamble
> +_begin_fstest auto quick compress
> +
> +_require_scratch
> +_require_btrfs_command inspect-internal dump-tree
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +       "btrfs: do not mark inode incompressible after inline attempt fai=
led"
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +
> +# This inline limit is too small for any header.
> +# Thus all compressed inline attempt should fail.

attempt -> attempts

> +_scratch_mount "-o compress,max_inline=3D4"
> +
> +blocksize=3D$(_get_file_block_size $SCRATCH_MNT)
> +
> +# The initial half block write can be compressed, but the compressed
> +# size will not meet the 4 bytes limits, thus it will not be inlined.

limits -> limit

Otherwise, it looks good, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>


> +#
> +# Normally such single block write itself should not mark the inode
> +# incompressible, no matter if there is an inline attempt or not.
> +#
> +# The 1M write should be compressed.
> +$XFS_IO_PROG -f -c "pwrite 0 $(( $blocksize / 2 ))" -c sync \
> +               -c "pwrite 1m 1m" $SCRATCH_MNT/foobar >> $seqres.full
> +ino=3D$(stat -c "%i" $SCRATCH_MNT/foobar)
> +_scratch_unmount
> +
> +# Dump the fs tree into seqres.full for debug.
> +$BTRFS_UTIL_PROG inspect-internal dump-tree -t 5 $SCRATCH_DEV >> $seqres=
.full
> +
> +# Check the NOCOMPRESS flag of the inode.
> +$BTRFS_UTIL_PROG inspect-internal dump-tree -t 5 $SCRATCH_DEV |\
> +grep -A 4 -e "item .* key ($ino INODE_ITEM 0)" | grep -q NOCOMPRESS
> +[ $? -eq 0 ] && echo "inode $ino has NOCOMPRESS flag"
> +
> +# Check the file extent at file offset 1m.
> +$BTRFS_UTIL_PROG inspect-internal dump-tree -t 5 $SCRATCH_DEV |\
> +grep -A 4 -e "item .* key ($ino EXTENT_DATA 1048576)" | grep -q "compres=
sion 0"
> +[ $? -eq 0 ] && echo "inode $ino file offset 1M is not compressed"
> +
> +echo "Silence is golden"
> +_exit 0
> diff --git a/tests/btrfs/344.out b/tests/btrfs/344.out
> new file mode 100644
> index 00000000..b950d5ae
> --- /dev/null
> +++ b/tests/btrfs/344.out
> @@ -0,0 +1,2 @@
> +QA output created by 344
> +Silence is golden
> --
> 2.51.2
>
>

