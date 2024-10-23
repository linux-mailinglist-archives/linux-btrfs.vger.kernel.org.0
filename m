Return-Path: <linux-btrfs+bounces-9083-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC3A9ABC5C
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 05:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6931C21248
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 03:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D2E3B7A8;
	Wed, 23 Oct 2024 03:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hjQ577U3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C603F84FAD
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2024 03:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729655035; cv=none; b=qrG5M9/LGuWCQbdMQJe8tdtGSJ+ABdlKOcLXmM9UQK8fk8aUEGi9VhupWiZrrgFaG80KiHUFW/wZrXRYPCZxi1kQyXjr+eFAENTq1D9gseBaY7TWpKhTiT9NhAY86y1RHw9m3xB3vhXam5Yaj4COuacIftUiJuPQ7LFH6OjcMsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729655035; c=relaxed/simple;
	bh=DrE3zMbY3opiAj9ivPnvoOqc2TUr6yZG1KasdCBlo0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDxbzShCpXhOMT+hIiZ3akm2jiC1oJLwUtd6wBIwdTXEzvTeDUqeoC6iKHCa9oHAXpWNQvQYG3fBf3Ys78Lm0xK1Bpd/dLs1TKmc2/SqGvy48SRrLjRPwkLtcLFG+5N9kk4S5RZsfa86fOhQusCWhSG1CIVS5fGY1jyuOqXc1j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hjQ577U3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729655032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ME4uxj2W+3TiF+0aUeXVAmiey9MLKGe2zI+5+yF4Xm4=;
	b=hjQ577U3GImKDJMZlPR852PHsbEi4eJVv8pmjQXL+QhUBxAlx7p1oS21Vt508hMnuvjYKK
	IxU5XwO1jVq/UTbYLTEpA1tF7Q9Xsx+rAglPGsp5rE1MCvBhbJGVwvo93AIDHXMzJ7Lbry
	V0TbcatQWmgW2HYBR6oxFLU+feTrl7Q=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-9mkUgfdQPCCE4Gax8da5Pg-1; Tue, 22 Oct 2024 23:43:51 -0400
X-MC-Unique: 9mkUgfdQPCCE4Gax8da5Pg-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-20e5ab8e022so58100105ad.3
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 20:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729655030; x=1730259830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ME4uxj2W+3TiF+0aUeXVAmiey9MLKGe2zI+5+yF4Xm4=;
        b=YqBWWzIRXtSM1aKyO1/NePDZLefHF1O7gOardzyulKeuSz+CVQtEHEEczAqkys8sH1
         RzfKT1IKH+Mirh4rqpxvc/Wnx74jIyy7VwQo/ylohe+VY+TO41HDCIbjotWdoEwIIK5p
         JJnQmLkxYfxNP/7y/CUuYjSw6HBkO5YRcxtKNBwOk26fBja3KFcenBmzgO7ScJRlPXeD
         eoPEahAgJAzrgKbBgxZYlEoBP4vpcNiJIEqjOK2ztLiovhnzwTQSJmLCd3+Jfj9YuP3m
         VBkDt2HN3CaINXInSc0GFV2/yQvT1bfbbS5NZJmSBcAnKQYT1of8i4leU8MWHf3yulT8
         Xg+w==
X-Forwarded-Encrypted: i=1; AJvYcCW2sPP9WEjHBu7erL7lO8WENOVRSB9ik0ibi81EtQjQXvPorCVP55Y1Up5GTR6p2G0FZxF7fZhqWOP4TQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2hr4WSpUPzlkFXHNkPAJK6XikEwVjjpvtHptItP0QiTJS/xuc
	NGf3kG9HUfUFdEyLr290CN0T05K4cx7el+UysK3JgdsVJf0U2BNYljTUfWDVyphrYgGhZycTcXF
	kaEkx6/bvdAfLgVTY6gLqK/M8ynUrrfnzwVmM9L0qCrQqSsxdFE89nK45Idwu
X-Received: by 2002:a17:903:41d1:b0:20c:d2e4:dc33 with SMTP id d9443c01a7336-20fa9e48cddmr20814945ad.14.1729655029989;
        Tue, 22 Oct 2024 20:43:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjuE82hLa9YB2wuraSz0dFx2/t/wwDKsvEpjOHgAcIuT7pfPrDgbEPo9gYPU8yuFWITRXnqg==
