Return-Path: <linux-btrfs+bounces-17799-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F157ABDC57A
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 05:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6E33BB49F
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 03:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4002836B5;
	Wed, 15 Oct 2025 03:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="ADDNCZ1t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UHcgs2h/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6F71547EE;
	Wed, 15 Oct 2025 03:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760499107; cv=none; b=EdQDeCKwkjRu2LE1/68pADVKX1s/T6sL9PVzyFAxErusoELRp/KpMvFijjBWA/KSCc2uQ/vXqYOJaP49mHHH+lq245wqqoQTJX7hyurVqdHjn3EMlTlGaFgk0yxO9vKXstQHm/OQ7c0Jxly4asRF+zUzH0PD4Vx9pOt6X+3FbZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760499107; c=relaxed/simple;
	bh=hd7k8NxvgQVjLpsL0c4bdGs8VplMDq8GXxMRahHxDeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcBsqNKCKSYvBCTngsk1RqpOsebl542DkWqDtxSu5te8QtfPXZJXmLeiVppGLrP9PMSao81lqQ1aks0qzn48guT9cFpjsCAvxkUVlOz15ql9rRASDYJH4b5SlJjxmqa6/AJA2o4lbGi45PhXeLCMyv+0bi7Dqkk/7uUL8Fhf0QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=ADDNCZ1t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UHcgs2h/; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 88838EC020C;
	Tue, 14 Oct 2025 23:31:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 14 Oct 2025 23:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1760499104; x=1760585504; bh=FCNJI3PZpo
	qgWJfIjLYy+Ya+ZfXuDLJVUaYsT9MnoA0=; b=ADDNCZ1tD8KwM9M8aji8xojWYw
	ezkzUAU/NUHOyMsNAUkHVjg2eE240NwcffEQbw8fOOQxTXWeqlaZmCznAW/3wdbu
	8dGAH39mOmn0BOTebgf2WTK05sOXTRtKUeqlwA48D8a9FWBWy6bmd456Aeb/+rBh
	UlV4DefpgMDllBdWYfxCbG/3jCyHUEefxqjQV/CjyVS5rE72o9qyjasA4/7KwD28
	AMWF0SKHwOQz2Y6XHPaZ/1dCGkoqE/Ne+pTJ6xCMQae0TsERHjSi5KFFbd+PCgV1
	6UV0+wNv+AJYwvDCaKY0ZTlz7M+MlEVpMJXSG1bvNLsuLtcADYbZjgdBkd/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760499104; x=1760585504; bh=FCNJI3PZpoqgWJfIjLYy+Ya+ZfXuDLJVUaY
	sT9MnoA0=; b=UHcgs2h/pLS81Hs3XNx3CfDZvsCSCwChPCXtP4vn7gEiz+0hmw6
	205ueixz3kCKLCRFWB7H9lLi39BLTXCKpOrJbNT9Fb/hS87q9XGIGS+rNnxR2mzr
	gdMe1/X1Y1gRI2J+W/MLS1ZU9NzseyGhFa4yS+ZxZ+FU1QNEbQEOtbyctllT8HQ1
	P+kfaagNWzIEx+bix31i219iYIL7LOjB54lgbuKc1jFImR1NtChokSpscppWpshx
	Hhoe9serRxISJ99+0X1ehripKoFSQK/4BuevHCRZnNXZ0GYaNBXfN4TUPNKZzoYj
	09ic5W29TGzDjdnNWP1/cblajBCiCQxihWA==
X-ME-Sender: <xms:oBXvaG9RGkTiHlCDn9Pf3g49tiALWLRh9B3EGdUCO-c1GkS46G9NAg>
    <xme:oBXvaEh00tHl4GXQHHKlKAAR8nnc8rim7NZXOHkaotgeDV3bbqZj6_GzTIlKMMX_w
    2SAjSosbV4vanpRzokp2NOnaZWzVWLO07cGVObpOOGC-DtWBpKBndg>
X-ME-Received: <xmr:oBXvaGdotboD98upFXEKPwczBVjLu7ondqRo_TdIg39oDa27WfzvP_GO88yh_e0ilu0-Ag5Sr5B_VA8AMteXRcmLyrE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiie
    eiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehlohgvmhhrrgdruggvvhesghhmrghilhdr
    tghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhmpdhrtghpthht
    ohepfhhsthgvshhtshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:oBXvaLpLlFqBrpMdCTT642VmgSshG4jim0Vc_jVEqlgKl5kDjVecqA>
    <xmx:oBXvaLBtkHBlwrdyDmbtCeZSnd0KDC-hfwKjOnQy689ipUJEz_uJvw>
    <xmx:oBXvaIa6d4mdbuQUJvsMp0Wfojsw_ZsqUwgmIQRc4WJLkHXQ4RoEsA>
    <xmx:oBXvaO5hKeQSpFDfO4ImPPogBZPipV-qAOTxUyN_H8ljY6xYVF0m3w>
    <xmx:oBXvaPM4suGWztZF6PJBdQCh0x94mChQvQ8vS-9byjdAMM3sc9QcsX-z>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 23:31:43 -0400 (EDT)
