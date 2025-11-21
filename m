Return-Path: <linux-btrfs+bounces-19245-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42446C7A44C
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 15:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id EA7B92E1F3
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 14:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EA328151C;
	Fri, 21 Nov 2025 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gzcqgKo2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZNbrdQpG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gzcqgKo2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZNbrdQpG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7884B276050
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 14:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763736463; cv=none; b=RuecQslaXlU1vgsdhFXStsNZ900nvOCIyBkYTqdl6oE/C3LNqt8KX+q5H7jvU2xkqs5dkwxarJABJtMlTkUR7O2AbSGOjz/WoXl9Cpagm1p2zQEwJMlTQqkPf+kMGa1lIlF2pkrZuAgtnVTUBZd+6vpzIjn0WubNvjkoOs5v728=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763736463; c=relaxed/simple;
	bh=Nnqcr3lNVk+A1qks1o89I5v0Ho/1fS6gWJN5my0iroQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0maVRjNdi1YwqLI3pJT4uBiDVwzZeU85muBq0nNsoDO4B0GBI3oSk5X4HxZybn3S1HqCyf32WKmyvEUqO+8Rb2qz20lsPLRebQv1DuHKnV8wCAfk3BNcB7Y2Me9kJjR1d+5KWTijcLj8P5uU/gNE9juHvABBR7n5rvAOasFc2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gzcqgKo2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZNbrdQpG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gzcqgKo2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZNbrdQpG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7AC77219EB;
	Fri, 21 Nov 2025 14:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763736459;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QaQjp6Z+00gowWeN7/AQIicm35GeoMVvIdSBeAonVg0=;
	b=gzcqgKo2NX50nAXDxL8DTL5rwLDxpvzMMfuCspguM0wmCoDSOcqF3et2Gcc5BD8QdQLlNk
	cKL/xO3xyGLES4Z/0BgCZBy6nDBn8JS2zZJjIMQ7RFtjhrOk0BCPQvDHiXRSa8M2hSy2OV
	dyuaq1ojOgkspOLPOFnobrRb3l/F1JU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763736459;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QaQjp6Z+00gowWeN7/AQIicm35GeoMVvIdSBeAonVg0=;
	b=ZNbrdQpGwZSy49sRMTtCO98eBJWAUr1JPbfOe+M08Xms0icigMuXcYMfHtUDvgfS397gfB
	ED9zD+dOYggV0RBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763736459;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QaQjp6Z+00gowWeN7/AQIicm35GeoMVvIdSBeAonVg0=;
	b=gzcqgKo2NX50nAXDxL8DTL5rwLDxpvzMMfuCspguM0wmCoDSOcqF3et2Gcc5BD8QdQLlNk
	cKL/xO3xyGLES4Z/0BgCZBy6nDBn8JS2zZJjIMQ7RFtjhrOk0BCPQvDHiXRSa8M2hSy2OV
	dyuaq1ojOgkspOLPOFnobrRb3l/F1JU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763736459;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QaQjp6Z+00gowWeN7/AQIicm35GeoMVvIdSBeAonVg0=;
	b=ZNbrdQpGwZSy49sRMTtCO98eBJWAUr1JPbfOe+M08Xms0icigMuXcYMfHtUDvgfS397gfB
	ED9zD+dOYggV0RBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6CC3A3EA61;
	Fri, 21 Nov 2025 14:47:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id todYGot7IGm+KAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 21 Nov 2025 14:47:39 +0000
Date: Fri, 21 Nov 2025 15:47:38 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Sun Yangkai <sunk67188@gmail.com>, "dsterba@suse.cz" <dsterba@suse.cz>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"boris@bur.io" <boris@bur.io>
Subject: Re: [PATCH 2/2] btrfs: simplify boolean argument for
 btrfs_{inc,dec}_ref
Message-ID: <20251121144738.GO13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251120141948.5323-1-sunk67188@gmail.com>
 <20251120141948.5323-3-sunk67188@gmail.com>
 <20251120190206.GM13846@twin.jikos.cz>
 <6e3d587b-89ed-4b44-ab62-c485b8fdf814@gmail.com>
 <b84d76d5-7046-4250-82ae-070e3f16e9b0@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b84d76d5-7046-4250-82ae-070e3f16e9b0@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,twin.jikos.cz:mid];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,vger.kernel.org,bur.io];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Fri, Nov 21, 2025 at 06:58:53AM +0000, Johannes Thumshirn wrote:
> On 11/21/25 4:17 AM, Sun Yangkai wrote:
> > 3. We can optionally add a local variable like Boris mentioned.
> 
> Yeah I'd opt for that as well.

Ok, this looks reasonable. We use the 'const bool = (condition)' pattern
elsewhere too.

