Return-Path: <linux-btrfs+bounces-22288-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sN0tIdvrrmkWKQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-22288-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Mar 2026 16:48:43 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F238423C051
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Mar 2026 16:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61F0F306967D
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2026 15:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912933DA5A8;
	Mon,  9 Mar 2026 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+klaNV0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yr00SgG6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CF43D9046
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Mar 2026 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070306; cv=none; b=hTznHFXLn1wf21UUKV+0hnkzdvgo5Q4ewtJXZtUUT6qGEO5rapXagDac57oAy0OsgsM2zRrGYWfP+QZiM4eFl6MhUFC41O9bgIJtXA1LzZh/EZE3eIW+pP1zuL0fZR0T2K+e/WuCg8e0macKzpGIRLhFinRRG9NoIIFtpAbjDVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070306; c=relaxed/simple;
	bh=styTRJidEb329/TYcyG6xwk1XD538n4BzhBnsVUAb0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQGBHdD0yMZ2/y0N1vx0JoZmnnJ0WXLCof90m/fTxBIqOI4/VT8RwCMnRR9fBJobBNtfusjollYDwwSQGmrHwxCzAA5sqos3O9HnL0AVTkv5rd4MFA03FgK6SJv8tfwZZyJEpbeYQ8IlTI14CRC/864jfZqm2hB6y6QfhBlv9jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H+klaNV0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yr00SgG6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773070304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HCA6EuPYCbjISG8NkXGqwgNV/qegVIJI7skqyHztj+g=;
	b=H+klaNV0RX81TWY4UofVt52Tvx5+za5BIXwnGHDIFmlMDGl6DmaVueHl5s/mWLF/hKjWBt
	hWyVpY48RJQHJjSDAM3cW1LXZbVrLJsUUrlAr1+tualRzk753MV4upxX0r6iwPQ3GvEVLP
	VKpgbZovyQxie4ZQPDcIMz3UbtH4VWI=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-7nGXtzTFPDySDcg-ZNJMHA-1; Mon, 09 Mar 2026 11:31:43 -0400
X-MC-Unique: 7nGXtzTFPDySDcg-ZNJMHA-1
X-Mimecast-MFC-AGG-ID: 7nGXtzTFPDySDcg-ZNJMHA_1773070303
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-829b8bb5173so576717b3a.3
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Mar 2026 08:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773070302; x=1773675102; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HCA6EuPYCbjISG8NkXGqwgNV/qegVIJI7skqyHztj+g=;
        b=Yr00SgG6h2Xxb4ejJT9o0ydOuXyNsMXMo2QixXXTwetRi5jM26M0FAscioGvt071Bc
         axWnjcQF4gdiSpnMczAdrf+H8x0IIhPQDubub+zastYuDOKAbg4bFLhqZ4LMa1JOLUtP
         fkXaEf/EQHpxTOrDl5TUU9J53X0+DP16EC527YkBJMx2gbzMYuXq3ZBJZo7DtrVapaGR
         vmZLucgkumy5KQRJ20stWGsSl2W+QT/nByLjUJ3FbF5uAtwcdM3FUKETzlOj6wG6kGfZ
         VfoDx98lKJfBImKmBAO3Z+yfarNvPjGN9N5JVZssBfM2wkP2jdvCmc0WpNxuzTXK2kie
         4HTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773070302; x=1773675102;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HCA6EuPYCbjISG8NkXGqwgNV/qegVIJI7skqyHztj+g=;
        b=dcjsQar7ynozkEKAGnfm+m003YDWlZZvhWC/qF1vk9wMmGAJZwui/83Zv+onnkhN1E
         P7ntls7AuNUyKH3tQowEyfUw0++OREMqeL4nSOWwWD2nuJk3MayD7iKpVXpYfpjzsb6j
         tU9F2qCHz4lP/ApKJeH2dBDZOpERrYlPW3XtE2tbwSGRddAevJBMPaiKzeiGU3Vjl4oc
         fdwmDsWTvVdMIYcB4RmIUoTOPp4vzluLoKiboVowLrSnoqqUih1GvrHXig1Y1HCy2rL8
         xFV4F8uBOMyeoCizN4iCx2Fz1oZki15tiYEwucQX7J5JalpFi69AnOdRWdeR3anxF7g5
         PM/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQT2ApkvR7Zu+gkfu+gymW/XCKsiOcmn3LSAftghBXdpC7ZkgocBuSIfGPA27j+/Di+APC3sdIXRi54Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRSBX+xb6NWyfi9J7e5snWVBcB97qtXfoEwUdX7ebPQs87SrUQ
	OXVqlZ0LgPt4ed3rGlpQUcNV8ua1XSFdkXV5vQ8Iz6dDatfZUYp5K/yclBi6wcT4yaZt3lHyUg3
	zbfZbnnVkErhktlMaMXIJPjhoMrFHryswplXo1uDfW9pcBrJT6/yBaoebY243m+8G
