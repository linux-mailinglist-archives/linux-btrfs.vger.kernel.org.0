Return-Path: <linux-btrfs+bounces-14510-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F38ACF921
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 23:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C18773B0226
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 21:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B536627E7DA;
	Thu,  5 Jun 2025 21:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1lYUO1kP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jY5quno1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1lYUO1kP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jY5quno1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F54627E7DD
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 21:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749157619; cv=none; b=PktMsZ+JUWcpDXYDujzo4ZfjcP9oefU+sHb9FdREniBuBg0oAB/FXahAyDWYDbGzJiBrQdSunXTMZZCutMxj0lZJQ/7xwf6XmafP2lZyPZYI3s/5WQ3YW7Ch+tswVKIhQTuU4pz6PyaqZnpcc/H/vcCWL3oohd0PzrDJzVoe7XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749157619; c=relaxed/simple;
	bh=g0qD0bA4KG4JU6lbRcfG1eZXZRwT5oyl6sH5YWo4c0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQip9b9MM6jLGBCh7s8BjDWSiv9xTZuA3tGTAYL2TMRHwB0S5wMCxJvswQmWs1C79WDAQLmhMvUp7EuU+h+smAkDLOMkESpeD5Iim1rVB2RNeyWQqDPfdPEOXRpNpMEmJ6ah9zoRjkCZpHvbGh2sglyX9zEk36xcMm9ylYi9WWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1lYUO1kP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jY5quno1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1lYUO1kP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jY5quno1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6684D336BD;
	Thu,  5 Jun 2025 21:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749157615;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v1edo5XXEFvm4E3op5Vs6S4durN/X4qYtGOXDp3oGIg=;
	b=1lYUO1kPrDm0xESuAB9RdoMf44jyDirfwcTK2pLRchUm/1g5QA6haMiWc7gsLE1Elh9oEf
	LB/FVpEgloSuQbBbN46c/vE9CEy1aQlNeiLxfvIe+LsLZmIbrChBOYFmsunWJ2ARONtypk
	Nx2S/duB0aFzjStk+xTFBXBxkHOrObw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749157615;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v1edo5XXEFvm4E3op5Vs6S4durN/X4qYtGOXDp3oGIg=;
	b=jY5quno1n2DPko5huYAFgUBF8U4D4aid38dAhaeuQ5ULIFSs6IEYIDDLNdyN4Sg/0X0md5
	SzHC4Eqtg9smScBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1lYUO1kP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jY5quno1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749157615;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v1edo5XXEFvm4E3op5Vs6S4durN/X4qYtGOXDp3oGIg=;
	b=1lYUO1kPrDm0xESuAB9RdoMf44jyDirfwcTK2pLRchUm/1g5QA6haMiWc7gsLE1Elh9oEf
	LB/FVpEgloSuQbBbN46c/vE9CEy1aQlNeiLxfvIe+LsLZmIbrChBOYFmsunWJ2ARONtypk
	Nx2S/duB0aFzjStk+xTFBXBxkHOrObw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749157615;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v1edo5XXEFvm4E3op5Vs6S4durN/X4qYtGOXDp3oGIg=;
	b=jY5quno1n2DPko5huYAFgUBF8U4D4aid38dAhaeuQ5ULIFSs6IEYIDDLNdyN4Sg/0X0md5
	SzHC4Eqtg9smScBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48E3D137FE;
	Thu,  5 Jun 2025 21:06:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EjxMEe8GQmjtQwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 05 Jun 2025 21:06:55 +0000
Date: Thu, 5 Jun 2025 23:06:46 +0200
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: update comment for fields in btrfs_root
Message-ID: <20250605210646.GV4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250604134710.10895-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604134710.10895-1-sunk67188@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6684D336BD
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.21

On Wed, Jun 04, 2025 at 09:46:39PM +0800, Sun YangKai wrote:
> The inode_lock field of struct btrfs_root was removed in
> commit e2844cce75c9e61("btrfs: remove inode_lock from struct btrfs_root and use xarray locks")
> but the related comment is not updated.
> 
> Signed-off-by: Sun YangKai <sunk67188@gmail.com>

Added to for-next, thanks.

