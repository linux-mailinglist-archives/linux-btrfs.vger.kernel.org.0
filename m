Return-Path: <linux-btrfs+bounces-14271-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBCCAC6AE0
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 15:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5B237A72EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 13:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3B8191F7E;
	Wed, 28 May 2025 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s9E9gtNL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VB/uLKhs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s9E9gtNL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VB/uLKhs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95F7548EE
	for <linux-btrfs@vger.kernel.org>; Wed, 28 May 2025 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748439915; cv=none; b=G3zXcigFowRyH9OI8rev3pHE6fhfKVuD8+dTSnuQhyndRbfWa2rZZCJFudOGrWS52POH8nTkGqXXT5UDPrYO3W8676UxkDUUbARYgRcHNuq9QnY/wocgL32+KxNQtDqWeqN4JUrH8cPQD23BWtkCU9g63ELGmB52AoSNUY41RrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748439915; c=relaxed/simple;
	bh=BYHiUIHrth3oEPS89G2H7FEw3GfRkc+i5VxEo2hprmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeM5Krqa4y55gnd4F6950Yfo9H/Lqg01wwdk8WeZh4YOrbiKNUU0UDJZ7qMQDY2ooyhmKCe9uuOYGgMhe4h6fxfv5ZwBxNFXXt0JUbeglJ9YdokLhHcJD+3okpd7GyDgTMFDSn9kDY9MGwxeCjtPOXG63nZhgiYSro0Wr0J+t24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s9E9gtNL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VB/uLKhs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s9E9gtNL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VB/uLKhs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 388271F79D;
	Wed, 28 May 2025 13:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748439911;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XTbv3oOi0yX3d6jwzno7ACSj5VWq928KLT+OqZqaG+E=;
	b=s9E9gtNL8HuuX09H8qcbS3VEGa49sZT0m2JMt7wVj0ImJeKMDleC1rNE9L+oI2TDXox6BH
	ouhntDZKF+WLcPdzdqUGGNfcLGGm1E9YqBumvAe1zENVzJ4J7BjcXxRL9KlKqJRiC8L4kv
	4FXsyiPuNzAJzHckaUMteSg+we/54Ks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748439911;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XTbv3oOi0yX3d6jwzno7ACSj5VWq928KLT+OqZqaG+E=;
	b=VB/uLKhsUbmzepZljBh5wvudWYdyknypx/UGxqYvbC++EHSy3lDs5NiWtnEhWjjMeMzind
	moKThkSo7tvAcaAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=s9E9gtNL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="VB/uLKhs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748439911;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XTbv3oOi0yX3d6jwzno7ACSj5VWq928KLT+OqZqaG+E=;
	b=s9E9gtNL8HuuX09H8qcbS3VEGa49sZT0m2JMt7wVj0ImJeKMDleC1rNE9L+oI2TDXox6BH
	ouhntDZKF+WLcPdzdqUGGNfcLGGm1E9YqBumvAe1zENVzJ4J7BjcXxRL9KlKqJRiC8L4kv
	4FXsyiPuNzAJzHckaUMteSg+we/54Ks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748439911;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XTbv3oOi0yX3d6jwzno7ACSj5VWq928KLT+OqZqaG+E=;
	b=VB/uLKhsUbmzepZljBh5wvudWYdyknypx/UGxqYvbC++EHSy3lDs5NiWtnEhWjjMeMzind
	moKThkSo7tvAcaAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20733136E3;
	Wed, 28 May 2025 13:45:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 356tB2cTN2hbPwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 28 May 2025 13:45:11 +0000
Date: Wed, 28 May 2025 15:45:09 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: unfold transaction abort at
 btrfs_insert_one_raid_extent()
Message-ID: <20250528134509.GE4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <abe65dcfac248737e735f5c3b9d7e9f165dac802.1747653415.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abe65dcfac248737e735f5c3b9d7e9f165dac802.1747653415.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 388271F79D
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.21
X-Spam-Level: 

On Mon, May 19, 2025 at 12:18:39PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We have a common error path where we abort the transaction, but like this
> in case we get a transaction abort stack trace we don't know exactly which
> previous function call failed. Instead abort the transaction after any
> function call that returns an error, so that we can easily indentify which
> function failed.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

