Return-Path: <linux-btrfs+bounces-2424-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4978562D5
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 13:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC361F21769
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 12:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C27012C7ED;
	Thu, 15 Feb 2024 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgOMV/Bm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C0512AAE4;
	Thu, 15 Feb 2024 12:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707999231; cv=none; b=oe/JJV/xfROgzA0U4XHcGO9oZFwp+rSSraNJK1JaErYq1Mn3/aRha9zKINiAUPW0Vdfw+gcNTvH2EV3AW31/dB4RJI9bmmvm3z/I8k4ghEb9nJRzH/HaBHdgM4a+DejFvSJt/nzrCzGD+DZdRhW1LR3C2qUcGfSF8YmhtvOuucs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707999231; c=relaxed/simple;
	bh=+iQdl/CjMrsDc5ZyN4diEbw6PxNNUCwtTXlb2r1tpws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zzl8+FEkg8Jslc//oEkKssLsC7tSOd/pgCTwoJT79/MrYpTUCcW/RFt+yCGoWm7YzVodSw8C/UMMdMlDuo/le08qs4S/CFA0Fr//u9zhyjG5//H0pouGFVK/ek1kRpPxO7xgQgGfGaiURp/wevr3NTeBRumBleanmISPrV+tRn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgOMV/Bm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C126C43394;
	Thu, 15 Feb 2024 12:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707999231;
	bh=+iQdl/CjMrsDc5ZyN4diEbw6PxNNUCwtTXlb2r1tpws=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jgOMV/Bmr+A+NjI1YD2ZAQ774jFXoC6n4G4Ddv1e0dNpQgspAyCwEgMmJl72nXf1l
	 AHZv8asGAl8sNQiRtvpvppu3O7kVdiYY9VtSKsbqJEMoQyF4OtQ+8KiJoWZNvvhURB
	 8xPJtDQAo/qi7fBuBh4BlDKfpnBqOK2ok/jQoApnO+ItqDWnyES7+uVgzCr3+yWGBY
	 TWPqcU/oHpQsglgqsHPK5AsdL/j5rF5abz+zJrdCDAeaz7YSCp++1WoMlwjHHL0I1g
	 P2bprdGUCMr2tDzUDnZBlU+fDx2mpTrZb4guro3UhD55kAH8leejAHd5yN/dkdhUX1
	 7rQK7dSamyNng==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a34c5ca2537so91269966b.0;
        Thu, 15 Feb 2024 04:13:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVp+O44yinjZ+wW5x+xBJSlNRvXVny8tI8ACJ85gBvtGDCLaQRHdYk83O2Fq9ILPn9HVmet6r3mjBeANY1bITU3ZNe3qNbwTyCAgyA=
X-Gm-Message-State: AOJu0YwRF/BsF/BOQXMBXf01va0lc9ZUIfy6rYLRwXcgPTYZ1HbAKWB/
	H4IKYLVwJ5/LUl1kMCySWa5v9c83qWyNsDVyH08kQ5BQdUk/EULxIrq+fvtYLfAdjIDCQYPi/ou
	uICAbcK2OZkNzfx34Kc9YOaYNN4s=
X-Google-Smtp-Source: AGHT+IEDOqOIN+2XinL8JHgecbJX/rJI4xbPtRRcxoY1Sg6AgwjyQgoHH5n1qZ/9s0mnvfV7BlAX7LEBeuOVN1e/CMI=
X-Received: by 2002:a17:906:cc9b:b0:a3d:14ce:5b84 with SMTP id
 oq27-20020a170906cc9b00b00a3d14ce5b84mr1092496ejb.7.1707999229515; Thu, 15
 Feb 2024 04:13:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707969354.git.anand.jain@oracle.com> <cd8342fb284a1983d7645698464debecf417e52a.1707969354.git.anand.jain@oracle.com>
In-Reply-To: <cd8342fb284a1983d7645698464debecf417e52a.1707969354.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 15 Feb 2024 12:13:12 +0000
X-Gmail-Original-Message-ID: <CAL3q7H72+YEPoo4c1LDj8j2YpPQoui74OwXKyKxH2ckeiD9pMQ@mail.gmail.com>
Message-ID: <CAL3q7H72+YEPoo4c1LDj8j2YpPQoui74OwXKyKxH2ckeiD9pMQ@mail.gmail.com>
Subject: Re: [PATCH 04/12] btrfs: create a helper function, check_fsid(), to
 verify the tempfsid
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 6:35=E2=80=AFAM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> check_fsid() provides a method to verify if the given device is mounted
> with the tempfsid in the kernel. Function sb() is an internal only
> function.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  common/btrfs | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/common/btrfs b/common/btrfs
> index e1b29c613767..5cba9b16b4de 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -792,3 +792,37 @@ _has_btrfs_sysfs_feature_attr()
>
>         test -e /sys/fs/btrfs/features/$feature_attr
>  }
> +
> +# Dump key members of the on-disk super-block from the given disk; helps=
 debug
> +sb()
> +{
> +       local dev1=3D$1
> +       local parameters=3D"device|devid|^metadata_uuid|^fsid|^incom|^gen=
eration|\
> +               ^flags| \|$| \)$|compat_flags|compat_ro_flags|dev_item.uu=
id"
> +
> +       $BTRFS_UTIL_PROG inspect-internal dump-super $dev1 | egrep "$para=
meters"
> +}

Don't add such a short function name that doesn't minimally indicate
what it does.... especially taking into account that it's polluting
the global namespace and isn't used anywhere else.
So this code should be in the function below, as it's only used once....

> +
> +check_fsid()
> +{
> +       local dev1=3D$1
> +       local fsid
> +
> +       # on disk fsid
> +       fsid=3D$(sb $dev1 | grep ^fsid | awk -d" " '{print $2}')

Please use $AWK_PROG instead.

Again this sb() function is pointless, even because here we only care
about the fsid line, yet the function is extracting a lot of other
lines without any users.

> +       echo -e "On disk fsid:\t\t$fsid" | sed -e "s/$fsid/FSID/g"
> +
> +       echo -e -n "Metadata uuid:\t\t"
> +       cat /sys/fs/btrfs/$fsid/metadata_uuid | sed -e "s/$fsid/FSID/g"

Ok, so why do we care about printing the fsid and metadata uuid lines
if we always replace the IDs with the constant FSID?
It seems pointless to print them... At the very least this deserves a
comment, a rationale on what this accomplishes.

Thanks.

> +
> +       # This returns the temp_fsid if set
> +       tempfsid=3D$(_btrfs_get_fsid $dev1)
> +       if [[ $tempfsid =3D=3D $fsid ]]; then
> +               echo -e "Temp fsid:\t\tFSID"
> +       else
> +               echo -e "Temp fsid:\t\tTEMPFSID"
> +       fi
> +
> +       echo -e -n "Tempfsid status:\t"
> +       cat /sys/fs/btrfs/$tempfsid/temp_fsid
> +}
> --
> 2.39.3
>
>

