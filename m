Return-Path: <linux-btrfs+bounces-2212-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4B184CD8F
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 16:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763CA1F28131
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 15:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3415A17BDD;
	Wed,  7 Feb 2024 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uS9n6nNS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6831095A;
	Wed,  7 Feb 2024 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707318098; cv=none; b=sU2qQ9Ajn/5LM6dNDu8cO6jqBsBEzVMilk+U3kUy4Op6nm4rmkDXQ5Ko49FBPntsIaG55jPFQRooKwc/ikZQ7bXYoYjjdjd18SFDzuxqycP33tdldhNXMdXyHPWO91jaOb4iOCakbqnrVoyzJibIVqdwfz4GofmJG75HyY8UDdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707318098; c=relaxed/simple;
	bh=/vgCAuSNs6gB+VdL6aXHg2WLg2R5391HBmpmQgQeePw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lWsy+mqqSHDJY7Z9TmnEpW7I/lES27jRwP9v48zDHenT56EQhXZgHO2sZO4ygeryIZcL+Jlwm2Sdhtc2i9v4Td8Br8rbGyUdduiIDXdwY1y5CiSjBH2X4y/ZyIUhakS+nrfr3Cp99ug/PsGYyxxXMsVaqoM684lcwtVkApBC2iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uS9n6nNS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D53C43390;
	Wed,  7 Feb 2024 15:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707318097;
	bh=/vgCAuSNs6gB+VdL6aXHg2WLg2R5391HBmpmQgQeePw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uS9n6nNSUom35ND9RI7sRkj5+mzrdYS2/U8rUj6imZSGMn/XaZ5MIvST6W9EfkW+h
	 HNs7MWoBNz8P3WU7SV+BkBVCINnYeWhgp3XOt1kzG5/gT8DHTMfXTvKEa2TCUzOBrt
	 G9oBQUvme8UrfpgPWzKkvatX2u1TejLOZrheG02iOIwEEKwI6C+nWR3uuaKRWHg2VV
	 QhjzkykTRtIosoltY3PAVNB48yWN4l2gvVHb7y1o9HZ2ewfiNgpXDexHhQvXSbRvQO
	 s061mpL/1vBWF8mkRTwnjbQZaV+ZDIPp0Gv3nfYvyhUlHCZOKx+eQPQX5LkJmyFjFr
	 fmsSV2X+qIt+g==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a388c5542e9so80466066b.1;
        Wed, 07 Feb 2024 07:01:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW4EI/aY1TpK8b5iqUnl4kijA7oglBqKMBTw75skyHk9w53QU5/AiOkWeJRuXa/fyLl0Aa0HbYFf/PsZv/jYYmnweL1Dv6oDg==
X-Gm-Message-State: AOJu0YxPtYkLhnkN3JpZq4YCpxhVPsYp80ZfEBA40nwj0nUP+F/yqBx3
	tgW4p2vLvsVgiFz5r5xcpB2+r/l1+ToqBJtr6ZWhPLoLNa7CJvwvVLauP+3ibHtqGnzXn/MQxrx
	amcizjPWSklR++aIKwaOnqhEv8y4=
X-Google-Smtp-Source: AGHT+IG+XIwwERR8Q53YhqtILZBk4MDebABH6+/p156YEx7Zuif88yjToDWGYTQSiFz9svAb8lvN/fu0AJp1c59rlnA=
X-Received: by 2002:a17:907:77ca:b0:a38:9ade:d8a2 with SMTP id
 kz10-20020a17090777ca00b00a389aded8a2mr585871ejc.1.1707318095955; Wed, 07 Feb
 2024 07:01:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206233024.35399-1-wqu@suse.com>
