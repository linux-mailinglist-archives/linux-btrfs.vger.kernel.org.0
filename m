Return-Path: <linux-btrfs+bounces-7662-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD22964B8A
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 18:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17362282F67
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 16:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F115F1B5EAB;
	Thu, 29 Aug 2024 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="usxUqEHY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LAZIFWO1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="usxUqEHY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LAZIFWO1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D671B5EA9;
	Thu, 29 Aug 2024 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948478; cv=none; b=IPqTfIb9C94wl2RGjXMeEFvxwXzVsWxdd8wg+v8GF2AORxIZRCvnwABbjYvPkyzvcx6BpuYHffQ74CHcVlgDeJwWCtdvZDqXYQQVf5RwBkE2qKMaW24ndIPpxQY8bOL+2EqdUtBB8EVIBQZUymCnzgZy3aiKCtaREzQdolcyR90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948478; c=relaxed/simple;
	bh=feddWetKR7w8vLOuU0KO55ikFM7rHi8fF5f60gOjwTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTgyErr6/FaBgOSQ5LEckYvLfauVw+99hI8R7vjeJNhOKGXa9grNPa25xR+BB/KurtAbL53XeSOq4f7MFuLPI71HAhckAkAYcdjSMZly1ssGEurQq9Trg4Y7xU0It1rfUWXOpRmj+Sfhtm3UOvw/b7zpxVpUO+SKUTSglTLFE1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=usxUqEHY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LAZIFWO1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=usxUqEHY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LAZIFWO1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 47FC1219C2;
	Thu, 29 Aug 2024 16:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724948474;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+TwU6ENaL8PPaefwtyUWsE4PAIXqcRKW6XtyVITl8CE=;
	b=usxUqEHYRggEOU9o8UoTcx+TVfATRePy7K8+XnPVOB9sRMAyybEfuuZaB2jwqDWVNeTxei
	VL32xFWDVokt9spoyuFvSXoSvGFjh0eOgROF3Fh8G9XmDTduhpusKy/OeGvHkI8rg46Ujf
	2J9F27DmGXKQbRC9dMhssmEfD7Az7mU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724948474;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+TwU6ENaL8PPaefwtyUWsE4PAIXqcRKW6XtyVITl8CE=;
	b=LAZIFWO1JJaONEHJBdttsTjU4anLzfhGQVMPbyFuSBeTK6az1+q0QwPKqlkquNGLdVPqve
	8U4tYSCaBKL1vVDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=usxUqEHY;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LAZIFWO1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724948474;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+TwU6ENaL8PPaefwtyUWsE4PAIXqcRKW6XtyVITl8CE=;
	b=usxUqEHYRggEOU9o8UoTcx+TVfATRePy7K8+XnPVOB9sRMAyybEfuuZaB2jwqDWVNeTxei
	VL32xFWDVokt9spoyuFvSXoSvGFjh0eOgROF3Fh8G9XmDTduhpusKy/OeGvHkI8rg46Ujf
	2J9F27DmGXKQbRC9dMhssmEfD7Az7mU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724948474;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+TwU6ENaL8PPaefwtyUWsE4PAIXqcRKW6XtyVITl8CE=;
	b=LAZIFWO1JJaONEHJBdttsTjU4anLzfhGQVMPbyFuSBeTK6az1+q0QwPKqlkquNGLdVPqve
	8U4tYSCaBKL1vVDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 342AA13408;
	Thu, 29 Aug 2024 16:21:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vZiADPqf0GbkeAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 29 Aug 2024 16:21:14 +0000
Date: Thu, 29 Aug 2024 18:21:03 +0200
From: David Sterba <dsterba@suse.cz>
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH] btrfs: Remove duplicate 'unlikely()' usage
Message-ID: <20240829162102.GL25962@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240829072952.35335-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829072952.35335-1-kunwu.chan@linux.dev>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 47FC1219C2
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Thu, Aug 29, 2024 at 03:29:52PM +0800, Kunwu Chan wrote:
> From: Kunwu Chan <chentao@kylinos.cn>
> 
> nested unlikely() calls, IS_ERR already uses unlikely() internally
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Thanks for noticing it, I've folded the change to the patch "btrfs:
convert extent_range_clear_dirty_for_io() to use a folio"

