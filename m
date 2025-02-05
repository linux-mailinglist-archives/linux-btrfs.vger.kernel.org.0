Return-Path: <linux-btrfs+bounces-11301-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5C6A299EC
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 20:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6C31889FF5
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 19:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB65C21128F;
	Wed,  5 Feb 2025 19:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3SUN0QF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1856200109
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Feb 2025 19:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782815; cv=none; b=SGdQbzwYYq6Y/p4m3k+H7od+c6Vm1Fg7DvyA9U0C7VKRdIqfl4y7qW6wCMH45SXsXSVd1qVkgCWsIUYbxqMJpIm17mLTxBgY1PHkzxxVOmm08IiRXswcWFYnp/C05yCLTIFaA/InN1u+lvTxjSYgppKv/ulPncyYhiSDl4x8DQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782815; c=relaxed/simple;
	bh=uHmKJjeh2u5wPF35CbGwRFwamUfPT9n/MMBPUmOuX3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ouDuOIDrN6beeP9/vlOvmJltOR/ppbUydKHbU0qK72eaeiDWnhp5gDtoPRuJQEXFGqiAQCfafSI1eOy013X5KzFPzSbjnT7pbfEwHZpBMWTyxGact+2S/hyAmHWP9LLq1YvGrTSbfeDhudODmV4DcjI2OSpgsbCbzZ78PwqdH/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3SUN0QF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9810FC4CED1
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Feb 2025 19:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738782815;
	bh=uHmKJjeh2u5wPF35CbGwRFwamUfPT9n/MMBPUmOuX3g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X3SUN0QFLzVrtjOYpjua2+QGNumKI7u/iNtJYtZNTkK8V5+6Ikd51yeCkC7fg8d70
	 xpmvO6XCf1tiNCY8lhQGMKn7ZO9iO4PlDoYqzoJHxLYRFLPkwlFMH77QcHtQHoDF7U
	 1nY7jPpzGJnGOhNBjvhyZr82QwmC8O4youGcUeVaJZk62v8mZatViICWRRuhi1LvjI
	 E1CIZKcXa2riIAEy6I7JQqmTM+nSrsW15KJkgd6MX/IVjJHHw1dYPxOpgeL9f5TqnB
	 RfsXZ8h6g2fKJpvK3Z6Dkhv3cZGmNVlRbaQwF1571zbwSqHuCLNz4Vn7A06bUIzxRv
	 IarvFRwTSPX3A==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab7430e27b2so27386166b.3
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Feb 2025 11:13:35 -0800 (PST)
X-Gm-Message-State: AOJu0YzC9Xzqv9Imj2CzTGPabiY55KmYaBMPojt7l2FbRc1WI33z8ltt
	d4KD0cQWoNXKCxdb0QStnvHaZoYYtenJFMzLhEsHPxXoihApw9FGm/irZ81eGHB1NKWlnFYfvO1
	uMmKqKm2E6sDH5uwIllEZp42YBdU=
X-Google-Smtp-Source: AGHT+IHGbghGLKn+60XDRJt+LLDtFgrchG6aNMSBeeTewQXv1odZ0qO8VrckF5rxwlOtEOKmWL2qKG7+PsJKVpquYgo=
X-Received: by 2002:a17:907:3f15:b0:ab6:b8dc:824f with SMTP id
 a640c23a62f3a-ab75e2f116cmr397551066b.37.1738782814130; Wed, 05 Feb 2025
 11:13:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e9b8716e2d613cac27e59ceb141f973540f40eef.1738639778.git.wqu@suse.com>
 <CAL3q7H7eJG2pRDQnvsfob7ifOiHSU_W0QNfzXyO=V99c5ugXQQ@mail.gmail.com>
In-Reply-To: <CAL3q7H7eJG2pRDQnvsfob7ifOiHSU_W0QNfzXyO=V99c5ugXQQ@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 5 Feb 2025 19:12:53 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6oAtVcNpMkHKY3+4kH3GjHyxz9UxqWFHcwEoXMmzOajQ@mail.gmail.com>
X-Gm-Features: AWEUYZkRxWIm_uzE3ZKcweM1lsOrjD1__jXkdMWqJAy-wjDni08S7pt0YKqSK4w
Message-ID: <CAL3q7H6oAtVcNpMkHKY3+4kH3GjHyxz9UxqWFHcwEoXMmzOajQ@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: always fallback to buffered write if the inode
 requires checksum
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, "hch@infradead.org" <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 11:19=E2=80=AFAM Filipe Manana <fdmanana@kernel.org>=
 wrote:
