Return-Path: <linux-btrfs+bounces-3253-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C7C87AAB2
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 16:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FBCCB20994
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 15:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5830482F4;
	Wed, 13 Mar 2024 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXmdCOyp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0310482C6;
	Wed, 13 Mar 2024 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710344936; cv=none; b=hUGh+9eOGq8yljvxEy6u/lGk0N7xYephmT+f5JaJ5/rKzPdo9ZMkGS+kfwBCZHBgZifQhvbdljmNrekhaSKQfek2MyowLJjSmoUJ8+Py/DSQP42ZEcw+uuQYPo1mWjpJXq2cq3t6WbkFz10EsImdo+vxXDmFf+6M0Kwoyz4QVe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710344936; c=relaxed/simple;
	bh=x4+zOtr5QIQnyLDUROboSTD0YW2zdJ79gzflG722yfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbp9mlE7qCxMzJH4PztF05iq+sOkXSpnflnAOwJ0xwYp5wTwE1nlbyGoZQzgr6i5C+7vHSXh92cn0Oj4e8g+S8J6UarjECyXXG/68cJd1jiFPhoZpq54a/ydTe0s9D41XVOweNKlsbnDRnU5+F0mWVia9Wv7C/Bu26WRYUO78MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXmdCOyp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EDFC433C7;
	Wed, 13 Mar 2024 15:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710344936;
	bh=x4+zOtr5QIQnyLDUROboSTD0YW2zdJ79gzflG722yfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LXmdCOypsTbUfZeyFZIH+mRe4m3G3D6fqG1k3RIE53j7JiJ0d8CQ4rohYuS0Jj8Rv
	 fl+1s+Dg/+09/MlPWtkqvxE0R6WG2vmxQVRnOap1C0aktchwmXSfXgYX13ODQpLWnk
	 re3awdFjTp1+T8s+KBkd5+i/RN0hXsD+lFOwdwfE5N8dNtCqqTyjj9ma5SEFQaPUcF
	 nMx77vXQ3xvaDAHzy5S0s2F4xL7XGU3ZtIBCYxXRFR2pLnBe53GmUkbQH3/95B/NPp
	 ld6FhuipZG2ZrpN8jbFNaoneeZQcLt4oFbRgst7z1rKSpQKK/OZScpaKqaVqT3XlVr
	 T/kRd2GpfrB/A==
Date: Wed, 13 Mar 2024 23:48:51 +0800
From: Zorro Lang <zlang@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] fstests: add a regression test for fiemap into an
 mmap range
Message-ID: <20240313154851.zvawwfmoufhdwtel@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <b8160b6dbaf4899ff95928a7af006a126baa8f9c.1707756045.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8160b6dbaf4899ff95928a7af006a126baa8f9c.1707756045.git.josef@toxicpanda.com>

On Mon, Feb 12, 2024 at 11:41:14AM -0500, Josef Bacik wrote:
> Btrfs had a deadlock that you could trigger by mmap'ing a large file and
> using that as the buffer for fiemap.  This test adds a c program to do
> this, and the fstest creates a large enough file and then runs the
> reproducer on the file.  Without the fix btrfs deadlocks, with the fix
> we pass fine.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v1->v2:
> - Add the fiemap group to the test.
> - Actually include the reproducer helper program.

Looks like this patch is missed (except the author changed the patch subject:),
correct me if I'm wrong. The last review point hoped to add "src/fiemap-fault"
to .gitignore.

> 
>  src/Makefile          |  2 +-
>  src/fiemap-fault.c    | 73 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/740     | 41 ++++++++++++++++++++++++
>  tests/generic/740.out |  2 ++
>  4 files changed, 117 insertions(+), 1 deletion(-)
>  create mode 100644 src/fiemap-fault.c
>  create mode 100644 tests/generic/740
>  create mode 100644 tests/generic/740.out
> 

[snip]

> diff --git a/tests/generic/740 b/tests/generic/740
> new file mode 100644
> index 00000000..30ace1dd
> --- /dev/null
> +++ b/tests/generic/740
> @@ -0,0 +1,41 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 708
> +#
> +# Test fiemap into an mmaped buffer of the same file
> +#
> +# Create a reasonably large file, then run a program which mmaps it and uses
> +# that as a buffer for an fiemap call.  This is a regression test for btrfs
> +# where we used to hold a lock for the duration of the fiemap call which would
> +# result in a deadlock if we page faulted.
> +#
> +. ./common/preamble
> +_begin_fstest quick auto fiemap
> +[ $FSTYP == "btrfs" ] && \
> +	_fixed_by_kernel_commit xxxxxxxxxxxx \

This commit id is "b0ad381fa769" now.

> +		"btrfs: fix deadlock with fiemap and extent locking"
> +
> +# real QA test starts here
> +_supported_fs generic
> +_require_test
> +_require_odirect
> +_require_test_program fiemap-fault
> +dst=$TEST_DIR/fiemap-fault-$seq
> +
> +echo "Silence is golden"
> +
> +for i in $(seq 0 2 1000)
> +do
> +	$XFS_IO_PROG -d -f -c "pwrite -q $((i * 4096)) 4096" $dst
> +done

_require_sparse_files ?

> +
> +$here/src/fiemap-fault $dst > /dev/null || _fail "failed doing fiemap"
> +
> +rm -f $dst

If you'd like to remove this file, do it in _cleanup(), e.g.

_cleanup()
{
	rm -f $dst
	cd /
	rm -r -f $tmp.*
}

Could you rebase this patch on latest fstests for-next branch with above
changes, then send a V2 please? I'd like to have this patch in next fstests
release.

Thanks,
Zorro

> +
> +# success, all done
> +status=$?
> +exit
> +
> diff --git a/tests/generic/740.out b/tests/generic/740.out
> new file mode 100644
> index 00000000..3f841e60
> --- /dev/null
> +++ b/tests/generic/740.out
> @@ -0,0 +1,2 @@
> +QA output created by 740
> +Silence is golden
> -- 
> 2.43.0
> 
> 

