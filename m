Return-Path: <linux-btrfs+bounces-745-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E62808766
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 13:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28FAF1C21F54
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 12:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC5339AF4;
	Thu,  7 Dec 2023 12:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4psUv2o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84AF187B;
	Thu,  7 Dec 2023 12:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52971C433C7;
	Thu,  7 Dec 2023 12:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701951131;
	bh=2+aGullRBbfnICMPkRMyx84gPHQIh1abH+d15HDJmeg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=L4psUv2oMN0Lxk13MvTZpzccwxqlsjuHMrlwUf2pzsQOArj80yGb0fpo/tfoggcqT
	 k5BBL+d5VzBoNHDiiiZ2C+AVxLLAsrqH5s16QMZg3nsyNfwkzhciWTADyE3jlfn7Rq
	 A7k3aaX7Sdo73YUiLt8TInIUTzVWbgPqITNoz+56BnQsXOeN/47GE8XYSAkwgvzG9P
	 ubxrREAQV+YSkKro7NXR+OA83OhAkU6Y8tkR2itsM6aqdQ4ryZ3nuSOhUWxpHe+yM4
	 0yxPQWl0+AGfWW9R6/nS57q3PGLNieMsQU9+KoyxfiAp0rpWkNwFpWv6rA62y5VZXt
	 xObTtSCW9HvWg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50bf2d9b3fdso752644e87.3;
        Thu, 07 Dec 2023 04:12:11 -0800 (PST)
X-Gm-Message-State: AOJu0YxDAxhNiLpOc4kp56pbbLuUeOG7knfpiMoX3f3lkWp+cGVNxKOT
	90Pis1hIcQYXqQJ17MlLNs6SC4AeUeMIM8lIFZQ=
X-Google-Smtp-Source: AGHT+IENODZwwZcL7JsTuG04t3TxoMLsR1CQ0Y9xF/ZNA5CA3Y59h+NLADpwxqow75rdnpytfSWpgb+ev3aqEe8iZ9M=
X-Received: by 2002:a05:6512:3124:b0:50c:a39:ee37 with SMTP id
 p4-20020a056512312400b0050c0a39ee37mr1494200lfd.109.1701951129477; Thu, 07
 Dec 2023 04:12:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207-btrfs-raid-v5-0-44aa1affe856@wdc.com>
In-Reply-To: <20231207-btrfs-raid-v5-0-44aa1affe856@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 7 Dec 2023 12:11:32 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7pMjbc1-xZ1xDSMRBM2C-FiTi=sx=mQNBqH4MbXQ_WLA@mail.gmail.com>
Message-ID: <CAL3q7H7pMjbc1-xZ1xDSMRBM2C-FiTi=sx=mQNBqH4MbXQ_WLA@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] fstests: add tests for btrfs' raid-stripe-tree feature
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>, 
	Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 9:03=E2=80=AFAM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> Add tests for btrfs' raid-stripe-tree feature. All of these test work by
> writing a specific pattern to a newly created filesystem and afterwards
> using `btrfs inspect-internal -t raid-stripe $SCRATCH_DEV_POOL` to verify
> the placement and the layout of the metadata.
>
> The md5sum of each file will be compared as well after a re-mount of the
> filesystem.
>
> ---
> Changes in v5:
> - add _require_btrfs_free_space_tree helper and use in tests
> - Link to v4: https://lore.kernel.org/r/20231206-btrfs-raid-v4-0-578284dd=
3a70@wdc.com
>
> Changes in v4:
> - add _require_btrfs_no_compress to all tests
> - add _require_btrfs_no_nodatacow helper and add to btrfs/308
> - add _require_btrfs_feature "free_space_tree" to all tests
> - Link to v3: https://lore.kernel.org/r/20231205-btrfs-raid-v3-0-0e857a54=
39a2@wdc.com
>
> Changes in v3:
> - added 'raid-stripe-tree' to mkfs options, as only zoned raid gets it
>   automatically
> - Rename test cases as btrfs/302 and btrfs/303 already exist upstream
> - Link to v2: https://lore.kernel.org/r/20231205-btrfs-raid-v2-0-25f80eea=
345b@wdc.com
>
> Changes in v2:
> - Re-ordered series so the newly introduced group is added before the
>   tests
> - Changes Filipe requested to the tests.
> - Link to v1: https://lore.kernel.org/r/20231204-btrfs-raid-v1-0-b254eb1b=
cff8@wdc.com
>
> ---
> Johannes Thumshirn (9):
>       fstests: doc: add new raid-stripe-tree group
>       common: add filter for btrfs raid-stripe dump
>       common: add _require_btrfs_no_nodatacow helper
>       common: add _require_btrfs_free_space_tree
>       btrfs: add fstest for stripe-tree metadata with 4k write
>       btrfs: add fstest for 8k write spanning two stripes on raid-stripe-=
tree
>       btrfs: add fstest for writing to a file at an offset with RST
>       btrfs: add fstests to write 128k to a RST filesystem
>       btrfs: add fstest for overwriting a file partially with RST
>
>  common/btrfs        |  17 +++++++++
>  common/filter.btrfs |  14 +++++++
>  doc/group-names.txt |   1 +
>  tests/btrfs/304     |  56 +++++++++++++++++++++++++++
>  tests/btrfs/304.out |  58 ++++++++++++++++++++++++++++
>  tests/btrfs/305     |  61 ++++++++++++++++++++++++++++++
>  tests/btrfs/305.out |  82 ++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/306     |  59 +++++++++++++++++++++++++++++
>  tests/btrfs/306.out |  75 +++++++++++++++++++++++++++++++++++++
>  tests/btrfs/307     |  56 +++++++++++++++++++++++++++
>  tests/btrfs/307.out |  65 ++++++++++++++++++++++++++++++++
>  tests/btrfs/308     |  60 +++++++++++++++++++++++++++++
>  tests/btrfs/308.out | 106 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  13 files changed, 710 insertions(+)
> ---
> base-commit: baca8a2b5cb6e798ce3a07e79a081031370c6cb8

Btw this base commit does not exist in the official fstests repo.
That commit is from the staging branch at https://github.com/kdave/xfstests

A "git am" will fail because the official fstests repo doesn't have
_require_btrfs_no_block_group_tree() at common/btrfs,
so it needs to be manually adjusted when applying the 3rd patch.

I tried the tests and they look good, so:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

One question I missed before. Test 304 for example does a 4K write and
expects in the golden output to get a 4K raid stripe item.
What happens on a machine with 64K page size? There the default sector
size is 64K, will the write result in a 64K raid stripe item or will
it be 4K? In the former case, it will make the test fail.

Thanks.


> change-id: 20231204-btrfs-raid-75975797f97d
>
> Best regards,
> --
> Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
>

