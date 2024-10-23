Return-Path: <linux-btrfs+bounces-9085-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAD29ABC99
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 06:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE741C2234D
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 04:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4A813C9CF;
	Wed, 23 Oct 2024 04:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HumlfwCD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0E23A1BA
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2024 04:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729656760; cv=none; b=Q0N1jnYW0w1vmQ7Y44VKLRWej3aBFINiavewY3mopFaID1Kpae35LbnMA39SIb2DojqRgb9MODy+8SvQguT+1Gm8EKFHIYQLUkJP1GQrV9VAkZmOMOwQVp+MQuTJX+GgSVb54yRc8knioOv45srA8mdxUrvc5S2SWLCQgpbCKGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729656760; c=relaxed/simple;
	bh=ly+gAL6FWqxVw1uhSK12MfSlG2GA1IdyXowrlEudL9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yd8+5lKwd/tOYaV1mhe8svozeQgHiEsS/MWupUdNmF/UrsrfCyP7V7GHD8aYKP9x8+Li1328nCmx8zUocPZBKXCSALlqRAP/+9F4pJp4ib6fMxrwZ+5c8uRUqrXePsNPMl8PS0453IE2hzBG6OmzwIMMmFN03Bi88XhQUPUM0aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HumlfwCD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729656757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+37vG64ySEsAwS8ZgQPLClCj9m5wCkSNkm3JVrJz12Y=;
	b=HumlfwCDmM1mZVGCrBhgrBtaReTYtBwNpbQkpM3YXQYLoF6sOffOkMmt51Iz9ib+LoXorJ
	mNoRcPvQfCdv01K8tluL4YYHjQtjiXdu5V+CPmWAN2L6/qYZYwRmSCNuB23mJDkJ14AD+9
	Tgg1OegzxOIydgwip1Xo7/yRuzpdYiE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-JageVda4MMevYdQEq_oydw-1; Wed, 23 Oct 2024 00:12:35 -0400
X-MC-Unique: JageVda4MMevYdQEq_oydw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2e2fb583e4cso7652159a91.3
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 21:12:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729656754; x=1730261554;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+37vG64ySEsAwS8ZgQPLClCj9m5wCkSNkm3JVrJz12Y=;
        b=CX/6ET8+JkZBAapoowPoWXj+kXCAw+MHQXAuu22SJo6lKK4sq6TG+X4IBWJK3iwpzj
         V1G7pSPbPsfsXHGYH7FTxxOe8wH3YoZMbPLS/nnpUChnn4EHpJxkguS8v7JNaVCntz3/
         pX7zXEtZNSjZWDm44kVp7bov6JnFo25s4lvSA830KgeWH77bJgo7D0FZ5zz0MB55mzUV
         rrLhnLzZk+gpzWf1kSDeSEIirrIUbJ5HjNFJ+OnM/989lNYBblDbEH1DxtLAX2SCcP4E
         dRnq24kMA7lwhvYEbGcbjdC8BSDqIdw27dZxDL1FW5D+uvEhlyTICotEwrFL5uBzFSU0
         B3gg==
X-Forwarded-Encrypted: i=1; AJvYcCVY89GxfCQ06JggzpnJy7+qt7n+UJgR2kNbj6qz47AMxzVVTLLBLV1ziJ1vV+5JQu8TFnc6Xr1yhK9lWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxRY1bDxaSNb3RNPEkfMgKM1L6OZbf2NeYEHEsruynqONNQP7o
	fmVyI/sF0McgHMjNv2ukELV2m4FLCs/dwhA6lTjfR/iQQzNjYk2wdWxdrzWLHGyupoDrunHdBto
	xfhPtabOfczzTNtfkwL41KYmjzSwHvu8u3TsE3CFpFg+bAn7RvkxjU1n4++gc
X-Received: by 2002:a17:90a:de8e:b0:2e2:bd68:b8d8 with SMTP id 98e67ed59e1d1-2e76b5b59a9mr1498290a91.8.1729656754482;
        Tue, 22 Oct 2024 21:12:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnHxPU6fpRamKmjky29NIoWmZ5rFzNRJcaN1vCYWtFkjg8Vtc28xndO+DadjjYyyVSmx4fRQ==
X-Received: by 2002:a17:90a:de8e:b0:2e2:bd68:b8d8 with SMTP id 98e67ed59e1d1-2e76b5b59a9mr1498276a91.8.1729656754152;
        Tue, 22 Oct 2024 21:12:34 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e76df29cd5sm296434a91.1.2024.10.22.21.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 21:12:33 -0700 (PDT)
Date: Wed, 23 Oct 2024 12:12:28 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
	Long An <lan@suse.com>
