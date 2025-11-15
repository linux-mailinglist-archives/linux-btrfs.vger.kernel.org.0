Return-Path: <linux-btrfs+bounces-19032-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0FDC6012C
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Nov 2025 08:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CC47135C6DF
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Nov 2025 07:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A74A20298C;
	Sat, 15 Nov 2025 07:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eURXKfUO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cE3O9eZS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A9F2B9A4
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Nov 2025 07:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763192256; cv=none; b=p0BbUGKGpg7q+M0Ds8vV3UltEbdVdBQcY+qucdRKi4mboZZ9lSOWSvehISkPa7yWSx61j1toqQ0lfzvNE4wpG3y31EiPqCDgpbqo01qUELMSSbPAgKRGDJrg6jx6kXNdxynAaf6dJsmzq0IuiWsg5rKpF4XQz2kLpwAb+k/A7O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763192256; c=relaxed/simple;
	bh=Q+EJgoV9OGNkgW6m/Rt5higpv0j5DfYxCG92xNr5Ngc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5X7dlWuUVaK9VIuoNaeoWukdN4TJSPENHNaT6jBVIlZRrqHKWx8paZmPvUBpF0t4+G0oRN3I9EqRgj2Hac1QztMqx7WTg1eClpWm2xpJwsXI/g2c5T5dQXD/ozHlUUVDHpN35qxvIbNK3VxrqMTvTY/E5inHSHA0fsn4bLZYmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eURXKfUO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cE3O9eZS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763192252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bpt7AJNJ29x1IN4z7g8Oew2mK6ZG5cMHvoRNgZWqvX4=;
	b=eURXKfUODhA8i/RtJMJawU70FYhLZFhqABrLpYyHXwAosY42CEkT2E1W3qhzSvsGCgkgAL
	7Kfz01ribElNUb+D98mfUP+x3fQloa/2J7isMmlm+4peCULhASm8OPA7uxCglWeeUuf9hJ
	Gv9H+ghM5wyqS6Q6W5DOy6bI/UEVBjQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-0DghNHkyM7Wjg9o9hSPTQA-1; Sat, 15 Nov 2025 02:37:31 -0500
X-MC-Unique: 0DghNHkyM7Wjg9o9hSPTQA-1
X-Mimecast-MFC-AGG-ID: 0DghNHkyM7Wjg9o9hSPTQA_1763192250
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-297e5a18652so30827695ad.1
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Nov 2025 23:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763192250; x=1763797050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bpt7AJNJ29x1IN4z7g8Oew2mK6ZG5cMHvoRNgZWqvX4=;
        b=cE3O9eZSoESYpfpAgTww4doDkO6jwirzPfzN7KUwETsBjJfui1eK8miB59ZN02HQ/4
         3T0l1AYGJDBCkD6Ro2LWvB2NAXxwBIGzcfEXfKn8IEzorAquMtDie5Vc1LsYcavllhUv
         +9AyEOi5Ya0pCduTB3vbbyseMW4DdpxmAnuq1/NVLEiBDBouBeHKwHg4S1/rxPwHO1/p
         QiJymjI3KxWwAucDS9Rk1Vf9omBJ80UXk4JRExcdrA+HODeZvtOSHGImIhE0949kBdwk
         VoVmzKjXZqimDoqiO80yJ3juIdKZGg0N+5dVyAT6zMcUtRRz1lh4HQAAkCSfgwuqQF/0
         jt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763192250; x=1763797050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpt7AJNJ29x1IN4z7g8Oew2mK6ZG5cMHvoRNgZWqvX4=;
        b=kJiTe1EOj1LxShwsPaJxDaTwsbIpNGalorlsxK+bAqMSrm5yjEaEB0PsAUZljVGWqe
         F4Hd7HBubWb2ee3V1DF6Gin0LZvuJn52c9ix1wm6N9Pe0q5ft5dlMFT7Tkvc0AC32E3g
         uJlRd2hutun4MfmOD45FAXkeY/Y7i38Su5LnOd7tKFHdgIqwEnxS0bk58BDT0Y9ZmK8K
         dDeRNgYXnwLG+iUMq6umAfF8GIsOoLir/II/qdu4yZ+zJhm5CN9lUdn3pBAEma77vq6Z
         MwwUgui2l+elY800Dv6gQIBW5rhXqPwXSTsfVzqR1pJ9bIOnN3IzANBAMMnRiEL1Gf1J
         dXlA==
