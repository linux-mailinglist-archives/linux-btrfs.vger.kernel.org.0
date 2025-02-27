Return-Path: <linux-btrfs+bounces-11911-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12279A481DF
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 15:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26BEF189929F
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 14:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2400235C1E;
	Thu, 27 Feb 2025 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O8wd9f/u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12452231A22
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740666991; cv=none; b=NDQt4RcZIRsoVgzPYLWX4emSbKSnLlCQ2nv7hAMWF70QSRLZW72r3+02fupmymq9L3dTO+QxVpP15mKZc1srlqM12UbS8y5zyiidxgD2Ef/TYPu2pUzDM1nr0MKkIorMsz1Z7wBv7d4FmbnSHonz7B37ipLvuC8trad/ljJ/1c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740666991; c=relaxed/simple;
	bh=qaw8+oYGrb3VtoDR75+qH+MtNUxFh7FY4GSfCj1qkPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b6uESbplxwCjIntBXHWlQQbazMEFJr+CA9ABJaiE8Ju4VyW/6zK/3LOhxs3ngNQW/06wjgn2bYPnF3faEec/FEWlUHrBjM9QNbpqyOS2b9Z0hr6MWL70lIpYM+jOJWNnIoaWoJTViLGbKHmWsFkNG5c+HWhyeVr35I2gMzW8gRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O8wd9f/u; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e0373c7f55so1446338a12.0
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 06:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740666987; x=1741271787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRamvwmKdk2aMVXe5uh5XvFcVb1nmIeiji8b1DHDW18=;
        b=O8wd9f/uXian8cET1jCee0w4bc/Y05BGMQ0iYpUUMktuPITZn2kNDKY3sLXZWp0GEL
         hsxMJL37JRB+cSEMYOMHh/U0Cs4moggXMdzRjNjoeOQI3Jfx9gSw5ChNVOVKsrX9PJV0
         /OLrxO3oCibC0jZYvPqJJnShfUe/N7LRqOw8gJnB9i1+ZgjZeuKHGvnFYiRSrWVZEImr
         ivHdlDM+ZEBGTfbsJpCRpmXYdLnTk+RqEt2MCDMxfJu/3TkRqQd/AnEtM7rhOVCsLBH2
         FfqYsyQNlS7WShHHPIBNPCb9sFJbqu7eYt/zY9e1HouzzFc6Ii379mpq//VLCu1mRuI9
         5yzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740666987; x=1741271787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRamvwmKdk2aMVXe5uh5XvFcVb1nmIeiji8b1DHDW18=;
        b=hjfFex5SRDtL/NpaUeQ+/t8JEzo8hKCoU2jaKR9by8zOC3f7LycRq3gev2T/shkV+Z
         /pzNSlgvXTI/rEihI+flnGG/2REw/yUJSRDxWcgKyfbJRvGZC8qHhwkGYPPhuPviSEPF
         WMrObVtVBJdg8LPsa4/3E/AxjYOJezguXzP9wMVP915T2q3KF+38tXqMAPL95kpxlxGy
         yMS9RtkwLDT4JbZ2IssH/Qw4Iq24mAjgeFX2vk3Pf+zcQ2q7tl/Gayy+YZaKSwiZatCk
         p5egTyYkETvj5fqmLs6NvqKuceKjNVOwDluszzWhtCeMJHHiuf+sJ22p9vI9z15+L35g
         SG4w==
X-Forwarded-Encrypted: i=1; AJvYcCX19ahYFtiBcTEygs4+4TFcPOco12Jn493I+EcYSsMq0pAWMpZ6/M+1nCgvVC+23tMkAkRIFQWJSI1qFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxWnmaYusbxvo1ePfMRV8zBXwXlKmd1so7UdDAPTgDtENPvLej
	B0aP0asJzdRBoz/lJzeO6vDl1o998StWqboVXGX0gP5UMaQ1HeLho3LZo5mCzUum85GDfaj2m5q
	LrJG9y3mFpxx1OjA4bQaMdgJ+2IsCJ2dAfdnlbzLRHGmRUGcr
X-Gm-Gg: ASbGnctDEUV1Eqn1b0yuTfWe+eVchON9EMg70Z86rMcgsmGWYeOXgIG+zJvhFmXsZEn
	Ja6+nRHSD9uMteAfPsxXamp+kS4/dvFtK3kvjzRB1Fm7NSB6Ua/2UM1SJNpYMHGPeb9mlE0yWyR
	oQcyFTyQ==
X-Google-Smtp-Source: AGHT+IGeSV1YnP9vKr/49JmDX1UETPkXx4c6UXNZmbmPWY1Qz/5OeWWMTzPVdNXT/Y1uEuKxnC01dK+S2G1oWNYnhYI=
X-Received: by 2002:a17:906:97ce:b0:abe:ef8b:6fb3 with SMTP id
 a640c23a62f3a-abeef8b767cmr832955066b.43.1740666987268; Thu, 27 Feb 2025
 06:36:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739608189.git.wqu@suse.com> <4e0368b2d4ab74e1a2cef76000ea75cb3198696a.1739608189.git.wqu@suse.com>
 <CAL3q7H5yrvxK5QFeCmfU+_sMmxpFyfcL_W8CALcCPLjkbbJHLQ@mail.gmail.com> <64782982-20d5-41e7-81d0-6960f3b5c0ee@gmx.com>
