Return-Path: <linux-btrfs+bounces-11729-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE11A4155A
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 07:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93E907A5932
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 06:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1B11CBE8C;
	Mon, 24 Feb 2025 06:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bNYLekPp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDCB1AB531
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Feb 2025 06:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740378667; cv=none; b=mVEVibRIJJXDqhIH9eAul55zTOwQouD+Uh/lPLLMQwtnFZEorn0oUuWaj4Wk9dqgAYhUAROrj0yLSy7WJPDlqO6Hww7bcR+yaQcbHk04W/Y6tV6gWzYsy3+3tZ0gOrdSnan9AiymHPrGpwsBkZ64IQ8HBEbDCGY+J/yQ6mJ2yNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740378667; c=relaxed/simple;
	bh=E1dIoHlKR/agJWLj3cGql40S1z8U1XpRW7oPQEEghfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkmcFU+fno7+/7yt5IyjJ8dUG07SuwrjLKWxgfP1SYDWQqhVxnFpkeUdsfXWRJSTyvEC5Bui0YPku7kgQpBhhOchMauRHdLzxYHw5WK4RsMrmhrY2NTHIJ4v9LkFb77VYFd9Q1m0DmfYt0aNEGNYzjtlHcTdoUuJBKrsizE4Bxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bNYLekPp; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abb90f68f8cso765483066b.3
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2025 22:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740378659; x=1740983459; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Aq+wki+MqXy/nndMCRwVQpc+5nJChRMlyfSHUzsL4QQ=;
        b=bNYLekPp3ysF/pkSf8RxamAoXTSobHaZR1rqeG/3h/ZUITEBjqo+Gb5mNlqb8Y3VCI
         fH0OSvrf05jkEoywUgJMbzR5Xh90xkZAyhpXFrn51jkjvW0W6mNyvgk5AGNz9f6J3HwG
         oAABiNXHpsc+HEU98aYFe61vcJcW497BeRQxGfFMZujzvMyCwchnxBtYV3vj3EA+b2Pu
         tHhIxKPWO7N5wI56wdwT0eDSYWUf4rz7idI80uOa0Jzb/yt0zY+lTqS8795HoXZKV01n
         Gp7QFPVbnW+b6jfuiCclNQlyD4CXvIHl9kG8JzXGcxPxXt8G/6KPBxafPPSakt3MVXZo
         wCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740378659; x=1740983459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aq+wki+MqXy/nndMCRwVQpc+5nJChRMlyfSHUzsL4QQ=;
        b=irkzQ+9/d5Erul4S2ha6H6o4KcsRZ1EyMx9lyXSJWT+/yoDKkL5VbcKmYuGjurd1x3
         jIfuaE+9dklCB6I39HF5Y2kFErhT3MTrO2Igtn52IB3LwTPQnMTaP/dEDN1w+Q/6m31O
         LHd5WWpnvXw59HMJxPHdvGiyqOp4jPSsCeYAU0oIobyhn84H+DzlleaNXTCsbt8dV7uD
         keMQS3BwW5jVEwlSjak7H+XT79e4wpx4EvUBKdZ1QxDEt6y92q6hSDe3hMN07pPKazvf
         uowO8zv1kO6ot2d6AE5ewRez/fND7KljoBQ3Uo5qx7x/olUfRc86P3r29E67q9DeKHCk
         DE8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUn+gXCe98rYBOrP7k+inQ8U6IH+IwT0ASXfgLwaW2V/EltI6x5qq1jL7NYVBLYpj7E/BZsnz0Qi1UtQw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe2pk/8wKlrWpKG9YJqT89dl/vZ3bRDB28Bpzkm8CDxM6rwb+K
	8EsN8V8DdgODQhLNInFp9BfvOKxZOJoZ4PZJyqz0hzjVAYaJyUy90Uaq7upn3CfZDRYpU2plIUu
	vRGrxqM3B8XoRkLHITvMEiDIGnwe7ntxO82ZsrQ==
X-Gm-Gg: ASbGncsQbQqk9/OA+vJmS9rfUkvaP9kAHg7PU65f2wBQQTDtN8rV+nfS/YCb1vforxz
	hnY0PDZvDYROkCkatCs1MW+OfOWZUsZQTOX3J14SvQDNQzuUgOICXxuecqJz8uhAHWFz128+5qc
	efjTqF9g==
