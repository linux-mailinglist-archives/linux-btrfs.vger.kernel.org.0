Return-Path: <linux-btrfs+bounces-22290-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFuKEcn8rmlbLQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-22290-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Mar 2026 18:00:57 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A55E23D415
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Mar 2026 18:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B56C6306BE16
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2026 16:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D563CB2E3;
	Mon,  9 Mar 2026 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXXsZB+N";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pVw45+nY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1673A9DA9
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Mar 2026 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075120; cv=none; b=Tn6ON/3frSms6zngGZvbAzI4lwz3AiFxjLKxV15etie2SQ65bKJyL9Bzl3SARrQ82apy6PLqSflP/sghMifd2uYHc/bacnzxT0oBSX6apxC+WngxqN5ov4smiD9rtBlq8iqT0UujO7ITPWZ588To5XxmWub8KLlq20/Y5PsSal8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075120; c=relaxed/simple;
	bh=pfPJGSGwLJpw6e+UV3B4HrX5vEv6FV7uTd+GSbj1eds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DphfG0NiqzHx2L39m44gOTc6fGPEn1+9lQkGj6szOixmaYBGJwg65C88RaSFecrSTYLyPnuyru9hhnrqXa4WhkOmyUDRcEyNCdfqPMHUxTdfDSSj0PgHipTQ1gnt49OIqMwC7LpOJ9+6eK8xydPy9PUh3WWc3j6wBPjDZghAJJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aXXsZB+N; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pVw45+nY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773075117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=25QIYSKQ8RVJbNVeADyj4xqplKGsCB0QVBu3zT5eoAo=;
	b=aXXsZB+NQQr1a/APnZv7F4o5DTnAoUZPUB3Ocgif3HzuTciZiW6UmLg7omNhiOyBM6wvnA
	xeCiA1eknoFQth5MnKduQa+swBP3QDyr0CeRgzhWaJ4ZSXRv8c2pEadbGWaBysiyh4AejZ
	CHwk6I/rXW5Bb3SOKIhOrc7u3oQgPPA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-clQjxSkuMOGlSqi3WLzVkg-1; Mon, 09 Mar 2026 12:51:55 -0400
X-MC-Unique: clQjxSkuMOGlSqi3WLzVkg-1
X-Mimecast-MFC-AGG-ID: clQjxSkuMOGlSqi3WLzVkg_1773075114
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2adc527eaf5so71221395ad.0
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Mar 2026 09:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773075114; x=1773679914; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=25QIYSKQ8RVJbNVeADyj4xqplKGsCB0QVBu3zT5eoAo=;
        b=pVw45+nYUYZIX2cRoIQs1dYngNBVwANh0g7rZE5mcqkLNiZM72ZNgJw9zS5gyG2A8Q
         PIYo2CNZXp+dNRxq15KLjO8wcC/Vv2MADnYHHsIjRVB/JSWxn1l3OuJmgf6JnQCZ3teZ
         b3cHn2iqkSDV3TuE4pbA/fBVxR7eSGxOkxh1IbkWUNXbQ9lUSpV+H5sb4juaTV9oG6RA
         uBefMEb9Zt9wI86XUl4pHK5X2qPpapQnJ9n0oF0dPLuU+yENS52+M0vJem00IXZPQW2y
         bokki4ESu915zMkFKu5TXVAts1Lu2csY2M+METaTcWNl0jWVaRKo91kStGP614ATSSh9
         WsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773075114; x=1773679914;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=25QIYSKQ8RVJbNVeADyj4xqplKGsCB0QVBu3zT5eoAo=;
        b=r10ypJEQcAgeWbFZWh4PdHvA91H6byN0mb8xz2FaFJYbOVoiMgCgJ617pqA8K96qME
         9Bp6ZE3hLPcx2owjzoWaXdZ4YTbHiO47ji2UjEXWUp7ER3iwI0pZQx85HjXBYBI41js3
         BzrsHYP+GVVI20q4SBxx3HfPyYyzTxNtbfU0q7nXzK/sOVWUtMtbfiucuugDflVom70O
         gNnWmHWhHSGgPdTWxfmweC5gA+OL11I+wukKmExEJ4BmKXhw6bu/vhub4Yb584g1XsUE
         YEjM541R7sbJkabu3VgfLsoVRFXmzGLDZL6umyHwFu5W4kn2zd5hDghZVxFIzY5r3xPQ
         xC/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5wsmEZOODcrx7/Cod/va1lwP7rX9GpNxWMcPULBMh4Gh6IcLy1nJ/oAE+sY/VMshhw99SqeDL+C6Pug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yznt27j0gaFgs1wokUqo5TeqVOAz00/d8x5puvv1f9xYxMt/869
	Cp58qAT7z1VP1yNpK9r9ebW5s3qUuvgJ7FokH4NRQMOy+53rxhFONTfR5ksPL76Rtkxt9nMsN5H
	a3Mxl8s3khJEK0p825HeUHEB7uOi8hgCoo0EgO0rah9BttxzwIrvFCUMOYDA9li+Y
