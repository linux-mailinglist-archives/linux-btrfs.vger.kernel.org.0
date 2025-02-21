Return-Path: <linux-btrfs+bounces-11685-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBE6A3EFBB
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 10:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A471890109
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 09:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC1F202F99;
	Fri, 21 Feb 2025 09:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YpJvbX0w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C8533EA
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2025 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740129228; cv=none; b=hDmq9t6ry5ZU5nNqSA9a0ZPDYg/IIqmU2gkiQ7nCfUo/y/wUenamVYRAEtDtc6Wh/k7BxStydVPc/hGThT9QhqH+Qyr0I1osvE6GbZgbgi/qmza3Mg0WxcBWY1IEgRfmi1MG2gi9L5WbkxayQ0cLkjQh9Otmptgskh19mm8Vf8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740129228; c=relaxed/simple;
	bh=61c5sjdm620NLtbWSvHap9pmlMoSlvepHRsTI5b6494=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHEb7tDeiWsf+RbTChJv0db093RtoH5ir5c+sleTfB+Inxb4Gr4+5AA900Qv3d1h6ZFKoZ/t8R8yQv3+z5ZrgbslCW2V2GqPu072pY3c5FEN/a2HKrSISKUMN5G+ZWQAqEOHSE78CvjXYQm/HPCee5GzNlMT/5zl4MsCbAswMG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YpJvbX0w; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abb9709b5b5so352636666b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2025 01:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740129224; x=1740734024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVHWUhxlfQEP8rrd9pdAA+mQirZVVjx5XnjXphJAdTQ=;
        b=YpJvbX0wtZjjN8/Z1ZRf2GwMuUR6D/ooFxAvnF6LDEohB8x1FzkYQwA2fwoKRvrh8b
         yBQpbW40p3VfmIN3K3GgbUQBfLDHEN4js0DMIu7D6Ggy8cmLwxsIgNAXJnQLBs3Boc2J
         Jc7EGUbecs8I+3itItsJ2hc76pqMJt++1F9mwmsnhIY44XFPpnRwEwPM32EIViBbSc0U
         oOB0k73aODeKQkethBv/WoIss70gkF1Fs+oh44rDJUd73Ytj7uBtJOauPJ26XgMHA6Sn
         k1maYma2Pdsrzuve5i75OU5wpvK+43dihoHfR9AxGBi2bAZw7/tahnKMoji+LPY4VbO0
         ZvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740129224; x=1740734024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVHWUhxlfQEP8rrd9pdAA+mQirZVVjx5XnjXphJAdTQ=;
        b=f2vV8di6W5BPMwC2Y1hULJYR8U/VfDbfsGB6xsUS4sDq3nvG5fFIFkCrJ3eNNUszbU
         M9cYodiwPdha3vu+ewuvlEkxM8mxeWMgkD20vsKHZJETgd9vlFXXkmGVdgh/KYqXiqHv
         Ju3dTFitaZ3pX3UEXITDFtZmW03WEtOQnzweVdiNuBNCbKrW9iyBfnb2RI9TdjEUqP2M
         TCnLrDGS+GMV3kJVE00hw78oTjpPlYYQuaCrwvi5l1mlc+U4B7MsI3J86bKhvRb3bpjv
         PizN6K/gZIHYF18jwWYmhwwtv+10JIpt4x58gTXYlPqGP5dGOkDcUp1lgjB2iuaNeW/P
         +9Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUeTrF9foHQY5Xir4qZ8kF4jIV027oVqsyPmpwHwpTAuXhKylqnEJltITdoNRdT4ay+NQeiv0cDUwgggA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyI61coCAlB2Fgl+f5SMhgYYCCClDWornkYTvqIQ0ydkLX6Vjgk
	zExauH+Ke0vjis994B70VBg5jvRyW+b4AkyO8WCjFWPeV0aZJIReo/jpixlyadjmPJxFn5kWFl4
	fwKpzExRLWwjzfUVbdy3qvJH9elTQWUJHtBPufy0Om/MSiVHfyI4=
