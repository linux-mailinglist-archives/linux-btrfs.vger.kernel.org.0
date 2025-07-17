Return-Path: <linux-btrfs+bounces-15542-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CE3B0939F
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Jul 2025 19:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8934E4A512D
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Jul 2025 17:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EB22FE321;
	Thu, 17 Jul 2025 17:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="H82ymsIo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l/PCU8W1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6FF287254
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Jul 2025 17:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752774745; cv=none; b=MCobJH2PMVTWJO6VFT6OW6rrGSb4dEgEliILXCUmN6q11XvaruGIsuG801UBVY+kHI+axenKeUcdNmBv+nU07hvY1l2sqt3t6r/OKHg0eK3OWrBFMkW/IsgHxuJqrj4V0XKJuJqQNzoDhJx6IVv9LYSn80Ld1jJq2qGEPUoEN5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752774745; c=relaxed/simple;
	bh=LFu94VUuPD+Tii4IT9weCFCFFF5KWRSFOUdOcJv5pgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFRJLPKOO/8qjqJ4uAj+pN2msCNpcyT0H6Me3jTjAcADJnDSqR0P7gIh3gomdmzWacT3J/rAeitFSPOR+FoPzqD4pNis06QXFp9StUOOT/bb0ofQScjJHDjzVZqmu+l5rAttxVzVL87Ho30JmYLA195zlhAwuKeN1MTPkbUBixQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=H82ymsIo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l/PCU8W1; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 50D6B1D0015C;
	Thu, 17 Jul 2025 13:52:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 17 Jul 2025 13:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1752774742; x=1752861142; bh=RJmruXm1EC
	v2BGEQdQfDjd61jIuSUvEYwTfEqClf8J8=; b=H82ymsIofO3SLnZOc0tkpLL7N1
	Fv2oYu+epm4uIe7Vdq1bznkb3bL1I+LuaVBaWr+GPUXLSIUo3q0TQFD+qa0GyGew
	qRAYCQjuYl665ym30D7IWBV0M8QR1Ls05S6vyehq7XrgCJ7gKfPVJ0qETByPkN+P
	ycttTZfeA0wan3BGoSnhVJn8ugIobWimWuAChGM3v83RZwTlPZceoSalVFun+gzv
	NwY19vEwYjt7WBC4eQhcpk1D1azoREf9OwVo1JUl7Yb1ay0RqFkUGRWuAVLYg/vw
	QZxWnZr6hz9P+a6HLBCqHx8biFuxNLzZksVEcfyOAKaKOEt1hvuYtY39jtIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752774742; x=1752861142; bh=RJmruXm1ECv2BGEQdQfDjd61jIuSUvEYwTf
	EqClf8J8=; b=l/PCU8W1pDSrPiFMqOM3UHVoNkisfyH54zc8H5jYprgebB4kpAM
	rxfFpi1K+aW/NPAHRlf3kr6YoeJGKzI7iTFOnm3z05HexMpeXtp2SxEvUyaBt1uy
	SJ/K8gWinTw6ilo42EOWei0ZYBN2gfpNzNLCeULZD/B0tOqLRXO9jXP/PBfvQRp6
	zRkFaGBOmhS09IQ/ZfCAHCA/w1ltRu76Hf0Jm4b87Jwa/kbJkj5boWbQ2gm4m58N
	l119l7bSxsJJSc3ot31LGZpNOExxFZImTvKnMiaAPvQJnFqMiWxcIJuu3t89Sw0v
	VWkUa4LwRL4Zze2vv2M4prORxatU283hZxg==
X-ME-Sender: <xms:VTh5aKvaQULpnUBMXhwzpOWhaE1F6B5vrRz7PEhVFH0Z_xIiD3ls2Q>
    <xme:VTh5aPqybHQY0p3oKlrcZPCdlbQSZwS6Nnq2gMkRxpyAUdw6hkDv85eb_p6NLxOio
    UaKLzxBbxIDVov3aEg>
X-ME-Received: <xmr:VTh5aHkZZy3WQ2S_HL6dpcc6XZEAYY_1UPBR-NuDUx-CGiooRmfSN--s80J_glMaozEu83sqzXFvjN4eWML4PR1m_hY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeiuddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiie
    dugfeugfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepfhgumhgrnhgrnhgrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:VTh5aDwMG0nyq95Qk_PsmPoEC1zotSo-ZrDr-A3Xe5fRQ--k4_9r4Q>
    <xmx:VTh5aPkIaloPfDGX2bRBcQOa8s2o0ue2n6Ac3H0uJlF2SUqin0S_iA>
    <xmx:VTh5aMc6VtKqJO0VI4SdNaEve70Wjc841lU6w5ijQGE23jS2lypUAA>
    <xmx:VTh5aFrIy3owK2dFqWgamPsaNB0PcD32SZKBkyB0DKj9sA6l4mDyxA>
    <xmx:Vjh5aFxr5O-rz6JKrhDd3NMKnrME0AIh4U-KOolO3iUU2jEod4WQbjwz>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 13:52:21 -0400 (EDT)
Date: Thu, 17 Jul 2025 10:53:53 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] btrfs: log replay bug fixes and cleanup
Message-ID: <20250717175320.GA3096524@zen.localdomain>
References: <cover.1752265165.git.fdmanana@suse.com>
 <cover.1752266047.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752266047.git.fdmanana@suse.com>

On Fri, Jul 11, 2025 at 09:36:37PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A couple bug fixes for log replay and a cleanup.
> 
> V2: Updated patch 2/3 to avoid a NULL pointer deref on directory.

Looks good, thanks.
Reviewed-by: Boris Burkov <boris@bur.io>

> 
> Filipe Manana (3):
>   btrfs: don't ignore inode missing when replaying log tree
>   btrfs: don't skip remaining extrefs if dir not found during log replay
>   btrfs: use saner variable type and name to indicate extrefs at add_inode_ref()
> 
>  fs/btrfs/tree-log.c | 37 ++++++++++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 9 deletions(-)
> 
> -- 
> 2.47.2
> 

