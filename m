Return-Path: <linux-btrfs+bounces-7302-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1299555A2
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Aug 2024 07:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51579285AA5
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Aug 2024 05:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999FA12FB0A;
	Sat, 17 Aug 2024 05:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/5K/yp6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706C2101DE
	for <linux-btrfs@vger.kernel.org>; Sat, 17 Aug 2024 05:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723873993; cv=none; b=WG3+iD8WDfQTVse9ex0hxKcS4g5lI3ubSQ+kO5abJhlimoZ2RBSz5QvI4e46QoTyJFS8TAcIMKB6jFeWHe/DLapPDKF+F5qxa6TWZQZrQ2RAVc59mYjB6aRnY4FrV0xB2P2We99UfbkFtTUpxZ/up6taEDk48kvh5tQdT8nsjhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723873993; c=relaxed/simple;
	bh=ucpncKES4KJw14hD8IfM5Zh+hz3zkHF2ESwrVlipdVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3tNuBCq+gV+CD8JRF+R2yMJom/Exck+e1V4EgNWqS7CgD418qt6EtjtR3mgqMJZxuZEIYhpWezYpPyBJQnunOLfffkFWg70Q2duWqjEtVpKbG5A8f8foV6mfm9QabEk6pCCK0e14Y4Hd74nG1jMfEbVDIMyPaJu7bYjb1xS+ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M/5K/yp6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723873989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qEAXMzXw+X+bVqWar3Yh4pHMhyMCyR0F3kFCLJ3f/CI=;
	b=M/5K/yp6zpv1H70ewRl83olew7pB8BEQi1gvpGLxfbUOnHR17e5YWPE67216P/tycFP5LV
	uhRTK+sPBeplOH9OALPBp1Zb0q+idNRUXZs1YfwLufmXE/H59Qknvf7YOzS6bqpqPFGedu
	cFRQ6Tw9mA01KaF0zi8v1/wfvqlsE0M=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-wo7ELoF9Nc-XAkdzRWsfaA-1; Sat, 17 Aug 2024 01:53:07 -0400
X-MC-Unique: wo7ELoF9Nc-XAkdzRWsfaA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-20201834f25so17393615ad.0
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2024 22:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723873986; x=1724478786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEAXMzXw+X+bVqWar3Yh4pHMhyMCyR0F3kFCLJ3f/CI=;
        b=wn/z4J1uP0JBPd7fZXdfcfDace8/ToGscnkPJj8n1WeBgiSldG9PBu+iuPFB2UMU3l
         +Zr1w5J/qoPJ4h+9AxuecTZR+pMe8l5lw+onjw0UgLL/+gDpcR0IM17KbX3LVuzNGJGh
         oXwBqjKIKmMNOU4LKiFUYupRnqkeohBdoV+zj7hveSyhukkVZLjyXeR1CldXszikM2Yr
         LSVlZO5s3sqPgVt3SlMdPuh92F2LRXx6HOglYhsco7UCRCi2dyiIwKhtKQw8ODwF4qh9
         ckBGR/1+JU0Sal2vSnZiZYJnyd2icctvSjGpbdepREtIeMmNjgfLnsPDPRk1Aiu1pSXf
         9Z9w==
X-Forwarded-Encrypted: i=1; AJvYcCXLpUb9Zz3drm9Cd17stjuLU3hdlOnJDY1De0YLzPdXEcDfq4S/S6Jlu06Dk0/aKUUuFDhMM6Wjva/HRA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMv8x3A2ZbujpgOqNla2zJSWA3CaCX2x4cog6ZAJcmzuff1E4u
	ALV/eOvKbcGYRlyzieKt02Eft471M25Hr1Y3heIXSfulR/M2eSsVgr5iTrMv6EegVkMT/YjSyfu
	PNFk+sJylsFWDFeW6g+a7Y8Yih/CKdh+HIdS+Hsket7F/hpfK6ePfDdQN+2Ig
X-Received: by 2002:a17:902:cec1:b0:201:ef87:9535 with SMTP id d9443c01a7336-20203e4c9c5mr60765415ad.3.1723873986528;
        Fri, 16 Aug 2024 22:53:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGuk3QzJCQcRlqzVWBZVy+LeAY9P0SxB7zFNl7Ztatybb0uNMFCyCw+wg/pN8dVnNZd8v3Bw==
X-Received: by 2002:a17:902:cec1:b0:201:ef87:9535 with SMTP id d9443c01a7336-20203e4c9c5mr60765195ad.3.1723873985801;
        Fri, 16 Aug 2024 22:53:05 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f037aeadsm33509125ad.138.2024.08.16.22.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 22:53:05 -0700 (PDT)
Date: Sat, 17 Aug 2024 13:53:01 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH fstests] generic/755: test that inode's ctime is updated
 on unlink
Message-ID: <20240817055301.nisxjdvue6lasois@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240813-master-v1-1-862678cc4000@kernel.org>
 <20240816125557.yu7664riqf4gvckl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <0fc76e7d49e8523d00f54fd5b50f24f040e7cf70.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fc76e7d49e8523d00f54fd5b50f24f040e7cf70.camel@kernel.org>

On Fri, Aug 16, 2024 at 08:58:28AM -0400, Jeff Layton wrote:
> On Fri, 2024-08-16 at 20:55 +0800, Zorro Lang wrote:
> > On Tue, Aug 13, 2024 at 02:21:08PM -0400, Jeff Layton wrote:
> > 
> > Hi Jeff :)
> > 
> > Any description about this case test for?
> > 
> 
> Yes. I should have put that info in the commit. Can you add it if the
> patch otherwise looks OK?
> 
>     https://lore.kernel.org/linux-btrfs/20240812-btrfs-unlink-v1-1-ee5c2ef538eb@kernel.org/

