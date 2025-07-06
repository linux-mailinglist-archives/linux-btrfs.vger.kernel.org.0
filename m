Return-Path: <linux-btrfs+bounces-15270-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBDEAFA35D
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Jul 2025 09:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4CC23A2A07
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Jul 2025 07:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA3C1B3925;
	Sun,  6 Jul 2025 07:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kx+wrIQv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290FCEACD
	for <linux-btrfs@vger.kernel.org>; Sun,  6 Jul 2025 07:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751785283; cv=none; b=FlLaCNDvBU9vBqFkczcXLhQ/C/7hO+LVUvUe0j4wV8y97UjArgsGqEkd9rTkkXcCKozao3dmX748Z7pEFHKomW/kItSrxJAhfNnop15wLYppjIVdTGQqAstR3H936siaXImnRdU2JbnJGYkgaOUZGWhhqVq8yeGpDhvpPkQcVbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751785283; c=relaxed/simple;
	bh=Pyh0WO10ZoP3+xuXGZ9oa9a+HSz1PzxzsoznYbcDe+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=EJjKYkK+OUcXU2G3fne3Ig3tcLUa98Ll4Wto7KY4hdNUfPtFjT1Jws1320SJSA75YSHi4COCTTpDa5pbHDVvd9OIZ/nORNqygnsEBhtqbMxQLAaxr0AslH5b8uw9Kc9UbqYUoWkvz2GjVqPSxj0d9bqIp+M7uZQvdi+Mj590IGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kx+wrIQv; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-553b544e7b4so2039454e87.3
        for <linux-btrfs@vger.kernel.org>; Sun, 06 Jul 2025 00:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751785280; x=1752390080; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pyh0WO10ZoP3+xuXGZ9oa9a+HSz1PzxzsoznYbcDe+I=;
        b=kx+wrIQvvo4SYxczgYzkSGXaUvHC7+d4vUn6M+yxtRqE8dOkQWx5BPEBbPgNrQaXfB
         S2w9kyEbcDBKJIm6D79kJlej43DCGYw1bjDNpNfR/vrFZ6/yiWuEfwQCWMICZBIUCkph
         ajgLLXyE+rzB2/Rab1NCb8IJ8AMAXIAmVr3jdp8KhSKbwVuXExgt1PNgz0A+J7smR44F
         F98NwEdHVrSXjg2wyXgIib/vmU2PlEWsryB9uTogXKOiIXy7FVNIGlEK5AhSwEcmBVsj
         hwCN+PjzCt/YSNjZ8huCdLJbAK5yaU1jNc1Ubvx9xo3/QUZ5CkGajzESsBT6aZKSWsh4
         YMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751785280; x=1752390080;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pyh0WO10ZoP3+xuXGZ9oa9a+HSz1PzxzsoznYbcDe+I=;
        b=vn+XJayPsT6i6v+5cExE1iGNg9OtaBxBhvjBnbYeAoYBJqP0HxyKbAs6N/vlimm8gr
         1Mu0LSUz9NFH88HXuYzFFWwi/kA1QwjBQE0u0sviH7fWVW+0t8sH1X6X8ddKgm4EadHU
         xBxF8G21XhZ1A/juyag352q4ysun46HKOdEU+YY4/L5csN19eup8ywIjZtBIaX0gkRFj
         b1mr/9yEk94OKMONiV/2OHxwSVV6Nlp89VCwWghSebyAjsCffhdt1yVdaLP2t20pTU9i
         7kwjum5YUAC2MfveUFj3NKr/P3hJMdVjINHxIzNyb+g2sVvKPVrJmnAMIZaErbXiwtna
         pZAw==
X-Gm-Message-State: AOJu0YyPIQNL1Lg3pLs3CKbm2x3iNpivxzsyBaWKmKV9F2+vSMX0yFhn
	AUMnbQzJp9GuGZ+1QPtGDKCC40QkkYcuB4ZEU9gNFz/LWrREBoXXcoRSePjkQck0JZzJmLFYN0M
	hLNshsPodAfMRw4TSy774jfyvTh7IJd65Vb2W
X-Gm-Gg: ASbGncvIaOAbZzXOJRTatpt20ild/st2k0rTDBrR2K3Z+ssVs09lcxmHMt10ff57fZ9
	GF8eC8LHylxA4EMX9dDY9aVwOIrtpe0Q8f1O+xGNCKtsxy00AECJLmDvYXuOk1EFo6Nic1QkXxq
	Y7jBRoMeKZTnZxFy9J32O1k89UHJQoFJQixFFFNQI9DwTd
X-Google-Smtp-Source: AGHT+IGvYJDbJ6mK0tevnq3hN5UBKq6ltWTdaVTqGwESj0SdlbCRnzCtY0lVZvYkcudmIAfEsfIquVMw+Jb8hokNqMk=
X-Received: by 2002:a05:6512:138a:b0:553:35ad:2f2d with SMTP id
 2adb3069b0e04-557a19df4a3mr2123143e87.18.1751785279708; Sun, 06 Jul 2025
 00:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPYq2E23F7VdgtwCydEVa9wdomEVbQUsQPgfyLVh5ac=KLBEdw@mail.gmail.com>
In-Reply-To: <CAPYq2E23F7VdgtwCydEVa9wdomEVbQUsQPgfyLVh5ac=KLBEdw@mail.gmail.com>
From: PranshuTheGamer <12345qwertyman12345@gmail.com>
Date: Sun, 6 Jul 2025 10:01:07 +0300
X-Gm-Features: Ac12FXy-hi9ovB2gXoli541tdJkMiG7M3E4zyQEJDBuDEZ9q0Xxr4BWGXHify2M
Message-ID: <CAPYq2E2BSbW=8mYOO2NxJtcXPgPZ75nzH8C014-2ncyFb64L2A@mail.gmail.com>
Subject: Re: [help needed] parent verity error on HDD
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reply to this email thread:
https://lore.kernel.org/linux-btrfs/CAPYq2E0yh0cfM9AXNqjHpz9dLnzRa3xZ76vJEKqsM9-jaJpktQ@mail.gmail.com/T/#u

