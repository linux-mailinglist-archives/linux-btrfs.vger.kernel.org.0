Return-Path: <linux-btrfs+bounces-6424-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A44D892FED9
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 18:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57D3A1F21DE7
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 16:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653EE176AB0;
	Fri, 12 Jul 2024 16:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FP8tsfQU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F34ABE65;
	Fri, 12 Jul 2024 16:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720803413; cv=none; b=LSbKwoEC1f8iwN0F5ki81G5N4FGmZ40O+E8IB9sX43gwejvgxpImuOikc28RG3RT6Cqe8Um9lIkiVwGjt739iprjUTxnOLBLmSjCEzDCT1z4hEKttAVc9ijnqE8aoiJJ/UuEEC2GRUGhmwVXbx7d/V9RqajXSLhubhXCBPASQwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720803413; c=relaxed/simple;
	bh=AOvXGX/IMRI6uz1xJftJJ41BLvmJl8noqLEX8GGQPRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gu6D7g85Y35rjyNPpxMHT/Tkapjf5zgozwp2Y2Emo1zSuIX2lj9+K9vA69bi2LjOsqqCSO/mVYukC4o4hKUeZpAiYbARb+WA/3hKmNcxn5tFL7wDUSbcXWsVRKB+R16kSDLcQ830CfZEwjuq/EZ4jW32AKXf9LLY5iNzKrtCINo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FP8tsfQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B7DC4AF09;
	Fri, 12 Jul 2024 16:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720803413;
	bh=AOvXGX/IMRI6uz1xJftJJ41BLvmJl8noqLEX8GGQPRQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FP8tsfQU9qit7eoQKUi2eUCeLgrfq3/x4v8u+gJTp1LZyJ4tW+pozwW/Cfhdx9t62
	 RIrDbjRASbmLRFJ5G1s+MO1OUZ2w/UeKQIDsq1QEoDVtbV4mXGZ2Q3x/skS/VY3N9S
	 SW5c2lmT2SBKScnZ/d9tABhcdODelEh2OTzbn+/FMAje1jOtDWn7q/LHDXMsyZbGzn
	 boCK0DPdUHfQmRECMpi8buzD5Noj0gUSLSZuPTopoIT+Ko7A8GBSpKMmXg4P3P1iaP
	 J/8/ZmRut8XDxYCDwoQuZejEnaaDt9dBlWEHAp4l0cZpnQeF0STGnOCBAB4I1Tp+Bv
	 CXFMbcbkPidpw==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a77b550128dso295234766b.0;
        Fri, 12 Jul 2024 09:56:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX7wvV2RKQ8bLx6+yGsrR9ZNqapBJEwn5wmyrJjSjgodJjbwS9bzCi6UyBGpKMj3ZUNq252cxhp/SMLSflzNPk9VVoQIZbFLg==
X-Gm-Message-State: AOJu0Yy7OUiykN+VPrGYG0sA6166hXrQLHdXHXgLq+aCSUtZ6VZPbZMk
	MBqET8K+Sdbo5CQpBYUN9CjrVD8oW52CP3d8kVTAwKP8r9JR1kUXxCbeNis1tfWQV+djg3UprGY
	QE5bGYexn+JYWDcv3UnyNcZTJWWs=
X-Google-Smtp-Source: AGHT+IGeppHwWASu3TxIC7NZVzStKr3sbIOllX1HStHs5bQPdxnuqL1uohIjiQRljFsB29FbKqE+MdyG3a0JA1MRCiE=
X-Received: by 2002:a17:906:5fc1:b0:a77:d7f1:42eb with SMTP id
 a640c23a62f3a-a780b6b2034mr772961466b.23.1720803411736; Fri, 12 Jul 2024
 09:56:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7339416633376271b21b1be844e1a34f8656f780.1720799383.git.boris@bur.io>
