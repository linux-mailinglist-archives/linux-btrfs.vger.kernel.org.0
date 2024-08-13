Return-Path: <linux-btrfs+bounces-7166-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2026F9505D3
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 15:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37CFEB2C458
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 12:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0836C19B3FF;
	Tue, 13 Aug 2024 12:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0j17iggL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3cagGaXM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AcNwvEZ7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LZTPPjzY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ADC19AA41;
	Tue, 13 Aug 2024 12:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553886; cv=none; b=NT/jD8cg03C5pkSZlMV+mz+BXuumrExMAV+8uaCJK7bV/CLV6NklglizwUVKSH34IsPY4DwjiTpkc5X6QFL0z6mxhwWwu/ByGJrvWGBlccS/04V+Ahc7Koa/Q6v4ao6zTgg/hJqqjbYkCKz5YZSPEV1qmlcsgbzY51wHAzp1Ryo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553886; c=relaxed/simple;
	bh=fprbuUCIft12Lh/fqhPte7xgQHBYCl8hUXaC2w9707M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VF/kwALkbII59GxYHn1i1APSG24nSPn5KwoV23RzZWf8i12q5C++G5Vc3lzQe6yECH2z2GOTrSaZoDvmy+29V3ToZF94o3icaHTaEU0bxwA72P4LKYeqmRAMwpJsMk3f44B4QA0grkPfQC1f71DrSdFfd8UIJEpn6Kb+JwbVpP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0j17iggL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3cagGaXM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AcNwvEZ7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LZTPPjzY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D448F203AC;
	Tue, 13 Aug 2024 12:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723553882;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aHbJqc/Wg7mLt3KDCd57boNBus+5Zinmvd8FHgmbQIQ=;
	b=0j17iggL3Re4G2zLK1KciLdYfonnXLvvKv3LEetMghU0VhLM2D+Mhuv05VWf4LfKAjpWOk
	vYPFxD/70NyoJeoDM+OBvvUaA6nLiCvXL8mlMn2PilqXV5QuEE0u3ozFDp+4j1uN4Uud3k
	vlHgK69mc6abhyje/Qw5yiCM/+g+fQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723553882;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aHbJqc/Wg7mLt3KDCd57boNBus+5Zinmvd8FHgmbQIQ=;
	b=3cagGaXMsFn41Tkr0i1VXoWXnH7F2nLIBwRmoILAhuJsWy9R4iyBvYzXErWIBX/0lgdiqA
	da/AMkuWH4iJBHAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723553881;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aHbJqc/Wg7mLt3KDCd57boNBus+5Zinmvd8FHgmbQIQ=;
	b=AcNwvEZ7N+pcdDfri0BJiG95cQwIzO3MntLFNsp7AOkE225x3cyyTu86BCm5J/r5aBBUIs
	3ZyioeDhYa4f3+39ndRebgFa1ZSSv9CrpUOVlCH9sxhdmAth+0FnVO4tT7Vu7Oi5YfRnHe
	4BFl76LfCGhDlwsng7PTEzS2CZvibKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723553881;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aHbJqc/Wg7mLt3KDCd57boNBus+5Zinmvd8FHgmbQIQ=;
	b=LZTPPjzYFt+3Vv3t5Z4z67ZwbBLiyBiANm+J4ZPpjlBhtQyrk2ul8ozFuhpWT1w31bfDzR
	l+8RddRMXZ7DtZAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1C9813983;
	Tue, 13 Aug 2024 12:58:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YDdcKllYu2Y4CwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 13 Aug 2024 12:58:01 +0000
Date: Tue, 13 Aug 2024 14:57:45 +0200
From: David Sterba <dsterba@suse.cz>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, kees@kernel.org,
	gustavoars@kernel.org, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] btrfs: Annotate struct name_cache_entry with
 __counted_by()
Message-ID: <20240813125745.GO25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240813105314.58484-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813105314.58484-2-thorsten.blum@toblux.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.990];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Aug 13, 2024 at 12:53:15PM +0200, Thorsten Blum wrote:
> Add the __counted_by compiler attribute to the flexible array member
> name to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Thanks,

Reviewed-by: David Sterba <dsterba@suse.com>