X-Gm-Gg: ATEYQzycDBHvt/WSMYaJvlTwECBUXm+8ivNe+LdUuuC7mIvcOqae8WTXm2iyf11lWeF
	MItxDj2rrukaSTaann7U0SBYXtTnd+TbBClgfvHNuFKhehk0VUkosQHY8V/p/KbKK/rgtL7bsxT
	iCDzP6sY0rPeuoWReVViYFJaLhZqc7i286zUTaVS3EmCjdepB1uLPGsnmEG4cPKCWD7JWtHB5bh
	ajkMqcops4OXHyHOFEiRLfKSvCQCl2Fle0Fw7iqCQsfL+QSW8nkI3/J/1K+XA5PluyiJw6LvsEz
	CJL8m4vGb5JX+RhteX+MFvwgfpPx23dg1vK3zDXXo5iUeeWMNw5jYbBwCYf/ENEU7GxC4aVXyv8
	lU1p8Hi+Pqx7HVAy/J+4eaZo3S6ni5Y7doNX2fP30AIllJVZrTEno/YfoB6hbrQ==
X-Received: by 2002:a17:902:e745:b0:2aa:d60c:d48a with SMTP id d9443c01a7336-2ae8241815emr118925435ad.7.1773075114106;
        Mon, 09 Mar 2026 09:51:54 -0700 (PDT)
X-Received: by 2002:a17:902:e745:b0:2aa:d60c:d48a with SMTP id d9443c01a7336-2ae8241815emr118925235ad.7.1773075113658;
        Mon, 09 Mar 2026 09:51:53 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e9b9c6sm137627845ad.29.2026.03.09.09.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 09:51:53 -0700 (PDT)
Date: Tue, 10 Mar 2026 00:51:48 +0800
From: Zorro Lang <zlang@redhat.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: hch <hch@lst.de>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] fstests: test premature ENOSPC in zoned garbage
 collection
Message-ID: <20260309165148.nxuukjvpizrwawft@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20260210111103.265664-1-johannes.thumshirn@wdc.com>
 <20260309153136.taooohkzuc4ov56p@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <f39bb05c-f3ea-439e-8a78-71909ec3ef3e@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f39bb05c-f3ea-439e-8a78-71909ec3ef3e@wdc.com>
X-Rspamd-Queue-Id: 0A55E23D415
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22290-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zlang@redhat.com,linux-btrfs@vger.kernel.org];
	RSPAMD_EMAILBL_FAIL(0.00)[johannes.thumshirn.wdc.com:query timed out];
	NEURAL_HAM(-0.00)[-0.953];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 03:35:56PM +0000, Johannes Thumshirn wrote:
