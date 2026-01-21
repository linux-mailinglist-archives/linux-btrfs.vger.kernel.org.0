Return-Path: <linux-btrfs+bounces-20872-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6C8KCwpIcWn2fgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20872-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 22:41:30 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC985E2A1
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 22:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46DE94FD491
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 21:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18AA429828;
	Wed, 21 Jan 2026 21:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="i/bztVpO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VVdTdIs5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1A9330317
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 21:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769031678; cv=none; b=GpnV67fQ8kUjRQetoRLWAwK3/onZt52WzZ0xWEzpcUoX7ZekISNXPmHSlzzWQ2B8y8Ea7DdnNQDqW7xP+nufSE533s/1no/8EOyqtq613D1pZKVFNM4607GkCfWCSIfl/5nW4p3wRBWdwLOEIOX5aDsbau/+egZZUyozgMyvc6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769031678; c=relaxed/simple;
	bh=REv5fx466h6tdRiJwR6xohp71kUdHovpAHDfHOdzsL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LY61f0WWg/b5e40YiKfhY6M4L6Xcgb7xk2ZNKpljtx0Fh6QJzkcqbmwSd4ejRbpztW/lFbSm4FbloJZJAun3t9sUvPLUV+Ss+FIjBric7LddrB/NiosJf/hNukFettejB89h67SQr/E+TwpUElgGv6psiyR6pRyyz5jRFvOqC7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=i/bztVpO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VVdTdIs5; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A613B1400189;
	Wed, 21 Jan 2026 16:41:10 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 21 Jan 2026 16:41:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1769031670; x=1769118070; bh=vyXebcqrQ+
	/FDdgCdU98B0cnw0KJK98osLJ3nAFnkkM=; b=i/bztVpORRzohYSVhtVQ2TwAxE
	1xOEv0fokuTdqNyV5USzCYWjTNFVuB02oEND9bvgvNvcsk/ox2DuFdiKRGEChZud
	lw2mWZsuOEiwMgBEK55dQBMoAF42gjEQjl7mVdhrF0QiX94AODCMt/l5jpRguOG6
	SFie0jMJ2ZWkPfS5tPiXz6swkM1Hdq9CrRBifhYFnD+zOPpJgg6EOoEcl6GyK+gs
	1MDf5oSr840qel2YuO+dJ5U+Blasmye5hvN9P2BMr8FgeEZsT3yHhe+xnVmbElmK
	E/b+5WwmdErnDxSUp7M93gjqb6oeEKqiq7aiJvRr7flzbqVXKr2TgBIU+nog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769031670; x=1769118070; bh=vyXebcqrQ+/FDdgCdU98B0cnw0KJK98osLJ
	3nAFnkkM=; b=VVdTdIs5lJvbsZoJzFOTB2HVc4hLeE4oeQdE7Urh79x4lF3sb4R
	cz65urBgdvtaB4zhcrn3278ZQ+KNQD0nG2JzrH/TP/LAdYOuNb43t/Yp9mOkpe+C
	c2llC+Ldeqw3y8tCpqBReHy55eMtiGrqjhO6HSv7uj38DKKtb1Tva7jwPpfgk73e
	AMUVBn1b6OWeEAC9peikFyBqFDQhqnugcpg2uQ4mX/r7EQO/ov5jHOcdiRNXq/Dw
	C81wlX8rwVugJGBv7FUdHRzbfo6gE/9IsL0XgTkbuJz7HAzWyS2V8Tgzh5JHVif1
	1pfw0w8/eiRLTeNlM5/8a6pNZXFOm1vw8wQ==
X-ME-Sender: <xms:9kdxaaiPU4OBiXl-D4B5IOpO6iK6SO16FR4L5eBxXJkPvIwTgx2wWg>
    <xme:9kdxaRC6GPVOfR274xC7RUz7Gs8FaQUt7a_-PQQomCrpY05qPANEfi51nMY_MXYVL
    HJhbnkgq3CQdS_h53DM0vBYrjF7ek3HDZVb6D9v_BbAmVO0UEzLCw>
X-ME-Received: <xmr:9kdxafuOui3Y3QMJfQZoBLqzwsVKQCrGyquoi-KZgiV3bAoEkL02xt2QPVviQ5sCyrXqVaWz75bhGi0RYD6lyeQX32c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeegfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiie
    eiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehfughmrghnrghnrgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:9kdxaearIrZbordhrus7HV3LMkq9RAFwDAWKMVWrLoJvp3zjOEgnoQ>
    <xmx:9kdxaaVSAonlhdPZYZAfvlS71ODKAiKweW2K4IlkN32HKXvhEpgu7w>
    <xmx:9kdxaa5Z8U-DGM7WyeuXqbTrxhl7FV4C6q5CEbiTZig6X1LIrroY0A>
    <xmx:9kdxadg1UkzPV71fMphQxlQKYtrZ8BTQ5OZOsMkUh7aS2iCYX0yh6w>
    <xmx:9kdxafVul0xbNaM55pAE67lpIqUO8yF4IsncMQbA-XBeCrhuPP3aqeJM>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 16:41:09 -0500 (EST)
Date: Wed, 21 Jan 2026 13:40:55 -0800
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: unfold transaction aborts in
 btrfs_finish_one_ordered()
Message-ID: <20260121214055.GA1432482@zen.localdomain>
References: <f528a186fae32bf12b9d2a61efa77a1cad66e55a.1769013565.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f528a186fae32bf12b9d2a61efa77a1cad66e55a.1769013565.git.fdmanana@suse.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20872-lists,linux-btrfs=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,zen.localdomain:mid,bur.io:email,bur.io:dkim]
X-Rspamd-Queue-Id: 8BC985E2A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 04:40:45PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We have a single transaction abort that can be caused either by a failure
> from a call to btrfs_mark_extent_written(), if we are dealling with a
> write to a prealloc extent, or otherwise from a call to
> insert_ordered_extent_file_extent(). So when the transaction abort happens
> we can know for sure which case failed. Unfold the aborts so that it's
> clear in case of a failure.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/inode.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 09a7e074ecb9..10609b8199a0 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3253,19 +3253,21 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
>  						logical_len);
>  		btrfs_zoned_release_data_reloc_bg(fs_info, ordered_extent->disk_bytenr,
>  						  ordered_extent->disk_num_bytes);
> +		if (unlikely(ret < 0)) {
> +			btrfs_abort_transaction(trans, ret);
> +			goto out;
> +		}
>  	} else {
>  		BUG_ON(root == fs_info->tree_root);
>  		ret = insert_ordered_extent_file_extent(trans, ordered_extent);
> -		if (!ret) {
> -			clear_reserved_extent = false;
> -			btrfs_release_delalloc_bytes(fs_info,
> -						ordered_extent->disk_bytenr,
> -						ordered_extent->disk_num_bytes);
> +		if (unlikely(ret < 0)) {
> +			btrfs_abort_transaction(trans, ret);
> +			goto out;
>  		}
> -	}
> -	if (unlikely(ret < 0)) {
> -		btrfs_abort_transaction(trans, ret);
> -		goto out;
> +		clear_reserved_extent = false;
> +		btrfs_release_delalloc_bytes(fs_info,
> +					     ordered_extent->disk_bytenr,
> +					     ordered_extent->disk_num_bytes);
>  	}
>  
>  	ret = btrfs_unpin_extent_cache(inode, ordered_extent->file_offset,
> -- 
> 2.47.2
> 

