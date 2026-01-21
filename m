Return-Path: <linux-btrfs+bounces-20873-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEixH1hIcWn2fgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20873-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 22:42:48 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E91915E2F3
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 22:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5936A508B0E
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 21:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656ED438FED;
	Wed, 21 Jan 2026 21:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="S5lv8fCb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CWwkB/Dn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75203A9DA1
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 21:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769031757; cv=none; b=eQwgGe3cqF3GzSNbSuzjNKpFsIMBEeRtoBKliRbd9TpnWnxnGlSApIL6rZ/IkM74P06oqlzrcArVccH9OKE4r9G2yNqGdLLSzV6FbeKA+u6+gQzGSSwopyB7sKj0j3Ow/RU5HTLS9K8SD0DsAVxoASw0/DMUtQmi/EhlnzQ4+OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769031757; c=relaxed/simple;
	bh=WqpClatumhlH2dh84o1K75xZjHsKHmK6Rzf0fud+G98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkgU+vT9eZCBvAyvdsyboAKslx63sOFQzrWdXFCHATpgFJrCM58+5nnNgr4N9j+cqGrvtYYti9SzsvmRq5ZdCGTVLilFEq/2zimy0q/ZB0C2PIk6GbMALFQTuyYBwpvclCVZ0iuve0B+Ua0fP7Awg315LKE9MAMvJqz/JtHi5dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=S5lv8fCb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CWwkB/Dn; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 70E901400083;
	Wed, 21 Jan 2026 16:42:33 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 21 Jan 2026 16:42:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1769031753; x=1769118153; bh=GB8Ocd8AZP
	8TrVCUY/+2nFw4qs+xUAcVVzJvU3n4Xsw=; b=S5lv8fCbW7mVJW8Wg3rLx65BDC
	Ib1b9xTgSa5GqogoBpMJoZ7kCO8ss2tqrE05Er0lMo/5ocepsA2m0GzkUgEHvKKc
	WFg08uCoxFskj35Png0OcBhPFXUOHyGHyVfoNYFBqD05TL6Lx12RAiC7BvvKi0N9
	ArN8C4NScZVvNzi7J96zS6YEsoJh/psdHjEw8jGYgRNbh/cAdGojTwTnfcBt05g7
	YJ762G5mRkr5jEIoxlU4Pho/9/u8Mlyf2YjyX6fUQxbqAqFP8//CvvEQafEqc/iL
	5gZfUUMKYHVo3FtgO4x7RZJQR76N0vLyL7n9LNsMuW0FxNn+teNwGY8IhZQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769031753; x=1769118153; bh=GB8Ocd8AZP8TrVCUY/+2nFw4qs+xUAcVVzJ
	vU3n4Xsw=; b=CWwkB/DnJvV0YVDCe3rBnZipS3J8F2TWw+DZpXEEwCXHvGw8/Uw
	DGAiZIox5fliD18Tb7Gl31E/6vOlCNE5/3L5SYoCK5w6lLbASbPB67BfrwqFSlvm
	2wfDPIJA83noZw3q4GJnaMy6ZrV0kLfTkszfQOrQgQhuU/7Csn4459S8GIACMfXD
	MrzyVV7zFd5RK0ph06P4AXSrxSatAhFXTxSsjSyQzbc4lAJr9CjgVxdImD2Pmmtz
	nskAUmJbyhW0lLyITlDaDVAzKEhxu8EsSZkMirwv8W7X2qws5+Vdd0K2kODkynpw
	DR2yPWYdG+NnbfVNRu5rN6TNmNDdHFxDZcg==
X-ME-Sender: <xms:SUhxad5KehZIabQY0ObJqT2Gp4d19lBvYI0WB8vT-pzOr5yN6dVbtQ>
    <xme:SUhxaQ70kNLhpD2PRpTbJDEeEfsSJv5mq_qEQhXy3qY-uUyXne5ml2GsQM6xLSYz4
    RWA6lINKVei4013bESi-eHbxKhZkoSQzO35yhF0wdp2lpUADlu8Hk4>
X-ME-Received: <xmr:SUhxaSF0LTiUPayvYsdE2SE2J28Sm_QDsxvWkzSVyeuqOn_Z0jGkcLPWXLLujWTDsh9mKsT2T6wRAgw9EFTlO8BEHcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeegfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiie
    eiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehfughmrghnrghnrgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:SUhxaRRh9pUtooYmhIVbJkEgsB96q73N0Ay24qmm0zF0L4P5E9XipA>
    <xmx:SUhxaTvLVfWRsx30a54fH-it2J-sSzrBn3xB9NRrkMb8mQhloLcGfA>
    <xmx:SUhxaYx1GqwNJSim8_BCuwoDqrZQp3OfZR1ooBiBtah8uCVbToEbKQ>
    <xmx:SUhxaV6HhK1PYFFeKb_4GF24zD0p5batMFJETjLD2pwr4LtDtPFKow>
    <xmx:SUhxaXv7Xmrz5kdb6x3TrGtEaHu4KE4pOiI6vxW04wnRKUn60bSkqQMS>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 16:42:33 -0500 (EST)
Date: Wed, 21 Jan 2026 13:42:19 -0800
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: deal with missing root in
 sample_block_group_extent_item()
Message-ID: <20260121214219.GB1432482@zen.localdomain>
References: <cover.1769028677.git.fdmanana@suse.com>
 <30034e48a39502638fbac40662914132895cca4b.1769028677.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30034e48a39502638fbac40662914132895cca4b.1769028677.git.fdmanana@suse.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20873-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[bur.io];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zen.localdomain:mid,bur.io:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,suse.com:email]
X-Rspamd-Queue-Id: E91915E2F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 08:52:38PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> In case the does not exists, which is unexpected, btrfs_extent_root()

In case the root does not exist

> returns NULL, but we ignore that and so if it happens we can trigger
> a NULL pointer dereference later. So verify if we found the root and
> log an error message in case it's missing.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/block-group.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 6387e11f8f8e..b3345792f3a1 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -607,6 +607,12 @@ static int sample_block_group_extent_item(struct btrfs_caching_control *caching_
>  	lockdep_assert_held_read(&fs_info->commit_root_sem);
>  
>  	extent_root = btrfs_extent_root(fs_info, block_group->start);
> +	if (unlikely(!extent_root)) {
> +		btrfs_err(fs_info,
> +			  "Could not find extent root for block group at offset %llu\n",
> +			  block_group->start);
> +		return -EUCLEAN;
> +	}
>  
>  	search_offset = index * div_u64(block_group->length, max_index);
>  	search_key.objectid = block_group->start + search_offset;
> -- 
> 2.47.2
> 

