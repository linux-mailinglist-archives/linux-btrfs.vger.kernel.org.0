Return-Path: <linux-btrfs+bounces-3710-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E52488FB3D
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 10:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 540A529ADA1
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 09:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6357BB1C;
	Thu, 28 Mar 2024 09:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTZ0mDd8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD8554665;
	Thu, 28 Mar 2024 09:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617736; cv=none; b=mpF5MqKiaZ5PBEekrC3OQT3oKFiS4GHDe7O/v4TMckoiLzatNSXJNaygIdcHqxiYwpEi1su/7CiIUls6x+B7UxGFf2zZ45pEWZoumHJ+jk6PojyIG4k73O0UbVnGXXHlTXXoQws08+zEXtzruPrC6yZrpD7WdqIkn6AQdYfQIoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617736; c=relaxed/simple;
	bh=MLiC16heh8VLgR4nelgzrsNkbvODhBRW2RO926oAPJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=raBylzabHgEeRNptnSa6DLCGtNG7kafSO6ZVrVJ9lj3WV77kegIjG7a3fL0c34X3BF7Mwd2rqy4XDn1irw8TdKGOJ8ugfpRr9o5CCWAY2NMsYQe07U6PzEOjLMBqjaf3cKp+DuI+ydnDRYtOi0/1LGp9i6DUdukD2v641AceW98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTZ0mDd8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E252BC43394;
	Thu, 28 Mar 2024 09:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711617735;
	bh=MLiC16heh8VLgR4nelgzrsNkbvODhBRW2RO926oAPJk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RTZ0mDd8SdTahms8Qhof7YLzUahTaBZGMNWnorasyeyakUeNRC73S+iaGWtFTpcrL
	 seYl503yPhJ1WVKrRjn8r6tFLyk74TdeX+qeGanz2/gj2TKrfwOZnEVfwbZ3pAHzaQ
	 2s5/FypoR7ICjr5TJ2MBY+XyQ9NEekL+vhYQ3/ZkAFjgfBcJyjagYu2AwJzGm1oH0j
	 3UxtD1IT3l279vgpGJmsOhpHVDCFcfaMRB7X5W2nLD4aB71SyV84pHazZGIYmqST54
	 zXw7qvJ4Ib3K7CxsHenv0Y8C08b5aJVWIoyK1fqOhHb5HLoPdWNcSOSCNGG4NU7bI2
	 9v0BGTSGs84Lw==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a450bedffdfso78956066b.3;
        Thu, 28 Mar 2024 02:22:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXsklUn88uoQ3h706tl+iWkNIzmIcpXllOoUwDKKawbBdzv91i/u7jKqw4Siv89s/QhPNuqNN/qfHCk2QgYnZ5fdMz6bjuZcnC3sQ8=
X-Gm-Message-State: AOJu0YzB2YQa/02/4nYF65Rwce3QO6Wr3jXDN9n+owY1gbzUi9wmrEwK
	pMFQ2L3zJ/PW9koSiovLXso0PtWq7uERwPjPr5JFDvL0oGS9h8qjHFMHIG7TzqVpfFKzUowsJzW
	Ft24B4txIlrXex/ZfjNKAnlEZemE=
X-Google-Smtp-Source: AGHT+IFI5cij4smi98DyFKl1pj0Fshv6s7z5i/vOacMdFs8nxhVilb0Ybtoey5bmVBoAlY7/A/ut/ZKzyRGlt3ODd+0=
X-Received: by 2002:a17:906:ee8d:b0:a47:3527:96d2 with SMTP id
 wt13-20020a170906ee8d00b00a47352796d2mr1801058ejb.0.1711617734477; Thu, 28
 Mar 2024 02:22:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711558345.git.fdmanana@suse.com> <e5f1141cbe307e6057554e1c8fb8cff188ab68f0.1711558345.git.fdmanana@suse.com>
 <15593268-e561-4054-865a-98c704fbf65e@oracle.com>
