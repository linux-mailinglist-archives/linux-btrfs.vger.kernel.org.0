Return-Path: <linux-btrfs+bounces-10507-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAC59F57DD
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 21:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912421891BBE
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 20:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519071F9A98;
	Tue, 17 Dec 2024 20:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajFm7sCf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975DC15DBBA
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 20:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734467813; cv=none; b=k/JN9GEAAuaCvfbyvZy5KwUzA1iRcoipG7lYbVpsDz8J92Cy2rB19uBiMgBC4+2g76AoeU+7NE/ExdgXwhqkn92VP9D2EBQdpg4cvDEcltr9FnCfBvhuJ8pRkUOxpl7W4uzLCw/bIPIGq0y1l4pzLiX0TpYIOEWKMnRsx998fBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734467813; c=relaxed/simple;
	bh=hEbBfHY7GL5yCykBf8niDBqS6BG+C0+aY3OF0VqNgxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eeP0FelInVfJcDaGcUTwBHFCWfQHO4ZOJbCcy2wmQVJXBl2zFhcB07U3ZA9K4wiNqf5VKlFcThH/026ME3CYKIMGDO7vr4gvFPtZRhPLaVE3m0nxos/UV/MFR+xY7QTc51YuhO/zFgK4ylWQOtbMn7s0fW0XknDmwcGIC2YhCx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajFm7sCf; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4363ae65100so34195255e9.0
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 12:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734467809; x=1735072609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2xpoPQjDa0Ou+Qdlzt4vx3FpTHSPwFtu57+z1ZdT34=;
        b=ajFm7sCf/OHpfojbNuvOt8hqmZdsaETgKjy2Mm5jCW0X0ygbvA5IrZ9KoYF9/l6nZ+
         f3O7XRXwIcl2+0kcxSD2x/jNLb3BfAk3j2ohJspV+axRjReNcURQ1yQVw/56iq4OXKYk
         fv2IBs0Ob2+tD1BIUC4EwHh869GJRFpVVHjmF5mo42dTlrJ+DwDTJ/36WxapyFmEnt6U
         p+9I4K7ZxIUXK39DOxDKkbEOz7kC5ZFn0Bg2OEnpFAgrp8b0ytHa2Tzsb8d8iQMnUoRx
         dAIr09bQDU3NULP+Zo4uw/q2z0Q9xMuROJ/NgKkPYl6W5PJjYjZbtUAfrnVyUXLg0iBr
         8nlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734467809; x=1735072609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2xpoPQjDa0Ou+Qdlzt4vx3FpTHSPwFtu57+z1ZdT34=;
        b=dOXpSSFgBmqFYPZol9TwlsnMFYJ6HQzKzq1QjMQKS486Yj55Y5gtxH2abmYRrNoKQk
         pdb60lCVAlmioliV2peXL/sM3NDfIZnT96Wr/FTtV2gjkcSttPo73UbUPn8vv84kRMnn
         jb3eTpgXyj7O34TpREiVLNbHw7ZD8TvRhucuI0R+LxRmJEPU92S9bp7nsB7pS7WUNeQk
         x2Ws2TqX1qRdA8bbMaFgqHlKr6lszNsEhv0H/JHVg2fsSFflUdDiTDCDCfjWVQrZlNsO
         VHl7lc9t1g6lVA18Myc5svjKMJDeWh2F60hv4CAQGi2YrP81BC+JThM2BbaMx4Si5huB
         /4gw==
X-Forwarded-Encrypted: i=1; AJvYcCWvjEbMDCSsK/HbglORtGNGNuxf3ByREKP4ROKeFGij/Onaq4/GfVli0/21lhZ+3WKG5zRrAodxgg01uA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw312Sxr9ni25Gm0ZvL7P/KoDHfWXskraVfCPnS+UT/3b7nWEn6
	JSIGKnnCern7iBGXf4Um+bkkyDfn9u2b+Jge8hZaHRtT8CyNumoAxi3yK2lYBYWz1GGG2q9X/PQ
	5dJ0L6bEF1xLJL988AtiOanOsQMQrlY9c
