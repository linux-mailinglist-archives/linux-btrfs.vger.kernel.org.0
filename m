Return-Path: <linux-btrfs+bounces-6728-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAD593D6BD
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 18:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1BFE1F227E5
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 16:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B39217C22A;
	Fri, 26 Jul 2024 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjymUNfu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E1B17838E
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722010441; cv=none; b=f3kqelGBtmw24lctnSjhLH8OpbZmI1Mjq2z86gyOkS0vbNLYlPi9Dn+3A8xwkFm2ggsG0lgk7iuCEPdPGKTOIqd7Z3vQBZoGX2j1OYDOmduIG6/bBtWRwaU/9jrEbtOfDQRDJ4oVRSPwvvxfLJy+w6slICVn562Q7GHb6LejlLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722010441; c=relaxed/simple;
	bh=HTfyfYIqNcHZFVTVF7SnrAEneR+3CsZ0B5TFSPUFvSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VPDUi1+v8/bLNoIO1+juHsOgOfFYlMaS7QV/hdc9tWaQ6s7jeZ++C+Qi35AGfxAW+04ouA2bDpjRijBBHgxRLAf5y3Hb9WzF85QL02cDXU6aSe4fxuxlCCKfLT+bUV2AWj9DvF8OjS0y4n4uhb4nYcQSpO9PLPIKmMRC6acFaVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjymUNfu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B69AC4AF0E
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 16:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722010441;
	bh=HTfyfYIqNcHZFVTVF7SnrAEneR+3CsZ0B5TFSPUFvSw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CjymUNfucU2lYq28EG94dfO3MIPUWmF2HSH/H0+N/Ht4IcDa/SGmqLpILudtgbwPW
	 VnkfjHD9UxgDPHS621ATJTXoRuye0BDK8AFCWcC75H6I9dhWaDmNg1ynQkKliBuPjM
	 pZt7ecENyqMdvBqL6BOaL+2pIPRg2jqaTd2KKQkUKVvIdMErPsnfRPsKGAmdkLS3SJ
	 1hj/usTZuiS8MYTj+b//R6puHGW0Izq54wTYyg0DFSENCF2Gz62erKxEJrPWlZYNBm
	 eWdZnEUAyDDvop2fkRkZFzubRh5jKcxyk9RuqYl0aLnUQuKUgg5z4L9ngbX2lzS4iJ
	 NtXLXObZLzrTw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52efa16aad9so1994212e87.0
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 09:14:01 -0700 (PDT)
X-Gm-Message-State: AOJu0YzyCjoH/DZRzTfY6nHZZDLCeK8gGAozXnRO+j1RlXoi6HmrlbTL
	UGPEMammK36633Hd9HjfaoZuzg44yOCkl4lmBW0mVts02MmNBhWV2rJxS7+VQWbM80DoVKt1Rd3
	w4uK5QTWtdrj1WLV8GX7X+Tt4Lbw=
X-Google-Smtp-Source: AGHT+IHcnYZN/ai9u4sWoAI0pg+QAmrOjvDXlpsPFPsaO6wHTi9F1+1Wkywyj8zvLjsGijTZvT/bFstim+EdAXHHCGM=
X-Received: by 2002:ac2:4bd1:0:b0:52e:9b92:4999 with SMTP id
 2adb3069b0e04-5309b269ae5mr238922e87.2.1722010439873; Fri, 26 Jul 2024
 09:13:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0b841d46-12fe-4e64-9abb-871d8d0de271@redhat.com>
 <CAL3q7H5VoYb6BAXYR+VZbAWirnfYRf++raT752j8nVa-0xJ7hw@mail.gmail.com> <0192c705-df2c-4fcf-8385-4ece04e4ba3f@redhat.com>
