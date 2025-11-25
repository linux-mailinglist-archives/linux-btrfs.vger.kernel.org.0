Return-Path: <linux-btrfs+bounces-19345-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51258C86043
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 17:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B595E3A8567
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 16:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B5932938B;
	Tue, 25 Nov 2025 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="il7bVr1O";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G6XVR/dl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="il7bVr1O";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G6XVR/dl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF9E1E98EF
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 16:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089052; cv=none; b=cqs5WNsyUSu7lLxcumze22tF0DOmcagMjww5wxbDt2bSDKZKKPI40ET7ZX2FGmM6psAn9+erYSMPU66yLuX1aEL4Hz3qDsfdtf4jtGMPJl79i1a/3+++7ikTo3LfjbFS8OHu0al+c/OTzwKDlN981ts8BVgILzGTs7qdDcXAZ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089052; c=relaxed/simple;
	bh=/fk4Y/Cp0Xoh/adfXFwzTswAsruz3gpeTN3kJFSu6eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FT8U57Te2Ojs9nsttu2uWTtGJr08q3J0KmePjebXCI0yWVSVu79DA7zgygpixwU0tMlWsNyty8IAFAaMcGHVKQQxpMhK6NWbZOr95WpGHfCVtnTvBsZVw8++nO8RmZbnidOpkgsKgZGprQ539FhhPCQKV8bJ1cMbl4dOwKE71Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=il7bVr1O; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G6XVR/dl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=il7bVr1O; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G6XVR/dl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A80775BD9E;
	Tue, 25 Nov 2025 16:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764089046;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CoWbs5yuhm9coreZnQjiRP4NGO2XatEEJx1AmPPpT/k=;
	b=il7bVr1Oi2H1XQFN/U80ALS86IWyBNU8WF/m543shO9krtFbeLZpfPdXWSZ8nTUjsptWc1
	bkpEOY6a0ftGVWzB9ncW0/nSPbw+xPyeKgdWMvLLxj+I68Xnyokfw7toNnriF2oVWSSs3L
	6GuNSPxdcaSQ+51C4fMDfkJa8w/kpfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764089046;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CoWbs5yuhm9coreZnQjiRP4NGO2XatEEJx1AmPPpT/k=;
	b=G6XVR/dldI7GYzjxs83Y1dtRDGZ3A+NfgQ4ju56QOiqCwnyYqeP+kQ48v0AClgN1h/t/l+
	vaQR+aJgxJ9cH7CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=il7bVr1O;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="G6XVR/dl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764089046;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CoWbs5yuhm9coreZnQjiRP4NGO2XatEEJx1AmPPpT/k=;
	b=il7bVr1Oi2H1XQFN/U80ALS86IWyBNU8WF/m543shO9krtFbeLZpfPdXWSZ8nTUjsptWc1
	bkpEOY6a0ftGVWzB9ncW0/nSPbw+xPyeKgdWMvLLxj+I68Xnyokfw7toNnriF2oVWSSs3L
	6GuNSPxdcaSQ+51C4fMDfkJa8w/kpfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764089046;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CoWbs5yuhm9coreZnQjiRP4NGO2XatEEJx1AmPPpT/k=;
	b=G6XVR/dldI7GYzjxs83Y1dtRDGZ3A+NfgQ4ju56QOiqCwnyYqeP+kQ48v0AClgN1h/t/l+
	vaQR+aJgxJ9cH7CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F06A3EA63;
	Tue, 25 Nov 2025 16:44:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AtFrItbcJWkJawAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 25 Nov 2025 16:44:06 +0000
Date: Tue, 25 Nov 2025 17:44:05 +0100
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/2] btrfs: use true/false and simplify boolean
 parameters in btrfs_{inc,dec}_ref
Message-ID: <20251125164405.GY13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251122063516.4516-2-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122063516.4516-2-sunk67188@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: A80775BD9E
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto,twin.jikos.cz:mid]
X-Spam-Score: -4.21

On Sat, Nov 22, 2025 at 02:00:42PM +0800, Sun YangKai wrote:
> This tiny series removes the last 0/1 integer literals passed to
> btrfs_inc_ref() / btrfs_dec_ref() and replaces the open-coded
> if/else blocks with concise boolean expressions.
> 
> Patch 1 switches the callsites to the self-documenting true/false
> constants, eliminating the implicit bool <-> int mixing.
> 
> Patch 2 folds the remaining if/else ladders into a single line
> using the condition directly, which shrinks the code and makes the
> intent obvious.
> 
> No functional change.
> 
> [Changelog]
> 
> v2:
> 
> - Introduce local variable for the conditions in patch 2, suggested by Boris
> 
> - Merge the non-zero ret handling blocks in btrfs_copy_root()
> 
> Sun YangKai (2):
>   btrfs: use true/false for boolean parameters in btrfs_{inc,dec}_ref
>   btrfs: simplify boolean argument for btrfs_{inc,dec}_ref

Added to for-next, thanks.

