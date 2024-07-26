Return-Path: <linux-btrfs+bounces-6731-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4138A93D6EE
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 18:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 632921C221DD
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 16:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC55717C9E4;
	Fri, 26 Jul 2024 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhjMYpgs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DA3749C
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722011573; cv=none; b=ji/PVAXf39NRXjQFPVcAwdISVoDwMWgzI9XcVVTlAUc0QGLn4f3dnLZK34XSMZI26h8hcspRXNuwF6kRteiX0zmP4trnBSAOICL/TaOkl8nf2hEFo02kOOe67qmtAfggDkrVJgI8s7GoW5c+tAAFWcOHGsYczuQ+Bye4qXKpOKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722011573; c=relaxed/simple;
	bh=yXcZb8BPZPJ/PMyvMFE2SOJC909zIYT1iBoZ6Yhk4Ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ESOGhKY5nElwHJOVsa0DWyvXi/APTlIPDIBdjrSZXlXBFOolJ8ygTT4JgCRzEv5oVsR+zbm4OXFK4x7g/WbVakjJ3Sk7TfLgZZfe1jFFsKkuSc1jAqym7jSbxoPIKSwoXqVkTxN7RN1PGEVGJEofT4rX5ObcuZlszojRwpXPgXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhjMYpgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4B5C4AF09
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 16:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722011572;
	bh=yXcZb8BPZPJ/PMyvMFE2SOJC909zIYT1iBoZ6Yhk4Ns=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hhjMYpgsf5zdJaAtDBx7aX0FmsFs4q0O4hGKfb27dSatgjauj+USdJXDz17bynMSP
	 VqWQJJyNuf3yX4+UBB53OdaDE4PiLPGKaeU/UkfSAaP3cnS5/e/IXzvegFo3ICw9UV
	 RBFTxufFXZlm0sqYu4mZgE6Eq+fhuHC9oFquoTGH5vCWjUycF58qUxSvUujLQVSyd+
	 iwr6JCiZ1/XaX4ksoZRdTsSJg9lpEmmPEbTATdsoFvXWGcWul6OLgRHwun3zza3sDS
	 KE0vUhVnU+Vry9T6T1uJ88m8iYq1GNrl7ZkJgYBKnW69SdH3nDNlZ7SJhTq+5NNhLS
	 HSycuvltzj/fQ==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7aa4ca9d72so231366666b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 09:32:51 -0700 (PDT)
X-Gm-Message-State: AOJu0YzmseKOJeaH/76e1rk4szfCXCRlVJWr2IBGnXOb1ia3CdM3mAEn
	RqxCpTL37DZdAlIvHaYiC/hB6XroUyv8o3mk8jjz4hQvX3YLyZf/hvUcgblSuBXIq67KWP1M4pp
	NN1wQYmhSfCR7zLldthLw6LU2/jM=
X-Google-Smtp-Source: AGHT+IH4YBfrLDm4V4Jj0Tv5KsGMhSgQa0sqES5W7z6b2Ydngr46amm5o1KukmF/oZD+GJ9g6/jCOzlTFINBzCbeSk4=
X-Received: by 2002:a17:907:7d88:b0:a7a:8bcf:ac64 with SMTP id
 a640c23a62f3a-a7d400b2964mr2169366b.36.1722011570295; Fri, 26 Jul 2024
 09:32:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0b841d46-12fe-4e64-9abb-871d8d0de271@redhat.com>
 <CAL3q7H5VoYb6BAXYR+VZbAWirnfYRf++raT752j8nVa-0xJ7hw@mail.gmail.com>
 <0192c705-df2c-4fcf-8385-4ece04e4ba3f@redhat.com> <CAL3q7H6f=y5xJWn7UOFdbsAktEkE9EY71rbBAeZ0VRvN4DM2MQ@mail.gmail.com>
In-Reply-To: <CAL3q7H6f=y5xJWn7UOFdbsAktEkE9EY71rbBAeZ0VRvN4DM2MQ@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 26 Jul 2024 17:32:12 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7H-DCKObFv3enobqkzDqccw8KLOoEFStugR6fkc-aX=w@mail.gmail.com>
Message-ID: <CAL3q7H7H-DCKObFv3enobqkzDqccw8KLOoEFStugR6fkc-aX=w@mail.gmail.com>
Subject: Re: Appending from unpopulated page creates hole
To: Hanna Czenczek <hreitz@redhat.com>
Cc: linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 5:13=E2=80=AFPM Filipe Manana <fdmanana@kernel.org>=
 wrote:
