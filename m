Return-Path: <linux-btrfs+bounces-12762-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A8CA7986F
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Apr 2025 00:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F82F188F1E7
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 22:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9BF1F5425;
	Wed,  2 Apr 2025 22:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lIivGzyY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Td31J1Y6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lIivGzyY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Td31J1Y6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E535911CBA
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Apr 2025 22:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743634625; cv=none; b=fVIhnbdmXZJgb4A0BX09odUlo9ezmG5u1xAR0Sdkr6zvKdoVS3Rq46uBS9+wc3brGDvOVamcgdhNF0a9IHvarRADitjITsVqsk9xNsBgOQ4D3tTMSsaJLEzVd1gOR2nIFzE6EtUWOJv/HODBBGX7CFSNCk6JT9cjbYz0FUCIIsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743634625; c=relaxed/simple;
	bh=b+blwNgk3dymusj/ksJe1usPj+22W7lSwplFbCqMc9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBQYczvD5+Xom839TAu7XGEL0worRfm53QG+8lYqwGOvLQhIkS42YESgMULPvtjFgOw38Hi+mauOSRobRASlwtnJTuozf320vyAFZumD3R263Z4UkLbByEscRD+XSEYh2bQ4slI+vQ06JWSH2vObrjciB+CsgO3/q8HZsYjun7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lIivGzyY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Td31J1Y6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lIivGzyY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Td31J1Y6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 02F1D21180;
	Wed,  2 Apr 2025 22:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743634622;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6KAaJEu/JawdwfBl8iO/Ii3phpM+vVpEvbWuZtQglmU=;
	b=lIivGzyYfbiJm0gVmIzw+gg//sCfK0MzMTOnwyVmmXf/3evKs4Lt3YgYMXTGLe9iVpk2OL
	0Cvkqoxxkgcn0p/iT+hUIAtvurwGPxS+WLmmo2MPqjg6RMePjdwKSe6jBDmc2R2S/L5D9U
	5HLau8UTGVLqRIguMFAqaMKfelKpiZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743634622;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6KAaJEu/JawdwfBl8iO/Ii3phpM+vVpEvbWuZtQglmU=;
	b=Td31J1Y6vwIbeD27DaGogI7T6EKcpXNjIEZKK5ZalcLstoH9BIoXz8KfXrr7JqKxoh2H6q
	I0eYNNyQNBYa5BDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743634622;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6KAaJEu/JawdwfBl8iO/Ii3phpM+vVpEvbWuZtQglmU=;
	b=lIivGzyYfbiJm0gVmIzw+gg//sCfK0MzMTOnwyVmmXf/3evKs4Lt3YgYMXTGLe9iVpk2OL
	0Cvkqoxxkgcn0p/iT+hUIAtvurwGPxS+WLmmo2MPqjg6RMePjdwKSe6jBDmc2R2S/L5D9U
	5HLau8UTGVLqRIguMFAqaMKfelKpiZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743634622;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6KAaJEu/JawdwfBl8iO/Ii3phpM+vVpEvbWuZtQglmU=;
	b=Td31J1Y6vwIbeD27DaGogI7T6EKcpXNjIEZKK5ZalcLstoH9BIoXz8KfXrr7JqKxoh2H6q
	I0eYNNyQNBYa5BDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCAD9137D4;
	Wed,  2 Apr 2025 22:57:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BJKjNb3A7Wd1PgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 02 Apr 2025 22:57:01 +0000
Date: Thu, 3 Apr 2025 00:56:59 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: some more cleanups for the io tree code
Message-ID: <20250402225659.GQ32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1743604119.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1743604119.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Apr 02, 2025 at 03:54:08PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Some simple and short cleanups for the io tree code in preparation
> for other work. Details in the change logs.
> 
> Filipe Manana (4):
>   btrfs: fix documentation for tree_search_for_insert()
>   btrfs: remove redundant check at find_first_extent_bit_state()
>   btrfs: simplify last record detection at test_range_bit()
>   btrfs: remove redudant record start offset check at test_range_bit()

Reviewed-by: David Sterba <dsterba@suse.com>

