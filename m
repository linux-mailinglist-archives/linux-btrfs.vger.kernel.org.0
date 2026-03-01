Return-Path: <linux-btrfs+bounces-22131-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFwQCDI6pGksawUAu9opvQ
	(envelope-from <linux-btrfs+bounces-22131-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Mar 2026 14:08:02 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB751CFC16
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Mar 2026 14:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D51B0301E3EC
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Mar 2026 13:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F82C32694E;
	Sun,  1 Mar 2026 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xyb+YWJv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE102517AC
	for <linux-btrfs@vger.kernel.org>; Sun,  1 Mar 2026 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772370427; cv=none; b=MZxA/xlxwjAg/YSH7ybQ9lQAeMUdVyLVaX1uSSe/sZRh1iLIzP426ABrP6Y7mlEgcvCQTPOSnp6moNRbWiOPbGHXBl4z6IInoICM8ADdVdzgqRep+YP9qql72OTRmVniPk7NP+t2YxMhXTARSDkstz3Zzzpa9HXqId9RUUPpsfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772370427; c=relaxed/simple;
	bh=+b7IJmYsdPsiaWkABEc9hXLF8ekSKnQ2J1W6I/m5X0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzZ5CR09ey/yiJxTaMT885mJP27d2XW6+htgklxk7xUQqCb3JBVIU0HCAVUWDxHGKPVm9EifNLErO/WJdAr72v4zPnAEBnbE+6c1YIIbT/M8DJb6tocPoXdGqzRBTraT1fvk5WqQisO1j16T+uCwn5FTGKPNF3ltHFsBgQGETeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xyb+YWJv; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-65f980cea07so5105243a12.0
        for <linux-btrfs@vger.kernel.org>; Sun, 01 Mar 2026 05:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772370424; x=1772975224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=21RpwEPOwVSx/Gfqd4huN5SHo5O6W1YNzF0HAagBVOE=;
        b=Xyb+YWJvPyIRXvmbSfYtg+omoN8nPN8x4A+5QXO2Vc8ofRNPt4N+wpQB8ZSgPPA0PZ
         nHwaGB1ZYGiDsquXgV/h46XgCBL6c2dRiA4UZnseDfrZ6zpNJACACZ0yn3g/524OcUft
         nfsaXpxhJ7RyllFTEK10S0yI//CIvg7rfzro7qCZB4bfPY2sJLBuwIwTNyFm1n/Xephe
         eoAX1fP2CsPrb21nDNnr+SkGAD04e0aw0i1zqvoEUsrsas38kWAL32jiif7wlnumXCqZ
         wxeTd0U7zz20WiF2gu00BzhJIsMDzSOMT5UdWNey/0DiYWpUhuP17NsFG81ofzeOpIsN
         yiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772370424; x=1772975224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21RpwEPOwVSx/Gfqd4huN5SHo5O6W1YNzF0HAagBVOE=;
        b=NBR56dGTYCm8u6YFdNqybHJkdTyoR/bor+CYcij5YD3DF6+wZVtiW52iQMa6JBkcb0
         /UTTe6IwmmGmWPJKCR4tmylx0Oa3NWMV9MP12zkKEVahiWU+kpJCmU0oE+R2BQCVBkDH
         uNEBmFy/M2HFadccgtLinHutCt5mz1MCXMEBHJ76LBt9KP43NXrOh2dphOlU7ohH1qIn
         PcqiheQ4ycIDErDyiJqc7w5E29nc39CT80n2qn2lekjM9O5KtGwEXbXp7ccrmAJf/Gnn
         JC2hFJveag8OjscWCsFiLnAy9yWB400iY50I3OHzuJCaTeBz365nLvMTg2GnA0dLuPHG
         dt+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/DIGnbugI3PY6YOStRLwyyFFaf6u6Ab0mj5X7d6DXZ+laXakPqlgGe8z+tMu0ErKMPgrkJMIr/3dMSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1CIF5Ngl58Rvhj2a604V+Un3P9qDOkdaS9qDkO24tpmUc2dar
	b6gU7GMJAg1pYLvurbqHyWQQsGxLxWymg8Y2gTt7kR1v5mMnnO8GJBra
X-Gm-Gg: ATEYQzyCzCKqXb0P8tDSoQugUMup8Pdsj6yRghtobM2opE5XQiUSOsId3zbWs1MDX6h
	IyjMOATZEHOBHp4vKnmG2zzxo1ylwar8bQyjXk2dYcG6y0UNbJTnAEUl9HJCYwzkobP2bO0PXyF
	XxdQF6G+R7/EvFoljeXFPIvJ1v9tI7r+0Yo0c32iiYOi+YuJB0XE8xVbh/i6FjhShkba/4f8NIj
	85vzQFJIMz6KDtYoHLDYtR+jgBLoUxJe7XrX8RizfBE/KYz+Xg8zSOJFe7G5aD/G2FzF/CZYJ6k
	4KJbkzVTAL5zL1y+5CGD/co8AhVd2/5q8aKR/OhIrY9eGEe0FVYkZ4nRufYtuD/3koSGvb8zNgh
	PrUwyzRRZXKFchFkinuocahhxBVUeTsBbcKCHUxssWBv2P8yH5eVhvNrrh/oy/jIpiWVGmCd4O5
	l0YYfq9Z791sein7e7AQBqV9OyF8BH4A3WLbUdMqv/JdIU+0B5pOqpk4SmYS2QEaM+TD4mUeL7L
	KLMrK/OEZn4rmlERP+voQvb4hvC
X-Received: by 2002:a17:906:4fc6:b0:b8e:d04e:e4fc with SMTP id a640c23a62f3a-b93763b7090mr565823366b.22.1772370424268;
        Sun, 01 Mar 2026 05:07:04 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-d118-5ff5-6236-8e43.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:d118:5ff5:6236:8e43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9399ec5460sm145609966b.15.2026.03.01.05.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 05:07:03 -0800 (PST)
Date: Sun, 1 Mar 2026 14:07:02 +0100
From: Amir Goldstein <amir73il@gmail.com>
To: Anand Jain <asj@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 4/9] fstests: add test for inotify isolation on cloned
 devices
