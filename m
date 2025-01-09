Return-Path: <linux-btrfs+bounces-10815-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E358AA072A7
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 11:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E73541621E4
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 10:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032BE21506F;
	Thu,  9 Jan 2025 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LoVnGJ2R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yOh+N260";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LoVnGJ2R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yOh+N260"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6958D2040B6
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2025 10:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736417883; cv=none; b=DgQo3CFQK8nrs/usKj1a4nEwnaxklpicNWibFhRgoNb1QqL/DEa4UrdT8R8Ny7SdyZ98TQRCTzyH6VAA9H7uvjCSZPiLVNLK1Z5qEVdwf0nMZlQzwkaihMDV99qY5mIu8EkH3ww6vXKJJuYdtveIQ3ANSn18ZHX+jC8zgZTiujU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736417883; c=relaxed/simple;
	bh=cV0F9Mp0U5zUzUn9ANDAVDZXKQnIEaQ+5sOv3SnDmsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRTUuDdyn4cUGAT0YQgQs8oANgQ0KePkI9Bf4ax6XRNDYdMBDR+RkCGimNvFGu92/hwfthGfDuhahwitz1peK7TmvJBccyV/ujdOWTLxxIamRyy6aqqhBqELyNNIUTuPDM8tevko6SxUzB/xbiFnPG3GMDx50ZfiHxD3dxoV+yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LoVnGJ2R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yOh+N260; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LoVnGJ2R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yOh+N260; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 66AE1210F7;
	Thu,  9 Jan 2025 10:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736417879;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HjrPVM32Y/wJ0maaDL/QVf5MD2SxauCH0AMwgmqkj3o=;
	b=LoVnGJ2Re0aHw4UJp0SyyKLRjHm2vnzPku5XfyOdGBSGPS9jFgRd8aakYwR1rD11TH1116
	vNi/EVVxm4UJ5clKgdGH35yuyltHjOArtBBPX72/b6S7znQ1GvJyj52XmitaEMMTtxYlXH
	ljEu7KFEDI84lChHFH5SUxPtCQF5upo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736417879;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HjrPVM32Y/wJ0maaDL/QVf5MD2SxauCH0AMwgmqkj3o=;
	b=yOh+N260QOEiH5WLe3FYRbUu5LoC6iiFXbznP5b0mUZYDK8ZWYp9UmV6RkW6S3jFe/mxL1
	gguMQYDTC23sweDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LoVnGJ2R;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yOh+N260
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736417879;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HjrPVM32Y/wJ0maaDL/QVf5MD2SxauCH0AMwgmqkj3o=;
	b=LoVnGJ2Re0aHw4UJp0SyyKLRjHm2vnzPku5XfyOdGBSGPS9jFgRd8aakYwR1rD11TH1116
	vNi/EVVxm4UJ5clKgdGH35yuyltHjOArtBBPX72/b6S7znQ1GvJyj52XmitaEMMTtxYlXH
	ljEu7KFEDI84lChHFH5SUxPtCQF5upo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736417879;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HjrPVM32Y/wJ0maaDL/QVf5MD2SxauCH0AMwgmqkj3o=;
	b=yOh+N260QOEiH5WLe3FYRbUu5LoC6iiFXbznP5b0mUZYDK8ZWYp9UmV6RkW6S3jFe/mxL1
	gguMQYDTC23sweDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57325139AB;
	Thu,  9 Jan 2025 10:17:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lxgYFVeif2cwDwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 09 Jan 2025 10:17:59 +0000
Date: Thu, 9 Jan 2025 11:17:54 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH 0/2] btrfs: migrate tracking read blocks from fs_devices
 to
Message-ID: <20250109101754.GB2097@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1736369474.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1736369474.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 66AE1210F7
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Thu, Jan 09, 2025 at 05:01:34AM +0800, Anand Jain wrote:
> David reported btrfs/161 failing during sprouted filesystem unmount.
> Bisected to commit 49136a74162e ("btrfs: add tracking of read blocks
> for read policy"). Now, tracking is moved from `fs_devices` to `fs_info`.
> 
> Tested to be working fine.

Thanks, updated in for-next.

