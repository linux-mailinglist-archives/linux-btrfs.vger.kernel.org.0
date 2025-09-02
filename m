Return-Path: <linux-btrfs+bounces-16600-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D18D6B40D52
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 20:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7219918967DA
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 18:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C572E336F;
	Tue,  2 Sep 2025 18:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IkwLhwuB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yupS6ds0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IkwLhwuB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yupS6ds0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF352C11D4
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756838956; cv=none; b=MGgHmg6I//LFLWRIOG2N9PEwE8xAehNW7CvVv3vYG6/a4gj3+skzuxH6HmmypcVU66Us1YNAyJouA33uwMtEfi/DxzN/4vtPjC7DjNIwaIkra0Q7NhNBIfogRyjRFt/bl8gw/h0rOU7tNRS1O0b7qyJrlzBxlWXA5OIEps2A9Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756838956; c=relaxed/simple;
	bh=cym8zaW74exCNZBQ4SYo7KrhU1ZAj9efRoYho/jjZWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suYlAoLKEiV9WWL0g4YVnyDSmrPXsq882TQkcbK6tmZGZdoAKHJXlTuOR8y7FPJJH90DKVdDPDy4qSL6sb82wRe3kpFbaGmhTJe9mC/AtEwLGPQqaCXQOwhHHbT6+SGgUPikb15A2xnvCMloL7pLbmCuQy8ZxjYnoCNXSvalc/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IkwLhwuB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yupS6ds0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IkwLhwuB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yupS6ds0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0D723211AB;
	Tue,  2 Sep 2025 18:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756838953;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bcOcBRwegFpkgJXOJeLGasfOJQHS1UNwXwYSbdW7kw8=;
	b=IkwLhwuB2E0mslrMrq/Ylis8aBhcbyccVZxh0pQyLd6K29LD1ayK7FZPWfIXqJyJ1fKsYS
	y37MYicTeaAYOHeL5dTCdGGyyyhOl6Td/3BJ7nu5HDQyVIktbQfonmSsMw+htg91NGYO4E
	dGtNlmkugMdH8y1vonypZhoJCfzfGbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756838953;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bcOcBRwegFpkgJXOJeLGasfOJQHS1UNwXwYSbdW7kw8=;
	b=yupS6ds05fJQeVGrrJsUqreFLfKVn/A8ZXM36Vzp9EdFPlZAi4gUv5sSZ8fmdT6Bry8sMa
	boV6DmGWdiCewiCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756838953;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bcOcBRwegFpkgJXOJeLGasfOJQHS1UNwXwYSbdW7kw8=;
	b=IkwLhwuB2E0mslrMrq/Ylis8aBhcbyccVZxh0pQyLd6K29LD1ayK7FZPWfIXqJyJ1fKsYS
	y37MYicTeaAYOHeL5dTCdGGyyyhOl6Td/3BJ7nu5HDQyVIktbQfonmSsMw+htg91NGYO4E
	dGtNlmkugMdH8y1vonypZhoJCfzfGbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756838953;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bcOcBRwegFpkgJXOJeLGasfOJQHS1UNwXwYSbdW7kw8=;
	b=yupS6ds05fJQeVGrrJsUqreFLfKVn/A8ZXM36Vzp9EdFPlZAi4gUv5sSZ8fmdT6Bry8sMa
	boV6DmGWdiCewiCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAD8F13888;
	Tue,  2 Sep 2025 18:49:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nvgiOSg8t2ijawAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 02 Sep 2025 18:49:12 +0000
Date: Tue, 2 Sep 2025 20:49:03 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic/363: mention btrfs kernel fix for block size <
 page size scenario
Message-ID: <20250902184903.GI5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <1d3740e7564f94ed51d18c4d53103624fb51e735.1756813886.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d3740e7564f94ed51d18c4d53103624fb51e735.1756813886.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Tue, Sep 02, 2025 at 03:27:40PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There's another btrfs kernel commit that landed in v6.16-rc1 and fixes
> another EOF truncation bug exposed by this test case, so add the commit
> in a _fixed_by_kernel_commit call.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