Hi Jeff,

I saw this patch has gotten 3 RVBs, it's going to be in btrfs tree.
I think it's good enough. BTW, you can add "_fixed_by_kernel_commit"
to the test case, see below tests/generic/755 ...

By reading above link, I think this issue doesn't need a C program (to
reproduce), it can be done in bash script. e.g.

# touch file
# link file linkfile
# ctime1=$(stat -c %Z file)
# sleep 2
# ctime2=$(stat -c %Z file)
# if [ "$ctime1" == "$ctime2" ];then ....

Does that make sense to you?

> 
> Thanks,
> 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > > HCH suggested I roll a fstest for this problem that I found in btrfs the
> > > other day. In principle, we probably could expand this to other dir
> > > operations and to check the parent timestamps, but having to do all that
> > > in C is a pain.  I didn't see a good way to use xfs_io for this,
> > > however.
> > 
> > Is there a kernel commit or patch link about the bug which you found?
> > 
> > > ---
> > >  src/Makefile          |  2 +-
> > >  src/unlink-ctime.c    | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  tests/generic/755     | 26 ++++++++++++++++++++++++++
> > >  tests/generic/755.out |  2 ++
> > >  4 files changed, 79 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/src/Makefile b/src/Makefile
> > > index 9979613711c9..c71fa41e4668 100644
> > > --- a/src/Makefile
> > > +++ b/src/Makefile
> > > @@ -34,7 +34,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
> > >  	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
> > >  	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
> > >  	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
> > > -	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault
> > > +	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault unlink-ctime
> > 
> > The .gitignore need updating too.

[need changing]

> > 
> > >  
> > >  EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
> > >  	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
> > > diff --git a/src/unlink-ctime.c b/src/unlink-ctime.c
> > > new file mode 100644
> > > index 000000000000..7661e340eaba
> > > --- /dev/null
> > > +++ b/src/unlink-ctime.c
> > > @@ -0,0 +1,50 @@
> > > +#define _GNU_SOURCE 1
> > > +#include <stdio.h>
> > > +#include <fcntl.h>
> > > +#include <unistd.h>
> > > +#include <errno.h>
> > > +#include <sys/stat.h>
> > > +
> > > +int main(int argc, char **argv)
> > > +{
> > > +	int fd, ret;
> > > +	struct statx before, after;
> > > +
> > > +	if (argc < 2) {
> > > +		fprintf(stderr, "Must specify filename!\n");
> > > +		return 1;
> > > +	}
> > > +
> > > +	fd = open(argv[1], O_RDWR|O_CREAT, 0600);
> > > +	if (fd < 0) {
> > > +		perror("open");
> > > +		return 1;
> > > +	}
> > > +
> > > +	ret = statx(fd, "", AT_EMPTY_PATH, STATX_CTIME, &before);
> > > +	if (ret) {
> > > +		perror("statx");
> > > +		return 1;
> > > +	}
> > > +
> > > +	sleep(1);
> > > +
> > > +	ret = unlink(argv[1]);
> > > +	if (ret) {
> > > +		perror("unlink");
> > > +		return 1;
> > > +	}
> > > +
> > > +	ret = statx(fd, "", AT_EMPTY_PATH, STATX_CTIME, &after);
> > 
> > So you need to keep the "fd" after unlink. If so, there might not be a
> > way through xfs_io to do that.
> > 
> > > +	if (ret) {
> > > +		perror("statx");
> > > +		return 1;
> > > +	}
> > > +
> > > +	if (before.stx_ctime.tv_nsec == after.stx_ctime.tv_nsec &&
> > > +	    before.stx_ctime.tv_sec == after.stx_ctime.tv_sec) {
> > > +		printf("No change to ctime after unlink!\n");
> > > +		return 1;
> > > +	}
> > > +	return 0;
> > > +}
> > > diff --git a/tests/generic/755 b/tests/generic/755
> > > new file mode 100755
> > > index 000000000000..500c51f99630
> > > --- /dev/null
> > > +++ b/tests/generic/755
> > > @@ -0,0 +1,26 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2024, Jeff Layton <jlayton@kernel.org>
> > > +#
> > > +# FS QA Test No. 755
> > > +#
> > > +# Create a file, stat it and then unlink it. Does the ctime of the
> > > +# target inode change?
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick
> >                              ^^^^^^
> >                              unlink

[need changing]

> > 
> > > +
> > > +# Import common functions.
> > > +. ./common/filter
> > > +. ./common/dmerror
> > 
> > Why dmerror and filter are needed? If not necessary, remove these
> > 3 lines.

[need changing]

> > 
> > Others looks good to me.
> > 
> > Thanks,
> > Zorro
> > 
> > > +
> > > +_require_test
> > > +_require_test_program unlink-ctime

  _fixed_by_kernel_commit XXXXXXXXXXXX btrfs: update target inode's ctime on unlink

> > > +
> > > +testfile="$TEST_DIR/unlink-ctime.$$"
> > > +
> > > +$here/src/unlink-ctime $testfile
> > > +
> > > +echo Silence is golden
> > > +status=0
> > > +exit
> > > diff --git a/tests/generic/755.out b/tests/generic/755.out
> > > new file mode 100644
> > > index 000000000000..7c9ea51cd298
> > > --- /dev/null
> > > +++ b/tests/generic/755.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 755
> > > +Silence is golden
> > > 
> > > ---
> > > base-commit: f5ada754d5838d29fd270257003d0d123a9d1cd2
> > > change-id: 20240813-master-e3b46de630bd
> > > 
> > > Best regards,
> > > -- 
> > > Jeff Layton <jlayton@kernel.org>
> > > 
> > > 
> > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
> 


