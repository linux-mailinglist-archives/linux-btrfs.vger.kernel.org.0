Return-Path: <linux-btrfs+bounces-1663-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD2B839D66
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 00:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B80E1C254A5
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 23:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034C554BE6;
	Tue, 23 Jan 2024 23:52:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CF954BD0;
	Tue, 23 Jan 2024 23:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706053951; cv=none; b=kW/1csO7OqlNgBApMpRgxq7sifpWARlayUuPpFJzwdIyVPO4tjiZ/UE8YdG9MhGKSABt07ThIUgdwhY+59CICbecJP+Ripm2oNWlZjKLpqvV/hMw5A3sI7XPsO9yDAoO3MTwCbiyLS5wKAVv/BF9XIT2xNCi79eHzBflrSe4ZIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706053951; c=relaxed/simple;
	bh=MZXHxi+8P2+9SHjhQXmq7GABP4A394Ds+EowexxIe58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=erMXdc0YCVXIxxDMSxrVcusWf/Rmd5KjBxE5C0U8LQ9A7xRXr2ihD/i2gffu2yzYn1T53kJi28qIlGgk+Uf/wikiNFa4dJPr32J4fDtJflQ8q159pYeoKnyekzHpwEK7ldkGRtY3DBWMQB43TZxiUpR3//GIf4okO3zBxxO51mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50eabfac2b7so6232477e87.0;
        Tue, 23 Jan 2024 15:52:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706053947; x=1706658747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYUdyDvoLK5RS0LIW51mFYCETSvMhNuSzDAv/X0G7uc=;
        b=deQEie9j1jXMAq1hy2gzOULWfY0gHgZ+b2ssB6QuSKaVZ81HE5fygKcIRAMOGAxJRF
         SjJ2m+jptTTiQKPTvnxHtS/F6ygWH1IaQo7YT3GpC4lG6mG9I2jDZNWPIY2pqaY3EUUM
         v1DtV/e9KJz0i24gsZJ8Bjv4leDTgiWTHhi7FvB/rfbPMRhr3oAxFcYYAnhIbncDcUUQ
         C5qrP/STumhdnRE7c6s9d83JkA6IbnWiE9QNg8tDLVEuvXHiSiPkB28zwGURcvtattvb
         peCROfPj3PwM46lKQX9b15DL8VQMmQM3MQolnTHfosKDuo/4T5zmX3Ef8cOjJ+6lGnGL
         WXqA==
X-Gm-Message-State: AOJu0Yxi0Nl8NXlswYICaPUvn35aQWNMLr8frk89miKdc8RpedbW3LBz
	uvFuCaQsQXijj2Kor1eVzL2XtXLXWuH+uLLlZHHYB0DPWcTAhg2aUbxQ/8yldxg15A==
X-Google-Smtp-Source: AGHT+IEXB1fDoJFuaWUx9OITYWoCBrFWbXujcv6WFu/B3A5xhf4pR1Qfet08fnAJXPVhdR83Lh4+Vw==
X-Received: by 2002:a05:6512:318d:b0:50f:4ff:6cc5 with SMTP id i13-20020a056512318d00b0050f04ff6cc5mr3357903lfe.130.1706053946863;
        Tue, 23 Jan 2024 15:52:26 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id x30-20020a056512131e00b0050eebfbb4fdsm2419634lfu.20.2024.01.23.15.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 15:52:26 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cd1232a2c7so65917111fa.0;
        Tue, 23 Jan 2024 15:52:26 -0800 (PST)
X-Received: by 2002:a2e:878d:0:b0:2cd:fa80:1125 with SMTP id
 n13-20020a2e878d000000b002cdfa801125mr296417lji.100.1706053946262; Tue, 23
 Jan 2024 15:52:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123034908.25415-1-wqu@suse.com>