Message-ID: <aaQ59uL3rG7_WYHJ@amir-ThinkPad-T480>
References: <cover.1772095513.git.asj@kernel.org>
 <78014ba3d564004081dca3c1d7e69cec8943f629.1772095513.git.asj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78014ba3d564004081dca3c1d7e69cec8943f629.1772095513.git.asj@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22131-lists,linux-btrfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7EB751CFC16
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 10:41:45PM +0800, Anand Jain wrote:
> Add a new test, to verify that the kernel correctly differentiates between
> two block devices sharing the same FSID/UUID.
> 
> Signed-off-by: Anand Jain <asj@kernel.org>
> ---
>  common/config         |  1 +
>  tests/generic/790     | 78 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/790.out |  7 ++++
>  3 files changed, 86 insertions(+)
>  create mode 100644 tests/generic/790
>  create mode 100644 tests/generic/790.out
> 
> diff --git a/common/config b/common/config
> index 1420e35ddfee..c08f828575a2 100644
> --- a/common/config
> +++ b/common/config
> @@ -228,6 +228,7 @@ export BTRFS_MAP_LOGICAL_PROG=$(type -P btrfs-map-logical)
>  export PARTED_PROG="$(type -P parted)"
>  export XFS_PROPERTY_PROG="$(type -P xfs_property)"
>  export FSCRYPTCTL_PROG="$(type -P fscryptctl)"
> +export INOTIFYWAIT_PROG="$(type -P inotifywait)"
>  
>  # udev wait functions.
>  #
> diff --git a/tests/generic/790 b/tests/generic/790
> new file mode 100644
> index 000000000000..3809fced622d
> --- /dev/null
> +++ b/tests/generic/790
> @@ -0,0 +1,78 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
> +#
> +# FS QA Test 790
> +#
> +# Verify if the kernel or userspace becomes confused when two block devices
> +# share the same fid/fsid/uuid. Create inotify on both original and cloned
> +# filesystem. Monitor the notification in the respective logs.
> +
> +. ./common/preamble
> +
> +_begin_fstest auto quick mount clone
> +
> +_require_test
> +_require_scratch_dev_pool 2
> +_require_command "$INOTIFYWAIT_PROG" inotifywait
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -r -f $tmp.*
> +	umount $mnt1 $mnt2 2>/dev/null
> +	_scratch_dev_pool_put
> +}
> +
> +_scratch_dev_pool_get 2
> +_scratch_mkfs_sized_clone >$seqres.full 2>&1
> +devs=($SCRATCH_DEV_POOL)
> +mnt2=$TEST_DIR/mnt2
> +mkdir -p $mnt2
> +
> +_scratch_mount $(_clone_mount_option)
> +_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[1]} $mnt2 || \
> +						_fail "Failed to mount dev2"
> +
> +log1=$tmp.inotify1
> +log2=$tmp.inotify2
> +
> +echo "Setup inotify watchers on both SCRATCH_MNT and mnt2"
> +$INOTIFYWAIT_PROG -m -e create --format '%f' $SCRATCH_MNT > $log1 2>&1 &
> +pid1=$!
> +$INOTIFYWAIT_PROG -m -e create --format '%f' $mnt2 > $log2 2>&1 &
> +pid2=$!
> +sleep 2
> +
> +echo "Trigger file creation on SCRATCH_MNT"
> +touch $SCRATCH_MNT/file_on_scratch_mnt
> +sync
> +sleep 1
> +
> +echo "Trigger file creation on mnt2"
> +touch $mnt2/file_on_mnt2
> +sync
> +sleep 1
> +
> +echo "Verify inotify isolation"
> +kill $pid1 $pid2
> +wait $pid1 $pid2 2>/dev/null

