Return-Path: <linux-btrfs+bounces-22198-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA5lE7Ejp2mMegAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22198-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 19:08:49 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AFB1F4FF7
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 19:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7E4733041520
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2026 18:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E000F381B14;
	Tue,  3 Mar 2026 18:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbHfLf8l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C38F381B04
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2026 18:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561323; cv=none; b=Yss9edsnlV9BE2h7llnQTPMJTsfqC5ySYKrA9pIR1NTSdrbsCI9cFM384NTkEfV/8sISNbV3CZTQ8Uvo1mQIXU06aGdB0/kyrY+0zw/h4owiA7ppVfRqBi7nq0OXcOAcrl3UWkYfjgSuNI3FTsgikq5hiW6fjpNfscjc/Gx+Poc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561323; c=relaxed/simple;
	bh=LoU2vSvd2LIhQUXqdBWUWf6Gz78T6wP0D6/L1tVdZgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsDVUn2g5fJuBjm6lCDW1eKTer54TB5rVsLQIxNB+xjhbxrw6Xv0/l5m0ilKf+6+0eRaTLWQH+WWJufiWkjD8X1Q7EbpLlQiGwlHQ9fpW7rZHXPnXXgdieFYo85JnA7gjcQPd7vyl9W9pVB7o0EQBGD24E8MQGVxGIAvKaHA0AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbHfLf8l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7C3C116C6
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2026 18:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772561322;
	bh=LoU2vSvd2LIhQUXqdBWUWf6Gz78T6wP0D6/L1tVdZgk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tbHfLf8ly8/TEb4bF4atCJvsaSvOIZhc3vZ7nvJ1wawJe+ruLkLB/hlZjQe+Yl3+X
	 eb3jNLhUpHtoUUhcjU5+4GnqSJ/ZZc6WIHaL+k4gSfK7wRgE1DgUIkVoOQjfrv3Myv
	 4lVJm3rfrOU1IkK2aw/9Q8+yJbh4yfLW0EXm6wKpVySFJkBlWP2w+bhwPdcYPP9XTu
	 D4AHKe6lKHBse97AKnQ9g+sy0WaUHEsqorv5HOWCTHrrrRhrdq5Kir8rYS+iz1S5x2
	 SGtNfBclLyuPZGczegW+PfUazcONb/qGpVoYzxhn2heQ3x6ymVV2YMmnTQYAzOSeoC
	 ztzO9ckmYzpig==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b9373af81cdso848023366b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Mar 2026 10:08:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVDuHUI7WSHwo40HQmHtkCmY0i68Z3+GqMScn9ZdAPw0EyP/W4CfKkxnG8jM1l6yKH4SiuEYBQ0P1IXAg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa7xR9Jb5FyajoIJD2ht/Ts7RmnXdQ0Ozi5UNHGf3uHEY8BwBm
	d9epoHxP4PJqcRaLrTF+UDiLxfL0Y/ItyKAxq3xuA7CacjI6kbEHtLQRMIQVat3NMsiqPijazHm
	JEZcAiQfex2TkmzSzBoEhftRy4MBLwNw=
X-Received: by 2002:a17:907:7247:b0:b8e:3d49:25db with SMTP id
 a640c23a62f3a-b937659a34fmr1163358566b.54.1772561319861; Tue, 03 Mar 2026
 10:08:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8e3c1626b6e49678976db67a861cb5dcfdb532c0.1772558357.git.fdmanana@suse.com>
 <20260303180120.GF13843@frogsfrogsfrogs>
