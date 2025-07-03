Return-Path: <linux-btrfs+bounces-15226-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6990CAF8156
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jul 2025 21:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F43E3B8CCF
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jul 2025 19:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0472F3648;
	Thu,  3 Jul 2025 19:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="DhVckMrC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VClakT9W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9415B294A0A
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Jul 2025 19:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751570964; cv=none; b=GW2Mm5TVhDCBsrYk5CcLTCZIufvGUd7NaSgrtR457TowLF7f3z0jW3oYObz2HMRPme7rIdr+ASkP9E/orLERi6q7zCXQUjDqhE3vMc7fXN6o0k7u+ur2ZxNFL0RtkMICxpjovcx+26kWv5rEbfuCmYNVT70/Mp7UbzbRDmfMKgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751570964; c=relaxed/simple;
	bh=Qop+SmmT2e1N++ipLSChs4fMleVdCzVP1y/5q9LlAEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DT6WSnv3dkUCqIzhtHYh/WKrLc1rlARzJyQbvtubLGpWp7Ium55Ln/ZYky8r6v+RlwsZsHlN/LMkJAuB4wfy71bFIr6sPpHp34xbAR17Ey3tpcOaPmZ4zo1GyHmMZ7U017FcwNwxQW4nfMecaPWqfgzXxlhAAU0xys//SwSOnPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=DhVckMrC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VClakT9W; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B331D1400926;
	Thu,  3 Jul 2025 15:29:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 03 Jul 2025 15:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1751570960; x=1751657360; bh=NIpNjwJcG3
	/SKnz5Zfl3AhQ05YqgFb9w4VoHqGGns4g=; b=DhVckMrC+YCJAAk2HHx18CHqPZ
	h2GpKEkdcOXOI1Oqwl0v5LNtC78bbNnfLaL7lN9XDKDWCgXg8/+3ePVLapC0TCaU
	bByd1ZjprHoEwchdGzUMWi3paNRN/qkqOE9++nFpBXHuwiuUkPzXRfZIOTIrRFa0
	y9D2k/anRdDdYMlqO/tPo3yo3diQuG1U+iuO/EGTocOShdseZIQwcHi3ztz3H9af
	MaYKzMWSavwf6reIm3hPRslHNaRn2+YAinw4ZOzIfGfXwsZirgCEpzTFCkVV2EC4
	PMEU92QcOSaQud+/WbBgpyi4FdjXosQL05j+znvCdti0YsWr+Y4R5xn4ijnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751570960; x=1751657360; bh=NIpNjwJcG3/SKnz5Zfl3AhQ05YqgFb9w4Vo
	HqGGns4g=; b=VClakT9WBYI3Bv1DRtcdG5KBdQ0j0Jh1K8/netN5F4hdvHEz++5
	SMIYNZvY746nUi4p+wRzDw1/tmkmFENDrQeJobLfGzo5buyihfGg5GbnVqepKRwM
	4dcjm9GdK+zr8NFRVmuYivKSUlV6WHue8mj7VdjLGV6ajwoDGePnN3IJZf9hplzi
	CjC3SUKp0WIDCgbaZ8z3K3WQqz6CeKQlop+Egt6CrEV+KbnNEHXj49rR5KLXL8+u
	GWA5M2MK82aCaGjxLXlrVsuhXOuV5gpco7L92WoWKbg8qOni5v0VciL+sAx60GsP
	3tB6ZM5QCLaNObbhvLq5c4vBfXkwkpChraw==
X-ME-Sender: <xms:ENpmaGU9aM59utsjiA9tQJOytuasg3-HuejuXuVbjifkoqDgFQNmTg>
    <xme:ENpmaCn-nAD9jN5Lni1Yas16fd7TjuoKhkrJhmeThegT_n-4e3niudiiEqK5vsjXD
    VRSxY4duLKEuaHvj6g>
X-ME-Received: <xmr:ENpmaKZlXSL8mrqm9q3AyFfJh8ZiJ9ZFNEe_CcrvzGC5u_bjQJjrEbPtAWDLsCCVAzsok_RgP6-gI81_8eMs-hBkXuI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiie
    dugfeugfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepfhgumhgrnhgrnhgrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:ENpmaNXXAnlC5QtCa70-a68pUfDXOmGTppNeJTMz5C_DlbcQClzjTQ>
    <xmx:ENpmaAkIv_7nOSQv5Lt1uA9uZODAOvzEG1OXqeoWRt7O-HqNfl9NEw>
    <xmx:ENpmaCcewc8iR_F95QZPV1a5OZkPt_kB1pnTT4t16wVoB9IVQD-8jg>
    <xmx:ENpmaCFy4gbwnol-yI-51mQZ0VOUX1cAKrl1om9MjXwmFMhEGhmYpw>
    <xmx:ENpmaMx_oHjCPFHP8NffdUsePIy7_S5r5ywcgVbW5M5LTAZYQhhbG6XM>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 15:29:20 -0400 (EDT)
Date: Thu, 3 Jul 2025 12:30:53 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: send: directly return strcmp() result when
 comparing recorded refs
Message-ID: <20250703193053.GA374@zen.localdomain>
References: <30bcc022fde1071a86db10f10c984bddd87fcef9.1751558928.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30bcc022fde1071a86db10f10c984bddd87fcef9.1751558928.git.fdmanana@suse.com>

On Thu, Jul 03, 2025 at 05:10:06PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There's no point in converting the return values from strcmp() as all we
> need is that it returns a negative value if the first argument is less
> than the second, a positive value if it's greater and 0 if equal. We do
> not have a need for -1 instead of any other negative value and no need
> for 1 instead of any other positive value - that's all that rb_find()
> needs and no where else we need specific negative and positive values.
> 
> So remove the intermediate local variable and checks and return directly
> the result from strcmp().
> 
> This also reduces the module's text size.
> 
> Before:
> 
>   $ size fs/btrfs/btrfs.ko
>      text	   data	    bss	    dec	    hex	filename
>   1888116	 161347	  16136	2065599	 1f84bf	fs/btrfs/btrfs.ko
> 
> After:
> 
>   $ size fs/btrfs/btrfs.ko
>      text	   data	    bss	    dec	    hex	filename
>   1888052	 161347	  16136	2065535	 1f847f	fs/btrfs/btrfs.ko
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/send.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 01aab5b7c93a..09822e766e41 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -4628,7 +4628,6 @@ static int rbtree_ref_comp(const void *k, const struct rb_node *node)
>  {
>  	const struct recorded_ref *data = k;
>  	const struct recorded_ref *ref = rb_entry(node, struct recorded_ref, node);
> -	int result;
>  
>  	if (data->dir > ref->dir)
>  		return 1;
> @@ -4642,12 +4641,7 @@ static int rbtree_ref_comp(const void *k, const struct rb_node *node)
>  		return 1;
>  	if (data->name_len < ref->name_len)
>  		return -1;
> -	result = strcmp(data->name, ref->name);
> -	if (result > 0)
> -		return 1;
> -	if (result < 0)
> -		return -1;
> -	return 0;
> +	return strcmp(data->name, ref->name);
>  }
>  
>  static bool rbtree_ref_less(struct rb_node *node, const struct rb_node *parent)
> -- 
> 2.47.2
> 

