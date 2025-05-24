Return-Path: <linux-btrfs+bounces-14222-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC691AC309A
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 19:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141533BBDD6
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 17:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DDD1A2545;
	Sat, 24 May 2025 17:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQ+hmNnH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EC92566
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 17:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748107926; cv=none; b=YRdFC+fySBHOh/LTIXwt6uDs+0qYY+h4Ws+xEeEf4VNcpx4BpDolF4lCfAG0mqgX8mWhPJWOYO3Rasp9wt+SWk5qAMtFSC9cPypyr0KNuMH+mFRR17MPTul6ZAaky0yuuINdQQ3m8sTOrpdG8WMge0rHzY3XcdEIlgIu5Q3tJ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748107926; c=relaxed/simple;
	bh=wEBSYd6nZzn5myqgo6YJTmfqDgUD/Xf2oOh5Rskgna0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iS2owMkAFLVJ5YnTiIuOawTMKUZ9sr1SRqIx2YrVWFq3nvirTEGqF12SpXGzmwpWTcqQzGb+t5jIyrPxqhNRXfcPQO1F1yZGem95JuaFF+/VmZ6EA+OLluDviLmXP1suzhOti9YJjGLQsqLYzAl3+FyUBRAXXCbb4YQ2HTpZJ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQ+hmNnH; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3105ef2a071so9107311fa.1
        for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 10:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748107923; x=1748712723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DL93dQv8OmAhNw3HYIP0whT4/Y+A+IJdPikLZdqLrWs=;
        b=AQ+hmNnH+X5qoQQAsE3wH3ypWuurpdkEPUl3WSli1zhbA4jAKU6uvhFjhvmKvaF3Ew
         dk+M8Mj8faN61HCQH4+87PmhmDZ6c1LwrDlgibGpQTAxZFhmPwnEXilCErUHR0igG8Ud
         3utFJW6jaH4xBVXxHtrXdAbprKBByWijlCY93m3ZGkjUvRNgZT/cVvjvpOBTb+Sw4xoC
         KwdnBmc6cUQH21Rh/V7wUCcLNvLIgn96rok9SVZM9jV56MC4TKx4uqgafzsCb7bE9MzV
         gcPkLlOGlzYwOPNCGBKa4+h0reY7VNlsmGaZLoRFASMXleC2j+346/kYfrn5gYuaBVDR
         K6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748107923; x=1748712723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DL93dQv8OmAhNw3HYIP0whT4/Y+A+IJdPikLZdqLrWs=;
        b=J2reF/T8WaVSTv9hDVUMEE9EIdW8DuDY0h7VYr30g5zel0q5R9Xq/cyYuKm4xAZtOa
         iYMXm1rS5EoW94jJoOIE3rQo6Z7er6tCBB1uvKl8Y0zvqdrEYsJTYI7/SZTQHKJZuBq3
         YvajFzf8fc6p19RTg/LhZyzv7Cl0IDHO6afL/wywAxm6m//6NWdYxU/eZD38g2gkbBIj
         BIztqxFLTMtUAo0ANW/5j6SGa9Q4ldhRInRP7YSHTj76AFI14uw59s3L8S17oWm3q5sT
         1BEfRsJ2jpn8JT13O/6aMOQdoqLDE5wOf8R0m0c2u2JfJ1JrX2yOMjufit/hHDXzeQZJ
         fM4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUPppEmEJTz9EbzES23qTx64dp1wn6LsIiAz6K+9H67Chpz3WxKfMJBEco2XrE41Yxp1zSpF8vHFVhYg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/vw90zfWUFI9LAy7iFry7tT5rz8QvI135dHtSYdnpGZFaQWsE
	5O7V9UX0D74M8czpvdqGMpz4kAiQkVZmfdDJ2w+NIBnFICk1pPv580CisIbipqZf8PMKtDpU1sb
	HOFfSurBZs+Xjb2VEF1dURTIr9avbkDY=
X-Gm-Gg: ASbGncvbTyH1k7ZhiYWlvGy6QclMbPPpnQE80OJI0KPeip+Ss7+Qxi4djoP1pKfRsVq
	+nDUAlGeHHcJzBzAS5lBxxuOQqk0W+v0vcIwLWfEpVgA7leQ50wGzdiD9jhkmDoy6Zjn65QuKar
	D3k70PmJGWoXYUGgZsEbH08aHoWpQZqLye8hgKpcBkiws+0w+yT6XZpi0vNWWOLFSRnQs=
X-Google-Smtp-Source: AGHT+IFZ5GWOt74+EDw/OerPs7cty4OIOEpknqy0bVPUPcy2Jv5BhPeTptZxW+pLnBG37QufrQjnk+eGGb2mEl5O+hc=
X-Received: by 2002:a05:651c:3129:b0:310:856b:6875 with SMTP id
 38308e7fff4ca-3295b9bc8dcmr8020691fa.14.1748107922572; Sat, 24 May 2025
 10:32:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415002552.7208-1-ComputerDruid@gmail.com>
In-Reply-To: <20250415002552.7208-1-ComputerDruid@gmail.com>
From: Dan Johnson <computerdruid@gmail.com>
Date: Sat, 24 May 2025 10:31:51 -0700
X-Gm-Features: AX0GCFvXXd_keiJpKTjXLsrP8RJkATSICrFNg-TSsQVCyawWNvtyuqGMDhODKG4
Message-ID: <CAPBPrnvFkhWQcu-9YTgER879SA+_FBYY9PH2+WO8Px1-=Babzw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix comment in reserved space warning
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle bump here, it looks like this got missed? I did a bunch of
digging to figure that out and wanted to make sure to share it with
others.

On Mon, Apr 14, 2025 at 5:26=E2=80=AFPM Dan Johnson <computerdruid@gmail.co=
m> wrote:
>
> mkfs.btrfs up to v4.14 actually can leave a chunk inside the reserved
> space when invoked with `-m single`, fixed by 997f9977c24397eb6980bb9
> ("mkfs: Prevent temporary system chunk to use space in reserved 1M
> range") released with v4.15.
>
> Signed-off-by: Dan Johnson <ComputerDruid@gmail.com>
> ---
>  fs/btrfs/volumes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 4d5c5908300..28521015d01 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7989,7 +7989,7 @@ static int verify_one_dev_extent(struct btrfs_fs_in=
fo *fs_info,
>         }
>
>         /*
> -        * Very old mkfs.btrfs (before v4.1) will not respect the reserve=
d
> +        * Very old mkfs.btrfs (before v4.15) will not respect the reserv=
ed
>          * space. Although kernel can handle it without problem, better t=
o warn
>          * the users.
>          */
> --
> 2.49.0
>