Date: Tue, 14 Oct 2025 20:31:24 -0700
From: Boris Burkov <boris@bur.io>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: Re: [PATCH v2 3/3] fstests: btrfs: test RAID conversions under stress
Message-ID: <20251015033124.GC1702774@zen.localdomain>
References: <cover.1759532729.git.loemra.dev@gmail.com>
 <455b9a2b102631febc1b05802006d3d304d4baeb.1759534540.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455b9a2b102631febc1b05802006d3d304d4baeb.1759534540.git.loemra.dev@gmail.com>

On Fri, Oct 03, 2025 at 04:41:59PM -0700, Leo Martins wrote:
> Add test to test btrfs conversion while being stressed. This is
> important since btrfs no longer allows allocating from different RAID
> block_groups during conversions meaning there may be added enospc
> pressure.
> 

Aside from the patch intermingling stuff, this test looks good to me,
thanks for adding it.

Reviewed-by: Boris Burkov <boris@bur.io>

> Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> ---
>  tests/btrfs/337     | 95 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/337.out |  2 +
>  2 files changed, 97 insertions(+)
>  create mode 100755 tests/btrfs/337
>  create mode 100644 tests/btrfs/337.out
> 
> diff --git a/tests/btrfs/337 b/tests/btrfs/337
> new file mode 100755
> index 00000000..fa335ed7
> --- /dev/null
> +++ b/tests/btrfs/337
> @@ -0,0 +1,95 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Meta Platforms, Inc. All Rights Reserved.
> +#
> +# FS QA Test btrfs/337
> +#
> +# Test RAID profile conversion with concurrent allocations.
> +# This combines profile conversion (like btrfs/195) with concurrent
> +# fsstress allocations (like btrfs/060-064).
> +
> +. ./common/preamble
> +_begin_fstest auto volume balance scrub raid
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +	_kill_fsstress
> +}
> +
> +. ./common/filter
> +# we check scratch dev after each loop
> +_require_scratch_nocheck
> +_require_scratch_dev_pool 4
> +# Zoned btrfs only supports SINGLE profile
> +_require_non_zoned_device "${SCRATCH_DEV}"
> +
> +# Load up the available configs
> +_btrfs_get_profile_configs
> +declare -a TEST_VECTORS=(
> +# $nr_dev_min:$data:$metadata:$data_convert:$metadata_convert
> +"4:single:raid1"
> +"4:single:raid0"
> +"4:single:raid10"
> +"4:single:dup"
> +"4:single:raid5"
> +"4:single:raid6"
> +"2:raid1:single"
> +)
> +
> +run_testcase() {
> +	IFS=':' read -ra args <<< $1
> +	num_disks=${args[0]}
> +	src_type=${args[1]}
> +	dst_type=${args[2]}
> +
> +	if [[ ! "${_btrfs_profile_configs[@]}" =~ "$dst_type" ]]; then
> +		echo "=== Skipping test: $1 ===" >> $seqres.full
> +		return
> +	fi
> +
> +	_scratch_dev_pool_get $num_disks
> +
> +	echo "=== Running test: $1 (converting $src_type -> $dst_type) ===" >> $seqres.full
> +
> +	_scratch_pool_mkfs -d$src_type -m$src_type >> $seqres.full 2>&1
> +	_scratch_mount
> +
> +	echo "Creating initial data..." >> $seqres.full
> +	_run_fsstress -d $SCRATCH_MNT -w -n 10000 >> $seqres.full 2>&1
> +
> +	args=`_scale_fsstress_args -p 20 -n 1000 -d $SCRATCH_MNT/stressdir`
> +	echo "Starting fsstress: $args" >> $seqres.full
> +	_run_fsstress_bg $args
> +
> +	echo "Starting conversion: $src_type -> $dst_type" >> $seqres.full
> +	_run_btrfs_balance_start -f -dconvert=$dst_type $SCRATCH_MNT >> $seqres.full
> +	[ $? -eq 0 ] || echo "$1: Failed convert"
> +
> +	echo "Waiting for fsstress to complete..." >> $seqres.full
> +	_wait_for_fsstress
> +
> +	# Verify the conversion was successful
> +	echo "Checking filesystem profile after conversion..." >> $seqres.full
> +	$BTRFS_UTIL_PROG filesystem df $SCRATCH_MNT >> $seqres.full
> +
> +	# Scrub to verify data integrity
> +	echo "Scrubbing filesystem..." >> $seqres.full
> +	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >> $seqres.full 2>&1
> +	if [ $? -ne 0 ]; then
> +		echo "$1: Scrub found errors"
> +	fi
> +
> +	_scratch_unmount
> +	_check_scratch_fs
> +	_scratch_dev_pool_put
> +}
> +
> +echo "Silence is golden"
> +for i in "${TEST_VECTORS[@]}"; do
> +	run_testcase $i
> +done
> +
> +status=0
> +exit
> diff --git a/tests/btrfs/337.out b/tests/btrfs/337.out
> new file mode 100644
> index 00000000..d80a9830
> --- /dev/null
> +++ b/tests/btrfs/337.out
> @@ -0,0 +1,2 @@
> +QA output created by 337
> +Silence is golden
> -- 
> 2.47.3
> 

