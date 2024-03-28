Return-Path: <linux-btrfs+bounces-3713-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CEA88FB70
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 10:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A6E1C236D8
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 09:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A5F657A3;
	Thu, 28 Mar 2024 09:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8GYzWzI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A65535DE;
	Thu, 28 Mar 2024 09:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711618104; cv=none; b=q3vRJ2hRIQAtw60nMm5rg5HCoFE9JjpNmtydc6NDnfxQcUIfvT87wUVXgWgjPWEJ/P1gHA5vzeDwM/GTPua4LytQUhJrArQoOEg4wcWa38orbseHibVw5msiTsJRZN9vvonNiOF0KViM/fTbavOHJQjVzufDuhZWjRNYr8wVxAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711618104; c=relaxed/simple;
	bh=Uwhb2+BEhpnCgSDYlGptLqQzaMJpTnMwzNzBYyCrwOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svJJSTycaSq307kPd0EoPvqYxpA5FL4CahOV8ejhfTm60zh7wVu3+ivBKzfwnCxO+DqQhc75MBHESICXBOu6CgxjB64h0kYuLCeL84UEceXLiMdxDSqc36wqofO+MkCz2PuNNZ7NIN44B1hk2bSoF5IpBtgcbm6cm/ieXim5vIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8GYzWzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55EBC433C7;
	Thu, 28 Mar 2024 09:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711618103;
	bh=Uwhb2+BEhpnCgSDYlGptLqQzaMJpTnMwzNzBYyCrwOE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z8GYzWzIfvZtah2Ng1CwTI/MupB1LS+q6jHd7DRbzhQUSZWoYxygZvygznxXFDAa9
	 M0ZJUsF5WLJ3/so8PmPbYwYrl5Q4HDAmeuC6+h5GYGNAoYNOx77NLFIeZHiEi0wgUT
	 SWBTtKODeMlSL3wOEO8k4ZOvlJ186FACNzh657ZEuA58vt7YtUOplRoYwNizqXrOCp
	 8j5qXMztTTpsorasVZ+ps0UKe7IyaToVV5eFYik5EjqW+i0dIt88hlLTK1a4R8L+zE
	 dFNphLN3oSN/U3QtI2YeVQINIKlp8WGhIdWrJW92XKUv2w7x7GQacvdZy7J81lg9Yg
	 Vx2yBc+/NqULQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-515caffe2b5so228120e87.2;
        Thu, 28 Mar 2024 02:28:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXRq8nsIE3eX7HCmxL2u1dGmD2ONqE6qreXJhnWFjrG0wpNyW7R8UrDIu2Lxb8zRHghNSORBfgWWT8Gban5/TMmHz0xp5gYtbD63QM=
X-Gm-Message-State: AOJu0YwG0e9pRyXIkTnB0tzZ8FwBnkESVfUAcLNNsy80HbEwQBxgpaFg
	vr6+X3o1ACEK5mBLX42aJyuCFeiJVdHp8tsI8Koau6aC+8N5VuxqF8At/4Gjs8SFZSb4RHdeaj0
	cyPpZJ7QX2GIzt8XsKRscTeox8Tw=
X-Google-Smtp-Source: AGHT+IGXY9wv+1k9Mxk1+1QJ39zWYD5zJWa2wJ6zvRKAwCTLg6bceTZaoMFIOyxCWpMFoaKVvf+zrih+rYUfg/vAHRE=
X-Received: by 2002:a05:6512:11d2:b0:515:c9f7:6597 with SMTP id
 h18-20020a05651211d200b00515c9f76597mr446233lfr.23.1711618102268; Thu, 28 Mar
 2024 02:28:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711558345.git.fdmanana@suse.com> <091a8f4e0211299e21c3a3231584d0e8dac49ed1.1711558345.git.fdmanana@suse.com>
 <82afe79c-3408-47da-b0ff-346371263689@oracle.com>
