Return-Path: <linux-btrfs+bounces-12419-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B68DAA68B30
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 12:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1829E16602F
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 11:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42172586F4;
	Wed, 19 Mar 2025 11:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V630X90m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C572586CE;
	Wed, 19 Mar 2025 11:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382470; cv=none; b=uzjL2ViqxSWBCNiM+AjH0DMNoKLUtN9myglEsb6z70/q2mYnyko0oO+0DF9VNCIVVAnN/HXWfk9EMiLMt3i7LUbh8cv2RI7BbstJUiCGbgfl8vbn038wVMiwy00VKlu4qYTXoS1Y2sBGEVI6LRa7v/mSE038nihYRwZr3Gg7dKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382470; c=relaxed/simple;
	bh=at6MHo12AOe2orceofs6sKJOGZKgFfAfbioUG2Pv7nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NKJkYvWZLoDSa/xot3IAx1k60GXYJs0VoCl33m7eTS67CafZVnADr7ebhuCO72LHElUF6ExfGgmSwIylN3TC4EemrLtO8DkirlwzwHQAh3GhGZXUzJv9xy+0YjMVJ9jYz7hkDGMewTy4Y3XD3Vi/tu+QxlARVEfhp8viTbJ1tFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V630X90m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B339FC4CEF3;
	Wed, 19 Mar 2025 11:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742382469;
	bh=at6MHo12AOe2orceofs6sKJOGZKgFfAfbioUG2Pv7nk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V630X90myixhgu1d124bhwR4BxXxFnCQ9KPGAOKDwTpQbytZ8+7kAxwAuaslg3CV3
	 yjwI6LM+HjAnqItgP7uyBamrc2Zj66cHig03ZV7JM0EMw1YbZloJdN7+/55eG5RWJC
	 bn1AJsP8s2u2f3mEsbw9CFuKSa0objz+QwdkgPz+t+3vmvd64aioevHjeMhSjehwPu
	 PkQg30xzKvhbd+lSg7PAIVgH+EwulvBIH+TM//763S5ZX8fUsDgAOeLR7GSqau5J0s
	 C69IuwWu23bWdLj/R79QqlC9rpYwgEZvd3+2hsRjaAcGItpfAxgxnIsMMin7nNjz8l
	 eVnVIeUvdDWuA==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so9430873a12.0;
        Wed, 19 Mar 2025 04:07:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXMpQRpFcW3YLNBTN0a8ZOyPVTZaezAoJrlRKNzwFEWd/Ktb0VdYVpRmzppxV7sYjVgY27l1VaK@vger.kernel.org, AJvYcCXdaLRM60ZJORaJoekkBoXM0QGNessUkdR2I9YfPtgHWfw+PcqEvTesfi3gm27HYIRWYADSFd6k7kwXotQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3H94I/GWFKbOnQ5uevSpsjU45liLDxjqhnZs238pLHiCBW5C/
	yPPQHgKpwrW+4QbK9qP7ncxVe+Ilnw1fQ36OsYQu5beCEmjjUjbGqN9BmtGPnp/CRbDxuxC8t9J
	Y8UwIdWFp92msa7Ziy7yTzoIKzxE=
X-Google-Smtp-Source: AGHT+IHTKUwgv7CLpAit+xqEB9excGg0vEWdHe+2QYcGPSwasPu01kTbh7aBtZ4AurQOFyMT+sy5cKwul59R4sHaO70=
X-Received: by 2002:a17:907:94c9:b0:ac2:47f7:4ad7 with SMTP id
 a640c23a62f3a-ac3b7f506f8mr232105466b.36.1742382468170; Wed, 19 Mar 2025
 04:07:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <05f928908a7949fb1787680176840b5ab23fde0b.1742303818.git.jth@kernel.org>
 <D8JUIEYCDPGF.2OM4BFFRXRUAF@wdc.com> <f923efc8-055b-490e-98ed-280e9485454e@wdc.com>
