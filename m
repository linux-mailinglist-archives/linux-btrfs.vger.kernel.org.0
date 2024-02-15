Return-Path: <linux-btrfs+bounces-2428-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3311A85635C
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 13:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654F61C23219
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 12:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0D812CDB1;
	Thu, 15 Feb 2024 12:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fp6uR0k+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D530612E1D5;
	Thu, 15 Feb 2024 12:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708000693; cv=none; b=BFryn0WEoG5RRn5ocQ2So+Ih1PoL1A7bP8YmIF+EEMa26OOnsLD+cVJxmgUA/1BQbiJoMpX2N2I10rATmlFVS1iOzOFkKSjOHDmh6vpSiBKVAfijy0b0lXbh16dIxa3FD4mB5JQt0eH1fGBuIh2b6rt/hhgkKqC23wj2CHeZmDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708000693; c=relaxed/simple;
	bh=40gCfgfmhfXLzoCYPysdSxavHkn2U3BJps1u9cTy4Y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wo/jpfSC+ptu68CyVD6Y6cuaF3YDkBIeMInpWTnUispWS2Bdn8KaFvYpkfGas++tkZwFYJ17UAHEbyoB8lsSMG+ZhIBUr4IZWlM8FMvlzWGzl/q9EA8kpLAVPN70oYbovkcPmCG/ZqfqqP+qy1ZYb8wZvadCb/t4XxWFgTc5Uas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fp6uR0k+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CE6C43394;
	Thu, 15 Feb 2024 12:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708000693;
	bh=40gCfgfmhfXLzoCYPysdSxavHkn2U3BJps1u9cTy4Y4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fp6uR0k+8C42rH31QfOLQGndmOfhovbhdTEAQAa/qL0L8EqW98wCcOD3Q6TY4XYzp
	 rRG9ePS4WQ5pF7UOWfJc/1f72uTVowFfhBRaVSNPSWoUoXyd21kFaOoMhkgZdiaggB
	 kw/ck9FzsWr/vq8Jo0YTM0IB4/WmWElRziiInpAtIWOPcFM5pkmGoDY5d0QZ65PBDl
	 bG8kCDnqc2Z2DKP8x5PACqJZ/3e83VGjd7f+SLiH/zjuwMHfZALfSLy/NCzZk1B45R
	 ZtGznWdtdIQ8hHHiclIONbvypLsJBKgzPZ0DUp3+Ka/lacOd56i7dtYTbTuippp+Vd
	 ArGXSgh5+zN4A==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3d62da9d25so98964866b.3;
        Thu, 15 Feb 2024 04:38:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVLVEr1V8FfLDGoyH5xJ/K9AKggViYUmmyzmkcVTP92EXQcDc3vFSOa894S3oX+41KUr1jnDhZQica53R1amhShe96FMePh0/E5Nb8=
X-Gm-Message-State: AOJu0YwXB/li4PiQWZ5QAJwBe4PWkNL1SVpoewlMgXF62qMe8R1Rm8AZ
	sfRxRdzy8HUeD839X2LSsJq/chu/TZpisVtijFXDjh/riRrR8F1agIRasepIRlnmhDl17izfLTL
	3Edp47Ox3d7ry89NFmcrDLe8IVFY=
X-Google-Smtp-Source: AGHT+IE8F0sLNfU1U8lDWJTiY3N19FUUhOflSd56hnl+Bq+eDoGxo8mU/Ajns2HrayWY/W9I9G0+GOk8RGJqKA+TVkc=
X-Received: by 2002:a17:906:390a:b0:a3d:7e5b:bbef with SMTP id
 f10-20020a170906390a00b00a3d7e5bbbefmr1121905eje.5.1708000692087; Thu, 15 Feb
 2024 04:38:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707969354.git.anand.jain@oracle.com> <4d9c26252329f9cbbe48a77c58e8ff42d0b45275.1707969354.git.anand.jain@oracle.com>
In-Reply-To: <4d9c26252329f9cbbe48a77c58e8ff42d0b45275.1707969354.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 15 Feb 2024 12:37:35 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6h3177KhLckKrXPtExcpb05ZSwQ6Ud_SH2LMPdavpNgg@mail.gmail.com>
Message-ID: <CAL3q7H6h3177KhLckKrXPtExcpb05ZSwQ6Ud_SH2LMPdavpNgg@mail.gmail.com>
Subject: Re: [PATCH 08/12] btrfs: test case prerequisite _require_btrfs_mkfs_uuid_option
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 6:35=E2=80=AFAM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> For easier and more effective testing of btrfs tempfsid, newer versions
> of mkfs.btrfs contain options such as --device-uuid. Check if the
> currently running mkfs.btrfs contains this option.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  common/btrfs | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/common/btrfs b/common/btrfs
> index 61d5812d49d9..9a7fa2c71ec5 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -88,6 +88,22 @@ _require_btrfs_mkfs_feature()
>                 _notrun "Feature $feat not supported in the available ver=
sion of mkfs.btrfs"
>  }
>
> +_require_btrfs_mkfs_uuid_option()
> +{
> +       local cnt
> +       local feature
> +
> +       if [ -z $1 ]; then
> +               echo "Missing option name argument for _require_btrfs_mkf=
s_option"
> +               exit 1
> +       fi
> +       feature=3D$1
> +       cnt=3D$($MKFS_BTRFS_PROG --help 2>&1 |grep -E --count "\-\-uuid|\=
-\-device-uuid")

A space between | and grep would make things more readable and match
the general coding style.

> +       if [ $cnt !=3D 2 ]; then
> +               _notrun "Require $MKFS_BTRFS_PROG with --uuid and --devic=
e-uuid option"

option -> options.

Otherwise it looks fine, thanks.

> +       fi
> +}
> +
>  _require_btrfs_fs_feature()
>  {
>         if [ -z $1 ]; then
> --
> 2.39.3
>
>

