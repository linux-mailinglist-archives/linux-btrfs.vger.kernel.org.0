Return-Path: <linux-btrfs+bounces-2589-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC59685C0F6
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 17:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1F861C21C6D
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 16:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C00768F0;
	Tue, 20 Feb 2024 16:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHv3Hhb5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B9376056;
	Tue, 20 Feb 2024 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708445907; cv=none; b=Vb2VEiREM2p9JKhCRkp1Kyc7+KCVlcT1OJddJmP5JzJ+6So7NrlHhnxqB2PSlH1UFz49RkRhaLiOfdMID1EC1OD9+Jir3UJPaf7Z3KH1YwO2TF8KKAo32/SbPKGIm1fEqtSKHlk3McfmjnSps5xyB9eePlChTpc8WFQntWRuyIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708445907; c=relaxed/simple;
	bh=x4p9E4jPEmGxL2kLRMPSkWs0aphgvbe/YiEDX+S5PKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUcVeq+qPVplb9upIXl+moaUlHnpvi5Nw48uafw47UNs7QHlg5bNhoWR/QtsiBXTOBvS+tRwibvC59S2pvG46kD2rllq27yuBr6OoCx8shRME7BTRBHOQ/36trAnl/AqY+BWTXa8Js1/NhlIRYkeTnU+5GF3ahmo/B1TYaweFNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHv3Hhb5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B77EC433C7;
	Tue, 20 Feb 2024 16:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708445905;
	bh=x4p9E4jPEmGxL2kLRMPSkWs0aphgvbe/YiEDX+S5PKU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cHv3Hhb5PhxFk2TI8qmGhEEC2mr25RIXnizzujNcAqLB+OvHA8W6fR2c3ZsaX44K9
	 UVjHGzYyuZmdjois6Wo7oZJLOGc2/DMJN8Bu5/K2F0idKWjG3ntWQ/5ewB7xapjzdb
	 YTq2CgjDuMhXNQONyPFvDwSRxQ2rxNwzHAR8uD3IPK0HGEMPuoM9hLM8USk54U0GSx
	 6XsmwTFsk8CPuhAsPmk8OReBuM0bv8BCounEX3SEsm5ErhyYUS570QIXqlcQvXR43/
	 NIfjsxbSCOZT/1/IQPTRew+yyx00VoU44LKAyEOr9ZlPa3QxZ8g7vijU7ykJ/9zVY8
	 Vtxp4kwQyHVXA==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a28a6cef709so647599966b.1;
        Tue, 20 Feb 2024 08:18:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7j7t+U8fUp4rRIn2aoJZVV9ywT8OeOKgSI3KvIWfpTnn0pCyRPAAO9uZNmeq95M8z5vkpOQTaPz5lzihQJ9annGG1kGQAHlQ3OLE=
X-Gm-Message-State: AOJu0Yxd8DM5NpaMOr6A4kLLpljJGrZSyw5X7cjyIBj3XKevr0wJMxzN
	t3l4MBlrvKmQ+uoBlumzBSKqEJyx/fasbM23pnxGM7S6FfQ5VxtFYMtdfjKKw4zTZ/sMemULcwa
	N3MjeJN0dGobSZ/N+mmQibUB9+No=
X-Google-Smtp-Source: AGHT+IE11M9nAx8t9pbi+vcR+O95tIwuys/F9eNMwDIKPtygsUDFs0j5GqbCPq6dBrYr47IzgLUDbWG4DPCLsaHqWzk=
X-Received: by 2002:a17:906:3508:b0:a3f:1ce8:198a with SMTP id
 r8-20020a170906350800b00a3f1ce8198amr597701eja.35.1708445903880; Tue, 20 Feb
 2024 08:18:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708362842.git.anand.jain@oracle.com> <a234d5aa2612e0d28e3f9b4e6ced8e5a4dec98a7.1708362842.git.anand.jain@oracle.com>
In-Reply-To: <a234d5aa2612e0d28e3f9b4e6ced8e5a4dec98a7.1708362842.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 20 Feb 2024 16:17:46 +0000
X-Gmail-Original-Message-ID: <CAL3q7H656_AhD9eyuYhEkYm2pN1CdOAvpN-HQsrtOFb1_tO8Zw@mail.gmail.com>
Message-ID: <CAL3q7H656_AhD9eyuYhEkYm2pN1CdOAvpN-HQsrtOFb1_tO8Zw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] assign SCRATCH_DEV_POOL to an array
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, zlang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 7:49=E2=80=AFPM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> Many test cases use local variables to manage the names of each device in
> SCRATCH_DEV_POOL. Let _scratch_dev_pool_get set an array, SCRATCH_DEV_NAM=
E,
> for it.
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
> v2:
>  Fix typo in the commit log.
>  Fix array SCRATCH_DEV_POOL_SAVED handling.
>
>  common/rc | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/common/rc b/common/rc
> index 524ffa02aa6a..5d249af3df37 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -830,6 +830,8 @@ _spare_dev_put()
>  # required number of scratch devices by a-test-case excluding
>  # the replace-target and spare device. So this function will
>  # set SCRATCH_DEV_POOL to the specified number of devices.
> +# Also, this functions assigns array SCRATCH_DEV_NAME to the
> +# array SCRATCH_DEV_POOL.

I'm not a native English speaker, but when it's phrased like that it
gives the idea of:

SCRATCH_DEV_POOL =3D SCRATCH_DEV_NAME

Maybe a "Sets a SCRATCH_DEV_NAME array with the names of the devices."

But anyway:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

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
> +       if [[ -z "$SCRATCH_DEV_POOL_SAVED" || -z "${SCRATCH_DEV_NAME[@]}"=
 ]]; then
>                 _fail "Bug: str empty, must call _scratch_dev_pool_get be=
fore _scratch_dev_pool_put"
>         fi
>
> +       export SCRATCH_DEV_NAME=3D()
>         export SCRATCH_DEV_POOL=3D$SCRATCH_DEV_POOL_SAVED
>         export SCRATCH_DEV_POOL_SAVED=3D""
>  }
> --
> 2.39.3
>

