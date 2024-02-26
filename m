Return-Path: <linux-btrfs+bounces-2789-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D808673D3
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 12:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E301C265EA
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 11:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F65210E4;
	Mon, 26 Feb 2024 11:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOYOuxXs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9CB208B6;
	Mon, 26 Feb 2024 11:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948112; cv=none; b=Sga6DRNRJxWo1XudiDCasNmNjTpgwhqgmsdX56G/etglguttsC2cVmbnbbnjaLNuxHb8pW5K4Le4kVVL5oU34wUxQBzY6o4hvQ7zcxQtPQZgUu08Cnyw3abbxLFMtuxpg4DVDT3P3OcBwXjsPcFSz65YCjAaaj14j6ThjGU/OFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948112; c=relaxed/simple;
	bh=DumT/3FSK6hg+YznSrqRjCXQRN4miMUB+/Qo4pmg578=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQAs3M8XpksMGg4W4wUJ370GVQYkO8ju90LRzL1VaVfO5KmxLtPJpVhJbFOGIXWPA9FoQEgBisj9/750LmJaU8wHB+zoyGOMcvuBeSp/ZU2rHdcCHTXkasLxcGEP0fbmVaCU2NY57bJa+u+XBJA8A7xzZ2n38qojUi3EzOUtIOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOYOuxXs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC85DC43390;
	Mon, 26 Feb 2024 11:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708948111;
	bh=DumT/3FSK6hg+YznSrqRjCXQRN4miMUB+/Qo4pmg578=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oOYOuxXsDaa+83FQhJOJBlF3QlnE1BKlr5CQcf0ACI/XrGfuJWCamBf1bLp/eYc0H
	 YJHqQMKx2HJ+HjleQv0EapuFC6aq5ttTMqPhA+KFOVFbWklLGF8uPDLyxrg/hWRa9O
	 PIzpyXKc5IKWyOtz47EXIs4XCrPeoKe54FLlPBV91VXWWDJUcXm4KKi2AlY5p+0QOn
	 041ZZdBoWuz83PwwOjYRFnj6eUX3iz5Ar5cvs4rEP/hiXzf9+VWpflkavQunftER3A
	 8QisKZQ5oVwe0UBHHdgv4pTHumvJDmczijSD30U5RuJi/s51rkSTRdvGTD9JQJKhxI
	 LKYJNqHSf4z4A==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3f5808b0dfso403576766b.1;
        Mon, 26 Feb 2024 03:48:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXR4Gk5o6bLR6juvdoJRgtF/3C/ro04XMKcuLQRSTEDX60JTJuSpNWhkGpmYg7IA+dHG/7BMJOgPGx6eJa39Nqis8iWQfOyL2P+Ne0=
X-Gm-Message-State: AOJu0YxluCGlBZXk1I7JWoFTH8Vv9ry2CalWTxDq0BfE/c7RQAawbnmN
	hIAiSs4rBQ96krg6Cd/WkAnd5FAnJPTG0w60j4x9VsFyX108VI+LUmGJPRIkvrEY9CyWNqUCgYh
	DVGBICxh2rFy/K8kxO5lD9m7+zeM=
X-Google-Smtp-Source: AGHT+IESe8meCT15wU+pLRTAfrdQUDzIO8UeZt/XIbbC5myvw0o2foM4ANM0uXu4EIwETz3m6nRAztbMdikLP/QQwfU=
X-Received: by 2002:a17:906:f854:b0:a43:21fb:d0db with SMTP id
 ks20-20020a170906f85400b00a4321fbd0dbmr2458751ejb.10.1708948110069; Mon, 26
 Feb 2024 03:48:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708772619.git.anand.jain@oracle.com> <3fe54b69910e811ad63b2f0e37bd806e28752e8a.1708772619.git.anand.jain@oracle.com>
In-Reply-To: <3fe54b69910e811ad63b2f0e37bd806e28752e8a.1708772619.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 26 Feb 2024 11:47:53 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4EdcvJm4jAD+5-zm-WVAoaHhyy-9Q_1-P5pOWk_f6m=w@mail.gmail.com>
Message-ID: <CAL3q7H4EdcvJm4jAD+5-zm-WVAoaHhyy-9Q_1-P5pOWk_f6m=w@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] btrfs: create a helper function, check_fsid(),
 to verify the tempfsid
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 4:43=E2=80=AFPM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> check_fsid() provides a method to verify if the given device is mounted
> with the tempfsid in the kernel. Function sb() is an internal only
> function.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> ---
> v3:
>  add rb
>  add  _require_btrfs_command inspect-internal dump-super
> v2:
>  Fix typo in the commit log.
>  Fix array SCRATCH_DEV_POOL_SAVED handling.
>
>  common/btrfs | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/common/btrfs b/common/btrfs
> index e1b29c613767..406be9574e32 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -792,3 +792,40 @@ _has_btrfs_sysfs_feature_attr()
>
>         test -e /sys/fs/btrfs/features/$feature_attr
>  }
> +
> +# Print the fsid and metadata uuid replaced with constant strings FSID a=
nd
> +# METADATA_UUID. Compare temp_fsid with fsid and metadata_uuid, then ech=
o what
> +# it matches to or TEMP_FSID. This helps in comparing with the golden ou=
tput.
> +check_fsid()
> +{
> +       local dev1=3D$1
> +       local fsid
> +       local metadata_uuid
> +
> +       _require_btrfs_command inspect-internal dump-super

So, as pointed out in the previous version of the patchset, the
function should do the require for everything it needs that may not be
available.
It's doing for the inspect-internal command, but it's missing a:

_require_btrfs_sysfs_fsid

Instead this is being called for every test case that calls this new
helper function, when those requirements should be hidden from the
tests themselves.

Thanks.

> +
> +       # on disk fsid
> +       fsid=3D$($BTRFS_UTIL_PROG inspect-internal dump-super $dev1 | \
> +                               grep ^fsid | $AWK_PROG -d" " '{print $2}'=
)
> +       echo -e "On disk fsid:\t\t$fsid" | sed -e "s/$fsid/FSID/g"
> +
> +       # Print FSID even if it is not the same as metadata_uuid because =
it has
> +       # to match in the golden output.
> +       metadata_uuid=3D$(cat /sys/fs/btrfs/$fsid/metadata_uuid)
> +       echo -e "Metadata uuid:\t\tFSID"
> +
> +       # This returns the temp_fsid if set
> +       tempfsid=3D$(_btrfs_get_fsid $dev1)
> +       if [[ $tempfsid =3D=3D $fsid ]]; then
> +               echo -e "Temp fsid:\t\tFSID"
> +       elif [[ $tempfsid =3D=3D $metadata_uuid ]]; then
> +               # If we are here, it means there is a bug; let it not mat=
ch with
> +               # the golden output.
> +               echo -e "Temp fsid:\t\t$metadata_uuid"
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

