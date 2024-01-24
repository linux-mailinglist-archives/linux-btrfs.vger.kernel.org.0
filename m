Return-Path: <linux-btrfs+bounces-1667-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC913839DF1
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 02:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4FF28CD16
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 01:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3736F110B;
	Wed, 24 Jan 2024 01:07:39 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA78EC5;
	Wed, 24 Jan 2024 01:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706058458; cv=none; b=NlABc1VKDIlV3+LiL60AvHrl0LmQ30pSG1UdyiO8O3idelUg5/wHMKIut6jlcVVB0JkNKmd4U4y0xGA2YgKWjE+PwMAyBZG3NYL7lFJmBmLBGoUUfBf5Ca21bqmIzqC8YZtGlY89l8Bq5zZsJZctECAR1rUDI22sCD0DsRbw6vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706058458; c=relaxed/simple;
	bh=mkGOrrqvRsnc6kkdG/+1yUxbkfl8nhWQd1/WimGWUbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDc/3OpAP7RkDov9LJjSgZqMATbu2E2yVBrGn4FH+/fU8w6madCIZH6+wdBNOWdt42bjAeWgntd75YhavNbynWeDbvkQ2CdH3xqrXs04z0QzAti2h694RtNNPA4ES/ex5zUGDCKZ5JTxtraOuYCrSKyZeA9OR/7M4LZL/ZP7uGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55a90a0a1a1so4104060a12.0;
        Tue, 23 Jan 2024 17:07:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706058455; x=1706663255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2L/1mAC79s6Ltbyl0gn1RweXc8iZvoiPeqr87wdTLI8=;
        b=w8TzJOrDjdvXQ4Oa2ZTomCDe4XYRymCcCwMCXUlIsXkPIl29tXKLiX/npuYJCSLHMC
         RvbRmrb2zfgqCtssSHoKs2ShF9j4YlrIryrRykdQzNtQ0QWIGFLPwgDtLmaXc/0rcP12
         Q/fyXO/FgPPj/HvbCiMv5pW7ArSI+XvRa0yVihptBT+GPfRibkX/O0cvmmyAGxTHMHKW
         kVkgYvftT9y17XsL0CczNF78cwc4FsmZC+x8xhiQjdHC0NQRue3UZOiDds27RuuiKct7
         CAAU+Vzo50QD+QxzzLazJ5XGBdRpyzy9VaVQCXFAIThnRhcovxPOxfHp/J7mzZFuqdGO
         5gYw==
X-Gm-Message-State: AOJu0YyPdPZxtG6HYHK4+IVi0v/uudvnIMOeRI5CtfDOD5lPh8wVVyeP
	J8DmUCHlGs9xUd5sv/wmluHBhRroCxqjnQ9rsiWKO72HRqAJm7YP1G2MXryMgJUSrg==
X-Google-Smtp-Source: AGHT+IH0gPBkVIty4gSDuJBSqr/48coBilzbATQeXEoaf7mCFjKkYsiaLFQpLc1m8oqRPxhY7IHlTw==
X-Received: by 2002:a17:907:c81b:b0:a31:2103:c370 with SMTP id ub27-20020a170907c81b00b00a312103c370mr27358ejc.208.1706058454311;
        Tue, 23 Jan 2024 17:07:34 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id k26-20020a17090666da00b00a1df4387f16sm14928968ejp.95.2024.01.23.17.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 17:07:34 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-554fe147ddeso6535165a12.3;
        Tue, 23 Jan 2024 17:07:34 -0800 (PST)
X-Received: by 2002:aa7:d403:0:b0:559:b3fe:5cbf with SMTP id
 z3-20020aa7d403000000b00559b3fe5cbfmr802875edq.7.1706058453910; Tue, 23 Jan
 2024 17:07:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123034908.25415-1-wqu@suse.com> <CAEg-Je-0JN59m+Cjxf_oFjWn37JxyfVLeqy=wyjo5qyucsp8fQ@mail.gmail.com>
 <4f54135d-d013-4534-9598-f099df541205@gmx.com>
