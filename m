Return-Path: <linux-btrfs+bounces-4841-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A8C8BFD50
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 14:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56FE42811BB
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 12:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37D250A7E;
	Wed,  8 May 2024 12:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqsT1m/R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5823EA71
	for <linux-btrfs@vger.kernel.org>; Wed,  8 May 2024 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715171952; cv=none; b=IMRoOO82nqb4wPiUQTkCR60SCdNYt+5CbCZxZQrcNvZQHX17BhDuSjhlfTVWXfCgtmy9XKsqVG5hkr+25bfoSksANrMWFEyEci89+XcmRl1LjjeRMB8u3oItj16JqaWTLz2wBvxwdrTtwtZY7Tz1rmLC6lHJxMzm/ADHjqO2RZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715171952; c=relaxed/simple;
	bh=P+iDxl4sp1QT61TyPF80KorTNwcjQvg3F34rv7d+g4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KkjTtx/SW/itF/ZXJnMAQmlIblzmEpH+jVZQGCRjpwWqXqyVxPnXTJhAF+nKm/OzK5UPAUnVTDZw5zZdvBebszm3b8zIXsjLv9lwlfKJ3018TTjnyY2sPulMDQBItbi/E5rJK2VgFjeOPNsarFJfyLaCkU97mf3kcQTWu+bf2KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqsT1m/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B12C113CC
	for <linux-btrfs@vger.kernel.org>; Wed,  8 May 2024 12:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715171951;
	bh=P+iDxl4sp1QT61TyPF80KorTNwcjQvg3F34rv7d+g4w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LqsT1m/RUgE8SE0LsteLaCqGGdNJLsAgVvStSsBK240EIPQt98cOxCjmMbRHDidtD
	 CSFmEKv24MO15j7paJBhs9oZhjr5VTt+f/y59gUYzOhPERn1Wrpd1gChoM/1JNQn5G
	 r+9mHOiJ4D01FpeW/mtS29/AujHlBopw0QGNrlGnGhkwKHW8TW30UAVFPLeAbcnnJB
	 n3kqlaN+Gy2TmSfyCVqo01hxZupLAG8cE4btZ+PNM5DDURPvIVmeHg9CHscO34tlTF
	 hwN8zOQ2TLnVCs8n9Y0eaFtlh34HhXLwhftpW3bFqSRwk/mG8/1XhLM1BppgfhVzZf
	 yiGQme6TBTgSw==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59c5c9c6aeso910317966b.2
        for <linux-btrfs@vger.kernel.org>; Wed, 08 May 2024 05:39:11 -0700 (PDT)
X-Gm-Message-State: AOJu0YwukT+A9Bgck4s/wzGZoj2/JMYv0R6iPZjDIeufLA+ZTRd6X1GH
	X3rEx2MxeHusgLOmeyMqnVLzT9IRvggOspwhq4oddiUCjvhkOZb34OhUmtz9McgoiDplcwIfpvH
	F3kOyJinyBgJsQvnZk/F/CYxIYhM=
X-Google-Smtp-Source: AGHT+IED+6sDM/MmuISPwHPO3kNKODcrX5IuToU5b1aGVqKsDSyFdT+X/S9wrxsKiJg8DQpvpFSdAwRogPFRrdFO/iY=
X-Received: by 2002:a17:906:fb85:b0:a59:c577:c5cb with SMTP id
 a640c23a62f3a-a59fb94a413mr185683666b.10.1715171950310; Wed, 08 May 2024
 05:39:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508114016.18119-1-jth@kernel.org>
In-Reply-To: <20240508114016.18119-1-jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 8 May 2024 13:38:33 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7v=VmF9=_ErMdsKxwQANgCZ6wjiryPMT1YUuRXMiYyKg@mail.gmail.com>
Message-ID: <CAL3q7H7v=VmF9=_ErMdsKxwQANgCZ6wjiryPMT1YUuRXMiYyKg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] don't hold dev_replace rwsem over whole of btrfs_map_block
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 12:40=E2=80=AFPM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> This is the v2 of 'btrfs: don't hold dev_replace rwsem over whole of
> btrfs_map_block' sent as a series as I've added a 2nd patch, which
> I've came accross while looking at the code.
>
> @Filipe, unfortunately I can't find the original report from the CI
> anymore, so I don't have the stacktrace handy.
>
> Changes to RFC:
> - Incorporated Filipe's review
> - Added patch #2
> Link to RFC:
> https://lore.kernel.org/linux-btrfs/2454cd4eb1694d37056e492af32b23743c632=
02b.1714663442.git.jth@kernel.org/
>
> Johannes Thumshirn (2):
>   btrfs: don't hold dev_replace rwsem over whole of btrfs_map_block
>   btrfs: pass 'struct btrfs_io_geometry' into handle_ops_on_dev_replace
>
>  fs/btrfs/volumes.c | 52 ++++++++++++++++++++++++++--------------------
>  1 file changed, 29 insertions(+), 23 deletions(-)

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

>
> --
> 2.35.3
>

