Return-Path: <linux-btrfs+bounces-14776-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 999AFADF23B
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 18:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399344A0ACF
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 16:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FC02EB5C5;
	Wed, 18 Jun 2025 16:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehqtdz6U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8542063E7
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Jun 2025 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263321; cv=none; b=aKRcgfvAsnFifW6IZ2DcJEXfUwXPr26QSmXieKqnjQ2edE8awtUYRZDVziGOC296O95JyJdd99ptwBseRWQ6/sOFS0mmDKoBUPclb+cp/B8ZiJmYXzqEP2zhZHA8BBpFT72O8Bd83JYfARtNNGSt7zCUzrMFxuYGJBxqYLaYRWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263321; c=relaxed/simple;
	bh=D0mrRqgIl/7VDVTuSZ50v1QjOdj8U1c6/LirYwO5Bj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HaFAn7szpByZ27p37jFxCPkL+zYqn5hPszdtlDLb74omY9edxSlU2I9KK3aXSmJDRDZiXuNxqunpZfa6OycOmGj1syOsYAi4EJQjpbGLLDvBuNzGqZftJONcULwyyfATa6MDuzKptZ8MgT9X8yaMqm5Hxuf69JuucKC5Xx7ahDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ehqtdz6U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750263317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wrchTGE3j452OoiC9LNMCkJ2p4RKo+nkfCDMyJA3t1k=;
	b=ehqtdz6U06Iu7Jr0kUjaawUNOteFaOCDqgVccuggGGfsV1sIL82tru4wWdvGXN7SMMrVQ9
	/sKzL0vf4Y10qZAh1xZVFg+c118GEJN9nTzmUfmlzcpW6eQHjmXmPegojtGnRy3GGFtr8f
	BIiL4nizLwhdLPhXCv7XH995hAnQqpE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-tN0EY7oMPBuaE7rozwSnlw-1; Wed, 18 Jun 2025 12:15:16 -0400
X-MC-Unique: tN0EY7oMPBuaE7rozwSnlw-1
X-Mimecast-MFC-AGG-ID: tN0EY7oMPBuaE7rozwSnlw_1750263315
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-235e1d70d67so64433195ad.0
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Jun 2025 09:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750263315; x=1750868115;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wrchTGE3j452OoiC9LNMCkJ2p4RKo+nkfCDMyJA3t1k=;
        b=TRo4kQ86d2Uwt4h6asVCFvP5XGiJZIzPntOyvRB8thmITEhcICVFuJ8G3aGw8s8DNU
         x1QVfqEx8hE/kA4JNd7zn4jTArwgsQ+YA7J5AMM2oyTPAS0f+/wK9on1dyUjUvGCskbz
         IcNNjtEmP8Sekjom9skIjbkrDjqEgx3nodT2JHG32FrD19tUWoQafMCNsKjjyH6LQPlM
         rJwQk7zALAAvIb4kM2m9oWYubUQC4RpQ8FcOtn6PnoAmWLPIQ83Zz/Ga8LQwwQcImTPn
         IytwAEEW1uERtiLm5Rt+fbmOm9GgPXeyViUD8aUf/R+xs1jOiRMGGJzYzRtLEsMwxOKu
         ZzgA==
X-Forwarded-Encrypted: i=1; AJvYcCUaJHhAi0NDAbrIkPcsZq+lR9OuqGm0crPtrHy+3K2vLqivTDY8khjWt32duV5XOXdG3d7X8JcbN9ICdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbcntXpxYI7JpdsQJy5CP32bI0Jrm4tp7uqqZN5c5kUpXmLfHK
	E3Lb+Zix8mOMZg4sQPRT171brGkR8oMBHGih2bSkb0sKIrDwUEhIugnMdFwTXF59jnCXxCremt7
	2ivGlXKPASUu0eb4S+WhHmBVx/YxVs3TdxKMuDzdLvmVzthXhn+IHEt1I2Z8bA53X
