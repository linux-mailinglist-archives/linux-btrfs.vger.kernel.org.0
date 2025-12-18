Return-Path: <linux-btrfs+bounces-19856-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61993CCB380
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 10:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B285F300FF82
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 09:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D11F331230;
	Thu, 18 Dec 2025 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCX6rCvl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE33B21773D
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 09:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766050601; cv=none; b=TX5H0VZoy/kptpra2xjuWEbq9+8VOWDW2b9ZDRHSDCWESjyRLFCH3z37Sea+DiuDruM0nRnVsoXLHZyF+Ji3eSPk/1QZpRzaEA8U9p19ROKpJkn+CGydMEIBt18LvPgcNAZT4tgUQjhKRGmOSClZTSIra3Cp4tmoVNRFK8kSMG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766050601; c=relaxed/simple;
	bh=TkiFuc115zhqrCAyDrxjWdTtre8ap8aOdizXh/yaXbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SVu0Z9r5xyq2WhBPvZcKP5DMCBkw1s3GEZDzI9Ru8RCNlT75u6qdI2ri5MH+p2AagAyuiVzITSaF89/lIQiqUVMLPZhLyyVv0jaqLooW3itXjOUbYM5EsZFAFBUcMKW9jVTb0PNMEPDcsgNst3DojTkNoMubiMTUszCl+NphPo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCX6rCvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60970C4CEFB
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 09:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766050601;
	bh=TkiFuc115zhqrCAyDrxjWdTtre8ap8aOdizXh/yaXbQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OCX6rCvlt+D9fxUYwN879zDo+eakGc2fDqdaWd+NzDhziTnQpir+GcEI3XUcb/utT
	 JvhHcIa3SjBX5f7OHkOkQVgVJ97SjqeTPAmLv0iWo/cKfCJe8n8zLPuLlNpq6PuUYK
	 2DPF2pPGltVRxh38Fd5ZD87yOoO/IdNBQx7f4WwAzn2fdtxzc/wFIKb9ftkgLGYzQ9
	 Zo5OT/n39BOyfZDPPrENivMVo4+GzQIP1iVS28u9hHjmv+d3/SEXmye5eaaaGbfWdp
	 p+xQRH2cnRrv4Lda/58JXBLt3XqDSpRSKr3hbndNERrwcwRO1K9LMHnCxrlrbwzQFR
	 66T8PAj8FZrnw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64b791b5584so174507a12.0
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 01:36:41 -0800 (PST)
X-Gm-Message-State: AOJu0YzvbzQzalUIo9sNoQoa1Wjds53kaQiSIBCX3astajHvIgsGUBES
	rklawLVa6/6lK6mPR6cEiHaHVY4Tvt/i55F9xAf1irfHlyLSgGAMzqC+EzcHfgxrHZqvN5M8Bed
	W5tC6StpRLLNAFei71SrtD/svK3YTLHQ=
X-Google-Smtp-Source: AGHT+IFqyivWis7nvP/Jn7MxlFk0VOsNf80g11gi7FMRH714ABMjXh32QrblBa4fhjh2leTW40z4ECVnt8FJGSRSFVA=
X-Received: by 2002:a17:906:6a04:b0:b75:7b39:847a with SMTP id
 a640c23a62f3a-b7d23b603c2mr2200252766b.60.1766050599963; Thu, 18 Dec 2025
 01:36:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1766032843.git.wqu@suse.com>
In-Reply-To: <cover.1766032843.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 18 Dec 2025 09:36:02 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6gkt1pSTV5=mrv3G9hzJxecDvr8380wc1ti270Xn9jcw@mail.gmail.com>
X-Gm-Features: AQt7F2q6CtJPblWzGIDSHei0LYXVphRD2F9ijeamvTv7uKEW9G-U1S9jgftxxOA
Message-ID: <CAL3q7H6gkt1pSTV5=mrv3G9hzJxecDvr8380wc1ti270Xn9jcw@mail.gmail.com>
Subject: Re: [PATCH 0/2] btrfs: minor bs != ps cases fixes for free space tree enforcing
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 4:46=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> I'm update btrfs/131 to remove the v1 cache usage since v1 cache is
> already marked deprecated.
>
> With that update, I can run the test on bs < ps and bs > ps cases, the
> formal failed due to the following reason:
>
> - Free space cache is always enforced for bs < ps case
>   Even if 'nospace_cache' mount option is provided.
>   This is fixed by the first patch
>
> And during tests I also exposed a minor problem for bs > ps cases:
>
> - v1 cache mount is rejected for bs > ps cases
>   That's because we lack the automatic free space tree enforcing for
>   bs > ps cases.
>   This is fixed by the second patch.
>
> Qu Wenruo (2):
>   btrfs: only enforce free space tree if v1 cache is required for bs <
>     ps cases
>   btrfs: forcing free space tree for bs > ps cases

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.


>
>  fs/btrfs/super.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> --
> 2.52.0
>
>

