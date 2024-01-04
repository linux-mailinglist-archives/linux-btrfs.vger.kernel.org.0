Return-Path: <linux-btrfs+bounces-1244-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B91D98245BC
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 17:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19C21C222EB
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 16:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A618250E8;
	Thu,  4 Jan 2024 16:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AYoExCeO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vfxzz8Of";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AYoExCeO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vfxzz8Of"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57CC24B4C
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Jan 2024 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A328E1F7FE;
	Thu,  4 Jan 2024 16:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704384254;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XqgSEcY0vsB743Is1ARt2AMSGp2PJD8yFWnSGNSMhTg=;
	b=AYoExCeOk77mK0MCkIi0WlpsE55IjK57d3vEvjNY+DzaDxD+dEGRr15+VpbEPnyylCQSwj
	/hUc4RWKHg3gT6m/Td8Hy6/tCLnZOLKqhFnSTCiMYKBoX4e5v0MYStBQZd2hRKwZKC7n76
	OOqVptf+P4MC8zoPlFWldomKu6NLceE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704384254;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XqgSEcY0vsB743Is1ARt2AMSGp2PJD8yFWnSGNSMhTg=;
	b=Vfxzz8OfkgT8217sSZfP+pWR3a+Wm2uxFv8QXGu5MWMaX1z16bW8RJUQ0l7YTHDXJ9OF0u
	/ujhJ+BRLPlJ48Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704384254;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XqgSEcY0vsB743Is1ARt2AMSGp2PJD8yFWnSGNSMhTg=;
	b=AYoExCeOk77mK0MCkIi0WlpsE55IjK57d3vEvjNY+DzaDxD+dEGRr15+VpbEPnyylCQSwj
	/hUc4RWKHg3gT6m/Td8Hy6/tCLnZOLKqhFnSTCiMYKBoX4e5v0MYStBQZd2hRKwZKC7n76
	OOqVptf+P4MC8zoPlFWldomKu6NLceE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704384254;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XqgSEcY0vsB743Is1ARt2AMSGp2PJD8yFWnSGNSMhTg=;
	b=Vfxzz8OfkgT8217sSZfP+pWR3a+Wm2uxFv8QXGu5MWMaX1z16bW8RJUQ0l7YTHDXJ9OF0u
	/ujhJ+BRLPlJ48Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96EE113C96;
	Thu,  4 Jan 2024 16:04:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id m3C0JP7WlmX5WAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 04 Jan 2024 16:04:14 +0000
Date: Thu, 4 Jan 2024 17:04:02 +0100
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix unbalanced unlock of mapping_tree_lock
Message-ID: <20240104160402.GG15380@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <8752e4df194f7c765d04a5830716e3218fb22222.1703177167.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8752e4df194f7c765d04a5830716e3218fb22222.1703177167.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A328E1F7FE
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AYoExCeO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Vfxzz8Of
X-Spam-Score: -1.28
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.28 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 URIBL_BLOCKED(0.00)[suse.cz:dkim,wdc.com:email];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.07)[87.91%]

On Fri, Dec 22, 2023 at 01:46:16AM +0900, Naohiro Aota wrote:
> The error path of btrfs_get_chunk_map() releases
> fs_info->mapping_tree_lock. But, it is taken and released in
> btrfs_find_chunk_map(). So, there is no need to do so.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Thanks, it's from a recent one, 7dc66abb5a47 ("btrfs: use a dedicated
data structure for chunk maps"),

