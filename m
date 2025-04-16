Return-Path: <linux-btrfs+bounces-13112-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1239AA90E9B
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 00:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8630619054C2
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 22:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FD7233724;
	Wed, 16 Apr 2025 22:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XHtiUz6u";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KPdRmNQU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XHtiUz6u";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KPdRmNQU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B35E231CAE
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 22:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744842611; cv=none; b=OyqsfW9mjDJnZlbTpyQW0loWnipFaZ/k1STpvdAmIlPpMkMmBAQhA6IMxzOn5jGF/hgcGN8A1Z5xj5POSoJ717++MqUydU0YCoZxS1zFMVtzegWWIL8esfdejuWf69hxNzN2SkGADyHQ4XgKCl5wRHNvmy/vCRaSAFsAsrzqKE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744842611; c=relaxed/simple;
	bh=9DM67D+zCwMdW2rA45i7Oe2rIAEEtKWamtYp6zRKAHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIUJrLjv/Aju0xvFHeMmY074857afb5kCQpCJlcX/JYxOcG6cBBBocByxRlYWMUxdjyr40LFmStBQEQtsj4KwAUhV7fCSsjT2IzFJuJN9APt3yWx++1CxG5nzGBizUQK4B+QTvpUc2Xb5utFE+CJJgvm5tLmZsj8n5j8bzPCY9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XHtiUz6u; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KPdRmNQU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XHtiUz6u; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KPdRmNQU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5078F2119D;
	Wed, 16 Apr 2025 22:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744842607;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WCAgQX0ZVVSJm6tLXb63PviFaKJyoDyxlqno1tccwSQ=;
	b=XHtiUz6uUCnmx1RIaZYpeAZg128xx3q4Oke3CisIrMYn8bb4VzHdvUaHJ4eGGLYXdwGTTX
	rl3jV/AHqAi0JH5XrLtl6Pa90CB4Jz0fzKutuyRHsHgzSK6A6yc0JR79zrndovl2N5+Kjd
	NUMhHYCf37vG1gJs3auCwA5eMUFGfbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744842607;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WCAgQX0ZVVSJm6tLXb63PviFaKJyoDyxlqno1tccwSQ=;
	b=KPdRmNQUQAkxnJxy47JW3r1MwYRN34GsfLMSYaU1qmcIEWSkSUf9ys7hNGw0eew/9+ngXj
	b1HKohAMsI1p1WCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XHtiUz6u;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KPdRmNQU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744842607;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WCAgQX0ZVVSJm6tLXb63PviFaKJyoDyxlqno1tccwSQ=;
	b=XHtiUz6uUCnmx1RIaZYpeAZg128xx3q4Oke3CisIrMYn8bb4VzHdvUaHJ4eGGLYXdwGTTX
	rl3jV/AHqAi0JH5XrLtl6Pa90CB4Jz0fzKutuyRHsHgzSK6A6yc0JR79zrndovl2N5+Kjd
	NUMhHYCf37vG1gJs3auCwA5eMUFGfbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744842607;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WCAgQX0ZVVSJm6tLXb63PviFaKJyoDyxlqno1tccwSQ=;
	b=KPdRmNQUQAkxnJxy47JW3r1MwYRN34GsfLMSYaU1qmcIEWSkSUf9ys7hNGw0eew/9+ngXj
	b1HKohAMsI1p1WCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 381EF139A1;
	Wed, 16 Apr 2025 22:30:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id adKBDW8vAGhVSwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 16 Apr 2025 22:30:07 +0000
Date: Thu, 17 Apr 2025 00:30:02 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] Assertion and debugging helpers
Message-ID: <20250416223002.GH13877@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1744794336.git.dsterba@suse.com>
 <dbdf0811-6359-428b-bf23-79e793973c12@suse.com>
 <20250416202055.GG13877@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416202055.GG13877@suse.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 5078F2119D
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim,suse.cz:mid];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Wed, Apr 16, 2025 at 10:20:56PM +0200, David Sterba wrote:
> > So, if we're pushing towards VASSERT(), then it should replace all 
> > ASSERT() eventually. At least mark the ASSERT() macro deprecated and 
> > stop new usages.
> 
> You can consider VASSERT equivalent to ASSERT, the only reason it's a
> different macro now is because I'd have to implement the variable number
> of arguments and printk. But I can look into that, I agree that having
> just ASSERT would be best in the long term.

I have something, so the following will work:

ASSERT(condition);
ASSERT(condition, "string");
ASSERT(condition, "string=%d", variable);

