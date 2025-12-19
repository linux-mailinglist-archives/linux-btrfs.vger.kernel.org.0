Return-Path: <linux-btrfs+bounces-19898-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 699A4CD02FF
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 15:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B25C304F64F
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 14:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6463277A9;
	Fri, 19 Dec 2025 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CBqvTJEx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24982222B7
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766152912; cv=none; b=pX0reWgkUYsu302O2xyd7Hp5uuSRsl2CC/x9Hcooq33nL/XZ2j8CDr+Lt6cD1DoYfSgqtDrTX9PH24xoed6iwCjqNRLsZYdi9OBXlU7sGaocQiO7Rul9kAzjDxHpDuZmehyeplTlpOA7KqZceZZzXh62dWrtKhJ+TpDqvaZGGYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766152912; c=relaxed/simple;
	bh=+cyXvXJPTqpc3qWTws7DI373ucHeNzGZbLBeS0WidkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q6JiRIBpPCNSN18wkQXWs8koI8cjJ0bqajgzYsK59RFHpQ688gbw+DmOeauQh8E9+B1RFWEEyOPZwlLAZ9/CptPfU9y89Ut0VeHv6Q1RN6ZvyWeSJQJVgC1KvfTtKHkuiZWV47N9rmRRGxU0mwiDDLUx20Li9n2OQJwa6tQWJK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CBqvTJEx; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477b198f4bcso12829605e9.3
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 06:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766152907; x=1766757707; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MmDbfblyrnjo2cw2erUnn4x0kJkUs8UxPraagITOs2s=;
        b=CBqvTJEx82XZE+T2OVKByPyT9flxd0jVz6oPC/fjaCB8moRvXL6IZcRq2FBSvxByte
         i3Y7z2NeN2rlh4ttgf4owO/3rhoiQnBmwUjNPwqGhWPkEj1gzz3PW61ek+zTqPLWAypM
         Y78Aks+fNSDIB4r28XsYo7LYgJSGoJYpwTGH53XbDZMBAjPM44kAfqvB+geHYy1ngKhe
         bYpuJRN+Qprdx+a7ex7xLBAs8NSVe1x4kJLLK+IZHOcv63+wseS0VHGFYBF7ECk2p5gq
         ojZojvzThAlQuwAUzdirvQXufGuMlRyisNBHDm9zhUAfDRRMrQ+3/FNPi2OTgHy/mmuy
         qdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766152907; x=1766757707;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmDbfblyrnjo2cw2erUnn4x0kJkUs8UxPraagITOs2s=;
        b=mH4Wl8Th4/Htb/sTvMisfOQF7XRTN0KkFeGbdSpj928X9LxSKR5NOZWXbVg+45MO0F
         h0M83mcIYnfu7eeD8r8aouy+Kb3zH5rHutviCcm3maKximOYuOow4HGzO26xKDK1R2Z5
         xSf3TBoOZ0hQO/tJXhTXTW2Ii7lRU9fM+1tVq5zGCjlCIMZwnwuDeD7HiG2GHFn4zHao
         0vOChcTYbB+7Qsi4rxMwbpHvZpFRwlCMDFCXWJ6n+h9DAgCdpbPLYoP7DpR00qXg5zS6
         hS82s9iM2EzWKt4LTNcVZZ3iomgjfDQ+wr4S77XgHAtbEyqOIIL1fx69bY/Wg8etCnXQ
         f+qg==
X-Gm-Message-State: AOJu0Ywg716zDy/Q38Q8mLZMOMlnUsl0eBlBPP9UjykuawVXjjoA6x8O
	cv+VFP25GgmwDkDRutpmQpySB7c1wa2hjyezvJhwMyIF8pPAELrGwXtm1jsYZvx9LqB1dHrJyHL
	Wjf2+Bgl29PrpBjno6QrlhMwp9qa2VZqKxuFkZTr7MQ==
X-Gm-Gg: AY/fxX4Rvmpchr/6zVrMSL71vVtTwaMhzqZktvWFlkGi8l+DVtayQhQvg1hu6QzmKfQ
	YadEXSwLvKJ6/4lSS2a4wWQ12Cz++7gnU2NlErK443MfkhEcVPG8Vp7E5pQZEJ9Z23n568tjkYz
	dzpSeGd+wRjAQJVn+a2oOcS29WgWPWGsuhkWC1aF451Qw5Xhm2N9INxLanWkHreg0pq1iBgw2BZ
	fmF6bxecfHwu86LJ/qcuvbK/D8QEpVptGjz2AxpgaLc1yr+WnJ/EdWx13AwDJsRbfHKRNZQ1ORe
	kUKiI2fW/yyNJ6gAcN0ejY+hMGt6vE6d3zFNAsmm1t2Y3wChL1wuWNdspLZMqqR958qr
X-Google-Smtp-Source: AGHT+IHjvj6tQ+ivf2+MTtgWixYi7xljy0fMbr286nBRTA4aK9ssctpoX7HCo25cln0qP1LfhUOZdTS5a4e2NOlV1D4=
X-Received: by 2002:a05:600c:4e8e:b0:477:9f34:17b8 with SMTP id
 5b1f17b1804b1-47d195330dcmr26780015e9.1.1766152907110; Fri, 19 Dec 2025
 06:01:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d5f264d5a8be85998a6b65c5be122e56dbea5647.1765987488.git.fdmanana@suse.com>
In-Reply-To: <d5f264d5a8be85998a6b65c5be122e56dbea5647.1765987488.git.fdmanana@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 19 Dec 2025 15:01:36 +0100
X-Gm-Features: AQt7F2qddFN04CwHGfrKKBm4qpS1vda3UNa8CzFHR6GgIKHBcWdQ6rrw4hvNrmI
Message-ID: <CAPjX3FeT2=h+=mQi33BTTP0765mbvSepjSjXGYB24KpM-Eus6A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: avoid transaction commit on error in insert_balance_item()
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Dec 2025 at 17:19, <fdmanana@kernel.org> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> There's no point in committing the transaction if we failed to insert the
> balance item, since we haven't done anything else after we started/joined
> the transaction. Also stop using two variables for tracking the return
> value and use only 'ret'.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Looks good to me. Feel free to

Reviewed-by: Daniel Vacek <neelx@suse.com>

--nX

> ---
>  fs/btrfs/volumes.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 072f01b973a1..ce0535c0264d 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3642,7 +3642,7 @@ static int insert_balance_item(struct btrfs_fs_info *fs_info,
>         struct btrfs_path *path;
>         struct extent_buffer *leaf;
>         struct btrfs_key key;
> -       int ret, err;
> +       int ret;
>
>         path = btrfs_alloc_path();
>         if (!path)
> @@ -3677,9 +3677,11 @@ static int insert_balance_item(struct btrfs_fs_info *fs_info,
>         btrfs_set_balance_flags(leaf, item, bctl->flags);
>  out:
>         btrfs_free_path(path);
> -       err = btrfs_commit_transaction(trans);
> -       if (err && !ret)
> -               ret = err;
> +       if (ret == 0)
> +               ret = btrfs_commit_transaction(trans);
> +       else
> +               btrfs_end_transaction(trans);
> +
>         return ret;
>  }
>
> --
> 2.47.2
>
>

