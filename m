Return-Path: <linux-btrfs+bounces-18147-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3300BFA451
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 08:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8C63B0D5B
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 06:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8820B2ECEAC;
	Wed, 22 Oct 2025 06:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O0636VUf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hDsPMfLs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zsFA1XMs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a4cTGoWv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4836B2E718F
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Oct 2025 06:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115265; cv=none; b=nJFCTsdGmtOJVP86xmOZsFzsTSOCGcSH5ma1bNm+GQMk2zbO7n1IQkQcN7BQ6Tzjpsbc3D2i/G1hs4iDLhoJitUSbzXeDX4RwsDDKU5jkA9aNq1wH6JIfjOZX601tkkd+hqhVJHPfzrQXwpvbqqhIkf8qNfOXYbbe7sVWFd/IpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115265; c=relaxed/simple;
	bh=6wPil8ynpCSdalLR0eNok5HeBk8d8SWgigy5pYVRWI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9nBG/EFgY4mbWhNuWWZa7hGuCHKL8w10kl/x/AQU/FvCuJ1N/pPpJfBUaEZSoa3eY67Of+MGhG7MLCiCEarY3MrH3hKPo0uhwEepIVtj3ZmYBcMO7YGkyGXvvONfw1KzMSAG2LBpDZKu6mbuIuhzg4erU8IE2cvXJXTcxCpk8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O0636VUf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hDsPMfLs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zsFA1XMs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a4cTGoWv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3AC31211DF;
	Wed, 22 Oct 2025 06:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761115256;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HGnC6Qn/OFgHuQIkMRSsq4RDsq5IvHiyTXd6ZwQVB/w=;
	b=O0636VUf1N0JRyOctRA+sRYnl4Un2LexVaMnDg/On6mR7GlU4aE8jDEXAGhmoCzo75kXdt
	ONOzWvXkKekkmDSTLDdjxxj4x86InoTtZkuhQW34qBnfLF5x0Z1xRbqHoYrZWboSXaHxFN
	wZkfME+XmLKX8OxzCRNia/SiCvUdqOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761115256;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HGnC6Qn/OFgHuQIkMRSsq4RDsq5IvHiyTXd6ZwQVB/w=;
	b=hDsPMfLsfVx9rzT4j/r4f9vl0oZ9c7ysJc26VChoDoob6BVf1vrbuReNw4TPbmMNa/W+1m
	WUiWvrdIocvXYnAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zsFA1XMs;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=a4cTGoWv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761115252;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HGnC6Qn/OFgHuQIkMRSsq4RDsq5IvHiyTXd6ZwQVB/w=;
	b=zsFA1XMs9w58+In2kjLtWTjtCcLD3YSpFC4Osv6KZGKNBI8Tm7lj8yoilCTsxjPE+9HGUC
	O+COrez/GEr5uMBtryuyhU/spmN51dUArBnTaP53PwQEqiK9v1QJ54x97ArqK2z6f19+kE
	K82bkA/cX3FIbFxoluAnS66x0USTcWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761115252;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HGnC6Qn/OFgHuQIkMRSsq4RDsq5IvHiyTXd6ZwQVB/w=;
	b=a4cTGoWvPbY6P8feblcUbqYL85l4pTkQIHav6lLkXI53HrV1HZZSU/9Agd7iTclUdt/5Lb
	nuWbWH+ZIWvaLqDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F22613A29;
	Wed, 22 Oct 2025 06:40:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yqJaC3R8+GgGZwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 22 Oct 2025 06:40:52 +0000
Date: Wed, 22 Oct 2025 08:40:43 +0200
From: David Sterba <dsterba@suse.cz>
To: Dongjiang Zhu <zhudongjiang@alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH] btrfs-progs: btrfs-find-root: fix incorrect command name
 in usage text
Message-ID: <20251022064043.GS13776@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251021114211.2216602-1-zhudongjiang@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021114211.2216602-1-zhudongjiang@fnnas.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 3AC31211DF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.15 / 50.00];
	BAYES_HAM(-2.94)[99.76%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.15
X-Spam-Level: 

On Tue, Oct 21, 2025 at 07:42:11PM +0800, Dongjiang Zhu wrote:
> The usage string incorrectly showed "btrfs-find-usage" instead of
> "btrfs-find-root", which could confuse users reading the help text.
> 
> Signed-off-by: Dongjiang Zhu <zhudongjiang@fnnas.com>

Added to devel, thanks.

