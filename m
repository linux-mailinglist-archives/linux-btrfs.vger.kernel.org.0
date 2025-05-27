Return-Path: <linux-btrfs+bounces-14252-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F70AC4CAE
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 May 2025 13:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E806189EB57
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 May 2025 11:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A08C259C83;
	Tue, 27 May 2025 11:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BW82qhGw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B337A192D87
	for <linux-btrfs@vger.kernel.org>; Tue, 27 May 2025 11:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748343777; cv=none; b=i4qIi2iEPANla50HHRi8c7RfgawAvgafq6DyWeLOGsOxLHthXW19UyqwM7fVzaVkYXE0VyPAVNDOjdBuCsLGxL7DivmViwoajZFVAaMPG/EqHS6/IOv5d/fF+PtcCeZB5iSzHvfFJ+OP4KbhDDlRjaAwsPMTM7TL1R3jgi10CaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748343777; c=relaxed/simple;
	bh=8PNSD1yNDeaHzILizvaWS59CJEOW+AHJ1XgmcK1kkvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b8iQyfDQRZDhg5LufykGwNNvNkdvWBx5/ezadF6TpOcV1L8CQZlLTcH6M4eM0NxIvrsYTrW0YsNFnU05IHt0FULA1cNTitQB3nEuGSCr0IEnFr4iN/AkA4FA10f7+PiPrEaoUdqfmMYSjsWV2NwZTbJLKICWP1X5OgyFWMecO4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BW82qhGw; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ace94273f0dso629527966b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 27 May 2025 04:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748343774; x=1748948574; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ULCbu2oSoXQqPPNEVB3CcbyMZf5b2X/8UhsgQECmbJ0=;
        b=BW82qhGwMWAID2PPEkFuhM0xrA17D4JcS6IhgYATdp4kAe8Hp27Y/gtz0dCfUEoAxl
         TDma1mu7XRYzaXgn9nrPDoYiPwmY1/I6XkmiQxL6SzXGGD8xqeE3qHUpXuZ39Tw421jq
         wI9GKiATzYniye33M5KQ5r9T8AG+EapLMh8M3YzQYvcYmqDrC1yVYrkaoqu8KYxhhwkZ
         8C0I5nASUZZ4IOPe5uisuvqtWm7BZwS4SwqnOHsMjs3p0MgyD70HndyCifdEu/3bPAwa
         N8sqru8sKzlL0vsisic884hZohOu36hDp0W2PklVhBnKzpdUfMh825dSMJY3iOoHa1ID
         H+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748343774; x=1748948574;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ULCbu2oSoXQqPPNEVB3CcbyMZf5b2X/8UhsgQECmbJ0=;
        b=Pqyk/NqulYqlU31UpZ0XLYqtFgHGN1s0gcDssTvl2IrMLBYncz5Nh+XLfGExqVKIzx
         nw0SH2Vw0cTr+PJb6J/YRFHDZKnmMO9u0s7XUMlVsM7w7OH9f+f1aTX4XJOJmPNXI/sV
         Nbyhs4QtVOrvWrM22RhXrg9EG6yuuOTzVH9lyMyK38s6iwDzAb+4nSaVPOeBgfE7Ub6x
         t6kdrUkQWEU2fw91YfFBcYzkNPpOHZITB83EpiCyVu3YYGU689pvYjBeeNmQAD5EPexw
         Pjy1mcLq4qtCVGfA3btXxACph+PSuo/FehkEhBapGWiJpBQoykK02hCM4NAz1DY3xBVB
         8Tbw==
X-Gm-Message-State: AOJu0YxldiF0rFd0fZn+FdP5AzMW7DiFbCQwKYliHpGvNaMnPlBF6Sy+
	H2lAazGVV0TCY1pLp7Dozl2nBXP+1yoInG+/kQ3ehIj+4TQT13pf2P47RqUnLZfZfALyYDUYloG
	7O/sYiiA1NRRvNa0g2cutMEUJTpEdRTyA4puLafU8deLgIHc48Wh5b/eD8Q==
X-Gm-Gg: ASbGncsMxTwO8XPMwJUF8y/IH+ZEqh2JiovgB56iNcb9pSJWsQgyRl08PoWMG8CWpBI
	fNr5n1Tzh2lq8Ea0mKjnnW6s9NxCG/j3/XUgnb+R8RGl5INCesZvrNXLbtrfVR3QCBSaLdw2CaZ
	zZNQIaEzd5d0BGGgj0Q//+FNtwffIbFRR9g/3UEo5yAA==
X-Google-Smtp-Source: AGHT+IG2oX4F6BEiM2EHTXbN1stLSPOpl0lMyowDlRvAzvA49/TyeFolaqiWGIgADQVkTi2vNbsjwxOxdk00NSm2HN0=
X-Received: by 2002:a17:907:1c22:b0:ad5:c463:8d42 with SMTP id
 a640c23a62f3a-ad85b12022fmr1174915866b.12.1748343773890; Tue, 27 May 2025
 04:02:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <abe65dcfac248737e735f5c3b9d7e9f165dac802.1747653415.git.fdmanana@suse.com>
In-Reply-To: <abe65dcfac248737e735f5c3b9d7e9f165dac802.1747653415.git.fdmanana@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 27 May 2025 13:02:43 +0200
X-Gm-Features: AX0GCFuVYNYkZdvjsVf2cejhdH_AIztuxL-79r2ivJKPSRAJIqFovHWsh8PvrOQ
Message-ID: <CAPjX3FcNfFT33RWN_6Jj9NfM0z+gHC5J-A74psqotuumWPoBGw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: unfold transaction abort at btrfs_insert_one_raid_extent()
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 May 2025 at 13:18, <fdmanana@kernel.org> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> We have a common error path where we abort the transaction, but like this
> in case we get a transaction abort stack trace we don't know exactly which
> previous function call failed. Instead abort the transaction after any
> function call that returns an error, so that we can easily indentify which
> function failed.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Daniel Vacek <neelx@suse.com>

> ---
>  fs/btrfs/raid-stripe-tree.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 1834011ccc49..cab0b291088c 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -329,11 +329,14 @@ int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
>
>         ret = btrfs_insert_item(trans, stripe_root, &stripe_key, stripe_extent,
>                                 item_size);
> -       if (ret == -EEXIST)
> +       if (ret == -EEXIST) {
>                 ret = update_raid_extent_item(trans, &stripe_key, stripe_extent,
>                                               item_size);
> -       if (ret)
> +               if (ret)
> +                       btrfs_abort_transaction(trans, ret);
> +       } else if (ret) {
>                 btrfs_abort_transaction(trans, ret);
> +       }
>
>         kfree(stripe_extent);
>
> --
> 2.47.2
>
>

