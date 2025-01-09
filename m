Return-Path: <linux-btrfs+bounces-10849-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F02AA07B84
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 16:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D57AF3A823F
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 15:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0783E21CA1B;
	Thu,  9 Jan 2025 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfCI4TNW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1857B21C194;
	Thu,  9 Jan 2025 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435702; cv=none; b=pNbXp9XIDomhDDWmP+VZjJBQqSEcRBcHmDE0A+smeHjOb1ks+W+E3J+D1pkYrRoE2W5cGx3QuUWwQwItSfr8HAKRNQh45J5cfOnCIvfnNMugXbWgfu78oiMAJDHeFvhA2Kex1UasGihXo/zCCSdZN9oTF+e50BrhJROE6IsvhCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435702; c=relaxed/simple;
	bh=G6cjQeUE0PVWGP6gyLK7N231grCngMFrB0NXMiraNyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EhQqsJhY35K1S1LAwDqtyT/5T9bAUjHy5hMfP8A1emMJr0FzLMLvIA3T0LgqMgJzeA13QQTCp5TjHtCFKBIYedLilYNDc4WckvmxB+IBi6DAHS+3pECvaj8SaSXurvGIlWqPEFz6xfh6muWJ6NiinQAMI8GCZc4UQfKUFdU5EQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfCI4TNW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958C4C4CED2;
	Thu,  9 Jan 2025 15:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736435701;
	bh=G6cjQeUE0PVWGP6gyLK7N231grCngMFrB0NXMiraNyI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FfCI4TNWNczB5uaBti9rkbT0XehqgZ/BR/zvwC7NpryIc809YN7+9IRZ/6OVl4auF
	 GhFNi3a05GpIxeg9oqQkuKj/pqApy8desyThTFXnUmxiruH0OmWIoExWRr2nnvpRjE
	 6xokvNExOyclOwklPm/YRcr5QniFGUHS8MTNOAMP7jk3bNN6daViTnYpRQ5IhrBV31
	 rAEqEOjtGV8+YSKM6IL5G1ftCV/v1Pod1YHWYMpLPD7Y2qhu0khSoGM2rZ8zMfVKnG
	 VQQGgkofDfOVE2S//Otl1/iLvfv3EI43i/NNXyqBGJF1qDN6+ptWlmbqljxODu20LT
	 qL8RVKzfD2hPA==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa6c0d1833eso231178566b.1;
        Thu, 09 Jan 2025 07:15:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV5gcsyEfQEG0eFpi7MP65QOnJ8zEYWPfkHDAa14GasuB5OeGdB7c7rjCDuCne4RrQGogAitfq2L9kayw==@vger.kernel.org, AJvYcCVB0UwpBQJhoxgSGIvrvl2dV8D3yNmAo5WwlV7515EkSibYzGYIbliG9tc8eWUsN/V01jhfoHLA6I0mHoCI@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuc1BVCZnAn7RydKl8lEowiRRGUqjCbjntfnBvYdLE+wrAN4JO
	FkpL6G9espb3CjAkJ3AOI5VgvHcnz4dtCyDie5a5Db5I6srhSNEAQ+SY+8VPFo/dzFXbQChTMmT
	zdAKZiaC3dqRhLfXbDo3a7j/qiGI=
X-Google-Smtp-Source: AGHT+IFnFOhff2BPQCGBc/RWzLJ0rY3bB+prRdRbF8PEHHhDhP8vExpCxTMZzgD0S0jMfd+aJGkhr/Wq1kXr/eXqStU=
X-Received: by 2002:a17:907:d1b:b0:aa6:ac9b:681f with SMTP id
 a640c23a62f3a-ab2abcab4c1mr776033466b.43.1736435700172; Thu, 09 Jan 2025
 07:15:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
 <20250107-rst-delete-fixes-v2-1-0c7b14c0aac2@kernel.org> <CAL3q7H58qoA1MjDG4aFbaGE5ddAJRgyNZ0rAyb+XhEqP20xKcA@mail.gmail.com>
 <ca324436-f214-468d-a769-fd4f236313c0@wdc.com>
In-Reply-To: <ca324436-f214-468d-a769-fd4f236313c0@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 9 Jan 2025 15:14:23 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6cMsTn2ZksQTKuZYKW-g668i=o564sGMKGb1h2i06ohA@mail.gmail.com>
X-Gm-Features: AbW1kvabPDjQtbfEp-MjEntxEnl59eaKwkyxzT7C5hOj_va-Y82SARC8cO1YGao
Message-ID: <CAL3q7H6cMsTn2ZksQTKuZYKW-g668i=o564sGMKGb1h2i06ohA@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] btrfs: don't try to delete RAID stripe-extents
 if we don't need to
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 2:39=E2=80=AFPM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 09.01.25 13:35, Filipe Manana wrote:
> >> diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/=
raid-stripe-tree-tests.c
> >> index 30f17eb7b6a8a1dfa9f66ed5508da42a70db1fa3..f060c04c7f76357e6d2c6b=
a78a8ba981e35645bd 100644
> >> --- a/fs/btrfs/tests/raid-stripe-tree-tests.c
> >> +++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
> >> @@ -478,8 +478,9 @@ static int run_test(test_func_t test, u32 sectorsi=
ze, u32 nodesize)
> >>                  ret =3D PTR_ERR(root);
> >>                  goto out;
> >>          }
> >> -       btrfs_set_super_compat_ro_flags(root->fs_info->super_copy,
> >> +       btrfs_set_super_incompat_flags(root->fs_info->super_copy,
> >>                                          BTRFS_FEATURE_INCOMPAT_RAID_S=
TRIPE_TREE);
> > This hunk seems unrelated to the rest of the patch, could be fixed in
> > a different patch in case it actually solves any problem (probably
> > not, but it's an incompat feature so it should be changed anyway).
>
> I'll make it a separate patch. RST is an incompat feature not a compat on=
e.
>
> With this patch btrfs_delete_raid_extent() starts checking the incompat
> bit so it is fixing a 'problem'.

Yes, but for that all that's needed is this call:

btrfs_set_fs_incompat(root->fs_info, RAID_STRIPE_TREE);

Right?

Replacing the btrfs_set_super_compat_ro_flags() call with a call to
btrfs_set_super_incompat_flags() shouldn't be needed for this patch.
That's what I was referring to.