In-Reply-To: <82afe79c-3408-47da-b0ff-346371263689@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 28 Mar 2024 09:27:45 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6H6ZchXP4Nn3S0eaymgUHUn6q4tDiz=39i1GXT7BM5nw@mail.gmail.com>
Message-ID: <CAL3q7H6H6ZchXP4Nn3S0eaymgUHUn6q4tDiz=39i1GXT7BM5nw@mail.gmail.com>
Subject: Re: [PATCH 04/10] btrfs: add helper to kill background process
 running _btrfs_stress_scrub
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 8:41=E2=80=AFAM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> On 3/28/24 01:11, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Killing a background process running _btrfs_stress_scrub() is not as
> > simple as sending a signal to the process and waiting for it to die.
> > Therefore we have the following logic to terminate such process:
> >
> >     kill $pid
> >     wait $pid
> >     while ps aux | grep "scrub start" | grep -qv grep; do
> >         sleep 1
> >     done
> >
> > Since this is repeated in several test cases, move this logic to a comm=
on
> > helper and use it in all affected test cases. This will help to avoid
> > repeating the same code again several times in upcoming changes.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   common/btrfs    | 14 ++++++++++++++
> >   tests/btrfs/061 |  7 +------
> >   tests/btrfs/066 |  8 ++------
> >   tests/btrfs/069 | 11 +++++------
> >   tests/btrfs/072 | 11 +++++------
> >   tests/btrfs/073 | 11 +++++------
> >   6 files changed, 32 insertions(+), 30 deletions(-)
> >
> > diff --git a/common/btrfs b/common/btrfs
> > index e95cff7f..d0adeea1 100644
> > --- a/common/btrfs
> > +++ b/common/btrfs
> > @@ -349,6 +349,20 @@ _btrfs_stress_scrub()
> >       done
> >   }
> >
> > +# Kill a background process running _btrfs_stress_scrub()
> > +_btrfs_kill_stress_scrub_pid()
> > +{
> > +       local scrub_pid=3D$1
> > +
> > +       # Ignore if process already died.
> > +       kill $scrub_pid &> /dev/null
> > +       wait $scrub_pid &> /dev/null
> > +       # Wait for the scrub operation to finish.
>
>
> > +       while ps aux | grep "scrub start" | grep -qv grep; do
>
> This can be replaced by pgrep. I'll make the change if there are
> no objections.

Yes, but as previously pointed out, the goal of the patch is just to
move repeated code into a helper function.
I would prefer such a change to be done separately.

Thanks.

>
>        while pgrep -f "btrfs scrub start" > /dev/null; do
>
> Thanks, Anand
>
> > +               sleep 1
> > +       done
> > +}
> > +
> >   # stress btrfs by defragmenting every file/dir in a loop and compress=
 file
