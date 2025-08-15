Return-Path: <linux-btrfs+bounces-16093-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DE2B288D0
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Aug 2025 01:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0AE17EE73
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Aug 2025 23:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709A4283C83;
	Fri, 15 Aug 2025 23:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dtGYAP+B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g0APZUy8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dtGYAP+B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g0APZUy8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434C5165F16
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Aug 2025 23:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755300884; cv=none; b=L/NptyAjGhg1NKHzjao8ASO0/c4pE70M5NY4q0z/5vogR33M904vi/XJptdgrCKoqApg0WQkBrsk9VX4F+YGWP6qJ3VFGe75iBxaF98SAEU5PgvyHxyaIsscEKR7yOHUJmNfswQZ2TXn2ut1BtLU26YeqH9eB2Cwy6ZXfzWaO2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755300884; c=relaxed/simple;
	bh=ykZ9W6ajKAZh+JBL7J2fQtqY/3hATidVl7lMkeHxhhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDoic0xb4MUyQR+dL0Dg9uI4d8Xh2b7zWOveB3xFjuqoDm8SLcZ5FO2pAd6A7p9hHpqx372Kz9cDDXjBqbwc0Djg0gSVk92TZ/F0EBXLl/6BDjkC2NHySe4yfwynof/XRQ8qRUS0jDOefU9WKCjHab3164zmeq7oCrdNTitd5tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dtGYAP+B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g0APZUy8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dtGYAP+B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g0APZUy8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 28F5B218F4;
	Fri, 15 Aug 2025 23:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755300881;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JMwBB5EWNAQX5U6ONRtUiKECxZ35aY24q7he3DIL3fM=;
	b=dtGYAP+B3aSLkq0enSrxeGWJqCXH1R08KQpHXfjE+n8BpYJrCVLbAaWDZD2SBr0BKFZg5Q
	fk65dyixg9jz34i6JnQKyxJNb8ACesm9CJHDu97Y2Mz7r3Axo32qLvfJoDCfE0xz1okoUS
	FZYPJzgY+57zJUdFrsff0tdo4meS0JA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755300881;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JMwBB5EWNAQX5U6ONRtUiKECxZ35aY24q7he3DIL3fM=;
	b=g0APZUy8AM+sYfxjoSLI283heaxsp5gAHViTonkyoRwUcp7ol6ZzH9Lrieef1OXuU60cdW
	m3L3Zapm/Per/5CA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dtGYAP+B;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=g0APZUy8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755300881;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JMwBB5EWNAQX5U6ONRtUiKECxZ35aY24q7he3DIL3fM=;
	b=dtGYAP+B3aSLkq0enSrxeGWJqCXH1R08KQpHXfjE+n8BpYJrCVLbAaWDZD2SBr0BKFZg5Q
	fk65dyixg9jz34i6JnQKyxJNb8ACesm9CJHDu97Y2Mz7r3Axo32qLvfJoDCfE0xz1okoUS
	FZYPJzgY+57zJUdFrsff0tdo4meS0JA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755300881;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JMwBB5EWNAQX5U6ONRtUiKECxZ35aY24q7he3DIL3fM=;
	b=g0APZUy8AM+sYfxjoSLI283heaxsp5gAHViTonkyoRwUcp7ol6ZzH9Lrieef1OXuU60cdW
	m3L3Zapm/Per/5CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16D901368C;
	Fri, 15 Aug 2025 23:34:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cToRBRHEn2j2CwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 15 Aug 2025 23:34:41 +0000
Date: Sat, 16 Aug 2025 01:34:39 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: stop checking for NULL transaction when pinning
 log tree
Message-ID: <20250815233439.GI22430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <4629b5fcab544101e9b6f935a7856428abe2f56d.1755248327.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4629b5fcab544101e9b6f935a7856428abe2f56d.1755248327.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.com:email,suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 28F5B218F4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21

On Fri, Aug 15, 2025 at 10:03:21AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At process_one_buffer(), if we are pinning a log tree we don't need to
> check if the transaction is NULL or not, since when pinning we have always
> have a transaction, so we can stop doing the NULL checks and always call
> btrfs_abort_transaction() when an error happens. So remove the checks and
> assert the transaction is not NULL.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> This is meant to be folded into:
> 
>   "btrfs: abort transaction in the process_one_buffer() log tree walk callback"

Reviewed-by: David Sterba <dsterba@suse.com>

