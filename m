Return-Path: <linux-btrfs+bounces-14508-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF212ACF8E3
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 22:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA32C178E52
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 20:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A690927EC80;
	Thu,  5 Jun 2025 20:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l6fXyAx2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZxJAaaYM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SDJOTGzv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R9cut5jV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700771E5B9F
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 20:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749156222; cv=none; b=iTCpHrTPz69HYQ0aWxZULFKolDywgdW6ph97zOPmKicJhncLjO1BaJ4fM9LqCobtZwJbEpDrhTECs/pE8Rc2CEURfZG90rbIW4STqC/XqFnyG1IYuB2xn/DB8xuU/RxtyjXfvVPGNcoSGBc8iLVLG20ni09K+1xJXXNKZw5YGow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749156222; c=relaxed/simple;
	bh=YjrwhlBnlNPW+TXhRlj/k+agiEo0gJM0Hipgd9YC/0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Scb3c3152cwM2f5rUB0GG7TjWuSS6yk8bfmAF/vlRa1fMzPOQwPvFjATaGqPntookBtkqW8qL1rin8QbB3xRH0v8n1g6DWSdf+4fM9sTCRkE6QHcurfZSarOWk1JKEeUkZwcCOy/poKLN76CajO+QWMfYnOguqsgVchmrHhFbFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=l6fXyAx2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZxJAaaYM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SDJOTGzv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R9cut5jV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BB26B1F769;
	Thu,  5 Jun 2025 20:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749156218;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/tPpFbUzP9VjmoGo9EmlYqsMXhTIKTB/1mxB2S7nDrM=;
	b=l6fXyAx2k5OCJyLE7COjrq0fqiWzZosM1Qhh3VYN7IHiaYrEyeSj6yURPqqufxjR7Kf1Wc
	YjPyKAaxANq0nE4FEIfsEtfBKEPTAshBd8viQYERUZcBL8NpruZnMaj1OyuK2p0N7Exva8
	8dqKcJTKS/lpBXKsqae08859nqqbYCE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749156218;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/tPpFbUzP9VjmoGo9EmlYqsMXhTIKTB/1mxB2S7nDrM=;
	b=ZxJAaaYMTx8/rjcdBwcMU+QeN6Ezsr0qRidNfl2cYt/UMbZtV/MCDsesP6xdGshPT6aB9o
	RTw3zE0OdC9S+sCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SDJOTGzv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=R9cut5jV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749156217;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/tPpFbUzP9VjmoGo9EmlYqsMXhTIKTB/1mxB2S7nDrM=;
	b=SDJOTGzvbtlxwxS/kKZflT/QAjUqUXn9wJUkQN8oFr0uzEAi0freYfFnZi4/14rnEo874u
	zkMMDH3yesdLFT9stotUGEMm66w+ZY4dNtFcU8Yz3Sg5HKecFS0+aVssMyEl2V1GRvgTgn
	8TavZMgpDNMN9FXvcIDprJoL5HiaFkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749156217;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/tPpFbUzP9VjmoGo9EmlYqsMXhTIKTB/1mxB2S7nDrM=;
	b=R9cut5jVKL8vZV6t3sVmTdW6lDUEcmUfTp/GdtOJVIgW5JLlsPkZ9QSlPyNpf727OqjmQK
	QC6alTUFEbb6cFBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BA1D1373E;
	Thu,  5 Jun 2025 20:43:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dL59JXkBQmhnPQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 05 Jun 2025 20:43:37 +0000
Date: Thu, 5 Jun 2025 22:43:35 +0200
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: add comma delimiter for zone_unusable to
 space_info dump
Message-ID: <20250605204335.GT4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250605152431.396419-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605152431.396419-1-jth@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: BB26B1F769
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.21

On Thu, Jun 05, 2025 at 05:24:31PM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> On a space_info dump all values but 'zone_unusable' are delimited by a
> comma.
> 
> Add the missing comma between 'readonly' and 'zone_unusable' to be
> consistent and make parsing easier.

So this makes it consistent with the rest of the line but is otherwise
inconsistent with the style of values printed elsewhere, ie. without the
"=" between name and value.

But it seems it's been quite inconsistent everywhere. The only place
where the style is unified is tracepoints. I'm not sure if we should do
the same in the normal syslog messges, either with the space as
delimiter or with "=". In both cases the "," can be dropped though.

