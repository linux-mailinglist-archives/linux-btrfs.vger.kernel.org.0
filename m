Return-Path: <linux-btrfs+bounces-8305-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD8098884F
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 17:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CB241C20F2E
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 15:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291DB1C0DFA;
	Fri, 27 Sep 2024 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIfA88pL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516591EB35;
	Fri, 27 Sep 2024 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727451094; cv=none; b=TLpnNPBlZCjHDEhW19+BWkpQPAH39z4df/1uTmsyWz4xjXY0vbf5XQBhqZLfVAawxu2tOfdv8MGSj3pl16jtTUsdfeanOQwrm0kCtG81ed3RM6kcB/tOsSI1wURQDOS9aDhNzRuKLy6dBfVelFS0Rv8nSeOFwf/G4ofSufPworM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727451094; c=relaxed/simple;
	bh=fVwaEwSJgFTjWEgKDc3qk5RYB6tJJlCE7k52BMugN4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kc09IyrYeBnEl0TQgaov2W+6Jny+rN1PBvSVtR5e490J/oBfBUAho8mP+FVY2H0zZjIKbvvtmXeGhFis9s18yZMWHHpYzouYmJpe+dfqa4UGYd9ZiXHMmmx01VFAWqfZVFWbQMU1Q1DJmGKiw2MdHoZa0Km89zdTMhtrAmKYXkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIfA88pL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B65C4CECE;
	Fri, 27 Sep 2024 15:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727451093;
	bh=fVwaEwSJgFTjWEgKDc3qk5RYB6tJJlCE7k52BMugN4Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KIfA88pLST2A5iVjMTPovyfw5QyggVx+/wb4cICRwISc8q5QTwOWl2GJOTzS5P6Et
	 09UCUxUhfKcoq1vhP0JNsiaLJmtDvJ1HmZ1XXepx1+2J0C90Qv6pjc0yYEf0Z7xvr7
	 00Qqpg22N1qpjXC2NOzhZ25m9OI8Me5iYE5G1UfhbFW9KCV5hl0kIuqe1vIiLiKN/e
	 r/RGComg4LumAjKb8EKMgM4sLt0KxyMJb9marpyoD4qalhz+Ypn+jObvS4dUCkvQH0
	 5BDUw0FF/3dd0WuApdAoacmq+Vd46d7vvCBgi46FFR5jMQAPlrdWxlduwXknk1Bv5t
	 eXMPWEMcGGGAA==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f761461150so34101571fa.0;
        Fri, 27 Sep 2024 08:31:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWPJykijhAgSZm9WBrZ9GMaSsfjjGkbhr2ouHOfBLCYQ8qnZnVrVGNGWxiMYQ1QBpMkefhMQtLt4NsWTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyeWPdYbpE/GycBEqIeIHnzzVJ8GaTBvHaVo10T7xeBaCDUmw9J
	4OUcEWZQX/eLbv9ejP6VI/BoVJ4FMML8gZJZDewwjQA+ahErX2d40pU/dm3WV7B72e1J9OXhSpT
	pWeOqFSQBHYYXdhFQmBjyU9z0Pq4=
X-Google-Smtp-Source: AGHT+IEsmlLfNgGtTH/Y6/ZS/FEzDBBmAoq96epg9A+ppOlpFzgZBgbECuLREgJyGpB77cRCj5bphS+wvs0G4dSwf3s=
X-Received: by 2002:a2e:a986:0:b0:2f3:cb70:d447 with SMTP id
 38308e7fff4ca-2f9d4197881mr30112081fa.40.1727451092112; Fri, 27 Sep 2024
 08:31:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <76d94e63cec4cb04cbfbc0dcd0928f1fbdc27bdf.1727432832.git.fdmanana@suse.com>
 <20240927144408.3ewoi6qbi4qxv5mz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20240927144408.3ewoi6qbi4qxv5mz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 27 Sep 2024 16:30:55 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6Cz6gHPED55nx5L+77=rd_VCMQrRCzWLvqsh=hm6z+bQ@mail.gmail.com>