I think you also need to take care of killing the bg process
in _cleanup() so that the test could be cleanly aborted.

Thanks,
Amir.

> +
> +if grep -q "file_on_scratch_mnt" $log1 && ! grep -q "file_on_mnt2" $log1; then
> +	echo "SUCCESS: SCRATCH_MNT events isolated."
> +else
> +	echo "FAIL: SCRATCH_MNT inotify confusion!"
> +	[ ! -s $log1 ] && echo "  - SCRATCH_MNT received no events."
> +	grep -q "file_on_mnt2" $log1 && echo "  - SCRATCH_MNT received event from mnt2."
> +fi
> +
> +if grep -q "file_on_mnt2" $log2 && ! grep -q "file_on_scratch_mnt" $log2; then
> +	echo "SUCCESS: mnt2 events isolated."
> +else
> +	echo "FAIL: mnt2 inotify confusion!"
> +	[ ! -s $log2 ] && echo "  - mnt2 received no events."
> +	grep -q "file_on_scratch_mnt" $log2 && echo "  - mnt2 received event from SCRATCH_MNT."
> +fi
> +
> +status=0
> +exit
> diff --git a/tests/generic/790.out b/tests/generic/790.out
> new file mode 100644
> index 000000000000..3c92c34ffbda
> --- /dev/null
> +++ b/tests/generic/790.out
> @@ -0,0 +1,7 @@
> +QA output created by 790
> +Setup inotify watchers on both SCRATCH_MNT and mnt2
> +Trigger file creation on SCRATCH_MNT
> +Trigger file creation on mnt2
> +Verify inotify isolation
> +SUCCESS: SCRATCH_MNT events isolated.
> +SUCCESS: mnt2 events isolated.
> -- 
> 2.43.0
> 

