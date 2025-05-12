Return-Path: <linux-btrfs+bounces-13875-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C44AB30DC
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 09:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6EB3189BA22
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 07:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6142571D1;
	Mon, 12 May 2025 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtMI6pLE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807071B4F2C;
	Mon, 12 May 2025 07:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747036514; cv=none; b=igmWbu/jul9a+meq2pbv4pq/EzRmUyteiyXikMFu7Srrs+ktMwdS1GPUuRnU0UuEqMpEAQ+Q7AHU1/RA5kuwo9oMK/Z/OCQersO25vDmU1E/GZSgFrAGrC/KOEexvI0Mk8+yNV2wP2lSaLIsMenatvIk2JlxOgVUgadpdtSpNCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747036514; c=relaxed/simple;
	bh=xtrvImBE7Z/8/4cbYJJk38Wgm9lpNhQa9bCcAbo6T84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Evxg7J3Zugq8KjtQyFBh3F0n8L/i6SY36cqH2NqM/yf4rNPUCsXYSF+sQh/BoJ0oWDIAeoot8b2WrL23ttzTfOislmArpe9k4O3U0QKJ36TwVtNoBXjwrBwJvNK9q3Sn9dJsYdm4YY1e7O8p92TmN7DeiCbhUTmljuySpNzr/yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtMI6pLE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D815BC4CEEF;
	Mon, 12 May 2025 07:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747036513;
	bh=xtrvImBE7Z/8/4cbYJJk38Wgm9lpNhQa9bCcAbo6T84=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jtMI6pLEEf/WbD1Vw1k4iPGF8xjoOagr1hwYaDok16P/LYnK7DHFw0FXYPsXd+EOH
	 c7uZektcHV8r6GKGY3YLmrc60awKTVA9lKRBevWJR3yGjj9Y6RWSnjcsXlwgmH+3lz
	 ECPXh3vCF7+YaGD94MwoY/QpYNNltIW66lhuG8BUyOK/oUCitCCtJaa1sQSlnUQirM
	 Q27uH+GsECxEc47O6VQenp9rT2jHK6KQxVKxnNT4g3ZFy1Xa/WTMY1c3eCO7WOIxTS
	 np7aLB7zZA/wNiGj3qA3NCuYXEsKU9+1dhDiw7Qpws2cGulb8ks+a/Ul3OSA5fL5DW
	 TdddaQrxAEhKQ==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-acb39c45b4eso676481366b.1;
        Mon, 12 May 2025 00:55:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVCVJAZ6xPW2jLzGfj8ltd2jCyp6EX1F1lNyYeV4kEhwPm6LZSoNyn9U/Ub4mrROjPJPUfThqOY@vger.kernel.org
X-Gm-Message-State: AOJu0YwKyYdX6j5Zb7RkCvn5Jel6/qnlwSD5cOJxXjbWMRuyn0KGUwkY
	pRkAuaIsq7HgZ8LTvHMwznXT8B1oxW6sHgtV8ejmVrXRCu5kYK+9vDfdG6nP9t6iHtSqe1EkTnU
	rm3mjVQmIgUexvNDg0qSFduPvi2w=
X-Google-Smtp-Source: AGHT+IEd3walbHWpGiNDBga8aTvR2vl8Ec5Jd0P1kAg17tS2dp9KvrJ/Rvsi3E0EwlGvj5D8bEwg/hD1RNZ6SQbXr5M=
X-Received: by 2002:a17:907:7e8e:b0:ad2:4b33:ae62 with SMTP id
 a640c23a62f3a-ad24b33b82cmr446653466b.35.1747036512396; Mon, 12 May 2025
 00:55:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512052551.236243-1-wqu@suse.com> <CAL3q7H7cqfhVNwEJ6dgXgZSmfUbOrSNZuua3MPWTs0LJ43BQXQ@mail.gmail.com>
 <c119cf23-3165-42fd-85f8-e2240eb9b7df@suse.com>
In-Reply-To: <c119cf23-3165-42fd-85f8-e2240eb9b7df@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 12 May 2025 08:54:35 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4dxAGTK9XBe2Yeoywy7-HTktwt_Jcp=FE0yNYnrU8H0A@mail.gmail.com>
X-Gm-Features: AX0GCFuEM8WAbwauV-xZJznAAppaOJ9nzEOZiCJTwnBMabols0t1EFsjKbB-_w4
Message-ID: <CAL3q7H4dxAGTK9XBe2Yeoywy7-HTktwt_Jcp=FE0yNYnrU8H0A@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs: a new test case to verify scrub and rescue=idatacsums
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 8:51=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2025/5/12 17:14, Filipe Manana =E5=86=99=E9=81=93:
> > On Mon, May 12, 2025 at 6:26=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> There is a kernel bug report that scrub will trigger a NULL pointer
> >> dereference when rescue=3Didatacsums mount option is provided.
> >>
> >> Add a test case for such situation, to verify kernel can gracefully
> >> reject scrub when  there is no csum tree.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   tests/btrfs/336     | 32 ++++++++++++++++++++++++++++++++
> >>   tests/btrfs/336.out |  2 ++
> >>   2 files changed, 34 insertions(+)
> >>   create mode 100755 tests/btrfs/336
> >>   create mode 100644 tests/btrfs/336.out
> >>
> >> diff --git a/tests/btrfs/336 b/tests/btrfs/336
> >> new file mode 100755
> >> index 00000000..f76a8e21
> >> --- /dev/null
> >> +++ b/tests/btrfs/336
> >> @@ -0,0 +1,32 @@
> >> +#! /bin/bash
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +# Copyright (C) 2025 SUSE Linux Products GmbH. All Rights Reserved.
> >> +#
> >> +# FS QA Test 336
> >> +#
> >> +# Make sure read-only scrub won't cause NULL pointer dereference with
> >> +# rescue=3Didatacsums mount option
> >> +#
> >> +. ./common/preamble
> >> +_begin_fstest auto scrub quick
> >> +
> >> +_fixed_by_kernel_commit 6aecd91a5c5b \
> >> +       "btrfs: avoid NULL pointer dereference if no valid extent tree=
"
> >> +
> >> +_require_scratch
> >> +_scratch_mkfs >> $seqres.full
> >> +
> >> +_try_scratch_mount "-o ro,rescue=3Dignoredatacsums" > /dev/null 2>&1 =
||
> >> +       _notrun "rescue=3Dignoredatacsums mount option not supported"
> >> +
> >> +# For unpatched kernel this will cause NULL pointer dereference and c=
rash the kernel.
> >> +# For patched kernel scrub will be gracefully rejected.
> >> +$BTRFS_UTIL_PROG scrub start -Br $SCRATCH_MNT >> $seqres.full 2>&1
> >
> > If the scrub is supposed to fail, as the comment says, then we should
> > check that it fails.
> > Right now we're ignoring whether it succeeds or fails.
>
> Currently it indeed fails for patched kernel, but I'm not sure if it
> will keep so in the future.
>
> E.g. we can still properly scrub metadata chunks, and for data chunks we
> may even delayed the csum tree lookup so that if we got an empty data
> block group, we just do an early exit.
>
> Or should I do the failure check, and update the test case when the
> kernel behavior changes in the future?

It should check the current expected behaviour, and if that changes
one day, then update it.

I always find it terribly confusing when something is called and we
ignore its stdout/stderr and exit status - it makes one wonder why the
command is being called, if the author forgot about checking what's
supposed to happen.

Thanks.

>
> Thanks,
> Qu
>
>
> >
> > Otherwise it looks fine, thanks.
> >
>

