Return-Path: <linux-btrfs+bounces-1638-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044D983870D
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 07:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28FCB1C22B9E
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 06:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16142C1B7;
	Tue, 23 Jan 2024 06:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JFK98Nly";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="012p59RR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JFK98Nly";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="012p59RR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528E329403;
	Tue, 23 Jan 2024 06:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705989687; cv=none; b=FDPor6raZwWbnjc3AOa2TQKdqeU85idDNOCHhQbgXWhPvFWQd6+3R3e5p9iatn1D7Ga1dShEPjYtlgPz67qtM4tmBPveP8KR9J+b9cuv2PwtkLJs0o1Gvkcm4QjBM2Jz7kfKp0QSqeiztJg2JZy3q7JF/iZVqMlYMnXq6LyJbOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705989687; c=relaxed/simple;
	bh=TC06sNmEC5ag2xKTiP8k6lLbg2DX0H9nUT+LaKXgRI0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OUIvt5MhlIIz4iFLgULLJ8EKScVeVfNYV8BDDovhz33CSG6LEyjN/7Yh/AKzG/mwe3P3CDlnfVfalLsOP4Dmt5x8U+WP8/nkSIb57Hx+A+5+YeNkKw3+JJk/+GE25h6Mlw0BNxgpG8SCIre0kK8gtrCJuDHV5Aqc/aRsgZMMqZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JFK98Nly; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=012p59RR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JFK98Nly; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=012p59RR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9D2432228F;
	Tue, 23 Jan 2024 06:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705989677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eBgWpMGs3ed1A1yQv7oC90R+nk5B4eAFbu9MhY7TMpQ=;
	b=JFK98Nly5Xzc7JMb1LtlyMk7D5JXkmQkZVzO/ksMQtQ0RfTN7so3OgJpE+UeYSIYdcPITr
	ru9x6hQ4RJT1sZmRf1STU1gsRqfm7LhPP2OtGKknDv9pSFb0+WAm7hZmCWI1zqS063n/X0
	dRQ9U+MtWKd/3KaCfaoXa/ihg2zBaVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705989677;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eBgWpMGs3ed1A1yQv7oC90R+nk5B4eAFbu9MhY7TMpQ=;
	b=012p59RRwnppODfluzkIx1nZIFCikP/hRaq3H8ZE1fC+RN4G0rKWdRItyWEA1gw6dqWscS
	Qyuy3yTCnWoDQdCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705989677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eBgWpMGs3ed1A1yQv7oC90R+nk5B4eAFbu9MhY7TMpQ=;
	b=JFK98Nly5Xzc7JMb1LtlyMk7D5JXkmQkZVzO/ksMQtQ0RfTN7so3OgJpE+UeYSIYdcPITr
	ru9x6hQ4RJT1sZmRf1STU1gsRqfm7LhPP2OtGKknDv9pSFb0+WAm7hZmCWI1zqS063n/X0
	dRQ9U+MtWKd/3KaCfaoXa/ihg2zBaVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705989677;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eBgWpMGs3ed1A1yQv7oC90R+nk5B4eAFbu9MhY7TMpQ=;
	b=012p59RRwnppODfluzkIx1nZIFCikP/hRaq3H8ZE1fC+RN4G0rKWdRItyWEA1gw6dqWscS
	Qyuy3yTCnWoDQdCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A69E713786;
	Tue, 23 Jan 2024 06:01:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bphEFStWr2UnSgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 23 Jan 2024 06:01:15 +0000
Date: Tue, 23 Jan 2024 17:01:07 +1100
From: David Disseldorp <ddiss@suse.de>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, fstests@vger.kernel.org
Subject: Re: [PATCH] btrfs/304: test qgroup deletion
Message-ID: <20240123170107.2292abd8@echidna>
In-Reply-To: <c9fa8fa558e307a5d0d28545ff69433ae8324f4c.1705964751.git.boris@bur.io>
References: <c9fa8fa558e307a5d0d28545ff69433ae8324f4c.1705964751.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

Reviewed-by: David Disseldorp <ddiss@suse.de>

A few minor nits below which should be addressed prior to merge...

On Mon, 22 Jan 2024 15:06:28 -0800, Boris Burkov wrote:

