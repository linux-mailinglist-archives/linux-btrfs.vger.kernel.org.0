Return-Path: <linux-btrfs+bounces-22199-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFx7Gdomp2k3fAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22199-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 19:22:18 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F651F53A2
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 19:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1D1D314E601
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2026 18:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2DA3382C5;
	Tue,  3 Mar 2026 18:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9C2gRyD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB52728643C;
	Tue,  3 Mar 2026 18:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561805; cv=none; b=Zwcrs8UcILQbjb5+VGYWEx3paHrSR3gsHdipbtuW6MI91s5kpEKzG/knSE+aeGXfMoULKqSGNyZq8aWtV/AyTrUJSw6OjPY2P0NO5vCa8fb8u9ga38TNRyZwAm1zVimlIEyycJEHzMQacJCYTfuliNv/7fiCH3fBGjVL8bmAeM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561805; c=relaxed/simple;
	bh=15tuPrd20ioZRCD1LUykAzX53lk0CSkjcrNensN6mL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIJPY1I/TGvhci4yoYAezYkrrQV+FadMUfg0NBKfYQgN8NxtO+uGdyAKpwoiDxfFuRyglbsgpMK6yBPbrzQ4i8j4JOXjI6oNoEexfk66l/SjdBKAcfQuHbe5zVPLhBKaCdQzef++9DpXdseLE2hDoecuDHZeWkFGSba622L4PPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9C2gRyD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FF2C116C6;
	Tue,  3 Mar 2026 18:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772561805;
	bh=15tuPrd20ioZRCD1LUykAzX53lk0CSkjcrNensN6mL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s9C2gRyD4H+E8mBEwHtjAiBKViVtLqzl68gHNh+YWP1/T8Dastpb3TOnXrW5JwEGs
	 zuragptZbeKp9V3d/R03LrZX3/NnSVeAhKRFQioqtUeykFVm4uTdTXvRXH+OIdqKGH
	 fDJg9YVjv6Tla2HBKOoRUy2+cn0NTo1paZZVSoE4+GSsIQhfEU06YSuYzNC8OmRQXB
	 AAKT+W6LvHwU2EDGvFeeWq3jsxJadUjQ0TpuEnxDPTOEWY4FhcUWT/O2M/pRxYDzhD
	 pT7+ELvSa/6w0evwkGp3cdTWgsP3icUw08LK4fCTfsSQKJPDHCenV1qW/SJBRMQ1ni
	 hd/fBt4NLY+mg==
Date: Tue, 3 Mar 2026 10:16:44 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] btrfs: test a directory fsync scenaro after replacing
 a subdir with a file
Message-ID: <20260303181644.GG13843@frogsfrogsfrogs>
References: <8e3c1626b6e49678976db67a861cb5dcfdb532c0.1772558357.git.fdmanana@suse.com>
 <7997e07a4f530bc52edd1b93e662907c4cd07377.1772561118.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7997e07a4f530bc52edd1b93e662907c4cd07377.1772561118.git.fdmanana@suse.com>
X-Rspamd-Queue-Id: C2F651F53A2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22199-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 06:07:33PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test a scenario where we remove a directory previously persisted, create
> a file with the same name and parent directory, create two directories in
> the same parent directory, create a hard link for the new file in one of
> the new directories, fsync the directory with the hard link and fsync the
> parent directory. After a power failure we expect both directories to be
> persisted as well as the new file and its hard link.
> 
> This exercises a bug on btrfs fixed by the following kernel patch:
> 
>   "btrfs: log new dentries when logging parent dir of a conflicting inode"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> V2: Add missing scratch filter for the ls output.

Looks good to me now,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> 
>  tests/generic/790     | 70 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/790.out | 12 ++++++++
>  2 files changed, 82 insertions(+)
>  create mode 100755 tests/generic/790
>  create mode 100644 tests/generic/790.out
> 
> diff --git a/tests/generic/790 b/tests/generic/790
> new file mode 100755
> index 00000000..c9bac6d0
> --- /dev/null
> +++ b/tests/generic/790
> @@ -0,0 +1,70 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 SUSE S.A.  All Rights Reserved.
> +#
> +# FS QA Test 790
> +#
> +# Test a scenario where we remove a directory previously persisted, create a
> +# file with the same name and parent directory, create two directories in the
> +# same parent directory, create a hard link for the new file in one of the
> +# new directories, fsync the directory with the hard link and fsync the parent
> +# directory. After a power failure we expect both directories to be persisted
> +# as well as the new file and its hard link.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick log
> +
> +_cleanup()
> +{
> +	_cleanup_flakey
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +. ./common/filter
> +. ./common/dmflakey
> +
> +_require_scratch
> +_require_dm_target flakey
> +
> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: log new dentries when logging parent dir of a conflicting inode"
> +
> +_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> +_require_metadata_journaling $SCRATCH_DEV
> +_init_flakey
> +_scratch_mount
> +
> +mkdir $SCRATCH_MNT/foo
> +
> +_scratch_sync
> +
> +rmdir $SCRATCH_MNT/foo
> +
> +# Create two new directories in the same parent directory as the new file.
> +mkdir $SCRATCH_MNT/dir1
> +mkdir $SCRATCH_MNT/dir2
> +
> +# Create a file with the name of the directly we deleted and was persisted
> +# before.
> +touch $SCRATCH_MNT/foo
> +
> +# Create a hard link for the new file inside one of the new directories.
> +ln $SCRATCH_MNT/foo $SCRATCH_MNT/dir2/link
> +
> +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/dir2
> +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/
> +
> +# Simulate a power failure and then mount again the filesystem to replay the
> +# journal/log.
> +_flakey_drop_and_remount
> +
> +# We expect to see dir1, dir2, file foo and its hard link, since dir2 was
> +# explicitly fsynced as well as the parent directory.
> +echo -e "Filesystem content after power failure:\n"
> +# Exclude 'lost+found' dir from ext4 and last line if it's blank (due to removal
> +# of 'lost+found').
> +ls -R $SCRATCH_MNT/ | grep -v 'lost+found' | sed -e '${/^$/d;}' | _filter_scratch
> +
> +# success, all done
> +_exit 0
> diff --git a/tests/generic/790.out b/tests/generic/790.out
> new file mode 100644
> index 00000000..d9c0592d
> --- /dev/null
> +++ b/tests/generic/790.out
> @@ -0,0 +1,12 @@
> +QA output created by 790
> +Filesystem content after power failure:
> +
> +SCRATCH_MNT/:
> +dir1
> +dir2
> +foo
> +
> +SCRATCH_MNT/dir1:
> +
> +SCRATCH_MNT/dir2:
> +link
> -- 
> 2.47.2
> 
> 

