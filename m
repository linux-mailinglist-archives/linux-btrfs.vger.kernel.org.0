Return-Path: <linux-btrfs+bounces-11756-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12031A4395B
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 10:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06D167A653A
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 09:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B2925A35D;
	Tue, 25 Feb 2025 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XqO/IvxO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E28256C91
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 09:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475509; cv=none; b=GkeLAfCWB1QhZlQwUx+XeotQZbQ9IwPc++bUaSsN0d/ZWCthWoAIgwSWi8eDlx3tyJZQDfa7XIkyGUMQav8/0SMU1a4w3EuBKA4tOdnhN05eYPZ+fbFxxbkOXJhnkCzp5CeKQpHoSaZtV+kezIyFW0FtOD8G5bXel4wjX9umfK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475509; c=relaxed/simple;
	bh=erj9N9Vit1eVAGakU5HYsZ3c2ok6hACcCdpNmAG1RuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ab1RSkzzCc1BQzPS+Tv798pwHPMUIWEc9O/S5HVjboKUkEx1wMb4NZoPSHIj0HASbPKMth/1J7O3R7NPWhDV3V3APf5BgHIu9wsOlBm2yz25ZZjHoBcHqUO3wSMU2yvPQfqlXDohcuun95Szsq5+sVceb1Qe6ph9HMJUeWt3gBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XqO/IvxO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740475506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mankb6imwSp1UxMwbuGVJaLzZcCAIHqDBny0Cs+EpmU=;
	b=XqO/IvxOiIssYi+NhzZ2KOwdIfyNuBzeNXYmKjcCvCG5CoOXp+YBOFmCW9vMz1p5xW09dm
	dW5yAYPaqGb41sT76F5QdOGDjPuN6Z/oohkooYCyIo6ozVBu+lRsf937cNcZyxUZp6mfVL
	8CdZd23WQzYhOAxtMk87UJ5RRxfln3w=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-cK__4TTpMCyblxrFgfW3JA-1; Tue, 25 Feb 2025 04:25:04 -0500
X-MC-Unique: cK__4TTpMCyblxrFgfW3JA-1
X-Mimecast-MFC-AGG-ID: cK__4TTpMCyblxrFgfW3JA_1740475504
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fc5888c192so10622231a91.0
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 01:25:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740475503; x=1741080303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mankb6imwSp1UxMwbuGVJaLzZcCAIHqDBny0Cs+EpmU=;
        b=qZzhCX2nFadJ+WSgvrFrm18T4udHmdcQTDJuU7HtFdBBLntKA7tBSvxSB8hIkSBxwk
         cGmvi5oTuAL3fjXpxiN2lPNn1gmAki0VrtjZfZuP7ODaivlpq60UsOtfBtpuEQIDf4Eu
         fPvNnYluNQKPAavpp5fn+ZV4byMM0nfcQ6mJQfel6+yJEp0PqaEPRS7bvCMI+bbDgSv5
         SU9l8yU1nxE8ODAxv54Xdt/jepvPQ6qIutUktjMREyhfIhkU9itZK0RnqbVpqEJEG0uN
         2oxJVCGo2nHvOu1fjvqo60PVWu77djKCta8Qw0j1Acxdy8dZkR+s4NNunNNUmdWOi5E9
         5EQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw7YNbD9fLtVdzENQ1gzaNrwjmFjdA37eXvaFSBOoqXCHoCKrhNEkwON3KWa8UvwoR0niFN1LZYyuTEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXdyC40V15appsgrBRyQfEXKNvPYR4q4F6Ac51SIH+djylCTMF
	NWs1734jCMESrbmKGiZf9qaCw46FHtfftywq4rBm0J29ipM1SAaPN/WOlvynKtBzL9y/nOJtoaZ
	v+Xkg80QgnQIoQNoQpBVXxBdeq42HDAU7sRBd+4tO+rAHVpU7EUukAhHKYIF2
X-Gm-Gg: ASbGncuC5jHda2n2fwxEctwVEvISwenx6hSj3mtPl0hHX8lTvajyeN0BZ8Pq5zFKCMP
	+upWnFpNLHTFE+1K4r6JyU8vLQPuedwanFAn3vDH1wuohKCYpRjUM6coeFJqu8FTen9KrUh+TxX
	MWvhApBdOmJ8bcqySQNgKqszH7M8NYq/5OrwPqsN9VQbCJI0SNyxM7kQrhTEY8W9Ejmt7JyF4GU
	Tb4rg+DjmRmb+yuKTWn7iTiEGSPYS4r+CzP3Z1H2VNawpCky1bQk84SZKYW5LkgaCz8yHA4dG/3
	GFsYsc79cTw2Iy2B6iADy8nOyE/GGFVvQQWo40ESFTHkEgYpetSReIzJ
