Return-Path: <linux-btrfs+bounces-11690-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B245EA3F36F
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 12:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0039719C00B1
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 11:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E9820ADFE;
	Fri, 21 Feb 2025 11:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="grxI6YwT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4352320ADEC
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2025 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740138807; cv=none; b=XGDyI4cxMd7C+aPKexh/8DGzh3OOMz1lAU88i5JreB8SLH0mvMt/OFFj72FVKMgcIxEwz5uKOiczm94oKgFzFtKhqVPvFUy9MnDV6OLtKFx6m4pHeYijcd3ISWvgPBjXQt9Hkqtf4G2NUPYw6bjvAjsubOkLgBU9//TqxJi7RYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740138807; c=relaxed/simple;
	bh=TRoSBhXBDEA5b1z0U36Nw78wrO5SCdHSKDjVtDc/nZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/H76SvOqd78ddaCuIurWb834I63quDFkSrHUM9FZf3q4fzouudfEUUWbvg6ZgBp89blibedoGnUJpHSvA3GNtGeZlLLMCYHMDRd4uVxSAXM7WnaQvi6biuBRe/i2vFnSI+HJhRVjApEwOBrCm1JlYjcLpt8Yho6coQxUZu4UcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=grxI6YwT; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso345118666b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2025 03:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740138803; x=1740743603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+q1LwbTpGdeJRSKQY1Kxiac2D5amYXclDCWSkZ8cRE=;
        b=grxI6YwTigD6pqgOFr1DbVf2/Bccg6aOj+iiECrMs4nKq8qA64eazdeYrc5pmAZgxx
         jbl1+wlww9jpYW9NxrArplXaT+ODp6NpVg5jpuFby8FqG6TngpZ2dMxQVCG17BjN03w/
         SMiHeEk+3sv93kwgrq26smhvKyuItxFZ6cfYB1UZSzg6o6YGnK10Vdarx8XrR6GZCDfI
         T1czVOpMYw+X9L5LyLNOX8F1XACr0hU5YkHPjfxnY1nqLilKNvC+VV07HiKv9dyE2KrE
         tmNpBiQVcIqqLYe/tzALYecSLSjipOFb3MI8b6vjiROogT9iSbul/gY3dsuZ2FPbDRI4
         TftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740138803; x=1740743603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+q1LwbTpGdeJRSKQY1Kxiac2D5amYXclDCWSkZ8cRE=;
        b=IwY7AjXACxQhmhR+RAPp8SNVufCPw3LDgx5FB+xEBo2dxCEO10+OMiuiwkmvNzjjoV
         ixPu5+8UlgExxasODtkNacPeenAi8XxgAsIIBaAvR16YC5Fvl12tmJ78gSoS2ojraQSs
         CC+jhR1NggGBghh3lwJ8DOH1/n4vYdNuNcdK87WrnS+gXC2lZy/JtPZGw9EOdEDA0CqI
         qOUBbDQrsEf4Jt07K78qn1ptRVV2fUfkX0D0yFevqSsnD9CbqK+xRdHbnuAQN9SJIql2
         f+/lwoB8Elvf7ps9QUE0wLCVFPln1Ldk+PbjcDJuYq9/fB1BF2+6D2IBuTz0CMAR/8rr
         1Jtg==
X-Forwarded-Encrypted: i=1; AJvYcCX6+5xyg7QXY2o8DMOSyN5WAGtWeI3VDpAzlOdW1i8HrpwzqP+OHvqKtyKjesOTPukIRtA4WuvKm/xjrw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLomQeTazSRgBhJT4gW+BEbTnDKLAQPNZCxusdnY2MYdoLcKW9
	VdkygJRFlPbYIwQvZWOS3kNbuvIcMSaU1MBQ0/E/LP/M0ueYnAZuvodZgIJy8wuYrK5a0hNDydg
	JhJNx5yhDMdoP9110hTsGHkpZ0rxGHSW/C6Nbztj+eofKH4rNOhA=
X-Gm-Gg: ASbGnctPt1axekBKF/SxYBoaQWRj7goY6QnFhAKgMEvEMqKib4RHX5gI/GDOC7ugKGU
	31TVtLc4WHnhrXedMbQLsHiTZizk8Goso1EwBF637N6ONX/yHj9Cc7S44sNUTjhtZynYbK6uKfH
	HDcz1WyQ==
