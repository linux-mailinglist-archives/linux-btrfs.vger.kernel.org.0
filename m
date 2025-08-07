Return-Path: <linux-btrfs+bounces-15910-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2452AB1DD06
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Aug 2025 20:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589FE1685C7
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Aug 2025 18:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA39F2737EF;
	Thu,  7 Aug 2025 18:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LDigky8f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WtR/kuIB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uhtL4X0H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BNepNX+A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D9B273816
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Aug 2025 18:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754591238; cv=none; b=ABF3j1co6PljD6lGGOoLSCaK89kFUDS4EHoqFHbUrV4MmGoq7CxUWIe0CURYERVSh63zLmy+ebg3OutI1jbrQFgLEgAB5yDctANMeZwd+9ZosHBGLfxLZiB1Ur1jOzD6OUEoPxsdHYKEpLOcYo7I+FYGvqUroCarl8tEu9YgIwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754591238; c=relaxed/simple;
	bh=MXyjXnsiyDunIvR2Qu1NKtY/2YjF8EQM1Oh5XnTlH8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qovBZtwRu6uQwVAcRxPBLSunEEZrwykZYWdsyh9mF7HV9/u8PuQRnIeFf8bew0wEtDa93mvVJYosO+rA/dbNVhPdqlwEe1Z9DeDD1XsnFJEFTAEkxbh1doI/LUNqDiXbuhBb9P/kGba+fdA9nxwpZSMkdtYZLRFZHUC6kCSBNPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LDigky8f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WtR/kuIB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uhtL4X0H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BNepNX+A; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5EEBB33DBA;
	Thu,  7 Aug 2025 18:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754591234;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vG1b7txmXF2/q3tppFosTwTtuH0ZZMGwQtSWehw3Jo4=;
	b=LDigky8f/sHk86Gjzjqy6MK+541wUeDgN1gOVe6+NGypQ7gsRxot4X7Y5pRCcV2C+LWhFX
	AlSqfDt4wz2BKK9cKlObvYLveFfEMRkV1YAjjFlFn3+ABprObr1QnFRI1bDqkozUmEAWXT
	DTl3s0FmUYAkDnLQ32j+ezJ9OKBa5bU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754591234;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vG1b7txmXF2/q3tppFosTwTtuH0ZZMGwQtSWehw3Jo4=;
	b=WtR/kuIBxcGEMtim9FMjwGi3ehVc1t3IDJZxUBbxH/WtA9sMyN8rC1Xdpl0St9VOxyvvNa
	4Amwq0n6tV19g4CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754591233;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vG1b7txmXF2/q3tppFosTwTtuH0ZZMGwQtSWehw3Jo4=;
	b=uhtL4X0HysoBEUS4IXePHllycWJLN4sq39bryV4UfxHq1IiRPHFhu/YkxMfvzqRvkqrd96
	NRafvk/RBShVFzZVn7RiN6jhQ9bnp8FV+1hAOpG1zVag20Efj8CveLkQ0dewKHU/xxBge2
	PRSjqyrTCva9kalZ5c42kOqc5/3OlR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754591233;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vG1b7txmXF2/q3tppFosTwTtuH0ZZMGwQtSWehw3Jo4=;
	b=BNepNX+A4/lmC+iDxkYecQLdK2dWrhXjiFabemVy3SvJDWLYKpNsKWUZ87M0479jMeDa/5
	bllWPUPZuMneVUBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CCD6136DC;
	Thu,  7 Aug 2025 18:27:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +IeUEgHwlGhFYwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 07 Aug 2025 18:27:13 +0000
Date: Thu, 7 Aug 2025 20:27:12 +0200
From: David Sterba <dsterba@suse.cz>
To: sawara04.o@gmail.com
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	johannes.thumshirn@wdc.com, brauner@kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] [v2] btrfs: Fix incorrect log message related barrier
Message-ID: <20250807182712.GP6704@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250722153840.5620-1-sawara04.o@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722153840.5620-1-sawara04.o@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.50

On Wed, Jul 23, 2025 at 12:38:37AM +0900, sawara04.o@gmail.com wrote:
> From: Kyoji Ogasawara <sawara04.o@gmail.com>
> 
> Fix a wrong log message that appears when the "nobarrier" mount
> option is unset.
> When "nobarrier" is unset, barrier is actually enabled. However,
> the log incorrectly stated "turning off barriers".
> 
> Fixes: eddb1a433f26 ("btrfs: add reconfigure callback for fs_context")
> Signed-off-by: Kyoji Ogasawara <sawara04.o@gmail.com>

Added to for-next, thanks.

