Return-Path: <linux-btrfs+bounces-3714-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E9588FB90
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 10:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D0729E8DB
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 09:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A476752F6F;
	Thu, 28 Mar 2024 09:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dq3ximya"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC19A2AD1C;
	Thu, 28 Mar 2024 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711618367; cv=none; b=pYT+rExFfOUPFZBegCmhZseggVx34xwAZRGvIIr/T64XrlxpO/TWxtvnLXPhFJSXB5Al7xS2Nz7f54eCTLy2Lc6d9kuK/FcNpRu48ucyZVkL+O5H/asBa0kq4ySyGZcOFdoGwhteNpgq/dWXhjs6rch9abLYmNrGpTK73zkYZcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711618367; c=relaxed/simple;
	bh=94KlyCLZ7aIf6spnT988y5Lpn/yje4JuA8jD+3Ax16U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KFe0PmX6/VMT7SzXneEjB/oZAhRkkhFURxhmSpeh6QLko0HeKUhmnYswC3NzUR7Qw4LSEnlDQWeem6f2xOnXsesiCRtYXkOzIXo+2N/fsvytHApUj6MOsfO1rgt+BcNtUOA6yGJDS1D3eK5Z2D5JOZzOQAFChsJb0FrRd5unKBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dq3ximya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A57C433C7;
	Thu, 28 Mar 2024 09:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711618367;
	bh=94KlyCLZ7aIf6spnT988y5Lpn/yje4JuA8jD+3Ax16U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Dq3ximya44GBYcIG8lj2YQ19fqBLHyKtEw0fGSdXLhYQT0FJfKUtf7I6q+sojpyoH
	 M+DPbG8zX2XIDZV8Pl97zBBaZDrt2ScO7DquA1LVQVA8WaXFlNPwqqriaZe03j2hak
	 TxUQi9je843OWH9KqgsnBCJMTc5aGI4nWOpw2MP4jNZj11YlT21h0vQWWbPtegIPku
	 l7tx2EYe/q8pcqzO6R9VWrBWmSaY1Q8tzw8kLSeMszNN6ACofbylObCiNFPrEaixlt
	 6b/Y94IjiuywL+JdzQEJyFs5DheR9mJcY1WplLTXOvMoQMpcHWxIv1N1qT7HUNK/ug
	 DkCmCab4p3/Cw==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56bc5a3aeb9so904393a12.3;
        Thu, 28 Mar 2024 02:32:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV80A2MNyCygWZP1OLp9kamqdidLL0w3hWMgR50t4XZm6Xjryru1bGSD0LoVFevYhTL14vSaACNVjipJHo+kBrSergRpZuJhe2r8vw=
X-Gm-Message-State: AOJu0YxVPtu4PbvSS4oxQGlKMauLMIIOhoCOexm8Nud05rUuuruEvNAT
	/poDqG1VJkYqlBL6qMJjc7FXvWpIMhsleFlqNfw9bs6Ry+V4oK2T9zx0/Uhc+1S2DHvAoXHyX1p
	5X8GIqIKXipFu0gQ0eIXDor+ZJEc=
X-Google-Smtp-Source: AGHT+IGqBHja7BDqcmiOMoleXH0Iag9ab21yAC2JVi09qfVb1nZpjhTtW6idkrcNZ/QD4zIVqhgLrjxGF3vfzEKInyw=
X-Received: by 2002:a17:906:2b92:b0:a46:bdd8:64ef with SMTP id
 m18-20020a1709062b9200b00a46bdd864efmr1180897ejg.19.1711618365898; Thu, 28
 Mar 2024 02:32:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711558345.git.fdmanana@suse.com> <247bde0d4f7d943337e228dded8ad03753b0e3c9.1711558345.git.fdmanana@suse.com>
 <2ac567ab-b3a5-438f-afcb-f57a97379681@oracle.com>
In-Reply-To: <2ac567ab-b3a5-438f-afcb-f57a97379681@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 28 Mar 2024 09:32:09 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4DdH6CO8Xfd+a3GYkB9tZiFb4sV3NnD6b931incGXivg@mail.gmail.com>
Message-ID: <CAL3q7H4DdH6CO8Xfd+a3GYkB9tZiFb4sV3NnD6b931incGXivg@mail.gmail.com>
Subject: Re: [PATCH 05/10] btrfs: add helper to kill background process
 running _btrfs_stress_defrag
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 9:19=E2=80=AFAM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> On 3/28/24 01:11, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Killing a background process running _btrfs_stress_defrag() is not as
> > simple as sending a signal to the process and waiting for it to die.
> > Therefore we have the following logic to terminate such process:
> >
> >         kill $pid
> >         wait $pid
> >         while ps aux | grep "btrfs filesystem defrag" | grep -qv grep; =
do
> >             sleep 1
> >         done
> >
> > Since this is repeated in several test cases, move this logic to a comm=
on
> > helper and use it in all affected test cases. This will help to avoid
> > repeating the same code again several times in upcoming changes.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   common/btrfs    | 14 ++++++++++++++
> >   tests/btrfs/062 |  7 +------
> >   tests/btrfs/067 |  8 ++------
> >   tests/btrfs/070 | 11 +++++------
> >   tests/btrfs/072 |  7 +------
> >   tests/btrfs/074 | 11 +++++------
> >   6 files changed, 28 insertions(+), 30 deletions(-)
> >
> > diff --git a/common/btrfs b/common/btrfs
> > index d0adeea1..46056d4a 100644
> > --- a/common/btrfs
> > +++ b/common/btrfs
> > @@ -383,6 +383,20 @@ _btrfs_stress_defrag()
> >       done
> >   }
> >
> > +# Kill a background process running _btrfs_stress_defrag()
> > +_btrfs_kill_stress_defrag_pid()
> > +{
> > +       local defrag_pid=3D$1
> > +
> > +       # Ignore if process already died.
> > +       kill $defrag_pid &> /dev/null
> > +       wait $defrag_pid &> /dev/null
> > +       # Wait for the defrag operation to finish.
> > +       while ps aux | grep "btrfs filesystem defrag" | grep -qv grep; =
do
>
> The same comments apply here regarding the use of pgrep.

Yes, but as previously pointed out, the goal of the patch is just to
move repeated code into a helper function.
I would prefer such a change to be done separately.

Thanks.

>
> Looks good.
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
>
> Thanks, Anand
>
> > +               sleep 1
> > +       done
> > +}
> > +
> >   # stress btrfs by remounting it with different compression algorithms=
 in a loop
