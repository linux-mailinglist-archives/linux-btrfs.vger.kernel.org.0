Return-Path: <linux-btrfs+bounces-10486-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C0B9F4EEC
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 16:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32671668EC
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 15:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8C41F7587;
	Tue, 17 Dec 2024 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fE7XgpsW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06FC1F75A0
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448195; cv=none; b=sjgmDBC4RsDNkAtPsl+qHhA2D2BWaVO33f4lWkKWikvVGapXjZQ+4S2e5pblA7VYrbnHs6Asccb+iijLZIBxXBAWPPEOwc8bs7HKtzEpkuRjU7SvhXx9E87oNEMEjM2yZvGdrHQCmZtqvQGwQZRoYfuX4HVTf6e038jmZE3Wm6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448195; c=relaxed/simple;
	bh=JU5Ezu/PGZH0iIyHtmKWwxgM1vSw/za5Y/b7KPBDd8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMHkvBjS78GmBv0eLmP+em/PnPRUjsfKbRWvbRZ/xtIwOVLAwU8Uct85Bj/+q1vX5Kl8nZseMLwocGe9lePkpskgnh0mqWH5HVZ8sAE8XiDGbolFR3VDjKvPPvnC91NB6x8+vXmaMDQi4S/zAgclL69KuM3zyhsPfyf9mGiNbBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fE7XgpsW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E785C4CED3
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 15:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734448194;
	bh=JU5Ezu/PGZH0iIyHtmKWwxgM1vSw/za5Y/b7KPBDd8M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fE7XgpsWnI4rwNEeW+K+p4aI3dFMkvPrGU5tDmmlvBgyps2PRZRccYDASR07TowHF
	 3/nKQevsBO0cTDuziliJ621GT5a7036zAY4fNy29tWvEpxftxHGPTCDpfeapuLq1U5
	 gkH3J/u94k7TBqCJClRycXHksYrzOTSm0E09cBY3E4VfpAqrDgFCJwysbRZpyeK43l
	 IEIJPmCBlRMb6vks+bCuP48tK53346VSz4FQKdg0pF9qNKO+vyPZ5MQh+PlWStfbIt
	 PrmqMXo8xFQQSTTJfpd/Ba7rsSjbF6liZTbaSMXbBjCwNwiCfvCPcmKojB2LuxSbH7
	 wzHKo5sC/4uBA==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa69077b93fso807628566b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 07:09:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUYYtH4yUJlYldMO+OGWINSqUP7VRg1l4WuFNM9J/LFWHHx64EbzGUZiFL7OYmjK8TZa8EiUqAsu2T4Qw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8dNKtqv7TZzMb47Xs4TazpBDNiphRiPA4MwKMFGGoFnH1175+
	JLAV3F8nSY37AhwIh1FGJqydHLAn7gll0+ncLuiKfoF4rJKBzfdkTTWyzQED2+l+TfQskNIsFr1
	PkHJmZ3v8GtY4zTaLLulNtHw7QVY=
X-Google-Smtp-Source: AGHT+IHZBg44oW7TimYG90kNncVllota0XVvkwK3lGxPaUFAXSD5qymmBLDI9EQmz1zbbrUb/jXdtvEW3iyD7PMsazI=
X-Received: by 2002:a17:907:72c4:b0:aa6:824c:4ae5 with SMTP id
 a640c23a62f3a-aab77eda8f2mr1451567366b.56.1734448193037; Tue, 17 Dec 2024
 07:09:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1734108739.git.beckerlee3@gmail.com> <5b02e350-8c28-42b2-8ccf-8ce76b4ca683@gmx.com>
 <62871028-9f70-48d2-9d46-3ae1f6a57505@gmx.com>
In-Reply-To: <62871028-9f70-48d2-9d46-3ae1f6a57505@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 17 Dec 2024 15:09:16 +0000
X-Gmail-Original-Message-ID: <CAL3q7H733CPhUgtRuj_KCskSik1qXNbK7kdqyQb5XWvSJ4ARUw@mail.gmail.com>
Message-ID: <CAL3q7H733CPhUgtRuj_KCskSik1qXNbK7kdqyQb5XWvSJ4ARUw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] reduce boilerplate code within btrfs
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 10:07=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/12/17 07:50, Qu Wenruo =E5=86=99=E9=81=93:
> >
> >
> > =E5=9C=A8 2024/12/16 01:56, Roger L. Beckermeyer III =E5=86=99=E9=81=93=
:
> >> The goal of this patch series is to reduce boilerplate code
> >> within btrfs. To accomplish this rb_find_add_cached() was added
> >> to linux/include/rbtree.h. Any replaceable functions were then
> >> replaced within btrfs.
> >
> > Since Peter has acknowledged the change in rbtree, the remaining part
> > looks fine to me.
> >
> > The mentioned error handling bug will be fixed when I merge the series.
> >
> > Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> Well, during merge I found some extra things that you can improve in the
> future.

