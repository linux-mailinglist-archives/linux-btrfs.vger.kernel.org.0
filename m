Return-Path: <linux-btrfs+bounces-123-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A207EABA6
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Nov 2023 09:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEA91281097
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Nov 2023 08:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6D111C84;
	Tue, 14 Nov 2023 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXTVavJJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51136BE4A;
	Tue, 14 Nov 2023 08:32:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA04AC433CA;
	Tue, 14 Nov 2023 08:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699950766;
	bh=kZdud6AVCyCWChUZv9D4hp5roB/YtUbXhBY9OfJdqdI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WXTVavJJaU3rprfZ5aD3ge9vs0pgGwiRbTZzRQM+UrtZYFgIv82xxnvLZymjyVEjw
	 gkfcicXo9OqfGx8J8nalKuWukIbHfOZ5lG0zOutvpD3pVfqerRxk6DmHv/esjNi1x5
	 B3Y7rFkCmgBmSAykLkzQuUsqAoqhgxPu32JxCWOiexmRFOdXdoy+4au4CkIq+02ZH5
	 S1w7lXNYWkT05N/mHNa31FUhTFG7zG9olGSBbMCEmyd8XnMlaqFAAusVOrQO8HGAq8
	 ClxS8jehlGLDNzlBbbwHpxqWKGiC/mYNO8uHSLCrYXtxSVg8brWklMKhGoPithxmCe
	 wfz/g3g4tT/mA==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-9dd3f4a0f5aso796961366b.1;
        Tue, 14 Nov 2023 00:32:46 -0800 (PST)
X-Gm-Message-State: AOJu0YwkYEpSsNTwvFEZwfCD1mLMw0AN2R5ZQE1ufC6+92YVElJbidIz
	OOu8KzHackW0s5x9Dfcd+P3K+UPuPKwWHvoxZQk=
X-Google-Smtp-Source: AGHT+IFDQq7m9Rww7c/sORBwkNjCyJe4GSoW+eVgywpJYbE4R3aa9Q0vV7i8VxCJ0fsf7fCx8dN9BKLsZL/GhkmC+z4=
X-Received: by 2002:a17:906:33ce:b0:9e5:31c4:f5f8 with SMTP id
 w14-20020a17090633ce00b009e531c4f5f8mr6241786eja.53.1699950765153; Tue, 14
 Nov 2023 00:32:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231112233325.103250-1-wqu@suse.com> <CAL3q7H5so2=7MojMydXZfxQPCYmFrcNMvqA8fBxtKfEZ5hhsNA@mail.gmail.com>
 <4407b54a-30c6-4ee8-b2bc-bcfdb668e441@gmx.com>
In-Reply-To: <4407b54a-30c6-4ee8-b2bc-bcfdb668e441@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 14 Nov 2023 08:32:08 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4=Zz3Mb0ZcqmzRogE2nvF4_Wc=jULniDANHCbO4QYZhw@mail.gmail.com>
Message-ID: <CAL3q7H4=Zz3Mb0ZcqmzRogE2nvF4_Wc=jULniDANHCbO4QYZhw@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs: test snapshot creation with existing qgroup
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 2:56=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> On 2023/11/14 00:03, Filipe Manana wrote:
> > On Sun, Nov 12, 2023 at 11:33=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote=
:
> >>
> >> [BUG]
> >> There is a sysbot regression report about transaction abort during
> >> snapshot creation, which is caused by the new timing of qgroup creatio=
n
> >> and too strict error check.
> >>
> >> [FIX]
> >> The proper fix is already submitted, with the title "btrfs: do not abo=
rt
> >> transaction if there is already an existing qgroup".
> >>
> >> [TEST]
> >> The new test case would reproduce the regression by:
> >>
> >> - Create a subvolume and a snapshot of it
> >>
> >> - Record the subvolumeid of the snapshot
> >>
> >> - Re-create the fs
> >>    Since btrfs won't reuse the subvolume id, we have to re-create the =
fs.
> >>
> >> - Enable quota and create a qgroup with the same subvolumeid
> >>
> >> - Create a subvolume and a snapshot of it
> >>    For unpatched and affected kernel (thankfully no release is affecte=
d),
> >>    the snapshot creation would fail due to aborted transaction.
> >>
> >> - Make sure the subvolume id doesn't change for the snapshot
> >>    There is one very hacky attempt to fix it by avoiding using the
> >>    subvolume id, which is completely wrong and would be caught by this
> >>    extra check.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   tests/btrfs/303     | 80 +++++++++++++++++++++++++++++++++++++++++++=
++
> >>   tests/btrfs/303.out |  2 ++
> >>   2 files changed, 82 insertions(+)
> >>   create mode 100755 tests/btrfs/303
> >>   create mode 100644 tests/btrfs/303.out
> >>
> >> diff --git a/tests/btrfs/303 b/tests/btrfs/303
> >> new file mode 100755
> >> index 00000000..fe924496
> >> --- /dev/null
> >> +++ b/tests/btrfs/303
> >> @@ -0,0 +1,80 @@
> >> +#! /bin/bash
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
> >> +#
> >> +# FS QA Test 303
> >> +#
> >> +# A regression test to make sure snapshot creation won't cause transa=
ction
> >> +# abort if there is already an existing qgroup.
> >> +#
> >> +. ./common/preamble
> >> +_begin_fstest auto quick qgroup
> >
> > Also 'snapshot' and 'subvol' groups.
> >
> >> +
> >> +. ./common/filter
> >> +
> >> +_supported_fs btrfs
> >> +_require_scratch
> >> +
> >> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> >> +       "btrfs: do not abort transaction if there is already an existi=
ng qgroup"
> >> +
> >> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> >> +_scratch_mount
> >> +
> >> +# Create the first subvolume and get its id.
> >> +# This subvolume id should not change no matter if there is an existi=
ng
> >> +# qgroup for it.
> >> +$BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/subvol" >> $seqres.fu=
ll
> >> +$BTRFS_UTIL_PROG subvolume snapshot "$SCRATCH_MNT/subvol" \
> >> +       "$SCRATCH_MNT/snapshot">> $seqres.full
> >> +
> >> +init_subvolid=3D$(_btrfs_get_subvolid "$SCRATCH_MNT" "snapshot")
> >> +
> >> +if [ -z "$init_subvolid" ]; then
> >> +       _fail "Unable to get the subvolid of the first snapshot"
> >> +fi
> >> +
> >> +echo "Subvolumeid: ${init_subvolid}" >> $seqres.full
> >> +
> >> +_scratch_unmount
> >> +
> >> +# Re-create the fs, as btrfs won't reuse the subvolume id.
> >> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "2nd mkfs failed"
> >> +_scratch_mount
> >> +
> >> +$BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT" >> $seqres.full
> >> +$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" >> $seqres.full
> >> +
> >> +# Create a qgroup for the first subvolume, this would make the later
> >> +# subvolume creation to find an existing qgroup, and abort transactio=
n.
> >> +$BTRFS_UTIL_PROG qgroup create 0/"$init_subvolid" "$SCRATCH_MNT" >> $=
seqres.full
> >> +sync
> >
> > This sync is not needed. An unpatched kernel still fails, and a
> > patched kernel passes this test without the sync.
> >
> > Also, please always comment on why a sync is needed.
> > In this case it can be removed because it's redundant.
>
> Would address all comments, but here I'm a little curious about the
> "sync" comment principle.
>
> I totally understand for this particular case the "sync" is unnecessary,
> the qgroup item doesn't need to be committed, thus it's totally
> reasonable to remove this sync.
>
> But I'm wondering is there any other reasons why we should avoid
> unnecessary "sync"s?

