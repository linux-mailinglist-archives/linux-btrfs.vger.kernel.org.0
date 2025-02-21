Return-Path: <linux-btrfs+bounces-11683-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49305A3EDD3
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 09:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D3B42061B
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 08:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC1D1FF7B4;
	Fri, 21 Feb 2025 08:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WS3P4l5q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD331FE46B
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2025 08:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740124888; cv=none; b=c6sePBO9hE8OODJu12mi/sFxSdiwOxN0r5W6V5Jc9L3vV4f254THKRkj2LxDIZ6fExssQbjzhvV0TS0BmJtbhv10mcAiGlhsH7IA2LiEEiSqjlGg9ZYGybRss3AtlCnFgIeSHNUHIw5iLbfhn2o3JctwK8xQVHHrGSu0CXuHnGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740124888; c=relaxed/simple;
	bh=92MJphfxwChzqqP2MDO8RUvU55G6utaSAplo3DEYtKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oshMozbUkfws3a2kHImdmghMa1NWeLqjTckBuJptcQRAAex0lodspeR2+pp194EcdahZsTLjM9ew58Ud8fIETCcR6e+lLDIgUjAMn/D1C4bX3rZfOQenSuFQG/t6wdLRLnvOPDFZHqg8i87bsLRPFQKFCVNpZBPf7C9NTn9Izoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WS3P4l5q; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e05780509dso2561013a12.2
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2025 00:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740124885; x=1740729685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WZkHEN0KWJYGv2mCH3N5al+n3xj4fz8GPvedEJ4fHs=;
        b=WS3P4l5q1tkDBTbQoK7LvFL+U3TOSqbdH5Ah08/pcBR7SZmpLKG10HMn6dQiXzclx1
         4E/TDfWzV+zYr+STZf2ySsg6R+bMFtUcg4dPtaYrYBVUOQVh8LxdJPh1hccP2dncwvM8
         yJXnkjRtTDOSFo0+TsI1JDuzyPUFpLyBMrZkwqYmJ+C+Ndvl6yUm97KN0eYJqq/Nj/MA
         B4gmi+rfICQS5ooScG6nucK+oiBDYspXkUnNHqKXCnGFt7H7sgfJUi7JvAwZoaoerTY4
         IVoUY3TM+dQksGkoWwIvaJaN2cxXGya0z4pAm/HeO5JscLjPX3PA5KM8YnR7TjWcBjJR
         5+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740124885; x=1740729685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WZkHEN0KWJYGv2mCH3N5al+n3xj4fz8GPvedEJ4fHs=;
        b=aArKX4YM5VgM8NBl8XInEBIJmZdbiijAjbHzGuQMk+U01kQCs+Sh7tnt3CwqwMaZE9
         zTRQTBr3/dCOcy3/9Civ8Vdh2FxzXVkFQErd5WKlJSagLr2zxCA46p14jkC5f7WDfuzp
         wm12KiVZoyKQuE6tya7cDgR4nXAH/Qo1l6juwvjnyxTiSxZG1Vm1YSsDO0REedxw8mZF
         0lsciIltiKvJ0wCLg2qIpgfRndu/phagiOZfqVk++EcRs9iwVYKGmslSl/rV8mPNidIB
         qVdcE4RjEbfNozK8blmkbAB2NBiZ5M+68OSQAum/JH37O4FkHhOiecgU0Wa+bZg2BMGL
         oSYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXDOvx3bIfkX6Gppl4ez+JDa7ntp5gztMZCf1ppylsQgdvAHc8f1x19q3e7VqlIoINRa6Z1+uZn39RPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAj3iQlKnAmxHDNFdsKbrgddAy4zEms8ypC7/ZXW82asy+RPYw
	hFRGPPte4MDNcJst/pOL4slB+rNA0adS0qTqzgt26X7NuJrU+OaKtm576mSOBg28NoRldiVFOWo
	eeNQIwEwvwI1Ayi908u3WSrshG5/3Ym0yhDUUSg==
