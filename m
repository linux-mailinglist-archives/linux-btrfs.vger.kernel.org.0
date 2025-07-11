Return-Path: <linux-btrfs+bounces-15472-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0323AB023AB
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 20:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA3EB3A8BBF
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 18:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB072F2C75;
	Fri, 11 Jul 2025 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v8pSC8at";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DOGn/re0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v8pSC8at";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DOGn/re0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CAC2F2C59
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 18:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258647; cv=none; b=pbJqnYmuZ1Fzz6ymNssiLlyIa/hUHG9Mr6aTNzcS/ZBFZZK+SBYD4Xg4kV59jytqZ5vg17Z5MUaZEq0veW7rGnDQWbumfKijCjjiOXL5nQTYrj532CXamHYlPIKyZxG80Ut8s7kLLZnQeqJOLcBhGcm8+tsb0lqhNNeDBqbQylE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258647; c=relaxed/simple;
	bh=9uc7tqFJSsKvvirKtl9aDDvA0xNayjm3qbX3AUBdP+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFgZ5BWpLp8phY81k5ty8MIx7TXlbVBbdXviALRNqa2n7AI0eI8CHTuc5fSCCNuU3VowjsMvfAwZvOSVYVS1KLXVWZNEg86sW5Y1iKqRR3dBPix71CePZpGRDZdbBAyNWOf3uKNT+8VXSjhRtz6Fp1kXbwQgd4gxybmciIqRSU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v8pSC8at; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DOGn/re0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v8pSC8at; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DOGn/re0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A20B01F7A5;
	Fri, 11 Jul 2025 18:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752258643;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mE2W6ZOm5Asjl9NtZ664HL6eLfYOclSrfebXSEIsbRE=;
	b=v8pSC8atd0iulfr55NZCv2+rZ/09vcCz1BiGS5eCb6qZmZOuEWLsWV9bhT83zYXK/2TEqO
	c+WX7RMBcT2BtGIDJk2yRLQHmN6ezkXFUR6F5pB6v2xzhYatSchE93Y7QKcq1b7XivL9bG
	rIt+UDaWAHxRKk9cgNWvltic874vd0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752258643;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mE2W6ZOm5Asjl9NtZ664HL6eLfYOclSrfebXSEIsbRE=;
	b=DOGn/re0J4qTp1jDEM9QuBiAzcdkBxgOyDj3/2qVYvpwvoa+zo/NkeEzkU6dVMBJCAjf3Z
	Vuh5hC9B8nqo6vCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=v8pSC8at;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="DOGn/re0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752258643;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mE2W6ZOm5Asjl9NtZ664HL6eLfYOclSrfebXSEIsbRE=;
	b=v8pSC8atd0iulfr55NZCv2+rZ/09vcCz1BiGS5eCb6qZmZOuEWLsWV9bhT83zYXK/2TEqO
	c+WX7RMBcT2BtGIDJk2yRLQHmN6ezkXFUR6F5pB6v2xzhYatSchE93Y7QKcq1b7XivL9bG
	rIt+UDaWAHxRKk9cgNWvltic874vd0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752258643;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mE2W6ZOm5Asjl9NtZ664HL6eLfYOclSrfebXSEIsbRE=;
	b=DOGn/re0J4qTp1jDEM9QuBiAzcdkBxgOyDj3/2qVYvpwvoa+zo/NkeEzkU6dVMBJCAjf3Z
	Vuh5hC9B8nqo6vCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 464D01388B;
	Fri, 11 Jul 2025 18:30:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cd/rD1NYcWifGgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 11 Jul 2025 18:30:43 +0000
Date: Fri, 11 Jul 2025 20:30:41 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: set EXTENT_NORESERVE before range unlock in
 btrfs_truncate_block()
Message-ID: <20250711183041.GE22472@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b780ff5c6ffae11065555177e508a1c78cdf9ad9.1752049280.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b780ff5c6ffae11065555177e508a1c78cdf9ad9.1752049280.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: A20B01F7A5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21

On Wed, Jul 09, 2025 at 09:26:01AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Set the EXTENT_NORESERVE bit in the io tree before unlocking the range so
> that we can use the cached state and speedup the operation, since the
> unlock operation releases the cached state.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

