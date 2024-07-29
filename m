Return-Path: <linux-btrfs+bounces-6837-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9053E93F84A
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 16:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC7A2832E3
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 14:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC95157484;
	Mon, 29 Jul 2024 14:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dM+AGU/m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7277156C70;
	Mon, 29 Jul 2024 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263567; cv=none; b=joGbWiXAv2zsDP57+boElPOXmUcIFtDGRJuxkcM9g0A1iId0+KDPR6MYV6fKZPMDlIjbVevjWCHv8h8Jmi9FXih39hsCMn96jJC7J0wgUyQyf+Bd3Ll/Osif6mNB3zmP8jFiomZ8zItcpCKfDI/UpODRNWIdoB2ApaCuWAkAB0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263567; c=relaxed/simple;
	bh=b5F+YCrcadXXbcjYPd2AIJIQa99ZIrMyu2gUHeNNKOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1CpgLuWzMeAqbR+MVca5tnWubMLks7+wtajYXN1YpMJd+sGH2nblLxjf2wCciWW+rN/i6bmlY7/Oc141tUKfwf0liOoyrz8lY6Hd8JKaMnHOw4rO/w39fetfZxi56Vtg4WiWWhr0/J4svw8noCDX0k8yxxzOhPtB7EDF7n8Q8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dM+AGU/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEEEC4AF0F;
	Mon, 29 Jul 2024 14:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722263567;
	bh=b5F+YCrcadXXbcjYPd2AIJIQa99ZIrMyu2gUHeNNKOk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dM+AGU/m8NZciuW5aUPl47IMjOO6gc/P0J8XTpHDY6xFUDCpnsnoTz22Je/U1SStN
	 VCzlChH+1zd1qaazHKpKYgdnE//8Uq33pqTA8eE/kSsnlj+wJTKdh1sGRjqWBUMrVG
	 aQ2/TKVE8lVNdgkrtwSUX+8hB08/Fss+rhDkBhfQnUetqpWSIw0uIfW22r1diD/ZhR
	 6NRHfAghLhhIHJSt7h3slLq/02E+OnPQlmP/wqROpMtjvJQ5XhHxs/9Q2mWNyYydWF
	 tcRFaphM7vcQjHoYqZsvpD/ci/mbF32oZtAPDntolFFixv7606eKI9m3/Slsv2MgqE
	 6v9BGTNVNR5pQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52efa16aad9so5208788e87.0;
        Mon, 29 Jul 2024 07:32:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXMWmi3Dcv/SsSCqQeXbU415hLOMBvte6nSq8qdKOTeaCNI7mIeGxDoWx3XT72a0T8tpRD6YLEhwHmIt+3UXnoG4LlO52YdTurdTIRNlr0aw6mfR2tOVnJbbUNLkFrg0VcAK70
X-Gm-Message-State: AOJu0YyxFS6B7MSBo9dsCXoYeBDuo1rNvuR5lf7lhj3fwz2JeSeldz2x
	VW2xPbyy615RE7dnSdElDDAyU3EG+woC0fYCGZKwKVXupKD1sCPTbYcGyBsY76NLijBcGxoBseL
	mmB1kEaZMhR3K11MTDChHVPXJ7n8=
X-Google-Smtp-Source: AGHT+IEBVaqgiEOjUvwvwPzx0pvsiskjIhU0DCLh4DVYzArH+IJswZWaUTO6AMY+SU2YQ7e67MpW1vBM8/qsz7fXgeg=
X-Received: by 2002:a05:6512:210f:b0:52e:941d:7039 with SMTP id
 2adb3069b0e04-5309b2ce6afmr5261071e87.59.1722263565617; Mon, 29 Jul 2024
 07:32:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720083538.2999155-1-yangerkun@huawei.com>
 <CAL3q7H5AivAMSWk3FmmsrSqbeLfqMw_hr05b_Rdzk7hnnrsWiA@mail.gmail.com>
 <4188b7b5-3576-9e5f-6297-794558d7a01e@huawei.com> <9514fd55-4f83-8e43-bdf7-925396ab5e48@huawei.com>
