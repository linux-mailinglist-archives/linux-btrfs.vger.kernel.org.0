Return-Path: <linux-btrfs+bounces-3075-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E868756FA
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 20:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2BB21C214C3
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 19:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AAB136997;
	Thu,  7 Mar 2024 19:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NB7OR0wa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35CF136995
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Mar 2024 19:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839227; cv=none; b=NybRx29t4V+/ObfvuhrG4DG6rRhLe4i8tyTS/D2ymxiSSrZ+xsxHoMAgOSHuilA5p9UfLAzSKJr3ZyIiuGUA2nxJhjXNPpndtz0jnfVocKsQvToccUGdOEo2r5DhVXGChtnf8J0ilmNoane4eDxpfkwPxlSEpCh+ZFyp9Sp91UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839227; c=relaxed/simple;
	bh=DPvJrwfnPv3YPwnEanxIx6W+5VuN9Ynlbda5G4URcOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+677TYkvCNLHdn7YRtcnm1i08vSLoETAkC+peyMvcMpNkATkDZ1TtQ+2ZU2UojcPpP0DNq90PCLCS4aHHGBJDvaQ0v3yBc7on9LXtQeY+4rTynacxWTCBzXCyYERP+bDUNBQCAbGsV1+c0E3a+ZMPh0tmdsPbKZw/EspPg9KOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NB7OR0wa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709839224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9WfbMpoFUorDCUZ5uauUsNbFVkULWkKKGarWRB9V6xY=;
	b=NB7OR0waUAR3pWwfAwNFQ8FSkFKpSXJUXYRqRnhg5f/1ndjbsru3op8R2VLt6cE7GPSs0K
	vGa6qsvjNdXgjehsCLC6LsK5SvLtWGsYq4vJVO25CzQAYwxa1ngwiTSh489yJMoMceIjPG
	OlfSi0eb6raMpiIuDm5bPOUJ7kV7GYM=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-5leHFO6JP6qEgHX1I-eBiQ-1; Thu, 07 Mar 2024 14:20:23 -0500
X-MC-Unique: 5leHFO6JP6qEgHX1I-eBiQ-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6e661a33880so757150b3a.2
        for <linux-btrfs@vger.kernel.org>; Thu, 07 Mar 2024 11:20:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709839222; x=1710444022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WfbMpoFUorDCUZ5uauUsNbFVkULWkKKGarWRB9V6xY=;
        b=VLyJETvhpjrkutWFvBapWCa12n1Ad0FxE/7a3ydMDx0Bm1VHsJmhjtCTlgRyZE1Zph
         1hbTSXzBY85JixcCEfrWBUIvC/ctZ99HPhjKn5fAUQYhsWcxvmWBxgzjHUZXmAeXTf2E
         MZimek7sBjFJPEjQ1tOcFpo4VbwccLgKAE+oQBY/R7ruL3iV/5YZJO4+1b8+9q+F0BCd
         JSSxt3rBxHQL9SyssnpXN15xAIJps5cptoVrVL0MY7Cia9JkXHxYEUN6qxVrfxV7N3VV
         TZn8W30KH+S6EUGqV6hCN3OAbFpopCZeR0XzFTDxKR17Ehu4VQk0rP54ZwQKVfzyYs5C
         rhWA==
X-Forwarded-Encrypted: i=1; AJvYcCW+B+UIpQ3X5N9jHjmwVlR18nlbCG4X2VMRxP7KyLXNBrsAcS9m/F0wnCMHrIG+dksZLoB6+P2WE+j7Z9FyPN44e2s1kjZUXpuy01A=
X-Gm-Message-State: AOJu0YxjaGO61TzEhuC6SvhI0S1Ncsi5gxB6WWdFqJaNcJqGHc0/rMOr
	VwxDaqQsA8gbhGBoT1+dpGiqs8b/KDcxYeVtwxXPTI+HIf6h5msypKc3HpP0qHVeq4iC6divsnm
	2motj3abCaPYu6NRI0YDivxKpbNHJNJ4Gg6DmAp0FFD4IAsJ+BIL9OMJ51jHS
X-Received: by 2002:a05:6a00:1707:b0:6e5:9698:84a8 with SMTP id h7-20020a056a00170700b006e5969884a8mr20013776pfc.27.1709839221933;
        Thu, 07 Mar 2024 11:20:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBLrJUDQedIIht44YpoNSNMgffGU1eT2NUFatBePDFFigzDh6WW36BGHWk73fSVAfgQ6+1mA==
X-Received: by 2002:a05:6a00:1707:b0:6e5:9698:84a8 with SMTP id h7-20020a056a00170700b006e5969884a8mr20013754pfc.27.1709839221360;
        Thu, 07 Mar 2024 11:20:21 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id fx14-20020a056a00820e00b006e632056c40sm5977671pfb.0.2024.03.07.11.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 11:20:21 -0800 (PST)
Date: Fri, 8 Mar 2024 03:20:17 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs: test mount fails on physical device with
 configured dm volume
Message-ID: <20240307192017.4lxymyxhplysad4i@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1709806478.git.anand.jain@oracle.com>
 <c68878cb99025b8c8465221205d5de9e40777b18.1709806478.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c68878cb99025b8c8465221205d5de9e40777b18.1709806478.git.anand.jain@oracle.com>

On Thu, Mar 07, 2024 at 06:20:24PM +0530, Anand Jain wrote:
> When a flakey device is configured, we have access to both the physical
> device and the DM flaky device. Ensure that when the flakey device is
> configured, the physical device mount fails.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/btrfs/318     | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/318.out |  3 +++
>  2 files changed, 48 insertions(+)
>  create mode 100755 tests/btrfs/318
>  create mode 100644 tests/btrfs/318.out
> 
> diff --git a/tests/btrfs/318 b/tests/btrfs/318
> new file mode 100755
> index 000000000000..015950fbd93c
> --- /dev/null
> +++ b/tests/btrfs/318
> @@ -0,0 +1,45 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 318
> +#
> +# Create multiple device nodes with the same device try mount
> +#
> +. ./common/preamble
> +_begin_fstest auto volume tempfsid
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	umount $extra_mnt &> /dev/null
> +	rm -rf $extra_mnt &> /dev/null
> +	_unmount_flakey
> +	_cleanup_flakey
> + 	cd /
> + 	rm -r -f $tmp.*
> +}
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/dmflakey
> +
> +# real QA test starts here
> +_supported_fs btrfs

BTW, what cause it have to be a btrfs specific test case? I didn't any
btrfs specific operations below, can you explain the reason?

Thanks,
Zorro

> +_require_scratch
> +_require_dm_target flakey
> +
> +_scratch_mkfs >> $seqres.full
> +_init_flakey
> +
> +_mount_flakey
> +extra_mnt=$TEST_DIR/extra_mnt
> +rm -rf $extra_mnt
> +mkdir -p $extra_mnt
> +_mount $SCRATCH_DEV $extra_mnt 2>&1 | _filter_testdir_and_scratch
> +
> +_flakey_drop_and_remount
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/318.out b/tests/btrfs/318.out
> new file mode 100644
> index 000000000000..5cdbea8c4b2a
> --- /dev/null
> +++ b/tests/btrfs/318.out
> @@ -0,0 +1,3 @@
> +QA output created by 318
> +mount: TEST_DIR/extra_mnt: wrong fs type, bad option, bad superblock on SCRATCH_DEV, missing codepage or helper program, or other error.
> +       dmesg(1) may have more information after failed mount system call.
> -- 
> 2.39.3
> 
> 


