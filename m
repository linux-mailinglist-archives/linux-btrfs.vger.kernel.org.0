Return-Path: <linux-btrfs+bounces-556-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7C48033F5
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 14:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE04A280FF1
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 13:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A5524B2D;
	Mon,  4 Dec 2023 13:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Of0xYies"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88B124A11;
	Mon,  4 Dec 2023 13:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35128C433CB;
	Mon,  4 Dec 2023 13:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701695337;
	bh=k1ihNzR6xEepft0Kz1NIjeYkuQwprPhGUIlw+9TG0As=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Of0xYies3JDA2qlku0CKH8jvcroWCls7Ux9WGKSbzCAqMrbuWCsbl4UDxTs5ZjEP3
	 Hr9rfmCiEJrsl4MGn4lasyu996JXCV0DBJ+1HzsqSQos+cebLzPQwqlUzrOCug5ryP
	 wMuQ5VLkX6K1dIwcbTbGTVwCGiWw5MLVKVxRXtOGaDsH63hMnYNLtEfKS4MmzA5v0b
	 ipF65z+epTJF2RgTlTb2DmO4v8P4oatO714EM7QUp5W4i8/urfLni171gy63SLe7sJ
	 G8PEvsZQ3PB+jaDNGfMdRhK+B6gsA2BOFmtjp9p4WWoeJ6mCSyXGkZ9q5brlWt0tw0
	 D2IfJF7HIAe7A==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a1b68ae40ffso139711566b.0;
        Mon, 04 Dec 2023 05:08:57 -0800 (PST)
X-Gm-Message-State: AOJu0YyTBmvc2UEPtmAva8pMoXfXqVq6nTAEKprmB1b6jeXWQ8oaVfin
	CZKswabTC46dH2mMvfkrYTNp7a4Q5VTu7QxaYQ4=
X-Google-Smtp-Source: AGHT+IG8H9vI5rGH1H/7fkqhkGCqVRgTPWIVYm5mNKrWK/l1C7/aY5Z3UpvzE6j8YE8gLGk5X6wNojflMjS0v844WLk=
X-Received: by 2002:a17:906:1786:b0:a19:1afc:a16a with SMTP id
 t6-20020a170906178600b00a191afca16amr1844193eje.67.1701695335623; Mon, 04 Dec
 2023 05:08:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <18afc03e67772666190415c742f0793e8207c5e6.1701464909.git.boris@bur.io>
In-Reply-To: <18afc03e67772666190415c742f0793e8207c5e6.1701464909.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 4 Dec 2023 13:08:18 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6PxgZJgNi9soiGbk--E8Wg9x_MfVBqpf72avkPkkszwA@mail.gmail.com>
Message-ID: <CAL3q7H6PxgZJgNi9soiGbk--E8Wg9x_MfVBqpf72avkPkkszwA@mail.gmail.com>
Subject: Re: [PATCH] btrfs/303: use quota rescan wrapper
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 9:08=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> This new test called quota rescan directly rather than with the new
> wrapper. As a result, it failed with -O squota in MKFS_OPTIONS. Using
> the wrapper, it skips the rescan and passes again.
>
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  tests/btrfs/303 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/btrfs/303 b/tests/btrfs/303
> index b9d6c61d1..410460af5 100755
> --- a/tests/btrfs/303
> +++ b/tests/btrfs/303
> @@ -43,7 +43,7 @@ _scratch_mkfs >> $seqres.full 2>&1 || _fail "2nd mkfs f=
ailed"
>  _scratch_mount
>
>  $BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT" >> $seqres.full
> -$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" >> $seqres.full
> +_qgroup_rescan $SCRATCH_MNT >> $seqres.full
>
>  # Create a qgroup for the first subvolume, this would make the later
>  # subvolume creation to find an existing qgroup, and abort transaction.
> --
> 2.42.0
>
>