X-Gm-Gg: ASbGncu6fE/l81l6KFwIPWeJcmtE6oXsa+hExFqbOOwvrzA1Bn2dpVS0ZTA+yl210BI
	GwqBLkZXpXjwNJGy1WLT57/QZN1FWsaNc/iyujiz5s57TNNdlZJn3OsTet/++MxQPajFFqN9oXL
	vl+Ss0i8HdoKcIB+YpidK5EG/vhj+ldO4ljqhEHJw/1MCQKmQD1zEf3MVL7TWvfDiHelOnYqgQs
	1gSieX9UGtreUd83AEQ+xmbVNeMPPVJgXMS0JyinUJGt3A43/877FP6g6W4+MQ13OIp6pGk5DrQ
	0tTfD/ZSQqUll7FIeexRSNZmR0/s9tBspcDU+eSyPszC5lcPrzd7k0Rq8AZaQpk=
X-Received: by 2002:a17:903:1b05:b0:234:b41e:37a4 with SMTP id d9443c01a7336-2366afe98dcmr213018055ad.6.1750263314888;
        Wed, 18 Jun 2025 09:15:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTahDyDcmODgmG94C/Zo2qR87d8iLdvWQ/A6BwsGGalOtNH/BqFSqQccT99G7l5z55+fEqkg==
X-Received: by 2002:a17:903:1b05:b0:234:b41e:37a4 with SMTP id d9443c01a7336-2366afe98dcmr213017485ad.6.1750263314304;
        Wed, 18 Jun 2025 09:15:14 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d88c061sm102572565ad.1.2025.06.18.09.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:15:13 -0700 (PDT)
Date: Thu, 19 Jun 2025 00:15:09 +0800
From: Zorro Lang <zlang@redhat.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic/032: fix failure due to attempt to wait for
 non-child process
Message-ID: <20250618161509.5guwfq5hktlnwkvs@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <ad779afaef849e0febdce26cbcb5503beed87341.1748432418.git.fdmanana@suse.com>
 <20250605165225.fajg7aj3btuejhnp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H6h98w--8=-TUridEaOt03v70J3gvLA_g=72iL9hFYL1w@mail.gmail.com>
 <20250606005304.p36cjy23ekdlg53u@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H42puqn4=eX1SthjE_7eowQKvgWAzmbTx79eh+jJbtBqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H42puqn4=eX1SthjE_7eowQKvgWAzmbTx79eh+jJbtBqQ@mail.gmail.com>

On Fri, Jun 13, 2025 at 02:02:53PM +0100, Filipe Manana wrote:
> On Fri, Jun 6, 2025 at 1:53 AM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Thu, Jun 05, 2025 at 08:37:35PM +0100, Filipe Manana wrote:
> > > On Thu, Jun 5, 2025 at 5:52 PM Zorro Lang <zlang@redhat.com> wrote:
> > > >
> > > > On Wed, May 28, 2025 at 12:42:20PM +0100, fdmanana@kernel.org wrote:
> > > > > From: Filipe Manana <fdmanana@suse.com>
> > > > >
> > > > > Running generic/032 can sporadically fail like this:
> > > > >
> > > > >   generic/032 11s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//generic/032.out.bad)
> > > > >       --- tests/generic/032.out   2023-03-02 21:47:53.884609618 +0000
> > > > >       +++ /home/fdmanana/git/hub/xfstests/results//generic/032.out.bad    2025-05-28 10:39:34.549499493 +0100
> > > > >       @@ -1,5 +1,6 @@
> > > > >        QA output created by 032
> > > > >        100 iterations
> > > > >       +/home/fdmanana/git/hub/xfstests/tests/generic/032: line 90: wait: pid 3708239 is not a child of this shell
> > > > >        000000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >................<
> > > > >        *
> > > > >        100000
> > > > >       ...
> > > > >       (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/generic/032.out /home/fdmanana/git/h
> > > > >
> > > > > This is because we are attempting to wait for a process that is not a
> > > > > child process of the test process and it's instead a child of a process
> > > > > spawned by the test.
> > > > >
> > > > > To make sure that after we kill the process running _syncloop() there
> > > > > isn't any xfs_io process still running syncfs, add instead a trap to
> > > > > to _syncloop() that waits for xfs_io to finish before the process running
> > > > > that function exits.
> > > > >
> > > > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > > > ---
> > > >
> > > > Oh... I didn't remove the _pgrep when I reverted those "setsid" things.
> > > >
> > > > CC Darrick, what do you think if I remove the _pgrep from common/rc
> > > > and generic/032 :) On the other words, revert the:
> > > >
> > > >   commit 1bb15a27573eea1df493d4b7223ada2e6c04a07a
> > > >   Author: Darrick J. Wong <djwong@kernel.org>
> > > >   Date:   Mon Feb 3 14:00:29 2025 -0800
> > > >
> > > >       generic/032: fix pinned mount failure
> > >
> > > Reverting that commit won't fix anything. One still needs a mechanism
> > > to ensure that we don't attempt to unmount the scratch device while
> > > xfs_io from sync_pid is still running. The mechanism implemented in
> > > that commit is buggy and the trap based one from this patch should
> > > always work (and we do this trap based approach on several other tests
> > > to solve this same problem).
> >
> > Sure, don't worry, I didn't try to Nack your patch:) Just due to you remove
> > the _pgrep() in your patch, then I thought it can be removed from common/rc
> > totally, looks like nothing need that function. So I tried to confirm that
> > with Darrick (who brought in this function:)
> >
> > Due to commit 1bb15a27573 does two things:
> > 1) create a new function _pgrep
> > 2) call _pgrep in g/032
> >
> > You've removed the 2) in this patch, so I'm wondering how about removing
> > the 1) and 2) totally. As you can see, g/032 is the only one place uses
> > _pgrep:
> 
> Ok, but that shouldn't be a blocker to fix a bug.
> Can we make some progress on this?