In-Reply-To: <15593268-e561-4054-865a-98c704fbf65e@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 28 Mar 2024 09:21:37 +0000
X-Gmail-Original-Message-ID: <CAL3q7H530X+rNSzw8Vd-NXtRuhi9tdD5CYrhXkaOyTYHwtPLxQ@mail.gmail.com>
Message-ID: <CAL3q7H530X+rNSzw8Vd-NXtRuhi9tdD5CYrhXkaOyTYHwtPLxQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] btrfs: add helper to kill background process
 running _btrfs_stress_balance
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 8:17=E2=80=AFAM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> On 3/28/24 01:11, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Killing a background process running _btrfs_stress_balance() is not as
> > simple as sending a signal to the process and waiting for it to die.
> > Therefore we have the following logic to terminate such process:
> >
> >     kill $pid
> >     wait $pid
> >     # Wait for the balance operation to finish.
> >     while ps aux | grep "balance start" | grep -qv grep; do
>
>
> >         sleep 1
> >     done
> >
> > Since this is repeated in several test cases, move this logic to a comm=
on
> > helper and use it in all affected test cases. This will help to avoid
> > repeating the same code again several times in upcoming changes.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
>
> A few minor things below.
>
> > ---
> >   common/btrfs    | 14 ++++++++++++++
> >   tests/btrfs/060 |  8 ++------
> >   tests/btrfs/061 | 10 ++++------
> >   tests/btrfs/062 | 10 ++++------
> >   tests/btrfs/063 | 10 ++++------
> >   tests/btrfs/064 | 10 ++++------
> >   tests/btrfs/255 |  8 ++------
> >   7 files changed, 34 insertions(+), 36 deletions(-)
> >
> > diff --git a/common/btrfs b/common/btrfs
> > index aa344706..e95cff7f 100644
> > --- a/common/btrfs
> > +++ b/common/btrfs
> > @@ -308,6 +308,20 @@ _btrfs_stress_balance()
> >       done
> >   }
> >
> > +# Kill a background process running _btrfs_stress_balance()
> > +_btrfs_kill_stress_balance_pid()
> > +{
> > +     local balance_pid=3D$1
> > +
> > +     # Ignore if process already died.
> > +     kill $balance_pid &> /dev/null
> > +     wait $balance_pid &> /dev/null
> > +     # Wait for the balance operation to finish.
> > +     while ps aux | grep "balance start" | grep -qv grep; do
>
>
>   We can use pgrep instead. I will make the following changes before
>   merging if you are okay with it.

Not doing such a change was intentional, as the goal is just to move
repeated code into a helper.
I would prefer for such change to be done separately in its own patch.

>
> -       while ps aux | grep "balance start" | grep -qv grep; do
> +       while pgrep -f "btrfs balance start" > /dev/null; do
>
>
>
> > +             sleep 1
> > +     done
> > +}
> > +
> >   # stress btrfs by creating/mounting/umounting/deleting subvolume in a=
 loop
