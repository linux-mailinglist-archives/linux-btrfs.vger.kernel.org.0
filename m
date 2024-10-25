Return-Path: <linux-btrfs+bounces-9168-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 902C79B0439
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 15:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551122839DD
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 13:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456D11632F8;
	Fri, 25 Oct 2024 13:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1IAPKLv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0EE212178
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Oct 2024 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729863359; cv=none; b=MWajelrX+OVrL1Qnkr4I2Ycnqxl5DaO3OPgBFClepmKdX/MYVpxr26fhn3BCAaeDhUOT8bItCotaqh8mwvJ/fveGqt3T4VkylJuJSpjY+6GaKM9DDK6c9potDulp1RAX4vbB+VtFrnJqMacEtp8tlOSaokgDn9qQiqPtaNnhKME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729863359; c=relaxed/simple;
	bh=pBDCqZukY/nlO1gIr1cXY2iyEtJIsfVOAOYIB7nxkrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/0DSFMJkPEVrgKXzgO6a15AXEJX/wxLJDvFxhF55GFTbldkNWSea6U46pMJCmX1QE2B1PO8/wFQfJMYaOaWCoR6BXpcqZ2Mg+/TxF+4iXE21raX/2fNbCcFhQoG4iEwXGWwCGuzMhYFyAzAyb6HGYfCWmUmzs2ly2lSsZrT/TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1IAPKLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A637C4CECD
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Oct 2024 13:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729863359;
	bh=pBDCqZukY/nlO1gIr1cXY2iyEtJIsfVOAOYIB7nxkrY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e1IAPKLvA9V2311kH6r1Wrb+7ECFohYyxuZrstJxTqb2VC9dgosH0lhV/H6JtENB8
	 mwLy4suzcXvtFcFQK2eAzO+qAMomLghEUOoVkTenhKojPF98/hQokU/m9+MN7Mewhg
	 B6cItPWCRQSNtyEkTLrBZ0+WCTdqMDKaoqV7eOXTTkvTnFiVznx/ryySv9Rhyz3G8W
	 vh2JUX+Fm9wUEcPd2OvFi7yM68VUAsiE++KkalicdKNvbBL7rpgxnVpoUEVVTPq8M6
	 uZytXoR53QkoHxQms/vorqjz8gNzN1df90C/FaC1S/vwdxTLKScSxt+G/VFF3hgCEs
	 7EVnPyWX3P8jg==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a850270e2so334627066b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Oct 2024 06:35:58 -0700 (PDT)
X-Gm-Message-State: AOJu0YyCSoFE32ct3g+ptGJPfYUjhajMsXwCV6t7dFishG1F45K4/Dvq
	Let8XHDMGvBFnytwefhlvpvJww8wIdg72K8S+sFYQo8gCoxv9EbL30XuM+B8pQBJ1tBnZgdYtMt
	RF8hnVxR3rK/PIZDQ6HxgcrKPX+w=
X-Google-Smtp-Source: AGHT+IEZ/H+sUhezNTY83p5SP3e90ExAuRq2P/GfONJIWQaKCVzOF7h8U4yYxt320yDeW7b8qIDblaOqh1oAQofy8wg=
X-Received: by 2002:a17:906:d554:b0:a99:5ad9:b672 with SMTP id
 a640c23a62f3a-a9abf853500mr831222366b.10.1729863357600; Fri, 25 Oct 2024
 06:35:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729784712.git.fdmanana@suse.com> <49b1a5df-eefc-437a-b175-2e9532932dfe@wdc.com>
In-Reply-To: <49b1a5df-eefc-437a-b175-2e9532932dfe@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 25 Oct 2024 14:35:20 +0100
X-Gmail-Original-Message-ID: <CAL3q7H61-kM26sNZC6rLzbv2D3ku7NQ_B+PT9-eQYLMGxuySxQ@mail.gmail.com>
Message-ID: <CAL3q7H61-kM26sNZC6rLzbv2D3ku7NQ_B+PT9-eQYLMGxuySxQ@mail.gmail.com>
Subject: Re: [PATCH 00/18] btrfs: convert delayed head refs to xarray and cleanups
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 2:19=E2=80=AFPM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 24.10.24 18:24, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > This converts the rb-tree that tracks delayed ref heads into an xarray,
> > reducing memory used by delayed ref heads and making it more efficient
> > to add/remove/find delayed ref heads. The rest are mostly cleanups and
> > refactorings, removing some dead code, deduplicating code, move code
> > around, etc. More details in the changelogs.
>
> Stupid question (and by that I literally mean, it's a stupid question, I
> have no idea): looking at other places where we're heavily relying on
> rb-trees is ordered-extents. Would it make sense to move them over to
> xarrays as well?

For ordered extents I wouldn't consider it, because I don't think it's
common to have thousands of them per inode.
Same for delayed refs inside a delayed ref head for example.
For delayed ref heads, for every cow operation we get one to delete
the old extent and another one for the new extent, so these can easily
be thousands even for small filesystems with moderate and even low
workloads.

It may still be worth just to reduce structure sizes and memory usage,
though it would have to be analyzed on a case by case basis.

