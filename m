Return-Path: <linux-btrfs+bounces-20216-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6712CCFFC36
	for <lists+linux-btrfs@lfdr.de>; Wed, 07 Jan 2026 20:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C830300F701
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jan 2026 19:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A0B33FE01;
	Wed,  7 Jan 2026 19:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="OhIhfcl2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d6UEmK2i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B813233F8D8
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Jan 2026 19:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767814425; cv=none; b=jbsp/YfsnfyKp5AbLqDYOox1AXxNfxkN3crjkJwsXzLKOnPG+M0VkXoRYHnj0c4t2Xqa8cHzifhBvZ4arYDJabWmDTQVooMSj2fbdvRmyqQ1FsRWUByT3efjlCi9FXQ23OOMt516snNkcxAZs2kuywrk0nhXAj1VMK8n1u397lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767814425; c=relaxed/simple;
	bh=fze4JYbDErgXOtqNNNrVHphNcw/rTQtZ85cL1iudEUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmAusWmavFOdcAMUQIKd/7K/zoJmpPER6oGpyuwz6fQHoQJ1IbCNBNToLUdFGZyGCrdl9SMAyxYkxZze2MbEkaLO/Bo71OUd4/TcMuHuluQY3HlswpqYh/xartA08tqDRCyk9vB6cPMWHYbmgj9Oewe6ggZgvFCwlaK+Z6rsL4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=OhIhfcl2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d6UEmK2i; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C371014000B9;
	Wed,  7 Jan 2026 14:33:41 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 07 Jan 2026 14:33:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1767814421; x=1767900821; bh=SmWuuv3jZw
	r7LWSpsvex5zWnCrFmUs+usoSod9i+kDM=; b=OhIhfcl28PZRBd9vbG2fSqzwLj
	/0jOPlknw1v64Rbh55o6QhNb4AWbEnNXkGoM5MLPwcXMfnPHbB+HrNs80OIjlVlD
	4iTw0IriAILd50/a9swDXu2BQcg7slEI9hgYMuFFx8IqNF+ORP4T6dQim2LNuOGv
	rpOTjnBX431GgXuArGhWYwkHSY7AIn1Dg78jim3ragyojd0d8igOIFFwvELxJ2lI
	RqTw8Kw0b4aj1Oxis5sjXPsA37v1ssPvuwa/i4Ei8x4i0vKT/mNexkCNFvm/91fw
	6bn56JiFiLBK6pRGihTj3O7k6hB581xVrZqaq57xOfO8eOpHKQpSk0O2gsQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767814421; x=1767900821; bh=SmWuuv3jZwr7LWSpsvex5zWnCrFmUs+usoS
	od9i+kDM=; b=d6UEmK2iEps2zAl3DDxX01Bn9VZyLv9tgkxQsiil+sv2fpG5fJg
	bNy17Vf+CrHpTxU/YsI0Lh828rPm+yYjZ3fBntGJYeLFiGaSehq4L6H7Pg38Nl8R
	Ze6MKCF3OsId2Xu+itvkNZEFkRg/ZhX2UPNhXqJA/KYnxgyTeh2yxMWackdu5u4+
	0yxezHAGo452HQHO5KxhO+tsHwVVAaV8v7X5hRFmAINUrWwIDYP6XSLSfOVQD5c1
	u4yiJHTCR/fa1ejSD8sRt5iUrUm6qm5smKyCV9peut6CwoknKyHZBDWRbfrtFio0
	TWZBs8keuFJgQniX5nFVBpX/8JFoNjrE+1A==
X-ME-Sender: <xms:FbVeaW56ApB3TYSegdYN2hHbxmZjVZnAxZnueRwe7_TDKR5RzMBSQw>
    <xme:FbVeaV6UCKWRIkwbImM7Gou1N9qwkg8lhrK7iBPpWPW9xEPiA7la3mV3s1_BPl77_
    wsum4EcP6ag5KfJ1br66vZCdrGLE3bs7EX7gHdDzjD5uzWtOBAuaQ>
X-ME-Received: <xmr:FbVeaTGW5HjEqxeluzUb5V0T1jF9VA7T6l-n-xVxRYicMLXKnX34iC3cur3pnXRTMJA3vY8tQ9hgyJHQYPT-e9bgFkk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdefledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepughsthgvrhgsrgesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrh
    hfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FbVeaeRBSvOzROjh7026UwMYqc6DlQNfpqRl3UmL3VY1NHvDV3qzxA>
    <xmx:FbVeactjx62aaGvDxir7xJcNc15FCdNpt8CYN5LcOMEvhliggcvw0g>
    <xmx:FbVeadzKSciEBhX3JzhKZfrrghhpzOVU4saXWv_jYMv_0ENtLzi55Q>
    <xmx:FbVeaW66ETqfEIiNf0s5kOQCg6x7OLrhmLxIS1aB67B8C-wFHYuUQA>
    <xmx:FbVeaQFsDLrG5YEOWgYehhbN0yNpKCoEvh3EavHjyrDgkYaY3RyKLYcQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 14:33:41 -0500 (EST)
Date: Wed, 7 Jan 2026 11:33:52 -0800
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 02/12] btrfs: unify types for binary search variables
Message-ID: <20260107193352.GC2216040@zen.localdomain>
References: <cover.1767716314.git.dsterba@suse.com>
 <3fb05ea43fb3967a6327c2c0bf81f23fe2e57c82.1767716314.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fb05ea43fb3967a6327c2c0bf81f23fe2e57c82.1767716314.git.dsterba@suse.com>

On Tue, Jan 06, 2026 at 05:20:25PM +0100, David Sterba wrote:
> The variables calculating where to jump next are useing mixed in types
> which requires some conversions on the instruction level. Using 'u32'
> removes one call to 'movslq', making the main loop shorter.
> 
> This complements type conversion done in a724f313f84beb ("btrfs: do
> unsigned integer division in the extent buffer binary search loop")
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/ctree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 1eef80c2108331..0a7ee47aa8aaab 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -766,7 +766,7 @@ int btrfs_bin_search(const struct extent_buffer *eb, int first_slot,

Does converting first_slot to u32 also add a movslq?

Also, why the "q"? Isn't everything 32 bit sized here? surprised to see
it go to quad.

>  		unsigned long offset;
>  		struct btrfs_disk_key *tmp;
>  		struct btrfs_disk_key unaligned;
> -		int mid;
> +		u32 mid;

shouldn't it be unsigned long long to theoretically avoid overflow? Not
really sure why we are storing "nritems" as a u32, I doubt we ever want
4 billion items in a leaf :)

If there was a format enforcable limit, I suppose we could make the
low/high smaller unsigned types?

>  
>  		mid = (low + high) / 2;
>  		offset = p + mid * item_size;
> -- 
> 2.51.1
> 