In-Reply-To: <4f54135d-d013-4534-9598-f099df541205@gmx.com>
From: Neal Gompa <neal@gompa.dev>
Date: Tue, 23 Jan 2024 20:06:57 -0500
X-Gmail-Original-Message-ID: <CAEg-Je9VCpZr6A-3YpNo=zCKgH2N_NEBp9koe0kBnE8hiiG+SQ@mail.gmail.com>
Message-ID: <CAEg-Je9VCpZr6A-3YpNo=zCKgH2N_NEBp9koe0kBnE8hiiG+SQ@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs: verify the read behavior of compressed
 inline extent
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 7:08=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> On 2024/1/24 10:21, Neal Gompa wrote:
> > On Mon, Jan 22, 2024 at 10:49=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote=
:
> >>
> >> [BUG]
> >> There is a report about reading a zstd compressed inline file extent
> >> would lead to either a VM_BUG_ON() crash, or lead to incorrect file
> >> content.
> >>
> >> [CAUSE]
> >> The root cause is a incorrect memcpy_to_page() call, which uses
> >> incorrect page offset, and can lead to either the VM_BUG_ON() as we ma=
y
> >> write beyond the page boundary, or writes into the incorrect offset of
> >> the page.
> >>
> >> [TEST CASE]
> >> The test case would:
> >>
> >> - Mount with the specified compress algorithm
> >> - Create a 4K file
> >> - Verify the 4K file is all inlined and compressed
> >> - Verify the content of the initial write
> >> - Cycle mount to drop all the page cache
> >> - Verify the content of the file again
> >> - Unmount and fsck the fs
> >>
> >> This workload would be applied to all supported compression algorithms=
.
> >> And it can catch the problem correctly by triggering VM_BUG_ON(), as o=
ur
> >> workload would result decompressed extent size to be 4K, and would
> >> trigger the VM_BUG_ON() 100%.
> >> And with the revert or the new fix, the test case can pass safely.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   tests/btrfs/310     | 81 +++++++++++++++++++++++++++++++++++++++++++=
++
> >>   tests/btrfs/310.out |  2 ++
> >>   2 files changed, 83 insertions(+)
> >>   create mode 100755 tests/btrfs/310
> >>   create mode 100644 tests/btrfs/310.out
> >>
> >> diff --git a/tests/btrfs/310 b/tests/btrfs/310
> >> new file mode 100755
> >> index 00000000..b514a8bc
> >> --- /dev/null
> >> +++ b/tests/btrfs/310
> >> @@ -0,0 +1,81 @@
> >> +#! /bin/bash
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> >> +#
> >> +# FS QA Test 310
> >> +#
> >> +# Make sure reading on an compressed inline extent is behaving correc=
tly
> >> +#
> >> +. ./common/preamble
> >> +_begin_fstest auto quick compress
> >> +
> >> +# Import common functions.
> >> +# . ./common/filter
> >> +
> >> +# real QA test starts here
> >> +
> >> +# Modify as appropriate.
> >> +_supported_fs btrfs
> >> +_require_scratch
> >> +
> >> +# This test require inlined compressed extents creation, and all the =
writes
> >> +# are designed for 4K sector size.
> >> +_require_btrfs_inline_extents_creation
> >> +_require_btrfs_support_sectorsize 4096
> >> +
> >> +_fixed_by_kernel_commit e01a83e12604 \
> >> +       "Revert \"btrfs: zstd: fix and simplify the inline extent deco=
mpression\""
> >> +
> >> +# The correct md5 for the correct 4K file filled with "0xcd"
> >> +md5sum_correct=3D"5fed275e7617a806f94c173746a2a723"
> >> +
> >> +workload()
> >> +{
> >> +       local algo=3D"$1"
> >> +
> >> +       echo "=3D=3D=3D Testing compression algorithm ${algo} =3D=3D=
=3D" >> $seqres.full
> >> +       _scratch_mkfs >> $seqres.full
> >> +       _scratch_mount -o compress=3D${algo}
> >> +
> >> +       _pwrite_byte 0xcd 0 4k "$SCRATCH_MNT/inline_file" > /dev/null
> >> +       result=3D$(_md5_checksum "$SCRATCH_MNT/inline_file")
> >> +       echo "after initial write, md5sum=3D${result}" >> $seqres.full
> >> +       if [ "$result" !=3D "$md5sum_correct" ]; then
> >> +               _fail "initial write results incorrect content for \"$=
algo\""
> >> +       fi
> >> +       sync
> >> +
> >> +       $XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/inline_file | tail -n=
 1 > $tmp.fiemap
> >> +       cat $tmp.fiemap >> $seqres.full
> >> +       # Make sure we got an inlined compressed file extent.
> >> +       # 0x200 means inlined, 0x100 means not block aligned, 0x8 mean=
s encoded
> >> +       # (compressed in this case), and 0x1 means the last extent.
> >> +       if ! grep -q "0x309" $tmp.fiemap; then
> >> +               rm -f -- $tmp.fiemap
> >> +               _notrun "No compressed inline extent created, maybe su=
bpage?"
> >> +       fi
> >> +       rm -f -- $tmp.fiemap
> >> +
> >> +       # Unmount to clear the page cache.
> >> +       _scratch_cycle_mount
> >> +
> >> +       # For v6.8-rc1 without the revert or the newer fix, this can
> >> +       # crash or lead to incorrect contents for zstd.
> >> +       result=3D$(_md5_checksum "$SCRATCH_MNT/inline_file")
> >> +       echo "after cycle mount, md5sum=3D${result}" >> $seqres.full
> >> +       if [ "$result" !=3D "$md5sum_correct" ]; then
> >> +               _fail "read for compressed inline extent failed for \"=
$algo\""
> >> +       fi
> >> +       _scratch_unmount
> >> +       _check_scratch_fs
> >> +}
> >> +
> >> +algo_list=3D($(_btrfs_compression_algos))
> >> +for algo in ${algo_list[@]}; do
> >> +       workload $algo
> >> +done
> >> +
> >> +echo "Silence is golden"
> >> +
> >> +status=3D0
> >> +exit
> >> diff --git a/tests/btrfs/310.out b/tests/btrfs/310.out
> >> new file mode 100644
> >> index 00000000..7b9eaf78
> >> --- /dev/null
> >> +++ b/tests/btrfs/310.out
> >> @@ -0,0 +1,2 @@
> >> +QA output created by 310
> >> +Silence is golden
> >> --
> >> 2.42.0
> >>
> >>
> >
> > This looks reasonable to me, but how is $_btrfs_compression_algos
> > defined? Does it include all the algorithm options supported in Btrfs?
>
> It fetches all the supported compression algo through the sysfs interface=
s:
>
>    /sys/fs/btrfs/features/compress_*
>
> Along with the default supported zlib compression.
>

Cool then.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