Message-ID: <CAL3q7H6Cz6gHPED55nx5L+77=rd_VCMQrRCzWLvqsh=hm6z+bQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: test an incremental send scenario with cloning of
 unaligned extent
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 3:44=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Fri, Sep 27, 2024 at 11:28:07AM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Test that doing an incremental send with a file that had its size
> > decreased and became the destination for a clone operation of an extent
> > with an unaligned end offset that matches the new file size, works
> > correctly.
> >
> > This tests a bug fixed by the following kernel patch:
> >
> >   "btrfs: send: fix invalid clone operation for file that got its size =
decreased"
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  tests/btrfs/322     | 108 ++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/322.out |  24 ++++++++++
> >  2 files changed, 132 insertions(+)
> >  create mode 100755 tests/btrfs/322
> >  create mode 100644 tests/btrfs/322.out
> >
> > diff --git a/tests/btrfs/322 b/tests/btrfs/322
> > new file mode 100755
> > index 00000000..c03f6a4c
> > --- /dev/null
> > +++ b/tests/btrfs/322
> > @@ -0,0 +1,108 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> > +#
> > +# FS QA Test 322
> > +#
> > +# Test that doing an incremental send with a file that had its size de=
creased
> > +# and became the destination for a clone operation of an extent with a=
n
> > +# unaligned end offset that matches the new file size, works correctly=
.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick send clone fiemap
> > +
> > +_cleanup()
> > +{
> > +     cd /
> > +     rm -fr $tmp.*
> > +     rm -fr $send_files_dir
> > +}
> > +
> > +. ./common/filter
> > +. ./common/reflink
> > +. ./common/punch # for _filter_fiemap_flags
> > +
> > +_require_test
> > +_require_scratch_reflink
> > +_require_xfs_io_command "fiemap"
> > +_require_odirect
> > +
> > +_fixed_by_kernel_commit xxxxxxxxxxxx \
> > +     "btrfs: send: fix invalid clone operation for file that got its s=
ize decreased"
> > +
> > +check_all_extents_shared()
> > +{
> > +     local file=3D$1
> > +     local fiemap_output
> > +
> > +     fiemap_output=3D$($XFS_IO_PROG -r -c "fiemap -v" $file | _filter_=
fiemap_flags)
> > +     echo "$fiemap_output" | grep -qv 'shared'
> > +     if [ $? -eq 0 ]; then
> > +             echo -e "Found non-shared extents for file $file:\n"
> > +             echo "$fiemap_output"
> > +     fi
> > +}
> > +
> > +send_files_dir=3D$TEST_DIR/btrfs-test-$seq
> > +full_send_stream=3D$send_files_dir/full_snap.stream
> > +inc_send_stream=3D$send_files_dir/inc_snap.stream
> > +
> > +rm -fr $send_files_dir
> > +mkdir $send_files_dir
> > +
> > +_scratch_mkfs >> $seqres.full 2>&1 || _fail "first mkfs failed"
> > +_scratch_mount
> > +
> > +# Create a file with a size of 256K + 5 bytes, having two extents, the=
 first one
> > +# with a size of 128K and the second one with a size of 128K + 5 bytes=
.
> > +last_extent_size=3D$((128 * 1024 + 5))
> > +$XFS_IO_PROG -f -d -c "pwrite -S 0xab -b 128K 0 128K" \
> > +             -c "pwrite -S 0xcd -b $last_extent_size 128K $last_extent=
_size" \
> > +             $SCRATCH_MNT/foo | _filter_xfs_io
> > +
> > +# Another file which we will later clone foo into, but initially with
> > +# a larger size than foo.
> > +$XFS_IO_PROG -f -c "pwrite -b 0xef 0 1M" $SCRATCH_MNT/bar | _filter_xf=
s_io
> > +
> > +echo "Creating snapshot and the full send stream for it..."
> > +_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1
> > +$BTRFS_UTIL_PROG send -f $full_send_stream $SCRATCH_MNT/snap1 >> $seqr=
es.full 2>&1
> > +
> > +# Now resize bar and clone foo into it.
> > +$XFS_IO_PROG -c "truncate 0" \
> > +          -c "reflink $SCRATCH_MNT/foo" $SCRATCH_MNT/bar | _filter_xfs=
_io
>
> _require_xfs_io_command "reflink"
>
> I'll help to add it when I merge it. Other looks good to me. Thanks!