It's a principle of clarity and simplicity.

Adding a comment like "Make the qgroup item persisted in the qgroup
btree, commit the current transaction",
makes it clear why the sync is needed, what it accomplishes.

It makes the test easier to read for other people, and easier to maintain.

In this case it's a simplicity principle also because if it's not
needed, it's better to not be there, otherwise it just makes it
confusing and longer than necessary.

> Like slowing down the test or just to improve our awareness and avoid
> sync-happy guys?

My comment is not about performance.
I run tests in a VM dedicated to that, so adding a sync will at most
increase run time by a few milliseconds - that's insignificant and
therefore I don't care.
All I care about is that the test is clear and has no unnecessary
steps - be it a sync or something else.

Thanks.

>
> Thanks,
> Qu
> >
> >> +
> >> +# Now create the first snapshot, which should have the same subvolid =
no matter
> >> +# if the quota is enabled.
> >> +$BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/subvol" >> $seqres.fu=
ll
> >> +$BTRFS_UTIL_PROG subvolume snapshot "$SCRATCH_MNT/subvol" \
> >> +       "$SCRATCH_MNT/snapshot">> $seqres.full
> >> +
> >> +# Either the snapshot create failed and transaction is aborted thus n=
o
> >> +# snapshot here, or we should be able to create the snapshot.
> >> +new_subvolid=3D$(_btrfs_get_subvolid "$SCRATCH_MNT" "snapshot")
> >> +
> >> +echo "Subvolumeid: ${new_subvolid}" >> $seqres.full
> >> +
> >> +if [ -z "$new_subvolid" ]; then
> >> +       _fail "Unable to get the subvolid of the first snapshot"
> >> +fi
> >> +
> >> +# Make sure the subvolumeid for the first snapshot didn't change.
> >> +if [ "$new_subvolid" -ne "$init_subvolid" ]; then
> >> +       _fail "Subvolumeid for the first snapshot changed, has ${new_s=
ubvolid} expect ${init_subvolid}"
> >> +fi
> >> +
> >> +_scratch_unmount
> >
> > This explicit unmount is not needed, the fstests framework
> > automatically does that.
> >
> > Otherwise it looks fine, thanks.
> >
> >> +
> >> +echo "Silence is golden"
> >> +
> >> +# success, all done
> >> +status=3D0
> >> +exit
> >> diff --git a/tests/btrfs/303.out b/tests/btrfs/303.out
> >> new file mode 100644
> >> index 00000000..d48808e6
> >> --- /dev/null
> >> +++ b/tests/btrfs/303.out
> >> @@ -0,0 +1,2 @@
> >> +QA output created by 303
> >> +Silence is golden
> >> --
> >> 2.42.0
> >>
> >>
> >