X-Gm-Gg: ASbGnct8hSGzhGVbzU6f9c1RsbwHgtSMaCepjg3vXA0q00Nj5dhV2PeaCQ1by5+hrQ1
	MrgYvlLV2Vh/D7S9kQF1hro77B3iVtXs/q0bCgQAesb1Dkj7WqpGuFa+KlzRokKc6Z8R2ty3k3V
	5N5vjhLg==
X-Google-Smtp-Source: AGHT+IH9bsydM4xYZ5BCu0IzErJeoWK/XVSuAK7y8fQeJc5E7RDAM69B8SlUX3ituS9FN4aHkUT0JnoZyq13IPNnqjc=
X-Received: by 2002:a17:906:3087:b0:ab7:da56:af9f with SMTP id
 a640c23a62f3a-abc09d33a64mr213586166b.49.1740124884619; Fri, 21 Feb 2025
 00:01:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220145723.1526907-1-neelx@suse.com> <d84d2d83-03ac-4741-9677-52c71e1fb36d@suse.com>
 <c0a4b4a0-268c-42f3-b117-b87b2fb12a03@suse.com> <CAPjX3Fem-=D8dxyR1MGTQVskkzdijmc7k82+f5_S_YyBJ_Orsg@mail.gmail.com>
 <6bbfddea-f0ea-4825-a987-01be3ff18a23@suse.com>
