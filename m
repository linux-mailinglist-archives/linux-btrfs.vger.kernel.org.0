Return-Path: <linux-btrfs+bounces-11714-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4A4A407E0
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2025 12:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01F4317E92E
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2025 11:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564D2209693;
	Sat, 22 Feb 2025 11:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nF6xwGjr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E4D6FC3;
	Sat, 22 Feb 2025 11:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740223816; cv=none; b=qUG2dAzQffOxcM7FmqL0b87D0uHC6k/n3acMMXS+vBkoVAk86lx9ZKMHKsstGk/+DgkcI3L9QJHmlKHJP/rNBMXATHKVmKbeSkiz+jwvMgWCj2Z4g+j0/BiICnEQaUNr92j53kO6/j/pdEQlv/UPw3QQDlSs4pKu9omGQExgrJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740223816; c=relaxed/simple;
	bh=e9NtEVeOpyPCTknoebnxWmQvsujMhO0aDlcq3PRShXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I07h5qF+LA6SOtsp7nDVnsuD4CerYTbTBvL8/6mD1fJiLZdG7mQuwWGNEWsnSu0ApzIZYd5XjlrgIEQ6MDcs10xkqYcNmTE+tGSxHn0Bdf80eKdtOHeEWApfPSEqDxf6C2iTu4SA8jUP1d0naFEKTB1Iw7pOVcDa6KkSHd2wLFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nF6xwGjr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDAAC4CED1;
	Sat, 22 Feb 2025 11:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740223815;
	bh=e9NtEVeOpyPCTknoebnxWmQvsujMhO0aDlcq3PRShXQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nF6xwGjruw/sxjHX+RSG5ifWfL1eZGK/mzoowO5mPxueDSl0XcebfyppQOR7DoBFs
	 vHIfIe57rYz0tCsvRuq094IfLoskdHfvoD7tfjaeCxfIZbWZHKopcu/dOhdPg8MPsE
	 9GjotrRQRZrAO5KAuKLYdKeUWXtkDzzdKhPMxZ7f/osBDYtcB9a6H28yMVdujP9vbj
	 U5JreYKFfG7679qM0avl2ZNc7jIrHnVyxnOIEWoPzy/u5O2tLxyPGsaU4cZXP1KAlR
	 BdmkrRrT5+/d9V8/QMzjRiRUnSTizz3plKQGz1QmqBvqiG9UciEfXxxeq0oxkZTUUh
	 NK9zpTOWPskww==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso509537966b.1;
        Sat, 22 Feb 2025 03:30:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVBhzNrum3Ri+ILt7EJBV3+WWgVgVcKGCT/xc3w8zy5dvM1foRyAfuk+46ndIE1e7n6x7xTXUWILfF5qzY=@vger.kernel.org, AJvYcCXtC3gD3konFlk//VZ2yL+p77RsQ8Hl5TYRPObLRxAVFgfX7amIfbb/GoMkI39NbKqqEWzS16is@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+YzPJKQ4MmlWUe2Djk8zuWlmFOqf6lqN/8akcfGGFc2b2JvK2
	mQNIgKi4cvIXNDW3+HeehDyyuTqxL8d3zP+KTOoVrYxt59wy5+xRKd/ecRqNKQr2sZ+G4q5Oz3C
	ZIqU9rKPZ6WMXXHfCV6ROY5WKttM=
X-Google-Smtp-Source: AGHT+IFm1gaQZ1uxwKoW5u4HcAn0zwfBm9swa2GnkU8/bmA1aOzAi2y9I90eMyOmYHdxleACdbhB1ptxRMTjz8gdx5E=
X-Received: by 2002:a17:906:7950:b0:ab7:63fa:e4ab with SMTP id
 a640c23a62f3a-abc0cd0b6bamr663853066b.0.1740223813667; Sat, 22 Feb 2025
 03:30:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e73cfe5310a8cee5f6c709d54b8c18ff52e39a0a.1739918100.git.anand.jain@oracle.com>
 <CAL3q7H4GgaQKTLzXzza4xKsoa22pG6MbOFYOuNhK-5J-ieZdRg@mail.gmail.com>
 <20250221150311.eabczmxfxnvndkqk@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <4e013629-c1ff-4e84-99f0-6916058ca6ab@oracle.com>
