Return-Path: <linux-btrfs+bounces-2590-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2013E85C156
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 17:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D010A2865DD
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 16:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8BD76C67;
	Tue, 20 Feb 2024 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkFnSnpY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311B376408;
	Tue, 20 Feb 2024 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446319; cv=none; b=QBOGlFAhr8dDMd3VH8Z/FoQRZsdc71mXKMC04Glbg4HYm/WEOLf4iucBibsFmvbyYUFCKxLBLRzwI3KVApD/qm/Hee1HHEjWm6rdSgCcWd9t9JpcL7oprMnWI3S4hiaC0pn9lGu9BwLyLVyXOofpupRnDOrxGiJVyaLJLOgl87M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446319; c=relaxed/simple;
	bh=d6paxSigOAgG7rpDUwKe3qyUSatPIsXQrOZ5qv84rKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGh2mJmAeMWNa6qTivMd4aQBvQ9E2NuHy5MyCvqYeNzB+Mun6as4BavjXJn1D2Acs19BZY/165kcjdloWAuYR4/xF8TFZh3H5FGGdQKGM4pcquuwRxVAsCXtoRrzCKxvvYNTSRe+4JzvwaG2bI2haRel72Hp574jPv1U2EIlUh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkFnSnpY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8256C433F1;
	Tue, 20 Feb 2024 16:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708446318;
	bh=d6paxSigOAgG7rpDUwKe3qyUSatPIsXQrOZ5qv84rKM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HkFnSnpY/dG+zcb6t8knl1IlGsq6NS8/f9GKZRhmYEGzQ22aPvCXFqoFDx+CCaBYU
	 DsXqn0dC+gNaSl/1sfFtidUM5lIP/R5jTl6L9NPIJwsO3ylyTwDFylNBK6PDddMTwL
	 8L1Uk1Wx0jjUrnxUFjwe5P4ZjgPen6PwjvE/QibPLYZry7W1nES22CN2sqnuZT5l61
	 9iz8ezjo7co15w98fw/TGGqckQkWacsKQAvEExUin3JnZReQ6Y8++fo0QAFiImnNJW
	 ZaYh1fxhj1bcY/Yt1W1icZ7o/MjYyqU0zkplxNlsmS5L6gGa6VWBm3SB+tQXZQQ1Qp
	 kv3xlqnXbftKQ==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3e75e30d36so436569566b.1;
        Tue, 20 Feb 2024 08:25:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXPjApfZcGCtBJNXYy59juTa9uaADwfDjeXmPi9NnHPcQ4hIGZk/BTzIShyvWcKO9OiCx1PmqL1BqS8RQS77csYBfdMNdKIxV+0WpY=
X-Gm-Message-State: AOJu0YydHnbyhY0KozGq58jdZ/EcE534Lzv9ZggiYl5iqSKNQ4ocVCbG
	MpX/+ixUWndiOQVaB8ngme758gfbRB8q+2NuWGG73B55vaecWIWj80x8EVDXqbSG5hNF5X2PQdT
	9xHXNX6E2U0GV849FMzxvwXxxcOg=
X-Google-Smtp-Source: AGHT+IGXRcujG/ZYMowJbfz4kVBes22sezkoPmZGX9ufFdiZN5Mv6p//zTNYTucnCljwa5fEI5+ZJXeaOs4otpEXOkc=
X-Received: by 2002:a17:907:7208:b0:a3f:365:2276 with SMTP id
 dr8-20020a170907720800b00a3f03652276mr2112755ejc.34.1708446317048; Tue, 20
 Feb 2024 08:25:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708362842.git.anand.jain@oracle.com> <265a0f1115d7f421aed9c87d52b07e3c9627f2c0.1708362842.git.anand.jain@oracle.com>
In-Reply-To: <265a0f1115d7f421aed9c87d52b07e3c9627f2c0.1708362842.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 20 Feb 2024 16:24:39 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5iPYitfJt768pC0FwcUb896AZFdayv8FB6rcaLGGoTPA@mail.gmail.com>
Message-ID: <CAL3q7H5iPYitfJt768pC0FwcUb896AZFdayv8FB6rcaLGGoTPA@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] btrfs: create a helper function, check_fsid(),
 to verify the tempfsid
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, zlang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 7:49=E2=80=AFPM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> check_fsid() provides a method to verify if the given device is mounted
> with the tempfsid in the kernel. Function sb() is an internal only
> function.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
> v2:
> Drop the function sb()
> Use $AWK_PROG  instead of awk.
> egrep -> grep -E
>
>  common/btrfs | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/common/btrfs b/common/btrfs
> index e1b29c613767..797f6a794dfc 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -792,3 +792,38 @@ _has_btrfs_sysfs_feature_attr()
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