In-Reply-To: <20240123034908.25415-1-wqu@suse.com>
From: Neal Gompa <neal@gompa.dev>
Date: Tue, 23 Jan 2024 18:51:49 -0500
X-Gmail-Original-Message-ID: <CAEg-Je-0JN59m+Cjxf_oFjWn37JxyfVLeqy=wyjo5qyucsp8fQ@mail.gmail.com>
Message-ID: <CAEg-Je-0JN59m+Cjxf_oFjWn37JxyfVLeqy=wyjo5qyucsp8fQ@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs: verify the read behavior of compressed
 inline extent
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 10:49=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> There is a report about reading a zstd compressed inline file extent
> would lead to either a VM_BUG_ON() crash, or lead to incorrect file
> content.
>
> [CAUSE]
> The root cause is a incorrect memcpy_to_page() call, which uses
> incorrect page offset, and can lead to either the VM_BUG_ON() as we may
> write beyond the page boundary, or writes into the incorrect offset of
> the page.
>
> [TEST CASE]
> The test case would:
>
> - Mount with the specified compress algorithm
> - Create a 4K file
> - Verify the 4K file is all inlined and compressed
> - Verify the content of the initial write
> - Cycle mount to drop all the page cache
> - Verify the content of the file again
> - Unmount and fsck the fs
>
> This workload would be applied to all supported compression algorithms.
> And it can catch the problem correctly by triggering VM_BUG_ON(), as our
> workload would result decompressed extent size to be 4K, and would
> trigger the VM_BUG_ON() 100%.
> And with the revert or the new fix, the test case can pass safely.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/310     | 81 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/310.out |  2 ++
>  2 files changed, 83 insertions(+)
>  create mode 100755 tests/btrfs/310
>  create mode 100644 tests/btrfs/310.out
>
> diff --git a/tests/btrfs/310 b/tests/btrfs/310
> new file mode 100755
> index 00000000..b514a8bc
> --- /dev/null
> +++ b/tests/btrfs/310
> @@ -0,0 +1,81 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 310
> +#
> +# Make sure reading on an compressed inline extent is behaving correctly
> +#
> +. ./common/preamble
> +_begin_fstest auto quick compress
> +
> +# Import common functions.
> +# . ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch
> +
> +# This test require inlined compressed extents creation, and all the wri=
tes
> +# are designed for 4K sector size.
> +_require_btrfs_inline_extents_creation
> +_require_btrfs_support_sectorsize 4096
> +
> +_fixed_by_kernel_commit e01a83e12604 \
> +       "Revert \"btrfs: zstd: fix and simplify the inline extent decompr=
ession\""
> +
> +# The correct md5 for the correct 4K file filled with "0xcd"
> +md5sum_correct=3D"5fed275e7617a806f94c173746a2a723"
> +
> +workload()
> +{
> +       local algo=3D"$1"
> +
> +       echo "=3D=3D=3D Testing compression algorithm ${algo} =3D=3D=3D" =
>> $seqres.full
> +       _scratch_mkfs >> $seqres.full
> +       _scratch_mount -o compress=3D${algo}
> +
> +       _pwrite_byte 0xcd 0 4k "$SCRATCH_MNT/inline_file" > /dev/null
> +       result=3D$(_md5_checksum "$SCRATCH_MNT/inline_file")
> +       echo "after initial write, md5sum=3D${result}" >> $seqres.full
> +       if [ "$result" !=3D "$md5sum_correct" ]; then
> +               _fail "initial write results incorrect content for \"$alg=
o\""
> +       fi
> +       sync
> +
> +       $XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/inline_file | tail -n 1 =
> $tmp.fiemap
> +       cat $tmp.fiemap >> $seqres.full
> +       # Make sure we got an inlined compressed file extent.
> +       # 0x200 means inlined, 0x100 means not block aligned, 0x8 means e=
ncoded
> +       # (compressed in this case), and 0x1 means the last extent.
> +       if ! grep -q "0x309" $tmp.fiemap; then
> +               rm -f -- $tmp.fiemap
> +               _notrun "No compressed inline extent created, maybe subpa=
ge?"
> +       fi
> +       rm -f -- $tmp.fiemap
> +
> +       # Unmount to clear the page cache.
> +       _scratch_cycle_mount
> +
> +       # For v6.8-rc1 without the revert or the newer fix, this can
> +       # crash or lead to incorrect contents for zstd.
> +       result=3D$(_md5_checksum "$SCRATCH_MNT/inline_file")
> +       echo "after cycle mount, md5sum=3D${result}" >> $seqres.full
> +       if [ "$result" !=3D "$md5sum_correct" ]; then
> +               _fail "read for compressed inline extent failed for \"$al=
go\""
> +       fi
> +       _scratch_unmount
> +       _check_scratch_fs
> +}
> +
> +algo_list=3D($(_btrfs_compression_algos))
> +for algo in ${algo_list[@]}; do
> +       workload $algo
> +done
> +
> +echo "Silence is golden"
> +
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

This looks reasonable to me, but how is $_btrfs_compression_algos
defined? Does it include all the algorithm options supported in Btrfs?


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

