Return-Path: <linux-btrfs+bounces-2074-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79468470DE
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 14:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBE56B243B6
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 13:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823C017C67;
	Fri,  2 Feb 2024 13:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBC5R8/V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E825F4684
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706879491; cv=none; b=U0fVKQKE8ntKBc0xeU56EwqTpZzheVMri0TBoOQNvNU8bwDkoWjgb8AtmivivVvFeshqcJI4QfWN6N5j6nTSeMNZYdYRxeDZc7gcapjvW3l0IDXIcO+9H1BQnwuYjLkP/NeuEtKGmA9OjhDczprqyztT3hMx9ErXQHmyi22oPys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706879491; c=relaxed/simple;
	bh=YyTgKJvaiKug90qXFHOlmJCGsQUmZkn7asgzaFtSIdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5MIlL1X8ZYWXBGgNVZCfA77gW4ZYDiSefU74Qs6qh+ovbLR64oatY7jbygNbVfiflmeVmJu2tjUU0bYgbOAReUe8hXT95CtCdxbuxNF2UJR4bv2IVtU7w/ej9dcfhcGbSXQW42HYmRpzSnCGgYmvS9RIS4aB2IUcT6yVzLVr2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JBC5R8/V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706879488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JwFqUpnRF1eGrLmRen0RvOfSRmhk6v46jjK00x9zuEk=;
	b=JBC5R8/V23/DIOj0qDGnwXMFq+udCUAUdH00IzLWUhO0rYdU0O8Wmu45QGbmY+hyyggoTh
	7+8c2xWKgfTHYo2oOTlRPwvmwb76rIL4ZQFn384M0f/6BmHWeo3n+ioJpa6lfiBiXynI8p
	MynxETUIMDiCjayITS/Cb+yq1Nuuqq0=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-EHmJHrKWNS-TPyKmfbaPvg-1; Fri, 02 Feb 2024 08:11:27 -0500
X-MC-Unique: EHmJHrKWNS-TPyKmfbaPvg-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5cf555b2a53so2586599a12.1
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Feb 2024 05:11:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706879485; x=1707484285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwFqUpnRF1eGrLmRen0RvOfSRmhk6v46jjK00x9zuEk=;
        b=fXAWnSFticY+mZ7aSSDzYJKqEJ+eK6WNXTsLwxK9Oat04CWXEcEOWhdHG4mHe/YhLa
         N7/YAp7whPfBHwpVCH5rLzEm8tiWS9WDqrAwMpjCkoDM1q2iE/sISic+ufy6SylYi96o
         Cq1Sh0jQiwUwbp6pEW8CH7UrgUZcMrxzUOspKdkGxjaDsFSdXuLSPQlkLdTY3O1aC35e
         48A6tt6VKdy4BO1kUxwT14oOgnv6Po99TalARUpAEjY4wE776oNiAAt1BRLQAMFauCnT
         kBX8Bo6+phYOPPiaOFS4U0lTnCDHhxwkp3lWLcNUcRdJ8JHlnx5TB6Xw53iTYLWlnuro
         6M0w==
X-Gm-Message-State: AOJu0YwieAAvaDrmCAUAA4IPvWBjZxJ2Ur/fSCSp8Is/Yv+Jd2Q4VFq8
	Z8VwhVB3fvf10D4wWqqSLghniXIVo7HXEf7mGl9UGRs5OPxt07ReFYxpo7t1wL/QmL1qkxGx+MO
	urWZ58tCcRxALZ/etbv3p7eRly1WvLnlNqxwSi+x3pMp5I2yOG5AfW34kcA4P6OuK+HyD9rYGTf
	Ba1zvCFZGvLBixZsVotnFdA8G84TR0PkYGGvzgXoVpNRQ=
X-Received: by 2002:a05:6a21:339b:b0:19e:2d00:10c6 with SMTP id yy27-20020a056a21339b00b0019e2d0010c6mr3929545pzb.23.1706879485439;
        Fri, 02 Feb 2024 05:11:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQUIgH7jHGyE4E7iqhDI/U01DjAS66eH7HIxfNODSK5m4ONlKY3SvENaBlUDwCr+yxP4jSdQ==
X-Received: by 2002:a05:6a21:339b:b0:19e:2d00:10c6 with SMTP id yy27-20020a056a21339b00b0019e2d0010c6mr3929489pzb.23.1706879484964;
        Fri, 02 Feb 2024 05:11:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXAjnCPL3f4MZTH9VVyn/tcym8GkonzT7cAnyi3Uk1lcW7dCuliJtzOaDWCLPevd9+gdNFh2MisAJ8HmI8pPelN64wKkf6U1ciDK3dIVV1RcUR6Wcj3fyQan/eb
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c24-20020a634e18000000b005d7b18bb7e2sm1542261pgb.45.2024.02.02.05.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 05:11:24 -0800 (PST)
Date: Fri, 2 Feb 2024 21:11:20 +0800
From: Zorro Lang <zlang@redhat.com>
To: linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>, kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: Re: [PATCH] btrfs: Remove btrfs/303
Message-ID: <20240202131120.q35fe45cmu5e3dqz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <a3f51f2fff6581a6b4dd2e5776b7f40d22dcf65b.1706039782.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3f51f2fff6581a6b4dd2e5776b7f40d22dcf65b.1706039782.git.boris@bur.io>

