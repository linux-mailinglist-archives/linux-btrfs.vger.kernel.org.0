Return-Path: <linux-btrfs+bounces-2343-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06114852796
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 03:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251711C2333E
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 02:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988668C0A;
	Tue, 13 Feb 2024 02:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lL0HaWnq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Bi6DgzAR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lL0HaWnq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Bi6DgzAR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E746033E1;
	Tue, 13 Feb 2024 02:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707792634; cv=none; b=GGZVuFGeZgbT6VSA/1GYN7Um1OyIKv9kVUhVQDQ6bfozlUB59vZ+nrZ59QafTSwLYkJALSr9iGH9DGyHXoj+WkdDm7n5JvYcYkQJWGritI0ipfLHGLRYCndce1dv8tlQQqx/028oaB3WpAt1i+86ZlgOt5vDd1ia+4NBsCoBDCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707792634; c=relaxed/simple;
	bh=Vcc54earIgvf0w6waO07JJ0sf3udChEo+ekXR94uu2E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=II9sUB5lm8om4ptcQudW7cxW5YJwGZxjUYaHSyy4fONd4+4Z3a46XRND9FvVnVYNcZVWHt2Hg7we6p1dP3ot9q4NXYj/1KqzLaqAUbmasanDjpbnO4NzU9CotRc+1gndhN2VTXdFso840Y2T215tP8hI9uGNXDEOOw3RpLkA1PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lL0HaWnq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Bi6DgzAR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lL0HaWnq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Bi6DgzAR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 074FF21F98;
	Tue, 13 Feb 2024 02:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707792631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+UuvQ+15J37NeUHJ9eokBs09fcWQJd9zZwRgJDvEuGY=;
	b=lL0HaWnqUUC5Kja25lYHp0/vxYlZEY4SHvFwNqJuK+K3wdqJS7o0Cv6xzBraaw5IY9W2px
	tQchEFT9MEYbaS11Tk5y45eVjOIpJ7B9059RgfxbR/faJzoiPAnwFSseRPWfEv5+GaFnsy
	DGE7yDWFECXdG7fU3mKR2nv4r2yNVqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707792631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+UuvQ+15J37NeUHJ9eokBs09fcWQJd9zZwRgJDvEuGY=;
	b=Bi6DgzARluHp01xKHbdarbib41PTIv68wVPhsnajTnP77cK8UhzXx6xpoWbkKN2i1oE4KV
	BatjOJNxDNYsKNBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707792631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+UuvQ+15J37NeUHJ9eokBs09fcWQJd9zZwRgJDvEuGY=;
	b=lL0HaWnqUUC5Kja25lYHp0/vxYlZEY4SHvFwNqJuK+K3wdqJS7o0Cv6xzBraaw5IY9W2px
	tQchEFT9MEYbaS11Tk5y45eVjOIpJ7B9059RgfxbR/faJzoiPAnwFSseRPWfEv5+GaFnsy
	DGE7yDWFECXdG7fU3mKR2nv4r2yNVqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707792631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+UuvQ+15J37NeUHJ9eokBs09fcWQJd9zZwRgJDvEuGY=;
	b=Bi6DgzARluHp01xKHbdarbib41PTIv68wVPhsnajTnP77cK8UhzXx6xpoWbkKN2i1oE4KV
	BatjOJNxDNYsKNBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6683013A0B;
	Tue, 13 Feb 2024 02:50:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id L+sLBvXYymWSVQAAn2gu4w
	(envelope-from <ddiss@suse.de>); Tue, 13 Feb 2024 02:50:29 +0000
Date: Tue, 13 Feb 2024 13:50:19 +1100
From: David Disseldorp <ddiss@suse.de>
To: Josef Bacik <josef@toxicpanda.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] fstests: add a regression test for fiemap into an
 mmap range
Message-ID: <20240213135019.24c3c595@echidna>
In-Reply-To: <b8160b6dbaf4899ff95928a7af006a126baa8f9c.1707756045.git.josef@toxicpanda.com>
References: <b8160b6dbaf4899ff95928a7af006a126baa8f9c.1707756045.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

On Mon, 12 Feb 2024 11:41:14 -0500, Josef Bacik wrote:

> Btrfs had a deadlock that you could trigger by mmap'ing a large file and
> using that as the buffer for fiemap.  This test adds a c program to do
> this, and the fstest creates a large enough file and then runs the
> reproducer on the file.  Without the fix btrfs deadlocks, with the fix
> we pass fine.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

With a .gitignore entry added for the fiemap-fault binary:
Revewed-by: David Disseldorp <ddiss@suse.de>

A few other minor nits below...

> ---
> v1->v2:
> - Add the fiemap group to the test.
> - Actually include the reproducer helper program.
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
> diff --git a/src/Makefile b/src/Makefile
> index d79015ce..916f6755 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -34,7 +34,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
>  	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
>  	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
> -	uuid_ioctl
> +	uuid_ioctl fiemap-fault

Nit: FWIW, this hunk collides with 3a0381a4 ("btrfs: test snapshotting a
deleted subvolume")

>  EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
>  	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
> diff --git a/src/fiemap-fault.c b/src/fiemap-fault.c
> new file mode 100644
> index 00000000..27081188
> --- /dev/null
> +++ b/src/fiemap-fault.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
> + */
> +
> +#include <sys/ioctl.h>
> +#include <sys/mman.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <linux/fs.h>
> +#include <linux/types.h>
> +#include <linux/fiemap.h>
> +#include <err.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <unistd.h>
> +
> +int prep_mmap_buffer(int fd, void **addr)
> +{
> +	struct stat st;
> +	int ret;
> +
> +	ret = fstat(fd, &st);
> +	if (ret)
> +		err(1, "failed to stat %d", fd);
> +
> +	*addr = mmap(NULL, st.st_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
> +	if (*addr == MAP_FAILED)
> +		err(1, "failed to mmap %d", fd);
> +
> +	return st.st_size;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	struct fiemap *fiemap;
> +	size_t sz, last = 0;
> +	void *buf = NULL;
> +	int ret, fd;
> +
> +	if (argc != 2)
> +		errx(1, "no in and out file name arguments given");
> +
> +	fd = open(argv[1], O_RDWR, 0666);
> +	if (fd == -1)
> +		err(1, "failed to open %s", argv[1]);
> +
> +	sz = prep_mmap_buffer(fd, &buf);
> +
> +	fiemap = (struct fiemap *)buf;
> +	fiemap->fm_flags = 0;
> +	fiemap->fm_extent_count = (sz - sizeof(struct fiemap)) /
> +				  sizeof(struct fiemap_extent);
> +
> +	while (last < sz) {
> +		int i;
> +
> +		fiemap->fm_start = last;
> +		fiemap->fm_length = sz - last;
> +
> +		ret = ioctl(fd, FS_IOC_FIEMAP, (unsigned long)fiemap);
> +		if (ret < 0)
> +			err(1, "fiemap failed %d (%s)", errno, strerror(errno));

Nit: err() should already append the strerror() string.

> +		for (i = 0; i < fiemap->fm_mapped_extents; i++)
> +		       last = fiemap->fm_extents[i].fe_logical +
> +			       fiemap->fm_extents[i].fe_length;
> +	}
> +
> +	close(fd);
> +	return 0;
> +}
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

Test 740

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
> +
> +$here/src/fiemap-fault $dst > /dev/null || _fail "failed doing fiemap"

Nit: the error paths print errors, so the explicit _fail should be
unnecessary, or you could turn it into an echo.

> +
> +rm -f $dst
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