X-Received: by 2002:a17:903:41d1:b0:20c:d2e4:dc33 with SMTP id d9443c01a7336-20fa9e48cddmr20814745ad.14.1729655029689;
        Tue, 22 Oct 2024 20:43:49 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0de25bsm49522795ad.231.2024.10.22.20.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 20:43:49 -0700 (PDT)
Date: Wed, 23 Oct 2024 11:43:45 +0800
From: Zorro Lang <zlang@redhat.com>
To: Mark Harmstone <maharmstone@fb.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] generic: add test for missing btrfs csums in log when
 doing async on subpage vol
Message-ID: <20241023034345.nxrd4y7hvv2ncp7e@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241015153957.2099812-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015153957.2099812-1-maharmstone@fb.com>

On Tue, Oct 15, 2024 at 04:39:34PM +0100, Mark Harmstone wrote:
> Adds a test for a bug we encountered on Linux 6.4 on aarch64, where a
> race could mean that csums weren't getting written to the log tree,
> leading to corruption when it was replayed.
> 
> The patches to detect log this tree corruption are in btrfs-progs 6.11.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---
> This is a genericized version of the test I originally proposed as
> btrfs/333.
> 
>  tests/generic/757     | 71 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/757.out |  2 ++
>  2 files changed, 73 insertions(+)
>  create mode 100755 tests/generic/757
>  create mode 100644 tests/generic/757.out
> 
> diff --git a/tests/generic/757 b/tests/generic/757
> new file mode 100755
> index 00000000..6ad3d01e
> --- /dev/null
> +++ b/tests/generic/757
> @@ -0,0 +1,71 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test 757
> +#
> +# Test async dio with fsync to test a btrfs bug where a race meant that csums
> +# weren't getting written to the log tree, causing corruptions on remount.
> +# This can be seen on subpage FSes on Linux 6.4.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick metadata log recoveryloop
> +
> +_fixed_by_kernel_commit e917ff56c8e7 \
> +	"btrfs: determine synchronous writers from bio or writeback control"
> +
> +fio_config=$tmp.fio
> +
> +. ./common/dmlogwrites
> +
> +_require_scratch
> +_require_log_writes
> +
> +cat >$fio_config <<EOF
> +[global]
> +iodepth=128
> +direct=1
> +ioengine=libaio
> +rw=randwrite
> +runtime=1s
> +[job0]
> +rw=randwrite
> +filename=$SCRATCH_MNT/file
> +size=1g
> +fdatasync=1
> +EOF
> +
> +_require_fio $fio_config
> +
> +cat $fio_config >> $seqres.full
> +
> +_log_writes_init $SCRATCH_DEV
> +_log_writes_mkfs >> $seqres.full 2>&1
> +_log_writes_mark mkfs
> +
> +_log_writes_mount

For dmlogwrites test, we generally calls _log_writes_cleanup in _cleanup, to
recover the SCRATCH_DEV anyway, even if this test is killed at the middle of
its testing phase, to avoid later tests failed.

I'll add below code in this case, when I merge it. If there's not objection
from you.

_cleanup()
{
	cd /
	_log_writes_cleanup
	rm -f $tmp.*
}

Thanks,
Zorro

> +
> +$FIO_PROG $fio_config > /dev/null 2>&1
> +_log_writes_unmount
> +
> +_log_writes_remove
> +
> +prev=$(_log_writes_mark_to_entry_number mkfs)
> +[ -z "$prev" ] && _fail "failed to locate entry mark 'mkfs'"
> +cur=$(_log_writes_find_next_fua $prev)
> +[ -z "$cur" ] && _fail "failed to locate next FUA write"
> +
> +while [ ! -z "$cur" ]; do
> +	_log_writes_replay_log_range $cur $SCRATCH_DEV >> $seqres.full
> +
> +	_check_scratch_fs
> +
> +	prev=$cur
> +	cur=$(_log_writes_find_next_fua $(($cur + 1)))
> +	[ -z "$cur" ] && break
> +done
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/757.out b/tests/generic/757.out
> new file mode 100644
> index 00000000..dfbc8094
> --- /dev/null
> +++ b/tests/generic/757.out
> @@ -0,0 +1,2 @@
> +QA output created by 757
> +Silence is golden
> -- 
> 2.44.2
> 
> 


