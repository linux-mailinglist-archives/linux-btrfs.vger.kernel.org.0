Return-Path: <linux-btrfs+bounces-2993-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 797AF86F967
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Mar 2024 06:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26BC01F218EE
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Mar 2024 05:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2939E6FA9;
	Mon,  4 Mar 2024 05:10:43 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E7628FC
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Mar 2024 05:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709529042; cv=none; b=DSWMVNtlYOzxcOu6vBzThElWoyN8PmnaKIdi9HRxv/RP5KzxpkbfkeWpSNItRi28fW6U8Yi0tfXY+8V3VjmFewCOoKfiArOQ9lraq3/gmUpxdIDVeZxH4xBA47q4xAi1I3TcVXLqcLH6oVij3gYWpWYZShYvd2N4/q9L7YJT84E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709529042; c=relaxed/simple;
	bh=YHI/6A6K34rweZs2svjhE1Dg5c0AJr3DPXMfdQKU3yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hOtq0fc1oS0ool5PJogAmX+ZRjBvUXErURit42csOxk661u3Pf25zhu+MRGVExhB3UY8NXatt2dMiYkh7xxhQfOOP/FzHjAH4chwDwy2GcKRWan8a9Kqea82MRMrrXWupCgtqmGJMPhC0C9qfliBZj1eaxkeGUJfnvULImXMjis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so663437366b.0
        for <linux-btrfs@vger.kernel.org>; Sun, 03 Mar 2024 21:10:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709529039; x=1710133839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHI/6A6K34rweZs2svjhE1Dg5c0AJr3DPXMfdQKU3yg=;
        b=DMMWVYf3R7AG+ZCq8/82E5nHE3Hl9se1d9EuD6sFZZsIpha6NTR5P5gaqeJvTflAv8
         3FPdSd9qsUfGsXvCccFc7TbMx00Qz0aRkLQYYARRkIe8r98j0WCPPqnjezRb+E4Y6ehc
         CE2OQT+155kK4VilWH9FNE3D5CPzZZTIOl87e6Ddbla0qS/DuyVdYVzVBicKik3BkYQy
         xCdjnRL0nG5LubAEp6LMdze3W66Va4NcIIc5zQvNUCWNJ5QpVZcRY3HBH32S2SWh557K
         EaHd3e1zaUPXrvCgZvA8jk2DNnW24s/JYPqffRCGREEGjiopbbY+09HmCwv2RRIftWYH
         1asQ==
X-Gm-Message-State: AOJu0YwYl7TJs/9dvjTGtYEpgMy8ViZZqwsFPsk58NL9at4R0Grxhvqv
	Fx1z5PGf8EyZMFFVvsBxohozmEQExXMpQTaH4HLlo/EaP5mZfXN0fVKgJVnjcBrdMg==
X-Google-Smtp-Source: AGHT+IH14p10lIGJ2zjQ4zkWVXyayjntNxMgXjt5bUIhcfXPWU0oa2M3dCXF2lS8zR3jmYAAAXYkrw==
X-Received: by 2002:a17:906:b84e:b0:a45:3fb7:eed5 with SMTP id ga14-20020a170906b84e00b00a453fb7eed5mr1124945ejb.71.1709529038746;
        Sun, 03 Mar 2024 21:10:38 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id ts3-20020a170907c5c300b00a3d4dc76454sm4363485ejc.159.2024.03.03.21.10.38
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 21:10:38 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so663436066b.0
        for <linux-btrfs@vger.kernel.org>; Sun, 03 Mar 2024 21:10:38 -0800 (PST)
X-Received: by 2002:a17:906:b253:b0:a45:2621:d74d with SMTP id
 ce19-20020a170906b25300b00a452621d74dmr1539142ejb.53.1709529038476; Sun, 03
 Mar 2024 21:10:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708322044.git.wqu@suse.com> <f9be8d16-a1ae-4fb3-8670-c6c7a2615d36@suse.com>
In-Reply-To: <f9be8d16-a1ae-4fb3-8670-c6c7a2615d36@suse.com>
From: Neal Gompa <neal@gompa.dev>
Date: Mon, 4 Mar 2024 00:10:01 -0500
X-Gmail-Original-Message-ID: <CAEg-Je-tpYX5rikHjf3mXeqN1Rj+3Tr9arAift2j+Ycj+ma-sQ@mail.gmail.com>
Message-ID: <CAEg-Je-tpYX5rikHjf3mXeqN1Rj+3Tr9arAift2j+Ycj+ma-sQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] btrfs: initial subpage support for zoned devices
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 3, 2024 at 10:13=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> Ping?
>
> I know this is a very niche scenario (subpage + zoned), and the change
> itself looks very scary, but the change should be safe for non-subpage
> routine (as the new lock all delalloc ranges covers the page would still
> at most lock one delalloc range for normal cases).
>
> Furthermore without this series, there seems be no proper way to support
> subpage + zoned, unless we do a much larger change to merge
> extent_writepage_io() into run_delalloc_range() (which I believe it's
> still needed, but can be done in the future).
>

On the contrary, I don't think this is a niche scenario at all. Quite
the opposite: I expect this to be a *very* common scenario because we
will see AArch64 systems increasingly rely on subpage because 16K
AArch64 Linux is used on two very popular platforms: Apple Silicon
Macs (Fedora Asahi Remix) and Raspberry Pi 5 (Raspbian/RPi OS).

We *need* this series, but I do not have the hardware to stress this
patch set, unfortunately.

The code otherwise looks reasonable to me, though.

Acked-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