> >   _btrfs_stress_subvolume()
> >   {
> > diff --git a/tests/btrfs/060 b/tests/btrfs/060
> > index a0184891..58167cc6 100755
> > --- a/tests/btrfs/060
> > +++ b/tests/btrfs/060
> > @@ -57,12 +57,8 @@ run_test()
> >       wait $fsstress_pid
> >
> >       touch $stop_file
> > -     kill $balance_pid
> > -     wait
> > -     # wait for the balance operation to finish
> > -     while ps aux | grep "balance start" | grep -qv grep; do
> > -             sleep 1
> > -     done
> > +     wait $subvol_pid
> > +     _btrfs_kill_stress_balance_pid $balance_pid
> >
> >       echo "Scrub the filesystem" >>$seqres.full
> >       $BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> > diff --git a/tests/btrfs/061 b/tests/btrfs/061
> > index c1010413..d0b55e48 100755
> > --- a/tests/btrfs/061
> > +++ b/tests/btrfs/061
> > @@ -51,12 +51,10 @@ run_test()
> >
> >       echo "Wait for fsstress to exit and kill all background workers" =
>>$seqres.full
> >       wait $fsstress_pid
> > -     kill $balance_pid $scrub_pid
> > -     wait
> > -     # wait for the balance and scrub operations to finish
> > -     while ps aux | grep "balance start" | grep -qv grep; do
> > -             sleep 1
> > -     done
> > +     _btrfs_kill_stress_balance_pid $balance_pid
> > +     kill $scrub_pid
> > +     wait $scrub_pid
> > +     # wait for the crub operation to finish
>
> s/crub/scrub/

Yeah, but the comment is going away in the patch that adds the helper
to kill scrub.

Thanks.

>
> Thanks, Anand
>
> >       while ps aux | grep "scrub start" | grep -qv grep; do
> >               sleep 1
> >       done
> > diff --git a/tests/btrfs/062 b/tests/btrfs/062
> > index 818a0156..a2639d6c 100755
> > --- a/tests/btrfs/062
> > +++ b/tests/btrfs/062
> > @@ -52,12 +52,10 @@ run_test()
> >
> >       echo "Wait for fsstress to exit and kill all background workers" =
>>$seqres.full
> >       wait $fsstress_pid
> > -     kill $balance_pid $defrag_pid
> > -     wait
> > -     # wait for the balance and defrag operations to finish
> > -     while ps aux | grep "balance start" | grep -qv grep; do
> > -             sleep 1
> > -     done
> > +     _btrfs_kill_stress_balance_pid $balance_pid
> > +     kill $defrag_pid
> > +     wait $defrag_pid
> > +     # wait for the defrag operation to finish
> >       while ps aux | grep "btrfs filesystem defrag" | grep -qv grep; do
> >               sleep 1
> >       done
> > diff --git a/tests/btrfs/063 b/tests/btrfs/063
> > index 2f771baf..baf0c356 100755
> > --- a/tests/btrfs/063
> > +++ b/tests/btrfs/063
> > @@ -51,12 +51,10 @@ run_test()
> >
> >       echo "Wait for fsstress to exit and kill all background workers" =
>>$seqres.full
> >       wait $fsstress_pid
> > -     kill $balance_pid $remount_pid
> > -     wait
> > -     # wait for the balance and remount loop to finish
> > -     while ps aux | grep "balance start" | grep -qv grep; do
> > -             sleep 1
> > -     done
> > +     _btrfs_kill_stress_balance_pid $balance_pid
> > +     kill $remount_pid
> > +     wait $remount_pid
> > +     # wait for the remount loop to finish
> >       while ps aux | grep "mount.*$SCRATCH_MNT" | grep -qv grep; do
> >               sleep 1
> >       done
> > diff --git a/tests/btrfs/064 b/tests/btrfs/064
> > index e9b46ce6..58b53afe 100755
> > --- a/tests/btrfs/064
> > +++ b/tests/btrfs/064
> > @@ -63,12 +63,10 @@ run_test()
> >
> >       echo "Wait for fsstress to exit and kill all background workers" =
>>$seqres.full
> >       wait $fsstress_pid
> > -     kill $balance_pid $replace_pid
> > -     wait
> > -     # wait for the balance and replace operations to finish
> > -     while ps aux | grep "balance start" | grep -qv grep; do
> > -             sleep 1
> > -     done
> > +     _btrfs_kill_stress_balance_pid $balance_pid
> > +     kill $replace_pid
> > +     wait $replace_pid
> > +     # wait for the replace operation to finish
> >       while ps aux | grep "replace start" | grep -qv grep; do
> >               sleep 1
> >       done
> > diff --git a/tests/btrfs/255 b/tests/btrfs/255
> > index 7e70944a..aa250467 100755
> > --- a/tests/btrfs/255
> > +++ b/tests/btrfs/255
> > @@ -41,12 +41,8 @@ for ((i =3D 0; i < 20; i++)); do
> >       $BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
> >       $BTRFS_UTIL_PROG quota disable $SCRATCH_MNT
> >   done
> > -kill $balance_pid &> /dev/null
> > -wait
> > -# wait for the balance operation to finish
> > -while ps aux | grep "balance start" | grep -qv grep; do
> > -     sleep 1
> > -done
> > +
> > +_btrfs_kill_stress_balance_pid $balance_pid
> >
> >   echo "Silence is golden"
> >   status=3D0
>

