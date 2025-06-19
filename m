Return-Path: <linux-btrfs+bounces-14788-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFA7AE07DA
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jun 2025 15:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE813B6AE7
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jun 2025 13:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B5A28A72D;
	Thu, 19 Jun 2025 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dDDxfYt9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="92MG6WuY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dDDxfYt9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="92MG6WuY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D0227E1B1
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Jun 2025 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750341089; cv=none; b=SUOdYqehHXyN7cgjWFh37h1O6/U/8y8TaYVyuuaachuR2HUY+YTErH07GugxJFwH8/ovY55Tpg9z8CycRpVYoTu2iKjatLN4sepUbI84Qr/lub5DL9sOGZiqd9oSqDBXQ2XPZSC4b5UqQHdxZEfRfNXtyaAeAp7opxirbZzVw/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750341089; c=relaxed/simple;
	bh=mC8A3U2GUpteiJmo5YjxvEwg/kH+zzGSf9HDNz/ETmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5YhMxLCFpcsqL7pM4nTkZ/3qBMwDeHgiLqncLYvjHHMwAroMZCRYBZMsZ/ZxRWpU43J7lztVL16q0ApKzNecNhNQzriB5oHMRPqAiUZsGfpFdLdLeUBKnQGhqjVtfzbvfBqUf/3z4VUjx8uBG5w5iw4kUDxMxsTR80yvEKa8EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dDDxfYt9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=92MG6WuY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dDDxfYt9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=92MG6WuY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D7A6B1F38D;
	Thu, 19 Jun 2025 13:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750341085;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y2zfxl8QoCvFcLU2Jsf1YAYvLE7xKJtUQmP49b2cc5g=;
	b=dDDxfYt9dYLlScN9dyOMkkfK/H5m7+fMGydphvUBRiodVmU+m4s7+Ng+eh0VClhq4KUQwi
	YRAym3CGR2xVn9ztRIXb5/wL8NzeZN7sp9828dUpVQSpplouFk4QvLQQqQh+VS0WW+5Q95
	8GQ3OdnyibFIMrKhOfv+z7pt+jEa4Xg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750341085;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y2zfxl8QoCvFcLU2Jsf1YAYvLE7xKJtUQmP49b2cc5g=;
	b=92MG6WuYpVQmK+NfllwTGi9btaoSYja2bo/NBjNK0VRcSrLRDzx7PTlRDkAE6WQeZcGgdB
	1or9QKzYblBXRMCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750341085;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y2zfxl8QoCvFcLU2Jsf1YAYvLE7xKJtUQmP49b2cc5g=;
	b=dDDxfYt9dYLlScN9dyOMkkfK/H5m7+fMGydphvUBRiodVmU+m4s7+Ng+eh0VClhq4KUQwi
	YRAym3CGR2xVn9ztRIXb5/wL8NzeZN7sp9828dUpVQSpplouFk4QvLQQqQh+VS0WW+5Q95
	8GQ3OdnyibFIMrKhOfv+z7pt+jEa4Xg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750341085;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y2zfxl8QoCvFcLU2Jsf1YAYvLE7xKJtUQmP49b2cc5g=;
	b=92MG6WuYpVQmK+NfllwTGi9btaoSYja2bo/NBjNK0VRcSrLRDzx7PTlRDkAE6WQeZcGgdB
	1or9QKzYblBXRMCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C03FC136CC;
	Thu, 19 Jun 2025 13:51:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OtG3Lt0VVGg3FwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 19 Jun 2025 13:51:25 +0000
Date: Thu, 19 Jun 2025 15:51:20 +0200
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: search_tree ioctl performance improvements
 and cleanups
Message-ID: <20250619135120.GN4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250612043311.22955-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250612043311.22955-1-sunk67188@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Thu, Jun 12, 2025 at 12:31:10PM +0800, Sun YangKai wrote:
> This series optimizes the search_tree ioctl path used by tools like compsize
> and cleans up related code:

IIRC there were proposals to have a ioctl for compression size but I
can't find the most recent version now. The SEARCH_TREE what compsize
does is a "temporary" workaround.

> Patch 1: Narrow loop variable scope
> 
> Patch 2: Early exit for out-of-range keys
> 
>     Replaces continue with early exit when keys exceed max_key
> 
>     Provides measurable performance improvements:
>     Cold cache: 34.61s → 30.40s (about 12% improvement)
>     Hot cache: 14.19s → 10.57s (about 25% improvement)
> 
> Patch 3: Simplify key range checking
> 
>     Replaces key_in_sk() helper with direct comparisons
> 
>     Adds WARN_ON for min_key validation (safe due to forward search)
> 
>     Maintains equivalent functionality with cleaner implementation
> 
> These changes optimize a critical path for filesystem analysis tools while
> improving code maintainability. The performance gains are particularly
> noticeable when scanning large filesystems.

Thanks. The changes look good to me, and with a measurable performance
improvement.

