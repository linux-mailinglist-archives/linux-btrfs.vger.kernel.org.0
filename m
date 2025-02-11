Return-Path: <linux-btrfs+bounces-11384-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8967DA319A6
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 00:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F5227A2EB7
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2025 23:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35255268FEA;
	Tue, 11 Feb 2025 23:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BwDGmdrO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1DeNBEHi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BwDGmdrO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1DeNBEHi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764B8262D33
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Feb 2025 23:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739317389; cv=none; b=H3sNbuSsWT3n2LzVJ/uPwPfmIG4MgO1O/BgvvHVFRkWu3dQWUAP1EIu0msUzWxxs89pTlBoXFfN7wJSHM/q4e4XthxPcbbGkn2FD5rxjxCrGWCqW9yMH/Ddpm0rrJKGQQfiTX4k4Q4NC1aw/UdpHrKuwLl4IwChhS/iyV6A56Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739317389; c=relaxed/simple;
	bh=ntOXicoUGJGgp5ZVm+mkG97ZpnKxQ3E9EGhfzZ2bQdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mf3zbFlbRS5fHQDuciK2eDbqXRxpNT29i6a1ZifJy9Fcev2zIDp5roFemQQKcgd48hG05BRir19FckhQ6EgAHZ5hCf8+8ULU5OU8zF5+F0AEdcVGCAWusH35r46h7kBgeEP4y/YjkzGUe39eQ4O1uDJo3ECNU5nydxYjMlbm9lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BwDGmdrO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1DeNBEHi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BwDGmdrO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1DeNBEHi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 593A81FF0F;
	Tue, 11 Feb 2025 23:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739317385;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ntOXicoUGJGgp5ZVm+mkG97ZpnKxQ3E9EGhfzZ2bQdM=;
	b=BwDGmdrO1zwfYVrdhImZ3vr41JgrmcayLvptBLIrca3Lr8u9eTbP7bDFNxfvMC1TBdM79E
	Mo02gGRaeyJNyVrhJtyYLeoei5V6rtENnAmZcCQIojCANhg59wID6ScedxKS+0W6qY4lYe
	qVJz+8trV0N8BO+Tq6DNpi+mDOziu0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739317385;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ntOXicoUGJGgp5ZVm+mkG97ZpnKxQ3E9EGhfzZ2bQdM=;
	b=1DeNBEHi+9dHhKgjyLb8fOTr9oTjKcWTDtmGmhbB0I16QPT69/OOVvjzHFlMClTLJvaiYA
	sVyGqI5wF8ER6BCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739317385;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ntOXicoUGJGgp5ZVm+mkG97ZpnKxQ3E9EGhfzZ2bQdM=;
	b=BwDGmdrO1zwfYVrdhImZ3vr41JgrmcayLvptBLIrca3Lr8u9eTbP7bDFNxfvMC1TBdM79E
	Mo02gGRaeyJNyVrhJtyYLeoei5V6rtENnAmZcCQIojCANhg59wID6ScedxKS+0W6qY4lYe
	qVJz+8trV0N8BO+Tq6DNpi+mDOziu0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739317385;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ntOXicoUGJGgp5ZVm+mkG97ZpnKxQ3E9EGhfzZ2bQdM=;
	b=1DeNBEHi+9dHhKgjyLb8fOTr9oTjKcWTDtmGmhbB0I16QPT69/OOVvjzHFlMClTLJvaiYA
	sVyGqI5wF8ER6BCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4041713782;
	Tue, 11 Feb 2025 23:43:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TU94D4ngq2e6eAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 11 Feb 2025 23:43:05 +0000
Date: Wed, 12 Feb 2025 00:42:48 +0100
From: David Sterba <dsterba@suse.cz>
To: Racz Zoli <racz.zoli@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] Removed redundant if/else statement
Message-ID: <20250211234248.GW5777@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250207023302.311829-1-racz.zoli@gmail.com>
 <20250207023302.311829-2-racz.zoli@gmail.com>
 <20250211191457.GU5777@suse.cz>
 <CANoGd8mhGau83LU-bWjyi-A2jnzZoAyhqzo3yuxnhC2sETpfWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANoGd8mhGau83LU-bWjyi-A2jnzZoAyhqzo3yuxnhC2sETpfWw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:replyto]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Feb 11, 2025 at 09:31:33PM +0200, Racz Zoli wrote:
> I simplified that if/else block because looking at it it seemed the
> only difference between the two was that in the if block
> pretty_size_mode received UNITS_RAW and in else it received unit_mode.
> Didn`t know about the underlying reason you mentioned.
> But if the second patch containing the json output implementation is
> ok, I can rewrite it so it uses the function as it was before my
> commit.

I have fixed the unit printing and found another bug. Please base your
commit on current devel branch. The json patch won't apply cleanly but
it's only in the rate printing part.