X-Forwarded-Encrypted: i=1; AJvYcCXoGhZ8IJU8vdiv0NQOlielg+IYGdT47la/3DmMKDNuPUGt6zBOsTXLPQnAMz08FM6aN9rX9ddMGWCFBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoC/5pApYnUGdkvbwinWWOliTrLWoCgPqKehbxlGzW0xzs09ke
	ms5URKksuTE9yDcZOWb9imK646iGN7Dl/moHim3pavjhYSZ1S7UB1LaZEoS8HZmNAEWi89UoRz7
	yN/QsFymtxsGD25ZdRgWn/gsgaJZah9rA9cX8pSJcpxt1OnStBuaiNNjPJf898CzL
X-Gm-Gg: ASbGncunN8v79t8QyV/YLvlxSFvfjL2xWbut6WI35MQ4jraj63sqxpsNgKl7zsZduAX
	BqeRA9PKTxc6BdubwtpTQY5/jvR3isk9ieZQAz10AW4NwKSlAGxCYljRvSk5kGsklmlMb1gkXSb
	G0eGSrDQEPOlNc/yb20jrAhZp3jZX7Du9jBY9ZtyCpJBtjD+zX2Xjia15dQQqlpU6u/g0pt1dUE
	7J4L1eDIN0Dsqa8PLuYgXt6JspaM/oGMZG1c4yXbJUW+3DshSVprJhVgRQS6j0CSkWjRY079FL7
	ODIQGZ/F6eh8dgPVIRNGp2fvqDIbsKuHWkfEFkKgzBUR5+I4Z4kt5PHZfOK7eSlxm3UpV0+ObSm
	vmE4ZKqQxQZ1uhe6f+k+KAWosJhlQkR2sPIVxCk5rZ+mlb05nbA==
X-Received: by 2002:a17:902:ef51:b0:267:a1f1:9b23 with SMTP id d9443c01a7336-2986a6d0e8fmr72746235ad.18.1763192249886;
        Fri, 14 Nov 2025 23:37:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6hQKUeF6Jq+BIeWcwDmoIem2yUQBwotEdn/Us91MrAC17FzqEJUBOiCoK8CdxwDvRH6Wubg==
X-Received: by 2002:a17:902:ef51:b0:267:a1f1:9b23 with SMTP id d9443c01a7336-2986a6d0e8fmr72746025ad.18.1763192249369;
        Fri, 14 Nov 2025 23:37:29 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c23849esm77120015ad.5.2025.11.14.23.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 23:37:28 -0800 (PST)
Date: Sat, 15 Nov 2025 15:37:24 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: test incremental send after deleting directories
 with many hardlinks
Message-ID: <20251115073724.6qgcuijwutisrtu4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <8d1b819511b4c93b5ba0b3137090f5c28a952364.1761844883.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d1b819511b4c93b5ba0b3137090f5c28a952364.1761844883.git.fdmanana@suse.com>

