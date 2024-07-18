Return-Path: <linux-btrfs+bounces-6546-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9296934FF8
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2024 17:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A6941F22B28
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2024 15:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3678F1448D3;
	Thu, 18 Jul 2024 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1sQC/uAe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uHZbt707";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1sQC/uAe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uHZbt707"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED807A724;
	Thu, 18 Jul 2024 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721316915; cv=none; b=C674EuFf1+szcyEK6h6Bc9QkDNOUBAFfVyKzuUSK/FGx0Lt+D0wnUPmvrq61fQ00xI0OgRHMMLxSp5/anQaABY2839Sh0uc0x0/UHnMgtVVfibgygcUTTmYYpzu5CmN23SgYhpPYfE0tJ6eUmlJMVIZ1dEWt0IkEoLYh3eYiiO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721316915; c=relaxed/simple;
	bh=lIWToKvgUfIYprmsD7pL/ApsVusrVH2hYx0XZf2O5GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlWF0++1dSD9zBUIs9Uwda8lY5pTUZaFjSbRYuqZUIRRQd7rRw0fE3YRBWMGPqy/maGvxO4KmSY/bwiM4RqtraEUBTmx/k84NRPo3ijrbFaEnDPstAMMFMPijbeVkUKOo/obbbNOp6RuKv0A0RTNJA4TCeqfMP4xmG2CENbEH2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1sQC/uAe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uHZbt707; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1sQC/uAe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uHZbt707; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B1E221A47;
	Thu, 18 Jul 2024 15:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721316911;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oOF6GAsaVPMZI1BMvowPVFk8h6lPiD2wmG7Jf94UVZU=;
	b=1sQC/uAeKpeMJGgZBDc56QBaQoTChuBo1cmzAjJXK1ZanaUTZ5WWhyYK7hQwtf9+n4wbrq
	ynG2PanUqGl0wTDA7QpA7JqvfRBpmwnJu1t4W56dVHUsr9SmyrM5dljQEg66GS6hvns4Fx
	4PakgO+n2ZqPytJoXfpemHTIlxBVeJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721316911;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oOF6GAsaVPMZI1BMvowPVFk8h6lPiD2wmG7Jf94UVZU=;
	b=uHZbt707qaPzr06k50ToInHzzVGdSmreef/LGKVz3RygPkKAhVxn0AHU6rCRn5yQ3dpoCT
	MCoKu4M7JR8YpUCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="1sQC/uAe";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uHZbt707
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721316911;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oOF6GAsaVPMZI1BMvowPVFk8h6lPiD2wmG7Jf94UVZU=;
	b=1sQC/uAeKpeMJGgZBDc56QBaQoTChuBo1cmzAjJXK1ZanaUTZ5WWhyYK7hQwtf9+n4wbrq
	ynG2PanUqGl0wTDA7QpA7JqvfRBpmwnJu1t4W56dVHUsr9SmyrM5dljQEg66GS6hvns4Fx
	4PakgO+n2ZqPytJoXfpemHTIlxBVeJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721316911;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oOF6GAsaVPMZI1BMvowPVFk8h6lPiD2wmG7Jf94UVZU=;
	b=uHZbt707qaPzr06k50ToInHzzVGdSmreef/LGKVz3RygPkKAhVxn0AHU6rCRn5yQ3dpoCT
	MCoKu4M7JR8YpUCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 742491379D;
	Thu, 18 Jul 2024 15:35:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LNAhGy82mWaPLgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 18 Jul 2024 15:35:11 +0000
Date: Thu, 18 Jul 2024 17:35:10 +0200
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Qu Wenru <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v3 2/3] btrfs: replace stripe extents
Message-ID: <20240718153510.GH8022@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240712-b4-rst-updates-v3-0-5cf27dac98a7@kernel.org>
 <20240712-b4-rst-updates-v3-2-5cf27dac98a7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712-b4-rst-updates-v3-2-5cf27dac98a7@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 9B1E221A47
X-Spam-Flag: NO
X-Spam-Score: -0.21
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.21 / 50.00];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spamd-Bar: /

On Fri, Jul 12, 2024 at 09:48:37AM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Update stripe extents in case a write to an already existing address
> incoming.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Please update the subject and changelog (in for-next), this does explain
much or lacks context. Thanks.

