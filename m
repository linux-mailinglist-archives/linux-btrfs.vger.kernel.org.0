Return-Path: <linux-btrfs+bounces-14955-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D60BAE868A
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 16:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9597E17F3D7
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 14:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D03926738B;
	Wed, 25 Jun 2025 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="drRynzQs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kMMOdxO4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l0FaqPF5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bFfKvnae"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBF125DB15
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750861903; cv=none; b=LiouLsLc/M0Sb6dTdgt4cLjzfmSSlQirPRWKbv3viLECYJhoTzdmWoiAVkZrJVtUbLj1u/VgyF/WW5HEVNVo/9FZQHrIO4apUZhQTFROht0oAuzzuraBvDy0bT3HT+n+/leLYAIGGicjGXogs9/qu179aJqSrBW0mBEFPc7IEfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750861903; c=relaxed/simple;
	bh=mson3jAJY8hsN9K3YDnO2rzEPcf9lFodXzKAf40QLzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSelqeJXIPvGkgkMC2iD2FVS+qqvGsiOUhwg4/DJNBC4BwdgRJkr+p9Q2sM1QQ4xc5zwnUksPO+i+FXCzC7M0K6GgxQPb0CJgF3KENyhyfEAcI2Gl44toi35o2j6HARsQxEODEb5S0KyJgGojiFU2gPAfRjV4xYvlynPVmI1jw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=drRynzQs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kMMOdxO4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=l0FaqPF5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bFfKvnae; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F0B571F74A;
	Wed, 25 Jun 2025 14:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750861900;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4qfOPIyZWxggLYKvWDMqT83PRVq7I+hdks0CkLzhYPo=;
	b=drRynzQszYVI8w5JX7+uOPIDeGflUWUiwXmYOhFjITY+DX2NQ5yU9gJUYlhb7QfDxUzFIP
	PsLug3VbL/Y6NIsi+PwP/cGm1MgSf6FBM32raMzF0g1+RipLjINuEXzoqu6UFG/WojnVL1
	cyT3tfVw/jXuNEUf0oMPUKXz2j/Natw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750861900;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4qfOPIyZWxggLYKvWDMqT83PRVq7I+hdks0CkLzhYPo=;
	b=kMMOdxO4iSsvJNgQZN1lVgH4ZwKlqTmWU3YltddckeudRVGkvF3edZtS2hIVHCmoEnufa9
	/kx84qWSePifz2Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750861899;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4qfOPIyZWxggLYKvWDMqT83PRVq7I+hdks0CkLzhYPo=;
	b=l0FaqPF5JBCsVNADOLUfHcdxi7vrWuUuSHnraCiVQsEZ4laUoyoftv1fctihBUlv62jGn/
	qMwFTr1a5cENf0eJz1Aln/L1iZUCyDcfdt4VgHbUx1VKSmTwNNsN4KE10Le7LayOelr90u
	q4OYUwRQL/tAwTxAKkFBCmYSqSzAlTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750861899;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4qfOPIyZWxggLYKvWDMqT83PRVq7I+hdks0CkLzhYPo=;
	b=bFfKvnaeN0lSwR64w4k3Iy4m2ZhnEeTHO7KgsIYepQdw0v9fUM8AuG39ThlWJo3QE/mm2x
	l3YM4E3KOygeo6BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D004A13301;
	Wed, 25 Jun 2025 14:31:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gNuZMksIXGj6FgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 25 Jun 2025 14:31:39 +0000
Date: Wed, 25 Jun 2025 16:31:38 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5 0/8] btrfs: use fs_holder_ops for btrfs
Message-ID: <20250625143138.GA31241@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1750724841.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1750724841.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 

On Tue, Jun 24, 2025 at 10:02:37AM +0930, Qu Wenruo wrote:
> [CHANGELOG]
> v5:
> - Fix a tailing whitespace
>   This introduced by patch "btrfs: add comments to make super block
>   creation more clear", and that patch is created during a small
>   window where my commit checkpatch hook is broken.
> 
>   And unfortunately that comment is also later updated by several
>   patches, causing several conflicts with that whitespace error fixed.

Thanks, patches added to linux-next again.

