Return-Path: <linux-btrfs+bounces-17852-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCA5BDFD84
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 19:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F6AD486EE7
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 17:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B931338F36;
	Wed, 15 Oct 2025 17:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bPdDAg75";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BRP9pA9+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A0EZA/+J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xw+MkD9Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FBE21B9F5
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 17:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549271; cv=none; b=hZDQ2c/2J1yY9WMQQrdnD+9hYR4bKnhadagQ1AGTRMnUBCJFTmmyIiLtWju9mwCX5NB8dY5+BmEcEt9uiJpxK4HYZZlXehVH8+j0odY0SvVtsboo3ZwYahn9lkWnIVE1vDAnXMdFFqIToyJT5JgFV+ZEF0nRoS2AlPkgSyyS6E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549271; c=relaxed/simple;
	bh=gr8Rm3T7XPVKKZSZijBWerY3+TCgi1nqLes0rUsi7H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NhZ1Nv5k8W+z/xEJdQlhGNsSRXHh4/MCbPo2+/XVy8OBDlyDwS0/+LfnkbUcA1vEMMpJOG5p6VKI1e3CcpxH2l62/glisUrjlydqQyohsBjvs+Ig8anx+lmdqKSElK98vecHo5AmJOdaxTgcLZJVWIzMS2Q/xsrz9vh7XbRH5Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bPdDAg75; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BRP9pA9+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A0EZA/+J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xw+MkD9Q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 599CB33920;
	Wed, 15 Oct 2025 17:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760549266;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eCazV19M5jC+/0DIxVabsVSWDDN0UZpdMxle44nc5T4=;
	b=bPdDAg754H7DxhcB+1gmRCd0xGMmzI6pAk7ys1J0d6dTT5HvociimmST6NMkqA/vuHK3XA
	PTm81c5sJWolM2EsDwSzudlemBqYIAmxzwH/lebywewIc+mGSRpsMF0AZUifnL5KZRsXzX
	6JxCHxUmMbZPD3NvWirTSRgNsir07xc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760549266;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eCazV19M5jC+/0DIxVabsVSWDDN0UZpdMxle44nc5T4=;
	b=BRP9pA9+a3d2rM4Pf03H1KH6EWmufWqLDlQBFkKnmjKTn9puA1Q/Jp+9zMu5SmC9F5g+Cn
	DO2RszXpNEaurQCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="A0EZA/+J";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Xw+MkD9Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760549265;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eCazV19M5jC+/0DIxVabsVSWDDN0UZpdMxle44nc5T4=;
	b=A0EZA/+JqbKCZfaEcq8WVCI0ITut3P4C1Q6fi/fq3qaT7LMrV9Kb9+iYWLXZRrrnf9ZRkd
	l7JZLYfJ2PnQWQr/wAEFMQfRFHV3SGUzAQg/mVTK5hngEns/4j5gM6N0ApNcscJVFu0agw
	pCvyIzvS6wjz+wC/T5/aYRMxGnligRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760549265;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eCazV19M5jC+/0DIxVabsVSWDDN0UZpdMxle44nc5T4=;
	b=Xw+MkD9QtehG1BcK4qolPVqzQxAjQmuIP95h46InuGaIrHdp7KFb3sG7YyQ3hYa8T1hg6t
	pCmYmcjDgrjM4RDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3ADDB13A29;
	Wed, 15 Oct 2025 17:27:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nRXeDZHZ72i1OQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 15 Oct 2025 17:27:45 +0000
Date: Wed, 15 Oct 2025 19:27:44 +0200
From: David Sterba <dsterba@suse.cz>
To: xuanqiang.luo@linux.dev
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v1] btrfs: remove redundant refcount check in
 btrfs_put_transaction()
Message-ID: <20251015172744.GG13776@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251015070521.620364-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015070521.620364-1-xuanqiang.luo@linux.dev>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 599CB33920
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,linux.dev:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,kylinos.cn:email,suse.com:email]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Wed, Oct 15, 2025 at 03:05:21PM +0800, xuanqiang.luo@linux.dev wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> Eric Dumazet removed the redundant refcount check for sk_refcnt, I noticed
> a similar issue in btrfs_put_transaction().
> 
> refcount_dec_and_test() already checks for a zero refcount and complains,
> making the preceding WARN_ON redundant.
> 
> Cc: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Reviewed-by: David Sterba <dsterba@suse.com>