>
> On Thu, Jul 25, 2024 at 1:23=E2=80=AFPM Hanna Czenczek <hreitz@redhat.com=
> wrote:
> >
> > On 25.07.24 12:19, Filipe Manana wrote:
> > > On Thu, Jul 25, 2024 at 10:16=E2=80=AFAM Hanna Czenczek <hreitz@redha=
t.com> wrote:
> > >> Hi,
> > >>
> > >> I=E2=80=99ve noticed that appending to a file on btrfs will create a=
 hole before the appended data under certain circumstances:
> > >>
> > >> - Appending means O_APPEND or RWF_APPEND,
> > >> - Writing is done in direct mode, i.e. O_DIRECT, and
> > >> - The source buffer is not present in the page tables (what mmap() c=
alls =E2=80=9Cunpopulated=E2=80=9D).
> > >>
> > >> The hole seems to generally have the size of the data being written =
(i.e. a 64k write will create a 64k hole, followed by the 64k of data we ac=
tually wanted to write), but I assume this is true only up to a specific si=
ze (depending on how the request is split in the kernel).
> > >>
> > >> I=E2=80=99ve appended a reproducer.
> > >>
> > >> We encounter this problem with virtio-fs (sharing of directories bet=
ween a virtual machine host and guest), where writing is done by virtiofsd,=
 a process external to the VMM (e.g. qemu), but the buffer comes from the V=
M guest.  Memory is shared between virtiofsd and the VMM, so virtiofsd ofte=
n writes data from shared memory without having accessed it itself, so it i=
sn=E2=80=99t present in virtiofsd=E2=80=99s page tables.
> > >>
> > >> Stefano Garzarella (CC-ed) has tested some Fedora kernels, and has c=
onfirmed that this bug does not appear in 6.0.7-301.fc37.x86_64, but does a=
ppear in 6.0.9-300.fc37.x86_64.
> > >>
> > >> While I don=E2=80=99t know anything about btrfs code, I looked into =
it, and I believe the changes made by commit 8184620ae21213d51eaf2e0bd4186b=
aacb928172 (btrfs: fix lost file sync on direct IO write with nowait and ds=
ync iocb) may have caused this.  Specifically, it changed the `goto again` =
on EFAULT to `goto relock`, a much earlier label, which causes btrfs_direct=
_write() to call generic_write_checks() again after the first btrfs_dio_wri=
te() attempt.
> > >>
> > >> btrfs_dio_write() will have already allocated extents for the data a=
nd updated the file length before trying to actually write the data (which =
generates the EFAULT), so this second generic_write_checks() call will upda=
te the I/O position to this new file length, exactly at the end of the area=
 to where the data was supposed to be written.
> > > Yes.
> > >
> > >> To test this hypothesis, I=E2=80=99ve tried skipping the generic_wri=
te_checks() call after reaching this specific goto, and that does make the =
bug disappear.
> > > Yes that confirms it, but it's not the correct fix but the inode was
> > > unlocked and relocked and a lot of things may have changed between
> > > those steps.
> >
> > I thought as much :)
> >
> > > I'll work on a fix and let you know when it's ready in case you want
> > > to test/review.
> >
> > Great, thanks a lot!
>
> So here it is:
>
> https://lore.kernel.org/linux-btrfs/a7cdb10155e5e823ce82edfc8eed99d1b0ef4=
eeb.1722005943.git.fdmanana@suse.com/

I updated it to a v2 since there was missing unlock update in error
path for fsync:

https://lore.kernel.org/linux-btrfs/4922c658c56d0f5be975a477facebbc4df588da=
9.1722010742.git.fdmanana@suse.com/

(it wouldn't affect that reproducer)

>
> Note that this applies only to Linus' tree (6.11 changes, merge
> window), due to some refactorings/cleanups, but it's fairly simple to
> backport to stable kernels.
> Here's a gist with a version that applies at least to kernel 6.10:
>
> https://gist.githubusercontent.com/fdmanana/c835e21c708941e84ec3dbabd091a=
0da/raw/27551e26d54ffc399af49e6ffbbca5f58d300797/append-dio-fix-6.10.patch

And the updated gist is now:

https://gist.githubusercontent.com/fdmanana/96a6e4006a7fe7b22c4e014bc496c25=
3/raw/f29ff056d65ae28025fc9637f9c5773457f4bb9d/dio-append-write-fix-6.10.pa=
tch

>
> Thanks.
>
> >
> > Hanna
> >

