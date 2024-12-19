Return-Path: <linux-btrfs+bounces-10612-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2859F7EEC
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2024 17:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6B271886BBE
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2024 16:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657F1226182;
	Thu, 19 Dec 2024 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PivwlS5O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D083225785
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Dec 2024 16:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734624461; cv=none; b=UH18Y6EXU0VxKa50pg9AV8VhaWo8TUPhuZGYSU2WPT7HCs+bH7KXVEHpuS9lI4hEBC3vkULpJOaDQ0w/3SufMoZ8D+1eeuR2OJtieQfxH0S/Yrn8h3GQnIsJQMYjAfAXI7+fbiV506mSD2fAFMEJs5HIQcaZO63gLTxDW8p/4vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734624461; c=relaxed/simple;
	bh=KsP5e2qKpttKNWEQg5wuTR5fvDesf6OaQ0f4SGy+B+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZM81tpi/AuyquwV+gD2Clg+yL/ZZq7niD4/Fjkjv/e8biDKITEEg4xu7/eLqCiiv57tuehoOku9nOC8IoiFiApoU8O9itLeRZCP1IoLymxeovSIEDciIaW31jRFpz/NKYU4IjlUlNpvbrMoLyg9qTb1nw3r0PbvC6Ca3KmIvXCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PivwlS5O; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385d7f19f20so505228f8f.1
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Dec 2024 08:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734624458; x=1735229258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkf+lGCko0tmFRgPo8sHmVbcSO5facse1i35K7fMEp4=;
        b=PivwlS5OvgrUKOgiwjMqyr7e+Yxxot32akeayRCxRmNfXJgu4hiDSy41Nov6Q293hc
         5Imq8pNOKPik2oAGqRm1/+FWbdTn/wE2i5LKAHLJOg1BXTwuspdAAvDV6xnMq1vQhr/9
         yCshFRBoj028vBp74pq9ao3k8TR9gQlOJUXvqpIiN3Ljp8JO6mLpM3yjC14biLpQ8IwJ
         1fmnH/CjBbOF7J5r86qgmMbz5s2VcjyrYFAPPQiY4Cw7nq2UX2dXulHZAKqjheamYNF4
         jb/sOuYChQHfr6U3N938q0c+VvL/gCa8DxZKp4lEegSmchHeohsDqc9jr5bBbNhcjIhg
         GM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734624458; x=1735229258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkf+lGCko0tmFRgPo8sHmVbcSO5facse1i35K7fMEp4=;
        b=QFoFZwViZpKTqW1D5FUqznK/smEQLB1LQC5awXf7I1RxPSNP0zVjoxL4svDHVi0KU8
         2cEW1D9aqkc5Upp0a7gqSQC3Cr+1VlD0sJY3AKIK1amA5zNJ9riBvPZfUpLSSk16PRqR
         jYbkIGubOXRLgcL6J5XzLGWmYtslDw0LEfKG1/RJYemPf0drNP8nuM1yMtCyV26B9rhM
         99qtpMbo6mhBzv0SdPWozw3C1t8k9KCQ4T6W4c3UjyTzScYwCzGdFwb/Yr+J8xRQcmN5
         ncuPDuN135FEoPcvmR1iTyhuLeg/15w1qqqDLCFnPtsbx/lQsFaHHLMYFQGanKgTm67E
         dSXA==
X-Forwarded-Encrypted: i=1; AJvYcCX8ScrTuBSYXkpanJBK6kme3lS+wvu7dbJjY9/YYYLNmXVSWbGDiGHatPb0LrIVkg19p2s1b+AWwQF1fQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqwDc31U7UeCocU78IXqFKIjBg1Vmgm0EvdNuO+eMGrus+7fit
	5L0srT73BBW5Lgi7n9x0an5RErtDQSW18+5g9K5p2lbArNaGkRJzzzDkqkV0AagX0UdSdIaHvfN
	0BEornzIPXR7KnDg1DL0EM173RHo=
X-Gm-Gg: ASbGncu8imFC35sqqPlLTC9u3Co8/9xJ9EYde6KtqY22lvMacQuqXjffUVlwvXovyZT
	NEcXiwzwR3iZT79NWZTrb/edd+NDU6JrdWVUP