X-Google-Smtp-Source: AGHT+IHgE9E509oYktt9+jmj1xQrumpWkttOq5ngUzsnDsIIGBGYR/h+zbWrhVLScwXoJo54x47wBh1OBKi584FVdyo=
X-Received: by 2002:a17:907:7e90:b0:abb:c7d2:3a65 with SMTP id
 a640c23a62f3a-abc09bf5267mr284852766b.39.1740138803334; Fri, 21 Feb 2025
 03:53:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220145723.1526907-1-neelx@suse.com> <d84d2d83-03ac-4741-9677-52c71e1fb36d@suse.com>
 <c0a4b4a0-268c-42f3-b117-b87b2fb12a03@suse.com> <CAPjX3Fem-=D8dxyR1MGTQVskkzdijmc7k82+f5_S_YyBJ_Orsg@mail.gmail.com>
 <6bbfddea-f0ea-4825-a987-01be3ff18a23@suse.com> <CAPjX3Fc=E28A6zD4tJOT2bRZ-pnErVKzkYuzALt6soGLu=MRJQ@mail.gmail.com>
 <a2ae2321-4934-4a10-8a44-2f7dc3bf48c3@suse.com> <CAPjX3Fes+PDEyi4_tFJyRHePVVuv_K+nUfShEeuagOANd6VqfQ@mail.gmail.com>
 <61afcaa2-01ff-4d18-a8fa-804fe36464cb@gmx.com>
In-Reply-To: <61afcaa2-01ff-4d18-a8fa-804fe36464cb@gmx.com>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 21 Feb 2025 12:53:12 +0100
X-Gm-Features: AWEUYZlPGVrW65upd2CUI5XjyKL2nHFdUPNy53B73oX8rqeErufRB9VDjgzSOiQ
Message-ID: <CAPjX3FcnofHyQzHvP_R0CWWML2EVC-PmPY9k90X+ddWWPFxhBw@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs/314: fix the failure when SELinux is enabled
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Anand Jain <anand.jain@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Feb 2025 at 10:48, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> =E5=9C=A8 2025/2/21 19:43, Daniel Vacek =E5=86=99=E9=81=93:
> > On Fri, 21 Feb 2025 at 09:20, Qu Wenruo <wqu@suse.com> wrote:
> [...]
> >> Remember, user can provide their own mount options (including the
> >> SELinux ones) through MOUNT_OPTIONS environmental variables.
> >>
> >> So you at least need a full reason why SElinux context must be disable
> >> for this case.
> >> And I see none.
> >
> > It does not need to be disabled. But it also does not have to be
> > enabled for this test.
>
> Then good lucky if one day some QA guy finds out the send/receive
> behavior has a SELINUX specific bug, and you need to explain to them why
> it's a good idea to not test SELinux for this particular workload.
>
> Your mindset of "XX feature doesn't have to be tested" makes nosense for
> a test suite.

Huh, this is a huge misunderstanding.You still got it the other way
around. I'm sorry if I was confusing you.
I never said I'm against testing SELinux. Quite the opposite, to be
honest. I did argue that testing the default system policy without
overriding the context also works for this test, at least with my
testing on the latest TW.
SELinux is always tested. Just either with the default system policy
or with the given forced context.

> > At least not with the default policy on the latest Tumbleweed I was tes=
ting on.
> >
> > But your mileage may vary, I guess.
> >
> >>>
> >>> Or do you use such an option with any of your mounts? I doubt so.
> >>>
> >>> Check the mentioned commit 3839d299. fstests cripple SELinux by
> >>> default. Which doesn't look good by itself.
> >>
> >> Do you really believe that commit is going crippling SELINUX?
> >
> > Well, in a way, yes.
> >
> > What it does is that it overrides the system's default policy. Which
> > may make sense, as for example your system policy may deny some
> > operations the tests do, eventually resulting in failed tests.
> > Though as a side-effect it also prevents writing the security label
> > file attribute by design with the mount option override. In such a
> > case SELinux just returns with -EOPNOTSUPP.
> >
> > 3213         sbsec =3D selinux_superblock(inode->i_sb);
> > 3214         if (!(sbsec->flags & SBLABEL_MNT))
> > 3215                 return -EOPNOTSUPP;
> > ...                  ^^^^^^^^^^^^^^^^^^^
>
> This only explains why your mount option fix is correct.

Nope. This triggers precisely when the context is forced with the
mount option. In that case setting the file attribute is not
supported.

> The send stream has SELinux attrs, that's because the original fs is
> mounted with SELinux context (the regular _scratch_mount() helper added
> SELinux context).

Nope. Again, the other way around. The send stream has the
`security.selinux` attribute precisely because the mount was missing
the option and hence the file labels were used (and not refused). But
the receive side fails as that mount actually did use the context
mount option and so it was refusing setting the file label returning
this -EOPNOTSUPP error.