In-Reply-To: <20240206233024.35399-1-wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 7 Feb 2024 15:00:59 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5fBLhnsp2iVEXDWvM-V-0=VnRhwRvL0O74sf9+xyXQXg@mail.gmail.com>
Message-ID: <CAL3q7H5fBLhnsp2iVEXDWvM-V-0=VnRhwRvL0O74sf9+xyXQXg@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs: make sure defrag doesn't increase space usage
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 11:30=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> There is a bug report that, the following simple file layout would make
> btrfs defrag to wrongly defrag part of the file, and results in
> increased space usage:
>
>  # mkfs.btrfs -f $dev
>  # mount $dev $mnt
>  # xfs_io -f -c "pwrite 0 40m" $mnt/foobar
>  # sync
>  # xfs_io -f -c "pwrite 40m 64k" $mnt/foobar.
>  # sync
>  # btrfs filesystem defrag $mnt/foobar
>  # sync
>
> [CAUSE]
> It's a bug in the defrag decision part, where we use the length to the
> end of the extent to determine if it meets our extent size threshold.
>
> That cause us to do different defrag decision inside the same file
> extent, and such defrag would cause extra space caused by btrfs data
> CoW.
>
> [TEST CASE]
> The test case would just use the above workload as the core, and use
> qgroups to properly record the data usage of the fs tree, to make sure
> the defrag at least won't cause extra space usage in this particular
> case.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/310     | 63 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/310.out |  2 ++
>  2 files changed, 65 insertions(+)
>  create mode 100755 tests/btrfs/310
>  create mode 100644 tests/btrfs/310.out
>
> diff --git a/tests/btrfs/310 b/tests/btrfs/310
> new file mode 100755
> index 00000000..ca535f99
> --- /dev/null
> +++ b/tests/btrfs/310
> @@ -0,0 +1,63 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 YOUR NAME HERE.  All Rights Reserved.

Don't forget to update this.

> +#
> +# FS QA Test 310
> +#
> +# what am I here for?

And this too.

> +#
> +. ./common/preamble
> +_begin_fstest auto quick defrag qgroup
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch
> +_require_btrfs_no_nodatacow
> +_fixed_by_kernel_commit XXXXXXXXXXXX \
> +       "btrfs: btrfs: defrag: avoid unnecessary defrag caused by incorre=
ct extent size"
> +
> +_scratch_mkfs >> $seqres.full
> +
> +# We require no compression and enable datacow.
> +# As we rely on qgroup to give us an accurate number of used space,
> +# which is based on on-disk extent size, thus we have to disable compres=
sion.
> +#
> +# And we rely COW to cause wasted space on unpatched kernels, thus data =
cow
> +# is required.
> +_scratch_mount -o compress=3Dno,datacow

datacow is redundant here, _require_btrfs_no_nodatacow was already called a=
bove.

Should also use  _require_btrfs_no_compress()

> +
> +# Enable quota to account the wasted bookend space.
> +$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT 2>> $seqres.full &
> +_qgroup_rescan $SCRATCH_MNT >> $seqres.full
> +
> +# Create the following layout
> +# [0, 40M)             A regular uncompressed extent
> +# [40M, 40M+64K)       A small regular extent allowing merging
> +$XFS_IO_PROG -f -c "pwrite 0 40M" -c sync "$SCRATCH_MNT/foobar" >> $seqr=
es.full
> +$XFS_IO_PROG -f -c "pwrite 40M 64K" -c sync "$SCRATCH_MNT/foobar" >> $se=
qres.full
> +
> +# Then record the current qgroup number, which should be 40M + 64K + nod=
esize
> +qgroup_before=3D$($BTRFS_UTIL_PROG qgroup show --sync --raw "$SCRATCH_MN=
T" | tail -n1 | $AWK_PROG '{print $2}')
> +echo "qgroup number before defrag: $qgroup_before" >> $seqres.full
> +
> +# Now defrag the file with the default 32M extent size threshold.
> +$BTRFS_UTIL_PROG filesystem defrag -t 32M "$SCRATCH_MNT/foobar" >> $seqr=
es.full
> +
> +# Write back the re-dirtied content of defrag and update qgroup.
> +sync
> +
> +# Now check the newer qgroup numbers
> +qgroup_after=3D$($BTRFS_UTIL_PROG qgroup show --sync --raw "$SCRATCH_MNT=
" | tail -n1 | $AWK_PROG '{print $2}')
> +echo "qgroup number after defrag: $qgroup_after" >> $seqres.full
> +
> +# The new number should not exceed the old one, or the defrag itself is
> +# doing more damage.

Damage is not exactly the proper wording here, I would say wasting
space, as damage I would think of something like corruption, data
loss, etc.

Otherwise it looks fine.
Thanks.

> +if [ "$qgroup_after" -gt "$qgroup_before" ]; then
> +       echo "defrag caused more space usage: before=3D$qgroup_before aft=
er=3D$qgroup_after"
> +fi
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/310.out b/tests/btrfs/310.out
> new file mode 100644
> index 00000000..7b9eaf78
> --- /dev/null
> +++ b/tests/btrfs/310.out
> @@ -0,0 +1,2 @@
> +QA output created by 310
> +Silence is golden
> --
> 2.42.0
>
>