> >   # run this with fsstress running at background could exercise the com=
pression
> >   # code path and ensure no race when switching compression algorithm w=
ith constant
> > diff --git a/tests/btrfs/062 b/tests/btrfs/062
> > index a2639d6c..59d581be 100755
> > --- a/tests/btrfs/062
> > +++ b/tests/btrfs/062
> > @@ -53,12 +53,7 @@ run_test()
> >       echo "Wait for fsstress to exit and kill all background workers" =
>>$seqres.full
> >       wait $fsstress_pid
> >       _btrfs_kill_stress_balance_pid $balance_pid
> > -     kill $defrag_pid
> > -     wait $defrag_pid
> > -     # wait for the defrag operation to finish
> > -     while ps aux | grep "btrfs filesystem defrag" | grep -qv grep; do
> > -             sleep 1
> > -     done
> > +     _btrfs_kill_stress_defrag_pid $defrag_pid
> >
> >       echo "Scrub the filesystem" >>$seqres.full
> >       $BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> > diff --git a/tests/btrfs/067 b/tests/btrfs/067
> > index 709db155..2bb00b87 100755
> > --- a/tests/btrfs/067
> > +++ b/tests/btrfs/067
> > @@ -58,12 +58,8 @@ run_test()
> >       wait $fsstress_pid
> >
> >       touch $stop_file
> > -     kill $defrag_pid
> > -     wait
> > -     # wait for btrfs defrag process to exit, otherwise it will block =
umount
> > -     while ps aux | grep "btrfs filesystem defrag" | grep -qv grep; do
> > -             sleep 1
> > -     done
> > +     wait $subvol_pid
> > +     _btrfs_kill_stress_defrag_pid $defrag_pid
> >
> >       echo "Scrub the filesystem" >>$seqres.full
> >       $BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> > diff --git a/tests/btrfs/070 b/tests/btrfs/070
> > index 54aa275c..cefa5723 100755
> > --- a/tests/btrfs/070
> > +++ b/tests/btrfs/070
> > @@ -60,17 +60,16 @@ run_test()
> >
> >       echo "Wait for fsstress to exit and kill all background workers" =
>>$seqres.full
> >       wait $fsstress_pid
> > -     kill $replace_pid $defrag_pid
> > -     wait
> > +     kill $replace_pid
> > +     wait $replace_pid
> >
> > -     # wait for the defrag and replace operations to finish
> > -     while ps aux | grep "btrfs filesystem defrag" | grep -qv grep; do
> > -             sleep 1
> > -     done
> > +     # wait for the replace operation to finish
> >       while ps aux | grep "replace start" | grep -qv grep; do
> >               sleep 1
> >       done
> >
> > +     _btrfs_kill_stress_defrag_pid $defrag_pid
> > +
> >       echo "Scrub the filesystem" >>$seqres.full
> >       $BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> >       if [ $? -ne 0 ]; then
> > diff --git a/tests/btrfs/072 b/tests/btrfs/072
> > index 6c15b51f..505d0b57 100755
> > --- a/tests/btrfs/072
> > +++ b/tests/btrfs/072
> > @@ -52,13 +52,8 @@ run_test()
> >
> >       echo "Wait for fsstress to exit and kill all background workers" =
>>$seqres.full
> >       wait $fsstress_pid
> > -     kill $defrag_pid
> > -     wait $defrag_pid
> > -     # wait for the defrag operation to finish
> > -     while ps aux | grep "btrfs filesystem defrag" | grep -qv grep; do
> > -             sleep 1
> > -     done
> >
> > +     _btrfs_kill_stress_defrag_pid $defrag_pid
> >       _btrfs_kill_stress_scrub_pid $scrub_pid
> >
> >       echo "Scrub the filesystem" >>$seqres.full
> > diff --git a/tests/btrfs/074 b/tests/btrfs/074
> > index 9b22c620..d51922d0 100755
> > --- a/tests/btrfs/074
> > +++ b/tests/btrfs/074
> > @@ -52,16 +52,15 @@ run_test()
> >
> >       echo "Wait for fsstress to exit and kill all background workers" =
>>$seqres.full
> >       wait $fsstress_pid
> > -     kill $defrag_pid $remount_pid
> > -     wait
> > -     # wait for the defrag and remount operations to finish
> > -     while ps aux | grep "btrfs filesystem defrag" | grep -qv grep; do
> > -             sleep 1
> > -     done
> > +     kill $remount_pid
> > +     wait $remount_pid
> > +     # wait for the remount operation to finish
> >       while ps aux | grep "mount.*$SCRATCH_MNT" | grep -qv grep; do
> >               sleep 1
> >       done
> >
> > +     _btrfs_kill_stress_defrag_pid $defrag_pid
> > +
> >       echo "Scrub the filesystem" >>$seqres.full
> >       $BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> >       if [ $? -ne 0 ]; then
>