In-Reply-To: <64782982-20d5-41e7-81d0-6960f3b5c0ee@gmx.com>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 27 Feb 2025 15:36:16 +0100
X-Gm-Features: AQ5f1Jr6tw7QCvGa1asPrTDKeod-jhd3P6oWbTpr6ImEu5rtDK86jLbK_ZFuHSY
Message-ID: <CAPjX3FcqrQ-0PF1OxMzr=rNNwdz3M3vq5VQGGZFC-ndhdfSc7A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] btrfs: fix inline data extent reads which zero out
 the remaining part
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Feb 2025 at 23:39, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> =E5=9C=A8 2025/2/21 23:02, Filipe Manana =E5=86=99=E9=81=93:
> > On Sat, Feb 15, 2025 at 8:34=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> [BUG in DEVEL BRANCH]
> >> This bug itself can only be reproduced with the following out-of-tree
> >> patches:
> >>
> >>    btrfs: allow inline data extents creation if sector size < page siz=
e
> >
> > At least this patch could be part of this patchset no? It seems related=
.
> > It makes it harder to review with unmerged dependencies.
>
> Sure, I can merge all those patches into a much larger series.
>
> >
> >>    btrfs: allow buffered write to skip full page if it's sector aligne=
d
> >>
> >> With those out-of-tree patches, we can hit a data corruption:
> >>
> >>    # mkfs.btrfs -f -s 4k $dev
> >>    # mount $dev $mnt -o compress=3Dzstd
> >>    # xfs_io -f -c "pwrite 0 4k" $mnt/foobar
> >>    # sync
> >>    # echo 3 > /proc/sys/vm/drop_caches
> >>    # xfs_io -f -c" pwrite 8k 4k" $mnt/foobar
> >>    # md5sum $mnt/foobar
> >>    65df683add4707de8200bad14745b9ec
> >>
> >> Meanwhile such workload should result a md5sum of
> >>    277f3840b275c74d01e979ea9d75ac19
> >
> > So this is hard for us human beings to understand - we don't compute
> > checksums in our heads.
> > So something easier:
> >
> > # mkfs.btrfs -f -s 4k $dev
> > # mount $dev $mnt -o compress=3Dzstd
> > # xfs_io -f -c "pwrite -S 0xab 0 4k" $mnt/foobar
> > # sync
> > # echo 3 > /proc/sys/vm/drop_caches
> > # xfs_io -f -c "pwrite -S 0xcd 8k 4k" $mnt/foobar
> > # od -A d -t x1 $mnt/foobar
> >
> > Now display the result of od which is easy to understand and
> > summarises repeated patterns.
> > It should be obvious here that the expected pattern isn't observed,
> > bytes range 0 to 4095 full of 0xab and 8192 to 12K full of 0xcd.
> >
> > See, a lot easier for anyone to understand rather than comparing checks=
ums.
>
> Thanks a lot, will go that reproducer in the commit message.
> >
> >
> >>
> >> [CAUSE]
> >> The first buffered write into range [0, 4k) will result a compressed
> >> inline extent (relies on the patch "btrfs: allow inline data extents
> >> creation if sector size < page size" to create such inline extent):
> >>
> >>          item 6 key (257 EXTENT_DATA 0) itemoff 15823 itemsize 40
> >>                  generation 9 type 0 (inline)
> >>                  inline extent data size 19 ram_bytes 4096 compression=
 3 (zstd)
> >>
> >> Then all page cache is dropped, and we do the new write into range
> >> [8K, 12K)
> >>
> >> With the out-of-tree patch "btrfs: allow buffered write to skip full p=
age if
> >> it's sector aligned", such aligned write won't trigger the full folio
> >> read, so we just dirtied range [8K, 12K), and range [0, 4K) is not
> >> uptodate.
> >
> > And without that out-of-tree patch, do we have any problem?
>
> Fortunately no.
>
> > If that patch creates a problem then perhaps fix it before being
> > merged or at least include it early in this patchset?
>
> I'll put this one before that patch in the merged series.
>
> >
> > See, at least for me it's confusing to have patches saying they fix a
> > problem that happens when some other unmerged patch is applied.
> > It raises the doubt if that other patch should be fixed instead and
> > therefore making this one not needed, or at least if they should be in
> > the same patchset.
>
> But I'm wondering what's the proper way to handle such cases?
>
> Is putting this one before that patch enough?
>
> I really want to express some strong dependency, as if some one
> backported that partial uptodate folio support, it will easily screw up
> a lot of things.
>
> On the other hand, it's also very hard to explain why this patch itself
> is needed, without mentioning the future behavior change.
>
> Any good suggestions? Especially I'm pretty sure such pattern will
> happen again and again as we're approaching larger data folios support.

Perhaps an fstest which fails having the later patch without this one
would help?

