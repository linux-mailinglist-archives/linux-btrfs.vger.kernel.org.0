Return-Path: <linux-btrfs+bounces-21069-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FeUfJuyjd2k9jwEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21069-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 18:27:08 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E49588B703
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 18:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B28FE3012CC9
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 17:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B4534A3C4;
	Mon, 26 Jan 2026 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="DIFbzr2w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aO4QzFks"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD1422425B
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 17:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769448425; cv=none; b=pn3Dh9iM+YKYk0EX1blnyYYeFJUwQpY1TvBUHEPUkmqr1KEAye18V+rn4HVkTN35qrQ0Yy57euvvYLr5gYChhofhLM0dpe3IU/UEyd/NOP6qjtpaOTO5WIQFh638dilkCOGbNArNbLvKXLtKgzWMKmsyTg7DCjFzYcrblUc5iuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769448425; c=relaxed/simple;
	bh=nHofkBeNFVDhpKbqc0PCSn7ujtGTLwqxhn9Fytc0tTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tN5RLpDajEN7nNcyAxo/kNJAa9oyWv1+8QYpyB4QE8sM1I38VAsqR0ymLTdbLAiMoEmwtdjmzPqbCv/q8cUYR3ls3tx0vqbl/WtegZJNcasL7PIs3UvWNRk01kOfANymFXGbOH7dNGSkRr2hOQ7nlzZ/KnIDnr0tHK5jIoS+IEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=DIFbzr2w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aO4QzFks; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id DC718EC0104;
	Mon, 26 Jan 2026 12:27:02 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 26 Jan 2026 12:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1769448422; x=1769534822; bh=p3hrokllD5
	owE/nYdf7JQ3jIiIlU9a6YK9G08qCtyqk=; b=DIFbzr2w8zAhERQn7QBrtK8Ao5
	rXXyjD0675XhDpSaslfaOoUS5HdiZZAth7NdYen/wc/ZR3J5upHhWYBA7B6df2gb
	QgOup45j70+u6/2z2Y1rXWJ60UXsLLAzWdasLNY+03iYM/w0m9CkXf+TPQuiOCMs
	lfR891IRvAwylVZ9nMddjP4biG9D2V4aGjbdFmEAN3B8BKZmNRxgWx39E0wmfVdr
	fQAJYNn2jPfxAEUSTJIIY0HBnJmWE23LTNUoZoEhxJWglRSjGIChyr9iVRcpDpkM
	iw9ZdiZ/cZFiKo8dcljiJpqZ5aQwvXgZcUukxX1940BIzCWIudhXxcDvQZ+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769448422; x=1769534822; bh=p3hrokllD5owE/nYdf7JQ3jIiIlU9a6YK9G
	08qCtyqk=; b=aO4QzFksssn0q9/jR3qmLkIBoHZxWpyzDDFniAAH+XZQBTlBFRN
	0CC4rYFKIZdbVdBr45739l714VJzWdLpIz5I66Wt3jxcgPQkjtPvF46tqp3c/pgK
	kMQn6TKYIqTigmW8nx/5eUPTJxkWbNrSz6mxU/qmYQzKBPaL2px3JVr8y4ZmiFPW
	ULa3KrpMAGzXcs3Y+DCyFDsOEGDBCtVg2i6opE67X3riWUybWoxjaiqLUDAGsy79
	y0K8S2MS6Xulurw+hAW0/GCnISk5Qyjw1ZNIZ8WUYkmafn9ehw+0I/7PA2SDE98i
	xbWzjYeuWg6KjXA1apJ4/zMf1SMeP4kUoqg==
X-ME-Sender: <xms:5qN3aTdekZQA-wl0SLG54jUdEC0hmWIjbugpZKOPwqqZ-NXpuZKPhg>
    <xme:5qN3aQp_EBu3tPp1KY4bs4y33Ym4g6IE4fTKtJiaVCGCNUw7FUXN6tfcpvN_Vx9lS
    ZkYpvqkC3n_9lJUmIKLEHyadyohbiwGqDCJZGyY00cW_8tF9fPS24M>
X-ME-Received: <xmr:5qN3aZ4b31WasslTV_fCnUhYOIQ9kpJtg5xQ9EWBeoN0eDxa6FWYEtsTfDd-7S6HLFgEsyLjF0vejcSyG-EwddFbFXE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheekvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhohhgrnhhnvghsrdhthhhumhhshhhirhhnseifuggtrdgtohhmpdhrtghpthhtoh
    eplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegtlhhmsehmvghtrgdrtghomh
X-ME-Proxy: <xmx:5qN3aeo5QWUvmHx5QVM5jJEhJkYTyyx9NjQbmEFTPJ1br1TDSYZGdg>
    <xmx:5qN3aThg53D_K372kcBExGHQ_GexnPBZ-k1wGqwy3q6wjiwhDCASpQ>
    <xmx:5qN3aQLJJ0EHXr7eMh7Op8NlfIPZoB3bbAiNZeuddRe_2HjJqRNZWA>
    <xmx:5qN3abBrM_QYVmUe0DeLlLVMN63MVh39TVou4GPS6VlWMj7qSvoktA>
    <xmx:5qN3ab6tfT7bf--PX99z8rC-Gc8xGDUKXG7xIHrABpUCCWBbU5dcK5rL>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 12:27:02 -0500 (EST)
Date: Mon, 26 Jan 2026 09:26:40 -0800
From: Boris Burkov <boris@bur.io>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org, Chris Mason <clm@meta.com>
Subject: Re: [PATCH] btrfs: fix copying the flags of btrfs_bio after split
Message-ID: <20260126172640.GA1066493@zen.localdomain>
References: <20260126080524.612184-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126080524.612184-1-johannes.thumshirn@wdc.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21069-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[bur.io];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:email,messagingengine.com:dkim,bur.io:email,bur.io:dkim]
X-Rspamd-Queue-Id: E49588B703
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 09:05:24AM +0100, Johannes Thumshirn wrote:
> When a btrfs_bio gets split, only 'bbio->csum_search_commit_root' gets
> copied to the new btrfs_bio, all the other flags don't.
> 
> Copy the rest of the flags as well.
> 
> Reported-by: Chris Mason <clm@meta.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/bio.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index d3475d179362..0a69e09bfe28 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -97,7 +97,13 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
>  		bbio->orig_logical = orig_bbio->orig_logical;
>  		orig_bbio->orig_logical += map_length;
>  	}
> +
>  	bbio->csum_search_commit_root = orig_bbio->csum_search_commit_root;
> +	bbio->can_use_append = orig_bbio->can_use_append;
> +	bbio->is_scrub = orig_bbio->is_scrub;
> +	bbio->is_remap = orig_bbio->is_remap;
> +	bbio->async_csum = orig_bbio->async_csum;
> +
>  	atomic_inc(&orig_bbio->pending_ios);
>  	return bbio;
>  }
> -- 
> 2.52.0
> 