X-Gm-Gg: ATEYQzzkaBQiaigc/WbWK0o0W2bVHCNi+acnAB670B8Vy+QXQaO+qyj62vhsdU5kXZM
	Qp30GX1ONnxAvfP3i7K6P7gh/ZaH1KoDvk6OsK+Mp0yMaR3q8Ca1noi0GCBxC1v0h67t+0WIaAj
	0HHc3EL3OlweHcsjJL+0pUPujj9jbkZgDClEhMbKv+/oezbhQhxrhbEtMP0On0uvb2yjsr9oysW
	Fv9hnLDfAdp51kqjlfOluCemri7s6I46kXW2EL9N9ZURQoliFwYytJSra3Ixx+EcXKfqWcDPF0A
	RqiUdlyZIQMz6l20YN+aXTz7Z8n3IAMn3p02DzKEugHOlJXU9HsAYTWVVDSInqsfcbMOaLITo0j
	2pJxcXEmNm3l80jY5joOEtQX7J4s8dCTuG/TJkRRZ5Qtt3sPHfbwTJLpLducvyg==
X-Received: by 2002:a05:6a00:2483:b0:827:2dea:8840 with SMTP id d2e1a72fcca58-829a30b9c6fmr8489552b3a.56.1773070301550;
        Mon, 09 Mar 2026 08:31:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:2483:b0:827:2dea:8840 with SMTP id d2e1a72fcca58-829a30b9c6fmr8489528b3a.56.1773070300963;
        Mon, 09 Mar 2026 08:31:40 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4637bb1sm9901003b3a.10.2026.03.09.08.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 08:31:40 -0700 (PDT)
Date: Mon, 9 Mar 2026 23:31:36 +0800
From: Zorro Lang <zlang@redhat.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org, Hans Holmberg <Hans.Holmberg@wdc.com>,
	Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH] fstests: test premature ENOSPC in zoned garbage
 collection
Message-ID: <20260309153136.taooohkzuc4ov56p@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20260210111103.265664-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260210111103.265664-1-johannes.thumshirn@wdc.com>
X-Rspamd-Queue-Id: F238423C051
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22288-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zlang@redhat.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.951];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dell-per750-06-vm-08.rhts.eng.pek2.redhat.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 12:11:03PM +0100, Johannes Thumshirn wrote:
> This test stresses garbage collection in zoned file systems by
> constantly overwriting the same file. It is inspired by a reproducer for
> a btrfs bugifx.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  tests/generic/783     | 48 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/783.out |  2 ++
>  2 files changed, 50 insertions(+)
>  create mode 100755 tests/generic/783
>  create mode 100644 tests/generic/783.out
> 
> diff --git a/tests/generic/783 b/tests/generic/783
> new file mode 100755
> index 000000000000..f996d78803a1
> --- /dev/null
> +++ b/tests/generic/783
> @@ -0,0 +1,48 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Western Digital Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 783
> +#
> +# This test stresses garbage collection in zoned file systems by constantly
> +# overwriting the same file. It is inspired by a reproducer for a btrfs bugifx.
> +
> +. ./common/preamble
> +_begin_fstest auto quick zone
> +
> +. ./common/filter
> +
> +_require_scratch_size $((16 * 1024 * 1024))
> +_require_zoned_device "$SCRATCH_DEV"
> +
> +# This test requires specific data space usage, skip if we have compression
> +# enabled.
> +_require_no_compress
> +
> +if [ "$FSTYP" = btrfs ]; then
> +	_fixed_by_kernel_commit XXXXXXXXXXXX \
> +		"btrfs: zoned: cap delayed refs metadata reservation to avoid overcommit"
> +	_fixed_by_kernel_commit XXXXXXXXXXXX \
> +		"btrfs: zoned: move partially zone_unusable block groups to reclaim list"
> +	_fixed_by_kernel_commit XXXXXXXXXXXX \
> +		"btrfs: zoned: add zone reclaim flush state for DATA space_info"

Please rebase to latest for-next branch, then change above "_fixed_by_kernel_commit"
to "_fixed_by_fs_commit btrfs ...."

> +fi
> +
> +_scratch_mkfs_sized $((16 * 1024 * 1024 * 1024)) &>>$seqres.full
> +_scratch_mount
> +
> +blocks="$(df -TB 1G $SCRATCH_DEV |\
> +	$AWK_PROG -v fstyp="$FSTYP" 'match($2, fstyp) {print $3}')"

Wouldn’t it make more sense to get the available size here? And there's a helper
_get_available_space in common/rc.

> +
> +loops=$(echo "$blocks * 4 - 2" | bc)
Is $blocks a huge number? How about using $((blocks * 4 - 2)) simply?

Can you add a comment to explain what's this "blocks * 4 - 2" for?

> +
> +for (( i = 0; i < $loops; i++)); do
> +	dd if=/dev/zero of=$SCRATCH_MNT/test bs=1M count=1024 status=none 2>&1

Not sure what's the "2>&1" for.

This isn't an append write, right? So we keep writting from 0 to 1G? Can you use a
comment to explain why we require 16G sized SCRATCH_DEV ?

Thanks,
Zorro

> +	if [ $? -ne 0 ]; then
> +		_fail "Failed writing on iteration $i"
> +	fi
> +done
> +
> +echo "Silence is golden"
> +# success, all done
> +_exit 0
> diff --git a/tests/generic/783.out b/tests/generic/783.out
> new file mode 100644
> index 000000000000..2522395956d4
> --- /dev/null
> +++ b/tests/generic/783.out
> @@ -0,0 +1,2 @@
> +QA output created by 783
> +Silence is golden
> -- 
> 2.53.0
> 