On Tue, Jan 23, 2024 at 11:56:59AM -0800, Boris Burkov wrote:
> This test was reproducing a bug triggered by creating a subvolume qgroup
> before creating the subvolume itself with a snapshot.
> 
> The kernel patch:
> btrfs: forbid creating subvol qgroups
> 
> explicitly prevents that and makes it fail with EINVAL. I could "fix"
> this test by expecting the EINVAL message in the output, but at that
> point it would simply be a test that creating a subvolume and
> snapshotting it works with qgroups, which is adequately tested by other
> tests which focus on accurately measuring shared/exclusive usage in
> various snapshot/reflink scenarios. To avoid confusion, I think it is
> best to simply delete this test.
> 
> Signed-off-by: Boris Burkov
> ---

Just a reminder, this's a test deletion. To avoid test coverage decrease,
I'd like to give it more time to get more reviewing of btrfs list. If no
one has any concern, I'll merge it :)

>  tests/btrfs/303     | 77 ---------------------------------------------
>  tests/btrfs/303.out |  2 --
>  2 files changed, 79 deletions(-)
>  delete mode 100755 tests/btrfs/303
>  delete mode 100644 tests/btrfs/303.out
> 
> diff --git a/tests/btrfs/303 b/tests/btrfs/303
> deleted file mode 100755
> index 410460af5..000000000
> --- a/tests/btrfs/303
> +++ /dev/null
> @@ -1,77 +0,0 @@
> -#! /bin/bash
> -# SPDX-License-Identifier: GPL-2.0
> -# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
> -#
> -# FS QA Test 303
> -#
> -# A regression test to make sure snapshot creation won't cause transaction
> -# abort if there is already an existing qgroup.
> -#
> -. ./common/preamble
> -_begin_fstest auto quick snapshot subvol qgroup
> -
> -. ./common/filter
> -
> -_supported_fs btrfs
> -_require_scratch
> -
> -_fixed_by_kernel_commit xxxxxxxxxxxx \
> -	"btrfs: do not abort transaction if there is already an existing qgroup"
> -
> -_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> -_scratch_mount
> -
> -# Create the first subvolume and get its id.
> -# This subvolume id should not change no matter if there is an existing
> -# qgroup for it.
> -$BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/subvol" >> $seqres.full
> -$BTRFS_UTIL_PROG subvolume snapshot "$SCRATCH_MNT/subvol" \
> -	"$SCRATCH_MNT/snapshot">> $seqres.full
> -
> -init_subvolid=$(_btrfs_get_subvolid "$SCRATCH_MNT" "snapshot")
> -
> -if [ -z "$init_subvolid" ]; then
> -	_fail "Unable to get the subvolid of the first snapshot"
> -fi
> -
> -echo "Subvolumeid: ${init_subvolid}" >> $seqres.full
> -
> -_scratch_unmount
> -
> -# Re-create the fs, as btrfs won't reuse the subvolume id.
> -_scratch_mkfs >> $seqres.full 2>&1 || _fail "2nd mkfs failed"
> -_scratch_mount
> -
> -$BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT" >> $seqres.full
> -_qgroup_rescan $SCRATCH_MNT >> $seqres.full
> -
> -# Create a qgroup for the first subvolume, this would make the later
> -# subvolume creation to find an existing qgroup, and abort transaction.
> -$BTRFS_UTIL_PROG qgroup create 0/"$init_subvolid" "$SCRATCH_MNT" >> $seqres.full
> -
> -# Now create the first snapshot, which should have the same subvolid no matter
> -# if the quota is enabled.
> -$BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/subvol" >> $seqres.full
> -$BTRFS_UTIL_PROG subvolume snapshot "$SCRATCH_MNT/subvol" \
> -	"$SCRATCH_MNT/snapshot" >> $seqres.full
> -
> -# Either the snapshot create failed and transaction is aborted thus no
> -# snapshot here, or we should be able to create the snapshot.
> -new_subvolid=$(_btrfs_get_subvolid "$SCRATCH_MNT" "snapshot")
> -
> -echo "Subvolumeid: ${new_subvolid}" >> $seqres.full
> -
> -if [ -z "$new_subvolid" ]; then
> -	_fail "Unable to get the subvolid of the first snapshot"
> -fi
> -
> -# Make sure the subvolumeid for the first snapshot didn't change.
> -if [ "$new_subvolid" -ne "$init_subvolid" ]; then
> -	_fail "Subvolumeid for the first snapshot changed, has ${new_subvolid} expect ${init_subvolid}"
> -fi
> -
> -echo "Silence is golden"
> -
> -# success, all done
> -status=0
> -exit
> diff --git a/tests/btrfs/303.out b/tests/btrfs/303.out
> deleted file mode 100644
> index d48808e60..000000000
> --- a/tests/btrfs/303.out
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -QA output created by 303
> -Silence is golden
> -- 
> 2.43.0
> 
> 


