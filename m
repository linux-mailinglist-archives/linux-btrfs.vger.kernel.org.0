Return-Path: <linux-btrfs+bounces-11951-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1498FA4A54C
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 22:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C7A3A532C
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 21:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B391DE2BE;
	Fri, 28 Feb 2025 21:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cusQ9XYB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304381DDC1D;
	Fri, 28 Feb 2025 21:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740779226; cv=none; b=R9MAM3B6BI6r1dBoBATR9HxEWjLUWmAAled4kPOoDtzuxxVXI/zQbwfivJ9QIx5CEEmo3EIGmKeshQWu5AI8MnWDLjTDqMgptUs3iapg1bM0/7Y1n9WVNFnm7qfaLbL/a6k6zAuTM3Gr00+2Gqk0klJQZJBeNoi3ikNoSm/vUY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740779226; c=relaxed/simple;
	bh=ENbjatTrpj2/QTS6tvRwPg+Nwjkr86iUfAdQs5nKVzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQQpbzlh8r610sDqbn1BBHYtCC8LeW5dkvjpMHPVDwAZbuc/G/mMRiQHDEGHV7X+BbM4eJfXeY+nHPiKAWREvi3iuI03SEF60fkLpk+4yC1XGaVv/9U72HOA9j0mgu3emvRI4z9i/LP0xxlplwyA2AKm6wIS93J+ZItxeX8nTGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cusQ9XYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7417C4CEE5;
	Fri, 28 Feb 2025 21:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740779225;
	bh=ENbjatTrpj2/QTS6tvRwPg+Nwjkr86iUfAdQs5nKVzQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cusQ9XYBfNMoPFD89cSPGd9Hz32CHcKLQJm5DybH84uJobPG4khhDwR7lmM3Hm1Rj
	 zqPuDZlnEtAR90uyw22KD69RBj9oygMIrzdFCK7hOn7EPaWRFyJILYXweLSGNls67G
	 Ot2h0DPijDB00RtCiVm8daW0wZXBtXa/QSeV0QzwLSnH4r1GDzpYQY6iPIfyQfSj0y
	 mnAF5XdsfJmQ8/kjNJdKwmOo/VLLU/AnHGmh4gsusEXkOCHxzhSF2o6KsfMx+ogMbu
	 SgG2RnhgsK3gZjWuf4VvhQj+zkxHjAZEHpU2I1SbiTY/KyRGbyaEETmO2HGWTdWqwA
	 5hK/3Apy5Yuhg==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso367687266b.1;
        Fri, 28 Feb 2025 13:47:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUxpHaJtk3JXk6irjnCW5ZUj1oWEL0HVchSAe01YK8JgOckKUcjOf9v6qEy4vdVC68ZgmDqvU4GsCAZLw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlv290aZ5PmOslp6tp4/4VSkaYVRbF8LThaHAsL4HaMyHg7vrA
	vv7SUKo644LoEmm5T8FDYEriMgPmDhBQbKrPFgcM7NI0epdxOqvM+jlOKQBl/AEQZi9fvbMqLl1
	piuy6UagXioKxeJ8yAgNLKQpdwNU=
X-Google-Smtp-Source: AGHT+IGyuxbd+1cWp3QWCYQgtJC/+BpqcyaCddiMO4qMtaDgnUbAakqHrcDknFOnSIkFbQx0bnGgB1V7ND1/fJoGVMg=
X-Received: by 2002:a17:907:7b8b:b0:abb:b322:2c4e with SMTP id
 a640c23a62f3a-abf261fbb2amr553196166b.3.1740779224143; Fri, 28 Feb 2025
 13:47:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d48dd538e99048e73973c6b32a75a6ff340e8c47.1740759907.git.fdmanana@suse.com>
 <8cdc4be8-f1ad-4baa-beab-c22b0ca0832c@gmx.com>