In-Reply-To: <f923efc8-055b-490e-98ed-280e9485454e@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 19 Mar 2025 11:07:10 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6cSPEcUwBCkaZfnJvO8d_6jWi9HQFKEt4Twdj+bX2OiQ@mail.gmail.com>
X-Gm-Features: AQ5f1JpZybvx83-ryQxbel1vbq3caaWhG8erM1ytE90lJZtXlEShhGkOwalSSJc
Message-ID: <CAL3q7H6cSPEcUwBCkaZfnJvO8d_6jWi9HQFKEt4Twdj+bX2OiQ@mail.gmail.com>
Subject: Re: [PATCH v3] fstests: btrfs: zoned: verify RAID conversion with
 write pointer mismatch
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Naohiro Aota <Naohiro.Aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, Zorro Lang <zlang@redhat.com>, 
	Anand Jain <anand.jain@oracle.com>, Filipe Manana <fdmanana@suse.com>, 
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 11:05=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 19.03.25 02:18, Naohiro Aota wrote:
> > On Tue Mar 18, 2025 at 10:17 PM JST, Johannes Thumshirn wrote:
> >> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >>
> >> Recently we had a bug report about a kernel crash that happened when t=
he
> >> user was converting a filesystem to use RAID1 for metadata, but for so=
me
> >> reason the device's write pointers got out of sync.
> >>
> >> Test this scenario by manually injecting de-synchronized write pointer
> >> positions and then running conversion to a metadata RAID1 filesystem.
> >>
> >> In the testcase also repair the broken filesystem and check if both sy=
stem
> >> and metadata block groups are back to the default 'DUP' profile
> >> afterwards.
> >>
> >> Link: https://lore.kernel.org/linux-btrfs/CAB_b4sBhDe3tscz=3DduVyhc9hN=
E+gu=3DB8CrgLO152uMyanR8BEA@mail.gmail.com/
> >> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >>
> >> ---
> >> Changes to v2:
> >> - Filter SCRATCH_MNT in golden output
> >> Changes to v1:
> >> - Add test description
> >> - Don't redirect stderr to $seqres.full
> >> - Use xfs_io instead of dd
> >> - Use $SCRATCH_MNT instead of hardcoded mount path
> >> - Check that 1st balance command actually fails as it's supposed to
> >> ---
> >>   tests/btrfs/329     | 62 +++++++++++++++++++++++++++++++++++++++++++=
++
> >>   tests/btrfs/329.out |  7 +++++
> >>   2 files changed, 69 insertions(+)
> >>   create mode 100755 tests/btrfs/329
> >>   create mode 100644 tests/btrfs/329.out
> >>
> >> diff --git a/tests/btrfs/329 b/tests/btrfs/329
> >> new file mode 100755
> >> index 000000000000..5496866ac325
> >> --- /dev/null
> >> +++ b/tests/btrfs/329
> >> @@ -0,0 +1,62 @@
> >> +#! /bin/bash
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +# Copyright (c) 2025 Western Digital Corporation.  All Rights Reserve=
d.
> >> +#
> >> +# FS QA Test 329
> >> +#
> >> +# Regression test for a kernel crash when converting a zoned BTRFS fr=
om
> >> +# metadata DUP to RAID1 and one of the devices has a non 0 write poin=
ter
> >> +# position in the target zone.
> >> +#
> >> +. ./common/preamble
> >> +_begin_fstest zone quick volume
> >> +
> >> +. ./common/filter
> >> +
> >> +_fixed_by_kernel_commit XXXXXXXXXXXX \
> >> +    "btrfs: zoned: return EIO on RAID1 block group write pointer mism=
atch"
> >> +
> >> +_require_scratch_dev_pool 2
> >> +declare -a devs=3D"( $SCRATCH_DEV_POOL )"
> >> +_require_zoned_device ${devs[0]}
> >> +_require_zoned_device ${devs[1]}
> >> +_require_command "$BLKZONE_PROG" blkzone
> >> +
> >> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> >> +_scratch_mount
> >> +
> >> +# Write some data to the FS to dirty it
> >> +$XFS_IO_PROG -fc "pwrite 0 128M" $SCRATCH_MNT/test | _filter_xfs_io
> >> +
> >> +# Add device two to the FS
> >> +$BTRFS_UTIL_PROG device add ${devs[1]} $SCRATCH_MNT >> $seqres.full
> >> +
> >> +# Move write pointers of all empty zones by 4k to simulate write poin=
ter
> >> +# mismatch.
> >> +zones=3D$($BLKZONE_PROG report ${devs[1]} | $AWK_PROG '/em/ { print $=
2 }' |\
> >> +    sed 's/,//')
> >
> > Can we limit the number of zones to work with, in case we run this test
> > on a huge device? I guess 2*(128M/4M)=3D64 would be enough.
> >
>
> I.e. something like the following:
>
> diff --git a/tests/btrfs/329 b/tests/btrfs/329
> index 5496866ac325..24d34852db1f 100755
> --- a/tests/btrfs/329
> +++ b/tests/btrfs/329
> @@ -33,8 +33,14 @@ $BTRFS_UTIL_PROG device add ${devs[1]} $SCRATCH_MNT >>=
 $seqres.full
>
>   # Move write pointers of all empty zones by 4k to simulate write pointe=
r
>   # mismatch.
> +
> +nzones=3D$($BLKZONE_PROG report ${devs[1]} | wc -l)
> +if [ $nzones -gt 64 ]; then
> +       nzones=3D64
> +fi
> +
>   zones=3D$($BLKZONE_PROG report ${devs[1]} | $AWK_PROG '/em/ { print $2 =
}' |\
> -       sed 's/,//')
> +       sed 's/,//' | head -n $nzones)
>   for zone in $zones;
>   do
>
> Yup this still triggers the bug on an unpatched kernel in my case and the
> fix also fixes it.
>
> So yes I'll update the testcase (I guess Filipe's R-b remains with this c=
hange).

Yes.

>

