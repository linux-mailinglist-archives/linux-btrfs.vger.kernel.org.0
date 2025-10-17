Return-Path: <linux-btrfs+bounces-17958-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A55BE83F9
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 13:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81288741FC7
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 11:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04DA32F75B;
	Fri, 17 Oct 2025 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IleCQVM9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABED0328605
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698956; cv=none; b=SJ7M/m8GuQhyrFAzx2M4B1+DM1delMVzZ+zrsU1P8ERBzhhBbZTbJCSDkZWSnPGs0bn1QmpNFQsrPxi6CTlnJml06eiVSm7D2BK3GWU8FGl7TdqCkEN950mJQ8e3ZwZ2EMffTLg6BqXb3L1t21n1TYmBx1iuW4hQWzk58jZEf20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698956; c=relaxed/simple;
	bh=zuQ/loSY4n/D8RZxzZQ/ZNwe2S7wd7PFF1NZ3EPWkvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DhLIZVLne3lIgUZRrnieQ0xkn+wVSqvuohSFMed3yPfYAjY5DYJE2yoRe/FOh8NanHbFHMAjPCy2CPVhXtbab4ImaqEitl9i5uDehl7I+zJL8x3bg3glPjSsMwLBDYZgZhdMS3+7qFYmr68Mqbkw4FlEqfwJ8K6D30XKyeiLso4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IleCQVM9; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7815092cd0bso18779607b3.2
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 04:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760698953; x=1761303753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuQ/loSY4n/D8RZxzZQ/ZNwe2S7wd7PFF1NZ3EPWkvI=;
        b=IleCQVM9tADgWv0ttW26qAx5hXLBjsXOEpMrOcHJunegEF7hvhGAQCsC55tui9kWML
         JhGrtWeQ3VxyhCcz8bPHHKWm67bxHJTYol+FDN4FE/gS8rAqbasaYbFxGOZKp59AoyrJ
         Yh0deMZ3sL7prh3eBiMeMZvkPDfIUVkjNcaGAQjpA8YzLues3frObtgTzPiRrVxKAHvp
         J0MvYEqlkZkIGrYd0VVfc6PjUIz2CwKQCqCjXx5ACGCYgv38shLRoBN1BnheohZk4HDE
         US3WHMaS7nsLytaOmInIxZGhT7KJSuwKtDO4ZpipGoOvaeXQ26VEH/ttGJliDACn14Do
         zblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760698953; x=1761303753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuQ/loSY4n/D8RZxzZQ/ZNwe2S7wd7PFF1NZ3EPWkvI=;
        b=dCpqC9ZQPmYF6Z3GhM9LsPD8tZH6U2RU7VOv85yklbnUXaGGGNV19RRZeQRpeEEt+u
         /cAVYseK6o69lDpXs2Bs5NJ21Az8CXojF3D4RBdW6fN8UiN+IpbL78oX0rQPQpf6KnFi
         UGSsmijIq5a+AsF5eBs+mGuoQ9f6+sMOtqN45ejCJM/++qrmXgTZcUaI90/cMPfXGBZJ
         MLNWAJB5oi1XBLNu+H/GVoMwOBjIYp1MUsbVaernMkgukqyczsHbx/wbq7JjfVR2mPRD
         BDsw5+yUWppB1n8MmpSJ29iCwnvGFTtAyEqWXLovhRG7dDUXAmNLpNscq/BuD4DU6Hr4
         gn7Q==
X-Gm-Message-State: AOJu0YzQXz615hC2QWs7NdzC5RjgEvBkPovaYmivnFZ7VPHhugyJhkHd
	BNwc5ga3ow1TdFHVydsLAXA1FUeXKvXCE9kxQzAYogOq1Vler/cFaomIDrh2JEvYrggZRuZYpXj
	u2/DM6XGDUYEDZpf/DWwulE0DlTTQ5pbRlssnbuo=
X-Gm-Gg: ASbGncsO6LaqVikimosMGdCCvER2rn0FTeBUg4eBnoHc1EkPOTGcowsjhejApbJrwKs
	9jho/oYNq0kmF9kuSO5KO5qf1x8WQGo6YFVj/IJQs1g60b3bSo0M3HOiw088F08LKZLRrdFY4Xn
	MCwUtUAdAoRpxoZp08haiEudKL3vkPmgz4qnU5GtRMMA0ccxPLoMbVh1/2M0h4HTAhtCEU2kGxr
	bWvkR9E1qHaN5YYYEfyubVdZIT8+NdHfFrC5gDbq4alWZMUCuUK+Kqh9ZjuIGMo
X-Google-Smtp-Source: AGHT+IHuDEUmvVpA0QGMECoeun0a2avO2fATroZRWAOp4tGuNfL4yHoIBNGM+nzQdigyH48ZAXX+NObLE556ayzRcY8=
X-Received: by 2002:a05:690c:10c:b0:781:49b9:a79f with SMTP id
 00721157ae682-7836d381650mr50559097b3.66.1760698953474; Fri, 17 Oct 2025
 04:02:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d93b2a2d-6ad9-4c49-809f-11d769a6f30a@app.fastmail.com>
 <20251012085256.8628-1-safinaskar@gmail.com> <19dd908b-12df-45ad-bde4-ab7281557608@app.fastmail.com>
 <30c367f1-f65d-4ba5-a4a3-776bb308a682@app.fastmail.com>
In-Reply-To: <30c367f1-f65d-4ba5-a4a3-776bb308a682@app.fastmail.com>
From: Askar Safin <safinaskar@gmail.com>
Date: Fri, 17 Oct 2025 14:01:57 +0300
X-Gm-Features: AS18NWCuVr95uGW7LLq0yFW6nq3peQQ10y08Kci7VofgYxx1JquK4xbgzgcvLUM
Message-ID: <CAPnZJGAdsJ2HO+x+02BE+DhOAfgoEUDyqBTbwq4GgwqiOYp7Pg@mail.gmail.com>
Subject: Re: 6.17rc5: btrfs scrub, Freezing user space processes failed
To: Chris Murphy <lists@colorremedies.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 1:15=E2=80=AFAM Chris Murphy <lists@colorremedies.c=
om> wrote:
> I'm told the fix is already in the systemd I had when Inran into the prob=
lem. Fix is in 257.8 and I had 257.9-2.

Then systemd is not involved.

Anyway, a fix for original kernel bug is in progress.

I tested this patch and it works:
https://lore.kernel.org/linux-btrfs/5517a3cd-1afa-4db0-bf8b-439f3ba410ed@gm=
x.com/

--=20
Askar Safin

