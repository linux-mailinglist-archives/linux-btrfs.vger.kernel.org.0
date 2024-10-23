Return-Path: <linux-btrfs+bounces-9084-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739EF9ABC7B
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 05:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FCE1B21FE7
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 03:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBE0137776;
	Wed, 23 Oct 2024 03:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mi4KGDZA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC632AD20
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2024 03:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729655591; cv=none; b=Q0gpNR7XlPM4x3N7514GML0KdUVxuAyjJCtGfFLQjBqLEH+78FrbKTGbF52TaIN5J3LeEd4W2L0B4mzhLqv7TwRhO8AzhEQKsjjHXc41+bpHMswgS53cL1jJ07cAUeZh6uLbRdDkNcny0wSwNsMQVgNBzrqDPPAlB+xwY2l5JL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729655591; c=relaxed/simple;
	bh=x9Q9P1jcFOedVLmQygOV3TsI9HAfkG7xnhoSSc4vbw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ti2LQ2lLnHvaRIgdFUt4DzcfMy75thZe/cdvONA9KNzGHg9Ld3MA3nA9Xl0KorFboi3imL+mRQ8eA9vRvCtuJJcqqgrgtV8JIup+BVobF04IwZ77yIwe/JbN01MOQnwKS67Uxde39zzXPDOxlMJHSq5bkU7oCgQwkoDvzVjRjNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mi4KGDZA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729655588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qtNT+qtypMH7i1sLJxi3tnaKJ//hw1RtU8th0A1zkI4=;
	b=Mi4KGDZAcOCz4xlj5nPzb+mt64y2LR2wDT2asz/wlG8F+cPIezQlFVdFwmVo6/7zMvegMT
	aCeMEyo8itKNfbLlpgoPNFZ67vpJTUrk0q6zY9z+k6cMUywM4bGyT1kSx6s6Ky8KDoC6tg
	siImZRcNKkhVwVQv8qnPzARpFHNNv+8=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-5keIav3YOo2YxBh2EBz_nA-1; Tue, 22 Oct 2024 23:53:07 -0400
X-MC-Unique: 5keIav3YOo2YxBh2EBz_nA-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-71e6a7f3b67so7362187b3a.3
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 20:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729655585; x=1730260385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtNT+qtypMH7i1sLJxi3tnaKJ//hw1RtU8th0A1zkI4=;
        b=QD/24KUEjg8NK+yO8BFZmvAiWEPtbSOtLKcgGjJ7EFfMZVkuBbSgNC4jRfcoCRhvTZ
         JzmUhF2DYwLpgn0paS85Na4+YpJA6evKKFh16QZ9OEu4NbRbf0Zf0YfvBmQzw3AC4kNm
         Dgx8JCbCb3QeBqMn+akZXi7TbnvNoK3FjmgwjRRQtEwsqHHMuSBDGRGF0jiY9WfisQUk
         VgQjrD9PbbHKmB2RMOmNlfPh4/HUJTVVzwWCrGMWfRpI6MN3fZlIvEby3ySGtXjw4vBD
         EjYBixCnVaDZCrU+z348lR6FPDN9p3D/PPA9uSYxh9SpVJwuLK1grDDXTDPjzNg4lUNx
         1npw==
X-Forwarded-Encrypted: i=1; AJvYcCWMtfBA9QbvzLLLZEOUnUK7wAisX7sef9BvOFrgjcxAH+KrMJBNUpKRpT0o4mKVpmYXuHJb44i5sIO4qg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx485yw3TLIaypJXAyuRBILOmXba/6wW95ee90ajiSphn28auNS
	wB0168WL5qkZarJpkJ45EFgupIrnRShxbaxD1RzTLf+/iTmmKhPxGbi0wYmQy5bQYOmJIvnQsVP
	K/mCeAsSaJQLbOEurIls0LqSlL8lyp6zYYEHj4HnesVDinCK+2wCtRPHoleWvDaKBfKk7YMg=
X-Received: by 2002:a05:6a21:6b0b:b0:1d8:a13d:723d with SMTP id adf61e73a8af0-1d978bae5d1mr1389715637.31.1729655585685;
        Tue, 22 Oct 2024 20:53:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGE8iOLDtC5/BgrSqF0DGt/0TECa+ChMUGy75/TPv20YxMYrrxzzOzmlrGY6e1AYX8+52iDxQ==
X-Received: by 2002:a05:6a21:6b0b:b0:1d8:a13d:723d with SMTP id adf61e73a8af0-1d978bae5d1mr1389701637.31.1729655585313;
        Tue, 22 Oct 2024 20:53:05 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13355casm5428779b3a.59.2024.10.22.20.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 20:53:05 -0700 (PDT)
Date: Wed, 23 Oct 2024 11:53:01 +0800
From: Zorro Lang <zlang@redhat.com>
To: Mark Harmstone <maharmstone@fb.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] generic: add test for missing btrfs csums in log when
 doing async on subpage vol
Message-ID: <20241023035301.due7yoel6muwvmec@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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

Sorry, more review points below. I can help to change these if you say "yes"
to all :)

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
                                                      ^^^
                                                      aio

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

_require_aiodio ?

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
> +
> +$FIO_PROG $fio_config > /dev/null 2>&1

Don't you care the output of fio running anymore? Maybe use > $seqres.full ?

And just make sure, do you want to ignore failures of fio, as you do "2>&1"?

Thanks,
Zorro

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


