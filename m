Return-Path: <linux-btrfs+bounces-12909-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1654A82197
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 12:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D348A1709F1
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 10:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9C025D536;
	Wed,  9 Apr 2025 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azcBWgc1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9989F1D79BE;
	Wed,  9 Apr 2025 10:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744192867; cv=none; b=qAKFDULiObnunYlzaOfirkoCFsyWKHsf1BwaTw3KR8VtH0LIDNmebBaVIOcDeqC/Hl4MPBCaIvNFTPAOx+3/dRfGs9iSz7/U1UTEEcYJdhqnf/MeIbsMqBqusqbFu8UPJ8eY2uG7eHhRdQnawk9ug5tubiOxJS8H1Qvwidzt9pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744192867; c=relaxed/simple;
	bh=aaoSNuqVQs2wREEbSG0PEFNmz0B9YoRLzkQISElEe00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/1UZz8AdHNzED+0Q2O/ip4CocYDeCfKww8K5K7HV0HtcL6iEoTh2bmu9fSVmv1ENtG7XBMOm0qXQdmZobCWyxTmN+gnP44tRtPT6BrKONACPd/c46iCj6p48bmfqIuZPxIqVynmcnwj9WsroJpc59LdLTm0/kD+Gp5xaJHawaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azcBWgc1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11AE0C4CEE3;
	Wed,  9 Apr 2025 10:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744192867;
	bh=aaoSNuqVQs2wREEbSG0PEFNmz0B9YoRLzkQISElEe00=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=azcBWgc1dE/VMs7yH+MDdHJ6mOjwElzORaOR7Pco7L75Fwchen86RIr50Qwsofm04
	 ZAHVSjWZ4HSQR3dlHj9Ri0z9CjpG5MW09Ld8qEQtCMQMHCW1oyz++pOsw3SfWTnZWA
	 XI3QZNmD4Rv7U49mX894GTGEbF+q/LdPuH5MNZqae7zGqYAsmTsW49DTKbAGmR0HmF
	 3ZmLTBODEqrXMpJ5ZhuMhUC+sMIuHCkvs0WYK3e7PejwuSEpJhML4PlMH9qwD/Gu/j
	 8rwFJVRPLWgKbWpCCgYsuwIOPRXyMYAwUR1M12uXxcYiI0A+NKkeVVflnjFZIAuMbp
	 ROSbzKKUiTUcA==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac25520a289so1150695966b.3;
        Wed, 09 Apr 2025 03:01:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUKV2ZIDsNLrNFXyXadP9aMAahlwd5OP1WZhwpwCVEm6PKRq+WdwfXXZyqI8IXt5bypvUUfhfSXV71bLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBX85rdNQcyzM2VSl0mk8sKfhhU64+4tNOkvZqrC4MYDEHwgTf
	gY3wsNdxyPvbgvZIv2SFEAmBnYKQXxQaXL0D5MUFmiCClS2hzBwZd+EqCFlTs7X0PiHUNmA6DqH
	o1Nq/0KVb+W+6c4WWyc89oyAHFHs=
X-Google-Smtp-Source: AGHT+IH9pMfiS9RV/8UfF99mLuxU1yOHCshqaJnrrxhE8i6CJleH2faj16Fix1Z5kYPzqtluX8PqhMpLybfyeaD3+qk=
X-Received: by 2002:a17:907:6e8e:b0:ac7:1350:e878 with SMTP id
 a640c23a62f3a-aca9b73abadmr227606066b.46.1744192865598; Wed, 09 Apr 2025
 03:01:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cfb8c19533ac3c764edc1fe62b7fde75e76579a4.1743137470.git.anand.jain@oracle.com>
