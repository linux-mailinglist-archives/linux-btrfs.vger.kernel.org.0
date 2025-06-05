Return-Path: <linux-btrfs+bounces-14481-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A43F5ACF3B3
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 18:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DDC316C4B4
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 16:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511F0201278;
	Thu,  5 Jun 2025 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/sYpbdb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71481E7648
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 16:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749139449; cv=none; b=tvekJr3qaCtVX0Nx1Pulxzr6yGSMaQEf5oK2kfn5mYoVAKTi5q33Y6FEoCt/lZKShpJRW/j6XZND4HXjCKwv4XNLG+57W5IsN9jm9U6uP0obcV8IkuqFEPp6YDUBZ/UoyzksK8zUHfbS26G39YffT+UN20wIL0RonTZqF/mD0TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749139449; c=relaxed/simple;
	bh=1ZMYrUk6oQdoHZ84Une2mz68SYT78oTigBcDVF884Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dc5CTndZFaY+sZjhKjEz/tpcNNawx8Wgj5hMjwkqdDq4i4CkVUbPCmO5GXzRUo2JCpCRCrZhTKi4vA9ii8TOh/Iq9k8OBich7YiuwyHBBoC04f0rrL2FFKs18HIdkbCQesnnqqKzzNAjsrEWUyzkDj1SP8u2btNSbC09tvI6l/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B/sYpbdb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749139446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=il46EU6GFqNY2CbsWo+TEQFeQB0q8ljPTVtEK/gjjWI=;
	b=B/sYpbdbtan0T7ZR11oe9qwqQqOaXUPF7pRnAmEAFofuQJKT/vzJQG712PbKuQwgCk9u6n
	opaeOGKP2bu1WgKt2wqb3WQUj6AmwS4KEi1v0IzPlunhg3pvjkYm0musNssc/AYG0U3Aib
	FS24bYhPt2oIxTHYc7YScQHYj7eOxRI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-hf03tB15NFuMHQf0sba6oQ-1; Thu, 05 Jun 2025 12:04:05 -0400
X-MC-Unique: hf03tB15NFuMHQf0sba6oQ-1
X-Mimecast-MFC-AGG-ID: hf03tB15NFuMHQf0sba6oQ_1749139444
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-235e3f93687so17212505ad.2
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Jun 2025 09:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749139444; x=1749744244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=il46EU6GFqNY2CbsWo+TEQFeQB0q8ljPTVtEK/gjjWI=;
        b=gsRfnRors2dGJ/gcvRPuolNrl5mEP54tlNSajSv7nLfmHu4sdfNuOCpgj/trhrv3an
         vPk5r+KT2yg3UF7B0CvIHs3Y4t9qIwy/M87jDBbpgZFj2T2VsWyrlM9BL+QjRrTm+ou/
         SvCt/aUoLRyxjGkWPi5RMQH3mMLhpFJWZfICn7sn7XDfPs22R7PmFCVaSMvi+5h/oUQh
         QFYgigGKDg3JVLAq1U8GFAX6xTUAngBii63yFN/rfuvKzubRPZloP14vX3RwP4V1Z0cS
         W2waG12/GGNpDVYf10kGLsom6kVQxbYdFIv/DlriwCgqJVgC4O+RD3biJSLqRYdWrbdl
         7ADQ==
X-Forwarded-Encrypted: i=1; AJvYcCW09J1NVptTnXY2C9992rFDyMtvsfajioj+3kZnWrPJAq07u2DnyliiJ2XgzZ4Q+kkLpUnRR16st6FLFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjO5s6WcoQijl/OA8IzdZv2PyghwjfCKptVj/Z2Wr9WCwVEeUs
	pyD6F5b43sgrkmxNSu0GFjfFqY2g9BgHQk9QEZCoE++qdB3SBzF06xluzxK8EjUtI8xLaLJtvzG
	AVvUA0iVj53MYZaKNdRmw12u15EU92BSbecJvhlxAkJA8ClldOrW/yOUqS6Ir8o3q
