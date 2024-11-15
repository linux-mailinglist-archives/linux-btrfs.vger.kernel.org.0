Return-Path: <linux-btrfs+bounces-9734-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685C79CF210
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 17:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3DA296DEB
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 16:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB5C1D5170;
	Fri, 15 Nov 2024 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTO7aGXe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B721E4A6;
	Fri, 15 Nov 2024 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731689326; cv=none; b=Y3Q5wjkxi8bx7O6aniRKX1+rFYiY7jZCtpsVB7NhlLXRx2cW/NSRJ9GeonXO1A/z2jl69Wa9Qn6rtmfLDuvnmMzzjwSPL8zWSk7sfnEgaCdvrXkB9rawpNNCVN91zKEDi4DDFcYsm/sjOvmEoeT2DQ50t5dnGu5rUyJ+OArIisU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731689326; c=relaxed/simple;
	bh=kKGtfMwcba2Qcdey5QPWB7nF+4OGsRzJEgSd4xvkj+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rcWOXtDIMmyqLFeh2yD34QMXoQJmi6Z0TVYK9CPyZbVu9N3EE75RSg3HmLSB87F8jB6ueuy3dUstFaQzbCjhkNAFZPjueaz0VPCNfIQS7vm4Z4ubTxuRG8CW3ESySxupMdiG2TjZWJ7kNEbV8ZxeLVEZ94ASqFATslQdm2fX79Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTO7aGXe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F754C4CECF;
	Fri, 15 Nov 2024 16:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731689326;
	bh=kKGtfMwcba2Qcdey5QPWB7nF+4OGsRzJEgSd4xvkj+0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XTO7aGXe3Y7L3VmxQl+fmQcjP5U39biYXukP/iwUI7LEVB2VufqQWrz3WFPlzv1ne
	 rTZnO4gfnFBoSEghpmp6Fz9vSHL2+LYZbbAcaDOwnAeHAOE0inMMu2uDV72l3zCVeM
	 UGQ28uA5bazWQUsynw+awsXx7hQNPW70A0+qBLui4mvhOW2V2g84u3R56R+Taem9oY
	 P8xLC/4ZhLyDi6H/4lXJHGsF+UBUdZ+COfbV2kDhjJ8beR/O4Bu9gWn7sQW6jv++jD
	 GycCM/btSxbQrrAujB4bGMGDLrAgso15DksV5BMTLmcdHBSJIQozYcYFRkGA4fsXHD
	 GtkZZtuYSBYZQ==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c96b2a10e1so3388412a12.2;
        Fri, 15 Nov 2024 08:48:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVVwgugo1VCwhtjM6Hxae9kJBQYNKa8uK9Q6op5AtPtV6AQKwDP6hzwFnzfYiNTAXEuKkWyTDAo/HDZbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPaBL/bfxFi3xocErlkUCZJjv+jiS6AVVQKJfrMeh/gbs5s60+
	IroupXj1iYG/dgPZHwSBxe9NxT95PkMPO6v7rvkxGuDmZYIIphorqoLytOan0nLJN/sycT69JDR
	hYE0obL71/rR221VChRxGXZEEiyY=
X-Google-Smtp-Source: AGHT+IG2M1gtRGUI7dACjXN5Ox1oR2U6UDXdIcX9c2rbsI/xG2W5/AfmLByTXXr1OhpfHx1R6kFiYyecMaBxbDhpYks=
X-Received: by 2002:a17:906:c150:b0:a9e:6712:c27 with SMTP id
 a640c23a62f3a-aa483556529mr254190966b.49.1731689324855; Fri, 15 Nov 2024
 08:48:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731683116.git.anand.jain@oracle.com> <7af8f80173fab5408da86f5b3393e787659a81d6.1731683116.git.anand.jain@oracle.com>
In-Reply-To: <7af8f80173fab5408da86f5b3393e787659a81d6.1731683116.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 15 Nov 2024 16:48:07 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6tuucypvk=vjWtJGnyZa59XEcS-x3hd-XoAYWPLkK3nQ@mail.gmail.com>
Message-ID: <CAL3q7H6tuucypvk=vjWtJGnyZa59XEcS-x3hd-XoAYWPLkK3nQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fstests: move fs-module reload to earlier in the
 run_section function
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 3:22=E2=80=AFPM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> Reload the module before each test, instead of later in run_section.

Why?
The change log should give a justification for the change.
It's just stating what the code changes are doing but without any reasoning=
.

Thanks.

>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  check | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/check b/check
> index 9222cd7e4f81..d8ee73f48c77 100755
> --- a/check
> +++ b/check
> @@ -935,6 +935,15 @@ function run_section()
>                         continue
>                 fi
>
> +               # Reload the module after each test to check for leaks or
> +               # other problems.
> +               if [ -n "${TEST_FS_MODULE_RELOAD}" ]; then
> +                       _test_unmount 2> /dev/null
> +                       _scratch_unmount 2> /dev/null
> +                       modprobe -r fs-$FSTYP
> +                       modprobe fs-$FSTYP
> +               fi
> +
>                 # record that we really tried to run this test.
>                 if ((!${#loop_status[*]})); then
>                         try+=3D("$seqnum")
> @@ -1033,15 +1042,6 @@ function run_section()
>                         done
>                 fi
>
> -               # Reload the module after each test to check for leaks or
> -               # other problems.
> -               if [ -n "${TEST_FS_MODULE_RELOAD}" ]; then
> -                       _test_unmount 2> /dev/null
> -                       _scratch_unmount 2> /dev/null
> -                       modprobe -r fs-$FSTYP
> -                       modprobe fs-$FSTYP
> -               fi
> -
>                 # Scan for memory leaks after every test so that associat=
ing
>                 # a leak to a particular test will be as accurate as poss=
ible.
>                 _check_kmemleak || tc_status=3D"fail"
> --
> 2.46.1
>
>