>
> On Tue, Feb 4, 2025 at 3:31=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> >
> > [BUG]
> > It is a long known bug that VM image on btrfs can lead to data csum
> > mismatch, if the qemu is using direct-io for the image (this is commonl=
y
> > known as cache mode none).
> >
> > [CAUSE]
> > Inside the VM, if the fs is EXT4 or XFS, or even NTFS from Windows, the
> > fs is allowed to dirty/modify the folio even the folio is under
> > writeback (as long as the address space doesn't have AS_STABLE_WRITES
> > flag inherited from the block device).
> >
> > This is a valid optimization to improve the concurrency, and since thes=
e
> > filesystems have no extra checksum on data, the content change is not a
> > problem at all.
> >
> > But the final write into the image file is handled by btrfs, which need
> > the content not to be modified during writeback, or the checksum will
> > not match the data (checksum is calculated before submitting the bio).
> >
> > So EXT4/XFS/NTRFS believes they can modify the folio under writeback,
> > but btrfs requires no modification, this leads to the false csum
> > mismatch.
> >
> > This is only a controlled example, there are even cases where
> > multi-thread programs can submit a direct IO write, then another thread
> > modifies the direct IO buffer for whatever reason.
> >
> > For such cases, btrfs has no sane way to detect such cases and leads to
> > false data csum mismatch.
> >
> > [FIX]
> > I have considered the following ideas to solve the problem:
> >
> > - Make direct IO to always skip data checksum
> >   This not only requires a new incompatible flag, as it breaks the
> >   current per-inode NODATASUM flag.
> >   But also requires extra handling for no csum found cases.
> >
> >   And this also reduces our checksum protection.
> >
> > - Let hardware to handle all the checksum
> >   AKA, just nodatasum mount option.
> >   That requires trust for hardware (which is not that trustful in a lot
> >   of cases), and it's not generic at all.
> >
> > - Always fallback to buffered write if the inode requires checksum
> >   This is suggested by Christoph, and is the solution utilized by this
> >   patch.
> >
> >   The cost is obvious, the extra buffer copying into page cache, thus i=
t
> >   reduce the performance.
> >   But at least it's still user configurable, if the end user still want=
s
> >   the zero-copy performance, just set NODATASUM flag for the inode
> >   (which is a common practice for VM images on btrfs).
> >
> >   Since we can not trust user space programs to keep the buffer
> >   consistent during direct IO, we have no choice but always falling
> >   back to buffered IO.
> >   At least by this, we avoid the more deadly false data checksum
> >   mismatch error.
> >
> > Suggested-by: hch@infradead.org <hch@infradead.org>
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> > Changelog:
> > v2:
> > - Move the checksum check just after check_direct_IO()
> >   So that we don't need the extra ENOTBLK error code trick to fallback
> >   to buffered IO.
> >
> > - Slightly improve the comment
> >   Adds that only direct write is affected, and why buffered write is
> >   fine.
> > ---
> >  fs/btrfs/direct-io.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
> > index c99ceabcd792..0de4397130be 100644
> > --- a/fs/btrfs/direct-io.c
> > +++ b/fs/btrfs/direct-io.c
> > @@ -855,6 +855,21 @@ ssize_t btrfs_direct_write(struct kiocb *iocb, str=
uct iov_iter *from)
> >                 btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
> >                 goto buffered;
> >         }
> > +       /*
> > +        * For direct IO write, we have no control on the folios passed=
 in,
> > +        * thus the content can change halfway after we calculated the =
data
> > +        * checksum, and result data checksum mismatch and unable to re=
ad
> > +        * the data out anymore.
>
> I would phrase this differently to be more clear:
>
> We can't control the folios being passed in, applications can write to
> them while a
> direct IO write is in progress. This means the content might change
> after we calculate the data
> checksum. Therefore we can end up storing a checksum that doesn't
> match the persisted data.
>
> Otherwise it looks fine to me:
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>

Btw, did you actually run fstests with this?

At least one test is failing after this change:

btrfs/226 2s ... - output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/226.out.bad)
    --- tests/btrfs/226.out 2024-05-20 11:27:55.933394605 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/226.out.bad
2025-02-05 19:09:33.990188790 +0000
    @@ -39,14 +39,11 @@
     Testing write against prealloc extent at eof
     wrote 65536/65536 bytes at offset 0
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    -wrote 65536/65536 bytes at offset 65536
    -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    +pwrite: Resource temporarily unavailable
     File after write:
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/226.out
/home/fdmanana/git/hub/xfstests/results//btrfs/226.out.bad'  to see
the entire diff)



>
> Thanks.
>
> > +        *
> > +        * To be extra safe and avoid false data checksum mismatch, if =
the
> > +        * inode requires data checksum, just fallback to buffered IO.
> > +        * For buffered IO we have full control of page cache and can e=
nsure
> > +        * no one is modifying the content during writeback.
> > +        */
> > +       if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
> > +               btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
> > +               goto buffered;
> > +       }
> >
> >         /*
> >          * The iov_iter can be mapped to the same file range we are wri=
ting to.
> > --
> > 2.48.1
> >
> >