Thanks! I forgot that.

>
> > +
> > +echo "Creating another snapshot and the incremental send stream for it=
..."
> > +_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2
> > +$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/snap1 -f $inc_send_stream \
> > +              $SCRATCH_MNT/snap2 >> $seqres.full 2>&1
> > +
> > +echo "File digests in the original filesystem:"
> > +md5sum $SCRATCH_MNT/snap1/foo | _filter_scratch
> > +md5sum $SCRATCH_MNT/snap1/bar | _filter_scratch
> > +md5sum $SCRATCH_MNT/snap2/foo | _filter_scratch
> > +md5sum $SCRATCH_MNT/snap2/bar | _filter_scratch
> > +
> > +check_all_extents_shared "$SCRATCH_MNT/snap2/bar"
> > +check_all_extents_shared "$SCRATCH_MNT/snap1/foo"
> > +
> > +echo "Creating a new filesystem to receive the send streams..."
> > +_scratch_unmount
> > +_scratch_mkfs >> $seqres.full 2>&1 || _fail "second mkfs failed"
> > +_scratch_mount
> > +
> > +$BTRFS_UTIL_PROG receive -f $full_send_stream $SCRATCH_MNT
> > +$BTRFS_UTIL_PROG receive -f $inc_send_stream $SCRATCH_MNT
> > +
> > +echo "File digests in the new filesystem:"
> > +md5sum $SCRATCH_MNT/snap1/foo | _filter_scratch
> > +md5sum $SCRATCH_MNT/snap1/bar | _filter_scratch
> > +md5sum $SCRATCH_MNT/snap2/foo | _filter_scratch
> > +md5sum $SCRATCH_MNT/snap2/bar | _filter_scratch
> > +
> > +check_all_extents_shared "$SCRATCH_MNT/snap2/bar"
> > +check_all_extents_shared "$SCRATCH_MNT/snap1/foo"
> > +
> > +# success, all done
> > +status=3D0
> > +exit
> > diff --git a/tests/btrfs/322.out b/tests/btrfs/322.out
> > new file mode 100644
> > index 00000000..31e1ee55
> > --- /dev/null
> > +++ b/tests/btrfs/322.out
> > @@ -0,0 +1,24 @@
> > +QA output created by 322
> > +wrote 131072/131072 bytes at offset 0
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +wrote 131077/131077 bytes at offset 131072
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +wrote 1048576/1048576 bytes at offset 0
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +Creating snapshot and the full send stream for it...
> > +linked 0/0 bytes at offset 0
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +Creating another snapshot and the incremental send stream for it...
> > +File digests in the original filesystem:
> > +c3bb068b7e21d3f009581f047be84f44  SCRATCH_MNT/snap1/foo
> > +ca539970d4b1fa1f34213ba675007381  SCRATCH_MNT/snap1/bar
> > +c3bb068b7e21d3f009581f047be84f44  SCRATCH_MNT/snap2/foo
> > +c3bb068b7e21d3f009581f047be84f44  SCRATCH_MNT/snap2/bar
> > +Creating a new filesystem to receive the send streams...
> > +At subvol snap1
> > +At snapshot snap2
> > +File digests in the new filesystem:
> > +c3bb068b7e21d3f009581f047be84f44  SCRATCH_MNT/snap1/foo
> > +ca539970d4b1fa1f34213ba675007381  SCRATCH_MNT/snap1/bar
> > +c3bb068b7e21d3f009581f047be84f44  SCRATCH_MNT/snap2/foo
> > +c3bb068b7e21d3f009581f047be84f44  SCRATCH_MNT/snap2/bar
> > --
> > 2.43.0
> >
> >
>