X-Gm-Gg: ASbGncuNNKazuc7RLSmmGvX3t8P9AWhaLPGuoxR3f+H2mBKlBeYuAt/+HBqXtcd3D1f
	jaJUm9ttlYeReeIW0QH7NbU4VqWLOVP5NTgbvrl51IwwzMtKi5iLr2/xniPtBoIHZEKuwq8lPsr
	oLXpiFag==
X-Google-Smtp-Source: AGHT+IG4oHbqKvlAZh1fRg5LFvdSSeH5qXL3tC0fu9s/jAQQw4zFTodGk+ObDk6AqWE2Oq5rS1KYwSPOY6uKGEDBE54=
X-Received: by 2002:a17:907:6d02:b0:aa6:96ad:f903 with SMTP id
 a640c23a62f3a-abc09b0f127mr256741766b.31.1740129224466; Fri, 21 Feb 2025
 01:13:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220145723.1526907-1-neelx@suse.com> <d84d2d83-03ac-4741-9677-52c71e1fb36d@suse.com>
 <c0a4b4a0-268c-42f3-b117-b87b2fb12a03@suse.com> <CAPjX3Fem-=D8dxyR1MGTQVskkzdijmc7k82+f5_S_YyBJ_Orsg@mail.gmail.com>
 <6bbfddea-f0ea-4825-a987-01be3ff18a23@suse.com> <CAPjX3Fc=E28A6zD4tJOT2bRZ-pnErVKzkYuzALt6soGLu=MRJQ@mail.gmail.com>
 <a2ae2321-4934-4a10-8a44-2f7dc3bf48c3@suse.com>
In-Reply-To: <a2ae2321-4934-4a10-8a44-2f7dc3bf48c3@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 21 Feb 2025 10:13:33 +0100
X-Gm-Features: AWEUYZkqZeJ3ocuFXOFk5-TVU55FnY0DLbqL9OsDx_zxiSRctB3J5tGY9ITHMik
Message-ID: <CAPjX3Fes+PDEyi4_tFJyRHePVVuv_K+nUfShEeuagOANd6VqfQ@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs/314: fix the failure when SELinux is enabled
To: Qu Wenruo <wqu@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Anand Jain <anand.jain@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Feb 2025 at 09:20, Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2025/2/21 18:31, Daniel Vacek =E5=86=99=E9=81=93:
> > On Fri, 21 Feb 2025 at 08:45, Qu Wenruo <wqu@suse.com> wrote:
> >>
> >>
> >>
> >> =E5=9C=A8 2025/2/21 18:10, Daniel Vacek =E5=86=99=E9=81=93:
> >>> On Thu, 20 Feb 2025 at 22:54, Qu Wenruo <wqu@suse.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> =E5=9C=A8 2025/2/21 08:06, Qu Wenruo =E5=86=99=E9=81=93:
> >>>>>
> >>>>>
> >>>>> =E5=9C=A8 2025/2/21 01:27, Daniel Vacek =E5=86=99=E9=81=93:
> >>>>>> When SELinux is enabled this test fails unable to receive a file w=
ith
> >>>>>> security label attribute:
> >>>>>>
> >>>>>>        --- tests/btrfs/314.out
> >>>>>>        +++ results//btrfs/314.out.bad
> >>>>>>        @@ -17,5 +17,6 @@
> >>>>>>         At subvol TEST_DIR/314/tempfsid_mnt/snap1
> >>>>>>         Receive SCRATCH_MNT
> >>>>>>         At subvol snap1
> >>>>>>        +ERROR: lsetxattr foo
> >>>>>> security.selinux=3Dunconfined_u:object_r:unlabeled_t:s0 failed:
> >>>>>> Operation not supported
> >>>>>>         Send:    42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/314/
> >>>>>> tempfsid_mnt/foo
> >>>>>>        -Recv:    42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/sna=
p1/foo
> >>>>>>        +Recv:    d41d8cd98f00b204e9800998ecf8427e  SCRATCH_MNT/sna=
p1/foo
> >>>>>>        ...
> >>>>>>
> >>>>>> Setting the security label file attribute fails due to the default=
 mount
