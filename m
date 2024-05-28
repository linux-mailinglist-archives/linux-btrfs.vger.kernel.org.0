Return-Path: <linux-btrfs+bounces-5317-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C76E78D1871
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 12:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 664AA1F2524A
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 10:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D56416A39A;
	Tue, 28 May 2024 10:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7bxZzwE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA04315ECC2
	for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 10:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891780; cv=none; b=KERNisRA8177dNdYWy/cLU1zWXL/q4sfIMCej2W2VyuKnZ/tpvoL0LaYtpJohmhzwkbKNvGUj4ktpM/OAkqSJTfy7eHexOUdBGayHKvwe/9igbLwYlkJMX4uC+ATYfHIlnSyTnz+AXJS4ddYRReMun+TUSWKlN6Pep5bQQcK3+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891780; c=relaxed/simple;
	bh=36qnahoYzhkH5+tj3NqN+zp6TaAB828HrYFPDGWMzaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQe+btZfbkhX+joyMjxsEvoZ4WkqLuKkQnCqePFbzsoY9TCqQ3/4dbw+mNABG95Trxl4o4hAuNw6tA17jM28TNiduWfmrZT2Gus0jZtrPodkLGsmO3+cx9NMfK3Fm7z622aQESdXawO+m6/60/wNZz7RnGU4Bmc21y6+fHsyTO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7bxZzwE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8DAC32781
	for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 10:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716891780;
	bh=36qnahoYzhkH5+tj3NqN+zp6TaAB828HrYFPDGWMzaw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S7bxZzwEZfDOuZ3EeoQgFy3TFc21w6iVxM7inPxJwodhZNv1Zzxm2/POL/yr6qaxD
	 udNjsSxZCyOssqxbGoNUV0x5dMyULZ4mPJHpV8ieFPMrpqgnCmImJVAdu+pFon/f9Y
	 00GjCrrq4919OAgC7CB5wfUNyxsUGF4uT9PEaD6N8IwciwqPkRiGX/ZCA/FWfEv2UN
	 T9LFULkNvEaAZ5J9ReyjTH66nsUS3VVk/aI728EZyDOEG+L5RmSHfGOSpCuEy3DqdF
	 bH9ug09lAGqIHLXIdBLZ/QKhgRCuEQpJW+xr4H8HU4UPvm8eqt7brUZ4Q9Dj50IhbM
	 wK4JDjwnBZMVw==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a62ef52e837so74509666b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 03:23:00 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx1pkBQS/hB3/v9ej1iJXAkWAJqkQU58WL6egAlrJ/FAdvzPJp9
	SOObnSxOMMjszaT5EPR7dSaAgoXECxQN1jVIyK0K+hadwt9IsLKcoXlxoQWSDdVCjYX18VvB5OP
	JP7x+DTHiJq3oXUZibxzs2yO0ZJo=
X-Google-Smtp-Source: AGHT+IFiblTqpfVMjuE5BIfZccT1yzjflD4lmIC6DDkYLH6dVSlMTTcG/Bo6ZoBU0wJ50tPlJKi8s4LXJkkR2qcvm3Y=
X-Received: by 2002:a17:907:c99c:b0:a5a:8b17:d851 with SMTP id
 a640c23a62f3a-a62641ccfc9mr691156766b.20.1716891778811; Tue, 28 May 2024
 03:22:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716874214.git.wqu@suse.com> <1c461e2717312cb530377a519316a8c64cd13c09.1716874214.git.wqu@suse.com>
In-Reply-To: <1c461e2717312cb530377a519316a8c64cd13c09.1716874214.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 28 May 2024 11:22:21 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6_duugLhQct5D3M+chon0aKMWh9FvFSpCWLiejPUgjkg@mail.gmail.com>
Message-ID: <CAL3q7H6_duugLhQct5D3M+chon0aKMWh9FvFSpCWLiejPUgjkg@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: do not directly rwlock_types.h
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 6:34=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> There is already an error inside that header:
>
>  #if !defined(__LINUX_SPINLOCK_TYPES_H)
>  # error "Do not include directly, include spinlock_types.h"
>  #endif
>
> Thankfully it never get triggered as some other headers have already
> included spinlock_types.h.
>
> However clangd would still do a proper warning on that if only
> extent_map.h is opened.
> Fix it by using spinlock_types.h instead.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Looks good, but the subject is missing a word, it should be:

   btrfs: do not directly include rwlock_types.h

Anyway, that can be updated when adding the patch to for-next, so:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
>  fs/btrfs/extent_map.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
> index d3d1e5b7528d..5154a8f1d26c 100644
> --- a/fs/btrfs/extent_map.h
> +++ b/fs/btrfs/extent_map.h
> @@ -4,7 +4,7 @@
>  #define BTRFS_EXTENT_MAP_H
>
>  #include <linux/compiler_types.h>
> -#include <linux/rwlock_types.h>
> +#include <linux/spinlock_types.h>
>  #include <linux/rbtree.h>
>  #include <linux/list.h>
>  #include <linux/refcount.h>
> --
> 2.45.1
>
>

