Return-Path: <linux-btrfs+bounces-2594-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B7685C1BA
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 17:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E5E2865AC
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 16:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602C176C64;
	Tue, 20 Feb 2024 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbveLrpW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7E276906;
	Tue, 20 Feb 2024 16:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708447938; cv=none; b=RURuzbpXW8MiMFKO/H3NLxcYds0x1og7P32p8/V1UgjazQdC0jwOzt65pKsgPWotUd4BTaKmY0ZqWzm9GRg68eTINBKc5iQVX1QYmUSHNFwdbHdDP9BWyTyrXb3UXky5Ig0GPLy+Fc773hW9bnL+0ldtsQXbwaRZJxSmKNYO6hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708447938; c=relaxed/simple;
	bh=S1k5Gi5WanCicLlscbeyd/ONTVOsfc53kDFetKQGnQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGMn2+0v78sxz4JxofWjt54fUKpoFMnEF2WvS57UKF1JjffSd5C6AnLHSiN7cexBQp4QjZpqIAf1tlNR4T6EaDCHsKBOsxD6GTX1K73xuxvEXDJHUilslHgt/FEVygDovQZBGFuMEJbsmaBK3+NzG6V0mPEhPAwRTIK6W2ve3RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbveLrpW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20439C433C7;
	Tue, 20 Feb 2024 16:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708447938;
	bh=S1k5Gi5WanCicLlscbeyd/ONTVOsfc53kDFetKQGnQo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VbveLrpWqQMsLy0KWLmrwdRwqJucWR8EGCW2/irOSvx64Jqf8BubIwYMinZCGoKlY
	 kOQfjnpOk0X1rnON+LvsYqciI1NyYbFqClgKxgE623uk6Gs/KrKenOm2muT7d2vREz
	 JXDiqszgcYXPC94Fsmp1uhUnQ0UxIhhTxq6vBHiGHQqR1hn0dYVHG79oASnQ1jXfwm
	 AVTcdeC12wPuVnfLbThuL9lFmYwRkFnFIBMZJyPz9Y+08xh29GPrCAU5XP/+W2wpQF
	 mWV01xfiLB+9HlM2TmBJ53mWmIAyFd2aMW+vOAqDAY+5cGabLqV/tfBUJ2ZjP/Oqmm
	 b31hmY6+ra1tg==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3e75e30d36so443114166b.1;
        Tue, 20 Feb 2024 08:52:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX6ABiepNYII7F9krFuvplgOF73+LrzCLDcFs5oaRbNuxzo/eWn/+ckMNAQJym1U1i0ZhcqEuI3eToYOJQUw9dhcvpAlgZSUvjwXfU=
X-Gm-Message-State: AOJu0YwG9Llmih2ghLqjzB794dxSawzPT49/CH9CXf8cz7S0XPPEHzVM
	enj/GEZeJNyeemhlN7GuuvZPvQlO9kvP/UxBZCJdF5GII3FsdupFkjuKVggWn5Z8dIbawO1jdxf
	inNyTGt/VZB7b73nxSBOZZFEYM1s=
X-Google-Smtp-Source: AGHT+IF7MuV2DwXC7fw61KuTgK9gY34OOPV8yjVu5ht2NuHyq8h9pGgYpDWEa2gkzUaBBGwLmlw/azJIXWkvtkYRmIo=
X-Received: by 2002:a17:906:c297:b0:a3e:8b8e:8795 with SMTP id
 r23-20020a170906c29700b00a3e8b8e8795mr6343061ejz.34.1708447936522; Tue, 20
 Feb 2024 08:52:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708362842.git.anand.jain@oracle.com> <3b00cd9a28c6728ca2bf9c216fe67bf9c01cfc83.1708362842.git.anand.jain@oracle.com>
In-Reply-To: <3b00cd9a28c6728ca2bf9c216fe67bf9c01cfc83.1708362842.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 20 Feb 2024 16:51:39 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4xx6Jnee2vnLqdKhiJier2EfcuidA2q9QhyTYPB2LAsw@mail.gmail.com>
Message-ID: <CAL3q7H4xx6Jnee2vnLqdKhiJier2EfcuidA2q9QhyTYPB2LAsw@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] btrfs: introduce helper for creating cloned
 devices with mkfs
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, zlang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 7:49=E2=80=AFPM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> Use newer mkfs.btrfs option to generate two cloned devices,
> used in test cases.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2:
>  Organize changes to its right patch.
>  Fix _fail erorr message.
>  Declare local variables for fsid and uuid.
>
>  common/btrfs | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/common/btrfs b/common/btrfs
> index f694afac3d13..c3e5827562d6 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -838,3 +838,24 @@ check_fsid()
>         echo -e -n "Tempfsid status:\t"
>         cat /sys/fs/btrfs/$tempfsid/temp_fsid
>  }
> +
> +mkfs_clone()
> +{
> +       local fsid
> +       local uuid
> +       local dev1=3D$1
> +       local dev2=3D$2
> +
> +       [[ -z $dev1 || -z $dev2 ]] && \
> +               _fail "mkfs_clone requires two devices as arguments"
> +
> +       _mkfs_dev -fq $dev1
> +
> +       fsid=3D$($BTRFS_UTIL_PROG inspect-internal dump-super $dev1 | \
> +                                       grep -E ^fsid | $AWK_PROG '{print=
 $2}')
> +       uuid=3D$($BTRFS_UTIL_PROG inspect-internal dump-super $dev1 | \
> +                               grep -E ^dev_item.uuid | $AWK_PROG '{prin=
t $2}')
> +
> +       _mkfs_dev -fq --uuid $fsid --device-uuid $uuid $dev2

So this function should call:

_require_btrfs_command inspect-internal dump-super
_require_btrfs_mkfs_uuid_option

Instead of having all the test cases that use it to do those calls, as
mentioned in a previous patch.

> +}
> +>>>>>>> e22bb3c816c1 (btrfs: introduce helper for creating cloned device=
s with mkfs)

This isn't supposed to be here...

Thanks.

> --
> 2.39.3
>

