Return-Path: <linux-btrfs+bounces-13666-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C58ADAA9AF0
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 19:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D15F57A2169
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 17:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E50026B978;
	Mon,  5 May 2025 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rklxwPWN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="c4MyWA80";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SPt74Bkl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UF3j7C7O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C945419DF60
	for <linux-btrfs@vger.kernel.org>; Mon,  5 May 2025 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746467059; cv=none; b=PwHVfFGxLsENlrrba4CvCNzOGrp/IDb7yMmWOgcuhzx8xQLNJIfc2Jk2QFxqKpc11xUpJKHuWw4UTZlnIuPNK36iG1uTIUoufTKJEpXk2Vq9YioGdNmc7dSlA6QTQQwmvoXaK3KfZnxUlELyIVPnK+8dljFjuclhM0O2v7xMHm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746467059; c=relaxed/simple;
	bh=3ekdWHSlXOTxnq3SZCKPDIoBtW4NgcGn/4AHfSRrw90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKat8PRcEO3cO3kP3pPWuky9e+7LaaylTiVDulhpF/X7ywjEM4mUpCgmefWtnOg6FqxmI/TNFKHvjWRqvs8hhhqet9CW7CGrYZqgVO7H5UKUNNnwrwLtcZ6LIwbvaRv/1K3/GEhcvoYagciqohpS0N3Jb6G/KRBi2bUb5MhqWKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rklxwPWN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=c4MyWA80; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SPt74Bkl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UF3j7C7O; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ADEDC1F453;
	Mon,  5 May 2025 17:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746467053;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bA0fiPeco12milI2aTK6ZkwinYtkWKWd0DgFnyhcJjk=;
	b=rklxwPWNNHSdPMwXZI8YQGM77tvyZTrKHKlPkZKRDNQZwCqZkkat9fV5J/6ecmSTh8cdpP
	MTmV/nSvYhT92NMSxFVKmHSSbKfSe5PJJzN419VVsqK1jKR6pKdN6G0WvnFuxaX+rG4qgE
	miKMcQUIZZqmNt0UA+AhHUUrKzyagXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746467053;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bA0fiPeco12milI2aTK6ZkwinYtkWKWd0DgFnyhcJjk=;
	b=c4MyWA80FLP9N5zHk+zgBrKo5jvKxYTaRRsUBwB1SV/B+2gs/VTIfpt/0Wlk7pVPb/aYGg
	D8vYUl2vemO5D3Bw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SPt74Bkl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UF3j7C7O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746467052;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bA0fiPeco12milI2aTK6ZkwinYtkWKWd0DgFnyhcJjk=;
	b=SPt74BklrTgJYFPYAIpGfWvz1IiMkItM8OR3isSQcpaZIYRnsnP92rgMnJpXn0b4d4QhAn
	MZrRyeh8X9IsPDXujYQ/R0rZeZf8WdbJgCiSWDy5lCseQH6PC99hnctGpcFREPnzYaV80B
	Qtn1JLnGnc14ZpP+sqGrDtwd9Sh437g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746467052;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bA0fiPeco12milI2aTK6ZkwinYtkWKWd0DgFnyhcJjk=;
	b=UF3j7C7ON0VedBZUIPU9RofHqtOsu7h9bM4nYFtonuA2TFF8/+DGMRTeyKr+us9ccxKTJz
	/72bfobcgoGn4SAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9614213883;
	Mon,  5 May 2025 17:44:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sZxtJOz4GGiABAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 05 May 2025 17:44:12 +0000
Date: Mon, 5 May 2025 19:44:07 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: scrub: reduce memory usage for each
 scrub_stripe
Message-ID: <20250505174407.GA9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1746442395.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1746442395.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: ADEDC1F453
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, May 05, 2025 at 08:31:02PM +0930, Qu Wenruo wrote:
> The first patch fixes a scrub error reporting bug that metadata bytenr
> mismatch is reported as csum error, not a metadata error.
> 
> The second patch reduces the memory usage of each scrub_stripe by 24
> bytes (on systems with 64 bits LONG), this is done by aggregating all
> the small bitmaps (at most 16 bits, as we can have at most STRIPE_LEN /
> blocksize blocks per stripe) into a larger bitmap.
> Just like what we do with subpage helpers.
> 
> This will introduce a lot of small helpers:
> 
> - Set/clear bitmap range
> - Set/clear/test single bit
> - Bitmap weight
> - Bitmap empty check
> - Bitmap read
>   The last one allows us to read out a unsigned long and use it for
>   various bitmap operations directly.
>   In fact the above weight/empty are just a wrapper around the read
>   helper.
> 
> Those helpers are small enough thus can be inlined, this will slightly
> increase the overhead but saves 24 bytes per scrub_stripe, and we have
> 128 scrub_stripes for one device, saving around 3KB for scrub/dev-replace
> per device.
> 
> Qu Wenruo (2):
>   btrfs: scrub: fix a wrong error type when metadata bytenr mismatches
>   btrfs: scrub: aggregate small bitmaps into a larger one

Reviewed-by: David Sterba <dsterba@suse.com>

