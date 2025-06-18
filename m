Return-Path: <linux-btrfs+bounces-14773-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CD0ADEAF3
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 13:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4046A3BEF8E
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 11:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B032E266E;
	Wed, 18 Jun 2025 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XdJqEFs8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vKnjd6hv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lbo5I48W";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vuNEbxa2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01632DFF3E
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Jun 2025 11:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750247466; cv=none; b=qzYi7lpH+IfBQQ8+WLgS9qQ40kzEMI5X8jAkqUSiuyLYyxCYGgKLEDltmQffzMPSYJpQsUybjLULCfTMocNp2YnuvA7Ynot/MAa6axHtXAWnKyn7SiThACQfEsSRMgHQWy0qfknwcsR67cj73lKh69iqnP35FY3xCaXo109gGA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750247466; c=relaxed/simple;
	bh=yrKSquZhwzG57TiQXO/GctycSWEnDFQRHJW8Q59VZ14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyWmqfQKgVm6SBpGksfSguUpQj4P6JscuEBT9ewId1J9kirL4t34OwT852cnYRxzFUOTAlSYTp2uvCOwVE1kMB2WCxlLEZ/IrULL6Ie76lUzN19Yrfn+ixu+ke94GhdtjFhAH4cdq/aj+Xfh3xydfdQypMH5hEJS2ulh/542WvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XdJqEFs8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vKnjd6hv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lbo5I48W; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vuNEbxa2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D89652120A;
	Wed, 18 Jun 2025 11:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750247461;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wvWcmaSoO/L9w163ksQ1dIGD0MehuuTf2O0htpwEN3Y=;
	b=XdJqEFs8+gaXbFJixNyPucsn5/ssj1+R72soW+pLfGsUwzjuGFylZ3mWXTcW1Liys3Jibl
	aopIuDIdw42ATQIbzw/ClSdr58etyXJnXtexKZPLCff6wu76KrXk706slVkyn8VrKky0bx
	f7AFMNG61Z3z7B6oxAyIpbtVVM8XE/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750247461;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wvWcmaSoO/L9w163ksQ1dIGD0MehuuTf2O0htpwEN3Y=;
	b=vKnjd6hvvMTHdsFn7a/B4hNKKjy+bLEIgzgGKRKNXgZB8WukNKBv+YMJieTGD2+MgxzPXe
	w33TjyAHcbaGaeBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lbo5I48W;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vuNEbxa2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750247460;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wvWcmaSoO/L9w163ksQ1dIGD0MehuuTf2O0htpwEN3Y=;
	b=lbo5I48W1dQ75Y3JxDtLeWTJR8AaLrr12BqbPwwvB/ZfpHFmhNp4LOjgn6Ob5vOaza2qvr
	HdBB/mbHawLMALEcjrEf2f2cz69909+3K/2LphEowj3Elyu3nxYoHOGuw/69n3R+Onh6dl
	CEkTNX/z118bHW3gqcWXnWFq/9N1jCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750247460;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wvWcmaSoO/L9w163ksQ1dIGD0MehuuTf2O0htpwEN3Y=;
	b=vuNEbxa2z/8K3i+6+XX34QQgkAmgOGqCoIIeA/X2yRlRmUwL53St3f4vqnSTQKZ6HHeme+
	ZzTdy92ClM3hM4CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFBD213A3F;
	Wed, 18 Jun 2025 11:51:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CXpULiSoUmhJRgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 18 Jun 2025 11:51:00 +0000
Date: Wed, 18 Jun 2025 13:50:59 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/16] btrfs: free space tree optimization and cleanups
Message-ID: <20250618115059.GH4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1750075579.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1750075579.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D89652120A
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:replyto]
X-Spam-Score: -4.21
X-Spam-Level: 

On Tue, Jun 17, 2025 at 05:12:55PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A free space tree optimization (last patch in the series), and the rest
> mostly cleanups and preparatory work. Details in the change logs.
> 
> Filipe Manana (16):
>   btrfs: remove pointless out label from add_new_free_space_info()
>   btrfs: remove pointless out label from update_free_space_extent_count()
>   btrfs: make extent_buffer_test_bit() return a boolean instead
>   btrfs: make free_space_test_bit() return a boolean instead
>   btrfs: remove pointless out label from modify_free_space_bitmap()
>   btrfs: remove pointless out label from remove_free_space_extent()
>   btrfs: remove pointless out label from add_free_space_extent()
>   btrfs: remove pointless out label from load_free_space_bitmaps()
>   btrfs: remove pointless out label from load_free_space_extents()
>   btrfs: add btrfs prefix to free space tree exported functions
>   btrfs: rename free_space_set_bits() and make it less confusing
>   btrfs: turn remove argument of modify_free_space_bitmap() to boolean
>   btrfs: avoid double slot decrement at btrfs_convert_free_space_to_extents()
>   btrfs: use fs_info from local variable in btrfs_convert_free_space_to_extents()
>   btrfs: add and use helper to determine if using bitmaps in free space tree
>   btrfs: cache if we are using free space bitmaps for a block group

Reviewed-by: David Sterba <dsterba@suse.com>

