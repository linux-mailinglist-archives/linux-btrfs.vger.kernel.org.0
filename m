Return-Path: <linux-btrfs+bounces-19870-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C41CCD8B3
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 21:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04F79303659D
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 20:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C102D8798;
	Thu, 18 Dec 2025 20:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BQ3Upgtt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q7Gmt7P2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q7+CZkrl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YVtqpUWn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640DE2116E0
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 20:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090276; cv=none; b=fWSA4l0dPqH9WEo4KKhW0Kp2FVHrR2qkDUzQgPuD7Qj2sPTbrh755xGSwfgoFh3YEBu45uKnGoVVeGE5FviUD8AqcgmqkHhv9y2oEaSJ52+xmu1vNvL7qEFCGChv5vyOipK3yURPVxMWEfM+/xq2+/+2vWMmWbuA9kDLcC1XCSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090276; c=relaxed/simple;
	bh=Z3mksCpDKXaOvbQzcv2Al9AQOwRZInoKF/5JVU/vkSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpaxNIWmtu2TBKhC/RXwB6tAYVHwG6zcLCOuKAOKLPGpodxKiQFbzXvJ527J9trE3SDrp+sN+RberRJbiz4NAki6tOCzIygpIg+LdlFHIcu/ahe1DcGprBbf35WiA9xyHKH9GjaCXyELQwLDGQ5PwushuDv2hGK+dpHepXmc2qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BQ3Upgtt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q7Gmt7P2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q7+CZkrl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YVtqpUWn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 804025BD95;
	Thu, 18 Dec 2025 20:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766090273;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d25VYqp2xI37Jd1hzGUoKBtoU8+z/nwsruboLLkhbpo=;
	b=BQ3UpgttQ+zRuhf/etVXfJssygjXEJ3bVLcnAUXS1Bg4i7bSY/36cL7HAUOmEmpPoRzAib
	PHpKrprutantXl4bBmKSXBqBm5xmKGQhheITg3f56OH84TqyRbb4cvlwBMi6zjRKOtbCjn
	WcJ7NYARRa8oT3RqrOfd8gRd0GJ+z+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766090273;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d25VYqp2xI37Jd1hzGUoKBtoU8+z/nwsruboLLkhbpo=;
	b=Q7Gmt7P2gWt8BTaG2tdni1ipcvsxloroPnkSa5Orb/xzOCIXSE+GD6XcBXlEqRB9l4uzpQ
	hdxWqZEmCs3AKnAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766090272;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d25VYqp2xI37Jd1hzGUoKBtoU8+z/nwsruboLLkhbpo=;
	b=q7+CZkrlV8pM0iFMWfQlVgD1E5ebLIu5CuDcGNw7MLDUUrfmlYDRkzDWWOe/mlCKsVrfwo
	XI7aDLa4Xt/nlDNQgTlZLw9bYWHYWK/EPilV4AuTnHDxpzuvVCpQzpqrsqcQbuu265seU/
	wHkE+bkzYfxmtwQaUiPM+rcpzDMmkMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766090272;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d25VYqp2xI37Jd1hzGUoKBtoU8+z/nwsruboLLkhbpo=;
	b=YVtqpUWn415f2LrJygOwm9euKGUDJ5b2zL0oiNOH4+96VhYsIMB9KItKBo7HlH8Zem6Bfz
	EcFkfKynPUk5t4BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 718183EA63;
	Thu, 18 Dec 2025 20:37:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D/1+GyBmRGlJXAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 18 Dec 2025 20:37:52 +0000
Date: Thu, 18 Dec 2025 21:37:43 +0100
From: David Sterba <dsterba@suse.cz>
To: Qiang Ma <maqianga@uniontech.com>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Fix -Wmaybe-uninitialized warning
Message-ID: <20251218203743.GU3195@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251218081618.2038279-1-maqianga@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218081618.2038279-1-maqianga@uniontech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -3.96
X-Spam-Level: 
X-Spamd-Result: default: False [-3.96 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.16)[-0.821];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]

On Thu, Dec 18, 2025 at 04:16:18PM +0800, Qiang Ma wrote:
> Fix a -Wmaybe-uninitialized warning by initializing
> the variable to NULL.
> 
> $ make CFLAGS_tree-log.o=-Wmaybe-uninitialized
> 
> In file included from fs/btrfs/ctree.h:21,
>                  from fs/btrfs/tree-log.c:12:
> fs/btrfs/accessors.h: In function 'replay_one_buffer':
> fs/btrfs/accessors.h:66:16: warning: 'inode_item' may be used uninitialized [-Wmaybe-uninitialized]
>    66 |         return btrfs_get_##bits(eb, s, offsetof(type, member));         \
>       |                ^~~~~~~~~~
> fs/btrfs/tree-log.c:2803:42: note: 'inode_item' declared here
>  2803 |                 struct btrfs_inode_item *inode_item;
>       |                                          ^~~~~~~~~~
> 
> Warning was found when compiling using loongarch64-gcc 12.3.1.

We have the -Wmaybe-uninitialized warning enabled per fs/btrfs/
directory, there are no other known reports fixing the uninitialized
inode_item so this might be specific to loongarch gcc 12.x. I'll add the
patch to for-next as we still want to get all the warnings fixed, thanks.