In-Reply-To: <7339416633376271b21b1be844e1a34f8656f780.1720799383.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 12 Jul 2024 17:56:15 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6sDegx2d3336J70Nyri5oYSR6yn3KdZr+z1AqLMwaU4Q@mail.gmail.com>
Message-ID: <CAL3q7H6sDegx2d3336J70Nyri5oYSR6yn3KdZr+z1AqLMwaU4Q@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: add test for btrfstune squota enable/disable
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 4:53=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> btrfstune supports enabling simple quotas on a fleshed out filesystem
> (without adding owner refs) and clearing squotas entirely from a
> filesystem that ran under squotas (clearing the incompat bit)
>
> Test that these operations work on a relatively complicated filesystem
> populated by fsstress while preserving fssum.
>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  tests/btrfs/332     | 69 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/332.out |  2 ++
>  2 files changed, 71 insertions(+)
>  create mode 100755 tests/btrfs/332
>  create mode 100644 tests/btrfs/332.out
>
> diff --git a/tests/btrfs/332 b/tests/btrfs/332
> new file mode 100755
> index 000000000..d5cf32664
> --- /dev/null
> +++ b/tests/btrfs/332
> @@ -0,0 +1,69 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. btrfs/332
> +#
> +# Test tune enabling and removing squotas on a live filesystem
> +#
> +. ./common/preamble
> +_begin_fstest auto quick qgroup
> +
> +# Import common functions.
> +. ./common/filter.btrfs
> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_require_scratch_enable_simple_quota
> +_require_no_compress
> +_require_command "$BTRFS_TUNE_PROG" btrfstune
> +_require_fssum
> +_require_btrfs_dump_super
> +_require_btrfs_command inspect-internal dump-tree
> +$BTRFS_TUNE_PROG --help 2>&1 | grep -wq -- '--enable-simple-quota' || \
> +       _notrun "$BTRFS_TUNE_PROG too old (must support --enable-simple-q=
uota)"
> +$BTRFS_TUNE_PROG --help 2>&1 | grep -wq -- '--remove-simple-quota' || \
> +       _notrun "$BTRFS_TUNE_PROG too old (must support --remove-simple-q=
uota)"
> +
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mount
> +
> +# do some stuff
> +d1=3D$SCRATCH_MNT/d1
> +d2=3D$SCRATCH_MNT/d2
> +mkdir $d1
> +mkdir $d2
> +run_check $FSSTRESS_PROG -d $d1 -w -n 2000 $FSSTRESS_AVOID
> +fssum_pre=3D$($FSSUM_PROG -A $SCRATCH_MNT)
> +
> +# enable squotas
> +_scratch_unmount
> +$BTRFS_TUNE_PROG --enable-simple-quota $SCRATCH_DEV >> $seqres.full 2>&1=
 || \
> +       _fail "enable simple quota failed"

Instead of doing a "|| _fail ..." everywhere, can't we simply not
redirect stderr to the .full file and instead have a golden output
mismatch in case an error happens?
Not only that makes the test shorter and easier to read, it goes along
with the most common practice in fstests.

> +_check_btrfs_filesystem $SCRATCH_DEV
> +_scratch_mount
> +fssum_post=3D$($FSSUM_PROG -A $SCRATCH_MNT)
> +[ "$fssum_pre" =3D=3D "$fssum_post" ] \
> +       || echo "fssum $fssum_pre does not match $fssum_post after enabli=
ng squota"
> +
> +# do some more stuff
> +run_check $FSSTRESS_PROG -d $d2 -w -n 2000 $FSSTRESS_AVOID
> +fssum_pre=3D$($FSSUM_PROG -A $SCRATCH_MNT)
> +_scratch_unmount
> +_check_btrfs_filesystem $SCRATCH_DEV
> +
> +$BTRFS_TUNE_PROG --remove-simple-quota $SCRATCH_DEV >> $seqres.full 2>&1=
 || \
> +       _fail "remove simple quota failed"

Same here.

With that fixed (if it can be done):

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +_check_btrfs_filesystem $SCRATCH_DEV
> +$BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | grep 'SIMPLE=
_QUOTA'
> +$BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV  | grep -e 'QUO=
TA' -e 'QGROUP'
> +
> +_scratch_mount
> +fssum_post=3D$($FSSUM_PROG -A $SCRATCH_MNT)
> +_scratch_unmount
> +[ "$fssum_pre" =3D=3D "$fssum_post" ] \
> +       || echo "fssum $fssum_pre does not match $fssum_post after disabl=
ing squota"
> +
> +echo Silence is golden
> +status=3D0
> +exit
> diff --git a/tests/btrfs/332.out b/tests/btrfs/332.out
> new file mode 100644
> index 000000000..adb316136
> --- /dev/null
> +++ b/tests/btrfs/332.out
> @@ -0,0 +1,2 @@
> +QA output created by 332
> +Silence is golden
> --
> 2.45.2
>
>

