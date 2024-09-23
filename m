Return-Path: <linux-btrfs+bounces-8165-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF5097EAB5
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 13:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA1B280E49
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 11:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8D8198851;
	Mon, 23 Sep 2024 11:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPYILdR5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F077B944E;
	Mon, 23 Sep 2024 11:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727091000; cv=none; b=YBMJpT01FKxfEKvm5ZnqnahuP5aqsjwCY2az7AhvyEe2IKBtea+DM4gXuxTPhtfozF3cetHDKMRWcqR6wuGK6cJ48DBpT1oABJhQAom/kDpVEvHyGtUZMFdX4GxB4Nhn9BB4Eor+XwssAYls87A7xMXcTVBjVaJtydjuwohH9Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727091000; c=relaxed/simple;
	bh=+2zRyFXBiUEtBo6l6Y7PHtroq6VacM4aFb/HGecXMd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rk7JaSShVTfqhrwdxv8KN+VpOCrVs77BtuoyPDH1/gU+/Fk+dyISfBqqyniY4Mv+nvTHiBi9+tyMkmXSxVWR8/2YTu/Yy4VDQerrlwAhAPs+lqYPWE8unwdt7TmHehZQXo0TP7qjgpnSp17/eKo1Rd5soR7xMn+pwv1hubANSZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPYILdR5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D131C4CEC4;
	Mon, 23 Sep 2024 11:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727090999;
	bh=+2zRyFXBiUEtBo6l6Y7PHtroq6VacM4aFb/HGecXMd4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PPYILdR5rUcKyqCv2y80S0t4VcCAzapno5l3PmibonN5YJKnQiHDAQoE7Xu6pzH3J
	 huNxRwth/xhyppAcoUr+R5ViBIOOsQJ1RPv7cIOBdqPtdQoxp+eZgDjonBct7maq2w
	 iY45mP+nW6wQUPxujdY5pl6sHW7c3WZcVHFJfjYc2CTCWJy66AgFfAN29+Sy8L0bRE
	 hkJvvS/ifoUmfeVLS0mbs87UM3vRvMvJtz8F/TnGinm415w5794lSebogoCvFZG8bz
	 fc3sribh4ftKglLrK7ixSuxkRgE4PJ62YdUeAnjjmqrgK0tWZcLT/cK557aOfqerik
	 S6Ehouwdx695w==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c275491c61so5695411a12.0;
        Mon, 23 Sep 2024 04:29:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9MxGSl7Py6V04JdLAnLNRe/8SvAx6t3shp6x8y7Omkx/8gfb9C7d0gubEfYMHdsq3nsF5vSr3TO9+dA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtzqQq8/ZrrchVn5QuKwXMDlRd47XS6Hu2bOUlQwoSS4RFM81Y
	vlatcunei6jKdHq9jAC669SryVF0iETgrnqE0aVlgh0yDI1PhbMul5I2S1B4053Eqv+ZtLSTBqL
	K8V3R8Bayfbx6SHMcCYAkgJHBD2U=
X-Google-Smtp-Source: AGHT+IG2ZssLqLg6yjqoSIhM616XwIiG/d6LLcuqt8/XdGWKTi3EaWiuqYha22DnpA01X+5+l2ofDGqctz9ccT6KheI=
X-Received: by 2002:a17:906:cadc:b0:a8a:9070:a6ed with SMTP id
 a640c23a62f3a-a90d56bbc86mr1160115266b.31.1727090998005; Mon, 23 Sep 2024
 04:29:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <29dc7fdf9dd8cfb05ece7d5eb07858529517022f.camel@suse.com>
In-Reply-To: <29dc7fdf9dd8cfb05ece7d5eb07858529517022f.camel@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 23 Sep 2024 12:29:21 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5cfuc80OsqiNGTcr49MjZYURu2_8pMr+5wD+hw41it+Q@mail.gmail.com>
Message-ID: <CAL3q7H5cfuc80OsqiNGTcr49MjZYURu2_8pMr+5wD+hw41it+Q@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs/315: update filter to match mount cmd
To: An Long <lan@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 8:57=E2=80=AFAM An Long <lan@suse.com> wrote:
>
> Mount error info changed since util-linux v2.40
> (91ea38e libmount: report failed syscall name).
> So update _filter_mount_error() to match it.
>
> Signed-off-by: An Long <lan@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  tests/btrfs/315 | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tests/btrfs/315 b/tests/btrfs/315
> index 5852afad..5101a9a3 100755
> --- a/tests/btrfs/315
> +++ b/tests/btrfs/315
> @@ -39,7 +39,11 @@ _filter_mount_error()
>         # mount: <mnt-point>: fsconfig system call failed: File exists.
>         # dmesg(1) may have more information after failed mount system
> call.
>
> -       grep -v dmesg | _filter_test_dir | sed -e
> "s/mount(2)\|fsconfig//g"
> +       # For util-linux v2.4 and later:
> +       # mount: <mountpoint>: mount system call failed: File exists.
> +
> +       grep -v dmesg | _filter_test_dir | sed -e
> "s/mount(2)\|fsconfig//g" | \
> +        sed -E "s/mount( system call failed:)/\1/"
>  }
>
>  seed_device_must_fail()
> --
> 2.43.0
>
>