X-Gm-Gg: ASbGncsDSBXUJ+IUXGhl8GmA08vM50F1n5C35B/z3N82XMet9Iz08iffzPmGg+Sfa77
	3JqoAexZLaADhOgNcR/k+NDMa4Fs1UeIxIIT95kk3P2p/fS0ES41WS5Ne2xBV3xlnSArc93wqTb
	ShrlKgUDqpNda1++VdasBIIx1wUd+qd8F1YsKR6vQg5CCz9yLamn/1U7w3V5S+s7m9Ib3KLBpDF
	pSwWYPouRWJl8r5oIU1XUXQZvGnoRuuWk0gPuwOemZCCk401tp+BOMX2h8vLTm1T1MthRQw89db
	Bx67ABefC+JFndvsbCzL47ixbhWYFaXY8VyvChd3xmjQmglrJ3aN
X-Received: by 2002:a17:903:2f85:b0:235:ecf2:397 with SMTP id d9443c01a7336-235ecf20ecemr74123495ad.33.1749139444431;
        Thu, 05 Jun 2025 09:04:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdCJEykVbcD5HaKtvN7OCNa3pPRicn1BpDHm8htfAy3SkEAt9RKtETG4E4kitKlE9Pv2uZNA==
X-Received: by 2002:a17:903:2f85:b0:235:ecf2:397 with SMTP id d9443c01a7336-235ecf20ecemr74123055ad.33.1749139444019;
        Thu, 05 Jun 2025 09:04:04 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506d14a85sm121578835ad.232.2025.06.05.09.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 09:04:03 -0700 (PDT)
Date: Fri, 6 Jun 2025 00:03:59 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] fstests: add kernel commit IDs to some tests
Message-ID: <20250605160359.xjo35wqku67yblsw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <df0a4c7749812f3dec49c2ec05c6da5c7b7e822f.1748517133.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df0a4c7749812f3dec49c2ec05c6da5c7b7e822f.1748517133.git.fdmanana@suse.com>

On Thu, May 29, 2025 at 12:13:41PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The kernel fixes exercised by some tests have already landed in Linus'
> tree, so update the tests with the respective commit IDs.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Thanks for this update.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/f2fs/011    | 2 +-
>  tests/generic/370 | 2 +-
>  tests/generic/761 | 3 ++-
>  tests/generic/764 | 2 +-
>  4 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/f2fs/011 b/tests/f2fs/011
> index ec3d39ec..c21cb586 100755
> --- a/tests/f2fs/011
> +++ b/tests/f2fs/011
> @@ -23,7 +23,7 @@ _begin_fstest auto quick
>  
>  _fixed_by_kernel_commit 48ea8b200414 \
>  	"f2fs: fix to avoid panic once fallocation fails for pinfile"
> -_fixed_by_kernel_commit xxxxxxxxxxxx \
> +_fixed_by_kernel_commit f7f8932ca6bb \
>  	"f2fs: fix to avoid running out of free segments"
>  
>  _require_scratch
> diff --git a/tests/generic/370 b/tests/generic/370
> index cbc18644..d9ba6c57 100755
> --- a/tests/generic/370
> +++ b/tests/generic/370
> @@ -21,7 +21,7 @@ _cleanup()
>  
>  [ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 03018e5d8508 \
>      "btrfs: fix swap file activation failure due to extents that used to be shared"
> -[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit XXXXXXXXXXXX \
> +[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 2d873efd174b \
>  	"xfs: flush inodegc before swapon"
>  
>  _require_scratch_swapfile
> diff --git a/tests/generic/761 b/tests/generic/761
> index 9406a4b8..bd7b02a9 100755
> --- a/tests/generic/761
> +++ b/tests/generic/761
> @@ -18,7 +18,8 @@ _begin_fstest auto quick
>  _require_scratch
>  _require_odirect
>  _require_test_program dio-writeback-race
> -_fixed_by_kernel_commit XXXXXXXX \
> +
> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 968f19c5b1b7 \
>  	"btrfs: always fallback to buffered write if the inode requires checksum"
>  
>  _scratch_mkfs > $seqres.full 2>&1
> diff --git a/tests/generic/764 b/tests/generic/764
> index 1b21bc02..55937fc0 100755
> --- a/tests/generic/764
> +++ b/tests/generic/764
> @@ -20,7 +20,7 @@ _cleanup()
>  
>  . ./common/dmflakey
>  
> -[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 5e85262e542d \
>  	"btrfs: fix fsync of files with no hard links not persisting deletion"
>  
>  _require_scratch
> -- 
> 2.47.2
> 
> 


