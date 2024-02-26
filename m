Return-Path: <linux-btrfs+bounces-2821-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39745867F67
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 18:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740BA1C2218E
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 17:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3F312DDAB;
	Mon, 26 Feb 2024 17:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shflZx3m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A48B1DFEA
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 17:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708970179; cv=none; b=YnZgEayfScvcwAHytTjd7+q7PPvwEoMictGV+17L7PR0tj4EafEfQR1ukhIj62pjFw0Y4TjTkLPoQEb8mj06i3IsqyiG8cQ8CRqr+psG8srLtjlgaKl6gQtnLQhZqmtTkfRtzL+4hRb2VsFJbobsy2Mrt4vb1Lstw3gtsKMXH40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708970179; c=relaxed/simple;
	bh=ZocOUZL5CikMucuweXwZahwJEV1P0wzWYaK5eQjPVlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dWAz/32K7gS7XwTPvB4QniSnwaKsw4qb4YUKQHG/a+/CUHvTs8AxU6DRRyBVH/eHpB1118oJ6OOwHb3bmF+Nas1CNXBbSW04Wx6ODc1RxEpmduTx1sXZEFlq/K2E7ShC8EAq05Y3kZMFJcNtK2nv9ajV7lyAcHK+iPLFp5+mshY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shflZx3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B43C43390
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 17:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708970178;
	bh=ZocOUZL5CikMucuweXwZahwJEV1P0wzWYaK5eQjPVlU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=shflZx3mPAbKjqlvDCTpfpTl1sDJJRBt/54Sph4ILca5CdS+qw6/zf/zkA/v93FSs
	 elAXq1wMnnx/FnblpHghkylDxAjKC+BoMnWbxp6MRihh0UgzO+78PrChrx84eUMGvS
	 iEER0lF3GTPHgEi+dmZ53zCmUCRh6Fb6IhX6OtVpNuYwWoOu3MDSeISIG7Ac0a7ST8
	 YZmFqFczSLxpA6LDRAjU8A7G8rBN1UrxrwvpX3FIxM58hqiIadVBm3V3UfHkXmnIPU
	 vQIXaB9hAxysSB6y8qLCvtlDC37kO+ujJtMMkaBlt7O0LVXl63fzwo/7UobUUrQ12S
	 muvzOFz731B/Q==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3f3d0d2787so331849766b.3
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 09:56:18 -0800 (PST)
X-Gm-Message-State: AOJu0Yym8ip60McM8yvlYNGDg6xDf6lv63+i3pPEQj8tifZcTSFIHIKm
	qYl1IAmvHioAtJdHNAGGcQnKMPgJ31EsTkzZHkiS0KcU0Z/A9OFo80I+GWrE6y5silZj7GK8Ax9
	M3DgpJK/t7zC9Kr8raibPrevdKuw=
X-Google-Smtp-Source: AGHT+IFeuxhza981uHLB7k/g4BG3wmr3flmyW+SLKFKZdHzIyQMXc1SaTth5KkLEgPsApkFQXA4ynYCdewdPc8LDMQY=
X-Received: by 2002:a17:906:2749:b0:a43:9857:8112 with SMTP id
 a9-20020a170906274900b00a4398578112mr273624ejd.20.1708970177174; Mon, 26 Feb
 2024 09:56:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708429856.git.fdmanana@suse.com> <5ff1a68f4289d5bb870a499b248d329893d417ae.1708429856.git.fdmanana@suse.com>
 <cf24775e-a9da-498e-93c6-8a2c8009f53a@dorminy.me>
In-Reply-To: <cf24775e-a9da-498e-93c6-8a2c8009f53a@dorminy.me>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 26 Feb 2024 17:55:40 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7vcQj_4KoXaV+0274GUi=HBEkB_FLgEy+xEDqh5LW9Cg@mail.gmail.com>
Message-ID: <CAL3q7H7vcQj_4KoXaV+0274GUi=HBEkB_FLgEy+xEDqh5LW9Cg@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: fix data races when accessing the reserved
 amount of block reserves
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 5:39=E2=80=AFPM Sweet Tea Dorminy
<sweettea-kernel@dorminy.me> wrote:
>
>
> > So add a helper to get the reserved amount of a block reserve while
> > holding the lock. The value may be not be up to date anymore when used =
by
> > need_preemptive_reclaim() and btrfs_preempt_reclaim_metadata_space(), b=
ut
> > that's ok since the worst it can do is cause more reclaim work do be do=
ne
> > sooner rather than later. Reading the field while holding the lock inst=
ead
> > of using the data_race() annotation is used in order to prevent load
> > tearing.
>
> Would READ_ONCE() be enough? My understanding is that it should be
> enough against load tearing if it's aligned, and I think both size and
> reserved are aligned? But I'm always learning more about how to do
> things right.

READ_ONCE() works if it's paired with WRITE_ONCE() in every single
place where we update the value, and there are many such places.
Besides the quantity of places, expressions like:

rsv->reserved +=3D X;

would be become "ugly", like this:

WRITE_ONCE(rsv->reserved, rsv->reserved + X);

