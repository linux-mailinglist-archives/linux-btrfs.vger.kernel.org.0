Return-Path: <linux-btrfs+bounces-2429-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FFF85637C
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 13:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C65281E26
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 12:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559C512D760;
	Thu, 15 Feb 2024 12:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+GYnQ0N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D76112AACB;
	Thu, 15 Feb 2024 12:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708000985; cv=none; b=PEk5CcCYEPW0sFvCrfxuGTjDTt472xr8RShN6DP9MCrvhCsVJFA1+PjQq/T/KbIfSqMQRR+GSYproorF6utQFxod/wuu5WNsujyS0Q1H+GzaBu97ZesHifcsEMu2M+Kazx+UMyV3FZKDT7AtQ9ab074CRHcifmn83lmho7dCzio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708000985; c=relaxed/simple;
	bh=ps+ZcK7gppnmjfwRDAbo5hk1FLokld+EBMtARa+in0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hG0n3sZrs0xWsKpVBOV6FkH1EAMK1mbJYqoKJWc1xIeya5nmbGRasHrxvJPAkXkrvIqyO7ZO9Oiy15TNDXw7+RjIqrrtHX9ZAWPmeU9dDp9ZAdjHdMUsdduLVXp/Z4JRZlp/h2JzB3Cl3Y4ZnvKXzJFZcWAJ3Gqyvvcj1FJpNgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+GYnQ0N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6818C433C7;
	Thu, 15 Feb 2024 12:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708000984;
	bh=ps+ZcK7gppnmjfwRDAbo5hk1FLokld+EBMtARa+in0s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a+GYnQ0NX3BQZahSt4cq0HBRNuvRiDNB57ZPcgO+2qHI+NA5f5Z5s9EfG/jrh09lo
	 dPZQL0KtmilgmuTgCWhwV9M9DsUQJgF+s5oIrEH4has/ec5h/PWUtjgNOY3Gi74Gkl
	 alaI+sr9PvTVxdnyABft+veDJJI2QXgtt0CizSPtaOccxWC2pXgAQkeh7ZZX9+mm9T
	 vlm9prQBpoqrcms4xymVeZuxjWTcq/wH+JA44XEZtRuZmwBLHkUt4PxBMfuYUDhib6
	 A2ZoOGhCxjQdmQhaATZC6BjnwI7gEDQi6jVaRKOkvvI5y/8EF7v4DJa2WiZ5E6qypl
	 DJRR74XHxeoaA==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3c1a6c10bbso93407966b.3;
        Thu, 15 Feb 2024 04:43:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVB7ZNZq5PsdhMkvk14Bhgx/YDrNUdSNF9oE2c8d2aWz2F1QSYL4pD3ufREIiaC1h8u6w3VgvXB8sHDEFg9Hii6tfyIP/d1yfKX+zA=
X-Gm-Message-State: AOJu0YxYyqOCK9XXgEZ8aNsBuCWHEOB1ueaWJcuosAERu8Bh4chxHesY
	zRzjsTPXNFcWstCLrqx13VPo//iEHouaYUa8kMoxsCpy3nTHHSKvgS1/dSkQdIZXDeTyH5atFmg
	r0vyKHVMDX3ZGvDbyHA0zhehavvg=
X-Google-Smtp-Source: AGHT+IGMnj43EhZkgQn8oF/Jl2OXw9JHcJoW+lm0ureAIn/ai/naMHhyTgJXqdqN1yE3tsJv5ZnTR8DBuzUH7N+Yv2k=
X-Received: by 2002:a17:906:b0ca:b0:a3d:482e:9725 with SMTP id
 bk10-20020a170906b0ca00b00a3d482e9725mr1552597ejb.0.1708000983405; Thu, 15
 Feb 2024 04:43:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707969354.git.anand.jain@oracle.com> <b6026821942d5898dfc5f60d7a7c2b19574f764f.1707969354.git.anand.jain@oracle.com>
In-Reply-To: <b6026821942d5898dfc5f60d7a7c2b19574f764f.1707969354.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 15 Feb 2024 12:42:26 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5fp8=SBeAbkmaJahTYCZQ5LQtbkcXR_2d1tXmhJ_Q87A@mail.gmail.com>
Message-ID: <CAL3q7H5fp8=SBeAbkmaJahTYCZQ5LQtbkcXR_2d1tXmhJ_Q87A@mail.gmail.com>
Subject: Re: [PATCH 09/12] btrfs: introduce helper for creating cloned devices
 with mkfs
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 6:37=E2=80=AFAM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> Use newer mkfs.btrfs option to generate two cloned devices,
> used in test cases.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  common/btrfs | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/common/btrfs b/common/btrfs
> index 9a7fa2c71ec5..8ffce3c39695 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -91,13 +91,7 @@ _require_btrfs_mkfs_feature()
>  _require_btrfs_mkfs_uuid_option()
>  {
>         local cnt
> -       local feature
>
> -       if [ -z $1 ]; then
> -               echo "Missing option name argument for _require_btrfs_mkf=
s_option"
> -               exit 1
> -       fi
> -       feature=3D$1

This is confusing... It was just introduced in the previous patch that
introduced this function (_require_btrfs_mkfs_uuid_option).

If there was never any need for this code, why was it added in the
previous patch and removed in this one, without any users in between?

>         cnt=3D$($MKFS_BTRFS_PROG --help 2>&1 |grep -E --count "\-\-uuid|\=
-\-device-uuid")
>         if [ $cnt !=3D 2 ]; then
>                 _notrun "Require $MKFS_BTRFS_PROG with --uuid and --devic=
e-uuid option"
> @@ -864,3 +858,21 @@ create_cloned_devices()
>                                                         _fail "dd failed:=
 $?"
>         echo done
>  }
> +
> +mkfs_clone()
> +{
> +       local dev1=3D$1
> +       local dev2=3D$2
> +
> +       [[ -z $dev1 || -z $dev2 ]] && \
> +               _fail "BUGGY code, mkfs_clone needs arg1 arg2"

Rather more clear and informative to say "mkfs_clone requires two
devices as arguments".

> +
> +       _mkfs_dev -fq $dev1
> +
> +       fsid=3D$($BTRFS_UTIL_PROG inspect-internal dump-super $dev1 | \
> +                                       grep -E ^fsid | $AWK_PROG '{print=
 $2}')
> +       uuid=3D$($BTRFS_UTIL_PROG inspect-internal dump-super $dev1 | \
> +                               grep -E ^dev_item.uuid | $AWK_PROG '{prin=
t $2}')

Make the variables local please.

Thanks.

> +
> +       _mkfs_dev -fq --uuid $fsid --device-uuid $uuid $dev2
> +}
> --
> 2.39.3
>
>