X-Google-Smtp-Source: AGHT+IFUc6axFSOY1ruC1k9nWZWrok0gvgxEsVq9wV5s0Oi4FBjxvENQbhmH4c63QCWe18meJBsNg9f8DZvvPw+EM8c=
X-Received: by 2002:a5d:64cf:0:b0:385:f349:ffe7 with SMTP id
 ffacd0b85a97d-388e4d2f488mr8289592f8f.2.1734624457493; Thu, 19 Dec 2024
 08:07:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1734108739.git.beckerlee3@gmail.com> <5b02e350-8c28-42b2-8ccf-8ce76b4ca683@gmx.com>
 <62871028-9f70-48d2-9d46-3ae1f6a57505@gmx.com> <CAL3q7H733CPhUgtRuj_KCskSik1qXNbK7kdqyQb5XWvSJ4ARUw@mail.gmail.com>
 <CAMNkDpChHpDFPi4JT08zhbygXSPHV-sbLz=fgW9Fe5ajp9s_tA@mail.gmail.com> <d2af3a37-8486-4c95-b38e-7671466127f6@gmx.com>
In-Reply-To: <d2af3a37-8486-4c95-b38e-7671466127f6@gmx.com>
From: Lee Beckermeyer <beckerlee3@gmail.com>
Date: Thu, 19 Dec 2024 10:07:02 -0600
Message-ID: <CAMNkDpBqegfqF1UyH92=EzXhk700gRRTrBAZ0V7x80N5MESM4g@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] reduce boilerplate code within btrfs
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Filipe Manana <fdmanana@kernel.org>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 2:49=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/12/18 07:06, Lee Beckermeyer =E5=86=99=E9=81=93:
> > On Tue, Dec 17, 2024 at 9:09=E2=80=AFAM Filipe Manana <fdmanana@kernel.=
org> wrote:
> >>
> >> On Mon, Dec 16, 2024 at 10:07=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx=
.com> wrote:
> >>>
> >>>
> >>>
> >>> =E5=9C=A8 2024/12/17 07:50, Qu Wenruo =E5=86=99=E9=81=93:
> >>>>
> >>>>
> >>>> =E5=9C=A8 2024/12/16 01:56, Roger L. Beckermeyer III =E5=86=99=E9=81=
=93:
> >>>>> The goal of this patch series is to reduce boilerplate code
> >>>>> within btrfs. To accomplish this rb_find_add_cached() was added
> >>>>> to linux/include/rbtree.h. Any replaceable functions were then
> >>>>> replaced within btrfs.
> >>>>
> >>>> Since Peter has acknowledged the change in rbtree, the remaining par=
t
> >>>> looks fine to me.
> >>>>
> >>>> The mentioned error handling bug will be fixed when I merge the seri=
es.
> >>>>
> >>>> Reviewed-by: Qu Wenruo <wqu@suse.com>
> >>>
> >>> Well, during merge I found some extra things that you can improve in =
the
> >>> future.
> >>
> >> One more thing to improve in the future:
> >>
> >> - Run fstests and check that that are no tests failing after the chang=
es.
> >>
> >> There's at least 1 test case failing after this patchset.
> >> The patch "btrfs: update prelim_ref_insert() to use rb helpers" breaks
> >> btrfs/287:
> >>
> >> $ ./check btrfs/287
> >> FSTYP         -- btrfs
> >> PLATFORM      -- Linux/x86_64 debian0 6.13.0-rc2-btrfs-next-182+ #2
> >> SMP PREEMPT_DYNAMIC Tue Dec 17 11:02:25 WET 2024
> >> MKFS_OPTIONS  -- /dev/sdc
> >> MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> >>
> >> btrfs/287 1s ... - output mismatch (see
> >> /home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad)
> >>      --- tests/btrfs/287.out 2024-10-30 07:42:47.901514035 +0000
> >>      +++ /home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad
> >> 2024-12-17 15:00:35.341110069 +0000
> >>      @@ -8,82 +8,82 @@
> >>       linked 8388608/8388608 bytes at offset 16777216
> >>       XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >>       resolve first extent:
> >>      -inode 257 offset 16777216 root 5
> >>      -inode 257 offset 8388608 root 5
> >>       inode 257 offset 0 root 5
> >>      +inode 257 offset 8388608 root 5
> >>      ...
> >>      (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/287.out
> >> /home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad'  to see
> >> the entire diff)
> >>
> >> HINT: You _MAY_ be missing kernel fix:
> >>        0cad8f14d70c btrfs: fix backref walking not returning all inode=
 refs