On Thu, Oct 30, 2025 at 05:22:44PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that an incremental send works after we removed directories that have
> large number of hardlinks for the same file (so that we have extrefs).
> 
> This is a regression test for the kernel commit 1fabe43b4e1a ("btrfs:
> send: fix duplicated rmdir operations when using extrefs").
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

This patch is good to me, it can reproduce the bug on v6.18-rc1, then test
passed on v6.18-rc4 (which contains the bug fix). As there's not any review
point/objection from btrfs list after 2 weeks, I'd like to merge this patch
in next fstests release.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/338     | 93 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/338.out |  3 ++
>  2 files changed, 96 insertions(+)
>  create mode 100755 tests/btrfs/338
>  create mode 100644 tests/btrfs/338.out
> 
> diff --git a/tests/btrfs/338 b/tests/btrfs/338
> new file mode 100755
> index 00000000..0cc29c7c
> --- /dev/null
> +++ b/tests/btrfs/338
> @@ -0,0 +1,93 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 SUSE S.A.  All Rights Reserved.
> +#
> +# FS QA Test 338
> +#
> +# Test that an incremental send works after we removed directories that have
> +# large number of hardlinks for the same file (so that we have extrefs).
> +#
> +. ./common/preamble
> +_begin_fstest auto quick send
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -fr $tmp.*
> +	rm -fr $send_files_dir
> +}
> +
> +_require_test
> +_require_scratch
> +_require_fssum
> +
> +_fixed_by_kernel_commit 1fabe43b4e1a \
> +	"btrfs: send: fix duplicated rmdir operations when using extrefs"
> +
> +send_files_dir=$TEST_DIR/btrfs-test-$seq
> +
> +rm -fr $send_files_dir
> +mkdir $send_files_dir
> +
> +first_stream="$send_files_dir/1.send"
> +second_stream="$send_files_dir/2.send"
> +first_fssum="$send_files_dir/snap1.fssum"
> +second_fssum="$send_files_dir/snap2.fssum"
> +
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "first mkfs failed"
> +_scratch_mount
> +
> +# Create two directories which will have many hardlinks for the same file, a
> +# large number that triggers the use of extrefs. This way we will get many
> +# extref items in the subvolume tree, with a very high likelyhood that not
> +# all hardlinks for directory "a" are consecutive in the tree, that they are
> +# interspersed with extref items for hardlinks to directory "b".
> +#
> +# Example:
> +#
> +#        item 0 key (259 INODE_EXTREF 2309449) itemoff 16257 itemsize 26
> +#                index 6925 parent 257 namelen 8 name: foo.6923
> +#        item 1 key (259 INODE_EXTREF 2311350) itemoff 16231 itemsize 26
> +#                index 6588 parent 258 namelen 8 name: foo.6587
> +#        item 2 key (259 INODE_EXTREF 2457395) itemoff 16205 itemsize 26
> +#                index 6611 parent 257 namelen 8 name: foo.6609
> +#        (...)
> +#
> +# Refer to the kernel commit's changelog for more details.
> +mkdir $SCRATCH_MNT/a
> +mkdir $SCRATCH_MNT/b
> +
> +touch $SCRATCH_MNT/a/foo
> +for ((i = 1; i <= 1000; i++)); do
> +	ln $SCRATCH_MNT/a/foo $SCRATCH_MNT/a/foo.$i
> +	ln $SCRATCH_MNT/a/foo $SCRATCH_MNT/b/foo.$i
> +done
> +
> +_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1
> +
> +# Now delete the directories and all the links inside them.
> +rm -fr $SCRATCH_MNT/a
> +rm -fr $SCRATCH_MNT/b
> +
> +_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2
> +
> +_btrfs send -f $first_stream $SCRATCH_MNT/snap1
> +_btrfs send -f $second_stream -p $SCRATCH_MNT/snap1 $SCRATCH_MNT/snap2
> +
> +$FSSUM_PROG -A -f -w $first_fssum $SCRATCH_MNT/snap1
> +$FSSUM_PROG -A -f -w $second_fssum -x $SCRATCH_MNT/snap2/snap1 \
> +	$SCRATCH_MNT/snap2
> +
> +# Create a new fs and apply both send streams.
> +_scratch_unmount
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "second mkfs failed"
> +_scratch_mount
> +
> +_btrfs receive -f $first_stream $SCRATCH_MNT
> +_btrfs receive -f $second_stream $SCRATCH_MNT
> +
> +$FSSUM_PROG -r $first_fssum $SCRATCH_MNT/snap1
> +$FSSUM_PROG -r $second_fssum $SCRATCH_MNT/snap2
> +
> +# success, all done
> +_exit 0
> diff --git a/tests/btrfs/338.out b/tests/btrfs/338.out
> new file mode 100644
> index 00000000..7ea61817
> --- /dev/null
> +++ b/tests/btrfs/338.out
> @@ -0,0 +1,3 @@
> +QA output created by 338
> +OK
> +OK
> -- 
> 2.47.2
> 
> 


