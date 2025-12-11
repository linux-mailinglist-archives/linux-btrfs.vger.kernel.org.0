Return-Path: <linux-btrfs+bounces-19669-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A0889CB6F32
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 19:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 073453002CFE
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 18:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2003191B1;
	Thu, 11 Dec 2025 18:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HRUNLaxJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WgSMqkRi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R9v4WD1A";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pStZvhp8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5732D5B1EB
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765478933; cv=none; b=b9DINvGKfmpcWWoAJ8wTzRsje6wGNqP8f2YQ9bGU9UbQTxnjVBOob2rL3B4OePzRNuugEkaDB1NpTlPHwftLgC6quUlp/uf+IsTXVSe5P5Hw2w+7pYDcjPXfZYr8jwrBO1A28Nolz4rRyrhQc2QSuJzZaipzmFcENXz2jzMfrsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765478933; c=relaxed/simple;
	bh=RzH3/D8hYONSrUXhM2XR1qYT+BeRVYMkvRsy+Vtd9Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBEasYDHb2ZZlD4MlggysHRT1xN2tgGjEI1O0sRNk0+L3qyli+JK96n7LvKdq8rnvjrX9a8kiznhZyaszMrSlFKQMQ/bjr7DTPN/hv1hHVyuFRonc+hVIshc2Gr3xZaOu3P0CU9LXw/zezwYWO2DMpVBLaL0k0T+RhJCelBJOFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HRUNLaxJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WgSMqkRi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R9v4WD1A; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pStZvhp8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2C04D5BCD3;
	Thu, 11 Dec 2025 18:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765478929;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wj2KAfGPp2vwUn55obM7/LAScEdz3dfDIvwSX6w9Frg=;
	b=HRUNLaxJGh5ZjB+7NMOtQzkSHyA8Z2dLtdcewafviK2+Iy3h+Cf5oHI6O6GPZzq1zqHEJu
	2wd85i5nGVFJtBQd8xrLxZ4m3mX1ToccMh+XJCfNAICMhFOPKOTK3fpQirZ3b7EOxx9ggq
	4onSAcBShPjfBV9ASx5JS28l8bKVHuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765478929;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wj2KAfGPp2vwUn55obM7/LAScEdz3dfDIvwSX6w9Frg=;
	b=WgSMqkRirlhd0aKVJEBZ6DhxMeUZD4yD6OHLHPGuAVlz4CaAS58Vxr1rEAl3lcffSyTMV2
	A0DaF9HCX7BkqpBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=R9v4WD1A;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pStZvhp8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765478928;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wj2KAfGPp2vwUn55obM7/LAScEdz3dfDIvwSX6w9Frg=;
	b=R9v4WD1AcNgihW/x6wh3CNLW7BllL2yC0dWSAKG9dQ/EK/MnoM14Xwy0V+jsZWbyfYdKEd
	9tQO8A4R26Ttm7wFepccS8u9KxO18xpvg4xTFWwWWFKgC7rAoKV9VBPPKjfSh9ZQT8MQ/R
	DyqkZOZ4Gua3PgKpgeWTfduo+pZWxgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765478928;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wj2KAfGPp2vwUn55obM7/LAScEdz3dfDIvwSX6w9Frg=;
	b=pStZvhp8U9a7o76iMs2ASm/kDumsRXLxEspgAjQ+Vhfmh+S7gSu3sD67L2qpGHqKPyWzez
	OY8Lfir9EGvhjUDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B85F3EA63;
	Thu, 11 Dec 2025 18:48:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eFqEBhASO2mzLAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 11 Dec 2025 18:48:48 +0000
Date: Thu, 11 Dec 2025 19:48:38 +0100
From: David Sterba <dsterba@suse.cz>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: clm@fb.com, dsterba@suse.com, miaox@cn.fujitsu.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+eadd98df8bceb15d7fed@syzkaller.appspotmail.com
Subject: Re: [PATCH] btrfs: fix memory leak of fs_devices in degraded seed
 device path
Message-ID: <20251211184838.GN4859@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251210132807.3263207-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210132807.3263207-1-kartikey406@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-2.71 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:replyto,twin.jikos.cz:mid,appspotmail.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,syzkaller.appspot.com:url,suse.com:email];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[eadd98df8bceb15d7fed];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.cz:dkim,suse.cz:replyto,syzkaller.appspot.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,appspotmail.com:email,suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 2C04D5BCD3
X-Spam-Flag: NO
X-Spam-Score: -2.71

On Wed, Dec 10, 2025 at 06:58:07PM +0530, Deepanshu Kartikey wrote:
> In open_seed_devices(), when find_fsid() fails and we're in DEGRADED
> mode, a new fs_devices is allocated via alloc_fs_devices() but is never
> added to the seed_list before returning. This contrasts with the normal
> path where fs_devices is properly added via list_add().
> 
> If any error occurs later in read_one_dev() or btrfs_read_chunk_tree(),
> the cleanup code iterates seed_list to free seed devices, but this
> orphaned fs_devices is never found and never freed, causing a memory
> leak. Any devices allocated via add_missing_dev() and attached to this
> fs_devices are also leaked.
> 
> Fix this by adding the newly allocated fs_devices to seed_list in the
> degraded path, consistent with the normal path.
> 
> Fixes: 5f37583569442 ("Btrfs: move the missing device to its own fs device list")
> Reported-by: syzbot+eadd98df8bceb15d7fed@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=eadd98df8bceb15d7fed
> Tested-by: syzbot+eadd98df8bceb15d7fed@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

Reviewed-by: David Sterba <dsterba@suse.com>

