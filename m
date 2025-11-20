Return-Path: <linux-btrfs+bounces-19213-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 84865C73CA3
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 12:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E63DA4EF216
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 11:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FF032BF38;
	Thu, 20 Nov 2025 11:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PYg51p6C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="daMd1/ff";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PYg51p6C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="daMd1/ff"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236FA2FB0BF
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763638759; cv=none; b=QyLme1UpUA+P1xAyyMFUPmAwZixYP2SR9DdM4GXY4Fn2982swP24BPmJQsPSJMwkrnetai6q6Z7TB/Is7gT1m24TJBfPNjUbCVkrmPNYhHOfThE6aJIneCrTkMzKq4RF18+VzMHW4aa5qQLktxzr6zrQyVZ4YeQDq1GutSw+K1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763638759; c=relaxed/simple;
	bh=eCEQlM1ZPHcdb0LzO9aasr1BmFgRYpV7XZDFMmw5Lew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AD9N+Uhaad3URPkHTX3jHg6sIMxrTX/fNxuiU1LRY47Rco2Lpq+c+btJamCESDGho6YV6XkguL3MDiYlAv6GReYqCsKm1Zu/LSNV7YG+xcX1A7z69WXps8PTfa6U9p9b1I/ys6Vv02W7FiStf95KyhqO0MP4vQQ1fIN7YFlDv3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PYg51p6C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=daMd1/ff; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PYg51p6C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=daMd1/ff; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0F05B209DE;
	Thu, 20 Nov 2025 11:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763638755;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oBzrB560OhFtyq+dGqPxE/BexZfy4zuhrMa2P4rKZWk=;
	b=PYg51p6C8ZdqqxhcGOB9FggUeAMW01ZmO7CcQmnqsprUj6ULCt6TPaI2e/iYIIeDyLQmvP
	vDWyq2uUshOjo+IMLhK/XmDO5RQbMR6iZJ/IgEg1HuB0ojkcXwX2818KfaVZm9fb58nHwz
	Zrq/v/vBdXRuAfZutlRiBgvhetXpIAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763638755;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oBzrB560OhFtyq+dGqPxE/BexZfy4zuhrMa2P4rKZWk=;
	b=daMd1/ffQPsc4A/duuHzn3TRyoXgYrAwPChdxI4fBUES+9ByLfQsraQxB9piLkdk0t1pZZ
	WZrXod7BeeGGoBAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763638755;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oBzrB560OhFtyq+dGqPxE/BexZfy4zuhrMa2P4rKZWk=;
	b=PYg51p6C8ZdqqxhcGOB9FggUeAMW01ZmO7CcQmnqsprUj6ULCt6TPaI2e/iYIIeDyLQmvP
	vDWyq2uUshOjo+IMLhK/XmDO5RQbMR6iZJ/IgEg1HuB0ojkcXwX2818KfaVZm9fb58nHwz
	Zrq/v/vBdXRuAfZutlRiBgvhetXpIAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763638755;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oBzrB560OhFtyq+dGqPxE/BexZfy4zuhrMa2P4rKZWk=;
	b=daMd1/ffQPsc4A/duuHzn3TRyoXgYrAwPChdxI4fBUES+9ByLfQsraQxB9piLkdk0t1pZZ
	WZrXod7BeeGGoBAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED4D33EA61;
	Thu, 20 Nov 2025 11:39:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qqi/OeL9HmkjIQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 20 Nov 2025 11:39:14 +0000
Date: Thu, 20 Nov 2025 12:39:13 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: send: add unlikely to all unexpected overflow
 checks
Message-ID: <20251120113913.GI13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <70cee567e5423a6c87196db3ff6622ef9b5c2ccb.1763570949.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70cee567e5423a6c87196db3ff6622ef9b5c2ccb.1763570949.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-3.99 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.19)[-0.954];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -3.99

On Wed, Nov 19, 2025 at 04:52:14PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There are several checks for unexpected overflows of buffers and path
> lengths that makes us fail the send operation with an error if for some
> highly unexpected reason they happen. So add the unlikely tag to those
> checks to hint the compiler to generate better code, while also making
> it more explicit in the source that it's highly unexpected.
> 
> With gcc 14.2.0-19 from Debian on x86_64, I also got a small reduction
> the text size of the btrfs module.
> 
> Before:
> 
>   $ size fs/btrfs/btrfs.ko
>      text	   data	    bss	    dec	    hex	filename
>   1936917	 162723	  15592	2115232	 2046a0	fs/btrfs/btrfs.ko
> 
> After:
> 
>   $ size fs/btrfs/btrfs.ko
>      text	   data	    bss	    dec	    hex	filename
>   1936789	 162723	  15592	2115104	 204620	fs/btrfs/btrfs.ko
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

