Return-Path: <linux-btrfs+bounces-11716-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947A9A40D34
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Feb 2025 08:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCA45166315
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Feb 2025 07:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ACF1FC0E0;
	Sun, 23 Feb 2025 07:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7xANRXc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B580E1DED76
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2025 07:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740294480; cv=none; b=nGv8zEwJuiT4C2APtQI8oxODGJn1bHrp0OVkWN5LC2LdMzl0yY5S9oNLpNZUdN0crUhURqaOBsQtdjZWGTiIAMY+pp/H8QBMIuvRvmRx7yokt+gTXzujGloXqTidlvh/k31M3APDuCHVA4hphUkLbumqpGxPVmXLW7ENh9biB3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740294480; c=relaxed/simple;
	bh=2VRPymG1U1AkeC2EOlESAMwaS1rYMcnthSiWH7Yx9Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnWVUTC++omThwPlDS4MwUGlMFuzoyhYX0wfssCpqiV7BxyRQswFpVPSTcI23MTCXZCuYmkVYSJ95+1hEhWAco4U12TgqBa515TkCOkXltCNTgARodTY/ADSY9L+zjxlwJxpIBNfPpO5+GvHubN178CvqbmESbbcKAqYVaJX4/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y7xANRXc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740294477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zkWjc5e4+Oq+FwwYWxLPxh4bK4kAlysso9UshsQ7yRQ=;
	b=Y7xANRXcLacJiLr0Gp+tWcUXJ5o76PtoDoEQQTh6UyhG8EIZTTCqXO9I7z9U1BVaf0XZzJ
	6qo1+UY59Na/1/7PeizmtpO6Ga87VMmsKTy0fBgG45jADaF5kiXlyi2KHPDrWF2u4Y7Wbf
	uKTVeD70ptEVWadJg2maj7WTyM6QAc4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-cWAgxh2BMPi_Jt_k0JgKHA-1; Sun, 23 Feb 2025 02:07:55 -0500
X-MC-Unique: cWAgxh2BMPi_Jt_k0JgKHA-1
X-Mimecast-MFC-AGG-ID: cWAgxh2BMPi_Jt_k0JgKHA_1740294474
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-221063a808dso66294645ad.1
        for <linux-btrfs@vger.kernel.org>; Sat, 22 Feb 2025 23:07:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740294474; x=1740899274;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zkWjc5e4+Oq+FwwYWxLPxh4bK4kAlysso9UshsQ7yRQ=;
        b=EwPz5xrhRGlJzb5Z+XGpaH6x2M93r2/Avy/uZ3HClU+pGIGN7CJBurcccgbdG42kJn
         LnAp7yrmQiceuEHEaRG4PldgjflZxJ68/MIcczFxfeUATQe74V3CMoAWDKn6nmneouL5
         5RIcih08YUNi8eBXkQTPvhPRl2OJp4t9eXtPCXqFfRBsiGS9QbGF739P7g+Ht4+Ru0SE
         wtLL56zDsHC3+78cKRmTwyCgWfV6HtbdNmltj6LWbgYEyrOpJgb5jtWsaoQOM/42r0B4
         D8m0TPvrhj/r0pmMyeJCx/XQos1GgMP3EY0OKWyCoiVFg4WZBa4yFINLcaQ0X8+SIdql
         bLbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWH3NHedJLqcBWyO1jdOFhK4Xc9cUu1w9O5CvS4ngSprnHiDAY/gheQtghqiDZZ+ajrKkID1nUbI/c+1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YykyjIri3AgyrHQhckKPCDu+O3AeoZM4LVnoTlNWnTPQRTr+6fQ
	HqPeK8Omg1upQLT0ZFe6P3iIALmX5H7045Z70XBVaTXNFMjg6NEnLqa20AEVvO117zQWznu8btt
	0fL/EBI/OrEKVFjwSNzreCgkMW7/dE+LJF3tF+PwgqtMbsa9aMzysuHasjXJ/
X-Gm-Gg: ASbGncvwwtrao50ReMaO4c/JKFtlDErl62BsD02G3RbY+c84XxaA5+iCeuTgqnSjZpN
	93dNsPZX897ZwXqgLR4X0QzfuINS2lgidp/NCwK3Xwsh2sj42y2YtkWLUDHGWg18BlrpNtgy48O
	BVQbd/le6WXRORNpjiGyIcVSnW7sygYGDCQP+LNVBpTHLoKp25KDh+B/O38NoTCNFsnSOHtQVNz
	i89xa9hbfewqsVfvnXOPRZ87aFmouOLLJ0XitKbeeh75MZiQ4OrKiKWyWQ5+hfpJE9VlXJEJm56
	u+ZJZ7zAiJ3fBSRvXX3RlL5CW30ICJboHeZ+IzmUCUxHtUKkcC9geUnD
X-Received: by 2002:a05:6a00:807:b0:730:8e2c:e557 with SMTP id d2e1a72fcca58-73426ce7da9mr14938798b3a.11.1740294474033;
        Sat, 22 Feb 2025 23:07:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsXe5d81toRnfFwXrAbMbc+KTNccS5HQIYciF5hAFuZUj8NbDbhiSDvqq4YjfmwcxBnutHgw==
X-Received: by 2002:a05:6a00:807:b0:730:8e2c:e557 with SMTP id d2e1a72fcca58-73426ce7da9mr14938779b3a.11.1740294473683;
        Sat, 22 Feb 2025 23:07:53 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73265098570sm14711730b3a.22.2025.02.22.23.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 23:07:53 -0800 (PST)
