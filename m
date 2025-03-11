Return-Path: <linux-btrfs+bounces-12197-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CBFA5CAA0
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 17:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A081897757
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 16:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CBC25E833;
	Tue, 11 Mar 2025 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="pmhG8tOL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vyT/pfVo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9F525E825
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 16:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709898; cv=none; b=hURfq4Uci5L3DxzxQO6DeT/9Sfo8XbDvK47i9nqfSagEFD8u/lLTQDc+cxJTbopF7ynsDR1C9R4pIGSWXwwF2fmZQ6/csKK5kzG17xbFMRSFr28ngcrP2GW/+DfNasrl8VKV9PMow+ya49IslFkCKw4wA5FNK/xQk9EDKXSSJls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709898; c=relaxed/simple;
	bh=dsT3OUG0eoG1s3zAUEZhGh3wvl6pHWhaoZ/mxG3WXmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pnt7PLIxJqyHiFNX+c5GBH8fKpdzk2a0Zpmw/W4iHbfqnqX4g7ArBDeaRedMYWHSXYUnkUSXebPsJqCgfXzBVXh52zbUQCdSVCAUNz5+7kJAoFlOsQNdxTaVGZAhonFHK2hyhhTsmcv8z3r+uRtsAk98ADefGtSIbci7Oh1hL3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=pmhG8tOL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vyT/pfVo; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9B6871140143;
	Tue, 11 Mar 2025 12:18:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 11 Mar 2025 12:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1741709894; x=1741796294; bh=FpVMvrygxM
	3lMncDCOQYX74Dg18/w37uYNrfc9Cjb8Q=; b=pmhG8tOLtc3VitpFEV2XAf/S8i
	hoOZ5bgju1oMKYhe6MlHOs7h1sFWaZ7JqeE/jx2FFeHjLryFYp86M1/Wz3EWdxvF
	5ejEM+2j4F19C64Vrhm01BJURRffxj0wEQHFtsPpfUwvYWrVZFbWUDZxTrlrmd0o
	MuyEx+vosLc/f8Z0v0CpVu8yMIibuM+4aIBDAWlz82D+w9jvJwFfLDo1VrebNlAd
	XQBFQHYcfVIPOBR07pxiVS72teYyTK3d2wF0SeqxetSylXj6AJi4cyhYFRy2SwUP
	xCsuxJUGMVQBKnBmYJCh5Y+CaHa1K5WLXBlT84Q7NSnXimVtIp5KztkCAjRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741709894; x=1741796294; bh=FpVMvrygxM3lMncDCOQYX74Dg18/w37uYNr
	fc9Cjb8Q=; b=vyT/pfVo7gfiY0X1RfB+b832sRBgpKYqsrVBlYHMuvBYjHAzjgp
	YDiZ3GqbviqeJgf0K3DdiJa35Cpngd5vBtVMupCp7ZLX+T+hgGKKaZ81LXRnBlak
	7drzd/pC2HMrsyzZ3X1qJv5l+mhNuW1xCnjw7wZNR6wAvyj5/mkGU9LQ4FzCSwYR
	QB5eKS7AXYPf3sNN5UBT5jxhZzQD6PdgZh3Hn9WHRHlPQ9cRt4jT4faMHrbWLWEW
	03BEw5R6ekW/EsnXEgAJGoYrbYJd4V2lx2MwBFxVovv8PYZK8HrRP7XHYb5CHbxv
	15bV0VDYVxzFiM30OwVy2RleN4mpJmue3Kw==
X-ME-Sender: <xms:RmLQZ0pQesq0kWqMQ15ZA8WSFpvphyaewALjNofWWm9ed0VjVzDcTQ>
    <xme:RmLQZ6rHZJL28zTKaSq98IbmabhalJzhrfyBjRj2hQCV65e11a8K3hAkFDKy7a2f_
    GqYp1jWGme1r3Sf0aQ>
X-ME-Received: <xmr:RmLQZ5MXZFS73QlzOfpCVfIZ2PGtjlVMo3N5yZaycUyxEbfCGfE0-03Oq_uQZDO9v87sMuRMvdp7CeSiofaXB5mf07U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddvieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhho
    vhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepkedvkeffjeelle
    fhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfughm
    rghnrghnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfsh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RmLQZ76HM1ZaMdYMzTWmR60IK73o2fsFpDjQzbxY1rc-YH504Z7CbA>
    <xmx:RmLQZz5EUSNOIThlIhEa8Dqj2g5Cf8U532BNL1DIMQfoO3-v08TXCw>
    <xmx:RmLQZ7he-Do0BxsBn1ZPAFC1JbVMSe56m1kRGGFOZnHJrBR9MrbLbw>
    <xmx:RmLQZ941F5V6UYKPh3Y52F23TeJR_kpXFhVSE0o7nWc1LdooyFnDTA>
    <xmx:RmLQZzFbnSKfK65RWK1ZU6toP3M7NMCir15CtnLZspRXN38soRfWQbUj>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 12:18:13 -0400 (EDT)
Date: Tue, 11 Mar 2025 09:19:01 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: tests: fix chunk map leak after failure to add it
 to the tree
Message-ID: <20250311161901.GA1354267@zen.localdomain>
References: <f05862e33146ef046f6d377b8b2663b69f2c2e84.1741709026.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f05862e33146ef046f6d377b8b2663b69f2c2e84.1741709026.git.fdmanana@suse.com>

On Tue, Mar 11, 2025 at 04:06:46PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we fail to add the chunk map to the fs mapping tree we exit
> test_rmap_block() without freeing the chunk map. Fix this by adding a
> call to btrfs_free_chunk_map() before exiting the test function if the
> call to btrfs_add_chunk_map() failed.
> 
> Fixes: 7dc66abb5a47 ("btrfs: use a dedicated data structure for chunk maps")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/tests/extent-map-tests.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
> index 56e61ac1cc64..609bb6c9c087 100644
> --- a/fs/btrfs/tests/extent-map-tests.c
> +++ b/fs/btrfs/tests/extent-map-tests.c
> @@ -1045,6 +1045,7 @@ static int test_rmap_block(struct btrfs_fs_info *fs_info,
>  	ret = btrfs_add_chunk_map(fs_info, map);
>  	if (ret) {
>  		test_err("error adding chunk map to mapping tree");
> +		btrfs_free_chunk_map(map);
>  		goto out_free;
>  	}
>  
> -- 
> 2.45.2
> 

