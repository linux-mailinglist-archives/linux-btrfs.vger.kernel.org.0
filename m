Return-Path: <linux-btrfs+bounces-19869-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF995CCD89E
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 21:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B388301D59E
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 20:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AAA2C0283;
	Thu, 18 Dec 2025 20:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YdfZq/lB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C0722DFA4
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 20:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090069; cv=none; b=V8XEr5HQWr0C5uEXxFueXo1MCiR90qyBxSzf7hMs7Wo3zSCdfNBqf7kKcjsw8KB71ZdE86xgqcgHQjx5eF6hoBavs68n8sEtm3qO26qLRgiV/CMBKKeKT/6J7qqr27VlXKIQCpv9Wm58TtqduExITNwxWuQ0YGGuNKp2NVN6whU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090069; c=relaxed/simple;
	bh=+RowUUrYtzXa4i9REDNRtB7NHjBBJv9ASqbqnaOrOgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DY6obUzlG1OjX3Il9zag6Gk2XPINRYVLnZqp0rvAv3zLsSauTL7HWQ78Qu/T8JJhmE1wi7GibX46hkF1DAcQzVlm5HHvLgYM2ZUc4hLguJOC5hhiA7kbgTmJB6Hzzm0QmIDEpdFWSo7MNRnVCIE+5oM3BN6qXhRvHDuiGDbruoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YdfZq/lB; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6496a8dc5a7so1382889a12.2
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 12:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1766090066; x=1766694866; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AFdyme3OdkfY6SG6LYuzpXFnNfm347qWal7RaQqaQwE=;
        b=YdfZq/lBtcT85oHj+5X6OPGw15H6q/cdk42K4YZ/h+fQgHY8MlIv3yQSmW9KRksu2L
         cHJgTGNJnCjYcSx2k/D8h4CH6J7fPihJPqxNmx1LVLPK40Jp3t4G6qF+sHuJI2QFDdqx
         xU2n28E61NqVpYB3LxAZsEL1F/s5WAgizN2j0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766090066; x=1766694866;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFdyme3OdkfY6SG6LYuzpXFnNfm347qWal7RaQqaQwE=;
        b=P1/djkM0b8aeRWJZpvk1WVyvfXev4aR8f9gw/gsI5WbM5p8xhCyN+7+iWbyPq4sWDf
         i58sHlbquQkBk5z0v7oc/OE9MCkdcIysRVHB1xH1/HO/8xkPdGaSG1ESPZbWVZj/TQMy
         54NTi6stSOMpMsghxvmhydHYyieYmultln9t4lOUz6OUSd86EszjPt+NTWn97keebmF6
         Capkx/4VnNUZyAggXwwFUcPMro4dlf9B40cKlp7pMzJU1dJfLhCcSzts1SuWwkLP0ceQ
         JS0JYSbTf1h0iv9HIiotHwp+vfhcMyWtW6pm12bqGpacRSPTdrj8BxVAFUYsx2+MR+bD
         faWg==
X-Forwarded-Encrypted: i=1; AJvYcCW6xlioYj8ZREosGqe3Mu1rbb9DYeHwSf5vDMeTw1+co+FaczIcch3tZ83TQ5q5UfMR2GNrlm97R5xe3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXYjjJ11yUmpv2ZRP9DWF5jm8tIU8QEocrs9YDbKQE9oYfcmCp
	+W1wxUAghoevTrzVRhqg/o+PD40VoBzh5BOMlDUQ24E/XzO8EDwXeM6ZktiFJ2J4gm7eFMGgHac
	u3Q+Ank5x8A==
X-Gm-Gg: AY/fxX7xiCxxgG4V1U0ul+/DKl3RConkYQ3nxeo+9QtdnxySMieWMfwBx8tbsog0Eld
	InhP9TRng60zU8z01JGZZOCPlilzuir57zile9/u5eIEvIFpVOtRr1zu8WzYAnVmkrI3mcDiwW5
	vTxRJNTo3HESZMPj2l3j9NFVoE+AlmJZi1ARDBczgPGK+V4PK7toJaSoU88tlHKmkEcOjpng0d4
	RsdsEyP7FLu3pIs8t3gHikfB9glgJPOSdF8HosHcLSJbNQNnWZWVzNa02fAjUzf7H+8jmLmBcR2
	yfY7Dr5L6I13mvCa87+1YJ1Dxlsbw0DngVvDUXmFtneGy/Wt5e4TRfLPWTJ1o3GSb0t5yqA7/9N
	52eOQudzNlva/FoSsP+2w4bs0E7K630NUw3MuDPl6T6CqDldhav2LJ/Et5OOHgh6XYfhrR5st7V
	yvdRjktoxdnSrGFuKu5aYule+rnuJ4Ha5OWWMYRzx6zWAFUrJVQxVl93B26Sd9
X-Google-Smtp-Source: AGHT+IFkYJfxThtQVcgyDq+Jm+ryvDWfjY3p2hzDTla+6rXJ4EaT3kquyHEkdHDzUe1clpcrPp3w/w==
X-Received: by 2002:a05:6402:5209:b0:64b:4152:a8f2 with SMTP id 4fb4d7f45d1cf-64b8eb72a53mr612771a12.29.1766090066161;
        Thu, 18 Dec 2025 12:34:26 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b91056726sm343074a12.10.2025.12.18.12.34.22
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 12:34:25 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64b92abe63aso244133a12.0
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 12:34:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWV7y2+8zDSpw+72D6hlTVvTWv96OeDWcJPfw64tVAWwnYIdJedZQ2zoR5LJz1Y3p0i0o8ieSjfVV/D9A==@vger.kernel.org
X-Received: by 2002:a05:6402:1ec8:b0:647:532f:8efc with SMTP id
 4fb4d7f45d1cf-64b8ec8f844mr669213a12.33.1766090062459; Thu, 18 Dec 2025
 12:34:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218-remove_wtype-limits-v1-0-735417536787@kernel.org> <20251218202644.0bd24aa8@pumpkin>
In-Reply-To: <20251218202644.0bd24aa8@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 19 Dec 2025 08:34:05 +1200
X-Gmail-Original-Message-ID: <CAHk-=wjrNyuMfkU2RHs28TbFGSORk45mkjtzqeB7uhYJx33Vuw@mail.gmail.com>
X-Gm-Features: AQt7F2qOKBa-zo7QJgMQveUGo5xuaKkhNSphimTCrBEi3RG5l67qg5BeTDIQqhM
Message-ID: <CAHk-=wjrNyuMfkU2RHs28TbFGSORk45mkjtzqeB7uhYJx33Vuw@mail.gmail.com>
Subject: Re: [PATCH 0/2] kbuild: remove gcc's -Wtype-limits
To: David Laight <david.laight.linux@gmail.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, linux-kbuild@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Dec 2025 at 08:26, David Laight <david.laight.linux@gmail.com> wrote:
>
> One possibility is to conditionally add _Pragma()

No. That compiler warning is pure and utter garbage. I have pointed it
out fopr *years*, and compiler people don't get it.

So that warning just needs to die. It's shit. It's wrong.

The sparse patch points out that this *can* be done correctly if you a
compiler person doesn't have their head up their arse.

(And no, I'm not claiming the sparse patch is perfect. I'm only
claiming the sparse patch is _much_ better. Bit tt could be better
still, and there could be other valid cases that could be warned for).

The "warn on type limits" is idiotic. It expects programmers to have
to always track what the exact type limits are, instead of just
writing safe and obvious code, and it warns about *good* code and.

It's exactly the *wrong* kind of thing to warn about.

               Linus