In-Reply-To: <cfb8c19533ac3c764edc1fe62b7fde75e76579a4.1743137470.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 9 Apr 2025 11:00:28 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7nx9D_CQhWXNGjBcZ6We+B3qmsGdpbG_p0qdCHM-dpfA@mail.gmail.com>
X-Gm-Features: ATxdqUHL2CR1zAVV2En8TQh4rlkhznSQ1bcNg9Mv5gxljs_HZhPx7ucbvxkGHjI
Message-ID: <CAL3q7H7nx9D_CQhWXNGjBcZ6We+B3qmsGdpbG_p0qdCHM-dpfA@mail.gmail.com>
Subject: Re: [PATCH v2] fstests: add btrfs standard configuration
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 4:52=E2=80=AFAM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> Here's a standard configuration for quick, regular checks, commonly used
> during development to verify Btrfs.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2:
> - Renamed config file to `configs/btrfs-devel.config`
> - global section renamed to `generic-config`
> - Section names now use hyphens
> - Added `RECREATE_TEST_DEV=3Dtrue`
> - Removed `MKFS_OPTIONS=3D"--nodiscard"` from `generic-config`
>
>  .gitignore                 |  2 ++
>  configs/btrfs-devel.config | 40 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
>  create mode 100644 configs/btrfs-devel.config
>
> diff --git a/.gitignore b/.gitignore
> index 4fd817243dca..9a9351644278 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -44,6 +44,8 @@ tags
>
>  # custom config files
>  /configs/*.config
> +# Do not ignore the btrfs devel config for testing
> +!/configs/btrfs-devel.config
>
>  # ltp/ binaries
>  /ltp/aio-stress
> diff --git a/configs/btrfs-devel.config b/configs/btrfs-devel.config
> new file mode 100644
> index 000000000000..3a07b731abd9
> --- /dev/null
> +++ b/configs/btrfs-devel.config
> @@ -0,0 +1,40 @@
> +# Modify as required
> +[generic-config]
> +TEST_DIR=3D/mnt/test
> +TEST_DEV=3D/dev/sda
> +SCRATCH_MNT=3D/mnt/scratch
> +SCRATCH_DEV_POOL=3D"/dev/sdb /dev/sdc /dev/sdd /dev/sde"
> +LOGWRITES_DEV=3D/dev/sdf
> +RECREATE_TEST_DEV=3Dtrue

All these mount paths and device paths are far from "standard" as the
changelog suggests.
It's certainly different for me.

Plus this isn't sufficient for some tests that need more devices in the poo=
l:

btrfs/292 needs 6
btrfs/294 needs 8

I'm also seeing RECREATE_TEST_DEV=3Dtrue for the first time. Why is this ne=
eded?

> +
> +[btrfs-compress]
> +MKFS_OPTIONS=3D"--nodiscard"
> +MOUNT_OPTIONS=3D"-o compress"
> +
> +[btrfs-holes-spacecache]
> +MKFS_OPTIONS=3D"--nodiscard -O ^no-holes,^free-space-tree"
> +MOUNT_OPTIONS=3D" "
> +
> +[btrfs-holes-spacecache-compress]
> +MKFS_OPTIONS=3D"--nodiscard -O ^no-holes,^free-space-tree"
> +MOUNT_OPTIONS=3D"-o compress"
> +
> +[btrfs-block-group-tree]
> +MKFS_OPTIONS=3D"--nodiscard -O block-group-tree"
> +MOUNT_OPTIONS=3D" "
> +
> +[btrfs-raid-stripe-tree]
> +MKFS_OPTIONS=3D"--nodiscard -O raid-stripe-tree"
> +MOUNT_OPTIONS=3D" "
> +
> +[btrfs-squota]
> +MKFS_OPTIONS=3D"--nodiscard -O squota"
> +MOUNT_OPTIONS=3D" "
> +
> +[btrfs-subpage-normal]
> +MKFS_OPTIONS=3D"--nodiscard --nodesize 4k --sectorsize 4k"
> +MOUNT_OPTIONS=3D" "
> +
> +[btrfs-subpage-compress]
> +MKFS_OPTIONS=3D"--nodiscard --nodesize 4k --sectorsize 4k"
> +MOUNT_OPTIONS=3D"-o compress"

Why the --nodiscard?
I don't use it in my setups, doing the discard doesn't cause any
significant slowdown for me using 100G devices with qmu (raw type and
with discard support), and it's good to the discard.

So I think this is far from standard as you claim in the changelog and
won't fit everybody. It certainly doesn't for me.

Thanks.

> --
> 2.47.0
>
>

