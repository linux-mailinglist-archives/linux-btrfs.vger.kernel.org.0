Return-Path: <linux-btrfs+bounces-6596-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D07C893771D
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 13:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791C91F22436
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 11:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1E48615A;
	Fri, 19 Jul 2024 11:26:03 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597A67E1;
	Fri, 19 Jul 2024 11:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721388362; cv=none; b=Efg1DEVQV+79Zjh7AyDtRnK70Bo4A9QDvK9OmvmlV0WAfpVXOL0fxtzD7i3MCU0djAqddn1IkCH0lDiX9iGnBtACc7eE7pe/iZp30D9PTJb78Pj70wZFy/oN356IpSsJ8cXstq60Iya58laqjW71+0KL2iuaXMtRbMZTFVoeps0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721388362; c=relaxed/simple;
	bh=yIsOSUBsBAYRwfD1x6imO6+HBI+qJAWJRLOhxKoLMwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cz3O/mWTTvcVc55DRELyoN/pe5E0LM8IpZmw99ZlvcWrH2cj1KW3Aj9SM94rG2DZMmVGWdwiu9nCCW0gfeTqWU9OY47+IN9v/KvPjz/zr3ghZnEwyh0Ohal8ZStpRdEWxbcIIsN1wN3BxhnNf2NtiOggtN4OQXxdnqLHHD9HPpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-64b29539d86so17614157b3.2;
        Fri, 19 Jul 2024 04:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721388360; x=1721993160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qeRKx7HuMSLsGy/oXdGTsw0hVo+ExRNmTFMMWWZzJGM=;
        b=LrSFPCn5SGl0bOZZUL4hbHPEtywhTPzpDXgMp3ERYfK8tz4p7NCUxb8swySYBL44hF
         PJKTjSEdsj/go81y9RiI+Uzrk+jHDJDt4o6nGD+mQybIttk5K20ou9M34k6fPIH3UOvP
         tZHJ8XuEE07itGHC1Bd3HAsBpf3LbPcc0/oOVwXUxAydnwQb4xnCYKp/RX2E5IQxoTGK
         KvlquiBq5bLJy7LaAw4KBq/0v8ARw6qDIq2ner8Zpl1R30ssgNeURzJYYHpJXlT4vTYk
         K+c/KAWU/L98001RG4IRB08y6lzWPz/duOS+OTTywtFRhImENJ0i7V3nnPSS2d1jNLuO
         ZHvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTcCad0rBmlhER0XlGYHPhOYRHPlILlVTQwaLipz9pmKQzNH9W/X9QlE4GbEgIUn3SUI5UETi+ppDtULYAgO1lXraRGTFoVguv8IKv15uHhEg2L9eDkMeGClFdvY+3KcuH8vZjRkbnF5E=
X-Gm-Message-State: AOJu0YxoGP5owHU2qVYosDW3RcK1bVSfWUR4L/yc6tKBSxwIhK+oSjYy
	AA6wFsMUtyd0uiFzD/J6Af6QQ48VQfRfo2N0o/ftHE525vZ5TN0CSTeILp6Y
X-Google-Smtp-Source: AGHT+IFpTfRTuozm/XvRUkchrKtveL1T/wZyssOlaFU7B2c1TAa3F+BMltpl8KZCh5HCHNfW5r4aPQ==
X-Received: by 2002:a05:690c:310a:b0:62f:b282:9f02 with SMTP id 00721157ae682-666040cb87amr63857837b3.21.1721388359681;
        Fri, 19 Jul 2024 04:25:59 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-669541bb90asm4137967b3.117.2024.07.19.04.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 04:25:59 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-65fc94099a6so18436337b3.1;
        Fri, 19 Jul 2024 04:25:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFTRUHxVf94Czg2UkU6Exjc9BCA4BsPOB1cMr+jR2fDj+kh9sBQQwDnVmZ7OwhvgmzaBvdIxHx1zrHXKsmgIs2ZT5HerNCAlDRvhwfqFIwM2CPXma0abLHEARGpnQcnoNWmAbVNSXG9co=
X-Received: by 2002:a05:690c:4702:b0:650:9e71:bde7 with SMTP id
 00721157ae682-666044add08mr67281727b3.26.1721388359253; Fri, 19 Jul 2024
 04:25:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1721066206.git.dsterba@suse.com>
In-Reply-To: <cover.1721066206.git.dsterba@suse.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 19 Jul 2024 13:25:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdURvTtambJKd2uYqbRFYO_oBSsFHBunaXNfzvzqbPqbxQ@mail.gmail.com>
Message-ID: <CAMuHMdURvTtambJKd2uYqbRFYO_oBSsFHBunaXNfzvzqbPqbxQ@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs updates for 6.11
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 8:12=E2=80=AFPM David Sterba <dsterba@suse.com> wro=
te:
> please pull the changes described below. The hilights are new logic
> behind background block group reclaim, automatic removal of qgroup
> after removing a subvolume and new 'rescue=3D' mount options. The rest is
> optimizations, cleanups and refactoring.
>
> There's a merge conflict caused by the latency fixes from last week in
> extent_map.c:btrfs_scan_inode(), related commits 4e660ca3a98d931809734
> and b3ebb9b7e92a928344a. Resolved in branch for-6.11-merged and that's
> been in linux-next for a few days.

FTR, this is broken on 32-bit (doesn't build, good ;-) and on big-endian
(compiler warnings, no idea how it behaves :-(, so you better don't
trust your data to it in the latter case...

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