In-Reply-To: <9514fd55-4f83-8e43-bdf7-925396ab5e48@huawei.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 29 Jul 2024 15:32:08 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6bNpDnh=XYKgFOp4xTRHY2EDJ_MaSFx-nHfKnx8gQVkw@mail.gmail.com>
Message-ID: <CAL3q7H6bNpDnh=XYKgFOp4xTRHY2EDJ_MaSFx-nHfKnx8gQVkw@mail.gmail.com>
Subject: Re: [PATCH] generic/736: don't run it on tmpfs
To: yangerkun <yangerkun@huawei.com>
Cc: Christoph Hellwig <hch@infradead.org>, chuck.lever@oracle.com, zlang@kernel.org, 
	fstests@vger.kernel.org, linux-mm@kvack.org, hughd@google.com, 
	akpm@linux-foundation.org, linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 2:54=E2=80=AFPM yangerkun <yangerkun@huawei.com> wr=
ote:
>
> Hi,
>
> =E5=9C=A8 2024/7/24 21:30, yangerkun =E5=86=99=E9=81=93:
> > Hi, All,
> >
> > Sorry for the delay relay(something happened, and cannot use pc
> > before...).
> >
> > =E5=9C=A8 2024/7/21 1:26, Filipe Manana =E5=86=99=E9=81=93:
> >> On Sat, Jul 20, 2024 at 9:38=E2=80=AFAM Yang Erkun <yangerkun@huawei.c=
om> wrote:
> >>>
> >>> We use offset_readdir for tmpfs, and every we call rename, the offset
> >>> for the parent dir will increase by 1. So for tmpfs we will always
> >>> fail since the infinite readdir.
> >>
> >> Having an infinite readdir sounds like a bug, or at least an
> >> inconvenience and surprising for users.
> >> We had that problem in btrfs which affected users/applications, see:
> >>
> >> https://lore.kernel.org/linux-btrfs/2c8c55ec-04c6-e0dc-9c5c-8c7924778c=
35@landley.net/
> >>
> >> which was surprising for them since every other filesystem they
> >> used/tested didn't have that problem.
> >> Why not fix tmpfs?
> >
> > Thanks for all your advise, I will give a detail analysis first(maybe
> > until last week I can do it), and after we give a conclusion about does
> > this behavior a bug or something expected to occur, I will choose the
> > next step!
>
> The case generic/736 do something like below:
>
> 1. create 5000 files(1 2 3 ...) under one dir(testdir)
> 2. call readdir(man 3 readdir) once, and get entry
> 3. rename(entry, "TEMPFILE"), then rename("TMPFILE", entry)
> 4. loop 2~3, until readdir return nothing of we loop too many times(15000=
)
>
> For tmpfs before a2e459555c5f("shmem: stable directory offsets"), every
> rename called, the new dentry will insert to d_subdirs *head* of parent
> dentry, and dcache_readdir won't reenter this dentry if we have already
> enter the dentry, so in step 4 we will break the test since readdir
> return nothing  (I have try to change __d_move the insert to the "tail"
> of d_sub_dirs, problem can still happend).
>
> But after commit a2e459555c5f("shmem: stable directory offsets"),
> simple_offset_rename will just add the new dentry to the maple tree of
> &SHMEM_I(inode)->dir_offsets->mt with the key always inc by 1(since
> simple_offset_add we will find free entry start with octx->newx_offset,
> so the entry freed in simple_offset_remove won't be found). And the same
> case upper will be break since we loop too many times(we can fall into
> infinite readdir without this break).
>
> I prefer this is really a bug, and for the way to fix it, I think we can
> just use the same logic what 9b378f6ad48cf("btrfs: fix infinite
> directory reads") has did, introduce a last_index when we open the dir,
> and then readdir will not return the entry which index greater than the
> last index.

Don't forget to reset the index to whatever is the current last index
when rewind() is called.
We ended up with that bug in btrfs later, see:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3De60aa5da14d01fed8411202dbe4adf6c44bd2a57

Anyway, if the same mistake is made, it would be caught by a test case
for fstests I submitted after:

https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=3D68b958f=
5dc4ab13cfd86f7fb82621f9f022b7626



>
> Looking forward to your comments!
>
> Thanks,
> Erkun.
>
>
>
> >
> > Thanks again for all your advise!
> >
> >
> >>
> >> Thanks.
> >>
> >>>
> >>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> >>> ---
> >>>   tests/generic/736 | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/tests/generic/736 b/tests/generic/736
> >>> index d2432a82..9fafa8df 100755
> >>> --- a/tests/generic/736
> >>> +++ b/tests/generic/736
> >>> @@ -18,7 +18,7 @@ _cleanup()
> >>>          rm -fr $target_dir
> >>>   }
> >>>
> >>> -_supported_fs generic
> >>> +_supported_fs generic ^tmpfs
> >>>   _require_test
> >>>   _require_test_program readdir-while-renames
> >>>
> >>> --
> >>> 2.39.2
> >>>
> >>>

