Return-Path: <linux-btrfs+bounces-8906-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603D499D521
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 19:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D136284683
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 17:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E1F1BFE01;
	Mon, 14 Oct 2024 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="FD/MY1b6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iqzI6YdP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9831E14AA9
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728925250; cv=none; b=tu35Ig/UN4aum7ESc48IY1CqamTa2LRZura7J2v1GnTsKbNKng2HYRcTWZCHnCUgc/0PPgAuWa4V2/pfyKGEX10VCTl5seERb6pWdxAuqwjWKBarylpjQaM+IzF4kaQPhYU5klo400bEnzEavHh60RDpVVNix7aDFbE5IUKEWZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728925250; c=relaxed/simple;
	bh=Wky4A2Y9TqhjdyWr4fLg9bPFIlcmEqLtiPw3LclQzWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCwVoDy5htBC6oQUU0tYtdT0DMnvIZRpu2tZDkAWXW59+dfY51YuTnF90+26ALjfvl/zo5IaEztKyfozA0eAzlVlhrs6gZvmUY5fqLi2kc1ve+OQkOERqIT9sk1vaHxSm+JdjD5BtqPyKi5YpaQKKVvXLGap+3sSOU3hPYxbee8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=FD/MY1b6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iqzI6YdP; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A1D9D1380256;
	Mon, 14 Oct 2024 13:00:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 14 Oct 2024 13:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1728925247; x=1729011647; bh=Y9fWDk0njt
	fKHMgF+BBSTKVGJLd+3qRMQqMLNyZPAxY=; b=FD/MY1b6rLdi5Y7vcnl/MFBHzv
	0ybg0YqxAv0SkeOnOOuCbWhnnU7PF1nP/0VszjpI/8+f6/WExu1lvt7mcD+uL0GT
	EpT7a76ps/Q74JLkbnXnkGrehwJE2HTA9pkr4HY06lC6rO/99b0YaNqiIsHJXPgc
	9vtp/a1+zj4cy900sd+nccK6DTGiQoiNZvrXOU94isoCR3cXVFBrr71k7HXGpjHc
	M+LsgIf1ZfbONUnWCT0Ki4ANzHpnlR3cbaZ4MR/uC4fJ8ws25XsYcoaGclbh1IRm
	BFiYhqWT97oGaUdmwoWVLRkjfXnok4AE24zMU9HXsD/Jfoc+6Dt/y85FfHkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728925247; x=1729011647; bh=Y9fWDk0njtfKHMgF+BBSTKVGJLd+
	3qRMQqMLNyZPAxY=; b=iqzI6YdPk2y3gkIFgxWKZmjZ7zYPtjvw0cJ71ASsGWtp
	ghOJHd8q4j4M0aFiN89MMs0LlXjP9XO06u4Ts5lzP/GdB5P/1adTA9ysi/RV3EbI
	2JDxlArN5GxpDOnfc7SZD/RCHNCv6Ac3HctJcWtJWNA2C2ar1S0deBpgGfIDsUQy
	Xd7aGpKHUu3Z29CsI6mAOOluJgroja9ZZWy9qZ+jTIzA9HJQ3Ffrqlu4Hvuu5qcN
	I7sXa/IfsS6rcbyAgA5qkFMWyv4h8R5ocAxICOaPfdX2+fnRymwfOspgwWHxrYa7
	/wQIf1moqtk0CTueOeUErhtWAi0f1yVb5fLyMCwnMg==
X-ME-Sender: <xms:P04NZxyNNA2yRa_yZa8XvFPPBJLSEO3DlnxH3tIyDdl1bwOLQ4IKDQ>
    <xme:P04NZxRZ7XtFQcZ0blIJOw2rZqKs5837pHZwalKkwR62RikPyfHTk4Y1kPCcjvI7M
    vUKfqLekSmuUuHo3do>
X-ME-Received: <xmr:P04NZ7U952_GG-H84IoQp1Qu8JGCjuzt-Oguxtp8_jEuph92TDVJqAVHA8S4Yc5QEMyUX9foyLg9YzD8ACfLUu05WbU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcuuehurhhkohhv
    uceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeehtdfhvefghfdtve
    fghfelhffgueeugedtveduieehieehteelgeehvdefgeefgeenucffohhmrghinhepkhgv
    rhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehfughmrghnrghnrgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:P04NZzhQpYSF-qbJUjQ06iyo594TXPgjlcAUQ-07VLi99hVK-ED4gA>
    <xmx:P04NZzA8WcCmTsVRDfA2IZV1oiyTx851_5rYXrY8sDrid6sFwj_thQ>
    <xmx:P04NZ8JcOK-vbQ3Db6yj3mzTNz5eOUrQ1ct1ENVPms0ktdPlfLStvg>
    <xmx:P04NZyBcy29m6aMOATpJmbylTZ3m0P6yxaDrNN-0wOspkreeiGJWrg>
    <xmx:P04NZ2OfnXdKgt6KO2m6kyvJLKSGINp--qK-RF6BjfAthyRWQFPuCKUU>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 13:00:46 -0400 (EDT)
Date: Mon, 14 Oct 2024 10:00:26 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix use-after-free on head ref when adding
 delayed ref
Message-ID: <20241014170026.GA845260@zen.localdomain>
References: <02fc507b62b19be2348fc08de8b13bd7af1a440e.1728922973.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02fc507b62b19be2348fc08de8b13bd7af1a440e.1728922973.git.fdmanana@suse.com>

On Mon, Oct 14, 2024 at 05:24:26PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At add_delayed_ref(), if we added a qgroup record, we can trigger a
> use-after-free on the head reference when calling
> btrfs_qgroup_trace_extent_post() since we are not holding the delayed refs
> spinlock anymore at that point and in the meanwhile other task may have
> removed the head reference after running delayed refs.
> 
> So fix this by extracting the bytenr from the generic reference instead
> of the head reference.
> 
> Reported-by: syzbot+c3a3a153f0190dca5be9@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/670d3f2c.050a0220.3e960.0066.GAE@google.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
> 
> This is meant to be squashed into the following patch that is in for-next
> but not in Linus' tree:
> 
>   "btrfs: qgroups: remove bytenr field from struct btrfs_qgroup_extent_record"
> 
>  fs/btrfs/delayed-ref.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 13c2e00d1270..04586aa11917 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -1074,7 +1074,7 @@ static int add_delayed_ref(struct btrfs_trans_handle *trans,
>  		kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
>  
>  	if (qrecord_inserted)
> -		return btrfs_qgroup_trace_extent_post(trans, record, head_ref->bytenr);
> +		return btrfs_qgroup_trace_extent_post(trans, record, generic_ref->bytenr);
>  	return 0;
>  
>  free_record:
> -- 
> 2.43.0
> 

