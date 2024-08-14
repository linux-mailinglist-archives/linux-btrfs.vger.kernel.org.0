Return-Path: <linux-btrfs+bounces-7193-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A342B951EE4
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 17:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5995F1F23BCE
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 15:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24341B583B;
	Wed, 14 Aug 2024 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yi6Y5ln5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HfS10ZIg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yi6Y5ln5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HfS10ZIg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAFE1B580C;
	Wed, 14 Aug 2024 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650283; cv=none; b=AsINgCH2YAMK94UQDoGXWvVWDgnC/vqTrtx2YqsMH4ZHSkRE/LIS5Y+bg9t7blK61SmfnmLQvpohZZUOKc+LW+Y9Hx8kBbob/xcNZZnB3eNaNMcmYIhue7OxMBHwR6sTcJeuYlX+v1Ymrdle+MX6HZ1SORXG6jXPIy+bo+U3I1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650283; c=relaxed/simple;
	bh=77q1nxk9tE8ry1ySjlpJ9eGkfSzdeo8446QGWysA1uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ut+FQ7deApxIXC68FpTInR4ky5ld1ubewttHaSp4PaGgnAsckuRPaL5Tpld2rSVA7NdtM2TDNU2h/P2UIc0tzlOLmsXaBKL6dqm7dXiXcNow1lIafbSQCez32clQXjKqiN+lDliTs72FAxbLd8nGo+XLXx0NDSZDfSCQWqEGoSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yi6Y5ln5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HfS10ZIg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yi6Y5ln5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HfS10ZIg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C147E1FEFF;
	Wed, 14 Aug 2024 15:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723650279;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DBX9Wa76bfrIa6Qjr9NfjlTPoz1uKh0AviPE8T9sCk4=;
	b=yi6Y5ln55SgC3piygcLZaD+AQshbMLph2+LRp10kGVargB1Ar3nhEMUsYgu24B0nCH7nGf
	xsrQtfpaJPC4KN8l+UL8ePEeTqLW96LFLBySF3Xbu0e1MgGHtEVutzuE8LjL2HEKNVS2+8
	4yyydIIREnul+tIq0AkGMyi2ZAbJdTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723650279;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DBX9Wa76bfrIa6Qjr9NfjlTPoz1uKh0AviPE8T9sCk4=;
	b=HfS10ZIgqBEZAHH8esVDkN3514j6A5fxpq0e3OfL+tQHPFsAEhQFbRF6TlIf0FItDzKuYI
	fnXhA2eKf8fnMeCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723650279;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DBX9Wa76bfrIa6Qjr9NfjlTPoz1uKh0AviPE8T9sCk4=;
	b=yi6Y5ln55SgC3piygcLZaD+AQshbMLph2+LRp10kGVargB1Ar3nhEMUsYgu24B0nCH7nGf
	xsrQtfpaJPC4KN8l+UL8ePEeTqLW96LFLBySF3Xbu0e1MgGHtEVutzuE8LjL2HEKNVS2+8
	4yyydIIREnul+tIq0AkGMyi2ZAbJdTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723650279;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DBX9Wa76bfrIa6Qjr9NfjlTPoz1uKh0AviPE8T9sCk4=;
	b=HfS10ZIgqBEZAHH8esVDkN3514j6A5fxpq0e3OfL+tQHPFsAEhQFbRF6TlIf0FItDzKuYI
	fnXhA2eKf8fnMeCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7C061348F;
	Wed, 14 Aug 2024 15:44:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YMttKOfQvGbGbQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 14 Aug 2024 15:44:39 +0000
Date: Wed, 14 Aug 2024 17:44:34 +0200
From: David Sterba <dsterba@suse.cz>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: send: Fix grammar in comments
Message-ID: <20240814154433.GY25962@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240814081328.156202-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814081328.156202-2-thorsten.blum@toblux.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6]

On Wed, Aug 14, 2024 at 10:13:29AM +0200, Thorsten Blum wrote:
> s/a/an and s/then/than
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Thanks, added to for-next. I'm sure there's more to fix but this needs a
tool rather than fixing everything manually.

