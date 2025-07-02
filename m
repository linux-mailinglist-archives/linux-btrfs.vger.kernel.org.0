Return-Path: <linux-btrfs+bounces-15216-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 163F8AF643A
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 23:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261AC1883E01
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 21:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E962DCF42;
	Wed,  2 Jul 2025 21:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="wFZpTIPU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F1yerXhx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0D81F5437
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Jul 2025 21:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751492305; cv=none; b=JyqBKmrVHKaLPVZjtV2hJYRQrxb1jFV7ygILG8/eq9RsQg3bHp1EKJJ7nm4vDJX/Rl6Sct3T/38Q0NpMDyYRkcCh9fcUBVKevGdcqe3HMgG0lyFO/wJmrtenlgesbX4cle+b7suvozzEmRwlVPOaMsJ8Jslrm/hUoI3Hsv0K+SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751492305; c=relaxed/simple;
	bh=x2lbjxgRSyJlwIYv3eQHvsXYlHnLMpevFdGJvFIlJsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gbsm9KrYGDt86JsLRbDnjmzV3Uqi4KVfDNpdUM4UgPR3rChz655einXBi3Rcy5tTBQzPtvpzdbyVldMAE3PMNlhDArSNUAa9FpuBlsO8mP0YOkmRrz8L4ecyCTQYaagMvlxx2bDmjdedO3ubItEUU1wQGBAX3PNBb55J6Ei0Uts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=wFZpTIPU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F1yerXhx; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 64C45EC0078;
	Wed,  2 Jul 2025 17:38:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 02 Jul 2025 17:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1751492302; x=1751578702; bh=ZvF3lrKsi/
	2SpZi7ola8g2uf53ruGXEfNGmOwF+3wF0=; b=wFZpTIPUWc+DOaJtOLiSLnsaAL
	4aC1sw+CI6XZeuxaPe0hPD44wHR9f6iaJq2sTNmXje/RMXtgDDB7G3EKPgdprmkQ
	/TSgjoOGP67Ti5Dw9sSXA7UghQkfA914oJLuFFrRxy8PyR5igTZblnWP4i3xh6fN
	XW1sgDHR4Op1NZOTTFiFHOE+74iOUrMHHluonIaIR6oCoben+qX4gBPE578FmJ0I
	TC+gXFPTEQFCywmptD8/gMU0k2tgMbfMWQSJ686BGVMZ7mmTpiS0Vyc3iscAte3r
	NNeZwAQh2LvVQpZgoCIXT0faMLX1FHkIXuX6GkTT8V7ocUBBK4uTVpA7W80Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751492302; x=1751578702; bh=ZvF3lrKsi/2SpZi7ola8g2uf53ruGXEfNGm
	OwF+3wF0=; b=F1yerXhxRu95HuLac/RKF6d0PppeDbHncJfrBfuiVAHj5LlzdXC
	D/t3Sp/BhPVVf1TAtoOvIcK42rsEHmu7AJMpxMxopsJNuthhnRUoayi4n4DFdnV/
	0KyO0X6yVDtdlKDIrH7MBneSXW1XaiDu2rF8XhPLM/8OBJQVENTG2nP6aT3Tb02q
	NIp/DK81FrDUyMBv+bI5dBuza0ar4d0m6Kt94xhiu8Cy8R40H8DDBg1ajm1KjnC8
	bAiIAHAdPRdCBsXl4uB1fiC5o+oUoMt8ZinrHsJMQ+n4A6RUbkmm04zaA0UhRB2E
	2Ev9ymtmSYE2Jv4lo1qz5BQaX+sE1UD0IhQ==
X-ME-Sender: <xms:zqZlaI0ws1ZUN9pyFRH9i5izRbfFfjfxHFxdgya7ikcgah_qVfGbrw>
    <xme:zqZlaDF23Dfi8w1zmkxPGzJkZN6KttQMnfQkjC_VwLZw_0PQVDChifsY0kFBIMhji
    6YOwBvIhSDTX2JoyyY>
X-ME-Received: <xmr:zqZlaA6xmkU-VnETF6UzzG55H1ECXU87sHxiYuel57S15WKDqqXSaujPe8hTKnIsGnqm4XQ3tE9ArQNeAHgAFJ-BX5E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiie
    dugfeugfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepfhgumhgrnhgrnhgrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:zqZlaB1juz8nwSju1omjEBPNyO55GaMjGYDH9Ed6opKzibsT2nrisQ>
    <xmx:zqZlaLEF1T5qLFsMD66mIdQ5b1wV9dAAZru19OOgnmrG4RgODxvLpw>
    <xmx:zqZlaK8O42EhUPXMhgyY20Kn3Lqp5erqYvGnogSCGRIRPCd1p2P_xA>
    <xmx:zqZlaAkM0GpwdlKxLUB3lsF8gE__KOOcOdW-kXrtP4LALP7957M-EQ>
    <xmx:zqZlaLQtKe8Msw1ZqjMEYw3Q_CPEL4AdERnWwyHIKqoSv-uSZWomnrAj>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Jul 2025 17:38:21 -0400 (EDT)
Date: Wed, 2 Jul 2025 14:39:56 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: tree mod log optimizations and cleanup
Message-ID: <20250702213956.GA3337172@zen.localdomain>
References: <cover.1751460099.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1751460099.git.fdmanana@suse.com>

On Wed, Jul 02, 2025 at 04:38:29PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A couple optimizations for the tree mod log and a cleanup (related, for
> one of the users of tree mog log).

Looks good, thanks.

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> Filipe Manana (3):
>   btrfs: avoid logging tree mod log elements for irrelevant extent buffers
>   btrfs: reduce size of struct tree_mod_elem
>   btrfs: set search_commit_root to false in iterate_inodes_from_logical()
> 
>  fs/btrfs/backref.c      | 12 +++---
>  fs/btrfs/backref.h      |  3 +-
>  fs/btrfs/ioctl.c        | 10 +----
>  fs/btrfs/tree-mod-log.c | 81 ++++++++++++++++++++++++++++++-----------
>  4 files changed, 68 insertions(+), 38 deletions(-)
> 
> -- 
> 2.47.2
> 

