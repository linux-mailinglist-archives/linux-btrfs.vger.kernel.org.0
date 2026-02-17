Return-Path: <linux-btrfs+bounces-21710-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBCHFbaflGknGAIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21710-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 18:04:54 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1860E14E7F7
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 18:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0465A3028348
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 17:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FC236C5AD;
	Tue, 17 Feb 2026 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="C9AQMxLw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RLtZK+31"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79662283FE2
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771347885; cv=none; b=dgx7vNijHLdvfR7YYMOEq0fSCfXZ7i5UQORDz8b8dNNUR2QfaUmJgiWIXTKwqVJyLDSOXot11ykQnHInmFIrw8t5fDp1kNppnNzpSRxX9VCtLLiKe/IaJ8BG0VOGp7LDiaFKoYzK5cGk8H/hPHPIxW3qjN3qnVNg7Tbis6EJGaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771347885; c=relaxed/simple;
	bh=xWbDrKfKDdEvdzfQMmFzkSPwS/4W8pY+LOKbrPYj1NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfnCfGyROdpbN0kUC/xmeKmElAAvD6BJk/N+LCG5Ds8s5XUSe3iahmoO2RHqCssbnB6sZr3UdggbyBwyNHwkMmDsY2p5rsIHgdtrR7FLAa5cfPUMdNl1NHWobuIcltpU6/U7bXWabq1QvUEesZuRe5QfpzbW66cYAw4eOVeL6KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=C9AQMxLw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RLtZK+31; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id AE7D6EC05B5;
	Tue, 17 Feb 2026 12:04:42 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 17 Feb 2026 12:04:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1771347882; x=1771434282; bh=pZPOfSmf/I
	S8feBfvwrN6OZJ7CjhkNt6/46gofsAIGw=; b=C9AQMxLw9ux/JydbMepi9XxIpB
	V4+qT+RFlgU+LdleKUa5BZWnKqOtaQ/MZlpWytrLHS+LSJi50PJqB9b0Z9d+L8ft
	R63akWh7KBjwHM83P8DDlY/88f+r+C9UbMuN6UMy0mtXByuqs85js8a835lyztD7
	oudFKTXkXdNspBGdliDw/VukbmPOf8xaIJhwH0p7ZR8POYpIxZte97OOHzIGPf+b
	hBIi0IQ2Rc08ZYv1tHr4DT7OdCkmS4jKudR46eOLrBCQL9Pc46rwMGddpxZRELCf
	JTPy4JUgI/omJs/nSnUs2xb+iumiWIVLeC/g1ggV4zN1QqNUGuInHob+OmZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771347882; x=1771434282; bh=pZPOfSmf/IS8feBfvwrN6OZJ7CjhkNt6/46
	gofsAIGw=; b=RLtZK+31XGcZLdijkdTk/+8B/4pWY7Gr0UlMlIo6irny0N+O/7F
	Qjj5C7GTkVc1uxDgQ/4JGAZfv9KO3TN/ah3BuhizqHFdRgSTFaLYl9ca/Y2dmMTT
	0Eiv0aVYSlYr8h0HaV/VJQnPtpE71zWDBLzhfhDmY+7vLPKq1ZKySQu1qCCPUesq
	nPMkjAQsUC3GVWf5uFjjf9LsX1SSfYdUw7YbswsxAd9S6ND+pDh0DErnqmcgurIg
	bqWXcDEa63Vi2TnH8eSh105+zatSpQpH0O+SaKRYTxmgYf+FmWfv1+myyKC2EEvp
	xP7RH9RX1Me531QS0K40Ep78PDIM10+UnGQ==
X-ME-Sender: <xms:qp-UadwLjXf_RUontDVg8gu17p_zhCSdLzIVnmtw9IZmDGa_W9FRHQ>
    <xme:qp-UaUR1tLns32beHJ9kgh3JXzMESQhnVYfD7zhmhxgo83oHAWBfp-9p2ygv3KYrH
    9PMBy-qRb1axIRg4btOCFZNsTnbMnd8BBcsJdWfq3brSfQ0dH7yQrjf>
X-ME-Received: <xmr:qp-UacUTy7P6lCZEHWvHRYgkIFRW_dUkrrnTuCSmr-muwkS30VCn_DTUD7k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeifqhhusehsuhhs
    vgdrtghomhdprhgtphhtthhopegtlhhmsehfsgdrtghomh
X-ME-Proxy: <xmx:qp-UaeZ29umeixrr4Tb0qg-WFtedA8NgCddxKXDdB_JXE1VcGA3JDg>
    <xmx:qp-Uaa15DMow3o5GX4uPQptdBnm1i7GH0Dgyi8AmZ0BzEpZ8-P6OAA>
    <xmx:qp-UaYiKs7z3sOQh-R-aZlY9QBcWDl7HEaxXfQoYeOEXJqCca8aOFQ>
    <xmx:qp-UaWY_M9RoNYy7xHYU_0mCyJOp3KpIBbc0wjCsi4Pg9EBP0dtT-Q>
    <xmx:qp-UadptHYw7t8KrD0x4KuCUBWlaRTdSWUJXV6aTnYZQfsjWf75vG4xc>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 12:04:42 -0500 (EST)
Date: Tue, 17 Feb 2026 09:04:39 -0800
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org, wqu@suse.com, Chris Mason <clm@fb.com>
Subject: Re: [PATCH] btrfs: fix incorrect error message in
 check_dev_extent_item()
Message-ID: <aZSfpwbIsDs1zznG@devvm12410.ftw0.facebook.com>
References: <20260217103419.19609-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217103419.19609-1-mark@harmstone.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21710-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[bur.io];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bur.io:email,bur.io:dkim,devvm12410.ftw0.facebook.com:mid,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 1860E14E7F7
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 10:34:08AM +0000, Mark Harmstone wrote:
> Fix the error message in check_dev_extent_item(), when an overlapping
> stripe is encountered. For dev extents, objectid is the disk number and
> offset the physical address, so prev_key->objectid should actually be
> prev_key->offset.
> 
> (I can't take any credit for this one - this was discovered by Chris and
> his friend Claude.)
> 
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> Suggested-by: Chris Mason <clm@fb.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> Fixes: 008e2512dc56 ("btrfs: tree-checker: add dev extent item checks")
> ---
>  fs/btrfs/tree-checker.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 452394b34d01..9774779f060b 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -1921,7 +1921,7 @@ static int check_dev_extent_item(const struct extent_buffer *leaf,
>  		if (unlikely(prev_key->offset + prev_len > key->offset)) {
>  			generic_err(leaf, slot,
>  		"dev extent overlap, prev offset %llu len %llu current offset %llu",
> -				    prev_key->objectid, prev_len, key->offset);
> +				    prev_key->offset, prev_len, key->offset);
>  			return -EUCLEAN;
>  		}
>  	}
> -- 
> 2.52.0
> 