One more thing to improve in the future:

- Run fstests and check that that are no tests failing after the changes.

There's at least 1 test case failing after this patchset.
The patch "btrfs: update prelim_ref_insert() to use rb helpers" breaks
btrfs/287:

$ ./check btrfs/287
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 debian0 6.13.0-rc2-btrfs-next-182+ #2
SMP PREEMPT_DYNAMIC Tue Dec 17 11:02:25 WET 2024
MKFS_OPTIONS  -- /dev/sdc
MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

btrfs/287 1s ... - output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad)
    --- tests/btrfs/287.out 2024-10-30 07:42:47.901514035 +0000
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad
2024-12-17 15:00:35.341110069 +0000
    @@ -8,82 +8,82 @@
     linked 8388608/8388608 bytes at offset 16777216
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
     resolve first extent:
    -inode 257 offset 16777216 root 5
    -inode 257 offset 8388608 root 5
     inode 257 offset 0 root 5
    +inode 257 offset 8388608 root 5
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/287.out
/home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad'  to see
the entire diff)

HINT: You _MAY_ be missing kernel fix:
      0cad8f14d70c btrfs: fix backref walking not returning all inode refs

Ran: btrfs/287
Failures: btrfs/287
Failed 1 of 1 tests

So please fix the patch (or patches) and resend the updated version once fi=
xed.
Meanwhile it should be dropped from for-next.

Thanks.


>
> - The length of each code line
>    Although we no longer have the older strict 80 chars length limit,
>    check_patch.pl will still warn about lines over 100 chars.
>    Several patches triggered this.
>
>    So please use check_patch.pl or just use btrfs workflow instead.
>
> - The incorrect drop of const prefix in the last patch
>    Since the comparison function accepts one regular node and one const
>    node, the last patch drops the second const prefix, mostly due to
>    the factg that comp_refs() doesn't have const prefix at all for both
>    parameters.
>
>    The proper fix is to add const prefixes for involved functions, not
>    dropping the existing const prefixes.
>
>    I have also make all internal structure inside those helpers to be
>    const.
>    (Personally speaking I also want to check if the less() and cmp() can
>     be converted to accept both parameters as const in the future)
>
> - Upper case for the first letter of a sentence
>    I'm not good at English either, but at least for the commit message,
>    the first letter of a sentence should be in upper case.
>
> - Minor code style problems
>    IIRC others have already address the problem like:
>
>         int result;
>
>         result =3D some_function();
>         return result;
>
>    Which can be done by a simple "return some_function();".
>
> Thanks,
> Qu
>
> >
> > Thanks,
> > Qu
> >>
> >> changelog:
> >> updated if() statements to utilize newer error checking
> >> resolved lock error on 0002
> >> edited title of patches to utilize update instead of edit
> >> added Acked-by from Peter Zijlstra to 0001
> >> eliminated extra variables throughout the patch series
> >>
> >> Roger L. Beckermeyer III (6):
> >>    rbtree: add rb_find_add_cached() to rbtree.h
> >>    btrfs: update btrfs_add_block_group_cache() to use rb helper
> >>    btrfs: update prelim_ref_insert() to use rb helpers
> >>    btrfs: update __btrfs_add_delayed_item() to use rb helper
> >>    btrfs: update btrfs_add_chunk_map() to use rb helpers
> >>    btrfs: update tree_insert() to use rb helpers
> >>
> >>   fs/btrfs/backref.c       | 71 ++++++++++++++++++++------------------=
--
> >>   fs/btrfs/block-group.c   | 41 ++++++++++-------------
> >>   fs/btrfs/delayed-inode.c | 40 +++++++++-------------
> >>   fs/btrfs/delayed-ref.c   | 39 +++++++++-------------
> >>   fs/btrfs/volumes.c       | 39 ++++++++++------------
> >>   include/linux/rbtree.h   | 37 +++++++++++++++++++++
> >>   6 files changed, 141 insertions(+), 126 deletions(-)
> >>
> >
> >
>
>

