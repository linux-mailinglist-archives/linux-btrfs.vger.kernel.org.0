Return-Path: <linux-btrfs+bounces-18475-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AC9C26BCE
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 20:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A204B466AFB
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 19:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6A5344044;
	Fri, 31 Oct 2025 19:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZtW7IWeh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rB3f+mwE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZtW7IWeh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rB3f+mwE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF45330B512
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 19:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761938638; cv=none; b=gV0Zfz9KFC/pjtT03N7TwyLCG8eyzTWmrb1JNtEqOq5HMHbML8p0iSskI9C5spTorfQ42E6AbMe3FE78djNfPreZlnfrux3DUQmwlL3yFk6RqWcbRNjLEkQOwyspLDGrgLBwwZCaB+K/tzh3AyV60Y2Ib3B1hQr5fO26vHruBXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761938638; c=relaxed/simple;
	bh=cEG/l2KKX0iHwR4CfKjltLrcqIvs6CysmBSL7QmTQ9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aD5GPufbU5vPstVFyabL9g912m6ndYJ2GtFaohurZCxy7A8aXzVrwbYPDFizCpbvgFFIS1kKS629gm5GPx/dzsXj56IuCBQXq5/OJ8Tee2I444/J1nS/XnlYAXVAoasa8/SjWnXV7O0ZerICDou/d7l1dYAM+XPVA372DRjMrQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZtW7IWeh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rB3f+mwE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZtW7IWeh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rB3f+mwE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B24122325;
	Fri, 31 Oct 2025 19:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761938634;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SdRy716LEtX40RxEmVt6jYu9To1YFak4H5VwxoN23Fo=;
	b=ZtW7IWehD00D+FZM8y5pRncY7D81UWOjFeSOl1SXuLTtWX5J4gCqCZYNN3VD42GbBA8v8K
	HBEw4XKlS+S6ffXwAzzOT87bEfTXxPOsMRPB2CvoAhT4/2zo4d9oPFhEmaZkBLLWt//8O6
	HXLg2YBGH2wr37eKLTvVbDD2YyQ6j3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761938634;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SdRy716LEtX40RxEmVt6jYu9To1YFak4H5VwxoN23Fo=;
	b=rB3f+mwEGZzNEsat6Xtmsrvl1SpT5+DmClxAPxIjLlbMHCeYaNs2+FSHzhCa5tewK3sXE5
	LZZlN9w5GafruOBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZtW7IWeh;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rB3f+mwE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761938634;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SdRy716LEtX40RxEmVt6jYu9To1YFak4H5VwxoN23Fo=;
	b=ZtW7IWehD00D+FZM8y5pRncY7D81UWOjFeSOl1SXuLTtWX5J4gCqCZYNN3VD42GbBA8v8K
	HBEw4XKlS+S6ffXwAzzOT87bEfTXxPOsMRPB2CvoAhT4/2zo4d9oPFhEmaZkBLLWt//8O6
	HXLg2YBGH2wr37eKLTvVbDD2YyQ6j3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761938634;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SdRy716LEtX40RxEmVt6jYu9To1YFak4H5VwxoN23Fo=;
	b=rB3f+mwEGZzNEsat6Xtmsrvl1SpT5+DmClxAPxIjLlbMHCeYaNs2+FSHzhCa5tewK3sXE5
	LZZlN9w5GafruOBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80FB113393;
	Fri, 31 Oct 2025 19:23:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q2gCH8oMBWnlKgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 31 Oct 2025 19:23:54 +0000
Date: Fri, 31 Oct 2025 20:23:53 +0100
From: David Sterba <dsterba@suse.cz>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>
Subject: Re: [PATCH v1 1/1] btrfs: Replace const_ilog2() with ilog2()
Message-ID: <20251031192353.GL13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251031075509.3969206-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031075509.3969206-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 9B24122325
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,intel.com:email,suse.cz:replyto,suse.cz:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Fri, Oct 31, 2025 at 08:55:09AM +0100, Andy Shevchenko wrote:
> const_ilog2() was a workaround of some sparse issue, which was
> never appeared in the C functions. Replace it with ilog2().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Added to for-next, thanks.

