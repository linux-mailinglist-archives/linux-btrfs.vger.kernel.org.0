Return-Path: <linux-btrfs+bounces-1661-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2752839D54
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 00:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A529B275B0
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 23:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AC154BCA;
	Tue, 23 Jan 2024 23:42:26 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5426F4F5F3;
	Tue, 23 Jan 2024 23:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706053346; cv=none; b=pPsHQ97aCFtUbJTMkgMtoN4pclP6wpzibfWVnohPFLISQNXEgaMZGC7t5KfCDF3xezeqAKRt0X95m/OE5VZdILqfeBJE29CozbhfyKSc7Zyi10dSLCHgFgzA9XuXDbQp6+6pgnBZ6zQB8IYHZJ2p5rTFjdxPGW2pqV/y8Lm/Lsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706053346; c=relaxed/simple;
	bh=RZxJoOOqHHnySX1PEJh+LSQab+6C7qrc8k9TnC5izSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T6JDhp2vvZZfcgjnaw+4Pxewv4QOuQ1EAcerOstqyJsGQ/WiInPpu6OZLIyUKLm3Jf4PXC7amRPpJmvf8QXUlT52sjaInWXYyPphNwJmPrq6yeazblsww3ywCiwX7nKp1MUOn8o+j+rnv5zsvBC0CkMJpmuKOg7tNnGMFqhEpD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55a50649ff6so5337315a12.3;
        Tue, 23 Jan 2024 15:42:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706053342; x=1706658142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LkMgn4svPLGyos0vEBAiLxlkJZx1RwZ1fXvcbGlfEEQ=;
        b=Kgi26hBIzDPHEVb7oX/FIyzK+/zF8fJwms76rem6XH6f/mOJn9aG97CQGaRl4uSFwt
         KezANQdrYrMQurAe/RHR3BvJEzllu4yudVuzbS9li+8z34Uexzs+5VfIQrWhcEs0RcpO
         LgaKhWqqc7Ox021+aGPUey7Ci3uCTQhYC58J4Lfufmm2uAxjoqzontwxa0sMWUrvFkiD
         9TAvWUqjTkd1aSKcKO1//c8VkUqoXEJf5ZVufDWUEcdb+HaefVM3mHb/6CEuZlXJo/BX
         BQb01avtb06y9MZlUG6SGnwlWnXeEDeFv66v0GLWYs2vLt/F9poLHNyKz9lwu6bK0w7e
         6HFA==
X-Gm-Message-State: AOJu0YwNBhiFb1gUq63VXuEFKgpFsx9WLyYSwtTSXnhb11qDbmJbOzWR
	p6q8l86qLJf6ljLqoa0KlObpICj2vTpt27iEFWMtfXmu+/W70tUyJPSJ7foOZ8T7ZQ==
X-Google-Smtp-Source: AGHT+IEtWW70+ZiHTcnrGSkydf5i/gewHL18hrsPzI+FzmWEnY3W5bwqv/fRMvqr7uTH+fArYGGxDw==
X-Received: by 2002:a50:9ec1:0:b0:55c:2cf6:6690 with SMTP id a59-20020a509ec1000000b0055c2cf66690mr1271373edf.67.1706053341846;
        Tue, 23 Jan 2024 15:42:21 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id es18-20020a056402381200b00554b1d1a934sm15814938edb.27.2024.01.23.15.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 15:42:21 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so5788759a12.2;
        Tue, 23 Jan 2024 15:42:21 -0800 (PST)
X-Received: by 2002:aa7:cf11:0:b0:558:c9c7:130c with SMTP id
 a17-20020aa7cf11000000b00558c9c7130cmr1091834edy.78.1706053341241; Tue, 23
 Jan 2024 15:42:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a3f51f2fff6581a6b4dd2e5776b7f40d22dcf65b.1706039782.git.boris@bur.io>