Subject: Re: [PATCH] btrfs/012: fix false alerts when SELinux is enabled
Message-ID: <20241023041228.d3rkmmci5vnw5ict@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <5538c72ca7c1bf2eb0ff3dbaa73903869ba47e95.1729209889.git.wqu@suse.com>
 <96e09109-1b9c-4f15-a07d-26501ed891a3@oracle.com>
 <8f1acfa5-37f9-4deb-af9e-d2f7576e0c26@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f1acfa5-37f9-4deb-af9e-d2f7576e0c26@gmx.com>

On Tue, Oct 22, 2024 at 01:12:15PM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/10/19 08:45, Anand Jain 写道:
> > On 18/10/24 08:04, Qu Wenruo wrote:
> > > [FALSE FAILURE]
> > > If SELinux is enabled, the test btrfs/012 will fail due to metadata
> > > mismatch:
> > > 
> > > FSTYP         -- btrfs
> > > PLATFORM      -- Linux/x86_64 localhost 6.4.0-150600.23.25-default #1
> > > SMP PREEMPT_DYNAMIC Tue Oct  1 10:54:01 UTC 2024 (ea7c56d)
> > > MKFS_OPTIONS  -- /dev/loop1
> > > MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/loop1 /
> > > mnt/scratch
> > > 
> > > btrfs/012       - output mismatch (see /home/adam/xfstests-dev/
> > > results//btrfs/012.out.bad)
> > >      --- tests/btrfs/012.out    2024-10-18 10:15:29.132894338 +1030
> > >      +++ /home/adam/xfstests-dev/results//btrfs/012.out.bad
> > > 2024-10-18 10:25:51.834819708 +1030
> > >      @@ -1,6 +1,1390 @@
> > >       QA output created by 012
> > >       Checking converted btrfs against the original one:
> > >      -OK
> > >      +metadata mismatch in /p0/d2/f4
> > >      +metadata mismatch in /p0/d2/f5
> > >      +metadata and data mismatch in /p0/d2/
> > >      +metadata and data mismatch in /p0/
> > >      ...
> > > 
> > > [CAUSE]
> > > All the mismatch happens in the metadata, to be more especific, it's the
> > > security xattrs.
> > > 
> > > Although btrfs-convert properly convert all xattrs including the
> > > security ones, at mount time we will get new SELinux labels, causing the
> > > mismatch between the converted and original fs.
> > > 
> > > [FIX]
> > > Override SELINUX_MOUNT_OPTIONS so that we will not touch the security
> > > xattrs, and that should fix the false alert.
> > > 
> > > Reported-by: Long An <lan@suse.com>
> > > Link: https://bugzilla.suse.com/show_bug.cgi?id=1231524
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > >   tests/btrfs/012 | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/tests/btrfs/012 b/tests/btrfs/012
> > > index b23e039f4c9f..5811b3b339cb 100755
> > > --- a/tests/btrfs/012
> > > +++ b/tests/btrfs/012
> > > @@ -32,6 +32,11 @@ _require_extra_fs ext4
> > >   BASENAME="stressdir"
> > >   BLOCK_SIZE=`_get_block_size $TEST_DIR`
> > > +# Override the SELinux mount options, or it will lead to unexpected
> > > +# different security.selinux between the original and converted fs,
> > > +# causing false metadata mismatch during fssum.
> > > +export SELINUX_MOUNT_OPTIONS=""
> > > +
> > 
> > SELINUX_MOUNT_OPTIONS is set only when SELinux is enabled on the system,
> > so disabling SELinux will suffice.
> 
> Are you suggesting to disable SELinux just to pass the test case?
> 
> Then it doesn't sound correct to me at all.
> 
> It should be the test case to adapt to all kinds of systems, not the
> other way.

Hi Anand, I think Qu is right, it's not worth disable the whole SELinux
(at the beginning of fstests running), just for a single test case.
I just hope to make sure btrfs forks agree this's a failure which should
be fixed in test side, but not change the selinux config for btrfs-progs.
If you're sure about it, I'll merge this patch :)

Thanks,
Zorro

> 
> Thanks,
> Qu
> 
> > 
> > -------
> > fstests/common/config:
> > if [ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled; then
> >          : ${SELINUX_MOUNT_OPTIONS:="-o context=$(stat -c %C /)"}
> >          export SELINUX_MOUNT_OPTIONS
> > fi
> > ----------
> > 
> > Thanks, Anand
> > 
> > >   # Create & populate an ext4 filesystem
> > >   $MKFS_EXT4_PROG -F -b $BLOCK_SIZE $SCRATCH_DEV > $seqres.full 2>&1 || \
> > >       _notrun "Could not create ext4 filesystem"
> > 
> > 
> 
> 


