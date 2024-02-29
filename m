Return-Path: <linux-btrfs+bounces-2915-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4904286C84B
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 12:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0163A288445
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 11:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52587C6CA;
	Thu, 29 Feb 2024 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAvKe0Q8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA0D59B6A;
	Thu, 29 Feb 2024 11:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709207017; cv=none; b=bSKyiNpktU/IPL1fAryq5cPD7cG1HmcWUKReODbMUCXidHAY8wM/bGMbdS6Q7/AJegzh73sipQeseZpc28WT3+kmKafYF0ya9jrWHUZUT7lmf/WnKqoFblBJFCdkGlVro7QdKT4nqdsbg7S3JAx0qypIODilQHamai72d+9W23Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709207017; c=relaxed/simple;
	bh=iR+7Pwd5GcVuzGIkbuhn7t0TtidT2HZgYZJgFgmSPVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dGXHJrSa7H17kAjGG3uYjuh1fYX/tMc5kJd7yM6UlnAeEJUJ7MLBAD9aTCCPWvrzqN33Spkc6SAnnKKSxPoc6r3qwKe4F6swA582jo5A3K6hvvAKHFv51VGhap4HixL5Nd9EJAx4LnHOC+r3TAF8xHsgyH3oMrDb2WslZ46w30E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAvKe0Q8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6308C43390;
	Thu, 29 Feb 2024 11:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709207016;
	bh=iR+7Pwd5GcVuzGIkbuhn7t0TtidT2HZgYZJgFgmSPVE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qAvKe0Q8C8VCSmy7XVnHODvFXZFlg4Gst5usQ7TLdNVhVX6ZTQeAQyju+w+oB+7gD
	 UCOQYXKabhnWK8dj6Oo0CnNZH2uWdFsA65F0p+L9cd3P50Itn+j+w9Dr1ktZTV+hQw
	 kMKnUz3tPEXluFlYz5ZYwurHqVv3UDogwaA8Mh3mAmSgmLcR1mGRRM7YQJKHVN3T3/
	 FFHaKBDg1kQ/vSXkgH4uaCQ58XUHerRyPQdV0+CLSsxUqEU7sNQ6JQ56Q5WnMzdQx5
	 7SKIu9U4umQh5Zx4iHhjDQtqYxmBcYxxWuL0GTIYWdXCWqCxTpilGk0gCxglWRRc7O
	 0e5EamEiYajeA==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a4429c556efso141796466b.0;
        Thu, 29 Feb 2024 03:43:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV+u4RCBwC7tH/XlDRufxL5YI73A7jdx4un7+8s7k+0wQrgj/vV7xZBd76U8wlvymnA+kqiiBy/WfslYG7k+Nm+EIkbRSe1SRMSclo=
X-Gm-Message-State: AOJu0YyWOY2rD6VQrCu6UMeN7SV5sp1QFQZmWBXhaHiYprn0kXubUpXf
	g7qosHdkiu1OlGD5a6z5sw0M0ge3QjMEpwcpoPsYPyNwN64RO4NgLQt7b7UiyN2tydDegbUSgNC
	ciGN5KrskxZDsvKCmeX6i1GcanbQ=
X-Google-Smtp-Source: AGHT+IGzhVRe0noekaYMIyJDMaiWwCattMKWeOM7eUJcj4KtwFhApGz1nJLT/6uBrbSzC+aRfEDXgI94twbPF2mkflk=
X-Received: by 2002:a17:906:16d6:b0:a3e:c1ec:7bff with SMTP id
 t22-20020a17090616d600b00a3ec1ec7bffmr1385877ejd.68.1709207015151; Thu, 29
 Feb 2024 03:43:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709162170.git.anand.jain@oracle.com> <343786d75315f45e2bdd8cfb94d5bbf520f3df94.1709162170.git.anand.jain@oracle.com>
In-Reply-To: <343786d75315f45e2bdd8cfb94d5bbf520f3df94.1709162170.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 29 Feb 2024 11:42:58 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5-vnYVx5k9pMaEkhZWHDU1yoPb2JW1ZbxguZmY-GNpcQ@mail.gmail.com>
Message-ID: <CAL3q7H5-vnYVx5k9pMaEkhZWHDU1yoPb2JW1ZbxguZmY-GNpcQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/10] btrfs: verify tempfsid clones using mkfs
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 1:51=E2=80=AFAM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> Create appearing to be a clone using the mkfs.btrfs option and test if
> the tempfsid is active.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.


> ---
>  tests/btrfs/313     | 52 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/313.out | 16 ++++++++++++++
>  2 files changed, 68 insertions(+)
>  create mode 100755 tests/btrfs/313
>  create mode 100644 tests/btrfs/313.out
>
> diff --git a/tests/btrfs/313 b/tests/btrfs/313
> new file mode 100755
> index 000000000000..5b8062f4f71a
> --- /dev/null
> +++ b/tests/btrfs/313
> @@ -0,0 +1,52 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 313
> +#
> +# Functional test for the tempfsid, clone devices created using the mkfs=
 option.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick clone tempfsid
> +
> +_cleanup()
> +{
> +       cd /
> +       $UMOUNT_PROG $mnt1 > /dev/null 2>&1
> +       rm -r -f $tmp.*
> +       rm -r -f $mnt1
> +}
> +
> +. ./common/filter.btrfs
> +. ./common/reflink
> +
> +_supported_fs btrfs
> +_require_cp_reflink
> +_require_scratch_dev_pool 2
> +_require_btrfs_fs_feature temp_fsid
> +
> +_scratch_dev_pool_get 2
> +
> +mnt1=3D$TEST_DIR/$seq/mnt1
> +mkdir -p $mnt1
> +
> +echo ---- clone_uuids_verify_tempfsid ----
> +mkfs_clone ${SCRATCH_DEV_NAME[0]} ${SCRATCH_DEV_NAME[1]}
> +
> +echo Mounting original device
> +_mount ${SCRATCH_DEV_NAME[0]} $SCRATCH_MNT
> +check_fsid ${SCRATCH_DEV_NAME[0]}
> +
> +echo Mounting cloned device
> +_mount ${SCRATCH_DEV_NAME[1]} $mnt1
> +check_fsid ${SCRATCH_DEV_NAME[1]}
> +
> +$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | _filter_xfs_=
io
> +echo cp reflink must fail
> +_cp_reflink $SCRATCH_MNT/foo $mnt1/bar 2>&1 | _filter_testdir_and_scratc=
h
> +
> +_scratch_dev_pool_put
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/313.out b/tests/btrfs/313.out
> new file mode 100644
> index 000000000000..7a089d2c29c5
> --- /dev/null
> +++ b/tests/btrfs/313.out
> @@ -0,0 +1,16 @@
> +QA output created by 313
> +---- clone_uuids_verify_tempfsid ----
> +Mounting original device
> +On disk fsid:          FSID
> +Metadata uuid:         FSID
> +Temp fsid:             FSID
> +Tempfsid status:       0
> +Mounting cloned device
> +On disk fsid:          FSID
> +Metadata uuid:         FSID
> +Temp fsid:             TEMPFSID
> +Tempfsid status:       1
> +wrote 9000/9000 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +cp reflink must fail
> +cp: failed to clone 'TEST_DIR/313/mnt1/bar' from 'SCRATCH_MNT/foo': Inva=
lid cross-device link
> --
> 2.39.3
>