> But later we manually mounted a btrfs, not using _scratch_mount(), thus
> the new mounted btrfs doesn't have SELinux context, thus unable to set
> the SELinux attrs at receive side.

This is just wrong.

> It doesn't show why you need both the mount fix and overriding SELINUX
> context at all.

I'm saying you don't need both from the very beginning. Where did I say you=
 do?

> >
> >> All it does are just:
> >>
> >> - Allow scratch mount filter to ripple off selinux context
> >>     This is only to make certain golden output to skip the SElinux one=
s.
> >>
> >> - Make sure scratch mount follows the SELINUX context
> >>
> >> Please explain why you believe that commit "cripples" the whole SELinu=
x
> >> thing.
> >
> > Well, maybe not cripples. It overrides the system policy.
> >
> > The SELinux is always tested, just with different options/configuration=
.
>
> Not if you override the SELINUX context, then the test case will never
> have SELinux tested.

Wrong. SELinux is always tested. Either with the system-defined policy
or the overridden context.

> And you never know if someone in the future will find a bug in
> send/receive with SElinux enabled.

More likely you may find the test failing in the future as you'd be
testing on a distribution which changed it's policy to forbid access
to /mnt path. Or you configure fstests to mount somewhere else where
it's forbidden by the default system policy.

Again, SELinux is always tested. And it may just be easier for fstests
to force the context to prevent test failures due to the system
default policy. That's why I also said that I'm fine with dropping
that hunk.

> And I do not think your "combining two working fixes is fine" mindset
> makes any sense either.

One is a fix, one is a configuration. You change the configuration
(ie, keep the default system policy, no forced context) and it works.
You apply the fix and it works no matter what configuration.

So the configuration does not really need to be changed, which I'm
saying from the beginning. But I left it there as no biggie. Now,
after the discussion with you, I agree that fstests may be better
forcing the context explicitly instead of relying on the default
system policy.

> Every fix should have a reason, if you have different ways to fix a test
> case, you need to evaluate the pros and cons.

The pro was to test the real thing and not force override it. But that
may not be a good idea for fstests.

> Overriding SElinux means we will never test SElinux for this particular
> workload, which is not a small trade-off.

Wrong. Again, SELinux is always used and tested. Only the policy is
overridden or the default one.

> Fixing the mount command brings no obvious problem.
>
> So the choice should be obvious.
>
> But combining the two? You have all the cons (no more SElinux for this
> test case), but not any new benefit.

You're just confused by what the configuration changes. SELinux is still te=
sted.

> >
> > Thinking about it again, I guess fstests are not supposed to test the
> > SELinux policy and it's better to override it.
>
> It not your call.

Agreed. The intention was to cover it as an additional bonus but in
the end that may not be wanted. In the end I agree fstests may be
better to force the given context and not be eventually broken by the
default system policy. Eventhough it does not seem likely to happen at
this point.

> > SELinux should have
> > it's own tests after all.
>
> Say it again loud to all the SElinux guys, and better CC them.

What I meant is that for sure they have way more fundamental tests
then checking the correctness of the applied policy. That's more a
user/devops thing. That's what we're talking here about, whether to
use one policy or the other. Not whether to use SELinux as it's
enabled in both cases.

> >
> > That said, I'm fine with dropping the first hunk when merged.
> >
> > Thank you for the review, btw.
> >
> >>>
> >>> At least I'd say it's good for diversity to have one test different.
> >>> Diverse tests are prefered with testing, right?
> >>
> >> What diversity? You just ripped off the whole SELinux for this test
> >> case, that's killing the diversity.
> >>
> >> Reasons please, and "just to make it pass" doesn't count.
> >>
> >>>
> >>>> So please only fix the mount command (with the extra selinux mount
> >>>> option), without overriding the existing SElinux config.
> >>>>
> >>>> Thanks,
> >>>> Qu
> >>>>>
> >>>>> Anyways, this test is fine without forcing the default mount contex=
t,
> >>>>> which is more a bandaid for other fstests, IIUC. There's no need fo=
r
> >>>>> this option in this case, at least with my testing. Hence I disable=
d
> >>>>> it. Does it fail for you?
> >>>>>
> >>>>>> Thanks,
> >>>>>> Qu
> >>>>>>>>          $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo |
> >>>>>>>> _filter_xfs_io
> >>>>>>>>          _btrfs subvolume snapshot -r ${src} ${src}/snap1
> >>>>>>>
> >>>>>>>
> >>>>>>
> >>>>
> >>
> >
>