X-Google-Smtp-Source: AGHT+IFANUpl9PA24M96TCMpL3ASx4z9pMNb8ptEXkRZZYKabRXkwYX/5xYx9bv/y9Bn91SAl7DaCt3y+JqPPxhv1FQ=
X-Received: by 2002:a17:907:970f:b0:ab3:2b85:5d5 with SMTP id
 a640c23a62f3a-abc09d2dcc1mr1280389266b.49.1740378659424; Sun, 23 Feb 2025
 22:30:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220145723.1526907-1-neelx@suse.com> <20250222083753.wvdw2quokicxdqoz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20250222083753.wvdw2quokicxdqoz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 24 Feb 2025 07:30:48 +0100
X-Gm-Features: AWEUYZkpzLQ7FCiwksIzEvMHAdiGua0Ki_0J-oKEt5dRO4_DBgZicOeGKk6Bah8
Message-ID: <CAPjX3FdRuUzq7L_ZoWMt3WctLBAZbGPhSjio+bXpYM7KF+T3mQ@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs/314: fix the failure when SELinux is enabled
To: Zorro Lang <zlang@redhat.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, fstests@vger.kernel.org, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 22 Feb 2025 at 09:38, Zorro Lang <zlang@redhat.com> wrote:
>
> On Thu, Feb 20, 2025 at 03:57:23PM +0100, Daniel Vacek wrote:
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
> >      Send:    42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/314/tempfsid_mnt/foo
> >     -Recv:    42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/snap1/foo
> >     +Recv:    d41d8cd98f00b204e9800998ecf8427e  SCRATCH_MNT/snap1/foo
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
>
> Take it easy, Thanks for both of you would like to help fstests to get
> better :)
>
> Firstly, SELINUX_MOUNT_OPTIONS isn't a parameter to enable or disable
> SELinux test. We just use it to avoid tons of ondisk selinux lables to
> mess up the testing. So mount with a specified SELINUX_MOUNT_OPTIONS
> to avoid new ondisk selinux labels always be created in each file's
> extended attributes field.

Well put. I was trying to explain that.

In fact it does not mess with this test and that's why originally I
kept it and I did not remove it after coming up with the other way to
address the bug. I thought a bit of diversity could be useful with the
testing after all.

> Secondly, I don't want to attend the argument :) Just for this patch review,
> I prefer just doing:
>
>           _scratch_mount
>   -       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
>   +       _mount $SELINUX_MOUNT_OPTIONS ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}

I already agreed with dropping the other hunk before.

> or if you concern MOUNT_OPTIONS and SELINUX_MOUNT_OPTIONS both, maybe:
>
>           _scratch_mount
>   -       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
>   +       _mount $(_common_dev_mount_options) ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}

That's even better. I'll send a v2 with this change.
Thanks for the hint.

> That's enough to help "_scratch_mount" and later "_mount" use same
> SELINUX_MOUNT_OPTIONS, and fix the test failure you hit.
>
> About resetting "SELINUX_MOUNT_OPTIONS", I think btrfs/314 isn't a test case
> cares about SELinux labels on-disk or not. So how about don't touch it.

Yup, as I said, I already agreed with that in the previous conversation.

> If you'd like to talk about if xfstests cases should test with a specified
> SELINUX_MOUNT_OPTIONS mount option or not, you can send another patch to talk
> about 3839d299 ("xfstests: mount xfs with a context when selinux is on").
>
> Now let's fix this failure at first :)
>
> Thanks,
> Zorro
>
> >  tests/btrfs/314 | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/tests/btrfs/314 b/tests/btrfs/314
> > index 76dccc41..cc1a2264 100755
> > --- a/tests/btrfs/314
> > +++ b/tests/btrfs/314
> > @@ -21,6 +21,10 @@ _cleanup()
> >
> >  . ./common/filter.btrfs
> >
> > +# Disable the forced SELinux context. We are fine testing the
> > +# security labels with this test when SELinux is enabled.
> > +SELINUX_MOUNT_OPTIONS=
> > +
> >  _require_scratch_dev_pool 2
> >  _require_btrfs_fs_feature temp_fsid
> >
> > @@ -38,7 +42,7 @@ send_receive_tempfsid()
> >       # Use first 2 devices from the SCRATCH_DEV_POOL
> >       mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
> >       _scratch_mount
> > -     _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> > +     _mount ${SELINUX_MOUNT_OPTIONS} ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> >
> >       $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo | _filter_xfs_io
> >       _btrfs subvolume snapshot -r ${src} ${src}/snap1
> > --
> > 2.48.1
> >
> >
>

