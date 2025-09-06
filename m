Return-Path: <linux-btrfs+bounces-16689-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C25AB46B05
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Sep 2025 13:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9BE1B230F6
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Sep 2025 11:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F2727510B;
	Sat,  6 Sep 2025 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgiDmqmX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FC325A326;
	Sat,  6 Sep 2025 11:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757157903; cv=none; b=WMWYvYPGf6W6WwDimFEtt47wnosPGWgub1nv1pBGUkKhXUJJsEyMOeoHBeY2/3HoaVaCCeAdOco3gCctf7+GqRFtDGN8PSdhSwBP+NBrHkyMGkNLCZEcQRK6x6TIfWjocXCOdAVFPPsEqjryChDDm8/COczBXz28i9ZPqAAwZ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757157903; c=relaxed/simple;
	bh=ct/jNV3YJ6fvjezU8Fzw6M5BNMVQuB9YpzbFHkRJbLg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BpOBscvGG9ADuZnhyLKvKiXGcGjwUZZyiI+EadhVmcQ79bzcBnwbCotDedGwO1NvF033TYrSqB0jJQIeUi9/ELUIyes17qBthu03tPkwDEGNhvxmlOM7fWLTbKWhVR1tktVGiMMUfu1YSeFzRCJKNd/yVszmPOjcreweujWnDk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgiDmqmX; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b79ec2fbeso19861105e9.3;
        Sat, 06 Sep 2025 04:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757157900; x=1757762700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBOanA6zalGLYYyu9YMahK79U0EvwFc1g3mic7A2XsE=;
        b=RgiDmqmXLa8FNDPMfXknAcGXchwWe3Qki7YVFJhQ5BkxXPtEbmKjJU6E7f2sdxU3cP
         tQui810PnIpvCr0l4L4dGtrpvLAm9lFqX6n0vIdqwsWiR2n1fm0bFh79oN3x7iqhWSs0
         6YdZwTLHSGa4UvCIZTZv/VO4xbXKfxNl32eg7LaF7KSa2mGPgDma+67JbDbviVPbHu4B
         am2IPezd6SoP+8iBzGpHVI51UNkDVH9WrGnveHIyxqcdzesBVYxrwRvGWsSpKiHtN9eA
         e5wBswpSfMaXhrYznOpZcfR1BdZ/qsc6ew36mprrs7VZA6LrSVt5Dt0xovkKfjOBFLS4
         5CiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757157900; x=1757762700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBOanA6zalGLYYyu9YMahK79U0EvwFc1g3mic7A2XsE=;
        b=eZ/+mbpc0oJRUhdnM0IQ892XuW/0S6o2L9h7a1Fq78i0kqHkX2zd0ACSPKRTsGgEU7
         Fcf/d6st//zTSt2ssr/Bhofd/GfnorO8CdPeTEsjAgR8ipeCvSdog1uOfCyBIrgIrG5o
         dQxmA1HyrSsOH6kxjBdXmnUkL0JZuudlpVrrDXG5v+Vwg8nhI+55cbtnGhNH3qGsyuGG
         axcuedmU48/+iLbCdkDg+ul8xSq5hOxMP1wKiyx2Kx9HpNSBMxRXQZ9fJ7edhdWVOcsE
         BPlqyp54R3ZBKa4IuYrgFvzPiSQCkUsYKK80bu2oXzjFcHz3csFdhG9Li5mTQRDQZkKl
         /Rcw==
X-Forwarded-Encrypted: i=1; AJvYcCU5W94bRWkUBW5BGiE6kKfFrfRvhKm5TjGIwIUzgVyF3oiNQxBDfRwCuBnWMTIztuUayqrIyxaRomxftg==@vger.kernel.org, AJvYcCXYa/QeuY4D+7EbeGCIaxL+vbZlxefRBlxfcatHQEKzu2GHdGihCCRv4tJGL36tYQ7vTD1rPnjlmh51shxz@vger.kernel.org
X-Gm-Message-State: AOJu0Yyeg1Ih2XwiXkIozCLjq7hmGwBgRWeXr5bGK42pIxxZfDek6OwN
	Jv+8JGWbhiFWtOXND4hx+FcdLvf3ubQYE00szLzP6GSZdWOUajkm5rg6tPKNJg==
X-Gm-Gg: ASbGncvJqv/CxOpKMfINOwkHTiyUh5hNmk4ZTW1FHwdKiCrQhwD4Ttd+J1ZPVGnY6gM
	nUUrIZ+nygdukASTkJRkxZkC5Ktqsg8RVKOaYvHFsmNF43KVmcMyAC3YrWSyGBja5GewK4GKTC9
	y8RTOp6Skju3DgSbsZeCm4Xe1VNEjcyGbUzB1xVym350YRha62g26UloQeQiR5ZpcFS40l4pFOq
	jZtWMyhBHnacpSRwMaix7tJbRG2q13U765/CagNSBzBA87bwjn7+eHnASK2VsCQgKdwx/xFLK3K
	0Uath65NXNB2X531hjItJ1zND+NXohntTTZgKB1XTSVGWCv4rJKSf+24OvPPyc6lfLQ+6a6chYo
	loCIY4RtrTJCCoIO2pZQDTIcLl8/meENGvcRqdeSOcBtTZwFp49AwnqlKMWUeyxoRnxRRrfV9v1
	c=
X-Google-Smtp-Source: AGHT+IEqq/gP7GihJJE1vvhH8bWCtf+vjl7jrPTkrkQWlh2B1MBEzuH1ShRPD8Quxer/3nx3fqFFNw==
X-Received: by 2002:a05:600c:1d07:b0:45b:9c93:d236 with SMTP id 5b1f17b1804b1-45ddded246cmr15000855e9.27.1757157899968;
        Sat, 06 Sep 2025 04:24:59 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dda597641sm25599355e9.11.2025.09.06.04.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 04:24:59 -0700 (PDT)
Date: Sat, 6 Sep 2025 12:24:58 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David
 Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: scrub: replace max_t()/min_t() with clamp_t() in
 scrub_throttle_dev_io()
Message-ID: <20250906122458.75dfc8f0@pumpkin>
In-Reply-To: <20250901150144.227149-2-thorsten.blum@linux.dev>
References: <20250901150144.227149-2-thorsten.blum@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Sep 2025 17:01:44 +0200
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> Replace max_t() followed by min_t() with a single clamp_t(). Manually
> casting 'bwlimit / (16 * 1024 * 1024)' to u32 is also redundant when
> using max_t(u32,,) or clamp_t(u32,,) and can be removed.
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  fs/btrfs/scrub.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 6776e6ab8d10..ebfde24c0e42 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -1369,8 +1369,7 @@ static void scrub_throttle_dev_io(struct scrub_ctx *sctx, struct btrfs_device *d
>  	 * Slice is divided into intervals when the IO is submitted, adjust by
>  	 * bwlimit and maximum of 64 intervals.
>  	 */
> -	div = max_t(u32, 1, (u32)(bwlimit / (16 * 1024 * 1024)));
> -	div = min_t(u32, 64, div);
> +	div = clamp_t(u32, bwlimit / (16 * 1024 * 1024), 1, 64);

That probably ought to have a nack... although it isn't different.
bwlimit is 64bit, if very big dividing by 16M will still be over 32 bits.
and significant bits will be lost.

Just use clamp() without all the extra (bug introducing) (u32) casts.

	David

>  
>  	/* Start new epoch, set deadline */
>  	now = ktime_get();


