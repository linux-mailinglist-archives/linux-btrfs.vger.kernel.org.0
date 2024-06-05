Return-Path: <linux-btrfs+bounces-5478-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EA38FD48C
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 19:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56AF5B2650B
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 17:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC9619581F;
	Wed,  5 Jun 2024 17:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QoX5ckUQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iYERRn77";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iG2OzP6Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VSmi96P7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC63194AF9
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Jun 2024 17:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610283; cv=none; b=BigVwkPD0tBo4+mSD5/f8cw1noYc3FhFnTLqbOjskbwhonxNWBUIGhMp/Jjw4HN5SXxYdngzUBO+/OwDvKfdx/wz3WA+6hXadniYcqPgNxx2kiqFNAT7YLdXbbxgb/LLUl34z9RCXOC9bkPLgOfRUG1tMG/ZttmTm9/wRwM24n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610283; c=relaxed/simple;
	bh=sTAbyyLts3eSw595MXDy999/8PBZSgBCL85hgRef2ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBcS7vU+8MEimePK/OK4IkyeK1MBUIDxs3mQiGEOSDqvhr6wwSI1rMXBUNLb1mcICyopg5pf2xd12ZtwyFJE2GfDYLonPnGntNCMw+XJCOx/i0+8OD1YOu645fUdL+5JjiIaeFuitiVrU+3VUJ0ECz9xxF7Z/VKArycVmXNW2ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QoX5ckUQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iYERRn77; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iG2OzP6Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VSmi96P7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E7BAE1F831;
	Wed,  5 Jun 2024 17:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717610279;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aPgziB149UNO+zhf462lfvqfh3T3300gEk7TMAxMZAo=;
	b=QoX5ckUQ/6ScBD/HR1LaMyvSmaLOFtKrWIu2ES/NwmwgmQIv80IK4QsKWNc96aKFC9FV9F
	bAqaOhGds54lgS952n2IXUjU+wRmFY9plQTSSTNIDUhkKUowBit6odRT6NcR331mGNrSJZ
	i+ils+CPel/RXKTumFJ8eMPT5CagXaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717610279;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aPgziB149UNO+zhf462lfvqfh3T3300gEk7TMAxMZAo=;
	b=iYERRn77sUub9VlLPxEWPGMB2Z5MhwLY+ui5SIUbTKkApJgBJmOD/IMPAyCEQoMvjdy/sC
	tqkP1pUSA9YenpBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717610278;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aPgziB149UNO+zhf462lfvqfh3T3300gEk7TMAxMZAo=;
	b=iG2OzP6QqMVr+kvSO/Yx/mM0THnJ7+yECC9WnwSpSRF9r0lwmG/uXjal/zTIKwKTpQFREL
	FqVM3FS5B+WsZ65rHZY7A6JorxLBYA5Xv4rcNkCQXlzV+2alYqYBboVfBclO40RBv/AuiO
	cyKfTE9IJthThiUNu7kZ3smG/JUIQUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717610278;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aPgziB149UNO+zhf462lfvqfh3T3300gEk7TMAxMZAo=;
	b=VSmi96P7D6xEHpwQ8MQCBLtaIduGs/8GooZmPWfGnoWVEUeeSm8UBW/gH3L0PVDpfNFYOU
	R/mc/v633Mg1VNAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD75413A24;
	Wed,  5 Jun 2024 17:57:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RH+zMSanYGaYdgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 05 Jun 2024 17:57:58 +0000
Date: Wed, 5 Jun 2024 19:57:49 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/4] btrfs-progs: small bug fixes
Message-ID: <20240605175749.GC18508@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1717544015.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717544015.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-8.00 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -8.00
X-Spam-Flag: NO

On Wed, Jun 05, 2024 at 09:13:40AM +0930, Qu Wenruo wrote:
> 3 fixes for 3 github issues.
> 
> Meanwhile the last one fix a test failure which always fails on my VM
> (cause by one bug inside the test case), but it never fails on the
> github CI (as the kernel commits two transactions, causing slot change).
> 
> [Pull request]
> https://github.com/kdave/btrfs-progs/pull/807
> 
> [Changelog]
> v2:
> - Concentrate all small fixes into a patchset
> - Update the last patch to handle multiple transactions
> 
> Qu Wenruo (4):
>   btrfs-progs: corrupt-block: fix memory leak in debug_corrupt_sector()
>   btrfs-progs: print-tree: do sanity checks for dir items
>   btrfs-progs: error out immediately if an unknown backref type is hit
>   btrfs-progs: fix misc/038 test cases

Added to devel, thanks.

