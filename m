Return-Path: <linux-btrfs+bounces-18757-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6305FC39672
	for <lists+linux-btrfs@lfdr.de>; Thu, 06 Nov 2025 08:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D68F0350375
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Nov 2025 07:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC9B23BF91;
	Thu,  6 Nov 2025 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EpQ8A9/e";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7LnKmFWD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BGsZfIsH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MlA6C94z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F59136B
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762414249; cv=none; b=RF8AHKbvk2bkZePOoZc7jNWfaUYE2H6DuxBUxqxLj2MCjydlzuC6Qr+hou4y0Ajmm11ieoabuPGhwf1+0XAnGarqtT+5pvE0oorCJY6c/ijAIHqW/GB7FBjbfCc6ZlFOi6W4anXkzYozOrtR7TMcpLxFtNYtxr19ceE8kZMkqqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762414249; c=relaxed/simple;
	bh=cG+y6uD6cBBYB7vi4u1jLO1ArH7X64AuttUelNZrTFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEU5xaZPDKZccf/KxVZ/ndYU0orIlpc2j4uhtnxAt0uJCAtFZXfLwh5OWfZqZPaU4+ea1M26A4zoqyBH6ajwGqWvqWsq+dB6GiBALqlFdH99VujRiMLlboHexuMHc9RLAV2p1ROgBkoRQ/DtB7XNgFZpHZ/SeOkgwhzLhTUk4EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EpQ8A9/e; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7LnKmFWD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BGsZfIsH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MlA6C94z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5444A211C9;
	Thu,  6 Nov 2025 07:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762414246;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hCWhrukHj81Rz0IqTkBZ1kFiHF41nWoLKh3i0ZHuZto=;
	b=EpQ8A9/eGRMDKHViZ85DLnL05+EIhSSZdjsrPGbvq3oDQxi3wEX4ScH9jt4r0tKqzXI9r2
	1sAoZUEoK/OcSy0Q6YF53KAFo0cvNwqp8xX3PXGWh2j19sO571o1QPPNgTBSkcQp+eAk8L
	PnlZELurdBb1cb7PoWqDnpDOqhJMAig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762414246;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hCWhrukHj81Rz0IqTkBZ1kFiHF41nWoLKh3i0ZHuZto=;
	b=7LnKmFWD13w9eRja9jq5n/GaCfTOpdegAQAsbrns2fQQvEhT9QssXIHs3mvE3haF/KKvKu
	wEj22Jt8VvANleBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762414245;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hCWhrukHj81Rz0IqTkBZ1kFiHF41nWoLKh3i0ZHuZto=;
	b=BGsZfIsHKwD9k9jmlONa3c5RZIhgR3WkLH+VokpyFmIQiRaXDA4xHqkYjsY+C2ux62OQ6v
	hOUTNI0RFj+DJfQIXkPkJ/kQpcBdciPHK+YEmnjgRahOFWZOTZYwccxr6V4d/uAWJk18dl
	PkWMk2YHBJLGVLQIJ+PBBtr1Ami/Nq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762414245;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hCWhrukHj81Rz0IqTkBZ1kFiHF41nWoLKh3i0ZHuZto=;
	b=MlA6C94zV6idBwtJCwpZA8lZYwoXJ/2eg3ytfqlgfdGFdsXx+p06cSPTn/tLULmGKS4f/r
	nlL69ZqYUglGlmCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44DA6139A9;
	Thu,  6 Nov 2025 07:30:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X0SXEKVODGmuHwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 06 Nov 2025 07:30:45 +0000
Date: Thu, 6 Nov 2025 08:30:44 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: make sure extent and csum paths are always
 released in scrub_raid56_parity_stripe()
Message-ID: <20251106073044.GS13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <83ada67a04aee0542397e7442f6c6dd1d0719e60.1762336672.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83ada67a04aee0542397e7442f6c6dd1d0719e60.1762336672.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-8.00 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -8.00
X-Spam-Level: 

On Wed, Nov 05, 2025 at 08:28:12PM +1030, Qu Wenruo wrote:
> Unlike queue_scrub_stripe() which uses the global sctx->extent_path and
> sctx->csum_path which are always released at the end of scrub_stripe(),
> scrub_raid56_parity_stripe() uses local extent_path and csum_path, as
> that function is going to handle the full stripe, whose bytenr may be
> smaller than the bytenr in the global sctx paths.
> 
> However the cleanup of local extent/csum paths are only happening after
> we have successfully submitted an rbio.
> 
> There are several error routes that we didn't release those two paths:
> 
> - scrub_find_fill_first_stripe() errored out at csum tree search
>   In that case extent_path is still valid, and that function itself will
>   not release the extent_path passed in.
>   And the function returns directly without releasing both paths.
> 
> - The full stripe is empty
> - Some blocks failed to be recovered
> - btrfs_map_block() failed
> - raid56_parity_alloc_scrub_rbio() failed
>   The function returns directly without releasing both paths.
> 
> Fix it by covering btrfs_release_path() calls inside the out: tag.
> 
> This is just a hot fix, in the long run we will go scoped based auto
> freeing for both local paths.
> 
> Fixes: 1dc4888e725d ("btrfs: scrub: avoid unnecessary extent tree search preparing stripes")
> Fixes: 3c771c194402 ("btrfs: scrub: avoid unnecessary csum tree search preparing stripes")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