> When using squotas, an extent's OWNER_REF can long outlive the subvolume
> that is the owner, since it could pick up a different reference that
> keeps it around, but the subvolume can go away.
> 
> Test this case, as originally, it resulted in a read only btrfs.
> 
> Since we can blow up the subvolume in the same transaction as the extent
> is written, we can also increment the usage of a non-existent subvolume.
> 
> This leaves an OWNER_REF behind with no corresponding incremented usage
> in a qgroup, so if we re-create that qgroup, we can then underflow its
> usage.
> 
> Both of these cases are fixed in the kernel by disallowing
> creating subvol qgroups and by disallowing deleting qgroups that still
> have usage.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  common/btrfs        | 10 +++++
>  tests/btrfs/301     | 14 +------
>  tests/btrfs/304     | 90 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/304.out |  6 +++

btrfs/304 is already taken in fstests v2024.01.14 by
9d812702 ("btrfs: add fstest for stripe-tree metadata with 4k write").

>  4 files changed, 108 insertions(+), 12 deletions(-)
>  create mode 100755 tests/btrfs/304
>  create mode 100644 tests/btrfs/304.out
> 
> diff --git a/common/btrfs b/common/btrfs
> index f91f8dd86..c8593c1f9 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -775,3 +775,13 @@ _has_btrfs_sysfs_feature_attr()
>  
>  	test -e /sys/fs/btrfs/features/$feature_attr
>  }
> +
> +_enable_quota()
> +{
> +	local mode=$1
> +
> +	[ $mode == "n" ] && return
> +	arg=$([ $mode == "s" ] && echo "--simple")
> +
> +	$BTRFS_UTIL_PROG quota enable $arg $SCRATCH_MNT

It looks as though the "n" mode isn't used, and the "s" -> "--simple"
mapping is confusing. Can we instead just make this:
  $BTRFS_UTIL_PROG quota enable $* $SCRATCH_MNT

or drop the helper function altogether?

> +}
> diff --git a/tests/btrfs/301 b/tests/btrfs/301
> index db4697247..b3ee66cd9 100755
> --- a/tests/btrfs/301
> +++ b/tests/btrfs/301
> @@ -157,16 +157,6 @@ do_enospc_falloc()
>  	do_falloc $file $sz
>  }
>  
> -enable_quota()
> -{
> -	local mode=$1
> -
> -	[ $mode == "n" ] && return
> -	arg=$([ $mode == "s" ] && echo "--simple")
> -
> -	$BTRFS_UTIL_PROG quota enable $arg $SCRATCH_MNT
> -}
> -
>  get_subvid()
>  {
>  	_btrfs_get_subvolid $SCRATCH_MNT subv
> @@ -186,7 +176,7 @@ prepare()
>  {
>  	_scratch_mkfs >> $seqres.full
>  	_scratch_mount
> -	enable_quota "s"
> +	_enable_quota "s"

...as mentioned, _enable_quota --simple (or inline $BTRFS_UTIL_PROG ...)

>  	$BTRFS_UTIL_PROG subvolume create $subv >> $seqres.full
>  	local subvid=$(get_subvid)
>  	set_subvol_limit $subvid $limit
> @@ -397,7 +387,7 @@ enable_mature()
>  	# Sync before enabling squotas to reliably *not* count the writes
>  	# we did before enabling.
>  	sync
> -	enable_quota "s"
> +	_enable_quota "s"
>  	set_subvol_limit $subvid $limit
>  	_scratch_cycle_mount
>  	usage=$(get_subvol_usage $subvid)
> diff --git a/tests/btrfs/304 b/tests/btrfs/304
> new file mode 100755
> index 000000000..3fce0591c
> --- /dev/null
> +++ b/tests/btrfs/304
> @@ -0,0 +1,90 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 304
> +#
> +# Test various race conditions between qgroup deletion and squota writes
> +#
> +. ./common/preamble
> +_begin_fstest auto quick qgroup subvol clone
> +
> +# Override the default cleanup function.
> +# _cleanup()
> +# {
> +# 	cd /
> +# 	rm -r -f $tmp.*
> +# }

nit: doesn't look like there's a need to override the default.