In-Reply-To: <20260303180120.GF13843@frogsfrogsfrogs>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 3 Mar 2026 18:08:03 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4WwrvevNTbCOh_5=D57GaGJ4xW=6P5Bv+YPwVKkD_mYw@mail.gmail.com>
X-Gm-Features: AaiRm52Jl9tyUBWLSoQarkX3XztyjuPlMr0YKQIRfIWavpPeAtVX2FFJR645Fsg
Message-ID: <CAL3q7H4WwrvevNTbCOh_5=D57GaGJ4xW=6P5Bv+YPwVKkD_mYw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: test a directory fsync scenaro after replacing a
 subdir with a file
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 04AFB1F4FF7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-22198-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.com:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 6:01=E2=80=AFPM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Tue, Mar 03, 2026 at 05:20:10PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Test a scenario where we remove a directory previously persisted, creat=
e
> > a file with the same name and parent directory, create two directories =
in
> > the same parent directory, create a hard link for the new file in one o=
f
> > the new directories, fsync the directory with the hard link and fsync t=
he
> > parent directory. After a power failure we expect both directories to b=
e
> > persisted as well as the new file and its hard link.
> >
> > This exercises a bug on btrfs fixed by the following kernel patch:
> >
> >   "btrfs: log new dentries when logging parent dir of a conflicting ino=
de"
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  tests/generic/790     | 69 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/790.out | 12 ++++++++
> >  2 files changed, 81 insertions(+)
> >  create mode 100755 tests/generic/790
> >  create mode 100644 tests/generic/790.out
> >
> > diff --git a/tests/generic/790 b/tests/generic/790
> > new file mode 100755
> > index 00000000..a25203a1
> > --- /dev/null
> > +++ b/tests/generic/790
> > @@ -0,0 +1,69 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2026 SUSE S.A.  All Rights Reserved.
> > +#
> > +# FS QA Test 790
> > +#
> > +# Test a scenario where we remove a directory previously persisted, cr=
eate a
> > +# file with the same name and parent directory, create two directories=
 in the
> > +# same parent directory, create a hard link for the new file in one of=
 the
> > +# new directories, fsync the directory with the hard link and fsync th=
e parent
> > +# directory. After a power failure we expect both directories to be pe=
rsisted
> > +# as well as the new file and its hard link.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick log
> > +
> > +_cleanup()
> > +{
> > +     _cleanup_flakey
> > +     cd /
> > +     rm -r -f $tmp.*
> > +}
> > +
> > +. ./common/dmflakey
> > +
> > +_require_scratch
> > +_require_dm_target flakey
> > +
> > +[ "$FSTYP" =3D "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> > +     "btrfs: log new dentries when logging parent dir of a conflicting=
 inode"
> > +
> > +_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> > +_require_metadata_journaling $SCRATCH_DEV
> > +_init_flakey
> > +_scratch_mount
> > +
> > +mkdir $SCRATCH_MNT/foo
> > +
> > +_scratch_sync
> > +
> > +rmdir $SCRATCH_MNT/foo
> > +
> > +# Create two new directories in the same parent directory as the new f=
ile.
> > +mkdir $SCRATCH_MNT/dir1
> > +mkdir $SCRATCH_MNT/dir2
> > +
> > +# Create a file with the name of the directly we deleted and was persi=
sted
> > +# before.
> > +touch $SCRATCH_MNT/foo
> > +
> > +# Create a hard link for the new file inside one of the new directorie=
s.
> > +ln $SCRATCH_MNT/foo $SCRATCH_MNT/dir2/link
> > +
> > +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/dir2
> > +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/
> > +
> > +# Simulate a power failure and then mount again the filesystem to repl=
ay the
> > +# journal/log.
> > +_flakey_drop_and_remount
> > +
> > +# We expect to see dir1, dir2, file foo and its hard link, since dir2 =
was
> > +# explicitly fsynced as well as the parent directory.
> > +echo -e "Filesystem content after power failure:\n"
> > +# Exclude 'lost+found' dir from ext4 and last line if it's blank (due =
to removal
> > +# of 'lost+found').
> > +ls -R $SCRATCH_MNT/ | grep -v 'lost+found' | sed -e '${/^$/d;}'
> > +
> > +# success, all done
> > +_exit 0
>
> This all looks good to me, except that...
>
> > diff --git a/tests/generic/790.out b/tests/generic/790.out
> > new file mode 100644
> > index 00000000..d2232a19
> > --- /dev/null
> > +++ b/tests/generic/790.out
> > @@ -0,0 +1,12 @@
> > +QA output created by 790
> > +Filesystem content after power failure:
> > +
> > +/home/fdmanana/btrfs-tests/scratch_1/:
> > +dir1
> > +dir2
> > +foo
> > +
> > +/home/fdmanana/btrfs-tests/scratch_1/dir1:
> > +
> > +/home/fdmanana/btrfs-tests/scratch_1/dir2:
>
> ...^^^^^^^^^^^^^^ you might want a _filter_scratch for that.

Indeed, did it in so many tests with the filter and now I forgot it.
Fixed in v2, thanks.

>
> --D
>
> > +link
> > --
> > 2.47.2
> >
> >

