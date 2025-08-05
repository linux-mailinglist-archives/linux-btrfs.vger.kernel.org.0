Return-Path: <linux-btrfs+bounces-15860-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1A7B1BA70
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 20:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998051852A8
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 18:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE848296148;
	Tue,  5 Aug 2025 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="g1k5uSAC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TKaAXgNO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AAB15ECCC
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Aug 2025 18:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754419519; cv=none; b=qUgpJSfQnJD/tzCq+nd5fvmJ2gdcWFxc7EYCus5Cc4SjCpL6UzCY4SE5VUnTdVxrAzvQqxm9B3qFb6FPFbrPJwBRWKx+Ps2BbA5YNN9AnNspUPlY3mE7jBDfCSp0TWD/56lR52m/4DNW51yqPV33yTd+SmgZJJssEA8LSHI3Z9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754419519; c=relaxed/simple;
	bh=nAHftg5b3fsnTSfje3+Bi7XT8kXbWe5ep+DnRyPJiQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0+puZ5nDd1xhIwWxf8JKMTVIwWFGC/nA9ZZmGpeUjI4yLt32wmJiCeSNHB0BP+GXyZFLjF/MdCvGSDPvAJ3Z24chgPadR2Q6vhBOnxENQX1o15THsNYbBc5FE6YdWUtjSp3VKILAF2gb/hFXd+ZdBVeccREpdZy0ZOVLr9t57Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=g1k5uSAC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TKaAXgNO; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 6B9B3EC01F6;
	Tue,  5 Aug 2025 14:45:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 05 Aug 2025 14:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1754419516; x=1754505916; bh=G1NvOMWnVG
	E9Z4LcWJK2zYp+1Hh5uqHJY3f25l0ZMbo=; b=g1k5uSACybnxSiTqGX6mgVO8bR
	ZHo7TYNOWUtO2FeCpcWjx4kCDTeh9qkykFWqmXsJyo951OwFRzM6qvwucywVsnB2
	gN7w/MSFtlaVp2jaZpPJA3ZSkhYCZSSoaYLSJMKf1/9pLflWzHpegobLfBWjJQR+
	GxTRwyNhoMEQOrF1u5KzzeYlM298jTpMuTD5jks7UTfNUAP3r2NRrSISgiOFdjnA
	pFXzi6m67gHs/yQB63sDtC9s8q3O6TGkwxmpBAMF02/enhxWI7db43GsRwZDRbPu
	pyXWOJawtBcOjVCa3Vjt2M7FuN1e5d2Snn9hquH8K+iZ1zibXuRnItYyZnkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754419516; x=1754505916; bh=G1NvOMWnVGE9Z4LcWJK2zYp+1Hh5uqHJY3f
	25l0ZMbo=; b=TKaAXgNOKRnOjFaEJRaaD+UqK7/OQP3WeeU0Eeet8ZWELBWdOR7
	YqQv8bjNgdwKJLgfPnTstsCxd9JRKH+xFuAwWn0MHWHiF3A3SVpdHwaNPHSpsEUt
	yOfnyftSaNq/zZVwyuUJHN9/tE/GAP84fMgRX6iqSRUjcVanJ+f3ZqWvDHnxLQDn
	YmGtqjyRnjqwrO4JA6IjjMirJx35immQlFGU1HtRSGPRsH2TJeXCU0YhJ1yX7znE
	nLMZZ+7Fcvr6gDhI/2+6cm31tdbO8MJDX6HGK69z4MZkO+bDsMnme3m/Zr1/PhX1
	dmcoO6nOa9dYTuaC9Tq6KNAPWEPsBcFHb9g==
X-ME-Sender: <xms:PFGSaOUy6JqBBOMpBe7l36nlpQC-uXAY--P3LiG6pbSKQ3cjI7iROA>
    <xme:PFGSaKxf_EecD5biFqEF6iMsxBLksfmcgaxQ_Ibt4Xn_jxXxhr91GW_PSrtmvx2Ft
    Qmtl3THLSQiQO1YOh0>
X-ME-Received: <xmr:PFGSaEON0-Yqt8ZCuEM0AKre3wKDNg73pqyI7xKOTURqZ_smVaiGksVinc9W7FzW4a0IErAhhm654VbOOihmCr2TTzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiie
    eiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsuhhnkheijedukeeksehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:PFGSaD7Vh5bxp6o6Lw80vX5PlYdoUUmnI_Q6z0xd1jT1MgvQgaVoLA>
    <xmx:PFGSaNNqKxiwXfzhyae5sUJkeaWAmJKLOVGwTJNfLln7lj_5ifRPyg>
    <xmx:PFGSaJnAjpwuxS8BTaVFhSZSpPc2twM2dq1sCYMgDmw3PuQYQfRgNA>
    <xmx:PFGSaMRur9avCij8HZKSO6xA8TNzIEo_WYfpuV4GPHRsZEtdD_QYkw>
    <xmx:PFGSaAmmsq8OIyV3k3WltmmE7FLFxcEHORweYMegQJaVBnPZ5cdlrjN2>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 14:45:15 -0400 (EDT)
Date: Tue, 5 Aug 2025 11:46:15 -0700
From: Boris Burkov <boris@bur.io>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix node balancing condition in balance_level()
Message-ID: <20250805184615.GD4088788@zen.localdomain>
References: <20250805035718.16313-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805035718.16313-1-sunk67188@gmail.com>

On Tue, Aug 05, 2025 at 11:57:04AM +0800, Sun YangKai wrote:
> Commit cfbb9308463f ("Btrfs: balance btree more often") intended to
> trigger node balancing when node utilization drops below 50% (capacity/2)
> by modifying the condition in setup_nodes_for_search(). However, an
> undetected early return condition in balance_level() prevented this
> behavior from taking effect.
> 
> The early return condition:
>     if (btrfs_header_nritems(mid) > BTRFS_NODEPTRS_PER_BLOCK(fs_info) / 4)
>         return 0;
> 
> caused balance_level() to abort when nodes were still more than 25% full,
> effectively maintaining the original 25% threshold. This unintended
> behavior persisted for over a decade. Since setup_nodes_for_search() is
> the sole caller of balance_level(), remove the obsolete early return
> condition to:
> 
> 1. Align with the original intent of commit cfbb9308463f ("Btrfs: balance btree more often")
> 2. Allow proper node balancing at the 50% utilization threshold
> 3. Improve btree performance by more frequent node compaction

This is interesting, good catch.

However, we don't really have any evidence one way or the other which is
better. For better or worse, this logic has been around since ~2007, so
to change it I think requires more justification than the reasoning on a
faulty patch from 2009. Do you have any evidence for your #3:
  > Improve btree performance by more frequent node compaction

I would advise that you run:
- fsperf for generic benchmarking.
- a targeted workload that would get compacted more now that you removed
  the surprising check.

Thanks,
Boris

> 
> Fixes: cfbb9308463f ("Btrfs: balance btree more often")
> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> ---
>  fs/btrfs/ctree.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index acd85e317564..8cc52c8b38f3 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -939,9 +939,6 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
>  		}
>  		return 0;
>  	}
> -	if (btrfs_header_nritems(mid) >
> -	    BTRFS_NODEPTRS_PER_BLOCK(fs_info) / 4)
> -		return 0;
>  
>  	if (pslot) {
>  		left = btrfs_read_node_slot(parent, pslot - 1);
> -- 
> 2.50.1
> 