Sure, you're right. It'll be merged in this week fstests release. You
can find it in patches-in-queue branch :)

> 
> Do you want me to remove the function in a v2 of this patch, or do it
> as a separate patch?

I'll send a patch to remove it, don't worry.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> Thanks.
> 
> >
> > $ grep -rsn _pgrep .
> > ./common/rc:40:_pgrep()
> > ./tests/generic/032:87:dead_syncfs_pid=$(_pgrep xfs_io)
> >
> > Thanks,
> > Zorro
> >
> >
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > > Thanks,
> > > > Zorro
> > > >
> > > > >  tests/generic/032 | 13 ++++---------
> > > > >  1 file changed, 4 insertions(+), 9 deletions(-)
> > > > >
> > > > > diff --git a/tests/generic/032 b/tests/generic/032
> > > > > index 48d594fe..b04b84de 100755
> > > > > --- a/tests/generic/032
> > > > > +++ b/tests/generic/032
> > > > > @@ -28,6 +28,10 @@ _cleanup()
> > > > >
> > > > >  _syncloop()
> > > > >  {
> > > > > +     # Wait for any running xfs_io command running syncfs before we exit so
> > > > > +     # that unmount will not fail due to the mount being pinned by xfs_io.
> > > > > +     trap "wait; exit" SIGTERM
> > > > > +
> > > > >       while [ true ]; do
> > > > >               _scratch_sync
> > > > >       done
> > > > > @@ -81,15 +85,6 @@ echo $iters iterations
> > > > >  kill $syncpid
> > > > >  wait
> > > > >
> > > > > -# The xfs_io instance started by _scratch_sync could be stuck in D state when
> > > > > -# the subshell running _syncloop & is killed.  That xfs_io process pins the
> > > > > -# mount so we must kill it and wait for it to die before cycling the mount.
> > > > > -dead_syncfs_pid=$(_pgrep xfs_io)
> > > > > -if [ -n "$dead_syncfs_pid" ]; then
> > > > > -     _pkill xfs_io
> > > > > -     wait $dead_syncfs_pid
> > > > > -fi
> > > > > -
> > > > >  # clear page cache and dump the file
> > > > >  _scratch_cycle_mount
> > > > >  _hexdump $SCRATCH_MNT/file
> > > > > --
> > > > > 2.47.2
> > > > >
> > > > >
> > > >
> > >
> >
> 


