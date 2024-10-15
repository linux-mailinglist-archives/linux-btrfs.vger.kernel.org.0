Return-Path: <linux-btrfs+bounces-8943-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A20299F858
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 22:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E7BE2838C6
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 20:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5EC1F9ED7;
	Tue, 15 Oct 2024 20:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="dQhH2PU5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e33xvKmB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF881F80DD
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2024 20:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729025867; cv=none; b=gmhtsOQbDrWWBzYKRRmjL0xruYh3VVL1mTotTEzCCSKNzZ727fZU0s2YJHboZqQMTU4pjYB8TkzNbPARPzd/oIDty2uJb0e7pBMKP5Yxa3ysTPvQs5kxXX89kYm+YGAiZD+CBOaISwljjOTokgjhlUsOhbewye9KEndxrYDsrd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729025867; c=relaxed/simple;
	bh=yqx8ovaoNsCcjnZnHw4+BSB722qpkqYyVi0OOPVbF8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QihqMI4Cbrf66M1zDYPMcNc9UDBK5rbZjbWrc4AR7W4gUySShbOO59FuojAY8rZ23VPf1zKtqmokbrmR5M5ei4ybGhhuyfE0u38XthW8toHBAmINuqwp/ErZwBp/0SUkbM0dl7WWkLwqygF0v+P8NyP7T3nsIKphjdxe6ceGBto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=dQhH2PU5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e33xvKmB; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B95C11140179;
	Tue, 15 Oct 2024 16:57:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 15 Oct 2024 16:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729025864; x=1729112264; bh=rvrHdQkqj3
	+pxnn6hVEVREwj63cng3Ts7fqByfXd62M=; b=dQhH2PU5fPc4iWWu0TH+8Y1VEc
	gDTX/iA7C8Kt0enkGF98J+iNh3+UQ3EOeYHeA0yGeBdjKZTJQBDcpphAgvCVHyYO
	gQI8TFB26DZCqtcOYpMp/5/wUo1eORgtK86NzLHBG7okZ2dSKGVPoLxZPPQxBto1
	pHuOtypBjcvsn+D3/5TI040lKW8aEAjdPofM3mFV4mSBfqMIjG5HH+7/TvwGdMAn
	0O5w6usqEIir3J1k/fhPt1AadaIw2elsH96kDjRYcBn6t+JT6f5+G5xGEHXEenhN
	6f+KrEEQ3ZNjqIQKIMM0CIq84dFds3gCJwch0DliRgtB9tIDPYJ17r0SiYUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729025864; x=1729112264; bh=rvrHdQkqj3+pxnn6hVEVREwj63cn
	g3Ts7fqByfXd62M=; b=e33xvKmByp9jrqZOPmvWDwFw9Yi0UHEZcYVt/sGkAZzx
	cu9ibbxrBOvKhB8MtVEoyq25/es4ZuQMUW64iQZZRkSxZtTJ/ts9aBIlSw+gI+3r
	L1X0szCpbksi1wqGpyx29NaYidrWb6vvcaw8jmWWhmtUYtCsXFPZArQ5tzOKstY8
	ObLHZ5Db8k9oHBckFH/b24XWa4nP3+sC8gAgkgt9G/08lOLCSAiQyh0pE7PLrW8a
	XpVu1It+NOsBR0OXzwH/hbTFkNxA2sgACNwyjE8wYtCvsmkDLXjwIr22SPefmd05
	ty0a8hJGiGeI/zibZuqoSaJlG92BYfGr+E5oeyGI7g==
X-ME-Sender: <xms:SNcOZ5PnKrrY0HpMpr3MuXFZmQKh5wtKZFNQMsUG31nffkG6SmYnGA>
    <xme:SNcOZ7_HzA1aRXT5XcDWHuiFJJDBO8eOsi4FYCKreScRCqBDzfsHPJH1FsUbywCd1
    hm6PpmA5o1JDHcaopI>
X-ME-Received: <xmr:SNcOZ4T-Gpl9GjtPQCJ2LCEINCe-u2FP76yvodKOND71YHXmS35e6OTQNj8rTpulrV5PIzSapnTzjTw9PSlOFOcLP34>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqne
    cuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfg
    uefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmrghhrghrmhhsthhonhgvsehfsgdrtghomhdprh
    gtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:SNcOZ1tivM8saVatQGWLHoGsLLnyPhz3fKHbQlE38zrijueuH6ODhQ>
    <xmx:SNcOZxdnu4Wl6GdMjRU1f29HqFyT258SM2lE9o-hDuY02ICLTkc5-g>
    <xmx:SNcOZx0rhMuqDsC6NzvJlkXeGV0znDDVfWLnw52X933qmx888SXg2Q>
    <xmx:SNcOZ9_6W71_DooM7e8fpW2wOi6OhCx3QEwL6TWl6ZZeO6KCIby9uQ>
    <xmx:SNcOZyqgTY6PupCx7uot91BBajmKAucg6AsNoJ_4taXSy7iHvvouQz0j>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 16:57:44 -0400 (EDT)
Date: Tue, 15 Oct 2024 13:57:21 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix wrong sizeof in btrfs_do_encoded_write
Message-ID: <20241015205721.GA1841334@zen.localdomain>
References: <20241015113736.1006573-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015113736.1006573-1-maharmstone@fb.com>

On Tue, Oct 15, 2024 at 12:37:29PM +0100, Mark Harmstone wrote:
> btrfs_do_encoded_write was converted to use folios in 400b172b8cdc, but
> we're still allocating based on sizeof(struct page *) rather than
> sizeof(struct folio *).
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 5618ca02934a..5bffc2c77718 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9495,7 +9495,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
>  	 */
>  	disk_num_bytes = ALIGN(orig_count, fs_info->sectorsize);
>  	nr_folios = DIV_ROUND_UP(disk_num_bytes, PAGE_SIZE);
> -	folios = kvcalloc(nr_folios, sizeof(struct page *), GFP_KERNEL_ACCOUNT);
> +	folios = kvcalloc(nr_folios, sizeof(struct folio *), GFP_KERNEL_ACCOUNT);
>  	if (!folios)
>  		return -ENOMEM;
>  	for (i = 0; i < nr_folios; i++) {
> -- 
> 2.44.2
> 

