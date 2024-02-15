Return-Path: <linux-btrfs+bounces-2422-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED81685624A
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 12:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A852C2882AD
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 11:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C15F12D755;
	Thu, 15 Feb 2024 11:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJKVAdM4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED3612CD8F;
	Thu, 15 Feb 2024 11:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707998160; cv=none; b=PKhV3iNCV9cC2N6hSGYCOViniMW1U7uWkLOARRozjGdkjVoIxSnBqmY9FIZVYP+FVHUvB9R8V/Pzh6oAA3VztXLuuBh/eu+lvF4dG2z7aFPDF+eKnh8xYqsNSBxcuDilJWF5BwOVmgcDrRUpAIu2/2zShOajnWThrVzoQn1hW8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707998160; c=relaxed/simple;
	bh=f9zfpmaVTJb1BUrp1MS2qxmQK0p69U+fbg+EWDYYqQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rrs8y8E1b8aq9reFI2hi2AbMIrg8SnPhiMc27fJlP9axo97TtkPUpy9qzK51dBQydhdG7wXYmpBmqDLJBL6dOOE3Fx88eS4j9/9CzQcMsmSAM/ITKGQDNVW7PGybAJ24EiHlYgiqfi2Cb+VBx3DvvJEKTYR20shCxqQI34WVG50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJKVAdM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7159BC433A6;
	Thu, 15 Feb 2024 11:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707998159;
	bh=f9zfpmaVTJb1BUrp1MS2qxmQK0p69U+fbg+EWDYYqQE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LJKVAdM4BXsnzIqxKurKs2IFIdx/r1F4LaCF1XXjJp8el5W7jEnq+wq2gXLtukB+r
	 tU/iDlnKGRiQh8u6wVoqqzp/dlqwjcGtupz87KudnOD85OxybnIi+4tq37eJ38usWU
	 UrZDiSznHVFZ42MRQSrfGhLfz9QLwgfK984LCZ99dZCtGJWlWS975XAMvQcPDHgGxq
	 f52WvV6nfvcu6eIlOsYK6R73akvR26UOXBVv7ShE7UGB/Q/bzuxRVuvLZ6yzzNYNOv
	 JIrm2G6sPYwndSTacfwNqd9dvmgRM2zJ4QQ5AGwSF7u2tQ+IcJAoFXhNkCD0di5URh
	 X1Gi13TwXTV5A==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5638aa9a5c2so1117810a12.3;
        Thu, 15 Feb 2024 03:55:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWyorTWtFwag9rZwsgO77f61cjSgkQXeYbjIXrZQCxgumBKbnbdU8mAWttrQ+E7ZWcikn7trNitMNm42FksMWWdL/+Y6ULdCJWa420=
X-Gm-Message-State: AOJu0YzlA7g3HEcbPcR9xYIMbRKgiMU9pEabj7u/DQUeV6VNG7iV99pM
	3wLGbSiyRK6V6djn/R+sKWP9079um88/TFVKZCOyQ1KcQqIsJdlBIVhwWhxPYa7ecG8t3c+cHTM
	I41EeIC7LAriuGk3hXEj2cGI7klQ=
X-Google-Smtp-Source: AGHT+IGm7sHHNDplO93DZv4X2GmL0MkacuPDWu3gaVOiwjKUBMLP2UtweInf3qFhDMziEkzThHYUkwcP6tDH9mLRtdA=
X-Received: by 2002:a17:906:7fd5:b0:a3d:b100:cdc1 with SMTP id
 r21-20020a1709067fd500b00a3db100cdc1mr182830ejs.57.1707998157660; Thu, 15 Feb
 2024 03:55:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707969354.git.anand.jain@oracle.com> <366147ad0c29a6e4d4e0faa60231e66b81c7d678.1707969354.git.anand.jain@oracle.com>
In-Reply-To: <366147ad0c29a6e4d4e0faa60231e66b81c7d678.1707969354.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 15 Feb 2024 11:55:20 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6iCvMTu65Ngb3c+fNWMYoRVZRTqRcXJ4s0rM0HS66M1w@mail.gmail.com>
Message-ID: <CAL3q7H6iCvMTu65Ngb3c+fNWMYoRVZRTqRcXJ4s0rM0HS66M1w@mail.gmail.com>
Subject: Re: [PATCH 02/12] assign SCRATCH_DEV_POOL to an array
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 6:34=E2=80=AFAM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> Many test cases uses local variable to manage the names of each devices i=
n

uses -> use
variable -> variables
devices -> device

> SCRATCH_DEV_POOL. Let _scratch_dev_pool_get set an array for it.
>
> Usage:
>
>         _scratch_dev_pool_get <n>
>
>         # device names are in the array SCRATCH_DEV_NAME.
>         ${SCRATCH_DEV_NAME[0]} ${SCRATCH_DEV_NAME[1]} ...
>
>         _scratch_dev_pool_put
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  common/rc | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/common/rc b/common/rc
> index 524ffa02aa6a..5e4afb2cd484 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -830,6 +830,8 @@ _spare_dev_put()
>  # required number of scratch devices by a-test-case excluding
>  # the replace-target and spare device. So this function will
>  # set SCRATCH_DEV_POOL to the specified number of devices.
> +# Also, this functions assigns array SCRATCH_DEV_NAME to the
> +# array SCRATCH_DEV_POOL.
>  #
>  # Usage:
>  #  _scratch_dev_pool_get() <ndevs>
> @@ -860,19 +862,28 @@ _scratch_dev_pool_get()
>         export SCRATCH_DEV_POOL_SAVED
>         SCRATCH_DEV_POOL=3D${devs[@]:0:$test_ndevs}
>         export SCRATCH_DEV_POOL
> +       SCRATCH_DEV_NAME=3D( $SCRATCH_DEV_POOL )
> +       export SCRATCH_DEV_NAME
>  }
>
>  _scratch_dev_pool_put()
>  {
> +       local ret1
> +       local ret2
> +
>         typeset -p SCRATCH_DEV_POOL_SAVED >/dev/null 2>&1
> -       if [ $? -ne 0 ]; then
> +       ret1=3D$?
> +       typeset -p SCRATCH_DEV_NAME >/dev/null 2>&1
> +       ret2=3D$?
> +       if [[ $ret1 -ne 0 || $ret2 -ne 0 ]]; then
>                 _fail "Bug: unset val, must call _scratch_dev_pool_get be=
fore _scratch_dev_pool_put"
>         fi
>
> -       if [ -z "$SCRATCH_DEV_POOL_SAVED" ]; then
> +       if [[ -z "$SCRATCH_DEV_POOL_SAVED" || -z SCRATCH_DEV_NAME ]]; the=
n

missing dollar before SCRATCH_DEV_NAME... and should all be inside
double quotes, as -z is meant to test strings.
And as it's supposed to be an array, test it like:

-z "${SCRATCH_DEV_NAME[@]}"

>                 _fail "Bug: str empty, must call _scratch_dev_pool_get be=
fore _scratch_dev_pool_put"
>         fi
>
> +       export SCRATCH_DEV_NAME=3D""

Would rather assign an empty array (), as the variable is set to an
array in the get function.

Thanks.

>         export SCRATCH_DEV_POOL=3D$SCRATCH_DEV_POOL_SAVED
>         export SCRATCH_DEV_POOL_SAVED=3D""
>  }
> --
> 2.39.3
>
>