X-Gm-Gg: ASbGnct3vEGlmncBBhOI4yvVEg5HAtE3j3VIYPygXJzwezM5gXQKgIwVSeMU5tslgVQ
	v+kBlf6t/RFQs3xNKmEG+M1OqRX1HdkjCSLZS
X-Google-Smtp-Source: AGHT+IEd0hZ8jGhVnPwRE4shCA/Y403+krhi2HnVeefD0dUvGeAKIp+SE50tsoYwMgXpBnMevEX3/hPGUi/bRCrb+yQ=
X-Received: by 2002:a5d:5889:0:b0:385:fc00:f5e1 with SMTP id
 ffacd0b85a97d-388e4d6a50cmr232026f8f.9.1734467808607; Tue, 17 Dec 2024
 12:36:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1734108739.git.beckerlee3@gmail.com> <5b02e350-8c28-42b2-8ccf-8ce76b4ca683@gmx.com>
 <62871028-9f70-48d2-9d46-3ae1f6a57505@gmx.com> <CAL3q7H733CPhUgtRuj_KCskSik1qXNbK7kdqyQb5XWvSJ4ARUw@mail.gmail.com>
In-Reply-To: <CAL3q7H733CPhUgtRuj_KCskSik1qXNbK7kdqyQb5XWvSJ4ARUw@mail.gmail.com>
From: Lee Beckermeyer <beckerlee3@gmail.com>
Date: Tue, 17 Dec 2024 14:36:12 -0600
Message-ID: <CAMNkDpChHpDFPi4JT08zhbygXSPHV-sbLz=fgW9Fe5ajp9s_tA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] reduce boilerplate code within btrfs
To: Filipe Manana <fdmanana@kernel.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 9:09=E2=80=AFAM Filipe Manana <fdmanana@kernel.org>=
 wrote:
>
> On Mon, Dec 16, 2024 at 10:07=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
> >
> >
> >
> > =E5=9C=A8 2024/12/17 07:50, Qu Wenruo =E5=86=99=E9=81=93:
> > >
> > >
> > > =E5=9C=A8 2024/12/16 01:56, Roger L. Beckermeyer III =E5=86=99=E9=81=
=93:
> > >> The goal of this patch series is to reduce boilerplate code
> > >> within btrfs. To accomplish this rb_find_add_cached() was added
> > >> to linux/include/rbtree.h. Any replaceable functions were then
> > >> replaced within btrfs.
> > >
> > > Since Peter has acknowledged the change in rbtree, the remaining part
> > > looks fine to me.
> > >
> > > The mentioned error handling bug will be fixed when I merge the serie=
s.
> > >
> > > Reviewed-by: Qu Wenruo <wqu@suse.com>
> >
> > Well, during merge I found some extra things that you can improve in th=
e
> > future.
>
> One more thing to improve in the future:
>
> - Run fstests and check that that are no tests failing after the changes.
>
> There's at least 1 test case failing after this patchset.
> The patch "btrfs: update prelim_ref_insert() to use rb helpers" breaks
> btrfs/287:
>
> $ ./check btrfs/287
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 debian0 6.13.0-rc2-btrfs-next-182+ #2
> SMP PREEMPT_DYNAMIC Tue Dec 17 11:02:25 WET 2024
> MKFS_OPTIONS  -- /dev/sdc
> MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
>
> btrfs/287 1s ... - output mismatch (see
> /home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad)
>     --- tests/btrfs/287.out 2024-10-30 07:42:47.901514035 +0000
>     +++ /home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad
> 2024-12-17 15:00:35.341110069 +0000
>     @@ -8,82 +8,82 @@
>      linked 8388608/8388608 bytes at offset 16777216
>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>      resolve first extent:
>     -inode 257 offset 16777216 root 5
>     -inode 257 offset 8388608 root 5
>      inode 257 offset 0 root 5
>     +inode 257 offset 8388608 root 5
>     ...
>     (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/287.out
> /home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad'  to see
> the entire diff)
>
> HINT: You _MAY_ be missing kernel fix:
>       0cad8f14d70c btrfs: fix backref walking not returning all inode ref=
s
>
> Ran: btrfs/287
> Failures: btrfs/287
> Failed 1 of 1 tests
>
> So please fix the patch (or patches) and resend the updated version once =
fixed.
> Meanwhile it should be dropped from for-next.
>
> Thanks.
>
Found the problem, it's in prelim_ref_cmp in fs/btrfs/backref.c, if
you invert the comparison between the parent and node it passes the
test. e.g. prelim_ref_compare(ref2, ref1); instead of
prelim_ref_compare(ref1, ref2);

