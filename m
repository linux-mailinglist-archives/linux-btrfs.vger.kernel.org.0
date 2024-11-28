Return-Path: <linux-btrfs+bounces-9955-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6E89DB9E2
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2024 15:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A5D716410E
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2024 14:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A035C603;
	Thu, 28 Nov 2024 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hz58UEjn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6EgKYe/e";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hz58UEjn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6EgKYe/e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E892233A
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Nov 2024 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732805434; cv=none; b=sprzSzvd446pP3WJ+GN32ne4Fr78sDK+qfZY1jcV52CpW6n5kyblnxQvmKk7hFXiTVvhSLtnLlAdNA989Z3xGeRW+ABf2nqqXBKEBH2ZNkQcTwryTT1DJTvKZQYhX1QmGunPRRILZz+PvVwbxjNQ/JutvcKMu6btmYf5NEyAEpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732805434; c=relaxed/simple;
	bh=hBLXdDZ08w3JYurb8FXukO10JRa9eRhbUMreJg1gt50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5s5ejJ9glpQ4DvIXu56yCVnUliEW9Ks5wMAegr5IWI5t5Cauoa93e2iROgMn1WKkWNNaYdeE5Y5djK1qR1/oSmUSY2HpX9fL1BAa+VO7ZmqRaunNt7jaEwQKjZwvcAwTgBCiv0kEG9jkgdteqRlv7FYsZGzU8ZIplVFQwj85tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hz58UEjn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6EgKYe/e; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hz58UEjn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6EgKYe/e; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 28672210F6;
	Thu, 28 Nov 2024 14:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732805430;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AiUuAeMNj2zUtUBzAmyDBQ+ZUg3gtFdBtMuJsT5X+aA=;
	b=Hz58UEjnmhEG8Va2bO4I+r88vCsgTCa12emrSPve5wI/KWQqlDu7Ks9DX1m752kvlnyyUB
	rUZ+qg4jsv03GrCIU/B0S1tinIp6nVYKDZCnPeWZ9/pYCXsNQAFKUZJVOqd4AMX9jQdjXn
	6oLkjJqOq943F/BDO1AHS+bYH3ZPSWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732805430;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AiUuAeMNj2zUtUBzAmyDBQ+ZUg3gtFdBtMuJsT5X+aA=;
	b=6EgKYe/e+6KgHgLPCyCm7lh7ZF1Xf1XhAiHTsYADrWYFVrbtdN//ZQL1/Pk9rGrrOykkLj
	LzEFOUUP9MJ1TNDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Hz58UEjn;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="6EgKYe/e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732805430;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AiUuAeMNj2zUtUBzAmyDBQ+ZUg3gtFdBtMuJsT5X+aA=;
	b=Hz58UEjnmhEG8Va2bO4I+r88vCsgTCa12emrSPve5wI/KWQqlDu7Ks9DX1m752kvlnyyUB
	rUZ+qg4jsv03GrCIU/B0S1tinIp6nVYKDZCnPeWZ9/pYCXsNQAFKUZJVOqd4AMX9jQdjXn
	6oLkjJqOq943F/BDO1AHS+bYH3ZPSWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732805430;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AiUuAeMNj2zUtUBzAmyDBQ+ZUg3gtFdBtMuJsT5X+aA=;
	b=6EgKYe/e+6KgHgLPCyCm7lh7ZF1Xf1XhAiHTsYADrWYFVrbtdN//ZQL1/Pk9rGrrOykkLj
	LzEFOUUP9MJ1TNDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A67413974;
	Thu, 28 Nov 2024 14:50:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1X06BjaDSGc4GwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 28 Nov 2024 14:50:30 +0000
Date: Thu, 28 Nov 2024 15:50:28 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v4] btrfs: handle bio_split() error
Message-ID: <20241128145028.GV31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <3b491cb4fcb7c34bd8cd5265871ff115395fca79.1732786874.git.jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b491cb4fcb7c34bd8cd5265871ff115395fca79.1732786874.git.jth@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 28672210F6
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Nov 28, 2024 at 10:42:01AM +0100, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Commit bfebde92bd31 ("block: Rework bio_split() return value") changed
> bio_split() so that it can return errors.

Where is this commit or what are the merge plans?