> >   # contents while defragmenting if second argument is not "nocompress"
> >   _btrfs_stress_defrag()
> > diff --git a/tests/btrfs/061 b/tests/btrfs/061
> > index d0b55e48..b8b2706c 100755
> > --- a/tests/btrfs/061
> > +++ b/tests/btrfs/061
> > @@ -52,12 +52,7 @@ run_test()
> >       echo "Wait for fsstress to exit and kill all background workers" =
>>$seqres.full
> >       wait $fsstress_pid
> >       _btrfs_kill_stress_balance_pid $balance_pid
> > -     kill $scrub_pid
> > -     wait $scrub_pid
> > -     # wait for the crub operation to finish
> > -     while ps aux | grep "scrub start" | grep -qv grep; do
> > -             sleep 1
> > -     done
> > +     _btrfs_kill_stress_scrub_pid $scrub_pid
> >
> >       echo "Scrub the filesystem" >>$seqres.full
> >       $BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> > diff --git a/tests/btrfs/066 b/tests/btrfs/066
> > index a29034bb..29821fdd 100755
> > --- a/tests/btrfs/066
> > +++ b/tests/btrfs/066
> > @@ -57,12 +57,8 @@ run_test()
> >       wait $fsstress_pid
> >
> >       touch $stop_file
> > -     kill $scrub_pid
> > -     wait
> > -     # wait for the scrub operation to finish
> > -     while ps aux | grep "scrub start" | grep -qv grep; do
> > -             sleep 1
> > -     done
> > +     wait $subvol_pid
> > +     _btrfs_kill_stress_scrub_pid $scrub_pid
> >
> >       echo "Scrub the filesystem" >>$seqres.full
> >       $BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> > diff --git a/tests/btrfs/069 b/tests/btrfs/069
> > index 139dde48..20f44b39 100755
> > --- a/tests/btrfs/069
> > +++ b/tests/btrfs/069
> > @@ -59,17 +59,16 @@ run_test()
> >
> >       echo "Wait for fsstress to exit and kill all background workers" =
>>$seqres.full
> >       wait $fsstress_pid
> > -     kill $replace_pid $scrub_pid
> > -     wait
> > +     kill $replace_pid
> > +     wait $replace_pid
> >
> > -     # wait for the scrub and replace operations to finish
> > -     while ps aux | grep "scrub start" | grep -qv grep; do
> > -             sleep 1
> > -     done
> > +     # wait for the replace operation to finish
> >       while ps aux | grep "replace start" | grep -qv grep; do
> >               sleep 1
> >       done
> >
> > +     _btrfs_kill_stress_scrub_pid $scrub_pid
> > +
> >       echo "Scrub the filesystem" >>$seqres.full
> >       $BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> >       if [ $? -ne 0 ]; then
> > diff --git a/tests/btrfs/072 b/tests/btrfs/072
> > index 4b6b6fb5..6c15b51f 100755
> > --- a/tests/btrfs/072
> > +++ b/tests/btrfs/072
> > @@ -52,16 +52,15 @@ run_test()
> >
> >       echo "Wait for fsstress to exit and kill all background workers" =
>>$seqres.full
> >       wait $fsstress_pid
> > -     kill $scrub_pid $defrag_pid
> > -     wait
> > -     # wait for the scrub and defrag operations to finish
> > -     while ps aux | grep "scrub start" | grep -qv grep; do
> > -             sleep 1
> > -     done
> > +     kill $defrag_pid
> > +     wait $defrag_pid
> > +     # wait for the defrag operation to finish
> >       while ps aux | grep "btrfs filesystem defrag" | grep -qv grep; do
> >               sleep 1
> >       done
> >
> > +     _btrfs_kill_stress_scrub_pid $scrub_pid
> > +
> >       echo "Scrub the filesystem" >>$seqres.full
> >       $BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> >       if [ $? -ne 0 ]; then
> > diff --git a/tests/btrfs/073 b/tests/btrfs/073
> > index b1604f94..49a4abd1 100755
> > --- a/tests/btrfs/073
> > +++ b/tests/btrfs/073
> > @@ -51,16 +51,15 @@ run_test()
> >
> >       echo "Wait for fsstress to exit and kill all background workers" =
>>$seqres.full
> >       wait $fsstress_pid
> > -     kill $scrub_pid $remount_pid
> > -     wait
> > -     # wait for the scrub and remount operations to finish
> > -     while ps aux | grep "scrub start" | grep -qv grep; do
> > -             sleep 1
> > -     done
> > +     kill $remount_pid
> > +     wait $remount_pid
> > +     # wait for the remount operation to finish
> >       while ps aux | grep "mount.*$SCRATCH_MNT" | grep -qv grep; do
> >               sleep 1
> >       done
> >
> > +     _btrfs_kill_stress_scrub_pid $scrub_pid
> > +
> >       echo "Scrub the filesystem" >>$seqres.full
> >       $BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> >       if [ $? -ne 0 ]; then
>