In-Reply-To: <0192c705-df2c-4fcf-8385-4ece04e4ba3f@redhat.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 26 Jul 2024 17:13:22 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6f=y5xJWn7UOFdbsAktEkE9EY71rbBAeZ0VRvN4DM2MQ@mail.gmail.com>
Message-ID: <CAL3q7H6f=y5xJWn7UOFdbsAktEkE9EY71rbBAeZ0VRvN4DM2MQ@mail.gmail.com>
Subject: Re: Appending from unpopulated page creates hole
To: Hanna Czenczek <hreitz@redhat.com>
Cc: linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 1:23=E2=80=AFPM Hanna Czenczek <hreitz@redhat.com> =
wrote:
>
> On 25.07.24 12:19, Filipe Manana wrote:
> > On Thu, Jul 25, 2024 at 10:16=E2=80=AFAM Hanna Czenczek <hreitz@redhat.=
com> wrote:
> >> Hi,
> >>
> >> I=E2=80=99ve noticed that appending to a file on btrfs will create a h=
ole before the appended data under certain circumstances:
> >>
> >> - Appending means O_APPEND or RWF_APPEND,
> >> - Writing is done in direct mode, i.e. O_DIRECT, and
> >> - The source buffer is not present in the page tables (what mmap() cal=
ls =E2=80=9Cunpopulated=E2=80=9D).
> >>
> >> The hole seems to generally have the size of the data being written (i=
.e. a 64k write will create a 64k hole, followed by the 64k of data we actu=
ally wanted to write), but I assume this is true only up to a specific size=
 (depending on how the request is split in the kernel).
> >>
> >> I=E2=80=99ve appended a reproducer.
> >>
> >> We encounter this problem with virtio-fs (sharing of directories betwe=
en a virtual machine host and guest), where writing is done by virtiofsd, a=
 process external to the VMM (e.g. qemu), but the buffer comes from the VM =
guest.  Memory is shared between virtiofsd and the VMM, so virtiofsd often =
writes data from shared memory without having accessed it itself, so it isn=
=E2=80=99t present in virtiofsd=E2=80=99s page tables.
> >>
> >> Stefano Garzarella (CC-ed) has tested some Fedora kernels, and has con=
firmed that this bug does not appear in 6.0.7-301.fc37.x86_64, but does app=
ear in 6.0.9-300.fc37.x86_64.
> >>
> >> While I don=E2=80=99t know anything about btrfs code, I looked into it=
, and I believe the changes made by commit 8184620ae21213d51eaf2e0bd4186baa=
cb928172 (btrfs: fix lost file sync on direct IO write with nowait and dsyn=
c iocb) may have caused this.  Specifically, it changed the `goto again` on=
 EFAULT to `goto relock`, a much earlier label, which causes btrfs_direct_w=
rite() to call generic_write_checks() again after the first btrfs_dio_write=
() attempt.
> >>
> >> btrfs_dio_write() will have already allocated extents for the data and=
 updated the file length before trying to actually write the data (which ge=
nerates the EFAULT), so this second generic_write_checks() call will update=
 the I/O position to this new file length, exactly at the end of the area t=
o where the data was supposed to be written.
> > Yes.
> >
> >> To test this hypothesis, I=E2=80=99ve tried skipping the generic_write=
_checks() call after reaching this specific goto, and that does make the bu=
g disappear.
> > Yes that confirms it, but it's not the correct fix but the inode was
> > unlocked and relocked and a lot of things may have changed between
> > those steps.
>
> I thought as much :)
>
> > I'll work on a fix and let you know when it's ready in case you want
> > to test/review.
>
> Great, thanks a lot!

So here it is:

https://lore.kernel.org/linux-btrfs/a7cdb10155e5e823ce82edfc8eed99d1b0ef4ee=
b.1722005943.git.fdmanana@suse.com/

Note that this applies only to Linus' tree (6.11 changes, merge
window), due to some refactorings/cleanups, but it's fairly simple to
backport to stable kernels.
Here's a gist with a version that applies at least to kernel 6.10:

https://gist.githubusercontent.com/fdmanana/c835e21c708941e84ec3dbabd091a0d=
a/raw/27551e26d54ffc399af49e6ffbbca5f58d300797/append-dio-fix-6.10.patch

Thanks.

>
> Hanna
>