> On 3/9/26 4:31 PM, Zorro Lang wrote:
> > On Tue, Feb 10, 2026 at 12:11:03PM +0100, Johannes Thumshirn wrote:
> >> This test stresses garbage collection in zoned file systems by
> >> constantly overwriting the same file. It is inspired by a reproducer for
> >> a btrfs bugifx.
> >>
> >> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >> ---
> >>   tests/generic/783     | 48 +++++++++++++++++++++++++++++++++++++++++++
> >>   tests/generic/783.out |  2 ++
> >>   2 files changed, 50 insertions(+)
> >>   create mode 100755 tests/generic/783
> >>   create mode 100644 tests/generic/783.out
> >>
> >> diff --git a/tests/generic/783 b/tests/generic/783
> >> new file mode 100755
> >> index 000000000000..f996d78803a1
> >> --- /dev/null
> >> +++ b/tests/generic/783
> >> @@ -0,0 +1,48 @@
> >> +#! /bin/bash
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +# Copyright (c) 2026 Western Digital Corporation.  All Rights Reserved.
> >> +#
> >> +# FS QA Test 783
> >> +#
> >> +# This test stresses garbage collection in zoned file systems by constantly
> >> +# overwriting the same file. It is inspired by a reproducer for a btrfs bugifx.
> >> +
> >> +. ./common/preamble
> >> +_begin_fstest auto quick zone
> >> +
> >> +. ./common/filter
> >> +
> >> +_require_scratch_size $((16 * 1024 * 1024))
> >> +_require_zoned_device "$SCRATCH_DEV"
> >> +
> >> +# This test requires specific data space usage, skip if we have compression
> >> +# enabled.
> >> +_require_no_compress
> >> +
> >> +if [ "$FSTYP" = btrfs ]; then
> >> +	_fixed_by_kernel_commit XXXXXXXXXXXX \
> >> +		"btrfs: zoned: cap delayed refs metadata reservation to avoid overcommit"
> >> +	_fixed_by_kernel_commit XXXXXXXXXXXX \
> >> +		"btrfs: zoned: move partially zone_unusable block groups to reclaim list"
> >> +	_fixed_by_kernel_commit XXXXXXXXXXXX \
> >> +		"btrfs: zoned: add zone reclaim flush state for DATA space_info"
> > Please rebase to latest for-next branch, then change above "_fixed_by_kernel_commit"
> > to "_fixed_by_fs_commit btrfs ...."
> 
> Sure.
> 
> 
> >> +fi
> >> +
> >> +_scratch_mkfs_sized $((16 * 1024 * 1024 * 1024)) &>>$seqres.full
> >> +_scratch_mount
> >> +
> >> +blocks="$(df -TB 1G $SCRATCH_DEV |\
> >> +	$AWK_PROG -v fstyp="$FSTYP" 'match($2, fstyp) {print $3}')"
> > Wouldn’t it make more sense to get the available size here? And there's a helper
> > _get_available_space in common/rc.
> 
> I'll have a look at it and see if it fits.
> 
> 
> >> +
> >> +loops=$(echo "$blocks * 4 - 2" | bc)
> > Is $blocks a huge number? How about using $((blocks * 4 - 2)) simply?
> >
> > Can you add a comment to explain what's this "blocks * 4 - 2" for?
> Will do.
> >> +
> >> +for (( i = 0; i < $loops; i++)); do
> >> +	dd if=/dev/zero of=$SCRATCH_MNT/test bs=1M count=1024 status=none 2>&1
> > Not sure what's the "2>&1" for.
> It was there before I had status=none, I'll fix it in the next revision.
> >
> > This isn't an append write, right? So we keep writting from 0 to 1G? Can you use a
> > comment to explain why we require 16G sized SCRATCH_DEV ?
> Because of the zoned write constraints? We can't overwrite until the 
> zone is reset.

Oh, this's a zoned storage test, sure, thanks! I think we could add a comment here to
remind readers that this is actually a sequential/append write :)

Thanks,
Zorro


