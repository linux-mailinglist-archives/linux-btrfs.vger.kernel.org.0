Return-Path: <linux-btrfs+bounces-8810-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62045998C63
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 17:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 089741F23EFF
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 15:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58BA1CCEF4;
	Thu, 10 Oct 2024 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dK5LbDOt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05E41CCB41;
	Thu, 10 Oct 2024 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575598; cv=none; b=AibCiyFyShU1l1iMoPj/fdvuH3/chl9HYm5xq7OCwl553lZBZtOJwt4nG6E3KGQ7R22L4HRCJQ7ZPdu4UOUzO9SfmDKd6Gg5MfZkpx89YqIJV+3aqkRlp9IizB4VVjo9tgR4I4xTQ7zYmpRLkQLSOAIrIrK+g24RnRJBmzcLbVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575598; c=relaxed/simple;
	bh=6Xk/hm2b3OcgM8FvDvwtDE3O6L8y5egTkuO+hbgD3PQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ncbw9tqG81lTXg0UDACQWxsBeydwwJumFVX03exMPhL/cVpHDjPfP0MLEqcB+z0Ap3poH+0UKSgvl76Ho/+tlJcz2Hda9PQC9/YWZKHJf33M8Z+ZSrwY8HeJYOBLfuYZ5psZXYpYMF/8E4rCs1c3CxIQQwqjvBq4lqxLujqjlZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dK5LbDOt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C5CC4CECE;
	Thu, 10 Oct 2024 15:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728575597;
	bh=6Xk/hm2b3OcgM8FvDvwtDE3O6L8y5egTkuO+hbgD3PQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dK5LbDOtKSW5h6MQ76eN5Vuk3D1a9R8nBPA2XycT2Py5OoqJS1xDykoVzWS/xkfIT
	 bXSNXTeA95yiGq1Hwa+EyadJE+Q7fCw8Ygf50nriwWeyuhICM3zwRwhIwnq7Cmd65E
	 G8ofgipfyl7BgcxPo/Lb+uSq02tEC5N4i3s4tvFaPI0C0ygGSZcDsK7th532dnth7r
	 k1Hc+zVvr4ER1j4AaiP6HHAYxrXqC1dx9cMJYljU1MZFIIDyM0ayo52jtf2DQuqsks
	 fzLktPEmEaYySV3Agw5a+0cCZFkSASKPhlIhQ0jLo2xz1HvXcAp9hEt2hrceJ1KexZ
	 HCYW2m/ZirLww==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9952ea05c5so179656366b.2;
        Thu, 10 Oct 2024 08:53:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVLrXtePPAKtWve55alJJvu8bXno6e3wdqtMNKIsAj35ySgo7Y+NCQ+AZRkr6OavxRCNWBrSaluLEDfmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDQ+o3ZV5PmCT6X2QTri/+wRGhHXv4gTXi12CCln7jS4H3dLM3
	P9d4ubfrkvn/49r2AAsq5s0RPgY2JP8E+EtPQo4v8X7dNBpbgkmDdqHTx7CgGVU6zcfYoQA0THZ
	Iv1aIzVeJt8yFcRQwFUsdSt3dxsI=
X-Google-Smtp-Source: AGHT+IFf/nqyi+Om+lNXUSNPkl701Xi2GlZ3y/GPTfuobO43nxzsfmXZ2r/YuqCIh5Tu82pRA79CbIN7vyLr5Mhk1k0=
X-Received: by 2002:a17:907:970e:b0:a99:4ccc:9018 with SMTP id
 a640c23a62f3a-a998d334ac8mr683440366b.59.1728575596399; Thu, 10 Oct 2024
 08:53:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010153630.1225162-1-maharmstone@fb.com>
In-Reply-To: <20241010153630.1225162-1-maharmstone@fb.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 10 Oct 2024 16:52:39 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5f=EfNXryU37zxNHe8=wp6z2rXD5CTwMB9vszbLnVU5A@mail.gmail.com>
Message-ID: <CAL3q7H5f=EfNXryU37zxNHe8=wp6z2rXD5CTwMB9vszbLnVU5A@mail.gmail.com>
Subject: Re: [PATCH] btrfs/318: add _require_loop
To: Mark Harmstone <maharmstone@fb.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 4:46=E2=80=AFPM Mark Harmstone <maharmstone@fb.com>=
 wrote:
>
> btrfs/318 uses loopback devices, but was missing a call to _require_loop
> to print the correct message if CONFIG_LOOP is not set.
>
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  tests/btrfs/318 | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/btrfs/318 b/tests/btrfs/318
> index 79977276..df5a4a07 100755
> --- a/tests/btrfs/318
> +++ b/tests/btrfs/318
> @@ -18,6 +18,7 @@ _fixed_by_kernel_commit 9f7eb8405dcb \
>  _require_test
>  _require_command "$PARTED_PROG" parted
>  _require_batched_discard "$TEST_DIR"
> +_require_loop
>
>  _cleanup() {
>         cd /
> --
> 2.44.2
>
>