> >>>>>> option implied by fstests:
> >>>>>>
> >>>>>> MOUNT_OPTIONS -- -o context=3Dsystem_u:object_r:root_t:s0 /dev/sdb=
 /mnt/
> >>>>>> scratch
> >>>>>>
> >>>>>> See commit 3839d299 ("xfstests: mount xfs with a context when seli=
nux
> >>>>>> is on")
> >>>>>>
> >>>>>> fstests by default mount test and scratch devices with forced SELi=
nux
> >>>>>> context to get rid of the additional file attributes when SELinux =
is
> >>>>>> enabled. When a test mounts additional devices from the pool, it m=
ay need
> >>>>>> to honor this option to keep on par. Otherwise failures may be exp=
ected.
> >>>>>>
> >>>>>> Moreover this test is perfectly fine labeling the files so let's j=
ust
> >>>>>> disable the forced context for this one.
> >>>>>>
> >>>>>> Signed-off-by: Daniel Vacek <neelx@suse.com>
> >>>>>
> >>>>> Reviewed-by: Qu Wenruo <wqu@suse.com>
> >>>>>
> >>>>> Thanks,
> >>>>> Qu
> >>>>>
> >>>>>> ---
> >>>>>>     tests/btrfs/314 | 6 +++++-
> >>>>>>     1 file changed, 5 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/tests/btrfs/314 b/tests/btrfs/314
> >>>>>> index 76dccc41..cc1a2264 100755
> >>>>>> --- a/tests/btrfs/314
> >>>>>> +++ b/tests/btrfs/314
> >>>>>> @@ -21,6 +21,10 @@ _cleanup()
> >>>>>>     . ./common/filter.btrfs
> >>>>>> +# Disable the forced SELinux context. We are fine testing the
> >>>>>> +# security labels with this test when SELinux is enabled.
> >>>>>> +SELINUX_MOUNT_OPTIONS=3D
> >>>>
> >>>> Wait for a minute, this means you're disabling SELINUX mount options
> >>>> completely.
> >>>>
> >>>> I'm not sure if this is really needed.
> >>>>>> +
> >>>>>>     _require_scratch_dev_pool 2
> >>>>>>     _require_btrfs_fs_feature temp_fsid
> >>>>>> @@ -38,7 +42,7 @@ send_receive_tempfsid()
> >>>>>>         # Use first 2 devices from the SCRATCH_DEV_POOL
> >>>>>>         mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
> >>>>>>         _scratch_mount
> >>>>>> -    _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> >>>>>> +    _mount ${SELINUX_MOUNT_OPTIONS} ${SCRATCH_DEV_NAME[1]}
> >>>>>> ${tempfsid_mnt}
> >>>>
> >>>> The problem of the old code is it doesn't have any SELinux related m=
ount
> >>>> option, thus later receive will fail to set SELinux context.
> >>>>
> >>>> But since you have already added SELINUX_MOUNT_OPTIONS, I think you =
do
> >>>> not need to disable the SELINUX_MOUNT_OPTIONS.
> >>>>
> >>>> Have you tested with only this change, without resetting
> >>>> SELINUX_MOUNT_OPTIONS?
> >>>
> >>> Yes, I tested both. Actually resetting this option was the first fix =
I
> >>> came up with, that's why I kept it. This option breaks the test case
> >>> when SELinux is enabled.
> >>> But then I figured the other way around (using the option consistentl=
y
> >>> with all the mounts) also works. So I added it for consistency.
> >>> At that point, resetting the option is not really strictly needed
> >>> anymore (as you correctly suspect).
> >>>
> >>> So there are two possible solutions. Each one makes the testcase 314
> >>> pass. But they can as well be combined.
> >>
> >> Resetting the SELINUX one is not a good solution, that just means we
> >> reduce the coverage (No more SELINUX coverage for this test case anymo=
re).
> >
> > I understand it's the other way around. Forcing a default mount
> > context basically disables SELinux. Well, more precisely it partially
> > cripples it.
> > Removing this option enables the usual default SELinux behavior. Note,
> > SELinux is always enabled unless you cripple it.
>
> Nope, it's the other way around.
>
> You only disable SELinux when there is a reason that SELinux context is
> going to change.
> E.g. we're mounting two different filesystems, like btrfs/012.
>
> Which can created different SELinux context since the converted fs is a
> different one (Well, completely different fs type).
>
> Unless you have a strong reason that the security context is definitely
> going to be different, you should not override the existing one.
> Especially I believe the mount fix is already enough.
>
> Then you have no reason to keep the SELINUX override.
>
>
> Remember, user can provide their own mount options (including the
> SELinux ones) through MOUNT_OPTIONS environmental variables.
>
> So you at least need a full reason why SElinux context must be disable
> for this case.
> And I see none.

It does not need to be disabled. But it also does not have to be
enabled for this test.
At least not with the default policy on the latest Tumbleweed I was testing=
 on.

But your mileage may vary, I guess.

> >
> > Or do you use such an option with any of your mounts? I doubt so.
> >
> > Check the mentioned commit 3839d299. fstests cripple SELinux by
> > default. Which doesn't look good by itself.
>
> Do you really believe that commit is going crippling SELINUX?

Well, in a way, yes.

What it does is that it overrides the system's default policy. Which
may make sense, as for example your system policy may deny some
operations the tests do, eventually resulting in failed tests.
Though as a side-effect it also prevents writing the security label
file attribute by design with the mount option override. In such a
case SELinux just returns with -EOPNOTSUPP.

3213         sbsec =3D selinux_superblock(inode->i_sb);
3214         if (!(sbsec->flags & SBLABEL_MNT))
3215                 return -EOPNOTSUPP;
...                  ^^^^^^^^^^^^^^^^^^^

The documentation says that this option is usually used with external
devices like USB flash key-drives or filesystems where you do not want
to mess/break their labels. Like mounting a filesystem from another
machine.
Or eventually this option can be used for filesystems which do not
support extended file attributes, like for example the FAT filesystem.
In that case all files inherit the forced mount label and SELinux
treats them using that context.

> All it does are just:
>
> - Allow scratch mount filter to ripple off selinux context
>    This is only to make certain golden output to skip the SElinux ones.
>
> - Make sure scratch mount follows the SELINUX context
>
> Please explain why you believe that commit "cripples" the whole SELinux
> thing.

Well, maybe not cripples. It overrides the system policy.

The SELinux is always tested, just with different options/configuration.

Thinking about it again, I guess fstests are not supposed to test the
SELinux policy and it's better to override it. SELinux should have
it's own tests after all.

That said, I'm fine with dropping the first hunk when merged.

Thank you for the review, btw.

> >
> > At least I'd say it's good for diversity to have one test different.
> > Diverse tests are prefered with testing, right?
>
> What diversity? You just ripped off the whole SELinux for this test
> case, that's killing the diversity.
>
> Reasons please, and "just to make it pass" doesn't count.
>
> >
> >> So please only fix the mount command (with the extra selinux mount
> >> option), without overriding the existing SElinux config.
> >>
> >> Thanks,
> >> Qu
> >>>
> >>> Anyways, this test is fine without forcing the default mount context,
> >>> which is more a bandaid for other fstests, IIUC. There's no need for
> >>> this option in this case, at least with my testing. Hence I disabled
> >>> it. Does it fail for you?
> >>>
> >>>> Thanks,
> >>>> Qu
> >>>>>>         $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo |
> >>>>>> _filter_xfs_io
> >>>>>>         _btrfs subvolume snapshot -r ${src} ${src}/snap1
> >>>>>
> >>>>>
> >>>>
> >>
>