X-Received: by 2002:a05:6a21:700a:b0:1ee:7054:178b with SMTP id adf61e73a8af0-1eef3d90dcdmr28130648637.33.1740475503597;
        Tue, 25 Feb 2025 01:25:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFivElT9x3XxWObNvSoozQXJ8cmM0QVsoO3KYdNSyWXLZ76kROuJUG7XXuhU5Ywo0JE4oXD4A==
X-Received: by 2002:a05:6a21:700a:b0:1ee:7054:178b with SMTP id adf61e73a8af0-1eef3d90dcdmr28130622637.33.1740475503254;
        Tue, 25 Feb 2025 01:25:03 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6f9eb5sm1059933b3a.69.2025.02.25.01.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:25:02 -0800 (PST)
Date: Tue, 25 Feb 2025 17:24:58 +0800
From: Zorro Lang <zlang@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Daniel Vacek <neelx@suse.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v2] fstests: btrfs/314: fix the failure when SELinux is
 enabled
Message-ID: <20250225092458.n4lstidr3mifdrdp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250220145723.1526907-1-neelx@suse.com>
 <20250224111014.2276072-1-neelx@suse.com>
 <Z7zsIkC4SR103m0D@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7zsIkC4SR103m0D@dread.disaster.area>

On Tue, Feb 25, 2025 at 09:01:06AM +1100, Dave Chinner wrote:
> On Mon, Feb 24, 2025 at 12:10:14PM +0100, Daniel Vacek wrote:
> > When SELinux is enabled this test fails unable to receive a file with
> > security label attribute:
> > 
> >     --- tests/btrfs/314.out
> >     +++ results//btrfs/314.out.bad
> >     @@ -17,5 +17,6 @@
> >      At subvol TEST_DIR/314/tempfsid_mnt/snap1
> >      Receive SCRATCH_MNT
> >      At subvol snap1
> >     +ERROR: lsetxattr foo security.selinux=unconfined_u:object_r:unlabeled_t:s0 failed: Operation not supported
> >      Send:	42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/314/tempfsid_mnt/foo
> >     -Recv:	42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/snap1/foo
> >     +Recv:	d41d8cd98f00b204e9800998ecf8427e  SCRATCH_MNT/snap1/foo
> >     ...
> > 
> > Setting the security label file attribute fails due to the default mount
> > option implied by fstests:
> > 
> > MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sdb /mnt/scratch
> > 
> > See commit 3839d299 ("xfstests: mount xfs with a context when selinux is on")
> > 
> > fstests by default mount test and scratch devices with forced SELinux
> > context to get rid of the additional file attributes when SELinux is
> > enabled. When a test mounts additional devices from the pool, it may need
> > to honor this option to keep on par. Otherwise failures may be expected.
> > 
> > Moreover this test is perfectly fine labeling the files so let's just
> > disable the forced context for this one.
> > 
> > Signed-off-by: Daniel Vacek <neelx@suse.com>
> > ---
> >  tests/btrfs/314 | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tests/btrfs/314 b/tests/btrfs/314
> > index 76dccc41..29111ece 100755
> > --- a/tests/btrfs/314
> > +++ b/tests/btrfs/314
> > @@ -38,7 +38,7 @@ send_receive_tempfsid()
> >  	# Use first 2 devices from the SCRATCH_DEV_POOL
> >  	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
> >  	_scratch_mount
> > -	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> > +	_mount $(_common_dev_mount_options) ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> 
> I note that there are several similar instances of this in common/,
> either as '_mount $(_common_dev_mount_options)' or as '$MOUNT_PROG
> -t $FSTYP `_common_dev_mount_options $*`'
> 
> That kinda says to me there should be a _mount_dev() wrapper,
> similar to the _mkfs_dev() wrapper like this:
> 
> _mount_dev()
> {
> 	_mount $(_common_dev_mount_options) $*
> }
> 
> And all these open coded device mounts be converted to use the
> wrapper. That way we don't have this problem of omitting
> _common_dev_mount_options when future tests open code specific device
> mounts.

OK, so we have two requirements about mount/umount now:
1) Use _mount_dev to replace _mount or even $MOUNT_PROG. But overlayfs
   tests might be special, he has to deal with underlying devices which
   is not suitable for $(_common_dev_mount_options).
2) Use _umount to replace $UMOUNT_PROG:
   https://lore.kernel.org/fstests/20250221041819.GX21799@frogsfrogsfrogs/

Thanks,
Zorro

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 


