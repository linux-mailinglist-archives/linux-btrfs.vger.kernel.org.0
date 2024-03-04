Return-Path: <linux-btrfs+bounces-2995-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AC386FF7F
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Mar 2024 11:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0753F1C22EF8
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Mar 2024 10:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C232374F7;
	Mon,  4 Mar 2024 10:52:08 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CAF364C8
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Mar 2024 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549528; cv=none; b=MKjwnMpjI++zWhhaWtWzLkhBOCfnV19vDdeutq1AtgvCWmUWvMu8bMQpYWAkWz4MyhDy5WfkZH08UpwL5OmbYXOU8hYB+YKo+axoK3g0l9mkgMy4H60c38JPGvllqMS+Qb6dANn5IY7Z9cHhO3cx8sBMtyuQPvoVtYBOm1GvNZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549528; c=relaxed/simple;
	bh=7XqcRjFSwqo6SQR85tvHet7p2snaIQUYwA7sx1nCx/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7781+Nup8FAnAEapO853AssH+jMmcaNkn/vNTT78UVj9PnUw9+y/sgA6t0EBqaHJZ3Y74+X2iyouQRflx+9OzUpmrVWlkiZTvjF3NyJ6ay9cpQXEF1MnwXOucUctx+WGh1LrG3BI3iUZR0uFhdWVW1OCO47p2FLVq7LaDW4rOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d2ab9c5e83so42481021fa.2
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Mar 2024 02:52:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709549524; x=1710154324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7XqcRjFSwqo6SQR85tvHet7p2snaIQUYwA7sx1nCx/A=;
        b=ZTymhLfUOC4bGN8Gu63I0l73LT7eBvI9LpYz/ILyois8t76zEtSI6yCYPdQ8xbq1Ab
         P6SAB4klqjCqVYoIBzVDq6Yq5uMaB3YMRsCCR0kTcCJBs8JiDcx+R0MeGBbxhc0qT6fU
         dcU9L3eecIVD9wLwSAyJncT0dpwZWmQTczs94+ZIYCBjJYh9RdR2mUjVKTCXMzRC2xW1
         dG7FBttDaRbZ4BHgikAFBiH3joAq0eg+FOFac897QeErc/W62yeYRAg1tyr3m6theTdf
         eyBq4R0odDpyLAVxjx/OWUQqnACGoFXKg2wBJ43qekmC9zgkiPP2L/KNpQW5847Ixl/Q
         fiJw==
X-Forwarded-Encrypted: i=1; AJvYcCU21ZUlcUa+VgZM70XNRPCOQKlmHKws6Idc+SLA08EeKhWwj9n/6dY/YMLjmq67T0esvrO2AoCbxy1+7o/ZcTHRmIww2PYue4wRxjI=
X-Gm-Message-State: AOJu0YySGDrBs81nSvPTx1YnQelmmNvT+YfQRq1tjvxPPekZn+/VNfOY
	APO1MUqZcSt7PtqWkL8r2yeLOolHYuLYAXv+ngWsPmPEl0+8XuNfsJL61RKI/OjVHw==
X-Google-Smtp-Source: AGHT+IGJ3XluPSj6xWXptPUSFEJhLxrj0sC3THbkoj/E86H1UVbVc2TPeIekfRh+kH6GkdfeuOKhWw==
X-Received: by 2002:a05:6512:3a5:b0:513:3fa4:3f22 with SMTP id v5-20020a05651203a500b005133fa43f22mr2614939lfp.35.1709549523347;
        Mon, 04 Mar 2024 02:52:03 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id gx9-20020a170906f1c900b00a42ec389486sm4658214ejb.207.2024.03.04.02.52.03
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 02:52:03 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso5921447a12.2
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Mar 2024 02:52:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVonqouowJUpmWO/aKzlTRFgfaUuRli2OJJjtsQ3Y8JWtFTLwBh17QHg6U3S0Ro40XBTvczorNCiQ6e87tpomzR+s0hH850AFBefJ4=
X-Received: by 2002:a17:906:5a9a:b0:a43:bf25:989 with SMTP id
 l26-20020a1709065a9a00b00a43bf250989mr5963793ejq.9.1709549522879; Mon, 04 Mar
 2024 02:52:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708322044.git.wqu@suse.com> <f9be8d16-a1ae-4fb3-8670-c6c7a2615d36@suse.com>
 <CAEg-Je-tpYX5rikHjf3mXeqN1Rj+3Tr9arAift2j+Ycj+ma-sQ@mail.gmail.com> <e4bd611d-1187-4f91-aee8-91a028ab11b2@gmx.com>
In-Reply-To: <e4bd611d-1187-4f91-aee8-91a028ab11b2@gmx.com>
From: Neal Gompa <neal@gompa.dev>
Date: Mon, 4 Mar 2024 05:51:26 -0500
X-Gmail-Original-Message-ID: <CAEg-Je_j6ipc11atau=QKCS++usCu+0T3=w9GsZ0gy=RGAAbjA@mail.gmail.com>
Message-ID: <CAEg-Je_j6ipc11atau=QKCS++usCu+0T3=w9GsZ0gy=RGAAbjA@mail.gmail.com>
Subject: Re: [PATCH 0/4] btrfs: initial subpage support for zoned devices
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 2:32=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> w=
rote:
>
>
>
> =E5=9C=A8 2024/3/4 15:40, Neal Gompa =E5=86=99=E9=81=93:
> > On Sun, Mar 3, 2024 at 10:13=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> Ping?
> >>
> >> I know this is a very niche scenario (subpage + zoned), and the change
> >> itself looks very scary, but the change should be safe for non-subpage
> >> routine (as the new lock all delalloc ranges covers the page would sti=
ll
> >> at most lock one delalloc range for normal cases).
> >>
> >> Furthermore without this series, there seems be no proper way to suppo=
rt
> >> subpage + zoned, unless we do a much larger change to merge
> >> extent_writepage_io() into run_delalloc_range() (which I believe it's
> >> still needed, but can be done in the future).
> >>
> >
> > On the contrary, I don't think this is a niche scenario at all. Quite
> > the opposite: I expect this to be a *very* common scenario because we
> > will see AArch64 systems increasingly rely on subpage because 16K
> > AArch64 Linux is used on two very popular platforms: Apple Silicon
> > Macs (Fedora Asahi Remix) and Raspberry Pi 5 (Raspbian/RPi OS).
>
> In fact, the above 2 platforms further prove this is still a very niche
> combination, at least for consumer hardware.
>
> Apple Silicons, you know it's the usual anti-repair and anti-customer
> Apple, there is no way to add a zoned device natively, and if one goes a
> convertor/dongle, I strongly doubt if a SATA/SAS to USB convertor
> supports APPEND operation correctly.
>
> It's possible to go thunderbolt -> PCIE -> U.2/NVME to attach a ZNS
> device, but I strongly doubt if any Asahi Linux user has such hardware
> to go in the first place.
>
> It's the same for RPI5, I really appreciate the performance improvement
> since RPI4, but the IO is even worse than Apple, and not really get any
> better even in RPI5.
>
> For my environment, it's indeed aarch64, but with a better board with a
> lot of more IOs (RK3588, 4x PCIE3.0 + 1x PCIE2.0 + 1x PCIE2.0), but it's
> still not ideal, and I have to go tcmu-runner to emulate a zoned HDD.
>
> Unfortunately, we're still in the wild west of subpage world.
>

My understanding is that some server and cloud platforms are planning
to move to AArch64 16K pages precisely because of those two platforms.
So yes, it will become more common, not less.

Even Android is working on moving to 16K pages now.



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

