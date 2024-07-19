Return-Path: <linux-btrfs+bounces-6597-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B77937731
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 13:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDE27281942
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 11:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A28D126F02;
	Fri, 19 Jul 2024 11:36:10 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FD21E871;
	Fri, 19 Jul 2024 11:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721388969; cv=none; b=q3Cxp9f7j8SXq0HDWFGfgRhr0h6pe2dKfExcPTF0uWkEuvdUvfSBuM0I5/Q2XGxtxb+mJnCszAcZEnqQbAUbkngB0yrUrMxgwH6T2HcJHz6QTXidNaPwhF4/LZuNJHbi8YqaoRX2YKrBzGzRP4qoBGTqzAwDj+Y3zw3I1mD+Oc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721388969; c=relaxed/simple;
	bh=QoFstspoCX9Jtg4yoo8NJiNSmCMPqUTuZt1qsYnr3Kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNmOtC2PD0pczQLNmx41l3Anl3pM1U6PKfYjAMJbYASugC9/0XG5lMRDgu0b+3L+Hy6lLCEpJ1HoUXIBlXGclYTMw8W5YPkLgBCgRgCfSUYrfEv2T7AmChYvSCsb3ZrNZRL26As7X6erql9N9Nqpp3r7Ya1bTJ9pu+3zHfK0p/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e03a9f7c6a6so1828580276.3;
        Fri, 19 Jul 2024 04:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721388966; x=1721993766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=taEfSVdgkbbpcc/9Q3MIvrB+itVGxceRlFG7LI10Lv8=;
        b=KvVXm4T/YtXXbqF2ZGAD9YpuHruoYczMw3jscdJKD9LDLm/2+vkGQG5MP2xktopbL5
         FPLmRHPCd2h2pzQONae3HUIOkiXkz0Glah4RRjeBkSqrYHM4AGTf+W4FdQkP2sd1JqIm
         wz5qV7Ck6lR57tMFulazm4LlKjH3P3yYyxFEFVFGAOCVJYW1+v8v4/xhGfonhwp6cd6W
         tjczXxtQMIJNqbDl6B7of+qQiXvu2Apod85LuBhy//GUe94PGCqi2PEpca0GV+vSZM6q
         RiHWk2fxe3HBESEYj26s+JGThInsD4N+rYHD9eeKiH9gEo2BgKX0S+5l/GBfnLrRmKGt
         aPrw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ6SRJZR8bucx4Hu9b0Sq9Ep9EgJXWtO+IQJBnIIlNEBm8g5xdafFY/8IwRKxmlwpX3Fh8V2cHXFgremVDP9x4IIJQZJevdgsFgmS/eUCOV54zE98CRG5rnW93yUOaa0yzvo1iOfkpjEI=
X-Gm-Message-State: AOJu0YzOMB0y3cUsGeatefBIrOAdnuxvmOLxr5EYbnpVCDBAObpNx5tM
	xebj4xWW4o9pWvT29baQFqTWyyewGDxyS3QS6JaxG5jEVsPPK7q2l9lp8RHZ
X-Google-Smtp-Source: AGHT+IFcIf2bno2iP8EnbxU+iJNzJZMjE5spiDPQiBytpl6yAESZsTxI/l9ZAXJaByLNGQahpVvL7g==
X-Received: by 2002:a05:6902:e0d:b0:dca:c369:fac2 with SMTP id 3f1490d57ef6-e05ed6b8912mr8586716276.3.1721388965830;
        Fri, 19 Jul 2024 04:36:05 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0860adf5d3sm398045276.40.2024.07.19.04.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 04:36:05 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e05f913e382so1706379276.2;
        Fri, 19 Jul 2024 04:36:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2GtfAm0/aJL2pLFZ1AdsOcLbZUkoGg/CHp/CJzuFPb5X0BqZrXEJL7Q2Qn2gtUYGupG932ua3WpOFO/GlFz3n1hSe7QHkIrwTNZnnC9Hw8LSUbKdqpWXrk0341BqEsimd/tNOARYqFpU=
X-Received: by 2002:a05:6902:f87:b0:e06:fe1a:ffd4 with SMTP id
 3f1490d57ef6-e06fe1b04b2mr5906910276.2.1721388965381; Fri, 19 Jul 2024
 04:36:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1721066206.git.dsterba@suse.com> <CAMuHMdURvTtambJKd2uYqbRFYO_oBSsFHBunaXNfzvzqbPqbxQ@mail.gmail.com>
In-Reply-To: <CAMuHMdURvTtambJKd2uYqbRFYO_oBSsFHBunaXNfzvzqbPqbxQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 19 Jul 2024 13:35:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVW7NZJhsxnp71Fc9=RQR=gXtOXPkSxreR3ZuMDbVxnjw@mail.gmail.com>
Message-ID: <CAMuHMdVW7NZJhsxnp71Fc9=RQR=gXtOXPkSxreR3ZuMDbVxnjw@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs updates for 6.11
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Fri, Jul 19, 2024 at 1:25=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Mon, Jul 15, 2024 at 8:12=E2=80=AFPM David Sterba <dsterba@suse.com> w=
rote:
> > please pull the changes described below. The hilights are new logic
> > behind background block group reclaim, automatic removal of qgroup
> > after removing a subvolume and new 'rescue=3D' mount options. The rest =
is
> > optimizations, cleanups and refactoring.
> >
> > There's a merge conflict caused by the latency fixes from last week in
> > extent_map.c:btrfs_scan_inode(), related commits 4e660ca3a98d931809734
> > and b3ebb9b7e92a928344a. Resolved in branch for-6.11-merged and that's
> > been in linux-next for a few days.
>
> FTR, this is broken on 32-bit (doesn't build, good ;-) and on big-endian
> (compiler warnings, no idea how it behaves :-(, so you better don't
> trust your data to it in the latter case...

I cannot find any other report of this, and don't know yet where it
was introduced, but the bots started reporting this last May:

    3    fs/btrfs/inode.c:5711:5: warning: =E2=80=98location.type=E2=80=99 =
may be used
uninitialized in this function [-Wmaybe-uninitialized]
    3    fs/btrfs/inode.c:5640:9: warning: =E2=80=98location.objectid=E2=80=
=99 may be
used uninitialized in this function [-Wmaybe-uninitialized]

https://lore.kernel.org/all/6655b55f.170a0220.406f9.2e0e@mx.google.com/

and I'm seeing failures in e.g. my m68k allmodconfig builds with
gcc 9.5 due to CONFIG_WERROR=3Dy.

I suspect the big-endian accessors in fs/btrfs/accessors.h lack some
initializations?

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