In-Reply-To: <a3f51f2fff6581a6b4dd2e5776b7f40d22dcf65b.1706039782.git.boris@bur.io>
From: Neal Gompa <neal@gompa.dev>
Date: Tue, 23 Jan 2024 18:41:44 -0500
X-Gmail-Original-Message-ID: <CAEg-Je_k29TVpjFizKOvGKb6-xGVguhcpwtYwE4nN4iVxLUEoA@mail.gmail.com>
Message-ID: <CAEg-Je_k29TVpjFizKOvGKb6-xGVguhcpwtYwE4nN4iVxLUEoA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Remove btrfs/303
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 3:37=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> This test was reproducing a bug triggered by creating a subvolume qgroup
> before creating the subvolume itself with a snapshot.
>
> The kernel patch:
> btrfs: forbid creating subvol qgroups
>
> explicitly prevents that and makes it fail with EINVAL. I could "fix"
> this test by expecting the EINVAL message in the output, but at that
> point it would simply be a test that creating a subvolume and
> snapshotting it works with qgroups, which is adequately tested by other
> tests which focus on accurately measuring shared/exclusive usage in
> various snapshot/reflink scenarios. To avoid confusion, I think it is
> best to simply delete this test.
>
> Signed-off-by: Boris Burkov
> ---
>  tests/btrfs/303     | 77 ---------------------------------------------
>  tests/btrfs/303.out |  2 --
>  2 files changed, 79 deletions(-)
>  delete mode 100755 tests/btrfs/303
>  delete mode 100644 tests/btrfs/303.out
>
> diff --git a/tests/btrfs/303 b/tests/btrfs/303
> deleted file mode 100755
> index 410460af5..000000000
> --- a/tests/btrfs/303
> +++ /dev/null
> @@ -1,77 +0,0 @@
> -#! /bin/bash
> -# SPDX-License-Identifier: GPL-2.0
> -# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
> -#
> -# FS QA Test 303
> -#
> -# A regression test to make sure snapshot creation won't cause transacti=
on
> -# abort if there is already an existing qgroup.
> -#
> -. ./common/preamble
> -_begin_fstest auto quick snapshot subvol qgroup
> -
> -. ./common/filter
> -
> -_supported_fs btrfs
> -_require_scratch
> -
> -_fixed_by_kernel_commit xxxxxxxxxxxx \
> -       "btrfs: do not abort transaction if there is already an existing =
qgroup"
> -
> -_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> -_scratch_mount
> -
> -# Create the first subvolume and get its id.
> -# This subvolume id should not change no matter if there is an existing
> -# qgroup for it.
> -$BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/subvol" >> $seqres.full
> -$BTRFS_UTIL_PROG subvolume snapshot "$SCRATCH_MNT/subvol" \
> -       "$SCRATCH_MNT/snapshot">> $seqres.full
> -
> -init_subvolid=3D$(_btrfs_get_subvolid "$SCRATCH_MNT" "snapshot")
> -
> -if [ -z "$init_subvolid" ]; then
> -       _fail "Unable to get the subvolid of the first snapshot"
> -fi
> -
> -echo "Subvolumeid: ${init_subvolid}" >> $seqres.full
> -
> -_scratch_unmount
> -
> -# Re-create the fs, as btrfs won't reuse the subvolume id.
> -_scratch_mkfs >> $seqres.full 2>&1 || _fail "2nd mkfs failed"
> -_scratch_mount
> -
> -$BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT" >> $seqres.full
> -_qgroup_rescan $SCRATCH_MNT >> $seqres.full
> -
> -# Create a qgroup for the first subvolume, this would make the later
> -# subvolume creation to find an existing qgroup, and abort transaction.
> -$BTRFS_UTIL_PROG qgroup create 0/"$init_subvolid" "$SCRATCH_MNT" >> $seq=
res.full
> -
> -# Now create the first snapshot, which should have the same subvolid no =
matter
> -# if the quota is enabled.
> -$BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/subvol" >> $seqres.full
> -$BTRFS_UTIL_PROG subvolume snapshot "$SCRATCH_MNT/subvol" \
> -       "$SCRATCH_MNT/snapshot" >> $seqres.full
> -
> -# Either the snapshot create failed and transaction is aborted thus no
> -# snapshot here, or we should be able to create the snapshot.
> -new_subvolid=3D$(_btrfs_get_subvolid "$SCRATCH_MNT" "snapshot")
> -
> -echo "Subvolumeid: ${new_subvolid}" >> $seqres.full
> -
> -if [ -z "$new_subvolid" ]; then
> -       _fail "Unable to get the subvolid of the first snapshot"
> -fi
> -
> -# Make sure the subvolumeid for the first snapshot didn't change.
> -if [ "$new_subvolid" -ne "$init_subvolid" ]; then
> -       _fail "Subvolumeid for the first snapshot changed, has ${new_subv=
olid} expect ${init_subvolid}"
> -fi
> -
> -echo "Silence is golden"
> -
> -# success, all done
> -status=3D0
> -exit
> diff --git a/tests/btrfs/303.out b/tests/btrfs/303.out
> deleted file mode 100644
> index d48808e60..000000000
> --- a/tests/btrfs/303.out
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -QA output created by 303
> -Silence is golden
> --
> 2.43.0
>
>

Seems reasonable.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