Date: Sun, 23 Feb 2025 15:07:49 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Daniel Vacek <neelx@suse.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs/314: fix the failure when SELinux is
 enabled
Message-ID: <20250223070749.dmym2egqad4drwkc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250220145723.1526907-1-neelx@suse.com>
 <20250222083753.wvdw2quokicxdqoz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ddc27f3b-291f-43db-abfb-0f82d8c584fb@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ddc27f3b-291f-43db-abfb-0f82d8c584fb@gmx.com>

On Sun, Feb 23, 2025 at 07:56:02AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2025/2/22 19:07, Zorro Lang 写道:
> > On Thu, Feb 20, 2025 at 03:57:23PM +0100, Daniel Vacek wrote:
> > > When SELinux is enabled this test fails unable to receive a file with
> > > security label attribute:
> > > 
> > >      --- tests/btrfs/314.out
> > >      +++ results//btrfs/314.out.bad
> > >      @@ -17,5 +17,6 @@
> > >       At subvol TEST_DIR/314/tempfsid_mnt/snap1
> > >       Receive SCRATCH_MNT
> > >       At subvol snap1
> > >      +ERROR: lsetxattr foo security.selinux=unconfined_u:object_r:unlabeled_t:s0 failed: Operation not supported
> > >       Send:	42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/314/tempfsid_mnt/foo
> > >      -Recv:	42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/snap1/foo
> > >      +Recv:	d41d8cd98f00b204e9800998ecf8427e  SCRATCH_MNT/snap1/foo
> > >      ...
> > > 
> > > Setting the security label file attribute fails due to the default mount
> > > option implied by fstests:
> > > 
> > > MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sdb /mnt/scratch
> > > 
> > > See commit 3839d299 ("xfstests: mount xfs with a context when selinux is on")
> > > 
> > > fstests by default mount test and scratch devices with forced SELinux
> > > context to get rid of the additional file attributes when SELinux is
> > > enabled. When a test mounts additional devices from the pool, it may need
> > > to honor this option to keep on par. Otherwise failures may be expected.
> > > 
> > > Moreover this test is perfectly fine labeling the files so let's just
> > > disable the forced context for this one.
> > > 
> > > Signed-off-by: Daniel Vacek <neelx@suse.com>
> > > ---
> > 
> > Take it easy, Thanks for both of you would like to help fstests to get
> > better :)
> > 
> > Firstly, SELINUX_MOUNT_OPTIONS isn't a parameter to enable or disable
> > SELinux test. We just use it to avoid tons of ondisk selinux lables to
> > mess up the testing. So mount with a specified SELINUX_MOUNT_OPTIONS
> > to avoid new ondisk selinux labels always be created in each file's
> > extended attributes field.
> > 
> > Secondly, I don't want to attend the argument :) Just for this patch review,
> > I prefer just doing:
> > 
> >            _scratch_mount
> >    -       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> >    +       _mount $SELINUX_MOUNT_OPTIONS ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> > 
> > or if you concern MOUNT_OPTIONS and SELINUX_MOUNT_OPTIONS both, maybe:
> > 
> >            _scratch_mount
> >    -       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> >    +       _mount $(_common_dev_mount_options) ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> > 
> > That's enough to help "_scratch_mount" and later "_mount" use same
> > SELINUX_MOUNT_OPTIONS, and fix the test failure you hit.
> > 
> > About resetting "SELINUX_MOUNT_OPTIONS", I think btrfs/314 isn't a test case
> > cares about SELinux labels on-disk or not. So how about don't touch it.
> 
> Thanks for the sane final call.
> 
> Exactly what I want in the first place.

Your suggestion is good to me, but I think you confused Daniel a bit with "overriding
the SELINUX context just means disabling SELINUX" :) Anyway, I believe both of you
know how to fix this issue and how SELinux works, maybe you're just not talking in the
same channel, so take it easy, let's over it and move on :-D

Thanks,
Zorro

> 
> Thanks,
> Qu
> 
> > 
> > If you'd like to talk about if xfstests cases should test with a specified
> > SELINUX_MOUNT_OPTIONS mount option or not, you can send another patch to talk
> > about 3839d299 ("xfstests: mount xfs with a context when selinux is on").
> > 
> > Now let's fix this failure at first :)
> > 
> > Thanks,
> > Zorro
> > 
> > >   tests/btrfs/314 | 6 +++++-
> > >   1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tests/btrfs/314 b/tests/btrfs/314
> > > index 76dccc41..cc1a2264 100755
> > > --- a/tests/btrfs/314
> > > +++ b/tests/btrfs/314
> > > @@ -21,6 +21,10 @@ _cleanup()
> > > 
> > >   . ./common/filter.btrfs
> > > 
> > > +# Disable the forced SELinux context. We are fine testing the
> > > +# security labels with this test when SELinux is enabled.
> > > +SELINUX_MOUNT_OPTIONS=
> > > +
> > >   _require_scratch_dev_pool 2
> > >   _require_btrfs_fs_feature temp_fsid
> > > 
> > > @@ -38,7 +42,7 @@ send_receive_tempfsid()
> > >   	# Use first 2 devices from the SCRATCH_DEV_POOL
> > >   	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
> > >   	_scratch_mount
> > > -	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> > > +	_mount ${SELINUX_MOUNT_OPTIONS} ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> > > 
> > >   	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo | _filter_xfs_io
> > >   	_btrfs subvolume snapshot -r ${src} ${src}/snap1
> > > --
> > > 2.48.1
> > > 
> > > 
> > 
> > 
> 


