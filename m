Return-Path: <linux-btrfs+bounces-16019-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93864B225E2
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 13:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A2EB424755
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 11:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36322ED151;
	Tue, 12 Aug 2025 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B87VwRaT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yV7m2FY9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uuqJs6Y3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7zLUKCGy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9C81A9FB8
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 11:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754998260; cv=none; b=LBR6Co87acfKQWLtW9WrTriL3nxY5mQKMYM4Vh8bPvhHbVDjXgQT5aDap7Z36LSzywpKhrhPU2U4VLZJA5DgQr7h09si7WRmrOmu1NLTjdNUx/TuWL/Q52aiF8Ws7/9O6M2I9zzVZDphDmc9zJEpOwgN5vLgbSFeNvVeT5yYZjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754998260; c=relaxed/simple;
	bh=Wxhe4QvMSd4vqTLtf8pDA5MwdI07iBZCXn0qfBPk28E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEKQWWR4S8c9Ra2Z39m3SheOBZVuv/rMzthaDiCCEs9PyaoI6U9lOp0fq2VSmGXEDvlB4EJ/L4EsF3hbQQ1IDKZANUGBbkGIjFAemma7pTFaFrE1aIOXshiiGKAlhEnQ5ACAFhrJDUzlaiOSw6FRFnDFP1+a+XaJTY0iismKjCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B87VwRaT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yV7m2FY9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uuqJs6Y3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7zLUKCGy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A0EF51F785;
	Tue, 12 Aug 2025 11:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754998257;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fexx3aHF9Z6Y9wMRr12uPB0oTC5xEJ6C4S2QLWntkN8=;
	b=B87VwRaT9LyfHTx/1KUlFHvf6KUDpRySpfzq3poFur2j3jBI9DfCkUV1LbG7djL96KUozu
	v4X3OAAtvj+7pZwDEX3dW8bSPycb5bSC88YqXiflkP3fV6Hk65f2LzKoyrID54JJyBEoXZ
	bR5YvXalRDNpBJVLLk/af6VMtpXrmjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754998257;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fexx3aHF9Z6Y9wMRr12uPB0oTC5xEJ6C4S2QLWntkN8=;
	b=yV7m2FY9dI8wb91ajrazjLNKZwOTU+uOo1e/W2IJfprN6vH6px8wghmGJZsB0R420hW+Mz
	AInyfX3+/bPGeEDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uuqJs6Y3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7zLUKCGy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754998255;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fexx3aHF9Z6Y9wMRr12uPB0oTC5xEJ6C4S2QLWntkN8=;
	b=uuqJs6Y32YnrIhhY9lIiOYZcxXCXfPBx8e5qoYE3O1AoDrEZ0FGtbxTjrsyOU+6Sd+0Ga3
	U7ZNil+QL0z23l7UJTI+ZXkoaAughBBP8N/HzPu4mepHc3BVOsmD7L2xxHZA88YJ/7QIfL
	OzyR16UrFJ8e0tEp3/RBMk91rLPcUrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754998255;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fexx3aHF9Z6Y9wMRr12uPB0oTC5xEJ6C4S2QLWntkN8=;
	b=7zLUKCGyJeFXug0Kxtnulre+9DBb+fVbsgCFOa6TAr3jFMFJZbEaVb2C15svlTlrUdZcmw
	r+AlkUJ4pmY/jlAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C3F9136C7;
	Tue, 12 Aug 2025 11:30:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5noSIu8lm2i3GwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 12 Aug 2025 11:30:55 +0000
Date: Tue, 12 Aug 2025 13:30:54 +0200
From: David Sterba <dsterba@suse.cz>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: use PTR_ERR_OR_ZERO() to simplify code
Message-ID: <20250812113054.GB5507@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250812082554.48576-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812082554.48576-1-zhao.xichao@vivo.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: A0EF51F785
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vivo.com:email,suse.cz:dkim,suse.cz:mid,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.21

On Tue, Aug 12, 2025 at 04:25:54PM +0800, Xichao Zhao wrote:
> Use the standard error pointer macro to shorten the code and simplify.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>

Added to for-next, thanks.

