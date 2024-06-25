Return-Path: <linux-btrfs+bounces-5970-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D094E916F8A
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 19:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D32C1C21A0C
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 17:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27B3176FDF;
	Tue, 25 Jun 2024 17:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFMXV4uZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F2F176FB2
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337539; cv=none; b=OqTZdWyrkZnUTst1UymS+nulRHrDjKE+/jQHrkEnfmb6OnC21a14P2MQ0QbbCorrr6nNdz3HEIjhLkZlMuEgB8AoQhZh9AfNqIKZ+J2IiAq3mfeP6yZIyqNPqozH2KXglah74B7UNFAhf5durxsokcEjhRAD0jP+nM2EUgvtOxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337539; c=relaxed/simple;
	bh=q+Z9maan0HRfb6XFKBMTaeOB49vAgNTbwT4dw7hDiQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLIT9/Xi/T9BYeow/5lQLoqOJqSTatK1+jZ/8Jx/5irOveABnt43x4f7kkijNCCCHluIjI+R554S58xu5WCdpIui68P1gkrRZ+JYiNDaq3lGUT4NpRlvHsAKtgbANOY7BideVpKzbw/1fuxd7iKcuErz9c1Cf1S0t5zbiFMuYOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFMXV4uZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06BFC32781
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 17:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719337539;
	bh=q+Z9maan0HRfb6XFKBMTaeOB49vAgNTbwT4dw7hDiQk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JFMXV4uZ7XB32xyAicpAKtydzd8OBEkDrZ06z+xL2t/mo0S7ctmbP2+Y9LarGwmFq
	 hM4Wzo1ovEmuQMjfxAR7Cq1+lsDBghexuDiteC2wcWsjG8dSCc9b4CFr2mrTHd1fO0
	 Sem7asmIK5UQ4Ve9+nyPwRrHgFA66ZCcouGV26YDNa0ZxIsJPmPgBHJ5kSWTdMlABM
	 ExcjrB4Gl++2Bjx4e/VKuuiO3uqzB9XApgyo1wdql/cbHHaZZ+strtYhJv5Nl3LSmF
	 7n6Ja6FOgPIybjgX6ioX8QTllaoS5dKFHtmfVnLDzYJ4pduHBph9dchm0+WnJGw3F4
	 d6fXwPN0+DFpQ==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6fdd947967so375544866b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 10:45:39 -0700 (PDT)
X-Gm-Message-State: AOJu0YzJLPmKyuOUoscHXbjNPp7AE6vE+F298k8HTUzF8ofJjvhygxr6
	3Ph7wIVS5ZSh0n1qXnQSQnXEmemyuL/Md0St1LB2u3g5qocYp9WT1eoHSKmYQCbHfvbOQDNkUQN
	+vvyBy7vn0TjX/5+VekVtafxokHs=
X-Google-Smtp-Source: AGHT+IHPaQmqHiGMeF7jrvyL8DHlxmxDgDFhn2vyIMk9r+5XOGGMI5CX/R06mh//MaXxFEHB7NUbyW1aSa9Pj8RN3A0=
X-Received: by 2002:a17:906:c191:b0:a6f:6554:2a2a with SMTP id
 a640c23a62f3a-a7245cc04edmr619303666b.72.1719337538352; Tue, 25 Jun 2024
 10:45:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3034f66918cf06066b769f4d834905e25824ae8c.1719336718.git.boris@bur.io>
In-Reply-To: <3034f66918cf06066b769f4d834905e25824ae8c.1719336718.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 25 Jun 2024 18:45:01 +0100
X-Gmail-Original-Message-ID: <CAL3q7H49_gt=GnhOJEfH0eCRywYQfzNmEgcM=QNob9y05Pr+Sw@mail.gmail.com>
Message-ID: <CAL3q7H49_gt=GnhOJEfH0eCRywYQfzNmEgcM=QNob9y05Pr+Sw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: don't check NULL ulist in ulist_prealloc
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 6:35=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> There are no callers with a NULL ulist, so the check is not meaningful.
>
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks, good thanks.
Can be squashed into the patch that introduced this function.

> ---
>  fs/btrfs/ulist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/ulist.c b/fs/btrfs/ulist.c
> index f35d3e93996b..fc59b57257d6 100644
> --- a/fs/btrfs/ulist.c
> +++ b/fs/btrfs/ulist.c
> @@ -110,7 +110,7 @@ struct ulist *ulist_alloc(gfp_t gfp_mask)
>
>  void ulist_prealloc(struct ulist *ulist, gfp_t gfp_mask)
>  {
> -       if (ulist && !ulist->prealloc)
> +       if (!ulist->prealloc)
>                 ulist->prealloc =3D kzalloc(sizeof(*ulist->prealloc), gfp=
_mask);
>  }
>
> --
> 2.45.2
>
>