In-Reply-To: <6bbfddea-f0ea-4825-a987-01be3ff18a23@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 21 Feb 2025 09:01:13 +0100
X-Gm-Features: AWEUYZnJUn_xmtqkDZ4OD4nKVB8-Nad6vKkJB4z5FLqjJiHrVp2EjXcNeAeQr9w
Message-ID: <CAPjX3Fc=E28A6zD4tJOT2bRZ-pnErVKzkYuzALt6soGLu=MRJQ@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs/314: fix the failure when SELinux is enabled
To: Qu Wenruo <wqu@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Anand Jain <anand.jain@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Feb 2025 at 08:45, Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2025/2/21 18:10, Daniel Vacek =E5=86=99=E9=81=93:
> > On Thu, 20 Feb 2025 at 22:54, Qu Wenruo <wqu@suse.com> wrote:
> >>
> >>
> >>
> >> =E5=9C=A8 2025/2/21 08:06, Qu Wenruo =E5=86=99=E9=81=93:
> >>>
> >>>
> >>> =E5=9C=A8 2025/2/21 01:27, Daniel Vacek =E5=86=99=E9=81=93:
> >>>> When SELinux is enabled this test fails unable to receive a file wit=
h
> >>>> security label attribute:
> >>>>
> >>>>       --- tests/btrfs/314.out
> >>>>       +++ results//btrfs/314.out.bad
> >>>>       @@ -17,5 +17,6 @@
> >>>>        At subvol TEST_DIR/314/tempfsid_mnt/snap1
> >>>>        Receive SCRATCH_MNT
> >>>>        At subvol snap1
> >>>>       +ERROR: lsetxattr foo
> >>>> security.selinux=3Dunconfined_u:object_r:unlabeled_t:s0 failed:
> >>>> Operation not supported
> >>>>        Send:    42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/314/
> >>>> tempfsid_mnt/foo
> >>>>       -Recv:    42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/snap1/=
foo
> >>>>       +Recv:    d41d8cd98f00b204e9800998ecf8427e  SCRATCH_MNT/snap1/=
foo
> >>>>       ...
> >>>>
> >>>> Setting the security label file attribute fails due to the default m=
ount
> >>>> option implied by fstests:
> >>>>
> >>>> MOUNT_OPTIONS -- -o context=3Dsystem_u:object_r:root_t:s0 /dev/sdb /=
mnt/
> >>>> scratch
> >>>>
> >>>> See commit 3839d299 ("xfstests: mount xfs with a context when selinu=
x
> >>>> is on")
> >>>>
> >>>> fstests by default mount test and scratch devices with forced SELinu=
x
> >>>> context to get rid of the additional file attributes when SELinux is
> >>>> enabled. When a test mounts additional devices from the pool, it may=
 need
> >>>> to honor this option to keep on par. Otherwise failures may be expec=
ted.
> >>>>
> >>>> Moreover this test is perfectly fine labeling the files so let's jus=
t
> >>>> disable the forced context for this one.
> >>>>
> >>>> Signed-off-by: Daniel Vacek <neelx@suse.com>
> >>>
> >>> Reviewed-by: Qu Wenruo <wqu@suse.com>
> >>>
> >>> Thanks,
> >>> Qu
> >>>
> >>>> ---
> >>>>    tests/btrfs/314 | 6 +++++-
> >>>>    1 file changed, 5 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/tests/btrfs/314 b/tests/btrfs/314
> >>>> index 76dccc41..cc1a2264 100755
> >>>> --- a/tests/btrfs/314
> >>>> +++ b/tests/btrfs/314
> >>>> @@ -21,6 +21,10 @@ _cleanup()
> >>>>    . ./common/filter.btrfs
> >>>> +# Disable the forced SELinux context. We are fine testing the
> >>>> +# security labels with this test when SELinux is enabled.
> >>>> +SELINUX_MOUNT_OPTIONS=3D
> >>
> >> Wait for a minute, this means you're disabling SELINUX mount options
> >> completely.
> >>
> >> I'm not sure if this is really needed.
> >>>> +
> >>>>    _require_scratch_dev_pool 2
> >>>>    _require_btrfs_fs_feature temp_fsid
> >>>> @@ -38,7 +42,7 @@ send_receive_tempfsid()
> >>>>        # Use first 2 devices from the SCRATCH_DEV_POOL
> >>>>        mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
> >>>>        _scratch_mount
> >>>> -    _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> >>>> +    _mount ${SELINUX_MOUNT_OPTIONS} ${SCRATCH_DEV_NAME[1]}
> >>>> ${tempfsid_mnt}
> >>
> >> The problem of the old code is it doesn't have any SELinux related mou=
nt
> >> option, thus later receive will fail to set SELinux context.
> >>
> >> But since you have already added SELINUX_MOUNT_OPTIONS, I think you do
> >> not need to disable the SELINUX_MOUNT_OPTIONS.
> >>
> >> Have you tested with only this change, without resetting
> >> SELINUX_MOUNT_OPTIONS?
> >
> > Yes, I tested both. Actually resetting this option was the first fix I
> > came up with, that's why I kept it. This option breaks the test case
> > when SELinux is enabled.
> > But then I figured the other way around (using the option consistently
> > with all the mounts) also works. So I added it for consistency.
> > At that point, resetting the option is not really strictly needed
> > anymore (as you correctly suspect).
> >
> > So there are two possible solutions. Each one makes the testcase 314
> > pass. But they can as well be combined.
>
> Resetting the SELINUX one is not a good solution, that just means we
> reduce the coverage (No more SELINUX coverage for this test case anymore)=
.

I understand it's the other way around. Forcing a default mount
context basically disables SELinux. Well, more precisely it partially
cripples it.
Removing this option enables the usual default SELinux behavior. Note,
SELinux is always enabled unless you cripple it.

Or do you use such an option with any of your mounts? I doubt so.

Check the mentioned commit 3839d299. fstests cripple SELinux by
default. Which doesn't look good by itself.

At least I'd say it's good for diversity to have one test different.
Diverse tests are prefered with testing, right?

> So please only fix the mount command (with the extra selinux mount
> option), without overriding the existing SElinux config.
>
> Thanks,
> Qu
> >
> > Anyways, this test is fine without forcing the default mount context,
> > which is more a bandaid for other fstests, IIUC. There's no need for
> > this option in this case, at least with my testing. Hence I disabled
> > it. Does it fail for you?
> >
> >> Thanks,
> >> Qu
> >>>>        $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo |
> >>>> _filter_xfs_io
> >>>>        _btrfs subvolume snapshot -r ${src} ${src}/snap1
> >>>
> >>>
> >>
>

