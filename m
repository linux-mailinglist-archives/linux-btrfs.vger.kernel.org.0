Return-Path: <linux-btrfs+bounces-14668-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 594A5ADB5D4
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jun 2025 17:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32163A7383
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jun 2025 15:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8737267721;
	Mon, 16 Jun 2025 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="TKnQJFY0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W9ZVUpTR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB6F45C0B
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Jun 2025 15:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750088769; cv=none; b=oeh/PxMyKahlX5bew3zugrf8okQHcFDzdjjI5cfbPCkBoQQDsLfvsl0Wsd1LTjY7ZvcCW6RMbOoH3IgY0/D0Zabc08WVz9UjwBbEN1u1EEBrlj8Xc2QCPUybYRHKTQVNgeLB09v2e8KF8UQGFZGrD58M48EIzMwpouvhuwXZ1TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750088769; c=relaxed/simple;
	bh=THZXt6sjsCXqJ33vPBy7H0pbWqLAPz3FlNZdJkD3IQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzBx5vIay7JxuoPDfvFiImnTDc1HckebKKIxFQy5TTA8fn/yuwZaZE0G0iV9g9s3p4iVpZ9ukQanjIgKuH/hhU5SGim/O4zkZnqcG5cuLJ0tMQ17btCRiaVjmyJaLtMQFMeueWc0PVFhHRfJjZDgZuJqnxVwCQTcVZrhaypBSTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=TKnQJFY0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W9ZVUpTR; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 1F1AC13803E4;
	Mon, 16 Jun 2025 11:46:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 16 Jun 2025 11:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1750088767; x=1750175167; bh=c7KzGb7gqn
	nYUMpnotMbiz9mseWbip1XwSklAA1DKuE=; b=TKnQJFY05b+yb60SeW3nPKI3Rx
	WY8drMwSYgC9zfoHqsIBh/kC/51UHajoDzQYXqAefblDsUlBaHXIHMuUiFLnxtNd
	IQ2ce2Ts0OWPPTUkUkpKyTXNxqDDxL01qhH44armwetydIEdLy/TiwPKx9oCWP8t
	DUkzCESqQFpyeh+xxLJaclbYO4kc+32mHpIZ/wqRPyMjear/paLVHsCvTZaTnEx9
	fK33CxsoRG29YT0g069WCVQPpYi8Qa9uus2Ew/PGgMD/6T1FFyM0BBfVo3fgOtlf
	zAkbxV3G2PNZDhph3TbhGQez/+Ui5Qm71UOc6pyTq64ckVjuIEwS2/aVxktw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750088767; x=1750175167; bh=c7KzGb7gqnnYUMpnotMbiz9mseWbip1XwSk
	lAA1DKuE=; b=W9ZVUpTRIfd0cF+gs6JUX4IRl5d5/sWNz/KonJhXX18BkT/RUDT
	IxgUeKElJfYd/IOYISW1n+TCTHp5sZ1zKGp9qsh9NpNS9TLj1BBnABb0zfR5X2Rb
	sycG/ohyCStzgtpl9VLnFvOfxVhOTaHTGGrVLKeAFKAsymPuOYkMxaFVPYNnO5rx
	QFKfV/7OAj8Ke7hBrqhyAAyjxY31c9LJcJPxHUBKSY1GM+o5iSqwlVOCruyc6xRC
	N2+KfSlMOvOKqpKV1znVIdOy0QPMXVW20RMFOT3Il4YQAcSw5dlRrPB8EdK4ggXV
	QxQUWtPCCNsyvU+rYbMV7WUEt+tV6BytmWA==
X-ME-Sender: <xms:PjxQaPSq69ORNjnzypviR9Koh8c-CZ-KXL2EuA-U5uZGDU9I8-PlRA>
    <xme:PjxQaAwe1W-5M8dUwNy2csc9B5cR8lMlPUKD6fozIneerFSl6feG5WxMX-F0e3pQH
    AxC709jYJLT1nOCALw>
X-ME-Received: <xmr:PjxQaE3rLCl2Vx7UIBB4CEK888UctDTbpgkLdv-Sjbb92yTl9QErVQLFQ7a4Wb-CCpYNkRdWuwtE56nYpIr7b6Q3g8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvieeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcuuehurhhkohhv
    uceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvdekffejleelhf
    evhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhgumhgr
    nhgrnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgsthhrfhhsse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PjxQaPDJZtlaE72WMnkMRaw9Ruhz6Vi6NIeBZCUk4JbmP3GHmqg0pw>
    <xmx:PjxQaIhftW_J5AK5dkisWpvU3nj8OSm0Gg-Ex2Hc0comM6a8HhemWQ>
    <xmx:PjxQaDp5VAYJVLKB48C-1s_HXmElqRfI6uducFVbUPif_9XTCXWyJA>
    <xmx:PjxQaDhL9xY69A1W4brIp5ZAgbOvwrYXcrvqxZQIPu_jSy9Mi8Ulqg>
    <xmx:PzxQaGOwYlTNbHeV99cS8r2vpBaZEOEC0a07OvkvlqZMQ6xMwXWS1KeR>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Jun 2025 11:46:06 -0400 (EDT)
Date: Mon, 16 Jun 2025 08:45:42 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: free space tree fixes and cleanups
Message-ID: <20250616154542.GB812359@zen.localdomain>
References: <cover.1749421865.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1749421865.git.fdmanana@suse.com>

On Sun, Jun 08, 2025 at 11:43:31PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Fix a regression when rebuilding a free space tree, reported by syzbot,
> ensure transaction aborts where critical when adding a new block group to
> the free space tree, and a cleanup. Details in the changelogs.

This series LGTM, you can add:
Reviewed-by: Boris Burkov <boris@bur.io>

> 
> Filipe Manana (3):
>   btrfs: fix failure to rebuild free space tree using multiple transactions
>   btrfs: always abort transaction on failure to add block group to free space tree
>   btrfs: check BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE at __add_block_group_free_space()
> 
>  fs/btrfs/block-group.h     |   2 +
>  fs/btrfs/free-space-tree.c | 110 +++++++++++++++++++++++++------------
>  2 files changed, 77 insertions(+), 35 deletions(-)
> 
> -- 
> 2.47.2
> 

