Return-Path: <linux-btrfs+bounces-2437-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4E58568A2
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 16:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B53CB28FD75
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 15:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC961339BE;
	Thu, 15 Feb 2024 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkGhmXji"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913AC1339AD;
	Thu, 15 Feb 2024 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708012773; cv=none; b=HM2xskA9WJREKQhY2dE+HWVScvjmtG0z8d3/lLiFyERt+VTtL00+fjs0c5SpSIOfC3Xw7M4MOSm+BSO5Ivm7/4XdkTtxdHuJbLhm7+sMxhsGAtt3MD1W4c79B853ht16E3Dnp0V89mHcsM1FD1u3n5KMfWDyHzwNrOJarAvzV5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708012773; c=relaxed/simple;
	bh=PRqIKzfl9mFBT9oD2bvRh1XEsArrlDU0/zo1AUlscJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/aX6zO8c0ax+pEg3vkoJhN5vcKcGHv0KaN8yEEqCYIO6XWUcGsq8dvnqZK97uQcbc9I0ASh+wXiXF1KkNoBJX6PwXu6e2nAmIF+suw1MteGh+29cfqsjYhfqmXafShAbcuQqCVqjZvEu78gFxHl9qZx+jj7DdJI1INsYpbsu2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkGhmXji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4F4C43399;
	Thu, 15 Feb 2024 15:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708012773;
	bh=PRqIKzfl9mFBT9oD2bvRh1XEsArrlDU0/zo1AUlscJk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AkGhmXjigJya6f8aEnegjcg/vzL1AA/SgVvs2D1F21CNNrCaoCVQu+z0z5ffgggSa
	 NfY667HB7a+SWiHYHrFBtQlIC5rvohh7Mv/Y7eB9Sw2QLlImYUnFpUdP3NGYue3NP/
	 GlCFO0vHCi7GjIs7J+DY1vQLK2M9LqwYofl5st271Je4chAOQJpmt3yxlG4quxvLB8
	 U5tpA4ybTY48598E9saXz8ykbGldh+sYJlg9YXj+Jwh/mDAzKEBAEaPxquNGp9tJ3f
	 cNJ3SMc/JI8udxRSCjdlA1Bk0D7XVSgzcRmDLQhpQEIUIgq/N2RHL/lgHOpFwk1pNy
	 1xUtBi82XA2VQ==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a36126ee41eso141708566b.2;
        Thu, 15 Feb 2024 07:59:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWz+NmT80QXiVrWbqiGhW0iI72RK28rux91A4cJbK9hSaYmXTaRv2NBgNpbIK+H2mDlJDJ28rTM38LygupVnfViiyzI4q5lJtUH4wI=
X-Gm-Message-State: AOJu0YyP3HZk3dBq/wqAijQu5pNTapf75ZLjjIAbc4AkfU0tNutGrqMy
	jw9E5e5o3HNBJaHJisUZ/E75kZ/i5VAJgstMtqF0pesOb7Peuj8Hx/wfrpRg+mRBezeRxvpHxUq
	4qDdLBQayzkRO3mA5B8eTZ9Anm/4=
X-Google-Smtp-Source: AGHT+IHn+htW0GO0sNkVN2mNNvrKMjlYyt6AiLJ34tFhUItPZ7KiI7kRPA4v9PZnrdALIac8ZFoD9xIr+HE304jR9D0=
X-Received: by 2002:a17:906:80d7:b0:a3d:a4bf:8fd3 with SMTP id
 a23-20020a17090680d700b00a3da4bf8fd3mr1087525ejx.49.1708012771576; Thu, 15
 Feb 2024 07:59:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215140236.29171-1-l@damenly.org>
In-Reply-To: <20240215140236.29171-1-l@damenly.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 15 Feb 2024 15:58:54 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4rvZbhoCrsf96DCAkybL8FCPiRuJDq+_wbT+QF00Agtw@mail.gmail.com>
Message-ID: <CAL3q7H4rvZbhoCrsf96DCAkybL8FCPiRuJDq+_wbT+QF00Agtw@mail.gmail.com>
Subject: Re: [PATCH] btrfs/172,206: call _log_writes_cleanup in _cleanup
To: Su Yue <glass.su@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, l@damenly.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 2:04=E2=80=AFPM Su Yue <glass.su@suse.com> wrote:
>
> From: Su Yue <glass.su@suse.com>
>
> Because block group tree requires require no-holes feature,
> _log_writes_mkfs "-O ^no-holes" fails when "-O block-group-tree" is
> given in MKFS_OPTION.
> Without explicit _log_writes_cleanup, the two tests fail with
> logwrites-test device left. And all next tests will fail due to
> SCRATCH DEVICE EBUSY.
>
> Fix it by overriding _cleanup to call _log_writes_cleanup.
>
> Signed-off-by: Su Yue <glass.su@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, just one comment below.

> ---
>  tests/btrfs/172 | 6 ++++++
>  tests/btrfs/206 | 6 ++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/tests/btrfs/172 b/tests/btrfs/172
> index f5acc6982cd7..fceff56c9d37 100755
> --- a/tests/btrfs/172
> +++ b/tests/btrfs/172
> @@ -13,6 +13,12 @@
>  . ./common/preamble
>  _begin_fstest auto quick log replay recoveryloop
>
> +# Override the default cleanup function.

You don't need to add this comment.
Same for the other test.

Thanks.

> +_cleanup()
> +{
> +       _log_writes_cleanup &> /dev/null
> +}
> +
>  # Import common functions.
>  . ./common/filter
>  . ./common/dmlogwrites
> diff --git a/tests/btrfs/206 b/tests/btrfs/206
> index f6571649076f..e05adf75b67e 100755
> --- a/tests/btrfs/206
> +++ b/tests/btrfs/206
> @@ -14,6 +14,12 @@
>  . ./common/preamble
>  _begin_fstest auto quick log replay recoveryloop punch prealloc
>
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +       _log_writes_cleanup &> /dev/null
> +}
> +
>  # Import common functions.
>  . ./common/filter
>  . ./common/dmlogwrites
> --
> 2.43.0
>
>