> >>
> >> Ran: btrfs/287
> >> Failures: btrfs/287
> >> Failed 1 of 1 tests
> >>
> >> So please fix the patch (or patches) and resend the updated version on=
ce fixed.
> >> Meanwhile it should be dropped from for-next.
> >>
> >> Thanks.
> >>
> > Found the problem, it's in prelim_ref_cmp in fs/btrfs/backref.c, if
> > you invert the comparison between the parent and node it passes the
> > test. e.g. prelim_ref_compare(ref2, ref1); instead of
> > prelim_ref_compare(ref1, ref2);
> >
> > I can dig into it but I've got a couple of other things in the queue
> > right now so it might be a little bit. prelim_ref_cmp() could do with
> > a logic rework as well as prelim_ref_compare() is only used in 2
> > places within backref.c. It's just outside the scope of this patch
> > series so I didn't dig too deep into it.
>
> It's not the parameter order, it's the problem related to the parent/ref
> usage.
>
> Previously during the insert we update the parent/ref pointer during the
> search, but it's no longer the case, thus the whole if (exist) {} branch
> is wrong.
>
> >>
> >>>
> >>> - The length of each code line
> >>>     Although we no longer have the older strict 80 chars length limit=
,
> >>>     check_patch.pl will still warn about lines over 100 chars.
> >>>     Several patches triggered this.
> >>>
> >>>     So please use check_patch.pl or just use btrfs workflow instead.
> >>>
> > yee, I haven't built a really good workflow for kernel submissions yet.
> >>> - The incorrect drop of const prefix in the last patch
> >>>     Since the comparison function accepts one regular node and one co=
nst
> >>>     node, the last patch drops the second const prefix, mostly due to
> >>>     the factg that comp_refs() doesn't have const prefix at all for b=
oth
> >>>     parameters.
> >>>
> >>>     The proper fix is to add const prefixes for involved functions, n=
ot
> >>>     dropping the existing const prefixes.
> >>>
> > Okay, however, what do const keywords do that would require this
> > habit? There's also a place in backref.c where I didn't implement
> > const keywords.
> >>>     I have also make all internal structure inside those helpers to b=
e
> >>>     const.
> >>>     (Personally speaking I also want to check if the less() and cmp()=
 can
> >>>      be converted to accept both parameters as const in the future)
> >>>
> >>> - Upper case for the first letter of a sentence
> >>>     I'm not good at English either, but at least for the commit messa=
ge,
> >>>     the first letter of a sentence should be in upper case.
> > Gotcha, I can work on rewording those descriptions, just didn't seem
> > very important compared to validating everything works properly.
> >>>
> >>> - Minor code style problems
> >>>     IIRC others have already address the problem like:
> >>>
> >>>          int result;
> >>>
> >>>          result =3D some_function();
> >>>          return result;
> >>>
> >>>     Which can be done by a simple "return some_function();".
> > Where was this? I probably missed one when I went through these, sorry.
> >
> > Just to summarize, would you like me to resend the patch series with
> > the below changes?
> > - updated prelim_ref_compare to eliminate comparison error
> > - rescanned with scripts/checkpatch.pl
> > - whatever needs to be done with consts.
>
> I'll handle the error fix.
>
> Since I have already changed the series a lot, your update will get all
> the existing modification lost.
>
> Thanks,
> Qu
Sounds good, let me know if you need anything else on this patch
series from me then.

Thanks,
Lee
>
> >
> > Thanks for your time!
> > Lee
> >>>
> >>> Thanks,
> >>> Qu
> >>>
> >>>>
> >>>> Thanks,
> >>>> Qu
> >>>>>
> >>>>> changelog:
> >>>>> updated if() statements to utilize newer error checking
> >>>>> resolved lock error on 0002
> >>>>> edited title of patches to utilize update instead of edit
> >>>>> added Acked-by from Peter Zijlstra to 0001
> >>>>> eliminated extra variables throughout the patch series
> >>>>>
> >>>>> Roger L. Beckermeyer III (6):
> >>>>>     rbtree: add rb_find_add_cached() to rbtree.h
> >>>>>     btrfs: update btrfs_add_block_group_cache() to use rb helper
> >>>>>     btrfs: update prelim_ref_insert() to use rb helpers
> >>>>>     btrfs: update __btrfs_add_delayed_item() to use rb helper
> >>>>>     btrfs: update btrfs_add_chunk_map() to use rb helpers
> >>>>>     btrfs: update tree_insert() to use rb helpers
> >>>>>
> >>>>>    fs/btrfs/backref.c       | 71 ++++++++++++++++++++--------------=
------
> >>>>>    fs/btrfs/block-group.c   | 41 ++++++++++-------------
> >>>>>    fs/btrfs/delayed-inode.c | 40 +++++++++-------------
> >>>>>    fs/btrfs/delayed-ref.c   | 39 +++++++++-------------
> >>>>>    fs/btrfs/volumes.c       | 39 ++++++++++------------
> >>>>>    include/linux/rbtree.h   | 37 +++++++++++++++++++++
> >>>>>    6 files changed, 141 insertions(+), 126 deletions(-)
> >>>>>
> >>>>
> >>>>
> >>>
> >>>
>