I can dig into it but I've got a couple of other things in the queue
right now so it might be a little bit. prelim_ref_cmp() could do with
a logic rework as well as prelim_ref_compare() is only used in 2
places within backref.c. It's just outside the scope of this patch
series so I didn't dig too deep into it.
>
> >
> > - The length of each code line
> >    Although we no longer have the older strict 80 chars length limit,
> >    check_patch.pl will still warn about lines over 100 chars.
> >    Several patches triggered this.
> >
> >    So please use check_patch.pl or just use btrfs workflow instead.
> >
yee, I haven't built a really good workflow for kernel submissions yet.
> > - The incorrect drop of const prefix in the last patch
> >    Since the comparison function accepts one regular node and one const
> >    node, the last patch drops the second const prefix, mostly due to
> >    the factg that comp_refs() doesn't have const prefix at all for both
> >    parameters.
> >
> >    The proper fix is to add const prefixes for involved functions, not
> >    dropping the existing const prefixes.
> >
Okay, however, what do const keywords do that would require this
habit? There's also a place in backref.c where I didn't implement
const keywords.
> >    I have also make all internal structure inside those helpers to be
> >    const.
> >    (Personally speaking I also want to check if the less() and cmp() ca=
n
> >     be converted to accept both parameters as const in the future)
> >
> > - Upper case for the first letter of a sentence
> >    I'm not good at English either, but at least for the commit message,
> >    the first letter of a sentence should be in upper case.
Gotcha, I can work on rewording those descriptions, just didn't seem
very important compared to validating everything works properly.
> >
> > - Minor code style problems
> >    IIRC others have already address the problem like:
> >
> >         int result;
> >
> >         result =3D some_function();
> >         return result;
> >
> >    Which can be done by a simple "return some_function();".
Where was this? I probably missed one when I went through these, sorry.

Just to summarize, would you like me to resend the patch series with
the below changes?
- updated prelim_ref_compare to eliminate comparison error
- rescanned with scripts/checkpatch.pl
- whatever needs to be done with consts.

Thanks for your time!
Lee
> >
> > Thanks,
> > Qu
> >
> > >
> > > Thanks,
> > > Qu
> > >>
> > >> changelog:
> > >> updated if() statements to utilize newer error checking
> > >> resolved lock error on 0002
> > >> edited title of patches to utilize update instead of edit
> > >> added Acked-by from Peter Zijlstra to 0001
> > >> eliminated extra variables throughout the patch series
> > >>
> > >> Roger L. Beckermeyer III (6):
> > >>    rbtree: add rb_find_add_cached() to rbtree.h
> > >>    btrfs: update btrfs_add_block_group_cache() to use rb helper
> > >>    btrfs: update prelim_ref_insert() to use rb helpers
> > >>    btrfs: update __btrfs_add_delayed_item() to use rb helper
> > >>    btrfs: update btrfs_add_chunk_map() to use rb helpers
> > >>    btrfs: update tree_insert() to use rb helpers
> > >>
> > >>   fs/btrfs/backref.c       | 71 ++++++++++++++++++++----------------=
----
> > >>   fs/btrfs/block-group.c   | 41 ++++++++++-------------
> > >>   fs/btrfs/delayed-inode.c | 40 +++++++++-------------
> > >>   fs/btrfs/delayed-ref.c   | 39 +++++++++-------------
> > >>   fs/btrfs/volumes.c       | 39 ++++++++++------------
> > >>   include/linux/rbtree.h   | 37 +++++++++++++++++++++
> > >>   6 files changed, 141 insertions(+), 126 deletions(-)
> > >>
> > >
> > >
> >
> >