In-Reply-To: <8cdc4be8-f1ad-4baa-beab-c22b0ca0832c@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 28 Feb 2025 21:46:27 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5gEcxq8DV8m6WxKnPOQuTSesBJVA_eaFAG2Ua6e5MBUg@mail.gmail.com>
X-Gm-Features: AQ5f1JrfaNLps9jFrrmyARFeZo9Hnrbh4tq5CtLkDJ5Z5_HozHTv4hK81vswzpM
Message-ID: <CAL3q7H5gEcxq8DV8m6WxKnPOQuTSesBJVA_eaFAG2Ua6e5MBUg@mail.gmail.com>
Subject: Re: [PATCH] btrfs/080: fix sporadic failures starting with kernel 6.13
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>, Glass Su <glass.su@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 9:16=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2025/3/1 02:57, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Since kernel 6.13, namely since commit c87c299776e4 ("btrfs: make buffe=
red
> > write to copy one page a time"), the test can sporadically fail with an
> > unexpected digests for files in snapshots. This is because after that
> > commit the pages for a buffered write are prepared and dirtied one by o=
ne,
> > and no longer in batches up to 512 pages (on x86_64)
>
> Minor nitpicks, the original limit of pages is 8:
>
>         nrptrs =3D max(nrptrs, 8);
>         pages =3D kmalloc_array(nrptrs, sizeof(struct page *),
>                                GFP_KERNEL);

No, it can be more than 8, much more. You're missing previous code
there, as nrptrs could be greater than 8 before the max expression:

nrptrs =3D min(DIV_ROUND_UP(iov_iter_count(i), PAGE_SIZE), PAGE_SIZE /
(sizeof(struct page *)));
nrptrs =3D min(nrptrs, current->nr_dirtied_pause - current->nr_dirtied);
nrptrs =3D max(nrptrs, 8);
pages =3D kmalloc_array(nrptrs, sizeof(struct page *), GFP_KERNEL);

For example, for a 2M write, the first assignment to nrptrs results in 512.


>
> I'm not sure if it's a coincident or not, but the first 32K writes
> matches the pages limit perfectly (for x86_64).
>
> Meanwhile the second 32770 write is possible to be split even with the
> older code, but it should be super rare to hit.
>
> >, so a snapshot that
> > is created in the middle of a buffered write can result in a version of
> > the file where only a part of a buffered write got caught, for example =
if
> > a snapshot is created while doing the 32K write for file range [0, 32K)=
,
> > we can end up a file in the snapshot where only the first 8K (2 pages) =
of
> > the write are visible, since the remaining 24K were not yet processed b=
y
> > the write task. Before that kernel commit, this didn't happen since we
> > processed all the pages in a single batch and while holding the whole
> > range locked in the inode's io tree.
>
> This means no matter the buffered io buffer size, it's the filesystems'
> behavior determining if such a buffered write will be split.
>
> Maybe it's not that a huge deal, as the original behavior will also
> break the buffered io block size, just with a larger value (8 pages
> other than 1).
>
> >
> > This is easy to observe by adding an "od -A d -t x1" call to the test
> > before the _fail statement when we get an unexpected file digest:
> >
> >    $ ./check btrfs/080
> >    FSTYP         -- btrfs
> >    PLATFORM      -- Linux/x86_64 debian0 6.14.0-rc4-btrfs-next-188+ #1 =
SMP PREEMPT_DYNAMIC Wed Feb 26 17:38:41 WET 2025
> >    MKFS_OPTIONS  -- /dev/sdc
> >    MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> >
> >    btrfs/080 32s ... [failed, exit status 1]- output mismatch (see /hom=
e/fdmanana/git/hub/xfstests/results//btrfs/080.out.bad)
> >        --- tests/btrfs/080.out        2020-06-10 19:29:03.814519074 +01=
00
> >        +++ /home/fdmanana/git/hub/xfstests/results//btrfs/080.out.bad 2=
025-02-27 17:12:08.410696958 +0000
> >        @@ -1,2 +1,6 @@
> >         QA output created by 080
> >        -Silence is golden
> >        +0000000 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> >        +*
> >        +0008192
> >        +Unexpected digest for file /home/fdmanana/btrfs-tests/scratch_1=
/17_11_56_146646257_snap/foobar_50
> >        +(see /home/fdmanana/git/hub/xfstests/results//btrfs/080.full fo=
r details)
> >        ...
> >        (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/080.ou=
t /home/fdmanana/git/hub/xfstests/results//btrfs/080.out.bad'  to see the e=
ntire diff)
> >    Ran: btrfs/080
> >    Failures: btrfs/080
> >    Failed 1 of 1 tests
> >
> > The files are created like this while snapshots are created in parallel=
:
> >
> >      run_check $XFS_IO_PROG -f \
> >          -c "pwrite -S 0xaa -b 32K 0 32K" \
> >          -c "fsync" \
> >          -c "pwrite -S 0xbb -b 32770 16K 32770" \
> >          -c "truncate 90123" \
> >          $SCRATCH_MNT/$name
> >
> > So with the kernel behaviour before 6.13 we expected the snapshot to
> > contain any of the following versions of the file:
> >
> > 1) Empty file;
> >
> > 2) 32K file reflecting only the first buffered write;
> >
> > 3) A file with a size of 49154 bytes reflecting both buffered writes;
> >
> > 4) A file with a size of 90123 bytes, reflecting the truncate operation
> >     and both buffered writes.
> >
> > So now the test can fail since kernel 6.13 due to snapshots catching
> > partial writes.
> >
> > However the goal of the test when I wrote it was to verify that if the
> > snapshot version of a file gets the truncated size, then the buffered
> > writes are visible in the file, since they happened before the truncate
> > operation - that is, we can't get a file with a size of 90123 bytes tha=
t
> > doesn't have the range [0, 16K) full of bytes with a value of 0xaa and
> > the range [16K, 49154) full of bytes with the 0xbb value.
> >
> > So update the test to the new kernel behaviour by verifying only that i=
f
> > the file has the size we truncated to, then it has all the data we wrot=
e
> > previously with the buffered writes.
> >
> > Reported-by: Glass Su <glass.su@suse.com>
> > Link: https://lore.kernel.org/linux-btrfs/30FD234D-58FC-4F3C-A947-47A5B=
6972C01@suse.com/
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> Thanks for the detailed analyze and the fix.
>
> Thanks,
> Qu
>
> > ---
> >   tests/btrfs/080 | 42 +++++++++++++++++++++++-------------------
> >   1 file changed, 23 insertions(+), 19 deletions(-)
> >
> > diff --git a/tests/btrfs/080 b/tests/btrfs/080
> > index ea9d09b0..aa97d3f6 100755
> > --- a/tests/btrfs/080
> > +++ b/tests/btrfs/080
> > @@ -32,6 +32,8 @@ _cleanup()
> >
> >   _require_scratch_nocheck
> >
> > +truncate_offset=3D90123
> > +
> >   create_snapshot()
> >   {
> >       local ts=3D`date +'%H_%M_%S_%N'`
> > @@ -48,7 +50,7 @@ create_file()
> >               -c "pwrite -S 0xaa -b 32K 0 32K" \
> >               -c "fsync" \
> >               -c "pwrite -S 0xbb -b 32770 16K 32770" \
> > -             -c "truncate 90123" \
> > +             -c "truncate $truncate_offset" \
> >               $SCRATCH_MNT/$name
> >   }
> >
> > @@ -81,6 +83,12 @@ _scratch_mkfs "$mkfs_options" >>$seqres.full 2>&1
> >
> >   _scratch_mount
> >
> > +# Create a file while no snapshotting is in progress so that we get th=
e expected
> > +# digest for every file in a snapshot that caught the truncate operati=
on (which
> > +# sets the file's size to $truncate_offset).
> > +create_file "gold_file"
> > +expected_digest=3D`_md5_checksum "$SCRATCH_MNT/gold_file"`
> > +
> >   # Run some background load in order to make the issue easier to trigg=
er.
> >   # Specially needed when testing with non-debug kernels and there isn'=
t
> >   # any other significant load on the test machine other than this test=
.
> > @@ -103,24 +111,20 @@ for ((i =3D 0; i < $num_procs; i++)); do
> >   done
> >
> >   for f in $(find $SCRATCH_MNT -type f -name 'foobar_*'); do
> > -     digest=3D`md5sum $f | cut -d ' ' -f 1`
> > -     case $digest in
> > -     "d41d8cd98f00b204e9800998ecf8427e")
> > -             # ok, empty file
> > -             ;;
> > -     "c28418534a020122aca59fd3ff9581b5")
> > -             # ok, only first write captured
> > -             ;;
> > -     "cd0032da89254cdc498fda396e6a9b54")
> > -             # ok, only 2 first writes captured
> > -             ;;
> > -     "a1963f914baf4d2579d643425f4e54bc")
> > -             # ok, the 2 writes and the truncate were captured
> > -             ;;
> > -     *)
> > -             # not ok, truncate captured but not one or both writes
> > -             _fail "Unexpected digest for file $f"
> > -     esac
> > +     file_size=3D$(stat -c%s "$f")
> > +     # We want to verify that if the file has the size set by the trun=
cate
> > +     # operation, then both delalloc writes were flushed, and every ve=
rsion
> > +     # of the file in each snapshot has its range [0, 16K) full of byt=
es with
> > +     # a value of 0xaa and the range [16K, 49154) is full of bytes wit=
h a
> > +     # value of 0xbb.
> > +     if [ "$file_size" -eq "$truncate_offset" ]; then
> > +             digest=3D`_md5_checksum "$f"`
> > +             if [ "$digest" !=3D "$expected_digest" ]; then
> > +                     echo -e "Unexpected content for file $f:\n"
> > +                     _hexdump "$f"
> > +                     _fail "Bad file content"
> > +             fi
> > +     fi
> >   done
> >
> >   # Check the filesystem for inconsistencies.
>
>