In-Reply-To: <4e013629-c1ff-4e84-99f0-6916058ca6ab@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sat, 22 Feb 2025 11:29:37 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6cAGE4C5vRw60P1iu1zoA=JnK3+rNMbiN8CXiMT3C02g@mail.gmail.com>
X-Gm-Features: AWEUYZlmEXpC0utDVMdcB86WBs4ao8fFF1tI2WclVa20x23mA5JfJRaaz-GvozM
Message-ID: <CAL3q7H6cAGE4C5vRw60P1iu1zoA=JnK3+rNMbiN8CXiMT3C02g@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs/226: fill in missing comments changes
To: Anand Jain <anand.jain@oracle.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Zorro Lang <zlang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 11:17=E2=80=AFAM Anand Jain <anand.jain@oracle.com>=
 wrote:
>
>
>
> On 21/2/25 23:03, Zorro Lang wrote:
> > On Fri, Feb 21, 2025 at 12:04:32PM +0000, Filipe Manana wrote:
> >> On Tue, Feb 18, 2025 at 10:36=E2=80=AFPM Anand Jain <anand.jain@oracle=
.com> wrote:
> >>>
> >>> From: Qu Wenruo <wqu@suse.com>
> >>>
> >>> Update comments that were previously missed.
> >>>
> >>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> >>> ---
> >>>   tests/btrfs/226 | 6 ++----
> >>>   1 file changed, 2 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/tests/btrfs/226 b/tests/btrfs/226
> >>> index 359813c4f394..ce53b7d48c49 100755
> >>> --- a/tests/btrfs/226
> >>> +++ b/tests/btrfs/226
> >>> @@ -22,10 +22,8 @@ _require_xfs_io_command fpunch
> >>>
> >>>   _scratch_mkfs >>$seqres.full 2>&1
> >>>
> >>> -# This test involves RWF_NOWAIT direct IOs, but for inodes with data=
 checksum,
> >>> -# btrfs will fall back to buffered IO unconditionally to prevent dat=
a checksum
> >>> -# mimsatch, and that will break RWF_NOWAIT with -EAGAIN.
> >>> -# So here we have to go with nodatasum mount option.
> >>> +# RWF_NOWAIT works only with direct I/O and requires an inode with n=
odatasum
> >>> +# to avoid checksum mismatches. Otherwise, it falls back to buffered=
 I/O.
> >>
> >> Btw, this is different from what I suggested before here:
> >>
> >> https://lore.kernel.org/fstests/68aa436b-4ddd-4ee7-ad5a-8eca55aae176@o=
racle.com/T/#mb2369802d2e33c9778c62fcb3c0ee47de28b773b
> >>
> >> Which is:
> >>
> >> # RWF_NOWAIT only works with direct IO, which requires an inode with
> >> nodatasum (otherwise it falls back to buffered IO).
> >>
> >> What is being added in this patch:
> >>
> >> +# RWF_NOWAIT works only with direct I/O and requires an inode with no=
datasum
> >> +# to avoid checksum mismatches. Otherwise, it falls back to buffered =
I/O.
> >>
> >> Is confusing because:
> >>
> >> 1) It gives the suggestion RWF_NOWAIT requires nodatasum.
> >>
> >> 2) The part that says "to avoid checksum mismatches", that's not
> >> related to RWF_NOWAIT at all.
> >>      That's the reason why direct IO writes against inodes without
> >> nodatasum fallback to buffered IO.
> >>      We don't have to explain that - this is not a test to exercise th=
e
> >> fallback after all, all we have to say
> >>      is that RWF_NOWAIT needs direct IO and direct IO can only be done
> >> against inodes with nodatasum.
> >>
> >> So you didn't pick my suggestion after all, you just added your own
> >> rephrasing which IMO is confusing.
> >
>
> Your sentence missed the consequence part (checksum mismatches) that
> Qu's sentence included.

And that's totally irrelevant to this test case.

Preventing checksum mismatches is why direct IO writes fallback to
buffered IO if the inode doesn't have the nodatasum flag - it has
nothing to do with RWF_NOWAIT writes.
Besides that, such mismatches only happen for cases where an app
writes to the write buffer while the direct IO write is in progress -
which is not the case of this test case.



>
> How about,
>
> # RWF_NOWAIT only works with direct IO, which requires an inode with
> nodatasum to avoid checksum-mismatches (otherwise it falls back to
> buffered IO).

Just stick it to the original - simple and to the point.

Thanks.


>
> Thx, Anand
>
> > Hi Anand, please talk with Filipe (or more btrfs folks) and make a fina=
l
> > decision about how to write this comment. I'll drop this patch from
> > patches-in-queue branch temporarily, until you reach a consensus :)
> >
> > Thanks,
> > Zorro
> >
> >>
> >>
> >>
> >>>   _scratch_mount -o nodatasum
> >>>
> >>>   # Test a write against COW file/extent - should fail with -EAGAIN. =
Disable the
> >>> --
> >>> 2.47.0
> >>>
> >>>
> >>
> >
>

