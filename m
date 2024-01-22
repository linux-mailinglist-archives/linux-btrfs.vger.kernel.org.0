Return-Path: <linux-btrfs+bounces-1600-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F7B8363A7
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 13:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E59B81C262EA
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 12:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497293C08D;
	Mon, 22 Jan 2024 12:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLq/kFnj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BC41E878;
	Mon, 22 Jan 2024 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705927599; cv=none; b=GtPc1NRavBKzOHXnOeY7iR0PSaHyPc7Y35Me6MONhiR1kY18Bc1rQT/hq9j4eAdNAoXF16IN0ZAmMO98uiL4MjwrPSRgZFAjlOePRD7ML/xBvFfMLnwwMAY2AOr2NzW1GbWb3OGjvj0iosseyGIxbQqX+a2bputmyO7g062fzLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705927599; c=relaxed/simple;
	bh=RyPFRiZY6p6l7AyXDYoTC6Z3YjdoaLx9oDlPh2Pt2y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QtLinzft+ftKobIgFdiSlzNgzoZilWMaeAZB58IeJV4FAdAtJQ5v4FOXMySQtDESoppsK5UM2BqKEkm/RiZ6GdIvqLqNXJ54W+UFCaCTtZN7LnmY3M8Cw2JmSEeK1tF5Yw6tywzyD7q6R2aKCQviMAhazxWZfpcjRfSX+wXb/YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLq/kFnj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78BDC433F1;
	Mon, 22 Jan 2024 12:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705927598;
	bh=RyPFRiZY6p6l7AyXDYoTC6Z3YjdoaLx9oDlPh2Pt2y0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mLq/kFnjSJglPzYZ4tjeuIQCtUcFDJAmO5GRfNXu+nPQXAyowT+P+S+Ya3N6CzKOa
	 2zs0WW/ul2mDFzmve4+/nQj2Wm+28Y3SWx19DYc8+r1htzryb8oZxJwrrEd6lOzVXP
	 wx1D1lNBbsbcl4GYnrcVT+waO0U7ZBdOkPARz14fqXejoASLqU5qZrj5F1PaQ/lEmV
	 BU0AdnwKqrtq0X9K/+cy9ab1b7fA3t6j3tADXHpknPUZasa4qX4juoMiOrIBunoyI5
	 zP18Fycb62te1EriKRhD/MiwgkH6N+spgCz9tIszCE8oOcXv0PFWYP72LokrFv248p
	 AIY/bLrXko7Ng==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2d04888d3dso322597866b.2;
        Mon, 22 Jan 2024 04:46:38 -0800 (PST)
X-Gm-Message-State: AOJu0YzgKzsIufJ8q4vvAnH54WhthrLbKX3olkUman5j5ANGkamU/q3O
	dCV6ZHdDwzoTj/zbdZ3gZqZeecto43g8cIDFgUKZSbPDC0eB3gJ/0DRzWJG4M34Yzsbiq1J1xPA
	8Tu8B09ezpFZMzMlq3iXngox9tc4=
X-Google-Smtp-Source: AGHT+IEg0E3KHylNfl9M/vtSZgSc62+pk87t4U2/F1PT5w1r60l7Z9ZQowuphdDrDk8D7PiKE2TB17/fpYkLO2ebvOs=
X-Received: by 2002:a17:907:8dca:b0:a30:41ea:d410 with SMTP id
 tg10-20020a1709078dca00b00a3041ead410mr1099833ejc.129.1705927597317; Mon, 22
 Jan 2024 04:46:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122105554.1077035-1-johannes.thumshirn@wdc.com>
In-Reply-To: <20240122105554.1077035-1-johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 22 Jan 2024 12:46:00 +0000
X-Gmail-Original-Message-ID: <CAL3q7H44FfKYCmg3_PQK=swEwr+VrR2mJu2X8kDXFXBNMqgNFA@mail.gmail.com>
Message-ID: <CAL3q7H44FfKYCmg3_PQK=swEwr+VrR2mJu2X8kDXFXBNMqgNFA@mail.gmail.com>
Subject: Re: [PATCH] btrfs/zoned: test premature ENOSPC because of reclaim
 being too slow
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 10:56=E2=80=AFAM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> Add a test writing a file of 60% the drive size on a zoned btrfs and then
> overwriting the file again.
>
> On fast drives this will cause premature ENOSPC because the reclaim
> process isn't triggered fast enough.
>
> The kernel patch for this issue is:
>  btrfs: zoned: wake up cleaner sooner if needed
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  tests/btrfs/310     | 54 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/310.out |  2 ++
>  2 files changed, 56 insertions(+)
>  create mode 100755 tests/btrfs/310
>  create mode 100644 tests/btrfs/310.out
>
> diff --git a/tests/btrfs/310 b/tests/btrfs/310
> new file mode 100755
> index 000000000000..6f6f5542f73f
> --- /dev/null
> +++ b/tests/btrfs/310
> @@ -0,0 +1,54 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Western Digital Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 310
> +#
> +# Write a single file with 60% disk size to a zoned btrfs and then overw=
rite
> +# it again. On kernels without the fix this results in ENOSPC.
> +#
> +# This issue is fixed by the following kernel patch:
> +#    btrfs: zoned: wake up cleaner sooner if needed
> +
> +. ./common/preamble
> +_begin_fstest auto enospc rw zone

Why the rw group?
The test only exercises writes.

Also the enospc group, I think it's meant to exercise cases that are
expected to hit ENOSPC.
Here we want to verify that we don't hit ENOSPC (or any other error).

Thanks.

> +
> +# real QA test starts here
> +
> +_supported_fs btrfs
> +_require_scratch
> +_require_zoned_device "$SCRATCH_DEV"
> +
> +devsize=3D$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/size)
> +devsize=3D$(expr $devsize \* 512)
> +filesize=3D$(expr $devsize \* 60 / 100)
> +
> +fio_config=3D$tmp.fio
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +       rm -f $tmp.*
> +}
> +
> +cat >$fio_config <<EOF
> +[test]
> +filename=3D$SCRATCH_MNT/test
> +readwrite=3Dwrite
> +loops=3D2
> +filesize=3D$filesize
> +EOF
> +
> +_require_fio $fio_config
> +
> +_scratch_mkfs >/dev/null 2>&1
> +_scratch_mount
> +
> +$FIO_PROG $fio_config >> $seqres.full
> +
> +_scratch_unmount
> +
> +echo "Silence is golden"
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/310.out b/tests/btrfs/310.out
> new file mode 100644
> index 000000000000..7b9eaf78a07a
> --- /dev/null
> +++ b/tests/btrfs/310.out
> @@ -0,0 +1,2 @@
> +QA output created by 310
> +Silence is golden
> --
> 2.43.0
>
>

