Return-Path: <linux-btrfs+bounces-5305-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0379C8D0E82
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 May 2024 22:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5AB1F21D09
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 May 2024 20:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABB316130D;
	Mon, 27 May 2024 20:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tdo1ZylV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HRwLNDEZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F5uE1kNs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5RG8Llgl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E686117E8FC;
	Mon, 27 May 2024 20:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716840372; cv=none; b=pswC3+26hFK7VVIduqfdsJExbmjkKDsN4gtbw1pXWSzAfhbfVIDNuSDCwAe/JkGj3C8BYNz4Rd1eww1ulSlScEM0Abcw5YkL7ieRsgVxqiFTCGWbDG/YQx69DMC3GSNWA9MH9TU4cZ1UsNIZG2eyq7YBw4eqap60SIus7rROXv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716840372; c=relaxed/simple;
	bh=YG6JpafUpKZIOm1IA0t/WDwX2UK1c74J8DESS7+7oTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnwUJ3PlIbcPVKHTrHginDm5THVFdUHJgsvGwD9z5ejTRhMTOGz42BVLZKdOfmAKKiXQ6gOlRweFJdtCDoOmSLsA/ADDXdgsKpwnfVqYFJhnnLBY7IrhWEb/eqGZ7lXiTA7nQlvVVPPPFb58qKFpzS63I+EoN/f4Z4BbtBRe4Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tdo1ZylV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HRwLNDEZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F5uE1kNs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5RG8Llgl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 16C501F798;
	Mon, 27 May 2024 20:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716840367;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZvKRBOS5lmai+swz8tUdyTy4cTgsbuctR3BprEOuAuo=;
	b=tdo1ZylVlZ1jpH4UqpYkmpIJjViahurrTV7Bmhc01WQIvxhflEyu3i2RCYdqdWn2H5yL8o
	koJcQ9E53CFu2NTxxDUtEZGWswAFs3/Pnhc0R2eeTI8pTFJHlkIiEFkkm9C5Oo2w+T7DhY
	Ug0C6Go0GRVdmSfAhuq/OXd+mbKFzuw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716840367;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZvKRBOS5lmai+swz8tUdyTy4cTgsbuctR3BprEOuAuo=;
	b=HRwLNDEZIdowwt8ggtJETkmMrR7rwZlZBlMEWkIS5GwmdIbJaRoJofDBee50CSUumlrKKB
	APpt3C0Sz4lz5vAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716840366;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZvKRBOS5lmai+swz8tUdyTy4cTgsbuctR3BprEOuAuo=;
	b=F5uE1kNsabpjx8moGo6T37piosLwXQZbbaqB7UE/JnsdqUczJkPA5YK7wSVOc6SgGtpSZO
	nt8jgZN/LVCotUioIYyqAwWIf7qdzuFrVpaGBV8/kBFBB7kVlJTX3V3cAl6XI4qsiCb/85
	HJ9ShNAIj9vxXV64RI828xeVPtQpGVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716840366;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZvKRBOS5lmai+swz8tUdyTy4cTgsbuctR3BprEOuAuo=;
	b=5RG8LlglGU4PXd738B6Zp9OPBi6nV+ZiokrI0Covp1V0vmTFK7yw8eoTFVNLRjVW3FhC7E
	TlfS2e1GTg/vvJCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04F5513A6B;
	Mon, 27 May 2024 20:06:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /hgJAa7nVGagOgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 27 May 2024 20:06:06 +0000
Date: Mon, 27 May 2024 22:05:56 +0200
From: David Sterba <dsterba@suse.cz>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs: btrfs: add MODULE_DESCRIPTION()
Message-ID: <20240527200556.GC8631@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240527-md-fs-btrfs-v1-1-9a8732bf2a70@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527-md-fs-btrfs-v1-1-9a8732bf2a70@quicinc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]

On Mon, May 27, 2024 at 10:56:59AM -0700, Jeff Johnson wrote:
> Fix the 'make W=1' warning:
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/btrfs/btrfs.o
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Added to for-next, thanks.

