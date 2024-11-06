Return-Path: <linux-btrfs+bounces-9374-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5852D9BF80D
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 21:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8940D1C22089
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 20:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FE820C336;
	Wed,  6 Nov 2024 20:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GWQW2Xbx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cT8Nrlxg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sV2W9LVT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HFgw21iZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ECA20C321
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Nov 2024 20:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730925292; cv=none; b=rlDJbgRLkkHxSZGYFCmFwfJEEA3Bx6uFU3cQ9Gt/cMqmKl2dZ4avvI4MojIAh7K7xsPNKT0ovjrg1Fgp2WmEXq/lzN2fPudgBy4SeA3G0VNhGTojSoPgriVlnv9uSnMyIjSyFh2H+RwmQWMumVdckgdNN0nXEtzm1EaEOs0vxJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730925292; c=relaxed/simple;
	bh=vhT6V9jQqfY94uH2olR5AuZarPWPhLxW7PXVt6PJxKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eqvh4uEaz6mnwBBa/byDjNJLSmBsaNdCmPtweI7USi7pPf12brAIoJtD2s4tsmL901smdl/dIkAq1H+6e6dVWAxF8c2G+OBvtJFn45RMcR0NhGuarSmFK2G22DEORBOZVZI3pXwS/dMnCwGeBWe41dgXvjqnkqIaVSxE1fUJPfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GWQW2Xbx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cT8Nrlxg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sV2W9LVT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HFgw21iZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 655F81FB72;
	Wed,  6 Nov 2024 20:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730925288;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R/8SvvdVt38QVA198YGatFYIHksfmxT9els7VBjnuE0=;
	b=GWQW2Xbxe1BPCvAyG71S5ufH73vPsFL4iWgq5s11baq7aa8Pw56gOCbOMVrsrP/PI0sX2V
	ogPdVIyY7YjX4eS9n9ITlQ7wSNiP2JqcG4HoXO8hrIlHt8bwk0QvDrZwA6xz91VRlN5p4v
	mSAwKxmx+85+zu/Re8Tq7UaHLSej0yg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730925288;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R/8SvvdVt38QVA198YGatFYIHksfmxT9els7VBjnuE0=;
	b=cT8NrlxgX/XL1gOoxdpNBW3VbzHu/8b2yOSgMVclFp0gUjzs9/iTxdinZUwnbMAxokbzAm
	1GudjnghKU8A48Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sV2W9LVT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HFgw21iZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730925287;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R/8SvvdVt38QVA198YGatFYIHksfmxT9els7VBjnuE0=;
	b=sV2W9LVTFC/uUDRF3EQZsN7WgMYkNWY/eDx/iHvya84IIZRxL4hBxS0w0fQVw6pVMI4zmj
	K6WpNmZZ7Uhus18gblsaSuwGC8yNHF7GtDxhqPfoJo+YlCbTomT7wgmP77aHzZXmMLCIip
	02XkxLKWy/k3PPdjf5NbqMJw/vF98so=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730925287;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R/8SvvdVt38QVA198YGatFYIHksfmxT9els7VBjnuE0=;
	b=HFgw21iZ3jFjkHiPNoMT49DNRlKz/4ZOfBGJGcJyZSXS12oAL3k6NdhLFy0NKIFAWT+0R2
	FHqQgOV5m3tE08Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BD51137C4;
	Wed,  6 Nov 2024 20:34:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uIv8EefSK2dfKAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 06 Nov 2024 20:34:47 +0000
Date: Wed, 6 Nov 2024 21:34:46 +0100
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH] btrfs: avoid superfluous calls to free_extent_map() in
 btrfs_encoded_read()
Message-ID: <20241106203446.GK31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20241031115210.1965033-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031115210.1965033-1-maharmstone@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 655F81FB72
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Oct 31, 2024 at 11:52:05AM +0000, Mark Harmstone wrote:
> Change the control flow of btrfs_encoded_read() so that it doesn't call
> free_extent_map() when we know that this has already been done.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> Suggested-by: Anand Jain <anand.jain@oracle.com>

Added to for-next, thanks.

