Return-Path: <linux-btrfs+bounces-16016-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E09B22183
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 10:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37F0561130
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 08:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E664C2EAD19;
	Tue, 12 Aug 2025 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CiMgZmxP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8352E62CF
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 08:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987583; cv=none; b=ieQUIMeTP5nmSz6/pGQh0wypCWIZFwqbExomCXPcPT1d+FQc8Rs47Si+Yu/H+7y+UVdlGY9Mr9pn7wuSJcRmsi/oNcJVXLhezW829M5uD7zMJYwSjYjIFPTdITufe3Xbg2WF9Hn4sw1hVCsAyoT7eGAAXTCn9lX/9IjpDohLbn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987583; c=relaxed/simple;
	bh=gQqRnUDmyiq/c1A6dM6BP6rq4rA+ezyDXaqyuPkF4QI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S4T5ywaSL90ccdO6WJ79J4RClUylfC2wqVaoIXneZrzkV3s5Bd+LYlgOoEBFSiTmAr/Owr3/gGluMhHD506lYrjzJzr1SZIWjYlWAsXueR9kXvVXrPY38rsLpZFcAndqbLMa2c58Hy9Wg8FORNyDhO8XFtqiU7QdN0F7+Zc4o98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CiMgZmxP; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b8d0f1fb49so3074183f8f.2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 01:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754987578; x=1755592378; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wyb11Vz1qMy7piLHwJTSkYzDASFNds+IfXed84grTFc=;
        b=CiMgZmxPPDhq+ESiTzNiqo43ATK1tJ2A9Mu/n1b4o417B59XY82oBhSAB5b+6C5jQv
         W/Un+ECWJ9Fi8H7kzenfKjbMb/jaI4VbO75jY2ZDU8YRxZ13dYu2dpIjOgDvR6aPPgfT
         ZNzALa5fiQu9X/TZ3xxTB/0yRJdD3J4/GDgfkbgHtHLXHyQgqgGvUU5XPK6undPkWXiU
         fNwiVdpIDB3LOXYbIvZIacYrw7IpQD8cQ1Oy27ClbzhXUrI9vKsmrfTPU2jcRr8UHllX
         afbwbZyIQS3BOCu6Bash5qhVDLHtwvCeP2uyY14Cor6CYm9auFEchaXrZo28pUyfNt2n
         tBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754987578; x=1755592378;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wyb11Vz1qMy7piLHwJTSkYzDASFNds+IfXed84grTFc=;
        b=YfYWairjbXPpGjkxJKcakWiUSEnIVRxPU3lG4HpjJQ/AstQt6y69s/KSl42bOmBeg9
         sVDB41kFYccRrK0bWBME6DtHDvF0k6CwpJXQ3V5/SYfzXQqzklboTsK4a/ZDtrUWdrsW
         sa+/UAbMopH9i/yvyhDzEdHQadxR8BUgJeNL6j5iAmyjica87kVZLTv1xsh2D4LPhpzt
         Uj0C56ys6m32pLnzGKC9vXwfETewXz8QWmzRNJZKk9ZYdr5GUctWX9l6FLjNmjCCB2Ef
         dZ642+afktyzLm1OsI2IRx1D1aZvCqFIkSOQPz74CNGzxaHZP9U+HITOv3lRDFipfwKK
         TeYw==
X-Forwarded-Encrypted: i=1; AJvYcCXnvcMw3csXm+dAG1l6vAoOK9jP80M0oe9IchTxqVM2o0+BBaLxDWsYaFtWr3cLhFdKpoW0n5ZWIBc9yQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaBFm2KF1wJIZtJ3Pi5UT/zLF+TiS0mV8xqhz2IaGw7JyQSb3r
	3vSH/ra9755+glnQXscblwB0+ZL5l9MHKL+cE7B8qcD13rbVpd8ckX29KBCdjqDFuEwtdk9GqHm
	xRDF50XTKrH8vdhU6fkBqHI4xw2RfW+ZL/hsNgBPdkQ==
X-Gm-Gg: ASbGnctLOuRK6DdSp/GJfoVLu1CTMiYFKl2jQMHIpbKg/ga9HLMyelfLG3ZP40ikeuz
	1Mk8Ikh31fjy2f80sa/3vqV0kq/XkmPEwHbLYKlUuS7sS+qOAeFERxydR6oTTXfCYK6kd53tgkm
	yqueg7wKs18r3VHJu6lcj2+cSbyNRsgE3eS9Ig6cDVtIY9je82GAB+4PGXiLu+fhmT/l5wRL/KP
	I9Y1Q==
X-Google-Smtp-Source: AGHT+IHBLtLTODzXDFsr93yFdNHPG9OO0ylpV9rnIadLqUg4I1ShoVedu2pugApagMzIzY5ooOgOHXkrnb/sZBPX6qo=
X-Received: by 2002:a5d:5846:0:b0:3a5:8934:493a with SMTP id
 ffacd0b85a97d-3b911032aabmr2058548f8f.44.1754987578494; Tue, 12 Aug 2025
 01:32:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812082554.48576-1-zhao.xichao@vivo.com>
In-Reply-To: <20250812082554.48576-1-zhao.xichao@vivo.com>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 12 Aug 2025 10:32:47 +0200
X-Gm-Features: Ac12FXx-L34lpqbbVcTmKAvnU127pOEmWITQM3t417pxgkJF-1SZu7BL7ZF1YMk
Message-ID: <CAPjX3FdqXPnb=_JDsAtid2WszaqaODM1rxF5XcGGy7WmfJLquw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: use PTR_ERR_OR_ZERO() to simplify code
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Aug 2025 at 10:27, Xichao Zhao <zhao.xichao@vivo.com> wrote:
>
> Use the standard error pointer macro to shorten the code and simplify.
>
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  fs/btrfs/super.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 68e35a3700ff..57dd58fd8b9c 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2257,10 +2257,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
>                 device = btrfs_scan_one_device(vol->name, false);
>                 if (IS_ERR_OR_NULL(device)) {
>                         mutex_unlock(&uuid_mutex);
> -                       if (IS_ERR(device))
> -                               ret = PTR_ERR(device);
> -                       else
> -                               ret = 0;
> +                       ret = PTR_ERR_OR_ZERO(device);

LGTM.

Reviewed-by: Daniel Vacek <neelx@suse.com>

>                         break;
>                 }
>                 ret = !(device->fs_devices->num_devices ==
> --
> 2.34.1
>
>

